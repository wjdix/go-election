module GoPlayer
  class Position
    attr_reader :row
    COLUMNS = ('a'..'t').to_a - ['i']

    def self.all
      1.upto(19).to_a.product(COLUMNS).map {|row, col| new(row, col) }
    end

    def initialize(row, column)
      @row = row
      @column = column
    end

    def column
      @column && @column.downcase
    end

    def neighbors
      ([@row - 1, @row + 1].map { |new_row| self.class.new(new_row, column) } +
        [column_index - 1, column_index + 1].map { |new_col| self.class.new(row, COLUMNS[new_col]) }).
        select(&:valid?)
    end

    def valid?
      1.upto(19).to_a.include?(@row) &&
        COLUMNS.include?(column)
    end

    def ==(other)
      other.row == row && other.column == column
    end

    def eql?(other)
      self == other
    end

    def to_s
      "#{column}#{@row}"
    end

    def column_index
      COLUMNS.index(column)
    end
  end
end
