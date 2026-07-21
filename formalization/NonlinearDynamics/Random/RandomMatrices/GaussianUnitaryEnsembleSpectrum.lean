import NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity

/-!
# Finite GUE empirical spectral laws and normalized moments

This module names the finite GUE pushforward law of the empirical spectral
measure and packages the law as a probability measure. In positive dimension,
it also packages the random empirical measure itself in
`ProbabilityMeasure ℝ`. The raw law deliberately remains defined in dimension
zero, where it is the Dirac mass at the zero measure.

For a deterministic Hermitian matrix, the first two complex moments of its
empirical spectral measure are the normalized trace and normalized trace
square. Transporting the exact finite GUE trace identities through the
intrinsic-to-ambient law bridge proves integrability and the exact ensemble
averages. The first average is zero in every dimension. The second is
`n⁻¹ n`, hence zero in dimension zero and one in every positive dimension.

The law, the positive-dimensional probability-valued law, and the mean
empirical measure are distinct objects. This module proves no eigenvalue
density, joint density, Vandermonde formula, higher moment, concentration,
semicircle law, large-dimension convergence, or universality statement.
-/

open Matrix MeasureTheory
open scoped ENNReal Matrix

namespace NonlinearDynamics.Random.RandomMatrix

noncomputable section

/-- The `k`th complex moment of one finite empirical spectral measure. -/
noncomputable def empiricalSpectralMoment {n : ℕ} (k : ℕ)
    (H : HermitianEuclidean n) : ℂ :=
  ∫ x : ℝ, (x : ℂ) ^ k ∂empiricalSpectralMeasure H

/-- Every empirical spectral moment is zero in dimension zero, because the
project's zero-dimensional empirical spectral measure is the zero measure. -/
@[simp] theorem empiricalSpectralMoment_zero (k : ℕ)
    (H : HermitianEuclidean 0) : empiricalSpectralMoment k H = 0 := by
  simp [empiricalSpectralMoment]

/-- The first sample spectral moment is the reciprocal-dimension normalized
matrix trace, including the dimension-zero boundary. -/
theorem empiricalSpectralMoment_one {n : ℕ} (H : HermitianEuclidean n) :
    empiricalSpectralMoment 1 H =
      (((n : ℕ) : ℝ)⁻¹ : ℂ) * Matrix.trace (hermitianToMatrix H) := by
  rw [empiricalSpectralMoment, empiricalSpectralMeasure,
    integral_smul_measure, ENNReal.toReal_inv]
  simp only [pow_one]
  rw [integral_complex_ofReal_spectralCountingMeasure]
  norm_cast

/-- The second sample spectral moment is the reciprocal-dimension normalized
trace square, including the dimension-zero boundary. -/
theorem empiricalSpectralMoment_two {n : ℕ} (H : HermitianEuclidean n) :
    empiricalSpectralMoment 2 H =
      (((n : ℕ) : ℝ)⁻¹ : ℂ) * Matrix.trace ((hermitianToMatrix H) ^ 2) := by
  rw [empiricalSpectralMoment, empiricalSpectralMeasure,
    integral_smul_measure, ENNReal.toReal_inv]
  rw [integral_sq_complex_ofReal_spectralCountingMeasure]
  norm_cast

end


end NonlinearDynamics.Random.RandomMatrix

namespace NonlinearDynamics.Random.GUE

open RandomMatrix

noncomputable section

/-- The finite GUE law of the zero-aware empirical spectral measure. -/
noncomputable def empiricalSpectralLaw (n : ℕ) : Measure (Measure ℝ) :=
  (intrinsicLaw n).map empiricalSpectralMeasure

/-- The finite GUE empirical spectral law is a probability measure in every
dimension, including dimension zero. -/
instance instIsProbabilityMeasureEmpiricalSpectralLaw (n : ℕ) :
    IsProbabilityMeasure (empiricalSpectralLaw n) := by
  unfold empiricalSpectralLaw
  exact Measure.isProbabilityMeasure_map
    measurable_empiricalSpectralMeasure.aemeasurable

/-- The law of raw zero-aware empirical spectral measures bundled as a
probability measure. -/
noncomputable def empiricalSpectralLawProbability (n : ℕ) :
    ProbabilityMeasure (Measure ℝ) :=
  ⟨empiricalSpectralLaw n, inferInstance⟩

/-- In positive dimension, the GUE law on empirical spectra takes values in
the bundled space of probability measures. -/
noncomputable def empiricalSpectralProbabilityLaw (n : ℕ) :
    ProbabilityMeasure (ProbabilityMeasure ℝ) :=
  ⟨(intrinsicLaw (n + 1)).map (empiricalSpectralProbability n),
    Measure.isProbabilityMeasure_map
      (measurable_empiricalSpectralProbability n).aemeasurable⟩

/-- Forgetting the positive-dimensional probability wrapper recovers the raw
empirical spectral law. -/
theorem map_empiricalSpectralProbabilityLaw_coe (n : ℕ) :
    ((empiricalSpectralProbabilityLaw n :
      ProbabilityMeasure (ProbabilityMeasure ℝ)) :
      Measure (ProbabilityMeasure ℝ)).map
        (fun μ : ProbabilityMeasure ℝ => (μ : Measure ℝ)) =
      empiricalSpectralLaw (n + 1) := by
  rw [empiricalSpectralProbabilityLaw, empiricalSpectralLaw]
  change ((intrinsicLaw (n + 1)).map (empiricalSpectralProbability n)).map
      (fun μ : ProbabilityMeasure ℝ => (μ : Measure ℝ)) =
    (intrinsicLaw (n + 1)).map empiricalSpectralMeasure
  have hcoe : Measurable
      (fun μ : ProbabilityMeasure ℝ => (μ : Measure ℝ)) :=
    measurable_subtype_coe
  rw [Measure.map_map hcoe (measurable_empiricalSpectralProbability n)]
  rfl

/-- The intrinsic definition of the spectral law agrees with the pushforward
of the ambient GUE matrix law through the Hermitian-or-zero observable. -/
theorem empiricalSpectralLaw_eq_map_matrixLaw_ambient (n : ℕ) :
    empiricalSpectralLaw n =
      (matrixLaw n).map (ambientEmpiricalSpectralMeasure n) := by
  exact
    (map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw n).symm

/-- In dimension zero, the empirical spectral law is concentrated at the zero
measure. -/
@[simp] theorem empiricalSpectralLaw_zero :
    empiricalSpectralLaw 0 = Measure.dirac (0 : Measure ℝ) := by
  rw [empiricalSpectralLaw, intrinsicLaw_zero]
  rw [Measure.map_dirac' measurable_empiricalSpectralMeasure]
  simp

/-- The barycenter of the law of zero-aware empirical spectral measures. -/
noncomputable def meanEmpiricalSpectralMeasure (n : ℕ) : Measure ℝ :=
  (empiricalSpectralLaw n).join

/-- The mean empirical spectral measure is zero in dimension zero. -/
@[simp] theorem meanEmpiricalSpectralMeasure_zero :
    meanEmpiricalSpectralMeasure 0 = 0 := by
  rw [meanEmpiricalSpectralMeasure, empiricalSpectralLaw_zero]
  simp

/-- The mean empirical spectral measure is a probability measure in every
positive dimension. -/
theorem meanEmpiricalSpectralMeasure_succ_isProbability (n : ℕ) :
    IsProbabilityMeasure (meanEmpiricalSpectralMeasure (n + 1)) := by
  apply isProbabilityMeasure_join
  rw [empiricalSpectralLaw]
  apply (ae_map_iff measurable_empiricalSpectralMeasure.aemeasurable
    ProbabilityMeasure.measurableSet_isProbabilityMeasure).2
  exact Filter.Eventually.of_forall
    (empiricalSpectralMeasure_succ_isProbability n)

private noncomputable def ambientTracePower (n k : ℕ) :
    Matrix (Fin n) (Fin n) ℂ → ℂ :=
  RandomMatrix.tracePower
    (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ) k

/-- Every spectral moment observable is integrable in dimension zero. -/
theorem integrable_empiricalSpectralMoment_zero (k : ℕ) :
    Integrable (@empiricalSpectralMoment 0 k) (intrinsicLaw 0) := by
  have hz : (@empiricalSpectralMoment 0 k) = 0 := by
    funext H
    exact empiricalSpectralMoment_zero k H
  rw [hz]
  exact integrable_zero (HermitianEuclidean 0) ℂ (intrinsicLaw 0)

/-- Every expected spectral moment is zero in dimension zero. -/
@[simp] theorem integral_empiricalSpectralMoment_zero (k : ℕ) :
    ∫ H, empiricalSpectralMoment k H ∂intrinsicLaw 0 = 0 := by
  apply integral_eq_zero_of_ae
  exact Filter.Eventually.of_forall (empiricalSpectralMoment_zero k)

/-- The first empirical spectral moment is integrable under finite GUE in
every dimension. -/
theorem integrable_empiricalSpectralMoment_one (n : ℕ) :
    Integrable (@empiricalSpectralMoment n 1) (intrinsicLaw n) := by
  have htrace :
      Integrable (ambientTracePower n 1) (matrixLaw n) := by
    exact integrable_tracePower_one n
  rw [matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw] at htrace
  have hcomp : Integrable
      (ambientTracePower n 1 ∘ hermitianToMatrix) (intrinsicLaw n) :=
    (integrable_map_measure
      (RandomMatrix.measurable_tracePower
        (X := (id : Matrix (Fin n) (Fin n) ℂ →
          Matrix (Fin n) (Fin n) ℂ)) measurable_id 1).aestronglyMeasurable
      (measurable_hermitianToMatrix n).aemeasurable).1 htrace
  have hscaled := hcomp.const_mul (((n : ℝ)⁻¹ : ℂ))
  apply hscaled.congr
  filter_upwards with H
  rw [empiricalSpectralMoment_one]
  simp [ambientTracePower, RandomMatrix.tracePower]

/-- The expected first empirical spectral moment of finite GUE is zero in
every dimension. -/
theorem integral_empiricalSpectralMoment_one (n : ℕ) :
    ∫ H, empiricalSpectralMoment 1 H ∂intrinsicLaw n = 0 := by
  let c : ℂ := (((n : ℕ) : ℝ)⁻¹ : ℂ)
  calc
    ∫ H, empiricalSpectralMoment 1 H ∂intrinsicLaw n =
        ∫ H, c * ambientTracePower n 1 (hermitianToMatrix H)
          ∂intrinsicLaw n := by
      apply integral_congr_ae
      filter_upwards with H
      rw [empiricalSpectralMoment_one]
      simp [c, ambientTracePower, RandomMatrix.tracePower]
    _ = c * ∫ H, ambientTracePower n 1 (hermitianToMatrix H)
          ∂intrinsicLaw n := by
      rw [integral_const_mul]
    _ = c * ∫ A, ambientTracePower n 1 A ∂matrixLaw n := by
      rw [matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw,
        integral_map (measurable_hermitianToMatrix n).aemeasurable]
      exact RandomMatrix.measurable_tracePower
        (X := (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ))
        measurable_id 1 |>.aestronglyMeasurable
    _ = 0 := by
      rw [show ambientTracePower n 1 =
          RandomMatrix.tracePower
            (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ) 1
            from rfl,
        integral_tracePower_one]
      simp

/-- The second empirical spectral moment is integrable under finite GUE in
every dimension. -/
theorem integrable_empiricalSpectralMoment_two (n : ℕ) :
    Integrable (@empiricalSpectralMoment n 2) (intrinsicLaw n) := by
  have htrace :
      Integrable (ambientTracePower n 2) (matrixLaw n) := by
    exact integrable_tracePower_two n
  rw [matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw] at htrace
  have hcomp : Integrable
      (ambientTracePower n 2 ∘ hermitianToMatrix) (intrinsicLaw n) :=
    (integrable_map_measure
      (RandomMatrix.measurable_tracePower
        (X := (id : Matrix (Fin n) (Fin n) ℂ →
          Matrix (Fin n) (Fin n) ℂ)) measurable_id 2).aestronglyMeasurable
      (measurable_hermitianToMatrix n).aemeasurable).1 htrace
  have hscaled := hcomp.const_mul (((n : ℝ)⁻¹ : ℂ))
  apply hscaled.congr
  filter_upwards with H
  rw [empiricalSpectralMoment_two]
  simp [ambientTracePower, RandomMatrix.tracePower]

/-- The expected second empirical spectral moment is exactly `n⁻¹ n`, making
the zero-dimensional boundary explicit. -/
theorem integral_empiricalSpectralMoment_two (n : ℕ) :
    ∫ H, empiricalSpectralMoment 2 H ∂intrinsicLaw n =
      (((n : ℕ) : ℝ)⁻¹ : ℂ) * (n : ℂ) := by
  let c : ℂ := (((n : ℕ) : ℝ)⁻¹ : ℂ)
  calc
    ∫ H, empiricalSpectralMoment 2 H ∂intrinsicLaw n =
        ∫ H, c * ambientTracePower n 2 (hermitianToMatrix H)
          ∂intrinsicLaw n := by
      apply integral_congr_ae
      filter_upwards with H
      rw [empiricalSpectralMoment_two]
      simp [c, ambientTracePower, RandomMatrix.tracePower]
    _ = c * ∫ H, ambientTracePower n 2 (hermitianToMatrix H)
          ∂intrinsicLaw n := by
      rw [integral_const_mul]
    _ = c * ∫ A, ambientTracePower n 2 A ∂matrixLaw n := by
      rw [matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw,
        integral_map (measurable_hermitianToMatrix n).aemeasurable]
      exact RandomMatrix.measurable_tracePower
        (X := (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ))
        measurable_id 2 |>.aestronglyMeasurable
    _ = c * (n : ℂ) := by
      rw [show ambientTracePower n 2 =
          RandomMatrix.tracePower
            (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ) 2
            from rfl,
        integral_tracePower_two]
    _ = (((n : ℕ) : ℝ)⁻¹ : ℂ) * (n : ℂ) := rfl

/-- In every positive dimension, the expected second empirical spectral
moment of finite Wigner-scaled GUE is exactly one. -/
@[simp] theorem integral_empiricalSpectralMoment_two_succ (n : ℕ) :
    ∫ H, empiricalSpectralMoment 2 H ∂intrinsicLaw (n + 1) = 1 := by
  rw [integral_empiricalSpectralMoment_two]
  norm_cast
  exact inv_mul_cancel₀ (by positivity)

end


end NonlinearDynamics.Random.GUE
