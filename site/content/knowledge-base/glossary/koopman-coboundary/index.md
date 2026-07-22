---
title: "Koopman coboundary"
slug: "koopman-coboundary"
summary: "A Koopman coboundary is a one-step potential difference whose orbit sum cancels internally and leaves only its final and initial endpoint values."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.KoopmanL2Mean"
og_image: "koopman-coboundary-card.png"
og_image_alt: "Warm-paper glossary card showing an initial endpoint, paired interior terms that cancel, and a final endpoint. The remaining endpoint difference is divided by the horizon, with an explicit note that horizon zero is valid but vacuous."
---

A **Koopman coboundary** records the change in one potential during one step
of a dynamical system. Summing those changes along an orbit makes every
interior potential value appear once with each sign, so the entire sum reduces
to its two endpoints. If the potential stays bounded, dividing this bounded
endpoint difference by a growing positive horizon forces the averages to zero.

RMT-25 fixes the forward sign convention \(U_T-I\), proves the endpoint
identity at every natural horizon, proves pointwise convergence for bounded
potentials, and then uses simple-function coboundaries inside a dense
pointwise-good real \(L^2\) core. The complete development is
[Mean Is Not Pointwise: Koopman Geometry, Coboundaries, and the Missing Maximal Step]({{< relref "/knowledge-base/deep-dives/mean-is-not-pointwise-koopman-geometry-coboundaries-and-the-missing-maximal-step" >}}).
The checked implementation account is
[Koopman L² Mean Convergence and a Dense Pointwise-Good Core in Lean]({{< relref "/development-notebook/2026/07/koopman-l2-mean-convergence-and-a-dense-pointwise-good-core-in-lean" >}}).
The underlying composition operator is the
{{< refterm "koopman-operator" "Koopman operator" >}}, and the finite sums
are the {{< refterm "birkhoff-sum" "Birkhoff sums" >}} used throughout the
project.

{{< reference-figure
  src="coboundary-endpoint-cancellation.svg"
  alt="The initial potential value remains with a minus sign, each interior potential value appears once with each sign and cancels, and the final potential value remains with a plus sign. Dividing the two-endpoint remainder by a growing positive horizon sends bounded-potential averages to zero."
  caption="**Finding:** a forward coboundary sum remembers only the final and initial potential values because all interior values cancel in pairs. Bounded range keeps the endpoint difference bounded, so positive-time averages tend to zero. At horizon zero the totalized identity is still true, but it is the empty-sum equality \(0=0\) and carries no positive-time information. The plate is conceptual, not empirical data."
>}}

## Exact definition and sign convention

Let \(T:\Omega\to\Omega\) be any map and let
\(u:\Omega\to\mathbb R\) be a real potential. The forward raw coboundary is

\[
d=(U_T-I)u,
\qquad
d(\omega)=u(T\omega)-u(\omega).
\]

Here \(U_Tu=u\circ T\), following the composition-operator viewpoint introduced
for Hamiltonian dynamics by
[Koopman](#ref-koopman-coboundary-koopman). The term **potential** names the
generating function \(u\); it does not imply physical energy unless a
particular model gives it that interpretation.

Some texts use \((I-U_T)u=u-u\circ T\). That choice negates every coboundary
and reverses the endpoint difference. The cancellation, density, and
zero-limit ideas survive, but formulas cannot be copied between conventions
without changing the sign. RMT-25 consistently uses \(U_T-I\).

When \(T\) preserves a measure \(\mu\), the same construction is a continuous
linear operator on real \(L^2(\mu)\):

\[
C_T=U_T-I.
\]

The raw formula needs no measure. The \(L^2\) operator needs measure
preservation so that composition is well-defined and continuous on
almost-everywhere equivalence classes.

## The endpoint telescope

For a positive natural number \(n\), expand the first \(n\) orbit terms:

\[
\begin{aligned}
\sum_{j=0}^{n-1}d(T^j\omega)
&=
\sum_{j=0}^{n-1}
\left(u(T^{j+1}\omega)-u(T^j\omega)\right)\\
&=
u(T^n\omega)-u(\omega).
\end{aligned}
\]

Every interior value \(u(T^j\omega)\) occurs once positively and once
negatively. With the project's totalized finite
{{< refterm "birkhoff-sum" "Birkhoff average" >}}, RMT-25 proves the exact
all-natural-horizon identity
([Mathlib Birkhoff sums and averages](#ref-koopman-coboundary-mathlib-sums)):

\[
A_n d(\omega)
{} =
(n:\mathbb R)^{-1}
\left(u(T^n\omega)-u(\omega)\right).
\]

At \(n=0\), the sum on the left is empty. On the right,
\(T^0\omega=\omega\), so the endpoint difference is zero, and Lean's
totalized inverse also gives \(0^{-1}=0\). Both sides are zero. The formula is
valid at horizon zero but vacuous there. It must not be narrated as a
positive-time averaging statement.

## Why bounded potentials give a pointwise limit

Suppose the range of \(u\) is bounded. Equivalently for a real-valued
function, choose \(M\) with \(|u(\omega)|\le M\) for every \(\omega\). Then,
for every positive \(n\),

\[
\left|A_n d(\omega)\right|
\le
\frac{2M}{n}
\longrightarrow 0.
\]

The conclusion is pointwise for every starting state. It uses no measurable
space, measure, finite mass, probability normalization, ergodicity, or
invertibility. Global boundedness is a clean sufficient condition. Along one
fixed orbit, sublinear growth of the endpoint difference would also suffice,
but RMT-25 does not package that more general variant.

## Worked example: cancellation around a four-cycle

Let \(T\) cycle through \(0\to1\to2\to3\to0\), and choose

\[
u(0)=3,
\qquad
u(1)=-2,
\qquad
u(2)=1,
\qquad
u(3)=0.
\]

Starting at zero, the coboundary values repeat as

\[
-5,\ 3,\ -1,\ 3,\ -5,\ldots.
\]

The endpoint formula checks every partial average directly:

| Horizon \(n\) | Endpoint difference \(u(T^n0)-u(0)\) | Average \(A_nd(0)\) |
|---:|---:|---:|
| \(0\) | \(0\) | \(0\) |
| \(1\) | \(-5\) | \(-5\) |
| \(2\) | \(-2\) | \(-1\) |
| \(3\) | \(-3\) | \(-1\) |
| \(4\) | \(0\) | \(0\) |
| \(5\) | \(-5\) | \(-1\) |

The averages are not monotone, but the numerator is always between \(-5\)
and \(5\). Hence \(|A_nd(0)|\le5/n\) for positive \(n\), which forces the
limit to zero. The table is a deterministic algebraic example, not measured
data.

## Why simple coboundaries form the useful core

An arbitrary real \(L^2\) vector is an almost-everywhere equivalence class,
and an arbitrary representative need not be bounded pointwise. RMT-25 starts
instead with Mathlib's \(L^2\) simple vectors. Each has a chosen simple-function
representative with finite range, and a finite real range is bounded. The raw
endpoint theorem therefore proves pointwise convergence to zero for that
representative's coboundary
([Mathlib simple-function representatives and density](#ref-koopman-coboundary-mathlib-simple)).

Formally, RMT-25 defines

\[
\mathcal C_{\mathrm{simp}}
{} =
\{C_Tu:u\text{ is an }L^2\text{ simple vector}\}.
\]

Let \(K=\operatorname{Fix}(U_T)\). Hilbert-space mean-ergodic geometry gives
the checked one-sided inclusion. Its historical projection lineage is von
Neumann's Hilbert-space mean theorem
([von Neumann, 1932](#ref-koopman-coboundary-von-neumann)), while RMT-25 uses
Mathlib's closure-of-range implementation
([Mathlib mean-ergodic geometry](#ref-koopman-coboundary-mathlib-mean)):

\[
K^\perp
\subseteq
\overline{\operatorname{range}(C_T)}.
\]

Simple vectors are dense and \(C_T\) is continuous, so every vector in
\(K^\perp\) lies in the closure of \(\mathcal C_{\mathrm{simp}}\). Orthogonal
projection writes every \(f\in L^2\) as a fixed vector plus an orthogonal
remainder. Consequently,

\[
\{h+c:h\in K,\ c\in\mathcal C_{\mathrm{simp}}\}
\]

is dense in real \(L^2\).

There is a representative subtlety. The chosen representative of the
\(L^2\) difference \(C_Tu\) is only almost everywhere equal to the raw
function \(u\circ T-u\). RMT-25 transports that equality through the
{{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}}
rather than pretending it holds at every point. It similarly intersects the
countably many representative equalities needed for a fixed vector. The final
theorem says that every vector in the fixed-plus-simple-coboundary core has a
chosen representative whose Birkhoff averages converge almost everywhere.

Density plus pointwise-goodness is still not the full pointwise theorem.
RMT-26 must use an absolute weak maximal estimate to make convergence stable
under \(L^1\) approximation, following the maximal-to-pointwise route made
explicit by
[Keane and Petersen](#ref-koopman-coboundary-keane-petersen).

## Assumption ledger

| Statement | Assumptions actually used |
|---|---|
| Endpoint telescope | A map \(T\), a real potential \(u\), a horizon, and a starting point |
| Pointwise zero limit | Bounded range of \(u\) |
| Real \(L^2\) coboundary operator | <code>MeasurePreserving T μ μ</code> |
| Closure and dense-core theorems | Measure preservation and exponent-two Hilbert geometry |
| Almost-everywhere simple-coboundary bridge | Measure preservation plus the finite-range representative supplied by an \(L^2\) simple vector |

None of these statements assumes finite total mass, probability, ergodicity,
injectivity, surjectivity, or invertibility.

## Lean interface

The central declarations are:

- <code>birkhoffAverage_forwardCoboundary</code>, the all-horizon endpoint
  identity;
- <code>tendsto_birkhoffAverage_forwardCoboundary</code>, pointwise convergence
  to zero under bounded range;
- <code>koopmanCoboundaryL2</code>, the continuous linear operator \(U_T-I\);
- <code>simpleKoopmanCoboundarySetL2</code>, its image of \(L^2\) simple vectors;
- <code>fixedOrthogonal_le_closure_range_koopmanL2</code>, the checked closure
  inclusion for the full coboundary range;
- <code>fixedOrthogonal_subset_closure_simpleKoopmanCoboundarySetL2</code>, the
  simple-potential strengthening;
- <code>dense_fixedPlusSimpleCoboundarySetL2</code>, density of the good core;
- <code>ae_mem_birkhoffConvergenceSet_of_mem_simpleKoopmanCoboundarySetL2</code>,
  the representative-safe pointwise theorem for its simple part; and
- <code>ae_mem_birkhoffConvergenceSet_of_mem_fixedPlusSimpleCoboundarySetL2</code>,
  the final almost-everywhere good-core theorem.

## What the term does not imply

A Koopman coboundary does not by itself imply:

- that a generating \(L^2\) potential is essentially bounded or that its
  equivalence class comes with a canonical bounded representative;
- pointwise convergence for every arbitrary \(L^2\) coboundary representative;
- that every vector orthogonal to the fixed space is an exact coboundary;
- equality between the fixed orthogonal complement and the exported closed
  range, beyond the checked one-sided inclusion;
- full-sequence pointwise convergence for every \(L^2\) or \(L^1\) observable;
- identification of the eventual limit with a conditional expectation;
- ergodicity, mixing, or decay of correlations;
- a strong \(L^1\) maximal inequality;
- Kingman's subadditive ergodic theorem; or
- a Lyapunov exponent or Oseledets splitting.

## References

<a id="ref-koopman-coboundary-koopman"></a>**B. O. Koopman.**
[Hamiltonian Systems and Transformation in Hilbert Space](https://pmc.ncbi.nlm.nih.gov/articles/PMC1076052/),
*Proceedings of the National Academy of Sciences* 17(5), 315-318, 1931,
[DOI 10.1073/pnas.17.5.315](https://doi.org/10.1073/pnas.17.5.315).
Pages 315-316 are the primary historical source for the composition-operator
view underlying \(U_T-I\). RMT-25 uses a discrete real \(L^2\) specialization
and does not inherit the paper's invertible Hamiltonian setting.

<a id="ref-koopman-coboundary-von-neumann"></a>**John von Neumann.**
[Proof of the Quasi-Ergodic Hypothesis](https://pmc.ncbi.nlm.nih.gov/articles/PMC1076162/),
*Proceedings of the National Academy of Sciences* 18(1), 70-82, 1932,
[DOI 10.1073/pnas.18.1.70](https://doi.org/10.1073/pnas.18.1.70).
Pages 72-74 give the historical Hilbert-space projection argument. It is
lineage for the fixed-space and coboundary-range geometry, not the exact
Mathlib theorem statement.

<a id="ref-koopman-coboundary-keane-petersen"></a>**Michael Keane and Karl Petersen.**
[Easy and Nearly Simultaneous Proofs of the Ergodic Theorem and Maximal Ergodic Theorem](https://arxiv.org/abs/math/0608251),
*Institute of Mathematical Statistics Lecture Notes-Monograph Series* 48,
248-251, 2006,
[DOI 10.1214/074921706000000266](https://doi.org/10.1214/074921706000000266).
This primary proof source shows how a strengthened maximal estimate yields a
pointwise ergodic theorem. It supports the missing-maximal-step comparison;
RMT-25 itself supplies the dense core only.

<a id="ref-koopman-coboundary-mathlib-sums"></a>**Mathlib contributors.**
[Birkhoff sums](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Basic.html)
and
[Birkhoff averages](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Average.html),
Mathlib v4.32.0. These official definitions provide the finite sum, totalized
average, and subtraction identities used by the endpoint proof.

<a id="ref-koopman-coboundary-mathlib-simple"></a>**Mathlib contributors.**
[Density of simple functions in \(L^p\)](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Function/SimpleFuncDenseLp.html),
with the
[pinned v4.32.0 representative and density implementation](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/SimpleFuncDenseLp.lean#L519-L675).
The finite-range representative and dense embedding are the exact upstream
interfaces used for the simple-coboundary core.

<a id="ref-koopman-coboundary-mathlib-mean"></a>**Mathlib contributors.**
[Pinned von Neumann mean-ergodic implementation](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/InnerProductSpace/MeanErgodic.lean#L31-L94),
Mathlib v4.32.0. Its closure-of-range and orthogonal-projection machinery is
the formal geometry specialized by RMT-25.

The exact upstream revision for all pinned Mathlib references is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the version recorded in <code>formalization/lake-manifest.json</code>.
