# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Predicate

        # Abstract base class representing Exclusion optimizations
        class Exclusion < self
          include Enumerable

          # Optimize when the right operand is empty
          class EmptyRight < self
            include Enumerable::EmptyRight, Predicate::Tautology
          end # class EmptyRight

          # Optimize when the right operand has one entry
          class OneRight < self
            include Enumerable::OneRight

            # An Exclusion with a single right operand is equivalent to an Inequality
            #
            # @return [Inequality]
            #
            # @api private
            def optimize
              left.ne(right.first)
            end

          end # class OneRight

          Veritas::Function::Predicate::Exclusion.optimizer = chain(
            ConstantOperands,
            EmptyRight,
            OneRight,
            Enumerable::UnoptimizedOperands
          )

        end # class Exclusion
      end # class Predicate
    end # module Function
  end # class Optimizer
end # module Veritas
