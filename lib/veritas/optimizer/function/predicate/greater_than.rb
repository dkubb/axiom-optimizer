# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Predicate

        # Abstract base class representing GreaterThan optimizations
        class GreaterThan < self
          include Comparable

          # Optimize when the operands are a contradiction
          class Contradiction < self
            include Predicate::Contradiction

            # Test if the operands are a contradiction
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.equal?(right) ||
              GreaterThanOrEqualTo::Contradiction.new(operation).optimizable?
            end

          end # class Contradiction

          # Optimize when the operands are a tautology
          class Tautology < self
            include Predicate::Tautology

            # Test if the operands are a tautology
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operation.class.call(Util.min(left), Util.max(right))
            end

          end # class Tautology

          Veritas::Function::Predicate::GreaterThan.optimizer = chain(
            ConstantOperands,
            Contradiction,
            Tautology,
            NormalizableOperands
          )

        end # class GreaterThan
      end # class Predicate
    end # module Function
  end # class Optimizer
end # module Veritas
