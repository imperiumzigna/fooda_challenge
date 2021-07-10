# frozen_string_literal: true

require_relative './customer'
require 'pry'

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

      customers[id] = Customer.new(id)

      customers
    end

    def new_order(event, customers)
      customer = find_customer(event, customers)

      return unless customer

      reward = Reward.calculate(event['amount'], event['timestamp'])
      customer.update(reward) if RewardPolicy.valid?(reward)

      customers
    end

    def find_customer(event, customers)
      customers[event['customer']] || nil
    end
  end
end
