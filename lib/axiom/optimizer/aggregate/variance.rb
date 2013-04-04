# encoding: utf-8

module Axiom
  class Optimizer
    class Aggregate

      # Abstract base class representing Variance optimizations
      class Variance < self

        Axiom::Aggregate::Variance.optimizer = chain(
          UnoptimizedOperand
        )

      end # class Variance
    end # class Aggregate
  end # class Optimizer
end # module Axiom
