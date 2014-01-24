# encoding: utf-8

module Axiom
  class Optimizer

    # Partition a predicate to distribute it over binary operations
    class PredicatePartition
      include Adamantium

      TAUTOLOGY = Axiom::Function::Proposition::Tautology.instance

      # Returns the predicate for the left header
      #
      # @return [Function]
      #
      # @api private
      attr_reader :left

      # Returns the predicate for the right header
      #
      # @return [Function]
      #
      # @api private
      attr_reader :right

      # Returns the remainder predicate
      #
      # @return [Function]
      #
      # @api private
      attr_reader :remainder

      # Initialize a Predication Partition
      #
      # @example
      #   partition = PredicatePartition.new(predicate, left_header, right_header)
      #
      # @param [Function] predicate
      #
      # @param [Header] left_header
      #
      # @param [Header] right_header
      #
      # @return [undefined]
      #
      # @api private
      def initialize(predicate, left_header, right_header)
        @left      = TAUTOLOGY
        @right     = TAUTOLOGY
        @remainder = TAUTOLOGY

        @left_header  = left_header
        @right_header = right_header

        partition(predicate)
      end

    private

      # Partition the predicate into a left, right and remainder predicates
      #
      # @param [Function] predicate
      #
      # @return [undefined]
      #
      # @api private
      def partition(predicate)
        each_operand(predicate) do |operand|
          case operand
          when Axiom::Function::Binary   then partition_binary(operand)
          when Axiom::Function::Unary    then partition_unary(operand)
          when Axiom::Attribute::Boolean then partition_attribute(operand)
          else
            partition_proposition(operand)
          end
        end
      end

      # Partition the binary function up into a left, right and remainder predicates
      #
      # @param [Function::Binary] function
      #
      # @return [undefined]
      #
      # @api private
      def partition_binary(function)
        operands       = [function.left, function.right].grep(Axiom::Attribute)
        left_operands  = @left_header  & operands
        right_operands = @right_header & operands

        if (left_operands - right_operands).empty? || (right_operands - left_operands).empty?
          @left  &= function if left_operands.any?
          @right &= function if right_operands.any?
        else
          @remainder &= function
        end
      end

      # Partition the unary function up into the left and right predicates
      #
      # @param [Function::Unary] function
      #
      # @return [undefined]
      #
      # @api private
      def partition_unary(function)
        operand = function.operand
        @left  &= function if @left_header.include?(operand)
        @right &= function if @right_header.include?(operand)
      end

      # Partition the attribute up into the left and right predicates
      #
      # @param [Attribute] attribute
      #
      # @return [undefined]
      #
      # @api private
      def partition_attribute(attribute)
        @left  &= attribute if @left_header.include?(attribute)
        @right &= attribute if @right_header.include?(attribute)
      end

      # Partition the proposition up into the left, right and remainder predicates
      #
      # @param [Function::Proposition] proposition
      #
      # @return [undefined]
      #
      # @api private
      def partition_proposition(proposition)
        @remainder &= proposition
        @left      &= proposition
        @right     &= proposition
      end

      # Yield each operand in the predicate recursively
      #
      # @param [Function] predicate
      #
      # @yield [operand]
      #
      # @yieldparam [Function] operand
      #   each operand in the predicate
      #
      # @yieldreturn [undefined]
      #
      # @return [undefined]
      #
      # @api private
      def each_operand(predicate, &block)
        case predicate
        when Axiom::Function::Connective::Disjunction then each_operand(predicate.inverse.optimize, &block)
        when Axiom::Function::Connective::Conjunction then each_conjunction(predicate, &block)
        else
          block.call(predicate)
        end
      end

      # Yield each operand of the conjunction
      #
      # @param [Function::Connective::Conjunction] conjunction
      #
      # @yield [operand]
      #
      # @yieldparam [Function] operand
      #   each operand in the conjunction
      #
      # @yieldreturn [undefined]
      #
      # @return [undefined]
      #
      # @api private
      def each_conjunction(conjunction, &block)
        each_operand(conjunction.left,  &block)
        each_operand(conjunction.right, &block)
      end

    end # class PredicatePartition
  end # class Optimizer
end # module Axiom
