require 'spec_helper'
require_relative '../lib/go_player'
require_relative '../lib/go_player/colors'
require_relative '../lib/go_player/gtp/command'

describe GoPlayer do
  describe "integration" do
    it "handles initial commands" do
      in_pipe = StringIO.new("1 list_commands\n2 boardsize 19\n3 play black a1")
      out_pipe = StringIO.new
      GoPlayer.start(in_pipe, out_pipe)
      out_pipe.string.should == <<-EOS
=1 boardsize
genmove
list_commands
play

=2

=3

      EOS
    end

    it "generates a move" do
      in_pipe = StringIO.new("9 genmove black\n")
      out_pipe = StringIO.new
      GoPlayer.start(in_pipe, out_pipe)
      out_pipe.string.should =~ /\A=9/
      out_pipe.string.should =~ /[a-hj-tA-HJ-T]\d+\n\n\z/m
    end

    it "records generated moves" do
      in_pipe = StringIO.new("9 genmove black\n")
      out_pipe = StringIO.new
      game = GoPlayer.start(in_pipe, out_pipe)
      game.recorder.moves.count.should == 1
    end

    it "records played moves" do
      in_pipe = StringIO.new("9 play b A19\n")
      out_pipe = StringIO.new
      game = GoPlayer.start(in_pipe, out_pipe)
      game.recorder.moves.count.should == 1
      game.recorder.moves.first.should == GoPlayer::Move.new(GoPlayer::Colors::Black, GoPlayer::Position.new(19, 'A'))
    end
  end

end
