require_relative '../spec_helper'
require_relative '../../services/event_parser'

describe EventParser do
  it 'run event processing with invalid data' do
    expect { described_class.new({}).run }.to raise_error(StandardError, 'No events to handle found')
    expect { described_class.new(nil).run }.to raise_error(StandardError, 'No events to handle found')
    expect { described_class.new([]).run }.to raise_error(StandardError, 'No events to handle found')
  end
end
