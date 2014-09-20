require_relative "card"
class Deck 
  
  attr_reader :cards
  
  def initialize(cards = [])
    if cards == []
      Card.suits.each do |suit|
        Card.values.each do |value|
          cards << Card.new(suit, value)
        end
      end
    end
    @cards = cards
  end
  
  def count
    @cards.count
  end
  
  def deal(num)
    @cards.shift(num)
  end
  
  def return(cards)
    @cards.concat(cards)
  end
    
  def shuffle
    @cards.shuffle!
  end
  
end