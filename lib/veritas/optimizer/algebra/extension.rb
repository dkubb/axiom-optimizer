# encoding: utf-8

module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Extension optimizations
      class Extension < Relation::Operation::Unary

        # The optimized extensions
        #
        # @return [Hash{Attribute => Function}]
        #
        # @api private
        attr_reader :extensions

        # Initialize a Summarization optimizer
        #
        # @return [undefined]
        #
        # @api private
        def initialize(*)
          super
          @extensions = optimize_extensions
        end

      private

        # Optimize the extensions
        #
        # @return [Hash{Attribute => Function}]
        #
        # @api private
        def optimize_extensions
          Function.optimize_functions(operation.extensions)
        end

        # Wrap the operand's operand in an Extension
        #
        # @return [Extension]
        #
        # @api private
        def wrap_operand(operand = operand.operand)
          operand.extend do |context|
            extensions.each do |extension|
              context.add(*extension)
            end
          end
        end

        # Optimize when the operand is an Order
        class OrderOperand < self
          include Relation::Operation::Unary::OrderOperand
        end # class OrderOperand

        # Optimize when operands are optimizable
        class UnoptimizedOperand < self
          include Function::Unary::UnoptimizedOperand

          # Test if the operand is unoptimized
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            super || extensions_optimizable?
          end

          # Return an Extension with an optimized operand
          #
          # @return [Algebra::Extension]
          #
          # @api private
          def optimize
            wrap_operand(operand)
          end

        private

          # Test if the extensions are optimizable
          #
          # @return [Boolean]
          #
          # @api private
          def extensions_optimizable?
            ! extensions.eql?(operation.extensions)
          end

        end # class UnoptimizedOperand

        Veritas::Algebra::Extension.optimizer = chain(
          UnchangedHeader,
          MaterializedOperand,
          OrderOperand,
          UnoptimizedOperand
        )

      end # class Extension
    end # module Algebra
  end # class Optimizer
end # module Veritas
