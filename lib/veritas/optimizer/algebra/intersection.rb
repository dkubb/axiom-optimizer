# encoding: utf-8

module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Intersection optimizations
      class Intersection < Relation::Operation::Binary

        # Optimize when operands are equal
        class EqualOperands < self
          include Relation::Operation::Binary::EqualOperands

          # An Intersection with equal operands is equivalent to either operand
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            left
          end

        end # class EqualOperands

        # Optimize when the left operand is empty
        class EmptyLeft < self
          include Relation::Operation::Binary::EmptyLeft

          # An Intersection with an empty left operand is empty
          #
          # @return [Relation::Empty]
          #
          # @api private
          def optimize
            left
          end

        end # class EmptyLeft

        # Optimize when the right operand is empty
        class EmptyRight < self
          include Relation::Operation::Binary::EmptyRight

          # An Intersection with an empty right operand is empty
          #
          # @return [Relation::Empty]
          #
          # @api private
          def optimize
            right
          end

        end # class EmptyRight

        Veritas::Algebra::Intersection.optimizer = chain(
          EqualOperands,
          EmptyLeft,
          EmptyRight,
          LeftOrderOperand,
          RightOrderOperand,
          MaterializedOperand,
          UnoptimizedOperands
        )

      end # class Intersection
    end # module Algebra
  end # class Optimizer
end # module Veritas
