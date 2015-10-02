class Timer
  
  attr_accessor :seconds
  def initialize
    @seconds = 0
    @minutes = @seconds/60
    @hours = @minutes/60
  end
  
  def seconds
    @seconds
  end
  
  def minutes
    @minutes
  end
  
  def hours
    @hours
  end
  
  def time_string
    "#{format('%02d', @hours)}:#{format('%02d', @minutes)}:#{format('%02d', @seconds)}"
  end

end

timer = Timer.new
put timer.seconds
put timer.minutes
put timer.hours