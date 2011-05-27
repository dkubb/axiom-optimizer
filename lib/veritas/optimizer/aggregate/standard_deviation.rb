# encoding: utf-8

module Veritas
  class Optimizer
    class Aggregate

      # Abstract base class representing StandardDeviation optimizations
      class StandardDeviation < self

        Veritas::Aggregate::StandardDeviation.optimizer = chain(
          UnoptimizedOperand
        )

      end # class StandardDeviation
    end # class Aggregate
  end # class Optimizer
end # module Veritas
