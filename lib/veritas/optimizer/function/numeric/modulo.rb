# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing Modulo optimizations
        class Modulo < self

          Veritas::Function::Numeric::Modulo.optimizer = chain(
            ConstantOperands
          )

        end # class Modulo
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Veritas
