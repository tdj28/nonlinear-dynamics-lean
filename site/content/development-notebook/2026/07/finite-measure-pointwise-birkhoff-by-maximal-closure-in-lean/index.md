---
title: "The Missing Step Closes: Pointwise Birkhoff by Maximal Control in Lean"
slug: "finite-measure-pointwise-birkhoff-by-maximal-closure-in-lean"
date: 2026-07-21
weight: -60
author: "tdj28"
summary: "Random-matrix-theory milestone 26 (RMT-26) combines an absolute weak maximal estimate with an L¹-dense core of fixed observables and simple Koopman coboundaries to prove full-sequence almost-everywhere convergence of real Birkhoff averages on every finite measure-preserving system. The theorem needs neither probability normalization nor ergodicity and deliberately does not identify the limit."
lead: |
  A dense family of easy observables is not enough for a pointwise theorem. A nearby function can differ by a small integral while producing a large orbit average on a small set of initial states. The missing ingredient is quantitative stability: a weak maximal estimate says exactly how small that dangerous set must be. Random-matrix-theory milestone 26 (RMT-26) makes this closure argument executable in Lean. It defines fixed-scale Cauchy-failure events, confines each one to an absolute maximal-error event plus the approximant's null bad set, drives its measure to zero by L¹ density, and intersects a countable family of reciprocal scales. Finite measure then transfers the RMT-25 square-integrable good core into a dense integrable core. The result is the first full-sequence pointwise ergodic theorem in this repository.
key_result: |
  Let a measurable map T preserve a finite measure μ, and let f be a real integrable observable. Then for μ-almost every initial state ω there is a real number c(ω) such that the complete sequence of Birkhoff averages Aₙf(ω) converges to c(ω). No probability normalization, ergodicity, injectivity, surjectivity, or invertibility is assumed. The checked theorem proves convergence-event membership only. It does not yet identify c with a conditional expectation, prove that c is constant on an ergodic probability space, establish L¹-norm convergence, or reach Kingman's subadditive theorem.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Real L¹ and L² spaces, weak maximal estimates, Cauchy exceptional events, dense-good-function closure, almost-everywhere representatives, finite-measure Hölder inclusion, countable conull intersections, and Lean proof architecture"
reading_time: "165 to 250 minutes"
prerequisites:
  - "Finite Birkhoff sums and averages"
  - "Measure-preserving maps and almost-everywhere equality"
  - "The RMT-24 infinite weak maximal estimate"
  - "The RMT-25 fixed-plus-simple-coboundary pointwise-good core"
  - "Metric Cauchy sequences and completeness of the real numbers"
  - "No prior pointwise ergodic theorem or Lean experience required"
lean_module: "NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoff"
lean_source: "formalization/NonlinearDynamics/Random/RandomCocycles/PointwiseBirkhoff.lean"
tags:
  - "Lean 4"
  - "Pointwise ergodic theorem"
  - "Birkhoff averages"
  - "Maximal inequality"
  - "Weak type (1,1)"
  - "L1 density"
  - "Cauchy exceptional set"
  - "Boundary cases"
og_image: "finite-measure-pointwise-birkhoff-by-maximal-closure-in-lean-card.png"
og_image_alt: "Warm-paper teaching card showing an L1 observable approximated by a dense pointwise-good core, an absolute maximal estimate shrinking every fixed Cauchy-failure event to measure zero, and reciprocal thresholds joining into full-sequence almost-everywhere convergence."
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
**Editorial status.** This declaration-complete teaching chapter is published
as an open working note while human editorial acceptance and the separate
scientific-integrity
and zero-context expert-reader reviews are pending. The warning-fatal checked
Lean source is authoritative for every theorem statement and assumption.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** For a map \(T:\Omega\to\Omega\), a real observable
\(f:\Omega\to\mathbb R\), and a positive integer \(n\), write

\[
A_nf(\omega)=\frac1n\sum_{j=0}^{n-1}f(T^j\omega).
\]

RMT-24 proved the one-sided positive-part maximal estimate. RMT-26 first
derives \(\lvert A_nh\rvert\le A_n\lvert h\rvert\) and then obtains its
absolute event-level consequence: if \(T\) preserves a finite measure \(\mu\),
then every integrable error \(h\) and every \(a\gt0\) satisfy

\[
\mu\left\{\omega:\exists n\in\mathbb N,\ 1\le n
  \text{ and } a\lt\lvert A_nh(\omega)\rvert\right\}
\le \frac{\int |h|\,d\mu}{a}.
\]

RMT-25 proved that fixed \(L^2\) observables plus simple-function Koopman
coboundaries form a dense \(L^2\) class whose chosen representatives have
full-sequence almost-everywhere convergent averages. On a finite measure
space, the continuous inclusion \(L^2(\mu)\hookrightarrow L^1(\mu)\) has dense
range, so this core is also dense in \(L^1\).

For each \(\varepsilon\gt0\), RMT-26 defines the set
\(D_\varepsilon(f)\) on which the average sequence fails the Cauchy test at
scale \(\varepsilon\). If
\(g\) is pointwise good, then outside its null exceptional set,

\[
D_\varepsilon(f)
\subseteq
\left\{\omega:\exists n\in\mathbb N,\ 1\le n
  \text{ and }\varepsilon/3\lt\lvert A_n(f-g)(\omega)\rvert\right\}.
\]

The maximal estimate bounds the right side by
\(3\lVert f-g\rVert_1/\varepsilon\). Density lets the norm tend to zero, so
each positive-scale failure set is null. Avoiding the countable scales
\(1/(k+1)\) makes the averages Cauchy, and completeness of \(\mathbb R\) turns
that Cauchy sequence into a limit. The proof gives full-sequence
almost-everywhere convergence for every real integrable observable on a finite
measure-preserving system.
{{< /panel >}}

**Milestone status.** RMT-26 is implementation-complete in the linked Lean
module. This prose and its figures are published as an open working note. The
theorem closes the
maximal-to-pointwise convergence step, but limit identification remains a
separate ridge.

For a slower textbook ascent, read
[Pointwise Birkhoff from Maximal Control and Dense Good Functions]({{< relref "/knowledge-base/deep-dives/pointwise-birkhoff-from-maximal-control-and-dense-good-functions" >}}).
The compact reusable definitions are the
{{< refterm "birkhoff-cauchy-exceptional-set" "Birkhoff Cauchy exceptional set" >}}
and the
{{< refterm "weak-type-one-one-maximal-bound" "weak type (1,1) maximal bound" >}}.
They build on the existing {{< refterm "birkhoff-sum" "Birkhoff sum" >}},
{{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}},
and
{{< refterm "infinite-horizon-birkhoff-average-exceedance-event" "infinite-horizon average-exceedance event" >}}
entries.

{{< reference-figure
  src="maximal-closure-pipeline.svg"
  alt="A five-stage proof pipeline sends an arbitrary integrable observable through L1 approximation, maximal-error control, null fixed-scale Cauchy failures, countable reciprocal thresholds, and full-sequence almost-everywhere convergence."
  caption="The proof is a closure machine. Density supplies a good approximant, the weak maximal bound makes approximation stable outside a small set, and the Cauchy criterion converts countably many scale statements into one convergence statement. The figure does not identify the limit."
>}}

## The question RMT-25 could not answer

The previous milestone deliberately separated two statements.

1. Every real \(L^2\) observable has Koopman averages converging in \(L^2\)
   norm to the fixed-space projection.
2. A dense \(L^2\) class, consisting of fixed vectors plus simple
   coboundaries, has full-sequence almost-everywhere convergent pointwise
   averages.

Neither statement implies that the full average sequence converges pointwise
for every \(L^2\) vector, much less every \(L^1\) observable. Norm convergence
can supply an almost-everywhere convergent subsequence, but the omitted indices
can still oscillate. Density alone also fails: two \(L^1\)-near functions can
be pointwise far apart on a small set, and orbit averages can revisit that set.

The required bridge must answer a stability question:

> If \(g\) has convergent averages and \(f-g\) is small in \(L^1\), how large
> can the set be on which the averages of \(f\) still fail the Cauchy test?

The RMT-24 maximal estimate answers exactly this question. The rest of RMT-26
is the architecture needed to ask it in a countable, representative-safe form.

## Prior work, contribution, and non-claims

**Prior work.** Birkhoff's 1931 paper established an individual ergodic
theorem for invariant flows, using its own limsup and liminf argument. The
transformation maximal theorem appeared explicitly in Yosida and Kakutani's
1939 paper. Yosida's 1940 paper then used a closure lemma traced to Banach's
1926 almost-everywhere convergence principle. Hopf later generalized the
maximal framework to positive contraction and Markov operators. RMT-26 follows
this broad Banach-principle strategy, with the repository's weak maximal bound
providing quantitative continuity in measure. It is not a line-by-line
formalization of any one historical proof.

**This note's contribution.** The checked module:

- turns absolute Birkhoff-average exceedance into a named event with a weak
  maximal estimate;
- defines a representative-stable fixed-scale Cauchy exceptional event;
- proves a sharp-enough three-term containment using the error at each endpoint
  and the approximant's own Cauchy tail;
- derives null exceptional sets from arbitrarily close pointwise-good
  approximants;
- packages finite-measure \(L^2\to L^1\) inclusion as a continuous linear map
  with its norm coefficient and dense range;
- transfers the RMT-25 core into \(L^1\); and
- concludes full-sequence almost-everywhere convergence for every real
  integrable observable.

**Not claimed.** RMT-26 does not prove:

- that the limit equals conditional expectation onto an invariant sigma
  algebra;
- that ergodicity makes the limit constant or equal to the space average;
- strong \(L^1\) boundedness of the maximal function;
- \(L^1\)-norm convergence of the averages;
- the infinite-measure version of the theorem;
- a canonical pointwise representative for an \(L^1\) equivalence class;
- Kingman's subadditive theorem, Lyapunov exponents, or Oseledets splittings.

## One orbit, three errors

Suppose \(g\) has a Cauchy tail at a point \(\omega\). For large \(m,n\), insert
and subtract the two approximating averages:

\[
\begin{aligned}
|A_mf-A_nf|
&\le |A_mf-A_mg|
   +|A_mg-A_ng|
   +|A_ng-A_nf| \\
&= |A_m(f-g)|
   +|A_mg-A_ng|
   +|A_n(f-g)|.
\end{aligned}
\]

There are three terms, which explains the threshold \(\varepsilon/3\). The
middle term is eventually strictly below \(\varepsilon/3\) because \(g\)'s
averages are Cauchy. If neither endpoint error exceeds
\(\varepsilon/3\), then the two weak endpoint inequalities plus the strict
middle inequality make the total strictly below \(\varepsilon\). That
contradicts membership in the non-strict failure event.

{{< reference-figure
  src="three-error-triangle.svg"
  alt="Four points labelled A_m f, A_m g, A_n g, and A_n f form a three-segment path. The endpoint approximation errors are each at most epsilon over three, while the middle good-approximant tail is strictly below epsilon over three."
  caption="The constant three comes from the three edges of the comparison path. Strictness is carried by the middle edge, while the exceptional event uses a non-strict lower bound. Any larger fixed denominator could work, but the formal theorem and this chapter consistently use three."
>}}

Two small design choices matter.

First, maximal events use only positive horizons. The Cauchy failure supplies
witnesses beyond every requested lower bound, so the proof asks for witnesses
past \(\max(N,1)\). Horizon zero never enters the maximal event. Second, the
failure event uses \(\varepsilon\le |A_mf-A_nf|\), not a strict inequality.
Its complement therefore gives the strict estimate demanded by
`Metric.cauchySeq_iff` without a later boundary repair.

## Absolute maximal control

The elementary inequality behind the absolute event is

\[
\left|\frac1n\sum_{j\lt n}h(T^j\omega)\right|
\le
\frac1n\sum_{j\lt n}|h(T^j\omega)|.
\]

The source declaration
`abs_birkhoffAverage_le_birkhoffAverage_abs` proves it directly from the
finite-sum triangle inequality. Lean's natural-number inverse is totalized,
so the horizon-zero case is also true: both sides are zero.

`birkhoffAverageAbsoluteExceedanceSet` names the event

\[
M_a(h)=\{\omega:\exists n\ge1,\ a\lt|A_nh(\omega)|\}.
\]

`mem_birkhoffAverageAbsoluteExceedanceSet_iff` exposes the exact membership
interface. `birkhoffAverageAbsoluteExceedanceSet_subset` sends \(M_a(h)\) into
the existing one-sided exceedance event for \(|h|\). The RMT-24 theorem then
immediately yields
`measureReal_birkhoffAverageAbsoluteExceedanceSet_le`:

\[
\mu_{\mathbb R}(M_a(h))\le \frac{\int |h|\,d\mu}{a},
\qquad a\gt0.
\]

Here \(\mu_{\mathbb R}\) is Mathlib's real-valued projection of an extended
measure. Finite total mass is explicit because that projection sends infinity
to zero. This is weak type \((1,1)\): it controls the measure of level sets. It
does not state that the supremum function itself is integrable.

## The Cauchy exceptional event

The module defines
`birkhoffCauchyExceptionalSet T f ε` by

\[
D_\varepsilon(f)=
\left\{\omega:\forall N\ \exists m,n\ge N,
\ \varepsilon\le |A_mf(\omega)-A_nf(\omega)|\right\}.
\]

This is a tail event for one fixed numerical scale. It does not say that the
sequence fails to converge in every possible way. It says that arbitrarily
late pairs remain at least \(\varepsilon\) apart.

{{< reference-figure
  src="cauchy-exceptional-event.svg"
  alt="A timeline of Birkhoff averages shows an early finite prefix, then for each proposed tail cutoff two later averages remain epsilon apart. Beside it, avoiding all reciprocal threshold events squeezes every sufficiently late pair into any requested tolerance."
  caption="A fixed-scale failure is countably measurable and quantitatively controllable. Avoiding every reciprocal scale 1/(k+1) is equivalent to the full metric Cauchy requirement because those positive thresholds approach zero. The finite prefix, including horizon zero, is irrelevant."
>}}

`mem_birkhoffCauchyExceptionalSet_iff` is intentionally a reflexive API
theorem. It makes rewriting and source coverage explicit even though the proof
is `rfl`.

`measurableSet_birkhoffCauchyExceptionalSet` expands the event as a countable
intersection over tail cutoffs and countable unions over the two witness
horizons. Each innermost set is measurable because finite Birkhoff averages of
a measurable observable are measurable.

An \(L^1\) vector is an equivalence class, but this event is defined from a
chosen ordinary function. `birkhoffCauchyExceptionalSet_ae_eq_of_ae_eq` proves
that quasi-measure-preserving dynamics transport the event across
almost-everywhere equal representatives. The proof first transports every
finite average and then uses `ae_all_iff` to take the countable intersection
over horizons. This representative theorem feeds
`nullMeasurableSet_birkhoffCauchyExceptionalSet_of_aemeasurable`, which chooses
a measurable representative, and
`nullMeasurableSet_birkhoffCauchyExceptionalSet_of_integrable`, which obtains
almost-everywhere measurability from integrability.

These null-measurability declarations are not ornamental. They prevent the
formal proof from silently assuming that a chosen \(L^1\) representative is
everywhere measurable.

## The maximal-closure engine

`birkhoffCauchyExceptionalSet_subset_exceedance_union_compl` formalizes the
three-error argument. For \(\varepsilon\gt0\), it proves

\[
D_\varepsilon(f)
\subseteq
M_{\varepsilon/3}(f-g)
\cup
\bigl(\operatorname{Conv}(g)\bigr)^c,
\]

where \(\operatorname{Conv}(g)\) is the existing
`birkhoffConvergenceSet T g`. The proof assumes no measurable space because it
is pure pointwise metric algebra.

`measureReal_birkhoffCauchyExceptionalSet_le` adds finite measure, measure
preservation, integrability of the error \(f-g\), and almost-everywhere
convergence of \(g\). The complement of \(g\)'s good event has real measure
zero. Subadditivity for the union and the absolute maximal estimate give

\[
\mu_{\mathbb R}(D_\varepsilon(f))
\le
\frac{\int |f-g|\,d\mu}{\varepsilon/3}.
\]

The abstract approximation hypothesis used by
`measure_birkhoffCauchyExceptionalSet_eq_zero_of_dense_good` says that for
every \(\delta\gt0\), there is an ordinary function \(g\) such that:

1. \(f-g\) is integrable;
2. \(\int|f-g|\,d\mu\lt\delta\); and
3. the Birkhoff averages of \(g\) converge almost everywhere.

To prove that \(D_\varepsilon(f)\) is null, the Lean proof does not take an
informal limit. It fixes an arbitrary \(\eta\gt0\), chooses
\(\delta=\eta(\varepsilon/3)\), derives
\(\mu_{\mathbb R}(D_\varepsilon(f))\le\eta\), and invokes the ordered-real lemma
that a nonnegative number below every positive tolerance is zero. Finite mass
then converts real measure zero back to extended measure zero.

`cauchySeq_birkhoffAverage_of_not_mem_exceptional` is the pointwise countable
bridge. Given a target tolerance \(r\gt0\), Mathlib's
`exists_nat_one_div_lt` supplies \(k\) with \(1/(k+1)\lt r\). Nonmembership in
\(D_{1/(k+1)}(f)\) supplies one tail on which every pair is closer than that
reciprocal threshold, hence closer than \(r\).

Finally, `ae_mem_birkhoffConvergenceSet_of_dense_good` intersects the conull
complements of all reciprocal exceptional sets. At every surviving point the
averages form a real Cauchy sequence. `cauchySeq_tendsto_of_complete` produces
a real limit, and `mem_birkhoffConvergenceSet_iff` packages it as convergence
event membership.

This abstract theorem does not require `Integrable f`. It consumes only
arbitrarily close approximants whose errors are integrable. The final
specialization adds integrability to manufacture precisely those
approximants.

## Why finite measure turns L² into an L¹ dense source

The dense good class from RMT-25 lives in \(L^2\), while the target theorem is
about \(L^1\). On a finite measure space, Hölder's inequality gives

\[
\lVert h\rVert_1
\le \mu(\Omega)^{1/2}\lVert h\rVert_2.
\]

RMT-26 packages this inclusion instead of hiding it inside the last proof.

{{< reference-figure
  src="l2-to-l1-density.svg"
  alt="A nested-space diagram places the RMT-25 fixed-plus-simple-coboundary core densely inside L2, sends it through a continuous inclusion bounded by the square root of total mass, and shows its image dense in L1 because finite-range simple functions lie in both spaces."
  caption="Finite mass gives continuity of the inclusion, while simple-function density gives dense range. The image of the already dense RMT-25 core is therefore dense in L1. This route is unavailable as a global inclusion on a general infinite-measure space."
>}}

`l2ToL1Linear` constructs the underlying linear map from Mathlib's exponent
monotonicity theorem. `l2ToL1Linear_apply_ae` records that the same
almost-everywhere function is used on both sides.

`norm_l2ToL1Linear_apply_le` proves the quantitative norm inequality. The
proof works first in extended nonnegative real seminorms, establishes that the
right side is not infinity, and only then applies `ENNReal.toReal_mono`.
Skipping that finiteness check would be unsound because `toReal` is totalized.

`l2ToL1` bundles the linear map as a continuous linear map.
`l2ToL1_apply_ae` exposes its representative identity, while
`norm_l2ToL1_le` records the operator-norm bound. On a probability space the
coefficient becomes one. On the zero measure space the operator norm becomes
zero, which is why the module states a bound rather than unconditional norm
equality.

`l2ToL1_injective` proves injectivity at the quotient level. It is not a
pointwise statement. Two \(L^2\) classes with equal \(L^1\) images have
almost-everywhere equal representatives and are therefore equal as \(L^2\)
classes.

`denseRange_l2ToL1` proves density using finite-range simple functions. Every
simple \(L^1\) vector has a genuine finite-range representative; finite mass
makes that representative square-integrable. Since simple functions are dense
in \(L^1\), the inclusion has dense range.

`dense_image_l2ToL1_of_dense` is the reusable topological lemma: the image of
a dense set under a continuous map with dense range is dense. It is applied to
define `fixedPlusSimpleCoboundarySetL1`, the image of the RMT-25 core.
`dense_fixedPlusSimpleCoboundarySetL1` proves its density.

`ae_mem_birkhoffConvergenceSet_of_mem_fixedPlusSimpleCoboundarySetL1` performs
the representative bridge. A member of the \(L^1\) core comes from an \(L^2\)
core vector. RMT-25 gives almost-everywhere convergence for the \(L^2\)
representative, `l2ToL1_apply_ae` relates the two representatives, and the
earlier convergence-event transport theorem carries membership across that
almost-everywhere equality.

## The final theorem

The public summit is `ae_mem_birkhoffConvergenceSet_of_integrable`:

```lean
theorem ae_mem_birkhoffConvergenceSet_of_integrable
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ) :
    ∀ᵐ ω ∂μ, ω ∈ birkhoffConvergenceSet T f
```

The proof turns \(f\) into its \(L^1\) equivalence class, chooses a nearby
member \(g_1\) of `fixedPlusSimpleCoboundarySetL1`, and uses the exact identity

\[
\operatorname{dist}_{L^1}([f],g_1)
=\int \operatorname{dist}_{\mathbb R}(f(\omega),g_1(\omega))\,d\mu
=\int |f(\omega)-g_1(\omega)|\,d\mu.
\]

The first equality is representative-safe: `hf.coeFn_toL1` supplies the
almost-everywhere equality between the raw function and its \(L^1\) class.
The included core theorem supplies almost-everywhere convergence for \(g_1\).
These data satisfy the abstract maximal-closure hypothesis, so the conclusion
follows.

The limit remains existential and point-dependent:

\[
\text{for almost every }\omega,
\quad \exists c\in\mathbb R,
\quad A_nf(\omega)\longrightarrow c.
\]

Nothing in the signature says that \(c\) is measurable as a selected
function, invariant, integrable, a conditional expectation, or constant.
Those are later theorems, not prose consequences of this one.

## Assumption ledger

{{< reference-figure
  src="assumption-ledger.svg"
  alt="An assumption ledger shows finite total mass, measure preservation, and real integrability entering the theorem. Probability, ergodicity, injectivity, surjectivity, and invertibility are visibly crossed out as unnecessary. Conditional-expectation and constant-limit conclusions remain behind a future-proof gate."
  caption="The theorem's assumptions are intentionally weaker than the familiar ergodic probability-space slogan. Finite mass supports this proof route; measure preservation powers Koopman composition and the maximal estimate; integrability places the target in L1. Limit identification remains gated."
>}}

| Item | Status | Where it is used |
|---|---|---|
| Finite total mass | Required by this route | Real-measure control and dense \(L^2\hookrightarrow L^1\) inclusion |
| Measure preservation | Required | RMT-24 maximal estimate, RMT-25 core, representative transport |
| Real integrability of \(f\) | Required by the final specialization | Builds the \(L^1\) class and integrable approximation errors |
| Probability normalization | Not required | The total mass may be any finite nonnegative value |
| Ergodicity | Not required | Convergence is proved without identifying or rigidifying the limit |
| Injectivity or surjectivity | Not required | The theorem accepts arbitrary measure-preserving endomorphisms |
| Invertibility | Not required | Only forward iterates occur |
| Positive threshold | Required by quantitative scale lemmas | Division by \(\varepsilon/3\) and the Cauchy test |
| Horizon zero exclusion | Not a theorem assumption | The maximal event is positive-time; tail witnesses are chosen beyond one |

Finite mass is sufficient here, not mathematically optimal for every version of
Birkhoff's theorem. The formalization makes the chosen route visible rather
than advertising it as a sharp boundary.

## Declaration map, in source order

| Declaration | Proof job |
|---|---|
| `abs_birkhoffAverage_le_birkhoffAverage_abs` | Bounds an absolute average by the average of the absolute observable |
| `birkhoffAverageAbsoluteExceedanceSet` | Names positive-time absolute maximal threshold crossing |
| `mem_birkhoffAverageAbsoluteExceedanceSet_iff` | Exposes exact event membership |
| `birkhoffAverageAbsoluteExceedanceSet_subset` | Reduces absolute crossing to one-sided crossing for the absolute observable |
| `measureReal_birkhoffAverageAbsoluteExceedanceSet_le` | Proves the absolute weak maximal estimate |
| `birkhoffCauchyExceptionalSet` | Names fixed-scale Cauchy failure |
| `mem_birkhoffCauchyExceptionalSet_iff` | Exposes the quantified tail witnesses |
| `measurableSet_birkhoffCauchyExceptionalSet` | Proves ordinary measurability for measurable data |
| `birkhoffCauchyExceptionalSet_ae_eq_of_ae_eq` | Transports the event across representatives |
| `nullMeasurableSet_birkhoffCauchyExceptionalSet_of_aemeasurable` | Uses a measurable modification |
| `nullMeasurableSet_birkhoffCauchyExceptionalSet_of_integrable` | Specializes null measurability to integrable observables |
| `birkhoffCauchyExceptionalSet_subset_exceedance_union_compl` | Proves the three-error exceptional containment |
| `measureReal_birkhoffCauchyExceptionalSet_le` | Gives the quantitative one-scale closure bound |
| `measure_birkhoffCauchyExceptionalSet_eq_zero_of_dense_good` | Sends approximation error to zero |
| `cauchySeq_birkhoffAverage_of_not_mem_exceptional` | Converts reciprocal-scale avoidance to a Cauchy sequence |
| `ae_mem_birkhoffConvergenceSet_of_dense_good` | Packages the abstract maximal-closure principle |
| `l2ToL1Linear` | Constructs the finite-measure exponent inclusion |
| `l2ToL1Linear_apply_ae` | Records its representative identity |
| `norm_l2ToL1Linear_apply_le` | Proves the finite-mass Hölder bound |
| `l2ToL1` | Bundles the continuous linear inclusion |
| `l2ToL1_apply_ae` | Records the bundled map's representative identity |
| `norm_l2ToL1_le` | Bounds the inclusion operator norm |
| `l2ToL1_injective` | Proves quotient-level injectivity |
| `denseRange_l2ToL1` | Proves dense range using simple functions |
| `dense_image_l2ToL1_of_dense` | Preserves density for dense source sets |
| `fixedPlusSimpleCoboundarySetL1` | Names the included RMT-25 core |
| `dense_fixedPlusSimpleCoboundarySetL1` | Proves that core dense in \(L^1\) |
| `ae_mem_birkhoffConvergenceSet_of_mem_fixedPlusSimpleCoboundarySetL1` | Transfers its pointwise-good property |
| `ae_mem_birkhoffConvergenceSet_of_integrable` | States the final full-sequence almost-everywhere convergence theorem |

The table is intentionally complete. Small event-membership and
representative lemmas are part of the public proof contract, not disposable
implementation trivia.

## Boundary probes compiled with the theorem

Seven anonymous examples keep the edge behavior executable.

1. **Zero threshold.** `birkhoffCauchyExceptionalSet T f 0 = Set.univ` because
   choosing \(m=n=N\) always witnesses distance at least zero. This proves that
   positive scale is essential to the quantitative closure statements.
2. **Zero measure.** The `l2ToL1` operator norm is zero, not one. Total mass
   zero collapses both quotient spaces.
3. **Probability specialization.** If \(\mu(\Omega)=1\), the general norm bound
   simplifies to \(\lVert l2ToL1\rVert\le1\). Probability is a corollary, not a
   premise of the main theorem.
4. **Positive threshold.** Threshold one exercises the strict positivity gate
   in the absolute maximal estimate and simplifies away the denominator.
5. **Zero-measure theorem.** The final pointwise theorem compiles directly at
   the zero measure with no nonzero-mass premise; its almost-everywhere
   conclusion is vacuous, as it should be.
6. **Identity dynamics.** Every integrable observable satisfies the final
   conclusion for `MeasurePreserving.id μ` without an ergodicity hypothesis.
7. **Nonbijective Dirac dynamics.** The constant map on `Bool` preserves the
   Dirac mass at `false`, is neither injective nor surjective, and still satisfies the final
   theorem for every integrable observable. It simultaneously blocks hidden
   injectivity, surjectivity, and invertibility requirements.

The module also prints the axiom footprints of the absolute maximal theorem,
the abstract closure theorem, the dense inclusion, the included core, and the
final pointwise theorem. The warning-fatal check reports only `propext`,
`Classical.choice`, and `Quot.sound`. No project axiom, `sorry`, or unsafe
declaration appears.

## How to run the formalization

From the repository root on macOS or Linux:

```bash
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/PointwiseBirkhoff.lean
lake build NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoff
cd ..
make check
```

The first command checks the leaf module with warnings fatal. The second asks
Lake for the module target and its dependencies. `make check` validates the
whole Lean tree, proof-to-prose coverage, checkpoint contract, teaching-source
hygiene, and warning-fatal Hugo render.

To inspect only the theorem signature in a scratch file:

```lean
import NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoff

open MeasureTheory Filter
open NonlinearDynamics.Random.RandomCocycles

#check ae_mem_birkhoffConvergenceSet_of_integrable
#print axioms ae_mem_birkhoffConvergenceSet_of_integrable
```

## Solved exercises

### Exercise 1: prove the absolute average inequality

Expand the Birkhoff average as a nonnegative scalar times a finite sum. Apply
the finite-sum triangle inequality, then multiply by the nonnegative inverse of
the natural horizon. At horizon zero Lean's totalized inverse and empty sum
make both sides zero. This is exactly the proof strategy of
`abs_birkhoffAverage_le_birkhoffAverage_abs`.

### Exercise 2: why is there no factor two?

One could split \(h=h^+-h^-\) and control positive and negative crossings
separately, which often introduces a factor two. Here
\(|A_nh|\le A_n|h|\) pointwise, so a single application of the one-sided
maximal estimate to \(|h|\) controls the absolute event with constant one.

### Exercise 3: distinguish weak and strong type

The inequality
\(\mu\{M h\gt a\}\le\lVert h\rVert_1/a\) controls level-set measure and is weak
type \((1,1)\). A strong type statement would bound
\(\int M h\,d\mu\) by a constant times \(\lVert h\rVert_1\). The latter is not
proved and is generally false for the classical maximal ergodic operator at
the endpoint.

### Exercise 4: negate the exceptional event

Negating

\[
\forall N\ \exists m,n\ge N,
\varepsilon\le|A_mf-A_nf|
\]

gives

\[
\exists N\ \forall m,n\ge N,
|A_mf-A_nf|\lt\varepsilon.
\]

The strict inequality appears because the original relation was non-strict.
This matches the metric Cauchy criterion directly.

### Exercise 5: derive the three-error bound

Insert \(A_mg\) and \(A_ng\) between \(A_mf\) and \(A_nf\), then use the real
triangle inequality twice. Linearity of Birkhoff averages turns each endpoint
difference into an average of \(f-g\). Two endpoint bounds of
\(\varepsilon/3\) plus one strict middle bound below \(\varepsilon/3\) give a
strict total below \(\varepsilon\).

### Exercise 6: why force the witnesses past one?

The maximal event quantifies only \(n\ge1\), while a Cauchy failure supplies
witnesses beyond any chosen tail index. Ask the failure event for witnesses
beyond \(\max(N,1)\). They remain beyond the approximant's Cauchy cutoff and
become legal positive-time maximal witnesses.

### Exercise 7: kill one fixed scale

Fix \(\eta\gt0\) and choose a good \(g\) with
\(\lVert f-g\rVert_1\lt\eta\varepsilon/3\). The quantitative closure bound gives

\[
\mu_{\mathbb R}(D_\varepsilon(f))
\le \frac{\eta\varepsilon/3}{\varepsilon/3}=\eta.
\]

Because the real measure is nonnegative and this holds for every positive
\(\eta\), it equals zero. The Lean proof then converts real-measure zero back
to ordinary extended-measure zero.

### Exercise 8: why not intersect every real epsilon?

An uncountable intersection of conull sets need not be conull. The reciprocal
naturals \(1/(k+1)\) form a countable positive family approaching zero. Every
positive tolerance dominates one of them, so they are sufficient for the
Cauchy criterion.

### Exercise 9: locate completeness

All maximal and density reasoning produces only a pointwise Cauchy sequence.
The fact that every real Cauchy sequence converges enters exactly at
`cauchySeq_tendsto_of_complete`. Replacing \(\mathbb R\) by an incomplete
metric codomain would require completion or a stronger hypothesis.

### Exercise 10: prove the finite-measure inclusion coefficient

Apply Hölder to \(h\cdot1\):

\[
\int|h|\,d\mu
\le
\left(\int|h|^2\,d\mu\right)^{1/2}
\left(\int1^2\,d\mu\right)^{1/2}
=\lVert h\rVert_2\mu(\Omega)^{1/2}.
\]

RMT-26 uses Mathlib's exponent-comparison theorem at the extended seminorm
level and then justifies the conversion to real norms.

### Exercise 11: explain dense range

Finite-range simple functions are dense in \(L^1\). On a finite measure
space, every measurable finite-range function is square-integrable because it
is measurable, bounded, and the whole space has finite mass. Thus every
simple \(L^1\) vector lies in the image of `l2ToL1`, and the image is dense.

### Exercise 12: handle zero total mass

When \(\mu=0\), every two functions are almost everywhere equal. Both \(L^1\)
and \(L^2\) are zero spaces, so the inclusion map has operator norm zero. The
bound \(\lVert l2ToL1\rVert\le\mu(\Omega)^{1/2}\) specializes correctly to
zero.

### Exercise 13: separate injectivity from pointwise equality

`l2ToL1_injective` says equality of the \(L^1\) images forces equality of the
\(L^2\) equivalence classes. It does not say their chosen representatives are
equal at every point. The proof uses almost-everywhere equalities and `Lp.ext`.

### Exercise 14: reconstruct the final approximation

Turn the raw integrable \(f\) into `hf.toL1 f`. Density gives \(g_1\) in the
included core with `dist f₁ g₁ < δ`. The theorem
`L1.dist_eq_integral_dist` and the representative equality
`hf.coeFn_toL1` identify that distance with
\(\int|f-g_1|\,d\mu\). The core theorem supplies almost-everywhere convergence
for \(g_1\), completing the abstract hypothesis.

### Exercise 15: show why ergodicity is absent

The closure proof asks only whether each approximant converges almost
everywhere. It never asks whether invariant events have measure zero or full
measure. Ergodicity is relevant when identifying or rigidifying the limit, not
when proving that a limit exists.

### Exercise 16: audit the noninjective Dirac example

Let \(S:\mathrm{Bool}\to\mathrm{Bool}\) be constant at `false`. It is not
injective because `false` and `true` have the same image. The pushforward of
the Dirac mass at `false` is still that Dirac mass. Therefore `S` is
measure-preserving and the final theorem applies even though no inverse exists.

### Exercise 17: identify the finite-prefix principle

A sequence converges if and only if any sequence obtained by changing finitely
many terms converges to the same limit. The proof does not need this as a
separate lemma: every Cauchy statement is tail-based, and the maximal
containment explicitly pushes witnesses beyond horizon one.

### Exercise 18: state the exact summit without overclaiming

The correct conclusion is

\[
\forall^\mu\omega,\ \exists c\in\mathbb R,\ A_nf(\omega)\to c.
\]

It is not yet
\(c=\mathbb E[f\mid\mathcal I]\), not yet \(c=\int f\,d\mu\), and not yet a
named measurable function. Each stronger statement needs additional proof.

## Discussion

Everything in this section is interpretation. The warning-fatal theorem and
its explicit assumptions stand on their own; the conceptual connections below
do not add checked conclusions.

The proof illustrates why pointwise ergodic theory is often organized around
maximal inequalities. Density proves a theorem on a tractable algebraic core,
but a pointwise conclusion is discontinuous in ordinary norm topology. A weak
maximal inequality supplies the missing replacement for continuity: small
norm error implies small measure of the set on which any time horizon exposes
a large pointwise error. This is exactly the form of stability needed to pass
from the core to the completed space.

The formal architecture also separates three completions that are easy to
blend in prose. Completing simple functions in \(L^1\) creates equivalence
classes. Completing the real numbers turns pointwise Cauchy sequences into
limits. Taking a countable intersection of conull sets creates one set on
which every reciprocal-scale condition holds simultaneously. Each completion
has a different theorem and a different failure mode.

The next natural theorem is limit identification. That task is not a cosmetic
corollary. It requires choosing a measurable limit representative, proving
integrability and invariance, relating its integrals over invariant measurable
sets to those of \(f\), and reconciling exact invariant sets with a mod-null
invariant sigma algebra. Only after that layer can ergodicity collapse the
limit to a constant, and only under probability normalization does the
familiar space-average formula take its simplest form.

## The next ridge

{{< panel "info" >}}
**Successor completed.** RMT-27 now identifies the limit through the exact
invariant sigma algebra without adding probability, ergodicity, or
invertibility. Continue with
[What the Orbit Remembers: Identifying the Birkhoff Limit in Lean]({{< relref "/development-notebook/2026/07/identifying-the-finite-measure-birkhoff-limit-in-lean" >}}).
{{< /panel >}}

RMT-26 completes the existence half of the real finite-measure pointwise
Birkhoff theorem. RMT-27 supplies the missing measurable representative,
uniform-integrability and \(L^1\) bridge, invariant-set integral identities,
and conditional-expectation uniqueness. With the additive theorem complete,
the roadmap can add the carefully normalized ergodic corollary and then return
to the orbit-majorant, phase-averaging, and interval-packing infrastructure for
Kingman's theorem.

## References

<a id="ref-rmt26-banach"></a>
**Stefan Banach.**
[Sur la convergence presque partout de fonctionnelles linéaires](http://kielich.amu.edu.pl/Stefan_Banach/pdf/oeuvres2/355.pdf),
*Bulletin des Sciences Mathématiques* 50, 27–32 and 36–43, 1926, reprinted in
the linked collected-works scan. Theorems I and III develop continuity in
measure and extension of almost-everywhere convergence from a dense subset.
RMT-26 uses a Banach-principle strategy with a quantitative weak maximal
estimate; it does not claim to invoke Banach's historical theorem verbatim.

<a id="ref-rmt26-birkhoff"></a>
**George D. Birkhoff.**
[Proof of the Ergodic Theorem](https://pmc.ncbi.nlm.nih.gov/articles/PMC1076138/),
*Proceedings of the National Academy of Sciences* 17(12), 656–660, 1931,
[DOI](https://doi.org/10.1073/pnas.17.2.656). The paper treats an invariant
flow and proves its individual theorem with a limsup and liminf integral
argument. It did not use the later transformation maximal theorem.

<a id="ref-rmt26-yosida-kakutani"></a>
**Kôsaku Yosida and Shizuo Kakutani.**
[Birkhoff's Ergodic Theorem and the Maximal Ergodic Theorem](https://www.jstage.jst.go.jp/article/pjab1912/15/6/15_6_165/_pdf/-char/en),
*Proceedings of the Imperial Academy* 15(6), 165–168, 1939,
[DOI](https://doi.org/10.3792/pia/1195579375). Theorem 2 is presented as the
new maximal ergodic theorem. Its map assumptions differ from RMT-26, so the
chapter cites it for lineage rather than theorem identity.

<a id="ref-rmt26-yosida"></a>
**Kôsaku Yosida.**
[Ergodic theorems of Birkhoff-Khintchine's type](https://www.jstage.jst.go.jp/article/jjm1924/17/0/17_0_31/_pdf/-char/en),
*Japanese Journal of Mathematics* 17, 31–36, 1940,
[DOI](https://doi.org/10.4099/jjm1924.17.0_31). Pages 33–34 combine a closure
lemma attributed to Banach with convergence on a bounded dense class. This is
the closest primary historical precedent for the architecture used here.

<a id="ref-rmt26-hopf"></a>
**Eberhard Hopf.**
[The General Temporally Discrete Markoff Process](https://iumj.org/article/961/),
*Journal of Rational Mechanics and Analysis* 3, 13–45, 1954,
[DOI](https://doi.org/10.1512/iumj.1954.3.53002). Hopf generalized the maximal
and ergodic framework to positive contractions and Markov operators. The
repository uses the historically modest phrase "Hopf-style maximal control."

<a id="ref-rmt26-garsia"></a>
**Adriano Garsia.**
[A Simple Proof of E. Hopf's Maximal Ergodic Theorem](https://iumj.org/article/1584/),
*Journal of Mathematics and Mechanics* 14(3), 381–382, 1965,
[DOI](https://doi.org/10.1512/iumj.1965.14.14027). This short proof is the
closest classical source for the finite-maximum proof style upstream of
RMT-24.

<a id="ref-rmt26-keane-petersen"></a>
**Michael Keane and Karl Petersen.**
[Easy and Nearly Simultaneous Proofs of the Ergodic Theorem and Maximal Ergodic Theorem](https://doi.org/10.1214/074921706000000266),
*IMS Lecture Notes–Monograph Series* 48, 248–251, 2006, with open
[arXiv:math/0608251v1](https://arxiv.org/abs/math/0608251), submitted
2006-08-10. The peer-reviewed article treats a possibly noninvertible
measure-preserving transformation on a probability space and separates the
maximal inequality from the convergence corollary.

<a id="ref-rmt26-mathlib-lp"></a>
**Mathlib contributors.**
[Exponent comparison for finite-measure Lp spaces](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/LpSeminorm/CompareExp.lean#L65-L122),
[simple-function density](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/SimpleFuncDenseLp.lean#L648-L675),
and
[the L1 norm-integral bridge](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Integral/Bochner/Basic.lean#L904-L919),
Mathlib 4.32.0. These are the pinned upstream interfaces behind the finite
measure inclusion, dense range, and final raw-representative approximation.

<a id="ref-rmt26-lean"></a>
**Nonlinear Dynamics in Lean contributors.**
[`PointwiseBirkhoff.lean`](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/PointwiseBirkhoff.lean),
the checked source described declaration by declaration in this chapter.

The exact upstream Mathlib revision audited here is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by `formalization/lake-manifest.json`.
