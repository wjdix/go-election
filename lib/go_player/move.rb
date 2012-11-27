module GoPlayer
  class Move
    attr_reader :position
    def initialize(color, position)
      @color = color
      @position = position
    end
  end
end
