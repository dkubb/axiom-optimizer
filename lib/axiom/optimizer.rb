# encoding: utf-8

require 'axiom'

module Axiom

  # A optimization for an operation
  class Optimizer
    include AbstractType, Adamantium

    # An optimizer that returns the operation
    Identity = ->(operation) { operation }.freeze

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
    abstract_method :optimizable?

    # Abstract method that executes the optimization for the operation
    #
    # @example
    #   optimized = optimizer.optimize
    #
    # @return [Optimizable]
    #
    # @api public
    abstract_method :optimize

    # Chain together a list of optimizer classes into a callable object
    #
    # @example
    #   Optimizer.chain(Optimizer::Foo, Optimizer::Bar)
    #
    # @param [Array<Class<Optimizer>>] optimizers
    #   a list of optimizer classes to apply
    #
    # @return [#call]
    #
    # @api public
    def self.chain(*optimizers)
      optimizers.reverse_each.reduce(Identity) do |successor, optimizer|
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
end # module Axiom

require 'axiom/optimizer/version'

require 'axiom/optimizer/support/predicate_partition'

require 'axiom/optimizer/optimizable'

require 'axiom/optimizer/function'
require 'axiom/optimizer/function/binary'
require 'axiom/optimizer/function/unary'

require 'axiom/optimizer/relation/materialized'

require 'axiom/optimizer/relation/operation/binary'
require 'axiom/optimizer/relation/operation/unary'
require 'axiom/optimizer/relation/operation/combination'
require 'axiom/optimizer/relation/operation/limit'
require 'axiom/optimizer/relation/operation/offset'
require 'axiom/optimizer/relation/operation/sorted'
require 'axiom/optimizer/relation/operation/reverse'

require 'axiom/optimizer/algebra/difference'
require 'axiom/optimizer/algebra/extension'
require 'axiom/optimizer/algebra/intersection'
require 'axiom/optimizer/algebra/join'
require 'axiom/optimizer/algebra/product'
require 'axiom/optimizer/algebra/projection'
require 'axiom/optimizer/algebra/rename'
require 'axiom/optimizer/algebra/restriction'
require 'axiom/optimizer/algebra/summarization'
require 'axiom/optimizer/algebra/union'

require 'axiom/optimizer/relation/operation/deletion'
require 'axiom/optimizer/relation/operation/insertion'

require 'axiom/optimizer/function/connective/binary'
require 'axiom/optimizer/function/connective/conjunction'
require 'axiom/optimizer/function/connective/disjunction'
require 'axiom/optimizer/function/connective/negation'

require 'axiom/optimizer/function/predicate'
require 'axiom/optimizer/function/predicate/comparable'
require 'axiom/optimizer/function/predicate/enumerable'
require 'axiom/optimizer/function/predicate/equality'
require 'axiom/optimizer/function/predicate/exclusion'
require 'axiom/optimizer/function/predicate/greater_than'
require 'axiom/optimizer/function/predicate/greater_than_or_equal_to'
require 'axiom/optimizer/function/predicate/inequality'
require 'axiom/optimizer/function/predicate/inclusion'
require 'axiom/optimizer/function/predicate/less_than'
require 'axiom/optimizer/function/predicate/less_than_or_equal_to'

require 'axiom/optimizer/function/numeric'
require 'axiom/optimizer/function/numeric/absolute'
require 'axiom/optimizer/function/numeric/addition'
require 'axiom/optimizer/function/numeric/division'
require 'axiom/optimizer/function/numeric/exponentiation'
require 'axiom/optimizer/function/numeric/modulo'
require 'axiom/optimizer/function/numeric/multiplication'
require 'axiom/optimizer/function/numeric/square_root'
require 'axiom/optimizer/function/numeric/subtraction'
require 'axiom/optimizer/function/numeric/unary_minus'
require 'axiom/optimizer/function/numeric/unary_plus'

require 'axiom/optimizer/function/string/length'

require 'axiom/optimizer/aggregate'
require 'axiom/optimizer/aggregate/count'
require 'axiom/optimizer/aggregate/maximum'
require 'axiom/optimizer/aggregate/mean'
require 'axiom/optimizer/aggregate/minimum'
require 'axiom/optimizer/aggregate/sum'
require 'axiom/optimizer/aggregate/variance'
require 'axiom/optimizer/aggregate/standard_deviation'
