---
title: "Ergodic probability base"
slug: "ergodic-probability-base"
summary: "A probability base has total mass one, while ergodicity says invariant measurable information is trivial; integrability is a third, independent analytic requirement."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase"
og_image: "ergodic-probability-base-card.png"
og_image_alt: "Three separately labeled gates show probability fixing the measure scale, ergodicity making invariant information trivial, and integrability controlling finite moments. A final warning says that passing all three gates still does not itself prove a samplewise limit."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

An **ergodic probability base** is a measure-preserving dynamical system whose
measure has total mass one and whose invariant measurable information is
trivial up to null sets. In the seventeenth random-matrix-theory milestone
(RMT-17), this phrase is a coordination label, not a new bundled structure.
The two hypotheses remain separate:

~~~lean
[IsProbabilityMeasure μ]
hErg : Ergodic C.base μ
~~~

A third condition, <code>C.HasIntegrableGeneratorLogPlus</code>, controls the
finite log-positive cocycle moments. It is not part of probability or
ergodicity.

The separation is the central lesson:

- **probability fixes scale:** \(\mu(\Omega)=1\);
- **ergodicity fixes invariant information:** invariant events are null or
  conull, and suitably measurable invariant real observables are almost
  everywhere constant; and
- **integrability fixes analytic legitimacy:** the finite-horizon
  log-positive functions have genuine finite Bochner integrals.

Passing all three gates still does not, by itself, produce a theorem saying
that a normalized cocycle observable converges at almost every base point.

{{< reference-figure
  src="ergodic-probability-base.svg"
  alt="Probability, ergodicity, and integrability appear as three independent gates. Probability sets total mass to one and licenses expectation language. Ergodicity reduces invariant events to null or full and invariant observables to almost-everywhere constants. Integrability certifies finite-horizon moments. The three gates meet at a warning that no samplewise limit follows without an ergodic theorem."
  caption="**Finding:** probability normalization, ergodic rigidity, and integrability answer different questions. The current module combines them only where a theorem needs them. The diagram is an assumption map, not a claim that the three hypotheses imply independence, mixing, or samplewise convergence."
>}}

## Probability fixes the unit of measure

Mathlib's <code>IsProbabilityMeasure μ</code> class records exactly


\[
\mu(\Omega)=1.
\]

It also supplies finite-measure and nonzero-measure consequences through the
upstream typeclass hierarchy. It does not assert that a base map is ergodic,
that random variables are independent, or that a cocycle observable is
integrable. These semantics are visible in the official
[Mathlib probability-measure documentation](#ref-ergodic-probability-mathlib-probability).

RMT-17 uses mass one to license the name
<code>finiteHorizonLogPlusExpectation</code>. Under the separate integrability
hypothesis <code>hC</code>, it defines

\[
\mathbb E_\mu[P_k]
{} =
\int_\Omega P_k(\omega)\,d\mu(\omega),
\qquad
P_k(\omega)=\log^+\lVert C(k,\omega)\rVert_\infty.
\]

The theorem
<code>finiteHorizonLogPlusExpectation_eq_integratedLogPlusNorm</code> is proved
by reflexivity. Probability normalization does not numerically rescale the
existing integral. It makes expectation vocabulary correct, while
<code>hC</code> makes the totalized Bochner integral analytically meaningful.

## Ergodicity makes invariant information rigid

Mathlib's <code>Ergodic T μ</code> extends both measure preservation and a
pre-ergodic condition. The latter says that a measurable set satisfying the
strict invariance equation

\[
T^{-1}(A)=A
\]

is almost everywhere empty or almost everywhere the whole space. This is the
definition implemented by the official
[Mathlib ergodicity documentation](#ref-ergodic-probability-mathlib-ergodic).

On a probability space, conull means probability one. RMT-17 therefore exports

\[
\mu(A)=0
\quad\text{or}\quad
\mu(A)=1
\]

for every measurable, strictly invariant event \(A\). The theorem requires
both <code>[IsProbabilityMeasure μ]</code> and
<code>hErg : Ergodic C.base μ</code>. Ergodicity supplies the null-or-conull
dichotomy; probability supplies the numerical value one.

RMT-17 also exposes the function form of the same rigidity. If
\(g:\Omega\to\mathbb R\) is almost-everywhere strongly measurable and

\[
g\circ T = g
\qquad\text{almost everywhere},
\]

then there is a real constant \(c\) such that \(g=c\) almost everywhere. This
bridge follows the official
[Mathlib invariant-function theorem](#ref-ergodic-probability-mathlib-function).
It needs <code>Ergodic T μ</code>, but no probability typeclass. Without mass
one, the conclusion is still almost-everywhere constancy; one simply cannot
rename arbitrary integrals as expectations.

## Integrability controls the finite moments

For this cocycle, <code>HasIntegrableGeneratorLogPlus</code> says that the
one-step function \(P_1\) is integrable. RMT-15 propagates that fact to every
finite horizon. RMT-17 packages the result as

~~~lean
structure IsIntegrableSubadditiveProcessCandidate
    (T : Ω → Ω) (μ : Measure Ω) (X : ℕ → Ω → ℝ) : Prop where
  integrable : ∀ k, Integrable (X k) μ
  add_le : ∀ m k ω, X (m + k) ω ≤ X k (T^[m] ω) + X m ω
~~~

The word **candidate** is deliberate. The package stores finite-horizon
integrability and the shifted subadditive inequality. It does not store
probability normalization, measure preservation, ergodicity, or an asymptotic
theorem. For a matrix cocycle, preservation is already a field of the cocycle,
while the other assumptions remain explicit at theorem boundaries.

## Four examples separate the concepts

### Probability without ergodicity

Let \(\Omega=\{0,1\}\), give each point probability \(1/2\), and let \(T\) be
the identity. The event \(A=\{0\}\) is measurable and strictly invariant, but

\[
\mu(A)=\frac12.
\]

The base is a probability-preserving system and is not ergodic.

### Ergodicity without probability

Let \(\Omega=\{\ast\}\), let \(T\) be the identity, and give the only point raw
mass two. The only measurable events are empty and full, so the base is
ergodic. It is not a probability base because

\[
\mu(\Omega)=2.
\]

The invariant-function theorem still has content here: every real function on
one point is constant. The probability zero-one theorem is unavailable because
the full event has mass two, not one.

### Probability and ergodicity without mixing

Return to two points with equal probabilities, but let the base flip them:

\[
T(0)=1,
\qquad
T(1)=0.
\]

Only the empty and full sets are strictly invariant, so the base is ergodic.
It is not mixing. For \(A=\{0\}\),

\[
\mu\bigl(A\cap T^{-n}A\bigr)
{} =
\begin{cases}
\tfrac12,& n\text{ even},\\
0,& n\text{ odd},
\end{cases}
\]

which does not converge to
\(\mu(A)^2=1/4\). Ergodicity does not erase periodic correlation.

### Probability without integrability

On \(\Omega=(0,1]\) with Lebesgue probability measure, the measurable scalar
generator

\[
G(x)=\exp(1/x)
\]

is finite at every point, but its one-step log-positive envelope is \(1/x\),
whose integral diverges. Probability normalization alone does not establish
<code>HasIntegrableGeneratorLogPlus</code>. This is an analytic example, not a
formal declaration in RMT-17.

Conversely, any finite-valued generator on the two-point raw-mass-two identity
base is integrable. That base is neither probabilistic nor ergodic. Finite
moments do not determine the measure scale or the invariant-set structure.

## The flip cocycle is the calibration example

Use the equal-probability two-point flip and one-dimensional generators

\[
G(0)=\begin{bmatrix}2\end{bmatrix},
\qquad
G(1)=\begin{bmatrix}\tfrac12\end{bmatrix}.
\]

Let \(P_k\) be the log-positive product norm, let
\(E_k=\mathbb E[P_k]\), and define the normalized expectation
\(Q_k=E_k/k\) for positive \(k\). Every even product is one. At odd horizons,
the product starting at zero is two and the product starting at one is one
half. Therefore

\[
Q_1=\frac{\log 2}{2},
\qquad
Q_2=0,
\qquad
Q_3=\frac{\log 2}{6}.
\]

The normalized sequence is not monotone. Its deterministic integrated
log-positive growth rate is zero because every even positive horizon has
normalized value zero and all normalized values are nonnegative:

\[
\gamma_\mu^+(C)=0
\lt
\frac{\log2}{2}=E_1.
\]

This checks two RMT-17 rate facts sharply: the rate lies below every positive
normalized horizon, and the one-step upper bound can be strict. The example is
probabilistic, ergodic, finite, and integrable. RMT-17 still makes no formal
samplewise-limit claim about it.

## The ten-declaration interface

RMT-17 exports ten source-level declarations, counting the process-candidate
structure as one declaration:

| No. | Declaration | Required gate |
|---:|---|---|
| 1 | <code>IsIntegrableSubadditiveProcessCandidate</code> | Generic finite-horizon predicate |
| 2 | <code>HasIntegrableGeneratorLogPlus.isIntegrableSubadditiveProcessCandidate</code> | Integrability |
| 3 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_nonneg</code> | Integrability |
| 4 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_eq_sInf</code> | Integrability |
| 5 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_le_normalized</code> | Integrability and a positive horizon |
| 6 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_le_oneStep</code> | Integrability |
| 7 | <code>finiteHorizonLogPlusExpectation</code> | Probability and integrability |
| 8 | <code>finiteHorizonLogPlusExpectation_eq_integratedLogPlusNorm</code> | Probability and integrability |
| 9 | <code>ergodicBase_invariantEvent_prob_eq_zero_or_one</code> | Probability, ergodicity, measurability, and strict invariance |
| 10 | <code>ergodicBase_ae_eq_const_of_ae_invariant</code> | Ergodicity, almost-everywhere strong measurability, and almost-everywhere invariance |

The deterministic rate results do not need probability or ergodicity. The
expectation bridge does not need ergodicity. The event theorem needs both
probability and ergodicity. The invariant-function theorem needs ergodicity
but not probability. The rate comparisons reuse Mathlib's deterministic
[subadditive-sequence interface](#ref-ergodic-probability-mathlib-subadditive).
These signatures are part of the mathematical content.

## The pre-Kingman boundary

Kingman's subadditive ergodic theorem is the historical route from a stationary
subadditive process to an almost-everywhere normalized limit under additional
hypotheses
([Kingman, 1968](#ref-ergodic-probability-kingman)). Ergodicity can then make
the invariant limiting quantity constant in the relevant formulations.

RMT-17 does not invoke that theorem. The Mathlib revision pinned by this
project has deterministic subadditive-sequence machinery but no Kingman
theorem matching this process. The new candidate packages two finite-time
obligations so a future theorem can consume them honestly. It does not fill
the missing asymptotic step.

Accordingly, RMT-17 proves none of the following:

- convergence of \(P_k(\omega)/k\) at any base point;
- almost-everywhere, in-probability, distributional, or \(L^1\)
  integrable-norm convergence;
- equality between the deterministic integrated rate and a samplewise limit;
- interchange of expectation and a limit;
- mixing, independence, or decay of correlations;
- a Lyapunov exponent, spectrum, filtration, or Oseledets splitting; or
- the Furstenberg-Kesten theorem for products of random matrices
  ([Furstenberg and Kesten, 1960](#ref-ergodic-probability-furstenberg-kesten)).

## Where to continue

The standalone {{< refterm "ergodicity" >}} entry separates Mathlib's
<code>PreErgodic</code> rigidity field from the measure-preserving field of
full <code>Ergodic</code>. The
[RMT-28 Deep Dive]({{< relref "/knowledge-base/deep-dives/ergodic-birkhoff-limits-and-normalized-space-averages" >}})
then composes that distinction with the additive pointwise Birkhoff theorem
and identifies the {{< refterm "normalized-space-average" "normalized space average" >}}.
It still proves no subadditive cocycle-growth limit.

[The Birkhoff sum]({{< relref "/knowledge-base/glossary/birkhoff-sum" >}})
is the next finite-time concept: it packages powered-orbit block costs without
claiming that their normalized values converge.

[Probability Normalization and Ergodic Rigidity Before Kingman]({{< relref "/knowledge-base/deep-dives/probability-normalization-and-ergodic-rigidity-before-kingman" >}})
derives the ten-declaration interface, works all finite examples, and maps the
remaining theorem gap.

The
{{< refterm "integrated-log-positive-growth-rate" "integrated log-positive growth rate" >}}
entry explains the deterministic Fekete rate inherited from RMT-16.
[Integrated Log-Positive Cocycle Growth and Its Deterministic Fekete Limit]({{< relref "/knowledge-base/deep-dives/integrated-log-positive-cocycle-growth-and-fekete-limit" >}})
is the immediate asymptotic predecessor.

The
{{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}}
entry now applies the invariant-event interface to the set where one real
Birkhoff-average sequence converges. Its null-or-conull and probability
zero-one conclusions remain conditional: ergodicity cannot choose the conull
branch without a separate pointwise convergence theorem.

The
{{< refterm "finite-maximal-ergodic-inequality" "finite maximal ergodic inequality" >}}
entry demonstrates the premise separation in the other direction. Its core
integral theorem needs measure preservation and integrability, but neither
probability normalization nor ergodicity; finite total measure enters only
when a constant average threshold is subtracted.

## References

<a id="ref-ergodic-probability-mathlib-probability"></a>**Mathlib contributors.**
[Probability-measure typeclasses](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Typeclasses/Probability.html),
Mathlib 4 documentation. This official source defines
<code>IsProbabilityMeasure μ</code> by the equation \(\mu(\Omega)=1\) and
records its finite- and nonzero-measure consequences.

<a id="ref-ergodic-probability-mathlib-ergodic"></a>**Mathlib contributors.**
[Ergodic maps and measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/Ergodic.html),
Mathlib 4 documentation. This official source defines <code>PreErgodic</code>
and <code>Ergodic</code> and proves the probability zero-one bridge for
measurable strictly invariant events.

<a id="ref-ergodic-probability-mathlib-function"></a>**Mathlib contributors.**
[Functions invariant under an ergodic map](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/Function.html),
Mathlib 4 documentation. This official source proves almost-everywhere
constancy of suitably measurable almost-everywhere invariant functions.

<a id="ref-ergodic-probability-mathlib-subadditive"></a>**Mathlib contributors.**
[Subadditive and superadditive sequences](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Subadditive.html),
Mathlib 4 documentation. This official source supplies the deterministic
positive-index Fekete rate and comparison theorem used by the rate facts.

<a id="ref-ergodic-probability-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source establishes a subadditive ergodic theorem under additional
hypotheses. RMT-17 does not invoke it.

<a id="ref-ergodic-probability-furstenberg-kesten"></a>**Harry Furstenberg and Harry Kesten.**
[Products of Random Matrices](https://doi.org/10.1214/aoms/1177705909),
*The Annals of Mathematical Statistics* 31(2), 457-469, 1960. This primary
source motivates asymptotic random-matrix-product growth; none of its
samplewise conclusions is proved here.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
