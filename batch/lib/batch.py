import sys
import datetime
import os
from investpy import stocks
import mysql.connector as mydb
import logging
from random import sample

sys.path.append('..')

from lib.businessday import BusinessDay  # noqa: E402
from lib.stock import Stock  # noqa: E402
from lib.indicators import Indicators  # noqa: E402
from lib.dbregister import DBRegister  # noqa: E402

def batch():
    log_format = logging.Formatter("%(asctime)s [%(levelname)8s] %(message)s")
    logger = logging.getLogger("main")
    logger.setLevel(logging.DEBUG)

    stdout_handler = logging.StreamHandler(sys.stdout)
    stdout_handler.setFormatter(log_format)
    stdout_handler.setLevel(logging.DEBUG)
    logger.addHandler(stdout_handler)

    if not os.path.isdir('../log'):
        os.makedirs('../log', exist_ok=True)
    file_handler = logging.FileHandler(
        f"../log/{datetime.datetime.now():%Y%m%d%H%M%S}.log"
    )
    file_handler.setFormatter(log_format)
    file_handler.setLevel(logging.INFO)
    logger.addHandler(file_handler)


    logger.info("batch script start")
    TERMS = {
        'short': 5,
        'medium': 25,
        'long': 75
    }
    INTERVAL = 'Daily'
    COUNTRY = 'japan'

    businessday = BusinessDay()
    to_date = datetime.datetime.now()
    businessday.to_date = to_date
    term_of_analysis = TERMS['long'] * 2
    from_date = businessday.from_date(term_of_analysis)

    indicators = Indicators()
    indicators.stock = Stock(from_date, to_date, COUNTRY, INTERVAL)
    indicators.terms = TERMS
    if os.getenv('ENVIRONMENT') == 'production':
        indicators.symbols = stocks.get_stocks_list(COUNTRY)
    elif os.getenv('ENVIRONMENT') == 'development':
        indicators.symbols = sample(stocks.get_stocks_list(COUNTRY), 100)
    logger.info("start to calculate indicators")
    indicators_of_all_symbols = indicators.calculate_indicators_of_all_symbols()
    logger.info("the calculation of all indicators is completed!!")

    dbregister = DBRegister()
    dbregister.host = os.getenv('DB_HOST')
    dbregister.port = os.getenv('DB_PORT')
    dbregister.username = os.getenv('DB_USERNAME')
    dbregister.password = os.getenv('DB_PASSWORD')
    dbregister.database = os.getenv('DB_DATABASE')
    dbregister.table = os.getenv('DB_TABLE')

    try:
        dbregister.db_connect()
        dbregister.db_init()
        dbregister.db_insert(indicators_of_all_symbols)
    except mydb.Error as error:
        logger.error(f"database error : {error.args}")
    finally:
        dbregister.db_close()

    logger.info("batch script finish!!")

if __name__ == '__main__':
    batch()
