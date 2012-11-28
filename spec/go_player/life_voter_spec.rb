require 'spec_helper'
require_relative '../../lib/go_player/life_voter'
require_relative '../../lib/go_player/colors'
require_relative '../../lib/go_player/move'
require_relative '../../lib/go_player/board_recorder'

describe GoPlayer::LifeVoter do
  describe "#will_live?" do
    it "is false if all surrounding stones are different color" do
      moves = [
        GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(15, 'C')),
        GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(17, 'C')),
        GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(16, 'B')),
        GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(16, 'D'))
      ]
      recorder = GoPlayer::BoardRecorder.new(moves)
      voter = GoPlayer::LifeVoter.new(recorder, GoPlayer::Colors::White)
      voter.will_live?(GoPlayer::Position.new(16, 'C')).should be_false
    end
    it "is false if will fill in last liberty" do
      moves = [
        GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(15, 'C')),
        GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(18, 'C')),
        GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(16, 'B')),
        GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(17, 'B')),
        GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(16, 'D')),
        GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(17, 'D')),
        GoPlayer::Move.new(GoPlayer::Colors::White, GoPlayer::Position.new(16, 'C'))
      ]
      recorder = GoPlayer::BoardRecorder.new(moves)
      voter = GoPlayer::LifeVoter.new(recorder, GoPlayer::Colors::White)
      voter.will_live?(GoPlayer::Position.new(17, 'C')).should be_false
    end

    it "is true if only stone on board" do
      recorder = GoPlayer::BoardRecorder.new([])
      voter = GoPlayer::LifeVoter.new(recorder, GoPlayer::Colors::White)
      voter.will_live?(GoPlayer::Position.new(17, 'C')).should be_true
    end

    it "is true if only same color stones are on board" do
      moves = [
        GoPlayer::Move.new(GoPlayer::Colors::White, GoPlayer::Position.new(15, 'C')),
        GoPlayer::Move.new(GoPlayer::Colors::White, GoPlayer::Position.new(17, 'C')),
        GoPlayer::Move.new(GoPlayer::Colors::White, GoPlayer::Position.new(16, 'B')),
        GoPlayer::Move.new(GoPlayer::Colors::White, GoPlayer::Position.new(16, 'D'))
      ]
      recorder = GoPlayer::BoardRecorder.new(moves)
      voter = GoPlayer::LifeVoter.new(recorder, GoPlayer::Colors::White)
      voter.will_live?(GoPlayer::Position.new(16, 'C')).should be_true
    end
  end
end
