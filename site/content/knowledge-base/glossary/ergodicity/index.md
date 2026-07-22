---
title: "Ergodicity"
slug: "ergodicity"
summary: "Ergodicity says a measure-preserving system has no measurable strictly invariant distinction of intermediate measure, so invariant observables are constant almost everywhere."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.ErgodicBirkhoffLimit"
og_image: "ergodicity-card.png"
og_image_alt: "Warm-paper glossary card separating pre-ergodic invariant-information rigidity from the measure-preserving field that upgrades it to full ergodicity."
---

**Ergodicity** means that a measure-preserving dynamical system cannot be
decomposed into two measurable, strictly invariant pieces that both have
positive measure. Equivalently, every strictly invariant measurable event is
null or conull, and every suitably measurable invariant real observable is
constant almost everywhere.

The qualifier **almost everywhere** is essential. Ergodicity makes invariant
information trivial modulo null sets. It does not usually make Mathlib's exact
{{< refterm "invariant-sigma-algebra" "invariant sigma algebra" >}} literally
equal to the bottom measurable space.

Random-matrix-theory milestone 28 (RMT-28) uses this idea in two layers. The
weaker <code>PreErgodic</code> condition collapses an invariant
{{< refterm "conditional-expectation" "conditional expectation" >}} to a
constant. Full <code>Ergodic</code> additionally supplies measure preservation
when the RMT-27 Birkhoff convergence theorem is invoked. The complete chapter
is
[Ergodic Birkhoff Limits and Normalized Space Averages]({{< relref "/knowledge-base/deep-dives/ergodic-birkhoff-limits-and-normalized-space-averages" >}}).

{{< reference-figure
  wide="true"
  src="ergodicity-invariant-information.svg"
  alt="Strictly invariant measurable information passes through a pre-ergodic gate and becomes null or conull, while invariant observables become almost-everywhere constants. A separate measure-preservation rail joins that gate to form full ergodicity and support orbit convergence."
  caption="**Finding:** Mathlib separates invariant-information rigidity from measure preservation. Pre-ergodicity alone collapses invariant events and observables modulo null sets. Full ergodicity adds preservation of the measure, which is needed to turn the rigidity statement into an ergodic Birkhoff convergence theorem. The figure does not imply mixing, independence, or powered-map ergodicity."
>}}

## Exact Mathlib semantics

Let \((\Omega,\mathcal B,\mu)\) be a measure space and
\(T:\Omega\to\Omega\). Mathlib defines <code>PreErgodic T μ</code> by the
requirement that every measurable set \(S\) satisfying

\[
T^{-1}(S)=S
\]

is eventually constant in the almost-everywhere filter. In ordinary measure
language,

\[
\mu(S)=0
\quad\text{or}\quad
\mu(S^{\mathsf c})=0.
\]

The source structure is:

~~~lean
structure PreErgodic (T : Ω → Ω) (μ : Measure Ω) : Prop where
  aeconst_set :
    MeasurableSet S → T ⁻¹' S = S → EventuallyConst S (ae μ)
~~~

Full ergodicity adds measure preservation:

~~~lean
structure Ergodic (T : Ω → Ω) (μ : Measure Ω) : Prop extends
  MeasurePreserving T μ μ, PreErgodic T μ
~~~

Thus <code>Ergodic T μ</code> has two projections:
<code>hT.toMeasurePreserving</code> and <code>hT.toPreErgodic</code>.
RMT-28 uses each projection exactly where its meaning is needed.

## Event form and function form

The event form says no measurable strict invariant can split the measured
space into two positive pieces. On a probability space this becomes the
numerical zero-one law

\[
\mu(S)=0
\quad\text{or}\quad
\mu(S)=1.
\]

Outside probability normalization, the honest conclusion is null or conull.
If \(\mu(\Omega)=5\), a conull invariant event has mass \(5\), not \(1\).

The function form says that a measurable \(g:\Omega\to\mathbb R\) satisfying

\[
g\circ T=g
\]

is constant almost everywhere under pre-ergodicity. Mathlib also supplies
variants with almost-everywhere invariance and almost-everywhere strong
measurability. RMT-28 uses the exact representative-level equality furnished
by conditional expectation onto the exact invariant sigma algebra.

## Worked example: ergodic but not mixing

Let \(\Omega=\{0,1\}\), give both points probability \(1/2\), and define the
flip

\[
T(0)=1,\qquad T(1)=0.
\]

Only \(\varnothing\) and \(\Omega\) are strictly invariant. The map preserves
the uniform measure, so it is ergodic.

It is not mixing. For \(E=\{0\}\),

\[
\mu\bigl(E\cap T^{-n}(E)\bigr)
{} =
\begin{cases}
1/2,&n\text{ even},\\
0,&n\text{ odd}.
\end{cases}
\]

The overlap does not approach \(\mu(E)^2=1/4\). Moreover,
\(T^2=\operatorname{id}\), so the powered map \(T^2\) is not ergodic: each
singleton is invariant under it. This one model separates three concepts:

- \(T\) is ergodic;
- \(T\) is not mixing; and
- ergodicity of \(T\) does not imply ergodicity of every power.

For \(f(0)=a\) and \(f(1)=b\), the Birkhoff averages nevertheless converge
from both starting points to \((a+b)/2\). Mixing and powered-map ergodicity are
not premises of the additive RMT-28 theorem.

## Identity dynamics show the missing gate

On the same two positive-mass atoms, let \(T=\operatorname{id}\). Every
measurable set is strictly invariant. A singleton has positive measure and a
positive-measure complement, so the system is not pre-ergodic and therefore
not ergodic.

If \(f(0)=0\) and \(f(1)=1\), then \(f\) is invariant but not almost everywhere
constant. Conditional expectation onto the invariant sigma algebra returns
\(f\), not its global normalized average. RMT-28 compiles this as its exact
countermodel to the weak <code>PreErgodic</code> gate.

## Pre-ergodicity can hold without measure preservation

A Dirac measure makes every measurable set almost empty or almost full,
regardless of the self-map. On <code>Bool</code>, put the Dirac mass at
<code>true</code> and let \(T\) send both points to <code>false</code>. Then
<code>PreErgodic T μ</code> holds, but \(T\) does not preserve the measure
because it moves the supported atom.

RMT-28's conditional-expectation identification still applies. Its Birkhoff
convergence theorem does not. This compiled model demonstrates why the two
interfaces should not share an unnecessarily strong hypothesis.

## Null sets and the zero measure

An ergodic system may have nonempty invariant null sets. It may also have
proper invariant conull sets. These do not carry a measurable distinction of
positive mass, so they do not violate ergodicity.

At the extreme boundary, Mathlib permits the zero measure to be ergodic for a
measurable map. Every set is null and conull there, and every almost-everywhere
statement is vacuous. Ergodicity therefore does not imply
\(\mu\ne0\). RMT-28 separately requires nonzero finite mass before identifying
a constant by division.

## What ergodicity does not establish

- It does not imply mixing, weak mixing, or decay of correlations.
- It does not imply independence of orbit observations.
- It does not imply ergodicity of \(T^n\) for every positive \(n\).
- It does not imply injectivity, surjectivity, or invertibility.
- It does not make the exact invariant sigma algebra literally bottom.
- It does not by itself prove Birkhoff convergence. Measure preservation is
  part of full ergodicity, but a pointwise ergodic theorem is still an
  additional theorem.
- It does not imply integrability of an observable.
- It does not supply a convergence rate.
- It does not prove physical thermalization, a Lyapunov exponent, or an
  Oseledets splitting.

## Related concepts

- {{< refterm "normalized-space-average" "Normalized space average" >}} is the
  constant identified after invariant information collapses and finite nonzero
  mass is used.
- {{< refterm "conditional-expectation" "Conditional expectation" >}} is the
  general nonergodic Birkhoff target.
- {{< refterm "invariant-sigma-algebra" "Invariant sigma algebra" >}} stores
  the measurable information unchanged by one step.
- {{< refterm "ergodic-probability-base" "Ergodic probability base" >}}
  combines mass-one normalization with full ergodicity while keeping
  integrability separate.
- [Probability Normalization and Ergodic Rigidity Before Kingman]({{< relref "/knowledge-base/deep-dives/probability-normalization-and-ergodic-rigidity-before-kingman" >}})
  develops the earlier cocycle-facing assumption split.
- [Birkhoff Limits, Invariant Sigma Algebras, and Conditional Expectation]({{< relref "/knowledge-base/deep-dives/birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation" >}})
  proves the nonergodic predecessor whose target RMT-28 collapses.

## References

<a id="ref-ergodicity-mathlib"></a>**Mathlib contributors.**
[Ergodic structures](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Ergodic.lean#L40-L83)
and
[invariant-function theorems](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Function.lean),
Mathlib 4.32.0 at pinned commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).
These are authoritative for the exact <code>PreErgodic</code> and
<code>Ergodic</code> semantics used here.

<a id="ref-ergodicity-pollicott-yuri"></a>**Mark Pollicott and Michiko Yuri.**
[Ergodic measures](https://doi.org/10.1017/CBO9781139173049.011), chapter 9 of
*Dynamical Systems and Ergodic Theory*, Cambridge University Press, 1998.
Textbook source for the invariant-set and invariant-function viewpoints in a
probability setting.

<a id="ref-ergodicity-project"></a>**Nonlinear Dynamics in Lean contributors.**
[ErgodicBirkhoffLimit.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/ErgodicBirkhoffLimit.lean),
the checked project source for the minimized rigidity and convergence
interfaces and their boundary probes.
