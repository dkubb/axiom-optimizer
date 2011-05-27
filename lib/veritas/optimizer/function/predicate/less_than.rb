# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Predicate

        # Abstract base class representing LessThan optimizations
        class LessThan < self
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
              LessThanOrEqualTo::Contradiction.new(operation).optimizable?
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
              operation.class.call(Binary::Util.max(left), Binary::Util.min(right))
            end

          end # class Tautology

          Veritas::Function::Predicate::LessThan.optimizer = chain(
            ConstantOperands,
            Contradiction,
            Tautology,
            NormalizableOperands
          )

        end # class LessThan
      end # class Predicate
    end # module Function
  end # class Optimizer
end # module Veritas
