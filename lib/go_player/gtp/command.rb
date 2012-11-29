module GoPlayer
  module GTP
    class Command
      def initialize(line)
        @line = line
      end

      def number
        @number ||= @line[/\A\d+/]
      end

      def body
        @body ||= @line.sub(/\A\d+\s+/, "").strip
      end

      def move
        command, color, coords = body.split(" ")
        col = coords[/\w/]
        row = coords[/\d+/]
        GoPlayer::Move.new(GoPlayer::Colors.parse(color), GoPlayer::Position.new(row.to_i, col))
      end
    end
  end
end
