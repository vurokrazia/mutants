# frozen_string_literal: true

module Mutants
  class Validations
    attr_reader :sequence, :validate_sizes, :validate_dna

    class NotAnArraySequence < StandardError; end
    class InvalidSizeDnaSequence < StandardError; end
    class InvalidDNA < StandardError; end

    def initialize
      @sequence = []
    end

    def set_sequence(sequence)
      @sequence = valid_sequence?(sequence)
      self
    end

    def set_validate_sizes(validate_sizes)
      @validate_sizes = validate_sizes
      self
    end

    def set_validate_dna(validate_dna)
      @validate_dna = validate_dna
      self
    end

    def validate
      sequence.each do |dna|
        valid_sizes? dna
        valid_dna? dna
      end

      true
    end

    private

    def valid_sizes?(dna)
      return unless validate_sizes
      return if dna.length == sequence.length

      raise Mutants::Validations::InvalidSizeDnaSequence
    end

    def valid_dna?(dna)
      return unless validate_dna
      return if dna.scan(/[#{Mutants::Configuration::SEQUENCE}]/).size == dna.size

      raise Mutants::Validations::InvalidDNA
    end

    def valid_sequence?(sequence)
      return sequence if sequence.is_a?(Array) &&
                         sequence.size >= Mutants::Configuration::COUNTER_SEQUENCES

      raise Mutants::Validations::NotAnArraySequence
    end
  end
end
