module GoPlayer
  class Position
    attr_reader :row, :column
    COLUMNS = ('A'..'Z').to_a - ['I']
    def initialize(row, column)
      @row = row
      @column = column
    end

    def valid?
      1.upto(19).to_a.include?(@row) &&
        COLUMNS.include?(@column)
    end

    def ==(other)
      other.row == row && other.column == column
    end

    def eql?(other)
      self == other
    end
  end
end
