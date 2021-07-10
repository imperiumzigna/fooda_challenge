require_relative '../spec_helper'
require_relative '../../policies/event_policy'

describe EventPolicy do
  it 'valid data' do
    expect(described_class.valid?([1])).to be_truthy
    expect(described_class.valid?([{}])).to be_truthy
  end

  it 'invalid data' do
    expect(described_class.valid?('')).to be_falsey
    expect(described_class.valid?([])).to be_falsey
    expect(described_class.valid?({})).to be_falsey
    expect(described_class.valid?(nil)).to be_falsey
  end
end
