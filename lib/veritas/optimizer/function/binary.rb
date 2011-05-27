# encoding: utf-8

module Veritas
  class Optimizer
    module Function

      # Mixin for optimizations to Binary functions
      module Binary

        # The optimized left operand
        #
        # @return [Object]
        #
        # @api private
        attr_reader :left

        # The optimized right operand
        #
        # @return [Object]
        #
        # @api private
        attr_reader :right

        # Initialize an Predicate optimizer
        #
        # @return [undefined]
        #
        # @api private
        def initialize(*)
          super
          @left  = optimize_left
          @right = optimize_right
        end

      private

        # Optimize the left operand
        #
        # @return [Object]
        #
        # @api private
        def optimize_left
          Binary.optimize_operand(operation.left)
        end

        # Optimize the right operand
        #
        # @return [Object]
        #
        # @api private
        def optimize_right
          Binary.optimize_operand(operation.right)
        end

        # Optimize the operand if possible
        #
        # @param [#optimize, Object] operand
        #
        # @return [Object]
        #
        # @todo this does not belong in this module
        #
        # @api private
        def self.optimize_operand(operand)
          operand.respond_to?(:optimize) ? operand.optimize : operand
        end

        # Optimize when the operands are constants
        module ConstantOperands

          # Test if the operands are constants
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            util = Util
            util.constant?(left) && util.constant?(right)
          end

          # Evaluate the operands and return the constant
          #
          # @return [Object]
          #
          # @api private
          def optimize
            operation.class.call(left, right)
          end

        end # module ConstantOperands
      end # class Binary
    end # module Function
  end # class Optimizer
end # module Veritas
