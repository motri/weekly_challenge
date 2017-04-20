class Oystercard
  attr_reader :balance, :in_journey, :entry_station, :exit_station, :history

  DEFAULT_LIMIT = 90
  MIN_FUNDS = 1
  FARE = 1


  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @journey = {}
    @history = []

  end

  def top_up(amount)
    fail "Top-up would exceed £#{DEFAULT_LIMIT} limit" if @balance + amount > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail 'Insuficient funds' if @balance < MIN_FUNDS
    @in_journey = true
    @entry_station = station
  end

  def touch_out(station)
    @in_journey = false
    spend(FARE)
    @exit_station = station
    tracker
  end

  def in_journey?
    @in_journey
  end

  def tracker
    @journey[@entry_station] = @exit_station
    @history << @journey
    @entry_station = nil
  end


  private

  def spend(amount)
    @balance -= amount
  end

end
