# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../services/event_parser'

describe EventParser do
  let(:default_json) do
    load_json('default.json')
  end

  let(:shuffled_json) do
    load_json('shuffled.json')
  end

  it 'run event processing with invalid data' do
    expect { described_class.new({}).run }.to raise_error(StandardError, 'No events to handle found')
    expect { described_class.new(nil).run }.to raise_error(StandardError, 'No events to handle found')
    expect { described_class.new([]).run }.to raise_error(StandardError, 'No events to handle found')
  end

  context 'run' do
    it 'parses events to generate a report' do
      json = JSON.parse(default_json)
      parser = EventParser.new(json)

      message = parser.run
      expect(parser.customers.keys).to eql(%w[Jessica Will Elizabeth])
      expect(message).to eql("Jessica: 22 points with 11 points per order.\nWill: 3 points with 3 points per order.\nElizabeth: No orders.")
    end

    it 'parses events shuffled to generate a report' do
      json = JSON.parse(shuffled_json)
      parser = EventParser.new(json)

      message = parser.run

      expect(parser.customers.keys).to eql(%w[Jessica Will Elizabeth])
      expect(message).to eql("Jessica: 22 points with 11 points per order.\nWill: 3 points with 3 points per order.\nElizabeth: No orders.")
    end
  end
end
