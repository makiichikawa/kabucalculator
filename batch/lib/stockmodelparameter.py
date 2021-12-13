from decimal import Decimal, ROUND_HALF_UP


class StockModelParameter:

    @property
    def myu(self):
        pass

    @property
    def variance(self):
        pass

    @property
    def term(self):
        pass

    @myu.setter
    def myu(self, myu):
        self.__myu = Decimal(str(myu))

    @variance.setter
    def variance(self, variance):
        self.__variance = Decimal(str(variance))

    @term.setter
    def term(self, term):
        self.__term = Decimal(str(term))

    def calculate_myuhat(self):
        myuhat = ((
            self.__myu - self.__variance / Decimal('2')
            ) * self.__term
        ).quantize(
            Decimal('0.000000000000001'), rounding=ROUND_HALF_UP
        )
        return float(myuhat)

    def calculate_sigmahat(self):
        sigmahat = ((self.__variance * self.__term).sqrt()).quantize(
            Decimal('0.000000000000001'), rounding=ROUND_HALF_UP
        )
        return float(sigmahat)
