# encoding: utf-8

module Axiom
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing Modulo optimizations
        class Modulo < self

          Axiom::Function::Numeric::Modulo.optimizer = chain(
            ConstantOperands,
            UnoptimizedOperands
          )

        end # class Modulo
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Axiom
