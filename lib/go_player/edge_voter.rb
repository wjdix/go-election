module GoPlayer
  class EdgeVoter
    include Celluloid
    OPENING_LENGTH = 16
    def initialize(recorder, color)
      @recorder = recorder
      @color = color
    end

    def vote(position)
      return nil if @recorder.moves.count >= OPENING_LENGTH
      if too_close_to_edge?(position)
        GoPlayer::Votes::VETO
      elsif good_distance_from_edge?(position)
        GoPlayer::Votes::YEA
      end
    end

    private

    def too_close_to_edge?(position)
      column = position.column_index + 1
      position.row > 17 || position.row < 3 || column > 17 || column < 3
    end

    def good_distance_from_edge?(position)
      column = position.column_index + 1
      (position.row >= 3 && position.row <=6) || (position.row <=17 && position.row >= 14) ||
        (column >=3 && column <=6) || (column <=17 && column >= 14)
    end

  end
end
