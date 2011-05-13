# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Predicate

        # Abstract base class representing Inequality optimizations
        class Inequality < self
          include Comparable

          # Optimize when the operand are a contradiction
          class Contradiction < self
            include Predicate::Contradiction

            # Test if the operands are a contradiction
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.equal?(right)
            end

          end # class Contradiction

          # Optimize when the operand are a tautology
          class Tautology < self
            include Comparable::NeverEquivalent
            include Predicate::Tautology
          end # class Tautology

          Veritas::Function::Predicate::Inequality.optimizer = chain(
            ConstantOperands,
            Contradiction,
            Tautology,
            NormalizableOperands
          )

        end # class Inequality
      end # class Predicate
    end # module Function
  end # class Optimizer
end # module Veritas
