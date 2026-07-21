import NonlinearDynamics.Random.GaussianPrimitives

/-!
# Cartesian complex Gaussian primitive random variables

This module defines a complex Gaussian law by transporting the product of two
exact real Gaussian laws through the real-linear equivalence
`Complex.equivRealProdCLM.symm`. The parameters `vRe` and `vIm` remain visible:
they are the variances of the real and imaginary coordinates, respectively.

The word *Cartesian* records that the two coordinate laws form a product. It
does not assert circular symmetry, properness, a density formula, or any
matrix-ensemble normalization convention. Both variances may vanish; when
they do, the law is the Dirac mass at the stated complex mean.

As in `GaussianPrimitives`, exact `HasLaw` statements come before qualitative
Gaussianity. `HasCartesianComplexGaussianLaw` therefore provides only
almost-everywhere measurability. The constructor from independent real
variables does not claim ordinary measurability of its inputs.
-/

open MeasureTheory ProbabilityTheory
open scoped ENNReal NNReal ProbabilityTheory

universe uΩ

namespace NonlinearDynamics.Random

variable {Ω : Type uΩ} [MeasurableSpace Ω]

/-- The Cartesian complex Gaussian law with complex mean `m`, real-coordinate
variance `vRe`, and imaginary-coordinate variance `vIm`.

It is the pushforward of the product of the corresponding real Gaussian laws
under the canonical real-linear equivalence `ℝ × ℝ ≃L[ℝ] ℂ`.
-/
noncomputable def cartesianComplexGaussian (m : ℂ) (vRe vIm : ℝ≥0) : Measure ℂ :=
  ((gaussianReal m.re vRe).prod (gaussianReal m.im vIm)).map
    Complex.equivRealProdCLM.symm

/-- A Cartesian complex Gaussian law is a probability measure. -/
instance instIsProbabilityMeasureCartesianComplexGaussian (m : ℂ) (vRe vIm : ℝ≥0) :
    IsProbabilityMeasure (cartesianComplexGaussian m vRe vIm) := by
  unfold cartesianComplexGaussian
  infer_instance

/-- A Cartesian complex Gaussian law is Gaussian as a measure on the real
Banach space underlying `ℂ`. -/
instance instIsGaussianCartesianComplexGaussian (m : ℂ) (vRe vIm : ℝ≥0) :
    IsGaussian (cartesianComplexGaussian m vRe vIm) := by
  unfold cartesianComplexGaussian
  infer_instance

/-- Mapping a Cartesian complex Gaussian law back to its real and imaginary
coordinates recovers the defining product measure. -/
theorem cartesianComplexGaussian_map_equivRealProd (m : ℂ) (vRe vIm : ℝ≥0) :
    (cartesianComplexGaussian m vRe vIm).map Complex.equivRealProdCLM =
      (gaussianReal m.re vRe).prod (gaussianReal m.im vIm) := by
  unfold cartesianComplexGaussian
  rw [Measure.map_map (by fun_prop) (by fun_prop)]
  simp

/-- The real marginal of a Cartesian complex Gaussian law has the requested
exact real Gaussian law. -/
theorem cartesianComplexGaussian_map_re (m : ℂ) (vRe vIm : ℝ≥0) :
    (cartesianComplexGaussian m vRe vIm).map Complex.re =
      gaussianReal m.re vRe := by
  unfold cartesianComplexGaussian
  rw [Measure.map_map (by fun_prop) (by fun_prop)]
  rw [show Complex.re ∘ Complex.equivRealProdCLM.symm = Prod.fst by
    funext p
    simp]
  rw [Measure.map_fst_prod, measure_univ, one_smul]

/-- The imaginary marginal of a Cartesian complex Gaussian law has the
requested exact real Gaussian law. -/
theorem cartesianComplexGaussian_map_im (m : ℂ) (vRe vIm : ℝ≥0) :
    (cartesianComplexGaussian m vRe vIm).map Complex.im =
      gaussianReal m.im vIm := by
  unfold cartesianComplexGaussian
  rw [Measure.map_map (by fun_prop) (by fun_prop)]
  rw [show Complex.im ∘ Complex.equivRealProdCLM.symm = Prod.snd by
    funext p
    simp]
  rw [Measure.map_snd_prod, measure_univ, one_smul]

/-- If both coordinate variances vanish, the Cartesian complex Gaussian law
is the Dirac mass at its mean. -/
theorem cartesianComplexGaussian_zero_variances (m : ℂ) :
    cartesianComplexGaussian m 0 0 = Measure.dirac m := by
  unfold cartesianComplexGaussian
  simp only [gaussianReal_zero_var, Measure.dirac_prod_dirac]
  have hMean : Complex.equivRealProdCLM.symm (m.re, m.im) = m := by
    apply Complex.ext <;> simp
  rw [Measure.map_dirac, hMean]

/-- `Z` has the exact Cartesian complex Gaussian law with mean `m` and
coordinate variances `vRe` and `vIm` under `P`.

This law-level predicate retains the full normalization data. It makes no
circularity or properness claim.
-/
def HasCartesianComplexGaussianLaw (Z : Ω → ℂ) (m : ℂ) (vRe vIm : ℝ≥0)
    (P : Measure Ω) : Prop :=
  HasLaw Z (cartesianComplexGaussian m vRe vIm) P

namespace HasCartesianComplexGaussianLaw

variable {Z : Ω → ℂ} {m : ℂ} {vRe vIm : ℝ≥0} {P : Measure Ω}

/-- An exact Cartesian complex Gaussian law supplies almost-everywhere
measurability, not ordinary measurability. -/
theorem aemeasurable (hZ : HasCartesianComplexGaussianLaw Z m vRe vIm P) :
    AEMeasurable Z P :=
  ProbabilityTheory.HasLaw.aemeasurable hZ

/-- The base measure of a random variable with an exact Cartesian complex
Gaussian law is a probability measure. -/
theorem isProbabilityMeasure (hZ : HasCartesianComplexGaussianLaw Z m vRe vIm P) :
    IsProbabilityMeasure P :=
  ProbabilityTheory.HasLaw.isProbabilityMeasure hZ

/-- The real and imaginary parts jointly have the product of their exact real
Gaussian laws. -/
theorem jointHasLaw (hZ : HasCartesianComplexGaussianLaw Z m vRe vIm P) :
    HasLaw (fun ω ↦ ((Z ω).re, (Z ω).im))
      ((gaussianReal m.re vRe).prod (gaussianReal m.im vIm)) P := by
  have hCoordinates :
      HasLaw (fun z : ℂ ↦ (z.re, z.im))
        ((gaussianReal m.re vRe).prod (gaussianReal m.im vIm))
        (cartesianComplexGaussian m vRe vIm) :=
    ⟨by fun_prop, cartesianComplexGaussian_map_equivRealProd m vRe vIm⟩
  exact hCoordinates.fun_comp hZ

/-- The real part has its requested exact real Gaussian law. -/
theorem real_hasLaw (hZ : HasCartesianComplexGaussianLaw Z m vRe vIm P) :
    HasRealGaussianLaw (fun ω ↦ (Z ω).re) m.re vRe P := by
  have hReal : HasLaw Complex.re (gaussianReal m.re vRe)
      (cartesianComplexGaussian m vRe vIm) :=
    ⟨by fun_prop, cartesianComplexGaussian_map_re m vRe vIm⟩
  exact hReal.fun_comp hZ

/-- The imaginary part has its requested exact real Gaussian law. -/
theorem imag_hasLaw (hZ : HasCartesianComplexGaussianLaw Z m vRe vIm P) :
    HasRealGaussianLaw (fun ω ↦ (Z ω).im) m.im vIm P := by
  have hImag : HasLaw Complex.im (gaussianReal m.im vIm)
      (cartesianComplexGaussian m vRe vIm) :=
    ⟨by fun_prop, cartesianComplexGaussian_map_im m vRe vIm⟩
  exact hImag.fun_comp hZ

/-- The real and imaginary parts are independent under the base measure. -/
theorem indep_re_im (hZ : HasCartesianComplexGaussianLaw Z m vRe vIm P) :
    IndepFun (fun ω ↦ (Z ω).re) (fun ω ↦ (Z ω).im) P := by
  letI : IsProbabilityMeasure P := hZ.isProbabilityMeasure
  exact (indepFun_iff_hasLaw_prodMk_prod hZ.real_hasLaw hZ.imag_hasLaw).2 hZ.jointHasLaw

/-- Forgetting the explicit coordinate means and variances leaves a
qualitative Gaussian law on the real vector space `ℂ`. -/
theorem hasGaussianLaw (hZ : HasCartesianComplexGaussianLaw Z m vRe vIm P) :
    HasGaussianLaw Z P :=
  ProbabilityTheory.HasLaw.hasGaussianLaw hZ

/-- A Cartesian complex Gaussian random variable satisfies `MemLp Z p P` for
every exponent `p ≠ ∞`, including Mathlib's `p = 0` case. -/
theorem memLp (hZ : HasCartesianComplexGaussianLaw Z m vRe vIm P)
    (p : ℝ≥0∞) (hp : p ≠ ∞) : MemLp Z p P :=
  hZ.hasGaussianLaw.memLp hp

/-- A Cartesian complex Gaussian random variable is integrable. -/
theorem integrable (hZ : HasCartesianComplexGaussianLaw Z m vRe vIm P) :
    Integrable Z P :=
  hZ.hasGaussianLaw.integrable

/-- The expectation of a Cartesian complex Gaussian random variable is its
complex mean parameter. -/
theorem mean_eq (hZ : HasCartesianComplexGaussianLaw Z m vRe vIm P) :
    ∫ ω, Z ω ∂P = m := by
  apply Complex.ext
  · have hRealIntegral :
        ∫ ω, (Z ω).re ∂P = (∫ ω, Z ω ∂P).re := by
      simpa only [RCLike.re_to_complex] using integral_re hZ.integrable
    rw [← hRealIntegral]
    exact hZ.real_hasLaw.mean_eq
  · have hImagIntegral :
        ∫ ω, (Z ω).im ∂P = (∫ ω, Z ω ∂P).im := by
      simpa only [RCLike.im_to_complex] using integral_im hZ.integrable
    rw [← hImagIntegral]
    exact hZ.imag_hasLaw.mean_eq

/-- If both coordinate variances vanish, the random variable equals its mean
almost everywhere. -/
theorem ae_eq_const_of_variances_zero
    (hZ : HasCartesianComplexGaussianLaw Z m 0 0 P) :
    Z =ᵐ[P] fun _ ↦ m := by
  apply ProbabilityTheory.HasLaw.ae_eq_of_dirac
  simpa only [HasCartesianComplexGaussianLaw,
    cartesianComplexGaussian_zero_variances] using hZ

/-- Build an exact Cartesian complex Gaussian variable from independent exact
real Gaussian coordinates.

No ordinary measurability hypothesis is added: `HasLaw` supplies the
almost-everywhere measurability needed by `IndepFun.hasLaw_prod` and
`HasLaw.comp`.
-/
theorem of_indep_re_im {X Y : Ω → ℝ}
    (hX : HasRealGaussianLaw X m.re vRe P)
    (hY : HasRealGaussianLaw Y m.im vIm P) (hXY : IndepFun X Y P) :
    HasCartesianComplexGaussianLaw (fun ω ↦ X ω + Y ω * Complex.I)
      m vRe vIm P := by
  letI : IsProbabilityMeasure P := hX.isProbabilityMeasure
  have hProduct : HasLaw (fun ω ↦ (X ω, Y ω))
      ((gaussianReal m.re vRe).prod (gaussianReal m.im vIm)) P :=
    hXY.hasLaw_prod hX hY
  have hToComplex :
      HasLaw Complex.equivRealProdCLM.symm (cartesianComplexGaussian m vRe vIm)
        ((gaussianReal m.re vRe).prod (gaussianReal m.im vIm)) :=
    ⟨by fun_prop, rfl⟩
  have hMapped := hToComplex.comp hProduct
  apply hMapped.congr
  filter_upwards with ω
  simp only [Function.comp_apply, Complex.equivRealProdCLM_symm_apply]

end HasCartesianComplexGaussianLaw

end NonlinearDynamics.Random
