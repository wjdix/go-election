require 'spec_helper'

describe GoPlayer::EdgeVoter do
  context "first 16 moves" do
    let(:recorder) { GoPlayer::BoardRecorder.new([]) }
    subject { GoPlayer::EdgeVoter.new(recorder, GoPlayer::Colors::Black) }
    it "vetoes edge moves" do
      subject.vote(GoPlayer::Position.new(19, 'j')).should be_veto
      subject.vote(GoPlayer::Position.new(1, 'j')).should be_veto
      subject.vote(GoPlayer::Position.new(14, 't')).should be_veto
      subject.vote(GoPlayer::Position.new(14, 'a')).should be_veto
    end
    it "votes for move 3-6 from edge" do
      subject.vote(GoPlayer::Position.new(17, 'j')).should be_yea
      subject.vote(GoPlayer::Position.new(3, 'j')).should be_yea
      subject.vote(GoPlayer::Position.new(14, 'd')).should be_yea
    end
    it "ignores moves in center of board" do
      subject.vote(GoPlayer::Position.new(13, 'j')).should be_nil
    end
  end

  context "after 16 moves" do
    let(:recorder){ GoPlayer::BoardRecorder.new(GoPlayer::MoveNominator.new.candidates(16)) }
    subject { GoPlayer::EdgeVoter.new(recorder, GoPlayer::Colors::Black) }

    it "ignores all moves" do
      GoPlayer::Position.all.each do |pos|
        subject.vote(pos).should be_nil
      end
    end
  end

end
