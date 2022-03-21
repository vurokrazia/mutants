# frozen_string_literal: true

RSpec.describe Mutants::Dna do
  describe '#horizontal' do
    context 'When send sequence with 2 matchs' do
      it 'return true' do
        expect((described_class.new.horizontal(%w[
          TTTTGA
          ATGTGC
          AGTTGG
          AGATGG
          CCCCTA
          TCGCTG
        ].freeze))).to be true
      end
    end
    context 'When send sequence with 1 match' do
      it 'return false' do
        expect((described_class.new.horizontal(%w[
          ATTTGA
          ATGTGC
          AGTTGG
          AGATGG
          CCCCTA
          TCGCTG
        ].freeze))).to be false
      end
    end
    context 'When send sequence with 0 match' do
      it 'return false' do
        expect((described_class.new.horizontal(%w[
          ATTTGA
          ATGTGC
          AGTTGG
          AGATGG
          CCCATA
          TCGCTG
        ].freeze))).to be false
      end
    end
    context 'When send sequence empty' do
      it 'return false' do
        expect((described_class.new.horizontal([]))).to be false
      end
    end
  end

  describe '#vertical' do
    context 'When send sequence with 2 matchs' do
      it 'return true' do
        expect((described_class.new.vertical(%w[
          TTTTGA
          ATGTGC
          AGTTGG
          AGATGG
          ACCCTA
          TCGCTG
        ].freeze))).to be true
      end
    end
    context 'When send sequence with 1 match' do
      it 'return false' do
        expect((described_class.new.vertical(%w[
          ATTTGA
          ATGTGC
          AGTTAG
          AGAGGG
          CCCCTA
          TCGCTG
        ].freeze))).to be false
      end
    end
    context 'When send sequence with 0 match' do
      it 'return false' do
        expect((described_class.new.vertical(%w[
          ATTTGA
          TTGTGC
          AGTTGG
          AGATAG
          CCCATA
          TCGCTG
        ].freeze))).to be false
      end
    end
    context 'When send sequence empty' do
      it 'return false' do
        expect((described_class.new.vertical([]))).to be false
      end
    end
  end

  describe '#bottom_diagonals_from_left_read_without_main_diagonal' do
    context 'When send sequence with 2 matchs' do
      it 'return true' do
        expect(
          described_class.new
          .bottom_diagonals_from_left_read_without_main_diagonal(
            %w[
              ATTTGA
              ATGTGC
              AGTTGG
              AAGTGG
              ACAGTA
              TCGAGG
            ].freeze
          )
        ).to be true
      end
    end
    context 'When send sequence with 1 match' do
      it 'return false' do
        expect(
          described_class.new\
          .bottom_diagonals_from_left_read_without_main_diagonal(
            %w[
              ATTTGA
              ATGTGC
              AGTTGG
              AGGTGG
              ACAGTA
              TCGAGG
            ].freeze
          )
        ).to be false
      end
    end
    context 'When send sequence with 0 match' do
      it 'return false' do
        expect(described_class.new\
        .bottom_diagonals_from_left_read_without_main_diagonal(
          %w[
            ATTTGA
            TTGTGC
            AGTTGG
            AGATAG
            CCCATA
            TCGCTG
          ].freeze
        )).to be false
      end
    end
    context 'When send sequence empty' do
      it 'return false' do
        expect(described_class.new\
         .bottom_diagonals_from_left_read_without_main_diagonal(
           []
         )).to be false
      end
    end
  end

  describe '#bottom_diagonals_from_right_read_without_main_diagonal' do
    context 'When send sequence with 2 matchs' do
      it 'return true' do
        expect(
          described_class.new
          .bottom_diagonals_from_right_read_without_main_diagonal(
            %w[
              ATTTGA
              ATGTGC
              GGTTCG
              AAGCGG
              ACCGTA
              TCGAGG
            ].freeze
          )
        ).to be true
      end
    end
    context 'When send sequence with 1 match' do
      it 'return false' do
        expect(
          described_class.new\
          .bottom_diagonals_from_right_read_without_main_diagonal(
            %w[
              ATTTGA
              ATGTGC
              GGTTGG
              AAGTGG
              ACAGTA
              TCGAGG
            ].freeze
          )
        ).to be false
      end
    end
    context 'When send sequence with 0 match' do
      it 'return false' do
        expect(described_class.new\
        .bottom_diagonals_from_right_read_without_main_diagonal(
          %w[
            ATTTGA
            TTGTGC
            AGTTGG
            AGATAG
            CCCATA
            TCGCTG
          ].freeze
        )).to be false
      end
    end
    context 'When send sequence empty' do
      it 'return false' do
        expect(described_class.new\
         .bottom_diagonals_from_right_read_without_main_diagonal(
           []
         )).to be false
      end
    end
  end

  describe '#top_diagonals_from_left_read_with_main_diagonal' do
    context 'When send sequence with 2 matchs' do
      it 'return true' do
        expect(
          described_class.new
          .top_diagonals_from_left_read_with_main_diagonal(
            %w[
              ATTTGA
              GCGTGC
              GGCGTG
              AAGCGT
              ACAGCA
              TCGAGG
            ].freeze
          )
        ).to be true
      end
    end
    context 'When send sequence with 1 match' do
      it 'return false' do
        expect(
          described_class.new\
          .top_diagonals_from_left_read_with_main_diagonal(
            %w[
              ATTTGA
              ATGTGC
              GGTTGG
              AAGTGG
              ACAGTA
              TCGAGG
            ].freeze
          )
        ).to be false
      end
    end
    context 'When send sequence with 0 match' do
      it 'return false' do
        expect(described_class.new\
        .top_diagonals_from_left_read_with_main_diagonal(
          %w[
            ATTTGA
            TTGTGC
            AGTTGG
            AGATAG
            CCCATA
            TCGCTG
          ].freeze
        )).to be false
      end
    end
    context 'When send sequence empty' do
      it 'return false' do
        expect(described_class.new\
         .top_diagonals_from_left_read_with_main_diagonal(
           []
         )).to be false
      end
    end
  end

  describe '#top_diagonals_from_right_read_with_main_diagonal' do
    context 'When send sequence with 2 matchs' do
      it 'return true' do
        expect(
          described_class.new
          .top_diagonals_from_right_read_with_main_diagonal(
            %w[
              ATTTGA
              GCGAGC
              GGATTG
              AATCGT
              ATAGCA
              TCGAGG
            ].freeze
          )
        ).to be true
      end
    end
    context 'When send sequence with 1 match' do
      it 'return false' do
        expect(
          described_class.new\
          .top_diagonals_from_right_read_with_main_diagonal(
            %w[
              ATTTGA
              ATGTGC
              GGTTGG
              AAGTGG
              ACAGTA
              TCGAGG
            ].freeze
          )
        ).to be false
      end
    end
    context 'When send sequence with 0 match' do
      it 'return false' do
        expect(described_class.new\
        .top_diagonals_from_right_read_with_main_diagonal(
          %w[
            ATTTGA
            TTGTGC
            AGTTGG
            AGATAG
            CCCATA
            TCGCTG
          ].freeze
        )).to be false
      end
    end
    context 'When send sequence empty' do
      it 'return false' do
        expect(described_class.new\
         .top_diagonals_from_left_read_with_main_diagonal(
           []
         )).to be false
      end
    end
  end
end
