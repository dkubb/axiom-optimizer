# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Predicate

        # Abstract base class representing Enumerable predicate optimizations
        module Enumerable

          # Return a value to sort the obejct with
          #
          # @param [Object] object
          #
          # @return [Object]
          #
          # @api private
          def self.sort_by_value(object)
            case object
            when TrueClass  then 1
            when FalseClass then 0
            else
              object
            end
          end

        private

          # Optimize the right operand
          #
          # @return [Object]
          #
          # @api private
          def optimize_right
            right = operation.right

            if right.respond_to?(:to_inclusive)
              optimize_right_range
            elsif right.respond_to?(:select)
              optimize_right_enumerable
            else
              right
            end
          end

          # Optimize the right range operand
          #
          # @return [Range]
          #
          # @api private
          def optimize_right_range
            left  = self.left
            right = operation.right
            return unless left.respond_to?(:range)
            right.to_inclusive if right.overlaps?(left.range)
          end

          # Optimize the right enumerable operand
          #
          # @return [Enumerable]
          #
          # @api private
          def optimize_right_enumerable
            enumerable = normalized_right_enumerable
            right      = operation.right

            right.eql?(enumerable) ? right : enumerable
          end

          # Normalize the right enumerable to only include unique, sorted, valid values
          #
          # @return [Enumerable]
          #
          # @api private
          def normalized_right_enumerable
            enumerable = operation.right.select { |value| left.valid_value?(value) }
            enumerable.uniq!
            enumerable.sort_by! { |value| Enumerable.sort_by_value(value) }
          end

          # Optimize when the right operand is empty
          module EmptyRight
            include Enumerable

            # Test if the right operand is empty
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              right_nil? || right_none?
            end

          private

            # Test if the right operand is nil
            #
            # @return [Boolean]
            #
            # @api private
            def right_nil?
              right.nil?
            end

            # Test if the right operand has no entries
            #
            # @return [Boolean]
            #
            # @api private
            def right_none?
              right.none? { true }
            end

          end # module EmptyRight

          # Optimize when the right operand has one entry
          module OneRight
            include Enumerable

            # Test if the right operand has one entry
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              right.one? { true }
            end

          end # module OneRight

          # Optimize when the operands are unoptimized
          class UnoptimizedOperands < Predicate::UnoptimizedOperands
            include Enumerable, Function::Binary::UnoptimizedOperands
          end # class UnoptimizedOperands
        end # module Enumerable
      end # class Predicate
    end # module Function
  end # class Optimizer
end # module Veritas
