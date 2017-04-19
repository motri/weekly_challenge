class Oystercard
  attr_reader :balance, :in_journey, :logg
  DEFAULT_LIMIT = 90
  MIN_FUNDS = 1
  FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @logg = []
  end

  def top_up(amount)
    fail "Top-up would exceed £#{DEFAULT_LIMIT} limit" if @balance + amount > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail 'Insuficient funds' if @balance < MIN_FUNDS
    @in_journey = true
    @logg << station
  end

  def touch_out
    @in_journey = false
    spend(FARE)
  end

  def in_journey?
    @in_journey
  end

  private

  def spend(amount)
    @balance -= amount
  end

end
