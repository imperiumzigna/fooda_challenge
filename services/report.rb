# frozen_string_literal: true

module Report
  class << self
    def render(customers = {})
      reports = customers.values.map(&:report)

      puts reports.join("\n")
    end
  end
end
