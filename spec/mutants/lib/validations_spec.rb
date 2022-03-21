# frozen_string_literal: true

RSpec.describe Mutants::Validations do
  describe '#set_sequence' do
    context 'When set string to sequence' do
      it 'raise Mutants::Validations::NotAnArraySequence' do
        expect do
          described_class.new
                         .set_sequence('ACTG,ACTG,ATTT,CCCC')
        end.to raise_error(Mutants::Validations::NotAnArraySequence)
      end
    end
    context 'When sequence is less than COUNTER SEQUENCES' do
      it 'raise Mutants::Validations::NotAnArraySequence' do
        expect do
          described_class.new
                         .set_sequence(
                           %w[
                             ATT
                             ATG
                             AGT
                           ].freeze

                         )
        end.to raise_error(Mutants::Validations::NotAnArraySequence)
      end
    end
    context 'When sequence is greater than or equal COUNTER SEQUENCES' do
      it 'return sequence' do
        expect(
          described_class.new
                         .set_sequence(
                           %w[
                             ATTT
                             ATGT
                             AGTT
                             AGGG
                           ].freeze
                         ).sequence
        ).to eql(
          %w[
            ATTT
            ATGT
            AGTT
            AGGG
          ].freeze
        )
      end
    end
    context 'When set array to sequence' do
      it 'return same sequence' do
        expect(
          described_class.new
                         .set_sequence(
                           %w[
                             ATTTGA
                             ATGTGC
                             AGTTGG
                             AGATGG
                             CCCCTA
                             TCGCTG
                           ].freeze
                         ).sequence
        ).to eql(%w[
          ATTTGA
          ATGTGC
          AGTTGG
          AGATGG
          CCCCTA
          TCGCTG
        ].freeze)
      end
    end
  end
  describe '#set_validate_sizes' do
    context 'When be enabled validation' do
      it 'return true' do
        expect(
          described_class.new
            .set_validate_sizes(true)
            .validate_sizes
        ).to be(true)
      end
    end
    context 'when you do not enable validation' do
      it 'it should be disabled by default' do
        expect(
          described_class.new
            .validate_sizes
        ).to be(nil)
      end
    end
  end
  describe '#set_validate_dna' do
    context 'When be enabled validation' do
      it 'return true' do
        expect(
          described_class.new
            .set_validate_dna(true)
            .validate_dna
        ).to be(true)
      end
    end
    context 'when you do not enable validation' do
      it 'it should be disabled by default' do
        expect(
          described_class.new
            .validate_dna
        ).to be(nil)
      end
    end
  end
  describe '#validate' do
    context 'when enabled validation size and send incorrect size' do
      it 'raise Mutants::Validations::InvalidSizeDnaSequence' do
        expect  do
          described_class.new
                         .set_sequence(
                           %w[
                             ATTTGA
                             ATGTGC
                             AGTTGG
                             AGATGG
                             CCCCTA
                             TCGCTGG
                           ].freeze
                         )
                         .set_validate_sizes(true)
                         .validate
        end.to raise_error(Mutants::Validations::InvalidSizeDnaSequence)
      end
    end
    context 'when disabled validation size with incorrect sequence' do
      it 'return true' do
        expect(
          described_class.new
                         .set_sequence(
                           %w[
                             ATTTGA
                             ATGTGC
                             AGTTGG
                             AGATGG
                             CCCCTA
                             TCGCTGG
                           ].freeze
                         )
                         .validate
        ).to be(true)
      end
    end
    context 'when enabled validation size with correct sequence' do
      it 'return true' do
        expect(
          described_class.new
                         .set_sequence(
                           %w[
                             ATTTGA
                             ATGTGC
                             AGTTGG
                             AGATGG
                             CCCCTA
                             TCGCTG
                           ].freeze
                         )
                         .set_validate_sizes(true)
                         .validate
        ).to be(true)
      end
    end

    context 'when enabled validation dna and send incorrect dna' do
      it 'raise Mutants::Validations::InvalidDNA' do
        expect  do
          described_class.new
                         .set_sequence(
                           %w[
                             ATTTGA
                             ATGTGC
                             AGTTGG
                             AGATGG
                             CCCCTA
                             TCGCTX
                           ].freeze
                         )
                         .set_validate_dna(true)
                         .validate
        end.to raise_error(Mutants::Validations::InvalidDNA)
      end
    end
    context 'when disabled validation dna with incorrect sequence' do
      it 'return true' do
        expect(
          described_class.new
                         .set_sequence(
                           %w[
                             ATTTGA
                             ATGTGC
                             AGTTGG
                             AGATGG
                             CCCCTA
                             TCGCTX
                           ].freeze
                         )
                         .validate
        ).to be(true)
      end
    end
    context 'when enabled validation dna with correct sequence' do
      it 'return true' do
        expect(
          described_class.new
                         .set_sequence(
                           %w[
                             ATTTGA
                             ATGTGC
                             AGTTGG
                             AGATGG
                             CCCCTA
                             TCGCTG
                           ].freeze
                         )
                         .set_validate_dna(true)
                         .validate
        ).to be(true)
      end
    end
  end
end
