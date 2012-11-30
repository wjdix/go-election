require 'spec_helper'

describe GoPlayer::GTP::Command do
  subject{ GoPlayer::GTP::Command.new("1 drew stinks") }
  describe "#number" do
    it "pulls number from line" do
      subject.number.should == "1"
    end
  end

  describe "#body" do
    it "returns the body of the command" do
      subject.body.should == "drew stinks"
    end
  end

  describe "#move" do
    subject{ GoPlayer::GTP::Command.new("1 play black A19") }
    it "returns a move based on gtp command" do
      subject.move.should == GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(19, 'A'))
    end
  end
end
