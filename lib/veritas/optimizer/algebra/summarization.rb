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

        # The optimized summarizers
        #
        # @return [Hash]
        #
        # @api private
        attr_reader :summarizers

        # Initialize a Summarization optimizer
        #
        # @return [undefined]
        #
        # @api private
        def initialize(*)
          super
          @summarize_per = optimize_summarize_per
          @summarizers   = optimize_summarizers
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

        # Optimize the summarizers
        #
        # @return [Hash]
        #
        # @api private
        def optimize_summarizers
          summarizers = {}
          operation.summarizers.each do |attribute, function|
            summarizers[attribute] = Function.optimize_operand(function)
          end
          summarizers.eql?(operation.summarizers) ? operation.summarizers : summarizers
        end

        # Optimize when the operand is Empty
        class EmptyOperand < self

          # Return the default value for a function
          #
          # @param [Object] function
          #
          # @return [Object]
          #
          # @api private
          def self.extension_default(function)
            if function.respond_to?(:default)
              function.finalize(function.default)
            end
          end

          # Test if the operand is empty
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Empty)
          end

          # Return an extended relation with the same headers
          #
          # @return [Extension]
          #
          # @api private
          def optimize
            Veritas::Algebra::Extension.new(summarize_per, extensions)
          end

        private

          # Return the extensions for the optimized relation
          #
          # @return [Hash{Attribute => #call}]
          #
          # @api private
          def extensions
            extensions = {}
            operation.summarizers.each do |attribute, function|
              extensions[attribute] = self.class.extension_default(function)
            end
            extensions
          end

        end # class EmptyOperand

        # Optimize when the summarize_per is empty
        class EmptySummarizePer < self

          # Test if summarize_per is empty
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            summarize_per.kind_of?(Veritas::Relation::Empty)
          end

          # Return an empty relation if there is nothing to summarize over
          #
          # @return [Relation::Empty]
          #
          # @api private
          def optimize
            Veritas::Relation::Empty.new(operation.header)
          end

        end # class EmptySummarizePer

        # Optimize when operand is optimizable
        class UnoptimizedOperand < self
          include Function::Unary::UnoptimizedOperand

          # Test if the operand is unoptimized
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            super                      ||
            summarize_per_optimizable? ||
            summarizers_optimizable?
          end

          # Return a Summarization with an optimized operand
          #
          # @return [Rename]
          #
          # @api private
          def optimize
            operation = self.operation
            operation.class.new(operand, summarize_per, summarizers)
          end

        private

          # Test if the summarize_per relation is optimizable
          #
          # @return [Boolean]
          #
          # @api private
          def summarize_per_optimizable?
            !summarize_per.equal?(operation.summarize_per)
          end

          # Test if the summarizers are optimizable
          #
          # @return [Boolean]
          #
          # @api private
          def summarizers_optimizable?
            !summarizers.equal?(operation.summarizers)
          end

        end # class UnoptimizedOperand

        Veritas::Algebra::Summarization.optimizer = chain(
          EmptyOperand,
          EmptySummarizePer,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Summarization
    end # module Algebra
  end # class Optimizer
end # module Veritas
