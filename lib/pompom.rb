require 'ffi-ncurses'
require 'artii'

module Pompom
  def self.format_time(number)
    minutes = number / 60
    seconds = number % 60
    sprintf("%02d:%02d", minutes, seconds)
  end

  class Pomodoro
    attr_reader :time_remaining
    attr_writer :system_clock
    
    def initialize(time_remaining=1500)
      @time_remaining = time_remaining
      @system_clock = Kernel
      @observers = []
    end

    def add_observer(object)
      @observers << object
    end
    
    def tick
      @system_clock.sleep 1
      @time_remaining -= 1
      notify_observers
    end

    def finished?
      @time_remaining < 1
    end

    private

    def notify_observers
      @observers.each {|o| o.update(@time_remaining) }
    end
  end

  class View
    attr_writer :asciifier
    
    def initialize(screen)
      @screen = screen
      @asciifier = Asciifier.new
    end

    def run(&block)
      @screen.run(&block)
    end

    def update(time)
      @screen.display format_for_screen(time)
    end

    private
    
    def format_for_screen(time)
      @asciifier.asciify(Pompom.format_time(time))
    end
  end

  class Asciifier
    def initialize
      @asciifier = Artii::Base.new
    end

    def asciify(text)
      result = @asciifier.asciify(text).split("\n")
      # Fix kerning for when 2nd character of minutes is a 4. This fix
      # should really be moved back upstream to the figlet font.
      result[3].sub!(/_\| /, '_|')
      result.join("\n")
    end
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

    def display(str)
      clear
      addstr(str)
      refresh
    end
  end
end
