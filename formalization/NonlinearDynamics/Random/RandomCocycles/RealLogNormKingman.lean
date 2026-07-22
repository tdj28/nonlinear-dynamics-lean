import NonlinearDynamics.Random.RandomCocycles.RealLogNormIntegrability

/-!
# Signed Kingman convergence for invertible matrix cocycles

`RealLogNormIntegrability` constructs the contraction-sensitive observable

`X n ω = Real.log ‖C.value n ω‖`

and proves that pointwise generator invertibility together with integrable
forward and inverse log-positive tails makes every finite horizon integrable.
This module completes the corresponding pre-ergodic probability theorem.

The deterministic side starts from the signed integrals

`a n = ∫ ω, X n ω ∂μ`.

Preservation removes the shifted base point from the integral, so signed
subadditivity of `X` makes `a` subadditive.  The inverse-generator Birkhoff
sum supplies the uniform linear lower bound

`-n ∫ log⁺ ‖C.generator⁻¹‖ ≤ a n`.

Thus the normalized signed integrals are genuinely bounded below, and
Mathlib's finite-valued Fekete theorem gives their limit.  The rate is also
exposed as the infimum over strictly positive horizons; time zero remains a
totalized convenience rather than an admissible block length.

The samplewise proof deliberately keeps the two Kingman rails separate.  The
lower-liminf rail reuses the centered lower-deviation theorem from
`SubadditiveKingman`.  The upper-limsup rail uses the generalized phase-
averaging theorem from `SubadditiveUpperLimsup`, whose honest hypothesis is
eventual lower boundedness of the normalized sample path.  Pointwise
invertibility supplies exactly that hypothesis: the negative inverse-
generator Birkhoff average lies below the normalized signed logarithm, and
the pointwise Birkhoff theorem makes this lower comparison bounded almost
everywhere.  No positivity of the signed observable is asserted or needed.

Under `PreErgodic C.base μ` on a probability space, the two rails squeeze the
normalized real logarithmic norm to the deterministic signed Fekete rate
almost everywhere.  The theorem asks for no ergodicity of powered maps and no
nonempty matrix-index assumption; empty dimension is recorded explicitly as
rate zero.  When the older log-positive rate is strictly positive, uniqueness
of limits identifies the two deterministic rates.

This module proves pointwise signed convergence only.  It proves no `L¹`
convergence, uniform integrability of the signed normalized family,
limit-integral interchange, convergence rate, concentration bound,
singular-value or conorm limit, Lyapunov spectrum, invariant splitting,
Oseledets theorem, derivative-cocycle theorem, or stable-manifold theorem.
-/

open Matrix MeasureTheory Set Filter Topology
open scoped Matrix.Norms.Operator Real

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle

universe uΩ uι

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-! ## Signed finite-horizon integrals -/

/-- The raw integral of the total real logarithmic norm at horizon `k`.

This is a signed real integral, not the nonnegative log-positive envelope and
not a normalized average.  Like every bare Bochner integral in Mathlib, the
definition is total even before an integrability hypothesis is supplied;
later theorems use `HasIntegrableGeneratorLogTails` to recover its analytic
meaning. -/
def integratedRealLogNorm
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : ℝ :=
  ∫ ω, C.realLogNormObservable k ω ∂μ

/-- The signed integral is zero at the identity horizon. -/
@[simp] theorem integratedRealLogNorm_zero
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.integratedRealLogNorm 0 = 0 := by
  simp [integratedRealLogNorm]

/-- In empty matrix dimension every finite-horizon signed integral is zero. -/
@[simp] theorem integratedRealLogNorm_eq_zero_of_isEmpty [IsEmpty ι]
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    C.integratedRealLogNorm k = 0 := by
  simp [integratedRealLogNorm]

/-- Measure preservation makes the signed finite-horizon integral invariant
under every iterate of the cocycle base map. -/
theorem integral_realLogNormObservable_at_base_iterate_eq
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k j : ℕ) :
    (∫ ω, C.realLogNormObservable k (C.base^[j] ω) ∂μ) =
      C.integratedRealLogNorm k := by
  have hpres := C.base_iterate_preserving j
  have hstrong : AEStronglyMeasurable (C.realLogNormObservable k)
      (Measure.map (C.base^[j]) μ) :=
    (C.measurable_realLogNormObservable k).aestronglyMeasurable
  calc
    (∫ ω, C.realLogNormObservable k (C.base^[j] ω) ∂μ) =
        ∫ x, C.realLogNormObservable k x ∂Measure.map (C.base^[j]) μ :=
      (integral_map hpres.measurable.aemeasurable hstrong).symm
    _ = C.integratedRealLogNorm k := by rw [hpres.map_eq]; rfl

/-- Two-sided generator-tail integrability turns pointwise signed cocycle
subadditivity into subadditivity of the integrated sequence. -/
theorem HasIntegrableGeneratorLogTails.integratedRealLogNorm_add_le
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) (m k : ℕ) :
    C.integratedRealLogNorm (m + k) ≤
      C.integratedRealLogNorm m + C.integratedRealLogNorm k := by
  have hk := hC.integrable_realLogNormObservable k
  have hm := hC.integrable_realLogNormObservable m
  have hmk := hC.integrable_realLogNormObservable (m + k)
  have hkShift : Integrable
      (fun ω ↦ C.realLogNormObservable k (C.base^[m] ω)) μ := by
    change Integrable (C.realLogNormObservable k ∘ C.base^[m]) μ
    exact (C.base_iterate_preserving m).integrable_comp_of_integrable hk
  calc
    C.integratedRealLogNorm (m + k) ≤
        ∫ ω, (C.realLogNormObservable k (C.base^[m] ω) +
          C.realLogNormObservable m ω) ∂μ := by
      apply integral_mono hmk (hkShift.add hm)
      exact hC.isPointwiseInvertible.realLogNormObservable_add_le m k
    _ = (∫ ω, C.realLogNormObservable k (C.base^[m] ω) ∂μ) +
        C.integratedRealLogNorm m := by
      rw [integral_add hkShift hm]
      rfl
    _ = C.integratedRealLogNorm k + C.integratedRealLogNorm m := by
      rw [C.integral_realLogNormObservable_at_base_iterate_eq k m]
    _ = C.integratedRealLogNorm m + C.integratedRealLogNorm k := add_comm _ _

/-- The signed integrated real-log sequence is subadditive. -/
theorem HasIntegrableGeneratorLogTails.subadditive_integratedRealLogNorm
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) :
    Subadditive C.integratedRealLogNorm :=
  hC.integratedRealLogNorm_add_le

/-! ## Linear lower and upper controls -/

/-- The one-step integral of the inverse-generator log-positive norm.

Its negative is the uniform lower control for normalized signed growth. -/
def integratedInverseGeneratorLogPlusNorm
    (C : DiscreteMatrixCocycle (ι := ι) μ) : ℝ :=
  ∫ ω, C.inverseGeneratorLogPlusNormObservable ω ∂μ

/-- The integrated inverse-generator log-positive norm is nonnegative. -/
theorem integratedInverseGeneratorLogPlusNorm_nonneg
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    0 ≤ C.integratedInverseGeneratorLogPlusNorm := by
  apply integral_nonneg
  intro ω
  exact Real.posLog_nonneg

/-- The abstract Birkhoff sum of the inverse-generator observable is
definitionally the forward-orbit inverse-tail sum used by the cocycle API. -/
@[simp] theorem birkhoffSum_inverseGeneratorLogPlusNormObservable_eq
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    birkhoffSum C.base C.inverseGeneratorLogPlusNormObservable k =
      C.inverseOrbitLogPlusSum k := by
  rfl

/-- Preservation and integrability turn the inverse-orbit sum integral into
horizon times its one-step integral.  No forward-tail or invertibility
hypothesis is consumed here. -/
theorem integral_inverseOrbitLogPlusSum_eq
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (hintegrable : Integrable C.inverseGeneratorLogPlusNormObservable μ)
    (k : ℕ) :
    (∫ ω, C.inverseOrbitLogPlusSum k ω ∂μ) =
      k * C.integratedInverseGeneratorLogPlusNorm := by
  rw [← C.birkhoffSum_inverseGeneratorLogPlusNormObservable_eq k]
  exact integral_birkhoffSum_eq_nat_mul C.base_preserving
    hintegrable k

/-- The integrated signed logarithm is bounded below by the negative linear
inverse-tail cost. -/
theorem HasIntegrableGeneratorLogTails.neg_nat_mul_integratedInverseGeneratorLogPlusNorm_le_integratedRealLogNorm
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) (k : ℕ) :
    -(k * C.integratedInverseGeneratorLogPlusNorm) ≤
      C.integratedRealLogNorm k := by
  calc
    -(k * C.integratedInverseGeneratorLogPlusNorm) =
        ∫ ω, -C.inverseOrbitLogPlusSum k ω ∂μ := by
      rw [integral_neg]
      rw [C.integral_inverseOrbitLogPlusSum_eq
        hC.integrable_inverseGeneratorLogPlus k]
    _ ≤ C.integratedRealLogNorm k := by
      apply integral_mono
      · exact (hC.integrable_inverseOrbitLogPlusSum k).neg
      · exact hC.integrable_realLogNormObservable k
      · exact
          hC.isPointwiseInvertible.neg_inverseOrbitLogPlusSum_le_realLogNormObservable k

/-- The signed integrated logarithm lies below its log-positive envelope at
every horizon. -/
theorem HasIntegrableGeneratorLogTails.integratedRealLogNorm_le_integratedLogPlusNorm
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) (k : ℕ) :
    C.integratedRealLogNorm k ≤ C.integratedLogPlusNorm k := by
  apply integral_mono
  · exact hC.integrable_realLogNormObservable k
  · exact hC.hasIntegrableGeneratorLogPlus.integrable_logPlusNormObservable k
  · exact C.realLogNormObservable_le_logPlusNormObservable k

/-- The signed integrated logarithm has the same one-step linear upper bound
as the log-positive envelope. -/
theorem HasIntegrableGeneratorLogTails.integratedRealLogNorm_le_nat_mul
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) (k : ℕ) :
    C.integratedRealLogNorm k ≤ k * C.integratedLogPlusNorm 1 :=
  (hC.integratedRealLogNorm_le_integratedLogPlusNorm k).trans
    (hC.hasIntegrableGeneratorLogPlus.integratedLogPlusNorm_le_nat_mul k)

/-! ## The signed integrated Fekete rate -/

/-- The totalized normalized signed integral `a k / k`.

At `k = 0`, Lean's division convention makes this zero.  Fekete infima below
use only horizons in `Ici 1`. -/
def normalizedIntegratedRealLogNorm
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : ℝ :=
  C.integratedRealLogNorm k / k

/-- The totalized normalized signed integral is zero at time zero. -/
@[simp] theorem normalizedIntegratedRealLogNorm_zero
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.normalizedIntegratedRealLogNorm 0 = 0 := by
  simp [normalizedIntegratedRealLogNorm]

/-- Empty matrix dimension has zero normalized signed integral at every
horizon, including the totalized zero horizon. -/
@[simp] theorem normalizedIntegratedRealLogNorm_eq_zero_of_isEmpty [IsEmpty ι]
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    C.normalizedIntegratedRealLogNorm k = 0 := by
  simp [normalizedIntegratedRealLogNorm]

/-- Every normalized signed integral lies above the negative one-step
inverse-tail cost, including the totalized time-zero value. -/
theorem HasIntegrableGeneratorLogTails.neg_integratedInverseGeneratorLogPlusNorm_le_normalizedIntegratedRealLogNorm
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) (k : ℕ) :
    -C.integratedInverseGeneratorLogPlusNorm ≤
      C.normalizedIntegratedRealLogNorm k := by
  cases k with
  | zero =>
      simp only [normalizedIntegratedRealLogNorm_zero]
      exact neg_nonpos.mpr C.integratedInverseGeneratorLogPlusNorm_nonneg
  | succ k =>
      rw [normalizedIntegratedRealLogNorm]
      rw [le_div_iff₀ (Nat.cast_pos.mpr (Nat.succ_pos k))]
      have h :=
        hC.neg_nat_mul_integratedInverseGeneratorLogPlusNorm_le_integratedRealLogNorm
          (k + 1)
      have heq :
          -C.integratedInverseGeneratorLogPlusNorm * ((k + 1 : ℕ) : ℝ) =
            -(((k + 1 : ℕ) : ℝ) *
              C.integratedInverseGeneratorLogPlusNorm) := by ring
      rw [heq]
      exact h

/-- The range of normalized signed integrals is bounded below by a concrete
finite inverse-tail constant. -/
theorem HasIntegrableGeneratorLogTails.bddBelow_normalizedIntegratedRealLogNorm
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) :
    BddBelow (Set.range C.normalizedIntegratedRealLogNorm) := by
  refine ⟨-C.integratedInverseGeneratorLogPlusNorm, ?_⟩
  rintro _ ⟨k, rfl⟩
  exact
    hC.neg_integratedInverseGeneratorLogPlusNorm_le_normalizedIntegratedRealLogNorm k

/-- The finite signed Fekete rate of the integrated real-log norm sequence.

The bundled tail hypothesis is an explicit argument because it supplies both
subadditivity and the finite lower bound required by Mathlib's real-valued
Fekete theorem. -/
def integratedRealLogGrowthRate
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (hC : C.HasIntegrableGeneratorLogTails) : ℝ :=
  hC.subadditive_integratedRealLogNorm.lim

/-- Normalized signed integrals converge to the signed Fekete rate. -/
theorem HasIntegrableGeneratorLogTails.tendsto_normalizedIntegratedRealLogNorm
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) :
    Tendsto C.normalizedIntegratedRealLogNorm atTop
      (𝓝 (C.integratedRealLogGrowthRate hC)) := by
  exact hC.subadditive_integratedRealLogNorm.tendsto_lim
    hC.bddBelow_normalizedIntegratedRealLogNorm

/-- The signed Fekete rate is the infimum of normalized signed integrals over
strictly positive horizons. -/
theorem HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_eq_sInf
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) :
    C.integratedRealLogGrowthRate hC =
      sInf (C.normalizedIntegratedRealLogNorm '' Ici 1) := by
  rw [integratedRealLogGrowthRate, Subadditive.lim]
  rfl

/-- Every positive-horizon normalized signed integral bounds the signed
Fekete rate from above. -/
theorem HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_le_normalized
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) {k : ℕ} (hk : k ≠ 0) :
    C.integratedRealLogGrowthRate hC ≤
      C.normalizedIntegratedRealLogNorm k := by
  simpa [integratedRealLogGrowthRate, normalizedIntegratedRealLogNorm] using
    hC.subadditive_integratedRealLogNorm.lim_le_div
      hC.bddBelow_normalizedIntegratedRealLogNorm hk

/-- The one-step signed integral is an upper bound for the signed Fekete
rate. -/
theorem HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_le_oneStep
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) :
    C.integratedRealLogGrowthRate hC ≤ C.integratedRealLogNorm 1 := by
  simpa [normalizedIntegratedRealLogNorm] using
    hC.integratedRealLogGrowthRate_le_normalized (k := 1) one_ne_zero

/-- The signed Fekete rate is finite below, with the explicit inverse-tail
lower bound. -/
theorem HasIntegrableGeneratorLogTails.neg_integratedInverseGeneratorLogPlusNorm_le_integratedRealLogGrowthRate
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) :
    -C.integratedInverseGeneratorLogPlusNorm ≤
      C.integratedRealLogGrowthRate hC := by
  apply ge_of_tendsto hC.tendsto_normalizedIntegratedRealLogNorm
  exact Filter.Eventually.of_forall
    hC.neg_integratedInverseGeneratorLogPlusNorm_le_normalizedIntegratedRealLogNorm

/-- The signed Fekete rate lies below the log-positive Fekete rate. -/
theorem HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_le_integratedLogPlusGrowthRate
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) :
    C.integratedRealLogGrowthRate hC ≤
      C.integratedLogPlusGrowthRate hC.hasIntegrableGeneratorLogPlus := by
  apply le_of_tendsto_of_tendsto'
    hC.tendsto_normalizedIntegratedRealLogNorm
    hC.hasIntegrableGeneratorLogPlus.tendsto_normalizedIntegratedLogPlusNorm
  intro k
  unfold normalizedIntegratedRealLogNorm normalizedIntegratedLogPlusNorm
  exact div_le_div_of_nonneg_right
    (hC.integratedRealLogNorm_le_integratedLogPlusNorm k)
    (Nat.cast_nonneg k)

/-- The signed Fekete offset from the one-step integral lies below every
positive-horizon normalized centered integral.

This is the exact deterministic input required by the generic lower-liminf
Kingman rail. -/
theorem HasIntegrableGeneratorLogTails.centeredRealLogFeketeOffset_le_normalizedIntegral
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) (n : ℕ) (hn : n ≠ 0) :
    C.integratedRealLogGrowthRate hC - C.integratedRealLogNorm 1 ≤
      (∫ ω, centeredProcess C.base C.realLogNormObservable n ω ∂μ) /
        (n : ℝ) := by
  let hX := hC.isIntegrableSubadditiveProcessCandidate
  have hnR : (n : ℝ) ≠ 0 := by exact_mod_cast hn
  have hrate := hC.integratedRealLogGrowthRate_le_normalized (k := n) hn
  rw [normalizedIntegratedRealLogNorm] at hrate
  rw [hX.integral_centeredProcess C.base_preserving n]
  calc
    C.integratedRealLogGrowthRate hC - C.integratedRealLogNorm 1 ≤
        C.integratedRealLogNorm n / (n : ℝ) -
          C.integratedRealLogNorm 1 := sub_le_sub_right hrate _
    _ = (C.integratedRealLogNorm n -
          (n : ℝ) * C.integratedRealLogNorm 1) / (n : ℝ) := by
      field_simp [hnR]

/-! ## The inverse-tail lower rail on sample paths -/

/-- The negative inverse-generator Birkhoff average lies below the normalized
signed real-log norm at every horizon and sample.

The statement is total at `n = 0`; there both sides are zero. -/
theorem IsPointwiseInvertible.neg_birkhoffAverage_inverseGenerator_le_normalizedRealLogNorm
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.IsPointwiseInvertible) (n : ℕ) (ω : Ω) :
    -birkhoffAverage ℝ C.base
        C.inverseGeneratorLogPlusNormObservable n ω ≤
      normalizedProcess C.realLogNormObservable n ω := by
  cases n with
  | zero => simp
  | succ n =>
      have hrail :=
        hC.neg_inverseOrbitLogPlusSum_le_realLogNormObservable (n + 1) ω
      have hdiv := div_le_div_of_nonneg_right hrail
        (Nat.cast_nonneg (n + 1))
      simpa only [normalizedProcess, birkhoffAverage, smul_eq_mul,
        C.birkhoffSum_inverseGeneratorLogPlusNormObservable_eq,
        neg_div, div_eq_inv_mul, mul_comm, mul_neg] using hdiv

/-- On a finite-measure base, integrability of the inverse-generator envelope
makes the normalized signed real-log sample path eventually bounded below
almost everywhere.

Neither probability normalization nor ergodicity is needed: ordinary
pointwise Birkhoff convergence gives boundedness of the inverse average, and
the pointwise inverse rail transfers it to signed growth. -/
theorem IsPointwiseInvertible.ae_isBoundedUnder_ge_normalizedRealLogNormObservable
    [IsFiniteMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.IsPointwiseInvertible)
    (hintegrable : Integrable
      C.inverseGeneratorLogPlusNormObservable μ) :
    ∀ᵐ ω ∂μ, IsBoundedUnder (· ≥ ·) atTop
      (fun n ↦ normalizedProcess C.realLogNormObservable n ω) := by
  filter_upwards
      [ae_tendsto_birkhoffAverage_condExp C.base_preserving hintegrable]
      with ω hinverse
  exact hinverse.neg.isBoundedUnder_ge.mono_ge
    (Filter.Eventually.of_forall fun n ↦
      hC.neg_birkhoffAverage_inverseGenerator_le_normalizedRealLogNorm n ω)

/-! ## Signed Kingman endpoints and convergence -/

/-- On a pre-ergodic probability base, the signed integrated Fekete rate lies
below the almost-everywhere lower liminf of normalized signed growth.

This is the centered lower-deviation half of Kingman's theorem. -/
theorem HasIntegrableGeneratorLogTails.ae_integratedRealLogGrowthRate_le_liminf_normalized
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) (hT : PreErgodic C.base μ) :
    ∀ᵐ ω ∂μ,
      C.integratedRealLogGrowthRate hC ≤
        liminf
          (fun n ↦ normalizedProcess C.realLogNormObservable n ω) atTop := by
  let hX := hC.isIntegrableSubadditiveProcessCandidate
  let hErg : Ergodic C.base μ := ⟨C.base_preserving, hT⟩
  filter_upwards
      [hX.ae_add_oneStepIntegral_le_liminf_normalized hErg
        (C.integratedRealLogGrowthRate hC - C.integratedRealLogNorm 1)
        hC.centeredRealLogFeketeOffset_le_normalizedIntegral]
      with ω hω
  simpa only [integratedRealLogNorm, sub_add_cancel] using hω

/-- On a pre-ergodic probability base, the almost-everywhere upper limsup of
normalized signed growth lies below the signed integrated Fekete rate.

The generalized upper-limsup theorem requires an actual eventual lower bound;
the inverse-tail Birkhoff rail above supplies it. -/
theorem HasIntegrableGeneratorLogTails.ae_limsup_normalized_le_integratedRealLogGrowthRate
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) (hT : PreErgodic C.base μ) :
    ∀ᵐ ω ∂μ,
      limsup
          (fun n ↦ normalizedProcess C.realLogNormObservable n ω) atTop ≤
        C.integratedRealLogGrowthRate hC := by
  let hX := hC.isIntegrableSubadditiveProcessCandidate
  let hErg : Ergodic C.base μ := ⟨C.base_preserving, hT⟩
  have hbound :=
    hC.isPointwiseInvertible.ae_isBoundedUnder_ge_normalizedRealLogNormObservable
      hC.integrable_inverseGeneratorLogPlus
  have hblock : ∀ b : ℕ, ∀ᵐ ω ∂μ, b ≠ 0 →
      limsup
          (fun n ↦ normalizedProcess C.realLogNormObservable n ω) atTop ≤
        C.normalizedIntegratedRealLogNorm b := by
    intro b
    by_cases hb : b = 0
    · simp [hb]
    · filter_upwards
          [hX.ae_limsup_normalized_le_blockIntegral_of_ae_isBoundedUnder_ge
            hErg (by simpa only [normalizedProcess] using hbound) b hb]
          with ω hω
      intro _hb
      simpa only [normalizedProcess, normalizedIntegratedRealLogNorm,
        integratedRealLogNorm] using hω
  filter_upwards [ae_all_iff.2 hblock] with ω hω
  rw [hC.integratedRealLogGrowthRate_eq_sInf]
  apply le_csInf
  · exact ⟨C.normalizedIntegratedRealLogNorm 1, ⟨1, by simp, rfl⟩⟩
  · intro y hy
    rcases hy with ⟨b, hb, rfl⟩
    exact hω b (Nat.ne_of_gt hb)

/-- **Signed pre-ergodic Kingman theorem for invertible matrix cocycles.**

On a probability space, two-sided integrable generator tails and pre-
ergodicity of the preserved base imply almost-everywhere convergence of
`Real.log ‖C.value n ω‖ / n` to the deterministic signed Fekete rate.

This is pointwise convergence only; it includes no `L¹` or integral-limit
interchange conclusion. -/
theorem HasIntegrableGeneratorLogTails.ae_tendsto_normalizedRealLogNormObservable
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) (hT : PreErgodic C.base μ) :
    ∀ᵐ ω ∂μ,
      Tendsto
        (fun n ↦ normalizedProcess C.realLogNormObservable n ω) atTop
        (𝓝 (C.integratedRealLogGrowthRate hC)) := by
  let hX := hC.isIntegrableSubadditiveProcessCandidate
  let hErg : Ergodic C.base μ := ⟨C.base_preserving, hT⟩
  filter_upwards
      [hC.ae_integratedRealLogGrowthRate_le_liminf_normalized hT,
        hC.ae_limsup_normalized_le_integratedRealLogGrowthRate hT,
        hC.isPointwiseInvertible.ae_isBoundedUnder_ge_normalizedRealLogNormObservable
          hC.integrable_inverseGeneratorLogPlus,
        ae_tendsto_birkhoffAverage_integral_of_ergodic hErg
          (hC.integrable_realLogNormObservable 1)]
      with ω hlower hupper hnormLower hBirkhoff
  have hnorm_le_avg :
      (fun n ↦ normalizedProcess C.realLogNormObservable n ω) ≤ᶠ[atTop]
        (fun n ↦ birkhoffAverage ℝ C.base
          (C.realLogNormObservable 1) n ω) := by
    filter_upwards [eventually_ge_atTop 1] with n hn
    simpa only [normalizedProcess, birkhoffAverage, smul_eq_mul,
      div_eq_inv_mul] using
      (div_le_div_iff_of_pos_right (Nat.cast_pos.mpr hn)).2
        (hX.oneStepBirkhoffMajorant_of_ne_zero n (by omega) ω)
  have hnormUpper : IsBoundedUnder (· ≤ ·) atTop
      (fun n ↦ normalizedProcess C.realLogNormObservable n ω) :=
    hBirkhoff.isBoundedUnder_le.mono_le hnorm_le_avg
  exact tendsto_of_le_liminf_of_limsup_le
    hlower hupper hnormUpper hnormLower

/-- Empty matrix dimension has signed integrated growth rate zero. -/
@[simp] theorem HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_eq_zero_of_isEmpty
    [IsEmpty ι]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) :
    C.integratedRealLogGrowthRate hC = 0 := by
  have hzero : C.normalizedIntegratedRealLogNorm = fun _ ↦ 0 := by
    funext n
    simp [normalizedIntegratedRealLogNorm]
  have hzero_tendsto :
      Tendsto C.normalizedIntegratedRealLogNorm atTop (𝓝 0) := by
    rw [hzero]
    exact tendsto_const_nhds
  exact tendsto_nhds_unique
    hC.tendsto_normalizedIntegratedRealLogNorm hzero_tendsto

/-- If the log-positive Fekete rate is strictly positive, it equals the signed
Fekete rate.

The proof uses the uniqueness of the almost-everywhere sample-path limit, not
an interchange of limits and integrals. -/
theorem HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_eq_integratedLogPlusGrowthRate_of_pos
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) (hT : PreErgodic C.base μ)
    (hpos : 0 < C.integratedLogPlusGrowthRate
      hC.hasIntegrableGeneratorLogPlus) :
    C.integratedRealLogGrowthRate hC =
      C.integratedLogPlusGrowthRate hC.hasIntegrableGeneratorLogPlus := by
  have hboth : ∀ᵐ ω ∂μ,
      Tendsto
          (fun n ↦ normalizedProcess C.realLogNormObservable n ω) atTop
          (𝓝 (C.integratedRealLogGrowthRate hC)) ∧
        Tendsto
          (fun n ↦ normalizedProcess C.realLogNormObservable n ω) atTop
          (𝓝 (C.integratedLogPlusGrowthRate
            hC.hasIntegrableGeneratorLogPlus)) :=
    (hC.ae_tendsto_normalizedRealLogNormObservable hT).and
      (hC.hasIntegrableGeneratorLogPlus.ae_tendsto_normalizedRealLogNormObservable_of_pos
        hT hpos)
  obtain ⟨ω, hsigned, hpositive⟩ := hboth.exists
  exact tendsto_nhds_unique hsigned hpositive

end NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle

#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogTails.integratedRealLogNorm_add_le
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogTails.neg_nat_mul_integratedInverseGeneratorLogPlusNorm_le_integratedRealLogNorm
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogTails.tendsto_normalizedIntegratedRealLogNorm
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogTails.ae_integratedRealLogGrowthRate_le_liminf_normalized
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogTails.ae_limsup_normalized_le_integratedRealLogGrowthRate
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogTails.ae_tendsto_normalizedRealLogNormObservable
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_eq_integratedLogPlusGrowthRate_of_pos
