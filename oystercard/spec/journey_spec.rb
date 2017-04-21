require 'journey'
require 'oystercard'

describe Journey do

  let(:card) { Oystercard.new } # let(:card){double: card}
  before do
    @min = Oystercard::MIN_FUNDS

  end

  it 'starts with an empty travel history' do
    expect(subject.history).to eq []
  end

  describe '#start' do
    station = 'station'
    it 'starts journey' do
      card.top_up(@min); card.touch_in(station)
      expect(card.trip.in_journey).to eq true
    end
    it 'sets entry_station' do
      card.top_up(@min); card.touch_in(station)
      expect(card.trip.entry_station).to eq station
    end
  end

  describe '#end' do
    enter = 'Abbey Wood'
    out = 'Cannon Street'
    it 'end journey' do
      card.top_up(@min); card.touch_in(enter); card.touch_out(out)
      expect(card.trip).not_to be_in_journey
    end

    it 'sets exit_station' do
      card.top_up(@min); card.touch_in(enter); card.touch_out(out)
      expect(card.trip.exit_station).to eq out
    end

    it 'forgets the entry station' do
      card.top_up(@min); card.touch_in(enter); card.touch_out(out)
      expect(card.trip.entry_station).to eq nil
    end
  end

    describe '#tracker' do
      enter = 'Cannon Street'
      out = 'Abbey Wood'
      it 'creates a record of travel history' do
        card.top_up(@min); card.touch_in(enter); card.touch_out(out)
        expect(card.trip.history).to eq [{ 'Cannon Street' => 'Abbey Wood' }]
      end
    end

end
