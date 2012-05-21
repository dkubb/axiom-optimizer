# encoding: utf-8

module Veritas
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Difference optimizations
        class Insertion < Relation::Operation::Binary

          # Optimize when the left operand is a rename
          class RenameLeftOperand < self

            # Test if the left operand is a Rename
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.kind_of?(Veritas::Algebra::Rename)
            end

            # An Insertion into a Rename applies to the Rename operand
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

            # Unwrap the operand from the left relation
            #
            # @return [Relation]
            #
            # @api private
            def unwrap_left
              left.operand
            end

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

          end # class RenameLeftOperand

          Veritas::Relation::Operation::Insertion.optimizer = chain(
            RenameLeftOperand,
            LeftOrderOperand,
            RightOrderOperand,
            MaterializedOperands,
            UnoptimizedOperands
          )

        end # class Insertion
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
