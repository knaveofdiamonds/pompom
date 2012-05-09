require 'helper'

describe Pompom::Pomodoro do
  before do
    @pomodoro = Pompom::Pomodoro.new
  end

  it "starts with 25 minutes remaining by default" do
    @pomodoro.time_remaining.must_equal 1500
  end

  it "reduces the time remaining by one when tick is called" do
    Kernel.stub(:sleep, nil) do
      original_time = @pomodoro.time_remaining
      @pomodoro.tick
      @pomodoro.time_remaining.must_equal original_time - 1
    end
  end

  it "asks the system clock to sleep for 1 second when tick is called" do
    clock = MiniTest::Mock.new
    clock.expect(:sleep, nil, [1])
    @pomodoro.system_clock = clock
    @pomodoro.tick
    clock.verify
  end

  it "notifies observers of the time remaining when tick is called" do
    Kernel.stub(:sleep, nil) do
      observer = MiniTest::Mock.new
      observer.expect(:update, nil, [1499])
      @pomodoro.add_observer(observer)
      @pomodoro.tick
      observer.verify
    end
  end

  it "should be finished when the time remaining is 0" do
    Pompom::Pomodoro.new(0).finished?.must_equal true
    Pompom::Pomodoro.new(-1).finished?.must_equal true
  end
end
