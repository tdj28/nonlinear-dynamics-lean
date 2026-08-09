import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul
import NonlinearDynamics.Deterministic.Discrete.Bifurcation

/-!
# The real logistic-map family

This module studies the polynomial family
`logisticMap r x = r * (x * (1 - x))`.  It records the exact fixed-point
equation, two fixed-point branches, the sharp parameter range in which the
closed unit interval maps into itself, two elementary orbit calculations, and
the derivative and fixed-point multiplier formulas.

The interval theorem is an equivalence: `Icc 0 1` is forward invariant exactly
when `r ∈ Icc 0 4`.  Necessity is detected by the midpoint, whose image is
`r / 4`; sufficiency uses the global quadratic bound
`x * (1 - x) ≤ 1 / 4`.

At `r = 1`, the branch `1 - 1 / r` meets the zero branch.  This branch
collision is not by itself promoted to the project's topological bifurcation
predicate.  Likewise, the derivative values are exact multiplier
calculations, not stability or attraction theorems.
-/

open Function Set

namespace NonlinearDynamics.Deterministic.Models

open NonlinearDynamics.Deterministic.Discrete

/-- The real logistic map with parameter `r`. -/
def logisticMap (r x : ℝ) : ℝ :=
  r * (x * (1 - x))

/-- The logistic maps regarded as a parameterized family. -/
abbrev logisticFamily : ParameterizedFamily ℝ ℝ :=
  logisticMap

/-- Zero is fixed for every parameter. -/
@[simp] theorem logisticMap_zero (r : ℝ) :
    logisticMap r 0 = 0 := by
  simp [logisticMap]

/-- One maps to zero for every parameter. -/
@[simp] theorem logisticMap_one (r : ℝ) :
    logisticMap r 1 = 0 := by
  simp [logisticMap]

/-- Each member of the logistic family is continuous. -/
theorem continuous_logisticMap (r : ℝ) :
    Continuous (logisticMap r) := by
  unfold logisticMap
  fun_prop

/-- The fixed-point equation without division by the parameter.  This form is
valid at `r = 0` as well as at nonzero parameters. -/
@[simp] theorem logisticMap_isFixedPt_iff (r x : ℝ) :
    IsFixedPt (logisticMap r) x ↔ x = 0 ∨ r * x = r - 1 := by
  rw [IsFixedPt]
  constructor
  · intro h
    by_cases hx : x = 0
    · exact Or.inl hx
    · right
      have hfactor : x * (r * (1 - x) - 1) = 0 := by
        calc
          x * (r * (1 - x) - 1) = logisticMap r x - x := by
            simp only [logisticMap]
            ring
          _ = 0 := sub_eq_zero.mpr h
      have hlinear : r * (1 - x) - 1 = 0 :=
        (mul_eq_zero.mp hfactor).resolve_left hx
      nlinarith [hlinear]
  · rintro (rfl | h)
    · simp [logisticMap]
    · have hlinear : r * (1 - x) = 1 := by
        nlinarith [h]
      calc
        logisticMap r x = x * (r * (1 - x)) := by
          simp only [logisticMap]
          ring
        _ = x := by rw [hlinear, mul_one]

/-- The nonzero fixed-point branch, written as a total real-valued function.
It satisfies the fixed-point equation only when the parameter is nonzero. -/
noncomputable def logisticNonzeroFixedPoint (r : ℝ) : ℝ :=
  1 - 1 / r

/-- The nonzero branch consists of fixed points away from `r = 0`. -/
theorem logisticNonzeroFixedPoint_isFixedPt {r : ℝ} (hr : r ≠ 0) :
    IsFixedPt (logisticMap r) (logisticNonzeroFixedPoint r) := by
  rw [logisticMap_isFixedPt_iff]
  right
  change r * (1 - 1 / r) = r - 1
  field_simp [hr]

/-- The zero branch is a fixed-point branch on the whole parameter line. -/
theorem logisticFamily_zero_isFixedPointBranchOn :
    IsFixedPointBranchOn logisticFamily (fun _ ↦ 0) univ := by
  intro r _
  simp [IsFixedPt]

/-- The branch `1 - 1 / r` is a fixed-point branch on the nonzero parameters. -/
theorem logisticFamily_nonzero_isFixedPointBranchOn :
    IsFixedPointBranchOn logisticFamily logisticNonzeroFixedPoint
      {r : ℝ | r ≠ 0} := by
  intro r hr
  exact logisticNonzeroFixedPoint_isFixedPt hr

/-- Away from the singular parameter zero, the nonzero branch meets the zero
branch exactly at `r = 1`. -/
@[simp] theorem logisticNonzeroFixedPoint_eq_zero_iff {r : ℝ} (hr : r ≠ 0) :
    logisticNonzeroFixedPoint r = 0 ↔ r = 1 := by
  constructor
  · intro h
    have hzero : 1 - 1 / r = 0 := by
      simpa only [logisticNonzeroFixedPoint] using h
    have hcancel : r * (1 / r) = 1 := by
      field_simp [hr]
    nlinarith [hzero, hcancel]
  · rintro rfl
    norm_num [logisticNonzeroFixedPoint]

/-- The quadratic factor is nonnegative on the closed unit interval. -/
theorem logisticCore_nonneg {x : ℝ} (hx : x ∈ Icc 0 1) :
    0 ≤ x * (1 - x) :=
  mul_nonneg hx.1 (sub_nonneg.mpr hx.2)

/-- The quadratic factor has global maximum `1 / 4` at `x = 1 / 2`. -/
theorem logisticCore_le_oneQuarter (x : ℝ) :
    x * (1 - x) ≤ (1 : ℝ) / 4 := by
  nlinarith [sq_nonneg (x - (1 : ℝ) / 2)]

/-- The midpoint of the unit interval maps to `r / 4`. -/
@[simp] theorem logisticMap_oneHalf (r : ℝ) :
    logisticMap r ((1 : ℝ) / 2) = r / 4 := by
  simp only [logisticMap]
  ring

/-- Parameters in `[0, 4]` make the closed unit interval forward invariant. -/
theorem logisticMap_mapsTo_unitInterval {r : ℝ} (hr : r ∈ Icc 0 4) :
    MapsTo (logisticMap r) (Icc 0 1) (Icc 0 1) := by
  intro x hx
  constructor
  · simpa [logisticMap] using mul_nonneg hr.1 (logisticCore_nonneg hx)
  · rw [logisticMap]
    calc
      r * (x * (1 - x)) ≤ r * ((1 : ℝ) / 4) :=
        mul_le_mul_of_nonneg_left (logisticCore_le_oneQuarter x) hr.1
      _ ≤ 1 := by nlinarith [hr.2]

/-- Forward invariance of `[0, 1]` forces the parameter into `[0, 4]`. -/
theorem logisticMap_parameter_mem_unitInterval_of_mapsTo {r : ℝ}
    (hmap : MapsTo (logisticMap r) (Icc 0 1) (Icc 0 1)) :
    r ∈ Icc 0 4 := by
  have hhalf : logisticMap r ((1 : ℝ) / 2) ∈ Icc 0 1 :=
    hmap (by constructor <;> norm_num)
  rw [logisticMap_oneHalf] at hhalf
  constructor <;> nlinarith [hhalf.1, hhalf.2]

/-- The sharp real parameter range for forward invariance of the unit
interval. -/
@[simp] theorem logisticMap_mapsTo_unitInterval_iff (r : ℝ) :
    MapsTo (logisticMap r) (Icc 0 1) (Icc 0 1) ↔ r ∈ Icc 0 4 :=
  ⟨logisticMap_parameter_mem_unitInterval_of_mapsTo,
    logisticMap_mapsTo_unitInterval⟩

/-- At parameter two, the midpoint is a fixed point. -/
@[simp] theorem logisticMap_two_oneHalf :
    logisticMap 2 ((1 : ℝ) / 2) = (1 : ℝ) / 2 := by
  norm_num [logisticMap]

/-- At parameter four, the midpoint maps to the endpoint one. -/
@[simp] theorem logisticMap_four_oneHalf :
    logisticMap 4 ((1 : ℝ) / 2) = 1 := by
  norm_num [logisticMap]

/-- The derivative of the logistic map at an arbitrary real point. -/
theorem hasDerivAt_logisticMap (r x : ℝ) :
    HasDerivAt (logisticMap r) (r * (1 - 2 * x)) x := by
  have hCore : HasDerivAt (fun y : ℝ => y * (1 - y)) (1 - 2 * x) x := by
    have hRaw := (hasDerivAt_id' x).mul
      ((hasDerivAt_const x (1 : ℝ)).sub (hasDerivAt_id' x))
    have hNormalized := hRaw.congr_deriv (show
      (1 : ℝ) * (1 - x) + x * (0 - 1) = 1 - 2 * x by ring)
    convert hNormalized using 1 <;> rfl
  change HasDerivAt (fun y : ℝ => r * (y * (1 - y))) (r * (1 - 2 * x)) x
  exact hCore.const_mul r

/-- The derivative operator returns the logistic-map multiplier formula. -/
@[simp] theorem deriv_logisticMap (r x : ℝ) :
    deriv (logisticMap r) x = r * (1 - 2 * x) :=
  (hasDerivAt_logisticMap r x).deriv

/-- The multiplier at the zero fixed point is `r`. -/
@[simp] theorem deriv_logisticMap_zero (r : ℝ) :
    deriv (logisticMap r) 0 = r := by
  rw [deriv_logisticMap]
  ring

/-- The multiplier along the nonzero fixed-point branch is `2 - r`. -/
theorem deriv_logisticMap_nonzeroFixedPoint {r : ℝ} (hr : r ≠ 0) :
    deriv (logisticMap r) (logisticNonzeroFixedPoint r) = 2 - r := by
  rw [deriv_logisticMap]
  change r * (1 - 2 * (1 - 1 / r)) = 2 - r
  field_simp [hr]
  ring

end NonlinearDynamics.Deterministic.Models

#print axioms NonlinearDynamics.Deterministic.Models.logisticMap_isFixedPt_iff
#print axioms NonlinearDynamics.Deterministic.Models.logisticNonzeroFixedPoint_eq_zero_iff
#print axioms NonlinearDynamics.Deterministic.Models.logisticMap_mapsTo_unitInterval_iff
#print axioms NonlinearDynamics.Deterministic.Models.hasDerivAt_logisticMap
#print axioms NonlinearDynamics.Deterministic.Models.deriv_logisticMap_nonzeroFixedPoint
