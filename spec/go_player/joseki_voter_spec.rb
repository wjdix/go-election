require 'spec_helper'

describe GoPlayer::JosekiVoter do
  describe ".new_voter" do
    it "builds a new voter class based on sequence of moves" do
      voter_class = GoPlayer::JosekiVoter.new_voter([GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(4, 'd'))])
      voter = voter_class.new(GoPlayer::BoardRecorder.new([]), GoPlayer::Colors::Black)
      voter.sequence.should == [GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(4, 'd'))]
    end
  end

  describe "#vote" do
    it "votes yea if position would extend joseki" do
      voter_class = GoPlayer::JosekiVoter.new_voter([GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(4, 'd'))])
      voter = voter_class.new(GoPlayer::BoardRecorder.new([]), GoPlayer::Colors::Black)
      voter.vote(GoPlayer::Position.new(4, 'd')).should be_yea
    end

    it "does not vote if position would not extend joseki" do
      voter_class = GoPlayer::JosekiVoter.new_voter([GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(4, 'd'))])
      voter = voter_class.new(GoPlayer::BoardRecorder.new([]), GoPlayer::Colors::Black)
      voter.vote(GoPlayer::Position.new(7, 'e')).should be_nil
    end
  end
end
