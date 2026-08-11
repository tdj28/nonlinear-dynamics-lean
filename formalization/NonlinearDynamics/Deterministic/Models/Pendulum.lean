import Mathlib.Analysis.ODE.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv

/-!
# The normalized undamped pendulum

This module studies the autonomous first-order system

`θ' = ω`, `ω' = -κ * sin θ`

on the unwrapped phase plane `ℝ × ℝ`.  The parameter `κ` is left explicit;
the usual physical normalization has `κ > 0`.  Working on the covering space
rather than quotienting angles modulo `2π` keeps the state type elementary,
while separate theorems record the field and energy periodicity.

The mechanical energy is normalized as

`E(θ, ω) = ω^2 / 2 + κ * (1 - cos θ)`.

The main differential statement is local and assumption-explicit: whenever
component curves satisfy the pendulum equations at a time, the derivative of
their energy is zero at that time.  Constant curves through the downward and
upright equilibria are also exhibited as global integral curves.

This first pendulum slice does not construct a global `Flow ℝ (ℝ × ℝ)`, prove
that every initial state has a global solution, construct nonconstant periodic
orbits, classify librations and rotations, or establish stability or
instability.  Those are separate dynamical claims requiring more than the
pointwise identities formalized here.
-/

namespace NonlinearDynamics.Deterministic.Models

noncomputable section

/-- The normalized undamped-pendulum vector field on the unwrapped phase
plane.  A state is `(angle, angularVelocity)`. -/
def pendulumVectorField (κ : ℝ) (state : ℝ × ℝ) : ℝ × ℝ :=
  (state.2, -κ * Real.sin state.1)

/-- The pendulum vector field written as a time-independent field in
Mathlib's ODE interface. -/
def pendulumODEField (κ : ℝ) : ℝ → (ℝ × ℝ) → (ℝ × ℝ) :=
  fun _ state ↦ pendulumVectorField κ state

@[simp] theorem pendulumODEField_apply (κ t : ℝ) (state : ℝ × ℝ) :
    pendulumODEField κ t state = pendulumVectorField κ state :=
  rfl

/-- The pendulum vector field is continuous for every real parameter. -/
theorem continuous_pendulumVectorField (κ : ℝ) :
    Continuous (pendulumVectorField κ) := by
  unfold pendulumVectorField
  fun_prop

/-- The downward state is an equilibrium for every parameter. -/
@[simp] theorem pendulumVectorField_down (κ : ℝ) :
    pendulumVectorField κ (0, 0) = 0 := by
  simp [pendulumVectorField]

/-- The upright state is an equilibrium for every parameter. -/
@[simp] theorem pendulumVectorField_up (κ : ℝ) :
    pendulumVectorField κ (Real.pi, 0) = 0 := by
  simp [pendulumVectorField]

/-- For a nonzero parameter, the equilibria on the unwrapped phase plane are
exactly the zero-velocity states whose angles are integer multiples of π. -/
theorem pendulumVectorField_eq_zero_iff_of_ne {κ : ℝ} (hκ : κ ≠ 0)
    (state : ℝ × ℝ) :
    pendulumVectorField κ state = 0 ↔
      state.2 = 0 ∧ ∃ n : ℤ, (n : ℝ) * Real.pi = state.1 := by
  rcases state with ⟨θ, ω⟩
  simp [pendulumVectorField, hκ, Real.sin_eq_zero_iff]

/-- Translating the unwrapped angle by an integer number of full turns does
not change the vector field. -/
theorem pendulumVectorField_add_int_mul_two_pi (κ θ ω : ℝ) (n : ℤ) :
    pendulumVectorField κ (θ + n * (2 * Real.pi), ω) =
      pendulumVectorField κ (θ, ω) := by
  simp [pendulumVectorField, Real.sin_add_int_mul_two_pi]

/-- At the checkable state `(π / 2, 0)` with `κ = 1`, the angular velocity is
instantaneously zero and the angular acceleration is `-1`. -/
theorem pendulumVectorField_one_quarter_turn :
    pendulumVectorField 1 (Real.pi / 2, 0) = (0, -1) := by
  simp [pendulumVectorField, Real.sin_pi_div_two]

/-- The normalized mechanical energy: kinetic plus gravitational potential
energy, with zero potential at the downward equilibrium. -/
def pendulumEnergy (κ : ℝ) (state : ℝ × ℝ) : ℝ :=
  state.2 ^ 2 / 2 + κ * (1 - Real.cos state.1)

/-- The downward equilibrium has zero normalized energy. -/
@[simp] theorem pendulumEnergy_down (κ : ℝ) :
    pendulumEnergy κ (0, 0) = 0 := by
  simp [pendulumEnergy]

/-- The upright equilibrium has normalized energy `2κ`. -/
@[simp] theorem pendulumEnergy_up (κ : ℝ) :
    pendulumEnergy κ (Real.pi, 0) = 2 * κ := by
  simp [pendulumEnergy]
  ring

/-- The same checkable quarter-turn state has energy one when `κ = 1`. -/
theorem pendulumEnergy_one_quarter_turn :
    pendulumEnergy 1 (Real.pi / 2, 0) = 1 := by
  simp [pendulumEnergy, Real.cos_pi_div_two]

/-- For a nonnegative parameter, the normalized energy is nonnegative. -/
theorem pendulumEnergy_nonneg {κ : ℝ} (hκ : 0 ≤ κ) (state : ℝ × ℝ) :
    0 ≤ pendulumEnergy κ state := by
  exact add_nonneg
    (div_nonneg (sq_nonneg state.2) (by norm_num))
    (mul_nonneg hκ (sub_nonneg.mpr (Real.cos_le_one state.1)))

/-- Translating the unwrapped angle by an integer number of full turns does
not change the energy. -/
theorem pendulumEnergy_add_int_mul_two_pi (κ θ ω : ℝ) (n : ℤ) :
    pendulumEnergy κ (θ + n * (2 * Real.pi), ω) =
      pendulumEnergy κ (θ, ω) := by
  simp [pendulumEnergy, Real.cos_add_int_mul_two_pi]

section EnergyDerivative

attribute [local instance 1200] NormedAddCommGroup.toAddCommGroup
  NormedSpace.toModule

/-- If the component derivatives obey the pendulum equations at time `t`,
then the derivative of the mechanical energy is zero at `t`.  This is a
pointwise conservation identity, not an existence theorem for solutions. -/
theorem hasDerivAt_pendulumEnergy_along (κ : ℝ) {θ ω : ℝ → ℝ} {t : ℝ}
    (hθ : HasDerivAt θ (ω t) t)
    (hω : HasDerivAt ω (-κ * Real.sin (θ t)) t) :
    HasDerivAt (fun s ↦ pendulumEnergy κ (θ s, ω s)) 0 t := by
  unfold pendulumEnergy
  have hkinetic := (hω.pow 2).div_const 2
  have hpotential :=
    ((hasDerivAt_const t (1 : ℝ)).sub hθ.cos).const_mul κ
  have hcancel :
      (2 : ℝ) * ω t ^ (2 - 1) * (-κ * Real.sin (θ t)) / 2 +
          κ * (0 - -Real.sin (θ t) * ω t) = 0 := by
    norm_num
    ring
  exact ((hkinetic.add hpotential).congr_deriv hcancel).congr_of_eventuallyEq
    (Filter.Eventually.of_forall fun _ ↦ rfl)

end EnergyDerivative

/-- The constant downward-equilibrium curve is a global integral curve. -/
theorem pendulum_down_isIntegralCurve (κ : ℝ) :
    IsIntegralCurve (fun _ : ℝ ↦ (0, 0)) (pendulumODEField κ) := by
  intro t
  rw [show pendulumODEField κ t (0, 0) = (0 : ℝ × ℝ) by simp]
  exact hasDerivAt_const t ((0, 0) : ℝ × ℝ)

/-- The constant upright-equilibrium curve is a global integral curve. -/
theorem pendulum_up_isIntegralCurve (κ : ℝ) :
    IsIntegralCurve (fun _ : ℝ ↦ (Real.pi, 0)) (pendulumODEField κ) := by
  intro t
  rw [show pendulumODEField κ t (Real.pi, 0) = (0 : ℝ × ℝ) by simp]
  exact hasDerivAt_const t ((Real.pi, 0) : ℝ × ℝ)

end

end NonlinearDynamics.Deterministic.Models

#print axioms NonlinearDynamics.Deterministic.Models.pendulumVectorField_eq_zero_iff_of_ne
#print axioms NonlinearDynamics.Deterministic.Models.pendulumEnergy_nonneg
#print axioms NonlinearDynamics.Deterministic.Models.hasDerivAt_pendulumEnergy_along
#print axioms NonlinearDynamics.Deterministic.Models.pendulum_down_isIntegralCurve
