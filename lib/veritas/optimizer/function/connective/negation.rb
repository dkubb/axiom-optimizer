# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      module Connective

        # Abstract base class representing Negation optimizations
        class Negation < Optimizer
          include Unary

          # Optimize when the operand can be inverted
          class InvertibleOperand < self

            # Test if the operand can be inverted
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.respond_to?(:inverse)
            end

            # A Negation of an Function is equivalent to the inverted Function
            #
            # @return [Function]
            #
            # @api private
            def optimize
              operand.inverse
            end

          end # class InvertibleOperand

          # Optimize when the operand is constant
          class ConstantOperand < self
            include Unary::ConstantOperand
          end # class ConstantOperand

          Veritas::Function::Connective::Negation.optimizer = chain(
            ConstantOperand,
            InvertibleOperand
          )

        end # class Negation
      end # module Connective
    end # module Function
  end # class Optimizer
end # module Veritas
