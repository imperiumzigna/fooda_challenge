module EventPolicy
  class << self
    def valid?(events)
      events.is_a?(Array) && !events.empty?
    end
  end
end
