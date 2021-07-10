# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../policies/reward_policy'

describe RewardPolicy do
  it 'reward in range 3..20' do
    expect(described_class.valid?(3)).to be_truthy
    expect(described_class.valid?(20)).to be_truthy
    expect(described_class.valid?(5)).to be_truthy
  end

  it 'invalid reward' do
    expect(described_class.valid?(2)).to be_falsey
    expect(described_class.valid?(21)).to be_falsey
    expect(described_class.valid?(0)).to be_falsey
  end
end
