require_relative './customer'
require_relative './reward'
require_relative './report'
require_relative './event'
require_relative '../policies/reward_policy'
require_relative '../policies/event_policy'

class EventParser
  attr_accessor :customers

  def initialize(data)
    @customers = {}
    @data = data&.empty? ? nil : data
  end

  def run
    events = @data&.dig('events')

    error('No events to handle found') unless EventPolicy.valid?(events)

    events.each_slice(1000) do |slice|
      slice.map do |event|
        self.customers = Event.translate(event, customers)
      rescue StandardError
        next
      end
    end
    Report.render(customers)
  end

  private

  def error(message)
    raise StandardError, message
  end
end
