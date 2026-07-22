---
title: "Random Matrices: From Outcomes to Spectra"
slug: "random-matrices-from-outcomes-to-spectra"
date: 2026-07-20
summary: "A guided ascent from probability spaces and measurable coordinates to Hermitian symmetry, spectral observables, and the foundations consumed by a finite Gaussian unitary ensemble law."
lead: "Start with one random number. Add a second index. By the summit, the object is a random operator whose eigenvalues encode collective structure that no entry reveals alone."
draft: false
pro_reviewed: false
level: "Base camp to advanced"
reading_time: "35 to 50 minutes"
prerequisites: "Algebra of complex numbers; no prior measure theory or Lean required"
lean_module: "NonlinearDynamics.Random.RandomMatrices.Basic"
og_image: "random-matrices-card.png"
og_image_alt: "A warm-paper teaching card showing an outcome becoming a structured matrix and then a spectrum of eigenvalue points."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The canonical
author disclosure is intentionally pending until the human author has
inspected the prose, cited sources, equations, and Lean artifacts. The page is
publicly available as an open working note while that review remains pending.
{{< /panel >}}

Random matrix theory begins with an object that sounds almost trivial: a
matrix whose value is random. The subject becomes profound because matrices
carry geometry. They act on vectors, encode couplings, possess eigenvalues,
and remember symmetries. Randomness enters through the entries, but the most
interesting questions concern the collective structure of the entire matrix.

This chapter builds that idea twice. The mathematical path begins with events
and measurable functions, then reaches Hermitian matrices and spectra. The Lean
path follows the same ascent, exposing each hidden assumption as a type,
instance, definition, or theorem.

{{< panel "info" >}}
**Current continuation.** This chapter began with the foundational matrix
modules. The project has since constructed the Wigner-scaled finite Gaussian
unitary ensemble (GUE) coordinate and matrix laws, including exact marginals,
independence, the zero-dimensional Dirac boundary, intrinsic unitary
invariance, and the first two integrable trace moments. RMT-10A also constructs
the ordered finite Hermitian spectrum and zero-aware empirical spectral
measure. Follow
[Finite Hermitian Spectra and Empirical Measures]({{< relref "/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures" >}})
for that current layer. Coordinatewise eigenvalue measurability, an
unconditional random spectral law, densities, and large-dimension limits
remain later work.
{{< /panel >}}

## Choose a route up the mountain

| Route | Begin here | Destination |
|---|---|---|
| First encounter | Sample spaces and random variables | Understand what a random matrix actually is |
| Probability reader | Coordinate measurability | See why entrywise arguments are enough in finite dimensions |
| Linear algebra reader | Hermitian symmetry | Connect matrix structure to real spectra |
| Lean reader | The project encoding | Read every declaration in `RandomMatrices.Basic` |
| Research horizon | Beyond the current file | See the path through finite GUE toward trace moments and random stability |

### Learning objectives

By the end, you should be able to:

1. distinguish a matrix-valued random variable from its realization and its
   {{< refterm "probability-law" "probability law" >}};
2. explain why coordinate measurability is the correct measurable structure on a matrix space;
3. derive the conjugate-transpose, addition, multiplication, and symmetrization closure results;
4. explain why Hermitian matrices are the finite-dimensional gateway to spectral physics;
5. read the core Lean proofs without treating typeclass inference as magic; and
6. identify how the checked finite GUE law extends this foundation and which
   density, symmetry, spectral, and moment theorems remain.

## The complete ascent in one picture

{{< mermaid >}}
flowchart LR
  A[Outcome omega] --> B[Random matrix X omega]
  B --> C[Hermitian matrix H omega]
  C --> D[Real eigenvalues]
  D --> E[Spectral statistics]
  F[Measurable space] -. makes X observable .-> B
  G[Probability measure] -. gives X a law .-> B
  H[Symmetry and normalization] -. define an ensemble .-> C
{{< /mermaid >}}

<p class="figure-note"><strong>Reading the map.</strong> An outcome selects a matrix. Measurability lets probability reach that matrix, and the checked law layer records the resulting pushforward measure. Hermitian symmetry makes spectral questions physically and mathematically well behaved. The later RMT-06 module now supplies Gaussian, dependence, and normalization data for one finite GUE law; its invariant and spectral analysis remain beyond this map.</p>

## Base camp: from events to random variables

Probability does not begin with numbers. It begins with a set
\(\Omega\) of possible outcomes and a collection \(\mathcal F\) of
events we agree can be measured. The pair
\((\Omega,\mathcal F)\) is a
{{< refterm "measurable-space" "measurable space" >}}. Adding a probability
measure \(\mathbb P\) produces a probability space.

A real random variable is then a measurable function

\[
Y : \Omega \longrightarrow \mathbb R.
\]

The function is measurable when every measurable target set pulls back to an
event in \(\mathcal F\). If \(B\subseteq\mathbb R\) is measurable,
then

\[
\{\omega : Y(\omega)\in B\}
=Y^{-1}(B)
\]

must be an event to which \(\mathbb P\) can assign a probability.

This definition is less about technical ceremony than about legal questions.
Before asking for the probability that \(Y\) lands in a region, we must know
that the region's preimage is visible to the measure.

## First ridge: add matrix coordinates

Replace the scalar target with a matrix space:

\[
X : \Omega \longrightarrow \mathbb K^{m\times n}.
\]

Before measurability is established, this is only a matrix-valued map. It is a
{{< refterm "random-matrix" "random matrix" >}} in the standard probability
sense once that map is measurable. Each outcome \(\omega\) selects one
ordinary matrix \(X(\omega)\). Fixing a row \(i\) and column \(j\)
produces the scalar coordinate map

\[
X_{ij} : \Omega \longrightarrow \mathbb K,
\qquad
X_{ij}(\omega)=X(\omega)_{ij}.
\]

The natural measurable structure on matrices is the product structure generated
by these coordinates. Under that structure,

\[
X \text{ is measurable}
\quad\Longleftrightarrow\quad
X_{ij} \text{ is measurable for every }i,j.
\]

This equivalence is the central theorem of the first Lean file. It is also a
major simplification. Instead of reasoning directly about arbitrary measurable
sets in a matrix space, later proofs can descend to scalar entries.

{{< panel "definition" >}}
**Three layers, kept separate.** The map \(X\) tells us which matrix each
outcome selects. Its {{< refterm "probability-law" "law" >}} tells us how
probability mass is distributed over matrix space through a
{{< refterm "pushforward-measure" "pushforward measure" >}}. Conditions such
as independence, identical distribution,
Gaussianity, and Hermitian symmetry describe special classes of such maps or
laws. None follows from the word "random."
{{< /panel >}}

## Why matrix entries do not have to be independent

The coordinate criterion concerns measurability, not dependence. Consider the
two-by-two Hermitian pattern

\[
H=
\begin{bmatrix}
a & z \\
\overline z & b
\end{bmatrix}.
\]

Once \(z\) is chosen, the reflected entry is forced to be
\(\overline z\). Those coordinates are maximally dependent. They are still
individually measurable, and therefore the matrix-valued map is measurable.

This distinction is now implemented by the finite GUE constructor. The
independent primitive variables live on one triangle and the real diagonal.
Hermitian reflection then determines the rest. Saying "all entries are
independent" would destroy the defining symmetry.

## The Lean representation: a matrix is a two-index function

Mathlib represents a matrix with row type \(\iota\), column type
\(\kappa\), and value type \(\mathbb K\) as `Matrix ι κ 𝕜`.
The equivalence `Matrix.of` connects this type to the curried function space
`ι → κ → 𝕜`.

The project starts with the least opinionated matrix-valued map:

```lean
abbrev RandomMatrix
    (Ω : Type uΩ) (ι : Type uι) (κ : Type uκ) (𝕜 : Type u𝕜) :=
  Ω → Matrix ι κ 𝕜
```

There is deliberately no probability measure in this abbreviation. There is
not even a measurability field. `RandomMatrix` is therefore a convenient
project name for the carrier type, not by itself a certificate that a term is
a random variable in the standard measure-theoretic sense. The same underlying
map can later be studied under different measures, and deterministic matrix
families remain usable without carrying probabilistic baggage.

### Installing the missing measurable structure

At Mathlib 4.32.0, the imported modules do not supply the particular
entrywise `MeasurableSpace` instance needed here. The project constructs it:

```lean
instance instMeasurableSpaceMatrix [MeasurableSpace 𝕜] :
    MeasurableSpace (Matrix ι κ 𝕜) :=
  MeasurableSpace.comap Matrix.of.symm inferInstance
```

Read the right side from the inside out:

1. `inferInstance` finds the iterated function-space measurable structure on
   `ι → κ → 𝕜`.
2. `Matrix.of.symm` views a matrix as that two-argument function.
3. `MeasurableSpace.comap` transports the measurable structure back to the
   matrix type.

The word **comap** is doing conceptual work. We know how coordinates should be
measured on the function representation, so we pull that structure back along
an equivalence.

The claim above is release-specific. It was checked against
[Mathlib 4.32.0](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
the version pinned by this repository. The
[pinned matrix source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/LinearAlgebra/Matrix/Defs.lean)
and
[pinned measurable-space source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/MeasurableSpace/Basic.lean)
make the implementation context reproducible even after the generated latest
documentation changes.

{{< panel "info" >}}
**A maintainability note.** This is a global typeclass instance, even though
its declaration name sits in the project namespace. If a future Mathlib
release introduces the same canonical matrix instance, this project should
remove or reconcile its local instance during the upgrade.
{{< /panel >}}

## The coordinate theorem, one proof step at a time

The theorem statement is the mathematics we want:

```lean
theorem measurable_iff_entries (X : RandomMatrix Ω ι κ 𝕜) :
    Measurable X ↔ ∀ i j, Measurable fun ω ↦ X ω i j := by
  rw [measurable_comap_iff]
  change Measurable (fun ω i j ↦ X ω i j) ↔ _
  simp only [measurable_pi_iff]
```

The proof has three moves:

1. `measurable_comap_iff` unfolds what measurability means after the target
   structure was installed by a comap.
2. `change` presents the matrix-valued function as an explicitly curried
   coordinate function.
3. `measurable_pi_iff` says that a function into a product of measurable
   spaces is measurable exactly when each coordinate is measurable.

The short proof is not a trick. It succeeds because the instance was chosen to
make the mathematical interface true by construction.

{{< checkpoint stage="Base camp" title="Test the coordinate picture" >}}
Imagine hiding every matrix except one coordinate at a time. If every resulting
scalar observation is measurable, the product structure lets you reconstruct
measurability of the entire matrix-valued map. Independence never entered the
argument.
{{< /checkpoint >}}

### Extracting one coordinate

The next theorem packages the forward direction:

```lean
theorem measurable_entry {X : RandomMatrix Ω ι κ 𝕜}
    (hX : Measurable X) (i : ι) (j : κ) :
    Measurable fun ω ↦ X ω i j :=
  (measurable_iff_entries X).mp hX i j
```

This small lemma becomes the workhorse for every closure proof that follows.

## Closure under the operations matrix theory needs

The foundation proves that several pointwise matrix operations preserve
measurability.

| Operation | Entry-level reason |
|---|---|
| Transpose | Output entry \((i,j)\) is input entry \((j,i)\) |
| Scalar map | Compose each entry with a measurable scalar function |
| Constant matrix | Every coordinate is a constant measurable function |
| Conjugate transpose | Swap indices, then apply continuous complex conjugation |
| Addition | Add two measurable scalar coordinates |
| Multiplication | Take a finite sum of products of measurable coordinates |

The multiplication theorem explains why the shared index has a `Fintype`
assumption. Matrix multiplication uses

\[
(XY)_{ik}=\sum_j X_{ij}Y_{jk}.
\]

Each summand is measurable because products of measurable complex functions
are measurable. The finite sum remains measurable. Infinite-dimensional
operator products require a different analytic interface, so this theorem does
not pretend to cover them.

## High camp: Hermitian symmetry

For complex matrices, the
{{< refterm "conjugate-transpose" "conjugate transpose" >}} is

\[
(A^*)_{ij}=\overline{A_{ji}}.
\]

A {{< refterm "hermitian-matrix" "Hermitian matrix" >}} satisfies
\(A^*=A\). This is the matrix analogue of a self-adjoint operator.

The finite-dimensional spectral theorem gives the reward: a Hermitian complex
matrix has real eigenvalues and can be diagonalized by a unitary change of
basis. Hermitian realizations therefore have real spectra sample by sample,
even though their entries may be complex
([Mathlib contributors](#ref-mathlib-spectrum)).

Turning an ordered eigenvalue into a scalar random variable requires a separate
measurability theorem. The current project has not yet proved that step.

That property is central in quantum mechanics. A finite-dimensional Hamiltonian
is represented by a Hermitian matrix so that measured energy levels are real.
Random matrix ensembles do not claim that a complicated Hamiltonian literally
has independent random entries. They provide symmetry-constrained statistical
models for spectral questions after microscopic detail is set aside.

Historically, Wigner used random-matrix ideas to study the statistical behavior
of complex nuclear spectra, and Dyson organized orthogonal, unitary, and
symplectic symmetry classes
([Wigner, 1955](#ref-wigner-1955);
[Dyson, 1962](#ref-dyson-1962);
[Dyson, 1962, Threefold Way](#ref-dyson-threefold)). Those works motivate the
subject, but the present Lean file proves only the finite algebraic and
measurable foundation.

## A constructor that cannot miss Hermitian symmetry

Given any square complex matrix \(A\), define

\[
\operatorname{sym}(A)=A+A^*.
\]

Then

\[
\operatorname{sym}(A)^*
=(A+A^*)^*
=A^*+A
=A+A^*
=\operatorname{sym}(A).
\]

The project calls this **unnormalized Hermitian symmetrization**. Some contexts
use \((A+A^*)/2\), which is the projection onto the Hermitian part. Other
random-matrix constructions use dimension-dependent scaling to control the
spectral radius. Naming the current constructor as unnormalized prevents an
algebraic convenience from silently becoming an ensemble convention.

### A complete two-by-two example

Take

\[
A=
\begin{bmatrix}
1+i & 2-i \\
3+4i & -i
\end{bmatrix}.
\]

Its conjugate transpose is

\[
A^*=
\begin{bmatrix}
1-i & 3-4i \\
2+i & i
\end{bmatrix},
\]

so

\[
A+A^*=
\begin{bmatrix}
2 & 5-5i \\
5+5i & 0
\end{bmatrix}.
\]

The diagonal is real, and the off-diagonal entries are conjugate pairs. This
is not an observed dataset or a model fit. It is a toy calculation chosen so
every part of the definition is visible.

## Pointwise truth and almost-sure truth

For a random matrix \(X\), symmetrization is applied sample by sample:

\[
\omega \longmapsto X(\omega)+X(\omega)^*.
\]

The project proves this matrix is Hermitian for **every** outcome. It then
defines the weaker measure-dependent property

\[
X(\omega) \text{ is Hermitian for }\mu\text{-almost every }\omega.
\]

See {{< refterm "almost-everywhere" "almost everywhere" >}} for the distinction.
Because a pointwise theorem allows no exceptions, the almost-everywhere result
follows for any measure without further calculation.

{{< checkpoint stage="High camp" title="Do not spend a stronger theorem" >}}
The constructor is Hermitian at every sample. Keep that pointwise fact available
for exact ensemble constructors, then derive an almost-everywhere theorem only
when a measure-dependent API asks for it. Replacing the stronger statement too
early would discard useful information.
{{< /checkpoint >}}

In Lean:

```lean
def IsHermitianAE (X : RandomMatrix Ω ι ι ℂ) (μ : Measure Ω) : Prop :=
  ∀ᵐ ω ∂μ, (X ω).IsHermitian

theorem hermitianSymmetrization_isHermitianAE
    (X : RandomMatrix Ω ι ι ℂ) (μ : Measure Ω) :
    IsHermitianAE (hermitianSymmetrization X) μ :=
  Filter.Eventually.of_forall (hermitianSymmetrization_isHermitian X)
```

The proof term `Eventually.of_forall` is exactly the logical bridge: what is
true everywhere is eventually true in the almost-everywhere filter.

## What the base module proves

The current foundation establishes:

- a reusable matrix-valued map type;
- the entrywise measurable structure on matrix spaces;
- an if-and-only-if coordinate criterion for measurability;
- measurable transpose, scalar mapping, constants, conjugate transpose,
  addition, and finite matrix multiplication;
- an explicitly unnormalized Hermitian symmetrization;
- pointwise Hermitian symmetry of that constructor; and
- the corresponding almost-everywhere statement for an arbitrary measure.

Every item above is checked by Lean 4.32.0 against Mathlib 4.32.0.

## Four more checked ridges

The project now builds four modules on top of that base.

`RandomMatrices.Hermitian` separates pointwise, almost-everywhere, and
measurable Hermitian conditions. It bundles a measurable matrix that is
Hermitian at every realization, proves real diagonal entries and real traces,
and constructs congruence transforms \(AHA^*\) without pretending that an
arbitrary \(A\) gives {{< refterm "unitary-invariance" "unitary invariance" >}}.
Follow its complete proof narrative
in [Packaging Hermitian Random Matrices]({{< relref "/development-notebook/2026/07/hermitian-random-matrices" >}}).

`RandomMatrices.Observables` defines the scalar observable
\(\omega\mapsto\operatorname{tr}(X(\omega)^k)\), proves it measurable,
and proves it real for Hermitian realizations. It does not yet take an
expectation. Follow that boundary in
[Trace Powers Before Moments]({{< relref "/development-notebook/2026/07/trace-power-observables" >}}).

<code>RandomMatrices.Laws</code> defines
<code>RandomMatrix.law</code> as an explicit measurable pushforward, proves
evaluation, composition, probability-measure, and Dirac rules, and gives
bundled Hermitian laws. It defines
<code>IsUnitaryConjugationInvariant</code>, proves the zero measure and the
Dirac law at the zero matrix invariant, and proves
<code>law_conjugateBy</code>. That last theorem identifies the law of
\(AXA^*\) as a pushforward. It does not say that this law is unchanged. Read
the complete declaration-by-declaration account in
[From Random Matrices to Laws]({{< relref "/development-notebook/2026/07/from-random-matrices-to-laws" >}}).

<code>RandomMatrices.HermitianCoordinates</code> defines the finite strict
upper triangle, pairs it with a real diagonal, and assembles both directly
into a Hermitian matrix. It proves the diagonal, upper, and lower entry
formulas, pointwise Hermiticity, coordinatewise measurability, the canonical
coordinate map, and the exact zero-dimensional boundary. It does not use
\(X+X^*\), which would double a supplied real diagonal. Read the compact
{{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}
entry and the full
[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}})
chapter.

## What is not proved yet

The checked stack now includes one joint probability measure for the real
diagonal and complex strict upper coordinates, the Wigner-scaled finite GUE
matrix law, and its exact entry marginals and independence architecture. It
does not yet define or prove:

- a Gaussian orthogonal ensemble (GOE);
- a Hermitian-space density or support theorem for GUE;
- eigenvalue measurability;
- unitary invariance for the nontrivial GUE law;
- integrability or expected trace moments;
- a semicircle law; or
- any claim about quantum chaos in a physical system.

This list is not a disclaimer pasted onto a finished theory. It is the module
boundary. Each missing concept will become a new formal interface with its own
paired notebook entry.

## The route beyond the finite GUE law

RMT-06 has now completed the first four law-construction steps: it states the
variance ledger, defines the complete joint coordinate measure, chooses the
zero-dimensional policy, and pushes the measure through checked assembly. The
remaining route is:

1. prove Hermitian support at the law level;
2. prove that unitary conjugation preserves the
   {{< refterm "probability-law" "law" >}}; and
3. establish integrability and compute small trace moments before attempting
   asymptotic spectral laws.

The order matters. If normalization is vague, two mathematically legitimate
GUE conventions can produce different moment formulas. If the law is not
separated from the sample function, unitary invariance is easy to state at the
wrong level. If small moments are not checked first, an asymptotic theorem can
hide a finite-dimensional mismatch.

Every ensemble page therefore carries a normalization ledger:

| Convention field | Question that must have one answer |
|---|---|
| Diagonal variance | What is the variance of each real diagonal coordinate? |
| Off-diagonal variance | How is variance divided between real and imaginary parts? |
| Density exponent | Which coefficient multiplies \(\operatorname{tr}(H^2)\) in the Gaussian density? |
| Spectral scaling | Is the matrix divided by \(\sqrt n\), or is that scale already built into the entries? |
| Trace convention | Does `trace` mean the ordinary trace or the normalized trace \(n^{-1}\operatorname{tr}\)? |

Hermiticity alone fills none of these rows.

## Two bridges back to nonlinear dynamics

Random matrices are not a detour from dynamics.

### Random Jacobians

For a random or uncertain dynamical system, the derivative along a state can
be a random matrix. Its singular values and operator norm quantify one-step
perturbation growth. Eigenvalues can diagnose a fixed linearization under the
usual dynamical hypotheses, but they do not by themselves control transient
growth for a nonnormal matrix. The measurable matrix layer built here can
carry those Jacobians before any ensemble assumption is imposed.

### Matrix cocycles

Linearization along an orbit produces products

\[
A_{t-1}\cdots A_1A_0.
\]

When the matrices depend on a random environment, a base transformation and a
cocycle relation can organize them into a random matrix cocycle. Lyapunov
exponents then describe long-time growth rates of such products under further
hypotheses. The finite multiplication measurability theorem is a small but
genuine first ingredient in that direction.

## Exercises: from foothills to summit camp

1. **Coordinate check.** For a two-by-two real random matrix, write the four
   scalar functions whose measurability is equivalent to matrix measurability.
2. **Dependence check.** Explain why Hermitian symmetry prevents all off-diagonal
   coordinates from being independent.
3. **Algebra check.** Starting from \((AB)^*=B^*A^*\), determine when the
   product of two Hermitian matrices is Hermitian.
4. **Lean check.** Find the single point in `measurable_mul` where finiteness of
   the shared index is used.
5. **Design check.** Compare \(A+A^*\) with \((A+A^*)/2\). Which
   theorem statements are unchanged, and which future distributional
   statements would change?
6. **Research check.** Formulate
   {{< refterm "unitary-invariance" "unitary invariance" >}} as equality of
   laws rather than pointwise equality of matrices.

## References

<a id="ref-mathlib-measurable"></a>
**Mathlib contributors.**
[Measurable spaces and measurable functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/MeasurableSpace/Basic.html),
Mathlib 4 documentation. Accessed 2026-07-20. This is the implementation-level
source for Lean's measurable-space and measurable-function interfaces.

<a id="ref-mathlib-release"></a>
**Mathlib contributors.**
[Mathlib 4.32.0 release](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
commit `81a5d257c8e410db227a6665ed08f64fea08e997`. This is the exact dependency
release against which the Lean declarations in this chapter were checked.

<a id="ref-mathlib-hermitian"></a>
**Mathlib contributors.**
[Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html),
Mathlib 4 documentation. Accessed 2026-07-20. This documents
`Matrix.IsHermitian` and the algebraic closure lemmas used by the project.

<a id="ref-mathlib-spectrum"></a>
**Mathlib contributors.**
[Spectral theory of matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Spectrum.html),
Mathlib 4 documentation. Accessed 2026-07-20. This documents the finite
Hermitian spectral infrastructure that later project modules can build on; it
is not imported by the current basic random-matrix file.

<a id="ref-tao-rmt"></a>
**Terence Tao.**
[Topics in Random Matrix Theory](https://doi.org/10.1090/gsm/132),
Graduate Studies in Mathematics 132, American Mathematical Society, 2012.
The [author's book page](https://teorth.github.io/tao-web/topics-in-random-matrix-theory.html)
links an online draft, lecture notes, and errata.

<a id="ref-kallenberg"></a>
**Olav Kallenberg.**
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1),
third edition, Probability Theory and Stochastic Modelling 99, Springer, 2021.
This is a standard source for measurable random elements, laws, product
spaces, independence, and almost-everywhere reasoning.

<a id="ref-agz"></a>
**Greg W. Anderson, Alice Guionnet, and Ofer Zeitouni.**
[An Introduction to Random Matrices](https://doi.org/10.1017/CBO9780511801334),
Cambridge Studies in Advanced Mathematics 118, Cambridge University Press,
2010. This is a standard systematic source for real and complex Wigner
matrices, Gaussian ensembles, and asymptotic spectral theory.

<a id="ref-wigner-1955"></a>
**Eugene P. Wigner.**
[Characteristic Vectors of Bordered Matrices With Infinite Dimensions](https://doi.org/10.2307/1970079),
*Annals of Mathematics* 62(3), 548-564, 1955. This is cited for historical
context on random-matrix models of complex spectra, not as a source for the
Lean implementation.

<a id="ref-dyson-1962"></a>
**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems. I](https://doi.org/10.1063/1.1703773),
*Journal of Mathematical Physics* 3, 140-156, 1962. This is cited for the
symmetry-class framing that connects orthogonal, unitary, and symplectic
ensembles to physical invariances.

<a id="ref-dyson-threefold"></a>
**Freeman J. Dyson.**
[The Threefold Way: Algebraic Structure of Symmetry Groups and Ensembles in Quantum Mechanics](https://doi.org/10.1063/1.1703863),
*Journal of Mathematical Physics* 3(6), 1199-1215, 1962. This is the original
three-class symmetry analysis, not the broader later tenfold classification.
