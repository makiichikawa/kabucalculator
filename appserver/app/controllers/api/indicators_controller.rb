# frozen_string_literal: true

class Api::IndicatorsController < ApplicationController
  before_action :set_symbols_array
  def index
    @all_indicators = Indicator.filter_by_symbols(@symbols_array)
                               .filter_by_price(params[:pricelowervalue], params[:priceuppervalue])
                               .filter_by_probability_short(params[:probability_shortlowervalue], params[:probability_shortuppervalue])
                               .filter_by_myuhat_short(params[:myuhat_shortlowervalue], params[:myuhat_shortuppervalue])
                               .filter_by_sigmahat_short(params[:sigmahat_shortlowervalue], params[:sigmahat_shortuppervalue])
                               .filter_by_probability_medium(params[:probability_mediumlowervalue], params[:probability_mediumuppervalue])
                               .filter_by_myuhat_medium(params[:myuhat_mediumlowervalue], params[:myuhat_mediumuppervalue])
                               .filter_by_sigmahat_medium(params[:sigmahat_mediumlowervalue], params[:sigmahat_mediumuppervalue])
                               .filter_by_probability_long(params[:probability_longlowervalue], params[:probability_longuppervalue])
                               .filter_by_myuhat_long(params[:myuhat_longlowervalue], params[:myuhat_longuppervalue])
                               .filter_by_sigmahat_long(params[:sigmahat_longlowervalue], params[:sigmahat_longuppervalue])
  end

  private

  def set_symbols_array
    @symbols_array = params[:symbol].nil? ? nil : params[:symbol].split(',')
  end
end
