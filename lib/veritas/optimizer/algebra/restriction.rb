# encoding: utf-8

module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Restriction optimizations
      class Restriction < Relation::Operation::Unary

        # The optimized predicate
        #
        # @return [Function]
        #
        # @api private
        attr_reader :predicate

        # Initialize an Restriction optimizer
        #
        # @return [undefined]
        #
        # @api private
        def initialize(*)
          super
          @predicate = Function.optimize_operand(operation.predicate)
        end

      private

        # Wrap the operand's operand in a Restriction
        #
        # @return [Restriction]
        #
        # @api private
        def wrap_operand
          operation.class.new(operand.operand, predicate)
        end

        # Return true if the predicate is a true value
        #
        # @return [Boolean]
        #
        # @api private
        def constant_true_predicate?
          predicate.equal?(true)
        end

        # Return true if the predicate is not callable, and not a true value
        #
        # In the system anything not a Tautology or true is false.
        #
        # @return [Boolean]
        #
        # @api private
        def constant_false_predicate?
          !(predicate.respond_to?(:call) || constant_true_predicate?)
        end

        # Optimize when the predicate is a tautology
        class Tautology < self

          # Test if the predicate is a tautology
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            predicate.equal?(Veritas::Function::Proposition::Tautology.instance) ||
            constant_true_predicate?
          end

          # A Restriction with a tautology is a noop
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            operand
          end

        end # class Tautology

        # Optimize when the predicate is a contradiction
        class Contradiction < self

          # Test if the predicate is a contradiction
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            predicate.equal?(Veritas::Function::Proposition::Contradiction.instance) ||
            constant_false_predicate?
          end

          # A Restriction with a contradiction matches nothing
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            Veritas::Relation::Empty.new(operation.header)
          end

        end # class Contradiction

        # Optimize when the operand is a Restriction
        class RestrictionOperand < self

          # Test if the operand is a Restriction
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(operation.class)
          end

          # Flatten nested Restrictions into a single Restriction
          #
          # @return [Projection]
          #
          # @api private
          def optimize
            operation.class.new(operand.operand, optimized_predicate)
          end

        private

          # Join the operand and operation predicates and optimize them
          #
          # @return [Function]
          #
          # @api private
          def optimized_predicate
            Veritas::Function::Connective::Conjunction.new(operand.predicate, predicate).optimize
          end

        end # class RestrictionOperand

        # Optimize when the operand is a Set
        class SetOperand < self

          # Test if the operand is a Restriction
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Set)
          end

          # Wrap each operand in the Set in a Restriction
          #
          # @return [Set]
          #
          # @api private
          def optimize
            operand.class.new(wrap_left, wrap_right)
          end

        private

          # Utility method to wrap the left operand in a Restriction
          #
          # @return [Restriction]
          #
          # @api private
          def wrap_left
            operation.class.new(operand.left, predicate)
          end

          # Utility method to wrap the right operand in a Restriction
          #
          # @return [Restriction]
          #
          # @api private
          def wrap_right
            operation.class.new(operand.right, predicate)
          end

        end # class SetOperand

        # Optimize when the operand is an Order
        class OrderOperand < self

          # Test if the operand is an Order
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Order)
          end

          # Wrap the Restriction in an Order
          #
          # @return [Order]
          #
          # @api private
          def optimize
            wrap_operand
          end

        end # class OrderOperand

        # Optimize when operand is optimizable
        class UnoptimizedOperand < self
          include Function::Unary::UnoptimizedOperand

          # Test if the operand is unoptimized
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            super || !predicate.equal?(operation.predicate)
          end

          # Return a Restriction with an optimized operand
          #
          # @return [Rename]
          #
          # @api private
          def optimize
            operation.class.new(operand, predicate)
          end

        end # class UnoptimizedOperand

        Veritas::Algebra::Restriction.optimizer = chain(
          Tautology,
          Contradiction,
          RestrictionOperand,
          SetOperand,
          OrderOperand,
          EmptyOperand,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Restriction
    end # module Algebra
  end # class Optimizer
end # module Veritas
