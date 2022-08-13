import numpy as np
from abc import ABCMeta, abstractclassmethod
from decimal import Decimal


class Product(metaclass=ABCMeta):
    def __init__(self, from_date, to_date, country, interval):
        self.prices = {}
        self.from_date = str(from_date.day) + '/'\
            + str(from_date.month) + '/'\
            + str(from_date.year)
        self.to_date = str(to_date.day) + '/'\
            + str(to_date.month) + '/'\
            + str(to_date.year)
        self.interval = interval
        self.country = country

    @abstractclassmethod
    def set_historical_prices(self):
        pass

    def calculate_log_return(self, stocks):
        log_return = []
        for term in range(len(stocks)-1):
            log_return.append(
                float(
                    Decimal(str(stocks[term+1])).ln()
                    - Decimal(str(stocks[term])).ln()
                )
            )
        return log_return

    def calculate_myu(self, log_return):
        np_log_return = np.array(log_return)
        return np_log_return.mean()

    def calculate_variance(self, log_return):
        return np.var(log_return, ddof=1)
