---
title: "Lyapunov Functions and the Direct Method in Discrete Time"
slug: "lyapunov-functions-and-the-direct-method-in-discrete-time"
summary: "Use scalar sublevels to trap discrete orbits, while keeping positivity, descent, stability, and attraction as separate claims."
lead: "A Lyapunov function is useful because its sublevels can trap an orbit. The trap proves stability only when the sublevels control distance, and attraction still needs the scalar values to approach zero."
draft: false
pro_reviewed: false
toc: true
level: "Intermediate"
reading_time: "40 to 55 minutes"
prerequisites:
  - "Orbit and iterate"
  - "Forward stability"
  - "Basin of attraction"
lean_module: "NonlinearDynamics.Deterministic.Discrete.Lyapunov"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Discrete/Lyapunov.lean"
lean_source_sha256: "98e29093c7941935404f4bc3809fba4efd58b6ce993f31829118573165d70f5f"
tags:
  - "Discrete dynamics"
  - "Lyapunov functions"
  - "Sublevel sets"
  - "Stability"
  - "Attraction"
  - "Lean 4"
og_image: "lyapunov-functions-and-the-direct-method-card.png"
og_image_alt: "Nested Lyapunov sublevels trap a discrete orbit near a fixed point, while a separate zero-limit arrow leads to attraction."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this Deep Dive. The author selected the questions and remains
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary sources
  and released Lean source before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note. Human review
of its mathematics, Lean examples, figures, accessibility, and references is
pending. Professional review has not been performed, so
<code>pro_reviewed</code> remains false.
{{< /panel >}}

## A countdown certificate

Begin with the update rule on natural numbers that subtracts one until zero:

\[
f(0)=0,\qquad f(n+1)=n.
\]

Take \(V(n)=n\). Then \(V(n)\ge0\), \(V(n)=0\) exactly when \(n=0\), and

\[
n\ne0\Longrightarrow V(f(n))\lt V(n).
\]

Every orbit reaches zero after finitely many steps. The bundled
`countdown-energy.lean` worksheet checks these finite algebraic statements
using Lean and `Std`. It is a model of the descent pattern, not a replacement
for the metric and topological hypotheses used by the project theorem.

The identity update supplies the nearest boundary. The same \(V\) weakly
decreases because \(V(f(n))=V(n)\), but a positive start remains positive
forever. Weak descent alone therefore cannot establish attraction.

## The scalar difference

For a general self-map \(f:X\to X\) and scalar function
\(V:X\to\mathbb R\),
write

\[
\Delta V(x)=V(f(x))-V(x).
\]

The sign of this one-step difference describes scalar descent. It does not,
by itself, define stability of the state.

{{< lean-bridge
  human="The certificate does not increase after one update at any state in S."
  math="\(x\in S\Rightarrow V(f(x))\le V(x)\), equivalently \(\Delta V(x)\le0\)."
  lean="def IsWeakLyapunovDecreaseOn\n    (f : X → X) (V : X → ℝ) (S : Set X) : Prop :=\n  ∀ x ∈ S, V (f x) ≤ V x"
>}}
The set `S` is part of the statement. `∀ x ∈ S` restricts the estimate to
that region. Nothing in this definition says that `f` maps `S` back into
itself, so forward invariance remains a separate premise.
{{< /lean-bridge >}}

Strict descent replaces `≤` by `<` away from the reference point. If the
reference is fixed, the strict condition implies weak descent: at the
reference point the scalar value is unchanged, and everywhere else strict
inequality can be weakened to non-strict inequality.

## Why positivity has two levels

Nonnegative means \(V(x)\ge0\). Positive definite relative to \(p\) means

\[
V(p)=0,\qquad x\ne p\Longrightarrow V(x)\gt0.
\]

The second condition identifies one zero. The zero function satisfies the
first condition everywhere and the second nowhere on a state space with more
than one point. This distinction blocks a useless certificate from being
treated as if it localized the reference state.

The project also distinguishes a selected region from a neighborhood-level
statement. `IsPositiveDefiniteOn V p S` carries `S` explicitly and requires
that `p` belongs to it.
`IsLocallyPositiveDefiniteAt V p` requires strict positivity away from `p` in
some neighborhood. A region certificate becomes local when `S` itself is a
neighborhood. Neither form claims a global basin.

## Sublevels are the trapping device

For \(c\in\mathbb R\), an open sublevel is

\[
L_c=\{x:V(x)\lt c\}.
\]

If \(V(f(x))\le V(x)\), then \(x\in L_c\) implies \(f(x)\in L_c\). On a
selected region \(S\), the proof also needs \(f(S)\subseteq S\). Repeating the
one-step estimate gives

\[
V(f^{n+1}(x))\le V(f^n(x))\le V(x).
\]

{{< reference-figure
  wide="true"
  src="direct-method-flow.svg"
  alt="An initial point enters a positive sublevel of V; weak descent keeps every later iterate in that sublevel, which lies inside a requested epsilon ball around p."
  caption="**The direct-method flow:** continuity supplies an initial neighborhood inside a positive sublevel. Descent preserves the sublevel. Quantitative sublevel control places the entire orbit inside the requested metric ball."
>}}

In Lean, `Set.MapsTo f S S` expresses forward invariance. The two sublevel
theorems preserve intersections with \(S\). `iterate_le` proves the bound by
induction, while `antitone_orbit` packages all pairwise time comparisons as an
`Antitone` sequence.

## From trapping to stability

The missing geometry is expressed by `HasSublevelControlAt V p`:

\[
\forall\varepsilon\gt0\;\exists c\gt0\;\forall x,
V(x)\lt c\Longrightarrow d(x,p)\lt\varepsilon.
\]

This premise is deliberately stronger than pointwise positive definiteness.
In finite-dimensional Euclidean proofs, compact annuli often produce the
needed positive separation. An arbitrary pseudo-metric space offers no such
compactness automatically.

If \(V(p)=0\) and \(V\) is continuous at \(p\), then every positive sublevel is
a neighborhood of \(p\). Choose a small initial ball inside it. Weak descent
keeps all iterates in the sublevel, and sublevel control keeps all iterates in
the requested epsilon ball. That is the checked theorem
`isLyapunovStableFixedPoint_of_continuousAt_of_sublevelControl`.

Notice the conclusion: Lyapunov stability says that starts sufficiently close
to \(p\) remain close at every natural-number time. It does not say that their
distance tends to zero.

## Attraction is a separate limit

To obtain attraction, the first slice assumes the scalar conclusion directly:

\[
V(f^n(x))\to0.
\]

For any epsilon, sublevel control selects a positive threshold \(c\). The
scalar limit eventually places every later orbit value below \(c\), and the
control implication places every later state inside the epsilon ball. This is
`isAttractedTo_of_tendsto_lyapunov`.

Universal quantification over starts yields
`isGloballyAttractingFixedPoint_of_tendsto_lyapunov`. Combining the local
stability theorem with the universal limit yields
`isAsymptoticallyStableFixedPoint_of_lyapunov`. The API does not disguise a
global hypothesis as a local one: the universal scalar limit appears
literally in the theorem statement.

{{< reference-figure
  wide="true"
  src="boundary-comparison.svg"
  alt="Three panels compare strict geometric descent toward zero, equality under the identity map, and the zero certificate under an expanding map."
  caption="**Three boundaries:** quantified descent can drive a certificate to zero; equality permits a constant nonzero orbit; a certificate that vanishes everywhere carries no distance information and cannot diagnose expansion."
>}}

Strict descent alone is intentionally not an attraction theorem here. A
strictly decreasing real sequence can approach a positive limit. Classical
discrete LaSalle arguments add compact trapped trajectories and identify the
largest invariant subset where the difference vanishes. Coercive or
comparison-function arguments provide other routes. Those are later
milestones, not invisible assumptions in this one.

## Standalone Lean tutorial

The complete `countdown-energy.lean` file imports only `Std`. It proves the
finite countdown claims and the identity boundary. Run it on macOS or Linux:

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/lyapunov-functions-and-the-direct-method-in-discrete-time/countdown-energy.lean
```

This **standalone tutorial** has a small resource profile. It does not import
Mathlib and does not check the pseudo-metric direct-method theorem.

## Try the full project interface

~~~lean
import NonlinearDynamics.Deterministic.Discrete.Lyapunov

#check IsPositiveDefiniteOn
#check IsWeakLyapunovDecreaseOn.antitone_orbit
#check HasSublevelControlAt
#check isAttractedTo_of_tendsto_lyapunov
~~~

{{< repo-check >}}
The copied checks are a reader worksheet. The authoritative source is
`NonlinearDynamics/Deterministic/Discrete/Lyapunov.lean`; the full module check
uses the repository's pinned Lean and Mathlib environment and may require
substantial disk space and setup time.
{{< /repo-check >}}

## Boundaries

This module proves no converse Lyapunov theorem, compact LaSalle invariance
principle, exponential rate, invariant-set stability, periodic-orbit result,
stable manifold, structural robustness, stochastic stability, ODE theorem,
or Lyapunov-exponent statement. A decreasing certificate need not be physical
energy, and scalar descent does not mean that every coordinate descends.

Continue with the shorter {{< refterm "lyapunov-function" "Lyapunov function"
>}} glossary chapter or the declaration-complete [Research Note]({{< relref
"/development-notebook/2026/08/lyapunov-functions-for-discrete-systems-in-lean"
>}}).

## References

- J. P. LaSalle, “Difference Equations. Discrete Semidynamical Systems,”
  sections 6, 7, and 10, in *The Stability of Dynamical Systems*, SIAM CBMS
  25 (1976), pages 1–25,
  [DOI 10.1137/1.9781611970432.ch1](https://doi.org/10.1137/1.9781611970432.ch1).
- Saber Elaydi, “Stability Theory,” Chapter 4 of *An Introduction to
  Difference Equations*, third edition, especially Theorems 4.20 and 4.24,
  [DOI 10.1007/0-387-27602-5_4](https://doi.org/10.1007/0-387-27602-5_4).
- James Hurt, “Some Stability Theorems for Ordinary Difference Equations,”
  *SIAM Journal on Numerical Analysis* 4(4), 582–596 (1967),
  [DOI 10.1137/0704053](https://doi.org/10.1137/0704053).
- Mathlib 4.32.0, pinned revision `81a5d257`, source modules
  `Topology.Order.LocalExtr`, `Data.Set.Function`, and
  `Logic.Function.Iterate`.
