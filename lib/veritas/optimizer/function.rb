# encoding: utf-8

module Veritas
  class Optimizer

    # Mixin for function optimizations
    module Function

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

      # Optimize the summarizers
      #
      # @param [Hash{Attribute => Function}]
      #
      # @return [Hash{Attribute => Function}]
      #
      # @api private
      def self.optimize_functions(functions)
        optimized = {}
        functions.each do |attribute, function|
          optimized[attribute] = optimize_operand(function)
        end
        optimized.freeze
      end

      # Utility methods for Function optimization
      module Util

        # Test if the operand is a constant
        #
        # @return [Boolean]
        #
        # @api private
        def self.constant?(operand)
          !operand.nil? && !operand.respond_to?(:call)
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
    end # module Function
  end # class Optimizer
end # module Veritas
