import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsemble
import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Analysis.Normed.Lp.MeasurableSpace
import Mathlib.LinearAlgebra.UnitaryGroup
import Mathlib.Probability.Distributions.Gaussian.Multivariate

/-!
# Intrinsic Hermitian geometry and support of finite GUE laws

The project gives ambient matrices an entrywise measurable space, but that
carrier does not have a canonical Hilbert-space norm suitable for Mathlib's
finite-dimensional standard Gaussian. This module therefore flattens an
`n × n` complex matrix into `EuclideanSpace ℂ (Fin n × Fin n)`, equips its
Hermitian locus with the inherited real Frobenius geometry, and relates that
intrinsic carrier back to ambient matrices.

Unitary congruence preserves the complex Frobenius inner product, restricts to
a real linear isometric equivalence of the Hermitian locus, and hence preserves
Mathlib's canonical standard Gaussian on that real Euclidean space. Separately,
the coordinate GUE law constructed earlier is proved to assign full mass to
the measurable set of Hermitian ambient matrices.

This module does not yet identify the coordinate GUE law with a scaled
intrinsic standard Gaussian, and therefore does not claim unitary-conjugation
invariance of `GUE.matrixLaw`. It also makes no density, Jacobian, spectral,
eigenvalue, moment, or asymptotic claim.
-/

open Matrix MeasureTheory ProbabilityTheory
open scoped Matrix RealInnerProductSpace

namespace NonlinearDynamics.Random

namespace RandomMatrix

/-- Complex matrices flattened into their canonical finite Frobenius Euclidean
space. -/
abbrev FrobeniusMatrix (n : ℕ) := EuclideanSpace ℂ (Fin n × Fin n)

/-- Reinterpret a flattened Frobenius vector as a square complex matrix. -/
def frobeniusToMatrix {n : ℕ} (x : FrobeniusMatrix n) : Matrix (Fin n) (Fin n) ℂ :=
  fun i j => x (i, j)

/-- Flatten a square complex matrix into the Frobenius Euclidean carrier. -/
def matrixToFrobenius {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) : FrobeniusMatrix n :=
  WithLp.toLp 2 (fun ij => A ij.1 ij.2)

/-- Flattening a matrix and then restoring its entries is the identity. -/
@[simp] theorem frobeniusToMatrix_matrixToFrobenius {n : ℕ}
    (A : Matrix (Fin n) (Fin n) ℂ) : frobeniusToMatrix (matrixToFrobenius A) = A := by
  rfl

/-- Restoring a Frobenius vector as a matrix and flattening it is the identity. -/
@[simp] theorem matrixToFrobenius_frobeniusToMatrix {n : ℕ}
    (x : FrobeniusMatrix n) : matrixToFrobenius (frobeniusToMatrix x) = x := by
  rfl

/-- Entry flattening as a complex linear equivalence between the Frobenius
carrier and ambient matrices. -/
noncomputable def frobeniusMatrixLinearEquiv (n : ℕ) :
    FrobeniusMatrix n ≃ₗ[ℂ] Matrix (Fin n) (Fin n) ℂ where
  toFun := frobeniusToMatrix
  invFun := matrixToFrobenius
  left_inv := matrixToFrobenius_frobeniusToMatrix
  right_inv := frobeniusToMatrix_matrixToFrobenius
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

/-- The Hermitian matrices as a real submodule of the complex Frobenius
carrier. Real scalars are essential because the Hermitian locus is not closed
under arbitrary complex scalar multiplication. -/
def hermitianSubmodule (n : ℕ) : Submodule ℝ (FrobeniusMatrix n) where
  carrier := {x | (frobeniusToMatrix x).IsHermitian}
  zero_mem' := Matrix.isHermitian_zero
  add_mem' hx hy := by
    change (frobeniusToMatrix _ + frobeniusToMatrix _).IsHermitian
    exact hx.add hy
  smul_mem' r x hx := by
    change (r • frobeniusToMatrix x).IsHermitian
    exact hx.smul (IsSelfAdjoint.all r)

/-- The intrinsic finite-dimensional real Euclidean space of Hermitian
matrices, with the inherited Frobenius norm and inner product. -/
abbrev HermitianEuclidean (n : ℕ) := hermitianSubmodule n

/-- Forget the intrinsic Hermitian/Frobenius structure and return the
corresponding ambient complex matrix. -/
def hermitianToMatrix {n : ℕ} (x : HermitianEuclidean n) :
    Matrix (Fin n) (Fin n) ℂ :=
  frobeniusToMatrix x

/-- The intrinsic-to-ambient Hermitian inclusion is measurable. -/
theorem measurable_hermitianToMatrix (n : ℕ) :
    Measurable (@hermitianToMatrix n) := by
  rw [NonlinearDynamics.Random.RandomMatrix.measurable_iff_entries]
  intro i j
  change Measurable fun x : HermitianEuclidean n ↦ (x : FrobeniusMatrix n) (i, j)
  fun_prop

/-- The complex Frobenius inner product is the trace of `xᴴ * y`. -/
theorem inner_frobenius_eq_trace {n : ℕ} (x y : FrobeniusMatrix n) :
    inner ℂ x y = Matrix.trace ((frobeniusToMatrix x)ᴴ * frobeniusToMatrix y) := by
  simp only [PiLp.inner_apply, RCLike.inner_apply, Matrix.trace, Matrix.diag_apply,
    Matrix.mul_apply, Matrix.conjTranspose_apply, frobeniusToMatrix]
  rw [Fintype.sum_prod_type]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro i _
  apply Finset.sum_congr rfl
  intro j _
  rw [mul_comm]
  change star (x.ofLp (j, i)) * y.ofLp (j, i) = _
  rfl

/-- Matrix congruence `x ↦ U * x * Uᴴ` transported to the flattened
Frobenius carrier. -/
def frobeniusCongruence {n : ℕ} (U : Matrix (Fin n) (Fin n) ℂ)
    (x : FrobeniusMatrix n) : FrobeniusMatrix n :=
  matrixToFrobenius (U * frobeniusToMatrix x * Uᴴ)

/-- Restoring a Frobenius congruence gives ordinary matrix congruence. -/
@[simp] theorem frobeniusToMatrix_frobeniusCongruence {n : ℕ}
    (U : Matrix (Fin n) (Fin n) ℂ) (x : FrobeniusMatrix n) :
    frobeniusToMatrix (frobeniusCongruence U x) = U * frobeniusToMatrix x * Uᴴ := by
  rfl

/-- Congruence by a unitary matrix as a complex linear equivalence of the full
Frobenius carrier. Its inverse is congruence by the conjugate transpose. -/
noncomputable def unitaryCongruenceLinearEquiv {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ) : FrobeniusMatrix n ≃ₗ[ℂ] FrobeniusMatrix n where
  toFun := frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ)
  invFun := frobeniusCongruence ((U : Matrix (Fin n) (Fin n) ℂ)ᴴ)
  left_inv x := by
    apply (frobeniusMatrixLinearEquiv n).injective
    change frobeniusToMatrix
        (frobeniusCongruence ((U : Matrix (Fin n) (Fin n) ℂ)ᴴ)
          (frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ) x)) =
      frobeniusToMatrix x
    rw [frobeniusToMatrix_frobeniusCongruence,
      frobeniusToMatrix_frobeniusCongruence, Matrix.conjTranspose_conjTranspose]
    simp only [Matrix.mul_assoc]
    rw [show (U : Matrix (Fin n) (Fin n) ℂ)ᴴ * U = 1 by exact U.2.1]
    rw [mul_one]
    rw [← Matrix.mul_assoc,
      show (U : Matrix (Fin n) (Fin n) ℂ)ᴴ * U = 1 by exact U.2.1, one_mul]
  right_inv x := by
    apply (frobeniusMatrixLinearEquiv n).injective
    change frobeniusToMatrix
        (frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ)
          (frobeniusCongruence ((U : Matrix (Fin n) (Fin n) ℂ)ᴴ) x)) =
      frobeniusToMatrix x
    rw [frobeniusToMatrix_frobeniusCongruence,
      frobeniusToMatrix_frobeniusCongruence, Matrix.conjTranspose_conjTranspose]
    simp only [Matrix.mul_assoc]
    rw [show (U : Matrix (Fin n) (Fin n) ℂ) * Uᴴ = 1 by exact U.2.2]
    rw [mul_one]
    rw [← Matrix.mul_assoc,
      show (U : Matrix (Fin n) (Fin n) ℂ) * Uᴴ = 1 by exact U.2.2, one_mul]
  map_add' x y := by
    apply (frobeniusMatrixLinearEquiv n).injective
    change frobeniusToMatrix
        (frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ) (x + y)) =
      frobeniusToMatrix
          (frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ) x) +
        frobeniusToMatrix
          (frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ) y)
    rw [frobeniusToMatrix_frobeniusCongruence,
      frobeniusToMatrix_frobeniusCongruence,
      frobeniusToMatrix_frobeniusCongruence]
    change (U : Matrix (Fin n) (Fin n) ℂ) *
        (frobeniusToMatrix x + frobeniusToMatrix y) *
          (U : Matrix (Fin n) (Fin n) ℂ)ᴴ =
      ((U : Matrix (Fin n) (Fin n) ℂ) * frobeniusToMatrix x *
          (U : Matrix (Fin n) (Fin n) ℂ)ᴴ) +
        ((U : Matrix (Fin n) (Fin n) ℂ) * frobeniusToMatrix y *
          (U : Matrix (Fin n) (Fin n) ℂ)ᴴ)
    rw [Matrix.mul_add, Matrix.add_mul]
  map_smul' c x := by
    apply (frobeniusMatrixLinearEquiv n).injective
    change frobeniusToMatrix
        (frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ) (c • x)) =
      c • frobeniusToMatrix
        (frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ) x)
    rw [frobeniusToMatrix_frobeniusCongruence,
      frobeniusToMatrix_frobeniusCongruence]
    change (U : Matrix (Fin n) (Fin n) ℂ) * (c • frobeniusToMatrix x) *
        (U : Matrix (Fin n) (Fin n) ℂ)ᴴ =
      c • ((U : Matrix (Fin n) (Fin n) ℂ) * frobeniusToMatrix x *
        (U : Matrix (Fin n) (Fin n) ℂ)ᴴ)
    rw [Matrix.mul_smul, Matrix.smul_mul]

/-- Unitary congruence preserves the complex Frobenius inner product. -/
theorem frobeniusCongruence_inner {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ) (x y : FrobeniusMatrix n) :
    inner ℂ (frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ) x)
        (frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ) y) =
      inner ℂ x y := by
  rw [inner_frobenius_eq_trace, inner_frobenius_eq_trace]
  rw [frobeniusToMatrix_frobeniusCongruence,
    frobeniusToMatrix_frobeniusCongruence]
  have hstar : (U : Matrix (Fin n) (Fin n) ℂ)ᴴ * U = 1 := U.2.1
  have hcollapse :
      (U : Matrix (Fin n) (Fin n) ℂ)ᴴ *
          ((U : Matrix (Fin n) (Fin n) ℂ) *
            (frobeniusToMatrix y * Uᴴ)) =
        frobeniusToMatrix y * Uᴴ := by
    rw [← Matrix.mul_assoc, hstar, one_mul]
  calc
    Matrix.trace
        (((U : Matrix (Fin n) (Fin n) ℂ) * frobeniusToMatrix x * Uᴴ)ᴴ *
          ((U : Matrix (Fin n) (Fin n) ℂ) * frobeniusToMatrix y * Uᴴ)) =
        Matrix.trace
          ((U : Matrix (Fin n) (Fin n) ℂ) *
            ((frobeniusToMatrix x)ᴴ * frobeniusToMatrix y) * Uᴴ) := by
              simp only [Matrix.conjTranspose_mul, Matrix.conjTranspose_conjTranspose]
              simp only [Matrix.mul_assoc]
              rw [hcollapse]
    _ = Matrix.trace
          (Uᴴ * (U : Matrix (Fin n) (Fin n) ℂ) *
            ((frobeniusToMatrix x)ᴴ * frobeniusToMatrix y)) := by
              exact Matrix.trace_mul_cycle _ _ _
    _ = Matrix.trace ((frobeniusToMatrix x)ᴴ * frobeniusToMatrix y) := by
      rw [hstar, one_mul]

/-- Unitary congruence as a complex linear isometric equivalence of the full
Frobenius carrier. -/
noncomputable def unitaryCongruenceLinearIsometryEquiv {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ) : FrobeniusMatrix n ≃ₗᵢ[ℂ] FrobeniusMatrix n :=
  LinearEquiv.isometryOfInner (unitaryCongruenceLinearEquiv U) (frobeniusCongruence_inner U)

/-- Congruence restricted to the intrinsic Hermitian Euclidean space. -/
def hermitianCongruence {n : ℕ} (U : Matrix (Fin n) (Fin n) ℂ)
    (x : HermitianEuclidean n) : HermitianEuclidean n :=
  ⟨frobeniusCongruence U x, by
    change (U * frobeniusToMatrix x * Uᴴ).IsHermitian
    exact Matrix.isHermitian_mul_mul_conjTranspose U x.2⟩

/-- Coercing intrinsic Hermitian congruence exposes full Frobenius
congruence. -/
@[simp] theorem hermitianCongruence_coe {n : ℕ}
    (U : Matrix (Fin n) (Fin n) ℂ) (x : HermitianEuclidean n) :
    (hermitianCongruence U x : FrobeniusMatrix n) = frobeniusCongruence U x := rfl

/-- The intrinsic-to-ambient inclusion intertwines Hermitian congruence with
ambient matrix congruence. -/
@[simp] theorem hermitianToMatrix_hermitianCongruence {n : ℕ}
    (U : Matrix (Fin n) (Fin n) ℂ) (x : HermitianEuclidean n) :
    hermitianToMatrix (hermitianCongruence U x) =
      NonlinearDynamics.Random.RandomMatrix.congruence U (hermitianToMatrix x) := by
  rfl

/-- Unitary congruence as a real linear equivalence of the intrinsic
Hermitian Euclidean space. -/
noncomputable def hermitianUnitaryCongruenceLinearEquiv {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ) :
    HermitianEuclidean n ≃ₗ[ℝ] HermitianEuclidean n where
  toFun := hermitianCongruence (U : Matrix (Fin n) (Fin n) ℂ)
  invFun := hermitianCongruence ((U : Matrix (Fin n) (Fin n) ℂ)ᴴ)
  left_inv x := by
    apply Subtype.ext
    exact (unitaryCongruenceLinearEquiv U).left_inv x
  right_inv x := by
    apply Subtype.ext
    exact (unitaryCongruenceLinearEquiv U).right_inv x
  map_add' x y := by
    apply Subtype.ext
    exact (unitaryCongruenceLinearEquiv U).map_add x y
  map_smul' r x := by
    apply Subtype.ext
    change frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ) (r • (x : FrobeniusMatrix n)) =
      r • frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ) x
    have hin : r • (x : FrobeniusMatrix n) = (r : ℂ) • (x : FrobeniusMatrix n) := by
      ext ij
      simp [Complex.real_smul]
    have hout : r • frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ) x =
        (r : ℂ) • frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ) x := by
      ext ij
      simp [Complex.real_smul]
    rw [hin, hout]
    exact (unitaryCongruenceLinearEquiv U).map_smul (r : ℂ) (x : FrobeniusMatrix n)

/-- Unitary congruence as a real linear isometric equivalence of the
intrinsic Hermitian Euclidean space. -/
noncomputable def hermitianUnitaryCongruenceLinearIsometryEquiv {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ) :
    HermitianEuclidean n ≃ₗᵢ[ℝ] HermitianEuclidean n :=
  LinearIsometryEquiv.ofBounds (hermitianUnitaryCongruenceLinearEquiv U)
    (fun x => by
      change ‖frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ)
        (x : FrobeniusMatrix n)‖ ≤ ‖(x : FrobeniusMatrix n)‖
      exact le_of_eq ((unitaryCongruenceLinearIsometryEquiv U).norm_map
        (x : FrobeniusMatrix n)))
    (fun y => by
      change ‖frobeniusCongruence ((U : Matrix (Fin n) (Fin n) ℂ)ᴴ)
        (y : FrobeniusMatrix n)‖ ≤ ‖(y : FrobeniusMatrix n)‖
      exact le_of_eq ((unitaryCongruenceLinearIsometryEquiv U).symm.norm_map
        (y : FrobeniusMatrix n)))

/-- The canonical standard Gaussian on the intrinsic Hermitian Euclidean
space is invariant under unitary congruence. This is not yet a statement about
`GUE.matrixLaw`; the coordinate-law identification remains separate. -/
theorem map_stdGaussian_hermitianUnitaryCongruence {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ) :
    (stdGaussian (HermitianEuclidean n)).map
        (hermitianUnitaryCongruenceLinearIsometryEquiv U) =
      stdGaussian (HermitianEuclidean n) := by
  letI : Module ℝ (HermitianEuclidean n) :=
    InnerProductSpace.toNormedSpace.toModule
  let e : HermitianEuclidean n ≃ₗ[ℝ] HermitianEuclidean n :=
    { toFun := hermitianCongruence (U : Matrix (Fin n) (Fin n) ℂ)
      invFun := hermitianCongruence ((U : Matrix (Fin n) (Fin n) ℂ)ᴴ)
      left_inv := fun x ↦ by
        apply Subtype.ext
        exact (unitaryCongruenceLinearEquiv U).left_inv x
      right_inv := fun x ↦ by
        apply Subtype.ext
        exact (unitaryCongruenceLinearEquiv U).right_inv x
      map_add' := fun x y ↦ by
        apply Subtype.ext
        exact (unitaryCongruenceLinearEquiv U).map_add x y
      map_smul' := fun r x ↦ by
        apply Subtype.ext
        change frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ)
            (r • (x : FrobeniusMatrix n)) =
          r • frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ) x
        have hin : r • (x : FrobeniusMatrix n) =
            (r : ℂ) • (x : FrobeniusMatrix n) := by
          ext ij
          simp [Complex.real_smul]
        have hout : r • frobeniusCongruence
              (U : Matrix (Fin n) (Fin n) ℂ) x =
            (r : ℂ) • frobeniusCongruence
              (U : Matrix (Fin n) (Fin n) ℂ) x := by
          ext ij
          simp [Complex.real_smul]
        rw [hin, hout]
        exact (unitaryCongruenceLinearEquiv U).map_smul
          (r : ℂ) (x : FrobeniusMatrix n) }
  let f : HermitianEuclidean n ≃ₗᵢ[ℝ] HermitianEuclidean n :=
    LinearIsometryEquiv.ofBounds e
      (fun x ↦ by
        change ‖frobeniusCongruence (U : Matrix (Fin n) (Fin n) ℂ)
          (x : FrobeniusMatrix n)‖ ≤ ‖(x : FrobeniusMatrix n)‖
        exact le_of_eq ((unitaryCongruenceLinearIsometryEquiv U).norm_map
          (x : FrobeniusMatrix n)))
      (fun y ↦ by
        change ‖frobeniusCongruence ((U : Matrix (Fin n) (Fin n) ℂ)ᴴ)
          (y : FrobeniusMatrix n)‖ ≤ ‖(y : FrobeniusMatrix n)‖
        exact le_of_eq ((unitaryCongruenceLinearIsometryEquiv U).symm.norm_map
          (y : FrobeniusMatrix n)))
  change (stdGaussian (HermitianEuclidean n)).map
      (hermitianCongruence (U : Matrix (Fin n) (Fin n) ℂ)) =
    stdGaussian (HermitianEuclidean n)
  exact stdGaussian_map f

/-- The entrywise subset of ambient complex matrices that are Hermitian. -/
def hermitianSet (n : ℕ) : Set (Matrix (Fin n) (Fin n) ℂ) :=
  {H | H.IsHermitian}

/-- The Hermitian locus is measurable for the entrywise matrix measurable
space. The proof is entrywise because that ambient space has no global
`MeasurableEq` instance. -/
theorem measurableSet_hermitianSet (n : ℕ) :
    MeasurableSet (hermitianSet n) := by
  have hset : hermitianSet n =
      ⋂ i : Fin n, ⋂ j : Fin n,
        {H : Matrix (Fin n) (Fin n) ℂ | star (H j i) = H i j} := by
    ext H
    simp only [hermitianSet, Set.mem_setOf_eq, Set.mem_iInter]
    rw [Matrix.IsHermitian.ext_iff]
  rw [hset]
  apply MeasurableSet.iInter
  intro i
  apply MeasurableSet.iInter
  intro j
  apply measurableSet_eq_fun
  · exact continuous_star.measurable.comp
      (measurable_entry measurable_id j i)
  · exact measurable_entry measurable_id i j

end RandomMatrix

namespace GUE

/-- The ambient GUE matrix law assigns total mass one to the Hermitian locus. -/
theorem matrixLaw_hermitianSet (n : ℕ) :
    matrixLaw n (RandomMatrix.hermitianSet n) = 1 := by
  rw [matrixLaw_eq_map]
  rw [Measure.map_apply (RandomMatrix.measurable_hermitianCoordinateMap n)
    (RandomMatrix.measurableSet_hermitianSet n)]
  have hpreimage :
      RandomMatrix.hermitianCoordinateMap n ⁻¹' RandomMatrix.hermitianSet n =
        Set.univ := by
    ext x
    simp only [Set.mem_preimage, Set.mem_univ, iff_true]
    exact RandomMatrix.hermitianFromCoordinates_isHermitian x.1 x.2
  rw [hpreimage, measure_univ]

/-- A matrix sampled from the ambient GUE law is almost surely Hermitian. -/
theorem matrixLaw_ae_isHermitian (n : ℕ) :
    ∀ᵐ H ∂matrixLaw n, H.IsHermitian := by
  change RandomMatrix.hermitianSet n ∈ ae (matrixLaw n)
  exact (mem_ae_iff_prob_eq_one
    (RandomMatrix.measurableSet_hermitianSet n)).2
      (matrixLaw_hermitianSet n)

/-- The ambient GUE law assigns zero mass to the complement of the Hermitian
locus. -/
theorem matrixLaw_compl_hermitianSet (n : ℕ) :
    matrixLaw n (RandomMatrix.hermitianSet n)ᶜ = 0 := by
  exact mem_ae_iff.mp (matrixLaw_ae_isHermitian n)

end GUE

end NonlinearDynamics.Random
