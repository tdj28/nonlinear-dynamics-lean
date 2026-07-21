import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleGeometry
import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.MeasureTheory.Constructions.Pi
import Mathlib.Probability.Distributions.Gaussian.Multivariate

/-!
# Intrinsic Gaussian representation and unitary invariance of finite GUE

This module identifies the entrywise Wigner-scaled GUE construction exactly with an isotropic
Gaussian measure on the real inner-product space of Hermitian matrices. Its normalized real
coordinates consist of one diagonal coordinate and two strict-upper coordinates; division by
`sqrt 2` during assembly makes this coordinate map a real-linear isometry for the Frobenius inner
product. Transporting the common-variance product law through that isometry gives the intrinsic
GUE law, and the ambient matrix law is its pushforward along the Hermitian inclusion.

The representation is proved in every finite dimension, including dimension zero. Since unitary
congruence is an orthogonal transformation of intrinsic Hermitian space, invariance of standard
Gaussian measure then yields
`RandomMatrix.IsUnitaryConjugationInvariant (GUE.matrixLaw n)` for every `n`.

No density or Jacobian formula is proved here. The module also makes no eigenvalue, moment, or
asymptotic claim.
-/

open Matrix MeasureTheory ProbabilityTheory
open scoped Matrix NNReal ENNReal RealInnerProductSpace

namespace NonlinearDynamics.Random

/-- One real coordinate for every diagonal entry and two for every strict-upper entry. -/
abbrev HermitianRealIndex (n : ℕ) :=
  Fin n ⊕ (StrictUpperIndex n ⊕ StrictUpperIndex n)

/-- The diagonal, strict-upper, and reflected strict-upper coordinates enumerate all matrix
pairs. -/
def hermitianRealIndexToPair {n : ℕ} : HermitianRealIndex n → Fin n × Fin n
  | .inl i => (i, i)
  | .inr (.inl ij) => ij.1
  | .inr (.inr ij) => (ij.1.2, ij.1.1)

/-- Classify a matrix pair as diagonal, strict upper, or reflected strict upper. -/
def pairToHermitianRealIndex {n : ℕ} : Fin n × Fin n → HermitianRealIndex n
  | (i, j) =>
      if hij : i < j then .inr (.inl ⟨(i, j), hij⟩)
      else if hji : j < i then .inr (.inr ⟨(j, i), hji⟩)
      else .inl i

/-- Classifying the pair represented by a real Hermitian coordinate recovers that coordinate. -/
@[simp] theorem pairToHermitianRealIndex_toPair {n : ℕ}
    (k : HermitianRealIndex n) :
    pairToHermitianRealIndex (hermitianRealIndexToPair k) = k := by
  rcases k with i | k
  · simp [hermitianRealIndexToPair, pairToHermitianRealIndex]
  · rcases k with ij | ij
    · simp [hermitianRealIndexToPair, pairToHermitianRealIndex, ij.2]
    · simp [hermitianRealIndexToPair, pairToHermitianRealIndex, ij.2,
        not_lt_of_ge (le_of_lt ij.2)]

/-- Reading the matrix pair represented by its Hermitian-coordinate classification recovers it. -/
@[simp] theorem hermitianRealIndexToPair_pairTo {n : ℕ} (ij : Fin n × Fin n) :
    hermitianRealIndexToPair (pairToHermitianRealIndex ij) = ij := by
  rcases ij with ⟨i, j⟩
  rcases lt_trichotomy i j with hij | rfl | hji
  · simp [pairToHermitianRealIndex, hermitianRealIndexToPair, hij]
  · simp [pairToHermitianRealIndex, hermitianRealIndexToPair]
  · simp [pairToHermitianRealIndex, hermitianRealIndexToPair, hji,
      not_lt_of_ge (le_of_lt hji)]

/-- The real Hermitian coordinate indices are equivalent to all matrix-entry pairs. -/
def hermitianRealIndexEquivMatrixIndex (n : ℕ) :
    HermitianRealIndex n ≃ Fin n × Fin n where
  toFun := hermitianRealIndexToPair
  invFun := pairToHermitianRealIndex
  left_inv := pairToHermitianRealIndex_toPair
  right_inv := hermitianRealIndexToPair_pairTo

namespace RandomMatrix

/-- Repackage normalized real Hermitian coordinates as the earlier diagonal/upper coordinates. -/
noncomputable def realToHermitianCoordinates {n : ℕ}
    (x : HermitianRealIndex n → ℝ) : HermitianCoordinateSpace n :=
  (fun i ↦ x (.inl i), fun ij ↦
    ⟨x (.inr (.inl ij)) / Real.sqrt 2,
      x (.inr (.inr ij)) / Real.sqrt 2⟩)

/-- Repackaging normalized real coordinates into diagonal/upper coordinates is measurable. -/
@[fun_prop] theorem measurable_realToHermitianCoordinates (n : ℕ) :
    Measurable (@realToHermitianCoordinates n) := by
  apply Measurable.prodMk
  · rw [measurable_pi_iff]
    intro i
    exact measurable_pi_apply (Sum.inl i)
  · rw [measurable_pi_iff]
    intro ij
    change Measurable fun x : HermitianRealIndex n → ℝ ↦
      Complex.equivRealProdCLM.symm
        (x (.inr (.inl ij)) / Real.sqrt 2,
          x (.inr (.inr ij)) / Real.sqrt 2)
    fun_prop

/-- Assemble normalized real coordinates into intrinsic Hermitian space. -/
noncomputable def normalizedHermitianAssembly {n : ℕ}
    (x : EuclideanSpace ℝ (HermitianRealIndex n)) : HermitianEuclidean n :=
  ⟨matrixToFrobenius
      (hermitianCoordinateMap n (realToHermitianCoordinates x)),
    by
      change (hermitianCoordinateMap n (realToHermitianCoordinates x)).IsHermitian
      exact hermitianFromCoordinates_isHermitian _ _⟩

/-- Read normalized real coordinates from an intrinsic Hermitian matrix. -/
noncomputable def normalizedHermitianAnalysis {n : ℕ}
    (H : HermitianEuclidean n) : EuclideanSpace ℝ (HermitianRealIndex n) :=
  WithLp.toLp 2 fun k ↦
    match k with
    | .inl i => (hermitianToMatrix H i i).re
    | .inr (.inl ij) => Real.sqrt 2 * (hermitianToMatrix H ij.1.1 ij.1.2).re
    | .inr (.inr ij) => Real.sqrt 2 * (hermitianToMatrix H ij.1.1 ij.1.2).im

private theorem sqrt_two_ne_zero : Real.sqrt 2 ≠ 0 := by positivity

/-- Forgetting the intrinsic subtype after normalized assembly gives the coordinate matrix. -/
@[simp] theorem hermitianToMatrix_normalizedHermitianAssembly {n : ℕ}
    (x : EuclideanSpace ℝ (HermitianRealIndex n)) :
    hermitianToMatrix (normalizedHermitianAssembly x) =
      hermitianCoordinateMap n (realToHermitianCoordinates x) := by
  rfl

/-- Normalized assembly places a diagonal real coordinate on the matching diagonal entry. -/
@[simp] theorem normalizedHermitianAssembly_apply_diag {n : ℕ}
    (x : EuclideanSpace ℝ (HermitianRealIndex n)) (i : Fin n) :
    (normalizedHermitianAssembly x : FrobeniusMatrix n) (i, i) =
      x (.inl i) := by
  change hermitianCoordinateMap n (realToHermitianCoordinates x) i i = _
  simp [hermitianCoordinateMap, realToHermitianCoordinates]

/-- A strict-upper entry has real and imaginary coordinates divided by `sqrt 2`. -/
@[simp] theorem normalizedHermitianAssembly_apply_upper {n : ℕ}
    (x : EuclideanSpace ℝ (HermitianRealIndex n)) (ij : StrictUpperIndex n) :
    (normalizedHermitianAssembly x : FrobeniusMatrix n) ij.1 =
      ⟨x (.inr (.inl ij)) / Real.sqrt 2,
        x (.inr (.inr ij)) / Real.sqrt 2⟩ := by
  change hermitianCoordinateMap n (realToHermitianCoordinates x) ij.1.1 ij.1.2 = _
  simp [hermitianCoordinateMap, realToHermitianCoordinates, ij.2]

/-- The reflected lower entry is the conjugate of its normalized strict-upper partner. -/
@[simp] theorem normalizedHermitianAssembly_apply_lower {n : ℕ}
    (x : EuclideanSpace ℝ (HermitianRealIndex n)) (ij : StrictUpperIndex n) :
    (normalizedHermitianAssembly x : FrobeniusMatrix n) (ij.1.2, ij.1.1) =
      star ⟨x (.inr (.inl ij)) / Real.sqrt 2,
        x (.inr (.inr ij)) / Real.sqrt 2⟩ := by
  change hermitianCoordinateMap n (realToHermitianCoordinates x) ij.1.2 ij.1.1 = _
  simp [hermitianCoordinateMap, realToHermitianCoordinates, ij.2]

/-- Analyzing an assembled normalized coordinate vector recovers the vector. -/
@[simp] theorem normalizedHermitianAnalysis_assembly {n : ℕ}
    (x : EuclideanSpace ℝ (HermitianRealIndex n)) :
    normalizedHermitianAnalysis (normalizedHermitianAssembly x) = x := by
  ext k
  rcases k with i | k
  · simp [normalizedHermitianAnalysis, realToHermitianCoordinates,
      hermitianCoordinateMap]
  · rcases k with ij | ij
    · simp [normalizedHermitianAnalysis, realToHermitianCoordinates,
        hermitianCoordinateMap, ij.2]
      field_simp
    · simp [normalizedHermitianAnalysis, realToHermitianCoordinates,
        hermitianCoordinateMap, ij.2]
      field_simp

/-- Assembling the normalized coordinates of a Hermitian matrix recovers the matrix. -/
@[simp] theorem normalizedHermitianAssembly_analysis {n : ℕ}
    (H : HermitianEuclidean n) :
    normalizedHermitianAssembly (normalizedHermitianAnalysis H) = H := by
  apply Subtype.ext
  apply (frobeniusMatrixLinearEquiv n).injective
  change hermitianCoordinateMap n
      (realToHermitianCoordinates (normalizedHermitianAnalysis H)) =
    hermitianToMatrix H
  ext i j
  rcases lt_trichotomy i j with hij | rfl | hji
  · simp [normalizedHermitianAnalysis, realToHermitianCoordinates,
      hermitianCoordinateMap, hermitianFromCoordinates, hij]
  · simpa [normalizedHermitianAnalysis, realToHermitianCoordinates,
      hermitianCoordinateMap, hermitianToMatrix] using H.2.coe_re_apply_self i
  · simp [normalizedHermitianAnalysis, realToHermitianCoordinates,
      hermitianCoordinateMap, hermitianFromCoordinates, hji,
      not_lt_of_ge (le_of_lt hji)]
    exact Matrix.IsHermitian.ext_iff.mp H.2 i j

/-- Normalized real coordinates and intrinsic Hermitian matrices are real-linearly equivalent. -/
noncomputable def normalizedHermitianLinearEquiv (n : ℕ) :
    EuclideanSpace ℝ (HermitianRealIndex n) ≃ₗ[ℝ] HermitianEuclidean n where
  toFun := normalizedHermitianAssembly
  invFun := normalizedHermitianAnalysis
  left_inv := normalizedHermitianAnalysis_assembly
  right_inv := normalizedHermitianAssembly_analysis
  map_add' x y := by
    apply Subtype.ext
    apply (frobeniusMatrixLinearEquiv n).injective
    change hermitianCoordinateMap n (realToHermitianCoordinates (x + y)) =
      hermitianCoordinateMap n (realToHermitianCoordinates x) +
        hermitianCoordinateMap n (realToHermitianCoordinates y)
    ext i j
    rcases lt_trichotomy i j with hij | rfl | hji
    · simp [realToHermitianCoordinates, hermitianCoordinateMap,
        hermitianFromCoordinates, hij]
      apply Complex.ext <;> simp <;> ring
    · simp [realToHermitianCoordinates,
        hermitianCoordinateMap]
    · simp [realToHermitianCoordinates, hermitianCoordinateMap,
        hermitianFromCoordinates, hji, not_lt_of_ge (le_of_lt hji)]
      apply Complex.ext <;> simp <;> ring
  map_smul' r x := by
    apply Subtype.ext
    apply (frobeniusMatrixLinearEquiv n).injective
    change hermitianCoordinateMap n (realToHermitianCoordinates (r • x)) =
      r • hermitianCoordinateMap n (realToHermitianCoordinates x)
    ext i j
    rcases lt_trichotomy i j with hij | rfl | hji
    · simp [realToHermitianCoordinates, hermitianCoordinateMap,
        hermitianFromCoordinates, hij, Complex.real_smul]
      apply Complex.ext <;> simp <;> ring
    · simp [realToHermitianCoordinates,
        hermitianCoordinateMap]
    · simp [realToHermitianCoordinates, hermitianCoordinateMap,
        hermitianFromCoordinates, hji, not_lt_of_ge (le_of_lt hji),
        Complex.real_smul]
      apply Complex.ext <;> simp <;> ring

/-- Normalized coordinate assembly preserves the real Frobenius inner product exactly. -/
theorem normalizedHermitianAssembly_inner {n : ℕ}
    (x y : EuclideanSpace ℝ (HermitianRealIndex n)) :
    inner ℝ (normalizedHermitianAssembly x) (normalizedHermitianAssembly y) =
      inner ℝ x y := by
  change inner ℝ
      (normalizedHermitianAssembly x : FrobeniusMatrix n)
      (normalizedHermitianAssembly y : FrobeniusMatrix n) = inner ℝ x y
  simp only [PiLp.inner_apply]
  rw [← (hermitianRealIndexEquivMatrixIndex n).sum_comp]
  simp only [Fintype.sum_sum_type]
  simp [hermitianRealIndexEquivMatrixIndex, hermitianRealIndexToPair,
    Complex.inner]
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro ij _
  field_simp
  rw [Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2)]
  ring

/-- Normalized coordinate assembly is an isometry onto intrinsic Hermitian space. -/
noncomputable def normalizedHermitianLinearIsometryEquiv (n : ℕ) :
    EuclideanSpace ℝ (HermitianRealIndex n) ≃ₗᵢ[ℝ] HermitianEuclidean n :=
  LinearIsometryEquiv.ofBounds (normalizedHermitianLinearEquiv n)
    (fun x ↦ by
      change ‖normalizedHermitianAssembly x‖ ≤ ‖x‖
      apply le_of_eq
      rw [norm_eq_sqrt_real_inner, norm_eq_sqrt_real_inner,
        normalizedHermitianAssembly_inner])
    (fun H ↦ by
      change ‖normalizedHermitianAnalysis H‖ ≤ ‖H‖
      apply le_of_eq
      rw [norm_eq_sqrt_real_inner, norm_eq_sqrt_real_inner]
      have h := normalizedHermitianAssembly_inner
        (normalizedHermitianAnalysis H) (normalizedHermitianAnalysis H)
      rw [normalizedHermitianAssembly_analysis] at h
      rw [h])

end RandomMatrix

/-- A common-variance finite Gaussian product becomes a scalar multiple of standard Gaussian
after the canonical `L²` embedding. -/
theorem map_gaussianProduct_toLp_eq_map_smul_stdGaussian
    {ι : Type*} [Fintype ι] (v : ℝ≥0) :
    (gaussianProductMeasure (fun _ : ι ↦ 0) (fun _ ↦ v)).map (WithLp.toLp 2) =
      (stdGaussian (EuclideanSpace ℝ ι)).map
        (fun x ↦ Real.sqrt (v : ℝ) • x) := by
  let c : ℝ := Real.sqrt (v : ℝ)
  have hc : c ^ 2 = (v : ℝ) := by
    exact Real.sq_sqrt v.coe_nonneg
  have hcoord : (gaussianReal 0 1).map (fun x ↦ c * x) = gaussianReal 0 v := by
    rw [gaussianReal_map_const_mul]
    simp only [mul_zero]
    congr 1
    ext
    simp [hc]
  unfold gaussianProductMeasure
  have hpi :
      (Measure.pi fun _ : ι ↦ gaussianReal 0 1).map
          (fun x i ↦ c * x i) =
        Measure.pi fun _ : ι ↦ gaussianReal 0 v := by
    rw [Measure.pi_map_pi
      (fun _ ↦ (by fun_prop : Measurable fun x : ℝ ↦ c * x).aemeasurable)]
    simp_rw [hcoord]
  rw [← hpi]
  rw [Measure.map_map (by fun_prop) (by fun_prop)]
  have hfun :
      WithLp.toLp 2 ∘ (fun x : ι → ℝ ↦ fun i ↦ c * x i) =
        (fun x : EuclideanSpace ℝ ι ↦ c • x) ∘ WithLp.toLp 2 := by
    funext x
    rfl
  rw [hfun]
  rw [← Measure.map_map (by fun_prop) (by fun_prop)]
  rw [map_pi_eq_stdGaussian]

/-- Dividing a centered real Gaussian by `√2` divides its variance by two. -/
theorem gaussianReal_map_div_sqrt_two (v : ℝ≥0) :
    (gaussianReal 0 v).map (fun x ↦ x / Real.sqrt 2) =
      gaussianReal 0 (v / 2) := by
  rw [gaussianReal_map_div_const]
  simp only [zero_div]
  congr 1
  ext
  simp [Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2)]

/-- Combine two real strict-upper families into a complex family after `1/√2` scaling. -/
noncomputable def realUpperToComplex (n : ℕ)
    (x : (StrictUpperIndex n → ℝ) × (StrictUpperIndex n → ℝ)) :
    StrictUpperIndex n → ℂ :=
  fun ij ↦ Complex.equivRealProdCLM.symm
    (x.1 ij / Real.sqrt 2, x.2 ij / Real.sqrt 2)

@[fun_prop] theorem measurable_realUpperToComplex (n : ℕ) :
    Measurable (realUpperToComplex n) := by
  rw [measurable_pi_iff]
  intro ij
  change Measurable fun x : (StrictUpperIndex n → ℝ) × (StrictUpperIndex n → ℝ) ↦
    Complex.equivRealProdCLM.symm
      (x.1 ij / Real.sqrt 2, x.2 ij / Real.sqrt 2)
  fun_prop

/-- Two common-variance real product families become the required Cartesian complex product law
under normalized pairing. -/
theorem map_realUpperToComplex_gaussianProduct (n : ℕ) (v : ℝ≥0) :
    ((gaussianProductMeasure (fun _ : StrictUpperIndex n ↦ 0) (fun _ ↦ v)).prod
      (gaussianProductMeasure (fun _ : StrictUpperIndex n ↦ 0) (fun _ ↦ v))).map
        (realUpperToComplex n) =
      cartesianComplexGaussianProductMeasure
        (fun _ : StrictUpperIndex n ↦ 0) (fun _ ↦ v / 2) (fun _ ↦ v / 2) := by
  let I := StrictUpperIndex n
  let μ : Measure (I → ℝ) :=
    gaussianProductMeasure (fun _ : I ↦ 0) (fun _ ↦ v)
  let ν : Measure (I → ℝ) :=
    gaussianProductMeasure (fun _ : I ↦ 0) (fun _ ↦ v / 2)
  let scale : (I → ℝ) → I → ℝ := fun x i ↦ x i / Real.sqrt 2
  let split : (I → ℝ × ℝ) ≃ᵐ (I → ℝ) × (I → ℝ) :=
    MeasurableEquiv.arrowProdEquivProdArrow ℝ ℝ I
  let complexify : (I → ℝ × ℝ) → I → ℂ :=
    fun x i ↦ Complex.equivRealProdCLM.symm (x i)
  have hscale : μ.map scale = ν := by
    unfold μ ν scale gaussianProductMeasure
    rw [Measure.pi_map_pi
      (fun _ ↦ (by fun_prop : Measurable fun x : ℝ ↦ x / Real.sqrt 2).aemeasurable)]
    simp_rw [gaussianReal_map_div_sqrt_two]
  have hprod : (μ.prod μ).map (Prod.map scale scale) = ν.prod ν := by
    rw [← Measure.map_prod_map μ μ (by fun_prop) (by fun_prop)]
    rw [hscale]
  have hsplit : (ν.prod ν).map split.symm =
      Measure.pi (fun _ : I ↦
        (gaussianReal 0 (v / 2)).prod (gaussianReal 0 (v / 2))) := by
    exact (measurePreserving_arrowProdEquivProdArrow ℝ ℝ I
      (fun _ ↦ gaussianReal 0 (v / 2))
      (fun _ ↦ gaussianReal 0 (v / 2))).symm.map_eq
  have hcomplex :
      (Measure.pi (fun _ : I ↦
        (gaussianReal 0 (v / 2)).prod (gaussianReal 0 (v / 2)))).map complexify =
        cartesianComplexGaussianProductMeasure
          (fun _ : I ↦ 0) (fun _ ↦ v / 2) (fun _ ↦ v / 2) := by
    unfold complexify cartesianComplexGaussianProductMeasure
    rw [Measure.pi_map_pi (fun _ ↦ (by fun_prop :
      Measurable (Complex.equivRealProdCLM.symm : ℝ × ℝ → ℂ)).aemeasurable)]
    rfl
  change (μ.prod μ).map (realUpperToComplex n) = _
  have hfun : realUpperToComplex n = complexify ∘ split.symm ∘ Prod.map scale scale := by
    funext x i
    rfl
  rw [hfun]
  rw [← Measure.map_map (by fun_prop) (by fun_prop)]
  rw [← Measure.map_map (by fun_prop) (by fun_prop)]
  rw [hprod, hsplit, hcomplex]

namespace GUE

/-- The earlier Hermitian coordinate assembly, now landing in intrinsic Frobenius space. -/
noncomputable def coordinateToHermitianEuclidean (n : ℕ) :
    HermitianCoordinateSpace n → RandomMatrix.HermitianEuclidean n :=
  fun x ↦
    ⟨RandomMatrix.matrixToFrobenius
        (RandomMatrix.hermitianCoordinateMap n x),
      RandomMatrix.hermitianFromCoordinates_isHermitian x.1 x.2⟩

/-- The original diagonal/upper coordinate assembly into intrinsic Hermitian space is measurable. -/
theorem measurable_coordinateToHermitianEuclidean (n : ℕ) :
    Measurable (coordinateToHermitianEuclidean n) := by
  apply Measurable.subtype_mk
  unfold RandomMatrix.matrixToFrobenius
  apply (WithLp.measurable_toLp 2 (Fin n × Fin n → ℂ)).comp
  rw [measurable_pi_iff]
  intro ij
  exact RandomMatrix.measurable_entry
    (RandomMatrix.measurable_hermitianCoordinateMap n) ij.1 ij.2

/-- The original coordinate assembly agrees with normalized real assembly after `L²` embedding. -/
@[simp] theorem coordinateToHermitianEuclidean_realToHermitianCoordinates
    {n : ℕ} (x : HermitianRealIndex n → ℝ) :
    coordinateToHermitianEuclidean n (RandomMatrix.realToHermitianCoordinates x) =
      RandomMatrix.normalizedHermitianAssembly (WithLp.toLp 2 x) := by
  rfl

/-- The finite GUE coordinate law is a single isotropic real Gaussian product, decoded into
diagonal and normalized real/imaginary strict-upper coordinates. -/
theorem map_realToHermitianCoordinates_gaussianProduct (n : ℕ) :
    (gaussianProductMeasure
      (fun _ : HermitianRealIndex n ↦ 0) (fun _ ↦ varianceScale n)).map
        RandomMatrix.realToHermitianCoordinates = coordinateMeasure n := by
  let I := StrictUpperIndex n
  let μdiag : Measure (Fin n → ℝ) :=
    gaussianProductMeasure (fun _ : Fin n ↦ 0) (fun _ ↦ varianceScale n)
  let μupper : Measure (I → ℝ) :=
    gaussianProductMeasure (fun _ : I ↦ 0) (fun _ ↦ varianceScale n)
  let μrest : Measure ((I ⊕ I) → ℝ) :=
    gaussianProductMeasure (fun _ : I ⊕ I ↦ 0) (fun _ ↦ varianceScale n)
  let splitAll : (HermitianRealIndex n → ℝ) ≃ᵐ
      (Fin n → ℝ) × ((I ⊕ I) → ℝ) :=
    MeasurableEquiv.sumPiEquivProdPi (fun _ : Fin n ⊕ (I ⊕ I) ↦ ℝ)
  let splitUpper : ((I ⊕ I) → ℝ) ≃ᵐ (I → ℝ) × (I → ℝ) :=
    MeasurableEquiv.sumPiEquivProdPi (fun _ : I ⊕ I ↦ ℝ)
  let upperDecode : ((I ⊕ I) → ℝ) → I → ℂ :=
    realUpperToComplex n ∘ splitUpper
  have hUpperDecode : Measurable upperDecode := by
    exact (measurable_realUpperToComplex n).comp splitUpper.measurable
  have hAll :
      (gaussianProductMeasure
        (fun _ : HermitianRealIndex n ↦ 0) (fun _ ↦ varianceScale n)).map splitAll =
          μdiag.prod μrest := by
    exact (measurePreserving_sumPiEquivProdPi
      (fun _ : Fin n ⊕ (I ⊕ I) ↦ gaussianReal 0 (varianceScale n))).map_eq
  have hRest : μrest.map splitUpper = μupper.prod μupper := by
    exact (measurePreserving_sumPiEquivProdPi
      (fun _ : I ⊕ I ↦ gaussianReal 0 (varianceScale n))).map_eq
  have hUpper : μrest.map upperDecode =
      cartesianComplexGaussianProductMeasure
        (fun _ : I ↦ 0)
        (fun _ ↦ upperCartesianVariance n)
        (fun _ ↦ upperCartesianVariance n) := by
    unfold upperDecode
    rw [← Measure.map_map (measurable_realUpperToComplex n) splitUpper.measurable]
    rw [hRest]
    simpa only [upperCartesianVariance] using
      map_realUpperToComplex_gaussianProduct n (varianceScale n)
  have hfun : RandomMatrix.realToHermitianCoordinates =
      Prod.map id upperDecode ∘ splitAll := by
    funext x
    rfl
  rw [hfun]
  rw [← Measure.map_map (measurable_id.prodMap hUpperDecode) splitAll.measurable]
  rw [hAll]
  rw [← Measure.map_prod_map μdiag μrest measurable_id hUpperDecode]
  rw [Measure.map_id, hUpper]
  rfl

/-- The coordinate GUE law transported to intrinsic Hermitian space. -/
noncomputable def intrinsicLaw (n : ℕ) :
    Measure (RandomMatrix.HermitianEuclidean n) :=
  (coordinateMeasure n).map (coordinateToHermitianEuclidean n)

/-- The intrinsic GUE law is a probability measure in every dimension. -/
instance instIsProbabilityMeasureIntrinsicLaw (n : ℕ) :
    IsProbabilityMeasure (intrinsicLaw n) :=
  Measure.isProbabilityMeasure_map
    (measurable_coordinateToHermitianEuclidean n).aemeasurable

/-- The intrinsic GUE law is the Wigner-scale scalar multiple of canonical standard Gaussian. -/
theorem intrinsicLaw_eq_map_smul_stdGaussian (n : ℕ) :
    intrinsicLaw n =
      (stdGaussian (RandomMatrix.HermitianEuclidean n)).map
        (fun H ↦ Real.sqrt (varianceScale n : ℝ) • H) := by
  let μ : Measure (HermitianRealIndex n → ℝ) :=
    gaussianProductMeasure
      (fun _ : HermitianRealIndex n ↦ 0) (fun _ ↦ varianceScale n)
  have hAssembly : Measurable (@RandomMatrix.normalizedHermitianAssembly n) := by
    exact (RandomMatrix.normalizedHermitianLinearIsometryEquiv n).continuous.measurable
  unfold intrinsicLaw
  rw [← map_realToHermitianCoordinates_gaussianProduct n]
  rw [Measure.map_map (measurable_coordinateToHermitianEuclidean n)
    (RandomMatrix.measurable_realToHermitianCoordinates n)]
  have hfun :
      coordinateToHermitianEuclidean n ∘ RandomMatrix.realToHermitianCoordinates =
        RandomMatrix.normalizedHermitianAssembly ∘ WithLp.toLp 2 := by
    funext x
    rfl
  rw [hfun]
  rw [← Measure.map_map hAssembly (WithLp.measurable_toLp 2 _)]
  change (μ.map (WithLp.toLp 2)).map
    RandomMatrix.normalizedHermitianAssembly = _
  rw [map_gaussianProduct_toLp_eq_map_smul_stdGaussian]
  rw [Measure.map_map hAssembly (by fun_prop)]
  have hcomm :
      RandomMatrix.normalizedHermitianAssembly ∘
          (fun x : EuclideanSpace ℝ (HermitianRealIndex n) ↦
            Real.sqrt (varianceScale n : ℝ) • x) =
        (fun H : RandomMatrix.HermitianEuclidean n ↦
          Real.sqrt (varianceScale n : ℝ) • H) ∘
            RandomMatrix.normalizedHermitianAssembly := by
    funext x
    exact (RandomMatrix.normalizedHermitianLinearEquiv n).map_smul _ x
  rw [hcomm]
  rw [← Measure.map_map (by fun_prop) hAssembly]
  letI : Module ℝ (RandomMatrix.HermitianEuclidean n) :=
    InnerProductSpace.toNormedSpace.toModule
  let e : EuclideanSpace ℝ (HermitianRealIndex n) ≃ₗ[ℝ]
      RandomMatrix.HermitianEuclidean n :=
    { toFun := RandomMatrix.normalizedHermitianAssembly
      invFun := RandomMatrix.normalizedHermitianAnalysis
      left_inv := RandomMatrix.normalizedHermitianAnalysis_assembly
      right_inv := RandomMatrix.normalizedHermitianAssembly_analysis
      map_add' := fun x y ↦ by
        apply Subtype.ext
        exact congrArg Subtype.val
          ((RandomMatrix.normalizedHermitianLinearEquiv n).map_add x y)
      map_smul' := fun r x ↦ by
        apply Subtype.ext
        change (RandomMatrix.normalizedHermitianAssembly (r • x) :
            RandomMatrix.FrobeniusMatrix n) =
          r • (RandomMatrix.normalizedHermitianAssembly x :
            RandomMatrix.FrobeniusMatrix n)
        exact congrArg Subtype.val
          ((RandomMatrix.normalizedHermitianLinearEquiv n).map_smul r x) }
  let f : EuclideanSpace ℝ (HermitianRealIndex n) ≃ₗᵢ[ℝ]
      RandomMatrix.HermitianEuclidean n :=
    LinearIsometryEquiv.ofBounds e
      (fun x ↦ by
        change ‖RandomMatrix.normalizedHermitianAssembly x‖ ≤ ‖x‖
        apply le_of_eq
        rw [norm_eq_sqrt_real_inner, norm_eq_sqrt_real_inner,
          RandomMatrix.normalizedHermitianAssembly_inner])
      (fun H ↦ by
        change ‖RandomMatrix.normalizedHermitianAnalysis H‖ ≤ ‖H‖
        apply le_of_eq
        rw [norm_eq_sqrt_real_inner, norm_eq_sqrt_real_inner]
        have h := RandomMatrix.normalizedHermitianAssembly_inner
          (RandomMatrix.normalizedHermitianAnalysis H)
          (RandomMatrix.normalizedHermitianAnalysis H)
        rw [RandomMatrix.normalizedHermitianAssembly_analysis] at h
        rw [h])
  have hstd := stdGaussian_map f
  change (stdGaussian (EuclideanSpace ℝ (HermitianRealIndex n))).map
      RandomMatrix.normalizedHermitianAssembly =
    stdGaussian (RandomMatrix.HermitianEuclidean n) at hstd
  rw [hstd]

/-- In dimension zero, the intrinsic GUE law is Dirac at the unique zero Hermitian matrix. -/
theorem intrinsicLaw_zero :
    intrinsicLaw 0 =
      Measure.dirac (0 : RandomMatrix.HermitianEuclidean 0) := by
  rw [intrinsicLaw_eq_map_smul_stdGaussian, varianceScale_zero]
  simp

/-- The ambient GUE law is the intrinsic law pushed through the Hermitian inclusion. -/
theorem matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw (n : ℕ) :
    matrixLaw n =
      (intrinsicLaw n).map RandomMatrix.hermitianToMatrix := by
  rw [matrixLaw_eq_map]
  unfold intrinsicLaw
  rw [Measure.map_map (RandomMatrix.measurable_hermitianToMatrix n)
    (measurable_coordinateToHermitianEuclidean n)]
  congr 1

/-- The intrinsic Wigner-scaled GUE law is invariant under unitary congruence. -/
theorem map_intrinsicLaw_hermitianCongruence {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ) :
    (intrinsicLaw n).map
        (RandomMatrix.hermitianCongruence
          (U : Matrix (Fin n) (Fin n) ℂ)) =
      intrinsicLaw n := by
  have hCong : Measurable
      (RandomMatrix.hermitianCongruence
        (U : Matrix (Fin n) (Fin n) ℂ)) := by
    exact (RandomMatrix.hermitianUnitaryCongruenceLinearIsometryEquiv U).continuous.measurable
  rw [intrinsicLaw_eq_map_smul_stdGaussian]
  rw [Measure.map_map hCong (by fun_prop)]
  have hcomm :
      RandomMatrix.hermitianCongruence
          (U : Matrix (Fin n) (Fin n) ℂ) ∘
          (fun H : RandomMatrix.HermitianEuclidean n ↦
            Real.sqrt (varianceScale n : ℝ) • H) =
        (fun H : RandomMatrix.HermitianEuclidean n ↦
          Real.sqrt (varianceScale n : ℝ) • H) ∘
          RandomMatrix.hermitianCongruence
            (U : Matrix (Fin n) (Fin n) ℂ) := by
    funext H
    exact (RandomMatrix.hermitianUnitaryCongruenceLinearEquiv U).map_smul _ H
  rw [hcomm]
  rw [← Measure.map_map (by fun_prop) hCong]
  have hstdU := RandomMatrix.map_stdGaussian_hermitianUnitaryCongruence U
  change (stdGaussian (RandomMatrix.HermitianEuclidean n)).map
      (RandomMatrix.hermitianCongruence
        (U : Matrix (Fin n) (Fin n) ℂ)) =
    stdGaussian (RandomMatrix.HermitianEuclidean n) at hstdU
  rw [hstdU]

/-- The finite ambient GUE law is invariant under every unitary conjugation. -/
theorem matrixLaw_isUnitaryConjugationInvariant (n : ℕ) :
    RandomMatrix.IsUnitaryConjugationInvariant (matrixLaw n) := by
  intro U
  have hCong : Measurable
      (RandomMatrix.hermitianCongruence
        (U : Matrix (Fin n) (Fin n) ℂ)) := by
    exact (RandomMatrix.hermitianUnitaryCongruenceLinearIsometryEquiv U).continuous.measurable
  rw [matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw]
  rw [Measure.map_map (RandomMatrix.measurable_congruence U)
    (RandomMatrix.measurable_hermitianToMatrix n)]
  have hIntertwine :
      RandomMatrix.congruence (U : Matrix (Fin n) (Fin n) ℂ) ∘
          RandomMatrix.hermitianToMatrix =
        RandomMatrix.hermitianToMatrix ∘
          RandomMatrix.hermitianCongruence
            (U : Matrix (Fin n) (Fin n) ℂ) := by
    funext H
    exact (RandomMatrix.hermitianToMatrix_hermitianCongruence
      (U : Matrix (Fin n) (Fin n) ℂ) H).symm
  rw [hIntertwine]
  rw [← Measure.map_map (RandomMatrix.measurable_hermitianToMatrix n) hCong]
  rw [map_intrinsicLaw_hermitianCongruence U]

end GUE

end NonlinearDynamics.Random
