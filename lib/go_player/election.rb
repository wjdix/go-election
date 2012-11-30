module GoPlayer
  class Election
    include Celluloid
    attr_accessor :voters

    def initialize(voters)
      @voters = voters
    end

    def elect(candidates)
      results = {}
      candidates.pmap do |candidate|
        ElectionResult.new(candidate).collect_votes(voters)
      end.reject(&:vetoed?).sort_by(&:yea_votes).reverse.first.position
    end

    class ElectionResult
      attr_reader :position
      def initialize(position)
        @position = position
        @votes = []
      end

      def collect_votes(voters)
        @votes = voters.pmap {|voter| voter.vote(@position)}
        self
      end

      def vetoed?
        @votes.any?{|vote| vote == GoPlayer::Votes::VETO}
      end

      def yea_votes
        @votes.select{|vote| vote == GoPlayer::Votes::YEA}.count
      end
    end
  end
end
