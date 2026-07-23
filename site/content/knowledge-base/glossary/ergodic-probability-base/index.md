---
title: "Ergodic probability base"
slug: "ergodic-probability-base"
summary: "An ergodic probability base has total mass one, preserves that measure under time evolution, and gives every invariant measurable event probability zero or one."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase"
og_image: "ergodic-probability-base-card.png"
og_image_alt: "Two uniform four-state systems are compared: one four-cycle has only invariant-event masses zero and one, while two disjoint two-cycles preserve the event zero one with probability one half."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working draft. Human review
of the mathematics, Lean interpretation, sources, figure, and accessibility
remains pending. Publication does not mean that the page has completed that
review.
{{< /panel >}}

Consider four states with equal probability:

\[
\Omega=\{0,1,2,3\},
\qquad
\mu(\{j\})=\frac14
\quad\text{for every }j\in\Omega.
\]

Every subset of this finite space is an
{{< refterm "event" "event" >}}. The total mass is

\[
\mu(\Omega)=4\cdot\frac14=1,
\]

so \(\mu\) is a
{{< refterm "probability-measure" "probability measure" >}}. We will put two
different time evolutions on exactly this same probability space.

## Two systems, one decisive difference

The first evolution is one four-state cycle:

\[
\begin{aligned}
T_{\mathrm{cycle}}(0)&=1,&
T_{\mathrm{cycle}}(1)&=2,&
T_{\mathrm{cycle}}(2)&=3,&
T_{\mathrm{cycle}}(3)&=0.
\end{aligned}
\]

The second evolution has two disconnected two-state cycles:

\[
\begin{aligned}
T_{\mathrm{split}}(0)&=1,&
T_{\mathrm{split}}(1)&=0,&
T_{\mathrm{split}}(2)&=3,&
T_{\mathrm{split}}(3)&=2.
\end{aligned}
\]

Both maps are permutations. For any event \(S\subseteq\Omega\), a permutation
does not change the number of points in its preimage:

\[
\mu(T^{-1}S)
=\frac{|T^{-1}S|}{4}
=\frac{|S|}{4}
=\mu(S).
\]

Every map from this finite discrete measurable space is measurable. Thus both
the counting calculation and the required measurability gate hold.

Thus both maps are
{{< refterm "measure-preserving-transformation" "measure-preserving transformations" >}}.
Probability normalization and measure preservation do not distinguish the two
systems.

### The four-cycle is ergodic

An event \(S\) is **strictly invariant** when

\[
T_{\mathrm{cycle}}^{-1}(S)=S.
\]

The notation means preimage: a point \(x\) belongs to
\(T_{\mathrm{cycle}}^{-1}(S)\) exactly when
\(T_{\mathrm{cycle}}(x)\in S\). It does not require an inverse function.

Test the tempting half-space \(A=\{0,2\}\):

\[
T_{\mathrm{cycle}}^{-1}(A)=\{1,3\}\ne A.
\]

So \(A\) is not invariant. In fact, suppose an invariant event \(S\) contains
one point \(x\). Invariance gives

\[
x\in S
\iff T_{\mathrm{cycle}}(x)\in S.
\]

Following the four-cycle from \(x\) visits every state, so \(S=\Omega\).
If \(S\) contains no point, then \(S=\varnothing\). The only invariant events
are therefore

\[
\varnothing
\quad\text{and}\quad
\Omega,
\]

with probabilities \(0\) and \(1\). This system is ergodic.

### The split system is not ergodic

Now take

\[
B=\{0,1\}.
\]

The split map never moves a point between \(B\) and its complement:

\[
T_{\mathrm{split}}^{-1}(B)=B.
\]

But

\[
\mu(B)=\frac{2}{4}=\frac12.
\]

This measurable invariant event is neither null nor full. The split map is
probability preserving, but it is not ergodic.

{{< reference-figure
  wide="true"
  src="ergodic-probability-base.svg"
  alt="Two four-state systems use uniform mass one quarter at each state. The left system is one cycle zero to one to two to three to zero. The candidate event zero and two has preimage one and three, so it is not invariant; the only invariant events have mass zero or one. The right system swaps zero with one and two with three. The event zero and one is invariant and has mass one half, proving that system is not ergodic. A lower comparison shows that invariant real functions are constant on the single cycle but may take a different constant on each component of the split system."
  caption="**Finding:** probability and measure preservation are identical in the two examples: four atoms each have mass \(1/4\), and each map is a permutation. Their invariant-event structures differ. For the single cycle, \(T_{\mathrm{cycle}}^{-1}\{0,2\}=\{1,3\}\), and the only invariant events are \(\varnothing\) and \(\Omega\), with probabilities \(0\) and \(1\). For the split system, \(B=\{0,1\}\) satisfies \(T_{\mathrm{split}}^{-1}B=B\) while \(\mu(B)=1/2\), so the system is not ergodic. Likewise, an invariant real function is constant on the single cycle, while the split system permits value \(0\) on its first cycle and value \(1\) on its second. The final periodic calculation shows that the ergodic four-cycle is not mixing. Nothing in the figure asserts independence or convergence of time averages."
>}}

## Unpack the three layers

An **ergodic probability base** combines three statements about a state space
\(\Omega\), a measure \(\mu\), and a time-one map \(T:\Omega\to\Omega\).

### 1. Probability normalization

The measure has total mass one:

\[
\mu(\Omega)=1.
\]

This fixes the unit of measure. It lets an integrable raw integral be called an
{{< refterm "expectation" "expectation" >}}. It does not make \(T\) measurable,
measure preserving, or ergodic.

If we keep the same four-cycle but assign mass \(1/2\) to every point, then the
total mass is \(2\). The invariant sets are still only empty and full, but
their measures are \(0\) and \(2\), not \(0\) and \(1\). The numerical
zero-or-one conclusion uses probability normalization. This rescaled cycle is
measure preserving and ergodic, but it is not a probability base.

### 2. Measure preservation

The map is measurable and transporting the measure through one time step
returns the same measure:

\[
T_*\mu=\mu.
\]

Equivalently, for every measurable event \(S\),

\[
\mu(T^{-1}S)=\mu(S).
\]

This says the statistical weight of events is unchanged by the dynamics. It
does not say that invariant events are trivial. The split example preserves
the uniform measure and still has the half-mass invariant event \(B\).

### 3. Ergodic rigidity

Among measurable events satisfying \(T^{-1}S=S\), only null or conull events
are allowed:

\[
\mu(S)=0
\quad\text{or}\quad
\mu(S^{\mathsf c})=0.
\]

Here \(S^{\mathsf c}\) is the complement of \(S\). On a probability space,
the second alternative is equivalent to \(\mu(S)=1\). A
{{< refterm "null-set" "null set" >}} may contain points, so this is an
almost-everywhere statement in a general space. In the finite uniform example,
every point has positive mass, and the only null event is empty.

{{< panel "warning" >}}
**The zero-or-one law applies only to invariant measurable events.** In the
ergodic four-cycle, the ordinary event \(\{0\}\) has probability \(1/4\).
There is no contradiction because
\(T_{\mathrm{cycle}}^{-1}\{0\}=\{3\}\ne\{0\}\).
{{< /panel >}}

## Invariant functions carry the same idea

A real-valued observable is a function \(g:\Omega\to\mathbb R\). It is
invariant when advancing the base does not change its value:

\[
g\circ T=g.
\]

On the four-cycle, this equation forces

\[
g(0)=g(1)=g(2)=g(3).
\]

On the split system, define

\[
h(0)=h(1)=0,
\qquad
h(2)=h(3)=1.
\]

Then \(h\circ T_{\mathrm{split}}=h\), but \(h\) is not constant. This is the
function version of the invariant half-event: \(B=h^{-1}(\{0\})\).

In a general measure space, the checked theorem uses two weaker phrases:

- \(g\) is almost-everywhere strongly measurable, a standard measurable
  representative condition; and
- \(g\circ T=g\) holds almost everywhere, so failure on a null set is allowed.

Ergodicity then gives a constant \(c\) such that \(g=c\) almost everywhere.
The {{< refterm "almost-everywhere" "almost-everywhere" >}} entry explains the
quantifier, and the
{{< refterm "measurable-function" "measurable function" >}} entry explains why
measurability is a separate gate.

## Ergodic does not mean mixing or independent

**Mixing** would require long-lag overlaps to approach the product of their
probabilities. The four-cycle fails this stronger condition. Let
\(D=\{0\}\). Then

\[
\mu\bigl(D\cap T_{\mathrm{cycle}}^{-n}D\bigr)=
\begin{cases}
\frac14,&4\text{ divides }n,\\
0,&4\text{ does not divide }n.
\end{cases}
\]

This periodic sequence does not converge to

\[
\mu(D)^2=\frac1{16}.
\]

So the running example is ergodic and not mixing. It also does not make the
events \(D\) and \(T_{\mathrm{cycle}}^{-1}D\) independent: their intersection
has probability \(0\), while the product of their probabilities is \(1/16\).
The {{< refterm "independence" "independence" >}} page develops that separate
probabilistic relation.

Ergodicity also need not pass to a power of the map. The square
\(T_{\mathrm{cycle}}^2\) splits the states into the two cycles
\(\{0,2\}\) and \(\{1,3\}\). Thus \(\{0,2\}\) is invariant under the square
and has probability \(1/2\), even though the original four-cycle is ergodic.

## How the project keeps the assumptions separate

The project does not define a new structure called
<code>ErgodicProbabilityBase</code>. The phrase is a coordination label for
separate hypotheses:

~~~lean
[IsProbabilityMeasure μ]
hErg : Ergodic C.base μ
~~~

The cocycle \(C\) already stores a measure-preserving base. Mathlib's
<code>Ergodic</code> structure also contains measure preservation, plus the
invariant-event rigidity field. The probability typeclass adds total mass one.

The same module has a third, independent analytic hypothesis,
<code>C.HasIntegrableGeneratorLogPlus</code>. It propagates
{{< refterm "integrability" "integrability" >}} from a one-step log-positive
matrix observable to every finite horizon. It is not part of probability or
ergodicity.

This separation supports three precise conclusions:

| Hypotheses used | What the module may conclude |
|---|---|
| Probability and integrability | A finite-horizon integral may be named an expectation |
| Probability, ergodicity, event measurability, and strict invariance | The event has probability \(0\) or \(1\) |
| Ergodicity, almost-everywhere strong measurability, and almost-everywhere function invariance | The real observable is almost everywhere constant |

None of these rows alone states that a time average or normalized matrix
product converges.

## In Lean

The probability layer is a typeclass whose single field is total mass one.

{{< lean-bridge
  human="The measure mu assigns total mass one to the whole state space."
  math="\(\mu(\Omega)=1.\)"
  lean="[IsProbabilityMeasure μ]"
>}}

- Square brackets tell Lean to synthesize this hypothesis as a typeclass
  instance.
- <code>μ</code> has type <code>Measure Ω</code>.
- Mathlib writes the whole space as <code>Set.univ</code>.
- The exact field theorem <code>measure_univ</code> has conclusion
  <code>μ Set.univ = 1</code>.
- The numeral <code>1</code> is a value in the extended nonnegative reals,
  because measures return that scalar type.
{{< /lean-bridge >}}

The exact pinned Mathlib class is:

~~~lean
class IsProbabilityMeasure (μ : Measure α) : Prop where
  measure_univ : μ univ = 1
~~~

Ergodicity combines preservation with invariant-event rigidity.

{{< lean-bridge
  human="The map T preserves mu, and every measurable event fixed by taking its preimage is almost everywhere empty or almost everywhere full."
  math="\(T_*\mu=\mu,\quad T^{-1}S=S\Longrightarrow[\mu(S)=0\text{ or }\mu(S^{\mathsf c})=0].\)"
  lean="hErg : Ergodic T μ"
>}}

- <code>Ergodic T μ</code> is a proposition about one map and one measure.
- <code>hErg.toMeasurePreserving</code> extracts measurability and the
  pushforward equality.
- <code>hErg.toPreErgodic</code> extracts invariant-event rigidity.
- In the underlying strict set condition, Lean writes preimage as
  <code>T ⁻¹' s</code>. The token <code>⁻¹'</code> does not assert that
  <code>T</code> has an inverse.
- The rigidity conclusion is equality almost everywhere to the empty set or
  whole space, not necessarily literal set equality.
{{< /lean-bridge >}}

These are the exact pinned Mathlib structures:

~~~lean
structure PreErgodic (f : α → α) (μ : Measure α := by volume_tac) : Prop where
  aeconst_set ⦃s : Set α⦄ :
    MeasurableSet s → f ⁻¹' s = s → EventuallyConst s (ae μ)

structure Ergodic (f : α → α) (μ : Measure α := by volume_tac) : Prop extends
  MeasurePreserving f μ μ, PreErgodic f μ
~~~

The project exposes the probability zero-or-one statement directly.

{{< lean-bridge
  human="If s is measurable and its preimage under the cocycle base is exactly s, then an ergodic probability base gives s probability zero or one."
  math="\(C_{\mathrm{base}}^{-1}(s)=s\Longrightarrow[\mu(s)=0\text{ or }\mu(s)=1].\)"
  lean="C.ergodicBase_invariantEvent_prob_eq_zero_or_one hErg hs hinv"
>}}

- <code>C</code> is a bundled one-sided discrete matrix cocycle.
- <code>hErg : Ergodic C.base μ</code> supplies ergodicity.
- <code>hs : MeasurableSet s</code> says that \(s\) is an allowed event.
- <code>hinv : C.base ⁻¹' s = s</code> is strict preimage invariance.
- The result <code>μ s = 0 ∨ μ s = 1</code> uses <code>∨</code> for the two
  alternatives.
- The theorem delegates the invariant-set step to
  <code>hErg.toPreErgodic.prob_eq_zero_or_one</code>.
{{< /lean-bridge >}}

The exact checked project theorem is:

~~~lean
theorem ergodicBase_invariantEvent_prob_eq_zero_or_one
    [IsProbabilityMeasure μ]
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (hErg : Ergodic C.base μ) {s : Set Ω}
    (hs : MeasurableSet s) (hinv : C.base ⁻¹' s = s) :
    μ s = 0 ∨ μ s = 1 :=
  hErg.toPreErgodic.prob_eq_zero_or_one hs hinv
~~~

The invariant-function statement replaces strict pointwise equality with an
almost-everywhere equality.

{{< lean-bridge
  human="If a suitably measurable real observable is unchanged almost everywhere after one base step, ergodicity makes it equal almost everywhere to one constant."
  math="\(g\circ C_{\mathrm{base}}=g\ \mu\text{-a.e.}\Longrightarrow\exists c\in\mathbb R,\ g=c\ \mu\text{-a.e.}\)"
  lean="C.ergodicBase_ae_eq_const_of_ae_invariant hErg hg hinv"
>}}

- <code>hg : AEStronglyMeasurable g μ</code> supplies the measurable
  representative condition.
- <code>g ∘ C.base</code> means first apply the base, then read \(g\).
- <code>=ᵐ[μ]</code> is Lean's equality-almost-everywhere notation.
- <code>∃ c : ℝ</code> introduces the real constant.
- <code>Function.const Ω c</code> is the function that returns \(c\) at every
  point of \(\Omega\).
{{< /lean-bridge >}}

The exact project theorem is:

~~~lean
theorem ergodicBase_ae_eq_const_of_ae_invariant
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (hErg : Ergodic C.base μ) {g : Ω → ℝ}
    (hg : AEStronglyMeasurable g μ)
    (hinv : g ∘ C.base =ᵐ[μ] g) :
    ∃ c : ℝ, g =ᵐ[μ] Function.const Ω c :=
  hErg.ae_eq_const_of_ae_eq_comp_ae hg hinv
~~~

## Tiny local Lean/Std worksheet

**Resource label: tiny standalone check.** This worksheet imports only Lean's
<code>Std</code> library. It does not import Mathlib or this project, and it
does not build a project cache. It enumerates all sixteen events on four
points and checks invariance by finite computation.

Save the following as <code>ErgodicBaseWorksheet.lean</code> in a temporary
directory outside the repository:

~~~lean
import Std

namespace ErgodicBaseWorksheet

inductive Point where
  | p0
  | p1
  | p2
  | p3
deriving Repr, DecidableEq

def points : List Point := [.p0, .p1, .p2, .p3]

def cycle : Point → Point
  | .p0 => .p1
  | .p1 => .p2
  | .p2 => .p3
  | .p3 => .p0

def split : Point → Point
  | .p0 => .p1
  | .p1 => .p0
  | .p2 => .p3
  | .p3 => .p2

def invariant (T : Point → Point) (A : List Point) : Bool :=
  points.all fun x => decide (T x ∈ A) == decide (x ∈ A)

def allEvents : List (List Point) :=
  points.foldr
    (fun x events => events ++ events.map (fun event => x :: event))
    [[]]

def alternating : List Point := [.p0, .p2]
def firstSplitCycle : List Point := [.p0, .p1]

def splitLabel : Point → Nat
  | .p0 => 0
  | .p1 => 0
  | .p2 => 1
  | .p3 => 1

def functionInvariant (T : Point → Point) (g : Point → Nat) : Bool :=
  points.all fun x => g (T x) == g x

#eval invariant cycle alternating
#eval invariant split firstSplitCycle
#eval (allEvents.filter (invariant cycle)).map fun A => A.length
#eval (allEvents.filter (invariant split)).map fun A => A.length
#eval functionInvariant split splitLabel

example : invariant cycle alternating = false := by decide
example : invariant split firstSplitCycle = true := by decide
example : (allEvents.filter (invariant cycle)).length = 2 := by decide
example : (allEvents.filter (invariant split)).length = 4 := by decide
example : functionInvariant split splitLabel = true := by decide
example : splitLabel .p0 ≠ splitLabel .p2 := by decide

end ErgodicBaseWorksheet
~~~

From that temporary directory, a human with the pinned Lean toolchain already
installed can type:

~~~sh
elan run leanprover/lean4:v4.32.0 lean ErgodicBaseWorksheet.lean
~~~

The first two evaluations print <code>false</code> and <code>true</code>. The
next two print invariant-event cardinalities \(0,4\) for the single cycle and
\(0,2,2,4\) for the split system. Dividing by four gives probabilities
\(0,1\) versus \(0,1/2,1/2,1\). The last evaluation prints
<code>true</code> for the nonconstant split-system label. This finite program
models strict invariance exactly; it does not implement Mathlib measures or
almost-everywhere equivalence.

## Try it in the repository

{{< repo-check >}}
**Resource label: pinned project plus Mathlib.** The authoritative project
source is
[<code>formalization/NonlinearDynamics/Random/RandomCocycles/ProbabilityErgodicBase.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/ProbabilityErgodicBase.lean).
On an approved Linux builder with the project cache provisioned, a human can
type the following in a temporary probe:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase

#check MeasureTheory.IsProbabilityMeasure
#check MeasureTheory.measure_univ
#check MeasurePreserving
#check PreErgodic
#check Ergodic
#check PreErgodic.prob_eq_zero_or_one
#check Ergodic.ae_eq_const_of_ae_eq_comp_ae

#check NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.finiteHorizonLogPlusExpectation
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.finiteHorizonLogPlusExpectation_eq_integratedLogPlusNorm
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.ergodicBase_invariantEvent_prob_eq_zero_or_one
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.ergodicBase_ae_eq_const_of_ae_invariant
~~~

Each <code>#check</code> asks the pinned elaborator to display the exact type
of a declaration. To check the authoritative project module itself, type this
literal guarded command from the repository root:

~~~sh
CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/Random/RandomCocycles/ProbabilityErgodicBase.lean
~~~

That project command belongs on an approved Linux builder. Do not run it on
the Mac workstation; the repository deliberately keeps Mathlib builds in the
cloud.
{{< /repo-check >}}

## Boundaries and nonclaims

- An ergodic probability base is measure preserving, but a measure-preserving
  probability base need not be ergodic.
- The probability zero-or-one conclusion concerns invariant measurable events,
  not arbitrary events.
- Invariant functions are almost everywhere constant in the general theorem,
  not necessarily pointwise constant on every input.
- Ergodicity does not imply mixing, independence, or decay of correlations.
- Ergodicity of \(T\) does not imply ergodicity of every power \(T^n\).
- Ergodicity and probability normalization do not imply integrability of an
  arbitrary observable.
- Probability, ergodicity, and finite-horizon integrability still do not by
  themselves prove a pointwise ergodic theorem, a subadditive limit, a
  Lyapunov exponent, or an Oseledets splitting.

## Where to continue

The {{< refterm "ergodicity" "ergodicity" >}} entry isolates Mathlib's
<code>PreErgodic</code> rigidity from the measure-preserving field of full
<code>Ergodic</code>. The
[Probability Normalization and Ergodic Rigidity Before Kingman]({{< relref "/knowledge-base/deep-dives/probability-normalization-and-ergodic-rigidity-before-kingman" >}})
derives the complete project interface and keeps the finite-time integrability
and subadditive-rate declarations visible.

The
[Birkhoff Convergence Events Before the Pointwise Ergodic Theorem]({{< relref "/knowledge-base/deep-dives/birkhoff-convergence-events-before-the-pointwise-ergodic-theorem" >}})
uses invariant-event rigidity without pretending that rigidity chooses the
full-probability branch. The later
[Ergodic Birkhoff Limits and Normalized Space Averages]({{< relref "/knowledge-base/deep-dives/ergodic-birkhoff-limits-and-normalized-space-averages" >}})
adds the actual convergence and limit-identification machinery.

## References

**Mathlib contributors.**
[Probability-measure typeclasses](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Typeclasses/Probability.html),
Mathlib 4 documentation. The pinned source defines
<code>IsProbabilityMeasure μ</code> by the equation
<code>μ univ = 1</code>.

**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation. This official source packages measurability and
pushforward preservation.

**Mathlib contributors.**
[Ergodic maps and measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/Ergodic.html),
Mathlib 4 documentation. This official source defines <code>PreErgodic</code>
and <code>Ergodic</code> and proves the probability zero-or-one bridge for
measurable strictly invariant events.

**Mathlib contributors.**
[Functions invariant under an ergodic map](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/Function.html),
Mathlib 4 documentation. This official source proves almost-everywhere
constancy of suitably measurable almost-everywhere invariant functions.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
