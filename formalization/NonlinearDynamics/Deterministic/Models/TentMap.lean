import Mathlib.Analysis.Calculus.Deriv.Abs
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul
import NonlinearDynamics.Deterministic.Discrete.Bifurcation

/-!
# The real tent-map family

This module studies the piecewise-linear family
`tentMap s x = s * min x (1 - x)`.  Equivalently,

`tentMap s x = s * (1 / 2 - |x - 1 / 2|)`.

It records the two affine branches, symmetry about the turning point, the
sharp parameter range in which the closed unit interval maps into itself,
the fixed-point structure for slopes above one, and the exact branch
derivatives.  The slope-one member is kept as an explicit boundary: every
point of `[0, 1 / 2]` is fixed there.

The standard full tent map is the parameter-two member.  The module does not
promote its elementary orbit and slope calculations to transitivity, dense
periodic points, sensitivity, entropy, mixing, or conjugacy statements.
-/

open Filter Function Set

namespace NonlinearDynamics.Deterministic.Models

open NonlinearDynamics.Deterministic.Discrete

/-- The real tent map with slope parameter `s`. -/
def tentMap (s x : ℝ) : ℝ :=
  s * min x (1 - x)

/-- The tent maps regarded as a parameterized family. -/
abbrev tentFamily : ParameterizedFamily ℝ ℝ :=
  tentMap

/-- Zero is fixed for every parameter. -/
@[simp] theorem tentMap_zero (s : ℝ) :
    tentMap s 0 = 0 := by
  simp [tentMap]

/-- One maps to zero for every parameter. -/
@[simp] theorem tentMap_one (s : ℝ) :
    tentMap s 1 = 0 := by
  simp [tentMap]

/-- On the left of the turning point the tent map is multiplication by `s`. -/
theorem tentMap_eq_left_of_le_oneHalf {s x : ℝ} (hx : x ≤ (1 : ℝ) / 2) :
    tentMap s x = s * x := by
  rw [tentMap, min_eq_left]
  linarith

/-- On the right of the turning point the tent map has slope `-s`. -/
theorem tentMap_eq_right_of_oneHalf_le {s x : ℝ} (hx : (1 : ℝ) / 2 ≤ x) :
    tentMap s x = s * (1 - x) := by
  rw [tentMap, min_eq_right]
  linarith

/-- The two branches meet at height `s / 2`. -/
@[simp] theorem tentMap_oneHalf (s : ℝ) :
    tentMap s ((1 : ℝ) / 2) = s / 2 := by
  rw [tentMap_eq_left_of_le_oneHalf (le_refl ((1 : ℝ) / 2))]
  ring

/-- The `min` core is the usual centered absolute-value tent. -/
theorem tentCore_eq_oneHalf_sub_abs (x : ℝ) :
    min x (1 - x) = (1 : ℝ) / 2 - |x - (1 : ℝ) / 2| := by
  by_cases hx : x ≤ (1 : ℝ) / 2
  · rw [min_eq_left (by linarith), abs_of_nonpos (by linarith)]
    ring
  · have hx' : (1 : ℝ) / 2 ≤ x := (lt_of_not_ge hx).le
    rw [min_eq_right (by linarith), abs_of_nonneg (by linarith)]
    ring

/-- Absolute-value presentation of the tent family. -/
theorem tentMap_eq_oneHalf_sub_abs (s x : ℝ) :
    tentMap s x = s * ((1 : ℝ) / 2 - |x - (1 : ℝ) / 2|) := by
  rw [tentMap, tentCore_eq_oneHalf_sub_abs]

/-- Each member of the tent family is continuous, including at its turning
point. -/
theorem continuous_tentMap (s : ℝ) :
    Continuous (tentMap s) := by
  unfold tentMap
  fun_prop

/-- Reflection about the midpoint leaves every tent-map value unchanged. -/
@[simp] theorem tentMap_one_sub (s x : ℝ) :
    tentMap s (1 - x) = tentMap s x := by
  simp only [tentMap]
  congr 1
  rw [min_comm]
  ring

/-- The tent core is nonnegative on the closed unit interval. -/
theorem tentCore_nonneg {x : ℝ} (hx : x ∈ Icc 0 1) :
    0 ≤ min x (1 - x) :=
  min_nonneg hx.1 (sub_nonneg.mpr hx.2)

/-- The tent core is globally bounded above by `1 / 2`. -/
theorem tentCore_le_oneHalf (x : ℝ) :
    min x (1 - x) ≤ (1 : ℝ) / 2 := by
  rcases le_total x ((1 : ℝ) / 2) with hx | hx
  · exact (min_le_left x (1 - x)).trans hx
  · exact (min_le_right x (1 - x)).trans (by linarith)

/-- Parameters in `[0, 2]` make the closed unit interval forward invariant. -/
theorem tentMap_mapsTo_unitInterval {s : ℝ} (hs : s ∈ Icc 0 2) :
    MapsTo (tentMap s) (Icc 0 1) (Icc 0 1) := by
  intro x hx
  constructor
  · simpa only [tentMap] using mul_nonneg hs.1 (tentCore_nonneg hx)
  · rw [tentMap]
    calc
      s * min x (1 - x) ≤ s * ((1 : ℝ) / 2) :=
        mul_le_mul_of_nonneg_left (tentCore_le_oneHalf x) hs.1
      _ ≤ 1 := by nlinarith [hs.2]

/-- Forward invariance of `[0, 1]` forces the parameter into `[0, 2]`. -/
theorem tentMap_parameter_mem_unitInterval_of_mapsTo {s : ℝ}
    (hmap : MapsTo (tentMap s) (Icc 0 1) (Icc 0 1)) :
    s ∈ Icc 0 2 := by
  have hhalf : tentMap s ((1 : ℝ) / 2) ∈ Icc 0 1 :=
    hmap (by constructor <;> norm_num)
  rw [tentMap_oneHalf] at hhalf
  constructor <;> nlinarith [hhalf.1, hhalf.2]

/-- The sharp real parameter range for unit-interval forward invariance. -/
@[simp] theorem tentMap_mapsTo_unitInterval_iff (s : ℝ) :
    MapsTo (tentMap s) (Icc 0 1) (Icc 0 1) ↔ s ∈ Icc 0 2 :=
  ⟨tentMap_parameter_mem_unitInterval_of_mapsTo,
    tentMap_mapsTo_unitInterval⟩

/-- The zero branch is a fixed-point branch on the whole parameter line. -/
theorem tentFamily_zero_isFixedPointBranchOn :
    IsFixedPointBranchOn tentFamily (fun _ ↦ 0) univ := by
  intro s _
  simp [IsFixedPt]

/-- The nonzero fixed point selected when the slope exceeds one. -/
noncomputable def tentNonzeroFixedPoint (s : ℝ) : ℝ :=
  s / (s + 1)

/-- For `s > 1`, the nonzero fixed point lies strictly to the right of the
turning point. -/
theorem oneHalf_lt_tentNonzeroFixedPoint {s : ℝ} (hs : 1 < s) :
    (1 : ℝ) / 2 < tentNonzeroFixedPoint s := by
  have hden : 0 < s + 1 := by linarith
  rw [tentNonzeroFixedPoint, lt_div_iff₀ hden]
  nlinarith

/-- For `s > 1`, the nonzero fixed point belongs to the closed unit interval. -/
theorem tentNonzeroFixedPoint_mem_unitInterval {s : ℝ} (hs : 1 < s) :
    tentNonzeroFixedPoint s ∈ Icc 0 1 := by
  have hden : 0 < s + 1 := by linarith
  constructor
  · exact div_nonneg (by linarith) hden.le
  · exact (div_le_one hden).2 (by linarith)

/-- The nonzero branch consists of fixed points on the parameter interval
`(1, ∞)`. -/
theorem tentNonzeroFixedPoint_isFixedPt {s : ℝ} (hs : 1 < s) :
    IsFixedPt (tentMap s) (tentNonzeroFixedPoint s) := by
  rw [IsFixedPt, tentMap_eq_right_of_oneHalf_le
    (oneHalf_lt_tentNonzeroFixedPoint hs).le]
  change s * (1 - s / (s + 1)) = s / (s + 1)
  have hden : s + 1 ≠ 0 := ne_of_gt (by linarith)
  field_simp [hden] <;> ring

/-- The nonzero formula is a fixed-point branch on slopes above one. -/
theorem tentFamily_nonzero_isFixedPointBranchOn :
    IsFixedPointBranchOn tentFamily tentNonzeroFixedPoint (Ioi 1) := by
  intro s hs
  exact tentNonzeroFixedPoint_isFixedPt hs

/-- Above slope one, the two displayed points are exactly the fixed points in
the closed unit interval. -/
theorem tentMap_isFixedPt_iff_of_one_lt {s x : ℝ} (hs : 1 < s)
    (hx : x ∈ Icc 0 1) :
    IsFixedPt (tentMap s) x ↔ x = 0 ∨ x = tentNonzeroFixedPoint s := by
  have hden : s + 1 ≠ 0 := ne_of_gt (by linarith)
  constructor
  · intro hfix
    by_cases hleft : x ≤ (1 : ℝ) / 2
    · left
      rw [IsFixedPt, tentMap_eq_left_of_le_oneHalf hleft] at hfix
      nlinarith [hx.1]
    · right
      rw [IsFixedPt,
        tentMap_eq_right_of_oneHalf_le (lt_of_not_ge hleft).le] at hfix
      rw [tentNonzeroFixedPoint, eq_div_iff hden]
      nlinarith [hfix]
  · rintro (rfl | rfl)
    · simp [IsFixedPt]
    · exact tentNonzeroFixedPoint_isFixedPt hs

/-- At the boundary slope one, the fixed points in `[0, 1]` are exactly the
whole left half `[0, 1 / 2]`. -/
theorem tentMap_one_isFixedPt_iff {x : ℝ} (hx : x ∈ Icc 0 1) :
    IsFixedPt (tentMap 1) x ↔ x ∈ Icc 0 ((1 : ℝ) / 2) := by
  constructor
  · intro hfix
    refine ⟨hx.1, ?_⟩
    by_contra hleft
    have hright : (1 : ℝ) / 2 ≤ x := (lt_of_not_ge hleft).le
    rw [IsFixedPt, tentMap_eq_right_of_oneHalf_le hright] at hfix
    nlinarith
  · intro hleft
    rw [IsFixedPt, tentMap_eq_left_of_le_oneHalf hleft.2]
    ring

/-- The standard parameter-two tent sends the midpoint to one. -/
@[simp] theorem tentMap_two_oneHalf :
    tentMap 2 ((1 : ℝ) / 2) = 1 := by
  norm_num [tentMap]

/-- Two standard-tent steps send the midpoint to zero. -/
@[simp] theorem tentMap_two_iterate_two_oneHalf :
    (tentMap 2)^[2] ((1 : ℝ) / 2) = 0 := by
  norm_num [Function.iterate_succ_apply, tentMap]

/-- The standard tent's unit-interval fixed points are zero and two thirds. -/
theorem tentMap_two_isFixedPt_iff {x : ℝ} (hx : x ∈ Icc 0 1) :
    IsFixedPt (tentMap 2) x ↔ x = 0 ∨ x = (2 : ℝ) / 3 := by
  simpa [tentNonzeroFixedPoint] using
    (tentMap_isFixedPt_iff_of_one_lt (s := (2 : ℝ)) (x := x) (by norm_num) hx)

/-- The derivative on the open left branch is `s`. -/
theorem hasDerivAt_tentMap_of_lt_oneHalf {s x : ℝ}
    (hx : x < (1 : ℝ) / 2) :
    HasDerivAt (tentMap s) s x := by
  refine (hasDerivAt_const_mul (x := x) s).congr_of_eventuallyEq ?_
  filter_upwards [Iio_mem_nhds hx] with y hy
  exact tentMap_eq_left_of_le_oneHalf hy.le

/-- The derivative on the open right branch is `-s`. -/
theorem hasDerivAt_tentMap_of_oneHalf_lt {s x : ℝ}
    (hx : (1 : ℝ) / 2 < x) :
    HasDerivAt (tentMap s) (-s) x := by
  have hlinear : HasDerivAt (fun y : ℝ ↦ s * (1 - y)) (-s) x := by
    have hraw := (hasDerivAt_const x (1 : ℝ)).sub (hasDerivAt_id' x)
    convert hraw.const_mul s using 1 <;> ring
  refine hlinear.congr_of_eventuallyEq ?_
  filter_upwards [Ioi_mem_nhds hx] with y hy
  exact tentMap_eq_right_of_oneHalf_le hy.le

/-- Away from the zero parameter, the tent map is not differentiable at its
turning point. -/
theorem not_differentiableAt_tentMap_oneHalf {s : ℝ} (hs : s ≠ 0) :
    ¬ DifferentiableAt ℝ (tentMap s) ((1 : ℝ) / 2) := by
  intro htent
  have haux : DifferentiableAt ℝ
      (fun y : ℝ ↦ (1 : ℝ) / 2 - (1 / s) * tentMap s y)
      ((1 : ℝ) / 2) :=
    (differentiableAt_const ((1 : ℝ) / 2)).sub (htent.const_mul (1 / s))
  have habsShift : DifferentiableAt ℝ
      (fun y : ℝ ↦ |y - (1 : ℝ) / 2|) ((1 : ℝ) / 2) := by
    refine haux.congr_of_eventuallyEq (Filter.Eventually.of_forall fun y ↦ ?_)
    rw [tentMap_eq_oneHalf_sub_abs]
    field_simp [hs] <;> ring
  have htranslate : DifferentiableAt ℝ
      (fun z : ℝ ↦ z + (1 : ℝ) / 2) 0 := by
    fun_prop
  have habsZero := habsShift.comp 0 htranslate
  exact not_differentiableAt_abs_zero (by simpa using habsZero)

/-- The derivative operator returns the left branch slope. -/
theorem deriv_tentMap_of_lt_oneHalf {s x : ℝ} (hx : x < (1 : ℝ) / 2) :
    deriv (tentMap s) x = s :=
  (hasDerivAt_tentMap_of_lt_oneHalf hx).deriv

/-- The derivative operator returns the right branch slope. -/
theorem deriv_tentMap_of_oneHalf_lt {s x : ℝ} (hx : (1 : ℝ) / 2 < x) :
    deriv (tentMap s) x = -s :=
  (hasDerivAt_tentMap_of_oneHalf_lt hx).deriv

/-- The multiplier at the zero fixed point is `s`. -/
@[simp] theorem deriv_tentMap_zero (s : ℝ) :
    deriv (tentMap s) 0 = s :=
  deriv_tentMap_of_lt_oneHalf (by norm_num)

/-- Above slope one, the multiplier at the nonzero fixed point is `-s`. -/
theorem deriv_tentMap_nonzeroFixedPoint {s : ℝ} (hs : 1 < s) :
    deriv (tentMap s) (tentNonzeroFixedPoint s) = -s :=
  deriv_tentMap_of_oneHalf_lt (oneHalf_lt_tentNonzeroFixedPoint hs)

end NonlinearDynamics.Deterministic.Models

#print axioms NonlinearDynamics.Deterministic.Models.tentMap_mapsTo_unitInterval_iff
#print axioms NonlinearDynamics.Deterministic.Models.tentMap_isFixedPt_iff_of_one_lt
#print axioms NonlinearDynamics.Deterministic.Models.tentMap_one_isFixedPt_iff
#print axioms NonlinearDynamics.Deterministic.Models.not_differentiableAt_tentMap_oneHalf
#print axioms NonlinearDynamics.Deterministic.Models.deriv_tentMap_nonzeroFixedPoint
