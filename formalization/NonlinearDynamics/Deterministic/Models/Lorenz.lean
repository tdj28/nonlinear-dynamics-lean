import Mathlib.Analysis.ODE.Basic
import Mathlib.Analysis.Real.Sqrt

/-!
# The classical three-parameter Lorenz vector field

This module studies the autonomous system

`x' = sigma * (y - x)`,
`y' = x * (rho - z) - y`,
`z' = x * y - beta * z`

on `ℝ × ℝ × ℝ`.  Lean parses this carrier as the right-associated product
`ℝ × (ℝ × ℝ)`, so the coordinates of `state` are `state.1`, `state.2.1`,
and `state.2.2`.  The parameter order `(sigma, rho, beta)` follows Lorenz's
1963 equations, with Greek names used to avoid confusing the parameter
`beta` with Lean binders.

The slice records continuity, two coordinate-axis formulas, the simultaneous
sign-flip symmetry in the first two coordinates, the origin, and the complete
three-equilibrium classification under `sigma ≠ 0`, `0 < beta`, and
`1 < rho`.  It also exhibits the three constant equilibrium curves.

It does not prove existence through arbitrary initial states, uniqueness,
completeness, boundedness, a global flow, an absorbing set, an attractor,
sensitive dependence, transitivity, periodic-orbit structure, or chaos.
-/

namespace NonlinearDynamics.Deterministic.Models

noncomputable section

/-- The classical Lorenz vector field.  The right-associated state coordinates
are `(x, y, z) = (state.1, state.2.1, state.2.2)`. -/
def lorenzVectorField (sigma rho beta : ℝ) (state : ℝ × ℝ × ℝ) :
    ℝ × ℝ × ℝ :=
  (sigma * (state.2.1 - state.1),
    state.1 * (rho - state.2.2) - state.2.1,
    state.1 * state.2.1 - beta * state.2.2)

/-- The Lorenz vector field written as a time-independent field in Mathlib's
ODE interface. -/
def lorenzODEField (sigma rho beta : ℝ) :
    ℝ → (ℝ × ℝ × ℝ) → (ℝ × ℝ × ℝ) :=
  fun _ state ↦ lorenzVectorField sigma rho beta state

@[simp] theorem lorenzODEField_apply (sigma rho beta t : ℝ)
    (state : ℝ × ℝ × ℝ) :
    lorenzODEField sigma rho beta t state =
      lorenzVectorField sigma rho beta state :=
  rfl

/-- The Lorenz field is continuous for every choice of real parameters. -/
theorem continuous_lorenzVectorField (sigma rho beta : ℝ) :
    Continuous (lorenzVectorField sigma rho beta) := by
  unfold lorenzVectorField
  fun_prop

/-- Simultaneously negate the first two coordinates and retain the third. -/
def lorenzSymmetry (state : ℝ × ℝ × ℝ) : ℝ × ℝ × ℝ :=
  (-state.1, -state.2.1, state.2.2)

/-- Applying the Lorenz sign-flip symmetry twice returns the original state. -/
@[simp] theorem lorenzSymmetry_involutive (state : ℝ × ℝ × ℝ) :
    lorenzSymmetry (lorenzSymmetry state) = state := by
  rcases state with ⟨x, y, z⟩
  simp [lorenzSymmetry]

/-- The Lorenz vector field is equivariant under the simultaneous sign flip
of its first two coordinates. -/
theorem lorenzVectorField_symmetry (sigma rho beta : ℝ)
    (state : ℝ × ℝ × ℝ) :
    lorenzVectorField sigma rho beta (lorenzSymmetry state) =
      lorenzSymmetry (lorenzVectorField sigma rho beta state) := by
  rcases state with ⟨x, y, z⟩
  change
    (sigma * (-y - -x), (-x) * (rho - z) - (-y), (-x) * (-y) - beta * z) =
      (-(sigma * (y - x)), -(x * (rho - z) - y), x * y - beta * z)
  apply Prod.ext
  · ring
  · apply Prod.ext <;> ring

/-- The origin is a field zero for every parameter choice. -/
@[simp] theorem lorenzVectorField_origin (sigma rho beta : ℝ) :
    lorenzVectorField sigma rho beta (0, 0, 0) = 0 := by
  simp [lorenzVectorField]

/-- On the `z`-axis, only the third component is nonzero. -/
@[simp] theorem lorenzVectorField_zAxis (sigma rho beta z : ℝ) :
    lorenzVectorField sigma rho beta (0, 0, z) = (0, 0, -beta * z) := by
  simp [lorenzVectorField]

/-- On the `x`-axis, the first two components are linear in `x`. -/
@[simp] theorem lorenzVectorField_xAxis (sigma rho beta x : ℝ) :
    lorenzVectorField sigma rho beta (x, 0, 0) =
      (-sigma * x, rho * x, 0) := by
  simp [lorenzVectorField]
  ring

/-- At the classical parameter values and the exact state `(1, 2, 3)`, the
field is `(10, 23, -6)`. -/
theorem lorenzVectorField_classical_benchmark :
    lorenzVectorField 10 28 (8 / 3) (1, 2, 3) = (10, 23, -6) := by
  norm_num [lorenzVectorField]

/-- The nonnegative coordinate magnitude used by the two nonzero Lorenz
equilibria. -/
def lorenzEquilibriumRadius (rho beta : ℝ) : ℝ :=
  Real.sqrt (beta * (rho - 1))

/-- The positive-sign nonzero equilibrium candidate. -/
def lorenzPositiveEquilibrium (rho beta : ℝ) : ℝ × ℝ × ℝ :=
  (lorenzEquilibriumRadius rho beta,
    lorenzEquilibriumRadius rho beta,
    rho - 1)

/-- The negative-sign nonzero equilibrium candidate. -/
def lorenzNegativeEquilibrium (rho beta : ℝ) : ℝ × ℝ × ℝ :=
  (-lorenzEquilibriumRadius rho beta,
    -lorenzEquilibriumRadius rho beta,
    rho - 1)

/-- The two named nonzero equilibrium candidates are exchanged by the Lorenz
sign-flip symmetry. -/
@[simp] theorem lorenzSymmetry_positiveEquilibrium (rho beta : ℝ) :
    lorenzSymmetry (lorenzPositiveEquilibrium rho beta) =
      lorenzNegativeEquilibrium rho beta := by
  rfl

/-- When the radicand is nonnegative, the positive-sign candidate is a field
zero. -/
@[simp] theorem lorenzVectorField_positiveEquilibrium
    {sigma rho beta : ℝ} (hRadicand : 0 ≤ beta * (rho - 1)) :
    lorenzVectorField sigma rho beta
      (lorenzPositiveEquilibrium rho beta) = 0 := by
  have hSquare : lorenzEquilibriumRadius rho beta ^ 2 =
      beta * (rho - 1) := by
    exact Real.sq_sqrt hRadicand
  simp only [lorenzVectorField, lorenzPositiveEquilibrium]
  apply Prod.ext
  · simp
  · apply Prod.ext
    · simp
    · simpa [pow_two] using sub_eq_zero.mpr hSquare

/-- When the radicand is nonnegative, the negative-sign candidate is a field
zero. -/
@[simp] theorem lorenzVectorField_negativeEquilibrium
    {sigma rho beta : ℝ} (hRadicand : 0 ≤ beta * (rho - 1)) :
    lorenzVectorField sigma rho beta
      (lorenzNegativeEquilibrium rho beta) = 0 := by
  rw [← lorenzSymmetry_positiveEquilibrium]
  rw [lorenzVectorField_symmetry]
  simp [lorenzVectorField_positiveEquilibrium hRadicand, lorenzSymmetry]

/-- Under the classical nondegeneracy and sign hypotheses, the origin and the
two symmetric nonzero states are exactly the field zeros. -/
theorem lorenzVectorField_eq_zero_iff_of_pos
    {sigma rho beta : ℝ} (hSigma : sigma ≠ 0)
    (hBeta : 0 < beta) (hRho : 1 < rho) (state : ℝ × ℝ × ℝ) :
    lorenzVectorField sigma rho beta state = 0 ↔
      state = (0, 0, 0) ∨
        state = lorenzPositiveEquilibrium rho beta ∨
        state = lorenzNegativeEquilibrium rho beta := by
  rcases state with ⟨x, y, z⟩
  have hRadicand : 0 ≤ beta * (rho - 1) :=
    mul_nonneg hBeta.le (sub_nonneg.mpr hRho.le)
  constructor
  · intro hField
    have hFirst : sigma * (y - x) = 0 := by
      simpa [lorenzVectorField] using congrArg Prod.fst hField
    have hy : y = x := by
      exact sub_eq_zero.mp (mul_eq_zero.mp hFirst |>.resolve_left hSigma)
    subst y
    have hSecond : x * (rho - z) - x = 0 := by
      simpa [lorenzVectorField] using congrArg (fun p ↦ p.2.1) hField
    have hThird : x * x - beta * z = 0 := by
      simpa [lorenzVectorField] using congrArg (fun p ↦ p.2.2) hField
    have hFactor : x * (rho - z - 1) = 0 := by
      nlinarith [hSecond]
    rcases mul_eq_zero.mp hFactor with hx | hz
    · have hzZero : z = 0 := by
        subst x
        simpa [hBeta.ne'] using hThird
      exact Or.inl (by simp [hx, hzZero])
    · have hzEquilibrium : z = rho - 1 := by
        linarith
      have hRadiusSquare : lorenzEquilibriumRadius rho beta ^ 2 =
          beta * (rho - 1) := by
        exact Real.sq_sqrt hRadicand
      have hxSquare : x ^ 2 = lorenzEquilibriumRadius rho beta ^ 2 := by
        rw [hRadiusSquare]
        nlinarith [hThird, hzEquilibrium]
      rcases eq_or_eq_neg_of_sq_eq_sq x (lorenzEquilibriumRadius rho beta)
          hxSquare with hxPositive | hxNegative
      · exact Or.inr (Or.inl (by
          simp [lorenzPositiveEquilibrium, hxPositive, hzEquilibrium]))
      · exact Or.inr (Or.inr (by
          simp [lorenzNegativeEquilibrium, hxNegative, hzEquilibrium]))
  · rintro (hOrigin | hPositive | hNegative)
    · rw [hOrigin]
      exact lorenzVectorField_origin sigma rho beta
    · rw [hPositive]
      exact lorenzVectorField_positiveEquilibrium hRadicand
    · rw [hNegative]
      exact lorenzVectorField_negativeEquilibrium hRadicand

/-- The constant origin curve is a global integral curve. -/
theorem lorenz_origin_isIntegralCurve (sigma rho beta : ℝ) :
    IsIntegralCurve (fun _ : ℝ ↦ (0, 0, 0))
      (lorenzODEField sigma rho beta) := by
  intro t
  rw [show lorenzODEField sigma rho beta t (0, 0, 0) =
      (0 : ℝ × ℝ × ℝ) by simp]
  exact hasDerivAt_const t ((0, 0, 0) : ℝ × ℝ × ℝ)

/-- Under a nonnegative radicand, the constant positive-sign equilibrium curve
is a global integral curve. -/
theorem lorenz_positiveEquilibrium_isIntegralCurve
    {sigma rho beta : ℝ} (hRadicand : 0 ≤ beta * (rho - 1)) :
    IsIntegralCurve (fun _ : ℝ ↦ lorenzPositiveEquilibrium rho beta)
      (lorenzODEField sigma rho beta) := by
  intro t
  rw [show lorenzODEField sigma rho beta t
      (lorenzPositiveEquilibrium rho beta) = (0 : ℝ × ℝ × ℝ) by
        simp [hRadicand]]
  exact hasDerivAt_const t (lorenzPositiveEquilibrium rho beta)

/-- Under a nonnegative radicand, the constant negative-sign equilibrium curve
is a global integral curve. -/
theorem lorenz_negativeEquilibrium_isIntegralCurve
    {sigma rho beta : ℝ} (hRadicand : 0 ≤ beta * (rho - 1)) :
    IsIntegralCurve (fun _ : ℝ ↦ lorenzNegativeEquilibrium rho beta)
      (lorenzODEField sigma rho beta) := by
  intro t
  rw [show lorenzODEField sigma rho beta t
      (lorenzNegativeEquilibrium rho beta) = (0 : ℝ × ℝ × ℝ) by
        simp [hRadicand]]
  exact hasDerivAt_const t (lorenzNegativeEquilibrium rho beta)

end

end NonlinearDynamics.Deterministic.Models

#print axioms NonlinearDynamics.Deterministic.Models.lorenzVectorField_symmetry
#print axioms NonlinearDynamics.Deterministic.Models.lorenzVectorField_eq_zero_iff_of_pos
#print axioms NonlinearDynamics.Deterministic.Models.lorenz_origin_isIntegralCurve
#print axioms NonlinearDynamics.Deterministic.Models.lorenz_positiveEquilibrium_isIntegralCurve
#print axioms NonlinearDynamics.Deterministic.Models.lorenz_negativeEquilibrium_isIntegralCurve
