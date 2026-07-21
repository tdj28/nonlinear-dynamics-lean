---
title: "Probability and Ergodic Bases in Lean: Three Gates Before Kingman"
slug: "probability-and-ergodic-base-interfaces-for-matrix-cocycles"
date: 2026-07-21
weight: -49
author: "tdj28"
summary: "A declaration-complete separation of finite-horizon integrability, probability normalization, and ergodic rigidity for one-sided matrix cocycles, including deterministic rate bounds, an honest expectation alias, zero-one events, invariant-observable constancy, and a precise account of the samplewise theorem still missing."
lead: |
  Probability and ergodicity are not two names for the same kind of randomness. Probability fixes the scale of a measure. Ergodicity says invariant measurable information is trivial up to null sets. The one-step integrability hypothesis does a third job: it makes every finite-horizon positive-log cost a genuine finite integral. RMT-17 gives each assumption its own Lean interface, then stops before any theorem could be mistaken for Kingman's subadditive ergodic theorem or a Lyapunov exponent.
key_result: |
  The finite-horizon log-positive cocycle family is now packaged as an integrable shifted-subadditive-process candidate. Its deterministic integrated rate is nonnegative, equals the infimum of all positive-horizon normalized integrals, and is bounded above by each such horizon and by the one-step integral. On a probability space, the same finite-horizon integral may be exposed as an expectation, but only alongside the explicit integrability proof. Probability plus ergodicity gives a zero-one law for strictly invariant measurable events; ergodicity alone makes almost-everywhere invariant, almost-everywhere strongly measurable real observables almost everywhere constant. None of these declarations constructs a samplewise limit.
draft: true
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Probability normalization, ergodic rigidity, integrable subadditive-process interfaces, and deterministic rate bounds"
reading_time: "95 to 135 minutes"
prerequisites:
  - "Generator-presented one-sided discrete matrix cocycles"
  - "Finite-horizon log-positive cocycle integrability"
  - "Integrated log-positive growth and deterministic Fekete convergence"
  - "Measure-preserving maps and almost-everywhere equality"
  - "Basic probability measures and measurable events"
  - "No Kingman, Birkhoff, or multiplicative ergodic theorem required"
  - "No prior Lean proof experience required"
lean_module: "NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase"
lean_source: "formalization/NonlinearDynamics/Random/RandomCocycles/ProbabilityErgodicBase.lean"
tags:
  - "Lean 4"
  - "Matrix cocycles"
  - "Probability measures"
  - "Ergodicity"
  - "Invariant events"
  - "Invariant observables"
  - "Subadditive processes"
  - "Fekete rate"
og_image: "probability-and-ergodic-base-interfaces-for-matrix-cocycles-card.png"
og_image_alt: "Warm-paper teaching card with three independent columns. Integrability leads to a process candidate and deterministic rate bounds. Probability mass one joins integrability for the guarded expectation alias and joins ergodicity for a zero-one event law. Ergodicity alone rigidifies invariant events and observables. The footer states that even all three assumptions do not by themselves produce a samplewise limit, Kingman theorem, or Lyapunov exponent."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed Research Note. Verify claims against the cited primary
sources and any released artifacts before relying on them.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This teaching chapter remains a draft while human
editorial acceptance and the separate scientific-integrity and zero-context
expert-reader reviews are pending. The checked Lean source is authoritative
for every theorem statement.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** Let \(C\) be a one-sided complex matrix cocycle over a
measure-preserving base \(T\), and let

\[
  G_k(\omega)=\log^+\lVert\Phi(k,\omega)\rVert
\]

be its finite-horizon positive logarithmic norm. The previous two milestones
proved that an explicit one-step hypothesis makes every \(G_k\) integrable,
that the raw integrals

\[
  I_k=\int_\Omega G_k\,d\mu
\]

form a subadditive sequence, and that \(I_k/k\) converges to a deterministic
Fekete rate.

RMT-17 separates the assumptions needed to interpret and extend that layer.
Integrability packages the sample-dependent family as an integrable
shifted-subadditive-process candidate and proves four facts about the existing
deterministic rate. Probability normalization adds
<code>IsProbabilityMeasure μ</code>, so the same finite-horizon integral can
honestly be named an expectation. Ergodicity adds rigidity: strictly invariant
measurable events obey a zero-one law on a probability space, while
almost-everywhere invariant, almost-everywhere strongly measurable real
observables are almost everywhere constant even without probability
normalization.

These bridges do not prove the missing asymptotic theorem. The process package
contains no samplewise limit field. The pinned Mathlib release contains no
Kingman theorem used by this project. Probability does not imply ergodicity,
ergodicity does not imply probability normalization, and neither supplies
finite-horizon integrability. Even all three together do not create a
pointwise limit, a limit-integral identity, a Lyapunov exponent, or an
Oseledets splitting.
{{< /panel >}}

This is the proof-to-prose companion for
<code>formalization/NonlinearDynamics/Random/RandomCocycles/ProbabilityErgodicBase.lean</code>.
It covers all ten source-level public declarations in exact source order. The
two fields of the opening structure are covered explicitly with that
declaration. There are no private declarations in the module.

The immediate predecessor is
[Integrated Log-Positive Growth in Lean: Subadditivity and a Deterministic Fekete Limit]({{< relref "/development-notebook/2026/07/integrated-log-positive-growth-and-deterministic-fekete-limit" >}}).
Its raw-measure integral and deterministic rate remain unchanged. Reusable
foundations include
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycle" >}},
{{< refterm "integrated-log-positive-growth-rate" "integrated log-positive growth rate" >}},
and
{{< refterm "ergodic-probability-base" "ergodic probability base" >}}.
The parallel textbook treatment is
[Probability Normalization and Ergodic Rigidity Before Kingman]({{< relref "/knowledge-base/deep-dives/probability-normalization-and-ergodic-rigidity-before-kingman" >}}).

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| First encounter | [Three gates, three jobs](#three-gates-three-jobs) | Separate analytic control, measure scale, and invariant rigidity |
| Probability route | [Mass one changes language, not the integral](#mass-one-changes-language-not-the-integral) | Understand the guarded expectation alias |
| Ergodic route | [Ergodicity is rigidity of invariant information](#ergodicity-is-rigidity-of-invariant-information) | Reach zero-one events and constant observables |
| Example route | [Four examples separate the assumptions](#four-examples-separate-the-assumptions) | Test the missing implications on explicit examples |
| Rate route | [The alternating flip cocycle](#the-alternating-flip-cocycle) | See nonmonotone normalized values and a strict one-step bound |
| Lean route | [The complete declaration map](#the-complete-declaration-map) | Audit all ten declarations in source order |
| API route | [Why the package says candidate](#why-the-package-says-candidate) | Inspect the exact two-field process interface |
| Integrity route | [Exactly what the module does not prove](#exactly-what-the-module-does-not-prove) | Block Kingman, mixing, and Lyapunov overreads |

### Learning objectives

By the summit, a reader should be able to:

1. state the distinct formal jobs of integrability, probability normalization,
   measure preservation, and ergodicity;
2. explain why <code>IsProbabilityMeasure μ</code> means the whole space has
   mass one;
3. explain why <code>Ergodic T μ</code> contains measure preservation but not
   probability normalization;
4. read the two fields of
   <code>IsIntegrableSubadditiveProcessCandidate</code> literally;
5. identify the measurability and stationarity information not stored in that
   package;
6. derive the cocycle candidate from one-step log-positive integrability;
7. prove nonnegativity of a limit from convergence of nonnegative normalized
   values;
8. read the deterministic rate as an infimum over positive horizons;
9. explain why every positive horizon is an upper bound for that infimum;
10. specialize the rate bound to the one-step raw integral;
11. distinguish an expectation alias from a normalization procedure;
12. explain why the expectation definition asks for both mass one and
    integrability;
13. apply the strict-invariance zero-one theorem to a measurable event;
14. apply the almost-everywhere constancy theorem to a real observable;
15. distinguish strict event invariance from almost-everywhere function
    invariance;
16. use finite examples to show that probability and ergodicity are
    independent assumptions;
17. explain why ergodic does not mean mixing or independent;
18. calculate the alternating two-point cocycle's first normalized values;
19. explain why a subadditive normalized sequence need not be monotone;
20. run the leaf module and compile a signature audit; and
21. state the extra theorem still needed for a samplewise limit.

### Lineage, contribution, and boundary

Mathlib defines a probability measure by the typeclass equation

\[
  \mu(\Omega)=1.
\]

Its official probability-measure typeclass page is the direct API warrant for
that interpretation ([Mathlib probability typeclasses](#ref-mathlib-probability)).
Mathlib separately defines an ergodic map as a measure-preserving map whose
strictly invariant measurable sets are almost empty or almost full
([Mathlib ergodicity](#ref-mathlib-ergodic)). The two concepts therefore enter
through different interfaces.

Kingman's original theorem concerns subadditive stochastic processes and
derives an ergodic asymptotic conclusion under substantially richer hypotheses
([Kingman, 1968](#ref-kingman)). RMT-17 does not reprove a fragment under a new
name. It prepares a small process predicate, exposes the exact upstream
zero-one and invariant-function consequences already available in Mathlib,
and records deterministic consequences of the preceding Fekete limit.

The local contribution has four parts:

* a generic two-field predicate for an integrable shifted-subadditive
  real process;
* a proof that the matrix-cocycle positive-log family satisfies it;
* a sharper API for the already proved deterministic integrated rate; and
* probability and ergodicity bridges whose assumptions advertise their
  exact semantics.

**Not claimed:**

* no almost-everywhere or pointwise convergence of \(G_k(\omega)/k\);
* no Kingman, Birkhoff, Furstenberg-Kesten, or Oseledets theorem;
* no mixing, independence, or decay of correlations;
* no signed logarithmic growth or Lyapunov exponent; and
* no conversion of an arbitrary raw measure into a probability measure.

## Three gates, three jobs

The shortest faithful mental model is a dependency table.

| Gate | Lean evidence | What it licenses | What it does not license |
|---|---|---|---|
| Finite-horizon integrability | <code>C.HasIntegrableGeneratorLogPlus</code> | genuine finite integrals, process candidate, deterministic rate facts | mass one, invariant rigidity, samplewise limit |
| Probability normalization | <code>[IsProbabilityMeasure μ]</code> | probability and expectation language | ergodicity, mixing, integrability |
| Ergodicity | <code>hErg : Ergodic C.base μ</code> | rigidity of invariant events and observables | mass one, independence, a process limit |

The cocycle itself already stores a fourth ingredient:
<code>C.base_preserving</code>. Measure preservation says that shifting the
base leaves \(\mu\) unchanged. Ergodicity includes a measure-preserving proof,
but it adds the invariant-information condition. Probability normalization
says nothing about a map. Integrability says something about a function under
a measure, not about invariant sets.

{{< reference-figure
  src="assumption-outcome-map.svg"
  alt="Integrability, probability normalization, and ergodicity feed different theorem outcomes. Integrability alone supplies a finite-time process candidate and deterministic rate facts. Probability joins integrability for an expectation alias. Probability joins ergodicity for a zero-one event law. Ergodicity alone makes invariant real observables almost everywhere constant. No path reaches a samplewise limit."
  caption="**Finding:** the three assumptions perform independent jobs and meet only where a theorem needs a pair. Integrability alone supplies the process candidate and deterministic rate facts. Probability joins integrability for the guarded expectation alias. Probability joins ergodicity for the zero-one event theorem. Ergodicity alone supplies almost-everywhere constancy of invariant real observables. The map does not claim that any combination produces independence, mixing, samplewise convergence, or a Lyapunov exponent."
>}}

{{< panel "warning" >}}
**Do not order the three gates by strength.** They constrain different objects.
A probability measure can support a nonergodic identity map. An ergodic map
can preserve a finite measure whose total mass is not one. A probability
ergodic base can still carry a nonintegrable observable. The Lean signatures
keep these possibilities visible.
{{< /panel >}}

## Mass one changes language, not the integral

The prior module deliberately named

\[
  I_k=\int_\Omega G_k\,d\mu
\]

an integrated log-positive norm. The ambient measure was arbitrary. If
\(\mu(\Omega)=2\), the integral of a constant doubles relative to its value
under the corresponding mass-one measure. Calling that raw integral an
expectation would hide the scale choice.

RMT-17 adds <code>[IsProbabilityMeasure μ]</code>. In Mathlib this typeclass is
precisely the proposition that <code>μ univ = 1</code>. It also supplies the
finite-measure infrastructure expected of a probability measure. The new
definition
<code>finiteHorizonLogPlusExpectation</code> uses the same integral expression
as <code>integratedLogPlusNorm</code>. It does not divide by total mass, call a
normalizer, or create a new measure.

The integrability proof remains a separate argument. This matters because
Mathlib's real-valued Bochner integral is totalized: a nonintegrable function
still has a formal integral value. The definition therefore asks for
<code>hC</code> even though its body does not use the proof computationally.
The unused proof parameter is an intentional public gate. It prevents the API
from using expectation language for a totalized fallback value.

The resulting equality

\[
  \operatorname{Expectation}_\mu[G_k]=I_k
\]

is reflexive in Lean. Probability normalization changes the justified
interpretation, while integrability changes the analytic status. Neither
changes the bytes of the integral expression.

## Ergodicity is rigidity of invariant information

Mathlib's <code>Ergodic T μ</code> extends two structures:

1. <code>MeasurePreserving T μ μ</code>; and
2. <code>PreErgodic T μ</code>.

The pre-ergodic component says a measurable set satisfying

\[
  T^{-1}(s)=s
\]

is almost everywhere empty or almost everywhere the whole space. On a
probability space, almost-full is equivalent to probability one, so Mathlib
exports <code>PreErgodic.prob_eq_zero_or_one</code>. Declaration 9 is a thin
cocycle-facing wrapper around exactly that theorem
([Mathlib ergodicity](#ref-mathlib-ergodic)).

Invariant functions express the same rigidity at a richer codomain. For a
real observable \(g\), RMT-17 assumes

\[
  g\circ T = g
  \quad\text{almost everywhere}
\]

and <code>AEStronglyMeasurable g μ</code>. Mathlib's ergodic function API then
produces a real constant \(c\) such that \(g=c\) almost everywhere
([Mathlib invariant functions](#ref-mathlib-ergodic-function)).

The function theorem needs no probability typeclass. Almost-everywhere
constancy is invariant under many harmless rescalings of a measure because
the null sets are unchanged. The event theorem's numerical conclusion
<code>μ s = 0 ∨ μ s = 1</code>, however, needs mass one to turn "full" into
the number one.

Ergodicity is not independence. It does not say that finite-time matrix
generators at different orbit positions are independent. It does not say
correlations decay. A periodic two-cycle can be ergodic and still fail mixing.

## Four examples separate the assumptions

Three finite spaces and one general observable example make the missing
implications visible without asymptotic machinery. These are explanatory
examples, not declarations in RMT-17.

### Probability without ergodicity

Let \(\Omega=\{0,1\}\), give each point mass \(1/2\), and take the identity
map. The measure has total mass one, and the identity preserves it. Yet the
singleton \(\{0\}\) is measurable, strictly invariant, and has probability
\(1/2\). The base is not ergodic.

This example blocks the inference

\[
  \text{probability}+\text{measure preservation}
  \Longrightarrow
  \text{ergodicity}.
\]

### Ergodicity without probability normalization

Let \(\Omega=\{\ast\}\), let the identity be the base map, and assign the
single point a finite mass \(q\) with \(q\gt0\) and \(q\ne1\). Every measurable
set is empty or full, so the identity is ergodic for this measure. The total
mass is \(q\), not one, so <code>IsProbabilityMeasure μ</code> does not hold.

This example blocks the reverse inference. It also explains why declaration
10 can omit the probability typeclass: invariant real observables on a
one-point base are constant regardless of the finite positive scale.

### Probability and ergodicity without mixing

Return to two equally weighted points, but let \(T\) swap them. The only
strictly invariant subsets are empty and full, so the flip is ergodic. It is
not mixing. For \(s=\{0\}\), the quantity

\[
  \mu\bigl(s\cap T^{-n}s\bigr)
\]

alternates between \(1/2\) and \(0\), rather than converging to
\(\mu(s)^2=1/4\).

Thus periodicity does not prevent ergodicity, and ergodicity does not imply
mixing. RMT-17 formalizes neither a mixing predicate nor a correlation limit.

### Probability and ergodicity without integrability

Take any probability ergodic base that supports an unbounded measurable real
function with an infinite positive integral. The base assumptions constrain
the measure and invariant sets, not the tails of that function. An arbitrary
observable need not be integrable merely because the system is probability
preserving and ergodic.

For the cocycle API, the repair is explicit:
<code>C.HasIntegrableGeneratorLogPlus</code>. No theorem in the module attempts
to infer it from probability or ergodicity.

## The alternating flip cocycle

The two-point flip also gives a compact stress test for the deterministic rate
API. Use one-by-one complex matrices, with generator value \(2\) at point zero
and \(1/2\) at point one. The two-step product is the identity at either
starting point because the orbit alternates the two factors.

Let \(a=\log 2\). Under the uniform probability measure,

\[
\begin{aligned}
  I_1 &= \frac{a}{2},
  &Q_1 &= \frac{a}{2},\\
  I_2 &= 0,
  &Q_2 &= 0,\\
  I_3 &= \frac{a}{2},
  &Q_3 &= \frac{a}{6},\\
  I_4 &= 0,
  &Q_4 &= 0.
\end{aligned}
\]

The even products have norm one, so their positive logarithm is zero. The odd
products reproduce whichever one-step factor appears at the starting point,
so the raw expectation is \(a/2\). The Fekete rate is zero because positive
even horizons already attain normalized value zero.

This one example checks three reading rules:

* \(Q_k\) need not be monotone: \(Q_2=0\lt Q_3=a/6\);
* every positive \(Q_k\) is still an upper bound for the rate; and
* the one-step upper bound can be strict: \(0\lt I_1=a/2\).

The example is probability preserving and ergodic. Those facts do not create
a new rate here. The deterministic Fekete rate was already available from
integrability. Ergodicity becomes relevant only when a future theorem
constructs a sample-dependent invariant limit whose constancy can then be
deduced.

{{< panel "info" >}}
**Positive logarithm remains one-sided.** The factor \(1/2\) contributes zero
to the one-step positive-log observable, not \(-\log 2\). The neutral
two-step product also contributes zero. This chapter is still studying a
positive expansion envelope, not signed logarithmic growth.
{{< /panel >}}

## The complete declaration map

The module has ten source-level public declarations. The structure fields in
declaration 1 also generate public projections, and both are included below.
The order moves from a generic process interface, through deterministic rate
facts, to probability semantics and ergodic rigidity.

| # | Lean declaration | Mathematical content | Exact assumption boundary |
|---:|---|---|---|
| 1 | <code>IsIntegrableSubadditiveProcessCandidate</code> | package all finite-horizon integrability and the shifted pointwise inequality | no measure preservation, probability, or ergodicity field |
| 2 | <code>HasIntegrableGeneratorLogPlus.isIntegrableSubadditiveProcessCandidate</code> | instantiate the package with the cocycle positive-log family | <code>hC</code> only |
| 3 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_nonneg</code> | \(0\le\gamma_+\) | <code>hC</code> only |
| 4 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_eq_sInf</code> | rate equals the infimum of positive normalized horizons | <code>hC</code> only |
| 5 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_le_normalized</code> | \(\gamma_+\le Q_k\) for \(k\ne0\) | <code>hC</code> and a positive-horizon witness |
| 6 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_le_oneStep</code> | \(\gamma_+\le I_1\) | <code>hC</code> only |
| 7 | <code>finiteHorizonLogPlusExpectation</code> | expose the finite-horizon integral as an expectation | probability typeclass plus <code>hC</code> |
| 8 | <code>finiteHorizonLogPlusExpectation_eq_integratedLogPlusNorm</code> | expectation alias equals the raw integral | probability typeclass plus <code>hC</code> |
| 9 | <code>ergodicBase_invariantEvent_prob_eq_zero_or_one</code> | measurable strict invariant event has mass zero or one | probability typeclass plus <code>hErg</code> |
| 10 | <code>ergodicBase_ae_eq_const_of_ae_invariant</code> | measurable almost-everywhere invariant real observable is almost everywhere constant | <code>hErg</code>, no probability or <code>hC</code> |

The ambient cocycle variables remain:

```lean
variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}
```

The last two declarations explicitly omit the finite matrix-index instances
because their conclusions inspect only <code>C.base</code>. The matrix
dimension, generator, and finite-horizon observables play no role in those
two wrappers.

## Declaration 1: package the finite-time process obligations

```lean
structure IsIntegrableSubadditiveProcessCandidate
    {Ω : Type uΩ} [MeasurableSpace Ω] (T : Ω → Ω) (μ : Measure Ω)
    (X : ℕ → Ω → ℝ) : Prop where
  integrable : ∀ k, Integrable (X k) μ
  add_le : ∀ m k ω, X (m + k) ω ≤ X k (T^[m] ω) + X m ω
```

The structure takes a base map \(T\), a measure \(\mu\), and a real process
\(X_k(\omega)\). It lives in <code>Prop</code>, so an inhabitant is evidence
that two obligations hold rather than data intended for computation.

The first field is the generated projection
<code>IsIntegrableSubadditiveProcessCandidate.integrable</code>. It states that
each fixed horizon \(X_k\) is integrable under \(\mu\). The quantifier is over
natural-number horizons, so time zero is included.

The second field is the generated projection
<code>IsIntegrableSubadditiveProcessCandidate.add_le</code>. It records the
shifted pointwise inequality

\[
  X_{m+k}(\omega)
  \le
  X_k(T^m\omega)+X_m(\omega).
\]

The shift is essential. The later \(k\)-block starts after \(m\) base steps.
This is the process-level statement that later becomes ordinary subadditivity
only after integration and use of measure preservation.

### Why the package says candidate

The structure is intentionally smaller than a theorem-specific Kingman
interface. It stores no proof that \(T\) preserves \(\mu\), no probability
normalization, no ergodicity, no ordinary measurability of \(T\), no separate
ordinary measurability field for \(X_k\), no stationarity theorem, and no
limit. Integrability includes almost-everywhere strong measurability of each
horizon, but the structure does not advertise a stronger pointwise
measurability contract.

Calling it a "candidate" records that it has the two finite-time properties
needed to approach a subadditive ergodic theorem. It does not claim that the
pinned library already supplies such a theorem or that these two fields would
be sufficient for every possible formulation.

The generic placement outside <code>DiscreteMatrixCocycle</code> is also
deliberate. A future non-matrix process can satisfy the same predicate. The
structure itself does not know what a norm, matrix product, or cocycle is.

## Declaration 2: instantiate the candidate with cocycle growth

```lean
theorem HasIntegrableGeneratorLogPlus.isIntegrableSubadditiveProcessCandidate
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) :
    IsIntegrableSubadditiveProcessCandidate C.base μ
      C.logPlusNormObservable where
  integrable := hC.integrable_logPlusNormObservable
  add_le := C.logPlusNormObservable_add_le
```

The theorem fills each structure field with an existing checked result.

* <code>hC.integrable_logPlusNormObservable</code> is the RMT-15 propagation
  theorem from one-step integrability to every fixed horizon.
* <code>C.logPlusNormObservable_add_le</code> is the RMT-15 shifted pointwise
  inequality derived from the ordered cocycle law and matrix-norm
  submultiplicativity.

No new analysis occurs in the constructor. Its importance is interface
alignment. A consumer can now request the generic process predicate without
reopening the matrix-cocycle proof.

The cocycle stores measure preservation in <code>C.base_preserving</code>, but
the result does not copy that proof into the candidate. Probability and
ergodicity are absent from the theorem signature. The theorem therefore says
only that the finite-time process obligations hold.

## Declaration 3: the deterministic rate is nonnegative

```lean
theorem HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_nonneg
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) :
    0 ≤ C.integratedLogPlusGrowthRate hC := by
  apply ge_of_tendsto hC.tendsto_normalizedIntegratedLogPlusNorm
  exact Filter.Eventually.of_forall C.normalizedIntegratedLogPlusNorm_nonneg
```

The previous module proved

\[
  Q_k\longrightarrow\gamma_+.
\]

It also proved \(Q_k\ge0\) for every horizon. Declaration 3 combines those
facts with <code>ge_of_tendsto</code>: a limit of an eventually nonnegative
real sequence is nonnegative.

The proof strengthens "eventually" by using
<code>Filter.Eventually.of_forall</code>. Every \(Q_k\), including the
totalized time-zero value, is nonnegative. The limit theorem comes from
<code>hC.tendsto_normalizedIntegratedLogPlusNorm</code>.

This argument concerns a deterministic sequence of real integrals. It needs
the integrability proof that supports the preceding Fekete theorem. It needs
neither mass one nor ergodicity. Nonnegativity is also a consequence of using
the positive logarithm; it would not hold for a signed logarithmic growth
rate in general.

## Declaration 4: expose the positive-horizon infimum

```lean
theorem HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_eq_sInf
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) :
    C.integratedLogPlusGrowthRate hC =
      sInf (C.normalizedIntegratedLogPlusNorm '' Ici 1) := by
  rw [integratedLogPlusGrowthRate, Subadditive.lim]
  rfl
```

Mathlib defines <code>Subadditive.lim</code> as the infimum of the normalized
values over <code>Set.Ici 1</code>, the natural horizons at least one
([Mathlib subadditive sequences](#ref-mathlib-subadditive)). The project rate
is that library definition applied to the integrated sequence.

After rewriting both definitions, the theorem is reflexive. Its mathematical
content is still worth exporting because users should not have to unfold the
library implementation to learn what the rate means:

\[
  \gamma_+
  {} =
  \inf_{k\ge1} Q_k.
\]

Time zero is excluded. The infimum need not be attained, although the
alternating flip example happens to attain it at every positive even horizon.
The theorem does not say \(Q_k\) is decreasing. It only identifies the limit
with the greatest lower bound of all positive-horizon normalized values.

## Declaration 5: every positive horizon bounds the rate

```lean
theorem HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_le_normalized
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) {k : ℕ} (hk : k ≠ 0) :
    C.integratedLogPlusGrowthRate hC ≤
      C.normalizedIntegratedLogPlusNorm k := by
  simpa [integratedLogPlusGrowthRate, normalizedIntegratedLogPlusNorm] using
    hC.subadditive_integratedLogPlusNorm.lim_le_div
      C.bddBelow_normalizedIntegratedLogPlusNorm hk
```

For a natural number, <code>k ≠ 0</code> is the proof-relevant way to say the
horizon is positive. Mathlib's <code>Subadditive.lim_le_div</code> says the
subadditive limit lies below \(I_k/k\) at every nonzero horizon. The call needs
three ingredients:

1. the integrability-backed proof that \(I\) is subadditive;
2. the prior theorem that the normalized range is bounded below; and
3. the witness <code>hk</code> excluding division at time zero.

The <code>simpa</code> step unfolds the project names and aligns the library
ratio with <code>normalizedIntegratedLogPlusNorm</code>.

The conclusion is an upper bound on the asymptotic deterministic rate. It is
not a convergence-rate estimate. It does not quantify how close \(Q_k\) is to
\(\gamma_+\), and a poor finite horizon may be a very loose upper bound.

## Declaration 6: specialize the bound to one step

```lean
theorem HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_le_oneStep
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) :
    C.integratedLogPlusGrowthRate hC ≤ C.integratedLogPlusNorm 1 := by
  simpa [normalizedIntegratedLogPlusNorm] using
    hC.integratedLogPlusGrowthRate_le_normalized (k := 1) one_ne_zero
```

Declaration 6 calls declaration 5 at \(k=1\). The denominator simplifies to
one, so \(Q_1=I_1\). This yields

\[
  \gamma_+\le I_1.
\]

The bound is often convenient because the hypothesis itself is stated at one
step and because the one-step integral may be easier to estimate. It can be
strict, as the alternating flip cocycle demonstrates.

The theorem still uses a raw-measure integral. Without probability
normalization, \(I_1\) is not an expectation. The theorem is invariant under
none of the semantic relabeling introduced later; it simply records the
deterministic inequality already supported by <code>hC</code>.

## Declaration 7: expose a guarded expectation

```lean
def finiteHorizonLogPlusExpectation [IsProbabilityMeasure μ]
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (_hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) : ℝ :=
  ∫ ω, C.logPlusNormObservable k ω ∂μ
```

The definition introduces the first probability-specific name in the module.
Its two gates are visible:

* <code>[IsProbabilityMeasure μ]</code> establishes \(\mu(\Omega)=1\);
* <code>_hC</code> establishes integrability of every finite-horizon
  observable, including the requested horizon \(k\).

The leading underscore acknowledges that the proof is not used in the
definition body. It remains part of the type so a caller cannot obtain an
"expectation" value without presenting the analytic evidence. Proof
irrelevance ensures that different proofs of the same integrability
proposition do not create mathematically different expectations.

The body is an ordinary integral rather than special notation. The module
does not import an expectation-notation layer. This keeps the dependency small
and the equality with the raw integral transparent.

At time zero, the observable is zero, so the expectation is zero. For every
positive horizon it is the expected positive-log norm of the finite cocycle
product. It is not the expectation of a samplewise limit, and it does not
assert that a limit and expectation can be exchanged.

## Declaration 8: the expectation alias is the raw integral

```lean
@[simp] theorem finiteHorizonLogPlusExpectation_eq_integratedLogPlusNorm
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) :
    C.finiteHorizonLogPlusExpectation hC k = C.integratedLogPlusNorm k := by
  rfl
```

Both sides unfold to the same integral, so the proof is <code>rfl</code>. The
<code>@[simp]</code> attribute lets downstream proofs erase the semantic alias
when the raw integrated API is more convenient.

This theorem is not a normalization identity. No factor involving
\(\mu(\Omega)\) appears because the left side can only be formed after Lean has
already accepted mass one. If a caller starts with a finite measure of mass
two, the repair is not to apply this theorem. The caller must deliberately
construct or select a probability measure, then prove the cocycle assumptions
for that measure.

The equality also explains why the deterministic rate did not need to be
redefined. Under probability normalization, every \(I_k\) already is the
corresponding finite-horizon expectation. The previous rate can therefore be
interpreted as the limit of normalized expectations without changing its Lean
definition. That statement remains a limit of expectations, not an
expectation of a samplewise limit.

## Declaration 9: strictly invariant events have probability zero or one

```lean
omit [Fintype ι] [DecidableEq ι] in
theorem ergodicBase_invariantEvent_prob_eq_zero_or_one
    [IsProbabilityMeasure μ]
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (hErg : Ergodic C.base μ) {s : Set Ω}
    (hs : MeasurableSet s) (hinv : C.base ⁻¹' s = s) :
    μ s = 0 ∨ μ s = 1 :=
  hErg.toPreErgodic.prob_eq_zero_or_one hs hinv
```

The theorem takes a measurable event \(s\) and strict invariance under one
base step. The conclusion is a disjunction in the extended nonnegative real
measure values: the event has probability zero or probability one.

The proof delegates directly to Mathlib. From <code>hErg</code> it projects
<code>toPreErgodic</code>, then applies
<code>PreErgodic.prob_eq_zero_or_one</code> with the measurability and
invariance proofs. The probability typeclass converts the "almost full"
alternative into numerical mass one.

Three boundaries deserve attention.

First, <code>hs</code> is required. The wrapper does not make a statement about
arbitrary nonmeasurable subsets. Second, <code>hinv</code> is literal set
equality, not almost-everywhere equality. Mathlib has richer related APIs, but
this wrapper chooses the smallest strict form needed now. Third,
<code>hErg</code> is an ordinary proof argument rather than a typeclass. A
caller chooses and supplies the ergodicity theorem explicitly.

The <code>omit</code> command proves that finite matrix indexing is irrelevant.
The cocycle serves only as a typed route to its base map. No generator,
product, norm, or integrability hypothesis appears in the proof.

## Declaration 10: invariant real observables are almost everywhere constant

```lean
omit [Fintype ι] [DecidableEq ι] in
theorem ergodicBase_ae_eq_const_of_ae_invariant
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (hErg : Ergodic C.base μ) {g : Ω → ℝ}
    (hg : AEStronglyMeasurable g μ)
    (hinv : g ∘ C.base =ᵐ[μ] g) :
    ∃ c : ℝ, g =ᵐ[μ] Function.const Ω c :=
  hErg.ae_eq_const_of_ae_eq_comp_ae hg hinv
```

The theorem moves from events to real observables. Its invariance premise is
oriented exactly as Mathlib expects:

\[
  g\circ T = g
  \quad\mu\text{-almost everywhere}.
\]

The output provides a real number \(c\) and an almost-everywhere equality
between \(g\) and the constant function with value \(c\).

The proof is again a direct wrapper, this time around
<code>Ergodic.ae_eq_const_of_ae_eq_comp_ae</code>. The official Mathlib page
states the general principle for almost-everywhere strongly measurable maps
into metrizable spaces; RMT-17 specializes the codomain to the real numbers
([Mathlib invariant functions](#ref-mathlib-ergodic-function)).

No probability typeclass occurs. Ergodicity already supplies the qualitative
almost-everywhere rigidity needed for constancy. Without mass one, the module
cannot turn an almost-full invariant event into the numerical conclusion
<code>μ s = 1</code>, but it can still say that an invariant real observable
has only one value outside a null set.

The theorem does not compute \(c\), identify it with an integral, or say that
\(g\) arose as a limit. A future Kingman theorem might produce an invariant
limit function and then call this result to prove that the limit is constant
under ergodicity. RMT-17 constructs only the rigidity bridge, not that future
limit.

## Proof dependency architecture

The ten declarations form three branches rather than one ladder:

```text
RMT-15 one-step integrability
  |
  +--> all finite horizons integrable
  |       |
  |       +--> integrable shifted-subadditive-process candidate
  |
  +--> RMT-16 deterministic Fekete convergence
          |
          +--> nonnegative rate
          +--> positive-horizon infimum description
          +--> every positive normalized horizon is an upper bound
                    |
                    +--> one-step raw integral is an upper bound

probability normalization + finite-horizon integrability
  |
  +--> guarded finite-horizon expectation alias
          |
          +--> reflexive equality with the raw integral

probability normalization + ergodicity
  |
  +--> strict invariant measurable event has probability zero or one

ergodicity alone
  |
  +--> almost-everywhere invariant measurable real observable
       is almost everywhere constant
```

The branches share vocabulary but not hidden proofs. In particular, the rate
facts do not use <code>hErg</code>, and the ergodic wrappers do not use
<code>hC</code>. This separation makes a future theorem's obligations easy to
audit: if a samplewise result needs all three gates, its signature must bring
all three together explicitly.

## The assumption matrix

The following table is useful when reading a downstream goal. A check mark
means the declaration requires the item directly or through its named input.

| Declaration family | Integrability | Probability mass one | Ergodicity | Strict event invariance | Almost-everywhere function invariance |
|---|:---:|:---:|:---:|:---:|:---:|
| Process candidate constructor | ✓ |  |  |  |  |
| Deterministic rate facts | ✓ |  |  |  |  |
| Finite-horizon expectation alias | ✓ | ✓ |  |  |  |
| Invariant-event zero-one law |  | ✓ | ✓ | ✓ |  |
| Invariant-observable constancy |  |  | ✓ |  | ✓ |

Measure preservation is stored by <code>DiscreteMatrixCocycle</code> and is
also contained in <code>Ergodic</code>. The candidate structure itself does
not store it. Event measurability and almost-everywhere strong measurability
are additional row-specific premises, not consequences of the checked boxes.

## Run and audit the Lean module

The project pins Lean and the documented
[Mathlib 4.32.0 release](#ref-mathlib-release). Run these commands from the
repository root. The first command loads the Elan-installed toolchain on
macOS or Linux when Elan used its default location.

```sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true NonlinearDynamics/Random/RandomCocycles/ProbabilityErgodicBase.lean
lake build NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase
lake build NonlinearDynamics.Random.RandomCocycles
lake build NonlinearDynamics.Random
lake build NonlinearDynamics
```

The direct Lean invocation checks the leaf file while promoting every warning
to an error. The named builds then verify the public import chain through the
random-cocycle aggregator, the random-dynamics aggregator, and the project
root.

For a signature-only audit, remain in <code>formalization/</code>, create a
temporary file, and compile it exactly as follows:

```sh
tee /tmp/RMT17Smoke.lean >/dev/null <<'LEAN'
import NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase

open MeasureTheory Set Filter

#check NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate
#check NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.integrable
#check NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.add_le
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.isIntegrableSubadditiveProcessCandidate
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_nonneg
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_eq_sInf
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_le_normalized
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_le_oneStep
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.finiteHorizonLogPlusExpectation
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.finiteHorizonLogPlusExpectation_eq_integratedLogPlusNorm
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.ergodicBase_invariantEvent_prob_eq_zero_or_one
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.ergodicBase_ae_eq_const_of_ae_invariant
LEAN

lake env lean -DwarningAsError=true /tmp/RMT17Smoke.lean
```

The twelve <code>#check</code> commands include the ten source-level
declarations and the two generated structure projections. Success prints
their inferred signatures and no diagnostics.

For an axiom audit of the eight theorem declarations, append these commands to
the same temporary file before compiling:

```lean
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.isIntegrableSubadditiveProcessCandidate
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_nonneg
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_eq_sInf
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_le_normalized
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_le_oneStep
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.finiteHorizonLogPlusExpectation_eq_integratedLogPlusNorm
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.ergodicBase_invariantEvent_prob_eq_zero_or_one
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.ergodicBase_ae_eq_const_of_ae_invariant
```

The expected output may mention standard foundational principles used by
Mathlib. It must not reveal <code>sorryAx</code> or a project-specific axiom.
The two definitions and the structure are inspected by unfolding and
signature checking rather than by <code>#print axioms</code>.

## Failure modes worth learning

| Tempting move | Why it fails | Checked repair |
|---|---|---|
| Treat probability as a dynamical property | Mass one constrains the measure, not the map | Supply <code>hErg : Ergodic C.base μ</code> separately |
| Infer probability from ergodicity | <code>Ergodic</code> contains preservation and pre-ergodicity, not total mass one | Add <code>[IsProbabilityMeasure μ]</code> where a numerical probability conclusion needs it |
| Infer integrability from probability and ergodicity | Tail control is independent of invariant-set rigidity | Carry <code>C.HasIntegrableGeneratorLogPlus</code> explicitly |
| Call every raw integral an expectation | An arbitrary measure may have any total mass | Use <code>finiteHorizonLogPlusExpectation</code> only under the mass-one typeclass |
| Remove <code>_hC</code> because the definition body ignores it | Mathlib's integral is totalized outside the integrable case | Keep the proof as a semantic and analytic gate |
| Read the process candidate as a Kingman theorem | It stores only finite-time integrability and a shifted inequality | Treat it as input infrastructure for a future theorem |
| Add measure preservation to the candidate by assumption | The generic package deliberately separates process properties from base dynamics | Obtain preservation from the cocycle or a future theorem-specific wrapper |
| Use the rate bound at time zero | The Fekete infimum and division theorem use positive horizons | Supply <code>hk : k ≠ 0</code> |
| Infer monotonicity from subadditivity | Normalized ratios can rise after falling | Claim an infimum and convergence, not stepwise decrease |
| Call ergodicity independence | An ergodic periodic flip has deterministic dependence across time | State only invariant-information rigidity |
| Call ergodicity mixing | Ergodicity does not force correlation limits | Introduce and prove a separate mixing interface if needed |
| Drop event measurability | The zero-one theorem is about measurable events | Supply <code>hs : MeasurableSet s</code> |
| Replace strict event invariance by almost invariance silently | Declaration 9 takes literal preimage equality | Use the exact wrapper or choose a verified stronger upstream theorem explicitly |
| Replace a.e. function invariance by pointwise invariance in the statement | Declaration 10 is intentionally null-set stable | Provide the a.e. equality in the orientation <code>g ∘ C.base =ᵐ[μ] g</code> |
| Identify the constant with an integral | The theorem exports only existence of an a.e. constant | Prove any formula for that constant separately |
| Apply constancy to a limit that has not been constructed | Rigidity cannot manufacture its own invariant observable | First prove existence, measurability, and invariance of the candidate limit |
| Call the deterministic integrated rate a Lyapunov exponent | It clips negative logarithmic growth and takes a limit after integration | Keep the descriptive positive-log integrated rate name |

### A typeclass failure to recognize

Suppose Lean reports that it cannot synthesize
<code>IsProbabilityMeasure μ</code> when calling the expectation definition or
the zero-one event theorem. A proof that <code>μ</code> is finite is not enough.
A proof that the base preserves <code>μ</code> is not enough. A proof of
<code>Ergodic C.base μ</code> is not enough. The missing goal is specifically
that the total mass equals one.

The successful repair is to construct or invoke the precise probability
instance for the chosen measure. Do not insert an unsafe local instance unless
the mass-one proof is available. The typeclass error is exposing a genuine
normalization gap.

### An invariance-orientation failure to recognize

Declaration 10 expects

```lean
hinv : g ∘ C.base =ᵐ[μ] g
```

A hypothesis written in the reverse orientation is mathematically equivalent
because almost-everywhere equality is symmetric, but Lean will not always use
that symmetry automatically in the intended argument position. Apply
<code>hinv.symm</code> when needed. A hypothesis about
<code>g (C.base ω) = g ω</code> for every point can be promoted to an
almost-everywhere equality, but that conversion should be explicit.

## Boundary cases

### Zero measure

The zero measure cannot satisfy <code>IsProbabilityMeasure</code> because the
whole space has mass zero rather than one. Mathlib can nevertheless regard a
measurable map as ergodic for the zero measure: every statement holds almost
everywhere vacuously. Declaration 10 then says every suitable real observable
is almost everywhere constant, also vacuously.

This edge case is a useful warning. Almost-everywhere constancy is a statement
relative to a measure. Without nonzero or probability normalization, it need
not identify observable values at any actual point.

### Finite nonunit mass

Multiplying a finite ergodic measure by a strictly positive finite scalar
preserves its null sets and qualitative ergodicity in the usual setting, but
changes the total mass. Declaration 10 remains the right qualitative tool.
Declaration 9 is unavailable until a mass-one instance is provided, because
"full measure" would numerically mean the new total mass rather than one.

RMT-17 exports no general scalar-rescaling theorem. The point is the signature
boundary, not a new formal law about scaled measures.

### Empty matrix dimension

The rate branch permits an empty finite matrix index type. Earlier project
conventions make the relevant log-positive norm observables zero in that
dimension, so the deterministic rate facts remain valid.

Declarations 9 and 10 go further: they use <code>omit [Fintype ι]
[DecidableEq ι]</code>. Their proofs do not inspect matrix coordinates at all.
They are base-dynamics theorems presented in a cocycle namespace.

### Time zero

The process candidate includes integrability and the shifted inequality at
time zero. The expectation alias can also be formed at time zero and equals
zero. The rate upper-bound theorem deliberately rejects time zero with
<code>k ≠ 0</code> because the Fekete ratio is a positive-horizon concept.

### Periodic ergodic bases

The two-point flip is both periodic and ergodic under the uniform measure. Its
invariant real observables are constant on the entire two-cycle, but its
time-separated events oscillate. This is the cleanest finite warning that
ergodicity does not imply mixing.

### Strictly invariant events versus almost-invariant functions

Declaration 9 accepts <code>C.base ⁻¹' s = s</code>. Declaration 10 accepts an
almost-everywhere equality. This is not an inconsistency. They wrap different
upstream theorems with different convenient interfaces. Downstream code must
not silently transfer one equality notion to the other.

### Nonunique constants under degenerate measures

Declaration 10 returns an existential constant. Under the zero measure, every
constant satisfies the conclusion because all functions are almost everywhere
equal. On a nonzero measure, additional reasoning can often show uniqueness,
but RMT-17 neither needs nor exports such a theorem.

## Physical interpretation and the missing asymptotic bridge

In smooth dynamics, a derivative cocycle transports tangent perturbations
along an orbit. In random matrix products, a cocycle transports vectors through
a sequence of random linear maps. Integrability of positive logarithmic norm
is a familiar upper-tail hypothesis in both traditions. Furstenberg and
Kesten's original random-matrix product work studies normalized logarithmic
growth under probabilistic assumptions
([Furstenberg and Kesten, 1960](#ref-furstenberg-kesten)). Oseledets' theorem
organizes Lyapunov exponents and invariant splittings under a multiplicative
ergodic framework ([Oseledets, 1968](#ref-oseledets)).

RMT-17 formalizes neither physical bridge. The generator remains an arbitrary
measurable complex matrix field. There is no nonlinear map with a derivative,
no tangent bundle, no chain rule, no singular-value filtration, and no
exterior-power construction.

The ergodic constancy theorem explains one future proof pattern. If a genuine
subadditive ergodic theorem constructs a real samplewise limit \(g(\omega)\),
and if that limit is almost-everywhere strongly measurable and invariant, then
declaration 10 can make it almost everywhere constant under ergodicity. Every
"if" in that sentence names work not done here. Constancy is the final
rigidity step, not the existence theorem.

The positive logarithm is another independent boundary. Even a successful
samplewise theorem for \(G_k/k\) would yield a positive-growth envelope. It
would not automatically become the signed top Lyapunov exponent, because
strict contraction and singular collapse have already been clipped to zero.

## Exactly what the module does not prove

RMT-17 does not prove any of the following:

* probability normalization from finite measure, measure preservation, or
  ergodicity;
* ergodicity from probability normalization or measure preservation;
* integrability from probability, ergodicity, bounded measure, or finite
  matrix dimension;
* a canonical normalization of an arbitrary raw measure;
* expectation notation or a new numerical expectation operator;
* a samplewise limit of \(G_k(\omega)/k\);
* almost-everywhere convergence of a subadditive process;
* convergence in probability, in measure, or in \(L^1\);
* an exchange between a limit and an integral;
* identification of an expected samplewise limit with the deterministic
  integrated Fekete rate;
* Kingman's subadditive ergodic theorem;
* Birkhoff's pointwise ergodic theorem;
* the Furstenberg-Kesten theorem;
* a Lyapunov exponent or Lyapunov spectrum;
* an Oseledets filtration or splitting;
* mixing, weak mixing, strong mixing, exactness, or decay of correlations;
* independence or identical distribution of generator values along an orbit;
* monotonicity of the normalized integrated sequence;
* a quantitative convergence rate;
* attainment of the positive-horizon infimum;
* a zero-one law for arbitrary nonmeasurable sets;
* a zero-one wrapper for merely almost-invariant events;
* a formula for the constant in declaration 10;
* uniqueness of that constant under every permitted measure;
* ordinary pointwise constancy of an almost-everywhere invariant observable;
* a nonlinear derivative cocycle or tangent-dynamics interpretation; or
* entropy, stability, bifurcation, sensitivity, or chaos.

The module does prove useful bridges. Its restraint is part of their value:
each name and signature says which conclusion is now earned and which theorem
must still be built.

## Exercises with solutions

### Exercise 1: classify the gates

Which assumption licenses expectation language, and which assumption makes
invariant measurable information rigid?

**Solution.** <code>[IsProbabilityMeasure μ]</code> licenses probability and
expectation language by asserting mass one. <code>Ergodic C.base μ</code>
makes invariant measurable events and observables rigid. Integrability is a
third gate that makes the finite-horizon integral analytically meaningful.

### Exercise 2: inspect the candidate

Does <code>IsIntegrableSubadditiveProcessCandidate T μ X</code> imply that
\(T\) preserves \(\mu\)?

**Solution.** No. Its fields state only that every \(X_k\) is integrable and
that the shifted pointwise subadditive inequality holds. Measure preservation
must come from the cocycle or a separate theorem-specific hypothesis.

### Exercise 3: locate the shift

Why does the process inequality contain \(X_k(T^m\omega)\) rather than
\(X_k(\omega)\)?

**Solution.** The later \(k\)-step block begins after the first \(m\) base
steps. The shift is part of the one-sided cocycle law. It can disappear after
integration under a measure-preserving map, but not pointwise in general.

### Exercise 4: challenge the probability implication

Why is the identity on two equally weighted points not ergodic?

**Solution.** Either singleton is measurable, strictly invariant under the
identity, and has probability \(1/2\). An ergodic probability base would force
such an event to have probability zero or one.

### Exercise 5: challenge the reverse implication

Can an identity map be ergodic when the total mass is not one?

**Solution.** Yes, on a one-point space. Every measurable set is empty or
full, so the map is ergodic for any chosen measure. If the single point has a
finite positive mass other than one, the measure is not a probability measure.

### Exercise 6: separate ergodicity from mixing

Why is the uniform two-point flip ergodic but not mixing?

**Solution.** Only the empty set and whole space are strictly invariant, so it
is ergodic. A singleton returns to itself at even times and swaps to the other
singleton at odd times, so its self-intersection probability oscillates rather
than converging to the product of probabilities.

### Exercise 7: read the nonnegative limit proof

Which two facts does declaration 3 combine?

**Solution.** Every normalized integrated value \(Q_k\) is nonnegative, and
the sequence \(Q_k\) converges to the deterministic integrated rate. A limit
of an eventually nonnegative real sequence is nonnegative.

### Exercise 8: interpret the infimum

Does declaration 4 say some finite horizon realizes the rate?

**Solution.** No. It identifies the rate with an infimum over positive
horizons. An infimum need not be attained, although special examples may
attain it.

### Exercise 9: reject monotonicity

In the alternating flip example, which values disprove monotonic decrease of
\(Q_k\)?

**Solution.** \(Q_2=0\) while \(Q_3=(\log 2)/6\), so the normalized sequence
rises from time two to time three. Subadditivity still yields convergence to
the infimum.

### Exercise 10: inspect the one-step bound

Why can declaration 6 be strict?

**Solution.** One-step positive-log expansion may be canceled by later
contracting factors in the matrix product. In the alternating flip example,
the one-step integral is \((\log 2)/2\), while every even product is neutral
and the deterministic rate is zero.

### Exercise 11: explain the unused proof parameter

Why does <code>finiteHorizonLogPlusExpectation</code> accept
<code>_hC</code> if its body is just an integral?

**Solution.** Mathlib's real integral is a total function and returns a formal
value even outside the integrable case. The proof parameter makes the
expectation name available only when the finite-horizon observable has a
genuine finite integral.

### Exercise 12: compare the two event equalities

What equality does declaration 9 require, and what equality does declaration
10 require?

**Solution.** Declaration 9 requires strict set equality
<code>C.base ⁻¹' s = s</code>. Declaration 10 requires almost-everywhere
function equality <code>g ∘ C.base =ᵐ[μ] g</code>.

### Exercise 13: remove an irrelevant assumption

Why can declarations 9 and 10 omit <code>Fintype ι</code> and
<code>DecidableEq ι</code>?

**Solution.** Their proofs use only the cocycle's base map and an ergodicity
proof. No matrix coordinate, product, norm, or finite sum appears.

### Exercise 14: interpret the constant

Does declaration 10 show that the constant is the expectation of \(g\)?

**Solution.** No. It proves only existence of a real \(c\) with
\(g=c\) almost everywhere. A formula involving an integral would require
additional hypotheses and a separate proof.

### Exercise 15: place the future Kingman theorem

If a future theorem produces an almost-everywhere invariant samplewise limit,
which RMT-17 declaration could make that limit deterministic under ergodicity?

**Solution.** Declaration 10, once the future limit is shown to be
almost-everywhere strongly measurable and invariant in the required
orientation. Declaration 10 cannot produce the limit itself.

### Exercise 16: inspect the zero measure

Why is declaration 10 potentially vacuous for \(\mu=0\)?

**Solution.** Under the zero measure, every pointwise exception lies in a null
set, so any two functions are almost everywhere equal. The theorem remains
formally true but need not constrain values at any point.

### Exercise 17: compare two asymptotic objects

What is the difference between
\(\lim_k \int G_k/k\,d\mu\) and
\(\int \lim_k G_k/k\,d\mu\)?

**Solution.** The first is a limit of real numbers after each horizon is
integrated. RMT-16 proves that kind of deterministic limit. The second assumes
a samplewise limit exists and then integrates it. RMT-17 proves neither that
existence nor an interchange between the two operations.

### Exercise 18: reject the Lyapunov label

Why would even a samplewise limit of \(G_k/k\) not automatically be a signed
Lyapunov exponent?

**Solution.** \(G_k\) uses the positive logarithm. Norms below one, including
strict contraction and zero products, all contribute zero rather than a
negative logarithm. The observable has already discarded the information a
signed exponent would need.

## The next ridge

The prerequisite interfaces are now explicit. The next samplewise step must
either formalize a genuine subadditive ergodic theorem or deliberately leave
this branch and advance another dependency-ordered part of the nonlinear
dynamics roadmap. Another alias or assumption package would not substitute for
the missing theorem.

A Kingman-style formalization must first choose an exact statement. Versions
differ in their indexing conventions, integrability hypotheses, invariant
sigma-algebra conclusions, finite versus extended-real limits, and whether
ergodicity is assumed at the theorem or used later to prove constancy. The
chosen statement must match the project's shifted inequality without silently
reversing time or product order.

At minimum, the proof path must keep these objects distinct:

1. the sample process \(X_k(\omega)\);
2. its normalized sample values \(X_k(\omega)/k\);
3. any almost-everywhere limit function;
4. the integral of that limit, when defined;
5. the deterministic Fekete rate of the integrated sequence; and
6. a constant value supplied by ergodicity, if the limit is invariant.

Only a checked theorem can connect those rows. Probability sets the unit of
measure. Ergodicity controls invariant information. Integrability controls
finite-horizon analytic legitimacy. None of the three is a synonym for the
missing connection.

For a true Lyapunov theorem, the observable layer must also change. Signed or
extended logarithmic growth, singular values, exterior powers, negative-tail
control, and possibly invertibility must be selected before an Oseledets-style
claim can be stated honestly.

RMT-17 therefore completes the interface audit before the difficult theorem.
The project now knows exactly which assumptions perform which jobs, which
upstream Mathlib results can be reused, and where the proof gap actually
begins.

## References

The links below were checked on 2026-07-21. The pinned local Mathlib 4.32.0
checkout remains the exact API authority for the Lean declarations.

<a id="ref-mathlib-release"></a>
**Mathlib contributors.**
[Mathlib 4.32.0 release](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
2026. This is the dependency release selected by
<code>formalization/lakefile.toml</code>.

<a id="ref-mathlib-probability"></a>
**Mathlib contributors.**
[Probability-measure typeclasses](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Typeclasses/Probability.html),
Mathlib 4 documentation. This official page defines
<code>IsProbabilityMeasure μ</code> by <code>μ univ = 1</code> and documents
the surrounding finite and probability measure instances.

<a id="ref-mathlib-ergodic"></a>
**Mathlib contributors.**
[Ergodic maps and measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/Ergodic.html),
Mathlib 4 documentation. This official page defines <code>PreErgodic</code>
and <code>Ergodic</code> and exposes
<code>PreErgodic.prob_eq_zero_or_one</code>, the upstream theorem used by
declaration 9.

<a id="ref-mathlib-ergodic-function"></a>
**Mathlib contributors.**
[Functions invariant under an ergodic map](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/Function.html),
Mathlib 4 documentation. This official page states the almost-everywhere
constancy theorem used directly by declaration 10.

<a id="ref-mathlib-subadditive"></a>
**Mathlib contributors.**
[Subadditive sequences](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Subadditive.html),
Mathlib 4 documentation. This official page defines
<code>Subadditive.lim</code>, its positive-index infimum, and the
<code>lim_le_div</code> bound used in declarations 4 through 6.

<a id="ref-kingman"></a>
**J. F. C. Kingman.**
["The Ergodic Theory of Subadditive Stochastic Processes"](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
<em>Journal of the Royal Statistical Society: Series B</em> 30(3), 499-510,
1968. This primary source is cited for the sample-dependent subadditive
ergodic theorem that motivates the process candidate. RMT-17 does not
formalize that theorem.

<a id="ref-furstenberg-kesten"></a>
**Harry Furstenberg and Harry Kesten.**
["Products of Random Matrices"](https://doi.org/10.1214/aoms/1177705909),
<em>The Annals of Mathematical Statistics</em> 31(2), 457-469, 1960. This
original paper provides historical context for normalized logarithmic growth
of random matrix products. Its probabilistic limit theorem is not formalized
here.

<a id="ref-oseledets"></a>
**V. I. Oseledets.**
["A multiplicative ergodic theorem. Characteristic Ljapunov exponents of dynamical systems"](https://www.mathnet.ru/eng/mmo214),
<em>Transactions of the Moscow Mathematical Society</em> 19, 197-231, 1968.
This primary source provides the multiplicative-ergodic context for Lyapunov
exponents and invariant splittings. RMT-17 proves neither.
