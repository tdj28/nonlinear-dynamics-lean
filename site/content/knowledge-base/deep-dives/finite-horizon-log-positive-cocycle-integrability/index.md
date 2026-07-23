---
title: "Finite-Horizon Log-Positive Cocycle Integrability"
slug: "finite-horizon-log-positive-cocycle-integrability"
date: 2026-07-21
summary: "Compute an exact four-state positive-log ledger, use a geometric expanding tail to exhibit nonintegrability, and then follow the checked Lean proof from one explicit generator hypothesis to every fixed finite horizon."
lead: "On a uniform four-state cycle, one-step positive logs have mean three quarters of log two, the two-step cocycle has mean one quarter, and its orbit-sum budget has mean three halves. Those finite numbers expose every job in the theorem before the general measure theory begins."
draft: false
pro_reviewed: false
level: "From finite weighted sums to measure-preserving pullbacks, Bochner integrability, and finite cocycle domination"
reading_time: "100 to 130 minutes"
prerequisites: "Arithmetic with fractions and powers; measures, measurable functions, integrability, cocycles, and Lean syntax are introduced from the finite example"
lean_module: "NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability"
toc: true
og_image: "finite-horizon-log-positive-cocycle-integrability-card.png"
og_image_alt: "A uniform four-state cycle with generator norms one half, two, one quarter, and four. The horizon-two positive-log values zero, zero, zero, one are pointwise below orbit budgets one, one, two, two, all measured in units of log two."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The mathematical
prose, sources, exact examples, Lean declaration map, worksheet, figures, and
accessibility have not yet received the required human and Pro reviews. The
page is publicly available as an open working note while those reviews remain
pending.
{{< /panel >}}

## Begin with four states and one exact ledger

Take four base states

\[
\Omega=\{0,1,2,3\}
\]

and let the base map move one place clockwise:

\[
T(0)=1,\qquad T(1)=2,\qquad T(2)=3,\qquad T(3)=0.
\]

Put mass \(1/4\) at each state. This is a probability measure because the four
masses add to one. The map \(T\) preserves it because \(T\) merely permutes
four equally weighted points. Every subset is an event and every real-valued
function is measurable on this finite discrete space.

Now use one-dimensional matrices. At the four states, choose the positive
generator values

\[
A(0)=\frac12,\qquad
A(1)=2,\qquad
A(2)=\frac14,\qquad
A(3)=4.
\]

Regarded as \(1\times1\) complex matrices, their operator norms are just their
absolute values. Each is a power of two:

\[
\lVert A(i)\rVert=2^{e_i},
\qquad
(e_0,e_1,e_2,e_3)=(-1,1,-2,2).
\]

We will measure logarithms in units of \(\log2\). This removes numerical
approximations without changing any inequality:

\[
\frac{\log \lVert A(i)\rVert}{\log2}=e_i.
\]

The positive logarithm keeps only the positive part,

\[
\log^+r=\max\{0,\log r\}.
\]

Therefore the one-step observable, again in units of \(\log2\), is

\[
\left(
\frac{P_1(0)}{\log2},
\frac{P_1(1)}{\log2},
\frac{P_1(2)}{\log2},
\frac{P_1(3)}{\log2}
\right)
=(0,1,0,2).
\]

The contractions \(1/2\) and \(1/4\) contribute zero. The expansions \(2\)
and \(4\) contribute one and two.

Because the measure is uniform, the integral is the ordinary average:

\[
\int_\Omega P_1\,d\mu
{} =
\frac{0+1+0+2}{4}\log2
{} =
\frac34\log2.
\]

This number is finite. In this example the explicit one-step integrability
hypothesis is true.

### Compute the two-step cocycle before bounding it

For a generator-presented one-sided cocycle,

\[
C(2,i)=A(Ti)A(i).
\]

Multiplying powers of two adds their signed exponents. Taking positive log
afterward keeps the positive part of that total. The four exact calculations
are:

| Start \(i\) | Signed exponents | Product norm | \(P_2(i)/\log2\) |
|---:|---:|---:|---:|
| \(0\) | \(-1+1=0\) | \(1\) | \(0\) |
| \(1\) | \(1-2=-1\) | \(1/2\) | \(0\) |
| \(2\) | \(-2+2=0\) | \(1\) | \(0\) |
| \(3\) | \(2-1=1\) | \(2\) | \(1\) |

So

\[
\int_\Omega P_2\,d\mu=\frac14\log2.
\]

The theorem does not compute \(P_2\) from an average. It first constructs the
pointwise orbit budget

\[
S_2(i)=P_1(i)+P_1(Ti).
\]

Its four values in \(\log2\)-units are

\[
(1,1,2,2).
\]

Thus

\[
\int_\Omega S_2\,d\mu
{} =
\frac{1+1+2+2}{4}\log2
{} =
\frac32\log2.
\]

At every state,

\[
0\le P_2(i)\le S_2(i).
\]

The inequality is strict at all four states in this example. Positive parts
do not add exactly: a later expansion can cancel an earlier contraction in the
signed product, while \(S_2\) has already clipped the contraction to zero.

At horizon four, every orbit sees all four signed exponents. Their sum is
zero, so \(P_4=0\) everywhere. But every orbit sum is
\(S_4=(0+1+0+2)\log2=3\log2\). A useful majorant need not be sharp.

{{< reference-figure
  wide="true"
  src="four-cycle-positive-log-ledger.svg"
  alt="Four equally likely states form a cycle. Their generator norms are one half, two, one quarter, and four; signed base-two exponents are minus one, one, minus two, and two; one-step positive-log coefficients are zero, one, zero, and two. At horizon two the positive-log coefficients zero, zero, zero, one are below orbit budgets one, one, two, two. Their uniform means are one quarter and three halves."
  caption="**Exact finite ledger:** the uniform one-step mean is \(\frac34\log2\). At horizon two, \(P_2/\log2=(0,0,0,1)\) while \(S_2/\log2=(1,1,2,2)\), giving means \(1/4\) and \(3/2\). The base is measure preserving because it is a permutation; no independence, limiting theorem, or Lyapunov exponent is involved."
>}}

## What the measure-theory words mean here

The finite ledger is already a complete small model of the vocabulary.

- A {{< refterm "measurable-space" "measurable space" >}} specifies which
  subsets count as events. Here every subset of \(\Omega\) is an event.
- A {{< refterm "measure" "measure" >}} assigns nonnegative mass to events.
  Here the mass of a set is the number of its points divided by four.
- A {{< refterm "probability-measure" "probability measure" >}} has total mass
  one. That is why the integral above can also be called an expectation.
- A {{< refterm "measurable-function" "measurable function" >}} respects the
  selected events. Every function out of this finite discrete space does.
- A real function is {{< refterm "integrability" "integrable" >}} when its
  absolute size has finite integral. A finite list of finite values with finite
  weights is automatically integrable.
- A {{< refterm "null-set" "null set" >}} has mass zero. Because every point
  here has positive mass, the only null set is the empty set.
- A claim holding {{< refterm "almost-everywhere" "almost everywhere" >}} may
  fail on a null set. In this finite example that means it holds everywhere.

For a function \(f:\Omega\to\mathbb R\), the integral is the weighted sum

\[
\int_\Omega f\,d\mu
{} =
\frac14f(0)+\frac14f(1)+\frac14f(2)+\frac14f(3).
\]

For integrability one inserts absolute values:

\[
\int_\Omega |f|\,d\mu\lt\infty.
\]

The target observable \(P_k\) is nonnegative, so \(|P_k|=P_k\). This small
identity is exactly the final step used by the Lean proof.

### A measure need not be a probability measure

The target module accepts an arbitrary raw measure \(\mu\). To see the
difference, give each of the same four states mass \(2\). The total mass is
\(8\), not \(1\). The one-step integral in \(\log2\)-units becomes

\[
2(0+1+0+2)=6.
\]

It is still finite, so \(P_1\) is integrable. But \(6\log2\) is not an
expectation under that unnormalized measure. “Integral” is the correct general
word; “expectation” is reserved for a probability measure.

Measure preservation also has a precise job. It says that moving all mass
through \(T\) does not change the measure. Consequently, if \(P_1\) is already
integrable, then each shifted function

\[
\omega\longmapsto P_1(T^j\omega)
\]

is integrable. Preservation transports an existing fact. It does not turn an
arbitrary measurable function into an integrable one.

## The explicit hypothesis can genuinely fail

Finite spaces hide heavy tails. Move to the countable space
\(\Omega=\mathbb N\), keep the identity base \(T(n)=n\), and put geometric
probability mass

\[
\mu\{n\}=2^{-(n+1)}
\]

at atom \(n\). The masses sum to one. The identity map preserves them, and
every function is measurable for the discrete measurable structure.

Choose a one-dimensional expanding generator with norm

\[
\lVert A(n)\rVert=\exp(2^n).
\]

Then

\[
P_1(n)=\log^+\lVert A(n)\rVert=2^n.
\]

Every atom contributes exactly the same amount to the integral:

\[
\mu\{n\}P_1(n)
{} =
2^{-(n+1)}2^n
{} =
\frac12.
\]

Therefore the first \(N\) atoms already contribute \(N/2\), and

\[
\int_{\mathbb N}P_1\,d\mu
{} =
\frac12+\frac12+\frac12+\cdots
{} =
\infty.
\]

This is not merely a large finite sample. The algebra proves every summand is
\(1/2\), so the partial integrals are unbounded. Probability normalization,
ordinary measurability, and measure preservation are all present, yet
<code>HasIntegrableGeneratorLogPlus</code> is false.

{{< reference-figure
  wide="true"
  src="geometric-expanding-nonintegrable-near-miss.svg"
  alt="On atom n, a geometric probability has mass one over two to the n plus one and a scalar generator has norm exponential of two to the n. Its one-step positive log is two to the n, so every weighted contribution is one half. Six rows and a staircase show partial integrals one half, one, three halves, two, five halves, and three, continuing as N over two."
  caption="**A genuine failed hypothesis:** the identity base preserves a probability measure and the one-step observable is measurable, but its positive-log integral diverges because every atom contributes \(1/2\). RMT-15 states one-step integrability explicitly precisely because the other assumptions cannot create it."
>}}

### The opposite sign is a wrong-level near miss

Replace the generator norm by

\[
\lVert A(n)\rVert=\exp(-2^n).
\]

Now every norm is at most one, so \(P_1(n)=0\). The RMT-15 hypothesis holds
because the positive-log observable is identically zero. But the signed
logarithm has magnitude \(2^n\), and its weighted absolute integral again
contains \(1/2\) at every atom. The inverse norm has
the same expanding tail.

This does not contradict RMT-15. Positive log deliberately erased the
contraction before integrability was discussed. A later project module checks
this geometric contraction model as a counterexample separating forward
positive-log integrability from inverse-tail and signed-real-log
integrability. The target module makes neither stronger claim.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [Four states and one ledger](#begin-with-four-states-and-one-exact-ledger) | Compute \(P_1\), \(P_2\), and \(S_2\) exactly |
| Vocabulary route | [What the words mean](#what-the-measure-theory-words-mean-here) | Separate measure, probability, measurability, and integrability |
| Failure route | [The explicit hypothesis can fail](#the-explicit-hypothesis-can-genuinely-fail) | See a genuine measurable nonintegrable positive tail |
| Lean route | [Seven bridges](#in-lean-seven-bridges-from-the-ledger-to-the-theorem) | Translate human statements into exact project syntax |
| Hands-on route | [Run the worksheet](#type-the-ledgers-yourself-with-lean-and-std) | Recheck both finite and geometric arithmetic locally |
| Proof route | [Why the propagation works](#why-the-finite-horizon-propagation-works) | Follow pullbacks, finite sums, and domination |
| Interface route | [The complete declaration map](#the-complete-sixteen-declaration-map) | Audit every public name and its assumptions |
| Summit route | [What has and has not been proved](#summit-what-has-and-has-not-been-proved) | Keep finite integrability separate from asymptotic dynamics |

### Learning objectives

By the summit, you should be able to compute the four-state ledger without a
calculator; explain why a finite weighted list is integrable; distinguish a
raw integral from an expectation; produce the geometric heavy-tail
counterexample; explain what positive log erases; read seven Lean bridges
token by token; run the bounded <code>Std</code> worksheet; derive the
orbit-sum majorant; reconstruct the pullback and domination proof; audit all
sixteen public declarations; and state which probability, tail, uniform-time,
ergodic, and Lyapunov conclusions remain outside the file.

## In Lean: seven bridges from the ledger to the theorem

All seven bridges below belong to
<code>NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability</code>.
The human sentence, paper formula, and Lean expression say the same thing at
three levels.

### Bridge one: define the real nonnegative envelope

{{< lean-bridge
  human="At a fixed horizon and base state, take the positive logarithm of the cocycle matrix norm."
  math="\(P_k(\omega)=\log^+\lVert C(k,\omega)\rVert_\infty\in\mathbb R.\)"
  lean="C.logPlusNormObservable k ω : ℝ"
>}}

- <code>C</code> is the bundled discrete matrix cocycle.
- <code>k</code> is a natural-number factor count.
- <code>ω</code> is one base state.
- <code>normObservable</code> computes the finite matrix norm.
- <code>log⁺</code> is Mathlib's <code>Real.posLog</code>, namely the maximum
  of zero and the real logarithm.
- The codomain is <code>ℝ</code>, so exact collapse and contraction have no
  bottom value here.
{{< /lean-bridge >}}

The companion theorem
<code>C.logPlusNormObservable_nonneg k ω</code> supplies
\(0\le P_k(\omega)\).

### Bridge two: split a finite history

{{< lean-bridge
  human="The positive log of the full history is at most the shifted later-block positive log plus the early-block positive log."
  math="\(P_{m+k}(\omega)\le P_k(T^m\omega)+P_m(\omega).\)"
  lean="C.logPlusNormObservable_add_le m k ω"
>}}

- <code>m + k</code> is the total horizon.
- <code>C.base^[m] ω</code> is \(T^m\omega\), the base state after the early
  block.
- The shifted \(k\)-block acts later and appears on the left in the matrix
  product.
- The first inequality comes from matrix-norm submultiplicativity.
- <code>Real.posLog_mul</code> turns the product budget into an additive
  positive-log budget.
{{< /lean-bridge >}}

### Bridge three: add the shifted one-step costs

{{< lean-bridge
  human="For a finite horizon, add the one-step positive logs observed along the first k base states."
  math="\(S_k(\omega)=\sum_{j=0}^{k-1}P_1(T^j\omega).\)"
  lean="C.orbitLogPlusSum k ω"
>}}

- <code>Finset.range k</code> contains \(0,\ldots,k-1\).
- <code>C.base^[j] ω</code> is the \(j\)-fold base iterate.
- Every summand uses horizon one.
- At <code>k = 0</code>, the finite range is empty and the sum is zero.
- This is a deterministic finite sum along one orbit, not a sum of independent
  random variables.
{{< /lean-bridge >}}

### Bridge four: append the newest term

{{< lean-bridge
  human="Increasing the horizon by one appends the one-step cost at the kth base iterate."
  math="\(S_{k+1}(\omega)=S_k(\omega)+P_1(T^k\omega).\)"
  lean="C.orbitLogPlusSum_succ k"
>}}

- The theorem is equality of functions.
- Supplying <code>ω</code> evaluates both sides at one state.
- <code>Finset.sum_range_succ</code> is the finite-list arithmetic behind the
  identity.
- The index \(k\) is the newly appended term because counting starts at zero.
{{< /lean-bridge >}}

### Bridge five: the orbit sum dominates pointwise

{{< lean-bridge
  human="At every state and fixed finite horizon, the cocycle positive log lies below the one-step orbit budget."
  math="\(P_k(\omega)\le S_k(\omega).\)"
  lean="C.logPlusNormObservable_le_orbitLogPlusSum k ω"
>}}

- This is pointwise, stronger than an almost-everywhere inequality.
- The proof inducts on <code>k</code>.
- The successor step splits the horizon as <code>k + 1</code>.
- Bridge two creates the newest one-step term; bridge four identifies the
  resulting sum.
- No measure, integral, or probability arithmetic is used in this proof.
{{< /lean-bridge >}}

### Bridge six: name the missing analytic assumption

{{< lean-bridge
  human="Assume explicitly that the one-step positive-log generator norm is integrable against the stated measure."
  math="\(P_1\in L^1(\mu).\)"
  lean="C.HasIntegrableGeneratorLogPlus"
>}}

- The name unfolds to
  <code>Integrable (C.logPlusNormObservable 1) μ</code>.
- <code>Integrable</code> is Mathlib's Bochner-integrability predicate.
- For a real function it includes suitable almost-everywhere measurability and
  a finite integral of the absolute value.
- The target module already proves ordinary measurability, but that does not
  imply a finite integral.
- The geometric expanding model above is a concrete counterexample to any
  attempted automatic proof.
{{< /lean-bridge >}}

### Bridge seven: propagate to every fixed horizon

{{< lean-bridge
  human="Under the one-step hypothesis, the positive-log norm at every natural finite horizon is integrable."
  math="\(P_k\in L^1(\mu)\quad\text{for every }k\in\mathbb N.\)"
  lean="hC.integrable_logPlusNormObservable k"
>}}

- <code>hC</code> is evidence for bridge six.
- <code>hC.integrable_at_base_iterate j</code> first transports integrability
  to \(P_1\circ T^j\).
- <code>hC.integrable_orbitLogPlusSum k</code> adds the finite family.
- <code>Integrable.mono'</code> transfers integrability from \(S_k\) to
  \(P_k\).
- Nonnegativity rewrites \(\lvert P_k\rvert\) as \(P_k\), and bridge five
  supplies the required domination.
- “Every \(k\)” means each fixed natural horizon. It is not one
  uniform-in-\(k\) integrable bound.
{{< /lean-bridge >}}

### Check the exact project interface

{{< repo-check >}}
**Full project check: pinned project plus Mathlib.** Put these commands in a
temporary project scratch file if you want to inspect every public declaration:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability

open NonlinearDynamics.Random.RandomCocycles

#print DiscreteMatrixCocycle.logPlusNormObservable
#check DiscreteMatrixCocycle.logPlusNormObservable_nonneg
#check DiscreteMatrixCocycle.logPlusNormObservable_zero
#check DiscreteMatrixCocycle.logPlusNormObservable_one
#check DiscreteMatrixCocycle.measurable_logPlusNormObservable
#check DiscreteMatrixCocycle.logPlusNormObservable_add_le
#check DiscreteMatrixCocycle.logPlusNormObservable_eq_zero_of_isEmpty
#print DiscreteMatrixCocycle.orbitLogPlusSum
#check DiscreteMatrixCocycle.orbitLogPlusSum_zero
#check DiscreteMatrixCocycle.orbitLogPlusSum_succ
#check DiscreteMatrixCocycle.measurable_orbitLogPlusSum
#check DiscreteMatrixCocycle.logPlusNormObservable_le_orbitLogPlusSum
#print DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integrable_at_base_iterate
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integrable_orbitLogPlusSum
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integrable_logPlusNormObservable
~~~

The full project command rendered below checks the authoritative source file
with the pinned toolchain and dependencies. This import reaches Mathlib.
{{< /repo-check >}}

## Type the ledgers yourself with Lean and Std

The project theorem uses Mathlib matrices, measures, iterates, and Bochner
integrability. The arithmetic that motivates it is much smaller. The following
worksheet imports only <code>Std</code>, represents logarithms by their exact
coefficients, and checks the finite and geometric ledgers without compiling
Mathlib.

Create a scratch directory outside <code>formalization/</code>. Save the exact
block below as <code>FiniteHorizonLogPlusIntegrabilityTutorial.lean</code>:

~~~lean
import Std

namespace FiniteHorizonLogPlusIntegrabilityTutorial

/-
The four generator norms are powers of two:

  state       0     1     2     3
  norm       1/2    2    1/4    4
  exponent    -1    1     -2    2

All logarithms below are measured in units of log 2.  This keeps every
calculation exact while preserving the positive-log arithmetic.
-/

def exponentAt (state : Nat) : Int :=
  match state % 4 with
  | 0 => -1
  | 1 => 1
  | 2 => -2
  | _ => 2

def base (state : Nat) : Nat :=
  (state + 1) % 4

def positivePart (z : Int) : Nat :=
  z.toNat

def oneStepPositive (state : Nat) : Nat :=
  positivePart (exponentAt state)

def signedExponent (state horizon : Nat) : Int :=
  (List.range horizon).foldl
    (fun total j => total + exponentAt (state + j)) 0

def horizonPositive (state horizon : Nat) : Nat :=
  positivePart (signedExponent state horizon)

def orbitBudget (state horizon : Nat) : Nat :=
  ((List.range horizon).map
    (fun j => oneStepPositive (state + j))).sum

structure HorizonLedger where
  start : Nat
  signedExponent : Int
  horizonPositive : Nat
  orbitBudget : Nat
  deriving Repr, DecidableEq

def ledgerAt (horizon start : Nat) : HorizonLedger :=
  { start := start
    signedExponent := signedExponent start horizon
    horizonPositive := horizonPositive start horizon
    orbitBudget := orbitBudget start horizon }

def horizonTwoLedger : List HorizonLedger :=
  (List.range 4).map (ledgerAt 2)

def horizonFourLedger : List HorizonLedger :=
  (List.range 4).map (ledgerAt 4)

def fairMean (values : List Nat) : Rat :=
  (values.sum : Rat) / values.length

def oneStepMean : Rat :=
  fairMean ((List.range 4).map oneStepPositive)

def horizonTwoMean : Rat :=
  fairMean ((List.range 4).map (fun state => horizonPositive state 2))

def horizonTwoBudgetMean : Rat :=
  fairMean ((List.range 4).map (fun state => orbitBudget state 2))

/-
The same four atoms with raw mass 2 each have total mass 8.  Their integral
is still finite, but it is not an expectation until the measure is normalized.
-/

def rawMassTwoOneStepIntegral : Nat :=
  2 * ((List.range 4).map oneStepPositive).sum

/-
Near miss on the countable probability space Nat:

  mass at n                 = 1 / 2^(n+1)
  generator norm           = exp (-(2^n))
  positive log             = 0
  missing negative magnitude = 2^n

Each missing-tail contribution is exactly 1/2, so its partial sums grow
without bound even though the positive-log integral is zero.
-/

def tailWeight (n : Nat) : Rat :=
  1 / (2 ^ (n + 1) : Nat)

def missingNegativeMagnitude (n : Nat) : Nat :=
  2 ^ n

def missingTailContribution (n : Nat) : Rat :=
  tailWeight n * missingNegativeMagnitude n

def missingTailPartialSum (count : Nat) : Rat :=
  ((List.range count).map missingTailContribution).sum

def forwardPositivePartialSum (count : Nat) : Rat :=
  ((List.range count).map (fun _ => (0 : Rat))).sum

/-
Flipping the sign in the exponent gives the expanding generator
exp (2^n).  Then the very same contributions belong to the positive log,
so the RMT-15 one-step hypothesis itself fails.
-/

def expandingPositiveContribution (n : Nat) : Rat :=
  tailWeight n * missingNegativeMagnitude n

def expandingPositivePartialSum (count : Nat) : Rat :=
  ((List.range count).map expandingPositiveContribution).sum

structure TailLedger where
  atom : Nat
  weight : Rat
  positiveLog : Nat
  missingNegativeMagnitude : Nat
  weightedMissingTail : Rat
  deriving Repr, DecidableEq

def tailLedger (count : Nat) : List TailLedger :=
  (List.range count).map fun n =>
    { atom := n
      weight := tailWeight n
      positiveLog := 0
      missingNegativeMagnitude := missingNegativeMagnitude n
      weightedMissingTail := missingTailContribution n }

#eval (List.range 4).map exponentAt
#eval (List.range 4).map oneStepPositive
#eval horizonTwoLedger
#eval horizonFourLedger
#eval [oneStepMean, horizonTwoMean, horizonTwoBudgetMean]
#eval rawMassTwoOneStepIntegral
#eval (List.range 6).map missingTailContribution
#eval (List.range 6).map missingTailPartialSum
#eval (List.range 6).map forwardPositivePartialSum
#eval (List.range 6).map expandingPositivePartialSum

example : (List.range 4).map exponentAt = [-1, 1, -2, 2] := by
  native_decide

example : (List.range 4).map oneStepPositive = [0, 1, 0, 2] := by
  native_decide

example : horizonTwoLedger =
    [ { start := 0, signedExponent := 0,
        horizonPositive := 0, orbitBudget := 1 },
      { start := 1, signedExponent := -1,
        horizonPositive := 0, orbitBudget := 1 },
      { start := 2, signedExponent := 0,
        horizonPositive := 0, orbitBudget := 2 },
      { start := 3, signedExponent := 1,
        horizonPositive := 1, orbitBudget := 2 } ] := by
  native_decide

example : horizonTwoLedger.all
    (fun row => decide (row.horizonPositive ≤ row.orbitBudget)) := by
  native_decide

example : horizonFourLedger.map
    (fun row => (row.horizonPositive, row.orbitBudget)) =
      [(0, 3), (0, 3), (0, 3), (0, 3)] := by
  native_decide

example : oneStepMean = 3 / 4 := by native_decide
example : horizonTwoMean = 1 / 4 := by native_decide
example : horizonTwoBudgetMean = 3 / 2 := by native_decide
example : rawMassTwoOneStepIntegral = 6 := by native_decide

example : (List.range 6).map missingTailContribution =
    [1 / 2, 1 / 2, 1 / 2, 1 / 2, 1 / 2, 1 / 2] := by
  native_decide

example : missingTailPartialSum 8 = 4 := by native_decide
example : forwardPositivePartialSum 8 = 0 := by native_decide
example : expandingPositivePartialSum 8 = 4 := by native_decide

end FiniteHorizonLogPlusIntegrabilityTutorial
~~~

Open a terminal in that scratch directory and type:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean \
  FiniteHorizonLogPlusIntegrabilityTutorial.lean
~~~

**Resource label: small standalone Lean tutorial, ordinary Mac or Linux.**
This exact worksheet was executed with Lean 4.32.0 and printed this complete
transcript:

~~~text
[-1, 1, -2, 2]
[0, 1, 0, 2]
[{ start := 0, signedExponent := 0, horizonPositive := 0, orbitBudget := 1 },
 { start := 1, signedExponent := -1, horizonPositive := 0, orbitBudget := 1 },
 { start := 2, signedExponent := 0, horizonPositive := 0, orbitBudget := 2 },
 { start := 3, signedExponent := 1, horizonPositive := 1, orbitBudget := 2 }]
[{ start := 0, signedExponent := 0, horizonPositive := 0, orbitBudget := 3 },
 { start := 1, signedExponent := 0, horizonPositive := 0, orbitBudget := 3 },
 { start := 2, signedExponent := 0, horizonPositive := 0, orbitBudget := 3 },
 { start := 3, signedExponent := 0, horizonPositive := 0, orbitBudget := 3 }]
[(3 : Rat)/4, (1 : Rat)/4, (3 : Rat)/2]
6
[(1 : Rat)/2, (1 : Rat)/2, (1 : Rat)/2, (1 : Rat)/2, (1 : Rat)/2, (1 : Rat)/2]
[0, (1 : Rat)/2, 1, (3 : Rat)/2, 2, (5 : Rat)/2]
[0, 0, 0, 0, 0, 0]
[0, (1 : Rat)/2, 1, (3 : Rat)/2, 2, (5 : Rat)/2]
~~~

The first two lines are the signed exponents and their positive parts. The
next two ledgers give horizons two and four. The three rational means are
\(3/4\), \(1/4\), and \(3/2\); the raw mass-two integral is \(6\). The next
line shows six identical geometric contributions of \(1/2\). The final three
lines show their partial sums: the missing contraction tail grows as \(N/2\),
the contraction's forward positive log stays zero, and the expanding positive
tail again grows as \(N/2\).

<code>native_decide</code> does not estimate these values. It evaluates exact
integer and rational computations and produces a proof term checked by Lean's
kernel. The worksheet models logarithms by exact coefficients; it
does not reimplement Mathlib's analytic logarithm, matrix norm, measure, or
<code>Integrable</code> predicate. Those authoritative interfaces remain the
full project check above.

## Why the finite-horizon propagation works

Return to the general setting. Fix:

- a base type \(\Omega\) with a measurable-space structure;
- a finite matrix index type \(\iota\) with decidable equality;
- an arbitrary measure \(\mu\) on \(\Omega\); and
- a bundled <code>DiscreteMatrixCocycle μ</code>.

The cocycle stores a measurable generator \(A\), a measurable
measure-preserving base map \(T\), and the newest-factor-left finite product

\[
C(m+k,\omega)
{} =
C(k,T^m\omega)C(m,\omega).
\]

The predecessor module defines

\[
N_k(\omega)=\lVert C(k,\omega)\rVert_\infty
\]

using the maximum absolute row-sum matrix norm and proves

\[
N_{m+k}(\omega)
\le
N_k(T^m\omega)N_m(\omega).
\]

### Positive log keeps only expansion

The target defines

\[
P_k(\omega)=\log^+N_k(\omega)
\]

as an ordinary real number. For nonnegative norm inputs:

\[
\log^+r=
\begin{cases}
0,&0\le r\le1,\\
\log r,&1\le r.
\end{cases}
\]

| Norm regime | \(P_k\) records |
|---|---:|
| exact zero | \(0\) |
| strict contraction \(0\lt r\lt1\) | \(0\) |
| neutral norm \(r=1\) | \(0\) |
| expansion \(r\gt1\) | \(\log r\) |

The first three cases collapse to one value. This is why \(P_k\) is an upper
integrability envelope, not the predecessor's zero-faithful extended log norm
and not a signed growth rate.

Mathlib proves that <code>Real.posLog</code> is continuous, hence measurable.
Composing it with the predecessor's measurable norm observable gives
<code>measurable_logPlusNormObservable</code>.

At time zero, the cocycle value is the identity. In nonempty matrix dimension
its norm is one; in empty dimension its norm is zero. Positive log sends both
to zero, so

\[
P_0=0
\]

without a <code>Nonempty ι</code> assumption. In empty dimension every matrix
value has norm zero and every \(P_k\) is identically zero.

### Finite-time subadditivity

Pass the norm split through the monotone positive logarithm:

\[
\begin{aligned}
P_{m+k}(\omega)
&=\log^+N_{m+k}(\omega)\\
&\le
\log^+\!\left(
N_k(T^m\omega)N_m(\omega)
\right)\\
&\le
\log^+N_k(T^m\omega)+\log^+N_m(\omega).
\end{aligned}
\]

The first inequality uses norm nonnegativity and positive-log monotonicity.
The second is Mathlib's product inequality
<code>Real.posLog_mul</code>. It is an inequality rather than an equality
because clipping can discard negative logarithms before addition.

### Induct to the one-step orbit budget

Define

\[
S_k(\omega)=\sum_{j=0}^{k-1}P_1(T^j\omega).
\]

The empty sum is zero and

\[
S_{k+1}(\omega)
{} =
S_k(\omega)+P_1(T^k\omega).
\]

Now induct on \(k\). The base case is \(P_0=0=S_0\). For the successor,
finite-time subadditivity at the split \(k+1\) gives

\[
P_{k+1}(\omega)
\le
P_1(T^k\omega)+P_k(\omega).
\]

Apply the induction hypothesis \(P_k\le S_k\), commute the two real summands,
and recognize \(S_{k+1}\). Therefore

\[
0\le P_k(\omega)\le S_k(\omega)
\]

for every state, not merely almost everywhere.

### Transport, add, dominate

Assume

\[
\operatorname{Integrable}(P_1,\mu).
\]

The bundled cocycle proves that every natural iterate \(T^j\) is
measure-preserving. Mathlib's pullback theorem transports the assumption to

\[
P_1\circ T^j.
\]

There are only \(k\) such terms in \(S_k\). Finite sums of integrable
functions are integrable, so \(S_k\) is integrable. No independence,
identical-distribution assumption, infinite series, or convergence theorem is
needed.

Finally, \(P_k\) is measurable, \(P_k\ge0\), and \(P_k\le S_k\). Hence

\[
|P_k|=P_k\le S_k.
\]

Mathlib's dominated-integrability method <code>Integrable.mono'</code>
therefore proves \(P_k\) integrable.

{{< reference-figure
  src="finite-horizon-log-positive-integrability.svg"
  alt="An explicit one-step positive-log integrability hypothesis is transported along every iterate of a measure-preserving base, producing integrable pulled-back terms whose finite orbit sum dominates the finite-horizon positive-log norm. A warning branch states that contraction and exact collapse were clipped away."
  caption="**The general proof pipeline:** an explicit one-step \(L^1\) fact is pulled back by preserved base iterates, finite addition builds an integrable \(S_k\), and \(0\le P_k\le S_k\) transfers integrability. The warning branch is essential: positive log discarded contraction and collapse before the argument began."
>}}

## The complete sixteen-declaration map

The file exposes exactly sixteen public declarations in source order.

| # | Declaration | Exact role |
|---:|---|---|
| 1 | <code>logPlusNormObservable</code> | Defines \(P_k:\Omega\to\mathbb R\) |
| 2 | <code>logPlusNormObservable_nonneg</code> | Proves \(0\le P_k(\omega)\) pointwise |
| 3 | <code>logPlusNormObservable_zero</code> | Proves \(P_0=0\) in every finite dimension |
| 4 | <code>logPlusNormObservable_one</code> | Identifies \(P_1(\omega)=\log^+\lVert A(\omega)\rVert\) |
| 5 | <code>measurable_logPlusNormObservable</code> | Proves ordinary measurability of every fixed \(P_k\) |
| 6 | <code>logPlusNormObservable_add_le</code> | Proves the shifted finite-time subadditivity inequality |
| 7 | <code>logPlusNormObservable_eq_zero_of_isEmpty</code> | Makes every \(P_k\) zero in empty matrix dimension |
| 8 | <code>orbitLogPlusSum</code> | Defines \(S_k=\sum_{j\lt k}P_1\circ T^j\) |
| 9 | <code>orbitLogPlusSum_zero</code> | Proves the empty orbit sum is zero |
| 10 | <code>orbitLogPlusSum_succ</code> | Appends the term at base iterate \(k\) |
| 11 | <code>measurable_orbitLogPlusSum</code> | Proves the finite orbit sum measurable |
| 12 | <code>logPlusNormObservable_le_orbitLogPlusSum</code> | Proves \(P_k\le S_k\) pointwise |
| 13 | <code>HasIntegrableGeneratorLogPlus</code> | Names the explicit assumption \(\operatorname{Integrable}(P_1,\mu)\) |
| 14 | <code>HasIntegrableGeneratorLogPlus.integrable_at_base_iterate</code> | Transports integrability through \(T^j\) |
| 15 | <code>HasIntegrableGeneratorLogPlus.integrable_orbitLogPlusSum</code> | Adds the finite integrable family |
| 16 | <code>HasIntegrableGeneratorLogPlus.integrable_logPlusNormObservable</code> | Dominates \(P_k\) by \(S_k\) and concludes integrability |

The ambient assumptions are a measurable base type, a finite matrix index type
with decidable equality, and an arbitrary measure. There is no global
<code>Nonempty ι</code>, probability, finite-measure, sigma-finite, ergodic,
invertible-base, or independence assumption.

The bundled cocycle receiver still carries its base-preservation and
measurability fields even when an early pointwise theorem does not consume
them. That packaging should not be mistaken for additional theorem-specific
hypotheses.

## Edge cases worth keeping visible

### Horizon zero

The conclusion theorem retains the one-step hypothesis even at \(k=0\),
because it is stated uniformly for every natural \(k\). But \(P_0=0\) is
integrable without that hypothesis. A separate zero-only theorem could omit
it; the current declaration instead presents one uniform interface.

### Empty matrix dimension

When \(\iota\) is empty, every square matrix is the unique empty matrix and its
selected norm is zero. The positive-log observable is identically zero at
every horizon. This is why the target's time-zero theorem needs no inhabited
coordinate type even though the predecessor's norm-one theorem does.

### Zero measure

Under the zero measure, every suitably measurable finite real function is
integrable because all integrals vanish. The theorem allows this degenerate
case. It does not silently normalize the measure.

### Pointwise versus almost everywhere

The cocycle inequality \(P_k\le S_k\) is pointwise. The final Mathlib
integrability interface asks only for an almost-everywhere norm bound, so the
proof converts the stronger statement into the weaker form automatically.

### Finite horizons versus one uniform bound

For each fixed \(k\), the sum \(S_k\) has finitely many integrable terms. This
does not exhibit one integrable random variable dominating \(P_k\) for all
\(k\), and it does not justify exchanging a limit with an integral.

## Exercises from foothill to summit

### Foothill

1. Recompute the four one-step positive-log coefficients.
2. Multiply the four horizon-two scalar pairs and recover
   \(P_2/\log2=(0,0,0,1)\).
3. Compute \(S_2/\log2=(1,1,2,2)\).
4. Verify all four pointwise inequalities \(P_2\le S_2\).
5. Replace uniform masses by \(1/10,2/10,3/10,4/10\). Decide whether the same
   clockwise cycle preserves the new probability measure.
6. Give each state raw mass two and explain why the word “expectation” is no
   longer appropriate.

### Ridge

7. Expand \(S_3(\omega)\) with all three base iterates visible.
8. Derive \(S_{k+1}=S_k+P_1\circ T^k\) from a finite range.
9. Prove \(P_k\le S_k\) by induction on paper.
10. In the expanding geometric model, prove the masses sum to one.
11. Prove every weighted positive-log contribution is \(1/2\).
12. Explain why an identity base is measure preserving but does not create
    integrability.
13. Change the sign of the geometric exponent and distinguish the forward
    positive tail from the missing signed tail.

### Summit

14. Translate <code>Integrable.mono'</code> into measurability, an integrable
    majorant, and an almost-everywhere norm bound.
15. Audit all sixteen declarations against their exact assumptions.
16. Explain why no independence hypothesis appears in the finite-sum proof.
17. State an additional hypothesis that would control the inverse-generator
    positive log.
18. State what probability and asymptotic assumptions would be needed before
    invoking a precise subadditive ergodic theorem.
19. Explain why an integrable \(P_k\) does not make the predecessor's
    extended-real log norm integrable.
20. Design a derivative-cocycle interface for a nonlinear random dynamical
    system and list the chain-rule and measurability facts it would require.

## Reproduce the chapter

The bounded <code>Std</code> worksheet above is a standalone tutorial for an
ordinary macOS or Linux host. The exact target imports Mathlib and is a full
project check. From the repository root, run:

~~~sh
cd formalization
lake env lean NonlinearDynamics/Random/RandomCocycles/LogPlusIntegrability.lean
~~~

This command may require substantial disk space and memory. Passing technical
checks would still leave human mathematical,
source, accessibility, scientific-integrity, and editorial review pending.

## Summit: what has and has not been proved

| Topic | Status in RMT-15 |
|---|---|
| Real positive-log finite-time norm | Defined |
| Pointwise nonnegativity | Checked |
| Time-zero value zero in every finite dimension | Checked |
| One-step generator identity | Checked |
| Ordinary measurability at each fixed horizon | Checked |
| Shifted positive-log subadditivity | Checked pointwise |
| Empty-dimensional observable identically zero | Checked |
| Finite shifted one-step orbit sum | Defined |
| Empty-sum and successor identities | Checked |
| Orbit-sum measurability | Checked |
| Pointwise domination \(P_k\le S_k\) | Checked |
| One-step positive-log integrability | Explicit hypothesis |
| Integrability after every natural base iterate | Checked under the hypothesis |
| Integrability of every finite orbit sum | Checked under the hypothesis |
| Integrability of every fixed finite-horizon \(P_k\) | Checked under the hypothesis |
| Probability normalization or expectation | Not assumed or defined |
| Automatic integrability from measurability or preservation | False; the geometric example shows failure |
| Signed or extended-log integrability | Not proved |
| Negative tail, inverse norm, or smallest singular value control | Not proved |
| Uniform-in-time integrable domination | Not proved |
| Independence, identical distribution, mixing, or ergodicity | Not assumed |
| Normalized samplewise or integrated limit | Not defined or proved |
| Kingman or Furstenberg–Kesten conclusion | Not invoked |
| Lyapunov exponent, spectrum, filtration, or splitting | Not defined or proved |
| Two-sided time or invertible cocycle | Not assumed |
| Nonlinear derivative or random-Jacobian representation | Not connected |

The checked result is finite and exact: one existing integrability fact for
the expanding one-step envelope propagates through preserved pullbacks, finite
addition, and pointwise domination to every fixed horizon.

## Where to continue

[Integrated Log-Positive Cocycle Growth and Its Deterministic Fekete Limit]({{< relref "/knowledge-base/deep-dives/integrated-log-positive-cocycle-growth-and-fekete-limit" >}})
is the immediate successor. It integrates these finite-horizon envelopes and
uses a deterministic Fekete argument. It still does not turn RMT-15 into a
samplewise ergodic or Lyapunov theorem.

[Finite-Time Norm and Extended-Log-Norm Observables for Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/finite-time-norm-and-extended-log-norm-cocycle-observables" >}})
is the immediate predecessor. It develops the maximum absolute row-sum norm
and the zero-faithful extended log norm whose contraction and collapse data
the present positive envelope discards.

[Generator-Presented One-Sided Discrete Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/generator-presented-one-sided-discrete-matrix-cocycles" >}})
supplies the base orbit, measure-preserving natural iterates, and exact
later-block-left product law.

The
{{< refterm "log-positive-integrability-envelope" "log-positive integrability envelope" >}}
glossary entry is the compact companion for the clipping and majorization
strategy.

## References

<a id="ref-log-plus-deep-poslog"></a>**Mathlib contributors.**
[The positive part of the logarithm](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/SpecialFunctions/Log/PosLog.html),
Mathlib 4 documentation. This official source defines
<code>Real.posLog</code> and records its nonnegativity, endpoint values,
continuity, monotonicity on nonnegative inputs, and product inequality.

<a id="ref-log-plus-deep-integrable"></a>**Mathlib contributors.**
[Bochner integrability](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Function/L1Space/Integrable.html),
Mathlib 4 documentation. The pinned local source supplies the exact
<code>MeasurePreserving.integrable_comp_of_integrable</code>,
<code>integrable_finsetSum</code>, and <code>Integrable.mono'</code>
interfaces used by the target.

<a id="ref-log-plus-deep-measure-preserving"></a>**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation. RMT-13 packages natural-iterate preservation for the
cocycle base.

<a id="ref-log-plus-deep-furstenberg-kesten"></a>**Harry Furstenberg and Harry Kesten.**
[Products of Random Matrices](https://doi.org/10.1214/aoms/1177705909),
*The Annals of Mathematical Statistics* 31(2), 457–469, 1960. This primary
source motivates logarithmic growth of random matrix products. RMT-15 proves
none of its asymptotic conclusions.

<a id="ref-log-plus-deep-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499–510, 1968.
The target supplies only a finite-time integrability layer, not the hypotheses
or conclusion of the subadditive ergodic theorem.

<a id="ref-log-plus-deep-oseledets"></a>**V. I. Oseledets.**
[A multiplicative ergodic theorem. Characteristic Ljapunov exponents of dynamical systems](https://www.mathnet.ru/eng/mmo214),
*Transactions of the Moscow Mathematical Society* 19 (1968), 197–231. This
is an asymptotic destination; the present module proves no exponent, spectrum,
filtration, or splitting.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
