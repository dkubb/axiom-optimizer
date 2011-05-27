# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      module Connective

        # Abstract base class representing Disjunction optimizations
        class Disjunction < Binary

          # Optimize when the left operand is a contradiction
          class ContradictionLeftOperand < self

            # Test if the left operand is a contradiction
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left_contradiction?
            end

            # A Disjunction with a contradiction left operand is equivalent to the right
            #
            # @return [Function]
            #
            # @api private
            def optimize
              right
            end

          end # class ContradictionLeftOperand

          # Optimize when the right operand is a contradiction
          class ContradictionRightOperand < self

            # Test if the right operand is a contradiction
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              right_contradiction?
            end

            # A Disjunction with a contradiction right operand is equivalent to the left
            #
            # @return [Function]
            #
            # @api private
            def optimize
              left
            end

          end # class ContradictionRightOperand

          # Optimize when the operands are equality predicates for the same attribute
          class OptimizableToInclusion < self

            # Test if the operands are equality predicates for the same attribute
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              equality_with_same_attributes?
            end

            # Return an Inclusion for an attribute having a set of values
            #
            # @return [Inclusion]
            #
            # @api private
            def optimize
              left = self.left
              Veritas::Function::Predicate::Inclusion.new(left.left, [ left.right, right.right ]).optimize
            end

          end # class OptimizableToInclusion

          # Optimize when the operands are a tautology
          class Tautology < self

            # Test if the operands are a tautology
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left_tautology?                  ||
              right_tautology?                 ||
              inequality_with_same_attributes? ||
              left.inverse.eql?(right)
            end

            # Return a tautology
            #
            # @return [Tautology]
            #
            # @api private
            def optimize
              Veritas::Function::Proposition::Tautology.instance
            end

          end # class Tautology

          Veritas::Function::Connective::Disjunction.optimizer = chain(
            ConstantOperands,
            ContradictionLeftOperand,
            ContradictionRightOperand,
            OptimizableToInclusion,
            EqualOperands,
            RedundantLeftOperand,
            RedundantRightOperand,
            Tautology,
            UnoptimizedOperand
          )

        end # class Disjunction
      end # module Connective
    end # module Function
  end # class Optimizer
end # module Veritas
