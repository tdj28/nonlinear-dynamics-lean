---
title: "Finite Centered Bad-Block Measure Control in Lean"
slug: "finite-centered-bad-block-measure-control-in-lean"
date: 2026-07-22
weight: -64
author: "tdj28"
summary: "Random-matrix-theory milestone 30 (RMT-30) converts finite ordered interval packing into a finite-measure estimate for points with a short centered block below a negative slope. It counts bad-set visits exactly, integrates the count under preservation, and proves a ratio bound without probability or ergodicity."
lead: |
  A point is marked when some centered block of length at most m falls below the line of slope c. RMT-30 turns those local witnesses into a global measure estimate: if every positive normalized centered integral stays above delta and c is strictly below delta, then the real measure of the finite bad-block set is at most delta divided by c. The proof is finite-measure and measure-preserving, but neither probabilistic nor ergodic.
key_result: |
  For an integrable subadditive-process candidate on a finite measure-preserving system, assume delta is a lower bound for every positive normalized centered integral and c < delta. Then the finite set of points admitting a witness length 1 <= n <= m with centeredProcess n < c n has real measure at most delta / c. Time one forces c < delta <= 0, so the negative divisor reverses the final inequality. The cocycle specialization uses the integrated log-positive Fekete offset. No lower liminf, convergence, equality, Kingman theorem, signed rate, Lyapunov exponent, or Oseledets splitting is proved.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Finite orbit counts, centered subadditive processes, null measurability, ordered interval packing, finite measures, and Lean proof architecture"
reading_time: "180 to 260 minutes"
prerequisites:
  - "RMT-21 ordered disjoint interval packing"
  - "RMT-29 centered-process integration and integrated log-positive rates"
  - "Finite Birkhoff sums, Bochner integrals, and measure preservation"
  - "Basic familiarity with subadditivity and Lean theorem statements"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveBadBlockMeasure"
lean_source: "formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveBadBlockMeasure.lean"
tags:
  - "Lean 4"
  - "Subadditive processes"
  - "Bad blocks"
  - "Interval packing"
  - "Finite measures"
  - "Birkhoff sums"
  - "Matrix cocycles"
  - "Kingman theorem"
og_image: "finite-centered-bad-block-measure-control-in-lean-card.png"
og_image_alt: "Warm-paper teaching card showing short centered bad blocks becoming finite orbit visits, a packed pointwise inequality, an exact integrated visit count, and a negative-rate ratio bound, with a stop line stating finite measure control only and no lower liminf or convergence."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed Research Note. Verify claims against the cited primary
sources and any released artifacts before relying on them.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** Let \(T\) preserve a finite measure \(\mu\), let
\(X_n(\omega)\) be an integrable subadditive-process candidate, and center it
by the one-step orbit majorant:

\[
Y_n(\omega)=X_n(\omega)-S_n(X_1)(\omega).
\]

For a length cap \(m\) and threshold \(c\), define the finite bad-block set

\[
B_{m,c}=\bigcup_{1\le n\le m}
\{\omega:Y_n(\omega)\lt cn\}.
\]

Suppose a real number \(\delta\) satisfies

\[
\delta\le \frac{1}{n}\int Y_n\,d\mu
\quad\text{for every }n\ge1,
\]

and suppose \(c\lt\delta\). RMT-30 proves

\[
\mu(B_{m,c})\le \frac{\delta}{c}.
\]

The sign is not an extra premise: the time-one centered identity gives
\(\delta\le0\), hence \(c\lt0\). The proof chooses one short witness at every
marked orbit start, invokes the finite ordered packing theorem from RMT-21,
integrates an exact visit-count identity, and sends an auxiliary horizon to
infinity. The final specialization sets
\(\delta\) equal to the integrated log-positive growth rate minus the
one-step integrated log-positive norm. This is a finite bad-block estimate,
not the lower half of Kingman's theorem.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This declaration-complete teaching chapter is published
as an open working note while human editorial acceptance and the separate
scientific-integrity
and zero-context expert-reader reviews are pending. The warning-fatal checked
Lean source is authoritative for every theorem statement and assumption.
{{< /panel >}}

For reusable vocabulary, see {{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}},
{{< refterm "ordered-interval-packing" "ordered interval packing" >}},
{{< refterm "birkhoff-sum" "Birkhoff sums" >}},
{{< refterm "finite-orbit-visit-count" "finite orbit-visit counts" >}}, and
{{< refterm "integrated-log-positive-growth-rate" "integrated log-positive growth rate" >}}.
The textbook companion is
[Finite Bad-Block Measure Bounds Before Kingman Lower Liminf]({{< relref "/knowledge-base/deep-dives/finite-bad-block-measure-bounds-before-kingman-lower-liminf" >}}).

## Orientation: what the theorem measures

The theorem concerns a fixed finite menu of possible witness lengths. A point
\(\omega\) is bad when at least one length \(n\in\{1,\ldots,m\}\) makes the
centered value \(Y_n(\omega)\) fall strictly below the line \(cn\). It does not
ask whether infinitely many lengths are bad, whether the normalized process
has a limit, or whether a pointwise lower liminf is controlled.

The auxiliary horizon \(H\) asks how often the first \(H\) orbit positions
visit this finite bad set. Each visit supplies one witness length. RMT-21's
greedy theorem packs the resulting intervals and converts their total cost
into a bound for the centered process at the enlarged horizon \(H+m\).

{{< reference-figure
  wide="true"
  src="finite-centered-bad-block-window.svg"
  alt="A finite window of allowed block lengths from one through m feeds a strict below-threshold test. Points with at least one witness enter the finite centered bad-block set, while longer blocks remain outside the theorem's definition."
  caption="**Definition boundary:** a point enters the bad set through one strict witness among lengths one through \(m\). The finite union says nothing about longer lengths or infinitely recurring bad blocks."
>}}

## Prior work, contribution, and nonclaims

**Prior work.** Kingman's 1968 paper is the primary historical source for the
subadditive ergodic theorem ([Kingman 1968](#ref-rmt30-kingman)). Its full
argument includes a maximal-ergodic lower-bound mechanism, but the present
module formalizes only one finite bad-block estimate used on the way to that
destination. Steele's 1989 paper gives an algorithmic proof based on interval
decomposition ([Steele 1989](#ref-rmt30-steele)). Lalley's short lecture notes
present an especially close pedagogical pattern: define bad starts, select a
leftmost family, and integrate the resulting contradiction
([Lalley notes](#ref-rmt30-lalley)). Those notes are expository rather than a
primary theorem source. RMT-21 supplies the repository's checked half-open
interval repair and finite packing API, while
[RMT-29](#ref-rmt30-rmt29) supplies the exact centered-integral identity used
by the cocycle specialization.

**Contribution.** RMT-30 adds a reusable natural-valued finite orbit count,
identifies its real cast with an indicator Birkhoff sum, integrates that count
exactly under finite measure preservation, defines finite centered bad blocks,
and composes witness choice, greedy packing, integration, and a horizon limit
into the ratio estimate \(\mu(B_{m,c})\le\delta/c\). It then discharges the
generic lower-rate premise for the log-positive matrix-cocycle process.

**Not claimed.** The module proves no lower liminf estimate, samplewise
convergence, equality with an integrated rate, full Kingman theorem,
\(L^1\) convergence, limit-integral interchange, powered-map ergodicity,
signed logarithmic growth, Lyapunov exponent, or Oseledets splitting. It also
does not replace the finite cap \(m\) by an infinite union.

## Notation and sign ledger

| Symbol | Meaning | Checked boundary |
|---|---|---|
| \(T\) | The measure-preserving base map | Preservation, not ergodicity |
| \(X_n\) | Integrable subadditive-process candidate | May have arbitrary time-zero value |
| \(S_n(X_1)\) | First \(n\) orbit values of the one-step observable | Empty at \(n=0\) |
| \(Y_n\) | `centeredProcess T X n` | \(Y_1=0\) exactly |
| \(m\) | Maximum witness length | \(m=0\) makes the candidate window empty |
| \(H\) | Number of visited orbit positions | \(H=0\) is allowed if \(m\gt0\) |
| \(B_{m,c}\) | Finite union of strict bad-block sublevel sets | Equality at the threshold is not bad |
| \(\delta\) | Lower bound for every positive normalized centered integral | Time one forces \(\delta\le0\) |
| \(c\) | Strictly lower comparison slope | \(c\lt\delta\le0\), hence \(c\lt0\) |

The sign logic deserves to be read before the division. Since
`centeredProcess_one` is zero,

\[
\delta\le \int Y_1\,d\mu=0.
\]

The strict premise \(c\lt\delta\) therefore gives \(c\lt0\). After the proof
obtains

\[
\delta\le c\,\mu(B_{m,c}),
\]

division by the negative number \(c\) reverses the inequality and yields the
advertised measure bound. The ratio \(\delta/c\) is nonnegative because both
numbers are nonpositive and the denominator is strictly negative.

{{< reference-figure
  src="negative-rate-ratio-gate.svg"
  alt="A sign gate starts from the time-one centered identity equal to zero, deduces delta is nonpositive, combines c strictly below delta to deduce c is negative, and then reverses the inequality when dividing by c to obtain the measure ratio."
  caption="**Sign finding:** the theorem does not assume \(c<0\) separately. Time one forces \(\delta\le0\), strict comparison forces \(c<0\), and only then is negative division used."
>}}

## The proof as a finite-to-measure bridge

### Step 1: count visits without measure theory

`finiteOrbitVisitCount T s H ω` filters `Finset.range H` by membership of
\(T^j\omega\) in \(s\) and takes the cardinality. It is natural-valued and
total at \(H=0\). Casting it to \(\mathbb R\) gives exactly

\[
\sum_{j=0}^{H-1}\mathbf 1_s(T^j\omega).
\]

This identity is pure finite combinatorics. It has no measurable space,
measure, preservation, finiteness, probability, or ergodicity premise.

### Step 2: integrate visits exactly

If \(s\) is null measurable, its constant-one indicator is integrable on a
finite measure space. Preservation makes every orbit translate have the same
integral. Therefore

\[
\int \operatorname{visits}_{s,H}\,d\mu
{}=H\,\mu(s).
\]

Null measurability is enough. The source deliberately avoids strengthening
the requirement to ordinary measurability.

{{< reference-figure
  src="rmt30-finite-measure-bridge.svg"
  alt="A four-stage bridge maps a finite bad-block set to an orbit visit count, then to an indicator Birkhoff sum, and finally to horizon times the real measure. Labels state that finite total mass and preservation enter only at the integration stage."
  caption="**Bridge identity:** finite counting becomes a Birkhoff sum before any measure assumptions appear. Finite total mass, null measurability, and preservation enter only when that finite sum is integrated."
>}}

### Step 3: choose one witness at every marked start

Fix \(H,m,c,\omega\). The marked starts are precisely the indices
\(j\lt H\) for which \(T^j\omega\in B_{m,c}\). Membership in the finite union
supplies a witness \(n\in[1,m]\) with

\[
Y_n(T^j\omega)\lt cn.
\]

Classical choice selects one such length at each marked start. The proof then
weakens strict inequality to a non-strict cost bound because the imported
packing theorem is stated with `≤`.

{{< reference-figure
  wide="true"
  src="bad-visits-to-witness-lengths.svg"
  alt="Several marked orbit starts each point to one chosen witness length between one and m. Unmarked starts receive a harmless default length one that is never consumed. The selected starts and lengths feed the ordered packing theorem."
  caption="**Witness extraction:** each bad visit contributes one positive length at most \(m\). The default length at unmarked starts makes the choice function total but has no mathematical effect because packing reads it only on marked starts."
>}}

### Step 4: invoke ordered packing pointwise

RMT-21's `le_mul_card_of_greedy_cover` consumes the centered process's shifted
subadditivity, its nonpositivity away from the joint zero corner, the marked
starts, and their witness lengths. When \(c\le0\) and \(H+m\ne0\), it returns

\[
Y_{H+m}(\omega)
\le c\,\operatorname{visits}_{B_{m,c},H}(\omega).
\]

The enlargement from \(H\) to \(H+m\) is the finite tail needed to absorb a
witness starting near the end of the visited window.

### Step 5: integrate the pointwise packing inequality

Both sides are integrable. Monotonicity of the integral and the exact visit
identity give

\[
\int Y_{H+m}\,d\mu
\le cH\,\mu(B_{m,c}).
\]

The lower-rate premise at \(H+m\gt0\) gives

\[
\delta
\le
c\,\mu(B_{m,c})\frac{H}{H+m}.
\]

{{< reference-figure
  src="integrate-packed-visit-bound.svg"
  alt="A pointwise packed inequality is integrated. The left side becomes the centered integral at the enlarged horizon. The right side becomes c times H times the real bad-set measure. Dividing by H plus m leaves the finite correction factor H over H plus m."
  caption="**Integrated inequality:** the only finite-horizon loss is \(H/(H+m)\). The exact visit integral introduces no extra constant and no probability normalization."
>}}

### Step 6: let the auxiliary horizon grow

For fixed \(m\),

\[
\frac{H}{H+m}\longrightarrow1.
\]

`ge_of_tendsto` transfers the eventual inequalities to the limit and yields
\(\delta\le c\mu(B_{m,c})\). Negative division completes the generic theorem.
This is a limit in the auxiliary deterministic horizon only. It is not a
samplewise limit of \(X_n/n\).

### Step 7: specialize to the matrix cocycle

For a discrete matrix cocycle with an integrable generator log-positive norm,
set

\[
\delta=
\operatorname{integratedLogPlusGrowthRate}
-\operatorname{integratedLogPlusNorm}(1).
\]

RMT-29's centered-integral identity and the existing normalized-rate lower
bound show that this \(\delta\) satisfies the generic premise for every
positive \(n\). Declaration 9 now exposes that implication as a reusable
public theorem, and declaration 10 applies it to the same ratio estimate for
`centeredLogPlusBadBlockSet`.

## Public declaration surface in exact source order

The module exports ten declarations. Namespace variables already in scope are
described in prose where omitting them makes the signature easier to read.

### 1. `finiteOrbitVisitCount`

```lean
noncomputable def finiteOrbitVisitCount {Ω : Type uΩ} (T : Ω → Ω)
    (s : Set Ω) (H : ℕ) (ω : Ω) : ℕ
```

Counts marked starts in `Finset.range H`. It is noncomputable because set
membership is filtered classically.

### 2. `natCast_finiteOrbitVisitCount_eq_birkhoffSum_indicator`

```lean
theorem natCast_finiteOrbitVisitCount_eq_birkhoffSum_indicator
    {Ω : Type uΩ} (T : Ω → Ω) (s : Set Ω) (H : ℕ) (ω : Ω) :
    (finiteOrbitVisitCount T s H ω : ℝ) =
      birkhoffSum T (s.indicator fun _ ↦ (1 : ℝ)) H ω
```

This is the combinatorial cast bridge and has no analytic hypotheses.

### 3. `integral_finiteOrbitVisitCount`

```lean
theorem integral_finiteOrbitVisitCount
    {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω} {μ : Measure Ω}
    [IsFiniteMeasure μ] (hT : MeasurePreserving T μ μ)
    {s : Set Ω} (hs : NullMeasurableSet s μ) (H : ℕ) :
    (∫ ω, (finiteOrbitVisitCount T s H ω : ℝ) ∂μ) = H * μ.real s
```

The natural horizon is coerced to a real scalar on the right.

### 4. `finiteCenteredBadBlockSet`

```lean
def finiteCenteredBadBlockSet {Ω : Type uΩ} (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) (m : ℕ) (c : ℝ) : Set Ω :=
  ⋃ n ∈ Finset.Icc 1 m,
    {ω | centeredProcess T X n ω < c * (n : ℝ)}
```

The witness window is positive, finite, and inclusive at both endpoints. The
sublevel comparison is strict.

### 5. `IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_finiteCenteredBadBlockSet`

```lean
theorem nullMeasurableSet_finiteCenteredBadBlockSet
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (m : ℕ) (c : ℝ) :
    NullMeasurableSet (finiteCenteredBadBlockSet T X m c) μ
```

Finite centered integrability makes each strict sublevel set null measurable;
a finite binary union closes the construction.

### 6. `IsIntegrableSubadditiveProcessCandidate.centeredProcess_le_badBlockVisitCount`

```lean
theorem centeredProcess_le_badBlockVisitCount
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (H m : ℕ) (hHm : H + m ≠ 0) (c : ℝ) (hc : c ≤ 0) (ω : Ω) :
    centeredProcess T X (H + m) ω ≤
      c * (finiteOrbitVisitCount T
        (finiteCenteredBadBlockSet T X m c) H ω : ℝ)
```

This theorem is pointwise and purely finite after the candidate structure is
available. It assumes neither a finite measure nor preservation.

### 7. `IsIntegrableSubadditiveProcessCandidate.measureReal_finiteCenteredBadBlockSet_le_rateRatio`

```lean
theorem measureReal_finiteCenteredBadBlockSet_le_rateRatio
    [IsFiniteMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (m : ℕ) (δ c : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ))
    (hc : c < δ) :
    μ.real (finiteCenteredBadBlockSet T X m c) ≤ δ / c
```

This is the generic finite-measure endpoint. No probability or ergodicity
typeclass appears.

### 8. `DiscreteMatrixCocycle.centeredLogPlusBadBlockSet`

```lean
def centeredLogPlusBadBlockSet
    (C : DiscreteMatrixCocycle (ι := ι) μ) (m : ℕ) (c : ℝ) : Set Ω :=
  finiteCenteredBadBlockSet C.base C.logPlusNormObservable m c
```

This is a thin cocycle-facing name for the generic bad set.

### 9. `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.centeredFeketeOffset_le_normalizedIntegral`

```lean
theorem HasIntegrableGeneratorLogPlus.centeredFeketeOffset_le_normalizedIntegral
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (n : ℕ) (hn : n ≠ 0) :
    C.integratedLogPlusGrowthRate hC - C.integratedLogPlusNorm 1 ≤
      (∫ ω, centeredProcess C.base C.logPlusNormObservable n ω ∂μ) /
        (n : ℝ)
```

Extracts the reusable numerical bridge from the deterministic integrated
Fekete rate to every positive normalized centered integral. It uses the
RMT-29 centered-integral identity and requires no finite-measure, probability,
or ergodicity typeclass.

### 10. `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusBadBlockSet_le_rateRatio`

```lean
theorem HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusBadBlockSet_le_rateRatio
    [IsFiniteMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (m : ℕ) (c : ℝ)
    (hc : c < C.integratedLogPlusGrowthRate hC -
      C.integratedLogPlusNorm 1) :
    μ.real (C.centeredLogPlusBadBlockSet m c) ≤
      (C.integratedLogPlusGrowthRate hC -
        C.integratedLogPlusNorm 1) / c
```

The index type needs `Fintype` and `DecidableEq`, but not `Nonempty`.

## Complete local proof-step ledger

This ledger follows the executable source from top to bottom. It includes the
named local `let` and `have` steps, plus the short tactic chains in the small
declarations, so a reader can reconstruct the proof without searching the
file.

| Declaration | Local step, in source order | Job |
|---|---|---|
| `finiteOrbitVisitCount` | `classical`; filtered range card | Makes arbitrary set membership decidable locally and returns the count |
| Cast identity | unfold count; cast filtered card; unfold `birkhoffSum`; `sum_congr`; membership case split | Proves every summand is the same zero-or-one test |
| Visit integral | rewrite cast identity; apply `integral_birkhoffSum_eq_nat_mul`; use `indicator₀`; evaluate `integral_indicator₀` and `setIntegral_const` | Converts the finite count to \(H\mu(s)\) |
| Bad-set null measurability | finite null-measurable bi-union; fix \(n\); `nullMeasurableSet_lt` | Uses centered integrability against the measurable constant threshold |
| Pointwise packing | `marked` | Filters starts \(j\lt H\) that visit the finite bad set |
| Pointwise packing | `hexists` | Unpacks union membership into one witness \(n\in[1,m]\) and a strict cost inequality |
| Inside `hexists` | `hjbad` | Extracts finite bad-set membership from membership in the filtered marked-start set |
| Pointwise packing | `length` | Chooses a witness on marked starts and defaults to one elsewhere |
| Pointwise packing | `hlength_mem` | Records membership of the chosen length in `Finset.Icc 1 m` |
| Pointwise packing | `hlength_cost` | Records the strict centered cost of the chosen witness |
| Pointwise packing | `hmarked` | Shows all marked starts lie in `Finset.range H` |
| Pointwise packing | `hlength` | Splits interval membership into \(0\lt\ell(j)\) and \(\ell(j)\le m\) |
| Pointwise packing | `hcost` | Weakens strict witness cost to the non-strict packing premise |
| Pointwise packing | `hpack` | Calls RMT-21 `le_mul_card_of_greedy_cover` |
| Pointwise packing | final `simpa` | Unfolds `marked` and identifies its card with `finiteOrbitVisitCount` |
| Ratio theorem | `s` | Abbreviates the finite bad set |
| Ratio theorem | `hs` | Obtains null measurability from public declaration 5 |
| Ratio theorem | `hδnonpos` | Specializes `hδ` at one and simplifies `centeredProcess_one` to prove \(\delta\le0\) |
| Ratio theorem | `hcneg` | Composes \(c\lt\delta\) with \(\delta\le0\) |
| Ratio theorem | `hfinite` | Packages the finite-horizon inequality for every nonzero \(H\) |
| Inside `hfinite` | `hHm` | Uses arithmetic to prove \(H+m\ne0\) |
| Inside `hfinite` | `hcenterInt` | Gets integrability of \(Y_{H+m}\) |
| Inside `hfinite` | `hindicator` | Gets integrability of the constant-one indicator of \(s\) |
| Inside `hfinite` | `hcount` | Rewrites the count function extensionally as a Birkhoff sum and proves integrability |
| Inside `hfinite` | `hpoint` | Instantiates the pointwise packing theorem using \(c\le0\) |
| Inside `hfinite` | `hintle` | Applies integral monotonicity, pulls out \(c\), and evaluates the visit integral |
| Inside `hfinite` | `hdenom` | Records nonnegativity of the real cast of \(H+m\) |
| Inside `hfinite` | `hquot` | Chains the lower-rate premise with division monotonicity |
| Inside `hfinite` | cast rewrite and ring calculation | Rewrites \(H+m\) over reals and isolates \(H/(H+m)\) |
| Ratio theorem | `hlim` | Proves the correction factor tends to one |
| Ratio theorem | `hδmul` | Uses `ge_of_tendsto` and eventual nonzero horizons to obtain \(\delta\le c\mu(s)\) |
| Ratio theorem | negative-division rewrite | Applies `le_div_iff_of_neg hcneg` and commutes multiplication |
| Centered Fekete bridge | `hX` | Retrieves the generic integrable subadditive candidate |
| Centered Fekete bridge | `hnR` | Casts \(n\ne0\) into a nonzero real denominator |
| Centered Fekete bridge | `hrate` | Retrieves `integratedLogPlusGrowthRate_le_normalized` |
| Centered Fekete bridge | two rewrites | Exposes the normalized integral and exact centered-integral formula |
| Centered Fekete bridge | subtraction comparison and `field_simp` | Subtracts the one-step integral and proves the quotient identity |
| Cocycle ratio theorem | `δ` | Names the integrated Fekete offset |
| Cocycle ratio theorem | `hX` | Retrieves the generic integrable subadditive candidate |
| Cocycle ratio theorem | `hδ` | Reuses the public centered Fekete bridge at every positive length |
| Cocycle ratio theorem | final `simpa` | Instantiates the generic ratio theorem and unfolds the thin wrapper |

## Private boundary-support declarations

The source next introduces eleven private items. They are compiled support for
the anonymous probes and do not enlarge the public API.

| Order | Private item | Construction or proof |
|---:|---|---|
| 1 | `rmt30ZeroProcess` | Constant zero at every time and point |
| 2 | `rmt30ZeroProcess_candidate` | `integrable_zero`; subadditivity by simplification |
| 3 | `rmt30PositiveAtZeroProcess` | Value one at time zero, zero otherwise |
| 4 | `rmt30PositiveAtZeroProcess_candidate` | Zero-measure integrability; four cases on whether the two times vanish |
| 5 | `rmt30TwoPointProbability` | Half the sum of Dirac masses at `false` and `true` |
| 6 | private `IsProbabilityMeasure rmt30TwoPointProbability` instance | Checks that the two half masses sum to one |
| 7 | `rmt30Id_not_preErgodic` | Uses the invariant singleton `{false}` and computes that neither it nor its complement has zero measure |
| 8 | `rmt30TwoPointProcess` | Equals −(`n - 1`) on `false` and zero on `true` |
| 9 | `rmt30TwoPointProcess_candidate` | Proves finite integrability and shifted subadditivity of the two-atom process |
| 10 | `rmt30MassTwoMeasure` | Twice the Dirac measure on `Unit` |
| 11 | private `IsFiniteMeasure rmt30MassTwoMeasure` instance | Infers finite measure after unfolding the scalar multiple |

## Nine compiled boundary probes in exact source order

{{< reference-figure
  wide="true"
  src="rmt30-boundary-probe-grid.svg"
  alt="A three by three grid lists the nine compiled boundaries: zero length cap, zero horizon with positive cap, zero process, joint zero corner failure, zero measure, nonergodic preserved identity, strict-threshold equality, mass-two finite measure, and empty matrix index."
  caption="**Compiled boundary grid:** the nine anonymous examples protect empty windows, totalized zero cases, strictness, nonprobability finite measures, nonergodicity, and empty matrix dimensions. Only the joint corner \(H=m=0\) is proved false."
>}}

1. **Zero length cap.** `finiteCenteredBadBlockSet T X 0 c = ∅` because
   `Finset.Icc 1 0` is empty.
2. **Zero horizon with positive cap.** The pointwise packing inequality still
   holds at \(H=0\) when \(m\ne0\). The right side is zero, and centered
   nonpositivity controls the left side.
3. **Zero process with negative threshold.** No positive length can satisfy
   \(0\lt cn\) when \(c\lt0\), so the finite bad set is empty.
4. **Joint zero corner is genuinely false.** For the process equal to one only
   at time zero, \(Y_0=1\), while the horizon-zero visit count is zero. This
   refutes the pointwise theorem with \(H=m=0\).
5. **Zero measure.** Every finite centered bad set has real measure zero,
   independently of the process or threshold.
6. **Preserved nonergodic identity.** The two-point identity is not
   pre-ergodic. For the process equal to −(`n - 1`) on one atom and zero on
   the other, the bad set at \(m=5\) and \(c=-3/4\) is exactly the first atom.
   Its measure is \(1/2\), and the generic theorem proves the genuine bound
   \(1/2\le(-1/2)/(-3/4)=2/3\). This exercises the ratio while compiling the
   absence of an ergodicity premise.
7. **Strict-threshold equality.** At length one and threshold zero, the
   centered value equals zero, so strict `<` marks no point.
8. **Finite-measure rescaling.** A mass-two measure on `Unit` satisfies the
   theorem. Probability normalization is not hidden in the proof.
9. **Empty matrix index.** The cocycle endpoint compiles with `ι := Empty`.
   No coordinate choice or nonempty-index premise is required.

## Complete source-order map

| Order | Kind | Source item |
|---:|---|---|
| 1 | Public definition | `finiteOrbitVisitCount` |
| 2 | Public theorem | `natCast_finiteOrbitVisitCount_eq_birkhoffSum_indicator` |
| 3 | Public theorem | `integral_finiteOrbitVisitCount` |
| 4 | Public definition | `finiteCenteredBadBlockSet` |
| 5 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_finiteCenteredBadBlockSet` |
| 6 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.centeredProcess_le_badBlockVisitCount` |
| 7 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.measureReal_finiteCenteredBadBlockSet_le_rateRatio` |
| 8 | Public cocycle definition | `DiscreteMatrixCocycle.centeredLogPlusBadBlockSet` |
| 9 | Public cocycle receiver theorem | `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.centeredFeketeOffset_le_normalizedIntegral` |
| 10 | Public cocycle receiver theorem | `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusBadBlockSet_le_rateRatio` |
| 11 | Private boundary definition | `rmt30ZeroProcess` |
| 12 | Private boundary theorem | `rmt30ZeroProcess_candidate` |
| 13 | Private boundary definition | `rmt30PositiveAtZeroProcess` |
| 14 | Private boundary theorem | `rmt30PositiveAtZeroProcess_candidate` |
| 15 | Private boundary definition | `rmt30TwoPointProbability` |
| 16 | Private boundary instance | `IsProbabilityMeasure rmt30TwoPointProbability` |
| 17 | Private boundary theorem | `rmt30Id_not_preErgodic` |
| 18 | Private boundary definition | `rmt30TwoPointProcess` |
| 19 | Private boundary theorem | `rmt30TwoPointProcess_candidate` |
| 20 | Private boundary definition | `rmt30MassTwoMeasure` |
| 21 | Private boundary instance | `IsFiniteMeasure rmt30MassTwoMeasure` |
| 22 | Anonymous example | Zero length cap gives the empty bad set |
| 23 | Anonymous example | Zero horizon is valid for positive cap |
| 24 | Anonymous example | Zero process and negative threshold give the empty bad set |
| 25 | Anonymous example | Joint zero corner refutation |
| 26 | Anonymous example | Zero measure gives zero real bad-set measure |
| 27 | Anonymous example | Nonergodic two-atom system has a half-mass bad set and a nontrivial ratio bound |
| 28 | Anonymous example | Equality at the strict threshold is unmarked |
| 29 | Anonymous example | Mass-two finite-measure rescaling |
| 30 | Anonymous example | Empty matrix-index cocycle endpoint |
| 31 | Axiom audit | Cast identity |
| 32 | Axiom audit | Visit-count integral |
| 33 | Axiom audit | Bad-set null measurability |
| 34 | Axiom audit | Pointwise packing inequality |
| 35 | Axiom audit | Generic rate-ratio theorem |
| 36 | Axiom audit | Centered Fekete offset lower bound |
| 37 | Axiom audit | Cocycle rate-ratio theorem |

## Seven axiom reports

The module ends with seven `#print axioms` commands in the same theorem order as
the mathematical dependency chain. A warning-fatal Lean run reports:

```text
'NonlinearDynamics.Random.RandomCocycles.natCast_finiteOrbitVisitCount_eq_birkhoffSum_indicator'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.integral_finiteOrbitVisitCount'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_finiteCenteredBadBlockSet'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.centeredProcess_le_badBlockVisitCount'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.measureReal_finiteCenteredBadBlockSet_le_rateRatio'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.centeredFeketeOffset_le_normalizedIntegral'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusBadBlockSet_le_rateRatio'
depends on axioms: [propext, Classical.choice, Quot.sound]
```

These are the standard logical and quotient principles inherited through
Lean and Mathlib. No project-specific axiom appears.

## Assumption and conclusion ledger

| Layer | Required assumptions | Exact output | Explicitly absent |
|---|---|---|---|
| Visit-count cast | Function, set, finite horizon | Count cast equals indicator Birkhoff sum | Measurability, measure, preservation |
| Visit-count integral | Finite measure, preservation, null-measurable set | Integral equals \(H\mu(s)\) | Probability, ergodicity |
| Bad-set null measurability | Integrable candidate, preservation | `NullMeasurableSet B_{m,c}` | Finite total mass, threshold sign |
| Pointwise packing | Candidate, \(H+m\ne0\), \(c\le0\) | \(Y_{H+m}\le c\times\) visit count | Any measure hypothesis |
| Generic ratio | Finite measure, preservation, normalized lower rate, \(c\lt\delta\) | \(\mu(B_{m,c})\le\delta/c\) | Probability, ergodicity, nonnegativity of \(X\) |
| Cocycle ratio | Finite measure, integrable generator log-positive norm, strict threshold | Same bound with the integrated Fekete offset | Ergodicity, nonempty index, signed logarithm |

The generic theorem does not assume pointwise nonnegativity of \(X\). Its
centered process has the nonpositive property required by the finite packing
theorem because of the candidate's one-step majorant. This differs from
RMT-29, where nonnegativity was needed for the real-valued limsup API.

## Common wrong turns

### Treating the ratio as a probability bound

`μ.real` is the real-valued measure of the set. It need not be at most one.
The mass-two boundary probe is deliberate. Calling the left side a
probability is correct only after adding a probability-measure assumption.

### Forgetting that the divisor is negative

From \(\delta\le c\mu(B)\), division by \(c\lt0\) reverses the direction. Any
derivation that divides before proving `hcneg` is incomplete.

### Replacing strict `<` by `≤`

The bad-set definition uses a strict sublevel set. The length-one equality
probe compiles that choice. A closed-threshold theorem would have a different
boundary and would require separate proof work.

### Letting `m` become infinity silently

The theorem controls a finite union. Passing to all lengths requires an
increasing-union argument and a correctly identified limiting set. That is a
separate theorem now supplied by RMT-31, not notation hidden inside RMT-30.

### Reading the auxiliary limit as process convergence

Only \(H/(H+m)\to1\) is used. There is no proof that \(X_n/n\) or \(Y_n/n\)
converges samplewise.

### Adding ergodicity to explain preservation

Ergodicity is stronger than needed. The generic theorem consumes a
`MeasurePreserving` witness directly, and the nonergodic identity probe
ensures that boundary remains visible.

### Forgetting the time-zero exception

The candidate interface does not force \(X_0\le0\). Therefore the pointwise
packing theorem excludes exactly \(H+m=0\). The positive-at-zero process
shows this is a semantic boundary, not a tactic inconvenience.

### Calling log-positive growth a Lyapunov exponent

The observable clips logarithmic contraction at zero. The cocycle theorem is
about a nonnegative envelope and cannot recover signed exponential rates or
invariant subspaces.

## Twenty-four solved exercises

### Exercise 1: expand the orbit count

Compute `finiteOrbitVisitCount T s 3 ω` in words.

**Solution.** It is the number of true membership tests among
\(\omega\in s\), \(T\omega\in s\), and \(T^2\omega\in s\).

### Exercise 2: check horizon zero

What is the count at \(H=0\)?

**Solution.** `Finset.range 0` is empty, so the filtered card is zero.

### Exercise 3: derive the indicator identity

Why does the cast of the filtered card equal the indicator sum?

**Solution.** At each index, both sides contribute one when the orbit point
belongs to the set and zero otherwise; finite sum congruence finishes.

### Exercise 4: locate finite total mass

Why does `integral_finiteOrbitVisitCount` assume `IsFiniteMeasure μ`?

**Solution.** It needs the constant-one function, and hence its indicator, to
be integrable. The combinatorial cast identity does not need this assumption.

### Exercise 5: explain null measurability

Why is ordinary measurability not required for the visited set?

**Solution.** Bochner integration is insensitive to completion-null changes,
and Mathlib's `indicator₀` and `integral_indicator₀` accept a
`NullMeasurableSet`.

### Exercise 6: empty the witness window

Evaluate \(B_{0,c}\).

**Solution.** There is no natural \(n\) satisfying \(1\le n\le0\), so the
finite union is empty.

### Exercise 7: test equality

If \(Y_n(\omega)=cn\), is \(\omega\) marked by length \(n\)?

**Solution.** No. Membership requires the strict inequality \(Y_n\lt cn\).

### Exercise 8: find the time-one center

Compute \(Y_1\).

**Solution.** The one-step Birkhoff sum of \(X_1\) is exactly \(X_1\), so
\(Y_1=X_1-X_1=0\).

### Exercise 9: force the rate sign

Use Exercise 8 to constrain \(\delta\).

**Solution.** Apply the lower-rate premise at \(n=1\):
\(\delta\le\int Y_1=0\).

### Exercise 10: force the threshold sign

What follows from \(c\lt\delta\le0\)?

**Solution.** Transitivity gives \(c\lt0\).

### Exercise 11: explain the default length

Why does the `length` function return one at unmarked starts?

**Solution.** Lean needs a total function on naturals. The packing theorem
queries its positivity and cost only for marked starts, so the default is
irrelevant.

### Exercise 12: weaken the witness cost

Why change \(Y_{\ell(j)}\lt c\ell(j)\) to `≤`?

**Solution.** Strict inequality implies non-strict inequality, matching the
imported packing theorem's premise.

### Exercise 13: explain the tail `m`

Why does the pointwise target use \(H+m\) rather than \(H\)?

**Solution.** A marked start just before \(H\) may carry a witness interval of
length as large as \(m\); the enlarged endpoint contains every selected
interval.

### Exercise 14: isolate the false corner

Why is \(H=m=0\) excluded?

**Solution.** Then the target is \(Y_0=X_0\), which the candidate interface
does not force nonpositive, while the visit count is zero.

### Exercise 15: integrate the right side

What is \(\int c\operatorname{visits}_{B,H}\,d\mu\)?

**Solution.** Pull out the scalar and use the visit identity to obtain
\(cH\mu(B)\).

### Exercise 16: normalize the finite inequality

Why does the factor \(H/(H+m)\) appear?

**Solution.** The lower-rate premise divides the centered integral at horizon
\(H+m\) by \(H+m\), while the visit integral contributes a factor \(H\).

### Exercise 17: pass to the horizon limit

What happens to the correction factor for fixed \(m\)?

**Solution.** \(H/(H+m)\to1\) as natural \(H\to\infty\).

### Exercise 18: divide with the correct order

From \(\delta\le c\mu(B)\) and \(c\lt0\), derive the result.

**Solution.** Negative division reverses order, giving
\(\mu(B)\le\delta/c\).

### Exercise 19: inspect zero measure

What does the theorem say when \(\mu=0\)?

**Solution.** Every real set measure is zero, and the compiled boundary probe
computes the left side as zero.

### Exercise 20: reject hidden ergodicity

Which compiled model instantiates the theorem without ergodicity?

**Solution.** The identity map on the two-point probability space is not
pre-ergodic. In the compiled model, the finite bad set is one atom of mass
\(1/2\), and the theorem proves the nontrivial bound \(1/2\le2/3\).

### Exercise 21: reject hidden probability

Which compiled model instantiates the theorem without total mass one?

**Solution.** `rmt30MassTwoMeasure` has total mass two and still satisfies the
generic theorem.

### Exercise 22: build the cocycle rate premise

Which two ingredients establish `hδ` in the specialization?

**Solution.** The integrated Fekete rate is below each positive normalized
block integral, and RMT-29 computes the centered integral by subtracting
\(n\) times the one-step integral.

### Exercise 23: audit the empty index

Why can `ι := Empty` compile?

**Solution.** The endpoint assumes finite decidable equality but never
chooses a coordinate, so no `Nonempty ι` instance is required.

### Exercise 24: state the next missing bridge

What must happen before this result can contribute to a lower-liminf theorem?

**Solution.** One must pass from the increasing family of finite bad sets to
the all-length bad event with the correct measure-continuity argument, then
connect absence or smallness of that event to an eventual samplewise lower
bound. RMT-31 now proves the first bridge; the asymptotic bridge remains open.

## Reproduction and audit

The frozen source inspected for this note has 506 lines and SHA-256
`a8aee618a10f8434c1c33d8e433fd77e98ed3e5c8dee399e7d6fa323c5079b28`.

Build the leaf module with warnings fatal:

```text
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/SubadditiveBadBlockMeasure.lean
```

Regenerate and verify the page-owned social card from any working directory:

```text
site/content/development-notebook/2026/07/finite-centered-bad-block-measure-control-in-lean/generate-card.sh
site/content/development-notebook/2026/07/finite-centered-bad-block-measure-control-in-lean/generate-card.sh --verify
```

Validate the site after the shared coverage and navigation surfaces are
updated in their own release step:

```text
make content-coverage
make content-hygiene
make site-check
```

## Discussion

RMT-30 changes the epistemic status of one narrow bridge. Before this module,
the development had a checked finite interval-packing theorem and an upper
limsup theorem, but no checked theorem that converted short centered-block
witnesses into a quantitative finite-measure bound. The new source now checks
that conversion, including the exact visit integral, sign reversal, and
finite-horizon correction.

The formalization clarifies three often hidden distinctions. Counting is
combinatorial before it is measurable. Preservation is enough for exact
finite visit integration, while ergodicity is irrelevant. A finite measure is
enough, so the result controls real measure rather than necessarily
probability. The two nonprobability probes and the nonergodic probe make those
distinctions executable rather than editorial.

The required epistemic downgrade is substantial. A bound for each finite
witness cap is not an infinite-horizon bad-event theorem. An auxiliary limit
of \(H/(H+m)\) is not convergence of the normalized process. The cocycle
offset uses log-positive norms and is not a signed Lyapunov exponent. Thus
RMT-30 advances one finite-measure component of a Kingman route while leaving
the lower liminf, equality, and convergence layers open.

## Navigation: previous and next milestones

**Previous, RMT-29:**
[Subadditive Upper Limsup Bounds from Phase Averaging in Lean]({{< relref "/development-notebook/2026/07/subadditive-upper-limsup-from-phase-averaging-in-lean" >}})
proves the complementary samplewise upper-limsup ceiling and supplies the
centered-integral identity reused in the cocycle specialization.

**Next, RMT-31:**
[All-Positive-Length Centered Bad-Block Control in Lean]({{< relref "/development-notebook/2026/07/all-positive-length-centered-bad-block-control-in-lean" >}})
identifies the increasing union over length caps, proves extended-measure and
finite-real-measure continuity, and passes this chapter's uniform ratio to the
uncapped event. Its compiled countermodel also shows why that raw once-bad
event must not be called invariant.

## References

<a id="ref-rmt30-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://academic.oup.com/jrsssb/article/30/3/499/7026968),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968,
[doi:10.1111/j.2517-6161.1968.tb00749.x](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x).
This is the primary historical theorem source. Its full result is stronger
than RMT-30.

<a id="ref-rmt30-steele"></a>**J. Michael Steele.**
[Kingman's subadditive ergodic theorem](https://www.numdam.org/item/AIHPB_1989__25_1_93_0/),
*Annales de l'Institut Henri Poincaré, Probabilités et Statistiques* 25(1),
93-98, 1989, MR 995293, Zbl 0669.60039. Section 2 gives an algorithmic
interval-decomposition proof related to the finite packing architecture.

<a id="ref-rmt30-lalley"></a>**Steven P. Lalley.**
[Kingman's Subadditive Ergodic Theorem](https://galton.uchicago.edu/~lalley/Courses/Graz/Kingman.pdf),
University of Chicago lecture notes, undated, accessed 2026-07-22. Pages 2-3
give the closest prose blueprint for bad starts and leftmost selection. These
notes are pedagogical context, not the primary theorem source, and RMT-21's
checked half-open formulation governs the present endpoint conventions.

<a id="ref-rmt30-mathlib-birkhoff"></a>**Mathlib contributors.**
[Birkhoff sums](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Basic.lean),
Mathlib commit `81a5d257`. The pinned source defines `birkhoffSum` and its
finite-sum interface.

<a id="ref-rmt30-mathlib-indicator"></a>**Mathlib contributors.**
[Bochner integration over sets](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Integral/Bochner/Set.lean),
Mathlib commit `81a5d257`. The pinned source contains `integral_indicator₀`.

<a id="ref-rmt30-mathlib-null"></a>**Mathlib contributors.**
[Null-measurable sets](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/NullMeasurable.lean),
Mathlib commit `81a5d257`. The pinned source contains finite
null-measurable bi-union closure.

<a id="ref-rmt30-rmt21"></a>**This project.**
[Ordered Disjoint Interval Packing for Subadditive Cocycles]({{< relref "/development-notebook/2026/07/ordered-disjoint-interval-packing-for-subadditive-cocycles" >}}),
RMT-21. This checked predecessor supplies
`OrderedNatIntervalPacking.le_mul_card_of_greedy_cover`.

<a id="ref-rmt30-rmt29"></a>**This project.**
[Subadditive Upper Limsup Bounds from Phase Averaging in Lean]({{< relref "/development-notebook/2026/07/subadditive-upper-limsup-from-phase-averaging-in-lean" >}}),
RMT-29. This predecessor supplies exact finite Birkhoff-sum integration and
the centered-integral identity used by the cocycle wrapper.
