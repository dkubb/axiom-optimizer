# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing UnaryPlus optimizations
        class UnaryPlus < self

          Veritas::Function::Numeric::UnaryPlus.optimizer = chain(
            ConstantOperand,
            UnoptimizedOperand
          )

        end # class UnaryPlus
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Veritas
