# frozen_string_literal: true

RSpec.describe :VERSION do
  describe '::VERSION' do
    context 'When make build to gem has a number' do
      it 'return version number' do
        expect(Mutants::VERSION.to_f > 0).to be(true)
      end
    end
    context 'When make build to gem version is not a nil' do
      it 'return true' do
        expect(Mutants::VERSION).not_to be nil
      end
    end
  end
end
