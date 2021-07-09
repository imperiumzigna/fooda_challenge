module Report
  class << self
    def render(customers = {})
      reports = customers.values.map(&:get_report)

      puts reports.join("\n")
    end
  end
end
