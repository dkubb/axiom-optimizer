# encoding: utf-8

module Veritas
  class Optimizer
    module Logic
      class Predicate

        # Abstract base class representing Equality optimizations
        class Equality < self
          include Comparable

          # Optimize when the operand are a contradiction
          class Contradiction < self
            include Comparable::NeverEquivalent
            include Predicate::Contradiction
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

          Veritas::Logic::Predicate::Equality.optimizer = chain(
            ConstantOperands,
            Contradiction,
            Tautology,
            NormalizableOperands
          )

        end # class Equality
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
