# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../services/event'
require_relative '../../services/customer'

describe Event do
  let(:new_customer) do
    '{"action": "new_customer",
      "name": "customer_name",
      "timestamp": "2020-07-01T01:00:00-05:00"}'
  end

  let(:new_order) do
    '{"action": "new_order",
      "customer": "customer",
      "amount": 12.50,
      "timestamp": "2020-07-01T12:15:57-05:00"}'
  end

  let(:customers_data) do
    { "person1": Customer.new('person'), "customer": Customer.new('person2') }
  end

  context 'validations' do
    it 'invalid actions' do
      expect { described_class.translate({}, {}) }.to raise_error("Doesn't know how to handle action")
      expect do
        described_class.translate({ "action": 'something' },
                                  {})
      end.to raise_error("Doesn't know how to handle action")
    end
  end
  context 'valid actions' do
    it 'new_customer' do
      customers = Event.new_customer(JSON.parse(new_customer), {})
      expect(customers).to have_key('customer_name')
      expect(customers['customer_name']).to be_a(Customer)
    end

    it 'new_order' do
      customers = Event.new_order(JSON.parse(new_order), {})
      expect(customers).to have_key('customer')
      expect(customers['customer']).to be_a(Customer)
      expect(customers['customer'].points).to eql(5)
    end
  end

  context 'find customers or create' do
    it 'finds a customer by name' do
      customer = Event.send(:find_or_create_customer, new_order, customers_data)

      expect(customer).to be_a(Customer)
      expect(customer.name).to eql('customer')
      expect(customer.points).to eql(0)
    end

    it 'returns a new customer' do
      customer = Event.send(:find_or_create_customer, new_order, {})

      expect(customer).to be_a(Customer)
      expect(customer.name).to eql('customer')
      expect(customer.points).to eql(0)
    end
  end
end
