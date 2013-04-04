# encoding: utf-8

module Axiom
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Difference optimizations
        class Deletion < Relation::Operation::Binary

          Axiom::Relation::Operation::Deletion.optimizer = chain(
            MaterializedOperands,
            UnoptimizedOperands
          )

        end # class Deletion
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Axiom
