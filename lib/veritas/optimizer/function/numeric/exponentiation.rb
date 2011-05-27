# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing Exponentiation optimizations
        class Exponentiation < self

          Veritas::Function::Numeric::Exponentiation.optimizer = chain(
            ConstantOperands
          )

        end # class Exponentiation
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Veritas
