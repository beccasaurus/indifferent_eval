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

The Code
--------

The code is tiny.  This gem exists only for convenience.

```ruby
module IndifferentEval
  def indifferent_eval(object_to_eval_on = self, &block)
    if block.arity == 0 || block.arity == -1
      object_to_eval_on.instance_eval &block
    else  
      block.call object_to_eval_on
    end
  end
end
```  

([Annotated source code](https://github.com/remi/indifferent_eval/blob/master/lib/indifferent_eval/module.rb))

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

## But I don't want every Ruby object to be extended with this!

If you don't want to include IndifferentEval into all Ruby `Object`s, you don't have to.

```ruby
# This simply requires the IndifferentEval module without 
# automatically icluding the module into any classes.
require "indifferent_eval/module"
```

If you only want to "indifferent_eval" certain types of objects:

```ruby
class Configuration
  include IndifferentEval
end

Configuration.new.indifferent_eval(&block)
```

If you want to call #indifferent_eval on different objects from 1 class in particular, 
indifferent takes an argument for the object to evaluate, so you can use it like this:

```ruby
class MyClass
  include IndifferentEval

  def do_something
    indifferent_eval some_object, &some_block
    indifferent_eval another_object, &another_block
  end
end
```

Nothing magical  :)

## License

indifferent_eval is released under the MIT license.
