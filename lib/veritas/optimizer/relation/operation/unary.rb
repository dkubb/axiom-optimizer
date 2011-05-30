# encoding: utf-8

module Veritas
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Unary relation optimizations
        class Unary < Optimizer
          include Function::Unary

          # Optimize when the operand is an Order
          module OrderOperand

            # Test if the operand is an Order
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(Veritas::Relation::Operation::Order)
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
              operand.kind_of?(Veritas::Relation::Materialized)
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
end # module Veritas
