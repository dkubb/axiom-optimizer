# encoding: utf-8

module Veritas
  class Optimizer
    module Function

      # Abstract base class representing Predicate optimizations
      class Predicate < Optimizer

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
          self.class.optimize_operand(operation.left)
        end

        # Optimize the right operand
        #
        # @return [Object]
        #
        # @api private
        def optimize_right
          self.class.optimize_operand(operation.right)
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
        class ConstantOperands < self

          # Test if the operands are constants
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            util = Util
            util.constant?(left) && util.constant?(right)
          end

          # A Predicate with constant values is equivalent to a Proposition
          #
          # @return [Proposition]
          #
          # @api private
          def optimize
            Veritas::Function::Proposition.new(operation.class.call(left, right))
          end

        end # class ConstantOperands

        # Optimize when the operands are a contradiction
        module Contradiction

          # Return a contradiction
          #
          # @return [Contradiction]
          #
          # @api private
          def optimize
            Veritas::Function::Proposition::Contradiction.instance
          end

        end # module Contradiction

        # Optimize when the operands are a tautology
        module Tautology

          # Return a tautology
          #
          # @return [Tautology]
          #
          # @api private
          def optimize
            Veritas::Function::Proposition::Tautology.instance
          end

        end # module Tautology

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
      end # class Predicate
    end # module Function
  end # class Optimizer
end # module Veritas
