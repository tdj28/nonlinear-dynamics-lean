---
title: "Integrable generator log tails"
slug: "integrable-generator-log-tails"
summary: "Integrable generator log tails require genuine one-step inverses and finite average budgets for both logarithmic expansion and logarithmic contraction."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.RealLogNormIntegrability"
lean_snapshot: "/lean/NonlinearDynamics/Random/RandomCocycles/RealLogNormIntegrability.lean"
lean_source_sha256: "ac950f8728e5fd003cff3b7a5d0750e5c36060730b3ebadc5b0e1165b54e72ea"
og_image: "integrable-generator-log-tails-card.png"
og_image_alt: "A fair two-outcome model uses scalar generators two and one quarter; their forward log-positive tails are log two and zero, their inverse tails are zero and log four, and both signed logs lie between the resulting rails."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working note. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is public so readers can follow the work while that review
is still open.
{{< /panel >}}

Suppose a fair coin chooses one of two one-by-one matrices:

\[
A(u)=\begin{bmatrix}2\end{bmatrix},
\qquad
A(v)=\begin{bmatrix}\tfrac14\end{bmatrix},
\qquad
\mathbb P(u)=\mathbb P(v)=\tfrac12.
\]

The first outcome doubles a vector. The second divides it by four. If we only
record expansion, the second outcome looks harmless because its norm is below
one. If we also inspect the inverse, its contraction reappears as an expansion
by four. **Integrable generator log tails** are the hypothesis that keeps both
of those one-step logarithmic budgets finite.

## Work the two outcomes before naming the abstraction

Take the base map to be the identity, so an outcome stays \(u\) or stays
\(v\) at every time. The event family is every subset of
\(\Omega=\{u,v\}\), and the displayed probabilities define a
{{< refterm "probability-measure" "probability measure" >}}: the two masses
are nonnegative and add to one. With this discrete event structure, the
identity base map and the displayed generator are measurable, and the
identity preserves the probability measure. A one-by-one matrix has the
absolute value of its entry as its
{{< refterm "induced-infinity-operator-norm" "induced infinity operator norm" >}}.

For a positive number \(x\), write

\[
\log^+x=\max(0,\log x).
\]

That is the ordinary paper definition on positive inputs. Lean's
<code>Real.log</code> is a total function with value zero at zero, so the
formal <code>log⁺</code> is total too. The singular and empty-dimensional
boundaries below explain why that implementation detail cannot be ignored.

Define three one-step quantities:

\[
F(\omega)=\log^+\lVert A(\omega)\rVert_\infty,
\qquad
I(\omega)=\log^+\lVert A(\omega)^{-1}\rVert_\infty,
\qquad
R_1(\omega)=\log\lVert A(\omega)\rVert_\infty.
\]

Here \(F\) is the **forward expansion tail**, \(I\) is the **inverse
contraction tail**, and \(R_1\) is the signed logarithmic growth. The complete
arithmetic is:

| outcome | probability | generator norm | inverse norm | \(F\) | \(I\) | \(R_1\) |
|---|---:|---:|---:|---:|---:|---:|
| \(u\) | \(1/2\) | \(2\) | \(1/2\) | \(\log 2\) | \(0\) | \(\log 2\) |
| \(v\) | \(1/2\) | \(1/4\) | \(4\) | \(0\) | \(\log 4\) | \(-\log 4\) |

The one-step lower and upper bounds can now be checked without any theorem:

\[
\begin{aligned}
u:&\qquad 0\leq \log 2\leq \log 2,\\
v:&\qquad -\log 4\leq-\log 4\leq0.
\end{aligned}
\]

Both tail budgets have finite
{{< refterm "expectation" "expectation" >}}:

Here expectation is the probability-weighted average of the two values.

\[
\mathbb E[F]
=\tfrac12\log2,
\qquad
\mathbb E[I]
=\tfrac12\log4
=\log2.
\]

The signed logarithm is
{{< refterm "integrability" "integrable" >}} too, because its expected
absolute value is finite:

\[
\mathbb E[|R_1|]
=\tfrac12\log2+\tfrac12\log4
=\tfrac32\log2
\lt\infty.
\]

This last calculation is what ordinary real-valued integrability means on the
finite probability space: the function is measurable and the integral of its
absolute value is finite. Measurability and integrability are different
questions in general. On this finite space with every subset declared an
event, every real-valued function is measurable; the explicit sums above then
settle finiteness.

{{< reference-figure
  wide="true"
  src="integrable-generator-log-tails.svg"
  alt="A fair two-outcome probability example shows that the scalar generator two spends one unit of log-two expansion and no contraction budget, while the scalar generator one quarter spends no expansion and two units of contraction budget. Both outcomes satisfy the signed-log sandwich, and the weighted absolute signed log totals three halves of log two."
  caption="**Worked tail budget:** outcome \(u\), with probability \(1/2\), uses generator \(2\): its forward tail is \(\log2\), its inverse tail is \(0\), and its signed log is \(\log2\). Outcome \(v\), also with probability \(1/2\), uses generator \(1/4\): its forward tail is \(0\), its inverse tail is \(\log4\), and its signed log is \(-\log4\). Thus the forward expectation is \((1/2)\log2\), the inverse expectation is \((1/2)\log4=\log2\), and the expected absolute signed log is \((3/2)\log2\). The singular matrix with diagonal entries \(1/2,0\) is shown as a near-miss: its total inverse tail is zero even though its signed log is negative. The plate proves no independence, zero-or-one law for invariant events, asymptotic limit, or Lyapunov spectrum."
>}}

## One more step shows why the condition propagates

Because the base map is the identity, the horizon-two products are

\[
C(2,u)=\begin{bmatrix}4\end{bmatrix},
\qquad
C(2,v)=\begin{bmatrix}\tfrac1{16}\end{bmatrix}.
\]

At \(u\), the two inverse-tail terms are both zero. At \(v\), each is
\(\log4\). Therefore the horizon-two sandwich is

\[
\begin{aligned}
u:&\qquad 0\leq \log4\leq\log4,\\
v:&\qquad -2\log4=-\log16\leq-\log16\leq0.
\end{aligned}
\]

The example is deliberately small, but the mechanism is already complete:
one-step tail budgets become finite sums along the orbit, and the signed log
norm sits between them.

## Prerequisites in plain language

The general definition combines algebra, probability, and analysis. The
following distinctions prevent the notation from doing too much at once.

- A **sample space** \(\Omega\) is the set of possible base states. An
  {{< refterm "event" "event" >}} is a measurable subset of that space.
- A {{< refterm "measure" "measure" >}} \(\mu\) assigns sizes to measurable
  events. It need not have total mass one. A probability measure does.
- A {{< refterm "measurable-function" "measurable function" >}} respects the
  selected event structures. Measurability lets integration theory see the
  function; it does not say that the function has a finite integral.
- A real-valued function \(f\) is integrable when it is measurable and
  \(\int |f|\,d\mu\lt\infty\). Positive and negative values cannot hide an
  infinite tail by cancellation because the absolute value is integrated.
- A square matrix is a **unit** when it has a multiplicative inverse. For a
  finite complex square matrix, this is equivalent to nonzero determinant.
  The project asks for a unit at every base state, not merely outside a
  {{< refterm "null-set" "null set" >}}.
- A {{< refterm "measure-preserving-transformation" "measure-preserving transformation" >}}
  \(T:\Omega\to\Omega\) moves the base state without changing the measure.
  This lets one-step integrability travel to \(T^j\omega\).

No independence assumption appears in this list. No probability density is
required either. The package is formulated for a measure-preserving
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycle" >}},
not specifically for an independent and identically distributed sequence.

## The general package

Let \(A(\omega)\) be the one-step generator and let the newest factor appear
on the left:

\[
C(k,\omega)
=A(T^{k-1}\omega)\cdots A(T\omega)A(\omega),
\qquad
C(0,\omega)=I.
\]

For a finite coordinate type \(\iota\), the matrices have complex entries and
use the project's maximum absolute row-sum norm. Define

\[
\begin{aligned}
F(\omega)&=\log^+\lVert A(\omega)\rVert_\infty,\\
I(\omega)&=\log^+\lVert A(\omega)^{-1}\rVert_\infty,\\
R_k(\omega)&=\log\lVert C(k,\omega)\rVert_\infty.
\end{aligned}
\]

The integrable-generator-log-tails package has three fields:

| field | paper condition | job |
|---|---|---|
| <code>isPointwiseInvertible</code> | \(A(\omega)\) is a unit for every \(\omega\) | keeps the inverse lower bound honest |
| <code>hasIntegrableGeneratorLogPlus</code> | \(F\in L^1(\mu)\) | controls large one-step expansion |
| <code>integrable_inverseGeneratorLogPlus</code> | \(I\in L^1(\mu)\) | controls deep one-step contraction |

The exact proposition-valued structure in the pinned Random Matrix Theory
milestone RMT-34 source is:

~~~lean
structure HasIntegrableGeneratorLogTails
    (C : DiscreteMatrixCocycle (ι := ι) μ) : Prop where
  isPointwiseInvertible : C.IsPointwiseInvertible
  hasIntegrableGeneratorLogPlus : C.HasIntegrableGeneratorLogPlus
  integrable_inverseGeneratorLogPlus :
    Integrable C.inverseGeneratorLogPlusNormObservable μ
~~~

The structure stores proofs, not extra cocycle data. It does not change the
base map, choose inverses, or construct negative-time dynamics.

### Why the two analytic fields are separate

The function \(\log^+x\) clips every nonpositive logarithm to zero. A strong
contraction can therefore disappear from \(F\). Applying the same operation to
the inverse makes that contraction visible in \(I\).

For a nonzero scalar \(a\), measured in a one-by-one matrix,

\[
F=\max(0,\log|a|),
\qquad
I=\max(0,-\log|a|).
\]

These are exactly the positive and negative tails of \(\log|a|\). In higher
dimension the interpretation is not perfectly symmetric: the forward norm
sees the strongest expansion, while the inverse norm sees the strongest
contraction. Neither field implies the other.

## The finite-time sandwich

For a horizon \(k\in\mathbb N\), define the inverse orbit budget and forward
envelope by

\[
S_k^-(\omega)
=\sum_{j=0}^{k-1}I(T^j\omega),
\qquad
P_k(\omega)
=\log^+\lVert C(k,\omega)\rVert_\infty.
\]

The three fields give the pointwise inequality

\[
\boxed{
-S_k^-(\omega)
\leq R_k(\omega)
\leq P_k(\omega)}.
\]

The upper rail is the elementary inequality \(\log x\leq\log^+x\). The lower
rail uses genuine inverses. For a nonzero finite product,

\[
1\leq
\lVert C(k,\omega)^{-1}\rVert_\infty
\lVert C(k,\omega)\rVert_\infty.
\]

Taking logarithms bounds \(R_k\) from below by the negative inverse-product
log norm. Norm submultiplicativity then bounds that inverse-product quantity
by the sum \(S_k^-\). The order of the two inequalities reverses when the
inverse quantity is negated.

Measure preservation makes every transported one-step tail integrable. Hence
\(S_k^-\) is a finite sum of integrable functions, and the forward-tail field
makes \(P_k\) integrable. The signed function \(R_k\) is measurable, so an
integrable lower rail and upper rail imply

\[
R_k\in L^1(\mu)
\qquad\text{for every finite }k.
\]

No probability normalization or ergodicity is needed for this finite-horizon
result.

## In Lean: read the conclusion in three languages

{{< lean-bridge
  human="If every one-step generator is invertible and both the expansion and contraction logarithmic tails are integrable, then the signed real log norm is integrable at every finite horizon."
  math="\(\left[\forall\omega,\ A(\omega)\text{ invertible};\ F\in L^1(\mu);\ I\in L^1(\mu)\right]\Longrightarrow\forall k\in\mathbb N,\ R_k\in L^1(\mu).\)"
  lean="hC.integrable_realLogNormObservable k"
>}}

- <code>hC</code> is a proof of
  <code>C.HasIntegrableGeneratorLogTails</code>, so it carries all three fields.
- The dot in <code>hC.integrable_realLogNormObservable</code> selects the
  theorem whose first explicit proof argument is <code>hC</code>.
- <code>k : ℕ</code> is the finite time horizon.
- <code>C.realLogNormObservable k</code> is the function
  \(\omega\mapsto\log\lVert C(k,\omega)\rVert_\infty\).
- The theorem's result is
  <code>Integrable (C.realLogNormObservable k) μ</code>. The final
  <code>μ</code> tells Lean which measure defines integrability.
{{< /lean-bridge >}}

Here is the complete exact source theorem. The proof first supplies
measurability, then the eventual lower and upper inequalities, then the
integrability of the two rails:

~~~lean
theorem HasIntegrableGeneratorLogTails.integrable_realLogNormObservable
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) (k : ℕ) :
    Integrable (C.realLogNormObservable k) μ := by
  exact MeasureTheory.integrable_of_le_of_le
    (C.measurable_realLogNormObservable k).aestronglyMeasurable
    (Filter.Eventually.of_forall fun ω ↦
      hC.isPointwiseInvertible.neg_inverseOrbitLogPlusSum_le_realLogNormObservable k ω)
    (Filter.Eventually.of_forall fun ω ↦
      C.realLogNormObservable_le_logPlusNormObservable k ω)
    (hC.integrable_inverseOrbitLogPlusSum k).neg
    (hC.hasIntegrableGeneratorLogPlus.integrable_logPlusNormObservable k)
~~~

The word <code>Eventually</code> here packages pointwise inequalities in the
almost-everywhere filter interface expected by the integrability theorem. The
proofs were built with <code>of_forall</code>, so these particular inequalities
hold at every \(\omega\), not merely
{{< refterm "almost-everywhere" "almost everywhere" >}}.

## A tiny standalone Lean worksheet a human can type

**Resource label: tiny Lean standard-library (<code>Std</code>) check.** The two matrices are
powers of two, so the worksheet records each signed logarithm by its exact
integer coefficient of \(\log2\). Thus \(2\) has coefficient \(1\), while
\(1/4=2^{-2}\) has coefficient \(-2\). This checks the arithmetic and the
sandwich without importing Mathlib, Lean's community mathematics library,
defining matrices, or claiming to prove
measure-theoretic integrability.

Save the following as <code>GeneratorLogTailsTutorial.lean</code>:

~~~lean
import Std

inductive Outcome where
  | expand
  | contract
deriving Repr, DecidableEq

-- Exact coefficients of log 2: log 2 = 1 unit, log (1/4) = -2 units.
def signedLogUnits : Outcome → Int
  | .expand => 1
  | .contract => -2

def positivePart (z : Int) : Int :=
  if 0 ≤ z then z else 0

def forwardTailUnits (ω : Outcome) : Int :=
  positivePart (signedLogUnits ω)

def inverseTailUnits (ω : Outcome) : Int :=
  positivePart (-signedLogUnits ω)

def sandwichHolds (ω : Outcome) : Bool :=
  decide (-inverseTailUnits ω ≤ signedLogUnits ω ∧
    signedLogUnits ω ≤ forwardTailUnits ω)

def absoluteSignedLogUnits (ω : Outcome) : Nat :=
  (signedLogUnits ω).natAbs

def totalAbsoluteSignedLogUnits : Nat :=
  absoluteSignedLogUnits .expand + absoluteSignedLogUnits .contract

def horizonSignedLogUnits (k : Nat) (ω : Outcome) : Int :=
  (k : Int) * signedLogUnits ω

def horizonInverseBudgetUnits (k : Nat) (ω : Outcome) : Int :=
  (k : Int) * inverseTailUnits ω

def horizonForwardBudgetUnits (k : Nat) (ω : Outcome) : Int :=
  (k : Int) * forwardTailUnits ω

def horizonSandwichHolds (k : Nat) (ω : Outcome) : Bool :=
  decide (-horizonInverseBudgetUnits k ω ≤ horizonSignedLogUnits k ω ∧
    horizonSignedLogUnits k ω ≤ horizonForwardBudgetUnits k ω)

#eval (forwardTailUnits .expand, inverseTailUnits .expand,
  signedLogUnits .expand)
#eval (forwardTailUnits .contract, inverseTailUnits .contract,
  signedLogUnits .contract)
#eval sandwichHolds .expand
#eval sandwichHolds .contract
#eval totalAbsoluteSignedLogUnits
#eval horizonSandwichHolds 2 .expand
#eval horizonSandwichHolds 2 .contract

example : forwardTailUnits .expand = 1 := by decide
example : inverseTailUnits .contract = 2 := by decide
example : totalAbsoluteSignedLogUnits = 3 := by decide
example : horizonSignedLogUnits 2 .contract = -4 := by decide
~~~

From the directory containing that file, type:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean GeneratorLogTailsTutorial.lean
~~~

The first two outputs should be <code>(1, 0, 1)</code> and
<code>(0, 2, -2)</code>. The next two and the two horizon checks should be
<code>true</code>, and the absolute-log total should be <code>3</code>. Since
the outcomes are equally likely, dividing that total by two recovers the
paper value \((3/2)\log2\).

This tutorial is safe for an ordinary Mac or Linux machine because it imports
only <code>Std</code>. It does **not** check the project's matrices, norms,
measures, logarithms, or integrability theorem.

## Try the exact declarations in the project

{{< repo-check >}}
**Resource label: pinned project plus Mathlib.** In a deliberately provisioned
copy of the repository, a human can put the following in a temporary project
worksheet:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.RealLogNormIntegrability

#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.IsPointwiseInvertible
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogTails
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.measurable_inverseGeneratorLogPlusNormObservable
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.IsPointwiseInvertible.neg_inverseOrbitLogPlusSum_le_realLogNormObservable
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.realLogNormObservable_le_logPlusNormObservable
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogTails.integrable_realLogNormObservable
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogTails.isIntegrableSubadditiveProcessCandidate
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedRealLogNormObservable_of_pos
~~~

Each <code>#check</code> asks the pinned elaborator for the exact type of a
declaration. The long namespace identifies the declarations without relying on
local <code>open</code> commands. The guarded command below checks the complete
authoritative RMT-34 module on approved Linux compute. It intentionally does
not run on this Mac workstation.
{{< /repo-check >}}

## Why this condition matters for cocycle growth

The signed process is **shifted-subadditive** when a long interval costs no
more than its two consecutive pieces:

\[
R_{m+k}(\omega)
\leq R_k(T^m\omega)+R_m(\omega).
\]

Subadditive growth theory studies the normalized signed quantity

\[
\frac1k\log\lVert C(k,\omega)\rVert_\infty.
\]

Before an ergodic theorem can control its long-time behavior, the finite-time
functions must be analytically usable. The tail package provides exactly two
pieces of infrastructure:

1. <code>integrable_realLogNormObservable</code> proves every finite signed log
   norm is integrable.
2. <code>isIntegrableSubadditiveProcessCandidate</code> combines that
   integrability with shifted subadditivity.

The repository's current RMT-35 source then adds a probability base and the
project's pre-ergodic invariant-set condition. Its signed Kingman endpoint is
named
<code>HasIntegrableGeneratorLogTails.ae_tendsto_normalizedRealLogNormObservable</code>.
Under those extra assumptions, it states almost-everywhere convergence to a
deterministic integrated signed growth rate.

That downstream theorem explains why the present hypothesis is valuable, but
it must not be read backward into this page. This page's pinned source and
hash cover RMT-34 only. The RMT-35 source still needs its own teaching layer
and cloud release gate, and the tail package by itself proves no asymptotic
convergence.

## Near-misses and boundary cases

### Near-miss 1: a singular contraction fools the total inverse

Mathlib's nonsingular matrix inverse is a total function: on a singular matrix
it returns the zero matrix. Take

\[
A=
\begin{bmatrix}
\tfrac12&0\\
0&0
\end{bmatrix}.
\]

Its norm is \(1/2\), so its signed one-step log is \(-\log2\). Its total inverse
is zero, whose inverse log-positive tail is \(0\). Without the unit condition,
the proposed lower rail would say

\[
0\leq-\log2,
\]

which is false. Inverse-tail integrability alone does not rule out singular
collapse. Pointwise units make the lower rail meaningful.

### Near-miss 2: the forward field does not control contraction

There is a compiled probability-space counterexample in RMT-34. Let
\(\Omega=\mathbb N\), give \(n\) probability \(2^{-n-1}\), use the identity
base, and choose the one-dimensional generator

\[
A(n)=\begin{bmatrix}\exp(-2^n)\end{bmatrix}.
\]

Every generator is a unit and every norm is below one, so \(F(n)=0\). The
forward tail is integrable. But

\[
I(n)=2^n,
\qquad
|R_1(n)|=2^n,
\qquad
2^{-n-1}2^n=\tfrac12.
\]

Every outcome contributes the same \(1/2\) to the absolute integral, so the
infinite series diverges. The inverse field and signed one-step integrability
both fail. This is a probability example, but it is not independent and
identically distributed and the identity base is not ergodic. It separates
the hypotheses; it does not model repeated independent sampling.

### Near-miss 3: almost-everywhere invertibility is not this package

The structure requires <code>∀ ω, IsUnit (C.generator ω)</code>. A statement
that the generator is a unit outside a null set is weaker. One may eventually
develop an almost-everywhere representative interface, but it would need its
own proof that finite products and pointwise lower bounds are valid on a
common full-measure set. It cannot be substituted silently for the current
field.

### Boundary 1: inversion reverses matrix order

Because the cocycle puts the newest factor on the left,

\[
C(k,\omega)^{-1}
=A(\omega)^{-1}\cdots A(T^{k-1}\omega)^{-1}.
\]

The scalar log-norm estimate can add the inverse-tail terms in any order, but
the matrix product itself cannot. RMT-34 therefore does not pretend that these
inverse generators form a same-base one-sided inverse cocycle.

### Boundary 2: empty matrix dimension is totalized to zero

If the finite coordinate type has no elements, the unique square matrix is
both zero and identity. It is a unit, while the selected row-sum norm is zero.
Mathlib's total real logarithm has \(\log0=0\), so every real-log and
log-positive observable in this branch is zero. The public theorem handles
this type-level case separately, and the sandwich becomes \(0\leq0\leq0\).

### Boundary 3: a positive-rate shortcut is a different theorem

RMT-34 also proves that if the earlier log-positive growth rate is strictly
positive, then normalized log-positive and signed real logs eventually agree
almost everywhere. That route needs neither pointwise inverses nor the inverse
tail field. It cannot handle zero clipped rate or negative signed growth, so it
does not replace the two-sided tail package.

## What this page does not claim

- Integrable one-step tails do not imply independence or identical
  distribution.
- The three fields alone do not imply ergodicity or a deterministic limit.
- Finite-horizon \(L^1\) membership is not \(L^1\) convergence as
  \(k\to\infty\).
- The inverse norm does not identify every Lyapunov exponent, an asymptotic
  exponential growth rate, or construct an Oseledets splitting, a measurable
  decomposition into directions with different rates.
- Pointwise units do not construct an invertible two-sided base system.
- The small <code>Std</code> worksheet checks integer arithmetic only. The
  guarded Linux project command is the check for the exact Mathlib-backed
  source.

## Check your understanding

1. **Why is the forward tail zero at \(A(v)=[1/4]\)?**

   Because \(\log(1/4)=-\log4\lt0\), and \(\log^+\) replaces negative values by
   zero.

2. **Why is the inverse tail \(\log4\) at the same outcome?**

   The inverse is \([4]\), whose norm is \(4\), so its positive logarithm is
   \(\log4\).

3. **Which field fails in the geometric counterexample?**

   The inverse-tail integrability field fails. The unit field and the forward
   log-positive integrability field both hold.

4. **Why is measurability not enough?**

   A measurable function can still have infinite absolute integral. The
   geometric inverse tail is measurable but not integrable.

5. **What extra ingredients are needed before reading the RMT-35 asymptotic
   conclusion?**

   In addition to the tail package, the theorem uses a probability measure and
   the project's pre-ergodic condition for the preserved base.

## Where to continue

The
{{< refterm "log-positive-integrability-envelope" "log-positive integrability envelope" >}}
develops the forward field and its finite orbit-sum majorant. The
{{< refterm "extended-log-norm-observable" "extended log-norm observable" >}}
explains the zero-faithful extended-real value that the total real logarithm
does not retain. The
{{< refterm "ergodic-probability-base" "ergodic probability base" >}}
separates probability normalization from invariant-set rigidity.

[Finite-Horizon Log-Positive Cocycle Integrability]({{< relref "/knowledge-base/deep-dives/finite-horizon-log-positive-cocycle-integrability" >}})
derives the forward majorant in detail. [The Forward-and-Inverse Tail Sandwich
for Finite-Time Real Log Norms]({{< relref "/knowledge-base/deep-dives/forward-and-inverse-tail-sandwich-for-finite-time-real-log-norms" >}})
turns the present mechanism into a longer textbook ascent.

The [RMT-34 Development Notebook]({{< relref "/development-notebook/2026/07/real-log-norm-integrability-from-forward-and-inverse-tails-in-lean" >}})
records source-order engineering decisions and proof boundaries.

## References

<a id="ref-integrable-log-tails-project"></a>**Nonlinear Dynamics Lean project.**
[Site-hosted RMT-34 checked source](/lean/NonlinearDynamics/Random/RandomCocycles/RealLogNormIntegrability.lean),
with repository provenance at
[commit <code>624c727146532d3b2656f5f23136557d5779b4fd</code>](https://github.com/tdj28/nonlinear-dynamics-lean/commit/624c727146532d3b2656f5f23136557d5779b4fd),
<code>RealLogNormIntegrability.lean</code>. This is the authoritative source
for the three-field structure, finite-time sandwich, singular and empty
boundaries, geometric counterexample, and positive-rate shortcut described on
this page.

<a id="ref-integrable-log-tails-geometric"></a>**Mathlib contributors.**
[Geometric probability measures](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Probability/Distributions/Geometric.lean),
Mathlib 4. This pinned source defines <code>geometricMeasure</code>, proves its
probability-measure instance, computes singleton masses, and supplies the
weighted-series integrability test used by the compiled counterexample.

<a id="ref-integrable-log-tails-inverse"></a>**Mathlib contributors.**
[Total nonsingular matrix inverse](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/LinearAlgebra/Matrix/NonsingularInverse.lean),
Mathlib 4. This pinned source defines the determinant-adjugate total inverse,
proves its zero value on singular matrices, characterizes matrix units, and
proves the product-order theorem <code>Matrix.mul_inv_rev</code>.

<a id="ref-integrable-log-tails-poslog"></a>**Mathlib contributors.**
[Positive logarithm](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/SpecialFunctions/Log/PosLog.lean),
Mathlib 4. This pinned source defines <code>Real.posLog</code> as the maximum of
zero and the total real logarithm and proves the product bound used for finite
orbit majorants.

<a id="ref-integrable-log-tails-integrable"></a>**Mathlib contributors.**
[Bochner integrability bounds](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/L1Space/Integrable.lean#L632-L638),
Mathlib 4. The theorem <code>integrable_of_le_of_le</code> turns measurable
control by an integrable lower and upper function into integrability of the
sandwiched real-valued function.

<a id="ref-integrable-log-tails-kingman"></a>**J. F. C. Kingman.**
[The Ergodic Theory of Subadditive Stochastic Processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society, Series B* 30(3), 1968, 499-510.
This is the classical asymptotic destination for integrable subadditive
processes. The RMT-34 package prepares an input interface rather than
reproving the classical theorem.

<a id="ref-integrable-log-tails-oseledets"></a>**V. I. Oseledets.**
[A Multiplicative Ergodic Theorem: Characteristic Lyapunov Exponents of Dynamical Systems](https://www.mathnet.ru/eng/mmo214),
*Transactions of the Moscow Mathematical Society* 19, 1968, 197-231. This is
the classical source for measurable Lyapunov splittings. RMT-34 proves neither
a spectrum nor a splitting.

The exact upstream Lean revision audited for this page is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
