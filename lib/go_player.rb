require 'rubygems'
require 'bundler/setup'
require 'celluloid'


module GoPlayer
  require_relative './go_player/board_recorder'
  require_relative './go_player/election'
  require_relative './go_player/move_nominator'
  require_relative './go_player/votes'
  require_relative './go_player/input_listener'
  require_relative './go_player/open_space_voter'
  require_relative './go_player/life_voter'
  require_relative './go_player/colors'
  require_relative './go_player/attachment_voter'
  require_relative './go_player/gtp/command'

  class Game
    include Celluloid
    attr_reader :recorder

    def initialize(out_pipe, color)
      @out_pipe = out_pipe
      @color = color
      @recorder = BoardRecorder.new
      open_space_voter = OpenSpaceVoter.new(@recorder)
      life_voter = LifeVoter.new(@recorder, @color)
      capture_voter = CaptureVoter.new(@recorder, @color)
      attachment_voter = AttachmentVoter.new(@recorder, @color)
      voters = [open_space_voter, life_voter, attachment_voter, capture_voter]
      @nominator = MoveNominator.new
      @election = Election.new voters
    end

    def receive_command(command)
      if command.body == "list_commands"
        @out_pipe.puts("=#{command.number} #{valid_commands.join("\n")}\n\n")
      elsif command.body =~ /\Agenmove/
        @out_pipe.puts("=#{command.number} #{gen_move}\n\n")
      elsif command.body =~ /\Aplay/
        receive_move command.move
        @out_pipe.puts("=#{command.number}\n\n")
      else
        @out_pipe.puts("=#{command.number}\n\n")
      end
      @out_pipe.flush
    end

    def receive_move move
      @recorder.record move
    end

    def gen_move
      candidates = @nominator.candidates 5
      @election.elect(candidates).tap do |selected|
        @recorder.record GoPlayer::Move.new(@color, selected)
      end
    end

    private
    def valid_commands
      %w[boardsize genmove list_commands play]
    end
  end

  class << self
    def start(in_pipe=$stdin, out_pipe=$stdout)
      # spin up output actor
      game = Game.new(out_pipe, GoPlayer::Colors::Black)
      input_listener = InputListener.new(in_pipe, game)
      input_listener.start
      game
    end
  end
end
