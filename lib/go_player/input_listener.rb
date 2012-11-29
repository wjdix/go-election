module GoPlayer
  class InputListener
    include Celluloid

    def initialize(io, game)
      @io = io
      @game = game
    end

    def start
      while line = @io.gets
        command = GTP::Command.new(line)
        @game.receive_command(command)
      end
    end
  end
end
