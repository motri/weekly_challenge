class Oystercard

  MAX_BALANCE = 99

  attr_reader :balance

  def initialize
    @balance = 0
    @status = false
  end

  def top_up(n)
    raise 'That exceeds the maximum balance' if
    (balance + n) > MAX_BALANCE
    @balance += n
  end

  def deduct(m)
    @balance -= m
  end

  def in_journey?
    @status
  end

  def touch_in
    @status = true
  end

  def touch_out
    @status = false
  end

end
