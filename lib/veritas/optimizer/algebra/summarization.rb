# encoding: utf-8

module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Summarization optimizations
      class Summarization < Relation::Operation::Unary

        # The optimized summarize_per relation
        #
        # @return [Relation]
        #
        # @api private
        attr_reader :summarize_per

        # Initialize a Summarization optimizer
        #
        # @return [undefined]
        #
        # @api private
        def initialize(*)
          super
          @summarize_per = optimize_summarize_per
        end

      private

        # Optimize the summarize per relation
        #
        # @return [Relation]
        #
        # @api private
        def optimize_summarize_per
          operation.summarize_per.optimize
        end

        # Optimize when operand is optimizable
        class UnoptimizedOperand < self

          # Test if the operand is unoptimized
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            !operand.equal?(operation.operand) ||
            !summarize_per.equal?(operation.summarize_per)
          end

          # Return a Summarization with an optimized operand
          #
          # @return [Rename]
          #
          # @api private
          def optimize
            operation = self.operation
            operation.class.new(operand, summarize_per, operation.summarizers)
          end

        end # class UnoptimizedOperand

        Veritas::Algebra::Summarization.optimizer = chain(
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Summarization
    end # module Algebra
  end # class Optimizer
end # module Veritas
