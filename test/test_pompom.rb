require 'helper'
  
describe "Pompom" do
  it "should format 0 as 00:00" do
    format_time(0).must_equal "00:00"
  end

  it "should format 1 second as 00:01" do
    format_time(1).must_equal "00:01"
  end

  it "formats 60 seconds as 01:00" do
    format_time(60).must_equal "01:00"
  end

  it "formats 61 seconds as 01:01" do
    format_time(61).must_equal "01:01"
  end
end
