module GoPlayer
  class JosekiVoter

    def self.new_voter(joseki_sequence)
      new_class = self.clone
      new_class.sequence = joseki_sequence
      new_class
    end

    def self.sequence=(joseki_sequence)
      @@joseki_sequence = joseki_sequence
    end

    def sequence
      @@joseki_sequence || []
    end

    def initialize(recorder, color)
      @color = color
      @recorder = recorder
    end

    def vote(position)
      played, unplayed = sequence.partition{|move| @recorder.played?(move.position)}
      return GoPlayer::Votes::YEA if unplayed.first.position == position
    end

  end
end
