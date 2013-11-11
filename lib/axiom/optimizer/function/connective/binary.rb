# encoding: utf-8

module Axiom
  class Optimizer
    module Function
      module Connective

        # Abstract base class representing Binary connective optimizations
        class Binary < Optimizer
          include Function::Binary

        private

          # Test if the operands are equality/inclusion predicates for the same attribute
          #
          # @return [Boolean]
          #
          # @api private
          def equality_with_same_attributes?
            left_equality?  &&
            right_equality? &&
            same_attribute? &&
            constant_value?
          end

          # Test if the operands are inequality/exclusion predicates for the same attribute
          #
          # @return [Boolean]
          #
          # @api private
          def inequality_with_same_attributes?
            left_inequality?  &&
            right_inequality? &&
            same_attribute?   &&
            constant_value?
          end

          # Test if the left and right predicates are for the same attribute
          #
          # @return [Boolean]
          #
          # @api private
          def same_attribute?
            left.left.equal?(right.left)
          end

          # Test if the left and right predicates match against constant values
          #
          # @return [Boolean]
          #
          # @api private
          def constant_value?
            util = Util
            util.constant?(left.right) && util.constant?(right.right)
          end

          # Test if the left is an equality or inclusion
          #
          # @return [Boolean]
          #
          # @api private
          def left_equality?
            util = Axiom::Function::Predicate
            left.kind_of?(util::Equality) || left.kind_of?(util::Inclusion)
          end

          # Test if the right is an equality or inclusion
          #
          # @return [Boolean]
          #
          # @api private
          def right_equality?
            util = Axiom::Function::Predicate
            right.kind_of?(util::Equality) || right.kind_of?(util::Inclusion)
          end

          # Test if the left is an inequality or exclusion
          #
          # @return [Boolean]
          #
          # @api private
          def left_inequality?
            util = Axiom::Function::Predicate
            left.kind_of?(util::Inequality) || left.kind_of?(util::Exclusion)
          end

          # Test if the right is an inequality or exclusion
          #
          # @return [Boolean]
          #
          # @api private
          def right_inequality?
            util = Axiom::Function::Predicate
            right.kind_of?(util::Inequality) || right.kind_of?(util::Exclusion)
          end

          # Test if the left is a tautology
          #
          # @return [Boolean]
          #
          # @api private
          def left_tautology?
            left.equal?(Axiom::Function::Proposition::Tautology.instance)
          end

          # Test if the right is a tautology
          #
          # @return [Boolean]
          #
          # @api private
          def right_tautology?
            right.equal?(Axiom::Function::Proposition::Tautology.instance)
          end

          # Test if the left is a contradiction
          #
          # @return [Boolean]
          #
          # @api private
          def left_contradiction?
            left.equal?(Axiom::Function::Proposition::Contradiction.instance)
          end

          # Test if the right is a contradiction
          #
          # @return [Boolean]
          #
          # @api private
          def right_contradiction?
            right.equal?(Axiom::Function::Proposition::Contradiction.instance)
          end

          # Test if the left and right
          #
          # @return [Boolean]
          #
          # @api private
          def contradiction?
            left.respond_to?(:inverse)  &&
            right.respond_to?(:inverse) &&
            left.inverse.eql?(right)
          end

          # Merge the right enumerables from the operands
          #
          # @return [Array]
          #
          # @api private
          def merged_right_enumerables
            [left.right, right.right].flatten
          end

          # Optimize when the operands are constants
          class ConstantOperands < self
            include Function::Binary::ConstantOperands

            # A Connective with constant values is equivalent to a Proposition
            #
            # @return [Proposition]
            #
            # @api private
            def optimize
              Axiom::Function::Proposition.coerce(super)
            end

          end # class ConstantOperands

          # Optimize when the operands are equal
          class EqualOperands < self

            # Test if the operands are equal
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.eql?(right)
            end

            # A Binary connective with equal operands is equivalent to the left
            #
            # @return [Function]
            #
            # @api private
            def optimize
              left
            end

          end # class EqualOperands

          # Optimize when the left operand is redundant
          class RedundantLeft < self

            # Test if the left operand is redundant
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operation.kind_of?(left.class) && right.eql?(left.right)
            end

            # A Binary connective with a redundant left operand is equivalent to the left
            #
            # @return [Function]
            #
            # @api private
            def optimize
              left
            end

          end # class RedundantLeft

          # Optimize when the right operand is redundant
          class RedundantRight < self

            # Test if the right operand is redundant
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operation.kind_of?(right.class) && left.eql?(right.left)
            end

            # A Binary connective with a redundant right operand is equivalent to the right
            #
            # @return [Function]
            #
            # @api private
            def optimize
              right
            end

          end # class RedundantRight

          # Optimize when the operands are unoptimized
          class UnoptimizedOperands < self
            include Function::Binary::UnoptimizedOperands
          end # class UnoptimizedOperands
        end # class Binary
      end # module Connective
    end # module Function
  end # class Optimizer
end # module Axiom
