require "rspec"
require "card"
require "hand"
describe Hand do
  let(:high_card) do [ Card.new(:hearts, :five),
    Card.new(:clubs, :three), Card.new(:diamonds, :six),
    Card.new(:spades, :king), Card.new(:clubs, :eight)
  ]
  end
  let(:pair) do [ Card.new(:hearts, :five),
    Card.new(:clubs, :five), Card.new(:diamonds, :six),
    Card.new(:spades, :king), Card.new(:clubs, :eight)
    ]
  end
  let(:three_of) do [ Card.new(:hearts, :five),
    Card.new(:clubs, :five), Card.new(:diamonds, :five),
    Card.new(:spades, :king), Card.new(:clubs, :eight)
  ]
  end
  let(:house) do [ Card.new(:hearts, :five),
  Card.new(:clubs, :five), Card.new(:diamonds, :five),
  Card.new(:spades, :king), Card.new(:clubs, :king)
  ]
  end
  let(:house) do [ Card.new(:hearts, :five),
  Card.new(:clubs, :five), Card.new(:diamonds, :five),
  Card.new(:spades, :king), Card.new(:clubs, :king)
  ]
  end      
  let(:flush) do [ Card.new(:hearts, :five),
  Card.new(:hearts, :six), Card.new(:hearts, :nine),
  Card.new(:hearts, :queen), Card.new(:hearts, :jack)
  ]  
  end
  let(:straight) do [ Card.new(:hearts, :five),
  Card.new(:hearts, :six), Card.new(:hearts, :nine),
  Card.new(:hearts, :eight), Card.new(:clubs, :seven)
  ]
  end
  let(:ace_high) do [ Card.new(:hearts, :five),
  Card.new(:hearts, :deuce), Card.new(:hearts, :four),
  Card.new(:clubs, :three), Card.new(:clubs, :ace)
  ]
  end
  let(:ace_low) do [ Card.new(:hearts, :queen),
  Card.new(:hearts, :ten), Card.new(:hearts, :king),
  Card.new(:hearts, :ace), Card.new(:clubs, :jack)
  ]    
  end   
  let(:two_pairs) do [ Card.new(:hearts, :five),
  Card.new(:diamonds, :six), Card.new(:clubs, :six),
  Card.new(:clubs, :five), Card.new(:hearts, :jack)
  ]
  end    
  let(:four_of) do [ Card.new(:hearts, :five),
  Card.new(:clubs, :five), Card.new(:spades, :five),
  Card.new(:diamonds, :five), Card.new(:hearts, :jack)
  ]
  end   
  let(:four_of) do [ Card.new(:hearts, :five),
  Card.new(:clubs, :five), Card.new(:spades, :five),
  Card.new(:diamonds, :five), Card.new(:hearts, :jack)
  ]
  end 
  let(:straigh_flush) do [ Card.new(:hearts, :five),
  Card.new(:hearts, :six), Card.new(:hearts, :eight),
  Card.new(:hearts, :seven), Card.new(:hearts, :four)
  ]
  end  
  let(:deck) { double("deck") }
  
  context "hand creation" do
  
    it "can be created from a deck" do
      deck.stub(:is_a? => :Deck)
      deck.stub(:deal).with(5).and_return(:high_card)
      expect(Hand.new(deck).cards).to eq(:high_card)
    end

    it "can be created from an array of cards" do
      expect{ Hand.new(:high_card) }.to_not raise_error
    end

  end
  
  it "should be able to tell you how many cards are in it" do
    expect(Hand.new(high_card).count).to eq(5)
  end
  
  context "hand destruction" do
       
    it "can be returned into a deck" do
      hand = Hand.new(high_card)
      expect(deck).to receive(:return).exactly(5).times
      hand.return([0,1,2,3,4], deck)
      expect(hand.count).to eq(0)
    end
    
  end

  context "Hand Update" do 
  
    it "can returns two cards back to deck and take two more" do 
      hand = Hand.new( [ Card.new(:hearts, :five),
    Card.new(:clubs, :three), Card.new(:diamonds, :six)])
    expect(deck).to receive(:return).exactly(2).times
    expect(deck).to receive(:deal).with(2).and_return([Card.new(:spades, :king), Card.new(:clubs, :eight)
    ])
      hand.draw([0,1], deck)
      expect(hand.cards).to eq([Card.new(:diamonds, :six),Card.new(:spades, :king), Card.new(:clubs, :eight)])
    end
      
  end
  
  context "Hand Type" do
   
    it "can tell if it's a pair" do 
      hand = Hand.new(pair)
      expect(hand.type).to eq(:pair)
    end
  
    it "can tell if it's a three of a kind" do 
      hand = Hand.new(three_of)
      expect(hand.type).to eq(:three_of_a_kind)
    end
  
    it "can tell if it's a house" do 
      hand = Hand.new(house)
      expect(hand.type).to eq(:full_house)
    end
  
    it "can tell if it's a flush" do 
      hand = Hand.new(flush)
      expect(hand.type).to eq(:flush)
    end
  
    it "can tell if its a straight" do 
      hand = Hand.new(straight)
      expect(hand.type).to eq(:straight)
    end
    
    it "can tell if its an ace high straight" do 
      hand = Hand.new(ace_high)
      expect(hand.type).to eq(:straight)
    end
    
    it "can tell if its an ace low straight" do 
      hand = Hand.new(ace_low)
      expect(hand.type).to eq(:straight)
    end        
  
    it "can tell if it's two pairs" do 
      hand = Hand.new(two_pairs)
      expect(hand.type).to eq(:two_pairs)
    end
  
    it "can tell if it's a four of a kind" do 
      hand = Hand.new(four_of)
      expect(hand.type).to eq(:four_of_a_kind)
    end
  
    it "can tell if it's only a high card" do 
      hand = Hand.new(high_card)
      expect(hand.type).to eq(:high_card)
    end
  
    it "can tell if it's a straight flush" do 
      hand = Hand.new(straigh_flush)
      expect(hand.type).to eq(:straight_flush)
    end
  end
  
    context "Hand Comparison" do 
    
    it "Knows Straight Flush Beats Everything" do
      good_hand = Hand.new(straigh_flush)
      bad_hand = Hand.new(ace_low)
      expect(good_hand <=> bad_hand).to eq(-1)
    end
  
    it "Knows four of a kind is next best" do
      better_hand = Hand.new(straigh_flush)
      good_hand = Hand.new(four_of)
      bad_hand = Hand.new(ace_low)
      expect(good_hand <=> better_hand).to eq(1)
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    
    it "knows full house is great" do
      better_hand = Hand.new(four_of)
      good_hand = Hand.new(house)
      bad_hand = Hand.new(ace_low)
      expect(good_hand <=> better_hand).to eq(1)
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    
    it "knows flush is next best" do
      better_hand = Hand.new(straigh_flush)
      good_hand = Hand.new(flush)
      bad_hand = Hand.new(ace_low)
      expect(good_hand <=> better_hand).to eq(1)
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    
    it "knows straight is pretty good" do
      better_hand = Hand.new(four_of)
      good_hand = Hand.new(ace_high)
      bad_hand = Hand.new(high_card)
      expect(good_hand <=> better_hand).to eq(1)
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    
    it "knows two_pairs is up there" do
      better_hand = Hand.new(straight)
      good_hand = Hand.new(two_pairs)
      bad_hand = Hand.new(pair)
      expect(good_hand <=> better_hand).to eq(1)
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    
    it "knows about three of a kind" do
      better_hand = Hand.new(straight)
      good_hand = Hand.new(three_of)
      bad_hand = Hand.new(pair)
      expect(good_hand <=> better_hand).to eq(1)
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    
    it "knows how to measure pairs" do
      better_hand = Hand.new(three_of)
      good_hand = Hand.new(pair)
      bad_hand = Hand.new(high_card)
      expect(good_hand <=> better_hand).to eq(1)
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    
    it "knows high_card kind of isn't great" do
      better_hand = Hand.new(two_pairs)
      good_hand = Hand.new(high_card)
      expect(good_hand <=> better_hand).to eq(1)
    end
    
    context "Can use kickers correctly" 
    
    it "knows to compare straight flushes" do 
      good_hand = Hand.new(straigh_flush)
      bad_hand = Hand.new([ Card.new(:hearts, :five),
  Card.new(:hearts, :six), Card.new(:hearts, :four),
  Card.new(:hearts, :seven), Card.new(:hearts, :three)
  ])
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    it "knows to compare four of a kinds" do 
      good_hand = Hand.new(four_of)
      bad_hand = Hand.new([ Card.new(:hearts, :five),
  Card.new(:clubs, :five), Card.new(:spades, :five),
  Card.new(:diamonds, :five), Card.new(:hearts, :seven)
  ])
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    
    it "knows to compare flushes" do 
      good_hand = Hand.new(flush)
      bad_hand = Hand.new([ Card.new(:hearts, :five),
  Card.new(:hearts, :six), Card.new(:hearts, :nine),
  Card.new(:hearts, :deuce), Card.new(:hearts, :jack)
  ]  )
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    
    it "knows to compare straights" do 
      good_hand = Hand.new(ace_high)
      bad_hand = Hand.new([ Card.new(:hearts, :five),
  Card.new(:hearts, :six), Card.new(:hearts, :nine),
  Card.new(:hearts, :eight), Card.new(:clubs, :seven)
  ])
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    
    it "knows to compare full houses" do 
      good_hand = Hand.new(house)
      bad_hand = Hand.new([ Card.new(:hearts, :five),
  Card.new(:clubs, :five), Card.new(:diamonds, :five),
  Card.new(:spades, :queen), Card.new(:clubs, :queen)
  ])
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    
    it "knows to compare two pairs" do 
      good_hand = Hand.new(two_pairs)
      bad_hand = Hand.new([ Card.new(:hearts, :five),
  Card.new(:diamonds, :six), Card.new(:clubs, :three),
  Card.new(:clubs, :three), Card.new(:hearts, :jack)
  ])
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    
    it "knows to compare three of a kinds" do 
      good_hand = Hand.new(three_of)
      bad_hand = Hand.new([ Card.new(:hearts, :five),
    Card.new(:clubs, :five), Card.new(:diamonds, :five),
    Card.new(:spades, :seven), Card.new(:clubs, :eight)
  ])
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    
    it "knows to compare pairs" do 
      good_hand = Hand.new(pair)
      bad_hand = Hand.new([ Card.new(:hearts, :five),
    Card.new(:clubs, :five), Card.new(:diamonds, :six),
    Card.new(:spades, :king), Card.new(:clubs, :seven)
    ])
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    
    it "knows to compare high cards" do 
      good_hand = Hand.new(high_card)
      bad_hand = Hand.new([ Card.new(:hearts, :five),
    Card.new(:clubs, :three), Card.new(:diamonds, :six),
    Card.new(:spades, :jack), Card.new(:clubs, :eight)
  ])
      expect(good_hand <=> bad_hand).to eq(-1)
    end
    it "knows when hands are exactly the same" do 
      good_hand = Hand.new(high_card)
      bad_hand = Hand.new([ Card.new(:hearts, :five),
    Card.new(:clubs, :three), Card.new(:diamonds, :six),
    Card.new(:spades, :king), Card.new(:clubs, :eight)
    ])
      expect(good_hand <=> bad_hand).to eq(0)
    end    
  end
end