import Mathlib.Analysis.ODE.Basic
import Mathlib.Analysis.SpecialFunctions.Log.Deriv

/-!
# The four-parameter Lotka-Volterra predator-prey field

This module studies the autonomous first-order system

`x' = x * (alpha - beta * y)`,
`y' = y * (delta * x - gamma)`

on the full plane `ℝ × ℝ`.  The first coordinate is prey and the second
is predator.  The four parameters remain algebraically explicit; their usual
predator-prey interpretation assumes that all four are strictly positive.

The full-plane carrier keeps the polynomial vector field and its degenerate
parameter cases available without subtype coercions.  A separate set names the
strictly positive quadrant.  Under positive parameters the field has exactly
the origin and the coexistence state `(gamma / delta, alpha / beta)` as zeros.

On positive states the customary logarithmic first integral is

`delta * x - gamma * log x + beta * y - alpha * log y`.

The main differential statement is local and assumption-explicit: whenever
positive component curves satisfy the two Lotka-Volterra equations at a time,
the derivative of this scalar is zero at that time.  Although `Real.log` is
totalized in Lean, no conservation claim is made on either coordinate axis.

This first slice does not prove forward invariance of the positive quadrant,
construct solutions through arbitrary states, bundle a global flow, classify
nonconstant level sets as closed orbits, prove periodicity, or establish any
stability conclusion.  Those require additional ODE and dynamical arguments.
-/

open Set

namespace NonlinearDynamics.Deterministic.Models

noncomputable section

/-- The four-parameter Lotka-Volterra predator-prey vector field on the full
plane.  A state is `(prey, predator)`. -/
def lotkaVolterraVectorField (alpha beta gamma delta : ℝ)
    (state : ℝ × ℝ) : ℝ × ℝ :=
  (state.1 * (alpha - beta * state.2),
    state.2 * (delta * state.1 - gamma))

/-- The Lotka-Volterra vector field written as a time-independent field in
Mathlib's ODE interface. -/
def lotkaVolterraODEField (alpha beta gamma delta : ℝ) :
    ℝ → (ℝ × ℝ) → (ℝ × ℝ) :=
  fun _ state ↦ lotkaVolterraVectorField alpha beta gamma delta state

@[simp] theorem lotkaVolterraODEField_apply
    (alpha beta gamma delta t : ℝ) (state : ℝ × ℝ) :
    lotkaVolterraODEField alpha beta gamma delta t state =
      lotkaVolterraVectorField alpha beta gamma delta state :=
  rfl

/-- The strict positive quadrant, named separately from the full-plane carrier
of the polynomial vector field. -/
def lotkaVolterraPositiveQuadrant : Set (ℝ × ℝ) :=
  Ioi 0 ×ˢ Ioi 0

@[simp] theorem mem_lotkaVolterraPositiveQuadrant (state : ℝ × ℝ) :
    state ∈ lotkaVolterraPositiveQuadrant ↔
      0 < state.1 ∧ 0 < state.2 := by
  simp [lotkaVolterraPositiveQuadrant]

/-- The coexistence state selected by the four parameters.  Its biological
interpretation requires positive parameters, while the algebraic definition
is meaningful whenever the displayed divisions are interpreted in `Real`. -/
def lotkaVolterraCoexistence (alpha beta gamma delta : ℝ) : ℝ × ℝ :=
  (gamma / delta, alpha / beta)

/-- Positive parameters place the coexistence state in the strict positive
quadrant. -/
theorem lotkaVolterraCoexistence_mem_positiveQuadrant
    {alpha beta gamma delta : ℝ}
    (hAlpha : 0 < alpha) (hBeta : 0 < beta)
    (hGamma : 0 < gamma) (hDelta : 0 < delta) :
    lotkaVolterraCoexistence alpha beta gamma delta ∈
      lotkaVolterraPositiveQuadrant := by
  simp [lotkaVolterraCoexistence, lotkaVolterraPositiveQuadrant,
    div_pos hGamma hDelta, div_pos hAlpha hBeta]

/-- The Lotka-Volterra vector field is continuous for every choice of real
parameters. -/
theorem continuous_lotkaVolterraVectorField (alpha beta gamma delta : ℝ) :
    Continuous (lotkaVolterraVectorField alpha beta gamma delta) := by
  unfold lotkaVolterraVectorField
  fun_prop

/-- The extinction state is an equilibrium for every choice of parameters. -/
@[simp] theorem lotkaVolterraVectorField_origin
    (alpha beta gamma delta : ℝ) :
    lotkaVolterraVectorField alpha beta gamma delta (0, 0) = 0 := by
  simp [lotkaVolterraVectorField]

/-- On the predator-free axis, the field is tangent to the axis and the prey
coordinate has its uncoupled exponential-growth derivative. -/
@[simp] theorem lotkaVolterraVectorField_predator_free
    (alpha beta gamma delta x : ℝ) :
    lotkaVolterraVectorField alpha beta gamma delta (x, 0) =
      (alpha * x, 0) := by
  simp [lotkaVolterraVectorField, mul_comm]

/-- On the prey-free axis, the field is tangent to the axis and the predator
coordinate has its uncoupled mortality derivative. -/
@[simp] theorem lotkaVolterraVectorField_prey_free
    (alpha beta gamma delta y : ℝ) :
    lotkaVolterraVectorField alpha beta gamma delta (0, y) =
      (0, -gamma * y) := by
  simp [lotkaVolterraVectorField, mul_comm]

/-- When the interaction denominators are nonzero, the coexistence state is a
zero of the vector field. -/
@[simp] theorem lotkaVolterraVectorField_coexistence
    {alpha beta gamma delta : ℝ} (hBeta : beta ≠ 0) (hDelta : delta ≠ 0) :
    lotkaVolterraVectorField alpha beta gamma delta
      (lotkaVolterraCoexistence alpha beta gamma delta) = 0 := by
  have hPreyFactor : alpha - beta * (alpha / beta) = 0 := by
    field_simp [hBeta]
    ring
  have hPredatorFactor : delta * (gamma / delta) - gamma = 0 := by
    field_simp [hDelta]
    ring
  change
    ((gamma / delta) * (alpha - beta * (alpha / beta)),
      (alpha / beta) * (delta * (gamma / delta) - gamma)) = (0, 0)
  rw [hPreyFactor, hPredatorFactor]
  simp

/-- With four strictly positive parameters, the origin and the coexistence
state are exactly the zeros of the full-plane vector field. -/
theorem lotkaVolterraVectorField_eq_zero_iff_of_pos
    {alpha beta gamma delta : ℝ}
    (hAlpha : 0 < alpha) (hBeta : 0 < beta)
    (hGamma : 0 < gamma) (hDelta : 0 < delta)
    (state : ℝ × ℝ) :
    lotkaVolterraVectorField alpha beta gamma delta state = 0 ↔
      state = (0, 0) ∨
        state = lotkaVolterraCoexistence alpha beta gamma delta := by
  rcases state with ⟨x, y⟩
  constructor
  · intro hField
    have hPrey : x * (alpha - beta * y) = 0 := by
      simpa [lotkaVolterraVectorField] using congrArg Prod.fst hField
    have hPredator : y * (delta * x - gamma) = 0 := by
      simpa [lotkaVolterraVectorField] using congrArg Prod.snd hField
    rcases mul_eq_zero.mp hPrey with hx | hPreyFactor
    · have hy : y = 0 := by
        subst x
        simpa [hGamma.ne'] using hPredator
      exact Or.inl (by simp [hx, hy])
    · rcases mul_eq_zero.mp hPredator with hy | hPredatorFactor
      · exfalso
        subst y
        simp [hAlpha.ne'] at hPreyFactor
      · have hxCoexistence : x = gamma / delta := by
          apply (eq_div_iff hDelta.ne').2
          nlinarith [hPredatorFactor]
        have hyCoexistence : y = alpha / beta := by
          apply (eq_div_iff hBeta.ne').2
          nlinarith [hPreyFactor]
        exact Or.inr (by
          simp [lotkaVolterraCoexistence, hxCoexistence, hyCoexistence])
  · rintro (hOrigin | hCoexistence)
    · rw [hOrigin]
      exact lotkaVolterraVectorField_origin alpha beta gamma delta
    · rw [hCoexistence]
      exact lotkaVolterraVectorField_coexistence hBeta.ne' hDelta.ne'

/-- At the normalized state `(2, 3)`, prey decreases at rate four while
predator increases at rate three. -/
theorem lotkaVolterraVectorField_normalized_benchmark :
    lotkaVolterraVectorField 1 1 1 1 (2, 3) = (-4, 3) := by
  norm_num [lotkaVolterraVectorField]

/-- The logarithmic first-integral expression.  Its mathematical conservation
interface below is restricted to strictly positive component values even
though `Real.log` itself is totalized. -/
def lotkaVolterraFirstIntegral (alpha beta gamma delta : ℝ)
    (state : ℝ × ℝ) : ℝ :=
  (delta * state.1 - gamma * Real.log state.1) +
    (beta * state.2 - alpha * Real.log state.2)

/-- The normalized coexistence state `(1, 1)` has first-integral value two. -/
theorem lotkaVolterraFirstIntegral_normalized_coexistence :
    lotkaVolterraFirstIntegral 1 1 1 1 (1, 1) = 2 := by
  norm_num [lotkaVolterraFirstIntegral]

section FirstIntegralDerivative

attribute [local instance 1200] NormedAddCommGroup.toAddCommGroup
  NormedSpace.toModule

/-- If two positive component curves obey the Lotka-Volterra equations at
time `t`, then the derivative of the logarithmic first integral is zero there.
This is a pointwise conservation identity, not a solution-existence,
positive-invariance, periodic-orbit, or stability theorem. -/
theorem hasDerivAt_lotkaVolterraFirstIntegral_along
    (alpha beta gamma delta : ℝ) {x y : ℝ → ℝ} {t : ℝ}
    (hxPositive : 0 < x t) (hyPositive : 0 < y t)
    (hx : HasDerivAt x (x t * (alpha - beta * y t)) t)
    (hy : HasDerivAt y (y t * (delta * x t - gamma)) t) :
    HasDerivAt
      (fun s ↦ lotkaVolterraFirstIntegral alpha beta gamma delta (x s, y s))
      0 t := by
  change HasDerivAt
    (((fun s ↦ delta * x s) - fun s ↦ gamma * Real.log (x s)) +
      ((fun s ↦ beta * y s) - fun s ↦ alpha * Real.log (y s))) 0 t
  have hDerivative :=
    ((hx.const_mul delta).sub ((hx.log hxPositive.ne').const_mul gamma)).add
      ((hy.const_mul beta).sub ((hy.log hyPositive.ne').const_mul alpha))
  have hCancel :
      (delta * (x t * (alpha - beta * y t)) -
          gamma * (x t * (alpha - beta * y t) / x t)) +
        (beta * (y t * (delta * x t - gamma)) -
          alpha * (y t * (delta * x t - gamma) / y t)) = 0 := by
    field_simp [hxPositive.ne', hyPositive.ne']
    ring
  exact hDerivative.congr_deriv hCancel

end FirstIntegralDerivative

/-- The constant extinction-state curve is a global integral curve. -/
theorem lotkaVolterra_origin_isIntegralCurve
    (alpha beta gamma delta : ℝ) :
    IsIntegralCurve (fun _ : ℝ ↦ (0, 0))
      (lotkaVolterraODEField alpha beta gamma delta) := by
  intro t
  rw [show lotkaVolterraODEField alpha beta gamma delta t (0, 0) =
      (0 : ℝ × ℝ) by simp]
  exact hasDerivAt_const t ((0, 0) : ℝ × ℝ)

/-- Under nonzero interaction denominators, the constant coexistence-state
curve is a global integral curve. -/
theorem lotkaVolterra_coexistence_isIntegralCurve
    {alpha beta gamma delta : ℝ} (hBeta : beta ≠ 0) (hDelta : delta ≠ 0) :
    IsIntegralCurve
      (fun _ : ℝ ↦ lotkaVolterraCoexistence alpha beta gamma delta)
      (lotkaVolterraODEField alpha beta gamma delta) := by
  intro t
  rw [show lotkaVolterraODEField alpha beta gamma delta t
      (lotkaVolterraCoexistence alpha beta gamma delta) =
        (0 : ℝ × ℝ) by simp [hBeta, hDelta]]
  exact hasDerivAt_const t (lotkaVolterraCoexistence alpha beta gamma delta)

end

end NonlinearDynamics.Deterministic.Models

#print axioms NonlinearDynamics.Deterministic.Models.lotkaVolterraVectorField_eq_zero_iff_of_pos
#print axioms NonlinearDynamics.Deterministic.Models.lotkaVolterraCoexistence_mem_positiveQuadrant
#print axioms NonlinearDynamics.Deterministic.Models.hasDerivAt_lotkaVolterraFirstIntegral_along
#print axioms NonlinearDynamics.Deterministic.Models.lotkaVolterra_origin_isIntegralCurve
#print axioms NonlinearDynamics.Deterministic.Models.lotkaVolterra_coexistence_isIntegralCurve
