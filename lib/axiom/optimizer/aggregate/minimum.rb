# encoding: utf-8

module Axiom
  class Optimizer
    class Aggregate

      # Abstract base class representing Minimum optimizations
      class Minimum < self

        Axiom::Aggregate::Minimum.optimizer = chain(
          UnoptimizedOperand
        )

      end # class Minimum
    end # class Aggregate
  end # class Optimizer
end # module Axiom
