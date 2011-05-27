# encoding: utf-8

module Veritas
  class Optimizer
    class Aggregate

      # Abstract base class representing Mean optimizations
      class Mean < self

        Veritas::Aggregate::Mean.optimizer = chain(
          UnoptimizedOperand
        )

      end # class Mean
    end # class Aggregate
  end # class Optimizer
end # module Veritas
