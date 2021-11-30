import unittest
import sys
import os
import datetime
from unittest.mock import MagicMock
from unittest.mock import patch

sys.path.append(os.path.abspath('..'))

from lib.indicators import Indicators  # noqa: E402
from lib.stock import Stock  # noqa: E402


class TestIndicators(unittest.TestCase):

    def setUp(self):
        self.indicators = Indicators()
        self.indicators.symbols = ['1234']
        self.indicators.terms = {
            'short': 1,
            'medium': 2,
            'long': 3
        }
        self.indicators.stock = (
            Stock(
                datetime.datetime(2021, 11, 24),
                datetime.datetime(2021, 11, 26),
                'japan',
                'Daily'
            )
        )

    @patch('lib.indicators.Indicators._calculate_indicators_by')
    def test_calculate_indicators_of_all_symbols(self, patch_method):
        expected_value = [
            ('1234', 100, 0.1, 0.2, 0.3, 0.1, 0.2, 0.3, 0.1, 0.2, 0.3)
        ]
        patch_method.return_value = expected_value[0]
        self.assertEqual(
            self.indicators.calculate_indicators_of_all_symbols(),
            expected_value
        )

    @patch('lib.indicators.Indicators._get_prices')
    @patch('lib.indicators.Indicators._calculate_rate')
    def test_calculate_indicators_by(self, _calculate_rate, _get_prices):
        _calculate_rate.return_value = -0.5
        _get_prices.return_value = [100, 150, 200]
        self.indicators.stockmodelparameter.calculate_myuhat = (
            MagicMock(return_value=1.1)
        )
        self.indicators.stockmodelparameter.calculate_sigmahat = (
            MagicMock(return_value=2.2)
        )
        self.assertEqual(
            self.indicators._calculate_indicators_by('1234'),
            ['1234', 200, 1.1, 2.2, -0.5, 1.1, 2.2, -0.5, 1.1, 2.2, -0.5]
        )

    @patch(
        'lib.indicators.Indicators._get_prices',
        MagicMock(side_effect=IndexError)
    )
    def test_calculate_indicators_by_indexerror(self):
        with self.assertRaises(IndexError):
            self.indicators._calculate_indicators_by('1234')

    @patch(
        'lib.indicators.Indicators._calculate_rate',
        MagicMock(side_effect=ZeroDivisionError)
    )
    @patch('lib.indicators.Indicators._get_prices')
    def test_calculate_indicators_by_zerodivisionerror(self, _get_prices):
        _get_prices.return_value = [100, 150, 200]
        self.indicators.stockmodelparameter.calculate_myuhat = (
            MagicMock(return_value=1.1)
        )
        self.indicators.stockmodelparameter.calculate_sigmahat = (
            MagicMock(return_value=2.2)
        )
        with self.assertRaises(ZeroDivisionError):
            self.indicators._calculate_indicators_by('1234')

    def test_get_prices(self):
        self.indicators.stock = (
            MagicMock(
                prices={
                    'open': [100, 150, 200],
                    'high': [101, 151, 201],
                    'low': [102, 152, 202],
                    'close': [103, 153, 203]
                }
            )
        )
        self.assertEqual(
            self.indicators._get_prices('1234'),
            [103, 153, 203]
        )

    def test_get_prices_indexerror(self):
        self.indicators.stock = (
            MagicMock(
                prices={
                    'open': [100, 150],
                    'high': [101, 151],
                    'low': [102, 152],
                    'close': [103, 153]
                }
            )
        )
        with self.assertRaises(IndexError):
            self.indicators._get_prices('1234')

    def test_calculate_rate(self):
        self.indicators.stockmodelprobability.calculate_upper_probability = (
            MagicMock(return_value=0.85)
        )

        self.assertEqual(
            self.indicators._calculate_rate(
                term=2,
                initial_price=100,
                current_price=120
            ),
            float(0.35)
        )


if __name__ == "__main__":
    unittest.main()
