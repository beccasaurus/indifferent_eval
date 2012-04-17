# Run via: bundle exec rake sample
require "indifferent_eval"

class MyLibrary
  def self.config(&block)
    @config = MyConfig.new.indifferent_eval(&block) if block
    @config
  end

  class MyConfig
    attr_writer :some_setting

    def some_setting(value = nil)
      @some_setting = value if value
      @some_setting
    end
  end
end

puts MyLibrary.config.inspect

MyLibrary.config do |config|
  config.some_setting = "Called a method with a block variable"
end

puts MyLibrary.config.inspect

MyLibrary.config do
  some_setting "Called a method without a block variable"
end

puts MyLibrary.config.inspect
