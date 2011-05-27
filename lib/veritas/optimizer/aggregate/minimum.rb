# encoding: utf-8

module Veritas
  class Optimizer
    class Aggregate

      # Abstract base class representing Minimum optimizations
      class Minimum < self

        Veritas::Aggregate::Minimum.optimizer = chain(
          UnoptimizedOperand
        )

      end # class Minimum
    end # class Aggregate
  end # class Optimizer
end # module Veritas
