# frozen_string_literal: true

require_relative './customer'

module Event
  class << self
    ACTIONS = {
      'new_customer' => :new_customer,
      'new_order' => :new_order
    }.freeze

    def translate(event, customers)
      action = ACTIONS[event['action']]

      error("Doesn't know how to handle #{action}") unless action

      send(action, event, customers)
    end

    def new_customer(event, customers)
      id = event['name']
      customers[id] = find_or_create_customer(event, customers)

      customers
    end

    def new_order(event, customers)
      id = event['customer']
      customer = find_or_create_customer(event, customers)

      reward = Reward.calculate(event['amount'], event['timestamp'])
      customer.update(reward) if RewardPolicy.valid?(reward)

      customers[id] = customer
      customers
    end

    private

    def find_or_create_customer(event, customers)
      id = event['name'] || event['customer']

      customers[id] || Customer.new(id)
    end
  end
end
