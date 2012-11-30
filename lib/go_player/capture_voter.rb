module GoPlayer
  class CaptureVoter
    include Celluloid
    def initialize(color, recorder)
      @recorder = recorder
      @color = color
    end

    def vote(position)
      move = GoPlayer::Move.new(@color, position)
      return nil if position.neighbors.all?{|neighbor| !@recorder.played?(neighbor) || @recorder.color_at(neighbor) == @color }
      enemies = position.neighbors.select{|neighbor| @recorder.played?(neighbor) && @recorder.color_at(neighbor) != @color }
      if enemies.any? {|neighbor| check_liberties_after_move(neighbor, move) == 0 }
        return GoPlayer::Votes::YEA
      end
    end

    private
    def check_liberties_after_move(position, move)
      recorder = BoardRecorder.new(@recorder.moves.clone << move)
      counter = GoPlayer::LibertyCounter.new(recorder)
      liberties = counter.count_liberties(position)
      counter.terminate
      recorder.terminate
      liberties
    end
  end
end
