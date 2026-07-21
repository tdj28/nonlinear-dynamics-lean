---
title: "Finite random-matrix product"
slug: "finite-random-matrix-product"
summary: "A finite random-matrix product multiplies a finite time prefix pointwise on the sample space, then forms its probability law only after the resulting matrix-valued map is proved measurable."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.MatrixProducts.MeasurableFiniteProducts"
og_image: "finite-random-matrix-product-card.png"
og_image_alt: "A finite prefix of random matrix factors is evaluated at one outcome, multiplied in chronological action order, certified measurable, and transported into a probability law."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page must remain a draft until that review is complete.
{{< /panel >}}

A **finite random-matrix product** is a random matrix obtained by multiplying a
finite, time-indexed collection of random matrices at the same outcome. It has
two stages that should never be collapsed:

1. evaluate every factor at one outcome and form an ordinary matrix product;
2. prove that this product map is measurable before transporting a source
   measure through it.

Let \(\Omega\) be an outcome space and let
\(A_j:\Omega\to M_\iota(\mathbb C)\) be a complex square random matrix at each
natural time \(j\). For a horizon \(k\), define

\[
\Pi_k(\omega)
{} =
A_{k-1}(\omega)\cdots A_1(\omega)A_0(\omega)
\]

when \(k\) is positive, and define

\[
\Pi_0(\omega)=I.
\]

Here \(M_\iota(\mathbb C)\) is the space of complex matrices whose rows and
columns are indexed by the same finite type \(\iota\). The earliest factor acts
first on a column vector, so it is written furthest to the right. The newest
factor acts last and is written on the left. This is the same convention as
the {{< refterm "forward-matrix-product" "forward matrix product" >}}.

The word *random* describes the outcome-dependent map
\(\omega\mapsto\Pi_k(\omega)\). It does not assert independence, identical
distribution, stationarity, or any particular entry law.

{{< reference-figure
  src="finite-random-matrix-product.svg"
  alt="A time-indexed family supplies only the factors before a chosen horizon. One outcome selects ordinary matrices, chronological multiplication produces one matrix, a measurability certificate validates that map, and the source measure is then transported to a law."
  caption="**Finding:** a finite random-matrix product is built sample first and transported second. Only the factors in the selected finite prefix enter the sample product or its measurability proof. The law is formed after that proof, and no independence or long-time conclusion is supplied by this finite construction."
>}}

## The pointwise construction

The underlying deterministic product \(P_B(k)\) is defined by

\[
P_B(0)=I,
\qquad
P_B(k+1)=B_kP_B(k).
\]

For an outcome-dependent family \(A\), substitute
\(B_j=A_j(\omega)\). The sample product is therefore

\[
\Pi_k(\omega)=P_{j\mapsto A_j(\omega)}(k).
\]

This substitution preserves all finite algebraic identities. In particular,

\[
\begin{aligned}
\Pi_0(\omega)&=I,\\
\Pi_1(\omega)&=A_0(\omega),\\
\Pi_{k+1}(\omega)&=A_k(\omega)\Pi_k(\omega).
\end{aligned}
\]

Splitting after \(m\) factors gives

\[
\Pi_{m+k}(\omega)
{} =
\Pi^{(m)}_k(\omega)\Pi_m(\omega),
\]

where \(\Pi^{(m)}_k\) is built from the shifted family
\(j\mapsto A_{m+j}\). The later block is on the left because it acts after
the earlier block.

These equations need only finite matrix algebra. In the checked Lean layer,
the scalar type can be any semiring. A semiring supplies the zero, one,
addition, multiplication, and distributive laws needed for finite matrix
multiplication. Probability and topology do not enter this first stage.

## Exact prefix measurability

To call \(\Pi_k\) a random matrix in the measure-theoretic sense, it must be a
{{< refterm "measurable-space" "measurable" >}} function. The natural
hypothesis is not that every future factor is measurable. It is exactly

\[
\forall j\lt k,\quad A_j\text{ is measurable}.
\]

This condition covers the finite prefix that the product actually reads.
Factors \(A_k,A_{k+1},\ldots\) do not affect \(\Pi_k\), so asking for their
measurability would add irrelevant assumptions.

The proof follows the product recursion:

- at horizon zero, the sample product is the constant identity map, which is
  measurable;
- at a successor horizon, the new factor \(A_k\) is measurable by the prefix
  hypothesis, the previous product is measurable by induction, and matrix
  multiplication preserves measurability.

At \(k=0\), the prefix condition is vacuous. There is no natural number
\(j\lt0\), just as there is no factor in the empty product.

## From the sample map to its law

Let \(\mu\) be a measure on \(\Omega\). Once \(\Pi_k\) is measurable, its
{{< refterm "probability-law" "law" >}} is the
{{< refterm "pushforward-measure" "pushforward measure" >}}

\[
\mathcal L_{\mu}(\Pi_k)
{} =
(\Pi_k)_*\mu.
\]

For every measurable set \(B\) of matrices,

\[
\mathcal L_{\mu}(\Pi_k)(B)
{} =
\mu\{\omega:\Pi_k(\omega)\in B\}.
\]

The subscript on \(\mathcal L_\mu\) matters. The same factor maps can have
different laws under different source measures. The checked definition keeps
\(\mu\) as an explicit argument.

Mathlib makes <code>Measure.map</code> a total operation by returning the zero
measure when its function is not almost-everywhere measurable. That fallback
is useful for a total library interface, but it is not the intended
probabilistic meaning of a law. The project therefore routes the construction
through <code>RandomMatrix.law</code> with an explicit proof of ordinary
measurability. The proof is evidence that the pushforward is being used in its
mathematical regime, not a claim inferred from the word *random*.

## Zero and one step calibrate the law

Suppose \(\mu\) is a probability measure. The zero-step sample product is the
constant identity matrix, so its law is

\[
\mathcal L_{\mu}(\Pi_0)=\delta_I,
\]

where \(\delta_I\) is the point mass at the identity matrix.

The probability assumption is important for this exact formula. Pushing an
arbitrary finite measure through a constant map preserves its total mass. It
equals the unit point mass only when the source has total mass one.

At one step,

\[
\Pi_1=A_0,
\qquad
\mathcal L_{\mu}(\Pi_1)=\mathcal L_{\mu}(A_0).
\]

This identity does not need \(\mu\) to be a probability measure. It simply
says that the one-factor product map is the time-zero factor map.

## A checkable two-outcome example

Take a one-dimensional complex matrix space, so each matrix can be displayed
by its single entry. Let the outcome space contain \(r\) and \(b\), with

\[
\mu\{r\}=\frac14,
\qquad
\mu\{b\}=\frac34.
\]

Choose the first two factors by

\[
\begin{array}{c|cc}
&r&b\\ \hline
A_0&[2]&[-1]\\
A_1&[3]&[4]
\end{array}
\]

where \([z]\) denotes the one-by-one matrix with entry \(z\). Then

\[
\Pi_2(r)=[3][2]=[6],
\qquad
\Pi_2(b)=[4][-1]=[-4].
\]

The product law is

\[
\mathcal L_\mu(\Pi_2)
{} =
\frac14\delta_{[6]}+\frac34\delta_{[-4]}.
\]

At horizon zero the law is \(\delta_{[1]}\). At horizon one it is
\(\frac14\delta_{[2]}+\frac34\delta_{[-1]}\). These are exact toy
probabilities, not measurements or asymptotic approximations.

No independence assumption was used. Both factors are functions of the same
two-point outcome, and their dependence is completely visible.

## Raw measure and bundled probability measure

The raw law has type <code>Measure (Matrix ι ι ℂ)</code>. If the source
measure has total mass one and the sample product is measurable, the raw law
also has total mass one. The checked theorem
<code>forwardProductLaw_isProbabilityMeasure</code> records precisely that
fact.

Mathlib also offers <code>ProbabilityMeasure α</code>, a subtype that bundles
a raw measure together with evidence that its total mass is one. The project
uses that subtype for
<code>forwardProductProbabilityLaw</code>. Coercing the bundled object back to
a raw measure returns <code>forwardProductLaw</code> definitionally.

Bundling changes the interface, not the probabilities. It lets downstream
code require a probability measure by type rather than repeatedly passing a
separate mass-one proof.

## Empty matrix dimension remains valid

The coordinate type \(\iota\) may be empty. There is still exactly one square
matrix on an empty row and column type, and it is the identity. Matrix
multiplication and the pointwise product remain well-defined.

Consequently, no <code>Nonempty ι</code> assumption appears in either the
sample-product or law layer. Under a probability source, the zero-step law is
still the point mass at the identity, and the same statement remains valid in
empty dimension.

This differs from the operator-norm layer of deterministic finite products.
That layer requests positive dimension so the chosen induced norm gives the
identity norm one. Measurability and pushforward laws need no such
normalization.

## The checked Lean shape

The pointwise definition is:

~~~lean
def sampleForwardProduct
    (A : ℕ → RandomMatrix Ω ι ι 𝕜) (k : ℕ) :
    RandomMatrix Ω ι ι 𝕜 :=
  fun ω => forwardProduct (fun j => A j ω) k
~~~

Its measurability theorem exposes the exact prefix:

~~~lean
theorem measurable_sampleForwardProduct
    (A : ℕ → RandomMatrix Ω ι ι ℂ)
    (k : ℕ) (hA : ∀ j < k, Measurable (A j)) :
    Measurable (sampleForwardProduct A k)
~~~

The law then receives the same evidence:

~~~lean
noncomputable def forwardProductLaw
    (μ : Measure Ω)
    (A : ℕ → RandomMatrix Ω ι ι ℂ)
    (k : ℕ) (hA : ∀ j < k, Measurable (A j)) :
    Measure (Matrix ι ι ℂ)
~~~

The code fence keeps Lean's literal comparison operator. In mathematical
delimiters on this site, the same relation is written with <code>\lt</code> so
Goldmark cannot misread it as an HTML tag.

## What this term does not imply

A finite random-matrix product does not by itself provide:

- independent, identically distributed, or stationary factors;
- a probability-preserving time shift or random cocycle;
- invertible factors;
- a norm bound, moment estimate, or integrability theorem;
- an almost-sure statement;
- a logarithmic growth rate or Lyapunov exponent;
- a limit as the horizon tends to infinity;
- a spectral law, density, universality result, or chaos criterion.

Those are later structures and theorems. This finite object supplies the
sample map, its exact finite measurability proof, and its law.

## Where to continue

[Measurable Finite Random-Matrix Products and Proof-Carrying Pushforward Laws]({{< relref "/knowledge-base/deep-dives/measurable-finite-random-matrix-products-and-pushforward-laws" >}})
derives all twelve checked declarations, explains their proof architecture,
and follows the empty-dimensional boundary.

For the underlying order convention, read
{{< refterm "forward-matrix-product" "forward matrix product" >}}. For the
three measure-theoretic ingredients, continue to
{{< refterm "measurable-space" "measurable space" >}},
{{< refterm "pushforward-measure" "pushforward measure" >}}, and
{{< refterm "probability-law" "probability law" >}}. The
{{< refterm "random-matrix" "random matrix" >}} entry distinguishes the sample
map from one realization and from its distribution.

## References

<a id="ref-finite-random-product-law"></a>**Mathlib contributors.**
[Pushforward of a measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
Mathlib 4 documentation. This official source documents
<code>Measure.map</code>, its measurable-map theorems, and its totalized
fallback outside the almost-everywhere-measurable regime.

<a id="ref-finite-random-product-probability"></a>**Mathlib contributors.**
[Bundled probability measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/ProbabilityMeasure.html),
Mathlib 4 documentation. This official source defines
<code>ProbabilityMeasure</code> and its coercion to raw measures.

<a id="ref-finite-random-product-kallenberg"></a>**Olav Kallenberg.**
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1),
third edition, Springer, 2021. This is a standard reference for measurable
random elements, their distributions, and measurable mappings.

<a id="ref-finite-random-product-arnold"></a>**Ludwig Arnold.**
[Random Dynamical Systems](https://doi.org/10.1007/978-3-662-12878-7),
Springer Monographs in Mathematics, 1998. This develops the later cocycle and
ergodic setting in which long random matrix products are studied. Those
structures are motivation here, not claims of the finite-law interface.
