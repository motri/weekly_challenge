class Oystercard

  MAX_BALANCE = 99

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(n)
    fail "That exceeds the maximum balance" if
   (balance + n) > MAX_BALANCE
    @balance += n
  end

  def deduct(m)
    @balance -= m
  end

end
