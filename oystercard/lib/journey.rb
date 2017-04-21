class Journey

  attr_reader :history
  attr_accessor :in_journey, :entry_station, :exit_station, :journey

  def initialize
    @history = []
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @journey = {}
  end

  def start(station)
    @in_journey = true
    @entry_station = station
    @journey[@entry_station]
  end

  def end(station)
    @in_journey = false
    @exit_station = station
    @journey[@entry_station] = @exit_station
    tracker
  end

  def in_journey?
    @in_journey
  end

  def tracker
    @history << @journey
    @entry_station = nil
  end


end
