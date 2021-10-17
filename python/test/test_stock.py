import unittest
import sys
import os
import datetime

sys.path.append(os.path.abspath('.'))

from lib.stock import Stock  # noqa: E402


class TestStock(unittest.TestCase):
    def setUp(self):
        symbol = '1332'
        from_date = datetime.datetime(2021, 10, 14)
        to_date = datetime.datetime(2021, 10, 15)
        country = 'japan'
        interval = 'Daily'
        self.stock = Stock(from_date, to_date, country, interval)
        self.stock.set_prices(symbol)

    def test_set_stocks(self):
        expect = {
            'open': [626, 677],
            'high': [689, 683],
            'low': [623, 656],
            'close': [679, 671]
            }
        self.assertEqual(expect, self.stock.prices)


if __name__ == "__main__":
    unittest.main()
