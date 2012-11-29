require 'spec_helper'
require_relative '../../lib/go_player/move'
require_relative '../../lib/go_player/position'
require_relative '../../lib/go_player/colors'
require_relative '../../lib/go_player/attachment_voter'
require_relative '../../lib/go_player/board_recorder'

describe GoPlayer::AttachmentVoter do
  describe "#vote" do
    it "votes Yea for moves with same colored neighbors" do
      recorder = GoPlayer::BoardRecorder.new([GoPlayer::Move.new(GoPlayer::Colors::White, GoPlayer::Position.new(15, 'A'))])
      attachment_voter = GoPlayer::AttachmentVoter.new(recorder, GoPlayer::Colors::White)
      attachment_voter.vote(GoPlayer::Position.new(16, 'A')).should be_yea
    end

    it "has no vote for moves without same colored neighbors" do
      recorder = GoPlayer::BoardRecorder.new([])
      attachment_voter = GoPlayer::AttachmentVoter.new(recorder, GoPlayer::Colors::White)
      attachment_voter.vote(GoPlayer::Position.new(16, 'A')).should be_nil
    end
  end
end
