# frozen_string_literal: true

class Api::IndicatorsController < ApplicationController
  def index
    @all_indicators = Indicator.filter_by(symbols, price, probability, myuhat, sigmahat)
                               .order(:symbol)
                               .map(&:round)
  end

  private

  def symbols
    params[:symbol].nil? ? nil : params[:symbol].split(',')
  end

  def price
    {
      lower: params[:price_lowervalue],
      upper: params[:price_uppervalue]
    }
  end

  def probability
    {
      short: {
        lower: params[:probability_short_lowervalue],
        upper: params[:probability_short_uppervalue]
      },
      medium: {
        lower: params[:probability_medium_lowervalue],
        upper: params[:probability_medium_uppervalue]
      },
      long: {
        lower: params[:probability_long_lowervalue],
        upper: params[:probability_long_uppervalue]
      }
    }
  end

  def myuhat
     {
      short: {
        lower: params[:myuhat_short_lowervalue],
        upper: params[:myuhat_short_uppervalue]
      },
      medium: {
        lower: params[:myuhat_medium_lowervalue],
        upper: params[:myuhat_medium_uppervalue]
      },
      long: {
        lower: params[:myuhat_long_lowervalue],
        upper: params[:myuhat_long_uppervalue]
      }
    }
  end

  def sigmahat
    {
      short: {
        lower: params[:sigmahat_short_lowervalue],
        upper: params[:sigmahat_short_uppervalue]
      },
      medium: {
        lower: params[:sigmahat_medium_lowervalue],
        upper: params[:sigmahat_medium_uppervalue]
      },
      long: {
        lower: params[:sigmahat_long_lowervalue],
        upper: params[:sigmahat_long_uppervalue]
      }
    }
  end
end
