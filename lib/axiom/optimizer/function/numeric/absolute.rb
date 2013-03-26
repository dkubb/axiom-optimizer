# encoding: utf-8

module Axiom
  class Optimizer
    module Function
      class Numeric

        # Abstract base class representing Absolute optimizations
        class Absolute < self

          Axiom::Function::Numeric::Absolute.optimizer = chain(
            ConstantOperand,
            UnoptimizedOperand
          )

        end # class Absolute
      end # class Numeric
    end # module Function
  end # class Optimizer
end # module Axiom
