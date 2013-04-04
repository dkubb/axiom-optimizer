# encoding: utf-8

module Axiom
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing SquareRoot optimizations
        class SquareRoot < self

          Axiom::Function::Numeric::SquareRoot.optimizer = chain(
            ConstantOperand,
            UnoptimizedOperand
          )

        end # class SquareRoot
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Axiom
