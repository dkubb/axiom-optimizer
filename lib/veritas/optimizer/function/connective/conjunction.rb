# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      module Connective

        # Abstract base class representing Conjunction optimizations
        class Conjunction < Binary

          # Optimize when the left operand is a tautology
          class TautologyLeft < self

            # Test if the left operand is a tautology
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left_tautology?
            end

            # A Conjunction with a tautology left operand is equivalent to the right
            #
            # @return [Function]
            #
            # @api private
            def optimize
              right
            end

          end # class TautologyLeft

          # Optimize when the right operand is a tautology
          class TautologyRight < self

            # Test if the right operand is a tautology
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              right_tautology?
            end

            # A Conjunction with a tautology right operand is equivalent to the left
            #
            # @return [Function]
            #
            # @api private
            def optimize
              left
            end

          end # class TautologyRight

          # Optimize when the operands are inequality predicates for the same attribute
          class OptimizableToExclusion < self

            # Test if the operands are inequality predicates for the same attribute
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              inequality_with_same_attributes?
            end

            # Return an Exclusion for an attribute against a set of values
            #
            # @return [Exclusion]
            #
            # @api private
            def optimize
              left.left.exclude(merged_right_enumerables).optimize
            end

          end # class OptimizableToExclusion

          # Optimize when the operands are a contradiction
          class Contradiction < self

            # Test if the operands are a contradiction
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left_contradiction?            ||
              right_contradiction?           ||
              equality_with_same_attributes? ||
              contradiction?
            end

            # Return a contradiction
            #
            # @return [Contradiction]
            #
            # @api private
            def optimize
              Veritas::Function::Proposition::Contradiction.instance
            end

          end # class Contradiction

          Veritas::Function::Connective::Conjunction.optimizer = chain(
            ConstantOperands,
            TautologyLeft,
            TautologyRight,
            OptimizableToExclusion,
            EqualOperands,
            RedundantLeft,
            RedundantRight,
            Contradiction,
            UnoptimizedOperands
          )

        end # class Conjunction
      end # module Connective
    end # module Function
  end # class Optimizer
end # module Veritas
