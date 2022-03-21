# frozen_string_literal: true

RSpec.describe Mutants::Detector do
  describe '#isMutant' do
    context 'when the sequence has invalidate size' do
      it 'raise Mutants::Validations::InvalidSizeDnaSequence' do
        sequence = %w[
          TTTTGA
          ATGTGC
          AGTTGG
          AGAGTG
          CCCCTA
          TCGCTGG
        ]
        expect do
          Mutants::Detector.new(
            Mutants::Validations.new
              .set_sequence(
                sequence
              )
              .set_validate_sizes(true)
              .set_validate_dna(true)
          ).isMutant(sequence)
        end.to raise_error Mutants::Validations::InvalidSizeDnaSequence
      end
    end
    context 'when the sequence has invalidate content DNA' do
      it 'raise Mutants::Validations::InvalidDNA' do
        sequence = %w[
          TTTTGA
          ATGTGC
          AGTTGG
          AGAGTG
          CCCCTA
          TCGCTX
        ]
        expect do
          Mutants::Detector.new(
            Mutants::Validations.new
              .set_sequence(
                sequence
              )
              .set_validate_sizes(true)
              .set_validate_dna(true)
          ).isMutant(sequence)
        end.to raise_error Mutants::Validations::InvalidDNA
      end
    end
    context 'when the sequence has 2 sequence on horizonzal' do
      it 'return true' do
        sequence = %w[
          TTTTGA
          ATGTAC
          AGTTGG
          AGAGTG
          CCCCTA
          TCGCTA
        ]
        expect(Mutants::Detector.new(
          Mutants::Validations.new
            .set_sequence(
              sequence
            )
            .set_validate_sizes(true)
            .set_validate_dna(true)
        ).isMutant(sequence)).to be(true)
      end
    end
    context 'when the sequence has 2 sequence on vertical' do
      it 'return true' do
        sequence = %w[
          AACAAC
          ACACCA
          AACCTA
          ATTGTG
          AAATTT
          CCCTTT
        ]
        expect(Mutants::Detector.new(
          Mutants::Validations.new
            .set_sequence(
              sequence
            )
            .set_validate_sizes(true)
            .set_validate_dna(true)
        ).isMutant(sequence)).to be(true)
      end
    end
    context 'when the sequence has 2 sequence on bottom diagonals from left' do
      it 'return true' do
        sequence = %w[
          CACAAC
          ACACCA
          TACATA
          CTTCCG
          AATCTT
          CCCTTT
        ]
        expect(Mutants::Detector.new(
          Mutants::Validations.new
            .set_sequence(
              sequence
            )
            .set_validate_sizes(true)
            .set_validate_dna(true)
        ).isMutant(sequence)).to be(true)
      end
    end
    context 'when the sequence has 2 sequence on bottom diagonals from right' do
      it 'return true' do
        sequence = %w[
          ATGG
          TCGA
          AGGG
          GCGA
        ]
        expect(Mutants::Detector.new(
          Mutants::Validations.new
            .set_sequence(
              sequence
            )
            .set_validate_sizes(true)
            .set_validate_dna(true)
        ).isMutant(sequence)).to be(true)
      end
    end
    context 'when the sequence has 2 sequence on top diagonals from left' do
      it 'return true' do
        sequence = %w[
          ATGG
          TCGA
          AGGG
          GCGA
        ]
        expect(Mutants::Detector.new(
          Mutants::Validations.new
            .set_sequence(
              sequence
            )
            .set_validate_sizes(true)
            .set_validate_dna(true)
        ).isMutant(sequence)).to be(true)
      end
    end
    context 'when the sequence has 2 sequence on top diagonals from right' do
      it 'return true' do
        sequence = %w[
          ATAG
          TAAA
          AGAG
          ACAA
        ]
        expect(Mutants::Detector.new(
          Mutants::Validations.new
            .set_sequence(
              sequence
            )
            .set_validate_sizes(true)
            .set_validate_dna(true)
        ).isMutant(sequence)).to be(true)
      end
    end
  end
end
