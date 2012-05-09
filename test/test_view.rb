require 'helper'

describe Pompom::View do
  before do
    @screen = MiniTest::Mock.new
    @view = Pompom::View.new(@screen)
  end

  it "should display an asciified time on the screen when updated" do
    asciifier = MiniTest::Mock.new
    asciifier.expect(:asciify, "foo", ["00:01"])
    @view.asciifier = asciifier
    @screen.expect(:display, nil, ["foo"])
    
    @view.update(1)
    
    @screen.verify
    asciifier.verify
  end
end
