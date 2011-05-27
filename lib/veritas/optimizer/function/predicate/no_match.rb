# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Predicate

        # Abstract base class representing NoMatch optimizations
        class NoMatch < self

          Veritas::Function::Predicate::NoMatch.optimizer = chain(
            ConstantOperands,
            UnoptimizedOperands
          )

        end # class NoMatch
      end # class Predicate
    end # module Function
  end # class Optimizer
end # module Veritas
