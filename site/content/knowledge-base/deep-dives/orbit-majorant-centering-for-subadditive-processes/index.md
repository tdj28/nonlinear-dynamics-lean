---
title: "Orbit-Majorant Centering for Subadditive Processes"
slug: "orbit-majorant-centering-for-subadditive-processes"
date: 2026-07-21
summary: "Compute an exact three-state orbit ledger, subtract its additive one-step majorant, catch a wrong shift that makes six less than or equal to three, and then follow the checked Lean interfaces for nonpositivity, subadditivity, integrability, and finite normalization."
lead: "On a uniform three-state cycle, the one-step values are nine, one, and two. At horizon three the orbit majorant is twelve, the process is six, and the centered residual is minus six at every state: a complete finite model of the theorem before any abstract Birkhoff notation appears."
draft: false
pro_reviewed: false
level: "From a finite orbit ledger to shifted subadditivity, Birkhoff sums, measure-preserving pullbacks, integrable centered families, and a finite normalized split"
reading_time: "110 to 145 minutes"
prerequisites: "Finite sums, integer inequalities, and weighted averages; measurable functions, integrability, Birkhoff sums, process candidates, and Lean syntax are introduced as they appear"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveCentering"
toc: true
og_image: "orbit-majorant-centering-for-subadditive-processes-card.png"
og_image_alt: "A uniform three-state cycle with one-step values nine, one, and two, followed by a horizon ledger. At horizon three the one-step orbit majorant is twelve, the process is six, and the centered residual is minus six at every state."
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

## Begin with a three-state orbit

Take the finite base space

\[
\Omega=\{0,1,2\}
\]

and let \(T\) move clockwise:

\[
0\longmapsto1\longmapsto2\longmapsto0.
\]

Give every state probability \(1/3\). The map preserves this measure because
it permutes equally weighted atoms. Every subset is measurable, and every
real-valued function on this finite discrete space is measurable.

Define the one-step values

\[
X_1(0)=9,\qquad X_1(1)=1,\qquad X_1(2)=2.
\]

Their one-step expectation is

\[
\frac{9+1+2}{3}=4.
\]

The finite one-step orbit sum is

\[
S_n(\omega)
{} =
\sum_{j=0}^{n-1}X_1(T^j\omega).
\]

Now define the complete process by subtracting a deterministic penalty:

\[
X_n(\omega)=S_n(\omega)-n(n-1).
\]

This is not circular. The right side uses the already specified one-step
function \(X_1\); the penalty vanishes at \(n=1\), so the formula reproduces
the three one-step values exactly.

Finally, subtract the one-step orbit sum:

\[
Y_n(\omega)=X_n(\omega)-S_n(\omega).
\]

For this model,

\[
Y_n(\omega)=-n(n-1)
\]

at every state. The residual is zero at horizons zero and one, then strictly
negative.

### Why this process is genuinely subadditive

The orbit sum has the exact shifted addition law

\[
S_{m+n}(\omega)
{} =
S_m(\omega)+S_n(T^m\omega).
\]

The penalty satisfies

\[
(m+n)(m+n-1)
{} =
m(m-1)+n(n-1)+2mn.
\]

Subtract the second identity from the first:

\[
\begin{aligned}
X_{m+n}(\omega)
&=
X_m(\omega)+X_n(T^m\omega)-2mn\\
&\le
X_n(T^m\omega)+X_m(\omega).
\end{aligned}
\]

So this is an exact shifted-subadditive process. The gap in the inequality is
\(2mn\), independent of the state.

### Read the finite horizon ledger

The first five horizons are:

| Horizon \(n\) | \(S_n\) at states \(0,1,2\) | \(X_n\) at states \(0,1,2\) | \(Y_n=X_n-S_n\) |
|---:|---:|---:|---:|
| \(0\) | \([0,0,0]\) | \([0,0,0]\) | \([0,0,0]\) |
| \(1\) | \([9,1,2]\) | \([9,1,2]\) | \([0,0,0]\) |
| \(2\) | \([10,3,11]\) | \([8,1,9]\) | \([-2,-2,-2]\) |
| \(3\) | \([12,12,12]\) | \([6,6,6]\) | \([-6,-6,-6]\) |
| \(4\) | \([21,13,14]\) | \([9,1,2]\) | \([-12,-12,-12]\) |

The target theorem calls \(S_n\) a majorant because

\[
X_n(\omega)\le S_n(\omega)
\]

pointwise. In this model the difference is exactly \(n(n-1)\).

At horizon three, the finite normalized split is especially transparent:

\[
\frac{X_3}{3}
{} =
\frac{Y_3}{3}+\frac{S_3}{3},
\qquad
2=-2+4.
\]

This is an equality of three finite numbers. It does not assert that any
sequence converges as \(n\) grows.

{{< reference-figure
  wide="true"
  src="three-cycle-centered-process-ledger.svg"
  alt="Three equally likely states form a cycle with one-step values nine, one, and two. A table gives the orbit-majorant, process, and centered residual vectors from horizons zero through four. At horizon three they are twelve, six, and minus six at every state. A normalized badge shows two equals minus two plus four, and an analytic badge shows absolute means six for the process and residual."
  caption="**Exact finite ledger:** \(S_n\) adds the one-step values along the orbit, \(X_n=S_n-n(n-1)\), and \(Y_n=X_n-S_n=-n(n-1)\). At horizon three, the normalized identity is \(2=-2+4\). Because the base is finite and discrete, every displayed function is measurable; the finite absolute means establish integrability without an asymptotic theorem."
>}}

## Measurability and integrability are visible here

On this finite probability space, the integral of a function
\(f:\Omega\to\mathbb R\) is

\[
\int_\Omega f\,d\mu
{} =
\frac{f(0)+f(1)+f(2)}{3}.
\]

Integrability asks for a finite integral of the absolute value:

\[
\int_\Omega |f|\,d\mu\lt\infty.
\]

At horizon three,

\[
\int_\Omega |X_3|\,d\mu=6,
\qquad
\int_\Omega |Y_3|\,d\mu=6,
\qquad
\int_\Omega |S_3|\,d\mu=12.
\]

All are finite. The same reasoning works at every fixed horizon because each
function is a finite list of finite real numbers.

This small model separates three interfaces:

- {{< refterm "measurable-function" "measurability" >}} says the values can be
  used in measure-theoretic events and integrals;
- {{< refterm "integrability" "integrability" >}} says the absolute integral
  is finite; and
- {{< refterm "measure-preserving-transformation" "measure preservation" >}}
  says orbit shifts do not distort the underlying measure.

The general Lean theorem cannot use “finite list” as its proof. Instead, the
candidate supplies integrability of every \(X_n\), and measure preservation
transports integrability of \(X_1\) to \(X_1\circ T^j\). Finite-sum closure
then proves the Birkhoff sum integrable. Subtracting two integrable real
functions proves the centered horizon integrable.

No probability normalization is required by the module. The uniform
probability measure only makes this example and its expectations concrete.

## The shift is determined by the early block

Now use the same model to split horizon three as

\[
3=m+n,\qquad m=1,\quad n=2,
\]

starting at state \(\omega=2\).

The early block has length one:

\[
X_1(2)=2.
\]

After consuming it, the later block begins at

\[
T^m\omega=T^1(2)=0.
\]

The correct later value is

\[
X_2(0)=8.
\]

The shifted-subadditive theorem therefore reads

\[
X_3(2)=6\le X_2(T^1(2))+X_1(2)=8+2=10.
\]

The gap is \(4=2mn\), exactly as the process formula predicted.

The orbit majorant splits with equality:

\[
S_3(2)
{} =
S_1(2)+S_2(T^1(2))
{} =
2+10
{} =
12.
\]

The exponent on \(T\) is \(m\), the length of the early block. It is not the
length \(n\) of the later block.

### A wrong shift that actually breaks the inequality

If one mistakenly starts the later block at \(T^n\omega=T^2(2)=1\), then

\[
X_2(1)=1.
\]

The false calculation becomes

\[
6\le1+2=3,
\]

which is wrong. This is more than an aesthetic indexing complaint: the
incorrect shift produces a false theorem on a three-point example.

### Two other seductive meanings of “centered”

The project definition subtracts majorant from process:

\[
Y_3=X_3-S_3=6-12=-6.
\]

Reversing the subtraction gives \(S_3-X_3=+6\), destroying the
nonpositivity conclusion.

Subtracting the expectation of \(X_1\) is a different legitimate operation:

\[
X_1-\mathbb E[X_1]=(5,-3,-2).
\]

That vector has mean zero, but it is neither identically zero nor pointwise
nonpositive. The project theorem is not expectation centering. It is
pointwise compensation by an additive orbit majorant.

{{< reference-figure
  wide="true"
  src="shift-and-centering-near-misses.svg"
  alt="Starting at state two, a horizon-three process is split into an early block of length one and later block of length two. The correct later start is T to the first power of state two, state zero, and six is at most eight plus two. The wrong T squared start is state one and gives the false inequality six is at most one plus two. Three lower cards compare the correct residual minus six, the wrong-sign residual plus six, and expectation-centered values five, minus three, minus two."
  caption="**Shift and sign audit:** the later block starts at \(T^m\omega\) because \(m\) early steps have been consumed. Replacing it by \(T^n\omega\) makes \(6\le3\) in this ledger. The lower cards separate orbit-majorant compensation from reversed subtraction and from expectation centering."
>}}

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [The three-state orbit](#begin-with-a-three-state-orbit) | Compute \(S_n\), \(X_n\), and \(Y_n\) exactly |
| Analytic route | [Measurability and integrability](#measurability-and-integrability-are-visible-here) | Connect finite absolute means to the general interfaces |
| Shift route | [The early block decides the shift](#the-shift-is-determined-by-the-early-block) | See \(T^m\omega\) and a numerical failure of \(T^n\omega\) |
| Lean route | [Seven bridges](#in-lean-seven-bridges-from-orbit-slack-to-the-cocycle) | Translate each human claim into exact syntax |
| Hands-on route | [Run the worksheet](#type-the-entire-ledger-with-lean-and-std) | Recheck every integer, rational mean, and failed inequality |
| Proof route | [Why the generic theorem works](#why-the-generic-theorem-works) | Follow majorization, cancellation, and integrability |
| Interface route | [The complete declaration map](#the-complete-eighteen-declaration-map) | Audit all public declarations and private helpers |
| Summit route | [What has and has not been proved](#summit-what-has-and-has-not-been-proved) | Keep the finite split separate from limits |

### Learning objectives

By the summit, you should be able to reproduce the three-state ledger; prove
its shifted subadditivity with exact slack \(2mn\); explain why the correct
later start is \(T^m\omega\); distinguish orbit-majorant and expectation
centering; read seven Lean bridges token by token; execute the bounded
<code>Std</code> worksheet; explain how preservation transports
integrability; reconstruct centered subadditivity by cancellation; audit all
eighteen public declarations and two private helpers; and state precisely
which normalized, ergodic, cocycle, and Lyapunov conclusions remain absent.

## In Lean: seven bridges from orbit slack to the cocycle

### Bridge one: subtract the finite one-step Birkhoff sum

{{< lean-bridge
  human="At horizon n, subtract the sum of the one-step process values along the first n orbit states."
  math="\(Y_n(\omega)=X_n(\omega)-\sum_{j=0}^{n-1}X_1(T^j\omega).\)"
  lean="centeredProcess T X n ω"
>}}

- <code>T</code> is the base self-map.
- <code>X</code> has type <code>ℕ → Ω → ℝ</code>.
- <code>n</code> is the finite horizon and <code>ω</code> the starting state.
- <code>birkhoffSum T (X 1) n ω</code> samples indices
  \(0,\ldots,n-1\).
- The subtraction order is process minus orbit majorant.
- No measure, probability, integrability, or convergence premise appears in
  the definition.
{{< /lean-bridge >}}

The simplification theorems say
<code>centeredProcess T X 0 = X 0</code> and
<code>centeredProcess T X 1 = 0</code>. At time zero the Birkhoff sum is empty;
at time one it is exactly \(X_1\).

### Bridge two: majorize every positive horizon

{{< lean-bridge
  human="For a positive horizon, shifted subadditivity makes the one-step orbit sum a pointwise upper bound."
  math="\(n\ne0\Longrightarrow X_n(\omega)\le\sum_{j=0}^{n-1}X_1(T^j\omega).\)"
  lean="hX.oneStepBirkhoffMajorant_of_ne_zero n hn ω"
>}}

- <code>hX</code> is an
  <code>IsIntegrableSubadditiveProcessCandidate T μ X</code>.
- <code>hn : n ≠ 0</code> selects the positive-horizon theorem.
- The proof uses only <code>hX.add_le</code>, not the candidate's
  integrability field.
- The induction appends \(X_1(T^n\omega)\) at the correct shifted state.
- A separate theorem
  <code>hX.oneStepBirkhoffMajorant hX0 n ω</code> includes \(n=0\) when
  <code>hX0 : X 0 = 0</code>.
{{< /lean-bridge >}}

### Bridge three: turn the majorant into a sign theorem

{{< lean-bridge
  human="Subtracting the pointwise upper bound leaves a nonpositive residual."
  math="\(Y_n(\omega)\le0.\)"
  lean="hX.centeredProcess_nonpos hX0 n ω"
>}}

- The uniform theorem uses exact time-zero normalization
  <code>hX0 : X 0 = 0</code>.
- Without it, use
  <code>centeredProcess_nonpos_of_ne_zero n hn ω</code>.
- The proof is the ordered-ring equivalence
  <code>sub_nonpos.mpr</code>.
- It is pointwise, not almost everywhere.
- It does not claim the residual has mean zero.
{{< /lean-bridge >}}

### Bridge four: preserve the shifted-subadditive structure

{{< lean-bridge
  human="The centered residual obeys the same shifted subadditive inequality as the original process."
  math="\(Y_{m+n}(\omega)\le Y_n(T^m\omega)+Y_m(\omega).\)"
  lean="hX.centeredProcess_add_le m n ω"
>}}

- The later block is evaluated at <code>T^[m] ω</code>.
- <code>birkhoffSum_add</code> splits the orbit sum at that same state.
- Subtracting an exact additive identity from a subadditive inequality leaves
  a subadditive inequality.
- Integrability and \(X_0=0\) are not used by this proof.
- The three-state wrong-shift calculation above shows why replacing
  <code>m</code> by <code>n</code> is invalid.
{{< /lean-bridge >}}

### Bridge five: preserve finite-horizon integrability

{{< lean-bridge
  human="If the base preserves the measure, every centered finite-horizon function is integrable."
  math="\(T_*\mu=\mu\Longrightarrow Y_n\in L^1(\mu).\)"
  lean="hX.integrable_centeredProcess hT n"
>}}

- <code>hX.integrable n</code> gives integrability of \(X_n\).
- <code>hT : MeasurePreserving T μ μ</code> transports one-step
  integrability along all orbit iterates.
- <code>integrable_birkhoffSum_blocks</code> adds the finite family.
- <code>Integrable.sub</code> closes under subtraction.
- Probability normalization, ergodicity, and time-zero normalization are not
  required.
{{< /lean-bridge >}}

The companion
<code>hX.centeredProcess_candidate hT</code> packages both this integrability
field and bridge four into a new process candidate.

### Bridge six: split the normalized finite value

{{< lean-bridge
  human="Dividing the defining equality by the horizon separates the original value into a centered quotient and a one-step Birkhoff average."
  math="\(X_n(\omega)/n=Y_n(\omega)/n+\frac1n\sum_{j=0}^{n-1}X_1(T^j\omega).\)"
  lean="normalized_eq_centered_add_birkhoffAverage n ω"
>}}

- <code>(n : ℝ)</code> coerces the natural horizon to a real number.
- <code>birkhoffAverage ℝ T (X 1) n ω</code> is the totalized finite average.
- At <code>n = 0</code>, real division and the Birkhoff average both
  totalize to zero; the identity remains true.
- The theorem needs no measurability, integrability, or preservation.
- An equality for every finite \(n\) is not a convergence theorem for either
  right-hand branch.
{{< /lean-bridge >}}

### Bridge seven: specialize the reduction to cocycle positive-log growth

{{< lean-bridge
  human="For the matrix cocycle, subtract the existing one-step log-positive orbit sum from the finite-horizon log-positive norm."
  math="\(Y_n^C(\omega)=P_n(\omega)-S_n(\omega)\le0.\)"
  lean="C.centeredLogPlusNormObservable_nonpos n ω"
>}}

- <code>C.centeredLogPlusNormObservable n</code> is
  <code>centeredProcess C.base C.logPlusNormObservable n</code>.
- The prior <code>orbitLogPlusSum</code> is definitionally the corresponding
  Mathlib Birkhoff sum.
- The pointwise sign theorem needs the cocycle but not its integrability
  hypothesis.
- Shifted subadditivity is
  <code>C.centeredLogPlusNormObservable_add_le m n ω</code>.
- Only
  <code>hC.centeredLogPlusNormObservable_candidate</code> needs
  <code>HasIntegrableGeneratorLogPlus</code>.
- Positive log still erases contraction and exact collapse before centering.
{{< /lean-bridge >}}

### Check the exact project interface

{{< repo-check >}}
**Full project check: pinned project plus Mathlib.** A temporary project
scratch file can inspect the complete public surface:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.SubadditiveCentering

open NonlinearDynamics.Random.RandomCocycles

#print centeredProcess
#check centeredProcess_zero
#check centeredProcess_one
#check IsIntegrableSubadditiveProcessCandidate.oneStepBirkhoffMajorant_of_ne_zero
#check IsIntegrableSubadditiveProcessCandidate.oneStepBirkhoffMajorant
#check IsIntegrableSubadditiveProcessCandidate.centeredProcess_nonpos_of_ne_zero
#check IsIntegrableSubadditiveProcessCandidate.centeredProcess_nonpos
#check IsIntegrableSubadditiveProcessCandidate.centeredProcess_add_le
#check IsIntegrableSubadditiveProcessCandidate.integrable_centeredProcess
#check IsIntegrableSubadditiveProcessCandidate.centeredProcess_candidate
#check normalized_eq_centered_add_birkhoffAverage
#check DiscreteMatrixCocycle.birkhoffSum_logPlusNormObservable_one_eq_orbitLogPlusSum
#print DiscreteMatrixCocycle.centeredLogPlusNormObservable
#check DiscreteMatrixCocycle.centeredLogPlusNormObservable_apply
#check DiscreteMatrixCocycle.centeredLogPlusNormObservable_nonpos
#check DiscreteMatrixCocycle.centeredLogPlusNormObservable_add_le
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.centeredLogPlusNormObservable_candidate
#check DiscreteMatrixCocycle.logPlusNormObservable_normalized_eq_centered_add_birkhoffAverage
~~~

The two raw-algebra helpers are private and therefore absent from this
external interface. The full project command rendered below checks the
authoritative module with the pinned toolchain and dependencies.
{{< /repo-check >}}

## Type the entire ledger with Lean and Std

The project theorem uses Mathlib's Birkhoff sums, measures, integrability, and
cocycle interfaces. The complete finite arithmetic can be checked first by a
bounded file that imports only <code>Std</code>.

Create a scratch directory outside <code>formalization/</code>. Save this
exact block as <code>OrbitMajorantCenteringTutorial.lean</code>:

~~~lean
import Std

namespace OrbitMajorantCenteringTutorial

/-
Three equally weighted states form the cycle 0 → 1 → 2 → 0.
The one-step process values are 9, 1, and 2.

The finite process is deliberately subadditive:

  X_n(ω) = S_n(ω) - n(n - 1),

where S_n is the orbit sum of the one-step values.  Its centered residual is
therefore Y_n(ω) = -n(n - 1).
-/

def nextState (state : Nat) : Nat :=
  (state + 1) % 3

def iterateState (steps state : Nat) : Nat :=
  (state + steps) % 3

def oneStep (state : Nat) : Int :=
  match state % 3 with
  | 0 => 9
  | 1 => 1
  | _ => 2

def orbitSum (state horizon : Nat) : Int :=
  ((List.range horizon).map
    (fun j => oneStep (iterateState j state))).sum

def penalty (horizon : Nat) : Int :=
  (horizon : Int) * ((horizon : Int) - 1)

def process (state horizon : Nat) : Int :=
  orbitSum state horizon - penalty horizon

def oneStepMajorant (state horizon : Nat) : Int :=
  ((List.range horizon).map
    (fun j => process (iterateState j state) 1)).sum

def centered (state horizon : Nat) : Int :=
  process state horizon - oneStepMajorant state horizon

def processVector (horizon : Nat) : List Int :=
  (List.range 3).map (fun state => process state horizon)

def majorantVector (horizon : Nat) : List Int :=
  (List.range 3).map (fun state => oneStepMajorant state horizon)

def centeredVector (horizon : Nat) : List Int :=
  (List.range 3).map (fun state => centered state horizon)

def uniformMean (values : List Int) : Rat :=
  (values.sum : Rat) / values.length

def uniformAbsoluteMean (values : List Int) : Rat :=
  (((values.map Int.natAbs).sum : Nat) : Rat) / values.length

structure HorizonLedger where
  horizon : Nat
  majorant : List Int
  process : List Int
  centered : List Int
  processMean : Rat
  centeredAbsoluteMean : Rat
  deriving Repr, DecidableEq

def horizonLedger (horizon : Nat) : HorizonLedger :=
  { horizon := horizon
    majorant := majorantVector horizon
    process := processVector horizon
    centered := centeredVector horizon
    processMean := uniformMean (processVector horizon)
    centeredAbsoluteMean := uniformAbsoluteMean (centeredVector horizon) }

structure ShiftLedger where
  start : Nat
  earlyLength : Nat
  laterLength : Nat
  fullProcess : Int
  earlyProcess : Int
  correctLaterStart : Nat
  correctLaterProcess : Int
  correctRightSide : Int
  correctInequality : Bool
  wrongLaterStart : Nat
  wrongLaterProcess : Int
  wrongRightSide : Int
  wrongInequality : Bool
  fullMajorant : Int
  correctMajorantPieces : Int × Int
  wrongMajorantPieces : Int × Int
  deriving Repr, DecidableEq

def shiftLedger : ShiftLedger :=
  let state := 2
  let m := 1
  let n := 2
  let full := process state (m + n)
  let early := process state m
  let correctStart := iterateState m state
  let correctLater := process correctStart n
  let correctRight := correctLater + early
  let wrongStart := iterateState n state
  let wrongLater := process wrongStart n
  let wrongRight := wrongLater + early
  { start := state
    earlyLength := m
    laterLength := n
    fullProcess := full
    earlyProcess := early
    correctLaterStart := correctStart
    correctLaterProcess := correctLater
    correctRightSide := correctRight
    correctInequality := decide (full ≤ correctRight)
    wrongLaterStart := wrongStart
    wrongLaterProcess := wrongLater
    wrongRightSide := wrongRight
    wrongInequality := decide (full ≤ wrongRight)
    fullMajorant := oneStepMajorant state (m + n)
    correctMajorantPieces :=
      (oneStepMajorant state m, oneStepMajorant correctStart n)
    wrongMajorantPieces :=
      (oneStepMajorant state m, oneStepMajorant wrongStart n) }

def wrongSignCentered (state horizon : Nat) : Int :=
  oneStepMajorant state horizon - process state horizon

def expectationCenteredOneStep (state : Nat) : Int :=
  process state 1 - 4

def unshiftedRepeatedCentering (state horizon : Nat) : Int :=
  process state horizon - (horizon : Int) * process state 1

def constantOneProcess (_state _horizon : Nat) : Int :=
  1

def constantOneCentered (horizon : Nat) : Int :=
  constantOneProcess 0 horizon -
    ((List.range horizon).map
      (fun _ => constantOneProcess 0 1)).sum

def normalizedHorizonThree : Rat × Rat × Rat :=
  ((process 0 3 : Rat) / 3,
    (centered 0 3 : Rat) / 3,
    (oneStepMajorant 0 3 : Rat) / 3)

#eval (List.range 3).map oneStep
#eval (List.range 5).map horizonLedger
#eval shiftLedger
#eval (List.range 3).map (fun state => wrongSignCentered state 3)
#eval (List.range 3).map expectationCenteredOneStep
#eval (centered 2 3, unshiftedRepeatedCentering 2 3)
#eval (List.range 4).map constantOneCentered
#eval normalizedHorizonThree

example : (List.range 3).map oneStep = [9, 1, 2] := by
  native_decide

example : majorantVector 2 = [10, 3, 11] := by native_decide
example : processVector 2 = [8, 1, 9] := by native_decide
example : centeredVector 2 = [-2, -2, -2] := by native_decide

example : majorantVector 3 = [12, 12, 12] := by native_decide
example : processVector 3 = [6, 6, 6] := by native_decide
example : centeredVector 3 = [-6, -6, -6] := by native_decide

example : (List.range 9).all fun horizon =>
    (List.range 3).all fun state =>
      decide (process state horizon ≤ oneStepMajorant state horizon) := by
  native_decide

example : shiftLedger.correctLaterStart = 0 := by native_decide
example : shiftLedger.correctRightSide = 10 := by native_decide
example : shiftLedger.correctInequality = true := by native_decide
example : shiftLedger.wrongLaterStart = 1 := by native_decide
example : shiftLedger.wrongRightSide = 3 := by native_decide
example : shiftLedger.wrongInequality = false := by native_decide
example : shiftLedger.correctMajorantPieces = (2, 10) := by native_decide
example : shiftLedger.wrongMajorantPieces = (2, 3) := by native_decide

example : uniformAbsoluteMean (processVector 3) = 6 := by native_decide
example : uniformAbsoluteMean (centeredVector 3) = 6 := by native_decide
example : normalizedHorizonThree = (2, -2, 4) := by native_decide

example : (List.range 3).map expectationCenteredOneStep = [5, -3, -2] := by
  native_decide

example : (List.range 4).map constantOneCentered = [1, 0, -1, -2] := by
  native_decide

end OrbitMajorantCenteringTutorial
~~~

Open a terminal in that scratch directory and type:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean OrbitMajorantCenteringTutorial.lean
~~~

**Resource label: small standalone Lean tutorial, ordinary Mac or Linux.**
This exact worksheet was executed with Lean 4.32.0 and printed this complete
transcript:

~~~text
[9, 1, 2]
[{ horizon := 0,
   majorant := [0, 0, 0],
   process := [0, 0, 0],
   centered := [0, 0, 0],
   processMean := 0,
   centeredAbsoluteMean := 0 },
 { horizon := 1,
   majorant := [9, 1, 2],
   process := [9, 1, 2],
   centered := [0, 0, 0],
   processMean := 4,
   centeredAbsoluteMean := 0 },
 { horizon := 2,
   majorant := [10, 3, 11],
   process := [8, 1, 9],
   centered := [-2, -2, -2],
   processMean := 6,
   centeredAbsoluteMean := 2 },
 { horizon := 3,
   majorant := [12, 12, 12],
   process := [6, 6, 6],
   centered := [-6, -6, -6],
   processMean := 6,
   centeredAbsoluteMean := 6 },
 { horizon := 4,
   majorant := [21, 13, 14],
   process := [9, 1, 2],
   centered := [-12, -12, -12],
   processMean := 4,
   centeredAbsoluteMean := 12 }]
{ start := 2,
  earlyLength := 1,
  laterLength := 2,
  fullProcess := 6,
  earlyProcess := 2,
  correctLaterStart := 0,
  correctLaterProcess := 8,
  correctRightSide := 10,
  correctInequality := true,
  wrongLaterStart := 1,
  wrongLaterProcess := 1,
  wrongRightSide := 3,
  wrongInequality := false,
  fullMajorant := 12,
  correctMajorantPieces := (2, 10),
  wrongMajorantPieces := (2, 3) }
[6, 6, 6]
[5, -3, -2]
(-6, 0)
[1, 0, -1, -2]
(2, -2, 4)
~~~

The first line is the one-step function. The next record list is the complete
horizon-zero-through-four ledger. The shift record contains both the valid
right side \(10\) and invalid right side \(3\), with the corresponding Boolean
checks. The remaining lines expose the wrong sign, expectation centering,
unshifted repeated subtraction, the constant-one time-zero boundary, and the
normalized triple \(2,-2,4\).

The <code>example</code> declarations ask Lean to prove all recorded values.
The nested Boolean check additionally verifies \(X_n\le S_n\) at all three
states for horizons zero through eight. This worksheet models the finite
arithmetic only. Mathlib's actual <code>birkhoffSum</code>,
<code>MeasurePreserving</code>, <code>Integrable</code>, and cocycle
interfaces remain the full project check above.

## Why the generic theorem works

### The candidate separates algebra from analysis

The predecessor defines
<code>IsIntegrableSubadditiveProcessCandidate T μ X</code> with exactly two
fields:

~~~lean
integrable : ∀ k, Integrable (X k) μ
add_le : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω
~~~

The structure does not store probability normalization, measure preservation,
ergodicity, invertibility, or a limit. Measure preservation is requested only
when a theorem actually pulls functions along the base orbit.

### Positive-horizon majorization is pure induction

For \(n=1\), the Birkhoff sum contains only \(X_1(\omega)\), so the bound is
equality. For the successor, shifted subadditivity gives

\[
X_{n+1}(\omega)
\le
X_1(T^n\omega)+X_n(\omega).
\]

Apply the induction hypothesis to the second term and use Mathlib's successor
identity

\[
\operatorname{birkhoffSum}(T,X_1,n+1,\omega)
{} =
\operatorname{birkhoffSum}(T,X_1,n,\omega)+X_1(T^n\omega).
\]

Only the candidate's <code>add_le</code> field is read. The private helper
<code>oneStepBirkhoffMajorant_of_add_le</code> makes that dependency explicit.

At \(n=0\), the Birkhoff sum is zero while subadditivity alone only forces
\(X_0\ge0\). Exact normalization \(X_0=0\) is therefore a separate premise
for the uniform theorem.

### The constant-one boundary

On a singleton, let \(X_n=1\) for every \(n\). Then

\[
1\le1+1,
\]

so the process is subadditive and every horizon is integrable. Its centered
values are

\[
(1,0,-1,-2,\ldots).
\]

Positive horizons are nonpositive, but \(Y_0=1\). This tiny model proves that
the <code>X 0 = 0</code> premise cannot simply be deleted from the uniform
nonpositivity theorem.

### Centered subadditivity is cancellation

Let \(A_n\) denote the Birkhoff sum of \(X_1\). Mathlib proves

\[
A_{m+n}(\omega)
{} =
A_m(\omega)+A_n(T^m\omega).
\]

Subtract this equality from

\[
X_{m+n}(\omega)
\le
X_n(T^m\omega)+X_m(\omega).
\]

Regrouping produces

\[
Y_{m+n}(\omega)
\le
Y_n(T^m\omega)+Y_m(\omega).
\]

The source's first private helper,
<code>centeredProcess_add_le_of_add_le</code>, performs exactly this rewrite
and finishes with linear arithmetic. It needs neither integrability nor
time-zero normalization.

### Integrability uses preservation at one narrow gate

The candidate already says \(X_n\) and \(X_1\) are integrable. If \(T\)
preserves \(\mu\), then every iterate \(T^j\) preserves \(\mu\), so

\[
X_1\circ T^j
\]

is integrable. The finite Birkhoff sum is integrable by finite-sum closure.
Then

\[
Y_n=X_n-A_n
\]

is integrable by closure under subtraction.

Without preservation, composition can move mass into a heavy part of an
integrable function and destroy integrability. The premise is analytic, not
decorative.

## The complete eighteen-declaration map

The source contains two private raw-algebra helpers and eighteen public
declarations.

### Private helpers in source order

| Helper | Exact dependency |
|---|---|
| <code>centeredProcess_add_le_of_add_le</code> | A raw shifted-subadditive inequality and the Birkhoff addition law |
| <code>oneStepBirkhoffMajorant_of_add_le</code> | A raw shifted-subadditive inequality, positive horizon, and induction |

### Public declarations in source order

| # | Declaration | Exact role |
|---:|---|---|
| 1 | <code>centeredProcess</code> | Defines \(Y_n=X_n-\operatorname{birkhoffSum}(X_1)\) |
| 2 | <code>centeredProcess_zero</code> | Proves \(Y_0=X_0\) |
| 3 | <code>centeredProcess_one</code> | Proves \(Y_1=0\) |
| 4 | <code>oneStepBirkhoffMajorant_of_ne_zero</code> | Majorizes every positive horizon |
| 5 | <code>oneStepBirkhoffMajorant</code> | Includes time zero under \(X_0=0\) |
| 6 | <code>centeredProcess_nonpos_of_ne_zero</code> | Makes every positive-horizon residual nonpositive |
| 7 | <code>centeredProcess_nonpos</code> | Makes every residual nonpositive under \(X_0=0\) |
| 8 | <code>centeredProcess_add_le</code> | Preserves shifted subadditivity |
| 9 | <code>integrable_centeredProcess</code> | Proves each \(Y_n\) integrable when \(T\) preserves \(\mu\) |
| 10 | <code>centeredProcess_candidate</code> | Repackages the centered family as an integrable subadditive candidate |
| 11 | <code>normalized_eq_centered_add_birkhoffAverage</code> | Gives the totalized finite normalized identity |
| 12 | <code>birkhoffSum_logPlusNormObservable_one_eq_orbitLogPlusSum</code> | Identifies the cocycle orbit sum definitionally |
| 13 | <code>centeredLogPlusNormObservable</code> | Defines the cocycle-centered positive-log process |
| 14 | <code>centeredLogPlusNormObservable_apply</code> | Expands it as \(P_n-S_n\) |
| 15 | <code>centeredLogPlusNormObservable_nonpos</code> | Proves cocycle-centered nonpositivity without integrability |
| 16 | <code>centeredLogPlusNormObservable_add_le</code> | Proves cocycle-centered shifted subadditivity |
| 17 | <code>centeredLogPlusNormObservable_candidate</code> | Packages the cocycle family under one-step integrability |
| 18 | <code>logPlusNormObservable_normalized_eq_centered_add_birkhoffAverage</code> | Specializes the finite normalized identity |

Declarations 4 through 10 are methods in the
<code>IsIntegrableSubadditiveProcessCandidate</code> namespace. Declarations
12 through 18 live in the <code>DiscreteMatrixCocycle</code> namespace.

## The cocycle specialization is intentionally thin

For a discrete matrix cocycle, the earlier module defines

\[
P_n(\omega)=\log^+\lVert C(n,\omega)\rVert
\]

and its one-step orbit sum

\[
S_n(\omega)=\sum_{j=0}^{n-1}P_1(T^j\omega).
\]

The target proves by reflexivity that this \(S_n\) is Mathlib's
<code>birkhoffSum</code> with the same base, range, and iterate convention.
It then defines

\[
Y_n^C=P_n-S_n.
\]

The earlier pointwise majorant \(P_n\le S_n\) immediately yields
\(Y_n^C\le0\), including time zero because \(P_0=0\). The earlier shifted
subadditivity of \(P_n\) feeds the raw centering helper and proves shifted
subadditivity of \(Y^C\).

These pointwise facts need no
<code>HasIntegrableGeneratorLogPlus</code>. That hypothesis enters only when
declaration 17 packages every centered horizon as integrable.

The cocycle normalized identity is

\[
\frac{P_n(\omega)}{n}
{} =
\frac{Y_n^C(\omega)}{n}
{} +
\operatorname{birkhoffAverage}(T,P_1,n,\omega).
\]

It remains a finite equality. Positive log has already clipped contraction,
so the residual cannot reconstruct signed logarithmic growth, inverse norms,
or an Oseledets splitting.

{{< reference-figure
  src="normalized-split-without-a-limit.svg"
  alt="A normalized finite process value splits into a normalized centered residual and a one-step orbit average. Both branches carry unresolved convergence questions, and a footer says that exact equality at every finite horizon is not a limit theorem."
  caption="**Finite identity, open asymptotics:** dividing the defining equality by \(n\) reorganizes the same finite quantities. A limit for the left side still requires control of both right-hand branches through additional theorems and assumptions."
>}}

## Edge cases that determine the theorem statements

### Time zero is totalized, not ignored

Mathlib's real division and Birkhoff average are total at zero:

\[
0^{-1}=0,\qquad \operatorname{birkhoffAverage}(T,f,0,\omega)=0.
\]

Therefore declaration 11 is algebraically true at \(n=0\). This does not make
\(X_0/0\) a classical growth rate; it records Lean's totalized field
operations.

### Candidate packaging does not need \(X_0=0\)

The centered candidate needs integrability and shifted subadditivity. Neither
field asks for nonpositivity or a normalized time-zero value. The constant-one
model has \(Y_0=1\) and still forms a valid centered candidate.

### The zero measure is allowed

The generic module assumes an arbitrary measure. Under the zero measure,
integrability is trivial and the identity map preserves the measure. No hidden
probability instance appears.

### Empty matrix dimension is allowed

The cocycle layer assumes a finite matrix index type but not a nonempty one.
In empty dimension the positive-log observable and its orbit sum are both
zero, so the centered cocycle process is zero.

### Additive processes are the zero-residual boundary

If \(X_n\) already equals the Birkhoff sum of \(X_1\), then \(Y_n=0\). The
normalized identity reduces to

\[
X_n/n=\operatorname{birkhoffAverage}(T,X_1,n).
\]

That still does not force the orbit average to converge. One can build a
single binary orbit with alternating blocks whose lengths dominate everything
before them; its empirical averages have subsequences near zero and one.

## Exercises from foothill to summit

### Foothill

1. Starting at each state, compute \(S_2\) and recover
   \([10,3,11]\).
2. Subtract \(2(2-1)\) and recover \(X_2=[8,1,9]\).
3. Verify \(Y_2=[-2,-2,-2]\).
4. Compute the three absolute means at horizon three.
5. Check \(2=-2+4\) in the normalized horizon-three split.
6. Explain why every function in the ledger is measurable.

### Ridge

7. Prove the exact penalty identity with the \(2mn\) cross term.
8. Derive shifted subadditivity for the three-state process.
9. Recompute the \(m=1,n=2,\omega=2\) correct split.
10. Replace \(T^m\omega\) by \(T^n\omega\) and identify the false inequality.
11. Prove the Birkhoff addition law by dividing the index range into its first
    \(m\) and next \(n\) terms.
12. Reconstruct positive-horizon majorization by induction.
13. Use the constant-one process to refute uniform nonpositivity without
    \(X_0=0\).
14. Explain why expectation centering has mean zero but does not prove the
    target sign theorem.

### Summit

15. Translate <code>integrable_centeredProcess</code> into its three closure
    operations.
16. Audit all eighteen public declarations and identify which proof fields
    each consumes.
17. Explain why the normalized identity has no analytic premises.
18. Build an additive process whose normalized orbit sum fails to converge.
19. State the additional assumptions and theorem needed to obtain an
    almost-everywhere Birkhoff limit.
20. State the stronger assumptions needed for a subadditive ergodic limit.
21. Explain why the cocycle-centered positive-log process cannot recover
    negative logarithmic growth.
22. Describe what a derivative-cocycle bridge would need before this scalar
    reduction could speak about nonlinear dynamics.

## Reproduce the chapter

The bounded <code>Std</code> worksheet above is a standalone tutorial for an
ordinary macOS or Linux host. The target module imports Mathlib and is a full
project check. From the repository root, run:

~~~sh
cd formalization
lake env lean NonlinearDynamics/Random/RandomCocycles/SubadditiveCentering.lean
~~~

This command may require substantial disk space and memory. Passing automated
checks would still leave human mathematical,
source, accessibility, scientific-integrity, and editorial review pending.

## Summit: what has and has not been proved

| Topic | Status in RMT-19 |
|---|---|
| Centered process \(X_n-\) one-step Birkhoff sum | Defined |
| Time-zero value | Exactly \(X_0\) |
| One-step centered value | Exactly zero |
| Positive-horizon one-step majorant | Checked from shifted subadditivity |
| Uniform majorant including zero | Checked under \(X_0=0\) |
| Positive-horizon centered nonpositivity | Checked |
| Uniform centered nonpositivity | Checked under \(X_0=0\) |
| Centered shifted subadditivity | Checked by finite algebra |
| Centered finite-horizon integrability | Checked under measure preservation |
| Centered candidate packaging | Checked; no \(X_0=0\) needed |
| Totalized finite normalized identity | Checked |
| Cocycle Birkhoff-sum bridge | Definitionally checked |
| Cocycle-centered pointwise sign and subadditivity | Checked without integrability |
| Cocycle-centered integrable candidate | Checked under one-step positive-log integrability |
| Probability normalization or expectation centering | Not assumed |
| Mean-zero centered residual | Not proved and generally false |
| Ergodicity, mixing, independence, or invertible base | Not assumed |
| Convergence of the one-step Birkhoff average | Not proved |
| Convergence of the normalized centered residual | Not proved |
| Convergence of the normalized original process | Not proved |
| Pointwise Birkhoff or Kingman theorem | Not invoked |
| Signed logarithmic growth or inverse-tail control | Not proved |
| Lyapunov exponent, spectrum, filtration, or splitting | Not defined or proved |
| Nonlinear derivative or random-Jacobian representation | Not connected |

The strongest honest summary is finite: subtracting the exact additive
one-step orbit route exposes a nonpositive residual, preserves the
shifted-subadditive structure, and, under measure preservation, preserves
finite-horizon integrability. The normalized split prepares later arguments
but proves no limit.

## Where to continue

[Finite Block Decomposition for Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-block-decomposition-for-subadditive-processes" >}})
is the immediate predecessor. It develops exact block-and-remainder bounds;
the present one-step majorant is the block-length-one reduction.

[Orbit-Majorant Centering Before Any Ergodic Limit]({{< relref "/development-notebook/2026/07/orbit-majorant-centering-for-subadditive-cocycles" >}})
is the Development Notebook companion that follows the Lean implementation
and records its boundary probes.

The {{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}}
glossary entry gives the compact operational definition. The
{{< refterm "birkhoff-sum" "Birkhoff sum" >}} entry isolates the finite orbit
convention.

[Finite Phase Averaging for Nonpositive Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-phase-averaging-for-nonpositive-subadditive-processes" >}})
is the immediate finite successor. It averages shifted block bounds across
residue phases. It remains finite combinatorics, not an almost-everywhere
theorem.

## References

<a id="ref-centering-birkhoff-basic"></a>**Mathlib contributors.**
[Birkhoff sums](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Basic.html),
Mathlib 4 documentation. The exact pinned source defines the finite sum and
its zero, one, successor, and shifted addition laws.

<a id="ref-centering-birkhoff-average"></a>**Mathlib contributors.**
[Birkhoff averages](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Average.html),
Mathlib 4 documentation. The pinned definition records the totalized finite
average used by the normalized identity.

<a id="ref-centering-preserving"></a>**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation. This is the analytic interface used to transport
integrability along the orbit.

<a id="ref-centering-integrable"></a>**Mathlib contributors.**
[Integrable functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Function/L1Space/Integrable.html),
Mathlib 4 documentation. The pinned source supplies composition under
measure preservation and closure under finite sums and subtraction.

<a id="ref-centering-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499–510, 1968.
This is primary asymptotic context. RMT-19 proves a finite reduction only.

<a id="ref-centering-lalley"></a>**Steven P. Lalley.**
[Kingman's Subadditive Ergodic Theorem](https://galton.uchicago.edu/~lalley/Courses/Graz/Kingman.pdf),
University of Chicago lecture notes, undated, accessed 2026-07-21. These notes
serve only as a teaching guide to later proof architecture.

<a id="ref-centering-karlsson-margulis"></a>**Anders Karlsson and Gregory A.
Margulis.**
[A Multiplicative Ergodic Theorem and Nonpositively Curved Spaces](https://doi.org/10.1007/s002200050750),
*Communications in Mathematical Physics* 208, 107–123, 1999. This paper is a
later geometric destination. Its almost-sure tracking theorem is not used or
formalized here.

The exact upstream revision audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
