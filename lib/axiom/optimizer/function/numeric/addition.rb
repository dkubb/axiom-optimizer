# encoding: utf-8

module Axiom
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing Addition optimizations
        class Addition < self

          Axiom::Function::Numeric::Addition.optimizer = chain(
            ConstantOperands,
            UnoptimizedOperands
          )

        end # class Addition
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Axiom
