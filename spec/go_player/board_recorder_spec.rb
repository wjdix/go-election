require_relative '../spec_helper'
require_relative '../../lib/go_player/board_recorder'
require_relative '../../lib/go_player/move'
require_relative '../../lib/go_player/colors'
require_relative '../../lib/go_player/position'


describe GoPlayer::BoardRecorder do
  let(:position){ GoPlayer::Position.new(19, 'A') }
  describe "#played?" do
    it "checks if move is in played list" do
      move = GoPlayer::Move.new(GoPlayer::Colors::Black, position)
      recorder = GoPlayer::BoardRecorder.new([move])
      recorder.played?(position).should be_true
    end
  end

  describe "#record" do
    it "records moves as played" do
      move = GoPlayer::Move.new(GoPlayer::Colors::White, position)
      subject.record move
      subject.played?(position).should be_true
    end
  end
end
