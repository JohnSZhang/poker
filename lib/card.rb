class Card
  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUE_STRINGS = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }
  
  attr_reader :suit, :value
  
  def self.suits 
    SUIT_STRINGS.keys
  end
  
  def self.values
    VALUE_STRINGS.keys
  end
  
  def initialize(suit, value)
    raise "That's not a real suit!" unless SUIT_STRINGS.keys.include?(suit)
    raise "That's an illegal value!" unless VALUE_STRINGS.keys.include?(value)
    @suit = suit
    @value = value
  end
  
  def == (other_card)
    self.suit == other_card.suit && self.value == other_card.value
  end
  
  def to_s 
    "#{self.value} of #{self.suit}"
  end
    
end