# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{veritas-optimizer}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Dan Kubb}]
  s.date = %q{2011-05-27}
  s.description = %q{Optimizes veritas relations}
  s.email = %q{dan.kubb@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc",
    "TODO"
  ]
  s.files = [
    ".gemtest",
    ".rvmrc",
    ".travis.yml",
    "Gemfile",
    "Guardfile",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "TODO",
    "config/flay.yml",
    "config/flog.yml",
    "config/roodi.yml",
    "config/site.reek",
    "config/yardstick.yml",
    "lib/veritas-optimizer.rb",
    "lib/veritas/optimizer.rb",
    "lib/veritas/optimizer/algebra/difference.rb",
    "lib/veritas/optimizer/algebra/extension.rb",
    "lib/veritas/optimizer/algebra/intersection.rb",
    "lib/veritas/optimizer/algebra/join.rb",
    "lib/veritas/optimizer/algebra/product.rb",
    "lib/veritas/optimizer/algebra/projection.rb",
    "lib/veritas/optimizer/algebra/rename.rb",
    "lib/veritas/optimizer/algebra/restriction.rb",
    "lib/veritas/optimizer/algebra/summarization.rb",
    "lib/veritas/optimizer/algebra/union.rb",
    "lib/veritas/optimizer/function.rb",
    "lib/veritas/optimizer/function/binary.rb",
    "lib/veritas/optimizer/function/connective/binary.rb",
    "lib/veritas/optimizer/function/connective/conjunction.rb",
    "lib/veritas/optimizer/function/connective/disjunction.rb",
    "lib/veritas/optimizer/function/connective/negation.rb",
    "lib/veritas/optimizer/function/numeric.rb",
    "lib/veritas/optimizer/function/numeric/addition.rb",
    "lib/veritas/optimizer/function/numeric/division.rb",
    "lib/veritas/optimizer/function/numeric/exponentiation.rb",
    "lib/veritas/optimizer/function/numeric/modulo.rb",
    "lib/veritas/optimizer/function/numeric/multiplication.rb",
    "lib/veritas/optimizer/function/numeric/subtraction.rb",
    "lib/veritas/optimizer/function/predicate.rb",
    "lib/veritas/optimizer/function/predicate/comparable.rb",
    "lib/veritas/optimizer/function/predicate/enumerable.rb",
    "lib/veritas/optimizer/function/predicate/equality.rb",
    "lib/veritas/optimizer/function/predicate/exclusion.rb",
    "lib/veritas/optimizer/function/predicate/greater_than.rb",
    "lib/veritas/optimizer/function/predicate/greater_than_or_equal_to.rb",
    "lib/veritas/optimizer/function/predicate/inclusion.rb",
    "lib/veritas/optimizer/function/predicate/inequality.rb",
    "lib/veritas/optimizer/function/predicate/less_than.rb",
    "lib/veritas/optimizer/function/predicate/less_than_or_equal_to.rb",
    "lib/veritas/optimizer/function/predicate/match.rb",
    "lib/veritas/optimizer/function/predicate/no_match.rb",
    "lib/veritas/optimizer/function/unary.rb",
    "lib/veritas/optimizer/optimizable.rb",
    "lib/veritas/optimizer/relation/materialized.rb",
    "lib/veritas/optimizer/relation/operation/binary.rb",
    "lib/veritas/optimizer/relation/operation/combination.rb",
    "lib/veritas/optimizer/relation/operation/limit.rb",
    "lib/veritas/optimizer/relation/operation/offset.rb",
    "lib/veritas/optimizer/relation/operation/order.rb",
    "lib/veritas/optimizer/relation/operation/reverse.rb",
    "lib/veritas/optimizer/relation/operation/unary.rb",
    "lib/veritas/optimizer/version.rb",
    "spec/integration/veritas/algebra/difference/optimize_spec.rb",
    "spec/integration/veritas/algebra/intersection/optimize_spec.rb",
    "spec/integration/veritas/algebra/join/optimize_spec.rb",
    "spec/integration/veritas/algebra/product/optimize_spec.rb",
    "spec/integration/veritas/algebra/projection/optimize_spec.rb",
    "spec/integration/veritas/algebra/rename/optimize_spec.rb",
    "spec/integration/veritas/algebra/restriction/optimize_spec.rb",
    "spec/integration/veritas/algebra/summarization/optimize_spec.rb",
    "spec/integration/veritas/algebra/union/optimize_spec.rb",
    "spec/integration/veritas/function/connective/conjunction/optimize_spec.rb",
    "spec/integration/veritas/function/connective/disjunction/optimize_spec.rb",
    "spec/integration/veritas/function/connective/negation/optimize_spec.rb",
    "spec/integration/veritas/function/optimize_spec.rb",
    "spec/integration/veritas/function/predicate/equality/optimize_spec.rb",
    "spec/integration/veritas/function/predicate/exclusion/optimize_spec.rb",
    "spec/integration/veritas/function/predicate/greater_than/optimize_spec.rb",
    "spec/integration/veritas/function/predicate/greater_than_or_equal_to/optimize_spec.rb",
    "spec/integration/veritas/function/predicate/inclusion/optimize_spec.rb",
    "spec/integration/veritas/function/predicate/inequality/optimize_spec.rb",
    "spec/integration/veritas/function/predicate/less_than/optimize_spec.rb",
    "spec/integration/veritas/function/predicate/less_than_or_equal_to/optimize_spec.rb",
    "spec/integration/veritas/relation/empty/optimize_spec.rb",
    "spec/integration/veritas/relation/materialized/optimize_spec.rb",
    "spec/integration/veritas/relation/operation/limit/optimize_spec.rb",
    "spec/integration/veritas/relation/operation/offset/optimize_spec.rb",
    "spec/integration/veritas/relation/operation/order/optimize_spec.rb",
    "spec/integration/veritas/relation/operation/reverse/optimize_spec.rb",
    "spec/integration/veritas/relation/optimize_spec.rb",
    "spec/rcov.opts",
    "spec/shared/function_connective_binary_optimize_behavior.rb",
    "spec/shared/idempotent_method_behavior.rb",
    "spec/shared/optimize_method_behavior.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "spec/support/add_method_missing.rb",
    "spec/unit/veritas/optimizer/algebra/difference/empty_left/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/difference/empty_right/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/difference/equal_operands/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/extension/unoptimized_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/extension/unoptimized_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/intersection/empty_left/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/intersection/empty_right/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/intersection/equal_operands/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/join/equal_headers/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/join/equal_headers/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/product/table_dee_left/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/product/table_dee_left/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/product/table_dee_right/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/product/table_dee_right/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/projection/empty_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/projection/empty_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/projection/header_spec.rb",
    "spec/unit/veritas/optimizer/algebra/projection/projection_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/projection/projection_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/projection/set_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/projection/set_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/projection/unchanged_header/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/projection/unchanged_header/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/projection/unoptimized_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/projection/unoptimized_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/aliases_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/class_methods/union_aliases_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/empty_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/empty_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/header_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/limit_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/limit_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/offset_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/offset_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/order_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/order_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/projection_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/projection_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/rename_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/rename_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/rename_operand_and_empty_aliases/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/rename_operand_and_empty_aliases/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/restriction_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/restriction_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/reverse_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/reverse_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/set_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/set_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/unchanged_header/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/unchanged_header/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/unoptimized_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/rename/unoptimized_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/class_methods/optimize_predicate_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/contradiction/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/contradiction/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/order_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/order_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/predicate_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/restriction_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/restriction_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/reverse_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/reverse_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/set_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/set_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/tautology/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/tautology/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/unoptimized_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/restriction/unoptimized_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/summarization/empty_operand/class_methods/extension_default_spec.rb",
    "spec/unit/veritas/optimizer/algebra/summarization/empty_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/summarization/empty_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/summarization/empty_summarize_per/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/summarization/empty_summarize_per/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/summarization/summarize_per_spec.rb",
    "spec/unit/veritas/optimizer/algebra/summarization/unoptimized_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/algebra/summarization/unoptimized_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/union/empty_left/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/union/empty_right/optimize_spec.rb",
    "spec/unit/veritas/optimizer/algebra/union/equal_operands/optimize_spec.rb",
    "spec/unit/veritas/optimizer/class_methods/chain_spec.rb",
    "spec/unit/veritas/optimizer/function/binary/constant_operands/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/binary/constant_operands/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/binary/left_spec.rb",
    "spec/unit/veritas/optimizer/function/binary/right_spec.rb",
    "spec/unit/veritas/optimizer/function/class_methods/optimize_operand_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/binary/constant_operands/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/binary/equal_operands/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/binary/equal_operands/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/binary/left_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/binary/redundant_left_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/binary/redundant_left_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/binary/redundant_right_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/binary/redundant_right_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/binary/right_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/binary/unoptimized_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/binary/unoptimized_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/conjunction/contradiction/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/conjunction/contradiction/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/conjunction/left_operand_tautology/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/conjunction/left_operand_tautology/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/conjunction/optimizable_to_exclusion/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/conjunction/optimizable_to_exclusion/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/conjunction/right_operand_tautology/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/conjunction/right_operand_tautology/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/disjunction/contradiction_left_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/disjunction/contradiction_left_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/disjunction/contradiction_right_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/disjunction/contradiction_right_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/disjunction/optimizable_to_inclusion/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/disjunction/optimizable_to_inclusion/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/disjunction/tautology/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/disjunction/tautology/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/negation/invertible_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/negation/invertible_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/connective/negation/operand_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/comparable/never_comparable/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/comparable/never_equivalent/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/comparable/normalizable_operands/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/comparable/normalizable_operands/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/constant_operands/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/contradiction/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/enumerable/class_methods/sort_by_value_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/enumerable/empty_right_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/enumerable/one_right_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/enumerable/unoptimized_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/enumerable/unoptimized_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/equality/tautology/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/exclusion/empty_right_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/exclusion/one_right_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/greater_than/contradiction/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/greater_than/tautology/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/greater_than_or_equal_to/contradiction/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/greater_than_or_equal_to/tautology/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/inclusion/empty_right_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/inclusion/one_right_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/inequality/contradiction/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/less_than/contradiction/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/less_than/tautology/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/less_than_or_equal_to/contradiction/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/less_than_or_equal_to/tautology/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/predicate/tautology/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/unary/constant_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/function/unary/constant_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/function/unary/operand_spec.rb",
    "spec/unit/veritas/optimizer/function/util/class_methods/attribute_spec.rb",
    "spec/unit/veritas/optimizer/function/util/class_methods/constant_spec.rb",
    "spec/unit/veritas/optimizer/function/util/class_methods/max_spec.rb",
    "spec/unit/veritas/optimizer/function/util/class_methods/min_spec.rb",
    "spec/unit/veritas/optimizer/operation_spec.rb",
    "spec/unit/veritas/optimizer/optimizable/class_methods/optimizer_spec.rb",
    "spec/unit/veritas/optimizer/optimizable/optimize_spec.rb",
    "spec/unit/veritas/optimizer/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/materialized/empty_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/materialized/empty_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/binary/empty_left/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/binary/empty_right/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/binary/equal_operands/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/binary/left_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/binary/materialized_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/binary/materialized_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/binary/right_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/binary/unoptimized_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/binary/unoptimized_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/combination/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/limit/equal_limit_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/limit/equal_limit_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/limit/limit_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/limit/limit_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/limit/unoptimized_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/limit/unoptimized_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/limit/zero_limit/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/limit/zero_limit/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/offset/offset_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/offset/offset_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/offset/unoptimized_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/offset/unoptimized_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/offset/zero_offset/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/offset/zero_offset/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/order/one_limit_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/order/one_limit_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/order/order_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/order/order_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/order/unoptimized_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/order/unoptimized_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/reverse/order_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/reverse/order_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/reverse/reverse_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/reverse/reverse_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/reverse/unoptimized_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/reverse/unoptimized_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/unary/empty_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/unary/empty_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/unary/materialized_operand/optimizable_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/unary/materialized_operand/optimize_spec.rb",
    "spec/unit/veritas/optimizer/relation/operation/unary/operand_spec.rb",
    "tasks/metrics/ci.rake",
    "tasks/metrics/flay.rake",
    "tasks/metrics/flog.rake",
    "tasks/metrics/heckle.rake",
    "tasks/metrics/metric_fu.rake",
    "tasks/metrics/reek.rake",
    "tasks/metrics/roodi.rake",
    "tasks/metrics/yardstick.rake",
    "tasks/spec.rake",
    "tasks/yard.rake",
    "veritas-optimizer.gemspec"
  ]
  s.homepage = %q{https://github.com/dkubb/veritas-optimizer}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.4}
  s.summary = %q{Relational algebra optimizer}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<veritas>, ["= 0.0.4"])
      s.add_development_dependency(%q<backports>, ["~> 2.2.1"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.0"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.0"])
      s.add_development_dependency(%q<rspec>, ["~> 1.3.2"])
      s.add_development_dependency(%q<yard>, ["~> 0.7.1"])
    else
      s.add_dependency(%q<veritas>, ["= 0.0.4"])
      s.add_dependency(%q<backports>, ["~> 2.2.1"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.0"])
      s.add_dependency(%q<rake>, ["~> 0.9.0"])
      s.add_dependency(%q<rspec>, ["~> 1.3.2"])
      s.add_dependency(%q<yard>, ["~> 0.7.1"])
    end
  else
    s.add_dependency(%q<veritas>, ["= 0.0.4"])
    s.add_dependency(%q<backports>, ["~> 2.2.1"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.0"])
    s.add_dependency(%q<rake>, ["~> 0.9.0"])
    s.add_dependency(%q<rspec>, ["~> 1.3.2"])
    s.add_dependency(%q<yard>, ["~> 0.7.1"])
  end
end

