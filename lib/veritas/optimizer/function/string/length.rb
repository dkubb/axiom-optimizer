# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      module String

        # Abstract base class representing Length optimizations
        class Length < Optimizer

          # Optimize when the operand is constant
          class ConstantOperand < self
            include Unary::ConstantOperand
          end # class ConstantOperand

          Veritas::Function::String::Length.optimizer = chain(
            ConstantOperand
          )

        end # class Length
      end # module String
    end # module Function
  end # class Optimizer
end # module Veritas
