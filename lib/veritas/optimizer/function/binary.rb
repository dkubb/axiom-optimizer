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
          Function.optimize_operand(operation.left)
        end

        # Optimize the right operand
        #
        # @return [Object]
        #
        # @api private
        def optimize_right
          Function.optimize_operand(operation.right)
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

        # Optimize when the operand is unoptimized
        module UnoptimizedOperands

          # Test if the operands are unoptimized
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            left_optimizable? || right_optimizable?
          end

          # Return a Binary connective with optimized operands
          #
          # @return [Binary]
          #
          # @api private
          def optimize
            operation.class.new(left, right)
          end

        private

          # Test if the left operand is optimizable
          #
          # @return [Boolean]
          #
          # @api private
          def left_optimizable?
            ! left.equal?(operation.left)
          end

          # Test if the right operand is optimizable
          #
          # @return [Boolean]
          #
          # @api private
          def right_optimizable?
            ! right.equal?(operation.right)
          end

        end # module UnoptimizedOperands
      end # class Binary
    end # module Function
  end # class Optimizer
end # module Veritas
