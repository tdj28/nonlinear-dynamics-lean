---
title: "Probability measure"
slug: "probability-measure"
summary: "A probability measure is a measure whose total mass on the whole outcome space is exactly one."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase"
og_image: "probability-measure-card.png"
og_image_alt: "Proportional mass bars compare total mass one with a mass-two finite measure and a mass-three-quarters subprobability measure."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean examples, source interpretation, figure, and accessibility
remains pending. It is public so readers can follow the educational rebuild
while that review is open.
{{< /panel >}}

A **probability measure** is a
{{< refterm "measure" "measure" >}} whose total mass is exactly one. If
\(\Omega\) is the entire outcome space and \(\mathbb P\) is the measure, the
defining normalization is

\[
\mathbb P(\Omega)=1.
\]

Nonnegativity and countable additivity come from being a measure. Total mass
one is the extra condition that turns mass into probability.

## Start with one fair die

Let

\[
\Omega=\{1,2,3,4,5,6\}
\]

be the possible outcomes of a fair six-sided die. Assign every face mass
\(1/6\):

\[
\mathbb P\{k\}=\frac16
\qquad\text{for each }k\in\Omega.
\]

The six singleton events are disjoint and their union is the whole space, so
finite additivity gives

\[
\mathbb P(\Omega)
=\sum_{k=1}^{6}\mathbb P\{k\}
=6\cdot\frac16
=1.
\]

Thus \(\mathbb P\) is a probability measure. For the
{{< refterm "event" "event" >}}

\[
E=\{2,4,6\}
\quad\text{(the roll is even)},
\]

we calculate

\[
\mathbb P(E)=3\cdot\frac16=\frac12.
\]

The number \(1/2\) is not an extra label attached to \(E\). It is the measure
of that set under this particular total-mass-one measure.

## Two nearby measures that are not probabilities

Keep the same six-point space but change the mass per face.

First define \(\nu\{k\}=1/3\). Its total mass is

\[
\nu(\Omega)=6\cdot\frac13=2.
\]

This is a finite measure because its total mass is finite. It is not a
probability measure because the total is two rather than one. The even event
has \(\nu(E)=3\cdot(1/3)=1\); that value does not mean the event is certain,
because certainty language is licensed only after total mass is one.

Next define \(\rho\{k\}=1/8\). Its total mass is

\[
\rho(\Omega)=6\cdot\frac18=\frac34.
\]

This is a **subprobability measure**: its total mass is at most one, but here it
is strictly below one. The even event has

\[
\rho(E)=3\cdot\frac18=\frac38.
\]

Neither finiteness nor the upper bound \(\rho(\Omega)\le1\) is the defining
probability condition. The gate is exact equality with one.

{{< reference-figure
  wide="true"
  src="total-mass-gate.svg"
  alt="Three six-segment mass bars share a scale from zero to two. The fair-die bar has six segments of one sixth and ends at the mass-one probability gate. A finite measure has six segments of one third and ends at two. A subprobability has six segments of one eighth and ends at three quarters."
  caption="**Finding:** all three rows are valid finite measures on the same six outcomes, but only the fair-die measure lands exactly on the total-mass-one gate. Six weights of \(1/6\) total \(1\); six weights of \(1/3\) total \(2\); and six weights of \(1/8\) total \(3/4\). Every bar uses the same horizontal scale, and each segment represents one face's exact mass. The dashed line marks the defining probability condition, not a pass-fail judgment about whether the other measures are mathematically useful."
>}}

## The exact definition

Let \((\Omega,\mathcal F)\) be a measurable space. A probability measure is a
measure

\[
\mathbb P:\mathcal F\longrightarrow[0,\infty]
\]

with the following properties:

1. \(\mathbb P(A)\ge0\) for every measurable event \(A\);
2. \(\mathbb P\) is countably additive on pairwise disjoint events; and
3. \(\mathbb P(\Omega)=1\).

The first two are the ordinary measure axioms. The third is the probability
normalization. It immediately gives

\[
0\le\mathbb P(A)\le1
\]

for every event \(A\), because \(A\subseteq\Omega\) and measures are
monotone.

For a measurable event \(A\), its complement satisfies

\[
\mathbb P(A^{\mathsf c})=1-\mathbb P(A).
\]

That familiar probability formula is the ordinary measure identity
\(\mathbb P(A)+\mathbb P(A^{\mathsf c})=\mathbb P(\Omega)\) with total mass
one substituted at the final step.

## Normalizing a finite measure

Suppose \(\nu\) is a finite measure with strictly positive total mass:

\[
0\lt\nu(\Omega)\lt\infty.
\]

Then the rescaled measure

\[
\widehat\nu(A)=\frac{\nu(A)}{\nu(\Omega)}
\]

is a probability measure, because

\[
\widehat\nu(\Omega)
=\frac{\nu(\Omega)}{\nu(\Omega)}
=1.
\]

For the mass-two die measure, normalization divides every event mass by two:

\[
\widehat\nu\{k\}=\frac16,
\qquad
\widehat\nu(E)=\frac12.
\]

For the mass-three-quarters subprobability, normalization multiplies every
event mass by \(4/3\):

\[
\widehat\rho\{k\}=\frac16,
\qquad
\widehat\rho(E)=\frac12.
\]

The two normalized measures happen to become the same fair-die law because
both original examples gave equal weight to every face.

## Why normalization is not always harmless

Rescaling preserves which sets have mass zero and preserves ratios of positive
finite event masses. It does not preserve the original absolute scale. In the
mass-two model, the even set changes from mass one to probability one half. An
integral \(\int f\,d\nu\) is divided by the same total mass, so a physical
quantity such as particle intensity, spatial density, or expected count can
change meaning.

Normalization also requires a positive finite denominator:

- the zero measure has \(\nu(\Omega)=0\), so division by the total cannot
  produce a probability measure;
- an infinite measure has \(\nu(\Omega)=\infty\), so constant rescaling does
  not turn it into a total-mass-one measure; and
- a measure chosen for its absolute units may be intentionally unnormalized.

Therefore “normalize the measure” is a mathematical operation with
preconditions and semantic consequences, not a free change of notation.

## Probability measure, law, and density are different layers

A probability measure can be specified directly, as with the fair die. It can
also arise as the {{< refterm "probability-law" "probability law" >}} of a
random object, obtained by pushing a source probability measure onto a value
space.

A density is only one possible representation of a measure relative to a
chosen reference measure. The fair die has a probability mass function. A
Dirac probability measure concentrates all mass at one point. A continuous
law may have a density, but not every probability measure does. “Probability
measure” names the measure itself, not a formula used to describe it.

A {{< refterm "null-set" "null set" >}} is also measure-relative. Rescaling a
positive finite measure to a probability measure preserves its null sets, but
changing to an unrelated probability measure can change which sets are null.

## In Lean: total mass one is a typeclass gate

Mathlib represents the normalization as a proposition-valued typeclass. In a
theorem, square brackets ask Lean to find or receive the probability-measure
certificate automatically.

{{< lean-bridge
  human="The measure mu is a probability measure, so the whole outcome space has mass one."
  math="\(\mu(\Omega)=1\)."
  lean="example [IsProbabilityMeasure μ] : μ univ = 1 := measure_univ"
>}}

- <code>μ</code> has type <code>Measure Ω</code> for some measurable outcome
  type <code>Ω</code>.
- <code>[IsProbabilityMeasure μ]</code> is an implicit typeclass assumption.
  Its data is a proof of the mass-one equation.
- <code>univ : Set Ω</code> is the set of all outcomes, the Lean counterpart of
  \(\Omega\) in the displayed formula.
- <code>μ univ</code> applies the measure to the whole set.
- <code>measure_univ</code> is the theorem exported from the typeclass. Under
  the square-bracket assumption, Lean uses it to prove <code>μ univ = 1</code>.
- The numeral <code>1</code> is interpreted in the measure's extended
  nonnegative-real codomain.
{{< /lean-bridge >}}

### Small standalone tutorial: test the total-mass gate

Put all three six-face examples over the common denominator \(24\). A fair
face has mass \(4/24=1/6\), a face in the mass-two model has
\(8/24=1/3\), and a face in the subprobability model has
\(3/24=1/8\). Total mass one is therefore exactly total numerator \(24\).
Create <code>/tmp/ProbabilityMassGate.lean</code> with these contents:

~~~lean
import Std

namespace ProbabilityMassGate

def totalTwentyFourths (perFaceTwentyFourths : Nat) : Nat :=
  6 * perFaceTwentyFourths

def hasTotalMassOne (perFaceTwentyFourths : Nat) : Bool :=
  totalTwentyFourths perFaceTwentyFourths == 24

#eval [
  totalTwentyFourths 4,
  totalTwentyFourths 8,
  totalTwentyFourths 3
]
#eval [
  hasTotalMassOne 4,
  hasTotalMassOne 8,
  hasTotalMassOne 3
]

example : totalTwentyFourths 4 = 24 := by decide
example : totalTwentyFourths 8 = 48 := by decide
example : totalTwentyFourths 3 = 18 := by decide
example : hasTotalMassOne 4 = true := by decide
example : hasTotalMassOne 8 = false := by decide
example : hasTotalMassOne 3 = false := by decide

end ProbabilityMassGate
~~~

From any directory on a normal macOS or Linux machine with the pinned compiler,
type exactly:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean /tmp/ProbabilityMassGate.lean
~~~

This exact worksheet was executed successfully with Lean 4.32.0 while
repairing this page. It printed:

~~~text
[24, 48, 18]
[true, false, false]
~~~

Dividing the first row by \(24\) recovers the exact totals \(1\), \(2\), and
\(3/4\). Only the first Boolean is true because only that total equals one.
This bounded arithmetic model imports only <code>Std</code>. It illustrates
the normalization gate; it does not construct Mathlib measures.

### Exact project and Mathlib interface

The project uses the typeclass as a semantic gate, not as a hidden
renormalization operation. The following definition and theorem are exact
excerpts from <code>ProbabilityErgodicBase.lean</code>:

~~~lean
def finiteHorizonLogPlusExpectation [IsProbabilityMeasure μ]
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (_hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) : ℝ :=
  ∫ ω, C.logPlusNormObservable k ω ∂μ

@[simp] theorem finiteHorizonLogPlusExpectation_eq_integratedLogPlusNorm
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) :
    C.finiteHorizonLogPlusExpectation hC k = C.integratedLogPlusNorm k := by
  rfl
~~~

The definition does not divide by \(\mu(\Omega)\). The square-bracket premise
already certifies that \(\mu(\Omega)=1\), so the raw integral can be exposed
honestly as an expectation. The equality proof is <code>rfl</code>, meaning
both sides reduce to the same expression by definition. Probability here
changes which terminology and theorems are licensed; it does not silently
change the measure supplied by the caller.

The same module uses <code>[IsProbabilityMeasure μ]</code> in its checked
zero-or-one theorem for a measurable invariant event. The outcomes \(0\) and
\(1\) are probability values only because the total-mass-one gate is visible.

{{< repo-check >}}
The authoritative checked source is
[<code>formalization/NonlinearDynamics/Random/RandomCocycles/ProbabilityErgodicBase.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/ProbabilityErgodicBase.lean).
A human can type the following worksheet in a scratch buffer inside a clone
with the repository's pinned dependencies installed:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase

open MeasureTheory Set

#check IsProbabilityMeasure
#check measure_univ
#check isProbabilityMeasure_iff
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.finiteHorizonLogPlusExpectation
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.ergodicBase_invariantEvent_prob_eq_zero_or_one

example {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω)
    [IsProbabilityMeasure μ] : μ univ = 1 :=
  measure_univ
~~~

The first three <code>#check</code> commands expose Mathlib's class and its
defining equation. The next two inspect real project declarations whose
probability language is guarded by that class. The final <code>example</code>
asks Lean to recover the mass-one equation from the typeclass assumption. The
full-project command below checks the complete project module containing the exact
excerpt.
{{< /repo-check >}}

## Boundaries that prevent common mistakes

| Tempting shortcut | Correct statement |
|---|---|
| “Every finite measure is a probability measure.” | A finite measure only has finite total mass; a probability measure has total mass exactly one. |
| “A subprobability is already a probability.” | A subprobability may have total mass below one. Equality with one is required. |
| “Event mass one always means certainty.” | That language assumes the whole space also has mass one. Under the mass-two measure, a proper event can have mass one. |
| “Normalization changes nothing.” | It preserves relative mass and null sets under positive finite scaling, but changes absolute event masses and integrals. |
| “Every measure can be normalized.” | Constant normalization needs strictly positive finite total mass. |
| “Probability measure means density.” | A density is an optional representation relative to another measure. |

{{< panel "warning" >}}
**What total mass one does not prove.** A probability measure need not have a
density, finite moments, independent coordinates, symmetry, invariance under a
dynamical map, or an ergodic property. It only supplies a normalized measure.
Every additional probabilistic or dynamical claim needs its own hypotheses.
{{< /panel >}}

## Where to continue

The {{< refterm "measure" "measure" >}} entry develops nonnegativity,
countable additivity, and total mass without assuming normalization. The
{{< refterm "event" "event" >}} entry teaches the measurable sets to which
probabilities are assigned. The
{{< refterm "probability-law" "probability distribution (law)" >}} entry shows
how a measurable random object transports a probability measure to its value
space. The
{{< refterm "null-set" "null set" >}} entry explains zero-mass exceptions and
why they need not be empty.

For the project use of this gate, continue to
[Probability Normalization and Ergodic Rigidity Before Kingman]({{< relref "/knowledge-base/deep-dives/probability-normalization-and-ergodic-rigidity-before-kingman" >}}).
It separates finite-horizon integrability, probability normalization,
measure preservation, and ergodicity before any samplewise convergence claim.

## References

**Mathlib contributors.**
[Probability-measure typeclasses](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Typeclasses/Probability.html),
Mathlib 4 documentation. This official source defines
<code>IsProbabilityMeasure</code> by <code>μ univ = 1</code> and derives the
standard probability bounds and complement identities.

**Olav Kallenberg.**
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1),
third edition, Springer, 2021. This is a standard reference for probability
measures, distributions, and normalization.

**Project source.**
[ProbabilityErgodicBase.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/ProbabilityErgodicBase.lean)
contains the checked expectation and invariant-event interfaces used in the
Lean section.
