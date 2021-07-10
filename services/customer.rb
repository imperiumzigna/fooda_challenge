# frozen_string_literal: true

class Customer
  attr_reader :name, :orders, :points, :avg_points

  def initialize(name)
    @name = name
    @orders = 0
    @points = 0
    @avg_points = 0
  end

  def report
    if orders.zero?
      "#{name}: No orders."
    else
      "#{name}: #{points} points with #{avg_points} points per order."
    end
  end

  def update(new_points)
    @orders += 1
    @points = points + new_points
    @avg_points = points / orders if orders.positive?
  end

  def find_customer(event, customers)
    customers[event['customer']] || nil
  end
end
