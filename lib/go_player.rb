require 'rubygems'
require 'bundler/setup'
require 'celluloid'


module GoPlayer
  require_relative './go_player/board_recorder'
  require_relative './go_player/election'
  require_relative './go_player/move_nominator'
  require_relative './go_player/votes'

  class Game
    def initialize
      @recorder = BoardRecorder.new
      open_space_voter = OpenSpaceVoter.new(@recorder)
      voters = [open_space_voter]
      @nominator = MoveNominator.new
      @election = Election.new voters
    end

    def receive_move move
      @recorder.async.record move
      candidates = @nominator.candidates 5
      @election.elect candidates
    end
  end
end
