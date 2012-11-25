class VetoVoter
  include Celluloid
  def initialize to_veto
    @to_veto = to_veto
  end

  def vote move
    if move == @to_veto
      GoPlayer::Votes::VETO
    end
  end
end

class YayVoter
  include Celluloid
  def initialize to_support
    @to_support = to_support
  end

  def vote move
    if move == @to_support
      GoPlayer::Votes::YAY
    end
  end
end
