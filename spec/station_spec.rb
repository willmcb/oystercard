require 'station'

describe Station do
 subject(:station) { Station.new("barbican", 3) }
 it 'has a name and zone on instantiation' do
   expect(station.zone).to eq(3)
   expect(station.name).to eq("barbican")
 end
end
