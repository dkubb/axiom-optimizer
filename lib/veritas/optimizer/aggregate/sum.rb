# encoding: utf-8

module Veritas
  class Optimizer
    class Aggregate

      # Abstract base class representing Sum optimizations
      class Sum < self

        Veritas::Aggregate::Sum.optimizer = chain(
          UnoptimizedOperand
        )

      end # class Sum
    end # class Aggregate
  end # class Optimizer
end # module Veritas
