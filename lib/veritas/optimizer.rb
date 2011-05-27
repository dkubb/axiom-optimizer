# encoding: utf-8

require 'veritas'

module Veritas

  # A optimization for an operation
  class Optimizer
    include AbstractClass, Immutable

    # A noop optimizer that returns the operation as-is
    Noop = lambda { |operation| operation }.freeze

    # The operation to optimize
    #
    # @return [Optimizable]
    #
    # @api private
    attr_reader :operation

    # Initialize an Optimizer
    #
    # @param [Optimizable] operation
    #   the operation to optimize
    #
    # @return [undefined]
    #
    # @api private
    def initialize(operation)
      @operation = operation
    end

    # Abstract method that tests if the optimization should be applied
    #
    # @example
    #   optimizer.optimizable?  # => true or false
    #
    # @return [Boolean]
    #
    # @api public
    def optimizable?
      raise NotImplementedError, "#{self.class}#optimizable? must be implemented"
    end

    # Abstract method that executes the optimization for the operation
    #
    # @example
    #   optimized = optimizer.optimize
    #
    # @return [Optimizable]
    #
    # @api public
    def optimize
      raise NotImplementedError, "#{self.class}#optimize must be implemented"
    end

    # Chain together a list of optimizer classes into a callable object
    #
    # @example
    #   Optimizer.chain(Optimizer::Foo, Optimizer::Bar)
    #
    # @param [Array<Class<Optimizer>>] *optimizers
    #   a list of optimizer classes to apply
    #
    # @return [#call]
    #
    # @api public
    def self.chain(*optimizers)
      optimizers.reverse_each.reduce(Noop) do |successor, optimizer|
        link_optimizers(optimizer, successor)
      end
    end

    # Link an optimizer to a successor
    #
    # @param [Class<Optimizer>] optimizer
    #   the optimizer to link to the successor
    # @param [#proc] successor
    #   the next optimizer to call if the current optimizer is not applied
    #
    # @return [#call]
    #
    # @api private
    def self.link_optimizers(optimizer, successor)
      lambda do |operation|
        op = optimizer.new(operation)
        op.optimizable? ? op.optimize : successor.call(operation)
      end
    end

    private_class_method :link_optimizers

  end # class Optimizer
end # module Veritas

require 'veritas/optimizer/version'

require 'veritas/optimizer/optimizable'

require 'veritas/optimizer/relation/materialized'

require 'veritas/optimizer/relation/operation/binary'
require 'veritas/optimizer/relation/operation/unary'
require 'veritas/optimizer/relation/operation/combination'
require 'veritas/optimizer/relation/operation/limit'
require 'veritas/optimizer/relation/operation/offset'
require 'veritas/optimizer/relation/operation/order'
require 'veritas/optimizer/relation/operation/reverse'

require 'veritas/optimizer/algebra/difference'
require 'veritas/optimizer/algebra/extension'
require 'veritas/optimizer/algebra/intersection'
require 'veritas/optimizer/algebra/join'
require 'veritas/optimizer/algebra/product'
require 'veritas/optimizer/algebra/projection'
require 'veritas/optimizer/algebra/rename'
require 'veritas/optimizer/algebra/restriction'
require 'veritas/optimizer/algebra/summarization'
require 'veritas/optimizer/algebra/union'

require 'veritas/optimizer/function/binary'

require 'veritas/optimizer/function/connective/binary'
require 'veritas/optimizer/function/connective/conjunction'
require 'veritas/optimizer/function/connective/disjunction'
require 'veritas/optimizer/function/connective/negation'

require 'veritas/optimizer/function/predicate'
require 'veritas/optimizer/function/predicate/comparable'
require 'veritas/optimizer/function/predicate/enumerable'
require 'veritas/optimizer/function/predicate/equality'
require 'veritas/optimizer/function/predicate/exclusion'
require 'veritas/optimizer/function/predicate/greater_than'
require 'veritas/optimizer/function/predicate/greater_than_or_equal_to'
require 'veritas/optimizer/function/predicate/inequality'
require 'veritas/optimizer/function/predicate/inclusion'
require 'veritas/optimizer/function/predicate/less_than'
require 'veritas/optimizer/function/predicate/less_than_or_equal_to'
