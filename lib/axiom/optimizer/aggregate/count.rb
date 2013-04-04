# encoding: utf-8

module Axiom
  class Optimizer
    class Aggregate

      # Abstract base class representing Count optimizations
      class Count < self

        Axiom::Aggregate::Count.optimizer = chain(
          UnoptimizedOperand
        )

      end # class Count
    end # class Aggregate
  end # class Optimizer
end # module Axiom
