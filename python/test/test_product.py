import unittest
import sys
import os
import datetime

sys.path.append(os.path.abspath('..'))

from lib.product import Product  # noqa: E402


class ConcreteProduct(Product):
    def set_prices(self):
        self.prices = [100]


class TestProduct(unittest.TestCase):
    def setUp(self):
        from_date = datetime.datetime(2021, 10, 11)
        to_date = datetime.datetime(2021, 10, 15)
        country = 'japan'
        interval = 'Daily'
        self.product = ConcreteProduct(from_date, to_date, country, interval)

    def test_calculate_log_return(self):
        self.assertEqual(
            [0.6931471805599453, 0.4054651081081644, 0.2876820724517809],
            self.product.calculate_log_return([1, 2, 3, 4]))

    def test_calculate_myu(self):
        self.assertEqual(2.22, self.product.calculate_myu([1.11, 2.22, 3.33]))

    def test_calculate_variance(self):
        self.assertEqual(
            self.product.calculate_variance([1, 2]),
            0.5
        )


if __name__ == "__main__":
    unittest.main()
