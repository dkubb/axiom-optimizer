# encoding: utf-8

module Axiom
  class Optimizer
    class Aggregate

      # Abstract base class representing StandardDeviation optimizations
      class StandardDeviation < self

        Axiom::Aggregate::StandardDeviation.optimizer = chain(
          UnoptimizedOperand
        )

      end # class StandardDeviation
    end # class Aggregate
  end # class Optimizer
end # module Axiom
