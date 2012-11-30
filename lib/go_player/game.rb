module GoPlayer
  class Game
    include Celluloid
    attr_reader :color
    VOTERS = [OpenSpaceVoter, LifeVoter, AttachmentVoter]

    def initialize(out_pipe)
      @out_pipe = out_pipe
      @election = Election.new voters
    end

    def receive_command(command)
      if command.body == "list_commands"
        @out_pipe.puts("=#{command.number} #{valid_commands.join("\n")}\n\n")
      elsif command.body =~ /\Agenmove/
        set_color(command)
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

    def set_color command
      @color ||= command.color
    end

    def gen_move
      candidates = nominator.candidates 5
      election.elect(candidates).tap do |selected|
        recorder.record GoPlayer::Move.new(@color, selected)
      end
    end

    private
    def election
      @election ||= Election.new voters
    end

    def nominator
      @nominator ||= MoveNominator.new
    end

    def recorder
      @recorder ||= BoardRecorder.new([])
    end

    def voters
      @voters ||= VOTERS.map {|voter| voter.new(recorder, @color) }
    end

    def valid_commands
      %w[boardsize genmove list_commands play]
    end
  end
end
