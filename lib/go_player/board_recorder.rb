require 'celluloid'
module GoPlayer
  class BoardRecorder
    include Celluloid
    def initialize(moves=[])
      @moves = moves
    end

    def played? position
      @moves.map(&:position).include? position
    end

    def record move
      @moves << move
    end
  end
end
