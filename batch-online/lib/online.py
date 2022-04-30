import datetime
import sys
import os
from flask import Flask, jsonify, request
api = Flask(__name__)

sys.path.append(os.path.abspath('..'))
from lib.stockmodelprobability import StockModelProbability  # noqa: E402
from lib.stock import Stock  # noqa: E402
from lib.businessday import BusinessDay  # noqa: E402


@api.route("/futureprice", methods=["GET"])
def get_future_price():
    args = request.args
    symbol = args.get("symbol")
    term = int(args.get("term"))
    lower_probability = float(args.get("lower_probability"))
    initial_price = float(args.get("initial_price"))
    TERM_OF_ANALYSIS = term * 5
    INTERVAL = 'Daily'
    COUNTRY = 'japan'
    businessday = BusinessDay()
    TO_DATE = datetime.datetime.now()
    businessday.to_date = TO_DATE
    FROM_DATE = businessday.from_date(TERM_OF_ANALYSIS)

    stock = Stock(
            from_date=FROM_DATE,
            to_date=TO_DATE,
            country=COUNTRY,
            interval=INTERVAL
    )
    stock.set_historical_prices(symbol)
    prices = stock.close_prices
    log_returns = stock.calculate_log_return(prices)
    stockmodelprobability = StockModelProbability()
    stockmodelprobability.myu = stock.calculate_myu(
        log_returns
    )
    stockmodelprobability.variance = stock.calculate_variance(
        log_returns
    )
    stockmodelprobability.term = term 
    stockmodelprobability.initial_price = initial_price
    future_price = {
        "upper_price":
            stockmodelprobability.calculate_future_value(
                lower_probability
            )
    }
    return jsonify(future_price)

if __name__ == '__main__':
    api.run(host="0.0.0.0", debug=True, port=4951)
