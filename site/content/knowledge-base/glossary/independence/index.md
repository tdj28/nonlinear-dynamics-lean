---
title: "Independence"
slug: "independence"
summary: "Independence says that joint probabilities factor into products of marginal probabilities for every measurable choice of events."
draft: false
pro_reviewed: false
toc: true
og_image: "independence-card.png"
og_image_alt: "A two-by-two probability grid has four equally weighted joint outcomes and one-half margins, so every cell equals the product of its margins."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

Two random variables are **independent** when learning the value of one does
not change the probability law of the other. The precise definition does not
depend on informal notions such as separate causes or unrelated formulas. It
requires a factorization identity for every pair of measurable target events.

Let \(X:\Omega\to S\) and \(Y:\Omega\to T\) be random
variables under a probability measure \(\mathbb P\). They are independent if

\[
\mathbb P\{X\in A,\ Y\in B\}
=\mathbb P\{X\in A\}\,\mathbb P\{Y\in B\}
\]

for every measurable \(A\subseteq S\) and \(B\subseteq T\).
Equivalently, the joint {{< refterm "probability-law" "probability law" >}}
of \((X,Y)\) is the product of the two marginal laws:

\[
\mathcal L(X,Y)=\mathcal L(X)\otimes\mathcal L(Y).
\]

The symbol \(\otimes\) here denotes a product measure, not a tensor product of
vectors.

## A complete finite example

Let \(X\) and \(Y\) be independent fair bits, each taking values \(0\) and
\(1\) with probability \(1/2\). Their four joint outcomes have probabilities

\[
\mathbb P\{X=x,Y=y\}=\frac{1}{4}
\qquad
\text{for every }(x,y)\in\{0,1\}^2.
\]

For example,

\[
\mathbb P\{X=1,Y=0\}
=\frac{1}{4}
=\frac{1}{2}\cdot\frac{1}{2}
=\mathbb P\{X=1\}\mathbb P\{Y=0\}.
\]

{{< reference-figure
  src="independence-factorization.svg"
  alt="Four joint outcomes each have probability one quarter, while every row and column margin is one half, so cell probabilities factor into their margins."
  caption="**Finding:** independence is visible as factorization of every joint cell into its row and column margins. These are exact toy probabilities. Equal-looking marginals alone would not force the four joint cells to have these values."
>}}

Now define \(Y=X\) using one fair bit. The marginals of \(X\) and \(Y\)
are still identical and fair, but

\[
\mathbb P\{X=1,Y=1\}=\frac{1}{2}
\ne\frac{1}{4}
=\mathbb P\{X=1\}\mathbb P\{Y=1\}.
\]

The copied variables are maximally dependent. This comparison shows why
knowing every one-variable law is insufficient to recover a joint law.

## Families need mutual independence

For an indexed family \((X_i)_{i\in I}\), **mutual independence** means
that every finite subfamily factors. If \(J\subseteq I\) is finite and each
\(A_j\) is measurable, then

\[
\mathbb P\!\left(\bigcap_{j\in J}\{X_j\in A_j\}\right)
=\prod_{j\in J}\mathbb P\{X_j\in A_j\}.
\]

Pairwise independence checks only two indices at a time. It does not imply
mutual independence. A standard exact counterexample uses two independent fair
bits \(U,V\) and their exclusive-or \(W=U\oplus V\). Each pair among
\(U,V,W\) is independent, but the triple is constrained by \(W=U\oplus V\),
so its joint law is not the product of three fair-bit laws.

For finite Gaussian coordinates, the project uses mutual independence. That
is the condition that turns exact coordinate laws into one exact finite product
law.

## Independence is not identical distribution

The letters in "independent and identically distributed" name two separate
properties:

- **independent** specifies how the joint law factors;
- **identically distributed** says the marginal laws are equal.

A family can be independent with different means and variances. Conversely,
several coordinates can have the same marginal law while being dependent, as
the copied-bit example shows.

Independence also differs from zero covariance. With finite second moments,
independence implies zero covariance. Zero covariance alone usually does not
imply independence. Jointly Gaussian variables form an important special
setting in which appropriate covariance information can characterize
independence, but that stronger theorem requires joint Gaussianity, not merely
Gaussian marginal laws.

## Independence survives coordinatewise measurable transformations

If \((X_i)_{i\in I}\) is mutually independent and each \(f_i\) is a
measurable function on the target of \(X_i\), then the transformed family
\((f_i(X_i))_{i\in I}\) remains independent. Each new coordinate reveals no
more information than its original coordinate.

This closure is essential for normalization. Starting from independent
standard Gaussian variables, one may scale coordinate \(i\) by its own
constant and shift it by its own mean without introducing dependence. The
project's finite family theorem <code>IndependentRealGaussianFamily.scale</code>
formalizes the scaling part while preserving ordinary coordinate
measurability, exact laws, and <code>iIndepFun</code> as separate obligations.

## The pinned Lean representation

Mathlib 4.32.0 defines:

```lean
#check ProbabilityTheory.IndepFun
#check ProbabilityTheory.iIndepFun
#check ProbabilityTheory.iIndepFun.hasLaw_pi
```

<code>IndepFun X Y P</code>, also written <code>X ⟂ᵢ[P] Y</code> in the
<code>ProbabilityTheory</code> scope, handles two functions. The indexed
predicate <code>iIndepFun X P</code> handles a family whose target type may
depend on the index. Both definitions work through the measurable structures
generated by the functions.

The project bundles exactly the ingredients needed later:

```lean
structure IndependentRealGaussianFamily
    (X : ι → Ω → ℝ) (m : ι → ℝ) (v : ι → ℝ≥0)
    (P : Measure Ω) : Prop where
  measurable : ∀ i, Measurable (X i)
  hasLaw : ∀ i, HasRealGaussianLaw (X i) (m i) (v i) P
  independent : iIndepFun X P
```

Ordinary coordinate measurability is explicit even though each exact law also
supplies almost-everywhere measurability. For finite index types, the theorem
<code>IndependentRealGaussianFamily.jointHasLaw</code> concludes

```text
HasLaw (fun ω i ↦ X i ω)
  (Measure.pi fun i ↦ gaussianReal (m i) (v i)) P
```

This is a statement about the complete joint law. It is stronger than a list
of marginal-law theorems.

The separate constructor <code>gaussianProductMeasure</code> puts the product
law directly on the function space <code>ι → ℝ</code>. Under that measure,
coordinate evaluation has its requested Gaussian law and all evaluation maps
form an <code>iIndepFun</code> family. This supplies a canonical sample space,
not merely an existence claim.

## Edge cases and nonclaims

- Constant random variables can be independent. Degeneracy does not by itself
  create dependence.
- Independence depends on the measure. The same functions can be independent
  under one measure and dependent under another.
- Pairwise independence is weaker than mutual independence.
- Equal marginals do not imply independence, and independence does not imply
  equal marginals.
- Zero covariance is not independence in general.
- Independent real and imaginary parts are one possible ingredient of a
  complex Gaussian convention. The
  {{< refterm "cartesian-complex-gaussian-law" "Cartesian complex Gaussian law" >}}
  uses exactly this ingredient while keeping both variances declared.
- This page constructs no matrix ensemble and proves no unitary invariance.

## Where to continue

The {{< refterm "gaussian-distribution" "Gaussian distribution" >}} page
defines each coordinate law. The
{{< refterm "normalization-convention" "normalization convention" >}} page
explains what must be fixed before scaling those coordinates. The Deep Dive
[Gaussian Laws, Independence, and Normalization]({{< relref "/knowledge-base/deep-dives/gaussian-laws-independence-and-normalization" >}})
shows how finite product measures and exact Lean laws fit together. The next
chapter,
[Complex Gaussian Coordinates and Geometry]({{< relref "/knowledge-base/deep-dives/complex-gaussian-coordinates-and-geometry" >}}),
turns one independent real pair into an exact complex law and then separates
properness from circular symmetry. Continue with the
{{< refterm "independent-cartesian-complex-gaussian-family" "Independent Cartesian complex Gaussian family" >}}
for mutual independence across indexed complex blocks. The Deep Dive
[Finite Product Probability Spaces and Independent Gaussian Fields]({{< relref "/knowledge-base/deep-dives/finite-product-probability-spaces-and-independent-gaussian-fields" >}})
shows why pairwise independence, within-pair independence, and separate source
families do not replace one exact field product law.

## References

**Mathlib contributors.**
[Independence of functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Independence/Basic.html),
Mathlib 4 documentation. This official reference defines
<code>IndepFun</code> and <code>iIndepFun</code> and states the finite product
law bridge.

**Mathlib contributors.**
[Law of a random variable](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/HasLaw.html),
Mathlib 4 documentation. The theorem <code>iIndepFun.hasLaw_pi</code> turns
mutual independence plus coordinate laws into a joint <code>Measure.pi</code>
law.

**Mathlib contributors.**
[Finite product measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Constructions/Pi.html),
Mathlib 4 documentation. This is the official implementation reference for
<code>Measure.pi</code> and its rectangle factorization theorem.

The local code uses the exact Mathlib 4.32.0 dependency pinned at commit
[`81a5d257`](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).
