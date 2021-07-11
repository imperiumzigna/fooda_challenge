# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../services/report'
require_relative '../../services/customer'

describe Report do
  let(:customers_unsorted) do
    {
      'person3': Customer.new('person3', points: 2),
      'person1': Customer.new('person1', points: 5),
      'person2': Customer.new('person2', points: 3)
    }
  end

  let(:customers_sorted) do
    {
      'person1': Customer.new('person1', points: 3),
      'person2': Customer.new('person2', points: 2),
      'person3': Customer.new('person3', points: 1)
    }
  end

  context 'renders customer report' do
    it 'sorts unsorted customers' do
      reports = Report.render(customers_unsorted)

      expect(reports).to eql("person1: No orders.\nperson2: No orders.\nperson3: No orders.")
    end

    it 'sorts unsorted customers' do
      reports = Report.render(customers_sorted)

      expect(reports).to eql("person1: No orders.\nperson2: No orders.\nperson3: No orders.")
    end
  end
end
