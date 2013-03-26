# encoding: utf-8

module Axiom
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Offset optimizations
        class Offset < Unary

        private

          # Return the operation offset
          #
          # @return [Integer]
          #
          # @api private
          def offset
            operation.offset
          end

          # Optimize when the offset is zero
          class ZeroOffset < self

            # Test if the offset is zero
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              offset.zero?
            end

            # An Offset with an offset of zero is a noop
            #
            # @return [Relation]
            #
            # @api private
            def optimize
              operand
            end

          end # class ZeroOffset

          # Optimize when the operand is an Offset
          class OffsetOperand < self

            # Test if the operand is an Offset
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(operation.class)
            end

            # Flatten Offset operations using the sum of the offsets
            #
            # @return [Boolean]
            #
            # @api private
            def optimize
              operand.operand.drop(sum_offset)
            end

          private

            # Return the sum of the operation and operand offsets
            #
            # @return [Integer]
            #
            # @api private
            def sum_offset
              offset + operand.offset
            end

          end # class OffsetOperand

          # Optimize when operand is optimizable
          class UnoptimizedOperand < self
            include Function::Unary::UnoptimizedOperand

            # Return an Offset with an optimized operand
            #
            # @return [Offset]
            #
            # @api private
            def optimize
              operand.drop(offset)
            end

          end # class UnoptimizedOperand

          Axiom::Relation::Operation::Offset.optimizer = chain(
            ZeroOffset,
            OffsetOperand,
            EmptyOperand,
            MaterializedOperand,
            UnoptimizedOperand
          )

        end # class Offset
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Axiom
