require_relative './customer'
require 'pry'

module Event
  class << self
    ACTIONS = {
      'new_customer' => :new_customer,
      'new_order' => :new_order
    }

    def translate(event, customers)
      action = ACTIONS[event['action']]

      error("Doesn't know how to handle #{event['action']}") if action.nil?
      send(action, event, customers)
    end

    def new_customer(event, customers)
      customers[event['name']] = Customer.new(event['name'])

      customers
    end

    def new_order(event, customers)
      customer = customers[event['customer']].find_customer(event, customers)

      return if customer.nil?

      reward = Reward.calculate(event['amount'], event['timestamp'])
      customer.update(reward) if RewardPolicy.valid?(reward)

      customers
    end
  end
end
