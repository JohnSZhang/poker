class Player

  attr_reader :name, :hand, :bankroll
  
  def initialize(name, hand, bankroll)
    raise "Not a valid name!" unless String(name)
    raise "Not a valid bankroll!" unless bankroll.is_a?(Fixnum)
    @name, @hand, @bankroll, @folded = name, hand, bankroll, false
  end
  
  def discard(pos, deck)
    self.hand.return(pos, deck)
    self.hand.draw(pos,deck)
  end
  
  def new_hand(new_hand)
    @hand = new_hand
    @folded = false
  end
  
  def bet(amt)
    raise "can't bet what you don't have, big shot" unless @bankroll > amt
    @bankroll -= 400
  end
  
  def receive(winning)
    @bankroll += winning
  end
  
  def fold(deck)
    @folded = true
    hand_length = self.hand.count
    self.hand.return((0...hand_length).to_a, deck)
    @hand = nil
  end
  
  def folded?
    @folded
  end
  
end