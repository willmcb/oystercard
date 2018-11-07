require 'oystercard'

describe "feature tests" do
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

  it 'can deduct an amount from the balance' do
    card = Oystercard.new
    card.top_up(10)
    card.deduct(5)
    expect(card.balance).to eq(5)
  end

  it 'has touch in and out functionality' do
    card = Oystercard.new
    card.touch_in
    in_journey = card.in_journey?
    card.touch_out
    expect(in_journey).to be(true)
    expect(card.in_journey?).to be(false)
  end
end
