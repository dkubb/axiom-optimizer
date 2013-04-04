# encoding: utf-8

module Axiom
  class Optimizer
    module Algebra

      # Abstract base class representing Difference optimizations
      class Difference < Relation::Operation::Binary

        # Optimize when operands are equal
        class EqualOperands < self
          include Relation::Operation::Binary::EqualOperands

          # A Difference with equal operands is empty
          #
          # @return [Relation::Empty]
          #
          # @api private
          def optimize
            Axiom::Relation::Empty.new(operation.header, operation)
          end

        end # class EqualOperands

        # Optimize when the left operand is empty
        class EmptyLeft < self
          include Relation::Operation::Binary::EmptyLeft

          # A Difference with an empty left operand is empty
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

          # A Difference with an empty right operand is equivalent to the left
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            left
          end

        end # class EmptyRight

        Axiom::Algebra::Difference.optimizer = chain(
          EqualOperands,
          EmptyLeft,
          EmptyRight,
          OrderLeft,
          OrderRight,
          MaterializedOperands,
          UnoptimizedOperands
        )

      end # class Difference
    end # module Algebra
  end # class Optimizer
end # module Axiom
