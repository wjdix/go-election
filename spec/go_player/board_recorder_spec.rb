require_relative '../spec_helper'
require_relative '../../lib/go_player/board_recorder'
require_relative '../../lib/go_player/move'
require_relative '../../lib/go_player/colors'


describe GoPlayer::BoardRecorder do

  describe "#played?" do
    it "checks if move is in played list" do
      move = GoPlayer::Move.new(GoPlayer::Colors::Black, "A19")
      recorder = GoPlayer::BoardRecorder.new([move])
      recorder.played?("A19").should be_true
    end
  end

  describe "#record" do
    it "records moves as played" do
      move = GoPlayer::Move.new(GoPlayer::Colors::White, "A19")
      subject.record move
      subject.played?("A19").should be_true
    end
  end
end
