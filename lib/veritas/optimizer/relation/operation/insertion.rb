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

          # Unwrap the operand from the right relation
          #
          # @return [Relation]
          #
          # @api private
          def unwrap_right
            right.operand
          end

          # Optimize when the left operand is a Rename
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

          # Optimize when the left operand is a Projection
          class ProjectionLeft < self

            # Test if the left operand is a Projection
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.kind_of?(Veritas::Algebra::Projection) &&
              ! required_attributes?
            end

            # An Insertion into a Projection applies to its operand
            #
            # Push-down the insertion to apply to the projection operand
            # only if the projected-away properties are not required. The right
            # operand will be extended with same named attributes.
            #
            # @return [Veritas::Algebra::Projection]
            #
            # @api private
            def optimize
              unwrap_left.insert(extend_right).project(operation.header)
            end

          private

            # Test if all attributes are required
            #
            # @return [Boolean]
            #
            # @api private
            def required_attributes?
              removed_attributes.all? { |attribute| attribute.required? }
            end

            # Returns the attributes removed from the left projection
            #
            # @return [#all?]
            #
            # @api private
            def removed_attributes
              left = self.left
              left.operand.header - left.header
            end

            # Extend the right relation with the removed attributes
            #
            # @return [Veritas::Algebra::Extension]
            #
            # @api private
            def extend_right
              right.extend do |context|
                removed_attributes.each do |attribute|
                  context.add(attribute, nil)
                end
              end
            end

          end # class ProjectionLeft

          # Optimize when the left operand is an Order
          class OrderLeft < self

            # Test if the left operand is an Order
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.kind_of?(Veritas::Relation::Operation::Order)
            end

            # An Insertion into an Order applies to its operand
            #
            # @return [Veritas::Relation::Operation::Order]
            #
            # @api private
            def optimize
              unwrap_left.insert(unwrap_right).sort_by { left.directions }
            end

          end # class OrderLeft

          class JoinLeft < self

            # Test if the left operand is a Join
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.kind_of?(Veritas::Algebra::Join)
            end

            # An Insertion into a Join applies to the left and right operand
            #
            # @return [Veritas::Algebra::Join]
            #
            # @api private
            def optimize
              wrap_left.join(wrap_right)
            end

          private

            # Wrap the left operand of the join in an insertion
            #
            # @return [Veritas::Relation::Operation::Insertion]
            #
            # @api private
            def wrap_left
              insert(left.left)
            end

            # Wrap the right operand of the join in an insertion
            #
            # @return [Veritas::Relation::Operation::Insertion]
            #
            # @api private
            def wrap_right
              insert(left.right)
            end

            # Insert a projection of the right operand into the relation
            #
            # @param [Veritas::Relation] relation
            #
            # @return [Veritas::Relation::Operation::Insertion]
            #
            # @api private
            def insert(relation)
              relation.insert(right.project(relation.header))
            end

          end # class Join

          Veritas::Relation::Operation::Insertion.optimizer = chain(
            RenameLeft,
            ProjectionLeft,
            OrderLeft,
            JoinLeft,
            MaterializedOperands,
            UnoptimizedOperands
          )

        end # class Insertion
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
