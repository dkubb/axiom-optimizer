# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing Addition optimizations
        class Addition < self

          Veritas::Function::Numeric::Addition.optimizer = chain(
            ConstantOperands
          )

        end # class Addition
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Veritas
