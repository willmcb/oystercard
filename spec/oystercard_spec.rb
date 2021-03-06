require 'oystercard'

describe Oystercard do

  subject(:oystercard) {Oystercard.new}
  before :each do
    oystercard.top_up(10)
  end

  it 'can add money to balance' do
    expect(oystercard.balance).to eq(10)
  end

  it 'has a maximum limit of 90 pounds' do
    expect{oystercard.top_up(Oystercard::MAX_LIMIT + 1)}.to raise_error
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

  it "returns an error if user attempts to touch in with less than minimum" do
    oystercard.balance = 0
    expect{ oystercard.touch_in }.to raise_error "You have less than minimum fare: please top up!"
  end

  it "deducts the correct amount for journey on touch out" do
    oystercard.touch_in
    expect{oystercard.touch_out}.to change{oystercard.balance}.by(-Oystercard::MINIMUM_FARE)
  end

  it "print a list of my journeys" do
    barbican = Station.new("barbican", 1)
    lewisham = Station.new("lewisham", 3)
    oystercard.top_up(10)
    oystercard.touch_in(barbican)
    oystercard.touch_out(lewisham)
    oystercard.touch_in(lewisham)
    oystercard.touch_out(barbican)
    expect{oystercard.print_journey_history}.to output("barbican (zone 1) : lewisham (zone 3)\nlewisham (zone 3) : barbican (zone 1)\n").to_stdout
  end
end
