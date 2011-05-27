# encoding: utf-8

module Veritas
  class Optimizer
    class Aggregate

      # Abstract base class representing Variance optimizations
      class Variance < self

        Veritas::Aggregate::Variance.optimizer = chain(
          UnoptimizedOperand
        )

      end # class Variance
    end # class Aggregate
  end # class Optimizer
end # module Veritas
