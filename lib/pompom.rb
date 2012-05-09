require 'ffi-ncurses'
require 'artii'

def format_time(number)
  minutes = number / 60
  seconds = number % 60
  sprintf("%02d:%02d", minutes, seconds)
end

module Pompom
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
end
