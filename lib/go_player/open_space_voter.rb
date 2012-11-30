module GoPlayer
  class OpenSpaceVoter
    include Celluloid
    def initialize(recorder, color)
      @recorder = recorder
    end

    def vote(move)
      GoPlayer::Votes::VETO if @recorder.played? move
    end
  end
end
