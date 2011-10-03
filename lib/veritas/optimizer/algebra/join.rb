# encoding: utf-8

module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Join optimizations
      class Join < Relation::Operation::Combination

        CONTRADICTION = Veritas::Function::Proposition::Contradiction.instance

      private

        # Return the key to join the operations with
        #
        # @return [Header]
        #
        # @todo find a minimal key from the header
        #
        # @api private
        def join_key
          operation.join_header
        end

        # Return a predicate that matches every tuple in the materialized operand
        #
        # @return [Function]
        #
        # @api private
        def materialized_predicate
          matching_projection.reduce(CONTRADICTION) { |predicate, tuple| predicate.or(tuple.predicate) }.optimize
        end

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
            left.intersect(right)
          end

        end # class EqualHeaders

        # Optimize when the left operand is materialized
        class LeftMaterializedOperand < self

          # Test if the left operand is materialized
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            left.materialized? && ! right_matching_left?
          end

          # Return the join of the left and right with the right restricted
          #
          # @return [Algebra::Join]
          #
          # @api private
          def optimize
            left.join(right.restrict { materialized_predicate })
          end

        private

          # Test if the right operand is a restriction matching the left
          #
          # @return [Boolean]
          #
          # @api private
          def right_matching_left?
            right = self.right
            right.kind_of?(Veritas::Algebra::Restriction) && right.predicate.eql?(materialized_predicate)
          end

          # Return a the matching projection of the materializd relation
          #
          # @return [Projection]
          #
          # @api private
          def matching_projection
            left.project(join_key)
          end

        end # class LeftMaterializedOperand

        # Optimize when the right operand is materialized
        class RightMaterializedOperand < self

          # Test if the right operand is materialized
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            right.materialized? && ! left_matching_right?
          end

          # Return the join of the left and right with the left restricted
          #
          # @return [Algebra::Join]
          #
          # @api private
          def optimize
            left.restrict { materialized_predicate }.join(right)
          end

        private

          # Test if the left operand is a restriction matching the right
          #
          # @return [Boolean]
          #
          # @api private
          def left_matching_right?
            left = self.left
            left.kind_of?(Veritas::Algebra::Restriction) && left.predicate.eql?(materialized_predicate)
          end

          # Return a the matching projection of the materializd relation
          #
          # @return [Projection]
          #
          # @api private
          def matching_projection
            right.project(join_key)
          end

        end # class RightMaterializedOperand

        Veritas::Algebra::Join.optimizer = chain(
          EmptyLeft,
          EmptyRight,
          EqualHeaders,
          LeftOrderOperand,
          RightOrderOperand,
          MaterializedOperands,
          LeftMaterializedOperand,
          RightMaterializedOperand,
          UnoptimizedOperands
        )

        memoize :materialized_predicate

      end # class Join
    end # module Algebra
  end # class Optimizer
end # module Veritas
