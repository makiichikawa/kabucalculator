# frozen_string_literal: true

class Indicator < ApplicationRecord
  self.table_name = 'indicators'

  scope :filter_by_symbols, lambda { |symbols|
    where(symbol: symbols) unless symbols.nil?
  }

  scope :filter_by_price, lambda { |price|
    where(price: price[:lower]..price[:upper])
  }

  scope :filter_by_probability, lambda { |probability|
    where(
      probability_short: probability[:short][:lower]..probability[:short][:upper],
      probability_medium: probability[:medium][:lower]..probability[:medium][:upper],
      probability_long: probability[:long][:lower]..probability[:long][:upper]
    )
  }

  scope :filter_by_myuhat, lambda { |myuhat|
    where(
      myuhat_short: myuhat[:short][:lower]..myuhat[:short][:upper],
      myuhat_medium: myuhat[:medium][:lower]..myuhat[:medium][:upper],
      myuhat_long: myuhat[:long][:lower]..myuhat[:long][:upper]
    )
  }

  scope :filter_by_sigmahat, lambda { |sigmahat|
    where(
      sigmahat_short: sigmahat[:short][:lower]..sigmahat[:short][:upper],
      sigmahat_medium: sigmahat[:medium][:lower]..sigmahat[:medium][:upper],
      sigmahat_long: sigmahat[:long][:lower]..sigmahat[:long][:upper]
    )
  }

  scope :filter_by, lambda { |symbols, price, probability, myuhat, sigmahat|
    filter_by_symbols(symbols).filter_by_price(price)
                              .filter_by_probability(probability)
                              .filter_by_myuhat(myuhat)
                              .filter_by_sigmahat(sigmahat)
  }

  def round
    indicators = {}
    indicators['symbol'] = symbol
    indicators['price'] = price
    indicators['probability_short'] = probability_short.round(4)
    indicators['myuhat_short'] = myuhat_short.round(4)
    indicators['sigmahat_short'] = sigmahat_short.round(4)
    indicators['probability_medium'] = probability_medium.round(4)
    indicators['myuhat_medium'] = myuhat_medium.round(4)
    indicators['sigmahat_medium'] = sigmahat_medium.round(4)
    indicators['probability_long'] = probability_long.round(4)
    indicators['myuhat_long'] = myuhat_long.round(4)
    indicators['sigmahat_long'] = sigmahat_long.round(4)
    indicators
  end
end
