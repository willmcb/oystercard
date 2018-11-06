require 'oystercard'

describe Oystercard do

  subject(:oystercard) {Oystercard.new}

  it 'has deafault balance of zero' do
    expect(oystercard.balance).to eq(0)
  end

  it 'can add money to balance' do
    oystercard.top_up(9)
    expect(oystercard.balance).to eq(9)
  end

end
