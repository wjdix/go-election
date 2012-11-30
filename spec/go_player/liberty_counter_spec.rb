require 'spec_helper'
require_relative '../../lib/go_player/board_recorder'
require_relative '../../lib/go_player/position'
require_relative '../../lib/go_player/liberty_counter'
require_relative '../../lib/go_player/move'
require_relative '../../lib/go_player/colors'

describe GoPlayer::LibertyCounter do
  describe "#count liberties" do
    it "returns nil if no stone at space" do
      recorder = GoPlayer::BoardRecorder.new([])
      counter = GoPlayer::LibertyCounter.new(recorder)
      counter.count_liberties(GoPlayer::Position.new(16, 'd')).should be_nil
    end

    it "is 4 for only stone in center of board" do
      position = GoPlayer::Position.new(16, 'j')
      move = GoPlayer::Move.new(GoPlayer::Colors::Black, position)
      recorder = GoPlayer::BoardRecorder.new([move])
      counter = GoPlayer::LibertyCounter.new(recorder)
      counter.count_liberties(GoPlayer::Position.new(16, 'j')).should == 4
    end

    it "is 6 for two stones next to each other" do
      position1 = GoPlayer::Position.new(16, 'j')
      position2 = GoPlayer::Position.new(17, 'j')
      move1 = GoPlayer::Move.new(GoPlayer::Colors::Black, position1)
      move2 = GoPlayer::Move.new(GoPlayer::Colors::Black, position2)
      recorder = GoPlayer::BoardRecorder.new([move1, move2])
      counter = GoPlayer::LibertyCounter.new(recorder)
      counter.count_liberties(GoPlayer::Position.new(16, 'j')).should == 6
    end
  end
end
