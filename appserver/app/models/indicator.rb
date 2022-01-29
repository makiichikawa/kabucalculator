# frozen_string_literal: true

class Indicator < ApplicationRecord
  self.table_name = 'indicators'
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
