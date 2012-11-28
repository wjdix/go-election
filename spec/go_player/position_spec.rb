require 'spec_helper'
require_relative '../../lib/go_player/position'

describe GoPlayer::Position do
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
