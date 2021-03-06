import unittest
from unittest.mock import MagicMock
from unittest.mock import patch
import sys
import os
import datetime

sys.path.append(os.path.abspath('..'))

from lib.stock import Stock  # noqa: E402


class TestStock(unittest.TestCase):
    def setUp(self):
        self.symbol = '1332'
        self.from_date = datetime.datetime(2021, 10, 14)
        self.to_date = datetime.datetime(2021, 10, 15)
        self.country = 'japan'
        self.interval = 'Daily'
        self.stock = Stock(
            self.from_date,
            self.to_date,
            self.country,
            self.interval
            )
        self.stock.set_historical_prices(self.symbol)

    def test_set_historical_prices(self):
        expect = {
            'open': [626, 677],
            'high': [689, 683],
            'low': [623, 656],
            'close': [679, 671]
            }
        self.assertEqual(expect, self.stock.prices)

    def test_properties(self):
        self.assertEqual(self.stock.open_prices, [626, 677])
        self.assertEqual(self.stock.high_prices, [689, 683])
        self.assertEqual(self.stock.low_prices, [623, 656])
        self.assertEqual(self.stock.close_prices, [679, 671])

    @patch(
        "investpy.stocks.get_stock_historical_data",
        MagicMock(side_effect=IndexError)
        )
    def test_set_stocks_error(self):
        stock = Stock(
            self.from_date,
            self.to_date,
            self.country,
            self.interval
            )
        with self.assertRaises(IndexError):
            stock.set_historical_prices(self.symbol)


if __name__ == "__main__":
    unittest.main()
