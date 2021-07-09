require 'time'

module RewardPolicy
  class << self
    def valid?(reward)
      reward >= 3 && reward <= 20
    end
  end
end
