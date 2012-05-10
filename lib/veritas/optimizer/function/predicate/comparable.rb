# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Predicate

        # Abstract base class representing Comparable predicate optimizations
        module Comparable

          # Optimize when the operands can be normalized
          class NormalizableOperands < Predicate

            # Test if the operands can be normalized
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              util = Util
              util.constant?(left) && util.attribute?(right)
            end

            # Normalize the predicate by reversing the operands
            #
            # @return [Predicate]
            #
            # @api private
            def optimize
              operation.class.reverse.new(right, left)
            end

          end # class NormalizableOperands

          # Optimize when the operands will never be equivalent
          module NeverEquivalent

            # Test if the operands will never be equivalent
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              util = Util
              if    nil_operand?          then true
              elsif util.constant?(left)  then left_invalid_constant?
              elsif util.constant?(right) then right_invalid_constant?
              else
                ! joinable?
              end
            end

          private

            # Test if an operand is nil
            #
            # @return [Boolean]
            #
            # @api private
            def nil_operand?
              left.nil? || right.nil?
            end

            # Test if the left operand is an invalid constant
            #
            # @return [Boolean]
            #
            # @api private
            def left_invalid_constant?
              ! right.valid_value?(left)
            end

            # Test if the right operand is an invalid constant
            #
            # @return [Boolean]
            #
            # @api private
            def right_invalid_constant?
              ! left.valid_value?(right)
            end

            # Test if the left and right operand are joinable
            #
            # @return [Boolean]
            #
            # @api private
            def joinable?
              left = self.left
              left == right.rename(left.name)
            end

          end # module NeverEquivalent

          # Optimize when the operands will never be comparable
          module NeverComparable

            # Test if the operands will never be comparable
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              util = Util
              if    nil_operand?          then true
              elsif util.constant?(left)  then left_invalid_constant?
              elsif util.constant?(right) then right_invalid_constant?
              else
                ! comparable?
              end
            end

          private

            # Test if an operand is nil
            #
            # @return [Boolean]
            #
            # @api private
            def nil_operand?
              left.nil? || right.nil?
            end

            # Test if the left operand is an invalid constant
            #
            # @return [Boolean]
            #
            # @api private
            def left_invalid_constant?
              ! right.valid_primitive?(left)
            end

            # Test if the right operand is an invalid constant
            #
            # @return [Boolean]
            #
            # @api private
            def right_invalid_constant?
              ! left.valid_primitive?(right)
            end

            # Test if the left and right operand are comparable
            #
            # @return [Boolean]
            #
            # @api private
            def comparable?
              left.class <=> right.class
            end

          end # module NeverComparable
        end # module Comparable
      end # class Predicate
    end # module Function
  end # class Optimizer
end # module Veritas
