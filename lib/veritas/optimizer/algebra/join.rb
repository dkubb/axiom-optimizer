# encoding: utf-8

module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Join optimizations
      class Join < Relation::Operation::Combination

        # Optimize when operands' headers are equal
        class EqualHeaders < self

          # Test if the operands' headers are equal to the join's headers
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            left.header.eql?(right.header)
          end

          # A Join with an equal header is an Intersection
          #
          # @return [Algebra::Intersection]
          #
          # @api private
          def optimize
            Veritas::Algebra::Intersection.new(left, right)
          end

        end # class EqualHeaders

        Veritas::Algebra::Join.optimizer = chain(
          EmptyLeft,
          EmptyRight,
          EqualHeaders,
          LeftOrderOperand,
          RightOrderOperand,
          MaterializedOperands,
          UnoptimizedOperands
        )

      end # class Join
    end # module Algebra
  end # class Optimizer
end # module Veritas
