module GoPlayer
  class LifeVoter
    include Celluloid
    def initialize(recorder, color)
      @color = color
      @recorder = recorder
    end

    def vote(position)
      will_live?(position) ? GoPlayer::Votes::YEA : GoPlayer::Votes::VETO
    end

    def will_live?(position)
      cloned_recorder_after_move(position) do |cloned|
        GoPlayer::LibertyCounter.new(cloned).count_liberties(position) != 0
      end
    end

    private

    def cloned_recorder_after_move(position)
      move = Move.new(@color, position)
      recorder = BoardRecorder.new(@recorder.moves.clone << move)
      result = yield recorder
      recorder.terminate
      result
    end
  end
end
