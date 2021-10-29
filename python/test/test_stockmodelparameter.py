import unittest
import sys
import os

sys.path.append(os.path.abspath('..'))

from lib.stockmodelparameter import StockModelParameter  # noqa: E402


class TestMyuHat(unittest.TestCase):

    def setUp(self):
        self.stockmodelparameter = StockModelParameter()
        self.stockmodelparameter.myu = 1
        self.stockmodelparameter.variance = 2
        self.stockmodelparameter.term = 0.5

    def test_calculate_myuhat(self):
        self.assertEqual(0, self.stockmodelparameter.calculate_myuhat())

    def test_calculate_sigmahat(self):
        self.assertEqual(1, self.stockmodelparameter.calculate_sigmahat())


if __name__ == "__main__":
    unittest.main()
