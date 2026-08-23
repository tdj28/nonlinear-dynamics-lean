import NonlinearDynamics.QuantumChaos.SpectralStatistics
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleSpectrum

/-!
# Finite GUE laws of raw spacing measures

This module connects the validated deterministic raw-spacing observable to the
project's existing finite Gaussian unitary ensemble (GUE) law. Pushing the
intrinsic GUE probability law through `empiricalRawSpacingMeasure` gives a
probability law whose outcomes are whole measures on the real line.

The outer law is a probability measure in every dimension. Its inner outcome
is the zero measure in dimensions zero and one, so both boundary laws are
Dirac masses at that zero measure. From dimension two onward, the same random
outcome is also bundled as a genuine `ProbabilityMeasure ℝ`; forgetting that
inner wrapper recovers the raw measure-valued law.

No ensemble is redefined here. No zero spacing is removed, and no unfolding,
unit-mean rescaling, moment, density, repulsion, universality, asymptotic, or
quantum-chaos claim is introduced.
-/

open MeasureTheory

namespace NonlinearDynamics.QuantumChaos.GUE

noncomputable section

/-- The finite GUE law of the zero-aware empirical raw-spacing measure. -/
noncomputable def empiricalRawSpacingLaw (n : ℕ) :
    Measure (Measure ℝ) :=
  (Random.GUE.intrinsicLaw n).map empiricalRawSpacingMeasure

/-- The outer raw-spacing law is a probability measure in every dimension,
including the two dimensions whose inner outcome is the zero measure. -/
instance instIsProbabilityMeasureEmpiricalRawSpacingLaw (n : ℕ) :
    IsProbabilityMeasure (empiricalRawSpacingLaw n) := by
  unfold empiricalRawSpacingLaw
  exact Measure.isProbabilityMeasure_map
    measurable_empiricalRawSpacingMeasure.aemeasurable

/-- The finite GUE raw-spacing law bundled as a probability measure on the
space of measures on the real line. -/
noncomputable def empiricalRawSpacingLawProbability (n : ℕ) :
    ProbabilityMeasure (Measure ℝ) :=
  ⟨empiricalRawSpacingLaw n, inferInstance⟩

/-- In dimension zero, the raw-spacing law is concentrated at the zero
measure. The outer law still has total mass one. -/
@[simp] theorem empiricalRawSpacingLaw_zero :
    empiricalRawSpacingLaw 0 = Measure.dirac (0 : Measure ℝ) := by
  rw [empiricalRawSpacingLaw, Random.GUE.intrinsicLaw_zero]
  rw [Measure.map_dirac' measurable_empiricalRawSpacingMeasure]
  simp

/-- In dimension one, every Hamiltonian has no adjacent gap slot, so the
raw-spacing law is again concentrated at the zero measure. -/
@[simp] theorem empiricalRawSpacingLaw_one :
    empiricalRawSpacingLaw 1 = Measure.dirac (0 : Measure ℝ) := by
  rw [empiricalRawSpacingLaw]
  calc
    (Random.GUE.intrinsicLaw 1).map (@empiricalRawSpacingMeasure 1) =
        (Random.GUE.intrinsicLaw 1).map
          (fun _ => (0 : Measure ℝ)) := by
      apply Measure.map_congr
      exact Filter.Eventually.of_forall empiricalRawSpacingMeasure_one
    _ = Measure.dirac (0 : Measure ℝ) := by simp

/-- From dimension two onward, finite GUE induces a probability law whose
outcomes are bundled empirical raw-spacing probability measures. -/
noncomputable def empiricalRawSpacingProbabilityLaw (n : ℕ) :
    ProbabilityMeasure (ProbabilityMeasure ℝ) :=
  ⟨(Random.GUE.intrinsicLaw (n + 2)).map
      (empiricalRawSpacingProbability n),
    Measure.isProbabilityMeasure_map
      (measurable_empiricalRawSpacingProbability n).aemeasurable⟩

/-- Forgetting the positive-gap-count probability wrapper recovers the raw
measure-valued GUE spacing law. -/
theorem map_empiricalRawSpacingProbabilityLaw_coe (n : ℕ) :
    ((empiricalRawSpacingProbabilityLaw n :
      ProbabilityMeasure (ProbabilityMeasure ℝ)) :
      Measure (ProbabilityMeasure ℝ)).map
        (fun μ : ProbabilityMeasure ℝ => (μ : Measure ℝ)) =
      empiricalRawSpacingLaw (n + 2) := by
  rw [empiricalRawSpacingProbabilityLaw, empiricalRawSpacingLaw]
  change ((Random.GUE.intrinsicLaw (n + 2)).map
      (empiricalRawSpacingProbability n)).map
        (fun μ : ProbabilityMeasure ℝ => (μ : Measure ℝ)) =
    (Random.GUE.intrinsicLaw (n + 2)).map empiricalRawSpacingMeasure
  have hcoe : Measurable
      (fun μ : ProbabilityMeasure ℝ => (μ : Measure ℝ)) :=
    measurable_subtype_coe
  rw [Measure.map_map hcoe (measurable_empiricalRawSpacingProbability n)]
  rfl

#print axioms instIsProbabilityMeasureEmpiricalRawSpacingLaw
#print axioms empiricalRawSpacingLaw_zero
#print axioms empiricalRawSpacingLaw_one
#print axioms map_empiricalRawSpacingProbabilityLaw_coe

end

end NonlinearDynamics.QuantumChaos.GUE
