# encoding: utf-8

module Veritas
  class Optimizer
    module Function

      # Mixin for optimizations to binary functions
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

        end # module ConstantOperands

        # Utility methods for Predicate optimization
        module Util

          # Test if the operand is a constant
          #
          # @return [Boolean]
          #
          # @api private
          def self.constant?(operand)
            !operand.respond_to?(:call)
          end

          # Test if the operand is an attribute
          #
          # @return [Boolean]
          #
          # @api private
          def self.attribute?(operand)
            operand.kind_of?(Attribute)
          end

          # Return the minimum value for the operand
          #
          # @return [Object]
          #
          # @api private
          def self.min(operand)
            case operand
              when Attribute::String  then operand.min_length
              when Attribute::Numeric then operand.range.first
            else
              operand
            end
          end

          # Return the maximum value for the operand
          #
          # @return [Object]
          #
          # @api private
          def self.max(operand)
            case operand
              when Attribute::String  then operand.max_length
              when Attribute::Numeric then operand.range.last
            else
              operand
            end
          end

        end # module Util
      end # class Binary
    end # module Function
  end # class Optimizer
end # module Veritas
