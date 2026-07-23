---
title: "Hermitian Random Matrices in Lean: From Symmetry to a Usable Interface"
slug: "hermitian-random-matrices"
date: 2026-07-20
weight: 60
author: "tdj28"
summary: "A declaration-by-declaration ascent through pointwise Hermitian symmetry, almost-sure reasoning, measurable trace, bundling, and congruence transforms in Lean."
lead: |
  Hermitian symmetry begins as a mirror rule for matrix entries. This module
  turns that rule into an interface that survives probability, null sets,
  measurable observables, and reusable Lean constructions.
key_result: |
  The module keeps three obligations separate: a matrix can be Hermitian at
  every sample, Hermitian almost surely under a chosen measure, and measurable
  as a matrix-valued function. The bundled `HermitianRandomMatrix` records the
  strongest useful combination, then makes entries, traces, symmetrization,
  and deterministic congruence transforms available without reopening the
  foundational proofs.
draft: false
pro_reviewed: false
status: "Pending human editorial and technical review"
level: "Base camp to proof summit"
reading_time: "40 to 55 minutes"
prerequisites:
  - "Complex-number conjugation"
  - "Basic matrix multiplication"
  - "No prior Lean measure theory required"
lean_module: "NonlinearDynamics.Random.RandomMatrices.Hermitian"
lean_source: "formalization/NonlinearDynamics/Random/RandomMatrices/Hermitian.lean"
tags:
  - "Lean 4"
  - "Random matrices"
  - "Hermitian matrices"
  - "Measure theory"
  - "Trace"
og_image: "hermitian-random-matrices-card.png"
og_image_alt: "Warm-paper conceptual card showing three Hermitian truth levels beside a matrix with real diagonal entries and conjugate-paired off-diagonal entries."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The human author
has not yet inspected and accepted the exposition, source interpretations,
equations, exercises, or visual. The canonical author disclosure is therefore
intentionally pending. This page is published as an open working note while
human editorial review and the required scientific and reader reviews remain
pending.
{{< /panel >}}

This entry is the code companion to
`formalization/NonlinearDynamics/Random/RandomMatrices/Hermitian.lean`.
Every major declaration in that source file is quoted or summarized below.

For the broader mathematical road from sample spaces to spectra, read the
[Random Matrices Deep Dive](/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra/).
This notebook entry has a narrower job: explain why this particular Lean file
is shaped as it is, how each proof works, and what later formalizations may now
reuse.

## Choose your route

| Route | Start | What you will reach |
|---|---|---|
| First encounter | [The mirror rule](#base-camp-the-mirror-rule) | Why Hermitian matrices have real diagonal entries |
| Probability route | [Three levels of truth](#three-levels-of-truth) | Pointwise versus almost-sure assertions |
| Lean route | [Open the module](#open-the-module) | Every major declaration and proof design |
| Algebra route | [Congruence transforms](#a-congruence-transform-that-preserves-hermiticity) | Why \(AHA^*\) is Hermitian without \(A\) being unitary |
| Builder route | [Run the proof](#run-the-proof-yourself) | Check the file with the pinned toolchain |
| Summit route | [Limits and next steps](#what-this-module-does-not-claim) | The exact runway toward observables and GUE |

### Learning objectives

By the end, a reader should be able to:

1. state Hermitian symmetry both as a matrix equality and entry by entry;
2. distinguish pointwise, almost-sure, and measurable-Hermitian predicates;
3. explain the Lean bridges from a universal proof to an almost-everywhere proof;
4. derive why diagonal entries and finite traces are real;
5. read the `HermitianRandomMatrix` structure, function coercion, and extensionality theorem;
6. verify measurability of trace and deterministic congruence transforms; and
7. identify which distributional claims are still absent.

## The summit map

{{< mermaid >}}
flowchart BT
  A[Entrywise mirror rule] --> B[Hermitian at each sample]
  B --> C[Hermitian almost surely]
  D[Matrix-valued measurability] --> E[Measurable and Hermitian]
  B --> E
  E --> F[Bundled Hermitian random matrix]
  F --> G[Measurable entries]
  F --> H[Real measurable trace]
  F --> I[Hermitian congruence A X A*]
  J[Unnormalized symmetrization X + X*] --> E
{{< /mermaid >}}

<p class="figure-note"><strong>Figure.</strong> The arrows are logical or constructor dependencies, not claims about probability laws. Pointwise Hermiticity implies the almost-sure form for any measure, while the reverse implication generally allows null-set exceptions. Measurability is a separate branch until the predicates or structure explicitly combine it with symmetry.</p>

## Base camp: the mirror rule

A {{< refterm "hermitian-matrix" "Hermitian matrix" >}} \(H\) is fixed by its
{{< refterm "conjugate-transpose" "conjugate transpose" >}}:

\[
H^*=H.
\]

Entrywise, this is

\[
\overline{H_{ji}}=H_{ij}.
\]

The rule couples entries across the diagonal. A general two-by-two Hermitian
matrix has the form

\[
H=
\begin{bmatrix}
a & z \\
\overline z & b
\end{bmatrix},
\qquad a,b\in\mathbb R,\quad z\in\mathbb C.
\]

Setting \(i=j\) in the entrywise rule gives

\[
\overline{H_{ii}}=H_{ii}.
\]

A complex number equals its conjugate exactly when its imaginary part vanishes.
Therefore every diagonal entry is real. Later, the module repeats the same
fixed-by-conjugation move for the trace.

{{< panel "intuition" >}}
Hermitian symmetry is not an independence assumption. If an upper-triangular
entry is \(z\), the reflected lower-triangular entry is forced to be
\(\overline z\). A future random-matrix ensemble must choose its independent
primitive variables without breaking this coupling.
{{< /panel >}}

The official Mathlib definition is exactly the matrix equality \(H^*=H\), and
its API exposes both the entrywise theorem `Matrix.IsHermitian.apply` and the
if-and-only-if theorem `Matrix.IsHermitian.ext_iff`
([Mathlib Hermitian API](#ref-mathlib-hermitian)).

## Three levels of truth

Let \(X\) be a {{< refterm "random-matrix" "random matrix" >}} carrier, meaning
a map from outcomes to square complex matrices:

\[
X:\Omega\longrightarrow\mathbb C^{\iota\times\iota}.
\]

The module separates three questions that ordinary prose often compresses
into one sentence.

| Question | Mathematical form | Can exceptions occur? | Depends on a measure? |
|---|---|---|---|
| Is every realization Hermitian? | \(\forall \omega,\ X(\omega)^*=X(\omega)\) | No | No |
| Is it Hermitian almost surely? | \(X(\omega)^*=X(\omega)\) for \(\mu\)-a.e. \(\omega\) | Only on a null set | Yes |
| Is it measurable? | \(X\) is a measurable map | Not a symmetry claim | Uses the measurable structures, not a probability mass by itself |

The second row uses {{< refterm "almost-everywhere" "almost everywhere" >}}.
The third uses a {{< refterm "measurable-space" "measurable space" >}} on the
sample space and the entrywise measurable structure on matrices established in
`RandomMatrices.Basic`.

{{< panel "warning" >}}
**Do not trade one row for another.** A pointwise symmetric map need not be
measurable. A measurable matrix need not be Hermitian. An almost-surely
Hermitian map may fail at particular outcomes. The module combines properties
only through explicit conjunctions or structure fields.
{{< /panel >}}

## Open the module

The file begins with two imports:

```lean
import Mathlib.LinearAlgebra.Matrix.Trace
import NonlinearDynamics.Random.RandomMatrices.Basic
```

The project import supplies `RandomMatrix`, its entrywise measurable space,
measurable matrix operations, `IsHermitianAE`, and unnormalized Hermitian
symmetrization. The Mathlib import supplies finite matrix trace and the theorem
relating trace to conjugate transpose
([Mathlib trace API](#ref-mathlib-trace)).

```lean
open Matrix MeasureTheory
open scoped Matrix

universe uΩ uι

namespace NonlinearDynamics.Random
namespace RandomMatrix

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
```

`open scoped Matrix` activates notation such as `Aᴴ`. The universes keep the
sample type and index type general. The `[MeasurableSpace Ω]` parameter gives
Lean the structure needed whenever a theorem says `Measurable` or mentions a
measure on \(\Omega\).

### Why some theorems say `omit`

Several declarations begin like this:

```lean
omit [MeasurableSpace Ω] in
```

That marker records a useful negative fact: the theorem is purely algebraic or
logical and its proof does not use the measurable-space instance. The same
outcome type can therefore support the theorem before any probability-facing
structure is relevant. This is dependency hygiene, not cosmetic syntax.

## Layer one: Hermitian at every sample

The first project-level predicate is deliberately direct:

```lean
def IsHermitianEverywhere (X : RandomMatrix Ω ι ι ℂ) : Prop :=
  ∀ ω, (X ω).IsHermitian
```

Read it left to right. `X` accepts an outcome. `X ω` is one ordinary complex
matrix. Mathlib's `.IsHermitian` checks that realization. The outer `∀ ω`
forbids exceptional outcomes.

The entrywise characterization then exposes the mirror rule:

```lean
theorem isHermitianEverywhere_iff_entries
    (X : RandomMatrix Ω ι ι ℂ) :
    IsHermitianEverywhere X ↔
      ∀ ω i j, star (X ω j i) = X ω i j := by
  simp only [IsHermitianEverywhere, Matrix.IsHermitian.ext_iff]
```

The proof works because Mathlib already knows the matrix-level equivalence.
After unfolding the project predicate, `simp only` applies exactly that theorem
at every outcome. There is no entry-by-entry algebra to redo.

{{< checkpoint stage="Camp I" title="Translate the types aloud" >}}
In `star (X ω j i) = X ω i j`, name the role of every symbol: the sample
\(\omega\), the reflected indices \(j,i\), scalar conjugation `star`, and the
target entry \(i,j\). If this sentence is clear, the later diagonal proof will
feel inevitable.
{{< /checkpoint >}}

## Layer two: descend safely to almost surely

`RandomMatrices.Basic` defines

```lean
def IsHermitianAE (X : RandomMatrix Ω ι ι ℂ) (μ : Measure Ω) : Prop :=
  ∀ᵐ ω ∂μ, (X ω).IsHermitian
```

Mathlib's `∀ᵐ` notation means that the property holds outside a set of
\(\mu\)-measure zero
([Mathlib almost-everywhere API](#ref-mathlib-ae)). Pointwise truth is stronger,
so the bridge is short:

```lean
theorem IsHermitianEverywhere.isHermitianAE
    {X : RandomMatrix Ω ι ι ℂ}
    (hX : IsHermitianEverywhere X) (μ : Measure Ω) :
    IsHermitianAE X μ :=
  Filter.Eventually.of_forall hX
```

`hX` proves the predicate for every \(\omega\). `Eventually.of_forall`
places that universal proof inside any filter, including the almost-everywhere
filter belonging to \(\mu\). No property of the measure is required.

The converse is absent for a reason. An almost-sure proof may ignore a null
set, while `IsHermitianEverywhere` may not.

## Layer three: combine symmetry with measurability

The file offers unbundled predicates for both strengths:

```lean
def IsMeasurableHermitian (X : RandomMatrix Ω ι ι ℂ) : Prop :=
  Measurable X ∧ IsHermitianEverywhere X

def IsMeasurableHermitianAE
    (X : RandomMatrix Ω ι ι ℂ) (μ : Measure Ω) : Prop :=
  Measurable X ∧ IsHermitianAE X μ
```

These are propositions about an existing map. They do not create a new data
type. Their conjunction shape makes projection straightforward:

```lean
theorem IsMeasurableHermitian.isMeasurableHermitianAE
    {X : RandomMatrix Ω ι ι ℂ}
    (hX : IsMeasurableHermitian X) (μ : Measure Ω) :
    IsMeasurableHermitianAE X μ :=
  ⟨hX.1, hX.2.isHermitianAE μ⟩
```

The first component `hX.1` is measurability. The second component `hX.2` is
pointwise Hermiticity, which the preceding theorem lowers to the
almost-sure form.

### The universal constructor

The basic module defines the unnormalized symmetrization

\[
\operatorname{sym}(X)(\omega)=X(\omega)+X(\omega)^*.
\]

This file packages the two existing facts about it:

```lean
theorem isMeasurableHermitian_hermitianSymmetrization
    {X : RandomMatrix Ω ι ι ℂ} (hX : Measurable X) :
    IsMeasurableHermitian (hermitianSymmetrization X) :=
  ⟨measurable_hermitianSymmetrization hX,
    hermitianSymmetrization_isHermitian X⟩
```

The first proof field follows from measurable addition and measurable conjugate
transpose. The second is pointwise algebra:

\[
(A+A^*)^*=A^*+A=A+A^*.
\]

{{< panel "warning" >}}
**Unnormalized means unnormalized.** The constructor is \(X+X^*\), not
\((X+X^*)/2\), and it contains no dimension scaling. It guarantees symmetry
and measurability. It does not by itself define GOE, GUE, independent entries,
Gaussian entries, or a spectral normalization.
{{< /panel >}}

## Extracting the algebraic consequences

Once pointwise Hermiticity is available, the reflected-entry theorem is a
thin wrapper around Mathlib:

```lean
theorem IsHermitianEverywhere.star_entry
    {X : RandomMatrix Ω ι ι ℂ}
    (hX : IsHermitianEverywhere X) (ω : Ω) (i j : ι) :
    star (X ω j i) = X ω i j :=
  (hX ω).apply i j
```

`hX ω` specializes the random-matrix property to one realized matrix.
`.apply i j` then extracts the scalar equality at the chosen entries.

### The diagonal proof as a change of language

```lean
theorem IsHermitianEverywhere.diagonal_im_eq_zero
    {X : RandomMatrix Ω ι ι ℂ}
    (hX : IsHermitianEverywhere X) (ω : Ω) (i : ι) :
    (X ω i i).im = 0 := by
  rw [← Complex.conj_eq_iff_im, ← Complex.star_def]
  exact hX.star_entry ω i i
```

The goal begins as a statement about an imaginary part. The first rewrite uses
the equivalence

\[
\overline z=z\quad\Longleftrightarrow\quad\operatorname{Im}(z)=0.
\]

Because the arrow on `rw` points left, Lean changes the goal into a conjugation
fixed-point equality. `Complex.star_def` aligns generic `star` notation with
complex conjugation. The existing diagonal instance of `star_entry` closes the
goal. The supporting complex-number lemmas are documented in Mathlib's official
complex API ([Mathlib complex API](#ref-mathlib-complex)).

### Carrying consequences through a null set

The almost-sure entry theorem maps an implication over an existing eventual
proof:

```lean
theorem isHermitianAE_star_entry
    {X : RandomMatrix Ω ι ι ℂ} {μ : Measure Ω}
    (hX : IsHermitianAE X μ) (i j : ι) :
    ∀ᵐ ω ∂μ, star (X ω j i) = X ω i j :=
  hX.mono fun _ hω ↦ hω.apply i j
```

For almost every outcome, `hω` says the realized matrix is Hermitian. The
function after `.mono` turns that matrix-level fact into the desired
entry-level fact without changing the exceptional set.

The diagonal theorem uses tactic syntax for the same pattern:

```lean
theorem isHermitianAE_diagonal_im_eq_zero
    {X : RandomMatrix Ω ι ι ℂ} {μ : Measure Ω}
    (hX : IsHermitianAE X μ) (i : ι) :
    ∀ᵐ ω ∂μ, (X ω i i).im = 0 := by
  filter_upwards [hX] with ω hω
  rw [← Complex.conj_eq_iff_im, ← Complex.star_def]
  exact hω.apply i i
```

`filter_upwards` brings an outcome and its Hermitian proof into the local
context. The remaining algebra is the pointwise diagonal argument again.

## The trace ridge

For a finite square matrix,

\[
\operatorname{tr}(A)=\sum_i A_{ii}.
\]

The file proves both facts needed for a useful Hermitian trace observable:
measurability for measurable finite matrices, and real-valuedness for
Hermitian ones.

### Why finite trace is measurable

```lean
theorem measurable_trace [Fintype ι]
    {X : RandomMatrix Ω ι ι ℂ} (hX : Measurable X) :
    Measurable fun ω ↦ Matrix.trace (X ω) := by
  simp only [Matrix.trace, Matrix.diag_apply]
  exact Finset.measurable_sum Finset.univ fun i _ ↦
    measurable_entry hX i i
```

The proof unfolds trace into a sum over `Finset.univ`. Each diagonal coordinate
is measurable by `RandomMatrix.measurable_entry`. A finite sum of measurable
complex-valued functions is measurable. `[Fintype ι]` is exactly what supplies
the finite index set.

{{< panel "info" >}}
**What finiteness buys.** The proof is not an infinite-series argument. No
summability, convergence, or operator trace appears. A future infinite-
dimensional theory would need different objects and hypotheses.
{{< /panel >}}

### Why a Hermitian trace is real

The central deterministic lemma is:

```lean
theorem star_trace_eq_of_isHermitian [Fintype ι]
    {A : Matrix ι ι ℂ} (hA : A.IsHermitian) :
    star (Matrix.trace A) = Matrix.trace A := by
  rw [← Matrix.trace_conjTranspose, hA.eq]
```

Mathlib proves

\[
\operatorname{tr}(A^*)=\overline{\operatorname{tr}(A)}.
\]

The backwards rewrite turns the left side of the goal into
\(\operatorname{tr}(A^*)\). Hermiticity supplies \(A^*=A\), exposed in Lean as
`hA.eq`. The trace is therefore fixed by conjugation, so its imaginary part is
zero.

The file applies that lemma at two strengths:

```lean
omit [MeasurableSpace Ω] in
theorem IsHermitianEverywhere.trace_im_eq_zero [Fintype ι]
    {X : RandomMatrix Ω ι ι ℂ} (hX : IsHermitianEverywhere X) (ω : Ω) :
    (Matrix.trace (X ω)).im = 0 := by
  rw [← Complex.conj_eq_iff_im, ← Complex.star_def]
  exact star_trace_eq_of_isHermitian (hX ω)

theorem isHermitianAE_trace_im_eq_zero [Fintype ι]
    {X : RandomMatrix Ω ι ι ℂ} {μ : Measure Ω}
    (hX : IsHermitianAE X μ) :
    ∀ᵐ ω ∂μ, (Matrix.trace (X ω)).im = 0 := by
  filter_upwards [hX] with ω hω
  rw [← Complex.conj_eq_iff_im, ← Complex.star_def]
  exact star_trace_eq_of_isHermitian hω
```

The pointwise theorem specializes `hX` at one outcome. The almost-sure theorem
uses `filter_upwards`, proving the same deterministic statement at every
outcome outside the inherited null set.

{{< checkpoint stage="Camp II" title="See one proof pattern in three places" >}}
Diagonal realness, pointwise trace realness, and almost-sure trace realness all
use the same spine: prove an object is fixed by complex conjugation, then invoke
`Complex.conj_eq_iff_im`. The surrounding logic changes, but the algebraic core
does not.
{{< /checkpoint >}}

## The bundle: carry evidence with the object

Unbundled predicates are ideal when a theorem starts with an existing function.
Repeated construction is easier when the data and its invariants travel
together. The file therefore introduces:

```lean
structure HermitianRandomMatrix
    (Ω : Type uΩ) (ι : Type uι) [MeasurableSpace Ω] where
  toRandomMatrix : RandomMatrix Ω ι ι ℂ
  measurable_toRandomMatrix : Measurable toRandomMatrix
  isHermitian : RandomMatrix.IsHermitianEverywhere toRandomMatrix
```

This structure stores one map and two proofs. It chooses pointwise Hermiticity,
the strongest predicate in the module. The documentation explicitly directs
measure-dependent null-set use cases toward
`RandomMatrix.IsMeasurableHermitianAE` instead.

### Use a bundle like a function

```lean
instance : CoeFun (HermitianRandomMatrix Ω ι)
    fun _ ↦ Ω → Matrix ι ι ℂ where
  coe X := X.toRandomMatrix
```

The `CoeFun` instance lets Lean insert the projection automatically, so `X ω`
means `X.toRandomMatrix ω`. The official Lean manual describes this same
function-coercion pattern for bundled morphisms
([Lean type classes](#ref-lean-typeclasses)).

The simplification theorem

```lean
@[simp]
theorem coe_toRandomMatrix (X : HermitianRandomMatrix Ω ι) :
    (X.toRandomMatrix : Ω → Matrix ι ι ℂ) = X := rfl
```

states that the projection and the function view are definitionally the same.
The right side is coerced to a function because the expected type is already a
function type.

### Equality follows the underlying realizations

```lean
@[ext]
theorem ext {X Y : HermitianRandomMatrix Ω ι}
    (h : ∀ ω, X ω = Y ω) : X = Y := by
  cases X
  cases Y
  congr
  funext ω
  exact h ω
```

The theorem turns equality of bundles into the natural mathematical test:
their realized matrices agree for every outcome. After both structures are
opened, `funext` converts pointwise equality into equality of the stored
functions. Proof fields live in `Prop`, so they do not create a second notion
of mathematical equality. The `@[ext]` attribute registers this theorem for
future extensionality proofs. Lean's official structures chapter explains the
underlying record model ([Lean structures](#ref-lean-structures)).

### The bundled projection lemmas

The next declarations make the stored evidence easy to consume:

| Declaration | What it returns | Evidence reused |
|---|---|---|
| `measurable_entry` | Every scalar entry is measurable | `measurable_toRandomMatrix` |
| `isHermitianAE` | Hermitian almost surely for any measure | pointwise `isHermitian` |
| `isMeasurableHermitianAE` | Measurable and Hermitian almost surely | both structure fields |
| `star_entry` | Conjugate symmetry at each sample | pointwise `isHermitian` |
| `diagonal_im_eq_zero` | Real diagonal entries | pointwise `isHermitian` |
| `measurable_trace` | A measurable complex trace | measurable structure field |
| `trace_im_eq_zero` | A real trace at every sample | pointwise structure field |

These theorems are intentionally short. The bundle's purpose is to pay for the
foundational obligations once and then route later proofs through projections.

## Two bundled constructors

### Package symmetrization

```lean
def ofSymmetrization
    (X : RandomMatrix Ω ι ι ℂ) (hX : Measurable X) :
    HermitianRandomMatrix Ω ι where
  toRandomMatrix := RandomMatrix.hermitianSymmetrization X
  measurable_toRandomMatrix :=
    RandomMatrix.measurable_hermitianSymmetrization hX
  isHermitian :=
    RandomMatrix.hermitianSymmetrization_isHermitian X
```

The constructor asks for a convenient sufficient premise: measurability of the
input. Algebra supplies Hermiticity automatically. This premise is not
logically necessary for every possible input, since cancellation can make a
symmetrization measurable even when the original map is not. No measure is
necessary for the Hermitian conclusion because it holds at every sample.

### A congruence transform that preserves Hermiticity

For a deterministic complex matrix \(A\), define

\[
Y(\omega)=A\,X(\omega)\,A^*.
\]

The module packages this construction:

```lean
def conjugateBy [Fintype ι]
    (A : Matrix ι ι ℂ) (X : HermitianRandomMatrix Ω ι) :
    HermitianRandomMatrix Ω ι where
  toRandomMatrix := fun ω ↦ A * X ω * Aᴴ
  measurable_toRandomMatrix :=
    RandomMatrix.measurable_mul
      (RandomMatrix.measurable_mul
        (RandomMatrix.measurable_const (Ω := Ω) A)
        X.measurable_toRandomMatrix)
      (RandomMatrix.measurable_const (Ω := Ω) Aᴴ)
  isHermitian := fun ω ↦
    Matrix.isHermitian_mul_mul_conjTranspose A (X.isHermitian ω)
```

The algebra is worth doing in full. If \(H^*=H\), then

\[
\begin{aligned}
(AHA^*)^*
  &= (A^*)^* H^* A^* \\
  &= AHA^*.
\end{aligned}
\]

No inverse appears. No unitary equation appears. Any square \(A\) gives a
Hermitian congruence transform. Mathlib's theorem
`Matrix.isHermitian_mul_mul_conjTranspose` packages precisely that algebra
([Mathlib Hermitian API](#ref-mathlib-hermitian)).

Measurability is built from the inside out:

1. the deterministic matrix \(A\) is a measurable constant;
2. the stored matrix \(X\) is measurable;
3. finite matrix multiplication makes \(AX\) measurable;
4. \(A^*\) is another measurable constant; and
5. a second finite multiplication makes \(AXA^*\) measurable.

### Worked algebra: Hermitian does not mean invariant

Take

\[
H=
\begin{bmatrix}
a & z \\
\overline z & b
\end{bmatrix},
\qquad
A=
\begin{bmatrix}
2 & 0 \\
0 & 1
\end{bmatrix}.
\]

Because \(A^*=A\),

\[
AHA^*=
\begin{bmatrix}
4a & 2z \\
2\overline z & b
\end{bmatrix}.
\]

The result is still Hermitian. Its trace is \(4a+b\), which generally differs
from \(a+b\). This is why the constructor's theorem must not be misread as
trace invariance, spectral invariance, or distributional invariance.

{{< panel "warning" >}}
**Congruence is not yet ensemble invariance.** If \(A\) is unitary, then
\(AHA^*\) is also a similarity transform and preserves the spectrum of each
realization. GUE unitary invariance is stronger again: it says the transformed
random matrix has the same law. This module proves only that deterministic
congruence preserves measurability and pointwise Hermiticity.
{{< /panel >}}

## Declaration inventory

The module's public story can be read as four layers.

| Layer | Declarations | Design job |
|---|---|---|
| Predicates | `IsHermitianEverywhere`, `IsMeasurableHermitian`, `IsMeasurableHermitianAE` | Separate algebraic strength from probability-facing structure |
| Bridges | `isHermitianEverywhere_iff_entries`, `.isHermitianAE`, `.isMeasurableHermitianAE`, `isMeasurableHermitian_hermitianSymmetrization` | Move between entrywise, pointwise, almost-sure, and measurable views |
| Consequences | `star_entry`, `diagonal_im_eq_zero`, their a.e. forms, `measurable_trace`, `star_trace_eq_of_isHermitian`, the two trace-realness theorems | Expose reusable scalar observables and symmetry facts |
| Bundle API | `HermitianRandomMatrix`, coercion, `ext`, projections, `ofSymmetrization`, `conjugateBy` | Make later modules construct and consume certified objects |

That separation is the main proof-engineering result. Each later theorem can
request the weakest interface it needs instead of unfolding one oversized
definition.

## Run the proof yourself

From the repository root, activate the pinned elan environment and check only
this file with warnings treated as errors:

```sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomMatrices/Hermitian.lean
```

From the repository root, build the entire formalization with:

```sh
cd formalization
lake build
```

A successful file check returns to the shell without diagnostic output. A full
`lake build` prints its build progress and final status. The exact Lean release
is pinned in `formalization/lean-toolchain`, and Mathlib is pinned in
`formalization/lakefile.toml`.

### A scratch theorem to try

Create a temporary file inside `formalization/` with this import and example:

```lean
import NonlinearDynamics.Random.RandomMatrices.Hermitian

open Matrix MeasureTheory
open scoped Matrix

namespace Scratch

open NonlinearDynamics.Random

variable {Ω ι : Type} [MeasurableSpace Ω]

example [Fintype ι] (X : HermitianRandomMatrix Ω ι) (ω : Ω) :
    (Matrix.trace (X ω)).im = 0 := by
  exact X.trace_im_eq_zero ω

end Scratch
```

Run it with `lake env lean YourScratchFile.lean`. The exercise demonstrates the
payoff of bundling: the final proof names the theorem that matches the intended
mathematics and does not reopen any matrix entries.

## What this module does not claim

This boundary is as important as the successful proofs.

- It defines no probability distribution or pushforward law on matrix space.
- It imposes no Gaussianity, independence, identical distribution, variance,
  or dimension normalization.
- It does not define GOE or GUE.
- Its symmetrization is explicitly unnormalized.
- Its bundle requires Hermiticity at every sample, not merely almost surely.
- Its congruence matrix \(A\) is deterministic. The file does not handle a
  random change of basis.
- It proves no unitary invariance in law.
- It proves trace measurability and realness, not integrability or existence of
  expected trace moments.
- It contains no eigenvalue measurability theorem and does not import the
  spectral theorem.
- Matrix multiplication and trace results here are finite-dimensional.

The broader Deep Dive explains why these missing layers matter before one can
honestly speak about GUE, spectral statistics, or quantum chaos. The official
Mathlib spectrum module already contains finite Hermitian diagonalization, but
that result is a future dependency, not a theorem proved by this file
([Mathlib spectrum API](#ref-mathlib-spectrum)).

## The next ridge

The immediate project module `RandomMatrices.Observables` builds trace powers

\[
\omega\longmapsto\operatorname{tr}(X(\omega)^k)
\]

on top of the trace interface proved here. The next ensemble-facing ascent
then needs:

1. probability laws for scalar primitives and matrices;
2. an explicit finite index such as `Fin n`;
3. Gaussian diagonal and off-diagonal variables with a stated convention;
4. independence on the primitive coordinates;
5. a normalization ledger;
6. equality in law under unitary conjugation; and
7. integrability before expected trace moments are formed.

The present module earns that climb by making Hermitian structure impossible to
hand-wave. Every future ensemble must say which symmetry predicate it has, how
measurability is obtained, and whether a statement is pointwise or only
almost sure.

## Exercises: foothills to summit

### 1. Mirror the entry

For

\[
H=
\begin{bmatrix}
3 & 1+2i \\
? & -4
\end{bmatrix},
\]

fill the missing entry so that \(H\) is Hermitian. Then state which Lean theorem
extracts the equality you used from an `IsHermitianEverywhere` hypothesis.

<details>
<summary>Hint and answer</summary>

The missing entry is \(1-2i\). The project theorem is
`RandomMatrix.IsHermitianEverywhere.star_entry`, which delegates to
`Matrix.IsHermitian.apply` for the realized matrix.

</details>

### 2. Break the false converse

Give a conceptual example of a matrix-valued map that is Hermitian almost
everywhere under a continuous measure but not Hermitian everywhere.

<details>
<summary>Hint and answer</summary>

Start with a constant Hermitian map and change its value at one outcome to a
non-Hermitian matrix. Under a measure that assigns that singleton measure zero,
the modified map can remain Hermitian almost everywhere while failing the
pointwise predicate. A complete Lean construction would also need to establish
measurability of the modification.

</details>

### 3. Find the finite hypothesis

Why does `measurable_trace` assume `[Fintype ι]` while
`IsHermitianEverywhere.diagonal_im_eq_zero` does not?

<details>
<summary>Hint and answer</summary>

One diagonal entry is local and needs only an index. Trace sums over all
indices, so this implementation uses `Finset.univ` and finite-sum measurability.

</details>

### 4. Predict the weakest premise

Suppose a theorem needs only that `trace (X ω)` is real for almost every
outcome. Should its input be a `HermitianRandomMatrix`,
`IsHermitianEverywhere X`, or `IsHermitianAE X μ`?

<details>
<summary>Hint and answer</summary>

`IsHermitianAE X μ` is the weakest of those premises that directly supports
the desired conclusion through `isHermitianAE_trace_im_eq_zero`. Requesting a
bundle would unnecessarily require measurability and pointwise symmetry.

</details>

### 5. Congruence versus similarity

Show algebraically that \(AHA^*\) is Hermitian for arbitrary square \(A\).
Then name the extra equation that makes the same operation a unitary similarity
transform.

<details>
<summary>Hint and answer</summary>

Use \((BCD)^*=D^*C^*B^*\), \(H^*=H\), and \((A^*)^*=A\). For a unitary matrix,
the extra equation is \(A^*=A^{-1}\). Only then can \(AHA^*\) be read as
\(AHA^{-1}\).

</details>

### 6. Extend the API

Draft the statement of a theorem saying that the real part of every entry of a
bundled Hermitian random matrix is measurable. Which existing theorem should
be composed with continuity of `Complex.re`?

<details>
<summary>Hint</summary>

Begin with `X.measurable_entry i j`. Then compose it with the official Mathlib
measurability or continuity theorem for the real-part projection. The task is
to find the exact library declaration before writing a proof.

</details>

{{< checkpoint stage="Summit" title="The interface in one breath" >}}
A measurable matrix map plus pointwise Hermitian symmetry can be bundled. The
bundle behaves like its underlying function, exposes measurable entries and a
real measurable finite trace, and remains bundled after unnormalized
symmetrization or deterministic congruence. Almost-sure variants remain
available when null-set modifications matter. Distributional claims begin only
after this interface ends.
{{< /checkpoint >}}

## References

Every external source below was opened and checked against the claim it supports
on 2026-07-20. Generated Mathlib documentation can move with later releases, so
the repository's Mathlib 4.32.0 pin remains the build authority.

<a id="ref-mathlib-release"></a>
**Mathlib contributors.**
[Mathlib 4.32.0 release](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
2026. This is the exact dependency release named by `lakefile.toml`.

<a id="ref-mathlib-hermitian"></a>
**Mathlib contributors.**
[Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html),
Mathlib 4 documentation. This is the official API source for
`Matrix.IsHermitian`, its entrywise forms, and
`Matrix.isHermitian_mul_mul_conjTranspose`.

<a id="ref-mathlib-conjtranspose"></a>
**Mathlib contributors.**
[Conjugate transpose](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/ConjTranspose.html),
Mathlib 4 documentation. This defines `Matrix.conjTranspose`, the `ᴴ` notation,
entry lookup, involution, and reversal of multiplication order.

<a id="ref-mathlib-trace"></a>
**Mathlib contributors.**
[Matrix trace](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Trace.html),
Mathlib 4 documentation. This is the official source for
`Matrix.trace_conjTranspose` and the finite trace interface.

<a id="ref-mathlib-complex"></a>
**Mathlib contributors.**
[Complex numbers](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/Complex/Basic.html),
Mathlib 4 documentation. This documents `Complex.conj_eq_iff_im` and
`Complex.star_def`, used to turn conjugation fixed points into realness.

<a id="ref-mathlib-ae"></a>
**Mathlib contributors.**
[The almost-everywhere filter](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/OuterMeasure/AE.html),
Mathlib 4 documentation. This defines `∀ᵐ ω ∂μ, P ω` as truth outside a
\(\mu\)-null set and explains its reduction to `Filter.Eventually`.

<a id="ref-mathlib-spectrum"></a>
**Mathlib contributors.**
[Spectral theory of matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Spectrum.html),
Mathlib 4 documentation. This official module contains finite Hermitian
eigenvalue and diagonalization results. It is cited as future infrastructure,
not as content proved in `RandomMatrices.Hermitian`.

<a id="ref-lean-structures"></a>
**Lean developers.**
[Structures and records](https://lean-lang.org/theorem_proving_in_lean4/Structures-and-Records/),
*Theorem Proving in Lean 4*. This is the official language guide for structure
declarations and their generated projections.

<a id="ref-lean-typeclasses"></a>
**Lean developers.**
[Type classes](https://lean-lang.org/theorem_proving_in_lean4/Type-Classes/),
*Theorem Proving in Lean 4*. Its coercion section documents `CoeFun`, the
mechanism that lets a bundled object be applied like its underlying function.
