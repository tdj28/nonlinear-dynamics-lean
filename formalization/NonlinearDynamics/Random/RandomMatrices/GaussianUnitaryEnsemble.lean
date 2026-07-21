import NonlinearDynamics.Random.ComplexGaussianFamilies
import NonlinearDynamics.Random.GaussianPrimitives
import NonlinearDynamics.Random.RandomMatrices.HermitianCoordinates
import NonlinearDynamics.Random.RandomMatrices.Laws

/-!
# Finite-dimensional Gaussian unitary ensemble laws

This module makes the project's Wigner-scaled normalization choice explicit
and constructs the finite-dimensional GUE law in two stages. First, it places
independent centered real Gaussian coordinates on the diagonal and independent
centered Cartesian complex Gaussian coordinates above the diagonal. Second,
it pushes that product law through the deterministic Hermitian coordinate map.

For positive dimension `n`, diagonal entries have variance `1 / n`, while the
real and imaginary parts of every strict-upper entry each have variance
`1 / (2n)`. Dimension zero is defined separately: both coordinate blocks are
empty, their product law is Dirac at the unique coordinate point, and the
matrix law is Dirac at the unique empty matrix.

No density, Hermitian-support-at-the-measure-level, unitary-invariance,
spectral, expectation, moment, or asymptotic claim is made here.
-/

open Matrix MeasureTheory ProbabilityTheory
open scoped ENNReal NNReal ProbabilityTheory Matrix

namespace NonlinearDynamics.Random

namespace GUE

/-- The Wigner variance scale, with an explicit zero-dimensional branch. -/
noncomputable def varianceScale : ℕ → ℝ≥0
  | 0 => 0
  | n + 1 => (((n + 1 : ℕ) : ℝ≥0))⁻¹

/-- The variance of a diagonal real coordinate. -/
noncomputable def diagonalVariance (n : ℕ) : ℝ≥0 := varianceScale n

/-- The variance of each displayed real Cartesian coordinate of an upper entry. -/
noncomputable def upperCartesianVariance (n : ℕ) : ℝ≥0 := varianceScale n / 2

/-- The total variance scale is explicitly zero in dimension zero. -/
@[simp] theorem varianceScale_zero : varianceScale 0 = 0 := rfl

/-- In positive dimension, the total variance scale is the reciprocal of the
dimension. -/
@[simp] theorem varianceScale_succ (n : ℕ) :
    varianceScale (n + 1) = (((n + 1 : ℕ) : ℝ≥0))⁻¹ := rfl

/-- The diagonal-coordinate variance is zero in dimension zero. -/
@[simp] theorem diagonalVariance_zero : diagonalVariance 0 = 0 := rfl

/-- In positive dimension, each diagonal entry has variance reciprocal to the
dimension. -/
@[simp] theorem diagonalVariance_succ (n : ℕ) :
    diagonalVariance (n + 1) = (((n + 1 : ℕ) : ℝ≥0))⁻¹ :=
  varianceScale_succ n

/-- The Cartesian variance of an upper coordinate is zero in dimension zero. -/
@[simp] theorem upperCartesianVariance_zero : upperCartesianVariance 0 = 0 := by
  simp [upperCartesianVariance]

/-- In positive dimension, each real and imaginary upper-coordinate variance
is the reciprocal of twice the dimension. -/
@[simp] theorem upperCartesianVariance_succ (n : ℕ) :
    upperCartesianVariance (n + 1) =
      (((2 * (n + 1) : ℕ) : ℝ≥0))⁻¹ := by
  simp only [upperCartesianVariance, varianceScale_succ]
  push_cast
  rw [mul_inv]
  norm_num [div_eq_mul_inv]
  rw [mul_comm]

/-- The exact product law of the independent Hermitian coordinates. -/
noncomputable def coordinateMeasure (n : ℕ) : Measure (HermitianCoordinateSpace n) :=
  (gaussianProductMeasure (fun _ : Fin n => 0) (fun _ => diagonalVariance n)).prod
    (cartesianComplexGaussianProductMeasure
      (fun _ : StrictUpperIndex n => 0)
      (fun _ => upperCartesianVariance n)
      (fun _ => upperCartesianVariance n))

/-- The coordinate law is a probability measure in every dimension. -/
instance instIsProbabilityMeasureCoordinateMeasure (n : ℕ) :
    IsProbabilityMeasure (coordinateMeasure n) := by
  unfold coordinateMeasure
  infer_instance

/-- The full real diagonal vector has its canonical finite product law. -/
theorem coordinateMeasure_hasLaw_diagonalBlock (n : ℕ) :
    HasLaw Prod.fst
      (gaussianProductMeasure (fun _ : Fin n => 0) (fun _ => diagonalVariance n))
      (coordinateMeasure n) := by
  exact measurePreserving_fst.hasLaw

/-- The full strict-upper vector has its canonical finite product law. -/
theorem coordinateMeasure_hasLaw_upperBlock (n : ℕ) :
    HasLaw Prod.snd
      (cartesianComplexGaussianProductMeasure
        (fun _ : StrictUpperIndex n => 0)
        (fun _ => upperCartesianVariance n)
        (fun _ => upperCartesianVariance n))
      (coordinateMeasure n) := by
  exact measurePreserving_snd.hasLaw

/-- The real diagonal block and complex strict-upper block are independent. -/
theorem coordinateMeasure_indepFun_diagonal_upper (n : ℕ) :
    IndepFun Prod.fst Prod.snd (coordinateMeasure n) := by
  exact indepFun_prod measurable_id measurable_id

/-- Every diagonal coordinate has the exact centered real Gaussian law. -/
theorem coordinateMeasure_diagonal_hasLaw (n : ℕ) (i : Fin n) :
    HasRealGaussianLaw (fun x : HermitianCoordinateSpace n => x.1 i)
      0 (diagonalVariance n) (coordinateMeasure n) := by
  exact (gaussianProductMeasure_hasLaw_eval
    (fun _ : Fin n => 0) (fun _ => diagonalVariance n) i).comp
      (coordinateMeasure_hasLaw_diagonalBlock n)

/-- Every upper coordinate has the exact centered Cartesian complex Gaussian law. -/
theorem coordinateMeasure_upper_hasLaw (n : ℕ) (ij : StrictUpperIndex n) :
    HasCartesianComplexGaussianLaw
      (fun x : HermitianCoordinateSpace n => x.2 ij)
      0 (upperCartesianVariance n) (upperCartesianVariance n)
      (coordinateMeasure n) := by
  exact (cartesianComplexGaussianProductMeasure_hasLaw_eval
    (fun _ : StrictUpperIndex n => 0)
    (fun _ => upperCartesianVariance n)
    (fun _ => upperCartesianVariance n) ij).comp
      (coordinateMeasure_hasLaw_upperBlock n)

/-- Diagonal coordinate evaluations remain mutually independent on the full space. -/
theorem coordinateMeasure_diagonal_iIndepFun (n : ℕ) :
    iIndepFun (fun i (x : HermitianCoordinateSpace n) => x.1 i)
      (coordinateMeasure n) := by
  rw [iIndepFun_iff_hasLaw_pi_pi
    (fun i => coordinateMeasure_diagonal_hasLaw n i)]
  simpa only [gaussianProductMeasure] using
    coordinateMeasure_hasLaw_diagonalBlock n

/-- Upper coordinate evaluations remain mutually independent on the full space. -/
theorem coordinateMeasure_upper_iIndepFun (n : ℕ) :
    iIndepFun (fun ij (x : HermitianCoordinateSpace n) => x.2 ij)
      (coordinateMeasure n) := by
  rw [iIndepFun_iff_hasLaw_pi_pi
    (fun ij => coordinateMeasure_upper_hasLaw n ij)]
  simpa only [cartesianComplexGaussianProductMeasure] using
    coordinateMeasure_hasLaw_upperBlock n

/-- A diagonal coordinate is independent of an upper coordinate. -/
theorem coordinateMeasure_diagonal_indepFun_upper (n : ℕ)
    (i : Fin n) (ij : StrictUpperIndex n) :
    IndepFun (fun x : HermitianCoordinateSpace n => x.1 i)
      (fun x => x.2 ij) (coordinateMeasure n) := by
  simpa only [Function.comp_def] using
    (coordinateMeasure_indepFun_diagonal_upper n).comp
      (measurable_pi_apply i) (measurable_pi_apply ij)

/-- The assembled Wigner-scaled GUE law on ambient complex matrices. -/
noncomputable def matrixLaw (n : ℕ) :
    Measure (Matrix (Fin n) (Fin n) ℂ) :=
  RandomMatrix.law (RandomMatrix.hermitianCoordinateMap n)
    (RandomMatrix.measurable_hermitianCoordinateMap n) (coordinateMeasure n)

/-- The matrix law is the measurable pushforward of the coordinate law. -/
theorem matrixLaw_eq_map (n : ℕ) :
    matrixLaw n = Measure.map (RandomMatrix.hermitianCoordinateMap n)
      (coordinateMeasure n) := rfl

/-- The matrix law is a probability measure in every dimension. -/
instance instIsProbabilityMeasureMatrixLaw (n : ℕ) :
    IsProbabilityMeasure (matrixLaw n) :=
  RandomMatrix.law_isProbabilityMeasure (RandomMatrix.hermitianCoordinateMap n)
    (RandomMatrix.measurable_hermitianCoordinateMap n) (coordinateMeasure n)

/-- Under the matrix law, a diagonal entry has the exact centered Cartesian
complex Gaussian law whose real variance is `1 / n` when `n > 0` and whose
imaginary variance is zero. -/
theorem matrixLaw_diagonal_hasLaw (n : ℕ) (i : Fin n) :
    HasCartesianComplexGaussianLaw
      (fun H : Matrix (Fin n) (Fin n) ℂ => H i i)
      0 (diagonalVariance n) 0 (matrixLaw n) := by
  change HasLaw (fun H : Matrix (Fin n) (Fin n) ℂ => H i i)
    (cartesianComplexGaussian 0 (diagonalVariance n) 0) (matrixLaw n)
  have hAssembly :
      HasLaw (RandomMatrix.hermitianCoordinateMap n) (matrixLaw n)
        (coordinateMeasure n) :=
    ⟨(RandomMatrix.measurable_hermitianCoordinateMap n).aemeasurable, rfl⟩
  have hSource :
      HasCartesianComplexGaussianLaw
        (fun x : HermitianCoordinateSpace n =>
          RandomMatrix.hermitianCoordinateMap n x i i)
        0 (diagonalVariance n) 0 (coordinateMeasure n) := by
    have hZero :
        HasRealGaussianLaw (fun _ : HermitianCoordinateSpace n => (0 : ℝ))
          0 0 (coordinateMeasure n) := by
      rw [HasRealGaussianLaw.zero_variance_iff]
    have hComplex := HasCartesianComplexGaussianLaw.of_indep_re_im
      (m := (0 : ℂ)) (vRe := diagonalVariance n) (vIm := 0)
      (coordinateMeasure_diagonal_hasLaw n i) hZero
      (indepFun_const_right
        (fun x : HermitianCoordinateSpace n => x.1 i) (0 : ℝ))
    refine hComplex.congr ?_
    filter_upwards with x
    simp [RandomMatrix.hermitianCoordinateMap]
  simpa only [Function.comp_apply, id_eq] using HasLaw.comp_of_hasLaw_comp
    (RandomMatrix.measurable_entry measurable_id i i).aemeasurable
    hAssembly HasLaw.id hSource

/-- Under the matrix law, a strict-upper entry has the exact centered
Cartesian complex Gaussian law with equal coordinate variances. -/
theorem matrixLaw_upper_hasLaw (n : ℕ) {i j : Fin n} (hij : i < j) :
    HasCartesianComplexGaussianLaw
      (fun H : Matrix (Fin n) (Fin n) ℂ => H i j)
      0 (upperCartesianVariance n) (upperCartesianVariance n) (matrixLaw n) := by
  change HasLaw (fun H : Matrix (Fin n) (Fin n) ℂ => H i j)
    (cartesianComplexGaussian 0 (upperCartesianVariance n)
      (upperCartesianVariance n)) (matrixLaw n)
  have hAssembly :
      HasLaw (RandomMatrix.hermitianCoordinateMap n) (matrixLaw n)
        (coordinateMeasure n) :=
    ⟨(RandomMatrix.measurable_hermitianCoordinateMap n).aemeasurable, rfl⟩
  have hSource :
      HasCartesianComplexGaussianLaw
        (fun x : HermitianCoordinateSpace n =>
          RandomMatrix.hermitianCoordinateMap n x i j)
        0 (upperCartesianVariance n) (upperCartesianVariance n)
        (coordinateMeasure n) := by
    refine (coordinateMeasure_upper_hasLaw n ⟨(i, j), hij⟩).congr ?_
    filter_upwards with x
    simp [RandomMatrix.hermitianCoordinateMap, hij]
  simpa only [Function.comp_apply, id_eq] using HasLaw.comp_of_hasLaw_comp
    (RandomMatrix.measurable_entry measurable_id i j).aemeasurable
    hAssembly HasLaw.id hSource

/-- In dimension zero, the coordinate law is the Dirac mass at zero. -/
theorem coordinateMeasure_zero :
    coordinateMeasure 0 = Measure.dirac (0 : HermitianCoordinateSpace 0) := by
  unfold coordinateMeasure gaussianProductMeasure
    cartesianComplexGaussianProductMeasure
  rw [Measure.pi_of_empty, Measure.pi_of_empty]
  rw [Measure.dirac_prod_dirac]
  congr
  · exact Subsingleton.elim _ _
  · exact Subsingleton.elim _ _

/-- In dimension zero, the matrix law is the Dirac mass at the empty matrix. -/
theorem matrixLaw_zero :
    matrixLaw 0 = Measure.dirac (0 : Matrix (Fin 0) (Fin 0) ℂ) := by
  rw [matrixLaw_eq_map, coordinateMeasure_zero]
  rw [Measure.map_dirac' (RandomMatrix.measurable_hermitianCoordinateMap 0)]
  simp

end GUE

end NonlinearDynamics.Random
