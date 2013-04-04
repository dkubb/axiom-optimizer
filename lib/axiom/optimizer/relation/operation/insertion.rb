# encoding: utf-8

module Axiom
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Difference optimizations
        class Insertion < Relation::Operation::Binary

          Axiom::Relation::Operation::Insertion.optimizer = chain(
            MaterializedOperands,
            UnoptimizedOperands
          )

        end # class Insertion
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Axiom
