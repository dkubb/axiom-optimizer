# encoding: utf-8

module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Projection optimizations
      class Projection < Relation::Operation::Unary

      private

        # Wrap the operand's operand in a Projection
        #
        # @return [Projection]
        #
        # @api private
        def wrap_operand(operand = operand.operand)
          operand.project(header)
        end

        # Optimize when the operand is a Projection
        class ProjectionOperand < self

          # Test if the operand is a Projection
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(operation.class)
          end

          # Flatten nested Projections into a single Projection
          #
          # @return [Projection]
          #
          # @api private
          def optimize
            wrap_operand
          end

        end # class ProjectionOperand

        # Optimize when the operand is an Extension
        class ExtensionOperand < self

          # Test if the operand is an Extension
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand = self.operand
            operand.kind_of?(Veritas::Algebra::Extension) &&
            operand.extensions != new_extensions
          end

          # Extend the operand with the attributes not projected away
          #
          # This avoid performing an extension when the new attributes are
          # immediately removed.
          #
          # @return [Projection]
          #
          # @api private
          def optimize
            extend_operand.project(operation.header)
          end

        private

          # Extend the operand with only the new extensions
          #
          # @return [Extension]
          #
          # @api private
          def extend_operand
            unwrap_operand.extend(new_extensions)
          end

          # Unwrap the operand from the Extension
          #
          # @return [Relation]
          #
          # @api private
          def unwrap_operand
            operand.operand
          end

          # Extensions minus the removed attributes
          #
          # @return [Hash{Attribute => Function}]
          #
          # @api private
          def new_extensions
            extensions = operand.extensions
            attributes = extensions.keys - removed_attributes
            Hash[attributes.zip(extensions.values_at(*attributes))]
          end

          # Attributes removed by the projection
          #
          # @return [Header]
          #
          # @api private
          def removed_attributes
            operand.header - operation.header
          end

          memoize :new_extensions, :removed_attributes
        end

        # Optimize when the operand is a Union
        class UnionOperand < self

          # Test if the operand is a Union
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Algebra::Union)
          end

          # Wrap each operand in the Union in a Projection
          #
          # @return [Set]
          #
          # @api private
          def optimize
            wrap_left.union(wrap_right)
          end

        private

          # Utility method to wrap the left operand in a Projection
          #
          # @return [Projection]
          #
          # @api private
          def wrap_left
            wrap_operand(operand.left)
          end

          # Utility method to wrap the right operand in a Projection
          #
          # @return [Projection]
          #
          # @api private
          def wrap_right
            wrap_operand(operand.right)
          end

        end # class UnionOperand

        # Optimize when the operand is an Order
        class OrderOperand < self
          include Relation::Operation::Unary::OrderOperand
        end # class OrderOperand

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

          # Return a Projection with an optimized operand
          #
          # @return [Projection]
          #
          # @api private
          def optimize
            wrap_operand(operand)
          end

        end # class UnoptimizedOperand

        Veritas::Algebra::Projection.optimizer = chain(
          UnchangedHeader,
          ProjectionOperand,
          ExtensionOperand,
          UnionOperand,
          OrderOperand,
          EmptyOperand,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Projection
    end # module Algebra
  end # class Optimizer
end # module Veritas
