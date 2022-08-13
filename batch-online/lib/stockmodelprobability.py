from lib.probability import Probability
from lib.stockmodelparameter import StockModelParameter
from scipy.stats import norm
from decimal import Decimal


class StockModelProbability(Probability):

    def __init__(self):
        self.stockmodelparameter = StockModelParameter()

    @property
    def myu(self):
        pass

    @property
    def variance(self):
        pass

    @property
    def term(self):
        pass

    @property
    def initial_price(self):
        pass

    @myu.setter
    def myu(self, myu):
        self.__myu = myu

    @variance.setter
    def variance(self, variance):
        self.__variance = variance

    @term.setter
    def term(self, term):
        self.__term = term

    @initial_price.setter
    def initial_price(self, initial_price):
        self.__initial_price = initial_price

    @property
    def myuhat(self):
        self.stockmodelparameter.myu = self.__myu
        self.stockmodelparameter.variance = self.__variance
        self.stockmodelparameter.term = self.__term
        return self.stockmodelparameter.calculate_myuhat()

    @property
    def sigmahat(self):
        self.stockmodelparameter.variance = self.__variance
        self.stockmodelparameter.term = self.__term
        return self.stockmodelparameter.calculate_sigmahat()

    def calculate_upper_probability(self, current_price):
        log_return = float(
            Decimal(str(current_price)).ln()
            - Decimal(str(self.__initial_price)).ln()
        )
        if self.sigmahat == 0:
            raise ZeroDivisionError('sigmahat is zero')
        else:
            return norm.sf(x=log_return, loc=self.myuhat, scale=self.sigmahat)

    def calculate_future_value(self, lower_probability):
        if self.sigmahat == 0:
            raise ZeroDivisionError('sigmahat is zero')
        else:
            future_value = Decimal(norm.ppf(
                q=lower_probability, loc=self.myuhat,
                scale=self.sigmahat
            )).exp() * Decimal(str(self.__initial_price))
            return float(future_value)
