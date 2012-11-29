module GoPlayer
  class AttachmentVoter
    def initialize(recorder, color)
      @color = color
      @recorder = recorder
    end

    def vote(position)
      if position.neighbors.any? { |neighbor| @recorder.color_at(neighbor) == @color }
        return GoPlayer::Votes::YEA
      end
    end
  end
end
