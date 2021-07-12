# frozen_string_literal: true

module RewardPolicy
  DEFAULT_REWARD_RULE = {
    prize: 0.25, per_point: 1
  }.freeze

  REWARD_RULES = [
    { start: 12, end: 13, prize: 1, per_point: 3 },
    { start: 11, end: 12, prize: 1, per_point: 2 },
    { start: 13, end: 14, prize: 1, per_point: 2 },
    { start: 10, end: 11, prize: 1, per_point: 1 },
    { start: 14, end: 15, prize: 1, per_point: 1 }
  ].freeze

  class << self
    def valid?(reward)
      reward >= 3 && reward <= 20
    end

    def get_settings(time)
      settings = RewardPolicy::REWARD_RULES.find { |rule| between?(time, rule[:start], rule[:end]) }

      settings || RewardPolicy::DEFAULT_REWARD_RULE
    end

    def between?(time, start_time, end_time)
      time >= start_time && time <= end_time
    end
  end
end
