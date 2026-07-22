---
title: "Hermitian Coordinate Assembly in Lean: From Free Parameters to Measurable Matrices"
slug: "hermitian-coordinate-assembly"
date: 2026-07-21
weight: 5
author: "tdj28"
summary: "A guided construction of complex Hermitian matrices from a real diagonal and complex strict upper triangle, with exact entry rules, pointwise symmetry, measurability, bundling, and a total zero-dimensional boundary."
lead: |
  A Hermitian matrix does not need every entry to be chosen separately. Choose a real diagonal and the complex entries strictly above it; conjugate reflection determines everything below. This chapter turns that familiar picture into a direct Lean constructor whose coordinates are inserted unchanged, whose output is Hermitian at every outcome, and whose measurability survives without choosing a Gaussian law or normalization.
key_result: |
  Lean now has a normalization-free measurable map from Hermitian coordinates to ambient complex matrices. The checked API exposes diagonal, upper, and lower entries exactly, proves every assembled matrix Hermitian, bundles measurable coordinate processes as pointwise Hermitian random matrices, and treats dimension zero as the unique empty matrix. It makes no probabilistic independence or GUE claim.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Finite-dimensional linear algebra to measurable random-matrix constructors"
reading_time: "60 to 80 minutes"
prerequisites:
  - "Complex conjugation and matrix indices"
  - "A measurable map as the deterministic core of a random variable"
  - "No prior Lean proof experience required"
lean_module: "NonlinearDynamics.Random.RandomMatrices.HermitianCoordinates"
lean_source: "formalization/NonlinearDynamics/Random/RandomMatrices/HermitianCoordinates.lean"
tags:
  - "Lean 4"
  - "Hermitian matrices"
  - "Coordinate spaces"
  - "Measurability"
  - "Random matrices"
  - "GUE foundations"
og_image: "hermitian-coordinate-assembly-card.png"
og_image_alt: "Warm-paper teaching card showing real diagonal coordinates and complex strict-upper coordinates flowing through direct assembly into a three-by-three Hermitian matrix, with conjugate reflection below the diagonal and no normalization choice."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed Research Note. Verify claims against the cited primary
sources and any released artifacts before relying on them.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This teaching chapter is published as an open working
note while human
editorial acceptance and the separate scientific-integrity and zero-context
expert-reader reviews are pending. The checked Lean source is authoritative
for every theorem statement.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** `HermitianCoordinates.lean` isolates a deterministic bridge that
random-matrix probability will later reuse. Its input is a pair: one real
number for each diagonal position and one complex number for each position
strictly above the diagonal. Its output places those values directly into a
complex matrix and fills the lower triangle by conjugate reflection.

The module proves exact formulas for all three index regions, pointwise
Hermiticity, entrywise measurability for coordinate processes, measurability of
the named coordinate map, a bundled `HermitianRandomMatrix` constructor, and
two explicit zero-dimensional theorems. These results need no probability
measure.

**Takeaway.** The file formalizes assembly, not an ensemble. It chooses no
coordinate law, variance, density, dimension scaling, independence relation,
unitary-invariance theorem, eigenvalue convention, or asymptotic limit.
{{< /panel >}}

This is the proof-to-prose companion to
`formalization/NonlinearDynamics/Random/RandomMatrices/HermitianCoordinates.lean`.
Every named public declaration in that file appears below. Explanatory formulas
use ordinary mathematical notation, while the source file gives the exact Lean
types.

The earlier chapters
[When Randomness Becomes a Matrix]({{< relref "/development-notebook/2026/07/random-matrices-as-measurable-maps" >}})
and
[Hermitian Random Matrices]({{< relref "/development-notebook/2026/07/hermitian-random-matrices" >}})
establish the measurable matrix carrier and the pointwise Hermitian bundle.
The probability-side coordinate chapters culminate in
[Independent Complex Gaussian Families]({{< relref "/development-notebook/2026/07/independent-complex-gaussian-families" >}}).
The stable textbook treatment is
[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}}).

Reusable vocabulary is indexed under
{{< refterm "hermitian-coordinate-space" >}},
{{< refterm "hermitian-matrix" >}},
{{< refterm "conjugate-transpose" "conjugate transpose" >}},
{{< refterm "random-matrix" >}},
{{< refterm "measurable-space" >}}, and
{{< refterm "normalization-convention" "normalization convention" >}}.

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| First encounter | [Why half a matrix is enough](#why-half-a-matrix-is-enough) | See why a real diagonal plus one complex triangle determines a Hermitian matrix |
| Geometry route | [The coordinate count](#the-real-geometry-hidden-in-the-entry-pattern) | Recover the \(n^2\) real degrees of freedom without duplicating entries |
| Lean route | [The strict-upper subtype](#camp-one-an-index-that-carries-its-own-proof) | Follow all seventeen public declarations and their proof engines |
| Measure-theory route | [Measurability](#high-camp-measurability-is-entrywise) | See why static index branches preserve measurable coordinate processes |
| Edge-case route | [Dimension zero](#the-zero-dimensional-boundary-is-a-theorem) | Understand why the empty matrix needs no exceptional division or probability convention |
| Ensemble route | [What comes next](#the-next-ridge-push-a-law-through-the-map) | Separate this deterministic constructor from the future GUE law |

### Learning objectives

By the summit, a reader should be able to:

1. derive the Hermitian entry pattern from \(H^*=H\);
2. explain why diagonal inputs are real and only strict-upper entries are free
   complex coordinates;
3. read `StrictUpperIndex n` as a pair of indices bundled with a proof of
   strict order;
4. evaluate `hermitianFromCoordinates` above, below, and on the diagonal;
5. explain why direct insertion avoids the diagonal factor introduced by
   `X + Xᴴ`;
6. follow the trichotomy proof of pointwise Hermiticity;
7. reduce matrix measurability to fixed entry functions;
8. explain the roles of `measurable_pi_apply`, `measurable_fst`, and
   `measurable_snd` in the canonical map;
9. distinguish free algebraic coordinates from probabilistically independent
   random variables; and
10. run the exact strict compiler command and identify every theorem that is
    intentionally absent.

## The construction in one picture

{{< mermaid >}}
flowchart LR
  D["Real diagonal coordinates"] --> A["Direct three-region assembly"]
  U["Complex strict-upper coordinates"] --> A
  A --> H["Complex matrix"]
  A --> R["Conjugate reflection below diagonal"]
  R --> H
  H --> P["Hermitian at every input"]
  MD["Measurable diagonal processes"] --> MM["Measurable matrix map"]
  MU["Measurable upper processes"] --> MM
  A --> MM
  L["Probability laws and normalization"] -. later .-> E["Matrix ensemble law"]
  MM -. pushforward later .-> E
{{< /mermaid >}}

<p class="figure-note"><strong>Figure.</strong> The solid path is checked in
this module. Real diagonal and complex strict-upper data are parallel inputs;
conjugate reflection fills the lower triangle, and entrywise hypotheses prove
measurability. The dotted path is future work. The current file does not put a
measure on the coordinate space or name any ensemble.</p>

## Why half a matrix is enough

For a complex square matrix \(H\), Hermiticity means

\[
H^*=H.
\]

The conjugate transpose reverses the indices and conjugates the entry, so the
same condition says

\[
H_{ji}=\overline{H_{ij}}
\qquad\text{for every }i,j.
\]

Two consequences arrive immediately. First, if \(i=j\), then

\[
H_{ii}=\overline{H_{ii}},
\]

so the diagonal entry is real. Second, if \(i\lt j\), choosing \(H_{ij}\)
automatically fixes the reflected entry \(H_{ji}\). Choosing both would be
redundant and would create a consistency obligation.

The efficient coordinates are therefore:

- \(d_i\in\mathbb R\) for each diagonal position \(i\); and
- \(u_{ij}\in\mathbb C\) for each strict-upper position \(i\lt j\).

Assembly is the piecewise rule

\[
H_{ij}=
\begin{cases}
u_{ij}, & i\lt j,\\
\overline{u_{ji}}, & j\lt i,\\
d_i, & i=j.
\end{cases}
\]

The comparisons are comparisons of fixed finite indices, not random events.
Once \(i\) and \(j\) are fixed, exactly one branch is active for every outcome.
That small observation drives both the algebraic and measurable proofs.

### A three-by-three matrix by hand

Take three real diagonal values \(d_0,d_1,d_2\) and three complex values
\(u_{01},u_{02},u_{12}\). The assembled matrix is

\[
H=
\begin{pmatrix}
d_0 & u_{01} & u_{02}\\
\overline{u_{01}} & d_1 & u_{12}\\
\overline{u_{02}} & \overline{u_{12}} & d_2
\end{pmatrix}.
\]

Reading across the first row uses supplied upper coordinates. Reading down the
first column uses their conjugates. The diagonal is inserted as real data. A
second pass confirms \(H_{ji}=\overline{H_{ij}}\) in every cell, so no
probability argument is needed.

This pattern also explains a physics use. For any complex state vector
\(\psi\), the scalar \(\psi^*H\psi\) is real when \(H\) is Hermitian:

\[
\overline{\psi^*H\psi}
=\psi^*H^*\psi
=\psi^*H\psi.
\]

In finite-dimensional quantum mechanics, a Hermitian \(H\) represents an
observable or Hamiltonian, while, in units where \(\hbar=1\), the
anti-Hermitian \(-iH\) generates unitary time evolution. The Lean file proves
the matrix symmetry needed for the
real-valued quadratic-form calculation, but it does not formalize quantum
states, dynamics, the spectral theorem, or a physical measurement postulate.

## Lineage, local contribution, and nonclaims

The mathematics of Hermitian matrices and product measurable spaces is
standard. The implementation targets the pinned
[Mathlib 4.32.0 release](#ref-mathlib-release) and reuses its official interfaces for
`Matrix.IsHermitian`, function-space measurable structures, finite indices,
and complex conjugation
([Hermitian matrix API](#ref-mathlib-hermitian),
[measurable constructions](#ref-mathlib-measurable),
[finite indices](#ref-mathlib-fin),
[complex numbers](#ref-mathlib-complex)). The project-specific entrywise matrix
measurable space was introduced in the earlier `Basic.lean` module.

This module's local contribution is the narrow bridge later ensemble code
needs:

- a proof-carrying type for strict-upper positions;
- a normalization-free coordinate space;
- direct entry assembly with three named simplification theorems;
- pointwise Hermiticity for every coordinate input;
- a general measurability theorem for coordinate processes;
- a named measurable map on the canonical product space;
- total definitions and simplification theorems at \(n=0\); and
- a constructor for the existing `HermitianRandomMatrix` bundle.

### Not claimed

- The word *coordinate* is algebraic here. No random coordinates are proved
  independent in this module.
- No probability measure or pushforward matrix law is constructed.
- No Gaussian, GUE, GOE, or other ensemble is defined.
- No diagonal or off-diagonal variance and no dimension scaling is selected.
- No density, partition function, covariance operator, or normalization
  constant is stated.
- No unitary invariance, eigenvalue law, trace moment, integrability result,
  spectral statistic, or asymptotic limit is proved.
- The source does not prove a cardinality formula for `StrictUpperIndex`; the
  degree-of-freedom calculation below is explanatory mathematics.

## The real geometry hidden in the entry pattern

An \(n\times n\) Hermitian matrix has \(n\) real diagonal coordinates. It has

\[
\binom n2=\frac{n(n-1)}2
\]

strict-upper positions, and every complex coordinate contributes two real
coordinates. The total real coordinate count is therefore

\[
n+2\binom n2
=n+n(n-1)
=n^2.
\]

That is the real dimension of the vector space of complex Hermitian matrices.
The coordinate representation is not merely storage compression. It is a
global real-linear parameterization of the entire finite-dimensional space.
The current Lean map is expressed as a function, not yet packaged as a linear
equivalence, so linearity, injectivity, surjectivity, and the cardinality
formula are not named theorems in this file.

{{< panel "info" >}}
**Two meanings of independence.** The \(n^2\) coordinates above are free
parameters in an algebraic chart: one can choose them without violating
Hermiticity. That does not make coordinate-valued random variables mutually
independent. Probabilistic independence is an additional law-level hypothesis
and belongs in the next ensemble construction.
{{< /panel >}}

## Camp one: an index that carries its own proof

### `StrictUpperIndex`

```lean
def StrictUpperIndex (n : ℕ) := {ij : Fin n × Fin n // ij.1 < ij.2}
```

The braces describe a Lean subtype. A term contains an index pair and a proof
that its row lies strictly before its column. If `ij : StrictUpperIndex n`,
then `ij.1` is the underlying pair and `ij.2` is the order proof. The official
Lean reference explains how subtypes retain a value together with evidence of
a proposition ([Lean subtypes](#ref-lean-subtypes)).

The strict inequality matters. Replacing it with \(i\le j\) would include the
diagonal and permit complex diagonal coordinates. That would duplicate the
separate real diagonal and weaken the representation of Hermiticity.

### `StrictUpperIndex.instFintype`

`StrictUpperIndex.instFintype` proves that the strict upper triangle is finite.
The implementation unfolds the subtype and lets type-class inference reuse the
finite structure of `Fin n × Fin n` and its finite subtype. Later product
measures and finite sums can therefore index over these coordinates without a
new enumeration.

### `StrictUpperIndex.instDecidableEq`

`StrictUpperIndex.instDecidableEq` gives decidable equality on proof-carrying
upper indices. Again the proof is inherited after unfolding. Lean's proof
irrelevance means two subtype terms with the same pair are not distinguished
because their inequality proofs were constructed differently.

### `StrictUpperIndex.instIsEmptyZero`

`StrictUpperIndex.instIsEmptyZero` records the first boundary fact:
`StrictUpperIndex 0` has no elements. Any supposed member contains a first
coordinate of type `Fin 0`; `Fin.elim0` eliminates that impossible value
([Lean finite natural numbers](#ref-lean-fin)). This
explicit instance lets later zero-dimensional code ask Lean for emptiness
directly instead of replaying the contradiction.

### `HermitianCoordinateSpace`

```lean
abbrev HermitianCoordinateSpace (n : ℕ) :=
  (Fin n → ℝ) × (StrictUpperIndex n → ℂ)
```

`HermitianCoordinateSpace` is an abbreviation for a product of two function
spaces. The first function supplies a real diagonal. The second supplies the
complex strict upper triangle. Because it is an `abbrev`, Lean can unfold it
transparently when projections or measurable-space instances are needed. No
law, topology beyond the inherited coordinate types, or distribution is part
of this abbreviation.

## Camp two: direct assembly without a hidden factor

### `RandomMatrix.hermitianFromCoordinates`

`RandomMatrix.hermitianFromCoordinates d u` implements the three-region rule
literally. Its first dependent `if` tests \(i\lt j\). If false, the second tests
\(j\lt i\). If both are false, linear order forces equality, and the diagonal
branch returns `d i`, coerced from \(\mathbb R\) to \(\mathbb C\).

The upper and lower branches build subtype values such as
`⟨(i, j), hij⟩`. The branch proof `hij` is exactly the evidence required to
index `u`. The function is total for every natural dimension, including zero.

### `RandomMatrix.hermitianFromCoordinates_apply_diag`

`hermitianFromCoordinates_apply_diag` says that the diagonal is exactly the
supplied real value:

\[
H_{ii}=d_i.
\]

Both strict comparisons \(i\lt i\) simplify to false, so `simp` reaches the final
branch. The theorem is marked `[simp]`, allowing later proofs to reduce a
diagonal lookup automatically.

### `RandomMatrix.hermitianFromCoordinates_apply_upper`

Given `hij : i < j`,
`hermitianFromCoordinates_apply_upper` reduces the entry to the exact supplied
coordinate `u ⟨(i, j), hij⟩`. There is no rescaling, conjugation, or addition.
The proof supplies `hij` to the definition and lets `simp` select the first
branch.

### `RandomMatrix.hermitianFromCoordinates_apply_lower`

Given `hji : j < i`,
`hermitianFromCoordinates_apply_lower` returns

\[
H_{ij}=\overline{u_{ji}}.
\]

The proof first derives `¬ i < j` from `hji`, preventing the first branch from
firing. Simplification then selects the lower branch. The star operation is
complex conjugation here.

### Why not reuse `X + Xᴴ`?

The earlier module deliberately defines unnormalized Hermitian
symmetrization. For an arbitrary matrix \(X\),

\[
(X+X^*)_{ii}=X_{ii}+\overline{X_{ii}}=2\operatorname{Re}(X_{ii}).
\]

If a real diagonal coordinate \(d_i\) were placed into \(X_{ii}\), that
constructor would return \(2d_i\), not \(d_i\). Dividing by two would inject a
scale choice into a function whose job is only to assemble coordinates.
Direct insertion gives the exact coordinate semantics needed for later
variance ledgers.

The same distinction protects off-diagonal meaning. A future law attached to
`u ⟨(i,j),hij⟩` should become the law of \(H_{ij}\) without an unnoticed sum
of two source variables. The direct branch makes that relationship
definitionally transparent.

## High camp one: Hermiticity by index trichotomy

### `RandomMatrix.hermitianFromCoordinates_isHermitian`

`hermitianFromCoordinates_isHermitian` proves

\[
\bigl(\operatorname{hermitianFromCoordinates}(d,u)\bigr)^*
=\operatorname{hermitianFromCoordinates}(d,u)
\]

for every input. The proof rewrites Mathlib's matrix predicate with
`Matrix.IsHermitian.ext_iff`, reducing a matrix equality to entries. It then
uses `lt_trichotomy i j`, which gives exactly three cases.

1. If \(i\lt j\), the right-hand entry is `u` and its reflected partner is
   `star u`; simplifying the double star closes the goal.
2. If \(i=j\), the entry is the embedded real value `d i`, which complex
   conjugation fixes.
3. If \(j\lt i\), the upper and lower simplification theorems reverse their roles
   and close the symmetric case.

No coordinate hypothesis appears because the output is Hermitian by
construction. In particular, neither measurability nor independence is needed
for this algebraic theorem.

{{< panel "info" >}}
**Proof orientation.** Mathlib's `IsHermitian.ext_iff` presents the entry goal
as `star (H j i) = H i j`. It is easy to write the desired conjugate equality
in the opposite direction on paper. The three application lemmas remove that
orientation ambiguity before `simp` handles conjugation.
{{< /panel >}}

## High camp two: measurability is entrywise

### `RandomMatrix.measurable_hermitianFromCoordinates`

Let the coordinates vary with an outcome \(\omega\):

\[
d:\Omega\to(\operatorname{Fin}(n)\to\mathbb R),
\qquad
u:\Omega\to(\operatorname{StrictUpperIndex}(n)\to\mathbb C).
\]

The theorem assumes ordinary measurability of each scalar coordinate:

\[
\omega\mapsto d(\omega)_i
\quad\text{and}\quad
\omega\mapsto u(\omega)_{ij}.
\]

It concludes that the assembled matrix-valued map is measurable. The proof
starts with the project's `measurable_iff_entries`, so it suffices to fix
\(i,j\) and prove measurability of one entry.

The two `by_cases` decisions are made on the fixed propositions \(i\lt j\) and
\(j\lt i\). They do not partition the outcome space. In the upper branch, the
corresponding hypothesis `hu` is the whole proof. In the lower branch,
measurable complex conjugation composes with `hu`. In the diagonal branch,
the measurable real coordinate composes with the canonical real-to-complex
map. The `fun_prop` tactic discharges those standard function-property
compositions.

This theorem asks for `Measurable`, not merely `AEMeasurable`. An exact
`HasLaw` statement elsewhere may provide only almost-everywhere measurability;
it cannot silently satisfy these stronger premises. The distinction keeps the
deterministic map reusable under any later probability measure.

### `RandomMatrix.hermitianCoordinateMap`

`hermitianCoordinateMap n` names the uncurried function

\[
(d,u)\longmapsto\operatorname{hermitianFromCoordinates}(d,u).
\]

Naming the map matters at the law level. A later ensemble can place a measure
on `HermitianCoordinateSpace n` and push it through this one deterministic
map. The present definition does not perform that pushforward.

### `RandomMatrix.measurable_hermitianCoordinateMap`

`measurable_hermitianCoordinateMap` proves that the named map is measurable
for the inherited product measurable space. The proof invokes the general
assembly theorem and supplies its hypotheses from canonical projections:

- `measurable_fst` reaches the diagonal function;
- `measurable_pi_apply i` evaluates it at a fixed diagonal index;
- `measurable_snd` reaches the upper-coordinate function; and
- `measurable_pi_apply ij` evaluates it at a fixed strict-upper index.

Composition gives each requested scalar coordinate. This proof is the formal
bridge between a product measure on coordinates and a later measurable
pushforward to matrices
([Mathlib measurable constructions](#ref-mathlib-measurable)).

## The zero-dimensional boundary is a theorem

Dimension zero is not an error case. `Fin 0` has no values, so the diagonal
function is the unique function out of an empty type. The explicit
`StrictUpperIndex.instIsEmptyZero` instance says the same for the upper
triangle. Their product is therefore a one-point coordinate space.

A zero-by-zero matrix is a function `Fin 0 → Fin 0 → ℂ`. It too is unique.
The matrix called zero and the matrix returned by any assembly input must be
the same function.

### `RandomMatrix.hermitianFromCoordinates_zero`

`hermitianFromCoordinates_zero` proves that every zero-dimensional input
assembles to the zero matrix. The proof applies matrix extensionality and then
uses `Fin.elim0` on the impossible row index. No entry branch needs to be
evaluated.

### `RandomMatrix.hermitianCoordinateMap_zero`

`hermitianCoordinateMap_zero` specializes the named map. It unfolds to the
previous theorem on the two projections of its coordinate input. Marking both
zero theorems `[simp]` makes later boundary calculations executable.

This design is normalization-free. It does not divide by \(n\), so \(n=0\)
does not force an arbitrary replacement for \(1/n\). A future ensemble module
must still decide what probability law and scaling convention it assigns in
dimension zero, but the deterministic map is already total.

## Summit camp: bundle measurable coordinate processes

### `HermitianRandomMatrix.ofCoordinates`

The existing `HermitianRandomMatrix Ω (Fin n)` structure stores a measurable
matrix-valued map and proof that every realization is Hermitian.
`HermitianRandomMatrix.ofCoordinates` builds that structure from coordinate
processes `d` and `u` plus their entrywise measurability proofs.

Its three structure fields are filled directly:

- `toRandomMatrix` is coordinate assembly at each outcome;
- `measurable_toRandomMatrix` is
  `RandomMatrix.measurable_hermitianFromCoordinates hd hu`; and
- `isHermitian` applies
  `RandomMatrix.hermitianFromCoordinates_isHermitian` pointwise.

The result is stronger than an almost-surely Hermitian map. It is Hermitian at
every outcome, including outcomes that a later measure might assign
probability zero.

### `HermitianRandomMatrix.ofCoordinates_apply`

`ofCoordinates_apply` exposes the underlying matrix at an outcome:

\[
\operatorname{ofCoordinates}(d,u,h_d,h_u)(\omega)
=\operatorname{hermitianFromCoordinates}(d(\omega),u(\omega)).
\]

The proof is `rfl`: the equality holds by unfolding the constructor and the
bundle's function coercion. Marking it `[simp]` lets downstream entry proofs
move from the bundled object to the concrete assembly without manual record
unpacking.

## The complete declaration map

| Public declaration | Checked content | Main proof mechanism |
|---|---|---|
| `StrictUpperIndex` | Proof-carrying pairs \(i\lt j\) | Subtype definition |
| `StrictUpperIndex.instFintype` | The upper index type is finite | Unfold, then type-class inference |
| `StrictUpperIndex.instDecidableEq` | Equality of upper indices is decidable | Unfold, then type-class inference |
| `StrictUpperIndex.instIsEmptyZero` | There is no upper coordinate at \(n=0\) | Eliminate `Fin 0` |
| `HermitianCoordinateSpace` | Real diagonal times complex strict upper triangle | Transparent abbreviation |
| `RandomMatrix.hermitianFromCoordinates` | Direct three-region matrix assembly | Two dependent conditionals |
| `RandomMatrix.hermitianFromCoordinates_apply_diag` | Exact diagonal lookup | `simp` |
| `RandomMatrix.hermitianFromCoordinates_apply_upper` | Exact upper lookup | `simp` with \(i\lt j\) |
| `RandomMatrix.hermitianFromCoordinates_apply_lower` | Conjugate reflected lower lookup | Derive `¬ i < j`, then `simp` |
| `RandomMatrix.hermitianFromCoordinates_isHermitian` | Every assembled matrix is Hermitian | Entry extensionality and trichotomy |
| `RandomMatrix.measurable_hermitianFromCoordinates` | Measurable scalar processes assemble measurably | Entrywise criterion, static cases, `fun_prop` |
| `RandomMatrix.hermitianCoordinateMap` | Named uncurried coordinate map | Definition by projections |
| `RandomMatrix.measurable_hermitianCoordinateMap` | Canonical coordinate map is measurable | Product projections and evaluation maps |
| `RandomMatrix.hermitianFromCoordinates_zero` | Zero-dimensional assembly is the zero matrix | Extensionality and `Fin.elim0` |
| `RandomMatrix.hermitianCoordinateMap_zero` | The zero-dimensional named map is zero | Previous zero theorem |
| `HermitianRandomMatrix.ofCoordinates` | Measurable coordinate processes form a bundled Hermitian random matrix | Fill structure fields with checked theorems |
| `HermitianRandomMatrix.ofCoordinates_apply` | Bundle evaluation is concrete assembly | Definitional equality |

The map contains exactly seventeen named public declarations in this version
of the module. Generated projections from existing structures are not new
declarations in this file.

## Run the checked source

From the repository root on macOS or Linux, load elan and invoke Lean through
the pinned Lake environment:

```sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomMatrices/HermitianCoordinates.lean
```

To build the whole library and the draft teaching site, return to the
repository root and run:

```sh
cd ..
make check
```

The first command checks this file directly and promotes warnings to errors.
The second rebuilds the complete Lean target, validates the proof-to-prose
coverage and checkpoint, and renders all Hugo drafts with warnings fatal.

For a small API-oriented session, the following file is complete Lean code:

```lean
import NonlinearDynamics.Random.RandomMatrices.HermitianCoordinates

open Matrix MeasureTheory
open scoped Matrix

open NonlinearDynamics.Random

#check StrictUpperIndex
#check HermitianCoordinateSpace
#check RandomMatrix.hermitianFromCoordinates
#check RandomMatrix.hermitianFromCoordinates_isHermitian
#check RandomMatrix.measurable_hermitianCoordinateMap
#check HermitianRandomMatrix.ofCoordinates
```

Save it inside `formalization` and run it with `lake env lean`. The snippet
contains no omitted terms or noncompiling ellipses.

## Failure modes the API is designed to expose

| Tempting shortcut | What goes wrong | Checked repair |
|---|---|---|
| Store every matrix entry independently | Lower and upper entries may violate conjugate symmetry | Store only the strict upper triangle and reflect it |
| Include \(i=j\) in the complex upper coordinates | The diagonal is duplicated and may cease to be real | Use strict inequality in `StrictUpperIndex` |
| Assemble with `X + Xᴴ` | A real diagonal inserted into \(X\) is doubled | Use direct three-region insertion |
| Forget conjugation below the diagonal | The output is generally transpose-symmetric, not Hermitian | Lower theorem returns `star` of the mirrored coordinate |
| Treat the index branch as outcome-dependent | The measurability proof looks harder than it is | Fix \(i,j\), then split on their static order |
| Infer ordinary measurability from an arbitrary exact law | `HasLaw` may supply only almost-everywhere measurability | Pass explicit `Measurable` coordinate hypotheses |
| Read “free coordinates” as random independence | Algebraic freedom says nothing about a joint probability law | Add independence only in the future coordinate measure |
| Insert \(1/n\) into deterministic assembly | Dimension zero becomes undefined and scale becomes hidden | Keep assembly normalization-free |
| Prove Hermiticity only almost everywhere | A structural identity is unnecessarily weakened | Use the pointwise trichotomy theorem |
| Unpack the bundle manually downstream | Proofs become tied to record layout | Rewrite with `ofCoordinates_apply` |

## Exercises with solutions

### Exercise 1: reconstruct a two-by-two input

Let \(d_0=2\), \(d_1=-1\), and \(u_{01}=3+4i\). Write the assembled matrix and
check one off-diagonal Hermitian equality.

**Solution.** Direct assembly gives

\[
H=
\begin{pmatrix}
2 & 3+4i\\
3-4i & -1
\end{pmatrix}.
\]

The reflected equality is
\(H_{10}=3-4i=\overline{3+4i}=\overline{H_{01}}\).
`hermitianFromCoordinates_apply_upper` and
`hermitianFromCoordinates_apply_lower` are the two Lean lemmas that expose
those entries.

### Exercise 2: locate the factor of two

Place the same real diagonal into a matrix \(X\) and compare direct assembly
with `X + Xᴴ` on the diagonal.

**Solution.** Direct assembly returns \(d_i\). Symmetrization returns
\(d_i+\overline{d_i}=2d_i\). The mismatch is deterministic and occurs before
any variance is chosen. This is why the module introduces a separate direct
constructor instead of reusing `hermitianSymmetrization`.

### Exercise 3: count coordinates at dimension four

How many real parameters are present in `HermitianCoordinateSpace 4`?

**Solution.** There are four real diagonal values and
\(\binom 42=6\) complex upper values. Complex coordinates contribute twelve
real parameters, so the total is \(4+12=16=4^2\). The module represents these
coordinates, but does not yet contain this cardinality theorem.

### Exercise 4: identify the exact measurability hypotheses

Suppose \(d_i(\omega)\) is measurable for every diagonal index and
\(u_{ij}(\omega)\) is measurable for every strict-upper index. Which theorem
produces the matrix-valued measurable map, and which theorem packages it in
the canonical coordinate space?

**Solution.** Use
`RandomMatrix.measurable_hermitianFromCoordinates` for arbitrary coordinate
processes. Use `RandomMatrix.measurable_hermitianCoordinateMap` when the sample
space itself is `HermitianCoordinateSpace n` and the processes are the two
canonical projections.

### Exercise 5: explain dimension zero without entries

Why does the proof of `hermitianFromCoordinates_zero` not inspect the
piecewise definition?

**Solution.** Matrix extensionality asks for a row index of type `Fin 0`.
`Fin.elim0` eliminates it immediately. Since no row exists, there is no cell at
which two zero-dimensional matrices can differ.

### Exercise 6: choose the weakest honest theorem

A later proof only needs to know that one deterministic assembled matrix is
Hermitian. Should it invoke the measurable theorem, the bundled constructor,
or the pointwise algebraic theorem?

**Solution.** Use
`RandomMatrix.hermitianFromCoordinates_isHermitian`. It asks for no measurable
space and no coordinate measurability. Adding those hypotheses would make the
statement stronger than the conclusion requires.

## The next ridge: push a law through the map

The module has now separated two layers cleanly:

1. a deterministic, measurable assembly map; and
2. probability laws that may later be placed on its coordinate domain.

The next ensemble slice can select an explicit normalization ledger, construct
a joint coordinate probability measure, and define the matrix law as the
pushforward

\[
\mu_H =
(\operatorname{hermitianCoordinateMap}(n))_*\mu_{\mathrm{coord}}.
\]

That later file must state the diagonal variances, the real and imaginary
upper-coordinate variances, their dimension dependence, the independence
scope, and a zero-dimensional policy. Only after those choices are checked can
the name GUE be attached honestly. Unitary invariance is a further theorem,
not a consequence of the word “Gaussian.”

The present constructor is valuable precisely because it does less. Every
future probabilistic statement will pass through one map whose entry behavior,
Hermiticity, measurability, and empty boundary have already been proved.

## References

The official documentation links below were checked on 2026-07-21. The local
Mathlib 4.32.0 checkout is the API authority for the checked proof, and the
release named by `lakefile.toml` is the reproducibility pin.

<a id="ref-mathlib-release"></a>
**Mathlib contributors.**
[Mathlib 4.32.0 release](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
2026. This is the exact dependency release used by the project.

<a id="ref-mathlib-hermitian"></a>
**Mathlib contributors.**
[Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html),
Mathlib 4 documentation. This is the official source for
`Matrix.IsHermitian`, `Matrix.IsHermitian.ext_iff`, and the entrywise symmetry
interface used by the proof.

<a id="ref-mathlib-measurable"></a>
**Mathlib contributors.**
[Measurable-space constructions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/MeasurableSpace/Constructions.html),
Mathlib 4 documentation. This official module defines product and function
measurable spaces together with `measurable_fst`, `measurable_snd`,
`measurable_pi_iff`, and `measurable_pi_apply`.

<a id="ref-mathlib-fin"></a>
**Mathlib contributors.**
[Finite natural-number types](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/Fin/Basic.html),
Mathlib 4 documentation. This is the official finite-index API used for
`Fin n` and the impossible `Fin 0` boundary.

<a id="ref-mathlib-complex"></a>
**Mathlib contributors.**
[Complex numbers](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/Complex/Basic.html),
Mathlib 4 documentation. This official module supplies complex conjugation and
the star structure simplified in the Hermiticity proof.

<a id="ref-lean-subtypes"></a>
**Lean developers.**
[Subtypes](https://lean-lang.org/doc/reference/latest/Basic-Types/Subtypes/),
*Lean Language Reference*. This official reference explains values paired with
proofs, the representation used by `StrictUpperIndex`.

<a id="ref-lean-fin"></a>
**Lean developers.**
[Finite natural numbers](https://lean-lang.org/doc/reference/latest/Basic-Types/Finite-Natural-Numbers/),
*Lean Language Reference*. This official reference documents `Fin n` as a
natural number carrying an upper-bound proof.
