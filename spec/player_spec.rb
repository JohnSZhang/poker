require "rspec"
require "player"

describe Player do
  subject(:player) { Player.new("James Bond", hand, 800) }
  let(:hand) { double("hand", :count => 5 ) }
  let(:deck) { double("deck") }
  let(:new_hand) { double("new_hand") }
  
  
  it "should have name" do 
    expect(player.name).to eq("James Bond")
  end
  
  it "should have a hand" do 
    expect(player.hand.count).to eq(5)
  end
  
  it "should have a bankroll" do
    expect(player.bankroll).to eq(800)
  end
  
  it "should correctly get a new hand" do 
    player.new_hand(new_hand)
    expect(player.hand).to eq(new_hand)
  end
  
  it "should have method that discards and gets new hand" do 
    expect(hand).to receive(:draw)
    expect(hand).to receive(:return)
    player.discard([0,1], deck)
  end
  
  it "should have bankroll subtracted if player raises." do
    player.bet(400)
    expect(player.bankroll).to eq(400)
  end
  
  it "shouldn't allow user to bet than he can cover" do
    expect do 
      player.bet(2000000)
    end.to raise_error
  end
  
  it "should allow player to receive winnings" do
    player.receive(400)
    expect(player.bankroll).to eq(1200)
  end
  
  
  it "should allow player to fold" do 
    expect(hand).to receive(:count).and_return(5)
    expect(hand).to receive(:return).with([0,1,2,3,4], deck)
    player.fold(deck)
    expect(player.hand).to be_nil
    expect(player.folded?).to be true
  end
  
end