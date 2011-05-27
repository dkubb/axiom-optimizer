# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing Multiplication optimizations
        class Multiplication < self

          Veritas::Function::Numeric::Multiplication.optimizer = chain(
            ConstantOperands,
            UnoptimizedOperands
          )

        end # class Multiplication
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Veritas
