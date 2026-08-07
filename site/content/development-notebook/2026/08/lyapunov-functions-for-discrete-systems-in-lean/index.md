---
title: "Lyapunov Functions for Discrete Systems in Lean"
slug: "lyapunov-functions-for-discrete-systems-in-lean"
date: 2026-08-06
weight: -75
author: "tdj28"
summary: "A discrete Lyapunov interface separates positivity, one-step descent, sublevel geometry, orbit-energy convergence, stability, and attraction."
lead: |
  A scalar certificate can organize a stability proof without solving every orbit explicitly, but each implication needs its own gate. This milestone distinguishes nonnegativity from positive definiteness, weak from strict descent, and local stability from pointwise or global attraction.
key_result: |
  Weak descent on a forward-invariant region makes orbit values antitone and preserves open and closed sublevels. Continuity plus explicit sublevel control yields Lyapunov stability; zero-energy convergence plus the same control yields point attraction, and a universal zero-energy limit yields global attraction.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Intermediate metric topology, filters, function iteration, order, and Lean 4"
reading_time: "50 to 70 minutes"
prerequisites:
  - "Orbit and iterate"
  - "Forward stability"
  - "Basin of attraction"
lean_module: "NonlinearDynamics.Deterministic.Discrete.Lyapunov"
lean_source: "formalization/NonlinearDynamics/Deterministic/Discrete/Lyapunov.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Discrete/Lyapunov.lean"
lean_source_sha256: "98e29093c7941935404f4bc3809fba4efd58b6ce993f31829118573165d70f5f"
tags:
  - "Lean 4"
  - "Discrete dynamics"
  - "Lyapunov functions"
  - "Stability"
  - "Attraction"
  - "Sublevel sets"
og_image: "lyapunov-functions-for-discrete-systems-in-lean-card.png"
og_image_alt: "A descending scalar-value staircase beside separate gates for positivity, stability, and attraction."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the scope, approved the formal-check
workflow, and remains responsible for the statements, sources, and released
artifacts. This is an independent, non-peer-reviewed Research Note.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This is a public working note. Human editorial and
expert review remain pending. The configured professional review has not been
performed, and `pro_reviewed` remains false.
{{< /panel >}}

## Start with a descending calculation

Let

\[
f(x)=\frac{x}{2},\qquad p=0,\qquad V(x)=x^2.
\]

Starting at \(x=4\) gives

| time \(n\) | state \(f^n(4)\) | certificate \(V(f^n(4))\) |
|---:|---:|---:|
| 0 | \(4\) | \(16\) |
| 1 | \(2\) | \(4\) |
| 2 | \(1\) | \(1\) |
| 3 | \(1/2\) | \(1/4\) |

The identities

\[
V(0)=0,\qquad V(x)\gt0\text{ for }x\ne0,\qquad
V(f(x))=\frac14V(x)
\]

show three different facts. The first identifies the reference value. The
second is positive definiteness. The third is a quantified descent estimate.
Together with the explicit orbit formula, this example exhibits convergence
to zero. It does not establish a theorem for arbitrary maps or certificates.

{{< reference-figure
  wide="true"
  src="descent-trace.svg"
  alt="Four successive states 4, 2, 1, and one half are paired with descending certificate values 16, 4, 1, and one quarter."
  caption="**One orbit, two sequences:** the state and the scalar certificate both descend in this example. A general Lyapunov argument monitors the scalar sequence; it does not require each coordinate of the state to decrease."
>}}

## Five ingredients, kept separate

For a region \(S\subseteq X\), the module records:

1. `IsNonnegativeOn V S`: \(0\le V(x)\) for \(x\in S\);
2. `IsPositiveDefiniteOn V p S`: \(p\in S\), \(V(p)=0\), and
   \(V(x)\gt0\) for \(x\in S\setminus\{p\}\);
3. `IsWeakLyapunovDecreaseOn f V S`: \(V(f(x))\le V(x)\) on \(S\);
4. `IsStrictLyapunovDecreaseOn f V p S`: \(V(f(x))\lt V(x)\) on
   \(S\setminus\{p\}\);
5. `HasSublevelControlAt V p`: every requested metric ball around \(p\)
   contains some positive open sublevel of \(V\).

The first and second conditions are not synonyms. The constant zero function
is nonnegative, but it cannot distinguish \(p\) from any other state. The
third and fourth conditions are also different. The identity map makes every
certificate weakly decrease by equality, yet a nonfixed starting state never
approaches \(p\).

The region parameter prevents a local calculation from being narrated as a
global conclusion. Forward invariance is not hidden in either descent
predicate. It is supplied separately whenever the proof follows an orbit
through \(S\).

{{< reference-figure
  wide="true"
  src="assumption-gates.svg"
  alt="Three paired gates contrast nonnegative with positive definite, weak with strict descent, and a selected region with the whole state space."
  caption="**Assumption gates:** each right-hand condition adds information. None of the horizontal comparisons is an automatic equivalence, and a local region does not become global merely because the same formula is used."
>}}

## Difference notation and Mathlib minima

The source defines

```lean
def lyapunovDifference (f : X → X) (V : X → ℝ) (x : X) : ℝ :=
  V (f x) - V x
```

Thus weak descent is equivalent to \(\Delta V(x)\le0\), checked by
`isWeakLyapunovDecreaseOn_iff_difference_nonpos`. Strict descent away from
the reference point is equivalent to \(\Delta V(x)\lt0\), checked by
`isStrictLyapunovDecreaseOn_iff_difference_neg`.

`IsPositiveDefiniteOn.isNonnegativeOn` proves the one-way sign implication.
`IsPositiveDefiniteOn.isMinOn` connects the project predicate to Mathlib's
weak `IsMinOn`. If the selected region is a neighborhood,
`IsPositiveDefiniteOn.isLocallyPositiveDefiniteAt` yields the local project
predicate, and `IsLocallyPositiveDefiniteAt.isLocalMin` yields Mathlib's weak
local-minimum predicate. Mathlib's minimum predicates do not encode strict
positivity away from one point, so the project retains that information in a
separate definition.

If \(p\) is fixed, strict descent away from \(p\) implies weak descent on the
same region. The checked theorem is
`IsStrictLyapunovDecreaseOn.isWeakLyapunovDecreaseOn`. Fixedness is necessary
to handle the missing case \(x=p\): strict descent deliberately says nothing
there.

## Sublevels trap the scalar sequence

Suppose \(f(S)\subseteq S\) and \(V(f(x))\le V(x)\) for \(x\in S\). Then the
closed sublevel

\[
S\cap\{x:V(x)\le c\}
\]

and the open sublevel \(S\cap\{x:V(x)\lt c\}\) are forward invariant. The source
names these results `IsWeakLyapunovDecreaseOn.mapsTo_closedSublevel` and
`IsWeakLyapunovDecreaseOn.mapsTo_openSublevel`.

Induction gives

\[
V(f^n(x))\le V(x)
\]

for every start \(x\in S\); this is
`IsWeakLyapunovDecreaseOn.iterate_le`. The stronger order statement
`IsWeakLyapunovDecreaseOn.antitone_orbit` says that

\[
n\longmapsto V(f^n(x))
\]

is antitone. It proves monotonicity of scalar values, not convergence of
states. An antitone nonnegative sequence has a scalar limit, but that limit
need not be zero.

## The stability bridge

Pointwise positive definiteness is not enough to manufacture a uniform lower
bound away from \(p\) on an arbitrary noncompact or infinite-dimensional
space. The module therefore names the needed comparison explicitly:

{{< lean-bridge
  human="Every desired distance tolerance contains a positive open sublevel of V."
  math="\(\forall\varepsilon>0\,\exists c>0:\ V(x)<c\Rightarrow d(x,p)<\varepsilon.\)"
  lean="def HasSublevelControlAt [PseudoMetricSpace X]\n    (V : X → ℝ) (p : X) : Prop :=\n  ∀ ε > 0, ∃ c > 0, ∀ x, V x < c → dist x p < ε"
>}}
`c` may depend on the requested `ε`. The implication applies to every state,
so the sublevel is contained in the metric ball. This is a quantitative
geometry condition, not another spelling of positive definiteness.
{{< /lean-bridge >}}

The theorem
`isLyapunovStableFixedPoint_of_continuousAt_of_sublevelControl` assumes:

- \(p\) is fixed;
- \(V(p)=0\);
- \(V\) is continuous at \(p\);
- `HasSublevelControlAt V p`;
- weak decrease on the whole state space.

Continuity makes each positive sublevel a neighborhood of \(p\). Weak descent
keeps later iterates inside the same sublevel. Sublevel control places that
trapped orbit inside the requested epsilon ball. The conclusion is the
existing `IsLyapunovStableFixedPoint f p`, not attraction.

## Attraction needs a zero limit

The theorem `isAttractedTo_of_tendsto_lyapunov` begins with an additional
fact:

\[
V(f^n(x))\longrightarrow0.
\]

Sublevel control then turns eventual smallness of the scalar value into
\(d(f^n(x),p)\to0\). This conclusion concerns one selected start. If the
zero-limit premise holds for every start,
`isGloballyAttractingFixedPoint_of_tendsto_lyapunov` gives the existing global
attraction predicate. Finally,
`isAsymptoticallyStableFixedPoint_of_lyapunov` combines the stability bridge
with universal zero-energy convergence. Its conclusion is asymptotic
stability; its premises still display the two separate obligations.

Strict one-step descent is not substituted for the zero-limit premise. On a
noncompact space, a strictly decreasing scalar sequence may converge to a
positive number. Compact trapping, coercive sublevels, comparison functions,
or a discrete LaSalle argument can close that gap in later modules.

## Declaration-complete source map

| Declaration | Role |
|---|---|
| `lyapunovDifference` | one-step scalar difference |
| `IsNonnegativeOn` | nonnegativity on a region |
| `IsPositiveDefiniteOn` | region contains `p`, with zero there and positivity away |
| `IsLocallyPositiveDefiniteAt` | neighborhood form of positive definiteness |
| `IsWeakLyapunovDecreaseOn` | weak one-step descent on a region |
| `IsStrictLyapunovDecreaseOn` | strict descent away from `p` on a region |
| `IsPositiveDefiniteOn.isNonnegativeOn` | positive-definite to nonnegative bridge |
| `IsPositiveDefiniteOn.isMinOn` | region minimum bridge |
| `IsPositiveDefiniteOn.isLocallyPositiveDefiniteAt` | region-to-local bridge |
| `IsLocallyPositiveDefiniteAt.isLocalMin` | local Mathlib minimum bridge |
| `isWeakLyapunovDecreaseOn_iff_difference_nonpos` | weak difference form |
| `isStrictLyapunovDecreaseOn_iff_difference_neg` | strict difference form |
| `IsStrictLyapunovDecreaseOn.isWeakLyapunovDecreaseOn` | fixed-point strict-to-weak bridge |
| `IsWeakLyapunovDecreaseOn.mapsTo_closedSublevel` | closed-sublevel invariance |
| `IsWeakLyapunovDecreaseOn.mapsTo_openSublevel` | open-sublevel invariance |
| `IsWeakLyapunovDecreaseOn.iterate_le` | initial-value orbit bound |
| `IsWeakLyapunovDecreaseOn.antitone_orbit` | antitone orbit values |
| `HasSublevelControlAt` | quantitative sublevel geometry |
| `isLyapunovStableFixedPoint_of_continuousAt_of_sublevelControl` | stability endpoint |
| `isAttractedTo_of_tendsto_lyapunov` | point-attraction endpoint |
| `isGloballyAttractingFixedPoint_of_tendsto_lyapunov` | global-attraction endpoint |
| `isAsymptoticallyStableFixedPoint_of_lyapunov` | combined endpoint |

Six `#print axioms` commands audit the main order, stability, and attraction
bridges. The warning-fatal full project check must report no `sorryAx` before
this milestone is called checked.

## Reproduce the checks

The countdown worksheet in the paired Deep Dive is a **standalone tutorial**
that imports only `Std`:

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/lyapunov-functions-and-the-direct-method-in-discrete-time/countdown-energy.lean
```

The authoritative source is a **full project check** using pinned Lean and
Mathlib dependencies and may require substantial disk space or setup time:

```sh
git clone https://github.com/tdj28/nonlinear-dynamics-lean.git
cd nonlinear-dynamics-lean/formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Discrete/Lyapunov.lean
```

`lake env lean` selects the pinned project environment. The warning option
rejects warnings. The command is portable across macOS and Linux after the
dependencies are installed.

Lean's elaborator constructs candidate proof terms and its kernel checks them
against the formal statements. That process does not by itself establish that
one certificate models a physical energy, nor that these definitions cover
every convention in stability theory.

## Exact nonclaims

This slice proves no compact LaSalle invariance principle, converse Lyapunov
theorem, exponential rate, uniqueness theorem, invariant-set or periodic-orbit
criterion, stable-manifold result, ODE theorem, derivative criterion,
structural or stochastic robustness theorem, or Lyapunov-exponent statement.
A local certificate gives no global basin conclusion. Weak descent does not
imply attraction. Strict descent alone is not promoted to attraction without
an explicit zero-limit, compactness, coercivity, or comparison argument.

## References

- J. P. LaSalle, “Difference Equations. Discrete Semidynamical Systems,”
  especially sections 6, 7, and 10, in *The Stability of Dynamical Systems*,
  SIAM CBMS 25 (1976), pages 1–25,
  [DOI 10.1137/1.9781611970432.ch1](https://doi.org/10.1137/1.9781611970432.ch1).
- Saber Elaydi, “Stability Theory,” Chapter 4 of *An Introduction to
  Difference Equations*, third edition, especially Theorems 4.20 and 4.24,
  [DOI 10.1007/0-387-27602-5_4](https://doi.org/10.1007/0-387-27602-5_4).
- S. P. Gordon, “On Converses to the Stability Theorems for Difference
  Equations,” *SIAM Journal on Control* 10(1), 76–81 (1972),
  [DOI 10.1137/0310007](https://doi.org/10.1137/0310007).
- Mathlib 4.32.0, pinned revision `81a5d257`, especially
  `Topology.Order.LocalExtr`, `Order.Filter.Extr`,
  `Topology.MetricSpace.Pseudo.Defs`, `Data.Set.Function`, and
  `Logic.Function.Iterate`.
