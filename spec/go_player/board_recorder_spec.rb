require 'spec_helper'

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

  describe "#color_at" do
    it "queries moves for color at position" do
      move = GoPlayer::Move.new(GoPlayer::Colors::White, position)
      subject.record move
      subject.color_at(position).should == GoPlayer::Colors::White
    end
  end
end
