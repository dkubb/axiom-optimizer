# encoding: utf-8

module Veritas
  class Optimizer
    module Function

      # Abstract base class representing Predicate optimizations
      class Predicate < Optimizer
        include AbstractClass, Binary

        # Optimize when the operands are constants
        class ConstantOperands < self
          include Binary::ConstantOperands

          # A Predicate with constant values is equivalent to a Proposition
          #
          # @return [Proposition]
          #
          # @api private
          def optimize
            Veritas::Function::Proposition.new(super)
          end

        end # class ConstantOperands

        # Optimize when the operands are a contradiction
        module Contradiction

          # Return a contradiction
          #
          # @return [Contradiction]
          #
          # @api private
          def optimize
            Veritas::Function::Proposition::Contradiction.instance
          end

        end # module Contradiction

        # Optimize when the operands are a tautology
        module Tautology

          # Return a tautology
          #
          # @return [Tautology]
          #
          # @api private
          def optimize
            Veritas::Function::Proposition::Tautology.instance
          end

        end # module Tautology
      end # class Predicate
    end # module Function
  end # class Optimizer
end # module Veritas
