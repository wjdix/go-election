module GoPlayer
  class Move
    attr_reader :position, :color
    def initialize(color, position)
      @color = color
      @position = position
    end
  end
end
