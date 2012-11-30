require 'rubygems'
require 'bundler/setup'
require 'celluloid'

require 'go_player/gtp/command'
require 'go_player/attachment_voter'
require 'go_player/board_recorder'
require 'go_player/colors'
require 'go_player/election'
require 'go_player/input_listener'
require 'go_player/liberty_counter'
require 'go_player/life_voter'
require 'go_player/move'
require 'go_player/move_nominator'
require 'go_player/open_space_voter'
require 'go_player/position'
require 'go_player/votes'
require 'go_player/game'

module GoPlayer
  def self.start(in_pipe=$stdin, out_pipe=$stdout)
    game = Game.new(out_pipe)
    input_listener = InputListener.new(in_pipe, game)
    input_listener.start
    game
  end
end
