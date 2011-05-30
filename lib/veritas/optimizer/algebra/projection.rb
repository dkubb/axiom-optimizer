# encoding: utf-8

module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Projection optimizations
      class Projection < Relation::Operation::Unary

        # The projected header
        #
        # @return [Header]
        #
        # @api private
        attr_reader :header

        # Initialize an Projection optimizer
        #
        # @return [undefined]
        #
        # @api private
        def initialize(*)
          super
          @header = operation.header
        end

      private

        # Wrap the operand's operand in a Projection
        #
        # @return [Projection]
        #
        # @api private
        def wrap_operand(operand = operand.operand)
          operation.class.new(operand, header)
        end

        # Optimize when the headers are not changed
        class UnchangedHeader < self

          # Test if the projected headers are the same as the operand's
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            header == operand.header
          end

          # A Projection with unchanged headers is a noop
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            operand
          end

        end # class UnchangedHeader

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
            operand.class.new(wrap_left, wrap_right)
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
            Veritas::Relation::Empty.new(header)
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
