import NonlinearDynamics.Random.ComplexGaussian

/-!
# Independent Cartesian complex Gaussian families

This module lifts the exact single-variable law from `ComplexGaussian` to
indexed families. Ordinary coordinate measurability remains explicit, every
coordinate retains separate real and imaginary variances, and mutual
independence is recorded with Mathlib's `iIndepFun`.

Real scalar multiplication scales both coordinate variances by the same
square. This is the operation needed later for deterministic entry scaling,
but no dimension-dependent scale or GUE normalization is selected here.

For finite index types, the joint law is the product of the coordinate
Cartesian complex Gaussian laws. The canonical product sample space realizes
that law with independent evaluation maps. Its empty-index case is stated
explicitly as a Dirac measure at the unique empty function.

Two separately independent real families need not be independent across the
two families. The constructor below therefore accepts independent *pair
vectors* with exact product laws. It never infers missing cross-family
independence.
-/

open MeasureTheory ProbabilityTheory
open scoped ENNReal NNReal ProbabilityTheory

universe uΩ uι

namespace NonlinearDynamics.Random

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]

namespace HasCartesianComplexGaussianLaw

variable {Z : Ω → ℂ} {m : ℂ} {vRe vIm : ℝ≥0} {P : Measure Ω}

/-- Multiplication by a real scalar scales the complex mean and multiplies
both Cartesian coordinate variances by the square of the scalar.

The theorem includes negative and zero scalars. At zero it recovers the
zero-variance Dirac law at the origin.
-/
theorem real_smul (hZ : HasCartesianComplexGaussianLaw Z m vRe vIm P) (c : ℝ) :
    HasCartesianComplexGaussianLaw (fun ω ↦ c • Z ω) (c • m)
      (⟨c ^ 2, sq_nonneg c⟩ * vRe) (⟨c ^ 2, sq_nonneg c⟩ * vIm) P := by
  have hIndep :
      IndepFun (fun ω ↦ c * (Z ω).re) (fun ω ↦ c * (Z ω).im) P := by
    simpa only [Function.comp_def] using
      hZ.indep_re_im.comp (measurable_const_mul c) (measurable_const_mul c)
  have hScaled :
      HasCartesianComplexGaussianLaw
        (fun ω ↦ ((c * (Z ω).re : ℝ) : ℂ) +
          ((c * (Z ω).im : ℝ) : ℂ) * Complex.I)
        ((c : ℂ) * m)
        (⟨c ^ 2, sq_nonneg c⟩ * vRe) (⟨c ^ 2, sq_nonneg c⟩ * vIm) P := by
    apply HasCartesianComplexGaussianLaw.of_indep_re_im
      (m := (c : ℂ) * m)
      (vRe := ⟨c ^ 2, sq_nonneg c⟩ * vRe)
      (vIm := ⟨c ^ 2, sq_nonneg c⟩ * vIm)
      (P := P)
      (X := fun ω ↦ c * (Z ω).re)
      (Y := fun ω ↦ c * (Z ω).im)
    · simpa using hZ.real_hasLaw.const_mul c
    · simpa using hZ.imag_hasLaw.const_mul c
    · exact hIndep
  have hMul :
      HasCartesianComplexGaussianLaw (fun ω ↦ (c : ℂ) * Z ω) ((c : ℂ) * m)
        (⟨c ^ 2, sq_nonneg c⟩ * vRe) (⟨c ^ 2, sq_nonneg c⟩ * vIm) P := by
    apply hScaled.congr
    filter_upwards with ω
    apply Complex.ext <;> simp
  simpa only [Complex.real_smul] using hMul

end HasCartesianComplexGaussianLaw

/-- A family of mutually independent Cartesian complex Gaussian random
variables with explicit means and separate real and imaginary variances.

The bundle is available for arbitrary index types. Finite-product conclusions
below add a `Fintype` assumption only where `Measure.pi` needs one.
-/
structure IndependentCartesianComplexGaussianFamily
    (Z : ι → Ω → ℂ) (m : ι → ℂ) (vRe vIm : ι → ℝ≥0)
    (P : Measure Ω) : Prop where
  /-- Each coordinate is ordinarily measurable. This is stronger than the
  almost-everywhere measurability contained in its exact `HasLaw`. -/
  measurable : ∀ i, Measurable (Z i)
  /-- Each coordinate has its stated exact Cartesian complex Gaussian law. -/
  hasLaw : ∀ i, HasCartesianComplexGaussianLaw (Z i) (m i) (vRe i) (vIm i) P
  /-- The complex coordinate random variables are mutually independent. -/
  independent : iIndepFun Z P

namespace IndependentCartesianComplexGaussianFamily

variable {Z : ι → Ω → ℂ} {m : ι → ℂ} {vRe vIm : ι → ℝ≥0}
  {P : Measure Ω}

/-- Each coordinate in the family is almost-everywhere measurable. -/
theorem aemeasurable
    (hZ : IndependentCartesianComplexGaussianFamily Z m vRe vIm P) (i : ι) :
    AEMeasurable (Z i) P :=
  (hZ.measurable i).aemeasurable

/-- The base measure of an independent Cartesian complex Gaussian family is
a probability measure. This remains true for an empty index type because
Mathlib's `iIndepFun` includes normalization of the base measure. -/
theorem isProbabilityMeasure
    (hZ : IndependentCartesianComplexGaussianFamily Z m vRe vIm P) :
    IsProbabilityMeasure P :=
  hZ.independent.isProbabilityMeasure

/-- The real part of coordinate `i` has its requested exact real Gaussian
law. -/
theorem real_hasLaw
    (hZ : IndependentCartesianComplexGaussianFamily Z m vRe vIm P) (i : ι) :
    HasRealGaussianLaw (fun ω ↦ (Z i ω).re) (m i).re (vRe i) P :=
  (hZ.hasLaw i).real_hasLaw

/-- The imaginary part of coordinate `i` has its requested exact real
Gaussian law. -/
theorem imag_hasLaw
    (hZ : IndependentCartesianComplexGaussianFamily Z m vRe vIm P) (i : ι) :
    HasRealGaussianLaw (fun ω ↦ (Z i ω).im) (m i).im (vIm i) P :=
  (hZ.hasLaw i).imag_hasLaw

/-- The expectation of coordinate `i` is its complex mean parameter. -/
theorem mean_eq
    (hZ : IndependentCartesianComplexGaussianFamily Z m vRe vIm P) (i : ι) :
    ∫ ω, Z i ω ∂P = m i :=
  (hZ.hasLaw i).mean_eq

/-- The variance of the real part of coordinate `i` is its real-coordinate
variance parameter. -/
theorem real_variance_eq
    (hZ : IndependentCartesianComplexGaussianFamily Z m vRe vIm P) (i : ι) :
    Var[fun ω ↦ (Z i ω).re; P] = (vRe i : ℝ) :=
  (hZ.hasLaw i).real_hasLaw.variance_eq

/-- The variance of the imaginary part of coordinate `i` is its
imaginary-coordinate variance parameter. -/
theorem imag_variance_eq
    (hZ : IndependentCartesianComplexGaussianFamily Z m vRe vIm P) (i : ι) :
    Var[fun ω ↦ (Z i ω).im; P] = (vIm i : ℝ) :=
  (hZ.hasLaw i).imag_hasLaw.variance_eq

/-- Every coordinate belongs to `Lᵖ` for each exponent other than infinity,
including Mathlib's `p = 0` case. -/
theorem memLp
    (hZ : IndependentCartesianComplexGaussianFamily Z m vRe vIm P)
    (i : ι) (p : ℝ≥0∞) (hp : p ≠ ∞) : MemLp (Z i) p P :=
  (hZ.hasLaw i).memLp p hp

/-- Every coordinate in the family is integrable. -/
theorem integrable
    (hZ : IndependentCartesianComplexGaussianFamily Z m vRe vIm P) (i : ι) :
    Integrable (Z i) P :=
  (hZ.hasLaw i).integrable

/-- Build a complex Gaussian family from independent real pair-vectors whose
individual pair laws are the requested products.

`hPairLaw` records independence inside each real-imaginary pair. `hPairs`
records mutual independence between the pair-vectors. Merely giving two
separately independent real families would establish neither fact and is not
accepted as a substitute.
-/
theorem of_independent_real_pair_laws
    {X Y : ι → Ω → ℝ}
    (hPairMeasurable : ∀ i, Measurable (fun ω ↦ (X i ω, Y i ω)))
    (hPairLaw : ∀ i, HasLaw (fun ω ↦ (X i ω, Y i ω))
      ((gaussianReal (m i).re (vRe i)).prod
        (gaussianReal (m i).im (vIm i))) P)
    (hPairs : iIndepFun (fun i ω ↦ (X i ω, Y i ω)) P) :
    IndependentCartesianComplexGaussianFamily
      (fun i ω ↦ (X i ω : ℂ) + (Y i ω : ℂ) * Complex.I)
      m vRe vIm P := by
  refine ⟨?_, ?_, ?_⟩
  · intro i
    have hToComplex : Measurable fun p : ℝ × ℝ ↦
        (p.1 : ℂ) + (p.2 : ℂ) * Complex.I := by fun_prop
    simpa only [Function.comp_def] using hToComplex.comp (hPairMeasurable i)
  · intro i
    have hToComplex :
        HasLaw Complex.equivRealProdCLM.symm
          (cartesianComplexGaussian (m i) (vRe i) (vIm i))
          ((gaussianReal (m i).re (vRe i)).prod
            (gaussianReal (m i).im (vIm i))) :=
      ⟨by fun_prop, rfl⟩
    have hMapped := hToComplex.comp (hPairLaw i)
    apply hMapped.congr
    filter_upwards with ω
    simp only [Function.comp_apply, Complex.equivRealProdCLM_symm_apply]
  · simpa only [Function.comp_def] using hPairs.comp
      (fun _ p ↦ (p.1 : ℂ) + (p.2 : ℂ) * Complex.I)
      (fun _ ↦ by fun_prop)

/-- Coordinatewise real scaling preserves ordinary measurability, every exact
Cartesian law, and mutual independence.

Both variance functions are multiplied by the same coordinatewise square.
No dimension-dependent normalization is chosen.
-/
theorem scale
    (hZ : IndependentCartesianComplexGaussianFamily Z m vRe vIm P)
    (c : ι → ℝ) :
    IndependentCartesianComplexGaussianFamily
      (fun i ω ↦ c i • Z i ω)
      (fun i ↦ c i • m i)
      (fun i ↦ ⟨(c i) ^ 2, sq_nonneg (c i)⟩ * vRe i)
      (fun i ↦ ⟨(c i) ^ 2, sq_nonneg (c i)⟩ * vIm i) P := by
  refine ⟨fun i ↦ (hZ.measurable i).const_smul (c i),
    fun i ↦ (hZ.hasLaw i).real_smul (c i), ?_⟩
  simpa only [Function.comp_def] using hZ.independent.comp
    (fun i z ↦ c i • z) (fun i ↦ measurable_const_smul (c i))

variable [Fintype ι]

/-- A finite independent Cartesian complex Gaussian family has the exact
product of its coordinate laws as its joint law. -/
theorem jointHasLaw
    (hZ : IndependentCartesianComplexGaussianFamily Z m vRe vIm P) :
    HasLaw (fun ω i ↦ Z i ω)
      (Measure.pi fun i ↦ cartesianComplexGaussian (m i) (vRe i) (vIm i)) P :=
  hZ.independent.hasLaw_pi hZ.hasLaw

/-- After forgetting all explicit coordinate parameters, a finite independent
Cartesian complex Gaussian family is jointly Gaussian. -/
theorem jointHasGaussianLaw
    (hZ : IndependentCartesianComplexGaussianFamily Z m vRe vIm P) :
    HasGaussianLaw (fun ω i ↦ Z i ω) P :=
  hZ.independent.hasGaussianLaw fun i ↦ (hZ.hasLaw i).hasGaussianLaw

end IndependentCartesianComplexGaussianFamily

/-- The canonical finite product of Cartesian complex Gaussian coordinate
laws. -/
noncomputable def cartesianComplexGaussianProductMeasure [Fintype ι]
    (m : ι → ℂ) (vRe vIm : ι → ℝ≥0) : Measure (ι → ℂ) :=
  Measure.pi fun i ↦ cartesianComplexGaussian (m i) (vRe i) (vIm i)

/-- The canonical finite Cartesian complex Gaussian product is a probability
measure. -/
instance instIsProbabilityMeasureCartesianComplexGaussianProduct
    [Fintype ι] (m : ι → ℂ) (vRe vIm : ι → ℝ≥0) :
    IsProbabilityMeasure (cartesianComplexGaussianProductMeasure m vRe vIm) := by
  unfold cartesianComplexGaussianProductMeasure
  infer_instance

/-- Under the canonical product measure, evaluation at `i` has the requested
exact Cartesian complex Gaussian law. -/
theorem cartesianComplexGaussianProductMeasure_hasLaw_eval [Fintype ι]
    (m : ι → ℂ) (vRe vIm : ι → ℝ≥0) (i : ι) :
    HasCartesianComplexGaussianLaw (fun z : ι → ℂ ↦ z i)
      (m i) (vRe i) (vIm i)
      (cartesianComplexGaussianProductMeasure m vRe vIm) := by
  exact (measurePreserving_eval
    (fun i ↦ cartesianComplexGaussian (m i) (vRe i) (vIm i)) i).hasLaw

/-- Coordinate evaluations are mutually independent under the canonical
Cartesian complex Gaussian product measure. -/
theorem cartesianComplexGaussianProductMeasure_iIndepFun [Fintype ι]
    (m : ι → ℂ) (vRe vIm : ι → ℝ≥0) :
    iIndepFun (fun i (z : ι → ℂ) ↦ z i)
      (cartesianComplexGaussianProductMeasure m vRe vIm) := by
  exact iIndepFun_pi
    (μ := fun i ↦ cartesianComplexGaussian (m i) (vRe i) (vIm i))
    (X := fun _ ↦ id) (fun _ ↦ aemeasurable_id)

/-- The evaluation maps on the canonical product sample space form an
independent Cartesian complex Gaussian family. -/
theorem cartesianComplexGaussianProductMeasure_independentFamily [Fintype ι]
    (m : ι → ℂ) (vRe vIm : ι → ℝ≥0) :
    IndependentCartesianComplexGaussianFamily
      (fun i (z : ι → ℂ) ↦ z i) m vRe vIm
      (cartesianComplexGaussianProductMeasure m vRe vIm) :=
  ⟨fun i ↦ measurable_pi_apply i,
    cartesianComplexGaussianProductMeasure_hasLaw_eval m vRe vIm,
    cartesianComplexGaussianProductMeasure_iIndepFun m vRe vIm⟩

/-- For an empty finite index type, the canonical product measure is the
Dirac measure at the unique empty function.

This scalar-product boundary does not choose a policy for zero-dimensional
matrix ensembles.
-/
theorem cartesianComplexGaussianProductMeasure_eq_dirac_of_isEmpty
    [Fintype ι] [IsEmpty ι]
    (m : ι → ℂ) (vRe vIm : ι → ℝ≥0) :
    cartesianComplexGaussianProductMeasure m vRe vIm =
      Measure.dirac (fun i ↦ isEmptyElim i) := by
  unfold cartesianComplexGaussianProductMeasure
  exact Measure.pi_of_empty _ _

end NonlinearDynamics.Random
