# encoding: utf-8

module Veritas
  class Optimizer
    module Function

      # Abstract base class representing Numeric optimizations
      class Numeric < Optimizer
        include AbstractClass

        # Optimize when the operand is constant
        class ConstantOperand < self
          include Unary::ConstantOperand
        end # class ConstantOperand

        # Optimize when the operands are constants
        class ConstantOperands < self
          include Binary::ConstantOperands
        end # class ConstantOperands
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Veritas
