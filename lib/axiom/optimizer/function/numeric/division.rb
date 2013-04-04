# encoding: utf-8

module Axiom
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing Division optimizations
        class Division < self

          Axiom::Function::Numeric::Division.optimizer = chain(
            ConstantOperands,
            UnoptimizedOperands
          )

        end # class Division
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Axiom
