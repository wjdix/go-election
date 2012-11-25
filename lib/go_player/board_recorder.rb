require 'celluloid'
module GoPlayer
  class BoardRecorder
    include Celluloid
    def initialize(moves=[])
      @moves = moves
    end

    def played? move
      @moves.include? move
    end

    def record move
      @moves << move
    end
  end
end
