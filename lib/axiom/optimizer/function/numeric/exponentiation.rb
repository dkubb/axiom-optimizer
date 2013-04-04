# encoding: utf-8

module Axiom
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing Exponentiation optimizations
        class Exponentiation < self

          Axiom::Function::Numeric::Exponentiation.optimizer = chain(
            ConstantOperands,
            UnoptimizedOperands
          )

        end # class Exponentiation
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Axiom
