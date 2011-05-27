# encoding: utf-8

module Veritas
  class Optimizer
    module Function

      # Mixin for optimizations to Unary functions
      module Unary

        # The optimized operand
        #
        # @return [Relation]
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
        # @return [Relation]
        #
        # @api private
        def optimize_operand
          Binary.optimize_operand(operation.operand)
        end

        # Optimize when the operand is constant
        module ConstantOperand

          # Test if the operand is constant
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            Util.constant?(operand)
          end

          # Evaluate the operand and return the constant
          #
          # @return [Object]
          #
          # @api private
          def optimize
            operation.class.call(operand)
          end

        end # module ConstantOperand
      end # class Unary
    end # module Function
  end # class Optimizer
end # module Veritas
