import Mathlib.Analysis.Normed.Algebra.MatrixExponential
import NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity

/-!
# Shared finite-dimensional quantum systems

This module fixes the conventions used by the later quantum-chaos branches.
A finite Hamiltonian is the project's existing intrinsic Hermitian Euclidean
carrier. Its matrix is therefore Hermitian by construction, and its ordered
spectrum and zero-aware empirical spectral measure are reused directly from
`NonlinearDynamics.Random.RandomMatrix`.

In units where `ℏ = 1`, the Schrödinger generator at real time `t` is
`-t • (I • H)`, so the evolution convention is `U_H(t) = exp (-I t H)`.
The exponential is bundled in Mathlib's finite matrix unitary group, and the
same-Hamiltonian evolution law is proved from commuting matrix exponentials.

The normalized trace is `n⁻¹ Tr(A)`, with the reciprocal taken in `ℝ` and
then included in `ℂ`. Consequently it is zero in dimension zero. For a finite
Hamiltonian it agrees with the first moment of the project's zero-aware
empirical spectral measure.

No level-spacing statistic, unfolding, spectral form factor, out-of-time-order
correlator, ensemble average, asymptotic limit, or quantum-chaos criterion is
defined or inferred here.
-/

open Matrix NormedSpace
open scoped Matrix Norms.Operator

namespace NonlinearDynamics.QuantumChaos

namespace RandomMatrix := NonlinearDynamics.Random.RandomMatrix

noncomputable section

/-- A finite-dimensional Hamiltonian, reusing the project's intrinsic real
Euclidean space of complex Hermitian matrices. -/
abbrev FiniteHamiltonian (n : ℕ) := RandomMatrix.HermitianEuclidean n

/-- Forget the intrinsic Hermitian/Frobenius structure and expose the
Hamiltonian as an ambient complex matrix. -/
def hamiltonianMatrix {n : ℕ} (H : FiniteHamiltonian n) :
    Matrix (Fin n) (Fin n) ℂ :=
  RandomMatrix.hermitianToMatrix H

/-- Every finite Hamiltonian matrix is Hermitian by construction. -/
theorem hamiltonianMatrix_isHermitian {n : ℕ} (H : FiniteHamiltonian n) :
    (hamiltonianMatrix H).IsHermitian :=
  H.2

/-- The time-`t` Schrödinger generator in the convention `ℏ = 1` and
`U_H(t) = exp (-I t H)`. The outer scalar is real, while `I` is complex. -/
def schrodingerGenerator {n : ℕ} (H : FiniteHamiltonian n) (t : ℝ) :
    Matrix (Fin n) (Fin n) ℂ :=
  (-t) • (Complex.I • hamiltonianMatrix H)

/-- A Hermitian Hamiltonian gives a skew-adjoint Schrödinger generator. -/
theorem schrodingerGenerator_mem_skewAdjoint {n : ℕ}
    (H : FiniteHamiltonian n) (t : ℝ) :
    schrodingerGenerator H t ∈
      skewAdjoint (Matrix (Fin n) (Fin n) ℂ) := by
  exact (skewAdjoint (Matrix (Fin n) (Fin n) ℂ)).smul_mem (-t)
    (hamiltonianMatrix_isHermitian H).isSelfAdjoint.I_smul_mem_skewAdjoint

/-- The time-zero generator is the zero matrix. -/
@[simp] theorem schrodingerGenerator_zero {n : ℕ}
    (H : FiniteHamiltonian n) : schrodingerGenerator H 0 = 0 := by
  simp [schrodingerGenerator]

/-- Generators for one Hamiltonian add with real time. -/
theorem schrodingerGenerator_add {n : ℕ} (H : FiniteHamiltonian n)
    (s t : ℝ) :
    schrodingerGenerator H (s + t) =
      schrodingerGenerator H s + schrodingerGenerator H t := by
  change (-(s + t)) • (Complex.I • hamiltonianMatrix H) =
    (-s) • (Complex.I • hamiltonianMatrix H) +
      (-t) • (Complex.I • hamiltonianMatrix H)
  rw [neg_add_rev, add_comm (-t) (-s), add_smul]

/-- Any two time-scaled generators of the same Hamiltonian commute. -/
theorem schrodingerGenerator_commute {n : ℕ} (H : FiniteHamiltonian n)
    (s t : ℝ) :
    Commute (schrodingerGenerator H s) (schrodingerGenerator H t) := by
  exact ((Commute.refl (Complex.I • hamiltonianMatrix H)).smul_left (-s)).smul_right (-t)

/-- The ambient matrix exponential `exp (-I t H)`. -/
noncomputable def timeEvolutionMatrix {n : ℕ} (H : FiniteHamiltonian n)
    (t : ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  exp (schrodingerGenerator H t)

/-- Finite Schrödinger evolution bundled as a unitary matrix. -/
noncomputable def timeEvolution {n : ℕ} (H : FiniteHamiltonian n) (t : ℝ) :
    Matrix.unitaryGroup (Fin n) ℂ :=
  ⟨timeEvolutionMatrix H t,
    exp_mem_unitary_of_mem_skewAdjoint
      (schrodingerGenerator_mem_skewAdjoint H t)⟩

/-- Forgetting the unitary certificate exposes the matrix exponential. -/
@[simp] theorem timeEvolution_coe {n : ℕ} (H : FiniteHamiltonian n) (t : ℝ) :
    (timeEvolution H t : Matrix (Fin n) (Fin n) ℂ) =
      timeEvolutionMatrix H t :=
  rfl

/-- Time-zero evolution is the identity unitary. -/
@[simp] theorem timeEvolution_zero {n : ℕ} (H : FiniteHamiltonian n) :
    timeEvolution H 0 = 1 := by
  apply Subtype.ext
  simp [timeEvolution, timeEvolutionMatrix]

/-- Evolution for one Hamiltonian composes according to addition of times. -/
theorem timeEvolution_add {n : ℕ} (H : FiniteHamiltonian n) (s t : ℝ) :
    timeEvolution H (s + t) = timeEvolution H s * timeEvolution H t := by
  apply Subtype.ext
  change exp (schrodingerGenerator H (s + t)) =
    exp (schrodingerGenerator H s) * exp (schrodingerGenerator H t)
  rw [schrodingerGenerator_add]
  exact Matrix.exp_add_of_commute _ _ (schrodingerGenerator_commute H s t)

/-- Opposite time gives the inverse unitary evolution. -/
@[simp] theorem timeEvolution_neg {n : ℕ} (H : FiniteHamiltonian n) (t : ℝ) :
    timeEvolution H (-t) = (timeEvolution H t)⁻¹ := by
  apply eq_inv_of_mul_eq_one_right
  rw [← timeEvolution_add]
  simp

/-- Reciprocal-dimension normalized complex matrix trace. The real reciprocal
is included into `ℂ`, matching the existing empirical-spectral-moment API. -/
def normalizedTrace {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) : ℂ :=
  (((n : ℕ) : ℝ)⁻¹ : ℂ) * Matrix.trace A

/-- The normalized trace is explicitly zero in dimension zero. -/
@[simp] theorem normalizedTrace_zero_dimension
    (A : Matrix (Fin 0) (Fin 0) ℂ) : normalizedTrace A = 0 := by
  simp [normalizedTrace]

/-- Unitary conjugation preserves the normalized trace. -/
theorem normalizedTrace_unitary_conjugation {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ)
    (A : Matrix (Fin n) (Fin n) ℂ) :
    normalizedTrace ((U : Matrix (Fin n) (Fin n) ℂ) * A * Uᴴ) =
      normalizedTrace A := by
  unfold normalizedTrace
  congr 1
  calc
    Matrix.trace ((U : Matrix (Fin n) (Fin n) ℂ) * A * Uᴴ) =
        Matrix.trace (Uᴴ * (U : Matrix (Fin n) (Fin n) ℂ) * A) :=
      Matrix.trace_mul_cycle _ _ _
    _ = Matrix.trace A := by rw [U.2.1, one_mul]

/-- For a finite Hamiltonian, normalized trace is the first complex moment of
the existing zero-aware empirical spectral measure. -/
theorem normalizedTrace_hamiltonian_eq_empiricalSpectralMoment_one {n : ℕ}
    (H : FiniteHamiltonian n) :
    normalizedTrace (hamiltonianMatrix H) =
      RandomMatrix.empiricalSpectralMoment 1 H := by
  simpa [normalizedTrace, hamiltonianMatrix] using
    (RandomMatrix.empiricalSpectralMoment_one H).symm

#print axioms hamiltonianMatrix_isHermitian
#print axioms schrodingerGenerator_mem_skewAdjoint
#print axioms timeEvolution_add
#print axioms timeEvolution_neg
#print axioms normalizedTrace_hamiltonian_eq_empiricalSpectralMoment_one

end

end NonlinearDynamics.QuantumChaos
