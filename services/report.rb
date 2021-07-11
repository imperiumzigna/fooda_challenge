# frozen_string_literal: true

module Report
  class << self
    def render(customers = {})
      reports = customers.values.sort_by(&:points).reverse.map(&:report)

      reports.join("\n")
    end
  end
end
