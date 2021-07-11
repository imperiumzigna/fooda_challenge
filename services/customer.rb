# frozen_string_literal: true

class Customer
  attr_accessor :name, :orders, :points, :avg_points

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
    self.orders += 1
    self.points = points + new_points
    self.avg_points = points / orders if orders.positive?
  end
end
