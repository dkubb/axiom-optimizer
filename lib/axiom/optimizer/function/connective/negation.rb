# encoding: utf-8

module Axiom
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

            # A Negation with constant values is equivalent to a Proposition
            #
            # @return [Proposition]
            #
            # @api private
            def optimize
              Axiom::Function::Proposition.new(super)
            end

          end # class ConstantOperand

          # Optimize when the operand is unoptimized
          class UnoptimizedOperand < self
            include Function::Unary::UnoptimizedOperand
          end # class UnoptimizedOperand

          Axiom::Function::Connective::Negation.optimizer = chain(
            ConstantOperand,
            InvertibleOperand,
            UnoptimizedOperand
          )

        end # class Negation
      end # module Connective
    end # module Function
  end # class Optimizer
end # module Axiom
