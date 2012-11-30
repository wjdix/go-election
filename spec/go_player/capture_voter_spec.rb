require 'spec_helper'
require_relative '../../lib/go_player/capture_voter'
require_relative '../../lib/go_player/move'
require_relative '../../lib/go_player/position'
require_relative '../../lib/go_player/colors'
require_relative '../../lib/go_player/board_recorder'
require_relative '../../lib/go_player/liberty_counter'

describe GoPlayer::CaptureVoter do
  describe "#vote" do
    it "votes yea if a move will reduce a neighboring opponent to 0 liberties" do
      moves = [
        GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(13, 'j')),
        GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(15, 'j')),
        GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(14, 'k')),
        GoPlayer::Move.new(GoPlayer::Colors::White, GoPlayer::Position.new(14, 'j'))
      ]
      recorder = GoPlayer::BoardRecorder.new(moves)
      voter = GoPlayer::CaptureVoter.new(GoPlayer::Colors::Black, recorder)

      voter.vote(GoPlayer::Position.new(14, 'h')).should be_yea
    end

    it "does not vote if only stone on empty board" do
      recorder = GoPlayer::BoardRecorder.new([])
      voter = GoPlayer::CaptureVoter.new(GoPlayer::Colors::Black, recorder)

      voter.vote(GoPlayer::Position.new(14, 'h')).should be_nil
    end

    it "does not vote if move will not eliminate final liberty" do
      move = GoPlayer::Move.new(GoPlayer::Colors::White, GoPlayer::Position.new(14, 'j'))
      recorder = GoPlayer::BoardRecorder.new([move])
      voter = GoPlayer::CaptureVoter.new(GoPlayer::Colors::Black, recorder)

      voter.vote(GoPlayer::Position.new(14, 'h')).should be_nil
    end
  end
end
