from decimal import Decimal


class ActualNormParameter:

    def set_parameters(self, myu, variance, term):
        self.myu = Decimal(str(myu))
        self.variance = Decimal(str(variance))
        self.term = Decimal(str(term))

    def calculate_myuhat(self):
        myuhat = float((self.myu - self.variance / Decimal('2')) * self.term)
        return myuhat

    def calculate_sigmahat(self):
        sigmahat = float((self.variance * self.term).sqrt())
        return sigmahat
