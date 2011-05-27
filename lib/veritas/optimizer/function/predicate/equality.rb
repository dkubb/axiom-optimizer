# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Predicate

        # Abstract base class representing Equality optimizations
        class Equality < self
          include Comparable

          # Optimize when the operand are a contradiction
          class Contradiction < self
            include Comparable::NeverEquivalent, Predicate::Contradiction
          end # class Contradiction

          # Optimize when the operand are a tautology
          class Tautology < self
            include Predicate::Tautology

            # Test if the operands are a tautology
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.equal?(right)
            end

          end # class Tautology

          Veritas::Function::Predicate::Equality.optimizer = chain(
            ConstantOperands,
            Contradiction,
            Tautology,
            NormalizableOperands,
            UnoptimizedOperands
          )

        end # class Equality
      end # class Predicate
    end # module Function
  end # class Optimizer
end # module Veritas
