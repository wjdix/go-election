require 'spec_helper'

describe GoPlayer::OpenSpaceVoter do
  let(:played){
    [ GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(19, 'A')) ]
  }

  it "vetoes if board recorder reports that space has a stone" do
    recorder = GoPlayer::BoardRecorder.new(played)
    voter = GoPlayer::OpenSpaceVoter.new(recorder)
    voter.vote(GoPlayer::Position.new(19, 'A')).should be_veto
  end

  it "does not vote if space does not have a stone" do
    recorder = GoPlayer::BoardRecorder.new(played)
    voter = GoPlayer::OpenSpaceVoter.new(recorder)
    voter.vote(GoPlayer::Position.new(17, 'A')).should be_nil
  end
end
