# encoding: utf-8

module Axiom
  class Optimizer
    module Function
      class Predicate

        # Abstract base class representing Inclusion optimizations
        class Inclusion < self
          include Enumerable

          # Optimize when the right operand is empty
          class EmptyRight < self
            include Enumerable::EmptyRight, Predicate::Contradiction
          end # class EmptyRight

          # Optimize when the right operand has one entry
          class OneRight < self
            include Enumerable::OneRight

            # An Inclusion with a single right operand is equivalent to an Equality
            #
            # @return [Equality]
            #
            # @api private
            def optimize
              left.eq(right.first)
            end

          end # class OneRight

          Axiom::Function::Predicate::Inclusion.optimizer = chain(
            ConstantOperands,
            EmptyRight,
            OneRight,
            Enumerable::UnoptimizedOperands
          )

        end # class Inclusion
      end # class Predicate
    end # module Function
  end # class Optimizer
end # module Axiom
