require_relative '../spec_helper'
require_relative '../../services/event_parser'

describe EventParser do
  it 'checks valid events array' do
    expect(described_class.new([1]).send(:valid?, [1])).to be_truthy
    expect(described_class.new([{}]).send(:valid?, [{}])).to be_truthy

    # failures
    expect(described_class.new('').send(:valid?, '')).to be_falsey
    expect(described_class.new([]).send(:valid?, [])).to be_falsey
    expect(described_class.new({}).send(:valid?, {})).to be_falsey
    expect(described_class.new(nil).send(:valid?, nil)).to be_falsey
  end

  it 'run event processing with invalid data' do
    expect { described_class.new({}).run }.to raise_error(StandardError, 'No events to handle found')
    expect { described_class.new(nil).run }.to raise_error(StandardError, 'No events to handle found')
    expect { described_class.new([]).run }.to raise_error(StandardError, 'No events to handle found')
  end
end
