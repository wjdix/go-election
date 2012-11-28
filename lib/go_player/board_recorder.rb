require 'celluloid'
module GoPlayer
  class BoardRecorder
    attr_reader :moves
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

    def color_at position
      move = @moves.first{|move| move.position == position}
      move ? move.color : nil
    end
  end
end
