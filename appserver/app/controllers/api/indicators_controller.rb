# frozen_string_literal: true

class Api::IndicatorsController < ApplicationController
  before_action :set_sql
  def index
    @all_indicators = if @sql.empty?
                        Indicator.order(:id).map(&:round)
                      else
                        Indicator.where(@sql).order(:id).map(&:round)
                      end
  end

  private

  def set_sql
    queryparams = params.permit!.to_h.each_with_object([]) do |(key, value), params|
      if key == 'symbol'
        params << value.split(',')
                       .map { |symbol| "symbol = #{symbol}" }
                       .join(' or ')
      elsif key.include?('uppervalue')
        params << "#{key.gsub(/uppervalue/, '')} <= #{value}"
      elsif key.include?('lowervalue')
        params << "#{key.gsub(/lowervalue/, '')} >= #{value}"
      end
    end
    @sql = queryparams.empty? ? '' : queryparams.join(' and ')
  end
end
