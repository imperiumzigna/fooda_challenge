# frozen_string_literal: true

require_relative '../policies/reward_policy'
require 'time'

# Reward Module
#
# Description: This module calculates the reward points an order would get based on
# this time table
#
# Time Rules:
# 12pm - 1pm	1 point per $3 spent                  | 12:00:00 --- 13:00:00
# 11am - 12pm and 1pm - 2pm	1 point per $2 spent    | 11:00:00 --- 12:00:00 or 13:00:00 --- 14:00:00
# 10am - 11am and 2pm - 3pm	1 point per $1 spent    | 10:00:00 --- 11:00:00 or 14:00:00 --- 15:00:00
# Any other time	0.25 points per $1                | any other
#
# Example:
# Jéssica made two orders
#
# Order 1: (amount = 12.50 , time = '12:15:57')
#
#  reward = 1 points per $3 dólars
#
#  total_points = (12.5 / 3).ceil  = 5 points
#
# Order 2: (amount = 16.50 , time = '10:01:00')
#
# reward = 1 point per 1$
# total_points = (16.5 / 1).ceil = 17 points
#
# Average points per order
# (total_points) / number_of_orders = 11 points
#
module Reward
  class << self
    def calculate(amount, timestamp)
      time = Time.parse(timestamp).hour

      settings = RewardPolicy.get_settings(time)
      count_points(amount, settings[:per_point], settings[:prize])
    end

    def count_points(amount, per_point, prize)
      return 0 if prize.zero? || per_point.zero? || amount.zero?

      reward = ((amount / per_point) * prize.to_f).ceil
      RewardPolicy.valid?(reward) ? reward : 0
    end
  end
end
