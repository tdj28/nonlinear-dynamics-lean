import Mathlib.Analysis.ODE.Basic
import Mathlib.Analysis.SpecialFunctions.Sigmoid

/-!
# The normalized real logistic ordinary differential equation

This module studies the autonomous scalar equation

`x' = r * x * (1 - x)`.

The carrying capacity has been normalized to one, while the real parameter
`r` remains explicit.  The vector field vanishes at zero and one, and for a
nonzero parameter those are its only equilibria.  For positive `r`, its sign
is positive between the equilibria and negative outside the closed unit
interval.

Interior solution curves are parameterized without division by an initial
state:

`logisticInteriorCurve r c t = Real.sigmoid (r * t + c)`.

Mathlib's sigmoid derivative proves that each such curve is a global integral
curve of the logistic field.  Its range remains in `(0, 1)`, every interior
initial state has such a phase `c`, and for positive `r` the curve tends to
zero at negative infinity and one at positive infinity.  The endpoint
equilibria are represented by separate constant integral curves.

This first model slice does not construct a `Flow ℝ ℝ` or a flow on the closed
unit interval.  It therefore does not promote curvewise containment or
convergence to the project's flow-level invariance, Lyapunov-stability, or
attraction predicates.  In particular, the polynomial vector field is not
asserted to have global solutions through every real initial state.
-/

open Filter Set

namespace NonlinearDynamics.Deterministic.Models

/-- The normalized real logistic vector field with growth-rate parameter
`r` and carrying capacity one. -/
def logisticODEVectorField (r x : ℝ) : ℝ :=
  r * (x * (1 - x))

/-- The logistic vector field written as a time-independent field in
Mathlib's scalar ODE interface. -/
def logisticODEField (r : ℝ) : ℝ → ℝ → ℝ :=
  fun _ x ↦ logisticODEVectorField r x

@[simp] theorem logisticODEField_apply (r t x : ℝ) :
    logisticODEField r t x = logisticODEVectorField r x :=
  rfl

/-- Zero is an equilibrium for every growth rate. -/
@[simp] theorem logisticODEVectorField_zero (r : ℝ) :
    logisticODEVectorField r 0 = 0 := by
  simp [logisticODEVectorField]

/-- One is an equilibrium for every growth rate. -/
@[simp] theorem logisticODEVectorField_one (r : ℝ) :
    logisticODEVectorField r 1 = 0 := by
  simp [logisticODEVectorField]

/-- The logistic vector field is continuous for each fixed growth rate. -/
theorem continuous_logisticODEVectorField (r : ℝ) :
    Continuous (logisticODEVectorField r) := by
  unfold logisticODEVectorField
  fun_prop

/-- The complete zero set, including the degenerate parameter `r = 0`. -/
@[simp] theorem logisticODEVectorField_eq_zero_iff (r x : ℝ) :
    logisticODEVectorField r x = 0 ↔ r = 0 ∨ x = 0 ∨ x = 1 := by
  simp [logisticODEVectorField, mul_eq_zero]

/-- At a nonzero growth rate, zero and one are the only equilibria. -/
theorem logisticODEVectorField_eq_zero_iff_of_ne {r : ℝ} (hr : r ≠ 0)
    (x : ℝ) :
    logisticODEVectorField r x = 0 ↔ x = 0 ∨ x = 1 := by
  simp [logisticODEVectorField_eq_zero_iff, hr]

/-- For a positive growth rate, the field points upward in the open unit
interval. -/
theorem logisticODEVectorField_pos {r x : ℝ} (hr : 0 < r)
    (hx : x ∈ Ioo 0 1) :
    0 < logisticODEVectorField r x := by
  exact mul_pos hr (mul_pos hx.1 (sub_pos.mpr hx.2))

/-- For a positive growth rate, the field is negative below zero. -/
theorem logisticODEVectorField_neg_of_neg {r x : ℝ} (hr : 0 < r)
    (hx : x < 0) :
    logisticODEVectorField r x < 0 := by
  exact mul_neg_of_pos_of_neg hr
    (mul_neg_of_neg_of_pos hx (sub_pos.mpr (hx.trans zero_lt_one)))

/-- For a positive growth rate, the field is negative above one. -/
theorem logisticODEVectorField_neg_of_one_lt {r x : ℝ} (hr : 0 < r)
    (hx : 1 < x) :
    logisticODEVectorField r x < 0 := by
  exact mul_neg_of_pos_of_neg hr
    (mul_neg_of_pos_of_neg (zero_lt_one.trans hx) (sub_neg.mpr hx))

/-- The denominator-safe family of global interior logistic curves.  The
phase `c` chooses the initial state, and `r` sets the time scale and
orientation. -/
noncomputable def logisticInteriorCurve (r c t : ℝ) : ℝ :=
  Real.sigmoid (r * t + c)

/-- The sigmoid representation is the familiar explicit logistic formula. -/
theorem logisticInteriorCurve_eq_inv (r c t : ℝ) :
    logisticInteriorCurve r c t =
      (1 + Real.exp (-(r * t + c)))⁻¹ :=
  rfl

/-- At time zero, the phase is passed directly to the sigmoid. -/
@[simp] theorem logisticInteriorCurve_zero (r c : ℝ) :
    logisticInteriorCurve r c 0 = Real.sigmoid c := by
  simp [logisticInteriorCurve]

/-- Every phase-parameterized curve remains strictly between zero and one for
every real time. -/
theorem logisticInteriorCurve_mem_Ioo (r c t : ℝ) :
    logisticInteriorCurve r c t ∈ Ioo 0 1 :=
  ⟨Real.sigmoid_pos _, Real.sigmoid_lt_one _⟩

/-- The derivative of an interior curve is the logistic vector field
evaluated at that curve. -/
theorem hasDerivAt_logisticInteriorCurve (r c t : ℝ) :
    HasDerivAt (logisticInteriorCurve r c)
      (logisticODEVectorField r (logisticInteriorCurve r c t)) t := by
  have hAffine : HasDerivAt (fun s : ℝ ↦ r * s + c) r t :=
    ((hasDerivAt_id' t).const_mul r).add_const c
  have hSigmoid := (Real.hasDerivAt_sigmoid (r * t + c)).comp t hAffine
  convert hSigmoid using 1 <;>
    simp only [logisticInteriorCurve, logisticODEVectorField] <;> ring

/-- Each phase-parameterized curve is a global integral curve of the
time-independent logistic field. -/
theorem logisticInteriorCurve_isIntegralCurve (r c : ℝ) :
    IsIntegralCurve (logisticInteriorCurve r c) (logisticODEField r) :=
  hasDerivAt_logisticInteriorCurve r c

/-- Every state in the open unit interval occurs at time zero on one of the
global interior curves. -/
theorem exists_logisticInteriorCurve_through {r x : ℝ} (hx : x ∈ Ioo 0 1) :
    ∃ c : ℝ, logisticInteriorCurve r c 0 = x ∧
      IsIntegralCurve (logisticInteriorCurve r c) (logisticODEField r) := by
  have hxRange : x ∈ Set.range Real.sigmoid := by
    rw [Real.range_sigmoid]
    exact hx
  rcases hxRange with ⟨c, hc⟩
  exact ⟨c, by simpa using hc, logisticInteriorCurve_isIntegralCurve r c⟩

/-- The zero equilibrium gives a constant global integral curve. -/
theorem logisticODE_zero_isIntegralCurve (r : ℝ) :
    IsIntegralCurve (fun _ : ℝ ↦ 0) (logisticODEField r) := by
  intro t
  simpa using (hasDerivAt_const t (0 : ℝ))

/-- The unit equilibrium gives a constant global integral curve. -/
theorem logisticODE_one_isIntegralCurve (r : ℝ) :
    IsIntegralCurve (fun _ : ℝ ↦ 1) (logisticODEField r) := by
  intro t
  simpa using (hasDerivAt_const t (1 : ℝ))

/-- Positive-rate interior solutions converge to the unit equilibrium as
time tends to positive infinity. -/
theorem tendsto_logisticInteriorCurve_atTop {r : ℝ} (hr : 0 < r) (c : ℝ) :
    Tendsto (logisticInteriorCurve r c) atTop (nhds 1) := by
  apply Real.tendsto_sigmoid_atTop.comp
  exact (tendsto_id.const_mul_atTop hr).atTop_add tendsto_const_nhds

/-- Positive-rate interior solutions converge to the zero equilibrium as
time tends to negative infinity. -/
theorem tendsto_logisticInteriorCurve_atBot {r : ℝ} (hr : 0 < r) (c : ℝ) :
    Tendsto (logisticInteriorCurve r c) atBot (nhds 0) := by
  apply Real.tendsto_sigmoid_atBot.comp
  exact (tendsto_id.const_mul_atBot hr).atBot_add tendsto_const_nhds

/-- Translating time updates only the phase parameter.  This is the algebraic
restart law for the explicit curves, not a bundled state-space flow. -/
theorem logisticInteriorCurve_add (r c t s : ℝ) :
    logisticInteriorCurve r c (t + s) =
      logisticInteriorCurve r (r * s + c) t := by
  unfold logisticInteriorCurve
  congr 1
  ring

end NonlinearDynamics.Deterministic.Models

#print axioms NonlinearDynamics.Deterministic.Models.logisticODEVectorField_eq_zero_iff
#print axioms NonlinearDynamics.Deterministic.Models.logisticODEVectorField_eq_zero_iff_of_ne
#print axioms NonlinearDynamics.Deterministic.Models.hasDerivAt_logisticInteriorCurve
#print axioms NonlinearDynamics.Deterministic.Models.exists_logisticInteriorCurve_through
#print axioms NonlinearDynamics.Deterministic.Models.tendsto_logisticInteriorCurve_atTop
#print axioms NonlinearDynamics.Deterministic.Models.logisticInteriorCurve_add
