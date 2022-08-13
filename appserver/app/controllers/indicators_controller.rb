# frozen_string_literal: true

class IndicatorsController < ApplicationController
  def index
    @update_at = Indicator.order(:update_at).last.update_at
  end

  def show
    @indicators = Indicator.find(params[:id])
  end

  def additionals; end
end
