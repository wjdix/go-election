require_relative '../spec_helper'
require_relative '../../lib/go_player/election'
require_relative '../../lib/go_player/votes'

describe GoPlayer::Election do

  describe "elect" do
    it "rejects candidates with vetoes" do
      voters = [VetoVoter.new('19A')]
      election = GoPlayer::Election.new(voters)
      election.elect(['19A', '18A']).should == '18A'
    end

    it "chooses the candidate with the most votes" do
      voters = [YayVoter.new('19A'), YayVoter.new('18A'), YayVoter.new('18A')]
      election = GoPlayer::Election.new(voters)
      election.elect(['19A', '18A']).should == '18A'
    end
  end
end
