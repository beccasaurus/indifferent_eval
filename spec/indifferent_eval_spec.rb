require File.dirname(__FILE__) + '/../lib/indifferent_eval'
require 'rubygems'
require 'spec'

# sample configuration object
class SampleConfig
  attr_accessor :value
  def set_value(val) self.value = val end
end

# sample App class that has configuration
class App
  class << self; attr_accessor :config; end
  @config = SampleConfig.new

  def self.configure &block
    indifferent_eval self.config, &block
  end
end

# this one has built-in config variables and we'll call
# indifferent_eval without an argument, so it should 
# default to evaluating on self (the class)
class App2
  class << self; attr_accessor :value; end
  def self.set_value(val) self.value = val end
  
  def self.configure &block
    indifferent_eval &block
  end
end

describe 'indifferent_eval' do

  it 'should work with a block variable' do
    App.config.value = nil
    App2.value.should == nil

    App.configure do |config|
      config.set_value 'Hello'
    end

    App.config.value.should == 'Hello'
  end

  it 'should work without a block variable' do
    App.config.value = nil
    App2.value.should == nil

    App.configure do
      set_value 'Hello'
    end

    App.config.value.should == 'Hello'
  end

  it 'should have a good default (self) (should work with block variable)' do
    App2.value = nil
    App2.value.should == nil

    App2.configure do |c|
      c.set_value 'Hello'
    end
    App2.value.should == 'Hello'

    App2.configure do |c|
      c.value = 'There'
    end
    App2.value.should == 'There'
  end

  it 'should have a good default (self) (should work without block variable)' do
    App2.value = nil
    App2.value.should == nil

    App2.configure do
      set_value 'Hello'
    end
    App2.value.should == 'Hello'

    App2.configure do
      self.value = 'There'
    end
    App2.value.should == 'There'
  end

end
