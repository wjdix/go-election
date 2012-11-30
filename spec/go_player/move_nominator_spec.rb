require 'spec_helper'

describe GoPlayer::MoveNominator do
  describe "#generate" do
    it "generates a valid move" do
      subject.generate.should be_valid
    end
  end

  describe "#candidates" do
    it "generates n random moves" do
      candidates = subject.candidates(4)
      candidates.length.should == 4
      candidates.each do |candidate|
        candidate.should be_valid
      end
    end
  end
end
