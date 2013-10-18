# encoding: utf-8

module Axiom
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Reverse optimizations
        class Reverse < Sorted

          # Optimize when the operand is a Reverse
          class ReverseOperand < self

            # Test if the operand is a Reverse
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(operation.class)
            end

            # A Reverse of a Reverse is a noop
            #
            # @return [Relation]
            #
            # @api private
            def optimize
              operand.operand
            end

          end # class ReverseOperand

          # Optimize when the operand is an Sorted
          class SortedOperand < self

            # Test if the operand is an Sorted
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(Axiom::Relation::Operation::Sorted)
            end

            # Flatten Reverse operation and Sorted operand into an Sorted
            #
            # @return [Sorted]
            #
            # @api private
            def optimize
              operand.operand.sort_by { operation.directions }
            end

          end # class SortedOperand

          # Optimize when operand is optimizable
          class UnoptimizedOperand < self
            include Function::Unary::UnoptimizedOperand

            # Return an Reverse with an optimized operand
            #
            # @return [Reverse]
            #
            # @api private
            def optimize
              operand.reverse
            end

          end # class UnoptimizedOperand

          Axiom::Relation::Operation::Reverse.optimizer = chain(
            ReverseOperand,
            SortedOperand,
            OneLimitOperand,
            EmptyOperand,
            MaterializedOperand,
            UnoptimizedOperand
          )

        end # class Reverse
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Axiom
