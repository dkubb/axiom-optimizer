# encoding: utf-8

module Axiom
  class Optimizer
    class Aggregate

      # Abstract base class representing Sum optimizations
      class Sum < self

        Axiom::Aggregate::Sum.optimizer = chain(
          UnoptimizedOperand
        )

      end # class Sum
    end # class Aggregate
  end # class Optimizer
end # module Axiom
