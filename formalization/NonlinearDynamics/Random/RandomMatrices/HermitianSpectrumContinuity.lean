import NonlinearDynamics.Random.RandomMatrices.HermitianSpectrum
import Mathlib.Analysis.Matrix.Normed
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Mathlib.Order.Interval.Finset.Fin

/-!
# Continuity and measurability of finite Hermitian spectra

This module proves a finite-dimensional Weyl perturbation bound for the
decreasingly ordered eigenvalues from `HermitianSpectrum`. Each coordinate is
1-Lipschitz for the intrinsic Frobenius norm. Consequently, the whole ordered
vector is 1-Lipschitz into the finite function space equipped with its sup
metric, and is continuous and measurable. The previously conditional Giry
measurability interfaces for counting and empirical spectral measures, and the
ambient-versus-intrinsic law bridge, are discharged.

The proof uses an order-preserving eigenbasis, top and bottom spectral
subspaces, a finite-dimensional intersection argument, and a Frobenius
matrix-vector bound.

The whole-vector estimate is a sup-metric coordinate bound. It is not the
Hoffman-Wielandt L2 theorem. This module proves no eigenvalue density, spectral
gap, simplicity, asymptotic law, universality, or non-Hermitian perturbation
claim.
-/

open Matrix
open scoped Matrix Norms.Frobenius

namespace NonlinearDynamics.Random.RandomMatrix

noncomputable section

private noncomputable def orderedHermitianEigenvectorBasis {n : ℕ}
    (H : HermitianEuclidean n) :
    OrthonormalBasis (Fin n) ℂ (EuclideanSpace ℂ (Fin n)) :=
  ((Matrix.isSymmetric_toEuclideanLin_iff.mpr H.2).eigenvectorBasis
      finrank_euclideanSpace).reindex
    (Fin.castOrderIso (Fintype.card_fin n).symm).symm.toEquiv

private theorem orderedHermitianEigenvectorBasis_repr_mulVec {n : ℕ}
    (H : HermitianEuclidean n) (x : EuclideanSpace ℂ (Fin n)) (i : Fin n) :
    (orderedHermitianEigenvectorBasis H).repr
        (WithLp.toLp 2 (hermitianToMatrix H *ᵥ x)) i =
      (orderedHermitianEigenvalues H i : ℂ) *
        (orderedHermitianEigenvectorBasis H).repr x i := by
  have h := (Matrix.isSymmetric_toEuclideanLin_iff.mpr H.2).eigenvectorBasis_apply_self_apply
    finrank_euclideanSpace x
    (Fin.cast (Fintype.card_fin n).symm i)
  have he :
      (((Fin.castOrderIso (Fintype.card_fin n).symm).symm.toEquiv).symm i) =
        Fin.cast (Fintype.card_fin n).symm i := by
    rfl
  simp only [orderedHermitianEigenvectorBasis, OrthonormalBasis.repr_reindex,
    he,
    hermitianToMatrix, orderedHermitianEigenvalues,
    Matrix.IsHermitian.eigenvalues₀]
  convert h using 1 <;> rfl

private theorem re_inner_real_mul_self (r : ℝ) (z : ℂ) :
    RCLike.re (inner ℂ z ((r : ℂ) * z)) = r * ‖z‖ ^ 2 := by
  rw [RCLike.inner_apply']
  rw [show (starRingEnd ℂ) z * ((r : ℂ) * z) =
      (r : ℂ) * (z * (starRingEnd ℂ) z) by
    ring]
  rw [Complex.mul_conj]
  change (↑r * (↑(Complex.normSq z) : ℂ)).re = r * ‖z‖ ^ 2
  rw [Complex.mul_re]
  simp only [Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero]
  rw [Complex.sq_norm]

private theorem hermitian_quadratic_eq_weighted_sum {n : ℕ}
    (H : HermitianEuclidean n) (x : EuclideanSpace ℂ (Fin n)) :
    RCLike.re (inner ℂ x (WithLp.toLp 2 (hermitianToMatrix H *ᵥ x))) =
      ∑ i, orderedHermitianEigenvalues H i *
        ‖(orderedHermitianEigenvectorBasis H).repr x i‖ ^ 2 := by
  let b := orderedHermitianEigenvectorBasis H
  let y : EuclideanSpace ℂ (Fin n) :=
    WithLp.toLp 2 (hermitianToMatrix H *ᵥ x)
  calc
    RCLike.re (inner ℂ x y) = RCLike.re (inner ℂ (b.repr x) (b.repr y)) := by
      rw [b.repr.inner_map_map]
    _ = RCLike.re (∑ i, inner ℂ ((b.repr x) i) ((b.repr y) i)) := by
      rw [PiLp.inner_apply]
    _ = RCLike.re (∑ i, inner ℂ ((b.repr x) i)
          ((orderedHermitianEigenvalues H i : ℂ) * (b.repr x) i)) := by
      congr 2
      funext i
      rw [orderedHermitianEigenvectorBasis_repr_mulVec]
    _ = ∑ i, orderedHermitianEigenvalues H i * ‖(b.repr x) i‖ ^ 2 := by
      rw [map_sum]
      apply Finset.sum_congr rfl
      intro i _
      exact re_inner_real_mul_self _ _

private noncomputable def orderedTopEigenSubspace {n : ℕ}
    (H : HermitianEuclidean n) (i : Fin n) :
    Submodule ℂ (EuclideanSpace ℂ (Fin n)) :=
  Submodule.span ℂ (Set.range fun j : Set.Iic i =>
    orderedHermitianEigenvectorBasis H j.1)

private noncomputable def orderedBottomEigenSubspace {n : ℕ}
    (H : HermitianEuclidean n) (i : Fin n) :
    Submodule ℂ (EuclideanSpace ℂ (Fin n)) :=
  Submodule.span ℂ (Set.range fun j : Set.Ici i =>
    orderedHermitianEigenvectorBasis H j.1)

@[simp] private theorem finrank_orderedTopEigenSubspace {n : ℕ}
    (H : HermitianEuclidean n) (i : Fin n) :
    Module.finrank ℂ (orderedTopEigenSubspace H i) = i + 1 := by
  rw [orderedTopEigenSubspace, finrank_span_eq_card]
  · simp
  · exact (orderedHermitianEigenvectorBasis H).orthonormal.linearIndependent.comp
      (fun j : Set.Iic i => j.1) Subtype.val_injective

@[simp] private theorem finrank_orderedBottomEigenSubspace {n : ℕ}
    (H : HermitianEuclidean n) (i : Fin n) :
    Module.finrank ℂ (orderedBottomEigenSubspace H i) = n - i := by
  rw [orderedBottomEigenSubspace, finrank_span_eq_card]
  · simp
  · exact (orderedHermitianEigenvectorBasis H).orthonormal.linearIndependent.comp
      (fun j : Set.Ici i => j.1) Subtype.val_injective

private theorem orderedTopEigenSubspace_eq_span_image {n : ℕ}
    (H : HermitianEuclidean n) (i : Fin n) :
    orderedTopEigenSubspace H i =
      Submodule.span ℂ (orderedHermitianEigenvectorBasis H '' Set.Iic i) := by
  unfold orderedTopEigenSubspace
  congr 1
  ext y
  constructor
  · rintro ⟨j, rfl⟩
    exact ⟨j.1, j.2, rfl⟩
  · rintro ⟨j, hj, rfl⟩
    exact ⟨⟨j, hj⟩, rfl⟩

private theorem orderedBottomEigenSubspace_eq_span_image {n : ℕ}
    (H : HermitianEuclidean n) (i : Fin n) :
    orderedBottomEigenSubspace H i =
      Submodule.span ℂ (orderedHermitianEigenvectorBasis H '' Set.Ici i) := by
  unfold orderedBottomEigenSubspace
  congr 1
  ext y
  constructor
  · rintro ⟨j, rfl⟩
    exact ⟨j.1, j.2, rfl⟩
  · rintro ⟨j, hj, rfl⟩
    exact ⟨⟨j, hj⟩, rfl⟩

private theorem ordered_repr_eq_zero_of_mem_top {n : ℕ}
    (H : HermitianEuclidean n) (i j : Fin n)
    (x : EuclideanSpace ℂ (Fin n)) (hx : x ∈ orderedTopEigenSubspace H i)
    (hji : i < j) :
    (orderedHermitianEigenvectorBasis H).repr x j = 0 := by
  let b := orderedHermitianEigenvectorBasis H
  rw [orderedTopEigenSubspace_eq_span_image] at hx
  have hs := b.toBasis.repr_support_subset_of_mem_span (Set.Iic i) hx
  by_contra hne
  have hjmem : j ∈ (b.toBasis.repr x).support := by
    rw [Finsupp.mem_support_iff]
    simpa only [b.coe_toBasis_repr_apply] using hne
  exact (not_le_of_gt hji) (hs hjmem)

private theorem ordered_repr_eq_zero_of_mem_bottom {n : ℕ}
    (H : HermitianEuclidean n) (i j : Fin n)
    (x : EuclideanSpace ℂ (Fin n)) (hx : x ∈ orderedBottomEigenSubspace H i)
    (hji : j < i) :
    (orderedHermitianEigenvectorBasis H).repr x j = 0 := by
  let b := orderedHermitianEigenvectorBasis H
  rw [orderedBottomEigenSubspace_eq_span_image] at hx
  have hs := b.toBasis.repr_support_subset_of_mem_span (Set.Ici i) hx
  by_contra hne
  have hjmem : j ∈ (b.toBasis.repr x).support := by
    rw [Finsupp.mem_support_iff]
    simpa only [b.coe_toBasis_repr_apply] using hne
  exact (not_le_of_gt hji) (hs hjmem)

private theorem ordered_eigenvalue_mul_norm_sq_le_quadratic_of_mem_top {n : ℕ}
    (H : HermitianEuclidean n) (i : Fin n)
    (x : EuclideanSpace ℂ (Fin n)) (hx : x ∈ orderedTopEigenSubspace H i) :
    orderedHermitianEigenvalues H i * ‖x‖ ^ 2 ≤
      RCLike.re (inner ℂ x (WithLp.toLp 2 (hermitianToMatrix H *ᵥ x))) := by
  let b := orderedHermitianEigenvectorBasis H
  rw [hermitian_quadratic_eq_weighted_sum]
  calc
    orderedHermitianEigenvalues H i * ‖x‖ ^ 2 =
        orderedHermitianEigenvalues H i * ‖b.repr x‖ ^ 2 := by
      rw [b.repr.norm_map]
    _ = orderedHermitianEigenvalues H i *
        ∑ j, ‖(b.repr x) j‖ ^ 2 := by
      rw [EuclideanSpace.norm_sq_eq]
    _ = ∑ j, orderedHermitianEigenvalues H i * ‖(b.repr x) j‖ ^ 2 := by
      rw [Finset.mul_sum]
    _ ≤ ∑ j, orderedHermitianEigenvalues H j * ‖(b.repr x) j‖ ^ 2 := by
      apply Finset.sum_le_sum
      intro j _
      by_cases hji : j ≤ i
      · exact mul_le_mul_of_nonneg_right
          (orderedHermitianEigenvalues_antitone H hji) (sq_nonneg _)
      · have hz := ordered_repr_eq_zero_of_mem_top H i j x hx (lt_of_not_ge hji)
        change orderedHermitianEigenvalues H i *
            ‖(orderedHermitianEigenvectorBasis H).repr x j‖ ^ 2 ≤
          orderedHermitianEigenvalues H j *
            ‖(orderedHermitianEigenvectorBasis H).repr x j‖ ^ 2
        rw [hz]
        norm_num

private theorem quadratic_le_ordered_eigenvalue_mul_norm_sq_of_mem_bottom {n : ℕ}
    (H : HermitianEuclidean n) (i : Fin n)
    (x : EuclideanSpace ℂ (Fin n)) (hx : x ∈ orderedBottomEigenSubspace H i) :
    RCLike.re (inner ℂ x (WithLp.toLp 2 (hermitianToMatrix H *ᵥ x))) ≤
      orderedHermitianEigenvalues H i * ‖x‖ ^ 2 := by
  let b := orderedHermitianEigenvectorBasis H
  rw [hermitian_quadratic_eq_weighted_sum]
  calc
    (∑ j, orderedHermitianEigenvalues H j * ‖(b.repr x) j‖ ^ 2) ≤
        ∑ j, orderedHermitianEigenvalues H i * ‖(b.repr x) j‖ ^ 2 := by
      apply Finset.sum_le_sum
      intro j _
      by_cases hji : i ≤ j
      · exact mul_le_mul_of_nonneg_right
          (orderedHermitianEigenvalues_antitone H hji) (sq_nonneg _)
      · have hz := ordered_repr_eq_zero_of_mem_bottom H i j x hx (lt_of_not_ge hji)
        change orderedHermitianEigenvalues H j *
            ‖(orderedHermitianEigenvectorBasis H).repr x j‖ ^ 2 ≤
          orderedHermitianEigenvalues H i *
            ‖(orderedHermitianEigenvectorBasis H).repr x j‖ ^ 2
        rw [hz]
        norm_num
    _ = orderedHermitianEigenvalues H i *
        ∑ j, ‖(b.repr x) j‖ ^ 2 := by
      rw [Finset.mul_sum]
    _ = orderedHermitianEigenvalues H i * ‖b.repr x‖ ^ 2 := by
      rw [EuclideanSpace.norm_sq_eq]
    _ = orderedHermitianEigenvalues H i * ‖x‖ ^ 2 := by
      rw [b.repr.norm_map]

private theorem ordered_top_inf_bottom_ne_bot {n : ℕ}
    (A B : HermitianEuclidean n) (i : Fin n) :
    orderedTopEigenSubspace A i ⊓ orderedBottomEigenSubspace B i ≠ ⊥ := by
  intro hbot
  have hdis : Disjoint (orderedTopEigenSubspace A i)
      (orderedBottomEigenSubspace B i) := disjoint_iff.mpr hbot
  have hdim := Submodule.finrank_add_finrank_le_of_disjoint hdis
  rw [finrank_orderedTopEigenSubspace, finrank_orderedBottomEigenSubspace,
    finrank_euclideanSpace, Fintype.card_fin] at hdim
  omega

private theorem norm_matrixToFrobenius_eq_frobenius {n : ℕ}
    (A : Matrix (Fin n) (Fin n) ℂ) :
    ‖matrixToFrobenius A‖ = ‖A‖ := by
  rw [EuclideanSpace.norm_eq, Matrix.frobenius_norm_def]
  simp only [matrixToFrobenius]
  rw [Fintype.sum_prod_type]
  rw [Real.sqrt_eq_rpow]
  simp_rw [Real.rpow_two]

/-- The Euclidean L2 norm of `A *ᵥ x` is at most the Frobenius norm of
`A` times the Euclidean L2 norm of `x`. -/
theorem norm_mulVec_le_frobenius {n : ℕ}
    (A : Matrix (Fin n) (Fin n) ℂ) (x : EuclideanSpace ℂ (Fin n)) :
    ‖WithLp.toLp 2 (A *ᵥ x)‖ ≤ ‖matrixToFrobenius A‖ * ‖x‖ := by
  calc
    ‖WithLp.toLp 2 (A *ᵥ x)‖ =
        ‖Matrix.replicateCol (Fin 1) (A *ᵥ x)‖ := by
      exact (Matrix.frobenius_norm_replicateCol
        (ι := Fin 1) (A *ᵥ x)).symm
    _ = ‖A * Matrix.replicateCol (Fin 1) x‖ := by
      rw [Matrix.replicateCol_mulVec]
    _ ≤ ‖A‖ * ‖Matrix.replicateCol (Fin 1) x‖ :=
      Matrix.frobenius_norm_mul _ _
    _ = ‖matrixToFrobenius A‖ * ‖x‖ := by
      rw [norm_matrixToFrobenius_eq_frobenius]
      congr 1
      exact Matrix.frobenius_norm_replicateCol (ι := Fin 1) x

private noncomputable def hermitianQuadratic {n : ℕ}
    (H : HermitianEuclidean n) (x : EuclideanSpace ℂ (Fin n)) : ℝ :=
  RCLike.re (inner ℂ x (WithLp.toLp 2 (hermitianToMatrix H *ᵥ x)))

private theorem abs_hermitianQuadratic_sub_le_frobenius {n : ℕ}
    (A B : HermitianEuclidean n) (x : EuclideanSpace ℂ (Fin n)) :
    |hermitianQuadratic A x - hermitianQuadratic B x| ≤
      ‖A - B‖ * ‖x‖ ^ 2 := by
  let yA : EuclideanSpace ℂ (Fin n) :=
    WithLp.toLp 2 (hermitianToMatrix A *ᵥ x)
  let yB : EuclideanSpace ℂ (Fin n) :=
    WithLp.toLp 2 (hermitianToMatrix B *ᵥ x)
  let yAB : EuclideanSpace ℂ (Fin n) :=
    WithLp.toLp 2 ((hermitianToMatrix A - hermitianToMatrix B) *ᵥ x)
  have hy : yA - yB = yAB := by
    apply PiLp.ext
    intro j
    simp [yA, yB, yAB, Matrix.sub_mulVec]
  have hmul : ‖yAB‖ ≤ ‖A - B‖ * ‖x‖ := by
    have h := norm_mulVec_le_frobenius
      (hermitianToMatrix A - hermitianToMatrix B) x
    change ‖yAB‖ ≤ ‖A - B‖ * ‖x‖
    convert h using 1
    all_goals rfl
  calc
    |hermitianQuadratic A x - hermitianQuadratic B x| =
        |RCLike.re (inner ℂ x yA - inner ℂ x yB)| := by
      simp only [hermitianQuadratic, yA, yB, map_sub]
    _ = |RCLike.re (inner ℂ x yAB)| := by
      rw [← inner_sub_right, hy]
    _ ≤ ‖inner ℂ x yAB‖ := RCLike.abs_re_le_norm _
    _ ≤ ‖x‖ * ‖yAB‖ := norm_inner_le_norm _ _
    _ ≤ ‖x‖ * (‖A - B‖ * ‖x‖) := by
      gcongr
    _ = ‖A - B‖ * ‖x‖ ^ 2 := by ring

/-- One-sided Weyl bound: the `i`th decreasing eigenvalue of `A` is at most
that of `B` plus their intrinsic Frobenius distance `‖A - B‖`. -/
theorem orderedHermitianEigenvalues_le_add_frobenius {n : ℕ}
    (A B : HermitianEuclidean n) (i : Fin n) :
    orderedHermitianEigenvalues A i ≤
      orderedHermitianEigenvalues B i + ‖A - B‖ := by
  obtain ⟨x, hx, hx0⟩ :=
    Submodule.exists_mem_ne_zero_of_ne_bot
      (p := orderedTopEigenSubspace A i ⊓ orderedBottomEigenSubspace B i)
      (ordered_top_inf_bottom_ne_bot A B i)
  have htop := ordered_eigenvalue_mul_norm_sq_le_quadratic_of_mem_top
    A i x hx.1
  have hbottom := quadratic_le_ordered_eigenvalue_mul_norm_sq_of_mem_bottom
    B i x hx.2
  change orderedHermitianEigenvalues A i * ‖x‖ ^ 2 ≤
    hermitianQuadratic A x at htop
  change hermitianQuadratic B x ≤
    orderedHermitianEigenvalues B i * ‖x‖ ^ 2 at hbottom
  have hscaled :
      (orderedHermitianEigenvalues A i - orderedHermitianEigenvalues B i) *
          ‖x‖ ^ 2 ≤
        ‖A - B‖ * ‖x‖ ^ 2 := by
    calc
      (orderedHermitianEigenvalues A i - orderedHermitianEigenvalues B i) *
          ‖x‖ ^ 2 =
        orderedHermitianEigenvalues A i * ‖x‖ ^ 2 -
          orderedHermitianEigenvalues B i * ‖x‖ ^ 2 := by ring
      _ ≤ hermitianQuadratic A x - hermitianQuadratic B x :=
        sub_le_sub htop hbottom
      _ ≤ |hermitianQuadratic A x - hermitianQuadratic B x| := le_abs_self _
      _ ≤ ‖A - B‖ * ‖x‖ ^ 2 :=
        abs_hermitianQuadratic_sub_le_frobenius A B x
  have hxnorm : 0 < ‖x‖ ^ 2 := sq_pos_of_pos (norm_pos_iff.mpr hx0)
  have hdiff :
      orderedHermitianEigenvalues A i - orderedHermitianEigenvalues B i ≤
        ‖A - B‖ := (mul_le_mul_iff_of_pos_right hxnorm).mp hscaled
  linarith

/-- Coordinatewise Weyl bound: the absolute real difference of corresponding
decreasing eigenvalues is bounded by the intrinsic Frobenius distance. -/
theorem abs_orderedHermitianEigenvalues_sub_le_frobenius {n : ℕ}
    (A B : HermitianEuclidean n) (i : Fin n) :
    |orderedHermitianEigenvalues A i - orderedHermitianEigenvalues B i| ≤
      ‖A - B‖ := by
  rw [abs_le]
  constructor
  · have h := orderedHermitianEigenvalues_le_add_frobenius B A i
    rw [norm_sub_rev] at h
    linarith
  · have h := orderedHermitianEigenvalues_le_add_frobenius A B i
    linarith

/-- Each ordered eigenvalue coordinate is 1-Lipschitz from the intrinsic
Hermitian Frobenius metric to the usual metric on `ℝ`. -/
theorem lipschitzWith_orderedHermitianEigenvalues_apply {n : ℕ} (i : Fin n) :
    LipschitzWith 1 (fun H : HermitianEuclidean n =>
      orderedHermitianEigenvalues H i) := by
  apply LipschitzWith.of_dist_le_mul
  intro A B
  simpa only [NNReal.coe_one, one_mul, Real.dist_eq, dist_eq_norm,
    Real.norm_eq_abs] using
    abs_orderedHermitianEigenvalues_sub_le_frobenius A B i

/-- The full ordered spectrum is 1-Lipschitz from the intrinsic Hermitian
Frobenius metric to `Fin n → ℝ` with its sup metric. -/
theorem lipschitzWith_orderedHermitianEigenvalues {n : ℕ} :
    LipschitzWith 1 (@orderedHermitianEigenvalues n) := by
  apply LipschitzWith.of_dist_le_mul
  intro A B
  apply (dist_pi_le_iff (by positivity)).2
  intro i
  exact (lipschitzWith_orderedHermitianEigenvalues_apply i).dist_le_mul A B

/-- Each ordered eigenvalue coordinate is continuous from the intrinsic
Hermitian Frobenius metric to the usual metric on `ℝ`. -/
theorem continuous_orderedHermitianEigenvalues_apply {n : ℕ} (i : Fin n) :
    Continuous (fun H : HermitianEuclidean n => orderedHermitianEigenvalues H i) :=
  (lipschitzWith_orderedHermitianEigenvalues_apply i).continuous

/-- The ordered spectrum is continuous into `Fin n → ℝ` with its sup
metric. -/
theorem continuous_orderedHermitianEigenvalues {n : ℕ} :
    Continuous (@orderedHermitianEigenvalues n) :=
  lipschitzWith_orderedHermitianEigenvalues.continuous

/-- Each ordered eigenvalue coordinate is unconditionally Borel-measurable,
as a consequence of its Frobenius-metric continuity. -/
theorem measurable_orderedHermitianEigenvalues_apply {n : ℕ} (i : Fin n) :
    Measurable (fun H : HermitianEuclidean n => orderedHermitianEigenvalues H i) :=
  (continuous_orderedHermitianEigenvalues_apply i).measurable

/-- The full ordered spectrum is unconditionally measurable into the finite
real function space carrying its Borel measurable structure. -/
theorem measurable_orderedHermitianEigenvalues {n : ℕ} :
    Measurable (@orderedHermitianEigenvalues n) :=
  continuous_orderedHermitianEigenvalues.measurable

/-- The spectral counting measure is unconditionally Giry-measurable; this
discharges RMT-10A's coordinatewise eigenvalue measurability hypothesis. -/
theorem measurable_spectralCountingMeasure {n : ℕ} :
    Measurable (@spectralCountingMeasure n) :=
  measurable_spectralCountingMeasure_of_measurable_eigenvalues
    measurable_orderedHermitianEigenvalues_apply

/-- The zero-aware empirical spectral measure is unconditionally
Giry-measurable by discharging RMT-10A's coordinatewise hypothesis. -/
theorem measurable_empiricalSpectralMeasure {n : ℕ} :
    Measurable (@empiricalSpectralMeasure n) :=
  measurable_empiricalSpectralMeasure_of_measurable_eigenvalues
    measurable_orderedHermitianEigenvalues_apply

/-- In dimension `n + 1`, the empirical `ProbabilityMeasure ℝ` wrapper is
unconditionally measurable after discharging the coordinatewise hypothesis. -/
theorem measurable_empiricalSpectralProbability (n : ℕ) :
    Measurable (empiricalSpectralProbability n) :=
  measurable_empiricalSpectralProbability_of_measurable_eigenvalues
    measurable_orderedHermitianEigenvalues_apply

/-- The Hermitian-or-zero empirical spectral observable on ambient complex
matrices is unconditionally Giry-measurable. -/
theorem measurable_ambientEmpiricalSpectralMeasure (n : ℕ) :
    Measurable (ambientEmpiricalSpectralMeasure n) :=
  measurable_ambientEmpiricalSpectralMeasure_of_measurable_eigenvalues
    measurable_orderedHermitianEigenvalues_apply

/-- Unconditionally, pushing the ambient GUE law through the Hermitian-or-zero
empirical observable equals pushing the intrinsic law through its empirical
spectral measure, discharging RMT-10A's coordinatewise hypothesis. -/
theorem map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw
    (n : ℕ) :
    (GUE.matrixLaw n).map (ambientEmpiricalSpectralMeasure n) =
      (GUE.intrinsicLaw n).map empiricalSpectralMeasure :=
  map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw_of_measurable_eigenvalues
    measurable_orderedHermitianEigenvalues_apply

end

end NonlinearDynamics.Random.RandomMatrix
