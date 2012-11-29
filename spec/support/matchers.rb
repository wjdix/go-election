require_relative '../../lib/go_player/votes'

Rspec::Matchers.define :be_veto do
  match do |actual|
    actual.should == GoPlayer::Votes::VETO
  end
end

Rspec::Matchers.define :be_yea do
  match do |actual|
    actual.should == GoPlayer::Votes::YEA
  end
end
