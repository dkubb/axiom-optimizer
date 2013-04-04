# encoding: utf-8

module Axiom
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing UnaryMinus optimizations
        class UnaryMinus < self

          Axiom::Function::Numeric::UnaryMinus.optimizer = chain(
            ConstantOperand,
            UnoptimizedOperand
          )

        end # class UnaryMinus
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Axiom
