module IndifferentEval
  begin
    old, $VERBOSE = $VERBOSE, nil
    VERSION = "0.2.0"
  ensure
    $VERBOSE = old
  end
end
