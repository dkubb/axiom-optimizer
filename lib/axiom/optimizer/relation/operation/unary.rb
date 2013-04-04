# encoding: utf-8

module Axiom
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Unary relation optimizations
        class Unary < Optimizer
          include Function::Unary

          # The operation header
          #
          # @return [Header]
          #
          # @api private
          attr_reader :header

          # Initialize a Unary optimizer
          #
          # @return [undefined]
          #
          # @api private
          def initialize(*)
            super
            @header = operation.header
          end

          # Optimize when the operand is an Order
          module OrderOperand

            # Test if the operand is an Order
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(Axiom::Relation::Operation::Order)
            end

            # Drop the Order and wrap the operand
            #
            # @return [Order]
            #
            # @api private
            def optimize
              wrap_operand
            end

          end # module OrderOperand

          # Optimize when the header is not changed
          class UnchangedHeader < self

            # Test if the operation header are the same as the operand's
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              header == operand.header
            end

            # A Projection, Rename or Extension with an unchanged header is a noop
            #
            # @return [Relation]
            #
            # @api private
            def optimize
              operand
            end

          end # class UnchangedHeader

          # Optimize when the operand is Empty
          class EmptyOperand < self

            # Test if the operand is empty
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(Axiom::Relation::Empty)
            end

            # A Unary operation on an empty operand is empty
            #
            # @return [Relation::Empty]
            #
            # @api private
            def optimize
              operand
            end

          end # class EmptyOperand

          # Optimize when the operand is Materialized
          class MaterializedOperand < self

            # Test if the operand is materialized
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(Axiom::Relation::Materialized)
            end

            # Return the materialized operation
            #
            # @return [Relation::Materialized]
            #
            # @api private
            def optimize
              operation.materialize
            end

          end # class MaterializedOperand
        end # class Unary
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Axiom
