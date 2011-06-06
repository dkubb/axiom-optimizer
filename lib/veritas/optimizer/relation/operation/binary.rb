# encoding: utf-8

module Veritas
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
              left.kind_of?(Veritas::Relation::Empty)
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
              right.kind_of?(Veritas::Relation::Empty)
            end

          end # module EmptyRight

          # Optimize when the left operand is an Order
          class LeftOrderOperand < self

            # Test if the left operand is an Order
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.kind_of?(Veritas::Relation::Operation::Order)
            end

            # Drop the Order and wrap the left operand
            #
            # @return [Binary]
            #
            # @api private
            def optimize
              operation.class.new(left.operand, right)
            end

          end # class LeftOrderOperand

          # Optimize when the right operand is an Order
          class RightOrderOperand < self

            # Test if the right operand is an Order
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              right.kind_of?(Veritas::Relation::Operation::Order)
            end

            # Drop the Order and wrap the right operand
            #
            # @return [Binary]
            #
            # @api private
            def optimize
              operation.class.new(left, right.operand)
            end

          end # class RightOrderOperand

          # Optimize when the operands are Materialized
          class MaterializedOperands < self

            # Test if the operands are materialized
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.kind_of?(Veritas::Relation::Materialized) &&
              right.kind_of?(Veritas::Relation::Materialized)
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
end # module Veritas
