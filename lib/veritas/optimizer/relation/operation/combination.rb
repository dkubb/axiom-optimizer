# encoding: utf-8

module Veritas
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing combinations of relations
        class Combination < Binary

          # Any relation combined with an empty relation is an empty relation
          #
          # @return [Relation::Empty]
          #
          # @api private
          def optimize
            operation = self.operation
            Veritas::Relation::Empty.new(operation.header, operation)
          end

          # Optimize when the left operand is Empty
          class EmptyLeft < self
            include Binary::EmptyLeft
          end # class EmptyLeft

          # Optimize when the right operand is Empty
          class EmptyRight < self
            include Binary::EmptyRight
          end # class EmptyRight
        end # class Combination
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
