from decimal import Decimal, ROUND_HALF_UP


class StockModelParameter:

    def set_parameters(self, myu, variance, term):
        self.myu = Decimal(str(myu))
        self.variance = Decimal(str(variance))
        self.term = Decimal(str(term))

    def calculate_myuhat(self):
        myuhat = ((
            self.myu - self.variance / Decimal('2')
            ) * self.term
        ).quantize(
            Decimal('0.000000000000001'), rounding=ROUND_HALF_UP
        )
        return float(myuhat)

    def calculate_sigmahat(self):
        sigmahat = ((self.variance * self.term).sqrt()).quantize(
            Decimal('0.000000000000001'), rounding=ROUND_HALF_UP
        )
        return float(sigmahat)
