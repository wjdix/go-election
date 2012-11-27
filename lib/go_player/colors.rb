module GoPlayer
  module Colors
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
