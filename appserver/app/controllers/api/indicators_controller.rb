# frozen_string_literal: true

class Api::IndicatorsController < ApplicationController
  def index
    @indicators = Indicator.order(:id)
  end
end
