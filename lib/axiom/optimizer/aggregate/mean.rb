# encoding: utf-8

module Axiom
  class Optimizer
    class Aggregate

      # Abstract base class representing Mean optimizations
      class Mean < self

        Axiom::Aggregate::Mean.optimizer = chain(
          UnoptimizedOperand
        )

      end # class Mean
    end # class Aggregate
  end # class Optimizer
end # module Axiom
