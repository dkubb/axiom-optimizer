# encoding: utf-8

module Axiom
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
        # @return [Hash{Attribute => Function}]
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
        # @return [Hash{Attribute => Function}]
        #
        # @api private
        def optimize_summarizers
          Function.optimize_functions(operation.summarizers)
        end

        # Wrap the operand's operand in a Summarization
        #
        # @return [Summarization]
        #
        # @api private
        def wrap_operand(operand = operand.operand)
          operand.summarize(summarize_per, summarizers)
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
            operand.kind_of?(Axiom::Relation::Empty)
          end

          # Return an extended relation with the same headers
          #
          # @return [Extension]
          #
          # @api private
          def optimize
            summarize_per.extend(extensions)
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
            summarize_per.kind_of?(Axiom::Relation::Empty)
          end

          # Return an empty relation if there is nothing to summarize over
          #
          # @return [Relation::Empty]
          #
          # @api private
          def optimize
            Axiom::Relation::Empty.new(operation.header, operation)
          end

        end # class EmptySummarizePer

        # Optimize when the operand is an Order
        class OrderOperand < self
          include Relation::Operation::Unary::OrderOperand
        end # class OrderOperand

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
            wrap_operand(operand)
          end

        private

          # Test if the summarize_per relation is optimizable
          #
          # @return [Boolean]
          #
          # @api private
          def summarize_per_optimizable?
            ! summarize_per.equal?(operation.summarize_per)
          end

          # Test if the summarizers are optimizable
          #
          # @return [Boolean]
          #
          # @api private
          def summarizers_optimizable?
            ! summarizers.eql?(operation.summarizers)
          end

        end # class UnoptimizedOperand

        Axiom::Algebra::Summarization.optimizer = chain(
          EmptyOperand,
          EmptySummarizePer,
          OrderOperand,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Summarization
    end # module Algebra
  end # class Optimizer
end # module Axiom
