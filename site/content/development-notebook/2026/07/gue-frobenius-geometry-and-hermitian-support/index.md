---
title: "The Geometry Behind GUE in Lean: Frobenius Space, Hermitian Support, and Gaussian Symmetry"
slug: "gue-frobenius-geometry-and-hermitian-support"
date: 2026-07-21
weight: -5
author: "tdj28"
summary: "A guided construction of the Euclidean geometry behind finite Hermitian matrices: matrix flattening, the intrinsic real Hermitian subspace, Frobenius trace pairing, unitary-congruence isometries, invariant intrinsic standard Gaussian measure, and almost-sure Hermitian support of the coordinate-built GUE law."
lead: |
  Entrywise Gaussian formulas tell us how to build a random Hermitian matrix in one basis. Geometry tells us why changing an orthonormal basis should not change an isotropic Gaussian law. This chapter gives Lean the missing finite-dimensional stage: a Frobenius Euclidean carrier, its intrinsic real Hermitian subspace, unitary-congruence isometries, an invariant standard Gaussian on that subspace, and a separate proof that the existing ambient GUE law is Hermitian almost surely.
key_result: |
  Lean now packages unitary congruence as an isometric equivalence of both the full complex Frobenius matrix space and the intrinsic real Hermitian space. Mathlib's canonical standard Gaussian on the intrinsic Hermitian space is proved invariant under every such congruence, while the coordinate-built `GUE.matrixLaw` is proved to assign mass one to the measurable Hermitian locus. These are two different theorems: this module does not yet identify the two measures or prove unitary invariance of `GUE.matrixLaw`.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Finite-dimensional Hilbert geometry, linear isometries, and measure support"
reading_time: "85 to 110 minutes"
prerequisites:
  - "Complex matrices, conjugate transpose, trace, and Hermiticity"
  - "Pushforward probability laws and the finite GUE coordinate construction"
  - "No prior Lean proof experience required"
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleGeometry"
lean_source: "formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleGeometry.lean"
tags:
  - "Lean 4"
  - "Gaussian unitary ensemble"
  - "Frobenius geometry"
  - "Hermitian matrices"
  - "Unitary invariance"
  - "Standard Gaussian"
  - "Measure support"
og_image: "gue-frobenius-geometry-and-hermitian-support-card.png"
og_image_alt: "Warm-paper teaching card showing an ambient complex matrix flattened into Frobenius Euclidean space, restricted to a real Hermitian subspace, rotated by unitary congruence without changing length, and paired with separate badges for intrinsic Gaussian invariance and full-mass Hermitian support of the ambient GUE law."
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
**Abstract.** `GaussianUnitaryEnsembleGeometry.lean` builds a geometric layer
without changing the RMT-06 probability law. It flattens square complex
matrices into a finite complex Euclidean space, proves that the Euclidean
inner product is the Frobenius trace pairing, isolates Hermitian matrices as a
real submodule, and packages unitary congruence as linear isometric
equivalences on the ambient and intrinsic carriers.

Mathlib's `stdGaussian_map` then proves that the canonical standard Gaussian
on the intrinsic Hermitian Euclidean space is invariant under those real
isometries. Separately, entrywise measurability and the earlier pointwise
assembly theorem show that `GUE.matrixLaw n` assigns mass one to the ambient
Hermitian set, has zero mass on its complement, and is almost everywhere
Hermitian.

**Takeaway.** Intrinsic Gaussian symmetry and support of the ambient GUE law
are both checked. Their equality is not. The normalized coordinate-to-
intrinsic-Gaussian bridge, and therefore unitary-conjugation invariance of
`GUE.matrixLaw`, remains the next milestone.
{{< /panel >}}

This is the proof-to-prose companion to
`formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleGeometry.lean`.
Every named public declaration in that module appears below.

The immediate predecessor,
[A Finite GUE Law in Lean]({{< relref "/development-notebook/2026/07/finite-gue-law-from-coordinates" >}}),
constructs the coordinate and ambient matrix measures with the Wigner
variance ledger. The deterministic assembly map comes from
[Hermitian Coordinate Assembly]({{< relref "/development-notebook/2026/07/hermitian-coordinate-assembly" >}}),
while
[From Random Matrices to Laws]({{< relref "/development-notebook/2026/07/from-random-matrices-to-laws" >}})
defines the exact measure-level property that the future bridge must prove.

The parallel textbook treatment of this milestone is
[Intrinsic Hermitian Gaussian Symmetry and Matrix-Law Support]({{< relref "/knowledge-base/deep-dives/intrinsic-hermitian-gaussian-symmetry-and-matrix-law-support" >}}).
Its prerequisite background is developed in
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}}),
[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}}),
and
[Random Matrices: From Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}}).
Reusable vocabulary is indexed under
{{< refterm "gaussian-unitary-ensemble" >}},
{{< refterm "hermitian-matrix" >}},
{{< refterm "conjugate-transpose" "conjugate transpose" >}},
{{< refterm "matrix-trace" "matrix trace" >}},
{{< refterm "hermitian-frobenius-geometry" >}},
{{< refterm "unitary-invariance" >}},
{{< refterm "almost-everywhere" >}},
{{< refterm "measurable-space" >}}, and
{{< refterm "pushforward-measure" "pushforward measure" >}}.

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| First encounter | [Why matrices need a geometric carrier](#why-matrices-need-a-geometric-carrier) | See how an array becomes a point in finite Euclidean space |
| Linear-algebra route | [Trace pairing](#the-frobenius-inner-product-is-a-trace) | Derive the Frobenius inner product and unitary isometry |
| Hermitian route | [A real, not complex, subspace](#the-hermitian-locus-is-real-not-complex) | Understand why Hermitian matrices form an intrinsic real Euclidean space |
| Probability route | [Standard Gaussian symmetry](#summit-one-the-intrinsic-standard-gaussian-is-invariant) | Apply basis-independent Gaussian invariance under real isometries |
| Measure route | [Ambient support](#summit-two-the-ambient-gue-law-has-hermitian-support) | Convert pointwise assembly into mass-one and almost-everywhere statements |
| Lean route | [Declaration map](#the-complete-declaration-map) | Locate all twenty-seven public declarations and their proof engines |
| Boundary route | [The missing bridge](#the-normalized-coordinate-bridge-is-still-missing) | See exactly why `GUE.matrixLaw` invariance is not yet proved |

### Learning objectives

By the summit, a reader should be able to:

1. reinterpret an \(n\times n\) complex matrix as a vector with \(n^2\)
   complex coordinates;
2. move between the curried matrix carrier and a pair-indexed Euclidean
   carrier without losing entries;
3. derive \(\langle X,Y\rangle_F=\operatorname{Tr}(X^*Y)\);
4. explain why Hermitian matrices are closed under real, but not arbitrary
   complex, scalar multiplication;
5. distinguish ambient complex linearity from intrinsic real linearity;
6. prove on paper that \(X\mapsto UXU^*\) preserves the Frobenius pairing
   when \(U\) is unitary;
7. understand the inverse congruence and the two unitary identities used by
   Lean;
8. state why a standard Gaussian on a real inner-product space is invariant
   under a linear isometry;
9. explain the local `Module ℝ` instance wrinkle in the `stdGaussian_map`
   proof;
10. distinguish a measurable full-mass Hermitian set, an almost-everywhere
    Hermitian predicate, and topological measure support;
11. trace the support proof back through the coordinate pushforward; and
12. identify the normalized orthonormal-coordinate theorem still required to
    transfer intrinsic symmetry to `GUE.matrixLaw`.

## Two theorem tracks, one future bridge

{{< mermaid >}}
flowchart LR
  A["Ambient complex matrices"] --> F["Frobenius Euclidean carrier"]
  F --> H["Intrinsic real Hermitian subspace"]
  U["Unitary congruence"] --> IF["Ambient complex isometry"]
  IF --> IH["Intrinsic real isometry"]
  IH --> SG["Intrinsic standard Gaussian invariant"]
  C["RMT-06 coordinate GUE law"] --> P["Hermitian assembly pushforward"]
  P --> M["Ambient GUE matrix law"]
  M --> S["Hermitian set has mass one"]
  SG -. normalized coordinate-law bridge .-> M
{{< /mermaid >}}

<p class="figure-note"><strong>Figure.</strong> The top path is intrinsic
geometry and Gaussian symmetry. The lower path is the already constructed
coordinate GUE law and its newly checked Hermitian support. Every solid arrow
is formalized. The dotted bridge is not: until the scaled intrinsic Gaussian
is identified with the coordinate pushforward, symmetry of the top measure
cannot be transferred to the lower one.</p>

## Why matrices need a geometric carrier

The project's ambient matrix type is

\[
\operatorname{Matrix}(\operatorname{Fin}(n),\operatorname{Fin}(n),\mathbb C)
=\operatorname{Fin}(n)\to\operatorname{Fin}(n)\to\mathbb C.
\]

That function type is ideal for entrywise algebra and for the measurable
space introduced in the earliest random-matrix module. It does not, in this
project's current instance graph, arrive as the exact finite Hilbert carrier
expected by Mathlib's canonical multivariate standard Gaussian.

The remedy is to flatten the two matrix indices into one pair index:

\[
\operatorname{FrobeniusMatrix}(n)
=\operatorname{EuclideanSpace}
  \bigl(\mathbb C,\operatorname{Fin}(n)\times\operatorname{Fin}(n)\bigr).
\]

This does not change the data. A matrix stores \(A_{ij}\); the flattened
vector stores the same value at coordinate \((i,j)\). What changes is the
available structure. `EuclideanSpace` supplies a norm, a complex inner
product, finite-dimensionality, a Borel measurable space, and the interfaces
used by linear isometries and Gaussian measures
([Mathlib Euclidean spaces](#ref-mathlib-euclidean)).

### Flatten, restore, and package the equivalence

`RandomMatrix.FrobeniusMatrix` is the carrier abbreviation.
`RandomMatrix.frobeniusToMatrix` uncouples a pair index into a row and column:

```lean
def frobeniusToMatrix {n : ℕ} (x : FrobeniusMatrix n) :
    Matrix (Fin n) (Fin n) ℂ :=
  fun i j => x (i, j)
```

`RandomMatrix.matrixToFrobenius` performs the reverse operation with
`WithLp.toLp 2`. The `Lp` wrapper carries the Euclidean norm; finiteness means
every coordinate function belongs to it.

The simplification theorems
`RandomMatrix.frobeniusToMatrix_matrixToFrobenius` and
`RandomMatrix.matrixToFrobenius_frobeniusToMatrix` prove that both round trips
are identities. Both proofs are `rfl`: flattening is representational rather
than an algorithm that rearranges or approximates entries.

`RandomMatrix.frobeniusMatrixLinearEquiv` packages those maps as a complex
linear equivalence. Addition and complex scalar multiplication are preserved
definitionally. This bundle gives later proofs injectivity, an explicit
inverse, and standard `LinearEquiv` transport without reopening entry
extensionality each time.

{{< panel "info" >}}
**No norm theorem yet.** The flattening is constructed inside the Euclidean
carrier, so its norm is the Frobenius entry norm by definition. The named
equivalence in this module is linear, not separately packaged as an isometric
equivalence to the project's ambient matrix type, because that ambient carrier
does not carry the matching norm structure here.
{{< /panel >}}

## The Frobenius inner product is a trace

For flattened matrices \(x,y\), write \(X\) and \(Y\) for their restored
matrices. The complex Euclidean inner product is the sum over all pair
coordinates:

\[
\langle x,y\rangle_{\mathbb C}
=\sum_{i,j}\overline{X_{ij}}Y_{ij}.
\]

The conjugate transpose has \((X^*)_{ij}=\overline{X_{ji}}\), so

\[
\begin{aligned}
\operatorname{Tr}(X^*Y)
&=\sum_i (X^*Y)_{ii}\\
&=\sum_i\sum_j (X^*)_{ij}Y_{ji}\\
&=\sum_i\sum_j \overline{X_{ji}}Y_{ji}\\
&=\sum_{i,j}\overline{X_{ij}}Y_{ij}.
\end{aligned}
\]

`RandomMatrix.inner_frobenius_eq_trace` checks exactly this identity:

```lean
inner ℂ x y = Matrix.trace ((frobeniusToMatrix x)ᴴ * frobeniusToMatrix y)
```

The Lean proof expands the Euclidean inner product, trace, diagonal lookup,
matrix multiplication, and conjugate transpose. `Fintype.sum_prod_type` turns
the sum over pairs into nested sums, `Finset.sum_comm` aligns their order, and
the final scalar equality is definitional after one commutation. This theorem
is the hinge between coordinate geometry and the invariant matrix expression
used in random-matrix theory
([Mathlib matrix trace](#ref-mathlib-trace)).

Setting \(x=y\) gives the familiar contextual norm identity

\[
\|X\|_F^2=\operatorname{Tr}(X^*X)=\sum_{i,j}|X_{ij}|^2.
\]

The file does not add a separately named squared-norm corollary, but every
later isometry proof uses the inner-product theorem that implies it.

## The Hermitian locus is real, not complex

A matrix is Hermitian when \(H^*=H\). If \(r\in\mathbb R\), then

\[
(rH)^*=rH^*=rH,
\]

so real scalar multiplication stays inside the Hermitian locus. For a general
complex \(c\), however,

\[
(cH)^*=\overline c H.
\]

Unless \(c=\overline c\) or \(H=0\), that is not \(cH\). In particular,
\(iH\) is anti-Hermitian for nonzero Hermitian \(H\). Hermitian matrices are
therefore a real vector space living inside a complex vector space.

### `RandomMatrix.hermitianSubmodule`

`hermitianSubmodule n` makes this fact a type. Its carrier is the set of
Frobenius vectors whose restored matrices satisfy `Matrix.IsHermitian`. The
three closure obligations reuse checked matrix facts:

- zero is Hermitian;
- sums of Hermitian matrices are Hermitian; and
- real scalars are self-adjoint, so real scalar multiples remain Hermitian.

Choosing `Submodule ℝ`, rather than `Submodule ℂ`, is a mathematical decision,
not a workaround for the prover.

### `RandomMatrix.HermitianEuclidean`

`HermitianEuclidean n` abbreviates that real submodule. As a submodule of a
finite Euclidean space, it inherits an additive normed group, a real inner
product, finite-dimensionality, its measurable structure, and a Borel-space
instance. A term contains a Frobenius vector together with proof that its
matrix is Hermitian.

The abbreviation does not yet construct the explicit \(n^2\)-element real
orthonormal basis. That basis, or an equivalent normalized coordinate map, is
exactly what the next probability bridge will need.

### `RandomMatrix.hermitianToMatrix`

`hermitianToMatrix` forgets the proof and Euclidean packaging, restoring the
ambient complex matrix. It is the inclusion through which the intrinsic
measure will eventually be compared with `GUE.matrixLaw`.

### `RandomMatrix.measurable_hermitianToMatrix`

The inclusion is measurable. The proof uses the project's entrywise matrix
criterion, fixes \(i,j\), and observes that the desired entry is coordinate
evaluation of the underlying Frobenius vector. `fun_prop` supplies the
measurability of the subtype coercion and evaluation.

This result is important for a future pushforward measure. Merely having an
algebraic inclusion would not justify mapping the intrinsic Gaussian to the
ambient matrix measurable space.

## Unitary congruence preserves Frobenius geometry

For a fixed complex matrix \(U\), define congruence by

\[
\mathcal C_U(X)=UXU^*.
\]

The operation preserves Hermiticity for every \(U\), because
\((UXU^*)^*=UX^*U^*\). It becomes invertible and length preserving when \(U\)
is unitary, meaning

\[
U^*U=I
\qquad\text{and}\qquad
UU^*=I.
\]

Mathlib's `Matrix.unitaryGroup` packages a matrix with these identities
([Mathlib unitary group](#ref-mathlib-unitary)).

### `RandomMatrix.frobeniusCongruence`

`frobeniusCongruence U x` restores `x`, forms \(UXU^*\), and flattens the
result. The companion theorem
`RandomMatrix.frobeniusToMatrix_frobeniusCongruence` exposes exactly that
matrix expression after restoration. Its proof is reflexivity.

This low-level definition accepts any matrix \(U\). Unitarity is introduced
only when invertibility or isometry is claimed.

### `RandomMatrix.unitaryCongruenceLinearEquiv`

For `U : Matrix.unitaryGroup (Fin n) ℂ`, congruence is packaged as a complex
linear equivalence of the full Frobenius carrier. Its inverse is congruence by
\(U^*\):

\[
\mathcal C_{U^*}(\mathcal C_U(X))=X,
\qquad
\mathcal C_U(\mathcal C_{U^*}(X))=X.
\]

The two inverse proofs are not duplicates. The first collapses \(U^*U\); the
second collapses \(UU^*\). Lean applies injectivity of the flattening linear
equivalence, rewrites both congruences as matrix expressions, reassociates
products, and then uses the corresponding field of the unitary-group proof.

Addition and complex scalar multiplication follow from distributivity of
matrix multiplication. This ambient map is genuinely complex linear because
the full matrix space is closed under complex scaling.

### `RandomMatrix.frobeniusCongruence_inner`

The central calculation proves

\[
\langle \mathcal C_U(X),\mathcal C_U(Y)\rangle_F
=\langle X,Y\rangle_F.
\]

Using the trace pairing, the paper proof is

\[
\begin{aligned}
\operatorname{Tr}\bigl((UXU^*)^*(UYU^*)\bigr)
&=\operatorname{Tr}(UX^*U^*UYU^*)\\
&=\operatorname{Tr}(UX^*YU^*)\\
&=\operatorname{Tr}(U^*UX^*Y)\\
&=\operatorname{Tr}(X^*Y).
\end{aligned}
\]

The third line uses cyclicity of trace. The Lean proof follows the same route:
rewrite both inner products, simplify conjugate transposes, collapse
\(U^*U\), apply `Matrix.trace_mul_cycle`, and collapse the remaining unit.
No determinant or eigenvalue argument is involved.

### `RandomMatrix.unitaryCongruenceLinearIsometryEquiv`

`LinearEquiv.isometryOfInner` upgrades the complex linear equivalence using the
preserved inner product. The result records in one object that congruence is
bijective, complex linear, and norm preserving.

That bundle is more useful than a standalone norm equation. It can transport
orthonormal bases and eventually any construction functorial under isometries.

## Restrict the symmetry to intrinsic Hermitian space

### `RandomMatrix.hermitianCongruence`

`hermitianCongruence U x` applies Frobenius congruence to an intrinsic
Hermitian point and supplies the proof that the result is still Hermitian.
This restriction works for arbitrary \(U\), not only unitary matrices, by
`Matrix.isHermitian_mul_mul_conjTranspose`.

`RandomMatrix.hermitianCongruence_coe` says that forgetting the subtype after
intrinsic congruence gives the full Frobenius congruence. The theorem is `rfl`.

`RandomMatrix.hermitianToMatrix_hermitianCongruence` is the commuting-square
theorem. Including the intrinsic result into ambient matrices is the same as
including first and applying the project's existing ambient
`RandomMatrix.congruence`. This too is definitional, but naming it prevents
future measure proofs from depending on record layout.

### `RandomMatrix.hermitianUnitaryCongruenceLinearEquiv`

On `HermitianEuclidean n`, unitary congruence is a **real** linear
equivalence. The to-function and inverse are the restricted congruences by
\(U\) and \(U^*\). Equality of subtype values reduces to equality of their
Frobenius values, where the ambient complex linear equivalence already proves
the inverse and addition laws.

The real scalar law is the first nontrivial coercion seam. Lean rewrites real
scalar multiplication on complex Frobenius coordinates as multiplication by
the embedded complex number with `Complex.real_smul`, applies ambient complex
linearity, and rewrites back. The proof mirrors the mathematics: restriction
from complex to real scalars preserves linearity, but the conversion must be
made explicit.

### `RandomMatrix.hermitianUnitaryCongruenceLinearIsometryEquiv`

The intrinsic real equivalence is upgraded with
`LinearIsometryEquiv.ofBounds`. One norm inequality comes from the ambient
unitary isometry; the other applies the inverse ambient isometry. Since both
bounds are equalities in disguise, the packaged map is a real linear
isometric equivalence.

This is the exact input shape required by Mathlib's standard-Gaussian
invariance theorem.

## Summit one: the intrinsic standard Gaussian is invariant

For any finite-dimensional real inner-product space \(E\), Mathlib defines
`ProbabilityTheory.stdGaussian E` by taking independent standard real
Gaussian coordinates in an orthonormal basis and mapping them into \(E\). The
definition is basis independent. Its characteristic function depends only on
the norm, and `stdGaussian_map` states that every real linear isometric
equivalence preserves the measure
([Mathlib multivariate Gaussians](#ref-mathlib-multivariate)).

### `RandomMatrix.map_stdGaussian_hermitianUnitaryCongruence`

The theorem applies that interface to the intrinsic Hermitian space:

\[
(\mathcal C_U)_*\gamma_{\mathrm{Herm}(n)}
=\gamma_{\mathrm{Herm}(n)},
\]

where \(\gamma_{\mathrm{Herm}(n)}\) is Mathlib's canonical standard Gaussian
on `HermitianEuclidean n`.

This is a checked invariance theorem, but its subject is exact: the unscaled
intrinsic `stdGaussian`, not `GUE.matrixLaw` and not an unnamed Gaussian with
matching marginal variances.

### The `Module ℝ` instance wrinkle

The proof contains more scaffolding than the one-line mathematical argument
"apply `stdGaussian_map` to the isometry." `HermitianEuclidean n` is a
submodule subtype and already inherits a real module instance. The
inner-product hierarchy can also recover a real module through
`InnerProductSpace.toNormedSpace.toModule`. These scalar actions agree on
values, but the structures are not definitionally interchangeable at every
elaboration boundary used by `stdGaussian_map`.

The proof therefore pins the instance locally:

```lean
letI : Module ℝ (HermitianEuclidean n) :=
  InnerProductSpace.toNormedSpace.toModule
```

It then rebuilds a local real linear equivalence `e` and a local real linear
isometric equivalence `f` under that exact instance, changes the map in the
goal back to concrete `hermitianCongruence`, and applies `stdGaussian_map f`.

Nothing mathematical changes. No new scalar action is introduced, and no
extra assumption is added. The maneuver aligns type-class identity so Lean
can see the already proved pointwise map as the isometry expected by the
Gaussian theorem. Recording this wrinkle matters because a future refactor
that merely reuses the earlier bundle may fail for definitional reasons even
though the theorem is unchanged.

{{< panel "warning" >}}
**Do not transfer this theorem by resemblance.** An isotropic Gaussian is
determined by a full joint law, not by a list of one-dimensional variances.
Before intrinsic invariance can say anything about `GUE.matrixLaw`, Lean needs
an exact measurable map and equality of pushforward measures.
{{< /panel >}}

## Summit two: the ambient GUE law has Hermitian support

The intrinsic carrier contains only Hermitian matrices by type. The RMT-06
law, in contrast, lives on the full ambient type
`Matrix (Fin n) (Fin n) ℂ`. To state that its samples are Hermitian, the
Hermitian predicate must first become a measurable set in that ambient space.

### `RandomMatrix.hermitianSet`

`hermitianSet n` is the set

\[
\{H:H^*=H\}.
\]

It deliberately stays in the ambient matrix carrier. This lets the already
defined `GUE.matrixLaw n` evaluate it directly.

### `RandomMatrix.measurableSet_hermitianSet`

The ambient entrywise measurable space has no global `MeasurableEq` instance,
so the proof cannot simply declare the matrix equation \(H^*=H\) measurable.
It expands Hermiticity into all entry equations:

\[
\bigcap_i\bigcap_j
\{H:\overline{H_{ji}}=H_{ij}\}.
\]

Each entry projection is measurable, complex conjugation is measurable, and
equality of two complex-valued measurable functions is a measurable set.
Finite dependent intersections assemble those scalar facts into the whole
Hermitian locus.

The entrywise route matches the project's measurable-space design. It does
not import a topological matrix-space structure or assume an unavailable
global equality interface.

### `GUE.matrixLaw_hermitianSet`

The first support theorem proves

\[
\operatorname{matrixLaw}(n)(\operatorname{hermitianSet}(n))=1.
\]

The proof rewrites `matrixLaw` as the pushforward of `coordinateMeasure`, uses
`Measure.map_apply` with the coordinate-map measurability and Hermitian-set
measurability proofs, and identifies the preimage with the whole coordinate
space. That last step is exactly RMT-05's pointwise theorem that every direct
coordinate assembly is Hermitian. The source probability measure of the
universe is one.

This is stronger than saying the matrix is Hermitian with high probability.
It is an exact mass-one statement in every natural dimension, including zero.

### `GUE.matrixLaw_ae_isHermitian`

The second theorem changes presentation, not content:

\[
\forall^{\mu_n}\,H,\quad H\text{ is Hermitian}.
\]

`mem_ae_iff_prob_eq_one` converts membership of the measurable Hermitian set
in the almost-everywhere filter to its probability-one equation. This is the
form downstream random-variable theorems can consume directly.

### `GUE.matrixLaw_compl_hermitianSet`

The third theorem states that the non-Hermitian complement has mass zero:

\[
\operatorname{matrixLaw}(n)
\bigl(\operatorname{hermitianSet}(n)^c\bigr)=0.
\]

It follows from the almost-everywhere membership theorem via `mem_ae_iff`.
Keeping all three formulations is useful: set evaluation, almost-everywhere
reasoning, and null-complement calculations appear in different downstream
APIs.

{{< panel "info" >}}
**Meaning of support here.** This chapter uses *Hermitian support* in the
measure-theoretic sense that a measurable Hermitian set has full mass and its
complement is null. It does not compute Mathlib's topological
`Measure.support`, prove equality with the entire Hermitian locus, or show that
every relative open subset has positive mass.
{{< /panel >}}

## Physics view: basis changes and ensemble symmetry

A finite quantum Hamiltonian is represented by a Hermitian matrix after an
orthonormal basis is chosen. Replacing the basis by a unitary \(U\) transforms
the matrix by \(H\mapsto UHU^*\). The operator has not changed; only its
coordinates have. The Frobenius trace pairing is invariant under this change,
so it gives a basis-independent quadratic geometry on Hamiltonians.

An intrinsic standard Gaussian depends only on that quadratic geometry. In
finite-dimensional statistical mechanics language, its weight is radial in
the Euclidean norm; a unitary congruence is a rotation of the real Hermitian
space. Mathlib's `stdGaussian_map` captures the measure-theoretic version of
that statement without choosing a basis.

Classical GUE combines this geometry with a dimension-dependent scale.
Guionnet presents the Wigner-scaled coordinate variances and states invariance
under unitary conjugation
([Guionnet, 2022](#ref-guionnet-2022)). This module formalizes the geometric
rotation and the intrinsic standard-Gaussian invariance, but not yet their
identification with the RMT-06 ensemble. It also does not formalize quantum
states, spectra, Schrödinger evolution, measurement, or any universality claim.

## Lineage, local contribution, and nonclaims

The Frobenius pairing, Hermitian real vector space, and unitary-congruence
symmetry are standard finite-dimensional mathematics. Mathlib supplies the
Euclidean-space inner product, matrix trace and cyclicity, Hermitian and
unitary interfaces, real linear isometries, Borel structures, and canonical
standard Gaussian theorem
([Euclidean spaces](#ref-mathlib-euclidean),
[matrix trace](#ref-mathlib-trace),
[Hermitian matrices](#ref-mathlib-hermitian),
[unitary group](#ref-mathlib-unitary),
[multivariate Gaussians](#ref-mathlib-multivariate)).

This module's local contribution is the bridge among those interfaces and the
project's ambient matrix law:

- mutually inverse flattening maps and a complex linear equivalence;
- a real Hermitian submodule with measurable ambient inclusion;
- the exact trace formula for the complex Frobenius inner product;
- ambient complex and intrinsic real unitary-congruence equivalences;
- their isometric upgrades;
- invariance of the intrinsic standard Gaussian;
- an entrywise measurable ambient Hermitian set; and
- three equivalent full-mass/null-complement forms of Hermitian support for
  `GUE.matrixLaw`.

### Not claimed

- No equality identifies `GUE.matrixLaw n` with the ambient image of an
  intrinsic standard Gaussian or a scaled version of it.
- No theorem proves
  `RandomMatrix.IsUnitaryConjugationInvariant (GUE.matrixLaw n)`.
- No normalized Hermitian coordinate equivalence or \(n^2\) real dimension
  theorem is constructed.
- No Lebesgue density, Jacobian, normalizing constant, or change-of-variables
  theorem appears.
- No topological-support equality is proved.
- No eigenvalue, spectrum, empirical measure, trace expectation, covariance,
  moment, semicircle, edge, spacing, or universality result is formalized.
- Intrinsic `stdGaussian` is unscaled. The Wigner \(1/n\) covariance scale has
  not yet been transferred into that carrier.

## The normalized coordinate bridge is still missing

RMT-06 chooses free coordinates \(d_i\in\mathbb R\) and
\(u_{ij}\in\mathbb C\) for \(i\lt j\). The Frobenius norm of the assembled
Hermitian matrix satisfies the contextual identity

\[
\|H\|_F^2
=\sum_i d_i^2+2\sum_{i\lt j}|u_{ij}|^2.
\]

The factor two appears because every strict-upper value also appears below the
diagonal as its conjugate. Therefore an orthonormal real coordinate list is

\[
d_i,
\qquad
\sqrt{2}\operatorname{Re}(u_{ij}),
\qquad
\sqrt{2}\operatorname{Im}(u_{ij}).
\]

Under the RMT-06 law, \(d_i\) has variance \(1/n\), while each unscaled real
or imaginary upper coordinate has variance \(1/(2n)\). Multiplication by
\(\sqrt{2}\) makes every orthonormal coordinate have variance \(1/n\). This is
the mathematical reason the positive-dimensional GUE should correspond to a
\(1/\sqrt n\)-scaled intrinsic standard Gaussian.

RMT-08 must make every word of that sentence exact:

1. define the normalized real coordinate carrier and its measurable map;
2. prove the Frobenius norm or inner-product identity with the factor two;
3. package the map as a real linear isometric equivalence;
4. push the RMT-06 finite product law through it;
5. identify the result with the scaled intrinsic `stdGaussian`;
6. include the intrinsic measure into ambient matrices; and
7. transfer the checked intrinsic congruence symmetry through those exact
   measure equalities.

Dimension zero also needs its explicit Dirac branch. Skipping any one of
these steps would turn matching coordinates into an unsupported equality of
measures.

## The complete declaration map

| Public declaration | Checked content | Main proof mechanism |
|---|---|---|
| `RandomMatrix.FrobeniusMatrix` | Pair-indexed complex Euclidean carrier for square matrices | `EuclideanSpace` abbreviation |
| `RandomMatrix.frobeniusToMatrix` | Restore a flattened vector as a curried matrix | Pair-coordinate evaluation |
| `RandomMatrix.matrixToFrobenius` | Flatten a curried matrix into Euclidean space | `WithLp.toLp 2` |
| `RandomMatrix.frobeniusToMatrix_matrixToFrobenius` | Restore after flattening is identity | Reflexivity |
| `RandomMatrix.matrixToFrobenius_frobeniusToMatrix` | Flatten after restoring is identity | Reflexivity |
| `RandomMatrix.frobeniusMatrixLinearEquiv` | Flattening is a complex linear equivalence | Inverse lemmas and definitional linearity |
| `RandomMatrix.hermitianSubmodule` | Hermitian matrices form a real submodule | Zero, addition, and self-adjoint real scaling |
| `RandomMatrix.HermitianEuclidean` | Intrinsic real Euclidean Hermitian carrier | Submodule abbreviation |
| `RandomMatrix.hermitianToMatrix` | Forget intrinsic structure into ambient matrices | Frobenius restoration |
| `RandomMatrix.measurable_hermitianToMatrix` | Intrinsic inclusion is measurable | Entrywise criterion and coordinate evaluation |
| `RandomMatrix.inner_frobenius_eq_trace` | Complex Euclidean inner product equals `Tr (XᴴY)` | Expand sums, commute finite indices |
| `RandomMatrix.frobeniusCongruence` | Transport `UXUᴴ` to the Frobenius carrier | Restore, multiply, flatten |
| `RandomMatrix.frobeniusToMatrix_frobeniusCongruence` | Restored Frobenius congruence is ordinary matrix congruence | Reflexivity |
| `RandomMatrix.unitaryCongruenceLinearEquiv` | Unitary congruence is an ambient complex linear equivalence | Inverse by `Uᴴ`, two unitary identities, distributivity |
| `RandomMatrix.frobeniusCongruence_inner` | Unitary congruence preserves the complex Frobenius inner product | Trace identity, cyclicity, `UᴴU=I` |
| `RandomMatrix.unitaryCongruenceLinearIsometryEquiv` | Ambient congruence is a complex linear isometric equivalence | `LinearEquiv.isometryOfInner` |
| `RandomMatrix.hermitianCongruence` | Congruence restricts to intrinsic Hermitian space | Hermiticity of `UXUᴴ` |
| `RandomMatrix.hermitianCongruence_coe` | Intrinsic congruence coerces to Frobenius congruence | Reflexivity |
| `RandomMatrix.hermitianToMatrix_hermitianCongruence` | Intrinsic inclusion intertwines ambient congruence | Reflexivity |
| `RandomMatrix.hermitianUnitaryCongruenceLinearEquiv` | Restricted unitary congruence is a real linear equivalence | Ambient equivalence plus real-to-complex scalar bridge |
| `RandomMatrix.hermitianUnitaryCongruenceLinearIsometryEquiv` | Restricted congruence is a real linear isometric equivalence | Forward and inverse norm bounds |
| `RandomMatrix.map_stdGaussian_hermitianUnitaryCongruence` | Intrinsic standard Gaussian is invariant under unitary congruence | Local module alignment and `stdGaussian_map` |
| `RandomMatrix.hermitianSet` | Ambient measurable-set target for Hermitian matrices | Set-builder definition |
| `RandomMatrix.measurableSet_hermitianSet` | Ambient Hermitian locus is measurable | Finite entrywise intersections and measurable equality |
| `GUE.matrixLaw_hermitianSet` | Ambient GUE law gives the Hermitian set mass one | Pushforward evaluation and universal preimage |
| `GUE.matrixLaw_ae_isHermitian` | An ambient GUE matrix is Hermitian almost everywhere | Probability-one set to `ae` membership |
| `GUE.matrixLaw_compl_hermitianSet` | Non-Hermitian matrices have GUE mass zero | Almost-everywhere membership to null complement |

The map contains exactly twenty-seven named public declarations in this
version of the module. Local equivalences inside the standard-Gaussian proof,
namespace openings, imported declarations, and automatically generated
submodule structure are not counted as new public declarations.

## Run the checked source

From the repository root on macOS or Linux, load elan and invoke Lean through
the pinned Lake environment:

```sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleGeometry.lean
```

Starting from the repository root, build the whole formalization and check the
public teaching content:

```sh
cd formalization
lake build

cd ..
make content-hygiene
make site-check
```

The direct command checks the geometry and support module with warnings
promoted to errors. The full build checks every dependency, and the final two
commands inspect the public teaching content and render the site.

This complete Lean snippet inspects the main interfaces:

```lean
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleGeometry

open Matrix MeasureTheory ProbabilityTheory
open scoped Matrix RealInnerProductSpace

open NonlinearDynamics.Random

#check RandomMatrix.FrobeniusMatrix
#check RandomMatrix.frobeniusMatrixLinearEquiv
#check RandomMatrix.HermitianEuclidean
#check RandomMatrix.inner_frobenius_eq_trace
#check RandomMatrix.unitaryCongruenceLinearIsometryEquiv
#check RandomMatrix.hermitianUnitaryCongruenceLinearIsometryEquiv
#check RandomMatrix.map_stdGaussian_hermitianUnitaryCongruence
#check RandomMatrix.measurableSet_hermitianSet
#check GUE.matrixLaw_hermitianSet
#check GUE.matrixLaw_ae_isHermitian
#check GUE.matrixLaw_compl_hermitianSet
```

Save the snippet inside `formalization` and run `lake env lean` on it. Every
name is part of the checked public API; the code contains no omitted terms or
noncompiling ellipses.

## Failure modes this layer blocks

| Tempting shortcut | What goes wrong | Checked repair |
|---|---|---|
| Treat a matrix array as already carrying the needed Hilbert instances | The standard-Gaussian API cannot see the intended Frobenius geometry | Flatten into `EuclideanSpace ℂ (Fin n × Fin n)` |
| Call the Hermitian locus a complex subspace | Multiplication by \(i\) generally leaves the locus | Define a `Submodule ℝ` |
| Prove only \(\|UXU^*\|=\|X\|\) pointwise | Inverses, linearity, and transport APIs remain unavailable | Package linear and linear-isometric equivalences |
| Use only \(U^*U=I\) for both inverse directions | One composite actually requires \(UU^*=I\) | Use both unitary-group identities explicitly |
| Claim trace invariance without handling product order | Matrix multiplication is noncommutative | Use trace cyclicity at the exact reordering step |
| Reuse the complex linear map on the Hermitian subtype | The subtype is only a real vector space | Build the restricted real linear equivalence |
| Assume matching real scalar actions are definitionally identical | Type-class elaboration can reject the Gaussian theorem application | Pin the local module instance and rebuild the local isometry |
| Call a set measurable because matrix equality is measurable globally | The project ambient matrix space has no global `MeasurableEq` instance | Expand Hermiticity into finitely many complex entry equations |
| Read pointwise Hermitian assembly as a statement about an ambient law | The pushforward and measurable-set steps are missing | Prove the preimage is universal and evaluate the map |
| Read full mass as topological support equality | A measure can have full mass on many larger measurable sets | State mass one, almost everywhere, and null complement only |
| Transfer `stdGaussian` invariance to `GUE.matrixLaw` by naming both Gaussian | The exact scaled pushforward equality is absent | Defer the claim until the normalized coordinate bridge is proved |
| Forget the strict-upper factor two | The proposed coordinate map is not an isometry | Normalize upper real and imaginary coordinates by \(\sqrt{2}\) |

## Exercises with solutions

### Exercise 1: flatten a two-by-two matrix

For

\[
A=\begin{pmatrix}a&b\\c&d\end{pmatrix},
\]

what values does `matrixToFrobenius A` have at the four pair coordinates?

**Solution.** It has values \(a,b,c,d\) at \((0,0),(0,1),(1,0),(1,1)\),
respectively. `frobeniusToMatrix_matrixToFrobenius` says restoration returns
the same four entries definitionally.

### Exercise 2: find the scalar-field obstruction

Let \(H\ne0\) be Hermitian. Show that \(iH\) is not generally Hermitian.

**Solution.** Since \(\overline i=-i\),
\((iH)^*=\overline i H^*=-iH\). Equality with \(iH\) would force
\(2iH=0\), hence \(H=0\) over \(\mathbb C\). The Hermitian locus is therefore
real linear but not complex linear.

### Exercise 3: derive the trace pairing

Which index swap turns \(\operatorname{Tr}(X^*Y)\) into the Euclidean
coordinate sum?

**Solution.** Expansion gives
\(\sum_i\sum_j\overline{X_{ji}}Y_{ji}\). Swap the dummy indices \(i,j\) to
obtain \(\sum_i\sum_j\overline{X_{ij}}Y_{ij}\). Lean performs the finite-sum
version with `Fintype.sum_prod_type`, `Finset.sum_comm`, and scalar
commutation.

### Exercise 4: choose the inverse congruence

Why is the inverse of \(X\mapsto UXU^*\) given by
\(X\mapsto U^*XU\)?

**Solution.** Compose in one direction:
\(U^*(UXU^*)U=(U^*U)X(U^*U)=X\). The other direction uses
\(U(U^*XU)U^*=(UU^*)X(UU^*)=X\). Both unitary identities are required.

### Exercise 5: separate the two invariance claims

What exact measure is known invariant after this module, and which measure is
not yet known invariant?

**Solution.** `stdGaussian (HermitianEuclidean n)` is invariant under the
intrinsic real unitary-congruence isometry. `GUE.matrixLaw n` is known to give
full mass to ambient Hermitian matrices, but its unitary-conjugation invariance
is not proved. An exact scaled pushforward equality must connect the measures.

### Exercise 6: prove the Hermitian preimage is universal

Why is the preimage of `hermitianSet n` under
`hermitianCoordinateMap n` equal to `Set.univ`?

**Solution.** A coordinate point is a real diagonal paired with a complex
strict upper triangle. RMT-05's
`hermitianFromCoordinates_isHermitian` proves its direct assembly Hermitian
without hypotheses. Hence every coordinate point belongs to the preimage.

### Exercise 7: compute the orthonormal upper coordinates

If one complex upper coordinate is \(u=x+iy\), what contribution does it make
to \(\|H\|_F^2\), and which real coordinates reproduce that contribution as a
sum of squares?

**Solution.** The upper value and its conjugate below the diagonal contribute
\(2|u|^2=2x^2+2y^2\). The real coordinates \(\sqrt{2}x\) and \(\sqrt{2}y\) have
squares summing to exactly that value. Omitting \(\sqrt2\) breaks isometry and
the probability normalization.

## The next ridge

RMT-07 has established the geometry that a clean invariance proof needs. The
intrinsic standard Gaussian is basis free and invariant. The ambient GUE law
is a genuine probability measure concentrated on Hermitian matrices. What is
missing is no longer vague: it is one normalized equality of finite product
and pushforward measures.

Once that bridge is checked, the existing commuting-square theorem can move
intrinsic congruence to ambient `RandomMatrix.congruence`, and the project's
law-level interface can finally discharge
`RandomMatrix.IsUnitaryConjugationInvariant (GUE.matrixLaw n)`. Only then
should density formulas or invariant-ensemble spectral calculations be built
on top.

## References

The external links below were opened and checked on 2026-07-21. The pinned
local Mathlib 4.32.0 source remains the API authority for the Lean proofs.

<a id="ref-guionnet-2022"></a>
**Alice Guionnet.**
["Rare Events in Random Matrix Theory"](https://ems.press/content/book-chapter-files/33150),
*Proceedings of the International Congress of Mathematicians 2022*, volume 2,
pages 1008–1052. [DOI 10.4171/ICM2022/174](https://doi.org/10.4171/ICM2022/174).
Section 1.1.1 states the GUE coordinate variances, matrix density convention,
and invariance under unitary conjugation. Those statements supply classical
context; this chapter claims only the portions checked in the local Lean
module.

<a id="ref-mathlib-release"></a>
**Mathlib contributors.**
[Mathlib 4.32.0 release](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
2026. This is the exact dependency release selected by
`formalization/lakefile.toml`.

<a id="ref-mathlib-multivariate"></a>
**Mathlib contributors.**
[Multivariate Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Multivariate.html),
Mathlib 4 documentation. The page defines `stdGaussian` on finite-dimensional
real inner-product spaces, states its basis-independent orthonormal-coordinate
description, and proves `stdGaussian_map` for real linear isometric
equivalences.

<a id="ref-mathlib-euclidean"></a>
**Mathlib contributors.**
[Euclidean spaces and inner products](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/InnerProductSpace/PiL2.html),
Mathlib 4 documentation. This is the official source for `EuclideanSpace`, its
pair-indexed inner product, finite-dimensional instances, norms, and
orthonormal-basis infrastructure.

<a id="ref-mathlib-hermitian"></a>
**Mathlib contributors.**
[Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html),
Mathlib 4 documentation. This module defines `Matrix.IsHermitian` and supplies
its entrywise, additive, real-scalar, and congruence closure theorems.

<a id="ref-mathlib-unitary"></a>
**Mathlib contributors.**
[The unitary group](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/UnitaryGroup.html),
Mathlib 4 documentation. This page packages finite unitary matrices and the
identities \(U^*U=I\) and \(UU^*=I\) used for inverse congruence and isometry.

<a id="ref-mathlib-trace"></a>
**Mathlib contributors.**
[Matrix trace](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Trace.html),
Mathlib 4 documentation. This is the official interface for finite matrix
trace and cyclic multiplication used in the Frobenius invariance proof.
