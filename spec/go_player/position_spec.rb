require 'spec_helper'
require_relative '../../lib/go_player/position'

describe GoPlayer::Position do
  describe "#column" do
    it "downcases the column string" do
      GoPlayer::Position.new(19, 'A').column.should == 'a'
    end
  end

  describe "#neighbors" do
    it "generates four neighboring positions" do
      position = GoPlayer::Position.new(14, 'G')
      position.neighbors.should =~ [
        GoPlayer::Position.new(13, 'G'),
        GoPlayer::Position.new(15, 'G'),
        GoPlayer::Position.new(14, 'F'),
        GoPlayer::Position.new(14, 'H')
      ]
    end

    context "on the edge" do
      it "excludes invalid neighbors" do
        position = GoPlayer::Position.new(19, 'G')
        position.neighbors.should =~ [
          GoPlayer::Position.new(18, 'G'),
          GoPlayer::Position.new(19, 'F'),
          GoPlayer::Position.new(19, 'H')
        ]
      end
    end
  end
end
