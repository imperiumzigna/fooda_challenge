# frozen_string_literal: true

require 'pry'
module Report
  class << self
    def render(customers = {})
      reports = customers.values.sort { |a, b| b.points <=> a.points }.map(&:report)

      reports.join("\n")
    end
  end
end
