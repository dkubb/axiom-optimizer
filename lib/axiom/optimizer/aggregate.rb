# encoding: utf-8

module Axiom
  class Optimizer

    # Abstract base class representing Aggregate optimizations
    class Aggregate < Optimizer
      include AbstractType, Function::Unary

      # Optimize when the operands are unoptimized
      class UnoptimizedOperand < self
        include Function::Unary::UnoptimizedOperand
      end # class UnoptimizedOperand
    end # class Aggregate
  end # class Optimizer
end # module Axiom
