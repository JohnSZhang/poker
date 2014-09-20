require "rspec"
require "card"
describe Card do 
  subject(:card) { Card.new(:hearts, :five)}
  it "has suits and value" do 
    expect(card.suit).to eq(:hearts)
    expect(card.value).to eq(:five)
  end
  
  it "doesn't allow illegal suits or values" do
    expect{ Card.new(:craziness, :seven) }.to raise_error("That's not a real suit!")
    expect{ Card.new(:diamonds, :twenety_two) }.to raise_error("That's an illegal value!")
  end
  
  it "has a good to string method" do
    expect(card.to_s).to eq("five of hearts")
  end
  
  it "can compare itself to another card" do 
    other_card = Card.new(:clubs, :eight)
    duplicate_card = Card.new(:hearts, :five)
    expect(card == other_card).to be false
    expect(card == duplicate_card).to be true
  end
end