# frozen_string_literal: true

class Api::IndicatorsController < ApplicationController
  before_action :set_symbols_array
  def index
    @all_indicators = Indicator.filter_by_symbols(@symbols_array)
                               .filter_by_price(params[:price_lowervalue], params[:price_uppervalue])
                               .filter_by_probability_short(params[:probability_short_lowervalue], params[:probability_short_uppervalue])
                               .filter_by_myuhat_short(params[:myuhat_short_lowervalue], params[:myuhat_short_uppervalue])
                               .filter_by_sigmahat_short(params[:sigmahat_short_lowervalue], params[:sigmahat_short_uppervalue])
                               .filter_by_probability_medium(params[:probability_medium_lowervalue], params[:probability_medium_uppervalue])
                               .filter_by_myuhat_medium(params[:myuhat_medium_lowervalue], params[:myuhat_medium_uppervalue])
                               .filter_by_sigmahat_medium(params[:sigmahat_medium_lowervalue], params[:sigmahat_medium_uppervalue])
                               .filter_by_probability_long(params[:probability_long_lowervalue], params[:probability_long_uppervalue])
                               .filter_by_myuhat_long(params[:myuhat_long_lowervalue], params[:myuhat_long_uppervalue])
                               .filter_by_sigmahat_long(params[:sigmahat_long_lowervalue], params[:sigmahat_long_uppervalue])
  end

  private

  def set_symbols_array
    @symbols_array = params[:symbol].nil? ? nil : params[:symbol].split(',')
  end
end
