import sys
import datetime
from decimal import Decimal
import os
import investpy
import mysql.connector as mydb

sys.path.append('..')

from lib.businessday import BusinessDay  # noqa: E402
from lib.stock import Stock  # noqa: E402
from lib.stockmodelprobability import StockModelProbability  # noqa: E402
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

stock = Stock(from_date, to_date, COUNTRY, INTERVAL)
probability = StockModelProbability()
symbols = investpy.stocks.get_stocks_list(COUNTRY)
indicators = []
for symbol in symbols:
    try:
        stock.set_prices(symbol)
        prices = stock.prices['close']
        if len(prices) < TERMS['long']:
            raise IndexError('prices length is less than long terms')
    except IndexError as error:
        print(error.args)
        print(symbol)
        continue
    indicator = []
    indicator.append(symbol)
    current_price = prices[-1]
    indicator.append(current_price)
    log_returns = stock.calculate_log_return(prices)

    try:
        for term in TERMS.values():
            probability.myu = stock.calculate_myu(log_returns[-term:-1])
            probability.variance = stock.calculate_variance(
                log_returns[-term:-1]
            )
            probability.term = term
            probability.initial_price = prices[-term]
            try:
                upper_probability = probability.calculate_upper_probability(
                    current_price
                )
            except ZeroDivisionError:
                raise
            rate = float(Decimal(str(upper_probability)) - Decimal('0.5'))
            myuhat = probability.myuhat
            sigmahat = probability.sigmahat
            indicator.extend([myuhat, sigmahat, rate])
    except ZeroDivisionError as error:
        print(error.args)
        print(symbol)
        continue
    else:
        indicators.append(indicator)

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
    dbregister.db_insert(indicators)
except mydb.Error as error:
    print(error.arg)
finally:
    dbregister.db_close()
