---
title: "From Random Matrices to Laws"
slug: "from-random-matrices-to-laws"
date: 2026-07-20
weight: 50
author: "tdj28"
summary: "A declaration-by-declaration climb from measurable matrix-valued maps to pushforward laws, congruence actions, probability preservation, and the exact statement of unitary invariance."
lead: |
  A realized matrix tells us what happened once. A probability law tells us how all possible realized matrices are distributed. This module crosses that bridge with pushforward measures, then states unitary invariance at the only level where an ensemble symmetry belongs: equality of laws.
key_result: |
  The law of a measurable random matrix is its pushforward measure. Measurable transformations compose at the level of laws, probability mass stays normalized, and a Dirac input gives a Dirac output. The module then defines unitary-conjugation invariance as equality of measures, while proving no Gaussian ensemble and making no GUE claim.
draft: true
pro_reviewed: false
status: "Pending human editorial and technical review"
level: "Beginner to research frontier"
reading_time: "50 to 70 minutes"
prerequisites:
  - "Functions, inverse images, and finite matrices"
  - "Basic measurable-space vocabulary; pushforwards are developed from first principles"
  - "The earlier Hermitian notebook is helpful but not required"
lean_module: "NonlinearDynamics.Random.RandomMatrices.Laws"
lean_source: "formalization/NonlinearDynamics/Random/RandomMatrices/Laws.lean"
tags:
  - "Lean 4"
  - "Random matrices"
  - "Probability laws"
  - "Pushforward measures"
  - "Unitary invariance"
og_image: "random-matrix-laws-card.png"
og_image_alt: "Warm-paper teaching card showing a sample-space measure transported through a measurable random matrix into a matrix law, with unitary conjugation posed as equality of laws rather than pointwise equality."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The human author
has not yet inspected and accepted the exposition, source interpretations,
equations, exercises, references, or social card. The canonical author
disclosure is therefore intentionally pending. Scientific-integrity and
zero-context reader reviews are also pending, so this page must remain a draft.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** `RandomMatrices.Laws` adds the distributional layer above the
project's matrix-valued maps. It defines deterministic matrix congruence,
proves its measurability and algebraic laws, defines the pushforward law of a
measurable random matrix, and exposes the preimage, composition, probability,
and Dirac identities that make the definition useful.

The module then imports Mathlib's finite unitary group and defines invariance
under unitary conjugation as equality of pushforward measures. Bundled
Hermitian random matrices inherit a law automatically, and their existing
`conjugateBy` construction is connected to the corresponding transformed law.

**Takeaway.** Pointwise Hermiticity, preservation of Hermiticity by
congruence, and invariance in law are different statements. This file makes
all three available without asserting that any Gaussian ensemble has been
constructed.
{{< /panel >}}

This entry is the code companion to
`formalization/NonlinearDynamics/Random/RandomMatrices/Laws.lean`. Every named
declaration in that file appears below with its exact statement or complete
definition. The Lean source is the build authority.

The wider ascent begins in
[Random Matrices: From Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}}).
The three preceding code companions cover
[matrix measurability]({{< relref "/development-notebook/2026/07/random-matrices-as-measurable-maps" >}}),
[Hermitian structure]({{< relref "/development-notebook/2026/07/hermitian-random-matrices" >}}),
and [trace-power observables]({{< relref "/development-notebook/2026/07/trace-power-observables" >}}).

## Choose your route

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [Four objects, four jobs](#four-objects-four-jobs) | Separate an outcome, realization, random matrix, and law |
| Probability route | [Pushforwards and preimages](#pushforwards-move-mass-forward-by-pulling-sets-back) | Read the defining equation of a law |
| Lean route | [The explicit law interface](#the-explicit-law-interface) | Understand every proof argument and declaration |
| Linear algebra route | [Congruence](#the-deterministic-action-congruence) | See why \(AHA^*\) composes and preserves Hermiticity |
| Symmetry route | [Unitary invariance](#unitary-invariance-lives-at-the-level-of-measures) | Distinguish equality in law from pointwise equality |
| Research route | [The GUE boundary](#the-frontier-what-remains-before-gue) | Identify every missing ensemble ingredient |

### Learning objectives

By the summit, a reader should be able to:

1. define a {{< refterm "pushforward-measure" "pushforward measure" >}} using inverse images;
2. explain why `RandomMatrix.law` asks for a measurability proof explicitly;
3. derive the law of a measurable composite in either order;
4. explain why a probability measure remains a probability measure after pushforward;
5. use a Dirac law as a deterministic sanity check;
6. distinguish congruence from unitary similarity and from invariance in law;
7. read `Matrix.unitaryGroup ι ℂ` as certified unitary matrices;
8. state exactly what `HasUnitaryConjugationInvariantLaw` means; and
9. list the missing ingredients before the project can claim GUE.

## The ascent in one picture

{{< mermaid >}}
flowchart LR
  A[Sample measure mu on Omega] --> B[Measurable matrix map X]
  B --> C[Matrix law: map X mu]
  C --> D[Map congruence A]
  D --> E[Law of A X A*]
  F[Hermitian at every sample] --> G[Congruence remains Hermitian]
  H[Unitary U] --> D
  C --> I{Same measure after every U?}
  E --> I
  I --> J[Unitary-conjugation-invariant law]
  K[Gaussian coordinates and normalization] -. future .-> L[GUE law]
  J -. required property .-> L
{{< /mermaid >}}

<p class="figure-note"><strong>Reading the map.</strong> The upper path transports probability: a measurable sample map pushes a source measure onto matrix space, and a measurable congruence pushes that law again. The lower path is algebraic: congruence preserves Hermiticity sample by sample. The equality test compares measures, not individual matrices. Gaussian coordinates, independence, and normalization are future work, so the GUE node is deliberately outside the checked path.</p>

## Four objects, four jobs

For this introductory probability picture, let
\((\Omega,\mathcal F,\mu)\) be a probability space and let

\[
X:\Omega\longrightarrow \mathbb C^{\iota\times\iota}.
\]

| Object | Question | Matrix interpretation |
|---|---|---|
| Outcome \(\omega\) | Which source point occurred? | One hidden state of the experiment |
| Realization \(X(\omega)\) | Which value did it produce? | One ordinary complex matrix |
| Matrix-valued map \(X\) | How does each outcome produce a matrix? | The sample-level mechanism |
| {{< refterm "probability-law" "Law" >}} \(\mathcal L_\mu(X)\) | How is mass distributed across values? | A measure on matrix space |

The law forgets the names of source outcomes. It retains every probability
question asked through the matrix value. Two maps can live on different sample
spaces, disagree pointwise wherever a comparison makes sense, and still have
the same law.

This is why ensemble symmetry cannot normally mean

\[
UX(\omega)U^*=X(\omega)
\quad\text{for every }\omega.
\]

That would require each realized matrix to be fixed. The distributional
statement asks whether transforming all realizations redistributes probability
mass.

## Pushforwards move mass forward by pulling sets back

For measurable \(f:S\to T\) and a measure \(\mu\) on \(S\), the pushforward is

\[
(f_*\mu)(B)=\mu\bigl(f^{-1}(B)\bigr)
\]

for every measurable \(B\subseteq T\). Points move forward through \(f\), but
sets move backward through \(f^{-1}\). Measures consume sets, so the mass
arriving in \(B\) is found by measuring all source points that land in \(B\).

For a measurable random matrix \(X\),

\[
\mathcal L_\mu(X)=X_*\mu,
\qquad
\mathcal L_\mu(X)(B)=\mu\{\omega:X(\omega)\in B\}.
\]

The Knowledge Base pages on
{{< refterm "pushforward-measure" "pushforwards" >}} and
{{< refterm "probability-law" "probability laws" >}} develop this picture
independently of Lean.

{{< checkpoint stage="Base camp" title="Follow points and sets in opposite directions" >}}
Pick a target event \(B\) in matrix space. Pull it back to \(X^{-1}(B)\), then
apply \(\mu\). If that sequence is clear, `law_apply` will read like the
definition rather than a technical lemma.
{{< /checkpoint >}}

## Lineage, contribution, and non-claims

Measure-theoretic probability defines the distribution of a random element as
a pushforward. Kallenberg gives the general framework
([Kallenberg, 2021](#ref-kallenberg)). Mathlib supplies `Measure.map`, its
evaluation and composition theorems, Dirac measures, the probability-measure
typeclass, and a finite matrix unitary group
([Mathlib pushforward API](#ref-mathlib-map);
[Mathlib unitary-group API](#ref-mathlib-unitary)).

Random-matrix references formulate ensembles as measures on matrix spaces and
treat conjugation invariance as a symmetry of those measures
([Anderson, Guionnet, and Zeitouni, 2010](#ref-agz)).

This module contributes a measurable congruence action, a law constructor with
visible measurability evidence, project-level pushforward identities, a
measure-level unitary-invariance predicate, and a bridge from bundled
Hermitian matrices to equality in law.

It does not define Gaussian variables, independence, covariance, density,
dimension scaling, GUE, expected moments, eigenvalue laws, or asymptotics.

## Open the module

```lean
import Mathlib.LinearAlgebra.UnitaryGroup
import Mathlib.MeasureTheory.Measure.Dirac
import Mathlib.MeasureTheory.Measure.Typeclasses.Probability
import NonlinearDynamics.Random.RandomMatrices.Hermitian
```

The imports supply certified unitary matrices, point-mass measures,
`IsProbabilityMeasure`, and the project's measurable Hermitian API. The local
context is:

```lean
open Matrix MeasureTheory
open scoped Matrix

universe uΩ uι

namespace NonlinearDynamics.Random

namespace RandomMatrix

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
```

The notation `Aᴴ` means conjugate transpose.

## The deterministic action: congruence

For a fixed square matrix \(A\), define \(C_A(H)=AHA^*\).

### `RandomMatrix.congruence`

```lean
/-- The deterministic congruence map `H ↦ A * H * Aᴴ` on square complex
matrices. No invertibility or unitarity assumption is needed for this map. -/
def congruence [Fintype ι] (A : Matrix ι ι ℂ) : Matrix ι ι ℂ → Matrix ι ι ℂ :=
  fun H ↦ A * H * Aᴴ
```

For arbitrary \(A\), this is congruence, not similarity. Similarity uses
\(A^{-1}\). If \(A\) is unitary, \(A^*=A^{-1}\), and the same formula becomes
unitary conjugation.

### `RandomMatrix.measurable_congruence`

```lean
/-- Congruence by a fixed finite matrix is measurable for the entrywise
measurable space on matrices. -/
theorem measurable_congruence [Fintype ι] (A : Matrix ι ι ℂ) :
    Measurable (congruence A) := by
  exact measurable_mul
    (measurable_mul
      (measurable_const (A := A)) measurable_id)
    (measurable_const (A := Aᴴ))
```

The variable \(H\) is observed by `measurable_id`. Fixed \(A\) and \(A^*\) are
measurable constants. Finite matrix multiplication builds \(H\mapsto AH\) and
then \(H\mapsto AHA^*\). Finiteness enters through the finite sums in matrix
multiplication.

### The identity, zero, and composition laws

```lean
/-- Congruence by the identity matrix is the identity action. -/
@[simp]
theorem congruence_one [Fintype ι] [DecidableEq ι] (H : Matrix ι ι ℂ) :
    congruence (1 : Matrix ι ι ℂ) H = H := by
  simp [congruence]

/-- Congruence sends the zero matrix to the zero matrix. -/
@[simp]
theorem congruence_zero [Fintype ι] (A : Matrix ι ι ℂ) :
    congruence A (0 : Matrix ι ι ℂ) = 0 := by
  simp [congruence]

/-- Congruence by a product is the composite of the two congruence maps. -/
theorem congruence_mul [Fintype ι] (A B H : Matrix ι ι ℂ) :
    congruence (A * B) H = congruence A (congruence B H) := by
  simp only [congruence, Matrix.conjTranspose_mul]
  simp only [Matrix.mul_assoc]
```

The third theorem encodes

\[
C_{AB}(H)=(AB)H(AB)^*=A(BHB^*)A^*=C_A(C_B(H)).
\]

The order matters: \(C_B\) acts first. `Matrix.conjTranspose_mul` reverses the
factors under conjugate transpose.

### `RandomMatrix.congruence_isHermitian`

```lean
/-- Congruence preserves Hermiticity, without any invertibility assumption on
the fixed matrix. -/
theorem congruence_isHermitian [Fintype ι] (A : Matrix ι ι ℂ)
    {H : Matrix ι ι ℂ} (hH : H.IsHermitian) : (congruence A H).IsHermitian :=
  Matrix.isHermitian_mul_mul_conjTranspose A hH
```

If \(H^*=H\), then \((AHA^*)^*=AH^*A^*=AHA^*\). This is sample-level algebra.
It says nothing about the probabilities of different Hermitian matrices.

### `RandomMatrix.map_congruence_one`

```lean
/-- Pushing a measure forward by identity congruence leaves it unchanged. -/
@[simp]
theorem map_congruence_one [Fintype ι] [DecidableEq ι]
    (ν : Measure (Matrix ι ι ℂ)) :
    Measure.map (congruence (1 : Matrix ι ι ℂ)) ν = ν := by
  convert Measure.map_id using 2
  funext H
  exact congruence_one H
```

`Measure.map_id` handles the identity function. `funext` proves that identity
congruence is that function.

{{< checkpoint stage="Camp I" title="Separate algebra from probability" >}}
`congruence_isHermitian` concludes a matrix property.
`map_congruence_one` concludes equality of measures. Keep the output types
visible before reading the law API.
{{< /checkpoint >}}

## The explicit law interface

### `RandomMatrix.law`

```lean
/-- The pushforward law of a measurable matrix-valued map.

The measurability proof is deliberately an explicit argument even though the
value of `Measure.map` itself does not store that proof. It supports the
standard pushforward evaluation and composition theorems below.
-/
noncomputable def law (X : RandomMatrix Ω ι ι ℂ) (_hX : Measurable X)
    (μ : Measure Ω) : Measure (Matrix ι ι ℂ) :=
  Measure.map X μ
```

The proof argument `_hX` does not occur in the right-hand side. It guards the
public interface. Mathlib makes `Measure.map X μ` total: if \(X\) is not
almost-everywhere measurable with respect to \(\mu\), the result is defined to
be the zero measure ([Mathlib pushforward API](#ref-mathlib-map)). A bare map
expression can therefore typecheck without denoting the intended law.

The project asks for the stronger measure-independent proof `Measurable X`.
That proof supports every later measure, the standard measurable-set formula,
and clean composition. A future API could instead be based on
`AEMeasurable X μ`, but this module is not.

`noncomputable` says that Lean does not promise an executable algorithm for a
general measure. It does not weaken the mathematical definition.

### `RandomMatrix.law_apply`

```lean
/-- A matrix law evaluates a measurable set by taking its preimage under the
random matrix. -/
theorem law_apply (X : RandomMatrix Ω ι ι ℂ) (hX : Measurable X)
    (μ : Measure Ω) {s : Set (Matrix ι ι ℂ)} (hs : MeasurableSet s) :
    law X hX μ s = μ (X ⁻¹' s) := by
  exact Measure.map_apply hX hs
```

This is the defining equation

\[
\mathcal L_\mu(X)(s)=\mu(X^{-1}(s)).
\]

`hX` certifies the matrix map. `hs` certifies the target event. The theorem
does not prove that any particular eigenvalue, norm, or spectral event is
measurable. Those events need their own proofs.

### `RandomMatrix.law_comp`

```lean
/-- The law of a measurable composite is the pushforward of the original law. -/
theorem law_comp {X : RandomMatrix Ω ι ι ℂ} (hX : Measurable X)
    {f : Matrix ι ι ℂ → Matrix ι ι ℂ} (hf : Measurable f) (μ : Measure Ω) :
    law (f ∘ X) (hf.comp hX) μ = Measure.map f (law X hX μ) := by
  exact (Measure.map_map hf hX).symm
```

There are two routes:

\[
\mathcal L_\mu(f\circ X)=f_*\mathcal L_\mu(X).
\]

One transforms each sample and then takes its law. The other takes the matrix
law first and pushes it through \(f\). Mathlib's theorem is oriented in the
opposite equality direction, so the proof uses `.symm`.

This project theorem is specialized to matrix endomorphisms. It supports
congruence directly. It does not directly produce the scalar law of trace or
`tracePower`, whose codomain is \(\mathbb C\). Mathlib's general `map_map` is
the template for a future codomain-general theorem.

### Probability preservation and the Dirac check

```lean
/-- A probability measure on the sample space induces a probability law. -/
theorem law_isProbabilityMeasure (X : RandomMatrix Ω ι ι ℂ) (hX : Measurable X)
    (μ : Measure Ω) [IsProbabilityMeasure μ] : IsProbabilityMeasure (law X hX μ) :=
  Measure.isProbabilityMeasure_map hX.aemeasurable

/-- Under a Dirac measure on the sample space, the law is the Dirac measure at
the realized matrix. -/
theorem law_dirac (X : RandomMatrix Ω ι ι ℂ) (hX : Measurable X) (ω : Ω) :
    law X hX (Measure.dirac ω) = Measure.dirac (X ω) := by
  exact Measure.map_dirac' hX ω
```

A probability measure has total mass one. Pushforward preserves that total
because the preimage of the whole matrix space is all of \(\Omega\). Mathlib
needs only almost-everywhere measurability here, obtained from
`hX.aemeasurable`. This does not imply integrability of a future observable.

A Dirac measure concentrates all mass at one point. The identity

\[
X_*\delta_\omega=\delta_{X(\omega)}
\]

reduces a law statement to ordinary evaluation. It is the deterministic sanity
check for later transformations.

{{< checkpoint stage="Camp II" title="Run a law through three tests" >}}
What mass does it assign to a measurable event? How does it behave under
composition? What happens under a Dirac source? Here the answers are
`law_apply`, `law_comp`, and `law_dirac`.
{{< /checkpoint >}}

## Unitary invariance lives at the level of measures

### Mathlib's unitary group

For finite \(\iota\), an element

```lean
variable [Fintype ι] [DecidableEq ι]
variable (U : Matrix.unitaryGroup ι ℂ)
```

is a matrix packaged with the equations \(UU^*=I\) and \(U^*U=I\). Mathlib
gives these values a group structure and a coercion to `Matrix ι ι ℂ`
([Mathlib unitary-group API](#ref-mathlib-unitary)). Thus

```lean
#check (U : Matrix ι ι ℂ)
```

uses the underlying matrix while `U` still carries its certificate.

For unitary \(U\), \(U^*=U^{-1}\), so \(H\mapsto UHU^*\) is both congruence and
similarity. It preserves each realization's spectrum. This Laws module does
not invoke the spectral theorem.

### `RandomMatrix.IsUnitaryConjugationInvariant`

```lean
/-- A finite complex matrix law is invariant under unitary conjugation when
every unitary congruence pushforward leaves it unchanged. -/
def IsUnitaryConjugationInvariant [Fintype ι] [DecidableEq ι]
    (ν : Measure (Matrix ι ι ℂ)) : Prop :=
  ∀ U : Matrix.unitaryGroup ι ℂ,
    Measure.map (congruence (U : Matrix ι ι ℂ)) ν = ν
```

In symbols,

\[
(C_U)_*\nu=\nu
\qquad\text{for every unitary }U.
\]

This compares measures. Equivalently, every measurable matrix event gets the
same mass before and after unitary conjugation. It does not say \(UHU^*=H\)
for each matrix or sample.

The predicate accepts any measure, not only a probability measure.
Normalization remains a separate property.

### The two invariant sanity checks

```lean
/-- The zero measure is invariant under unitary conjugation. -/
theorem isUnitaryConjugationInvariant_zero [Fintype ι] [DecidableEq ι] :
    IsUnitaryConjugationInvariant (0 : Measure (Matrix ι ι ℂ)) := by
  intro U
  simp

/-- The Dirac measure at the zero matrix is invariant under unitary
conjugation. -/
theorem isUnitaryConjugationInvariant_dirac_zero [Fintype ι] [DecidableEq ι] :
    IsUnitaryConjugationInvariant
      (Measure.dirac (0 : Matrix ι ι ℂ)) := by
  intro U
  rw [Measure.map_dirac' (measurable_congruence (U : Matrix ι ι ℂ))]
  simp
```

The zero measure is fixed by every measurable map, but it is not a probability
law. The Dirac mass at the zero matrix is a probability law, and

\[
(C_U)_*\delta_0=\delta_{C_U(0)}=\delta_0.
\]

This example is intentionally degenerate. It tests the definition without a
Gaussian claim. A Dirac law at a generic nonzero Hermitian matrix is not fixed
by every unitary.

## Lift laws to bundled Hermitian matrices

A `HermitianRandomMatrix` stores a matrix map, global measurability, and
pointwise Hermiticity.

The source first leaves the unbundled namespace and opens the bundled one:

```lean
end RandomMatrix

namespace HermitianRandomMatrix

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
```

### The bundled law and probability theorem

```lean
/-- The law of a bundled Hermitian random matrix. Its measurability evidence is
the corresponding field of the bundle. -/
noncomputable def law (X : HermitianRandomMatrix Ω ι) (μ : Measure Ω) :
    Measure (Matrix ι ι ℂ) :=
  RandomMatrix.law X.toRandomMatrix X.measurable_toRandomMatrix μ

/-- A probability measure on the sample space gives a probability law for a
bundled Hermitian random matrix. -/
theorem law_isProbabilityMeasure (X : HermitianRandomMatrix Ω ι) (μ : Measure Ω)
    [IsProbabilityMeasure μ] : IsProbabilityMeasure (law X μ) :=
  RandomMatrix.law_isProbabilityMeasure X.toRandomMatrix
    X.measurable_toRandomMatrix μ
```

The bundle supplies `X.measurable_toRandomMatrix`, so callers do not repeat the
proof. The law still lives on the full complex matrix space. Although every
realization is Hermitian, this file proves no full-measure support theorem for
the Hermitian subset.

### `HermitianRandomMatrix.law_conjugateBy`

```lean
/-- The law of `A X Aᴴ` is the congruence pushforward of the law of `X`. -/
theorem law_conjugateBy [Fintype ι] (A : Matrix ι ι ℂ)
    (X : HermitianRandomMatrix Ω ι) (μ : Measure Ω) :
    law (X.conjugateBy A) μ =
      Measure.map (RandomMatrix.congruence A) (law X μ) := by
  exact RandomMatrix.law_comp X.measurable_toRandomMatrix
    (RandomMatrix.measurable_congruence A) μ
```

Sample by sample, `X.conjugateBy A` is \(\omega\mapsto AX(\omega)A^*\). The
theorem says

\[
\mathcal L_\mu(AXA^*)=(C_A)_*\mathcal L_\mu(X).
\]

This identifies the transformed law. It does not claim invariance. The matrix
\(A\) need not be unitary, while the result remains pointwise Hermitian because
congruence preserves Hermiticity.

### The bundled invariance predicate and its equality-in-law form

```lean
/-- A bundled Hermitian random matrix has a unitary-conjugation-invariant law
under `μ` when its pushforward law has that measure-level property. -/
def HasUnitaryConjugationInvariantLaw [Fintype ι] [DecidableEq ι]
    (X : HermitianRandomMatrix Ω ι) (μ : Measure Ω) : Prop :=
  RandomMatrix.IsUnitaryConjugationInvariant (law X μ)

/-- Invariance of the law is equivalent to equality in law after conjugation
by every element of `Matrix.unitaryGroup`. -/
theorem hasUnitaryConjugationInvariantLaw_iff [Fintype ι] [DecidableEq ι]
    (X : HermitianRandomMatrix Ω ι) (μ : Measure Ω) :
    HasUnitaryConjugationInvariantLaw X μ ↔
      ∀ U : Matrix.unitaryGroup ι ℂ,
        law (X.conjugateBy (U : Matrix ι ι ℂ)) μ = law X μ := by
  simp only [HasUnitaryConjugationInvariantLaw,
    RandomMatrix.IsUnitaryConjugationInvariant, law_conjugateBy]
```

When \(\mu\) is a probability measure, the right side is equality in
distribution:

\[
UXU^*\mathrel{\overset{d}{=}}X
\qquad\text{for every unitary }U.
\]

Equality in distribution means equality of pushforward probability measures.
For an arbitrary measure \(\mu\), the checked theorem still states equality of
pushforward measures, but probability terminology is not implied. The original
and transformed maps share a sample space here, yet the theorem does not
assert pointwise equality. The proof unfolds the definitions and rewrites the
transformed law with `law_conjugateBy`.

## The four symmetry levels

| Level | Exact content | Status |
|---|---|---|
| Pointwise Hermiticity | \(X(\omega)^*=X(\omega)\) for every outcome | Stored by `HermitianRandomMatrix` |
| Congruence preservation | \(H^*=H\Rightarrow(AHA^*)^*=AHA^*\) | Proved for every finite \(A\) |
| Equality in law | \(\mathcal L_\mu(UXU^*)=\mathcal L_\mu(X)\) | Defined and characterized |
| GUE invariance | A normalized Gaussian Hermitian law has the equality for every unitary \(U\) | Not constructed or proved |

Unitary invariance in law does not require
\(UX(\omega)U^*=X(\omega)\). A symmetric distribution can move individual
samples around an orbit while leaving the distribution unchanged.

{{< panel "warning" >}}
**Hermitian does not imply invariant.** Hermiticity restricts which matrices
can occur. Unitary invariance restricts how probability mass is distributed
among unitary-conjugacy orbits. A generic deterministic Hermitian matrix has a
Hermitian-supported Dirac law, but unitary conjugation moves that law to a
Dirac mass at a different matrix.
{{< /panel >}}

## Declaration inventory

The file exposes twenty named declarations.

| Namespace | Declaration | Job |
|---|---|---|
| `RandomMatrix` | `congruence` | Define \(H\mapsto AHA^*\) |
| `RandomMatrix` | `measurable_congruence` | Prove fixed finite congruence measurable |
| `RandomMatrix` | `congruence_one` | Identity congruence fixes matrices |
| `RandomMatrix` | `congruence_zero` | Every congruence fixes zero |
| `RandomMatrix` | `congruence_mul` | Product congruence is composite congruence |
| `RandomMatrix` | `congruence_isHermitian` | Congruence preserves Hermiticity |
| `RandomMatrix` | `map_congruence_one` | Identity congruence fixes measures |
| `RandomMatrix` | `law` | Define the measurable matrix map's pushforward |
| `RandomMatrix` | `law_apply` | Evaluate a law through a preimage |
| `RandomMatrix` | `law_comp` | Commute law with matrix transformation |
| `RandomMatrix` | `law_isProbabilityMeasure` | Preserve probability mass |
| `RandomMatrix` | `law_dirac` | Compute a deterministic law |
| `RandomMatrix` | `IsUnitaryConjugationInvariant` | Define measure symmetry |
| `RandomMatrix` | `isUnitaryConjugationInvariant_zero` | Check the zero measure |
| `RandomMatrix` | `isUnitaryConjugationInvariant_dirac_zero` | Check the point mass at zero |
| `HermitianRandomMatrix` | `law` | Reuse bundled measurability |
| `HermitianRandomMatrix` | `law_isProbabilityMeasure` | Preserve bundled probability mass |
| `HermitianRandomMatrix` | `law_conjugateBy` | Identify the transformed law |
| `HermitianRandomMatrix` | `HasUnitaryConjugationInvariantLaw` | Attach the law-level property |
| `HermitianRandomMatrix` | `hasUnitaryConjugationInvariantLaw_iff` | Express invariance as equality in law |

## How to run the exact module

From the repository root:

```sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomMatrices/Laws.lean
```

Build the complete formalization from `formalization/`:

```sh
lake build
```

Run the combined Lean, proof-to-prose, and Hugo gate from the repository root:

```sh
make check
```

Preview drafts with `make blog-serve` at `http://127.0.0.1:1333/`. Private
tailnet preview uses `make blog-serve-tailscale`.

## Design decisions and limitations

The explicit `hX` argument prevents Mathlib's total, zero-on-non-a.e.-measurable
fallback from masquerading as a valid law. The bundled Hermitian type pays that
proof once. The congruence map exists for all finite \(A\), while invariance
restricts the actor to Mathlib's unitary group. Arbitrary measures come first;
`IsProbabilityMeasure` adds normalization as a separate property.

Important missing layers remain:

- no theorem that the bundled law gives full measure to the Hermitian subset;
- no codomain-general project theorem for scalar observable laws;
- no law constructor based only on almost-everywhere measurability;
- no general equality-in-law relation across different sample spaces;
- no Haar probability or integration on the unitary group;
- no Gaussian primitives, independence, covariance, or normalization;
- no eigenvalue measurability, spectral law, integrability, or expectation; and
- no GUE construction or GUE invariance theorem.

## The frontier: what remains before GUE

Everything in this section is a roadmap. The checked declarations above stand
on their own.

A finite GUE construction still needs an explicit dimension, a probability
space or direct matrix measure, Gaussian diagonal and off-diagonal primitives,
independence, conjugate reflection, an exact variance and dimension-scaling
convention, measurability of the assembled matrix, identification of its law,
and a proof that every unitary congruence pushforward fixes that law.

The current module supplies the language for the last steps, not their Gaussian
premises or proof. Dyson's symmetry analysis motivates the unitary class
([Dyson, 1962](#ref-dyson-1962)); modern random-matrix texts develop concrete
Gaussian laws and their normalization
([Anderson, Guionnet, and Zeitouni, 2010](#ref-agz)).

## Exercises: from preimages to ensemble design

1. **Read a law on an event.** Rewrite `law X hX μ s` as a source-space
   expression. Why does the answer use a preimage rather than an image?
2. **Run the Dirac check.** Put all source mass at \(\omega\). Where is the
   resulting matrix law concentrated?
3. **Compose congruences.** Apply \(C_B\), then \(C_A\). Use `congruence_mul`
   to identify the combined matrix and verify the order.
4. **Separate symmetry from normalization.** Explain why the invariant zero
   measure is not a probability law while \(\delta_0\) is.
5. **Separate pointwise and law equality.** Use a symmetric two-point scalar
   law under sign reversal as an analogy for unitary orbits.
6. **Break a Hermitian Dirac law.** Choose Hermitian \(H\) and unitary \(U\)
   with \(UHU^*\ne H\), then map \(\delta_H\).
7. **Generalize `law_comp`.** Give it an arbitrary target measurable space
   \(T\) and measurable \(f:\mathrm{Matrix}\to T\).
8. **Design Hermitian support.** State that the bundled law gives full mass to
   Hermitian matrices and identify the target-set measurability obligation.
9. **Design the GUE endpoint.** Write a normalization ledger and the exact
   `HasUnitaryConjugationInvariantLaw` goal the ensemble should satisfy.

## Summit register

A measurable matrix map pushes a source measure onto matrix space. Measurable
matrix transformations compose with that pushforward, probability mass remains
one, and Dirac inputs behave like deterministic evaluation. Congruence supplies
the algebraic action and preserves Hermiticity.

Restricting the actor to Mathlib's unitary group lets the module define
unitary-conjugation invariance as equality of measures. The bundled iff theorem
translates it into equality in law between \(X\) and \(UXU^*\). This is the
correct launchpad for GUE, not a GUE result.

## References

The software references were checked against the project's Mathlib 4.32.0 pin
and official generated documentation on 2026-07-20. Book and journal links
point to publisher or DOI records.

<a id="ref-mathlib-release"></a>
**Mathlib contributors.**
[Mathlib 4.32.0 release](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
commit `81a5d257c8e410db227a6665ed08f64fea08e997`.

<a id="ref-mathlib-map"></a>
**Mathlib contributors.**
[Pushforward of a measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
with [pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/Map.lean).
This is the official source for `Measure.map`, its non-a.e.-measurable
fallback, `map_apply`, `map_id`, and `map_map`.

<a id="ref-mathlib-dirac"></a>
**Mathlib contributors.**
[Dirac measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Dirac.html),
with [pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/Dirac.lean).
This documents `Measure.dirac` and `Measure.map_dirac'`.

<a id="ref-mathlib-probability"></a>
**Mathlib contributors.**
[Probability-measure typeclasses](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Typeclasses/Probability.html),
with [pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/Typeclasses/Probability.lean).
This documents `IsProbabilityMeasure` and
`Measure.isProbabilityMeasure_map`.

<a id="ref-mathlib-unitary"></a>
**Mathlib contributors.**
[The finite matrix unitary group](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/UnitaryGroup.html),
with [pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/LinearAlgebra/UnitaryGroup.lean).
This is the official source for `Matrix.unitaryGroup`, its equations, group
structure, and coercion to matrices.

<a id="ref-kallenberg"></a>
**Olav Kallenberg.**
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1),
third edition, Springer, 2021. This is a standard source for measurable random
elements, image measures, and equality in distribution.

<a id="ref-agz"></a>
**Greg W. Anderson, Alice Guionnet, and Ofer Zeitouni.**
[An Introduction to Random Matrices](https://doi.org/10.1017/CBO9780511801334),
Cambridge University Press, 2010. This develops Gaussian ensembles, invariant
matrix laws, and their normalization choices.

<a id="ref-dyson-1962"></a>
**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems. I](https://doi.org/10.1063/1.1703773),
`Journal of Mathematical Physics` 3, 140–156, 1962. This primary historical
source organizes spectral statistics by orthogonal, unitary, and symplectic
symmetry classes. It does not warrant a claim that this module constructed GUE.
