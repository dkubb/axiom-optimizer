# encoding: utf-8

module Veritas
  class Optimizer
    module Function
      class Predicate

        # Abstract base class representing Inclusion optimizations
        class Inclusion < self
          include Enumerable

          # Optimize when the right operand is empty
          class EmptyRightOperand < self
            include Enumerable::EmptyRightOperand

            # An Inclusion with an empty right operand matches nothing
            #
            # @return [Contradiction]
            #
            # @api private
            def optimize
              Veritas::Function::Proposition::Contradiction.instance
            end

          end # class EmptyRightOperand

          # Optimize when the right operand has one entry
          class OneRightOperand < self
            include Enumerable::OneRightOperand

            # An Inclusion with a single right operand is equivalent to an Equality
            #
            # @return [Equality]
            #
            # @api private
            def optimize
              Veritas::Function::Predicate::Equality.new(left, right.first)
            end

          end # class OneRightOperand

          Veritas::Function::Predicate::Inclusion.optimizer = chain(
            ConstantOperands,
            EmptyRightOperand,
            OneRightOperand,
            UnoptimizedOperand
          )

        end # class Inclusion
      end # class Predicate
    end # module Function
  end # class Optimizer
end # module Veritas
