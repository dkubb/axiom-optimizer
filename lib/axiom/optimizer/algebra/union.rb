# encoding: utf-8

module Axiom
  class Optimizer
    module Algebra

      # Abstract base class representing Union optimizations
      class Union < Relation::Operation::Binary

        # Optimize when operands are equal
        class EqualOperands < self
          include Relation::Operation::Binary::EqualOperands

          # A Union with equal operands is a noop
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

          # A Union with an empty left operand is equivalent to the right
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            right
          end

        end # class EmptyLeft

        # Optimize when the right operand is empty
        class EmptyRight < self
          include Relation::Operation::Binary::EmptyRight

          # A Union with an empty right operand is equivalent to the left
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            left
          end

        end # class EmptyRight

        Axiom::Algebra::Union.optimizer = chain(
          EqualOperands,
          EmptyRight,
          EmptyLeft,
          SortedLeft,
          SortedRight,
          MaterializedOperands,
          UnoptimizedOperands
        )

      end # class Union
    end # module Algebra
  end # class Optimizer
end # module Axiom
