import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleInvariance
import NonlinearDynamics.Random.RandomMatrices.Observables

/-!
# First exact trace moments of finite GUE

This module proves integrability and evaluates the first two complex Bochner integrals of the
trace-power observables under the finite Wigner-scaled GUE matrix law. The first moment is the sum
of the centered diagonal means. For the second moment, normalized real Hermitian coordinates turn
the pointwise identity `Tr(H ^ 2) = ‖H‖ ^ 2` into a sum of `n ^ 2` independent coordinate
squares, each with variance `GUE.varianceScale n`. The resulting integral is exactly `n`.

All four theorems hold in every natural dimension. In dimension zero the index sets are empty, the
matrix law is Dirac at the unique empty matrix, and both formulas reduce without a separate public
boundary theorem. The normalization is the existing Wigner convention: diagonal coordinates have
variance `1 / n` when `n > 0`, while the real and imaginary parts of each strict-upper entry have
variance `1 / (2 * n)`.

These are finite-dimensional trace moments only. No eigenvalue measurability, spectral density,
limiting distribution, concentration estimate, or asymptotic claim is proved here.
-/

open Matrix MeasureTheory ProbabilityTheory
open scoped ENNReal NNReal ProbabilityTheory Matrix RealInnerProductSpace

namespace NonlinearDynamics.Random

namespace GUE

private theorem trace_sq_hermitianToMatrix {n : ℕ}
    (H : RandomMatrix.HermitianEuclidean n) :
    Matrix.trace ((RandomMatrix.hermitianToMatrix H) ^ 2) = (‖H‖ ^ 2 : ℂ) := by
  have h := RandomMatrix.inner_frobenius_eq_trace
    (H : RandomMatrix.FrobeniusMatrix n) (H : RandomMatrix.FrobeniusMatrix n)
  rw [inner_self_eq_norm_sq_to_K] at h
  rw [H.2.eq] at h
  simpa [pow_two, RandomMatrix.hermitianToMatrix] using h.symm

private theorem centeredGaussian_integrable_sq
    {Ω : Type*} [MeasurableSpace Ω] {X : Ω → ℝ} {v : ℝ≥0} {P : Measure Ω}
    (hX : HasRealGaussianLaw X 0 v P) : Integrable (fun ω ↦ X ω ^ 2) P := by
  exact (hX.memLp 2 (by norm_num)).integrable_sq

private theorem centeredGaussian_integral_sq
    {Ω : Type*} [MeasurableSpace Ω] {X : Ω → ℝ} {v : ℝ≥0} {P : Measure Ω}
    (hX : HasRealGaussianLaw X 0 v P) : ∫ ω, X ω ^ 2 ∂P = (v : ℝ) := by
  rw [← ProbabilityTheory.variance_of_integral_eq_zero hX.aemeasurable hX.mean_eq]
  exact hX.variance_eq

private noncomputable def normalizedRealMatrixSample (n : ℕ) :
    (HermitianRealIndex n → ℝ) → Matrix (Fin n) (Fin n) ℂ :=
  RandomMatrix.hermitianCoordinateMap n ∘
    RandomMatrix.realToHermitianCoordinates

private theorem measurable_normalizedRealMatrixSample (n : ℕ) :
    Measurable (normalizedRealMatrixSample n) :=
  (RandomMatrix.measurable_hermitianCoordinateMap n).comp
    (RandomMatrix.measurable_realToHermitianCoordinates n)

private theorem matrixLaw_eq_map_normalizedRealMatrixSample (n : ℕ) :
    matrixLaw n =
      (gaussianProductMeasure
        (fun _ : HermitianRealIndex n ↦ 0) (fun _ ↦ varianceScale n)).map
          (normalizedRealMatrixSample n) := by
  rw [matrixLaw_eq_map, ← map_realToHermitianCoordinates_gaussianProduct n]
  rw [Measure.map_map (RandomMatrix.measurable_hermitianCoordinateMap n)
    (RandomMatrix.measurable_realToHermitianCoordinates n)]
  rfl

private theorem normalizedRealMatrixSample_eq (n : ℕ)
    (x : HermitianRealIndex n → ℝ) :
    normalizedRealMatrixSample n x =
      RandomMatrix.hermitianToMatrix
        (RandomMatrix.normalizedHermitianAssembly (WithLp.toLp 2 x)) := by
  rfl

private theorem tracePower_two_normalizedRealMatrixSample (n : ℕ)
    (x : HermitianRealIndex n → ℝ) :
    RandomMatrix.tracePower
        (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ) 2
        (normalizedRealMatrixSample n x) =
      ((∑ i, x i ^ 2 : ℝ) : ℂ) := by
  rw [normalizedRealMatrixSample_eq]
  unfold RandomMatrix.tracePower
  simp only [id_eq]
  rw [trace_sq_hermitianToMatrix]
  have hnorm := (RandomMatrix.normalizedHermitianLinearIsometryEquiv n).norm_map
    (WithLp.toLp 2 x)
  change ‖RandomMatrix.normalizedHermitianAssembly (WithLp.toLp 2 x)‖ =
    ‖WithLp.toLp 2 x‖ at hnorm
  rw [hnorm]
  norm_cast
  exact EuclideanSpace.real_norm_sq_eq (WithLp.toLp 2 x)

private theorem integrable_sum_sq_normalizedRealCoordinates (n : ℕ) :
    Integrable (fun x : HermitianRealIndex n → ℝ ↦ ∑ i, x i ^ 2)
      (gaussianProductMeasure
        (fun _ : HermitianRealIndex n ↦ 0) (fun _ ↦ varianceScale n)) := by
  apply integrable_finsetSum Finset.univ
  intro i _
  exact centeredGaussian_integrable_sq
    (gaussianProductMeasure_hasLaw_eval
      (fun _ : HermitianRealIndex n ↦ 0) (fun _ ↦ varianceScale n) i)

private theorem integral_sum_sq_normalizedRealCoordinates (n : ℕ) :
    ∫ x : HermitianRealIndex n → ℝ, ∑ i, x i ^ 2
      ∂(gaussianProductMeasure
        (fun _ : HermitianRealIndex n ↦ 0) (fun _ ↦ varianceScale n)) =
      Fintype.card (HermitianRealIndex n) * (varianceScale n : ℝ) := by
  rw [integral_finsetSum]
  · simp_rw [centeredGaussian_integral_sq
      (gaussianProductMeasure_hasLaw_eval
        (fun _ : HermitianRealIndex n ↦ 0) (fun _ ↦ varianceScale n) _)]
    simp
  · intro i _
    exact centeredGaussian_integrable_sq
      (gaussianProductMeasure_hasLaw_eval
        (fun _ : HermitianRealIndex n ↦ 0) (fun _ ↦ varianceScale n) i)

private theorem card_hermitianRealIndex (n : ℕ) :
    Fintype.card (HermitianRealIndex n) = n * n := by
  rw [Fintype.card_congr (hermitianRealIndexEquivMatrixIndex n)]
  simp

private theorem card_mul_varianceScale (n : ℕ) :
    Fintype.card (HermitianRealIndex n) * (varianceScale n : ℝ) = n := by
  rw [card_hermitianRealIndex]
  cases n with
  | zero => simp
  | succ n =>
      rw [varianceScale_succ]
      push_cast
      field_simp

/-- The first trace-power observable is Bochner integrable under finite GUE in every dimension. -/
theorem integrable_tracePower_one (n : ℕ) :
    Integrable
      (RandomMatrix.tracePower
        (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ) 1)
      (matrixLaw n) := by
  unfold RandomMatrix.tracePower
  simp only [id_eq, pow_one, Matrix.trace, Matrix.diag_apply]
  exact integrable_finsetSum Finset.univ fun i _ ↦
    (matrixLaw_diagonal_hasLaw n i).integrable

/-- The complex Bochner integral of the first trace power under finite GUE is exactly zero. -/
theorem integral_tracePower_one (n : ℕ) :
    ∫ H, RandomMatrix.tracePower
        (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ) 1 H
      ∂matrixLaw n = 0 := by
  simp only [RandomMatrix.tracePower, id_eq, pow_one, Matrix.trace, Matrix.diag_apply]
  rw [integral_finsetSum]
  · simp_rw [(matrixLaw_diagonal_hasLaw n _).mean_eq]
    simp
  · exact fun i _ ↦ (matrixLaw_diagonal_hasLaw n i).integrable

/-- The second trace-power observable is Bochner integrable under finite GUE in every dimension. -/
theorem integrable_tracePower_two (n : ℕ) :
    Integrable
      (RandomMatrix.tracePower
        (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ) 2)
      (matrixLaw n) := by
  rw [matrixLaw_eq_map_normalizedRealMatrixSample]
  apply (integrable_map_measure
    (RandomMatrix.measurable_tracePower
      (X := (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ))
      measurable_id 2).aestronglyMeasurable
    (measurable_normalizedRealMatrixSample n).aemeasurable).2
  apply (integrable_sum_sq_normalizedRealCoordinates n).ofReal.congr
  filter_upwards with x
  exact (tracePower_two_normalizedRealMatrixSample n x).symm

/-- The complex Bochner integral of the second trace power under finite Wigner-scaled GUE is
exactly the matrix dimension. -/
theorem integral_tracePower_two (n : ℕ) :
    ∫ H, RandomMatrix.tracePower
        (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ) 2 H
      ∂matrixLaw n = (n : ℂ) := by
  rw [matrixLaw_eq_map_normalizedRealMatrixSample]
  rw [integral_map
    (measurable_normalizedRealMatrixSample n).aemeasurable
    (RandomMatrix.measurable_tracePower
      (X := (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ))
      measurable_id 2).aestronglyMeasurable]
  calc
    ∫ x, RandomMatrix.tracePower
          (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ) 2
          (normalizedRealMatrixSample n x)
        ∂(gaussianProductMeasure
          (fun _ : HermitianRealIndex n ↦ 0) (fun _ ↦ varianceScale n)) =
        ∫ x, ((∑ i, x i ^ 2 : ℝ) : ℂ)
          ∂(gaussianProductMeasure
            (fun _ : HermitianRealIndex n ↦ 0) (fun _ ↦ varianceScale n)) := by
              apply integral_congr_ae
              filter_upwards with x
              exact tracePower_two_normalizedRealMatrixSample n x
    _ = ((∫ x, ∑ i, x i ^ 2
          ∂(gaussianProductMeasure
            (fun _ : HermitianRealIndex n ↦ 0) (fun _ ↦ varianceScale n))) : ℝ) := by
              exact integral_complex_ofReal
    _ = (n : ℂ) := by
      rw [integral_sum_sq_normalizedRealCoordinates,
        card_mul_varianceScale]
      norm_num

end GUE

end NonlinearDynamics.Random
