require 'station'
describe Station do
  it 'knows its name' do
    station = Station.new('Old Street', 1)
    expect(station.name).to eq('Old Street')
  end

  it 'knows its zone' do
    station = Station.new('Old Street', 1)
    expect(station.zone).to eq(1)
  end
end
