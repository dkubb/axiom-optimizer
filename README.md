# axiom-optimizer

Relational algebra optimizer

[![Gem Version](https://badge.fury.io/rb/axiom-optimizer.png)][gem]
[![Build Status](https://secure.travis-ci.org/dkubb/axiom-optimizer.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/dkubb/axiom-optimizer.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/dkubb/axiom-optimizer.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/dkubb/axiom-optimizer/badge.png?branch=master)][coveralls]

[gem]: https://rubygems.org/gems/axiom-optimizer
[travis]: https://travis-ci.org/dkubb/axiom-optimizer
[gemnasium]: https://gemnasium.com/dkubb/axiom-optimizer
[codeclimate]: https://codeclimate.com/github/dkubb/axiom-optimizer
[coveralls]: https://coveralls.io/r/dkubb/axiom-optimizer

## Examples

```ruby
# optimize a relation
new_relation = relation.optimize
new_relation = relation.optimize(optimizer)

# optimize a scalar function
new_function = function.optimize
new_function = function.optimize(optimizer)

# optimize an aggregate function
new_aggregate = function.aggregate
new_aggregate = function.aggregate(optimizer)
```

## Description

The purpose of this gem is to provide a simple API that can be used to optimize a [axiom](https://github.com/dkubb/axiom) relation, scalar or aggregate function. An optional optimizer can be passed in to the #optimize method and return an equivalent but simplified version of the object.

One of the primary benefits of Relational Algebra is that it's based on logic, and the rules for simplifying logic are well known and studied. An optimizer can pass through user-generated objects and typically find ways to simplify or organize them in a way that will be more efficient when the operation is executed.

The goal is not to replace the advanced optimizers that are inside most databases and datastores, but to augment it with some simple optimizations that make the user provided query easier for the datastore to accept. On the ruby side we have knowledge about intent and can perform semantic optimization that the datastore otherwise would not be able to perform. In many cases we have richer constraints and data than many datastores and we can use that information to simplify and possibly short-circuit queries that could otherwise never return valid results.

With the ability to provide custom optimizers we can even target output to a structure optimized for specific datastores. All operations in relational algebra can be transformed into other equivalent operations, ones that are more efficient for the target datastore to execute. The built-in optimizers included in this gem are only a starting point; the intention is to expand them as well as help others create custom optimizers that are optimized for each datastore.

## Design

The contract for an optimizer instance is simple:

1. it must respond to #call, and accept an optimizable object as it's only argument
2. it must return an equivalent object
3. it must return the exact object when it cannot perform further optimizations

The optimizer can perform whatever logic it wishes on the object or any of it's contained objects as far down the tree as it likes as long as the requirements for (2) and (3) are met.

Inside this gem we have the concept of an optimizer chain. It's a chain of responsibility, which means it's a set of objects chained together to form a pipeline. The object is passed into the head of the pipeline and is either matched and returned by one of the optimizers, or it is already fully optimized and passes through to the end of the chain and is returned as-is. This chain organization has proven to be extremely effective, and it is trivial to re-order or add new optimizers into the middle of the chain as needed. Further work will be made to provide APIs to make this even simpler.

Here is an example of an optimizer chain for the restriction operator (think WHERE clause in SQL):

```ruby
Axiom::Algebra::Restriction.optimizer = chain(
  Tautology,            # does the predicate match everything?
  Contradiction,        # does the predicate match nothing?
  RestrictionOperand,   # does the restriction contain another restriction?
  SetOperand,           # does the restriction contain a set operation?
  SortedOperand,        # does the restriction contain a sorted relation?
  EmptyOperand,         # does the restriction contain an empty relation?
  MaterializedOperand,  # does the restriction contain a materialized relation?
  UnoptimizedOperand    # does the restriction contain an unoptimized relation?
)
```

The restriction operator enters this pipeline, and tests are made at each stage. If the test returns true, then an optimization is performed. Usually the goal is to eliminate work performed by the system or collapse the tree of operations down into something simpler. More aggressive optimizations are usually checked first because we would like to prune as much of the tree as possible up-front. In this case, the first test checks to see if the restriction matches everything, in which case it's pretty much a no-op, and we can drop it altogether. If that's not the case, we then test to see if it matches nothing, if that's the case then we can return an empty relation. Then we test if it's another restriction, in which case we can "AND" the predicates for both restrictions together and return a single restriction operation. And so on down the list with the first match winning.

We always perform at least two optimization passes on each object, because once a tree has been simplified there could be further optimizations possible. Essentially we keep passing the objects into their corresponding optimizer chains until it passes through unchanged. This may seem rather expensive, and I guess it is, but optimization is very fast. Also it doesn't appear to affect performance much in practice due to our convention of testing for the most aggressive optimizations first; often it results in something that is completely optimized on the first try.

Once the optimization passes are finished, and no further optimization is possible, the result of an #optimize call is memoized. Further calls to #optimize will always return the same object.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## Copyright

Copyright &copy; 2011-2013 Dan Kubb. See LICENSE for details.
