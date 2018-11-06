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

end
