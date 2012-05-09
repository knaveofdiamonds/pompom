require 'ffi-ncurses'
require 'artii'

module Pompom
  def self.format_time(number)
    minutes = number / 60
    seconds = number % 60
    sprintf("%02d:%02d", minutes, seconds)
  end
  
  class NCursesScreen
    include FFI::NCurses

    def run
      begin
        initscr
        cbreak
        noecho
        curs_set 0
        yield
      ensure
        endwin
      end
    end
  end

  class Pomodoro
    attr_reader :time_remaining
    attr_writer :system_clock
    
    def initialize(time_remaining=1500)
      @time_remaining = time_remaining
      @system_clock = Kernel
    end

    def tick
      @system_clock.sleep 1
      @time_remaining -= 1
    end

    def finished?
      @time_remaining < 1
    end
  end
end
