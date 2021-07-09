require_relative './customer'
require_relative './reward'
require_relative './report'
require_relative '../policies/reward_policy'

class EventParser
  attr_accessor :customers

  def initialize(data)
    @customers = {}
    @data = data&.empty? ? nil : data
  end

  def run
    events = @data&.dig('events')

    error('No events to handle found') unless valid?(events)

    events.each_slice(1000) do |slice|
      slice.map do |event|
        translate(event)
      rescue StandardError
        next
      end
    end
    Report.render(customers)
  end

  private

  def translate(event)
    case event['action']
    when 'new_customer'
      new_customer(event)
    when 'new_order'
      new_order(event)
    else
      error("Doesn't know how to handle #{event['action']}")
    end
  end

  def new_customer(event)
    @customers[event['name']] = Customer.new(event['name'])
  end

  def new_order(event)
    customer = find_customer(event)

    return if customer.nil?

    reward = Reward.calculate(event['amount'], event['timestamp'])
    customer.update(reward) if RewardPolicy.valid?(reward)
  end

  def find_customer(event)
    customers[event['customer']] || nil
  end

  def valid?(events)
    events.is_a?(Array) && !events.empty?
  end

  def error(message)
    raise StandardError, message
  end
end
