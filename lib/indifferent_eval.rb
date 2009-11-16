# file documentation

# module documentation
module IndifferentEval

  # method documentation
  def indifferent_eval object_to_eval_on = self, &block
    
    if block.arity == -1
      # no block variable, use instance_eval
      object_to_eval_on.instance_eval &block

    else  
      # we were passed a variable, so #call the block
      block.call object_to_eval_on
    end

  end

end

Object.send :include, IndifferentEval
