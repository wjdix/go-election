require 'celluloid'
module GoPlayer
  class MoveNominator
    include Celluloid
    LETTERS = ('A'..'Z').to_a - ['I']
    def generate
      number = 1 + rand(19)
      letter = LETTERS[rand(19)]
      "#{letter}#{number}"
    end

    def candidates n
      (1..n).map{ generate }
    end
  end
end
