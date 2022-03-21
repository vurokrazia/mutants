# frozen_string_literal: true

RSpec.describe Mutants::Configuration do
  describe '::MIN_SEQUENCES_TO_BE_MUTANT' do
    context 'When call the constant it has an integer' do
      it 'return number 2' do
        expect(described_class::MIN_SEQUENCES_TO_BE_MUTANT).to be(2)
      end
    end
  end
  describe '::COUNTER_SEQUENCES' do
    context 'When call the constant it has an integer' do
      it 'return number 4' do
        expect(described_class::COUNTER_SEQUENCES).to be(4)
      end
    end
  end
end
