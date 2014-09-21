require_relative 'card'
require_relative 'deck'
class Hand
  attr_reader :cards
  POKER_RANKING = {
    :straight_flush => 10,
    :four_of_a_kind => 9,
    :full_house => 8,
    :flush => 7,
    :straight => 6,
    :two_pairs => 5,
    :three_of_a_kind => 4,
    :pair => 3,
    :high_card => 2
  }
  
  def initialize(source)
    source.is_a?(Deck) ? @cards = source.deal(5) : @cards = source
  end
  
  def count
    @cards.count
  end
  
  def return(pos, deck)
    pos.each do |card|
     deck.return(@cards[card])
     @cards[card] = nil
   end
   @cards.compact!
 end
  
 def draw(pos, deck)
   self.return(pos, deck)
   @cards += deck.deal(pos.count)
 end
  
 def flush?
   return false unless self.cards.map{|card| card.suit}.uniq.count == 1
   true
 end
 
 def flush_kicker
   @cards.sort.reverse
 end
 
 def pair?
   self.dup_count == [2]
 end
 
 def three_of?
   self.dup_count == [3]
 end
 
 def four_of? 
   self.dup_count == [4]
 end
 
 def two_pairs? 
   self.dup_count == [2,2]
 end
 
 def full_house?
   self.dup_count == [2,3]
 end
 
 def high_card?
   self.dup_count == []
 end
 
 def straight?
   cards = @cards.sort
   return true if cards[-1].value == :ace && cards[-2].value == :five
   pt_diff = []
   cards.each_with_index do |card, index|
     next if index == 4
     pt_diff << cards[index+1].poker_value - card.poker_value  
   end
   return true if pt_diff == [1,1,1,1]
   false
 end
 
 def dup_count
   value_counts = Hash.new(0)
   @cards.each do |card|
     value_counts[card.value] += 1
   end
   dups = []
   value_counts.each do |value, count|
     dups << count if count > 1
   end
   dups.sort
 end
 
 def type
   case
   when self.flush? && self.straight?
     return :straight_flush
   when self.flush?
     return :flush
   when self.straight? 
     return :straight
   when self.high_card?
     return :high_card
   when self.pair?
     return :pair
   when self.three_of?
     return :three_of_a_kind
   when self.four_of?
     return :four_of_a_kind
   when self.full_house?
     return :full_house
   when self.two_pairs?
     return :two_pairs
   else
     raise error "Not a known hand type, you sure you playing poker?"
   end
 end
  
 def sorted 
   sorted = []
   occurance = []
   num_counts = Hash.new(0)
   @cards.each do |card|
     num_counts[card.poker_value] += 1
   end
   #sort the numbeer of times each card type as occured 
   occurance = num_counts.sort_by {|value, times| times }.reverse
   occurance_times = occurance.map {|card| card.last}.uniq
   occurance_times.each do |occur|
     #select the double, single, etc type and sort by reverse value order
     sorted += occurance.select{|card| card.last == occur }.sort.reverse
   end
   sorted
 end
 
 def compare(hand1, hand2)
   hand1.count.times do |type_index|
     return -1 if hand1[type_index].first > hand2[type_index].first
     return 1 if hand1[type_index].first < hand2[type_index].first
   end
   0
 end
 
 def <=> (other_hand)
   hand_type_pt = POKER_RANKING[self.type]
   other_hand_type_pt = POKER_RANKING[other_hand.type]
   return -1 if hand_type_pt > other_hand_type_pt
   return 1 if other_hand_type_pt > hand_type_pt
   self.compare(self.sorted, other_hand.sorted)
 end
 
end