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

  it 'has a maximum limit of 90 pounds' do
    expect{oystercard.top_up(Oystercard::MAX_LIMIT + 1)}.to raise_error
  end

  it 'can deduct an amount from the balance' do
    oystercard.top_up(10)
    oystercard.deduct(5)
    expect(oystercard.balance).to eq(5)
  end

  it 'cannot deduct an amount that would make balance negative' do
    oystercard.top_up(10)
    expect{oystercard.deduct(15)}.to raise_error("balance cannot be negative")
  end

  it 'can be touched in' do
    expect{ oystercard.touch_in }.not_to raise_error
  end

  it 'can be touched out' do
    oystercard.touch_in
    expect{ oystercard.touch_out }.not_to raise_error
  end

  it "can't be touched in if in journey" do
    oystercard.touch_in
    expect{ oystercard.touch_in }.to raise_error "Card already touched in!"
  end

  it "can't be touched out if not previously touched in" do
    expect{ oystercard.touch_out }.to raise_error "Card not touched in!"
  end

  it "changes journey to true when touched in" do
    oystercard.touch_in
    expect(oystercard.in_journey?).to eq(true)
  end

  it "changes journey to false when touched out" do
    oystercard.touch_in
    oystercard.touch_out
    expect(oystercard.in_journey?).to eq(false)
  end

end
