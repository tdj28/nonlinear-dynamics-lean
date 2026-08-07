---
title: "Lyapunov function"
slug: "lyapunov-function"
summary: "A Lyapunov function is a scalar certificate whose sign, sublevels, and change along an orbit can establish stability or attraction when the required comparison hypotheses are explicit."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Discrete.Lyapunov"
tags:
  - "Discrete dynamics"
  - "Lyapunov functions"
  - "Stability"
  - "Attraction"
  - "Sublevel sets"
og_image: "lyapunov-function-card.png"
og_image_alt: "Nested scalar sublevels surround a fixed point while an orbit moves into lower levels."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note. Human review
of the mathematics, Lean bridge, figures, accessibility, and references
remains pending. Professional review has not been performed, so
<code>pro_reviewed</code> remains false.
{{< /panel >}}

A **Lyapunov function** is a scalar-valued certificate used to study a
dynamical system without first writing a closed formula for every orbit.
Its usefulness comes from three separate kinds of information:

- where the function is zero and positive;
- whether it decreases after an update;
- whether its small sublevels force the state to be close to the reference.

No one item can silently replace the others.

## Start with halving

For the discrete update \(f(x)=x/2\) on the real line, let \(p=0\) and
\(V(x)=x^2\). Then

\[
V(0)=0,\qquad x\ne0\Rightarrow V(x)\gt0,\qquad
V(f(x))=\frac14V(x).
\]

Starting at \(4\), the state values are \(4,2,1,1/2,\ldots\), while the
certificate values are \(16,4,1,1/4,\ldots\). This example exhibits strict
descent and convergence. A general theorem still has to say which hypotheses
turn scalar descent into state stability or attraction.

## Nonnegative is not positive definite

On a region \(S\), **nonnegative** means

\[
0\le V(x)\quad(x\in S).
\]

**Positive definite relative to \(p\)** means that \(p\in S\), \(V(p)=0\),
and \(V(x)\gt0\) for every other \(x\in S\). The zero function is nonnegative
but not positive definite on any region containing a point besides \(p\).
It therefore carries no information about distance to \(p\).

## Weak and strict descent

The one-step Lyapunov difference is

\[
\Delta V(x)=V(f(x))-V(x).
\]

Weak descent means \(\Delta V(x)\le0\). Strict descent away from \(p\) means
\(\Delta V(x)\lt0\) whenever \(x\ne p\). If \(p\) is fixed, strict descent
away from \(p\) implies weak descent everywhere on the same region.

Weak descent does not imply attraction. Under the identity map,
\(V(f(x))=V(x)\) for every \(V\), but a nonzero orbit is constant rather than
converging to zero. Strict descent alone also needs care: a strictly decreasing
real sequence may converge to a positive limit.

{{< reference-figure
  wide="true"
  src="certificate-boundaries.svg"
  alt="A three-row comparison shows the zero certificate as merely nonnegative, the identity map as weak equality without attraction, and a controlled descending certificate whose sublevels shrink toward p."
  caption="**Three checks, three jobs:** positivity distinguishes the reference state, descent traps later scalar values, and sublevel control translates small scalar values into metric closeness."
>}}

## Sublevel control

An open sublevel is a set of states with \(V(x)\lt c\). The project uses the
explicit condition

\[
\forall\varepsilon\gt0\;\exists c\gt0:\quad
V(x)\lt c\Longrightarrow d(x,p)\lt\varepsilon.
\]

This says that sufficiently low values occur only close to \(p\). It is not
automatic from pointwise positivity on an arbitrary noncompact space.

If \(V\) is continuous at \(p\), \(V(p)=0\), and weakly decreases, positive
sublevels can trap nearby forward orbits. Sublevel control then turns that
trap into {{< refterm "forward-stability" "Lyapunov stability" >}}. If the
certificate along a selected orbit additionally tends to zero, sublevel
control turns that scalar limit into attraction and hence membership in the
{{< refterm "basin-of-attraction" "basin of attraction" >}}.

## In Lean

{{< lean-bridge
  human="The certificate is zero at p and strictly positive at every other point of the selected region S."
  math="\(p\in S\land V(p)=0\land\forall x\in S\setminus\{p\},\ V(x)>0.\)"
  lean="def IsPositiveDefiniteOn\n    (V : X → ℝ) (p : X) (S : Set X) : Prop :=\n  p ∈ S ∧ V p = 0 ∧\n    ∀ x ∈ S, x ≠ p → 0 < V x"
>}}
`Set X` is a set of states. The first conjunct keeps the reference inside the
region. The second fixes its scalar value. The final implication supplies
strict positivity only when `x ≠ p`.
{{< /lean-bridge >}}

The descent predicate remains separate:

~~~lean
def IsWeakLyapunovDecreaseOn
    (f : X → X) (V : X → ℝ) (S : Set X) : Prop :=
  ∀ x ∈ S, V (f x) ≤ V x
~~~

This is a **full project check** using pinned Lean and Mathlib dependencies;
it may require substantial disk space and setup time:

~~~sh
git clone https://github.com/tdj28/nonlinear-dynamics-lean.git
cd nonlinear-dynamics-lean/formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Discrete/Lyapunov.lean
~~~

The command is portable across macOS and Linux after the project dependencies
are installed. The paired Deep Dive includes a smaller **standalone tutorial**
that imports only `Std`.

## What this term does not claim

A Lyapunov function need not be physical energy. Decreasing \(V\) does not say
that every state coordinate decreases. Weak descent alone gives no attraction,
and a local certificate gives no global basin. Exponential rates require a
quantified estimate. Compact LaSalle arguments, converse theorems, invariant
sets, ODEs, stochastic robustness, and Lyapunov exponents are separate topics.

Continue with [Lyapunov Functions and the Direct Method in Discrete
Time]({{< relref
"/knowledge-base/deep-dives/lyapunov-functions-and-the-direct-method-in-discrete-time"
>}}) or inspect the declaration-complete [Research Note]({{< relref
"/development-notebook/2026/08/lyapunov-functions-for-discrete-systems-in-lean"
>}}).

## References

- J. P. LaSalle, “Difference Equations. Discrete Semidynamical Systems,”
  sections 6, 7, and 10, in *The Stability of Dynamical Systems*, SIAM CBMS
  25 (1976), pages 1–25,
  [DOI 10.1137/1.9781611970432.ch1](https://doi.org/10.1137/1.9781611970432.ch1).
- Saber Elaydi, “Stability Theory,” Chapter 4 of *An Introduction to
  Difference Equations*, third edition,
  [DOI 10.1007/0-387-27602-5_4](https://doi.org/10.1007/0-387-27602-5_4).
- Mathlib 4.32.0, pinned revision `81a5d257`, and the project module
  `NonlinearDynamics.Deterministic.Discrete.Lyapunov`.
