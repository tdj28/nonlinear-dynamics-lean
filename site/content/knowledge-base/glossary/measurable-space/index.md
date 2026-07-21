---
title: "Measurable space"
slug: "measurable-space"
summary: "A measurable space specifies which questions about an outcome count as observable events."
draft: true
pro_reviewed: false
toc: false
---

A **measurable space** is a set of possible outcomes together with a disciplined
collection of subsets called measurable sets. Those subsets are the events to
which a measure, and eventually a probability, may assign a size.

If the outcome set is \(\Omega\), write its measurable sets as
\(\mathcal F\). The pair \((\Omega,\mathcal F)\) is a measurable
space when:

1. \(\Omega\) itself belongs to \(\mathcal F\);
2. the complement of every set in \(\mathcal F\) is also in
   \(\mathcal F\); and
3. a countable union of sets in \(\mathcal F\) remains in
   \(\mathcal F\).

These closure rules form a **sigma-algebra**. They let us combine observable
questions without leaving the world in which a measure is defined.

## Why a function must be measurable

Suppose \(f : \Omega \to Y\) turns an outcome into a value. The function is
measurable when every measurable question about \(f(\omega)\) pulls back to a
measurable question about \(\omega\):

\[
B \text{ measurable in }Y
\quad\Longrightarrow\quad
f^{-1}(B) \text{ measurable in }\Omega.
\]

The direction matters. We ask which original outcomes land inside a target
event. Probability can then evaluate that preimage.

## The matrix case

A matrix is determined by its entries. The natural measurable structure on a
matrix space therefore treats every coordinate lookup
\(A \mapsto A_{ij}\) as measurable. A matrix-valued function is measurable
exactly when every scalar entry is measurable.

That coordinate principle is the bridge used in the formalization. It turns a
large target object into a family of ordinary scalar proof obligations.

{{< panel "info" >}}
**What this does not say.** A measurable matrix-valued function need not have
independent entries, Gaussian entries, finite moments, or any particular
distribution. Measurability only makes probabilistic questions well-formed.
{{< /panel >}}

## In Lean

Mathlib represents the structure with `MeasurableSpace α` and the property
of a function with `Measurable f`. This project gives matrices the entrywise
structure by pulling back the product structure along the equivalence between
matrices and two-argument functions:

```lean
instance instMeasurableSpaceMatrix [MeasurableSpace 𝕜] :
    MeasurableSpace (Matrix ι κ 𝕜) :=
  MeasurableSpace.comap Matrix.of.symm inferInstance
```

The accompanying theorem `measurable_iff_entries` then exposes the intended
coordinate criterion.

Related concepts: {{< refterm "random-matrix" "random matrix" >}} and
{{< refterm "almost-everywhere" "almost everywhere" >}}.

Further reading: Mathlib's
[measurable-space documentation](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/MeasurableSpace/Basic.html)
states the underlying definitions and implementation conventions.
