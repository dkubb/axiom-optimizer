# encoding: utf-8

module Veritas
  class Optimizer
    class Aggregate

      # Abstract base class representing Maximum optimizations
      class Maximum < self

        Veritas::Aggregate::Maximum.optimizer = chain(
          UnoptimizedOperand
        )

      end # class Maximum
    end # class Aggregate
  end # class Optimizer
end # module Veritas
