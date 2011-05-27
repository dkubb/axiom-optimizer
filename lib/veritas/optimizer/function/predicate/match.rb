# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Predicate

        # Abstract base class representing Match optimizations
        class Match < self

          Veritas::Function::Predicate::Match.optimizer = chain(
            ConstantOperands,
            UnoptimizedOperands
          )

        end # class Match
      end # class Predicate
    end # module Function
  end # class Optimizer
end # module Veritas
