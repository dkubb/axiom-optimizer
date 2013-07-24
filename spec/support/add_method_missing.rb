# encoding: utf-8

module AddMethodMissing
  def add_method_missing(name = :described_class)
    before do
      # when #optimize delegates to super, it would normally
      # explode, so define method_missing to return self
      public_send(name).class_eval do
        undef_method :method_missing
        define_method(:method_missing) { self }
      end
    end
  end
end
