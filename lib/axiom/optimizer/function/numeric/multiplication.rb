# encoding: utf-8

module Axiom
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing Multiplication optimizations
        class Multiplication < self

          Axiom::Function::Numeric::Multiplication.optimizer = chain(
            ConstantOperands,
            UnoptimizedOperands
          )

        end # class Multiplication
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Axiom
