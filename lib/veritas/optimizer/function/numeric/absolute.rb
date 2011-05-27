# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing Absolute optimizations
        class Absolute < self

          Veritas::Function::Numeric::Absolute.optimizer = chain(
            ConstantOperand
          )

        end # class Absolute
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Veritas
