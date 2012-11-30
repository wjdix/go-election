module GoPlayer
  class MoveNominator
    include Celluloid
    LETTERS = ('A'..'Z').to_a - ['I']
    def generate
      row = 1 + rand(19)
      column = GoPlayer::Position::COLUMNS[rand(19)]
      GoPlayer::Position.new(row, column)
    end

    def candidates n
      (1..n).map{ generate }
    end
  end
end
