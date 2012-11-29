module GoPlayer
  class Move
    attr_reader :position, :color
    def initialize(color, position)
      @color = color
      @position = position
    end

    def ==(other)
      other.position == self.position &&
        other.color == self.color
    end
  end
end
