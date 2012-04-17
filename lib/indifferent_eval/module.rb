module IndifferentEval
  def indifferent_eval(object_to_eval_on = self, &block)
    if block.arity == 0 || block.arity == -1 # Blocks with no arguments return -1 in Ruby 1.8 but 0 in Ruby 1.9.
      object_to_eval_on.instance_eval &block # No block variable, use instance_eval.
    else  
      block.call object_to_eval_on # We were passed a variable, so #call the block.
    end
  end
end
