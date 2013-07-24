# encoding: utf-8

module Axiom
  class Optimizer

    # Allow operations to be optimizable
    module Optimizable
      include Adamantium

      # Hook called when module is included
      #
      # @param [Module] descendant
      #   the module or class including Optimizable
      #
      # @return [self]
      #
      # @api private
      def self.included(descendant)
        descendant.extend ClassMethods
        self
      end

      # Optimize the operation
      #
      # @example
      #   optimized = operation.optimize
      #
      # @return [Optimizable]
      #   the optimized operation
      #
      # @api public
      #
      # @todo simplify by setting a default Identity optimizer for all relations
      def optimize
        optimizer = self.class.optimizer || Optimizer::Identity
        optimized = optimizer.call(self)
        if equal?(optimized)                   then self
        elsif optimized.respond_to?(:optimize) then optimized.optimize
        else
          optimized
        end
      end

      memoize :optimize

      module ClassMethods

        # The Optimizer for the operation
        #
        # @return [Optimizable]
        #
        # @api private
        attr_accessor :optimizer

      end # module ClassMethods
    end # module Optimizable
  end # class Optimizer
end # module Axiom

Axiom::Aggregate.class_eval { include Axiom::Optimizer::Optimizable }
Axiom::Function.class_eval  { include Axiom::Optimizer::Optimizable }
Axiom::Relation.class_eval  { include Axiom::Optimizer::Optimizable }
