require_relative '../spec_helper'
require_relative '../../lib/go_player/open_space_voter'
require_relative '../../lib/go_player/board_recorder'

describe GoPlayer::OpenSpaceVoter do
  it "vetoes if board recorder reports that space has a stone" do
    recorder = GoPlayer::BoardRecorder.new(["19A"])
    voter = GoPlayer::OpenSpaceVoter.new(recorder)
    voter.vote("19A").should be_veto
  end

  it "does not vote if space does not have a stone" do
    recorder = GoPlayer::BoardRecorder.new(["19A"])
    voter = GoPlayer::OpenSpaceVoter.new(recorder)
    voter.vote("17A").should be_nil
  end
end
