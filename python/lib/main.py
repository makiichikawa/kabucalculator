import sys
import datetime
import os
import investpy
import mysql.connector as mydb

sys.path.append('..')

from lib.businessday import BusinessDay  # noqa: E402
from lib.stock import Stock  # noqa: E402
from lib.indicators import Indicators  # noqa: E402
from lib.dbregister import DBRegister  # noqa: E402

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
from_date = businessday.from_date(TERMS['long'])

indicators = Indicators()
indicators.stock = Stock(from_date, to_date, COUNTRY, INTERVAL)
indicators.terms = TERMS
indicators.symbols = investpy.stocks.get_stocks_list(COUNTRY)
indicators_of_all_symbols = indicators.calculate_indicators_of_all_symbols()

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
    print(error.args)
finally:
    dbregister.db_close()
