require 'helper'

describe Pompom::Asciifier do
  before do
    @asciifier = Pompom::Asciifier.new
  end

  # i.e. fix line 4:
  #   ___  _  _   __  ___  
  #  |__ \| || | __ |/ _ \ 
  #     ) | || |__) | | | |
  #    / /|__   _| | | | | |
  #   / /_   | | _| | |_| |
  #  |____|  |_|(_)_|\___/ 
  it "fixes the problem with figlet font kerning" do
    @asciifier.asciify("24:10").must_equal ["  ___  _  _   __  ___  ", " |__ \\| || | __ |/ _ \\ ", "    ) | || |__) | | | |", "   / /|__   _|| | | | |", "  / /_   | | _| | |_| |", " |____|  |_|(_)_|\\___/ ", "                       ", "                       "].join("\n")
  end
end
