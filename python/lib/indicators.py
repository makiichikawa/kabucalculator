from decimal import Decimal
import sys

sys.path.append('..')
from lib.stockmodelprobability import StockModelProbability  # noqa: E402
from lib.stockmodelparameter import StockModelParameter  # noqa: E402


class Indicators:

    def __init__(self):
        self.stockmodelprobability = StockModelProbability()
        self.stockmodelparameter = StockModelParameter()

    @property
    def symbols(self):
        pass

    @property
    def terms(self):
        pass

    @property
    def stock(self):
        pass

    @symbols.setter
    def symbols(self, symbols):
        self.__symbols = symbols

    @terms.setter
    def terms(self, terms):
        self.__terms = terms

    @stock.setter
    def stock(self, stock):
        self.__stock = stock

    def calculate_indicators_of_all_symbols(self):
        indicators = []
        for symbol in self.__symbols:
            try:
                indicators_by_symbol = self._calculate_indicators_by(symbol)
            except (IndexError, ZeroDivisionError) as error:
                print(error.args)
                print(symbol)
                continue
            else:
                indicators.append(indicators_by_symbol)
        return indicators

    def _calculate_indicators_by(self, symbol):
        indicators_by_symbol = []
        try:
            prices = self._get_prices(symbol)
        except IndexError:
            raise
        else:
            current_price = prices[-1]
            indicators_by_symbol.append(symbol)
            indicators_by_symbol.append(current_price)
            log_returns = self.__stock.calculate_log_return(prices)
            self._set_parameters_of_stockmodelprobability(log_returns)
            for term in self.__terms.values():
                self._set_attributes_of_stockmodelparameter(log_returns, term)
                myuhat = self.stockmodelparameter.calculate_myuhat()
                sigmahat = self.stockmodelparameter.calculate_sigmahat()
                try:
                    rate = (
                        self._calculate_rate(
                            term, prices[-term], current_price
                        )
                    )
                except ZeroDivisionError:
                    raise
                else:
                    indicators_by_symbol.extend([myuhat, sigmahat, rate])
            return indicators_by_symbol

    def _get_prices(self, symbol):
        self.__stock.set_historical_prices(symbol)
        prices = self.__stock.close_prices
        if len(prices) < self.__terms['long']:
            raise IndexError('prices length is less than long terms')
        else:
            return prices

    def _set_parameters_of_stockmodelprobability(self, log_returns):
        self.stockmodelprobability.myu = self.__stock.calculate_myu(
            log_returns
        )
        self.stockmodelprobability.variance = self.__stock.calculate_variance(
            log_returns
        )

    def _set_attributes_of_stockmodelparameter(self, log_returns, term):
        self.stockmodelparameter.myu = self.__stock.calculate_myu(
            log_returns[-term:]
        )
        self.stockmodelparameter.variance = (
            self.__stock.calculate_variance(
                log_returns[-term:]
            )
        )
        self.stockmodelparameter.term = term

    def _calculate_rate(self, term, initial_price, current_price):
        self.stockmodelprobability.term = term
        self.stockmodelprobability.initial_price = initial_price
        try:
            upper_probability = (
                self.stockmodelprobability.calculate_upper_probability(
                    current_price
                )
            )
        except ZeroDivisionError:
            raise
        else:
            rate = (
                float(
                    Decimal(str(upper_probability)) - Decimal('0.5')
                )
            )
            return rate
