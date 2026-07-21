---
title: "Pushforward measure"
slug: "pushforward-measure"
summary: "A pushforward measure transports mass through a measurable function by measuring preimages in the original space."
draft: true
pro_reviewed: false
toc: true
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
prose, equations, examples, references, and Lean interpretation is still
pending. The page must remain a draft until that review occurs.
{{< /panel >}}

A **pushforward measure** transports mass from one measurable space to another
through a function. The central rule is simple: to measure a target set, look
back at all source points that the function sends into it.

Let \((S,\mathcal A)\) and \((T,\mathcal B)\) be measurable spaces. Here \(S\)
and \(T\) are sets, while \(\mathcal A\) and \(\mathcal B\) are their
collections of measurable subsets. Let \(\mu\) be a measure on \(S\), and let

\[
f:S\longrightarrow T
\]

be measurable. The **pushforward of** \(\mu\) **by** \(f\) is the measure
\(f_*\mu\) on \(T\) defined by

\[
(f_*\mu)(B)=\mu\bigl(f^{-1}(B)\bigr)
\]

for every measurable set \(B\in\mathcal B\). Other common notations are
\(\mu\circ f^{-1}\) and \(f_\#\mu\).

The inverse image is essential. Measures consume sets, while \(f\) sends points
forward. To learn how much source mass arrives in \(B\), we collect the source
points that land there and measure that collection with \(\mu\).

## The transport picture

| Stage | Object | Operation |
|---|---|---|
| Source | A measure \(\mu\) on \(S\) | Start with mass assigned to source sets |
| Map | A measurable function \(f:S\to T\) | Send each source point to one target point |
| Target | The measure \(f_*\mu\) on \(T\) | Assign each target set the mass of its preimage |

This table is the teaching picture for the construction. It exposes the two
opposite directions that are easy to mix up: points travel forward through
\(f\), but sets travel backward through \(f^{-1}\).

## A finite example with collisions

Take the source set \(S=\{a,b,c\}\) and assign masses

\[
\mu\{a\}=\frac12,
\qquad
\mu\{b\}=\frac16,
\qquad
\mu\{c\}=\frac13.
\]

Let the target set be \(T=\{0,1\}\), and define

\[
f(a)=0,
\qquad
f(b)=1,
\qquad
f(c)=0.
\]

Two source points collide at the target value \(0\). Therefore

\[
\begin{aligned}
(f_*\mu)\{0\}
&=\mu\bigl(f^{-1}\{0\}\bigr)
=\mu\{a,c\}
=\frac12+\frac13
=\frac56,\\
(f_*\mu)\{1\}
&=\mu\bigl(f^{-1}\{1\}\bigr)
=\mu\{b\}
=\frac16.
\end{aligned}
\]

The total mass remains one. The pushforward combines mass when several source
points have the same image. It does not remember whether \(a\) or \(c\)
produced the target value \(0\).

## Probability laws are pushforwards

Let \(X:\Omega\to S\) be a random element on a probability space
\((\Omega,\mathcal F,\mathbb P)\). Its
{{< refterm "probability-law" "probability law" >}} is exactly

\[
\mathcal L(X)=X_*\mathbb P.
\]

Thus a law is not an unrelated object added after the random variable. It is
the source probability measure transported through that random variable.

For a random matrix
\(X:\Omega\to\mathbb C^{n\times n}\), the same formula produces a measure on
matrix space:

\[
\mathcal L(X)=X_*\mathbb P.
\]

The source outcomes disappear from the target description. What remains is
the probability assigned to each measurable region of matrix space.

## A matrix observable as a second pushforward

Suppose \(\nu\) is a measure on square complex matrices, and let

\[
\tau(H)=\operatorname{tr}(H)
\]

be the {{< refterm "matrix-trace" "matrix trace" >}}. When \(\tau\) is
measurable, its pushforward \(\tau_*\nu\) is the distribution of the trace.

If \(\nu=\mathcal L(X)=X_*\mathbb P\), then the composition rule gives

\[
\mathcal L(\operatorname{tr}X)
=\tau_*\bigl(X_*\mathbb P\bigr)
=(\tau\circ X)_*\mathbb P.
\]

This identity says that the two routes agree:

1. first form the matrix law and then push it through trace; or
2. first compute trace sample by sample and then take the scalar law.

The same pattern applies to
\(H\mapsto\operatorname{tr}(H^k)\), eigenvalue maps once their measurability
is proved, matrix norms, and other observables.

## Three structural identities

Pushforward has a small algebra that is worth remembering.

### Identity map

For the identity function \(\operatorname{id}_S\),

\[
(\operatorname{id}_S)_*\mu=\mu.
\]

### Composition

If \(R\) is a third measurable space, and \(f:S\to T\) and \(g:T\to R\)
are measurable, then

\[
(g\circ f)_*\mu=g_*\bigl(f_*\mu\bigr).
\]

### Total mass

Because \(f^{-1}(T)=S\),

\[
(f_*\mu)(T)=\mu(S).
\]

In particular, the pushforward of a probability measure by a measurable
function is again a probability measure.

## Integrating after transport

Pushforward also converts an integral over the target into an integral over
the source. Under the standard measurability hypotheses, and for a nonnegative
measurable function \(\varphi:T\to[0,\infty]\),

\[
\int_T \varphi(t)\,(f_*\mu)(dt)
=\int_S \varphi(f(s))\,\mu(ds).
\]

For signed, real, or complex integrals, the corresponding integrability
hypotheses are also required. This is the abstract form of "sample first, then
average": averaging a target observable under the transported law equals
averaging its composition with the original random object.

## Lean-facing interpretation

Mathlib names pushforward <code>Measure.map</code>:

~~~lean
Measure.map f μ
~~~

For a measurable map <code>f</code> and measurable set <code>B</code>, the
theorem <code>Measure.map_apply</code> has the mathematical content

~~~text
(Measure.map f μ) B = μ (f ⁻¹' B).
~~~

The composition theorem is <code>Measure.map_map</code>. These names make the
direction easy to remember: the **measure** is mapped forward, even though the
formula uses the function's inverse image on sets.

There is one implementation boundary to keep visible. Mathlib defines
<code>Measure.map f μ</code> to be the zero measure if <code>f</code> is not
almost-everywhere measurable with respect to <code>μ</code>. This makes the
operation total, but it is not a license to omit measurability proofs. A
probability-law interface should require the map's measurability before using
the expected identities.

The checked <code>RandomMatrices.Laws</code> module uses this interface
directly. <code>RandomMatrix.law</code> is <code>Measure.map X μ</code> with an
explicit measurability argument, and <code>RandomMatrix.law_comp</code> proves
that measurable matrix maps compose with laws in the expected way.

For the deterministic congruence map
\(C_A(H)=AHA^*\), the module proves <code>measurable_congruence</code>. Its
bundled transport theorem is

~~~lean
theorem HermitianRandomMatrix.law_conjugateBy
    [Fintype ι] (A : Matrix ι ι ℂ)
    (X : HermitianRandomMatrix Ω ι) (μ : Measure Ω) :
    law (X.conjugateBy A) μ =
      Measure.map (RandomMatrix.congruence A) (law X μ)
~~~

This is a checked pushforward identity. It says what the transformed law is.
It does not say that the transformed law equals the original law.

## Distinctions and failure modes

| Tempting shortcut | What is wrong | Correct repair |
|---|---|---|
| "Push \(\mu\) forward by measuring \(f(A)\)" | Images of measurable sets are not the sets in the defining formula | Measure \(f^{-1}(B)\) for target sets \(B\) |
| "Every function gives the intended pushforward" | Measurability is needed for the preimage formula and probability interpretation | Prove measurable or almost-everywhere measurable first |
| "Pushforward is a conditional distribution" | Conditioning changes mass using information; pushforward transports it through a function | Treat these as separate constructions |
| "The pushforward remembers the source outcome" | Different source points can merge at one target point | Keep the original coupling when source-level information matters |
| "Equal observable pushforwards imply equal matrix laws" | One observable can discard most matrix information | Use a separating family of observables or prove equality of the full laws |

{{< panel "warning" >}}
**A single statistic is not the whole law.** Two matrix laws can have the same
trace distribution while differing in their eigenvalues, eigenvectors, or
entry dependence. Pushing forward is deliberately information-losing whenever
the map is not injective.
{{< /panel >}}

## Where to continue

Read {{< refterm "probability-law" "probability law" >}} for the special case
of transporting a probability measure through a random object. Read
{{< refterm "random-matrix" "random matrix" >}} and
{{< refterm "trace-power" "trace power" >}} for the source and observable in
the project's first examples. The chapter
[Random Matrices: From Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}})
places the construction in the full probability-to-spectrum ascent.
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}})
is the first project chapter to use this bridge on a complete Gaussian
coordinate probability measure and obtain a named matrix law.

## References

**Mathlib contributors.**
[Pushforward of a measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
Mathlib 4 documentation. This official implementation reference states the
definitions and main theorems <code>map_apply</code> and
<code>map_map</code>, including Mathlib's behavior for maps that are not
almost-everywhere measurable.

**Olav Kallenberg.**
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1),
third edition, Springer, 2021. This is a standard measure-theoretic reference
for image measures, distributions of random elements, and integration under
measurable mappings.

**Mathlib contributors.**
[Measurable spaces and measurable functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/MeasurableSpace/Basic.html),
Mathlib 4 documentation. This official source gives the measurability layer on
which <code>Measure.map</code> depends.
