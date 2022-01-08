# frozen_string_literal: true

class Api::IndicatorsController < ApplicationController
  def index
    @Indicators = Indicator.order(:id)
  end
end
