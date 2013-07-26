# encoding: utf-8

module Axiom
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
        def wrap_operand(operand = operand.operand)
          operand.restrict(predicate)
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
          ! (predicate.respond_to?(:call) || constant_true_predicate?)
        end

        # Optimize when the predicate is a tautology
        class Tautology < self

          # Test if the predicate is a tautology
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            predicate.equal?(Axiom::Function::Proposition::Tautology.instance) ||
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
            predicate.equal?(Axiom::Function::Proposition::Contradiction.instance) ||
            constant_false_predicate?
          end

          # A Restriction with a contradiction matches nothing
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            Axiom::Relation::Empty.new(operation.header)
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
          # @return [Restriction]
          #
          # @api private
          def optimize
            wrap_operand
          end

        private

          # Join the operand and operation predicates and optimize them
          #
          # @return [Function]
          #
          # @api private
          def predicate
            operand.predicate.and(super).optimize
          end

        end # class RestrictionOperand

        # Optimize when the operand is a combine operation
        class CombinationOperand < self

          # Test if the restriction is commutative
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            restriction_commutative?
          end

          # Distribute the restriction across the operation and apply to the operands
          #
          # @return [Restriction]
          #
          # @api private
          def optimize
            left_restriction.send(relation_method, right_restriction).restrict(partition.remainder)
          end

        private

          # Return a predicate partition for the restriction and operand headers
          #
          # @return [PredicatePartition]
          #
          # @api private
          def partition
            PredicatePartition.new(predicate, operand.left.header, operand.right.header)
          end

          # Test if the restriction can be distributed over the operation
          #
          # If the predicates for the left and right operands would match
          # everything, there is no point in distributing the restriction
          # across the operation, since it will not affect the result.
          #
          # @return [Boolean]
          #
          # @api private
          def restriction_commutative?
            ! (partition_left_tautology? && partition_right_tautology?)
          end

          # Test if the predicate for the left operand would match everything
          #
          # @return [Boolean]
          #
          # @api private
          def partition_left_tautology?
            partition.left.equal?(Axiom::Function::Proposition::Tautology.instance)
          end

          # Test if the predicate for the right operand would match everything
          #
          # @return [Boolean]
          #
          # @api private
          def partition_right_tautology?
            partition.right.equal?(Axiom::Function::Proposition::Tautology.instance)
          end

          # Abstract method to return the relation method name
          #
          # @raise [NotImplementedError]
          #   raised when the subclass does not implement the method
          #
          # @api private
          def relation_method
            raise NotImplementedError, "#{self.class}#relation_method must be implemented"
          end

          # Restrict the left operand with the left predicate partition
          #
          # @return [Restriction]
          #
          # @api private
          def left_restriction
            operand.left.restrict(partition.left)
          end

          # Restrict the right operand with the right predicate partition
          #
          # @return [Restriction]
          #
          # @api private
          def right_restriction
            operand.right.restrict(partition.right)
          end

          memoize :partition
        end

        # Optimize when the operand is a Join
        class JoinOperand < CombinationOperand

          # Test if the operand is a Join and the restriction is commutative
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Axiom::Algebra::Join) && super
          end

        private

          # Return the relation method name for a Join operation
          #
          # @return [Symbol]
          #
          # @api private
          def relation_method
            :join
          end

        end # class JoinOperand

        # Optimize when the operand is a Product
        class ProductOperand < CombinationOperand

          # Test if the operand is a Join and the restriction is commutative
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Axiom::Algebra::Product) && super
          end

        private

          # Return the relation method name for a Product operation
          #
          # @return [Symbol]
          #
          # @api private

          def relation_method
            :product
          end

        end # class ProductOperand

        # Optimize when the operand is a Set
        class SetOperand < self

          # Test if the operand is a Restriction
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Axiom::Relation::Operation::Set)
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
            wrap_operand(operand.left)
          end

          # Utility method to wrap the right operand in a Restriction
          #
          # @return [Restriction]
          #
          # @api private
          def wrap_right
            wrap_operand(operand.right)
          end

        end # class SetOperand

        # Optimize when the operand is an Order
        class OrderOperand < self
          include Relation::Operation::Unary::OrderOperand
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
            super || ! predicate.equal?(operation.predicate)
          end

          # Return a Restriction with an optimized operand
          #
          # @return [Rename]
          #
          # @api private
          def optimize
            wrap_operand(operand)
          end

        end # class UnoptimizedOperand

        Axiom::Algebra::Restriction.optimizer = chain(
          Tautology,
          Contradiction,
          RestrictionOperand,
          JoinOperand,
          ProductOperand,
          SetOperand,
          OrderOperand,
          EmptyOperand,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Restriction
    end # module Algebra
  end # class Optimizer
end # module Axiom
