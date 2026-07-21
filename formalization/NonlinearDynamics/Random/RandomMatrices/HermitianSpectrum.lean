import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleMoments
import Mathlib.Analysis.Matrix.Spectrum
import Mathlib.MeasureTheory.Integral.Bochner.SumMeasure
import Mathlib.MeasureTheory.Measure.GiryMonad
import Mathlib.MeasureTheory.Measure.ProbabilityMeasure

/-!
# Finite Hermitian spectra and empirical spectral measures

This module packages the algebraic spectrum of an intrinsic finite Hermitian
matrix. The eigenvalues use Mathlib's decreasingly sorted
`Matrix.IsHermitian.eigenvalues₀`, transported to the project's concrete
index `Fin n` by an order-preserving cast. Their finite sums recover the trace
and the trace of the square, and unitary congruence leaves the ordered vector
unchanged.

The ordered vector generates a spectral counting measure of mass `n`. Scaling
that measure by `n⁻¹` gives a zero-aware empirical spectral measure: it is
the zero measure in dimension zero and a probability measure in every positive
dimension. A `ProbabilityMeasure` wrapper is therefore exposed only at
dimension `n + 1`.

Pinned Mathlib does not currently provide continuity or measurability of this
ordered eigenvalue enumeration. Every Giry-measurability theorem in this file
therefore takes coordinatewise eigenvalue measurability as an explicit
hypothesis. In particular, this module does not construct a GUE spectral law
unconditionally. It also makes no density, eigenvalue perturbation,
large-dimension, or asymptotic spectral claim.
-/

open Matrix MeasureTheory
open scoped ENNReal Matrix

namespace NonlinearDynamics.Random

namespace RandomMatrix

/-- The real eigenvalues of an intrinsic `n × n` Hermitian matrix, in
decreasing order and indexed by `Fin n`.

Mathlib's sorted vector is naturally indexed by
`Fin (Fintype.card (Fin n))`. The order-preserving finite cast used here keeps
the sorting theorem visible after identifying that cardinal with `n`.
-/
noncomputable def orderedHermitianEigenvalues {n : ℕ}
    (H : HermitianEuclidean n) : Fin n → ℝ :=
  fun i => H.2.eigenvalues₀ (Fin.cast (Fintype.card_fin n).symm i)

/-- The project's ordered Hermitian eigenvalue vector is decreasing. -/
theorem orderedHermitianEigenvalues_antitone {n : ℕ}
    (H : HermitianEuclidean n) : Antitone (orderedHermitianEigenvalues H) := by
  intro i j hij
  apply H.2.eigenvalues₀_antitone
  exact (Fin.cast_le_cast (Fintype.card_fin n).symm).2 hij

/-- The ordinary complex trace is the sum of the ordered real eigenvalues. -/
theorem trace_eq_sum_orderedHermitianEigenvalues {n : ℕ}
    (H : HermitianEuclidean n) :
    Matrix.trace (hermitianToMatrix H) =
      ∑ i, (orderedHermitianEigenvalues H i : ℂ) := by
  change Matrix.trace (frobeniusToMatrix (H : FrobeniusMatrix n)) = _
  rw [Matrix.trace_eq_sum_roots_charpoly_of_splits H.2.splits_charpoly]
  rw [H.2.roots_charpoly_eq_eigenvalues₀]
  simp only [Function.comp_apply]
  exact (Equiv.sum_comp
    (Fin.castOrderIso (Fintype.card_fin n).symm).toEquiv
    (fun i => (H.2.eigenvalues₀ i : ℂ))).symm

/-- The trace of the matrix square is the sum of the squared ordered
eigenvalues. -/
theorem trace_sq_eq_sum_sq_orderedHermitianEigenvalues {n : ℕ}
    (H : HermitianEuclidean n) :
    Matrix.trace ((hermitianToMatrix H) ^ 2) =
      ∑ i, (orderedHermitianEigenvalues H i : ℂ) ^ 2 := by
  let U : Matrix (Fin n) (Fin n) ℂ := H.2.eigenvectorUnitary
  let D : Matrix (Fin n) (Fin n) ℂ :=
    Matrix.diagonal (RCLike.ofReal ∘ H.2.eigenvalues)
  have hU : Uᴴ * U = 1 := H.2.eigenvectorUnitary.2.1
  have hspec : hermitianToMatrix H = U * D * Uᴴ := by
    change frobeniusToMatrix (H : FrobeniusMatrix n) = _
    rw [H.2.spectral_theorem]
    rfl
  rw [hspec, pow_two]
  calc
    Matrix.trace ((U * D * Uᴴ) * (U * D * Uᴴ)) =
        Matrix.trace (U * (D * D) * Uᴴ) := by
          congr 1
          simp only [Matrix.mul_assoc]
          rw [← Matrix.mul_assoc Uᴴ U, hU, one_mul]
    _ = Matrix.trace (Uᴴ * U * (D * D)) := Matrix.trace_mul_cycle U (D * D) Uᴴ
    _ = Matrix.trace (D * D) := by rw [hU, one_mul]
    _ = ∑ i, (H.2.eigenvalues i : ℂ) ^ 2 := by
      simp [D, pow_two]
    _ = ∑ i, (H.2.eigenvalues₀ i : ℂ) ^ 2 := by
      exact Equiv.sum_comp
        (Fintype.equivOfCardEq
          (Fintype.card_fin (Fintype.card (Fin n)))).symm
        (fun i => (H.2.eigenvalues₀ i : ℂ) ^ 2)
    _ = ∑ i, (orderedHermitianEigenvalues H i : ℂ) ^ 2 := by
      exact (Equiv.sum_comp
        (Fin.castOrderIso (Fintype.card_fin n).symm).toEquiv
        (fun i => (H.2.eigenvalues₀ i : ℂ) ^ 2)).symm

/-- Intrinsic congruence by a unitary matrix preserves the entire ordered
Hermitian eigenvalue vector. -/
theorem orderedHermitianEigenvalues_hermitianCongruence {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ) (H : HermitianEuclidean n) :
    orderedHermitianEigenvalues (hermitianCongruence U H) =
      orderedHermitianEigenvalues H := by
  have hchar :
      (hermitianToMatrix (hermitianCongruence U H)).charpoly =
        (hermitianToMatrix H).charpoly := by
    change ((U : Matrix (Fin n) (Fin n) ℂ) * hermitianToMatrix H * Uᴴ).charpoly = _
    have hU : (U : Matrix (Fin n) (Fin n) ℂ)ᴴ * U = 1 := U.2.1
    rw [Matrix.charpoly_mul_comm, ← Matrix.mul_assoc, hU, one_mul]
  apply funext
  intro i
  have hlist :
      List.ofFn (hermitianCongruence U H).2.eigenvalues₀ =
        List.ofFn H.2.eigenvalues₀ := by
    rw [← (hermitianCongruence U H).2.sort_roots_charpoly_eq_eigenvalues₀,
      ← H.2.sort_roots_charpoly_eq_eigenvalues₀]
    exact congrArg (fun A => (A.roots.map RCLike.re).sort (· ≥ ·)) hchar
  exact congrFun (List.ofFn_inj.mp hlist)
    (Fin.cast (Fintype.card_fin n).symm i)

/-- The finite spectral counting measure, with one Dirac mass at each ordered
eigenvalue and algebraic multiplicity represented by repeated indices. -/
noncomputable def spectralCountingMeasure {n : ℕ}
    (H : HermitianEuclidean n) : Measure ℝ :=
  ∑ i, Measure.dirac (orderedHermitianEigenvalues H i)

/-- Unitary congruence preserves the spectral counting measure. -/
@[simp] theorem spectralCountingMeasure_hermitianCongruence {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ) (H : HermitianEuclidean n) :
    spectralCountingMeasure (hermitianCongruence U H) =
      spectralCountingMeasure H := by
  simp only [spectralCountingMeasure,
    orderedHermitianEigenvalues_hermitianCongruence U H]

/-- In dimension zero, the spectral counting measure is the zero measure. -/
@[simp] theorem spectralCountingMeasure_zero
    (H : HermitianEuclidean 0) : spectralCountingMeasure H = 0 := by
  rw [spectralCountingMeasure]
  exact Fintype.sum_empty _

/-- The total mass of the spectral counting measure is the matrix dimension. -/
@[simp] theorem spectralCountingMeasure_univ {n : ℕ}
    (H : HermitianEuclidean n) : spectralCountingMeasure H Set.univ = n := by
  simp [spectralCountingMeasure]

/-- The first complex moment of the counting measure is the matrix trace. -/
theorem integral_complex_ofReal_spectralCountingMeasure {n : ℕ}
    (H : HermitianEuclidean n) :
    ∫ x : ℝ, (x : ℂ) ∂spectralCountingMeasure H =
      Matrix.trace (hermitianToMatrix H) := by
  rw [spectralCountingMeasure]
  rw [integral_finsetSum_measure]
  · simp only [integral_dirac]
    exact (trace_eq_sum_orderedHermitianEigenvalues H).symm
  · intro i _
    exact integrable_dirac (by simp)

/-- The second complex moment of the counting measure is the trace of the
matrix square. -/
theorem integral_sq_complex_ofReal_spectralCountingMeasure {n : ℕ}
    (H : HermitianEuclidean n) :
    ∫ x : ℝ, (x : ℂ) ^ 2 ∂spectralCountingMeasure H =
      Matrix.trace ((hermitianToMatrix H) ^ 2) := by
  rw [spectralCountingMeasure]
  rw [integral_finsetSum_measure]
  · simp only [integral_dirac]
    exact (trace_sq_eq_sum_sq_orderedHermitianEigenvalues H).symm
  · intro i _
    exact integrable_dirac (by simp)

/-- Coordinatewise measurability of the ordered eigenvalues is sufficient for
Giry measurability of the spectral counting measure. -/
theorem measurable_spectralCountingMeasure_of_measurable_eigenvalues {n : ℕ}
    (h : ∀ i, Measurable (fun H : HermitianEuclidean n =>
      orderedHermitianEigenvalues H i)) :
    Measurable (@spectralCountingMeasure n) := by
  unfold spectralCountingMeasure
  exact Finset.measurable_fun_sum Finset.univ fun i _ =>
    Measure.measurable_dirac.comp (h i)

/-- The empirical spectral measure, defined as `n⁻¹` times the spectral
counting measure. This definition deliberately returns zero when `n = 0`. -/
noncomputable def empiricalSpectralMeasure {n : ℕ}
    (H : HermitianEuclidean n) : Measure ℝ :=
  (n : ℝ≥0∞)⁻¹ • spectralCountingMeasure H

/-- Unitary congruence preserves the empirical spectral measure. -/
@[simp] theorem empiricalSpectralMeasure_hermitianCongruence {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ) (H : HermitianEuclidean n) :
    empiricalSpectralMeasure (hermitianCongruence U H) =
      empiricalSpectralMeasure H := by
  simp [empiricalSpectralMeasure]

/-- In dimension zero, the empirical spectral measure is the zero measure. -/
@[simp] theorem empiricalSpectralMeasure_zero
    (H : HermitianEuclidean 0) : empiricalSpectralMeasure H = 0 := by
  rw [empiricalSpectralMeasure, spectralCountingMeasure_zero H, smul_zero]

/-- In every dimension, the empirical spectral measure is either zero or a
probability measure. The zero alternative is realized exactly by the explicit
zero-dimensional policy. -/
theorem empiricalSpectralMeasure_isZeroOrProbability {n : ℕ}
    (H : HermitianEuclidean n) :
    IsZeroOrProbabilityMeasure (empiricalSpectralMeasure H) := by
  have hmass : (n : ℝ≥0∞) = spectralCountingMeasure H Set.univ := by
    simp
  rw [empiricalSpectralMeasure, hmass]
  infer_instance

/-- In positive dimension, the empirical spectral measure is a probability
measure. -/
theorem empiricalSpectralMeasure_succ_isProbability (n : ℕ)
    (H : HermitianEuclidean (n + 1)) :
    IsProbabilityMeasure (empiricalSpectralMeasure H) := by
  rw [isProbabilityMeasure_iff]
  rw [empiricalSpectralMeasure, Measure.smul_apply, spectralCountingMeasure_univ]
  exact ENNReal.inv_mul_cancel (by positivity) (by simp)

/-- The positive-dimensional empirical spectral measure bundled as a genuine
`ProbabilityMeasure`. -/
noncomputable def empiricalSpectralProbability (n : ℕ)
    (H : HermitianEuclidean (n + 1)) : ProbabilityMeasure ℝ :=
  ⟨empiricalSpectralMeasure H,
    empiricalSpectralMeasure_succ_isProbability n H⟩

private theorem measurable_const_smul_measure (c : ℝ≥0∞) :
    Measurable (fun μ : Measure ℝ => c • μ) := by
  refine Measure.measurable_of_measurable_coe _ fun s hs => ?_
  simp only [Measure.smul_apply, smul_eq_mul]
  exact _root_.measurable_const.mul (Measure.measurable_coe hs)

/-- Coordinatewise measurability of the ordered eigenvalues is sufficient for
Giry measurability of the empirical spectral measure. -/
theorem measurable_empiricalSpectralMeasure_of_measurable_eigenvalues {n : ℕ}
    (h : ∀ i, Measurable (fun H : HermitianEuclidean n =>
      orderedHermitianEigenvalues H i)) :
    Measurable (@empiricalSpectralMeasure n) := by
  exact (measurable_const_smul_measure (n : ℝ≥0∞)⁻¹).comp
    (measurable_spectralCountingMeasure_of_measurable_eigenvalues h)

/-- Under coordinatewise eigenvalue measurability, the positive-dimensional
`ProbabilityMeasure` wrapper is measurable. -/
theorem measurable_empiricalSpectralProbability_of_measurable_eigenvalues
    {n : ℕ}
    (h : ∀ i, Measurable (fun H : HermitianEuclidean (n + 1) =>
      orderedHermitianEigenvalues H i)) :
    Measurable (empiricalSpectralProbability n) := by
  exact (measurable_empiricalSpectralMeasure_of_measurable_eigenvalues h).subtype_mk

/-- Convert an ambient matrix to the intrinsic Hermitian carrier when it is
Hermitian, and to zero otherwise. This total extension lets intrinsic spectral
observables be composed with ambient matrix laws. -/
noncomputable def matrixToHermitianOrZero (n : ℕ)
    (A : Matrix (Fin n) (Fin n) ℂ) : HermitianEuclidean n :=
  if hA : A.IsHermitian then
    ⟨matrixToFrobenius A, by
      change (frobeniusToMatrix (matrixToFrobenius A)).IsHermitian
      simpa only [frobeniusToMatrix_matrixToFrobenius] using hA⟩
  else 0

private theorem measurable_matrixToFrobenius (n : ℕ) :
    Measurable (@matrixToFrobenius n) := by
  unfold matrixToFrobenius
  apply (WithLp.measurable_toLp 2 (Fin n × Fin n → ℂ)).comp
  rw [measurable_pi_iff]
  intro ij
  exact measurable_entry measurable_id ij.1 ij.2

/-- The Hermitian-or-zero extension from ambient matrices is measurable. -/
theorem measurable_matrixToHermitianOrZero (n : ℕ) :
    Measurable (matrixToHermitianOrZero n) := by
  classical
  apply Measurable.subtype_mk
  change Measurable (fun A =>
    ((matrixToHermitianOrZero n A : HermitianEuclidean n) : FrobeniusMatrix n))
  have hfun :
      (fun A => ((matrixToHermitianOrZero n A : HermitianEuclidean n) :
        FrobeniusMatrix n)) =
      (RandomMatrix.hermitianSet n).piecewise matrixToFrobenius (fun _ => 0) := by
    funext A
    by_cases hA : A.IsHermitian
    · simp [matrixToHermitianOrZero, hermitianSet, hA]
    · simp [matrixToHermitianOrZero, hermitianSet, hA]
  rw [hfun]
  exact Measurable.piecewise (measurableSet_hermitianSet n)
    (measurable_matrixToFrobenius n) _root_.measurable_const

/-- The Hermitian-or-zero extension is a left inverse to the intrinsic
Hermitian inclusion. -/
@[simp] theorem matrixToHermitianOrZero_hermitianToMatrix {n : ℕ}
    (H : HermitianEuclidean n) :
    matrixToHermitianOrZero n (hermitianToMatrix H) = H := by
  apply Subtype.ext
  have hH : (hermitianToMatrix H).IsHermitian := H.2
  simp only [matrixToHermitianOrZero, dif_pos hH]
  rfl

/-- The zero-extended empirical spectral observable on ambient complex
matrices. -/
noncomputable def ambientEmpiricalSpectralMeasure (n : ℕ)
    (A : Matrix (Fin n) (Fin n) ℂ) : Measure ℝ :=
  empiricalSpectralMeasure (matrixToHermitianOrZero n A)

/-- Under coordinatewise eigenvalue measurability, the ambient empirical
spectral observable is Giry-measurable. -/
theorem measurable_ambientEmpiricalSpectralMeasure_of_measurable_eigenvalues
    {n : ℕ}
    (h : ∀ i, Measurable (fun H : HermitianEuclidean n =>
      orderedHermitianEigenvalues H i)) :
    Measurable (ambientEmpiricalSpectralMeasure n) := by
  exact (measurable_empiricalSpectralMeasure_of_measurable_eigenvalues h).comp
    (measurable_matrixToHermitianOrZero n)

/-- Under coordinatewise eigenvalue measurability, pushing the ambient GUE law
through the zero-extended empirical spectral observable agrees exactly with
pushing the intrinsic GUE law through the intrinsic observable. -/
theorem map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw_of_measurable_eigenvalues
    {n : ℕ}
    (h : ∀ i, Measurable (fun H : HermitianEuclidean n =>
      orderedHermitianEigenvalues H i)) :
    (GUE.matrixLaw n).map (ambientEmpiricalSpectralMeasure n) =
      (GUE.intrinsicLaw n).map empiricalSpectralMeasure := by
  rw [GUE.matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw]
  rw [Measure.map_map
    (measurable_ambientEmpiricalSpectralMeasure_of_measurable_eigenvalues h)
    (measurable_hermitianToMatrix n)]
  congr 1
  funext H
  simp [ambientEmpiricalSpectralMeasure]

end RandomMatrix

end NonlinearDynamics.Random
