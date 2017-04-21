require_relative 'journey'

class Oystercard
  attr_reader :balance
  attr_accessor :trip, :entry_station, :exit_station

  DEFAULT_LIMIT = 90
  MIN_FUNDS = 1
  FARE = 1

  def initialize
    @balance = 0
    @trip = Journey.new
  end

  def top_up(amount)
    @increase = amount
    raise "Top-up would exceed £#{DEFAULT_LIMIT} limit" if overlimit
    @balance += @increase
  end

  def touch_in(station)
    raise 'Insuficient funds' if @balance < MIN_FUNDS
    @trip.start(station)
  end

  def touch_out(station)
    penalty if !@trip.in_journey?
    spend(FARE)
    @trip.end(station)
  end

  def overlimit
    @balance + @increase > DEFAULT_LIMIT
  end
  
  def penalty
    spend(6); fail 'You did not touch in'
  end
  private

  def spend(amount)
    @balance -= amount
  end
end
