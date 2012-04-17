Indifferent Eval
================

When you're making a Ruby DSL, you often have to decide between:

```ruby
# Use a block variable to access the MyConfig instance.
# This gives you the benefit of having access to the outer "self" inside of the block.
MyApp.config do |config|
  config.verbosity true
  config.foo       :bar
end
```

and:

```ruby
# Don't pass a block variable.  All method calls are sent to the MyConfig instance.
# This has the benefit of looking really clean (but no access to "self" inside the block).
MyApp.config do
  verbosity true
  foo       :bar
end
```

There are a number of pros and cons to each of these approaches.

Wouldn't it be nice if you could support both?  That's what `#indifferent_eval` is for!

Install
-------

```ruby
# In your Gemfile
gem "indifferent_eval"
```

Usage
-----

```ruby
require "indifferent_eval"

class MyLibrary
  def self.config(&block)
    @config = MyConfig.new.indifferent_eval(&block)
  end

  class MyConfig
    attr_writer :some_setting

    def some_setting(value = nil)
      @some_setting = value if value
      @some_setting
    end
  end
end

# Use a block variable to access the MyConfig instance.
# This gives you the benefit of having access to the outer "self" inside of the block.
MyLibrary.config do |config|
  config.some_setting = "Called a method with a block variable"
end

# Don't pass a block variable.  All method calls are sent to the MyConfig instance.
# This has the benefit of looking really clean (but no access to "self" inside the block).
MyLibrary.config do
  some_setting "Called a method without a block variable"
end
```

## License

indifferent_eval is released under the MIT license.
