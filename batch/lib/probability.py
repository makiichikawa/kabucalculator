from abc import ABCMeta, abstractclassmethod


class Probability(metaclass=ABCMeta):

    @abstractclassmethod
    def calculate_upper_probability(self, stochastic_variable):
        pass
