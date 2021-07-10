# frozen_string_literal: true

class Customer
  attr_reader :name, :orders, :points, :avg_points

  def initialize(name, points: 0, orders: 0, avg_points: 0)
    @name = name
    @orders = orders
    @points = points
    @avg_points = avg_points
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
end
