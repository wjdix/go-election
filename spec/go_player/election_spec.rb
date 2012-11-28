require_relative '../spec_helper'
require_relative '../../lib/go_player/election'
require_relative '../../lib/go_player/votes'
require_relative '../../lib/go_player/position'

describe GoPlayer::Election do

  describe "elect" do
    let(:candidates){
      [
        GoPlayer::Position.new(19, 'A'),
        GoPlayer::Position.new(18, 'A')
      ]
    }
    it "rejects candidates with vetoes" do
      voters = [VetoVoter.new(GoPlayer::Position.new(19, 'A'))]
      election = GoPlayer::Election.new(voters)
      election.elect(candidates).should == GoPlayer::Position.new(18, 'A')
    end

    it "chooses the candidate with the most votes" do
      voters = [
        YayVoter.new(GoPlayer::Position.new(19, 'A')),
        YayVoter.new(GoPlayer::Position.new(18, 'A')),
        YayVoter.new(GoPlayer::Position.new(18, 'A'))
      ]
      election = GoPlayer::Election.new(voters)
      election.elect(candidates).should == GoPlayer::Position.new(18, 'A')
    end
  end
end
