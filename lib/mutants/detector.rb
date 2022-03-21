# frozen_string_literal: true

module Mutants
  class Detector
    attr_reader :builder

    def initialize(builder)
      @builder = builder
    end

    def isMutant(sequence)
      validate
      return true if dna.horizontal(sequence) ||
                     dna.vertical(sequence) ||
                     dna.bottom_diagonals_from_left_read_without_main_diagonal(sequence) ||
                     dna.bottom_diagonals_from_right_read_without_main_diagonal(sequence) ||
                     dna.top_diagonals_from_left_read_with_main_diagonal(sequence) ||
                     dna.top_diagonals_from_right_read_with_main_diagonal(sequence)
    end

    private

    def dna
      @dna ||= Mutants::Dna.new
    end

    def validate
      builder
        .validate
    end
  end
end
