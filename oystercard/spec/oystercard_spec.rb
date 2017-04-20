require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new } #let(:card){double: card}
  before do
  @min = Oystercard::MIN_FUNDS
  end

  it 'initializes with a balance of zero' do
    expect(card.balance).to eq 0
  end

  it 'starts with an empty travel history' do
    expect(card.history).to eq []
  end
  describe '#top_up' do

    it 'tops up balance by specified amount' do
      subject.top_up(15)
      expect(subject.balance).to eq 15
    end


    it 'raises an error if top-up would push balance above £90' do
      expect{ subject.top_up(100) }.to raise_error "Top-up would exceed £#{Oystercard::DEFAULT_LIMIT} limit"
    end
  end

  describe '#touch_in(station)' do

    station = "abbeywood"

    it 'touches in' do
      card.top_up(@min); card.touch_in(station)
      expect(card).to be_in_journey
    end

    it 'raises an error when insufficient funds' do
      expect { card.touch_in(station) }.to raise_error 'Insuficient funds'
    end

    it 'remembers the station' do
      card.top_up(@min); card.touch_in(station)
      expect(card.entry_station).to include(station)
    end
  end


describe '#touch_out' do
  enter = "station"
  out = 'abbeywood'

  it 'touches out' do
    card.top_up(@min); card.touch_in(enter); card.touch_out(out)
    expect(card).not_to be_in_journey
  end


  it 'charges minimum fare' do
    card.top_up(10); card.touch_in(enter)
    expect{ card.touch_out(out) }.to change{ card.balance }.by -Oystercard::FARE
  end

  it 'forgets the entry station' do
    card.top_up(@min); card.touch_in(enter); card.touch_out(out)
    expect(card.entry_station).to eq nil
  end

  it 'stores exit station' do
    card.top_up(@min); card.touch_in(enter); card.touch_out(out)
    expect(card.exit_station).to eq out
  end
end

  describe '#in_journey?' do

    it 'checks the journey status' do
      expect(card.in_journey?).to eq(true).or(eq(false))
    end
  end

  describe '#tracker' do
    enter = "Cannon Street"
    out = 'Abbey Wood'
    it 'creates a record of travel history' do
      card.top_up(@min); card.touch_in(enter); card.touch_out(out)
      expect(card.history).to eq [{"Cannon Street"=>"Abbey Wood"}]
    end
  end
end
