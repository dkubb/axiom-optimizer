# encoding: utf-8

module Axiom
  class Optimizer
    module Function
      module String

        # Abstract base class representing Length optimizations
        class Length < Optimizer
          include Unary

          # Optimize when the operand is constant
          class ConstantOperand < self
            include Unary::ConstantOperand
          end # class ConstantOperand

          # Optimize when the operand is unoptimized
          class UnoptimizedOperand < self
            include Unary::UnoptimizedOperand
          end # class UnoptimizedOperand

          Axiom::Function::String::Length.optimizer = chain(
            ConstantOperand,
            UnoptimizedOperand
          )

        end # class Length
      end # module String
    end # module Function
  end # class Optimizer
end # module Axiom
