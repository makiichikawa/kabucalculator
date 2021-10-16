import unittest
import sys
import os

sys.path.append(os.path.abspath('.'))

from lib.product import Product  # noqa: E402


class TestProduct(unittest.TestCase):
    def setUp(self):
        self.product = Product()

    def test_calculate_log_return(self):
        self.assertEqual(
            [0.6931471805599453, 0.4054651081081645, 0.2876820724517808],
            self.product.log_return([1, 2, 3, 4]))

    def test_calculate_myu(self):
        self.assertEqual(2.22, self.product.myu([1.11, 2.22, 3.33]))

    def test_calculate_sigma(self):
        self.assertEqual(self.product.sigma([1, 2]), 0.7071067811865476)


if __name__ == "__main__":
    unittest.main()
