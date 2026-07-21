import NonlinearDynamics.Random.RandomCocycles.SubadditiveFiniteBlocks
import Mathlib.Dynamics.BirkhoffSum.Average

/-!
# Centering subadditive processes by a one-step Birkhoff sum

This module subtracts the additive orbit sum of the one-step observable from a
finite shifted-subadditive process. The resulting centered process is
nonpositive at every positive horizon. Uniform nonpositivity, including time
zero, requires the exact normalization `X 0 = 0`. Here "centered" means
compensation by a pointwise additive majorant, not subtraction of an
expectation and not a mean-zero assertion.

The compensation preserves shifted subadditivity by finite algebra alone. If
the one-step base map preserves the measure, it also preserves finite-horizon
integrability and therefore yields another integrable subadditive-process
candidate. An exact normalized identity separates the original process into a
centered term and a one-step Birkhoff average, including at the totalized
zero-time boundary.

The final declarations specialize this reduction to the cocycle log-positive
norm process. Pointwise nonpositivity and shifted subadditivity use only the
cocycle itself; the existing one-step integrability hypothesis enters only
when the centered family is packaged as an integrable candidate. No
probability, ergodicity, pointwise Birkhoff theorem, Kingman theorem,
almost-everywhere limit, Lyapunov exponent, or Oseledets splitting is proved.
-/

open MeasureTheory

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ uι

/-- Subtract the additive one-step orbit sum from a finite shifted-subadditive
process. This is pointwise compensation, not centering by an expectation. -/
def centeredProcess {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ)
    (n : ℕ) (ω : Ω) : ℝ :=
  X n ω - birkhoffSum T (X 1) n ω

/-- At time zero, the centered process retains the original time-zero value. -/
@[simp] theorem centeredProcess_zero {Ω : Type uΩ} (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) :
    centeredProcess T X 0 = X 0 := by
  funext ω
  simp [centeredProcess]

/-- At one step, the centered process vanishes identically. -/
@[simp] theorem centeredProcess_one {Ω : Type uΩ} (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) :
    centeredProcess T X 1 = 0 := by
  funext ω
  simp [centeredProcess, birkhoffSum_one]

private theorem centeredProcess_add_le_of_add_le
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω)
    (m n : ℕ) (ω : Ω) :
    centeredProcess T X (m + n) ω ≤
      centeredProcess T X n (T^[m] ω) + centeredProcess T X m ω := by
  unfold centeredProcess
  rw [birkhoffSum_add]
  linarith [hadd m n ω]

private theorem oneStepBirkhoffMajorant_of_add_le
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω)
    (n : ℕ) (hn : n ≠ 0) (ω : Ω) :
    X n ω ≤ birkhoffSum T (X 1) n ω := by
  obtain ⟨n, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hn
  induction n generalizing ω with
  | zero => simp [birkhoffSum_one]
  | succ n ih =>
      calc
        X ((n + 1) + 1) ω ≤
            X 1 (T^[n + 1] ω) + X (n + 1) ω :=
          hadd (n + 1) 1 ω
        _ ≤ X 1 (T^[n + 1] ω) +
              birkhoffSum T (X 1) (n + 1) ω :=
          by linarith [ih ω (Nat.succ_ne_zero n)]
        _ = birkhoffSum T (X 1) ((n + 1) + 1) ω := by
          rw [birkhoffSum_succ T (X 1) (n + 1) ω]
          exact add_comm _ _

namespace IsIntegrableSubadditiveProcessCandidate

variable {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
  {μ : Measure Ω} {X : ℕ → Ω → ℝ}

/-- At every positive horizon, the one-step Birkhoff sum pointwise majorizes
the process without a time-zero normalization hypothesis. -/
theorem oneStepBirkhoffMajorant_of_ne_zero
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (n : ℕ) (hn : n ≠ 0) (ω : Ω) :
    X n ω ≤ birkhoffSum T (X 1) n ω :=
  oneStepBirkhoffMajorant_of_add_le hX.add_le n hn ω

/-- With exact time-zero normalization, the one-step Birkhoff sum pointwise
majorizes every finite horizon, including time zero. -/
theorem oneStepBirkhoffMajorant
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hX0 : X 0 = 0) (n : ℕ) (ω : Ω) :
    X n ω ≤ birkhoffSum T (X 1) n ω := by
  cases n with
  | zero => simp [hX0]
  | succ n =>
      exact oneStepBirkhoffMajorant_of_add_le hX.add_le (n + 1)
        (Nat.succ_ne_zero n) ω

/-- The centered process is pointwise nonpositive at every positive horizon,
without a time-zero normalization hypothesis. -/
theorem centeredProcess_nonpos_of_ne_zero
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (n : ℕ) (hn : n ≠ 0) (ω : Ω) :
    centeredProcess T X n ω ≤ 0 :=
  sub_nonpos.mpr (hX.oneStepBirkhoffMajorant_of_ne_zero n hn ω)

/-- The centered process is pointwise nonpositive at every horizon when the
original process vanishes exactly at time zero. -/
theorem centeredProcess_nonpos
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hX0 : X 0 = 0) (n : ℕ) (ω : Ω) :
    centeredProcess T X n ω ≤ 0 :=
  sub_nonpos.mpr (hX.oneStepBirkhoffMajorant hX0 n ω)

/-- Subtracting the additive one-step orbit sum preserves shifted
subadditivity. Integrability and time-zero normalization are not used. -/
theorem centeredProcess_add_le
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (m n : ℕ) (ω : Ω) :
    centeredProcess T X (m + n) ω ≤
      centeredProcess T X n (T^[m] ω) + centeredProcess T X m ω :=
  centeredProcess_add_le_of_add_le hX.add_le m n ω

/-- If the one-step base map preserves the measure, every centered horizon is
integrable. Probability, ergodicity, and time-zero normalization are not
required. -/
theorem integrable_centeredProcess
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (n : ℕ) :
    Integrable (centeredProcess T X n) μ := by
  apply (hX.integrable n).sub
  simpa only [Function.iterate_one] using
    hX.integrable_birkhoffSum_blocks 1 n hT

/-- Under one-step measure preservation, the centered family is again an
integrable shifted-subadditive-process candidate. No time-zero normalization
is needed for this package. -/
theorem centeredProcess_candidate
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) :
    IsIntegrableSubadditiveProcessCandidate T μ (centeredProcess T X) where
  integrable := hX.integrable_centeredProcess hT
  add_le := hX.centeredProcess_add_le

end IsIntegrableSubadditiveProcessCandidate

/-- Normalizing the original process splits algebraically into the normalized
centered process and the one-step Birkhoff average. This identity is total at
time zero and needs no measurability, integrability, or preservation. -/
theorem normalized_eq_centered_add_birkhoffAverage
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (n : ℕ) (ω : Ω) :
    X n ω / (n : ℝ) = centeredProcess T X n ω / (n : ℝ) +
      birkhoffAverage ℝ T (X 1) n ω := by
  simp only [centeredProcess, birkhoffAverage, smul_eq_mul]
  ring

namespace DiscreteMatrixCocycle

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-- The existing orbit log-positive sum is definitionally the Birkhoff sum of
the one-step log-positive observable. -/
@[simp] theorem birkhoffSum_logPlusNormObservable_one_eq_orbitLogPlusSum
    (C : DiscreteMatrixCocycle (ι := ι) μ) (n : ℕ) :
    birkhoffSum C.base (C.logPlusNormObservable 1) n =
      C.orbitLogPlusSum n := by
  rfl

/-- The cocycle log-positive process after subtracting its additive one-step
orbit majorant. -/
def centeredLogPlusNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (n : ℕ) : Ω → ℝ :=
  centeredProcess C.base C.logPlusNormObservable n

/-- Cocycle centering is exactly finite-time log-positive growth minus its
one-step orbit sum. -/
@[simp] theorem centeredLogPlusNormObservable_apply
    (C : DiscreteMatrixCocycle (ι := ι) μ) (n : ℕ) (ω : Ω) :
    C.centeredLogPlusNormObservable n ω =
      C.logPlusNormObservable n ω - C.orbitLogPlusSum n ω := by
  rfl

/-- Cocycle centering is pointwise nonpositive without an integrability
hypothesis, uniformly including time zero. -/
theorem centeredLogPlusNormObservable_nonpos
    (C : DiscreteMatrixCocycle (ι := ι) μ) (n : ℕ) (ω : Ω) :
    C.centeredLogPlusNormObservable n ω ≤ 0 := by
  rw [C.centeredLogPlusNormObservable_apply]
  exact sub_nonpos.mpr (C.logPlusNormObservable_le_orbitLogPlusSum n ω)

/-- Cocycle centering preserves shifted subadditivity without an integrability
hypothesis. -/
theorem centeredLogPlusNormObservable_add_le
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (m n : ℕ) (ω : Ω) :
    C.centeredLogPlusNormObservable (m + n) ω ≤
      C.centeredLogPlusNormObservable n (C.base^[m] ω) +
        C.centeredLogPlusNormObservable m ω :=
  centeredProcess_add_le_of_add_le C.logPlusNormObservable_add_le m n ω

/-- Under the existing one-step integrability hypothesis, the centered
log-positive family is an integrable shifted-subadditive-process candidate. -/
theorem HasIntegrableGeneratorLogPlus.centeredLogPlusNormObservable_candidate
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) :
    IsIntegrableSubadditiveProcessCandidate C.base μ
      C.centeredLogPlusNormObservable := by
  refine
    { integrable := ?_
      add_le := C.centeredLogPlusNormObservable_add_le }
  intro n
  simpa only [centeredLogPlusNormObservable] using
    hC.isIntegrableSubadditiveProcessCandidate.integrable_centeredProcess
      C.base_preserving n

/-- The cocycle normalized log-positive value is the normalized centered value
plus the Birkhoff average of its one-step observable. No integrability
hypothesis is needed for this pointwise identity. -/
theorem logPlusNormObservable_normalized_eq_centered_add_birkhoffAverage
    (C : DiscreteMatrixCocycle (ι := ι) μ) (n : ℕ) (ω : Ω) :
    C.logPlusNormObservable n ω / (n : ℝ) =
      C.centeredLogPlusNormObservable n ω / (n : ℝ) +
        birkhoffAverage ℝ C.base (C.logPlusNormObservable 1) n ω :=
  normalized_eq_centered_add_birkhoffAverage n ω

end DiscreteMatrixCocycle

end NonlinearDynamics.Random.RandomCocycles
