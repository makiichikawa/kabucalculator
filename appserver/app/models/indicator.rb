# frozen_string_literal: true

class Indicator < ApplicationRecord
  self.table_name = 'indicators'

  scope :filter_by_symbols, lambda { |symbols|
    if symbols
      Indicator.where(symbol: symbols.split(','))
    else
      Indicator.all
    end
  }

  scope :filter_by_price, lambda { |lowervalue, uppervalue|
    where(price: lowervalue..uppervalue)
  }

  scope :filter_by_probability_short, lambda { |lowervalue, uppervalue|
    where(probability_short: lowervalue..uppervalue)
  }

  scope :filter_by_myuhat_short, lambda { |lowervalue, uppervalue|
    where(myuhat_short: lowervalue..uppervalue)
  }

  scope :filter_by_sigmahat_short, lambda { |lowervalue, uppervalue|
    where(sigmahat_short: lowervalue..uppervalue)
  }

  scope :filter_by_probability_medium, lambda { |lowervalue, uppervalue|
    where(probability_medium: lowervalue..uppervalue)
  }

  scope :filter_by_myuhat_medium, lambda { |lowervalue, uppervalue|
    where(myuhat_medium: lowervalue..uppervalue)
  }

  scope :filter_by_sigmahat_medium, lambda { |lowervalue, uppervalue|
    where(sigmahat_medium: lowervalue..uppervalue)
  }

  scope :filter_by_probability_long, lambda { |lowervalue, uppervalue|
    where(probability_long: lowervalue..uppervalue)
  }

  scope :filter_by_myuhat_long, lambda { |lowervalue, uppervalue|
    where(myuhat_long: lowervalue..uppervalue)
  }

  scope :filter_by_sigmahat_long, lambda { |lowervalue, uppervalue|
    where(sigmahat_long: lowervalue..uppervalue)
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
