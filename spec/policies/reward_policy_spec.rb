require_relative '../spec_helper'
require_relative '../../policies/reward_policy'

describe RewardPolicy do
  it 'reward in range 3..20' do
    expect(RewardPolicy.valid?(3)).to be_truthy
    expect(RewardPolicy.valid?(20)).to be_truthy
    expect(RewardPolicy.valid?(5)).to be_truthy
  end

  it 'invalid reward' do
    # failed validations
    expect(RewardPolicy.valid?(2)).to be_falsey
    expect(RewardPolicy.valid?(21)).to be_falsey
    expect(RewardPolicy.valid?(0)).to be_falsey
  end
end
