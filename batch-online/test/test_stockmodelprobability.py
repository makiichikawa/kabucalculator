import unittest
import sys
import os

sys.path.append(os.path.abspath('..'))

from lib.stockmodelprobability import StockModelProbability  # noqa: E402


class TestStockModelProbability(unittest.TestCase):

    def setUp(self):
        self.stockmodelprobability = StockModelProbability()
        self.stockmodelprobability.myu = 1
        self.stockmodelprobability.variance = 2
        self.stockmodelprobability.term = 0.5
        self.stockmodelprobability.initial_price = 1

    def test_calculate_upper_probability(self):
        self.assertEqual(
            0.5,
            self.stockmodelprobability.calculate_upper_probability(
                current_price=1
            )
        )

    def test_calculate_upper_probability_error(self):
        self.stockmodelprobability.variance = 0
        with self.assertRaises(ZeroDivisionError):
            self.stockmodelprobability.calculate_upper_probability(
                current_price=1
            )

    def test_calculate_future_value(self):
        self.assertEqual(
            1,
            self.stockmodelprobability.calculate_future_value(
                lower_probability=0.5
            )
        )


if __name__ == "__main__":
    unittest.main()
