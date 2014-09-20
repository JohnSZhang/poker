require "rspec"
require "deck"
require "card"

describe Deck do 
let(:five_cards) {[ Card.new(:hearts, :five),
  Card.new(:clubs, :three), Card.new(:diamonds, :six),
  Card.new(:spades, :king), Card.new(:clubs, :eight)
  ]}
  let(:five_card_deck) { Deck.new(five_cards)}

  context "a new 52 card deck" do
    it "should give you the cards in an array" do
      subject.cards.each do |card|
        expect(card).to be_a(Card)
      end
    end
  end
  
  it "should have 52 cards" do
    expect(subject.count).to eq(52)
  end

  it "should not have any duplicates" do
    cards = []
    subject.cards.each do |card|
      cards << [card.suit, card.value]
    end
    expect(cards.uniq.count).to eq(52)
  end

  context "a random deck of 5 cards" do 
  
    it "can be created from an array of cards" do
      expect{ Deck.new(five_cards) }.to_not raise_error
    end

    it "tells you how many cards are in the deck" do
      expect(five_card_deck.count).to eq(5)
    end
  end

  it "Can deal cards from top" do
    hand = subject.deal(5)
    expect(hand.count).to eq(5)
    expect(subject.count).to eq(47)
  end

  it "Can receive returned cards from others" do
    hand = five_card_deck.deal(2)
    expect(five_card_deck.count).to eq(3)
    five_card_deck.return(hand)
    expect(five_card_deck.cards.last).to eq(Card.new(:clubs, :three))
  end

  it "shuffles itself" do 
    five_card_deck.shuffle
    expect(five_card_deck.cards.first(2)).to_not eq([Card.new(:hearts, :five),
      Card.new(:clubs, :three)])
  end
end