# encoding: utf-8

module Axiom
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing Subtraction optimizations
        class Subtraction < self

          Axiom::Function::Numeric::Subtraction.optimizer = chain(
            ConstantOperands,
            UnoptimizedOperands
          )

        end # class Subtraction
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Axiom
