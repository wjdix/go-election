require_relative '../spec_helper'
require_relative '../../lib/go_player/board_recorder'

describe GoPlayer::BoardRecorder do

  describe "#played?" do
    it "checks if move is in played list" do
      recorder = GoPlayer::BoardRecorder.new(["A19"])
      recorder.played?("A19").should be_true
    end
  end

  describe "#record" do
    it "records moves as played" do
      subject.record "A19"
      subject.played?("A19").should be_true
    end
  end
end
