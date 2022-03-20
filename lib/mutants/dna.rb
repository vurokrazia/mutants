module Mutants
    class Dna
        attr_reader :sequence, :counter, :lastCharacter

        def initialize
            @counter = 0
        end

        def horizontal sequence
            @sequence = sequence
            row = 0
            loop do
                break unless row < sequence.length
                
                @lastCharacter = sequence[row][0]
                return true if readHorizontalOrVertical(Mutants::Orientation::HORIZONTAL, lastCharacter, row)                                    
                row += 1
            end
    
            false
        end

        def vertical(sequence) 
            @sequence = sequence
            col = 0
            loop do
                break unless col < sequence.length
                
                @lastCharacter = sequence[0][col]
                return true if readHorizontalOrVertical(Mutants::Orientation::VERTICAL, lastCharacter, col)                                    
                col += 1
            end
    
            false
        end

        def bottomDiagonalsFromLeftReadWithoutMainDiagonal sequence
            @sequence = sequence
            row = 1
            loop do
                break unless row < sequence.length
                
                @lastCharacter = sequence[row][0]
                return true if readDiagonals(Mutants::Orientation::FROM_LEFT,Mutants::Orientation::BELOW_MAIN_DIAGONAL, row, 0)                                  
                row += 1
            end
    
            false
        end

        def bottomDiagonalsFromRightReadWithoutMainDiagonal sequence
            @sequence = sequence
            row = 1
            loop do
                break unless row < sequence.length
                
                @lastCharacter = sequence[row][sequence.length - 1]
                return true if readDiagonals(Mutants::Orientation::FROM_RIGHT,Mutants::Orientation::BELOW_MAIN_DIAGONAL, row, sequence.length - 1)                                  
                row += 1
            end
    
            false
        end

        def topDiagonalsFromLeftReadWithMainDiagonal sequence
            @sequence = sequence
            col = 0
            loop do
                break unless col < sequence.length
                
                @lastCharacter = sequence[0][col]
                return true if readDiagonals(Mutants::Orientation::FROM_LEFT, Mutants::Orientation::ABOVE_MAIN_DIAGONAL_INCLUDING, 0, col)                                  
                col += 1
            end
    
            false
        end

        def topDiagonalsFromRightReadWithMainDiagonal sequence
            @sequence = sequence
            col = 1
            loop do
                break unless col < sequence.length
                
                @lastCharacter = sequence[0][sequence.length - col]
                return true if readDiagonals(Mutants::Orientation::FROM_RIGHT, Mutants::Orientation::ABOVE_MAIN_DIAGONAL_INCLUDING, 0, sequence.length - col)                                  
                col += 1
            end
    
            false
        end
    

        def readHorizontalOrVertical(direction, initialCharacter, index)
            charactersCount = 1
            lastCharacter = initialCharacter
            currentCharacter = nil
            subindex = 1
            while sequence.length - subindex + charactersCount >= 4 && subindex < sequence.length
                currentCharacter = (Mutants::Orientation::HORIZONTAL == direction ? sequence[index][subindex] : sequence[subindex][index])
                if lastCharacter == currentCharacter
                    charactersCount += 1
                    if charactersCount == Mutants::Configuration::COUNTER_SEQUENCES
                        @counter+=1
                        charactersCount = 0
                        if counter == Mutants::Configuration::MIN_SEQUENCES_TO_BE_MUTANT
                            # If a find the minimum sequences to determine if it is Mutant, I finish the search.
                            return true
                        end
                    end    
                else
                    lastCharacter = currentCharacter
                    charactersCount = 1    
                end
                subindex+=1
            end
            false
        end

        def readDiagonals(readDirection, readType, baseN, baseM) 
            offset = 1
    
            charactersCount = 1
    
            lastCharacter = sequence[baseN][baseM]
            currentCharacter = nil
    
            # This condition is valid when you can still read below the main diagonal
            bottomReadCondition = baseN + offset < sequence.length
    
            # This condition is valid when you can still read from the main diagonal to the top.
            topReadCondition = (readDirection.eql?(Mutants::Orientation::FROM_LEFT) && baseM + offset < sequence.length ||
                    readDirection.eql?(Mutants::Orientation::FROM_RIGHT) && baseM - offset >= 0)
    
            # From the verification of the previous conditions it decides if it is correct to continue reading the diagonal.
            while (readType.eql?(Mutants::Orientation::ABOVE_MAIN_DIAGONAL_INCLUDING) && topReadCondition) ||
                    (readType.eql?(Mutants::Orientation::BELOW_MAIN_DIAGONAL) && bottomReadCondition)
    
                currentCharacter = (readDirection.eql?(Mutants::Orientation::FROM_LEFT)) ? sequence[baseN + offset][baseM + offset] :
                        sequence[baseN + offset][baseM - offset]
                if lastCharacter == currentCharacter
                    charactersCount+=1
                    if charactersCount == Mutants::Configuration::COUNTER_SEQUENCES 
                        @counter+=1
                        charactersCount = 0
                        # If a find the minimum sequences to determine if it is Mutant, I finish the search.
                        return true if counter >= Mutants::Configuration::MIN_SEQUENCES_TO_BE_MUTANT
                    end
                else 
                    lastCharacter = currentCharacter
                    charactersCount = 1
                end
    
                offset+=1
    
                # I will verify the read conditions.
                bottomReadCondition = baseN + offset < sequence.length
    
                topReadCondition = (readDirection.eql?(Mutants::Orientation::FROM_LEFT) && baseM + offset < sequence.length ||
                        readDirection.eql?(Mutants::Orientation::FROM_RIGHT) && baseM - offset >= 0)
            end
            # The subject is Human
            false
        end
    end
end
DNA = [
    "TTTTGA",
    "ATGTGC",
    "AGTTGG",
    "AGATGG",
    "CCCCTA",
    "TCGCTG"]
DNA2 = [
    "TTATGA",
    "ATGTGC",
    "AGTTGG",
    "AGATGG",
    "CAACTA",
    "TCAAAC"]

DNA3 = [
    %i[T A A A],
    %i[A T A T],
    %i[C A A T],
    %i[T C A T]
]

DNA4 = [
%i[A T G C G A],
%i[C A G T G C],
%i[T T A T T T],
%i[A G A C G G],
%i[G T G A C A],
%i[T C A C T G] ]


DNA5 = [
%i[A T G C G A],
%i[C A G G G G],
%i[T T G T T T],
%i[A G A G G G],
%i[G T G A G A],
%i[T C A C T G] ]