require_relative './move'
require_relative './board_recorder'
require_relative './position'

module GoPlayer
  class LifeVoter
    include Celluloid
    def initialize(recorder, color)
      @color = color
      @recorder = recorder
    end

    def will_live?(position)
      allies = position.neighbors.select{|neighbor| @recorder.color_at(neighbor) == @color}
      position.neighbors.any?{|neighbor| !@recorder.played?(neighbor) } ||
      allies.any? do |neighbor|
        cloned_after_move(position) do |cloned|
          cloned.will_live?(neighbor)
        end
      end
    end

    def cloned_after_move(position)
      move = Move.new(@color, position)
      recorder = BoardRecorder.new(@recorder.moves << move)
      cloned = self.class.new(recorder, @color)
      result = yield cloned
      recorder.terminate
      cloned.terminate
      result
    end
  end
end
