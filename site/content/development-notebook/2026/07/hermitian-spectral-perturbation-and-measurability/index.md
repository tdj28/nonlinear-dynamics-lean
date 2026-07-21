---
title: "Hermitian Spectral Stability in Lean: From Weyl's Bound to Measurable Random Spectra"
slug: "hermitian-spectral-perturbation-and-measurability"
date: 2026-07-21
weight: -25
author: "tdj28"
summary: "A machine-checked finite-dimensional perturbation argument: Frobenius control of every decreasing Hermitian eigenvalue, exact 1-Lipschitz spectrum maps in the sup metric, and unconditional measurability of spectral counting and empirical-measure observables."
lead: |
  Eigenvalues are roots, but ordered eigenvalues must also move predictably when a matrix moves. RMT-10B proves that every decreasing Hermitian eigenvalue changes by at most the Frobenius size of the matrix perturbation. The proof builds the finite-dimensional variational witness from ordered eigenspaces, then turns the bound into continuity, measurability, and unconditional random spectral observables.
key_result: |
  For intrinsic finite Hermitian matrices `A` and `B`, Lean proves `|λᵢ(A) - λᵢ(B)| ≤ ‖A - B‖` at every ordered index. Each coordinate and the full `Fin n → ℝ` spectrum are 1-Lipschitz, where the vector codomain carries its product sup metric. The resulting continuity discharges every eigenvalue-measurability hypothesis left open by RMT-10A, including the ambient-versus-intrinsic Gaussian unitary ensemble (GUE) pushforward equality.
draft: true
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Finite-dimensional spectral perturbation, variational geometry, and measurable random spectra"
reading_time: "90 to 125 minutes"
prerequisites:
  - "Finite Hermitian matrices and orthonormal eigenbases"
  - "Decreasing ordered eigenvalues with multiplicity"
  - "Frobenius geometry and finite-dimensional subspaces"
  - "Lipschitz continuity and measurable maps"
  - "The RMT-10A counting and empirical spectral measures"
  - "No prior Lean proof experience required"
lean_module: "NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity"
lean_source: "formalization/NonlinearDynamics/Random/RandomMatrices/HermitianSpectrumContinuity.lean"
tags:
  - "Lean 4"
  - "Hermitian spectrum"
  - "Weyl perturbation bound"
  - "Min-max argument"
  - "Frobenius norm"
  - "Lipschitz continuity"
  - "Measurable eigenvalues"
  - "Empirical spectral measure"
og_image: "hermitian-spectral-perturbation-and-measurability-card.png"
og_image_alt: "Warm-paper teaching card showing a Hermitian matrix perturbation feeding an intersecting-subspace witness, an ordered-level stability bound, measurable spectral maps, and an ensemble-law bridge; the footer distinguishes the sup-metric result from Hoffman-Wielandt."
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
**Editorial status.** This teaching chapter remains a draft while human
editorial acceptance and the separate scientific-integrity and zero-context
expert-reader reviews are pending. The checked Lean source is authoritative
for every theorem statement.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** RMT-10A defined the decreasingly ordered eigenvalue vector of an
intrinsic finite Hermitian matrix, then built its spectral counting and
empirical measures. Its measure-valued interfaces remained conditional on one
analytic input: measurability of every ordered eigenvalue coordinate.

RMT-10B closes that gap with a direct finite-dimensional proof. It reindexes
Mathlib's Hermitian orthonormal eigenbasis into the same order as the project's
eigenvalue vector, expands the real quadratic form in those coordinates, and
constructs top and bottom spectral subspaces. Their dimensions add to one more
than the ambient dimension, so they share a nonzero vector. That witness
simultaneously bounds one matrix's quadratic form from below and the other's
from above. A Frobenius matrix-vector estimate controls the difference, giving
a one-sided Weyl inequality and then
\[
  \left|\lambda_i(A)-\lambda_i(B)\right|
  \le \left\|A-B\right\|_{\mathrm F}.
\]

Lean packages the coordinate maps and the whole ordered vector as
`LipschitzWith 1`, derives continuity and measurability, and invokes the
conditional RMT-10A interfaces with their hypotheses now proved. The vector
codomain uses the product sup metric. This is not a formalization of the
Hoffman-Wielandt Euclidean matching inequality, an operator-norm-optimal Weyl
bound, eigenvector stability, differentiability, or an asymptotic spectral
law.
{{< /panel >}}

This is the proof-to-prose companion for
`formalization/NonlinearDynamics/Random/RandomMatrices/HermitianSpectrumContinuity.lean`.
It maps all fourteen public theorems and the eighteen private definitions and
proof helpers in source order.

The immediate predecessor,
[Ordered Hermitian Spectra in Lean]({{< relref "/development-notebook/2026/07/ordered-hermitian-spectra-and-empirical-measures" >}}),
constructed the ordered spectrum and its finite measures while leaving
coordinatewise measurability explicit. RMT-10B preserves that interface and
supplies exactly the missing theorem. Reusable background appears under
{{< refterm "empirical-spectral-measure" >}},
{{< refterm "hermitian-matrix" >}},
{{< refterm "hermitian-frobenius-geometry" >}},
{{< refterm "weyl-eigenvalue-bound" >}},
{{< refterm "measurable-space" >}},
{{< refterm "pushforward-measure" >}}, and
{{< refterm "probability-law" >}}.

Its immediate successor,
[Finite Gaussian Unitary Ensemble Spectral Laws in Lean]({{< relref "/development-notebook/2026/07/finite-gue-empirical-spectral-laws-and-moments" >}}),
uses the completed measurability bridge to name the law of the random
empirical measure, construct its Giry barycenter, and transport the first two
exact normalized GUE moments.

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| First encounter | [The stability question](#the-stability-question) | Understand why sorted roots need perturbation control |
| Physics route | [Energy levels under a finite perturbation](#energy-levels-under-a-finite-perturbation) | Read the theorem as a deterministic Hamiltonian error bar |
| Geometry route | [The dimension count that creates a witness](#the-dimension-count-that-creates-a-witness) | See why top and bottom spectral subspaces must meet |
| Variational route | [Quadratic forms bracket the ordered level](#quadratic-forms-bracket-the-ordered-level) | Follow the finite min-max mechanism without importing a black box |
| Norm route | [A vector is a one-column matrix](#a-vector-is-a-one-column-matrix) | Derive the Frobenius matrix-vector estimate |
| Metric route | [One bound, two Lipschitz theorems](#one-bound-two-lipschitz-theorems) | Distinguish scalar and full-vector codomain metrics |
| Probability route | [Closing the measurability gate](#closing-the-measurability-gate) | Turn pointwise spectra into random measure-valued observables |
| Lean route | [The complete declaration map](#the-complete-declaration-map) | Audit all public and private declarations |
| Integrity route | [Strict nonclaims](#strict-nonclaims) | Separate this theorem from stronger perturbation results |

### Learning objectives

By the summit, a reader should be able to:

1. state the exact Frobenius perturbation bound for each decreasingly ordered
   Hermitian eigenvalue;
2. explain why ordering by value survives degeneracies even when individual
   eigenvector labels do not;
3. describe how Mathlib's orthonormal eigenbasis is reindexed to match
   `orderedHermitianEigenvalues`;
4. derive the weighted quadratic-form expansion in that basis;
5. identify the top \(i+1\) and bottom \(n-i\) spectral subspaces;
6. prove that those subspaces have a nonzero intersection by dimension;
7. use support vanishing to bracket the quadratic form by the \(i\)-th
   eigenvalue;
8. derive a Frobenius matrix-vector bound by treating a vector as a one-column
   matrix;
9. control the difference of two Hermitian quadratic forms;
10. cancel the squared norm of a nonzero witness without hiding positivity;
11. obtain an absolute bound by swapping the two matrices;
12. read the scalar `LipschitzWith 1` theorem in the real metric;
13. read the vector `LipschitzWith 1` theorem in the product sup metric;
14. distinguish this result from the Hoffman-Wielandt Euclidean matching
    inequality and the sharper operator-norm Weyl estimate;
15. follow the implication from Lipschitz to continuous to measurable;
16. see how one coordinatewise measurability theorem discharges all four
    measure-valued interfaces from RMT-10A;
17. explain the unconditional ambient/intrinsic GUE pushforward equality; and
18. state precisely what remains unproved about eigenvectors, gaps, densities,
    and large-dimension behavior.

## The stability question

RMT-10A supplied a function
\[
  H\longmapsto
  \bigl(\lambda_0(H),\ldots,\lambda_{n-1}(H)\bigr),
\]
where the real eigenvalues are listed in decreasing order and repeated
according to algebraic multiplicity. That definition answers the static
question: what ordered spectrum belongs to one Hermitian matrix?

The analytic question compares two matrices. If \(A\) and \(B\) are close in
the intrinsic Frobenius geometry, must their \(i\)-th ordered eigenvalues be
close? RMT-10B proves
\[
  \left|\lambda_i(A)-\lambda_i(B)\right|
  \le \left\|A-B\right\|_{\mathrm F}.
\]
This has the coordinate-stability shape associated with the classical
Hermitian eigenvalue inequalities initiated by
[Weyl (1912)](#ref-weyl-1912), but the checked right side is specifically the
Frobenius norm produced by this module's direct argument.
The norm on the right is the norm already carried by
`HermitianEuclidean n`. RMT-07 built that intrinsic real Euclidean space from
ambient Frobenius coordinates, so no new metric is chosen here. The bound is
uniform in the index, includes repeated eigenvalues, and is vacuous in
dimension zero because there is no `i : Fin 0`.

The result does three jobs. It is a deterministic error estimate for finite
Hermitian spectra. It makes each ordered coordinate continuous. Finally, it
makes the spectrum a legitimate measurable random observable, unlocking the
measure-valued constructions from RMT-10A.

Continuity is not obtained by saying that polynomial roots "obviously vary
continuously." Sorted repeated roots need an actual theorem, especially at
collisions. The perturbation inequality provides a quantitative result that
remains valid exactly where eigenvector labels become ambiguous.

{{< mermaid >}}
flowchart LR
  A["two intrinsic Hermitian matrices"] --> B["ordered eigenbases"]
  B --> C["top and bottom spectral subspaces"]
  C --> D["nonzero intersection witness"]
  D --> E["one-sided level bound"]
  E --> F["absolute Frobenius bound"]
  F --> G["1-Lipschitz ordered spectrum"]
  G --> H["continuity and measurability"]
  H --> I["unconditional random spectral measures"]
{{< /mermaid >}}

<p class="figure-note"><strong>Figure.</strong> The proof does not call an
opaque eigenvalue-continuity oracle. It creates one vector that lies in a top
spectral subspace for the first matrix and a bottom spectral subspace for the
second, controls its two quadratic forms, and then transports the coordinate
estimate through topology and probability.</p>

## Energy levels under a finite perturbation

In finite quantum mechanics, a Hermitian matrix represents an observable, and
a finite Hamiltonian's eigenvalues are its possible energy levels. Suppose a
model Hamiltonian \(H\) is replaced by \(H+E\), where \(E\) collects a field
perturbation, truncation error, calibration error, or numerical approximation.
The checked bound implies, for every ordered level,
\[
  \left|\lambda_i(H+E)-\lambda_i(H)\right|
  \le \left\|E\right\|_{\mathrm F}.
\]

This is a worst-case deterministic certificate. It needs no distribution for
the perturbation, no nondegeneracy assumption, and no first-order expansion.
If two levels collide, the ordered list still moves continuously. What can
fail at a collision is a persistent identity for a particular eigenvector or
eigenstate, not the ordered numerical spectrum.

The distinction matters physically. A small perturbation can rotate an
eigenbasis dramatically inside a nearly degenerate subspace while moving every
energy level only slightly. RMT-10B controls the latter. It proves no
eigenvector angle bound, spectral-projector estimate, adiabatic theorem, or
selection rule.

As a paper consequence, if two adjacent levels of \(H\) are separated by more
than \(2\varepsilon\) and \(\left\|E\right\|_{\mathrm F}\le\varepsilon\), their
ordered gap cannot close. This elementary corollary is not exported as a named
Lean theorem. It says nothing about random level repulsion or universal
spacing statistics.

{{< panel "info" >}}
**Ordering is not state tracking.** The coordinate \(\lambda_i(H)\) means the
\(i\)-th value after sorting, not "the energy of the same eigenvector as a
parameter changes." At a degeneracy, sorted values remain stable while a
preferred basis inside the eigenspace may not exist.
{{< /panel >}}

## An ordered orthonormal eigenbasis

The first private definition is `orderedHermitianEigenvectorBasis`. Mathlib
supplies an orthonormal eigenbasis for the symmetric linear map associated
with a Hermitian matrix
([Mathlib spectrum documentation](#ref-mathlib-spectrum)). RMT-10B reindexes
that basis by the same order-preserving finite cast used for
`orderedHermitianEigenvalues`.

This alignment is structural. A top subspace spanned by indices at most \(i\)
means nothing unless basis index \(j\) carries ordered eigenvalue
\(\lambda_j\). The theorem
`orderedHermitianEigenvectorBasis_repr_mulVec` proves
\[
  \operatorname{repr}_H(Hx)_i
  {} =
  \lambda_i(H)\operatorname{repr}_H(x)_i.
\]
Lean represents vectors in `EuclideanSpace ℂ (Fin n)` with an `Lp` wrapper,
so the theorem visibly passes through `WithLp.toLp`. The underlying statement
is familiar: in an eigenbasis, applying \(H\) multiplies each coordinate by
its eigenvalue.

The private scalar helper `re_inner_real_mul_self` proves
\[
  \operatorname{Re}\langle z,rz\rangle=r\lVert z\rVert^2
\]
for \(r\in\mathbb R\) and \(z\in\mathbb C\). It is the local bridge between a
complex inner product and the real quadratic form of a Hermitian operator.

Combining coordinate action, preservation of inner products by the basis
representation, and the finite `PiLp` formula,
`hermitian_quadratic_eq_weighted_sum` obtains
\[
  q_H(x)
  {} =
  \operatorname{Re}\langle x,Hx\rangle
  {} =
  \sum_j\lambda_j(H)
    \left|\operatorname{repr}_H(x)_j\right|^2.
\]
Every weight is nonnegative. That simple fact powers both variational
inequalities.

## Spectral subspaces from index intervals

Fix \(i : \operatorname{Fin}(n)\). The private definitions select two pieces
of an ordered eigenbasis:
\[
  T_i(H)=\operatorname{span}\{e_j(H):j\le i\},
  \qquad
  B_i(H)=\operatorname{span}\{e_j(H):i\le j\}.
\]
Their Lean names are `orderedTopEigenSubspace` and
`orderedBottomEigenSubspace`. The top space includes the first \(i+1\)
eigenvectors. The bottom space includes the final \(n-i\) eigenvectors. Both
include the \(i\)-th position.

The interval types are `Set.Iic i` and `Set.Ici i`. This is one reason the
order-preserving basis reindexing was necessary. An arbitrary equivalence
would preserve cardinality but destroy the meaning of these intervals.

The simp theorems `finrank_orderedTopEigenSubspace` and
`finrank_orderedBottomEigenSubspace` prove
\[
  \dim_{\mathbb C}T_i(H)=i+1,
  \qquad
  \dim_{\mathbb C}B_i(H)=n-i.
\]
Each uses `finrank_span_eq_card`. Orthonormality gives linear independence,
composition with subtype inclusion keeps the selected family independent,
and finite interval cardinality completes the calculation.

The helpers `orderedTopEigenSubspace_eq_span_image` and
`orderedBottomEigenSubspace_eq_span_image` rewrite the subtype-indexed ranges
into ordinary basis-image spans. Then
`ordered_repr_eq_zero_of_mem_top` says that \(x\in T_i(H)\) and \(i\lt j\)
force coordinate \(j\) to vanish. Dually,
`ordered_repr_eq_zero_of_mem_bottom` says that \(x\in B_i(H)\) and \(j\lt i\)
force coordinate \(j\) to vanish. Both ask the underlying basis for a
support-subset theorem and contradict any forbidden nonzero coordinate.

This explicit layer closes a gap paper proofs often suppress. Membership in a
span and vanishing of representation coordinates are related facts, not the
same expression to Lean.

## Quadratic forms bracket the ordered level

On the top subspace, only indices \(j\le i\) contribute. Antitonicity gives
\(\lambda_j(H)\ge\lambda_i(H)\), so
\[
  \lambda_i(H)\lVert x\rVert^2\le q_H(x)
  \qquad\text{for }x\in T_i(H).
\]
This is
`ordered_eigenvalue_mul_norm_sq_le_quadratic_of_mem_top`. The proof transports
the norm through the orthonormal representation, expands the Euclidean norm
square, distributes \(\lambda_i(H)\), and compares each term. Forbidden
coordinates are zero, so they close even where the eigenvalue order points the
other way.

On the bottom subspace, only \(j\ge i\) contributes and
\(\lambda_j(H)\le\lambda_i(H)\). The dual theorem
`quadratic_le_ordered_eigenvalue_mul_norm_sq_of_mem_bottom` proves
\[
  q_H(x)\le\lambda_i(H)\lVert x\rVert^2
  \qquad\text{for }x\in B_i(H).
\]
These two inequalities are the finite variational engine. The module does not
export a general Courant-Fischer formula involving extrema over all subspaces.
It proves exactly the brackets needed by the perturbation theorem.

## The dimension count that creates a witness

For two matrices \(A\) and \(B\), consider \(T_i(A)\cap B_i(B)\). Its two
source dimensions add to
\[
  (i+1)+(n-i)=n+1.
\]
Two subspaces of an \(n\)-dimensional space with dimensions totaling \(n+1\)
cannot be disjoint. The private theorem `ordered_top_inf_bottom_ne_bot`
formalizes this by contradiction. If the intersection were bottom, Mathlib's
`Submodule.finrank_add_finrank_le_of_disjoint` would force \(n+1\le n\)
([finite-dimensional lemmas](#ref-mathlib-finrank)). `omega` closes the
impossible arithmetic.

Choose a nonzero \(x\) in the intersection. It satisfies
\[
  \lambda_i(A)\lVert x\rVert^2\le q_A(x),
  \qquad
  q_B(x)\le\lambda_i(B)\lVert x\rVert^2.
\]
It need not be an eigenvector of either matrix. It is a dimension-forced
variational witness located in two different spectral subspaces.

{{< mermaid >}}
flowchart TD
  V["ambient complex space: dimension n"]
  T["top space of A: dimension i plus one"]
  B["bottom space of B: dimension n minus i"]
  X["shared nonzero vector"]
  V --> T
  V --> B
  T --> X
  B --> X
  X --> L["A form: lower bracket at ordered level i"]
  X --> U["B form: upper bracket at ordered level i"]
{{< /mermaid >}}

<p class="figure-note"><strong>Figure.</strong> The selected dimensions sum
to one more than the ambient dimension, forcing a nonzero intersection.
Membership in the top space of the first matrix and the bottom space of the
second supplies opposite quadratic-form bounds at the same ordered index.</p>

## A vector is a one-column matrix

The first public theorem, `norm_mulVec_le_frobenius`, states:

~~~lean
theorem norm_mulVec_le_frobenius {n : ℕ}
    (A : Matrix (Fin n) (Fin n) ℂ)
    (x : EuclideanSpace ℂ (Fin n)) :
    ‖WithLp.toLp 2 (A *ᵥ x)‖ ≤
      ‖matrixToFrobenius A‖ * ‖x‖
~~~

The proof uses a clean matrix trick. Regard \(x\) as an \(n\)-by-one matrix by
replicating it over `Fin 1`. Matrix-vector multiplication then becomes
ordinary matrix multiplication:
\[
  \operatorname{col}(Ax)=A\,\operatorname{col}(x).
\]
Mathlib proves Frobenius submultiplicativity,
\[
  \lVert AC\rVert_{\mathrm F}
  \le\lVert A\rVert_{\mathrm F}\lVert C\rVert_{\mathrm F},
\]
and identifies the Frobenius norm of a replicated one-column matrix with the
Euclidean vector norm
([Mathlib matrix norms](#ref-mathlib-normed)). The private helper
`norm_matrixToFrobenius_eq_frobenius` aligns the project's Frobenius carrier
with Mathlib's matrix norm by expanding the same finite sum of squared entry
norms.

The theorem is reusable beyond this proof, which is why it is public. Its norm
is specifically the Frobenius norm selected in the statement. No claim is made
that this is the best matrix norm constant.

## Comparing two quadratic forms

The private definition `hermitianQuadratic` names
\[
  q_H(x)=\operatorname{Re}\langle x,Hx\rangle.
\]
For fixed \(x\), subtraction and linearity give
\[
  q_A(x)-q_B(x)
  {} =
  \operatorname{Re}\langle x,(A-B)x\rangle.
\]

The helper `abs_hermitianQuadratic_sub_le_frobenius` combines three bounds:
\[
\begin{aligned}
  \left|q_A(x)-q_B(x)\right|
  &\le \left|\langle x,(A-B)x\rangle\right|\\
  &\le \lVert x\rVert\,\lVert(A-B)x\rVert\\
  &\le \lVert A-B\rVert_{\mathrm F}\,\lVert x\rVert^2.
\end{aligned}
\]
The first bounds the real part by the complex norm. The second is
Cauchy-Schwarz. The third invokes `norm_mulVec_le_frobenius`. Lean also proves
explicitly that subtracting the two wrapped matrix-vector products equals
applying the matrix difference.

Insert the nonzero intersection witness. The top and bottom brackets give
\[
  \bigl(\lambda_i(A)-\lambda_i(B)\bigr)\lVert x\rVert^2
  \le
  \lVert A-B\rVert_{\mathrm F}\lVert x\rVert^2.
\]
Because \(x\ne0\), its squared norm is strictly positive. Lean records this
with `norm_pos_iff`, squares the positive value, and uses
`mul_le_mul_iff_of_pos_right` to cancel it. The public one-sided theorem is:

~~~lean
theorem orderedHermitianEigenvalues_le_add_frobenius {n : ℕ}
    (A B : HermitianEuclidean n) (i : Fin n) :
    orderedHermitianEigenvalues A i ≤
      orderedHermitianEigenvalues B i + ‖A - B‖
~~~

Swap \(A\) and \(B\), rewrite
\(\lVert B-A\rVert=\lVert A-B\rVert\), and combine the directions with
`abs_le`:

~~~lean
theorem abs_orderedHermitianEigenvalues_sub_le_frobenius {n : ℕ}
    (A B : HermitianEuclidean n) (i : Fin n) :
    |orderedHermitianEigenvalues A i -
      orderedHermitianEigenvalues B i| ≤ ‖A - B‖
~~~

This quantitative theorem is the summit from which the topological and
probability results descend.

## One bound, two Lipschitz theorems

Mathlib's `LipschitzWith K f` means that output distance is at most \(K\)
times input distance, with `K : ℝ≥0`
([Mathlib Lipschitz documentation](#ref-mathlib-lipschitz)). RMT-10B exports
two constant-one theorems.

`lipschitzWith_orderedHermitianEigenvalues_apply i` fixes an index. The
codomain is \(\mathbb R\), so distance is absolute difference:
\[
  d\bigl(\lambda_i(A),\lambda_i(B)\bigr)
  {} =
  \left|\lambda_i(A)-\lambda_i(B)\right|
  \le d(A,B).
\]

`lipschitzWith_orderedHermitianEigenvalues` keeps the whole function
`Fin n → ℝ`. This finite function space carries the product sup metric:
\[
  d_\infty(\lambda(A),\lambda(B))
  {} =
  \max_i\left|\lambda_i(A)-\lambda_i(B)\right|.
\]
The proof uses `dist_pi_le_iff` and applies the coordinate theorem at every
index. Therefore
\[
  d_\infty(\lambda(A),\lambda(B))
  \le \lVert A-B\rVert_{\mathrm F}.
\]

{{< panel "warning" >}}
**The vector metric is part of the theorem.** The function type carries the
product sup metric here. The result does not say that the Euclidean norm of
the eigenvalue-difference vector is bounded by the Frobenius matrix norm with
constant one.
{{< /panel >}}

### Why this is not Hoffman-Wielandt

Hoffman and Wielandt's original theorem concerns a Euclidean sum of squared
spectral displacements for normal matrices after matching their spectra
([Hoffman and Wielandt, 1953](#ref-hoffman-wielandt)). For Hermitian matrices,
ordered matching gives the familiar shape
\[
  \sum_i\left|\lambda_i(A)-\lambda_i(B)\right|^2
  \le \lVert A-B\rVert_{\mathrm F}^2.
\]
RMT-10B does not prove that statement. Its vector result is
\[
  \max_i\left|\lambda_i(A)-\lambda_i(B)\right|
  \le \lVert A-B\rVert_{\mathrm F}.
\]

| Result | Spectral output metric | Matrix input metric | Status here |
|---|---|---|---|
| RMT-10B coordinate bound | One absolute coordinate | Frobenius | Proved |
| RMT-10B vector bound | Product sup metric | Frobenius | Proved |
| Hoffman-Wielandt shape | Euclidean matched spectrum | Frobenius | Not proved |
| Sharp Weyl perturbation shape | Sup ordered spectrum | Operator norm | Not proved |

Coordinatewise Frobenius control gives only a dimension-dependent Euclidean
estimate if one separately sums the same bound. It does not recover the
constant-one Hoffman-Wielandt theorem. Conversely, the checked result is
already sufficient for continuity and measurability.

## Closing the measurability gate

A Lipschitz map is continuous. A continuous map between these Borel spaces is
measurable. RMT-10B exports both steps at scalar and vector level:

- `continuous_orderedHermitianEigenvalues_apply`;
- `continuous_orderedHermitianEigenvalues`;
- `measurable_orderedHermitianEigenvalues_apply`; and
- `measurable_orderedHermitianEigenvalues`.

The scalar theorem has exactly the hypothesis type required by RMT-10A:

~~~lean
∀ i, Measurable (fun H : HermitianEuclidean n =>
  orderedHermitianEigenvalues H i)
~~~

RMT-10A deliberately kept this assumption visible. RMT-10B invokes each
conditional interface with
`measurable_orderedHermitianEigenvalues_apply`:

1. `measurable_spectralCountingMeasure` proves that the finite sum of
   eigenvalue Dirac masses is measurable.
2. `measurable_empiricalSpectralMeasure` proves measurability after the
   zero-aware inverse-dimension scaling.
3. `measurable_empiricalSpectralProbability` proves measurability of the
   positive-dimensional bundled probability measure.
4. `measurable_ambientEmpiricalSpectralMeasure` proves measurability after the
   Hermitian-or-zero totalization on ambient matrices.

Finite summation, normalization, probability bundling, and ambient
totalization are not reproved. That separation validates the RMT-10A design:
one explicit analytic gate now opens every measure-valued route.

{{< mermaid >}}
flowchart TD
  W["coordinate Frobenius bound"] --> LC["coordinate 1-Lipschitz"]
  W --> LV["ordered vector 1-Lipschitz in sup metric"]
  LC --> CC["coordinate continuity"]
  LV --> CV["vector continuity"]
  CC --> MC["coordinate measurability"]
  CV --> MV["vector measurability"]
  MC --> S["spectral counting measure measurable"]
  MC --> E["empirical spectral measure measurable"]
  MC --> P["positive-dimensional probability wrapper measurable"]
  MC --> A["ambient empirical observable measurable"]
{{< /mermaid >}}

<p class="figure-note"><strong>Figure.</strong> The public dependency graph
keeps scalar and vector topology separate. RMT-10A's Giry interfaces consume
the scalar coordinate theorem, while full-vector measurability remains
available for later finite spectral statistics.</p>

## The unconditional GUE pushforward bridge

RMT-10A proved, under coordinatewise measurability, that two routes to a law on
real-line measures agree:
\[
  \operatorname{map}\!
    \left(\operatorname{GUE.matrixLaw}(n),
      \operatorname{ambientEmpiricalSpectralMeasure}(n)\right)
  {} =
  \operatorname{map}\!
    \left(\operatorname{GUE.intrinsicLaw}(n),
      \operatorname{empiricalSpectralMeasure}\right).
\]
Its conditional theorem is named
`map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw_of_measurable_eigenvalues`.
RMT-10B supplies the hypothesis and exports the clean unconditional theorem
`map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw`.

The left route samples an ambient GUE matrix and applies its totalized spectral
observable. The right samples an intrinsic Hermitian GUE matrix and applies the
intrinsic empirical measure. Their pushforward distributions agree.

The theorem does not yet give that common law a new finite-GUE spectral-law
definition. It does not compute an average measure or a density. It closes the
measurability and representation seam so the next slice can define and study
that law without carrying an assumption.

## The complete declaration map

The module exports fourteen theorems and keeps eighteen proof components
private. It adds no public definitions because RMT-10A already designed the
spectral objects.

### Public API

| Declaration | Exact role |
|---|---|
| `norm_mulVec_le_frobenius` | Bounds a complex matrix-vector product by Frobenius matrix norm times Euclidean vector norm |
| `orderedHermitianEigenvalues_le_add_frobenius` | Gives the one-sided ordered-coordinate perturbation inequality |
| `abs_orderedHermitianEigenvalues_sub_le_frobenius` | Gives the absolute coordinatewise Frobenius perturbation bound |
| `lipschitzWith_orderedHermitianEigenvalues_apply` | Packages one ordered coordinate as `LipschitzWith 1` |
| `lipschitzWith_orderedHermitianEigenvalues` | Packages the full ordered vector as `LipschitzWith 1` in the product sup metric |
| `continuous_orderedHermitianEigenvalues_apply` | Derives continuity of one ordered coordinate |
| `continuous_orderedHermitianEigenvalues` | Derives continuity of the full ordered vector |
| `measurable_orderedHermitianEigenvalues_apply` | Derives coordinatewise Borel measurability |
| `measurable_orderedHermitianEigenvalues` | Derives Borel measurability of the full ordered vector |
| `measurable_spectralCountingMeasure` | Discharges RMT-10A's hypothesis for the counting-measure observable |
| `measurable_empiricalSpectralMeasure` | Discharges RMT-10A's hypothesis for the zero-aware empirical measure |
| `measurable_empiricalSpectralProbability` | Discharges the hypothesis for the positive-dimensional `ProbabilityMeasure` wrapper |
| `measurable_ambientEmpiricalSpectralMeasure` | Makes the total ambient spectral observable unconditionally measurable |
| `map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw` | Gives unconditional equality of ambient and intrinsic GUE spectral pushforward laws |

### Private proof architecture

| Declaration | Proof job |
|---|---|
| `orderedHermitianEigenvectorBasis` | Reindexes Mathlib's Hermitian orthonormal eigenbasis into decreasing eigenvalue order |
| `orderedHermitianEigenvectorBasis_repr_mulVec` | Identifies every matrix-action coordinate with eigenvalue times input coordinate |
| `re_inner_real_mul_self` | Reduces a scalar complex inner product's real part to real weight times squared norm |
| `hermitian_quadratic_eq_weighted_sum` | Expands the Hermitian quadratic form as the ordered eigenvalue-weighted sum |
| `orderedTopEigenSubspace` | Spans eigenvectors with indices in `Set.Iic i` |
| `orderedBottomEigenSubspace` | Spans eigenvectors with indices in `Set.Ici i` |
| `finrank_orderedTopEigenSubspace` | Computes the top dimension as `i + 1` |
| `finrank_orderedBottomEigenSubspace` | Computes the bottom dimension as `n - i` |
| `orderedTopEigenSubspace_eq_span_image` | Rewrites the top subtype range as a basis-image span |
| `orderedBottomEigenSubspace_eq_span_image` | Rewrites the bottom subtype range as a basis-image span |
| `ordered_repr_eq_zero_of_mem_top` | Proves coordinates after `i` vanish in the top subspace |
| `ordered_repr_eq_zero_of_mem_bottom` | Proves coordinates before `i` vanish in the bottom subspace |
| `ordered_eigenvalue_mul_norm_sq_le_quadratic_of_mem_top` | Gives the lower quadratic bracket on the top subspace |
| `quadratic_le_ordered_eigenvalue_mul_norm_sq_of_mem_bottom` | Gives the upper quadratic bracket on the bottom subspace |
| `ordered_top_inf_bottom_ne_bot` | Forces a nonzero top/bottom intersection by finite dimension |
| `norm_matrixToFrobenius_eq_frobenius` | Aligns the project carrier norm with Mathlib's matrix Frobenius norm |
| `hermitianQuadratic` | Names the real Hermitian quadratic form |
| `abs_hermitianQuadratic_sub_le_frobenius` | Controls quadratic-form difference by Frobenius distance times squared vector norm |

The dependency spine has four levels: diagonal coordinates, variational
geometry, perturbation analysis, and public topological transport. Keeping the
basis and subspace machinery private lets later modules consume a stable
perturbation API without depending on its proof representation.

## Lean proof engineering

### Why not call a prepackaged Weyl theorem?

The pinned Mathlib checkout supplies the Hermitian spectral theorem,
orthonormal eigenbases, Frobenius multiplication bounds, and finite-dimensional
submodule arithmetic. It does not supply the exact project theorem with this
ordered indexing and intrinsic Frobenius carrier. RMT-10B composes the local
APIs into a direct proof instead of guessing a theorem name or hiding a new
assumption.

### Why reindex the basis, not only the eigenvalues?

RMT-10A reindexed `eigenvalues₀` to `Fin n`. A variational proof also needs
"all contributing indices are at most \(i\)." The basis must carry the same
order for support facts to connect to eigenvalue antitonicity.

### Why use spans and coordinate support?

Spectral subspaces could be represented through projectors or polynomial
functional calculus. This finite proof needs less machinery. Spans of selected
orthonormal eigenvectors expose their dimensions and support through existing
Mathlib lemmas.

### Why export the one-sided theorem?

The intersection argument naturally yields
\(\lambda_i(A)\le\lambda_i(B)+\lVert A-B\rVert\). The absolute theorem is a
small symmetric wrapper obtained by swapping matrices. Exporting both records
the proof's natural reusable form and keeps the hard argument out of metric
packaging.

### Why is the full-vector metric a sup metric?

The codomain is literally `Fin n → ℝ`, and Mathlib gives function spaces their
uniform product metric. `dist_pi_le_iff` reduces the vector goal to coordinate
goals. An `EuclideanSpace ℝ (Fin n)` codomain would encode a different theorem
and would need a Hoffman-Wielandt-style proof.

### Why prove scalar and vector measurability?

RMT-10A consumes a family of scalar measurable maps, so the coordinate theorem
is the direct discharge. Full-vector measurability is independently useful
for later functions of the ordered spectrum. Neither fact is hidden in
typeclass search.

## How to run the checked source

Load elan and compile this module with warnings promoted to errors:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomMatrices/HermitianSpectrumContinuity.lean
~~~

Build the complete Lean library:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake build
~~~

From the repository root, run the proof-to-prose and Hugo gates:

~~~sh
make check
~~~

Useful local API reconnaissance:

~~~sh
rg -n "eigenvectorBasis|eigenvalues₀|eigenvectorBasis_apply_self_apply" \
  formalization/.lake/packages/mathlib/Mathlib/Analysis/Matrix/Spectrum.lean \
  formalization/.lake/packages/mathlib/Mathlib/Analysis/InnerProductSpace/Spectrum.lean

rg -n "frobenius_norm_mul|frobenius_norm_replicateCol|replicateCol_mulVec" \
  formalization/.lake/packages/mathlib/Mathlib

rg -n "finrank_add_finrank_le_of_disjoint|repr_support_subset_of_mem_span" \
  formalization/.lake/packages/mathlib/Mathlib
~~~

The local checkout of the
[pinned Mathlib 4.32.0 release](#ref-mathlib-release) is the API authority.
Online documentation is an orientation map, not a substitute for compiling
the pinned source.

## Common failure modes

### Pairing sorted eigenvalues with an arbitrarily indexed basis

Cardinality reindexing does not preserve `Set.Iic` and `Set.Ici`. Variational
support claims require the basis and eigenvalue vector to share the same
order-preserving cast.

### Reversing the top-space inequality

The eigenvalues decrease. In the top space, \(j\le i\), so
\(\lambda_j\ge\lambda_i\) and the quadratic form is bounded below. In the
bottom space, \(i\le j\), so it is bounded above.

### Forgetting the shared index

Both selected intervals include \(i\). Their dimensions are \(i+1\) and
\(n-i\). The sum \(n+1\), not \(n\), forces a nonzero intersection.

### Dividing by a norm without proving nonzero

The witness comes from `exists_mem_ne_zero_of_ne_bot`. Lean proves the squared
norm is strictly positive before cancellation. An arbitrary intersection
element could be zero and would yield no eigenvalue comparison.

### Confusing the intrinsic norm with a matrix norm instance

Matrices admit several useful norms. The helper
`norm_matrixToFrobenius_eq_frobenius` explicitly aligns the project Euclidean
carrier with the Frobenius scope used by Mathlib's submultiplicativity theorem.

### Claiming the sharper operator-norm inequality

The right side is Frobenius norm. The operator-norm Weyl bound is stronger in
finite dimensions. It is not proved by silently renaming the checked norm.

### Calling the vector theorem Hoffman-Wielandt

`Fin n → ℝ` carries the sup metric here. Hoffman-Wielandt controls a Euclidean
sum after spectral matching. The codomain type and metric are part of the
formal claim.

### Treating continuity as differentiability

Lipschitz continuity permits corners. Ordered eigenvalues can be nonsmooth at
degeneracies. RMT-10B proves no derivative formula.

### Assuming measurable eigenvalues imply a density

Measurability licenses `Measure.map`. It does not imply absolute continuity,
a joint density, a Vandermonde factor, or integrability of an arbitrary
spectral observable.

## Strict nonclaims

RMT-10B does **not** prove:

- the operator-norm-optimal Weyl perturbation inequality;
- the Hoffman-Wielandt Euclidean eigenvalue matching theorem;
- a public Courant-Fischer or Rayleigh-Ritz min-max characterization;
- continuity or perturbation bounds for a chosen eigenbasis;
- Davis-Kahan estimates for eigenspaces or spectral projectors;
- differentiability or analyticity of eigenvalue branches;
- a Hellmann-Feynman derivative formula;
- level repulsion, avoided crossing, or random spacing statistics;
- spectral rigidity, eigenvalue concentration, or tail probabilities;
- a joint eigenvalue density for GUE;
- a Vandermonde Jacobian or matrix-to-spectrum change of variables;
- a new named finite-GUE empirical spectral law or the expectation of its
  sample empirical measure;
- normalized empirical spectral moment identities under GUE;
- Wasserstein or weak-convergence stability of empirical spectral measures;
- convergence to the semicircle law or another large-dimension limit;
- universality of local or global spectral statistics;
- non-Hermitian eigenvalue perturbation theory; or
- an executable numerical eigensolver with floating-point error analysis.

The Hoffman-Wielandt paper is cited to mark a nearby stronger theorem, not to
claim that this module formalizes it. The checked result is exactly the
coordinatewise and sup-metric Frobenius bound stated in Lean.

## Exercises with solutions

### Exercise 1: read the order

If \(j\le i\), which eigenvalue is larger?

**Solution.** Antitonicity gives
\(\lambda_i(H)\le\lambda_j(H)\). Earlier indices carry greater or equal
eigenvalues.

### Exercise 2: count the subspaces

For \(n=7\) and zero-based \(i=2\), what are the top and bottom dimensions?

**Solution.** The top interval contains \(0,1,2\), so its dimension is three.
The bottom interval contains \(2,3,4,5,6\), so its dimension is five. Their
sum is eight, one more than the ambient dimension.

### Exercise 3: explain the intersection

Why does dimension sum \(n+1\) force a shared nonzero vector?

**Solution.** If the intersection were only zero, the subspaces would be
disjoint and their dimension sum could not exceed \(n\). The computed sum
contradicts that inequality.

### Exercise 4: bracket the top form

Why does \(x\in T_i(H)\) imply
\(q_H(x)\ge\lambda_i(H)\lVert x\rVert^2\)?

**Solution.** Coordinates after \(i\) vanish. Every remaining index \(j\le i\)
has \(\lambda_j(H)\ge\lambda_i(H)\). Compare each nonnegative squared
coordinate weight and sum.

### Exercise 5: use the one-column trick

Why can matrix submultiplicativity bound `mulVec`?

**Solution.** A vector replicated over `Fin 1` is a one-column matrix.
Multiplying that column agrees with `mulVec`. Frobenius submultiplicativity
applies, and the one-column Frobenius norm equals the vector norm.

### Exercise 6: cancel honestly

What fails if the intersection witness is zero?

**Solution.** Both quadratic inequalities collapse to \(0\le0\). The squared
norm cannot be canceled, so no eigenvalue comparison follows. The witness must
be nonzero.

### Exercise 7: get the absolute value

How does the one-sided theorem yield the absolute bound?

**Solution.** Apply it to \(A,B\) and then to \(B,A\). Norm symmetry gives the
same right side. The two inequalities bound a difference and its negative,
which is the `abs_le` criterion.

### Exercise 8: identify the vector metric

Does the vector Lipschitz theorem prove
\[
  \left(\sum_i|\lambda_i(A)-\lambda_i(B)|^2\right)^{1/2}
  \le\lVert A-B\rVert_{\mathrm F}?
\]

**Solution.** No. Its function-space codomain carries the product sup metric.
It bounds the maximum coordinate displacement. The displayed Euclidean
statement has Hoffman-Wielandt shape and is not formalized here.

### Exercise 9: pass to probability

Why does continuity unlock the empirical spectral pushforward?

**Solution.** Lipschitz implies continuous, and continuous maps between these
Borel spaces are measurable. RMT-10A already lifted measurable eigenvalue
coordinates through Dirac sums and normalization into measurable
measure-valued maps.

### Exercise 10: audit dimension zero

Does the coordinate theorem need a special \(n=0\) branch?

**Solution.** It quantifies over `i : Fin n`, so there is no coordinate at
zero dimension. The all-dimension measure statements reuse RMT-10A's zero
measure policy, while its probability wrapper remains successor-only.

### Exercise 11: separate levels from states

Can the theorem prevent a large eigenvector rotation near a repeated level?

**Solution.** No. It controls ordered numerical eigenvalues only. A repeated
eigenspace has many orthonormal bases, and a small perturbation may select a
different one while moving the levels little.

### Exercise 12: classify the final theorem

What is unconditional about
`map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw`?

**Solution.** It no longer assumes coordinatewise eigenvalue measurability;
RMT-10B proves that premise. It identifies the two pushforward representations.
It still does not name the common law, compute moments, or derive a density or
limit.

## The next ridge

RMT-10B turns the finite Hermitian spectrum into an unconditional measurable
observable. Its completed successor,
[Finite Gaussian Unitary Ensemble Spectral Laws in Lean]({{< relref "/development-notebook/2026/07/finite-gue-empirical-spectral-laws-and-moments" >}}),
defines the finite-GUE empirical spectral law, gives its ambient and intrinsic
presentations, proves its zero-dimensional Dirac boundary, constructs its
mean measure, and connects its first two normalized spectral moments to the
exact trace identities from RMT-09.

That chapter keeps three layers separate: one sample empirical measure, a
probability law over empirical measures, and the averaged spectral measure.
It preserves the approved Wigner normalization. A semicircle law, joint
eigenvalue density, Vandermonde formula, local spacing statistic, or
large-\(n\) convergence theorem still needs additional mathematics.

## References

The links below were checked on 2026-07-21. The pinned local Mathlib 4.32.0
checkout remains the exact API authority for the Lean proof.

<a id="ref-mathlib-release"></a>
**Mathlib contributors.**
[Mathlib 4.32.0 release](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
2026. This is the release selected by `formalization/lakefile.toml`.

<a id="ref-mathlib-spectrum"></a>
**Mathlib contributors.**
[Hermitian matrix spectra](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Spectrum.html),
Mathlib 4 documentation. This official API page documents Hermitian
eigenvalues, the orthonormal eigenvector basis, basis-coordinate eigenvector
action, and the matrix spectral theorem used by the private proof.

<a id="ref-mathlib-normed"></a>
**Mathlib contributors.**
[Matrices as normed spaces](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Normed.html),
Mathlib 4 documentation. This official API page defines the Frobenius norm
scope and documents `Matrix.frobenius_norm_mul`.

<a id="ref-mathlib-finrank"></a>
**Mathlib contributors.**
[Finite-dimensional vector-space lemmas](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/FiniteDimensional/Lemmas.html),
Mathlib 4 documentation. This official API page documents
`Submodule.finrank_add_finrank_le_of_disjoint`, the inequality contradicted by
the top and bottom subspaces.

<a id="ref-mathlib-lipschitz"></a>
**Mathlib contributors.**
[Lipschitz maps in metric spaces](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Topology/MetricSpace/Lipschitz.html),
Mathlib 4 documentation. This official page defines `LipschitzWith`, its
nonnegative-real constant, and the distance-bound constructors used here.

<a id="ref-hoffman-wielandt"></a>
**Alan J. Hoffman and Helmut W. Wielandt.**
["The Variation of the Spectrum of a Normal Matrix"](https://doi.org/10.1215/S0012-7094-53-02004-3),
*Duke Mathematical Journal* 20(1), 37-39, 1953. This original paper proves the
normal-matrix spectral variation theorem bearing the authors' names. It is
cited to distinguish its Euclidean matched-spectrum inequality from the
sup-metric Frobenius result checked in RMT-10B.

<a id="ref-weyl-1912"></a>
**Hermann Weyl.**
["Das asymptotische Verteilungsgesetz der Eigenwerte linearer partieller
Differentialgleichungen (mit einer Anwendung auf die Theorie der
Hohlraumstrahlung)"](https://eudml.org/doc/158545),
*Mathematische Annalen* 71, 441-479, 1912. This original paper is the
historical source associated with Weyl's Hermitian eigenvalue inequalities.
RMT-10B proves only the finite coordinate perturbation statement and norm
choice written in its Lean theorem.
