import NonlinearDynamics.Random.RandomMatrices.Hermitian

/-!
# Hermitian coordinate assembly

This module supplies the normalization-free deterministic assembly map needed
before defining a finite-dimensional Hermitian matrix ensemble. A coordinate
point consists of a real diagonal and a complex strict upper triangle. The
lower triangle is filled by complex conjugation, so every assembled matrix is
Hermitian without an almost-everywhere qualification.

The construction inserts every supplied coordinate unchanged. In particular,
it does not use `X + Xᴴ`, which would double the diagonal, and it does not
choose any Gaussian variance, dimension scaling, density, or random-matrix
law. Those probability-level choices belong in later ensemble modules.

The zero-dimensional boundary is explicit: both coordinate families are
empty, and assembly returns the unique empty matrix, namely zero.
-/

open Matrix MeasureTheory
open scoped Matrix

universe uΩ

namespace NonlinearDynamics.Random

/-- Ordered row-column pairs in the strict upper triangle of an `n × n`
matrix. -/
def StrictUpperIndex (n : ℕ) := {ij : Fin n × Fin n // ij.1 < ij.2}

namespace StrictUpperIndex

/-- The strict upper triangle of a finite matrix is finite. -/
instance instFintype (n : ℕ) : Fintype (StrictUpperIndex n) := by
  unfold StrictUpperIndex
  infer_instance

/-- Strict-upper-triangle indices have decidable equality. -/
instance instDecidableEq (n : ℕ) : DecidableEq (StrictUpperIndex n) := by
  unfold StrictUpperIndex
  infer_instance

/-- A zero-dimensional matrix has no strict-upper-triangle coordinates. -/
instance instIsEmptyZero : IsEmpty (StrictUpperIndex 0) :=
  ⟨fun ij ↦ Fin.elim0 ij.1.1⟩

end StrictUpperIndex

/-- The normalization-free coordinate space for complex Hermitian matrices:
a real diagonal and a complex strict upper triangle. -/
abbrev HermitianCoordinateSpace (n : ℕ) :=
  (Fin n → ℝ) × (StrictUpperIndex n → ℂ)

namespace RandomMatrix

/-- Assemble a complex Hermitian matrix from a real diagonal and a complex
strict upper triangle. -/
def hermitianFromCoordinates {n : ℕ} (d : Fin n → ℝ)
    (u : StrictUpperIndex n → ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  fun i j ↦
    if hij : i < j then
      u ⟨(i, j), hij⟩
    else if hji : j < i then
      star (u ⟨(j, i), hji⟩)
    else
      d i

/-- The diagonal of the assembled matrix is the supplied real diagonal. -/
@[simp]
theorem hermitianFromCoordinates_apply_diag {n : ℕ} (d : Fin n → ℝ)
    (u : StrictUpperIndex n → ℂ) (i : Fin n) :
    hermitianFromCoordinates d u i i = d i := by
  simp [hermitianFromCoordinates]

/-- Above the diagonal, assembly returns the supplied complex coordinate. -/
@[simp]
theorem hermitianFromCoordinates_apply_upper {n : ℕ} (d : Fin n → ℝ)
    (u : StrictUpperIndex n → ℂ) {i j : Fin n} (hij : i < j) :
    hermitianFromCoordinates d u i j = u ⟨(i, j), hij⟩ := by
  simp [hermitianFromCoordinates, hij]

/-- Below the diagonal, assembly returns the conjugate of the mirrored strict
upper coordinate. -/
@[simp]
theorem hermitianFromCoordinates_apply_lower {n : ℕ} (d : Fin n → ℝ)
    (u : StrictUpperIndex n → ℂ) {i j : Fin n} (hji : j < i) :
    hermitianFromCoordinates d u i j = star (u ⟨(j, i), hji⟩) := by
  have hnot : ¬ i < j := not_lt_of_ge (le_of_lt hji)
  simp [hermitianFromCoordinates, hji, hnot]

/-- Coordinate assembly is Hermitian for every input, with no probability or
normalization assumptions. -/
theorem hermitianFromCoordinates_isHermitian {n : ℕ} (d : Fin n → ℝ)
    (u : StrictUpperIndex n → ℂ) :
    (hermitianFromCoordinates d u).IsHermitian := by
  rw [Matrix.IsHermitian.ext_iff]
  intro i j
  rcases lt_trichotomy i j with hij | rfl | hji
  · rw [hermitianFromCoordinates_apply_upper d u hij]
    rw [hermitianFromCoordinates_apply_lower d u hij]
    simp
  · simp
  · rw [hermitianFromCoordinates_apply_lower d u hji]
    rw [hermitianFromCoordinates_apply_upper d u hji]

/-- Entrywise measurable coordinate processes assemble to a measurable matrix
sample map. -/
theorem measurable_hermitianFromCoordinates {n : ℕ} {Ω : Type uΩ}
    [MeasurableSpace Ω] {d : Ω → Fin n → ℝ}
    {u : Ω → StrictUpperIndex n → ℂ}
    (hd : ∀ i, Measurable fun ω ↦ d ω i)
    (hu : ∀ ij, Measurable fun ω ↦ u ω ij) :
    Measurable fun ω ↦ hermitianFromCoordinates (d ω) (u ω) := by
  rw [measurable_iff_entries]
  intro i j
  by_cases hij : i < j
  · simpa [hermitianFromCoordinates, hij] using hu ⟨(i, j), hij⟩
  by_cases hji : j < i
  · simp only [hermitianFromCoordinates, hij, hji, dite_false, dite_true]
    fun_prop
  · simp only [hermitianFromCoordinates, hij, hji, dite_false]
    fun_prop

/-- The named deterministic map from the coordinate product space to ambient
complex matrices. -/
def hermitianCoordinateMap (n : ℕ) :
    HermitianCoordinateSpace n → Matrix (Fin n) (Fin n) ℂ :=
  fun x ↦ hermitianFromCoordinates x.1 x.2

/-- The deterministic coordinate map is measurable for the canonical product
measurable space. -/
theorem measurable_hermitianCoordinateMap (n : ℕ) :
    Measurable (hermitianCoordinateMap n) := by
  apply measurable_hermitianFromCoordinates
  · intro i
    exact (measurable_pi_apply i).comp measurable_fst
  · intro ij
    exact (measurable_pi_apply ij).comp measurable_snd

/-- In dimension zero, every coordinate input assembles to the unique empty
matrix, namely zero. -/
@[simp]
theorem hermitianFromCoordinates_zero (d : Fin 0 → ℝ)
    (u : StrictUpperIndex 0 → ℂ) :
    hermitianFromCoordinates d u = (0 : Matrix (Fin 0) (Fin 0) ℂ) := by
  ext i
  exact Fin.elim0 i

/-- The named coordinate map is identically zero in dimension zero. -/
@[simp]
theorem hermitianCoordinateMap_zero (x : HermitianCoordinateSpace 0) :
    hermitianCoordinateMap 0 x = (0 : Matrix (Fin 0) (Fin 0) ℂ) :=
  hermitianFromCoordinates_zero x.1 x.2

end RandomMatrix

namespace HermitianRandomMatrix

/-- Bundle entrywise measurable diagonal and strict-upper coordinate
processes as a pointwise Hermitian random matrix. -/
def ofCoordinates {n : ℕ} {Ω : Type uΩ} [MeasurableSpace Ω]
    (d : Ω → Fin n → ℝ) (u : Ω → StrictUpperIndex n → ℂ)
    (hd : ∀ i, Measurable fun ω ↦ d ω i)
    (hu : ∀ ij, Measurable fun ω ↦ u ω ij) :
    HermitianRandomMatrix Ω (Fin n) where
  toRandomMatrix := fun ω ↦ RandomMatrix.hermitianFromCoordinates (d ω) (u ω)
  measurable_toRandomMatrix := RandomMatrix.measurable_hermitianFromCoordinates hd hu
  isHermitian := fun ω ↦ RandomMatrix.hermitianFromCoordinates_isHermitian (d ω) (u ω)

/-- Applying the bundled constructor exposes the underlying coordinate
assembly map. -/
@[simp]
theorem ofCoordinates_apply {n : ℕ} {Ω : Type uΩ} [MeasurableSpace Ω]
    (d : Ω → Fin n → ℝ) (u : Ω → StrictUpperIndex n → ℂ)
    (hd : ∀ i, Measurable fun ω ↦ d ω i)
    (hu : ∀ ij, Measurable fun ω ↦ u ω ij) (ω : Ω) :
    ofCoordinates d u hd hu ω =
      RandomMatrix.hermitianFromCoordinates (d ω) (u ω) :=
  rfl

end HermitianRandomMatrix

end NonlinearDynamics.Random
