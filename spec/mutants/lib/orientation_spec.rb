# frozen_string_literal: true

RSpec.describe Mutants::Orientation do
  describe '::HORIZONTAL' do
    context 'When call the constant it has an integer' do
      it 'return number 0' do
        expect(described_class::HORIZONTAL).to be(0)
      end
    end
  end
  describe '::VERTICAL' do
    context 'When call the constant it has an integer' do
      it 'return number 1' do
        expect(described_class::VERTICAL).to be(1)
      end
    end
  end
  describe '::BELOW_MAIN_DIAGONAL' do
    context 'When call the constant it has an integer' do
      it 'return number 2' do
        expect(described_class::BELOW_MAIN_DIAGONAL).to be(2)
      end
    end
  end
  describe '::ABOVE_MAIN_DIAGONAL_INCLUDING' do
    context 'When call the constant it has an integer' do
      it 'return number 3' do
        expect(described_class::ABOVE_MAIN_DIAGONAL_INCLUDING).to be(3)
      end
    end
  end
  describe '::FROM_RIGHT' do
    context 'When call the constant it has an integer' do
      it 'return number 4' do
        expect(described_class::FROM_RIGHT).to be(4)
      end
    end
  end
  describe '::FROM_LEFT' do
    context 'When call the constant it has an integer' do
      it 'return number 5' do
        expect(described_class::FROM_LEFT).to be(5)
      end
    end
  end
end
