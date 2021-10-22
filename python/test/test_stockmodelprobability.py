import unittest
import sys
import os

sys.path.append(os.path.abspath('..'))

from lib.stockmodelprobability import StockModelProbability  # noqa: E402


class TestMyuHat(unittest.TestCase):

    def setUp(self):
        self.stockmodelprobability = StockModelProbability()
        self.stockmodelprobability.set_attribute(
            myu=1, variance=2, term=0.5, initial_price=1
        )

    def test_calculate_upper_probability(self):
        self.assertEqual(
            0.5, self.stockmodelprobability.calculate_upper_probability(1)
        )


if __name__ == "__main__":
    unittest.main()
