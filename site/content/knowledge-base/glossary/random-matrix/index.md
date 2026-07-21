---
title: "Random matrix"
slug: "random-matrix"
summary: "A random matrix is a measurable rule that assigns a matrix to each outcome of a probability experiment."
draft: true
pro_reviewed: false
toc: false
---

A **random matrix** is a matrix-valued random variable. Begin with a probability
space \((\Omega,\mathcal F,\mathbb P)\). A random matrix is a measurable
map

\[
X : \Omega \longrightarrow \mathbb K^{m\times n},
\]

where \(\mathbb K\) is commonly \(\mathbb R\) or
\(\mathbb C\). An outcome \(\omega\) selects one ordinary matrix
\(X(\omega)\).

This definition separates three objects that are easy to blur together:

| Object | What it is | Typical notation |
|---|---|---|
| Sample space | All possible outcomes | \(\Omega\) |
| Random matrix | The rule from outcomes to matrices | \(X\) |
| Realized matrix | One matrix after choosing an outcome | \(X(\omega)\) |

The distribution, or **law**, of \(X\) is a probability measure on the
matrix space induced by this map. The function and its law are related, but
they are not the same object.

## Entries are random variables

For fixed row \(i\) and column \(j\),

\[
\omega \longmapsto X(\omega)_{ij}
\]

is an ordinary scalar random variable. This coordinate view is useful for
constructing ensembles, stating moment conditions, and proving measurability.
It does **not** imply that different coordinates are independent.

For example, a {{< refterm "hermitian-matrix" "Hermitian" >}} random matrix
must satisfy
\(X_{ji}=\overline{X_{ij}}\). Its lower-triangular entries are determined
by the upper triangle, so treating every coordinate as independent would
contradict the symmetry.

The {{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}
makes the nonredundant primitive positions explicit: real diagonal values and
complex strict-upper values are supplied, while the lower triangle is filled
by conjugate reflection.

## In Lean

The first project definition deliberately contains only the underlying
matrix-valued map:

```lean
abbrev RandomMatrix
    (Ω : Type uΩ) (ι : Type uι) (κ : Type uκ) (𝕜 : Type u𝕜) :=
  Ω → Matrix ι κ 𝕜
```

Measurability, a probability measure on \(\Omega\), symmetry, entry
laws, and independence are added as separate hypotheses. That choice keeps the
base type reusable for deterministic matrices, random Jacobians, matrix
products, and Gaussian ensembles.

{{< panel "warning" >}}
**Common overread.** The word "random" does not mean that every entry is
independent or identically distributed. Those are additional properties of a
particular ensemble.
{{< /panel >}}

Related concepts: {{< refterm "measurable-space" "measurable space" >}},
{{< refterm "conjugate-transpose" "conjugate transpose" >}}, and
{{< refterm "almost-everywhere" "almost everywhere" >}}. For the deterministic
assembly bridge, continue to
[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}}).

Further reading: Terence Tao's
[Topics in Random Matrix Theory](https://doi.org/10.1090/gsm/132)
develops the finite-dimensional subject from probabilistic tools to spectral
laws. The [author's book page](https://teorth.github.io/tao-web/topics-in-random-matrix-theory.html)
links an online draft, course notes, and errata.
