require 'oystercard'

describe "Feature tests: " do
  it 'has deafault balance of zero' do
    expect(Oystercard.new.balance).to eq(0)
  end

  it 'customer can add money to card' do
    card = Oystercard.new
    card.top_up(10)
    expect(card.balance).to eq(10)
  end

  it 'has a maximum balance of 90' do
    card = Oystercard.new
    expect{card.top_up(91)}.to raise_error
  end

  it 'has touch in and out functionality' do
    card = Oystercard.new
    card.top_up(10)
    card.touch_in
    in_journey = card.in_journey?
    card.touch_out
    expect(in_journey).to be(true)
    expect(card.in_journey?).to be(false)
  end

  it "can't be touched in if balance is less than the minimum fare" do
    card = Oystercard.new
    expect{ card.touch_in }.to raise_error
  end

  it "deducts the correct amount for journey on touch out" do
    card = Oystercard.new
    card.top_up(10)
    card.touch_in
    expect{card.touch_out}.to change{card.balance}.by(-Oystercard::MINIMUM_FARE)
  end

  it "store where I have travelled from" do
    card = Oystercard.new
    card.top_up(10)
    card.touch_in('barbican')
    expect(card.travelled_from).to eq('barbican')
  end
end
