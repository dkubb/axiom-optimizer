# encoding: utf-8

module Veritas
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Difference optimizations
        class Insertion < Relation::Operation::Binary

        private

          # Unwrap the operand from the left relation
          #
          # @return [Relation]
          #
          # @api private
          def unwrap_left
            left.operand
          end

          # Optimize when the left operand is a rename
          class RenameLeft < self

            # Test if the left operand is a Rename
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.kind_of?(Veritas::Algebra::Rename)
            end

            # An Insertion into a Rename applies to its operand
            #
            # Push-down the insertion to apply to the rename operand, and make
            # sure the inserted tuples are properly renamed to match the
            # operand. Apply the rename to the insertion.
            #
            # @return [Veritas::Algebra::Rename]
            #
            # @api private
            def optimize
              unwrap_left.insert(rename_right).rename(aliases)
            end

          private

            # Wrap the right relation in a Rename
            #
            # @return [Relation]
            #
            # @api private
            def rename_right
              right.rename(aliases.inverse)
            end

            # The left Rename aliases
            #
            # @return [Veritas::Algebra::Rename::Aliases]
            #
            # @api private
            def aliases
              left.aliases
            end

          end # class RenameLeft

          # Optimize when the left operand is a restriction
          class RestrictionLeft < self

            # Test if the left operand is a Restriction
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.kind_of?(Veritas::Algebra::Restriction)
            end

            # An Insertion into a Restriction applies to its operand
            #
            # Push-down the insertion to apply to the restriction operand,
            # and make sure the inserted tuples match the predicate since
            # they must be included in the new relation.
            #
            # @return [Veritas::Algebra::Restriction]
            #
            # @api private
            def optimize
              unwrap_left.insert(materialize_right).restrict { tuple_predicate }
            end

          private

            # Materialize the right operand
            #
            # @return [Relation::Materialized]
            #
            # @api private
            def materialize_right
              right.materialize
            end

            # Predicate matching the left or right tuples
            #
            # @return [Function]
            #
            # @api private
            def tuple_predicate
              materialize_right.reduce(left.predicate) do |predicate, tuple|
                predicate.or(tuple.predicate)
              end
            end

            memoize :materialize_right

          end # class RestrictionLeft

          Veritas::Relation::Operation::Insertion.optimizer = chain(
            RenameLeft,
            RestrictionLeft,
            OrderLeft,
            OrderRight,
            MaterializedOperands,
            UnoptimizedOperands
          )

        end # class Insertion
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
