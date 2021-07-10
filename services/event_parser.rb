# frozen_string_literal: true

require_relative './customer'
require_relative './reward'
require_relative './report'
require_relative './event'
require_relative '../policies/reward_policy'
require_relative '../policies/event_policy'

class EventParser
  attr_reader :customers, :data

  def initialize(data)
    @customers = {}
    @data = data&.empty? ? nil : data
  end

  def run
    events = data&.dig('events')

    error('No events to handle found') unless EventPolicy.valid?(events)

    process_data(events)

    Report.render(customers)
  end

  private

  def error(message)
    raise StandardError, message
  end

  def parse(events)
    events.each do |event|
      customers(Event.translate(event, customers))
    rescue StandardError
      next
    end
  end

  def process_data(events)
    return parse(events) if events.size <= 1000

    events.each_slice(1000) do |slice|
      parse(slice)
    end
  end
end
