# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      module Connective

        # Abstract base class representing Negation optimizations
        class Negation < Optimizer

          # The optimized operand
          #
          # @return [Function]
          #
          # @api private
          attr_reader :operand

          # Initialize a Unary optimizer
          #
          # @return [undefined]
          #
          # @api private
          def initialize(*)
            super
            @operand = optimize_operand
          end

        private

          # Optimize the operand
          #
          # @return [Function]
          #
          # @api private
          def optimize_operand
            Function::Binary.optimize_operand(operation.operand)
          end

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

          Veritas::Function::Connective::Negation.optimizer = chain(
            InvertibleOperand
          )

        end # class Negation
      end # module Connective
    end # module Function
  end # class Optimizer
end # module Veritas
