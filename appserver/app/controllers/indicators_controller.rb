# frozen_string_literal: true

class IndicatorsController < ApplicationController
  def index
    @indicators = Indicator.order(:id)
  end
end
