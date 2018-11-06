require 'oystercard'

describe Oystercard do
  it 'has deafault balance of zero' do
    expect(Oystercard.new.balance).to eq(0)
  end
end
