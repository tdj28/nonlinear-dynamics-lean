import Mathlib.Analysis.Matrix.Normed

/-!
# Ordered finite matrix products

This module fixes the forward-time convention
`A (k - 1) * ... * A 1 * A 0`, proves its concatenation law, and develops
operator-norm growth estimates in positive finite dimension. The newest factor
acts on the left, so matrix action follows chronological composition.

The analytic layer opens `Matrix.Norms.Operator`. Its matrix norm is the
maximum absolute row sum, equal to the norm induced by the vector supremum
norm. It is not the Frobenius norm, the Euclidean spectral norm, or the
entrywise maximum norm.

The algebraic layer permits an empty index type. The four norm estimates ask
for `Nonempty ι` because the selected norm's normalized identity theorem is
used at the zero horizon; this is an explicit interface choice, not an
assertion that empty matrices are ill-defined.

Only deterministic, finite products occur here. The module introduces no
random measurability, logarithmic growth rate, Lyapunov exponent, subadditive
limit, or multiplicative ergodic theorem.
-/

open scoped BigOperators Matrix Matrix.Norms.Operator

namespace NonlinearDynamics.Random.MatrixProducts

variable {𝕜 ι : Type*} [Fintype ι] [DecidableEq ι]

section Algebra

variable [Semiring 𝕜]

/-- The forward product `A (k - 1) * ... * A 0`; time zero is the identity. -/
def forwardProduct (A : ℕ → Matrix ι ι 𝕜) : ℕ → Matrix ι ι 𝕜
  | 0 => 1
  | k + 1 => A k * forwardProduct A k

@[simp] theorem forwardProduct_zero (A : ℕ → Matrix ι ι 𝕜) :
    forwardProduct A 0 = 1 := rfl

@[simp] theorem forwardProduct_succ (A : ℕ → Matrix ι ι 𝕜) (k : ℕ) :
    forwardProduct A (k + 1) = A k * forwardProduct A k := rfl

/-- Splitting a forward product after `m` steps leaves the later block on the
left, matching composition of matrix actions. -/
theorem forwardProduct_add (A : ℕ → Matrix ι ι 𝕜) (m k : ℕ) :
    forwardProduct A (m + k) =
      forwardProduct (fun j => A (m + j)) k * forwardProduct A m := by
  induction k with
  | zero => simp
  | succ k ih =>
      rw [Nat.add_succ, forwardProduct_succ, ih, forwardProduct_succ]
      simp only [mul_assoc]

@[simp] theorem forwardProduct_one (A : ℕ → Matrix ι ι 𝕜) :
    forwardProduct A 1 = A 0 := by
  simp [forwardProduct]

/-- A constant nonautonomous system recovers ordinary matrix powers. -/
@[simp] theorem forwardProduct_const (B : Matrix ι ι 𝕜) (k : ℕ) :
    forwardProduct (fun _ : ℕ => B) k = B ^ k := by
  induction k with
  | zero => simp
  | succ k ih => rw [forwardProduct_succ, ih, pow_succ']

/-- The identity system has identity forward product at every horizon. -/
@[simp] theorem forwardProduct_const_one (k : ℕ) :
    forwardProduct (fun _ : ℕ => (1 : Matrix ι ι 𝕜)) k = 1 := by
  simp

/-- At time zero, the forward product acts as the identity on every vector. -/
@[simp] theorem forwardProduct_mulVec_zero (A : ℕ → Matrix ι ι 𝕜) (x : ι → 𝕜) :
    forwardProduct A 0 *ᵥ x = x := by
  simp

/-- The forward product acts by iterating the matrices in chronological order. -/
theorem forwardProduct_mulVec_succ (A : ℕ → Matrix ι ι 𝕜) (k : ℕ) (x : ι → 𝕜) :
    forwardProduct A (k + 1) *ᵥ x =
      A k *ᵥ (forwardProduct A k *ᵥ x) := by
  rw [forwardProduct_succ, Matrix.mulVec_mulVec]

end Algebra

section PositiveDimension

variable [RCLike 𝕜] [Nonempty ι]

/-- The induced infinity operator norm of a finite product is bounded by the
product of the factor norms. -/
theorem linfty_opNorm_forwardProduct_le_prod (A : ℕ → Matrix ι ι 𝕜) (k : ℕ) :
    ‖forwardProduct A k‖ ≤ ∏ j ∈ Finset.range k, ‖A j‖ := by
  induction k with
  | zero => simp
  | succ k ih =>
      rw [forwardProduct_succ, Finset.prod_range_succ]
      calc
        ‖A k * forwardProduct A k‖ ≤ ‖A k‖ * ‖forwardProduct A k‖ :=
          norm_mul_le _ _
        _ ≤ ‖A k‖ * ∏ j ∈ Finset.range k, ‖A j‖ :=
          mul_le_mul_of_nonneg_left ih (norm_nonneg _)
        _ = (∏ j ∈ Finset.range k, ‖A j‖) * ‖A k‖ := by
          rw [mul_comm]

/-- A uniform one-step induced infinity operator-norm bound gives the usual
power bound. -/
theorem linfty_opNorm_forwardProduct_le_pow (A : ℕ → Matrix ι ι 𝕜) (C : ℝ)
    (k : ℕ) (hA : ∀ j < k, ‖A j‖ ≤ C) :
    ‖forwardProduct A k‖ ≤ C ^ k := by
  refine (linfty_opNorm_forwardProduct_le_prod A k).trans ?_
  calc
    (∏ j ∈ Finset.range k, ‖A j‖) ≤ ∏ _j ∈ Finset.range k, C :=
      Finset.prod_le_prod (fun _ _ => norm_nonneg _) fun j hj =>
        hA j (Finset.mem_range.mp hj)
    _ = C ^ k := by simp

/-- Product control transfers directly to every vector orbit in the supremum
norm. -/
theorem linfty_opNorm_forwardProduct_mulVec_le_prod
    (A : ℕ → Matrix ι ι 𝕜) (k : ℕ) (x : ι → 𝕜) :
    ‖forwardProduct A k *ᵥ x‖ ≤
      (∏ j ∈ Finset.range k, ‖A j‖) * ‖x‖ := by
  exact (Matrix.linfty_opNorm_mulVec _ _).trans
    (mul_le_mul_of_nonneg_right
      (linfty_opNorm_forwardProduct_le_prod A k) (norm_nonneg _))

/-- Under a uniform one-step bound, every vector orbit grows by at most the
corresponding geometric factor. -/
theorem linfty_opNorm_forwardProduct_mulVec_le_pow
    (A : ℕ → Matrix ι ι 𝕜) (C : ℝ)
    (k : ℕ) (hA : ∀ j < k, ‖A j‖ ≤ C) (x : ι → 𝕜) :
    ‖forwardProduct A k *ᵥ x‖ ≤ C ^ k * ‖x‖ := by
  exact (Matrix.linfty_opNorm_mulVec _ _).trans
    (mul_le_mul_of_nonneg_right
      (linfty_opNorm_forwardProduct_le_pow A C k hA) (norm_nonneg _))

end PositiveDimension

end NonlinearDynamics.Random.MatrixProducts
