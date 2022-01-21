# frozen_string_literal: true

class Api::IndicatorsController < ApplicationController
  def index
    @all_indicators = Indicator.order(:id).map(&:round)
  end
end
