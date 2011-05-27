# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing Division optimizations
        class Division < self

          Veritas::Function::Numeric::Division.optimizer = chain(
            ConstantOperands
          )

        end # class Division
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Veritas
