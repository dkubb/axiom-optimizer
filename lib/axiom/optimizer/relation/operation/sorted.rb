# encoding: utf-8

module Axiom
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Sorted optimizations
        class Sorted < Unary

          # Optimize when the operand is an Sorted
          class SortedOperand < self

            # Test if the operand is an Sorted
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(operation.class)
            end

            # Flatten Sorted operations using the operation directions
            #
            # @return [Sorted]
            #
            # @api private
            def optimize
              operand.operand.sort_by(operation.directions)
            end

          end # class SortedOperand

          # Optimize when the operand is a Limit with a limit of 1
          class OneLimitOperand < self

            # Test if the operand is an Limit with a limit of 1
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(Axiom::Relation::Operation::Limit) &&
              operand.limit == 1
            end

            # An Sorted of a Limit with a limit of 1 is a noop
            #
            # @return [Limit]
            #
            # @api private
            def optimize
              operand
            end

          end # class OneLimitOperand

          # Optimize when operand is optimizable
          class UnoptimizedOperand < self
            include Function::Unary::UnoptimizedOperand

            # Return an Sorted with an optimized operand
            #
            # @return [Offset]
            #
            # @api private
            def optimize
              operand.sort_by(operation.directions)
            end

          end # class UnoptimizedOperand

          Axiom::Relation::Operation::Sorted.optimizer = chain(
            SortedOperand,
            OneLimitOperand,
            EmptyOperand,
            MaterializedOperand,
            UnoptimizedOperand
          )

        end # class Sorted
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Axiom
