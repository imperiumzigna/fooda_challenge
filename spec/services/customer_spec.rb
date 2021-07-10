# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../services/customer'

describe Customer do
  context 'creates a customer' do
    it 'initializes customer with default values' do
      customer = described_class.new('person1')
      expect(customer.name).to eql('person1')
      expect(customer.orders).to eql(0)
      expect(customer.points).to eql(0)
      expect(customer.avg_points).to eql(0)
    end

    it 'fails to initialize customer' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end
  end

  context 'report' do
    it 'renders message for no orders' do
      customer = described_class.new('person1')

      expect(customer.report).to eql("#{customer.name}: No orders.")
    end

    it 'renders number of points and average points per order' do
      customer = described_class.new('person1', points: 10, avg_points: 2, orders: 2)

      expect(customer.report).to eql("#{customer.name}: #{customer.points} points with #{customer.avg_points} points per order.")
    end
  end

  context 'update customer' do
    it 'recalculate customer points' do
      customer = described_class.new('John')
      new_points = 10
      customer.update(new_points)

      expect(customer.orders).to eql(1)
      expect(customer.points).to eql(new_points)
      expect(customer.avg_points).to eql(10)
    end
  end
end
