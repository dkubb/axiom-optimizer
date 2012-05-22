# encoding: utf-8

module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Rename optimizations
      class Rename < Relation::Operation::Unary

        # The optimized aliases
        #
        # @return [Rename::Aliases]
        #
        # @api private
        attr_reader :aliases

        # Initialize an Rename optimizer
        #
        # @param [Relation] operation
        #
        # @return [undefined]
        #
        # @api private
        def initialize(operation)
          super
          @aliases = operation.aliases
        end

      private

        # Wrap the operand's operand in a Rename
        #
        # @return [Rename]
        #
        # @api private
        def wrap_operand(operand = operand.operand)
          operand.rename(aliases)
        end

        # Optimize when the operand is a Rename
        class RenameOperand < self

          # Test if the operand is a Rename
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(operation.class)
          end

          # Flatten nested Renames into a single Rename
          #
          # @return [Projection]
          #
          # @api private
          def optimize
            wrap_operand
          end

        private

          # The optimized aliases
          #
          # @return [Rename::Aliases]
          #
          # @api private
          def aliases
            super.union(operand.aliases)
          end

        end # class RenameOperand

        # Optimize when the operand is a Rename with aliases that cancel out
        class RenameOperandAndEmptyAliases < RenameOperand

          # Test if the operand is a Rename with aliases that cancel out
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            super && aliases.empty?
          end

          # A Rename wrapping a Rename with aliases that cancel out is a noop
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            operand.operand
          end

        end # class RenameOperandAndEmptyAliases

        # Optimize when the operand is a Projection
        class ProjectionOperand < self

          # Test if the operand is a Projection
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Algebra::Projection) && distributive?
          end

          # Wrap the Rename in a Projection
          #
          # @return [Projection]
          #
          # @api private
          def optimize
            wrap_operand.project(header)
          end

        private

          # Test if the rename can be distributed over the projection
          #
          # @return [Boolean]
          #
          # @api private
          def distributive?
            names = alias_names
            removed_attributes.none? do |attribute|
              names.include?(attribute.name)
            end
          end

          # Return the aliases as an inverted Hash
          #
          # @return [Hash]
          #
          # @api private
          def alias_names
            aliases.to_hash.values.map { |attribute| attribute.name }
          end

          # Returns the attributes removed from the projection
          #
          # @return [#all?]
          #
          # @api private
          def removed_attributes
            operand = self.operand
            operand.operand.header - operand.header
          end

        end # class ProjectionOperand

        # Optimize when the operand is a Restriction
        class RestrictionOperand < self

          # Test if the operand is a Restriction
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Algebra::Restriction)
          end

          # Wrap the Rename in a Restriction
          #
          # @return [Restriction]
          #
          # @api private
          def optimize
            wrap_operand.restrict { rename_predicate }
          end

        private

          # Rename the operand predicate
          #
          # @return [Function]
          #
          # @api private
          def rename_predicate
            operand.predicate.rename(aliases)
          end

        end # class RestrictionOperand

        # Optimize when the operand is a Set
        class SetOperand < self

          # Test if the operand is a Set
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Set)
          end

          # Wrap each operand in the Set in a Rename
          #
          # @return [Set]
          #
          # @api private
          def optimize
            operand.class.new(wrap_left, wrap_right)
          end

        private

          # Utility method to wrap the left operand in a Rename
          #
          # @return [Rename]
          #
          # @api private
          def wrap_left
            wrap_operand(operand.left)
          end

          # Utility method to wrap the right operand in a Rename
          #
          # @return [Rename]
          #
          # @api private
          def wrap_right
            wrap_operand(operand.right)
          end

        end # class SetOperand

        # Optimize when the operand is a Reverse
        class ReverseOperand < self

          # Test if the operand is a Reverse
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Reverse)
          end

          # Wrap the Rename in a Reverse
          #
          # @return [Reverse]
          #
          # @api private
          def optimize
            wrap_operand.reverse
          end

        end # class ReverseOperand

        # Optimize when the operand is an Order
        class OrderOperand < self
          include Relation::Operation::Unary::OrderOperand

          # Wrap the Rename in an Order
          #
          # @return [Order]
          #
          # @api private
          def optimize
            wrap_operand.sort_by { directions }
          end

        private

          # Return the renamed directions
          #
          # @return [Relation::Operation::Order::DirectionSet]
          #
          # @api private
          def directions
            operand.directions.rename(aliases)
          end

        end # class OrderOperand

        # Optimize when the operand is a Limit
        class LimitOperand < self

          # Test if the operand is a Limit
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Limit)
          end

          # Wrap the Rename in a Limit
          #
          # @return [Limit]
          #
          # @api private
          def optimize
            wrap_operand.take(operand.limit)
          end

        end # class LimitOperand

        # Optimize when the operand is an Offset
        class OffsetOperand < self

          # Test if the operand is an Offset
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Offset)
          end

          # Wrap the Rename in an Offset
          #
          # @return [Offset]
          #
          # @api private
          def optimize
            wrap_operand.drop(operand.offset)
          end

        end # class OffsetOperand

        # Optimize when the operand is Empty
        class EmptyOperand < self

          # Test if the operand is empty
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Empty)
          end

          # Return a new Empty relation with the operation's headers
          #
          # @return [Empty]
          #
          # @api private
          def optimize
            Veritas::Relation::Empty.new(header, operation)
          end

        end # class EmptyOperand

        # Optimize when operand is optimizable
        class UnoptimizedOperand < self
          include Function::Unary::UnoptimizedOperand

          # Return a Rename with an optimized operand
          #
          # @return [Rename]
          #
          # @api private
          def optimize
            wrap_operand(operand)
          end

        end # class UnoptimizedOperand

        Veritas::Algebra::Rename.optimizer = chain(
          UnchangedHeader,
          RenameOperandAndEmptyAliases,
          RenameOperand,
          ProjectionOperand,
          RestrictionOperand,
          SetOperand,
          ReverseOperand,
          OrderOperand,
          LimitOperand,
          OffsetOperand,
          EmptyOperand,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Rename
    end # module Algebra
  end # class Optimizer
end # module Veritas
