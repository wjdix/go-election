module GoPlayer
  module Colors
    class << self
      def parse(color)
        if color.downcase == "black" || color.downcase == "b"
          Black
        else
          White
        end
      end
    end
    class Black
      class << self
        def opposite
          GoPlayer::Colors::White
        end
      end
    end
    class White
      class << self
        def opposite
          GoPlayer::Colors::Black
        end
      end
    end
  end
end
