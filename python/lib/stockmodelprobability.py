from lib.probability import Probability
from lib.actualnormparameter import ActualNormParameter
from math import log
from scipy.stats import norm


class StockModelProbability(Probability):

    def set_attribute(self, myu, variance, term, initial_price):
        self.actual_norm_parameters = ActualNormParameter()
        self.actual_norm_parameters.set_parameters(myu, variance, term)
        self.initial_price = initial_price

    def calculate_upper_probability(self, current_price):
        log_return = log(current_price) - log(self.initial_price)
        myuhat = self.actual_norm_parameters.calculate_myuhat()
        sigmahat = self.actual_norm_parameters.calculate_sigmahat()
        return norm.sf(x=log_return, loc=myuhat, scale=sigmahat)
