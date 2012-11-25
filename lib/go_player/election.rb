require 'celluloid'
module GoPlayer
  class Election
    include Celluloid
    attr_accessor :voters

    def initialize(voters)
      @voters = voters
    end

    def elect(candidates)
      results = {}
      candidates.map do |candidate|
        ElectionResult.new(candidate).collect_votes(voters)
      end.reject(&:vetoed?).sort_by(&:yay_votes).reverse.first.move
    end

    class ElectionResult
      attr_reader :move
      def initialize(move)
        @move = move
        @votes = []
      end

      def collect_votes(voters)
        voters.each {|voter| record_vote(voter.vote(@move))}
        self
      end

      def record_vote(vote)
        @votes << vote
      end

      def vetoed?
        @votes.any?{|vote| vote == GoPlayer::Votes::VETO}
      end

      def yay_votes
        @votes.select{|vote| vote == GoPlayer::Votes::YAY}.count
      end
    end
  end
end
