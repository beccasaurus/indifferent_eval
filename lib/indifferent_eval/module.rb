module IndifferentEval

  def indifferent_eval(object_to_eval_on = self, &block)

    # Blocks with no arguments return -1 in Ruby 1.8 and 0 in Ruby 1.9

    if block.arity == 0 || block.arity == -1
      # no block variable, use instance_eval
      object_to_eval_on.instance_eval &block

    else  
      # we were passed a variable, so #call the block
      block.call object_to_eval_on
    end

  end

end
