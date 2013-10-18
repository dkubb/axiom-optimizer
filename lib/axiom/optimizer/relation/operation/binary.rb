# encoding: utf-8

module Axiom
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Binary relation optimizations
        class Binary < Optimizer
          include Function::Binary

          # Optimize when operands are equal
          module EqualOperands

            # Test if the operands are equal
            #
            # @return [Boolean]
            #
            # @todo do not materialize the operands to compare them
            #
            # @api private
            def optimizable?
              left.eql?(right)
            end

          end # module EqualOperands

          # Optimize when the left operand is Empty
          module EmptyLeft

            # Test if the left operand is empty
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.kind_of?(Axiom::Relation::Empty)
            end

          end # module EmptyLeft

          # Optimize when the right operand is Empty
          module EmptyRight

            # Test if the right operand is empty
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              right.kind_of?(Axiom::Relation::Empty)
            end

          end # module EmptyRight

          # Optimize when the left operand is an Sorted
          class SortedLeft < self

            # Test if the left operand is an Sorted
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.kind_of?(Axiom::Relation::Operation::Sorted)
            end

            # Drop the Sorted and wrap the left operand
            #
            # @return [Binary]
            #
            # @api private
            def optimize
              operation.class.new(left.operand, right)
            end

          end # class SortedLeft

          # Optimize when the right operand is an Sorted
          class SortedRight < self

            # Test if the right operand is an Sorted
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              right.kind_of?(Axiom::Relation::Operation::Sorted)
            end

            # Drop the Sorted and wrap the right operand
            #
            # @return [Binary]
            #
            # @api private
            def optimize
              operation.class.new(left, right.operand)
            end

          end # class SortedRight

          # Optimize when the operands are Materialized
          class MaterializedOperands < self

            # Test if the operands are materialized
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.kind_of?(Axiom::Relation::Materialized) &&
              right.kind_of?(Axiom::Relation::Materialized)
            end

            # Return the materialized operation
            #
            # @return [Relation::Materialized]
            #
            # @api private
            def optimize
              operation.materialize
            end

          end # class MaterializedOperand

          # Optimize when the operands are unoptimized
          class UnoptimizedOperands < self
            include Function::Binary::UnoptimizedOperands
          end # class UnoptimizedOperands
        end # class Binary
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Axiom
