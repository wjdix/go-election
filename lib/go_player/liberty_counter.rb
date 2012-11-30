module GoPlayer
  class LibertyCounter
    include Celluloid
    def initialize(recorder)
      @recorder = recorder
    end

    def count_liberties(position)
      return nil unless @recorder.played?(position)
      find_liberties(position).count
    end

    def find_liberties(position, counted=[])
      return [] if counted.include?(position)
      color = @recorder.color_at(position)
      free_spaces = position.neighbors.select{ |neighbor| !@recorder.played?(neighbor) }
      to_count = position.neighbors.
        select{ |neighbor| @recorder.played?(neighbor) && @recorder.color_at(neighbor) == color }
      to_count -= counted
      counted << position
      to_count.inject(free_spaces){|accum, neighbor|
        accum + find_liberties(neighbor, counted)
      }.uniq
    end
  end
end
