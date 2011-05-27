# encoding: utf-8

module Veritas
  class Optimizer
    class Aggregate

      # Abstract base class representing Count optimizations
      class Count < self

        Veritas::Aggregate::Count.optimizer = chain(
          UnoptimizedOperand
        )

      end # class Count
    end # class Aggregate
  end # class Optimizer
end # module Veritas
