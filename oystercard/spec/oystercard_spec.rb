require 'oystercard'

describe Oystercard do

  it 'checks the cards balance' do
    expect(subject.balance).not_to eq nil
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up your balance' do
      expect{ subject.top_up 5 }.to change{ subject.balance }.by 5
    end

  end

end
