# frozen_string_literal: true

module Mutants
  class Dna
    attr_reader :sequence, :counter, :last_character

    def initialize
      @counter = 0
    end

    def horizontal(sequence)
      @sequence = sequence
      row = 0
      loop do
        break unless row < sequence.length

        @last_character = sequence[row][0]
        return true if read_horizontal_or_vertical(Mutants::Orientation::HORIZONTAL,
                                                   last_character,
                                                   row)

        row += 1
      end

      false
    end

    def vertical(sequence)
      @sequence = sequence
      col = 0
      loop do
        break unless col < sequence.length

        @last_character = sequence[0][col]
        return true if read_horizontal_or_vertical(Mutants::Orientation::VERTICAL,
                                                   last_character,
                                                   col)

        col += 1
      end

      false
    end

    def bottom_diagonals_from_left_read_without_main_diagonal(sequence)
      @sequence = sequence
      row = 1
      loop do
        break unless row < sequence.length

        @last_character = sequence[row][0]
        return true if read_diagonals(Mutants::Orientation::FROM_LEFT,
                                      Mutants::Orientation::BELOW_MAIN_DIAGONAL,
                                      row, 0)

        row += 1
      end

      false
    end

    def bottom_diagonals_from_right_read_without_main_diagonal(sequence)
      @sequence = sequence
      row = 1
      loop do
        break unless row < sequence.length

        @last_character = sequence[row][sequence.length - 1]
        return true if read_diagonals(Mutants::Orientation::FROM_RIGHT,
                                      Mutants::Orientation::BELOW_MAIN_DIAGONAL,
                                      row,
                                      sequence.length - 1)

        row += 1
      end

      false
    end

    def top_diagonals_from_left_read_with_main_diagonal(sequence)
      @sequence = sequence
      col = 0
      loop do
        break unless col < sequence.length

        @last_character = sequence[0][col]
        return true if read_diagonals(Mutants::Orientation::FROM_LEFT,
                                      Mutants::Orientation::ABOVE_MAIN_DIAGONAL_INCLUDING,
                                      0,
                                      col)

        col += 1
      end

      false
    end

    def top_diagonals_from_right_read_with_main_diagonal(sequence)
      @sequence = sequence
      col = 1
      loop do
        break unless col < sequence.length

        @last_character = sequence[0][sequence.length - col]
        return true if read_diagonals(Mutants::Orientation::FROM_RIGHT,
                                      Mutants::Orientation::ABOVE_MAIN_DIAGONAL_INCLUDING,
                                      0,
                                      sequence.length - col)

        col += 1
      end

      false
    end

    def read_horizontal_or_vertical(direction, initial_character, index)
      characters_count = 1
      last_character = initial_character
      current_character = nil
      subindex = 1
      while sequence.length - subindex + characters_count >= 4 && subindex < sequence.length
        current_character = if Mutants::Orientation::HORIZONTAL == direction
                              sequence[index][subindex]
                            else
                              sequence[subindex][index]
                            end
        if last_character == current_character
          characters_count += 1
          if characters_count == Mutants::Configuration::COUNTER_SEQUENCES
            @counter += 1
            characters_count = 0
            if counter == Mutants::Configuration::MIN_SEQUENCES_TO_BE_MUTANT
              # If a find the minimum sequences to determine if it is Mutant, I finish the search.
              return true
            end
          end
        else
          last_character = current_character
          characters_count = 1
        end
        subindex += 1
      end
      false
    end

    def read_diagonals(read_direction, read_type, base_n, base_m)
      offset = 1

      characters_count = 1

      last_character = sequence[base_n][base_m]
      current_character = nil

      # This condition is valid when you can still read below the main diagonal
      bottom_read_condition = base_n + offset < sequence.length

      # This condition is valid when you can still read from the main diagonal to the top.
      top_read_condition = (read_direction.eql?(Mutants::Orientation::FROM_LEFT) && base_m + offset < sequence.length ||
              read_direction.eql?(Mutants::Orientation::FROM_RIGHT) && base_m - offset >= 0)

      # From the verification of the previous conditions it decides if it is correct to continue reading the diagonal.
      while (read_type.eql?(Mutants::Orientation::ABOVE_MAIN_DIAGONAL_INCLUDING) && top_read_condition) ||
            (read_type.eql?(Mutants::Orientation::BELOW_MAIN_DIAGONAL) && bottom_read_condition)

        current_character = if read_direction.eql?(Mutants::Orientation::FROM_LEFT)
                              sequence[base_n + offset][base_m + offset]
                            else
                              sequence[base_n + offset][base_m - offset]
                            end
        if last_character == current_character
          characters_count += 1
          if characters_count == Mutants::Configuration::COUNTER_SEQUENCES
            @counter += 1
            characters_count = 0
            # If a find the minimum sequences to determine if it is Mutant, I finish the search.
            return true if counter >= Mutants::Configuration::MIN_SEQUENCES_TO_BE_MUTANT
          end
        else
          last_character = current_character
          characters_count = 1
        end

        offset += 1

        # I will verify the read conditions.
        bottom_read_condition = base_n + offset < sequence.length

        top_read_condition = (read_direction.eql?(Mutants::Orientation::FROM_LEFT) && base_m + offset < sequence.length ||
                read_direction.eql?(Mutants::Orientation::FROM_RIGHT) && base_m - offset >= 0)
      end
      # The subject is Human
      false
    end
  end
end
DNA = %w[
  TTTTGA
  ATGTGC
  AGTTGG
  AGATGG
  CCCCTA
  TCGCTG
].freeze
DNA2 = %w[
  TTATGA
  ATGTGC
  AGTTGG
  AGATGG
  CAACTA
  TCAAAC
].freeze

DNA3 = %w[
  TTTT
  TTTT
  TTTT
  TTTT
].freeze

DNA4 = %w[
  TTTTGA
  ATGTGC
  ATGTCG
  AGTGGG
  CTCTGA
  TCGCTG
].freeze
