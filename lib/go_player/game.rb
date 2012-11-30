module GoPlayer
  class Game
    include Celluloid
    attr_reader :recorder

    def initialize(out_pipe, color)
      @out_pipe = out_pipe
      @color = color
      @recorder = BoardRecorder.new
      open_space_voter = OpenSpaceVoter.new(@recorder)
      life_voter = LifeVoter.new(@recorder, @color)
      attachment_voter = AttachmentVoter.new(@recorder, @color)
      voters = [open_space_voter, life_voter, attachment_voter]
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
end
