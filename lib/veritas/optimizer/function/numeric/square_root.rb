# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing SquareRoot optimizations
        class SquareRoot < self

          Veritas::Function::Numeric::SquareRoot.optimizer = chain(
            ConstantOperand,
            UnoptimizedOperand
          )

        end # class SquareRoot
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Veritas
