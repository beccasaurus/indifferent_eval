IndifferentEval
===============

When you're making a Ruby DSL, you often have to decide between:

    MyApp.config do |config|
      config.verbosity = true
      config.foo       = :bar
    end

and:

    MyApp.config do
      verbosity = true
      foo       = :bar
    end

Wouldn't it be nice if you could support both?  That's what IndifferentEval is for!

Install
-------

    gem install indifferent_eval

Usage
-----

    class MyWhatever
      def self.config &block
        indifferent_eval &block
      end

      def self.method_missing name, *args, &block
        puts "called #{self}.#{name}(#{args.inspect})"
      end
    end

    >> MyWhatever.config {|x| x.foo 'bar' }
    called MyWhatever.foo(["bar"])

    >> MyWhatever.config { foo 'bar' }
    called MyWhatever.foo(["bar"])

That's it.
