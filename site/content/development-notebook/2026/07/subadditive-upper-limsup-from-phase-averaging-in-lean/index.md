---
title: "Subadditive Upper Limsup Bounds from Phase Averaging in Lean"
slug: "subadditive-upper-limsup-from-phase-averaging-in-lean"
date: 2026-07-22
weight: -63
author: "tdj28"
summary: "Random-matrix-theory milestone 29 (RMT-29) combines a corrected finite phase-average bound with ergodic Birkhoff convergence under the original map to prove a samplewise upper limsup estimate for nonnegative subadditive processes, then optimizes all block lengths to reach the integrated log-positive Fekete rate for matrix cocycles."
lead: |
  A fixed-block proof of the subadditive ergodic theorem faces a subtle trap: an ergodic map can have a nonergodic power. RMT-29 avoids that trap by centering the process, averaging every block phase at finite time, and applying Birkhoff convergence only under the original transformation. The result is the upper half of a Kingman-style argument, formalized with its true probability, integrability, nonnegativity, and positive-block boundaries visible.
key_result: |
  On an ergodic probability system, every pointwise nonnegative integrable subadditive-process candidate satisfies, almost everywhere, limsup X_n(omega)/n at most the normalized integral of any fixed positive block X_b. For a discrete matrix cocycle with an integrable one-step log-positive envelope, the same samplewise limsup is at most the deterministic integrated log-positive Fekete rate. The module does not prove convergence, a matching lower bound, equality with the rate, a signed Lyapunov exponent, or an Oseledets splitting.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Subadditive processes, phase averaging, Birkhoff convergence, limit superior, probability normalization, Fekete rates, and Lean proof architecture"
reading_time: "170 to 240 minutes"
prerequisites:
  - "RMT-20 finite phase averaging"
  - "RMT-28 ergodic Birkhoff convergence to the probability integral"
  - "RMT-16 integrated log-positive growth and deterministic Fekete rates"
  - "Basic real integration, filters, and almost-everywhere notation"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveUpperLimsup"
lean_source: "formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveUpperLimsup.lean"
tags:
  - "Lean 4"
  - "Subadditive processes"
  - "Limit superior"
  - "Phase averaging"
  - "Birkhoff theorem"
  - "Ergodicity"
  - "Matrix cocycles"
  - "Fekete lemma"
og_image: "subadditive-upper-limsup-from-phase-averaging-in-lean-card.png"
og_image_alt: "Warm-paper teaching card showing a nonnegative subadditive process passing through centering, finite phase averaging, and the original map to a fixed-block upper ceiling, with warnings that no lower bound, convergence, or powered-map ergodicity is claimed."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed Research Note. Verify claims against the cited primary
sources and released artifacts before relying on them.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This declaration-complete teaching chapter is published
as an open working note while human editorial acceptance and the separate
scientific-integrity
and zero-context expert-reader reviews are pending. The warning-fatal checked
Lean source is authoritative for every theorem statement and assumption.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** Let \(T\) act ergodically on a probability space and let
\(X_n(\omega)\) be a pointwise nonnegative, integrable subadditive process.
For every positive block length \(b\), RMT-29 proves

\[
\limsup_{n\to\infty}\frac{X_n(\omega)}{n}
\le
\frac{1}{b}\int_\Omega X_b\,d\mu
\quad\text{for almost every }\omega.
\]

The proof centers \(X\) by its one-step Birkhoff majorant, imports RMT-20's
finite phase-averaged inequality, decomposes the complete sequence into
residue classes modulo \(b\), and invokes RMT-28 only for Birkhoff averages
under the original map \(T\). It never assumes that \(T^b\) is ergodic.

For the nonnegative log-positive norm process of a discrete matrix cocycle,
the theorem holds simultaneously for every positive \(b\). Taking the
infimum and using the checked deterministic Fekete identity from RMT-16 gives
an almost-everywhere upper bound by the integrated log-positive growth rate.
This is an upper-limsup milestone before full Kingman convergence.
{{< /panel >}}

For reusable terminology, see {{< refterm "limit-superior" "limit superior" >}},
{{< refterm "phase-averaging" "phase averaging" >}},
{{< refterm "birkhoff-sum" "Birkhoff sums" >}}, and
{{< refterm "integrated-log-positive-growth-rate" "integrated log-positive growth rate" >}}.
The textbook companion is
[Subadditive Upper Limsup Bounds Before Kingman Convergence]({{< relref "/knowledge-base/deep-dives/subadditive-upper-limsup-bounds-before-kingman-convergence" >}}).

## Why this milestone exists

RMT-20 established the finite combinatorial inequality needed to average all
block phases ([RMT-20 record](#ref-rmt29-rmt20)). RMT-28 established that
ordinary Birkhoff averages converge to the raw integral on ergodic probability
systems ([RMT-28 record](#ref-rmt29-rmt28)), through the modern checked form of
Birkhoff's individual ergodic theorem
([Birkhoff 1931](#ref-rmt29-birkhoff)). RMT-29 is the first layer to compose
those results into a samplewise asymptotic bound for a genuinely subadditive
family.

That composition matters because the most direct proof route is unsound.
Fix a block \(b\), follow \(X_b\) at times \(0,b,2b,\ldots\), and one obtains
an orbit sum for \(T^b\). But `Ergodic T μ` does not imply
`Ergodic (T^[b]) μ`. The uniform two-point flip is the smallest example:
the flip is ergodic, while its square is the identity and has nontrivial
invariant events.

The corrected route averages all phases before taking limits. That finite
average becomes one Birkhoff sum of the block observable under \(T\), not a
Birkhoff sum under \(T^b\). Every asymptotic call therefore uses exactly the
ergodicity present in the theorem statement.

{{< reference-figure
  wide="true"
  src="rmt29-upper-proof-ladder.svg"
  alt="A proof ladder begins with an integrable nonnegative shifted-subadditive process, centers it by the one-step Birkhoff majorant, applies finite phase averaging, takes two Birkhoff limits under the original map, obtains a fixed-block upper limsup bound, and then specializes to the cocycle Fekete rate. A separate unfinished branch marks the absent lower liminf proof."
  caption="**Finding:** RMT-29 composes finite phase averaging and ordinary-map Birkhoff convergence into an upper-limsup estimate. The ladder has no step producing a lower bound or samplewise convergence, so it must not be read as the full subadditive ergodic theorem."
>}}

## The mathematical proof ladder

### Step 1: integrate finite Birkhoff sums exactly

For a measure-preserving map and an integrable real observable \(f\),

\[
\int_\Omega S_n f\,d\mu
{} =
n\int_\Omega f\,d\mu.
\]

The proof expands the finite sum, uses `integral_finsetSum`, and applies
measure preservation to every iterate. Integrability is propagated through
the composed iterates. No probability or ergodicity assumption is needed.

### Step 2: compute the centered integral

Define

\[
Y_n=X_n-S_n(X_1).
\]

The integrable-candidate interface makes both terms integrable. Therefore

\[
\int Y_b
{} =
\int X_b-b\int X_1.
\]

This identity is the algebraic hinge of the asymptotic proof. After block
averaging, the \(X_1\) contribution cancels exactly.

### Step 3: get an almost-everywhere Birkhoff set

For each fixed positive block \(b\), RMT-28 gives a full-measure set on which
both

\[
A_n(Y_b)(\omega)\to\int Y_b
\]

and

\[
A_n(X_1)(\omega)\to\int X_1
\]

hold. Probability is used here to make the limits raw integrals. On a general
finite nonzero measure they would be normalized space averages.

### Step 4: establish the limsup bounds needed by Mathlib

The public generic theorem assumes

\[
0\le X_n(\omega)
\]

pointwise. Hence \(0\le X_n(\omega)/n\) for every natural \(n\), including
Lean's totalized time-zero value. This supplies the lower boundedness needed
by the real `limsup_le_iff` interface
([pinned Mathlib source](#ref-rmt29-mathlib-limsup)).

{{< reference-figure
  src="limsup-boundedness-gates.svg"
  alt="Two gates feed the real limsup API. Pointwise nonnegativity gives a lower bound of zero for normalized process values, while the one-step Birkhoff majorant and convergence of the one-step average give an eventual upper bound. Beyond the gates lies only a limsup inequality, not a convergence conclusion."
  caption="The real-valued `limsup_le_iff` route needs both order bounds. Nonnegativity is genuine theorem scope, while the upper bound comes from the one-step majorant and Birkhoff convergence. Passing both gates proves an upper comparison only."
>}}

For upper boundedness, the candidate's one-step majorant gives, eventually at
positive times,

\[
\frac{X_n(\omega)}n\le A_n(X_1)(\omega).
\]

The right side converges on the chosen full-measure set and is therefore
bounded.

### Step 5: work one residue at a time

Fix a residue \(r\lt b\) and write \(n=ba+r\). For \(a\ge2\), let

\[
m=b(a-1).
\]

The RMT-20 phase-average theorem gives

\[
Y_{ba+r}(\omega)
\le
\frac{S_m(Y_b)(\omega)}b.
\]

After division by \(ba+r\), the right side becomes

\[
A_m(Y_b)(\omega)
\frac{m}{b(ba+r)}.
\]

As \(a\to\infty\), one has \(m\to\infty\), \(ba+r\to\infty\), and

\[
\frac{m}{b(ba+r)}\to\frac1b.
\]

Adding the Birkhoff average of \(X_1\) reconstructs the normalized original
process. The limiting target simplifies to

\[
\frac{1}{b}\int Y_b+\int X_1
{} =
\frac1b\int X_b.
\]

{{< reference-figure
  src="centered-integral-cancellation.svg"
  alt="The integral of the centered block is shown as the block integral minus b copies of the one-step integral. Multiplication by one over b and addition of one one-step integral cancel those copies, leaving the normalized block integral."
  caption="Centering serves two roles: its nonpositive sign enables finite phase averaging, and its exact integral identity cancels the one-step Birkhoff limit to yield the normalized block integral."
>}}

### Step 6: recover every large time

`Eventually.atTop_of_arithmetic` says that an eventual statement holds on
all natural times once it holds eventually along every residue progression
for a positive modulus. This is the exact bridge from the finite family of
residue arguments to the complete sequence
([pinned Mathlib source](#ref-rmt29-mathlib-arithmetic)).

{{< reference-figure
  wide="true"
  src="arithmetic-residue-lanes.svg"
  alt="A toy block length three splits the horizons into lanes 3, 6, 9 and onward; 4, 7, 10 and onward; and 5, 8, 11 and onward. Each lane obeys the same fixed-block ceiling and the three lanes then recombine into the complete sequence."
  caption="Finite residue lanes recover the complete sequence. The proof establishes the target eventually on each arithmetic progression, then uses `Eventually.atTop_of_arithmetic` to recombine them without invoking ergodicity of a powered map."
>}}

### Step 7: optimize the cocycle endpoint

The cocycle log-positive observable is pointwise nonnegative. The generic
theorem therefore gives the block bound for every positive natural \(b\).
After taking a countable intersection of full-measure sets, the samplewise
limsup is below every normalized integrated block value. The earlier Fekete
identity identifies their infimum with
`integratedLogPlusGrowthRate hC`.

{{< reference-figure
  src="probability-scaling-boundary.svg"
  alt="A probability measure of mass one sends an ergodic Birkhoff average directly to the raw integral and hence to the normalized block integral. A neighboring finite positive measure of mass q sends the average to the integral divided by q, so the raw-integral Fekete comparison no longer has the same scale."
  caption="Probability is an exact scaling gate. It identifies the ergodic Birkhoff constant with the raw integral used by the established Fekete rate; preservation alone does not remove total-mass normalization."
>}}

## Public declaration surface

The module's four public declarations appear in this order. The receiver
namespace variables already in scope in the Lean source are suppressed in
snippets 2 through 4; the theorem names, explicit premises, and conclusions
are source-faithful.

### 1. `integral_birkhoffSum_eq_nat_mul`

```lean
theorem integral_birkhoffSum_eq_nat_mul
    {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω} {μ : Measure Ω}
    {f : Ω → ℝ} (hT : MeasurePreserving T μ μ) (hf : Integrable f μ)
    (n : ℕ) :
    (∫ ω, birkhoffSum T f n ω ∂μ) = n * ∫ ω, f ω ∂μ
```

The multiplier on the right is coerced into \(\mathbb R\). The theorem is
finite and exact. It needs neither finite total mass nor ergodicity.

### 2. `IsIntegrableSubadditiveProcessCandidate.integral_centeredProcess`

```lean
theorem IsIntegrableSubadditiveProcessCandidate.integral_centeredProcess
    {X : ℕ → Ω → ℝ}
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (b : ℕ) :
    (∫ ω, centeredProcess T X b ω ∂μ) =
      (∫ ω, X b ω ∂μ) - b * ∫ ω, X 1 ω ∂μ
```

This receiver-style theorem exposes the exact centering cancellation needed
later. Its horizon is unrestricted, so the time-zero specialization compiles.

### 3. `IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral`

```lean
theorem IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral
    [IsProbabilityMeasure μ] {X : ℕ → Ω → ℝ}
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (hXnonneg : ∀ n ω, 0 ≤ X n ω)
    (b : ℕ) (hb : b ≠ 0) :
    ∀ᵐ ω ∂μ,
      limsup (fun n ↦ X n ω / (n : ℝ)) atTop ≤
        (∫ x, X b x ∂μ) / (b : ℝ)
```

Every premise has a distinct job: candidate integrability supports the two
Birkhoff calls, ergodicity supplies preservation and integral-valued limits,
probability removes total-mass normalization, pointwise nonnegativity supplies
the real lower bound, and `hb` legitimizes the fixed-block phase argument.

### 4. `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_limsup_normalized_le_integratedLogPlusGrowthRate`

```lean
theorem DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.
    ae_limsup_normalized_le_integratedLogPlusGrowthRate
    [Fintype ι] [DecidableEq ι] [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (hT : Ergodic C.base μ) :
    ∀ᵐ ω ∂μ,
      limsup
          (fun n ↦ C.logPlusNormObservable n ω / (n : ℝ)) atTop ≤
        C.integratedLogPlusGrowthRate hC
```

The integrability receiver supplies the generic candidate instance and the
Fekete identity. No nonempty index assumption is present.

## Private helper ledger

The core private helpers occur after the finite Birkhoff-sum integration
theorem and before the namespace containing the candidate receiver theorems.

| Source item | Role |
|---|---|
| `blockPrefix` | Defines \(b(a-1)\), the phase-compatible Birkhoff horizon |
| `tendsto_blockPrefix` | Proves that prefix tends to infinity for \(b\ne0\) |
| `tendsto_arithmetic` | Proves \(ba+r\to\infty\) for \(b\ne0\) |
| `tendsto_blockCoefficient` | Proves the residual real coefficient tends to \(b^{-1}\) |

These helpers are private because they package proof geometry rather than a
stable mathematical API. The coefficient proof uses Mathlib's affine-ratio
limit and then reconciles natural subtraction with real arithmetic after
restricting eventually to \(a\ge1\).

## Boundary-support and probe ledger

After the four public declarations, the source contains a private compiled
boundary section. It defines `rmt29ZeroProcess`, proves
`rmt29ZeroProcess_candidate`, defines `rmt29Flip` and
`rmt29TwoCycleMeasure`, and installs a private probability instance for that
measure. The remaining named theorems are
`rmt29Flip_measurePreserving_twoCycle`,
`rmt29Flip_preErgodic_twoCycle`, `rmt29Flip_ergodic_twoCycle`,
`rmt29Flip_square_eq_id`, and `rmt29Flip_square_not_ergodic`.

Three anonymous `example` probes then compile the intended boundaries:

1. the finite Birkhoff-sum integral theorem at horizon zero;
2. the generic upper-limsup theorem for the totalized zero process at block
   one; and
3. the same theorem under the ergodic flip at block two, alongside the fact
   that the squared map is not ergodic.

The exact named boundary sub-order is reconciled in the source-order audit
below. These are compiled protections against accidentally strengthening
future APIs, not additional exported theorems.

## Complete source-order map

| Order | Kind | Source item |
|---:|---|---|
| 1 | Public theorem | `integral_birkhoffSum_eq_nat_mul` |
| 2 | Private definition | `blockPrefix` |
| 3 | Private theorem | `tendsto_blockPrefix` |
| 4 | Private theorem | `tendsto_arithmetic` |
| 5 | Private theorem | `tendsto_blockCoefficient` |
| 6 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.integral_centeredProcess` |
| 7 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral` |
| 8 | Public receiver theorem | `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_limsup_normalized_le_integratedLogPlusGrowthRate` |
| 9 | Private boundary definition | `rmt29ZeroProcess` |
| 10 | Private boundary theorem | `rmt29ZeroProcess_candidate` |
| 11 | Private boundary definition | `rmt29Flip` |
| 12 | Private boundary definition | `rmt29TwoCycleMeasure` |
| 13 | Private boundary instance | `IsProbabilityMeasure rmt29TwoCycleMeasure` |
| 14 | Private boundary theorem | `rmt29Flip_measurePreserving_twoCycle` |
| 15 | Private boundary theorem | `rmt29Flip_preErgodic_twoCycle` |
| 16 | Private boundary theorem | `rmt29Flip_ergodic_twoCycle` |
| 17 | Private boundary theorem | `rmt29Flip_square_eq_id` |
| 18 | Private boundary theorem | `rmt29Flip_square_not_ergodic` |
| 19 | Anonymous `example` | `integral_birkhoffSum_eq_nat_mul` specialized at horizon zero |
| 20 | Anonymous `example` | `ae_limsup_normalized_le_blockIntegral` for the zero process at block one |
| 21 | Anonymous `example` | Ergodic flip, nonergodic square, and zero-process block-two bound |
| 22 | Axiom audit | `#print axioms integral_birkhoffSum_eq_nat_mul` |
| 23 | Axiom audit | `#print axioms IsIntegrableSubadditiveProcessCandidate.integral_centeredProcess` |
| 24 | Axiom audit | `#print axioms IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral` |
| 25 | Axiom audit | `#print axioms DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_limsup_normalized_le_integratedLogPlusGrowthRate` |

## Axiom audit

The four final axiom reports are:

```text
'NonlinearDynamics.Random.RandomCocycles.integral_birkhoffSum_eq_nat_mul'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.integral_centeredProcess'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_limsup_normalized_le_integratedLogPlusGrowthRate'
depends on axioms: [propext, Classical.choice, Quot.sound]
```

These are the standard logical and quotient principles inherited through
Mathlib. No project-specific axiom is introduced.

## Boundary probes in depth

### Positive additive one-point sharpness

**Status:** explanatory sharpness model, not one of the three compiled
anonymous examples in this module.

Let \(X_n=cn\) on a one-point probability space, with \(c\ge0\). Then
\(X\) is additive and hence subadditive. For every \(n\gt0\),

\[
X_n/n=c.
\]

For every positive block \(b\),

\[
(\int X_b)/b=c.
\]

Thus the fixed-block bound is sharp. The theorem is not losing a constant
through its phase average.

### Zero process and totalized time zero

**Status:** compiled boundary model and example.

For `rmt29ZeroProcess`, every finite value, integral, centered value, and
normalized positive-time value vanishes. At time zero, real division is
totalized to zero. The proof does not interpret this as growth over zero
time; it moves eventually to positive horizons.

### Nonnegativity is a real boundary

**Status:** explanatory countermodel, not one of the three compiled anonymous
examples in this module.

The scalar family \(X_n=-n^2\) on a one-point probability space is integrable
and subadditive, while \(X_n/n=-n\) for positive \(n\) is unbounded below. In
the extended reals its limsup is \(-\infty\), but Mathlib's conditionally
complete real `Filter.limsup` is totalized here to `sInf univ = 0`, because
every real is eventually an upper bound. For every positive block \(b\), the
proposed right side is \((\int X_b)/b=-b\), so deleting nonnegativity would
make the theorem claim \(0\le-b\). Thus this model refutes the
hypothesis-deleted theorem, not merely this proof route. The log-positive
cocycle process satisfies nonnegativity canonically.

### The uniform flip avoids a powered-map assumption

**Status:** compiled boundary model and example.

For this Boolean system, the checked declarations establish both

```lean
Ergodic rmt29Flip rmt29TwoCycleMeasure
```

and

```lean
¬ Ergodic (rmt29Flip^[2]) rmt29TwoCycleMeasure.
```

The generic theorem nevertheless applies at block \(2\). This is executable
evidence that the proof consumes only `Ergodic rmt29Flip`, not ergodicity of
the squared map.

{{< reference-figure
  src="two-cycle-power-boundary.svg"
  alt="A two-state system alternates false and true under the original flip, whose only invariant events are null or conull. Under the square, each state is fixed, creating nontrivial invariant singletons. A block-two upper bound still follows through phase averaging under the original flip."
  caption="The uniform flip is ergodic but its square is not. The compiled block-two probe therefore rules out any hidden proof step that transfers ergodicity from \(T\) to \(T^2\)."
>}}

### Empty matrix dimension

**Status:** explanatory signature audit, not one of the three compiled
anonymous examples in this module.

The cocycle endpoint assumes `Fintype ι` and `DecidableEq ι`, but not
`Nonempty ι`. Its argument does not choose a coordinate. Empty finite matrix
dimensions therefore remain inside the theorem's formal boundary.

## Assumption ledger

| Assumption | First use | What it does not imply |
|---|---|---|
| `MeasurePreserving T μ μ` | Finite sum integration | Ergodicity or probability |
| Candidate integrability | Centered integrability and Birkhoff calls | Nonnegativity |
| `Ergodic T μ` | RMT-28 convergence under \(T\) | Ergodicity of \(T^b\) |
| `IsProbabilityMeasure μ` | Raw-integral Birkhoff target | Independence or mixing |
| `∀ n ω, 0 ≤ X n ω` | Lower boundedness for real limsup | Convergence |
| `b ≠ 0` | Arithmetic progressions and division | A uniform choice of block |
| `HasIntegrableGeneratorLogPlus` | Cocycle candidate and Fekete rate | Signed log integrability |

## Common wrong turns

### Calling this Kingman's theorem

Kingman's full theorem supplies a samplewise limit under a broader structural
argument. RMT-29 proves only the upper-limsup comparison. The lower-bound half
has not been formalized here.

### Applying Birkhoff to `T^[b]`

This inserts an unavailable hypothesis. The source uses finite phase
averaging and Birkhoff convergence under \(T\).

### Dropping pointwise nonnegativity as bookkeeping

In this real-valued implementation, nonnegativity supplies a lower bound
required by the limsup API. The candidate interface alone permits processes
such as \(-n^2\).

### Calling a raw integral an expectation before probability

The fixed-block target is a raw integral because the theorem assumes a
probability measure. Without mass one, the ergodic Birkhoff constant is the
normalized space average.

### Reading log-positive growth as signed growth

Positive clipping erases contraction. The theorem cannot identify a negative
Lyapunov exponent and does not construct invariant subspaces.

### Claiming a limit-integral interchange

The proof takes Birkhoff limits of fixed observables and compares the
samplewise limsup to a separately established infimum of finite integrals. It
does not integrate a samplewise limit.

## What prior work supplies

Kingman's 1968 paper is the primary historical destination for subadditive
stochastic processes ([Kingman 1968](#ref-rmt29-kingman)). Steele's 1989 paper
gives a conceptually algorithmic full proof, beginning with a Birkhoff-based
centering reduction and then using an interval-decomposition argument
([Steele 1989](#ref-rmt29-steele)). Lalley's short lecture notes motivate
phase averaging specifically because powers of an ergodic transformation need
not remain ergodic ([Lalley notes](#ref-rmt29-lalley)). They are pedagogical
context, not a primary theorem source, and RMT-20 audits a finite indexing
inconsistency in the displayed phase rows.

The repository contribution is narrower and checkable. RMT-20 repaired and
formalized the finite phase estimate with its boundary terms. RMT-28 supplied
ordinary-map ergodic Birkhoff limits with probability specialization. RMT-29
connects them, formalizes the exact real-limsup boundedness obligations, and
exports a cocycle endpoint tied to the already checked deterministic Fekete
rate.

## Contribution and nonclaims

The new contribution is the first checked almost-everywhere samplewise
subadditive upper asymptotic bound in this development. It is reusable at two
levels: a generic nonnegative integrable-process theorem for any positive
block and a matrix-cocycle theorem optimized over all blocks.

It does not establish:

- a lower liminf estimate;
- convergence of the normalized process;
- equality with the integrated rate;
- integrability of a samplewise limit;
- convergence in mean;
- a signed logarithmic growth rate;
- a Lyapunov exponent or Oseledets splitting;
- powered-map ergodicity;
- mixing, independence, stationarity beyond the preserved dynamical base; or
- a quantitative convergence rate.

Those are the boundaries of RMT-29 itself. The later
[RMT-33 Notebook]({{< relref "/development-notebook/2026/07/log-positive-kingman-convergence-from-rational-lower-deviations-in-lean" >}})
supplies the guarded lower-liminf half and obtains convergence for the
log-positive cocycle observable without retroactively strengthening any
declaration in this module.

## Twenty-four solved exercises

### Exercise 1: integrate one iterate

Show why \(\int f\circ T^j=\int f\).

**Solution.** The iterate of a measure-preserving map is measure preserving,
so its mapped measure is \(\mu\); the mapped-integral identity gives equality.

### Exercise 2: count the sum

Why does integrating \(S_nf\) produce the factor \(n\)?

**Solution.** The finite range has cardinality \(n\), and every summand has
the same integral by Exercise 1.

### Exercise 3: specialize to zero

What does the first public theorem say at \(n=0\)?

**Solution.** The empty Birkhoff sum integrates to zero and the right side is
zero times the integral, so both sides are zero.

### Exercise 4: compute the center

Derive \(\int Y_b=\int X_b-b\int X_1\).

**Solution.** Integrate the defining subtraction and use the first public
theorem for the one-step Birkhoff sum.

### Exercise 5: find the center's sign

What gives \(Y_n\le0\) for positive \(n\)?

**Solution.** The candidate's one-step Birkhoff majorant
\(X_n\le S_n(X_1)\).

### Exercise 6: reconstruct normalized \(X\)

Write \(X_n/n\) using \(Y_n\).

**Solution.** It is \(Y_n/n+A_n(X_1)\) for positive \(n\).

### Exercise 7: choose the prefix

For \(n=ba+r\), which prefix is used?

**Solution.** `blockPrefix b a = b * (a - 1)`.

### Exercise 8: explain positivity

Why restrict eventually to \(a\ge2\)?

**Solution.** Then \(a-1\gt0\), so the prefix and the reconstructed horizon are
positive and the required real divisions are order-safe.

### Exercise 9: take the coefficient limit

What is the limit of the block coefficient?

**Solution.** It is \(1/b\), because its numerator has leading coefficient
\(b\) and its denominator leading coefficient \(b^2\).

### Exercise 10: combine limits

What is the limit after adding the one-step average?

**Solution.** \((\int Y_b)/b+\int X_1=(\int X_b)/b\).

### Exercise 11: cover the sequence

Why are finitely many residue arguments sufficient?

**Solution.** Every natural has one residue in \(\{0,\ldots,b-1\}\), and
`Eventually.atTop_of_arithmetic` recombines their eventual tails.

### Exercise 12: locate nonnegativity

Which proof obligation uses `hXnonneg`?

**Solution.** The lower boundedness of the normalized real sequence for
`limsup_le_iff`.

### Exercise 13: test \(-n^2\)

Why does this example not fit the theorem?

**Solution.** It is subadditive but not pointwise nonnegative, and its
normalized values are unbounded below.

### Exercise 14: locate probability

Why is `IsProbabilityMeasure μ` present?

**Solution.** It turns the RMT-28 normalized space-average limit into the raw
integral used by the block target.

### Exercise 15: reject power ergodicity

Give the two-point counterexample.

**Solution.** The uniform Bool flip is ergodic, while its second iterate is
the identity and is not ergodic.

### Exercise 16: audit the actual map

Which map appears in both Birkhoff limits?

**Solution.** The original map \(T\), for observables \(Y_b\) and \(X_1\).

### Exercise 17: sharpen on one point

Evaluate the bound for \(X_n=cn\).

**Solution.** Both sides equal \(c\) for every positive block.

### Exercise 18: optimize blocks

How does the cocycle theorem pass from each block to the rate?

**Solution.** Intersect the countably many full-measure events, then apply
the Fekete identity for the infimum of positive-block normalized integrals.

### Exercise 19: witness the infimum set

Why is it nonempty?

**Solution.** The normalized integral at block one is a member.

### Exercise 20: inspect the empty index

Which theorem premise would force a coordinate to exist?

**Solution.** `Nonempty ι`, and it is deliberately absent.

### Exercise 21: reject convergence

What does a limsup upper bound leave open?

**Solution.** The liminf may be smaller, so oscillation and nonconvergence
remain possible.

### Exercise 22: reject a Lyapunov claim

Why can positive clipping hide contraction?

**Solution.** If the signed logarithmic rate is negative, its positive part
can still be identically zero.

### Exercise 23: list the four public roles

Name them without Lean syntax.

**Solution.** Finite Birkhoff-sum integration, centered-block integration,
generic fixed-block upper limsup, and cocycle all-block integrated-rate bound.

### Exercise 24: state the next missing theorem

What is the next analytic ridge toward Kingman convergence?

**Solution.** A complementary lower-liminf mechanism strong enough to meet
the upper bound and establish the samplewise limit, with its own exact
integrability and invariance obligations. RMT-33 later discharges that ridge
for the log-positive cocycle observable.

## Reproduction and audit

Build the leaf module with warnings fatal:

```text
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/SubadditiveUpperLimsup.lean
```

Starting from the repository root, build the complete formalization and check
the public teaching content:

```sh
cd formalization
lake build

cd ..
make content-hygiene
make site-check
```

The source's final four `#print axioms` commands provide the theorem-specific
logical audit. The coverage manifest connects this module to this Notebook.

## Discussion

RMT-29 changes the epistemic status of one part of the planned Kingman route.
Before this module, the project had a corrected finite phase inequality and a
separate ergodic Birkhoff endpoint. It did not yet have a checked theorem that
combined them into a samplewise asymptotic statement for subadditive data.
The new module closes exactly that upper-bound gap.

The formal proof also exposes which textbook shortcuts are unsafe. Powered-map
ergodicity is not inherited automatically. Probability normalization is not
synonymous with preservation. A real limsup proof has boundedness obligations.
Centering is not cosmetic because it creates the sign needed by the finite
phase theorem and the cancellation needed by the limiting constant.

The correct downgrade is equally important. This milestone does not make the
full subadditive ergodic theorem checked in the repository. It establishes one
direction of the asymptotic comparison for a nonnegative process, and its
cocycle application concerns a positive-log envelope. Any prose claiming a
samplewise limit, equality, signed exponent, or invariant splitting would
outrun the formal artifact.

## The next ridge

The next checked layer is
[Finite Centered Bad-Block Measure Control in Lean]({{< relref "/development-notebook/2026/07/finite-centered-bad-block-measure-control-in-lean" >}}).
It counts visits to finite strict centered sublevel sets, feeds one witnessing
length per visit into RMT-21's greedy interval packing, and integrates the
result into a real-measure ratio. That bridge still does not prove a lower
liminf.

The following layers must first pass to the all-length bad set, then define an
asymptotic lower-deviation event with the correct one-sided almost invariance
and apply ergodic zero-one rigidity. The raw all-length union is not silently
declared invariant. A full Kingman endpoint would then need to identify the
liminf, prove equality with the deterministic rate under the intended
hypotheses, and state any integrability or convergence-in-mean consequences
separately. Only after a signed cocycle observable and its
samplewise limit are established should the development speak about ordinary
Lyapunov exponents. Oseledets splittings require still more multiplicative and
invariant-subspace structure.

## References

<a id="ref-rmt29-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://academic.oup.com/jrsssb/article/30/3/499/7026968),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968,
[doi:10.1111/j.2517-6161.1968.tb00749.x](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x).
This primary source is the historical destination for the full theorem.
RMT-29 proves only the upper-limsup layer stated here.

<a id="ref-rmt29-steele"></a>**J. Michael Steele.**
[Kingman's subadditive ergodic theorem](https://www.numdam.org/item/AIHPB_1989__25_1_93_0/),
*Annales de l'Institut Henri Poincaré, Probabilités et Statistiques* 25(1),
93-98, 1989. Steele gives a conceptually algorithmic full proof, beginning
with a Birkhoff-based centering reduction and then using an
interval-decomposition argument.

<a id="ref-rmt29-lalley"></a>**Steven P. Lalley.**
[Kingman's Subadditive Ergodic Theorem](https://galton.uchicago.edu/~lalley/Courses/Graz/Kingman.pdf),
University of Chicago lecture notes, undated, accessed 2026-07-22. The notes
motivate phase averaging to avoid powered-map ergodicity. They are a teaching
source, not a primary source or Lean dependency; RMT-20 audits their finite
display boundary separately.

<a id="ref-rmt29-birkhoff"></a>**George D. Birkhoff.**
[Proof of the Ergodic Theorem](https://doi.org/10.1073/pnas.17.2.656),
*Proceedings of the National Academy of Sciences* 17(12), 656-660, 1931.
This is the historical source for the individual ergodic theorem. RMT-29 uses
the repository's modern checked RMT-28 interface.

<a id="ref-rmt29-mathlib-limsup"></a>**Mathlib contributors.**
[Liminf and limsup](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/LiminfLimsup.lean),
Mathlib commit `81a5d257`. The pinned source contains `limsup_le_iff`.

<a id="ref-rmt29-mathlib-arithmetic"></a>**Mathlib contributors.**
[Filters at top on finite ordered types](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/Filter/AtTopBot/Finite.lean),
Mathlib commit `81a5d257`. The pinned source contains
`Eventually.atTop_of_arithmetic`.

<a id="ref-rmt29-rmt20"></a>**This project.**
[Phase-Averaged Sliding-Block Bounds for Subadditive Cocycles]({{< relref "/development-notebook/2026/07/phase-averaged-sliding-block-bounds-for-subadditive-cocycles" >}}),
RMT-20. This checked predecessor supplies the corrected finite phase-average
inequality used here.

<a id="ref-rmt29-rmt28"></a>**This project.**
[When Invariant Information Becomes One Number]({{< relref "/development-notebook/2026/07/identifying-the-ergodic-birkhoff-constant-in-lean" >}}),
RMT-28. This checked predecessor supplies ordinary-map Birkhoff convergence
to the integral on ergodic probability systems.
