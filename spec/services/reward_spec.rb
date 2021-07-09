require_relative '../spec_helper'
require_relative '../../services/reward'

describe Reward do
  it 'return 0 points for invalid amount or prize' do
    expect(Reward.count_points(0, 0, 1)).to be(0)
    expect(Reward.count_points(3, 0, 1)).to be(0)
    expect(Reward.count_points(3, 0, 1)).to be(0)
    expect(Reward.count_points(22, 0, 1)).to be(0)
    expect(Reward.count_points(3, -1, 1)).to be(0)
  end

  it 'count points for valid reward' do
    expect(Reward.count_points(3, 1, 1)).to eq(3)
    expect(Reward.count_points(6, 2, 1)).to eq(3)
    expect(Reward.count_points(15.30, 2, 1)).to eq(8)
  end

  it 'calculate reward 12pm - 1pm' do
    expect(Reward.calculate(11.4, '12:00:00')).to be(4)
    expect(Reward.calculate(12.4, '13:30:00')).to be(5)
  end

  it 'calculate reward 11pm - 12pm' do
    expect(Reward.calculate(12.4, '11:30:00')).to be(7)
    expect(Reward.calculate(12.4, '12:30:00')).to be(7)
  end

  it 'calculate reward 1pm - 2pm' do
    expect(Reward.calculate(6.4, '13:30:00')).to be(4)
    expect(Reward.calculate(6.4, '14:30:00')).to be(4)
  end

  it 'calculate reward 10am - 11am' do
    expect(Reward.calculate(6.4, '10:30:00')).to be(7)
    expect(Reward.calculate(6.4, '11:30:00')).to be(4)
  end

  it 'calculate reward 2pm - 3pm' do
    expect(Reward.calculate(6.4, '14:30:00')).to be(4)
    expect(Reward.calculate(6.4, '15:30:00')).to be(7)
  end

  it 'any other time' do
    expect(Reward.calculate(12.4, '09:30:00')).to be(4)
    expect(Reward.calculate(12.4, '08:30:00')).to be(4)
    expect(Reward.calculate(12.4, '18:30:00')).to be(4)
    expect(Reward.calculate(12.4, '19:30:00')).to be(4)
  end
end
