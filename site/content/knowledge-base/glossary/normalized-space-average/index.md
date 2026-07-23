---
title: "Normalized space average"
slug: "normalized-space-average"
summary: "A normalized space average divides an integrable observable's integral by a finite nonzero total mass, so multiplying every mass by the same positive factor does not change the answer."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.ErgodicBirkhoffLimit"
og_image: "normalized-space-average-card.png"
og_image_alt: "Two atoms with weights two and one and values one and four have mass three, integral six, and normalized average two; multiplying both weights by five gives mass fifteen, integral thirty, and the same average."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted open working note. Human review of
the mathematics, Lean interpretation, sources, figure, and accessibility is
still pending. The calculations below are exact, but publication does not mean
the page has passed that review.
{{< /panel >}}

Start with a space containing exactly two atoms, \(p\) and \(q\). An **atom**
here is one indivisible outcome to which a
{{< refterm "measure" "measure" >}} assigns a weight. Give the atoms weights

\[
\mu(\{p\})=2,
\qquad
\mu(\{q\})=1,
\]

and let the real-valued observable \(f\) report

\[
f(p)=1,
\qquad
f(q)=4.
\]

There are two ledgers to add. The **mass ledger** adds the weights:

\[
\mu(\{p,q\})=2+1=3.
\]

The **integral ledger** multiplies each value by its weight before adding:

\[
\int_{\{p,q\}} f\,d\mu
{} =
2\cdot 1+1\cdot 4
{} =
2+4
{} =
6.
\]

The normalized space average is the integral divided by total mass:

\[
\operatorname{Avg}_{\mu}(f)
{} =
\frac{6}{3}
{} =
2.
\]

The answer is not the unweighted average \((1+4)/2=5/2\). Atom \(p\) carries
twice as much mass as atom \(q\), so its value \(1\) receives twice the weight.

Now multiply **both** atom weights by \(5\). The new measure \(5\mu\) has
weights \(10\) and \(5\). Its two ledgers become

\[
\begin{aligned}
(5\mu)(\{p,q\})
&=10+5=15,\\
\int_{\{p,q\}} f\,d(5\mu)
&=10\cdot1+5\cdot4=10+20=30.
\end{aligned}
\]

Both numerator and denominator grew by \(5\), so their ratio did not:

\[
\operatorname{Avg}_{5\mu}(f)=\frac{30}{15}=2.
\]

Finally, divide the original weights by their total mass \(3\). The resulting
weights \(2/3\) and \(1/3\) add to \(1\), so they define a
{{< refterm "probability-measure" "probability measure" >}}
\(\widehat\mu\). Its ordinary integral is

\[
\int f\,d\widehat\mu
{} =
\frac23\cdot1+\frac13\cdot4
{} =
\frac23+\frac43
{} =
2.
\]

For a probability measure, this integral is also called the
{{< refterm "expectation" "expectation" >}} of \(f\).

{{< reference-figure
  wide="true"
  src="normalized-space-average-scaling.svg"
  alt="The original two atoms contribute two and four to an integral of six over mass three. Fivefold scaling changes their contributions to ten and twenty, giving integral thirty over mass fifteen. Probability normalization changes their weights to two thirds and one third, and all three routes give average two."
  caption="**The complete two-atom ledger:** \(p\) has value \(1\) and original weight \(2\), while \(q\) has value \(4\) and original weight \(1\). Thus the mass is \(2+1=3\), the integral is \(2\cdot1+1\cdot4=6\), and the normalized average is \(6/3=2\). Multiplying both weights by \(5\) gives weights \(10,5\), contributions \(10,20\), mass \(15\), integral \(30\), and the same ratio \(30/15=2\). Dividing the original weights by \(3\) instead gives probabilities \(2/3,1/3\), whose expectation is \(2/3+4/3=2\). This finite calculation shows invariance under common positive scaling; it does not prove any orbit-average convergence theorem."
>}}

## The general definition

Let \(\Omega\) be a space, let \(\mu\) assign mass to its measurable subsets,
and let \(f:\Omega\to\mathbb R\) be an observable. Assume:

- \(\mu\) is finite, meaning \(\mu(\Omega)\lt\infty\);
- \(\mu\) is nonzero, meaning \(\mu(\Omega)\gt0\); and
- \(f\) is {{< refterm "integrability" "integrable" >}}, meaning its absolute
  size has finite integral.

Then the normalized space average is

\[
\operatorname{Avg}_{\mu}(f)
{} =
\frac{1}{\mu(\Omega)}\int_{\Omega} f\,d\mu.
\]

The measure tells us how much weight each part of the space receives. The
integral adds the weighted values. Dividing by total mass converts that total
into a per-unit-mass average.

If \(c\gt0\), then the scaled measure \(c\mu\) satisfies

\[
(c\mu)(\Omega)=c\mu(\Omega),
\qquad
\int f\,d(c\mu)=c\int f\,d\mu.
\]

Therefore

\[
\operatorname{Avg}_{c\mu}(f)
{} =
\frac{c\int f\,d\mu}{c\mu(\Omega)}
{} =
\operatorname{Avg}_{\mu}(f).
\]

This cancellation requires one **common** positive scale factor. Changing the
relative weights can change the answer. For example, changing the two-atom
weights from \((2,1)\) to \((1,2)\) gives

\[
\frac{1\cdot1+2\cdot4}{1+2}=\frac93=3,
\]

not \(2\).

## Why the denominator belongs in an ergodic theorem

Suppose a dynamical argument shows that a function is almost everywhere equal
to a constant \(c\), and that its integral equals the integral of \(f\). Then

\[
\mu(\Omega)c=\int_{\Omega}f\,d\mu.
\]

For finite nonzero mass, cancellation identifies

\[
c=\frac{1}{\mu(\Omega)}\int_{\Omega}f\,d\mu.
\]

The denominator is not cosmetic. If \(\mu=2\delta_x\), twice the unit mass at
one point \(x\), then

\[
\int h\,d\mu=2h(x),
\qquad
\operatorname{Avg}_{\mu}(h)=h(x).
\]

The orbit can only see the value \(h(x)\), not the arbitrarily doubled raw
integral. The project's twenty-eighth Random Matrix Theory milestone (RMT-28)
includes this mass-two boundary probe.

## In Lean: write the average notation

Mathlib, Lean's community mathematics library, uses a slashed integral sign
for the normalized average.

{{< lean-bridge
  human="Take the integral of f with respect to mu, then normalize by the total mass of mu."
  math="\(\operatorname{Avg}_{\mu}(f).\)"
  lean="⨍ x, f x ∂μ"
>}}

- <code>⨍</code> is Mathlib's notation for an integral average, not an
  ordinary integral sign.
- <code>x</code> is a bound variable ranging over the underlying space.
- <code>f x</code> is the value contributed at \(x\).
- <code>∂μ</code> says that the measure is \(\mu\). The symbol after
  <code>∂</code> changes when the measure changes.
- The notation elaborates to <code>MeasureTheory.average μ f</code>.
{{< /lean-bridge >}}

The notation is compact, but it hides the denominator. The next theorem makes
that normalization explicit.

## In Lean: expose the reciprocal mass

{{< lean-bridge
  human="The integral average equals the ordinary integral scaled by the reciprocal of the real total mass."
  math="\(\operatorname{Avg}_{\mu}(f)=\bigl(\mu_{\mathbb R}(\Omega)\bigr)^{-1}\!\int_{\Omega}f\,d\mu.\)"
  lean="MeasureTheory.average_eq (μ := μ) f"
>}}

- <code>average_eq</code> is the exact Mathlib rewrite theorem.
- <code>(μ := μ)</code> supplies the named measure argument explicitly.
- In the theorem's right-hand side, <code>μ.real univ</code> converts the total
  extended nonnegative mass to a real scalar. Here <code>univ</code> is the
  whole space \(\Omega\).
- The postfix <code>⁻¹</code> is multiplicative inverse.
- The operator <code>•</code> in the generic theorem is scalar multiplication.
  For real-valued \(f\), the project rewrites it as ordinary multiplication.
- The equality is total and remains syntactically true in the fallback cases
  discussed below. It becomes the usual division formula only under the
  finite, nonzero, integrable interpretation.
{{< /lean-bridge >}}

The exact pinned generic theorem is

~~~lean
theorem MeasureTheory.average_eq (f : Ω → E) :
    ⨍ x, f x ∂μ = (μ.real Set.univ)⁻¹ • ∫ x, f x ∂μ
~~~

The codomain \(E\) may be more general than \(\mathbb R\); it is a normed
additive commutative group with scalar multiplication by real numbers.

## In Lean: probability mass one removes the denominator

{{< lean-bridge
  human="When mu is a probability measure, its total mass is one, so its normalized average is its ordinary integral."
  math="\(\mu(\Omega)=1\quad\Longrightarrow\quad\operatorname{Avg}_{\mu}(f)=\int_{\Omega}f\,d\mu.\)"
  lean="MeasureTheory.average_eq_integral (μ := μ) f"
>}}

- <code>average_eq_integral</code> is a Mathlib theorem, not a new definition.
- Its hidden typeclass premise <code>[IsProbabilityMeasure μ]</code> records
  \(\mu(\Omega)=1\).
- <code>∫ x, f x ∂μ</code> is the ordinary Bochner integral. Calling it an
  expectation is appropriate when \(\mu\) is a probability measure and \(f\)
  is the random variable under discussion.
- The theorem itself is total; a mathematically informative expectation still
  needs the usual measurability and integrability conditions.
{{< /lean-bridge >}}

The exact pinned theorem is

~~~lean
theorem MeasureTheory.average_eq_integral
    [IsProbabilityMeasure μ] (f : Ω → E) :
    ⨍ x, f x ∂μ = ∫ x, f x ∂μ
~~~

## In Lean: the project theorem adds dynamics

The normalized average is a static quantity. RMT-28 proves a separate theorem
that identifies it as the limit of time averages under explicit dynamical
hypotheses.

{{< lean-bridge
  human="On a finite nonzero ergodic measure-preserving system, the Birkhoff averages of an integrable real observable converge for almost every starting point to its normalized space average."
  math="\(\mu\text{ finite},\ \mu\ne0,\ T\text{ ergodic},\ f\in L^1(\mu)\Longrightarrow \frac1n\sum_{j=0}^{n-1}f(T^j\omega)\to\frac{1}{\mu(\Omega)}\int f\,d\mu\text{ for }\mu\text{-almost every }\omega.\)"
  lean="ae_tendsto_birkhoffAverage_normalizedIntegral_of_ergodic (T := T) (f := f) hμ hT hf"
>}}

- <code>hμ : μ ≠ 0</code> rules out zero total mass, while
  <code>[IsFiniteMeasure μ]</code> is an ambient instance ensuring finite mass.
- <code>hT : Ergodic T μ</code> supplies both measure preservation and ergodic
  rigidity for the map \(T\).
- <code>hf : Integrable f μ</code> is the analytic hypothesis on \(f\).
- The theorem's conclusion begins <code>∀ᵐ ω ∂μ</code>, read “for almost every
  \(\omega\) with respect to \(\mu\).” It does not say every starting point.
- <code>Tendsto ... atTop (nhds target)</code> says the sequence converges as
  the natural-number horizon tends to infinity toward the displayed target.
- <code>birkhoffAverage ℝ T f n ω</code> averages the first \(n\) observations
  along the orbit of \(\omega\).
{{< /lean-bridge >}}

Its exact declaration is

~~~lean
theorem ae_tendsto_birkhoffAverage_normalizedIntegral_of_ergodic
    [IsFiniteMeasure μ]
    (hμ : μ ≠ 0) (hT : Ergodic T μ) (hf : Integrable f μ) :
    ∀ᵐ ω ∂μ,
      Tendsto (fun n ↦ birkhoffAverage ℝ T f n ω) atTop
        (nhds ((μ.real univ)⁻¹ * ∫ x, f x ∂μ))
~~~

The theorem is stronger than the definition of an average and narrower than a
general slogan about ergodicity: it is an almost-everywhere convergence result
for integrable real observables under the exact listed assumptions.

## A tiny standalone Lean worksheet a human can type

**Resource label: tiny Lean standard-library (<code>Std</code>) check.** This
worksheet verifies only the two finite integer ledgers. It does not import
Mathlib, construct a measure, or prove an ergodic theorem.

Save the following as <code>NormalizedAverageTutorial.lean</code>:

~~~lean
import Std

inductive Atom where
  | p | q
deriving Repr, DecidableEq

def atoms : List Atom := [.p, .q]

def value : Atom → Nat
  | .p => 1
  | .q => 4

def originalWeight : Atom → Nat
  | .p => 2
  | .q => 1

def scaledWeight (scale : Nat) (x : Atom) : Nat :=
  scale * originalWeight x

def totalMass (weight : Atom → Nat) : Nat :=
  atoms.foldl (fun total x => total + weight x) 0

def weightedIntegral (weight : Atom → Nat) : Nat :=
  atoms.foldl (fun total x => total + weight x * value x) 0

def exactIntegerAverage (weight : Atom → Nat) : Nat :=
  weightedIntegral weight / totalMass weight

#eval [totalMass originalWeight,
       weightedIntegral originalWeight,
       exactIntegerAverage originalWeight]

#eval [totalMass (scaledWeight 5),
       weightedIntegral (scaledWeight 5),
       exactIntegerAverage (scaledWeight 5)]

example : totalMass originalWeight = 3 := by decide
example : weightedIntegral originalWeight = 6 := by decide
example : exactIntegerAverage originalWeight = 2 := by decide
example : totalMass (scaledWeight 5) = 15 := by decide
example : weightedIntegral (scaledWeight 5) = 30 := by decide
example : exactIntegerAverage (scaledWeight 5) = 2 := by decide
~~~

From the directory containing that file, type exactly:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean NormalizedAverageTutorial.lean
~~~

The two output rows should be <code>[3, 6, 2]</code> and
<code>[15, 30, 2]</code>. This command is suitable for an ordinary Mac or
Linux machine because the worksheet imports only <code>Std</code>.

The tutorial uses natural-number division only because \(6/3\) and \(30/15\)
are exact integers. It stores the probability weights \(2/3\) and \(1/3\) as
the common numerator ledger \((2,1)\) over denominator \(3\). It is a check of
the finite arithmetic, not an implementation of real integration or rational
probability measures. This exact worksheet was executed successfully with the
pinned Lean 4.32.0 compiler on the Mac.

## Try the exact declarations in the project

{{< repo-check >}}
**Resource label: pinned project plus Mathlib.** In a deliberately provisioned
copy of the repository, a reader can create a scratch query containing:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.ErgodicBirkhoffLimit
import Mathlib.MeasureTheory.Integral.Average

open MeasureTheory Set Filter
open NonlinearDynamics.Random.RandomCocycles

#check MeasureTheory.average
#check MeasureTheory.average_eq
#check MeasureTheory.average_eq_integral
#check condExp_invariants_ae_eq_average_of_preErgodic
#check condExp_invariants_ae_eq_normalizedIntegral_of_preErgodic
#check ae_tendsto_birkhoffAverage_normalizedIntegral_of_ergodic
#check ae_tendsto_birkhoffAverage_integral_of_ergodic
~~~

Each <code>#check</code> asks the pinned elaborator for the exact declaration
type. The guarded command below checks the authoritative RMT-28 source module,
not the tiny standalone worksheet. It belongs on approved Linux compute and
must not be run on this Mac workstation.
{{< /repo-check >}}

## Totalized edge cases are conventions, not averages with evidence

Mathlib defines

~~~lean
noncomputable def MeasureTheory.average (μ : Measure Ω) (f : Ω → E) :=
  ∫ x, f x ∂(μ Set.univ)⁻¹ • μ
~~~

This is a **total** definition: Lean returns a value for every measure and
function instead of leaving exceptional inputs undefined.

- **Zero measure.** The scaled measure is again zero, and the average is zero.
  There is no positive mass over which to average.
- **Infinite total mass.** The inverse of infinite extended mass is zero, so
  the normalized measure and average are zero. This is a library convention,
  not a claim that every infinite-volume mean physically equals zero.
- **Nonintegrable function.** Mathlib's totalized Bochner integral returns zero
  outside its integrable regime, so the average does too. That zero does not
  certify {{< refterm "integrability" "integrability" >}} and should not be
  interpreted as cancellation of positive and negative contributions.
- **Inverse of zero.** In Lean's field operations, the inverse of zero is
  defined to be zero. Thus <code>average_eq</code> remains a valid rewrite at
  zero mass, but the resulting identity has no ordinary division-by-positive-
  mass meaning.

These choices are valuable for algebraic rewriting because every expression
has a type and a value. The semantic theorem in this page deliberately adds
<code>IsFiniteMeasure μ</code>, <code>μ ≠ 0</code>, and
<code>Integrable f μ</code> before identifying an ergodic limit with a genuine
normalized average. The probability specialization supplies finite nonzero
mass automatically but still keeps the observable's integrability premise.

## Space average is not time average

The normalized space average uses the measure over the whole state space. A
time average follows one orbit:

\[
\frac1n\sum_{j=0}^{n-1}f(T^j\omega).
\]

The two-atom arithmetic does not make these quantities equal. If \(T\) is the
identity map, then a point starting at \(p\) reads \(1\) forever and a point
starting at \(q\) reads \(4\) forever. Their time averages are \(1\) and \(4\),
not the global normalized average \(2\). The identity map preserves the
measure, but this two-positive-mass system is not
{{< refterm "ergodicity" "ergodic" >}}.

RMT-27 first identifies the general Birkhoff limit as
{{< refterm "conditional-expectation" "conditional expectation" >}} onto the
{{< refterm "invariant-sigma-algebra" "invariant sigma algebra" >}}. RMT-28
adds ergodic rigidity, which makes that invariant target almost everywhere
constant, and then the mass ledger identifies the constant as the normalized
space average.

## What this page does and does not establish

The two-atom example establishes exactly that common positive rescaling sends

\[
(\text{mass},\text{integral})=(3,6)
\quad\text{to}\quad
(15,30)
\]

while preserving their ratio \(2\). More generally, the definition records a
weighted average per unit mass.

It does **not** establish any of the following by definition alone:

- that \(f\) is measurable or integrable;
- that a totalized zero is a meaningful mean;
- invariance under changing relative weights;
- measure preservation or ergodicity of a map;
- convergence of any orbit average;
- convergence at every starting point;
- a rate of convergence, mixing, independence, or decay of correlations;
- a subadditive cocycle limit, Lyapunov exponent, or Oseledets splitting; or
- an identity with normalized matrix trace without a separate theorem.

## Where to continue

[Ergodic Birkhoff Limits and Normalized Space Averages]({{< relref "/knowledge-base/deep-dives/ergodic-birkhoff-limits-and-normalized-space-averages" >}})
develops the conditional-expectation collapse and every RMT-28 assumption.

[Birkhoff Limits, Invariant Sigma Algebras, and Conditional Expectation]({{< relref "/knowledge-base/deep-dives/birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation" >}})
explains the nonergodic target that comes first.

The {{< refterm "probability-measure" "probability measure" >}} page derives
the mass-one case. The {{< refterm "expectation" "expectation" >}} page
explains when ordinary-integral language becomes probabilistic. The
{{< refterm "ergodic-probability-base" "ergodic probability base" >}} page
keeps probability normalization, measure preservation, ergodicity, and
integrability as separate hypotheses.

## References

<a id="ref-normalized-average-mathlib"></a>**Mathlib contributors.**
[Integral averages](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Integral/Average.lean#L271-L345),
Mathlib 4.32.0 at pinned commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).
This source is authoritative for <code>⨍</code>,
<code>MeasureTheory.average</code>, <code>average_eq</code>,
<code>average_eq_integral</code>, and the documented totalized cases.

<a id="ref-normalized-average-project"></a>**Nonlinear Dynamics in Lean contributors.**
[ErgodicBirkhoffLimit.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/ErgodicBirkhoffLimit.lean),
the checked project source for the pre-ergodic conditional-expectation
identification and the finite-measure and probability Birkhoff endpoints.
