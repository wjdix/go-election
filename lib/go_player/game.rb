module GoPlayer
  class Game
    attr_reader :color
    VOTERS = [OpenSpaceVoter, LifeVoter, AttachmentVoter, EdgeVoter]

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
      candidates = GoPlayer::Position.all
      election.elect(candidates).tap do |selected|
        recorder.record GoPlayer::Move.new(@color, selected)
      end
    end

    def recorder
      @recorder ||= BoardRecorder.new([])
    end

    private
    def election
      @election ||= Election.new voters
    end

    def nominator
      @nominator ||= MoveNominator.new
    end


    def voters
      @voters ||= VOTERS.map {|voter| voter.pool(size: 36, args:[recorder, @color]) }
    end

    def valid_commands
      %w[boardsize genmove list_commands play]
    end
  end
end
