---
title: "When Randomness Becomes a Matrix"
slug: "random-matrices-as-measurable-maps"
date: 2026-07-20
weight: 70
author: "tdj28"
summary: "The first substantive Lean module turns matrix-valued maps into measurable objects one coordinate at a time, then builds the operations needed for Hermitian random matrices."
lead: |
  A random matrix is not an array with the word random attached. It is a measurable function from outcomes to matrices. Our first Lean module makes that sentence precise, then proves that transpose, conjugation, addition, multiplication, and Hermitian symmetrization preserve the structure we need.
key_result: |
  Matrix measurability is reduced to scalar measurability: a matrix-valued map is measurable exactly when every entry is measurable. That interface makes all later closure proofs coordinatewise and prepares one shared foundation for GUE, random Jacobians, and matrix cocycles.
draft: false
pro_reviewed: false
status: "Pending human editorial and technical review"
level: "Beginner to advanced"
reading_time: "30 to 45 minutes"
prerequisites: "Functions and matrices; no prior Lean or measure theory required"
lean_module: "NonlinearDynamics.Random.RandomMatrices.Basic"
lean_source: "formalization/NonlinearDynamics/Random/RandomMatrices/Basic.lean"
tags: ["random matrices", "measure theory", "Lean", "Hermitian matrices"]
og_image: "random-matrix-measurability-card.png"
og_image_alt: "An outcome omega flows into a three-by-three matrix whose highlighted coordinates certify matrix measurability."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The canonical
author disclosure is intentionally pending until the human author has
inspected the prose, cited sources, equations, and Lean artifact. This page is
published as an open working note while that review remains pending.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** This note introduces the first substantive module in the
formalization. The module defines the carrier type of a matrix-valued map,
constructs an entrywise measurable structure on matrix spaces, and proves an
if-and-only-if coordinate criterion.

It then establishes measurable transpose, entrywise scalar maps, constant
matrices, conjugate transpose, addition, finite multiplication, and Hermitian
symmetrization. The last construction is Hermitian at every sample and hence
almost surely for every measure.

**Takeaway.** Algebraic structure, measurability, and probability law are kept
separate. That separation is the main architectural result, not incidental
bookkeeping.
{{< /panel >}}

The source for this entry is
`formalization/NonlinearDynamics/Random/RandomMatrices/Basic.lean`. Every code
block below is either copied from that module or marked as explanatory
mathematics.

For the broader mathematical climb, read
[Random Matrices: From Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}}).

## What we are trying to make legal

Eventually we want to say things such as:

- a finite matrix has Gaussian-distributed primitive coordinates;
- the resulting matrix is Hermitian;
- its law is invariant under unitary conjugation;
- traces of powers are random variables whose expectations can be computed;
- a random Jacobian contracts or expands perturbations; and
- long products of random matrices have asymptotic growth rates.

Every sentence on that list presupposes a measurable matrix-valued object.
Without measurability, a probability measure cannot even assign probabilities
to matrix events. The first module therefore does not begin with eigenvalues or
Gaussian densities. It begins by making matrix observation precise.

## Prior work, contribution, and non-claims

### Lineage

Measure-theoretic probability treats a random element as a measurable map into
a measurable target space. Kallenberg gives the standard general framework
([Kallenberg, 2021](#ref-kallenberg)). Mathlib supplies measurable spaces,
function-space constructions, complex Borel measurability, and algebraic matrix
operations. Random-matrix texts such as Anderson, Guionnet, and Zeitouni begin
from finite matrix ensembles and develop their spectral theory
([Anderson, Guionnet, and Zeitouni, 2010](#ref-agz)).

### What this module contributes to the project

- A project-level `RandomMatrix` carrier that can be reused across probability
  measures and dynamical settings.
- An entrywise matrix measurable structure, pinned to the current Mathlib API.
- A coordinate theorem that turns matrix measurability into scalar proof goals.
- Closure lemmas for the concrete operations the next ensemble modules need.
- An unnormalized Hermitian symmetrization with pointwise and almost-sure
  guarantees.

### Not claimed

- `RandomMatrix` by itself does not certify measurability.
- No probability law, Gaussian variable, independence assumption, or ensemble
  is defined here.
- Hermitian symmetrization does not by itself construct GUE.
- No spectral law, stability theorem, or statement about physical quantum chaos
  appears in this module.

## The conceptual pipeline

{{< mermaid >}}
flowchart TD
  A[Scalar measurable spaces] --> B[Entrywise matrix measurable space]
  B --> C[Measurable iff every entry is measurable]
  C --> D[Transpose and scalar maps]
  C --> E[Addition and finite multiplication]
  D --> F[Conjugate transpose]
  E --> G[Hermitian symmetrization]
  F --> G
  G --> H[Hermitian for every outcome]
  H --> I[Hermitian almost everywhere]
{{< /mermaid >}}

<p class="figure-note"><strong>Dependency map.</strong> The entrywise measurable structure supplies the coordinate theorem. Every later measurability proof reduces to scalar coordinates. Hermitian symmetrization combines measurable addition and conjugate transpose, while its symmetry proof is algebraic. The final almost-everywhere theorem is weaker than the pointwise result and follows immediately from it.</p>

## Step 1: separate the sample space from the matrix space

Let \(\Omega\) be a type of outcomes, \(\iota\) a row-index
type, \(\kappa\) a column-index type, and \(\mathbb K\) a scalar
type. The module begins with:

```lean
abbrev RandomMatrix
    (Ω : Type uΩ) (ι : Type uι) (κ : Type uκ) (𝕜 : Type u𝕜) :=
  Ω → Matrix ι κ 𝕜
```

At the type level, this says only:

\[
X : \Omega \longrightarrow \mathbb K^{\iota\times\kappa}.
\]

Given \(\omega\in\Omega\), the value \(X(\omega)\) is one
realized matrix. Given \(i\in\iota\) and
\(j\in\kappa\), the value \(X(\omega)_{ij}\) is one scalar
entry of that realization.

{{< panel "warning" >}}
**Naming versus certification.** Standard probability terminology calls a map
a random variable or random element after measurability is established. The
project abbreviation `RandomMatrix` names the underlying carrier for
convenience. A term of that type becomes a genuine matrix-valued random
variable only when a theorem or bundled structure supplies `Measurable X`.
{{< /panel >}}

Why not store measurability inside the first definition? Keeping it separate
has three benefits.

First, the same map can be considered under different measurable structures or
measures. Second, algebraic constructors can be stated without carrying a
probability space. Third, later bundled types can choose exactly the strength
they need, such as measurable plus Hermitian everywhere, without forcing that
choice on every matrix-valued map.

## Step 2: give matrices the coordinatewise measurable structure

Mathlib's `Matrix ι κ 𝕜` is represented through two indices. The
equivalence `Matrix.of` connects matrices to functions of type
`ι → κ → 𝕜`. Function spaces already carry the product measurable
structure generated by their coordinate projections.

The project transports that structure back to matrices:

```lean
instance instMeasurableSpaceMatrix [MeasurableSpace 𝕜] :
    MeasurableSpace (Matrix ι κ 𝕜) :=
  MeasurableSpace.comap Matrix.of.symm inferInstance
```

Read this expression in four pieces:

| Lean fragment | Mathematical job |
|---|---|
| `inferInstance` | Find the product measurable structure on the curried function space |
| `Matrix.of.symm` | View a matrix as its two-index coordinate function |
| `MeasurableSpace.comap` | Pull the target structure back to the matrix type |
| `instance` | Make the result available to typeclass inference |

This instance is canonical for the project, but it is not currently supplied
by the imported Mathlib 4.32.0 modules. That is a release-specific observation,
verified against the pinned dependency source
([Mathlib 4.32.0](#ref-mathlib-release)). A future dependency upgrade must
check for an upstream instance before retaining this one.

## Step 3: prove the theorem the instance was designed to support

The mathematical criterion is:

\[
X \text{ measurable}
\quad\Longleftrightarrow\quad
\big(\omega\mapsto X(\omega)_{ij}\big)
\text{ measurable for every }i,j.
\]

Lean states it directly:

```lean
theorem measurable_iff_entries (X : RandomMatrix Ω ι κ 𝕜) :
    Measurable X ↔ ∀ i j, Measurable fun ω ↦ X ω i j := by
  rw [measurable_comap_iff]
  change Measurable (fun ω i j ↦ X ω i j) ↔ _
  simp only [measurable_pi_iff]
```

### Line 1: expose the comap

`rw [measurable_comap_iff]` rewrites measurability into the function-space
representation used to define the target measurable structure.

### Line 2: show Lean the coordinate function

The `change` command does not prove new mathematics. It replaces the current
goal with a definitionally equal form in which the outcome, row, and column
arguments are visible.

### Line 3: invoke product measurability

`measurable_pi_iff` is the general coordinate theorem for a dependent function
space. Simplification applies it across the two matrix indices.

The proof is short because the architecture did the hard work in advance. A
poorly chosen instance would leave every later theorem fighting conversions
between matrices and functions.

{{< checkpoint stage="Base camp" title="Say the contract without Lean" >}}
Before continuing, try to explain the theorem in one sentence: a matrix-valued
map is measurable exactly when every fixed coordinate is a measurable scalar
map. If that sentence is clear, the remaining closure proofs are variations on
one idea rather than fourteen unrelated tricks.
{{< /checkpoint >}}

## Step 4: package coordinate extraction

Once the equivalence is available, pulling out an entry is immediate:

```lean
theorem measurable_entry {X : RandomMatrix Ω ι κ 𝕜}
    (hX : Measurable X) (i : ι) (j : κ) :
    Measurable fun ω ↦ X ω i j :=
  (measurable_iff_entries X).mp hX i j
```

This theorem is intentionally small. It becomes the common input for every
entrywise closure proof, so downstream code does not repeatedly unpack the
if-and-only-if theorem.

## Step 5: transport the elementary operations

### Transpose

The entry \((X^\mathsf T)_{ij}\) is \(X_{ji}\). The proof swaps the
indices and reuses `measurable_entry`:

```lean
theorem measurable_transpose {X : RandomMatrix Ω ι κ 𝕜}
    (hX : Measurable X) :
    Measurable fun ω ↦ (X ω).transpose := by
  rw [measurable_iff_entries]
  exact fun i j ↦ measurable_entry hX j i
```

### Entrywise scalar maps

If \(f:\mathbb K\to\mathbb L\) is measurable, then each output entry
is the composition \(f\circ X_{ij}\):

```lean
theorem measurable_map {𝕝 : Type u𝕝} [MeasurableSpace 𝕝]
    {X : RandomMatrix Ω ι κ 𝕜} (hX : Measurable X)
    {f : 𝕜 → 𝕝} (hf : Measurable f) :
    Measurable fun ω ↦ (X ω).map f := by
  rw [measurable_iff_entries]
  exact fun i j ↦ hf.comp (measurable_entry hX i j)
```

### Constant matrices

A deterministic matrix can be regarded as a matrix-valued random variable that
ignores its outcome. Each entry is constant, so each is measurable.

This is more than a convenience. Later constructions combine fixed matrices
with random matrices, including congruence transforms and deterministic
changes of basis.

## Step 6: specialize to complex matrices

The remaining operations use the standard Borel measurable structure on
\(\mathbb C\). Mathlib supplies the needed scalar facts, including
continuity and hence measurability of complex conjugation
([Mathlib complex Borel source](#ref-mathlib-complex)).

### Conjugate transpose

The {{< refterm "conjugate-transpose" "conjugate transpose" >}} obeys

\[
(X(\omega)^*)_{ji}
=\overline{X(\omega)_{ij}}.
\]

The Lean proof makes that composition explicit:

```lean
theorem measurable_conjTranspose {X : RandomMatrix Ω ι κ ℂ}
    (hX : Measurable X) :
    Measurable fun ω ↦ (X ω)ᴴ := by
  rw [measurable_iff_entries]
  intro j i
  change Measurable (star ∘ fun ω ↦ X ω i j)
  exact continuous_star.measurable.comp (measurable_entry hX i j)
```

The proof uses three facts: indices swap, `star` is complex conjugation, and a
continuous scalar function is measurable.

### Addition

Addition is coordinatewise, so two measurable scalar entries add to a
measurable scalar entry.

### Multiplication

Matrix multiplication is the first operation that genuinely mixes
coordinates:

\[
(XY)_{ik}=\sum_j X_{ij}Y_{jk}.
\]

The Lean theorem assumes `[Fintype κ]`, making the shared index finite:

```lean
theorem measurable_mul [Fintype κ]
    {X : RandomMatrix Ω ι κ ℂ}
    {Y : RandomMatrix Ω κ ρ ℂ}
    (hX : Measurable X) (hY : Measurable Y) :
    Measurable fun ω ↦ X ω * Y ω := by
  rw [measurable_iff_entries]
  intro i k
  simp only [Matrix.mul_apply]
  exact Finset.measurable_sum Finset.univ fun j _ ↦
    (measurable_entry hX i j).mul (measurable_entry hY j k)
```

Every summand is a product of measurable scalar functions. A finite sum of
those products is measurable. This proof does not cover an infinite operator
series, convergence, or a bounded-operator topology.

## Step 7: force Hermitian symmetry

A complex square matrix \(H\) is
{{< refterm "hermitian-matrix" "Hermitian" >}} when \(H^*=H\). The module
defines:

```lean
def hermitianSymmetrization (X : RandomMatrix Ω ι ι ℂ) :
    RandomMatrix Ω ι ι ℂ :=
  fun ω ↦ X ω + (X ω)ᴴ
```

The adjective **unnormalized** in its documentation is essential. The map is
\(A\mapsto A+A^*\), not \(A\mapsto(A+A^*)/2\), and not a
dimension-scaled ensemble constructor.

Measurability follows compositionally:

```lean
theorem measurable_hermitianSymmetrization
    {X : RandomMatrix Ω ι ι ℂ} (hX : Measurable X) :
    Measurable (hermitianSymmetrization X) :=
  measurable_add hX (measurable_conjTranspose hX)
```

Hermitian symmetry is an algebraic proof at each outcome:

```lean
theorem hermitianSymmetrization_isHermitian
    (X : RandomMatrix Ω ι ι ℂ) (omega : Ω) :
    (hermitianSymmetrization X omega).IsHermitian := by
  simp [hermitianSymmetrization, Matrix.IsHermitian, add_comm]
```

Here `simp` expands conjugate transpose over addition, cancels the double
conjugate transpose, and uses commutativity of addition.

## Step 8: distinguish everywhere from almost everywhere

The module defines a measure-dependent predicate:

```lean
def IsHermitianAE (X : RandomMatrix Ω ι ι ℂ) (μ : Measure Ω) : Prop :=
  ∀ᵐ ω ∂μ, (X ω).IsHermitian
```

The notation means that the realized matrix is Hermitian for
\(\mu\)-{{< refterm "almost-everywhere" "almost every" >}} outcome.

Symmetrization is already Hermitian at **every** outcome. Lean lifts that
stronger theorem into the almost-everywhere filter:

```lean
theorem hermitianSymmetrization_isHermitianAE
    (X : RandomMatrix Ω ι ι ℂ) (μ : Measure Ω) :
    IsHermitianAE (hermitianSymmetrization X) μ :=
  Filter.Eventually.of_forall (hermitianSymmetrization_isHermitian X)
```

No property of \(\mu\) is needed. Logical weakening does all the work.

{{< checkpoint stage="High camp" title="Keep the three layers separate" >}}
Check that you can name the layers independently: `Measurable X` is analytic,
`(X ω).IsHermitian` is algebraic, and a probability law for `X` would be
distributional. The file combines the first two only where a theorem needs
both. It does not invent the third.
{{< /checkpoint >}}

## The declaration ledger

| Declaration | What a future module can rely on |
|---|---|
| `RandomMatrix` | A reusable matrix-valued map carrier |
| `instMeasurableSpaceMatrix` | Entrywise product measurability on matrix targets |
| `measurable_iff_entries` | Full matrix measurability exactly matches all coordinate maps |
| `measurable_entry` | One scalar coordinate can be extracted from a measurable matrix map |
| `measurable_transpose` | Reindexing by transpose preserves measurability |
| `measurable_map` | Measurable scalar maps lift entrywise |
| `measurable_const` | Fixed matrices are measurable random matrices |
| `measurable_conjTranspose` | Complex conjugate transpose preserves measurability |
| `measurable_add` | Pointwise matrix addition preserves measurability |
| `measurable_mul` | Finite matrix multiplication preserves measurability |
| `hermitianSymmetrization` | Build a square complex matrix map with forced symmetry |
| `measurable_hermitianSymmetrization` | The constructor remains measurable |
| `hermitianSymmetrization_isHermitian` | Every realization is Hermitian |
| `IsHermitianAE` | State measure-dependent almost-sure Hermiticity |
| `hermitianSymmetrization_isHermitianAE` | Pointwise symmetry implies the almost-sure property |

## How to run this exact module

From the repository root:

```sh
source "$HOME/.elan/env"
cd formalization
lake env lean NonlinearDynamics/Random/RandomMatrices/Basic.lean
```

Treat warnings as failures during a focused check:

```sh
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomMatrices/Basic.lean
```

Build the entire import graph:

```sh
lake build
```

Starting from the repository root, build the complete formalization and check
the public teaching content:

```sh
cd formalization
lake build

cd ..
make content-hygiene
make site-check
```

## Design decisions worth preserving

### General indices first

The basic module uses arbitrary index types. Only multiplication asks for a
finite shared index. Ensemble modules can later specialize to `Fin n`, while
random kernels or reindexed matrices can reuse the general statements.

### Complex operations are scoped

Transpose, scalar mapping, and constants are proved generically. Addition,
multiplication, conjugate transpose, and Hermitian structure are initially
specialized to complex matrices because that is the immediate GUE path. A
future generalization should be driven by a concrete reuse case rather than by
maximal abstraction.

### The probability measure arrives late

Only the almost-everywhere predicate mentions a measure. This keeps pure
measurability lemmas valid for any later measure and avoids confusing the
sample map with its law.

### The global instance needs upgrade discipline

Typeclass instances affect all downstream elaboration. Before changing the
Mathlib pin, search for a new upstream `MeasurableSpace (Matrix ...)` instance
and compare its definitional behavior with this one.

## Failure modes this architecture blocks

1. **Calling an arbitrary map a random variable.** Downstream bundled types can
   demand `Measurable` explicitly.
2. **Assuming entry independence from matrix measurability.** The coordinate
   theorem states only measurability.
3. **Losing a transpose index.** The entrywise proof makes the swap visible.
4. **Using an infinite sum without convergence data.** `measurable_mul` exposes
   its `Fintype` boundary.
5. **Assuming a GUE normalization.** Symmetrization is labeled
   unnormalized.
6. **Confusing pointwise and almost-sure symmetry.** The module gives the two
   statements different declarations.

## Discussion: why this modest layer matters

Everything in this section is architectural interpretation. The checked
theorems above stand on their own. Claims about how well this interface will
scale to later ensembles must be tested by those implementations.

The central bet is that random-matrix formalization should start from maps and
measurability, not from a named ensemble. That makes the early work reusable.
A random Jacobian is not normally GUE. A matrix cocycle is not normally
Hermitian. A deterministic change of basis is not random at all. All three can
still use the same coordinate interface.

The next layer tests that bet by bundling measurable pointwise-Hermitian
matrices and deriving their entry, diagonal, and trace consequences. After
that, trace powers become the first measurable spectral observables. Only then
does it become sensible to formalize Gaussian laws and expectations.

## Exercises

1. Show by hand that a measurable two-by-two matrix-valued map has four
   measurable scalar coordinate maps.
2. Rewrite the transpose proof using the if-and-only-if theorem in both
   directions explicitly.
3. Identify the scalar continuity fact used by conjugate transpose.
4. Explain why the zeroth matrix power will later require an identity matrix
   and therefore a decidable equality assumption on finite indices.
5. Replace \(A+A^*\) with \((A+A^*)/2\). Which proofs in this file
   need genuine changes, and which can be reused?
6. State, without proving, what it should mean for the **law** of a random
   Hermitian matrix to be invariant under unitary conjugation.

## References

<a id="ref-mathlib-release"></a>
**Mathlib contributors.**
[Mathlib 4.32.0 release](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
commit `81a5d257c8e410db227a6665ed08f64fea08e997`. This is the exact
dependency release used by the module.

<a id="ref-mathlib-matrix"></a>
**Mathlib contributors.**
[Matrix definitions, pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/LinearAlgebra/Matrix/Defs.lean).
This warrants the coordinate-function representation and `Matrix.of` bridge.

<a id="ref-mathlib-measurable"></a>
**Mathlib contributors.**
[Measurable-space foundations, pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/MeasurableSpace/Basic.lean).
This warrants the `comap` and measurable-function interfaces used here.

<a id="ref-mathlib-complex"></a>
**Mathlib contributors.**
[Complex Borel measurable structure, pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Constructions/BorelSpace/Complex.lean).
This supplies the scalar measurable infrastructure used in the complex section.

<a id="ref-mathlib-hermitian"></a>
**Mathlib contributors.**
[Hermitian matrices, pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/LinearAlgebra/Matrix/Hermitian.lean).
This is the algebraic source for `Matrix.IsHermitian` and conjugate-transpose
identities.

<a id="ref-kallenberg"></a>
**Olav Kallenberg.**
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1),
third edition, Springer, 2021. This is a standard source for measurable random
elements, product spaces, laws, independence, and almost-everywhere reasoning.

<a id="ref-agz"></a>
**Greg W. Anderson, Alice Guionnet, and Ofer Zeitouni.**
[An Introduction to Random Matrices](https://doi.org/10.1017/CBO9780511801334),
Cambridge Studies in Advanced Mathematics 118, Cambridge University Press,
2010. Chapters on real and complex Wigner matrices provide the broader
ensemble context that this foundational module is preparing to formalize.
