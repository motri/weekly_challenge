require 'oystercard'

describe Oystercard do

  it 'checks the cards balance' do
    expect(subject.balance).not_to eq nil
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it 'tops up your balance' do
      expect { subject.top_up 5 }.to change { subject.balance }.by 5
    end
    it 'raises an error when cleartrying to exceed max balance' do
      message = 'That exceeds the maximum balance'
      subject.top_up(Oystercard::MAX_BALANCE)
      expect { subject.top_up 1 }.to raise_error message
    end
  end

  describe '#deduct' do
    it 'deducts fare from balance' do
      expect { subject.deduct 5 }.to change { subject.balance }.by -5
    end
  end

  describe '#in_journey?' do
    it 'starts as not in journey'do
      expect(subject).to_not be_in_journey
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in) }
    it "loggs when touched in" do
      subject.touch_in
      expect(subject).to be_in_journey
    end


    it 'raises error when balance insuficient' do
      expect{ subject.touch_in }.to raise_error 'Insufficient funds'
    end
  end


  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out) }
    it 'loggs when touched out' do
      subject.touch_in
      subject.touch_out
      expect(subject).to_not be_in_journey
    end
  end
end
