require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new } # let(:card){double: card}
  before do
    @min = Oystercard::MIN_FUNDS
  end

  it 'initializes with a balance of zero' do
    expect(card.balance).to eq 0
  end

  describe '#top_up' do
    it 'tops up balance by specified amount' do
      subject.top_up(15)
      expect(subject.balance).to eq 15
    end

    it 'raises an error if top-up would push balance above £90' do
      expect { subject.top_up(100) }.to raise_error "Top-up would exceed £#{Oystercard::DEFAULT_LIMIT} limit"
    end
  end

  describe '#touch_in(station)' do
    station = 'abbeywood'
    it 'raises an error when insufficient funds' do
      expect { card.touch_in(station) }.to raise_error 'Insuficient funds'
    end
  end

  describe '#touch_out' do
    enter = 'station'
    out = 'abbeywood'

    it 'charges penalty when not touched in' do
      card.top_up(10)
      expect { card.touch_out(out) }.to raise_error 'You did not touch in'
      expect(card.balance).to eq (4) 
    end

    it 'charges minimum fare' do
      card.top_up(10); card.touch_in(enter)
      expect { card.touch_out(out) }.to change { card.balance }.by -Oystercard::FARE
    end

  end

end
