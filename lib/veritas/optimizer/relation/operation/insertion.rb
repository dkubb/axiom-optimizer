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

          Veritas::Relation::Operation::Insertion.optimizer = chain(
            OrderLeft,
            MaterializedOperands,
            UnoptimizedOperands
          )

        end # class Insertion
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
