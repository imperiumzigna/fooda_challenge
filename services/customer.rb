class Customer
  attr_accessor :name, :orders, :points, :avg_points

  def initialize(name)
    @name = name
    @orders = 0
    @points = 0
    @avg_points = 0
  end

  def get_report
    if orders.zero?
      "#{name}: No orders."
    else
      "#{name}: #{points} points with #{avg_points} points per order."
    end
  end

  def update(new_points)
    self.orders += 1
    self.points += new_points
    self.avg_points = points / orders if orders > 0
  end

  def find_customer(event, customers)
    customers[event['customer']] || nil
  end
end
