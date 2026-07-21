---
title: "From Coordinates to Symmetry: Proving Finite GUE Unitary Invariance in Lean"
slug: "gue-unitary-invariance-from-normalized-coordinates"
date: 2026-07-21
weight: -10
author: "tdj28"
summary: "A guided checked proof of the normalized real-coordinate bridge behind finite GUE symmetry: the square-root-of-two Frobenius isometry, exact transport of the coordinate product measure, the scaled intrinsic standard Gaussian, the intrinsic-to-ambient commuting square, and the zero-dimensional boundary."
lead: |
  Entrywise Gaussian coordinates built the finite GUE law. Frobenius geometry supplied an invariant intrinsic Gaussian. RMT-08 is the bridge between them: normalize every free Hermitian coordinate, identify the exact pushforward measure, and transport intrinsic symmetry through the ambient inclusion without using a density or Jacobian.
key_result: |
  Lean now identifies the coordinate-built ambient GUE law exactly with the ambient image of a dimension-scaled intrinsic standard Gaussian. The scaled intrinsic law is invariant under unitary congruence, and the intrinsic-to-ambient commuting square transfers that symmetry to a checked proof of `RandomMatrix.IsUnitaryConjugationInvariant (GUE.matrixLaw n)` for every natural dimension, including zero.
draft: true
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Finite-dimensional Gaussian transport, Euclidean isometries, and invariant matrix laws"
reading_time: "95 to 125 minutes"
prerequisites:
  - "The coordinate-built finite GUE law and its Wigner variance convention"
  - "Frobenius geometry on the intrinsic real Hermitian space"
  - "Pushforward measures, product measures, and unitary congruence"
  - "No prior Lean proof experience required"
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleInvariance"
lean_source: "formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleInvariance.lean"
tags:
  - "Lean 4"
  - "Gaussian unitary ensemble"
  - "Unitary invariance"
  - "Frobenius geometry"
  - "Gaussian transport"
  - "Product measures"
  - "Normalization"
og_image: "gue-unitary-invariance-from-normalized-coordinates-card.png"
og_image_alt: "Warm-paper teaching card showing diagonal, square-root-of-two real-upper, and square-root-of-two imaginary-upper coordinates merging into a real Euclidean index, passing through a Frobenius isometry to a scaled intrinsic Gaussian, and then through the ambient inclusion to a unitary-invariant GUE matrix law, with the zero-dimensional branch shown separately."
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
**Abstract.** The finite GUE law from RMT-06 is assembled from a real diagonal
and a complex strict upper triangle. RMT-07 independently equips Hermitian
matrices with their intrinsic real Frobenius geometry and proves that its
canonical standard Gaussian is invariant under unitary congruence. The two
measures have the right relationship, but mathematical resemblance is not an
equality of Lean terms or measures.

The checked bridge uses one disjoint real index: diagonal coordinates,
strict-upper real coordinates, and strict-upper imaginary coordinates. The
upper coordinates are multiplied by \(\sqrt{2}\), exactly compensating for
their mirrored appearances in a Hermitian matrix. This gives a real linear
isometry from a Euclidean coordinate space to the intrinsic Hermitian space.
Finite product-measure equivalences then decode an independent common-variance
real Gaussian family into the RMT-06 block law. Mapping the Euclidean family
through the isometry produces a \(\sqrt{\operatorname{varianceScale}(n)}\)-
scaled intrinsic standard Gaussian.

The final step is a commuting square. Intrinsic unitary congruence commutes
with inclusion into ambient matrices. Pushforward composition therefore moves
the intrinsic symmetry theorem across the exact measure identification and
discharges the project's ambient unitary-invariance predicate. Dimension zero
is included by the same formulas: the real index is empty, the variance scale
is zero, and every relevant measure is the Dirac mass at the unique zero
point.
{{< /panel >}}

This is the proof-to-prose companion for
`formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleInvariance.lean`.
Every named public declaration in that stable source is mapped below.

The immediate predecessor,
[The Geometry Behind GUE in Lean]({{< relref "/development-notebook/2026/07/gue-frobenius-geometry-and-hermitian-support" >}}),
proves the intrinsic isometry and standard-Gaussian symmetry while carefully
not claiming symmetry of `GUE.matrixLaw`. The coordinate measure itself is
constructed in
[A Finite GUE Law in Lean]({{< relref "/development-notebook/2026/07/finite-gue-law-from-coordinates" >}}),
and its deterministic matrix assembly comes from
[Hermitian Coordinate Assembly]({{< relref "/development-notebook/2026/07/hermitian-coordinate-assembly" >}}).

For the parallel textbook treatment of this milestone, see
[From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance]({{< relref "/knowledge-base/deep-dives/normalized-hermitian-coordinates-to-gue-invariance" >}}).
Its slower prerequisite development continues in
[Intrinsic Hermitian Gaussian Symmetry and Matrix-Law Support]({{< relref "/knowledge-base/deep-dives/intrinsic-hermitian-gaussian-symmetry-and-matrix-law-support" >}}),
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}}),
and
[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}}).
Reusable definitions are indexed under
{{< refterm "gaussian-unitary-ensemble" >}},
{{< refterm "hermitian-frobenius-geometry" >}},
{{< refterm "normalized-hermitian-coordinates" >}},
{{< refterm "normalization-convention" >}},
{{< refterm "unitary-invariance" >}},
{{< refterm "pushforward-measure" "pushforward measure" >}} and
{{< refterm "independence" >}}.

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| First encounter | [The bridge in one picture](#the-bridge-in-one-picture) | See why the two earlier measures do not become equal by resemblance |
| Geometry route | [Why the upper triangle needs a square root of two](#why-the-upper-triangle-needs-a-square-root-of-two) | Derive the normalized Frobenius isometry |
| Probability route | [Decode one common-variance real product law](#decode-one-common-variance-real-product-law) | Follow exact finite product-measure transport |
| Gaussian route | [From a common product to a scaled standard Gaussian](#from-a-common-product-to-a-scaled-standard-gaussian) | Identify the dimension-dependent intrinsic law |
| Symmetry route | [The commuting square that transfers invariance](#the-commuting-square-that-transfers-invariance) | Move intrinsic symmetry to the ambient matrix law |
| Boundary route | [Dimension zero is part of the theorem](#dimension-zero-is-part-of-the-theorem) | Audit the empty-index and zero-scale case |
| Lean route | [The complete declaration map](#the-complete-declaration-map) | Audit all thirty-five public declarations and their proof engines |
| Integrity route | [What this milestone does not prove](#what-this-milestone-does-not-prove) | Separate unitary invariance from spectral and asymptotic claims |

### Learning objectives

By the summit, a reader should be able to:

1. explain why RMT-07's intrinsic Gaussian symmetry does not automatically
   apply to RMT-06's independently constructed coordinate law;
2. construct a disjoint real index with diagonal, upper-real, and
   upper-imaginary sectors;
3. derive the factor two in the Frobenius norm of a Hermitian matrix;
4. derive the corresponding \(\sqrt{2}\) rescaling of upper real and imaginary
   coordinates;
5. describe mutually inverse normalized analysis and synthesis maps;
6. explain why those maps are real linear and isometric;
7. turn a product of complex Cartesian Gaussian laws into two real product
   laws without assuming a density;
8. use sum-index and function-product equivalences to reassociate a finite
   product measure;
9. compute why division by \(\sqrt{2}\) changes common variance \(v\) into
   \(v/2\);
10. identify a common-variance Euclidean product as a scaled standard Gaussian;
11. state the intrinsic-to-ambient commuting square for unitary congruence;
12. prove the final measure equality by repeated pushforward composition;
13. understand why the same construction handles dimension zero; and
14. distinguish unitary invariance of the matrix law from density, spectral,
    moment, and asymptotic theorems.

## The bridge in one picture

{{< mermaid >}}
flowchart LR
  C["RMT-06 block coordinates"] --> M["coordinateMeasure n"]
  R["one real sum index"] --> P["common-variance real product"]
  P -->|"decode: divide upper sectors by sqrt(2)"| M
  R --> E["real Euclidean coordinate space"]
  E -->|"Frobenius linear isometry"| H["intrinsic Hermitian space"]
  P --> G["scaled intrinsic stdGaussian"]
  G -->|"ambient inclusion"| L["GUE.matrixLaw n"]
  U["intrinsic unitary isometry"] --> G
  G -->|"invariant"| G
  U -. "commuting square" .-> A["ambient unitary congruence"]
  A --> L
{{< /mermaid >}}

<p class="figure-note"><strong>Figure.</strong> RMT-06 supplies the coordinate
law and RMT-07 supplies intrinsic Gaussian symmetry. RMT-08 checks the product
decoder, normalized Frobenius isometry, scaled-law identification, and final
transfer. No density or Jacobian is needed: every step is an equality produced
by a measurable map.</p>

The temptation is to argue in one sentence: both laws are centered isotropic
Gaussians on Hermitian matrices, so they are equal. That sentence hides four
formal obligations:

1. the RMT-06 law is not initially a measure on the intrinsic Hermitian type;
2. its free coordinates are not orthonormal in their displayed normalization;
3. its probability law is packaged as a nested real/complex block product,
   not as Mathlib's `stdGaussian`; and
4. the final project predicate is about an ambient matrix pushforward, not an
   intrinsic subtype measure.

RMT-08 is the deliberate discharge of those four obligations.

## Camp one: one real index for all Hermitian degrees of freedom

Let

\[
D_n=\operatorname{Fin}(n),
\qquad
T_n=\{(i,j):i,j\in\operatorname{Fin}(n),\ i\lt j\}.
\]

RMT-06 stores a coordinate point as

\[
(d,u)\in (D_n\to\mathbb R)\times(T_n\to\mathbb C).
\]

That is the natural representation for assembly: one real diagonal value and
one complex number above the diagonal. It is not yet the natural real
Euclidean representation. Split each complex number into its real and
imaginary components and index the resulting coordinates by the disjoint sum

\[
I_n=D_n\sqcup(T_n\sqcup T_n).
\]

The three sectors mean:

- `inl i`: diagonal coordinate \(d_i\);
- `inr (inl ij)`: normalized real part of \(u_{ij}\); and
- `inr (inr ij)`: normalized imaginary part of \(u_{ij}\).

The nesting order is not deep mathematics. It is a concrete way to let Lean's
sum-type equivalences split and recombine finite dependent function spaces.
It also makes the dimension ledger transparent:

\[
|I_n|
=n+2\binom n2
=n^2.
\]

That cardinality is the familiar real dimension of the Hermitian matrices.
The bridge does not need to choose an arbitrary enumeration by
`Fin (n^2)`. Keeping the semantic sum index lets every proof know whether it
is looking at a diagonal, real-upper, or imaginary-upper coordinate.

### The same index enumerates every matrix position

The inner-product proof needs to compare a sum over \(I_n\) with a sum over all
matrix pairs. `hermitianRealIndexToPair` makes that comparison concrete. It
sends a diagonal index to \((i,i)\), a real-upper index to \((i,j)\), and the
corresponding imaginary-upper index to the reflected lower position
\((j,i)\). The last choice is deliberate: the two copies of each strict-upper
index account for the two ambient Frobenius entries.

`pairToHermitianRealIndex` performs the inverse classification by comparing
the row and column. The simplification theorems
`pairToHermitianRealIndex_toPair` and
`hermitianRealIndexToPair_pairTo` check the two round trips, and
`hermitianRealIndexEquivMatrixIndex` bundles them as a finite equivalence. The
geometry proof later invokes its finite-sum transport theorem instead of
proving a separate cardinality formula.

### The Euclidean carrier

The corresponding Hilbert carrier is

\[
E_n=\operatorname{EuclideanSpace}(\mathbb R,I_n).
\]

A point of \(E_n\) is a real function on \(I_n\) wrapped in the finite
\(\ell^2\) structure used by Mathlib. The wrapper supplies exactly the norm,
inner product, Borel measurable space, finite-dimensional instances, and
standard-Gaussian API that the bridge needs.

The index is empty at \(n=0\). Thus \(E_0\) has one point without any special
quotient or arbitrary basis choice.

## Why the upper triangle needs a square root of two

Take a Hermitian matrix \(H\) with diagonal entries \(d_i\in\mathbb R\) and
strict-upper entries

\[
u_{ij}=x_{ij}+\mathrm i y_{ij}
\qquad(i\lt j).
\]

Hermiticity forces \(H_{ji}=\overline{u_{ij}}\). The Frobenius norm counts
both positions:

\[
\begin{aligned}
\lVert H\rVert_F^2
&=\sum_i |d_i|^2
  +\sum_{i\lt j}\left(|u_{ij}|^2+|\overline{u_{ij}}|^2\right)\\
&=\sum_i d_i^2+2\sum_{i\lt j}|u_{ij}|^2\\
&=\sum_i d_i^2
  +\sum_{i\lt j}(\sqrt{2}x_{ij})^2
  +\sum_{i\lt j}(\sqrt{2}y_{ij})^2.
\end{aligned}
\]

Therefore the orthonormal real coordinates are

\[
d_i,
\qquad
\sqrt{2}\operatorname{Re}(u_{ij}),
\qquad
\sqrt{2}\operatorname{Im}(u_{ij}).
\]

This factor is forced simultaneously by geometry and probability. Omitting it
would make the coordinate-to-matrix map fail to preserve norm. It would also
leave diagonal coordinates with variance \(1/n\) and upper real coordinates
with variance \(1/(2n)\), so the resulting real vector would not be isotropic.

### Normalized analysis

The analysis map reads an intrinsic Hermitian point \(H\) into \(E_n\):

\[
\mathcal A_n(H)=
\begin{cases}
H_{ii}, & \text{in the diagonal sector},\\
\sqrt{2}\operatorname{Re}(H_{ij}), & \text{in the upper-real sector},\\
\sqrt{2}\operatorname{Im}(H_{ij}), & \text{in the upper-imaginary sector}.
\end{cases}
\]

The diagonal is real because \(H\) is Hermitian. In Lean, extracting it as a
real scalar may require an explicit proof that its imaginary part vanishes;
the intrinsic subtype carries the Hermiticity evidence that supplies this
fact.

This operation is `RandomMatrix.normalizedHermitianAnalysis`. It returns a
point of `EuclideanSpace ℝ (HermitianRealIndex n)` directly, using
`WithLp.toLp 2` to install the finite \(\ell^2\) wrapper.

### Normalized synthesis

The synthesis map sends \(z\in E_n\) back to a Hermitian matrix. Its free
coordinates are

\[
d_i=z_{\mathrm{diag}(i)},
\qquad
u_{ij}=\frac{z_{\mathrm{re}(ij)}}{\sqrt{2}}
       +\mathrm i\frac{z_{\mathrm{im}(ij)}}{\sqrt{2}}.
\]

The existing deterministic Hermitian assembly then fills the lower triangle
by conjugation. Division is only by the fixed positive number \(\sqrt{2}\),
never by \(\sqrt{n}\). Consequently this definition remains valid when
\(n=0\); there simply are no upper indices on which the formula can be
evaluated.

`RandomMatrix.realToHermitianCoordinates` is the raw decoder from a real
function on \(I_n\) to the RMT-06 product carrier, and
`RandomMatrix.measurable_realToHermitianCoordinates` checks that decoder's
measurability. `RandomMatrix.normalizedHermitianAssembly` composes the decoder
with the old Hermitian assembly and lands in the intrinsic subtype.
`RandomMatrix.hermitianToMatrix_normalizedHermitianAssembly` records the
corresponding commuting edge to ambient matrices.

Three simplification theorems expose the entries:
`RandomMatrix.normalizedHermitianAssembly_apply_diag`,
`RandomMatrix.normalizedHermitianAssembly_apply_upper`, and
`RandomMatrix.normalizedHermitianAssembly_apply_lower`. They are the local API
used by inverse and inner-product proofs, so downstream arguments do not need
to unfold the nested conditional assembly definition.

### Inverses, linearity, and isometry

The intended proof proceeds in increasing structural strength:

1. show that analysis after synthesis returns every diagonal, upper-real, and
   upper-imaginary coordinate;
2. show that synthesis after analysis returns every diagonal, upper, and lower
   matrix entry;
3. package synthesis and analysis as a real linear equivalence; and
4. use the factor-two norm identity to upgrade it to a real linear isometric
   equivalence.

The entry cases matter. Above the diagonal, one uses the supplied complex
coordinate. Below the diagonal, equality follows only after conjugation is
tracked. On the diagonal, Hermiticity turns the complex entry into its real
part. A single `ext` without this trichotomy is unlikely to expose the right
normal form.

Once bundled, the isometry automatically gives continuity and measurability.
That matters twice: Mathlib's Gaussian isometry theorem expects a bundled real
linear isometry, and `Measure.map_map` requires the measurable maps whose
composition is being reassociated.

The checked names follow that ladder exactly.
`RandomMatrix.normalizedHermitianAnalysis_assembly` and
`RandomMatrix.normalizedHermitianAssembly_analysis` are the inverse laws;
`RandomMatrix.normalizedHermitianLinearEquiv` is the real linear bundle;
`RandomMatrix.normalizedHermitianAssembly_inner` is the exact inner-product
identity; and `RandomMatrix.normalizedHermitianLinearIsometryEquiv` is the
final isometric equivalence. The inner proof reindexes all matrix pairs through
`hermitianRealIndexEquivMatrixIndex`, splits the nested sum, uses
\((\sqrt{2})^2=2\), and closes the remaining scalar identity by ring algebra.

## Camp two: the probability ledger becomes isotropic

RMT-06 fixes the Wigner scale

\[
v_n=\operatorname{varianceScale}(n)
=\begin{cases}
0,&n=0,\\
1/n,&n\gt0.
\end{cases}
\]

Its coordinate law gives

\[
\operatorname{Var}(d_i)=v_n,
\qquad
\operatorname{Var}(x_{ij})
=\operatorname{Var}(y_{ij})
=v_n/2.
\]

After the geometric normalization,

\[
\operatorname{Var}(\sqrt{2}x_{ij})
=2(v_n/2)=v_n,
\]

and likewise for the imaginary part. Every coordinate indexed by \(I_n\) is
therefore centered Gaussian with the same variance \(v_n\). The normalized
real vector is isotropic before any matrix algebra is applied.

That variance calculation is necessary but not sufficient. Equal marginal
variances do not identify a joint law. The formal bridge must also retain the
product structure, hence independence, while it rearranges the three families.

## Decode one common-variance real product law

The clean proof direction starts from the single real product

\[
\Pi_n
=\bigotimes_{k\in I_n}\mathcal N(0,v_n)
\]

and decodes it into the nested RMT-06 coordinate space. This direction makes
the upper-coordinate formula literally divide by \(\sqrt{2}\).

### Step one: split the disjoint sum

A function on \(D_n\sqcup(T_n\sqcup T_n)\) is canonically the same thing as

\[
(D_n\to\mathbb R)
\times
\bigl((T_n\to\mathbb R)\times(T_n\to\mathbb R)\bigr).
\]

Mathlib's measurable equivalence for functions on a sum type supplies this
reassociation. Its measure-preserving theorem says that a product measure on
the sum index maps to the product of the two corresponding product measures.
Applying it twice isolates the diagonal, upper-real, and upper-imaginary
families
([Mathlib finite function-space measures](#ref-mathlib-pi)).

This is a structural probability theorem, not merely an equivalence of types.
The `map_eq` field is what permits later rewrites of measures.

### Step two: regroup two upper functions pointwise

The upper sectors initially have type

\[
(T_n\to\mathbb R)\times(T_n\to\mathbb R).
\]

The RMT-06 complex product is more naturally decoded pointwise from

\[
T_n\to(\mathbb R\times\mathbb R).
\]

Mathlib's measurable function/product equivalence turns one representation
into the other, and its measure-preserving theorem changes a product of two
function-space product measures into a function-space product of scalar
product measures. This is precisely the exchange

\[
\left(\bigotimes_{ij}\mu_{ij}\right)
\otimes
\left(\bigotimes_{ij}\nu_{ij}\right)
\longleftrightarrow
\bigotimes_{ij}(\mu_{ij}\otimes\nu_{ij}).
\]

### Step three: divide and reassemble each complex coordinate

At one upper index, send

\[
(r,s)\longmapsto \frac r{\sqrt{2}}+\mathrm i\frac s{\sqrt{2}}.
\]

Mathlib's real Gaussian scaling theorem gives

\[
\left(x\mapsto x/\sqrt{2}\right)_*
  \mathcal N(0,v_n)
=\mathcal N(0,v_n/2),
\]

because \((\sqrt{2})^2=2\). Its finite product mapping theorem lifts that
identity coordinatewise. The canonical real-pair/complex equivalence then
reassembles the two independent scalar laws as the Cartesian complex Gaussian
used by RMT-06.

The scalar identity is checked once as
`gaussianReal_map_div_sqrt_two`. The function `realUpperToComplex` performs
the pointwise pairing, and `measurable_realUpperToComplex` supplies its
ordinary measurability. `map_realUpperToComplex_gaussianProduct` then proves
the complete upper-family measure equality. Its proof names the scaling map,
the function/product split, and complexification separately, making every
`Measure.map_map` step visible.

The important words are *exactly the law used by RMT-06*. No uniqueness theorem
for generic Gaussian vectors and no appeal to a density is required.

### Step four: recover the nested coordinate measure

After the three transformations, the diagonal block is

\[
\bigotimes_{i\in D_n}\mathcal N(0,v_n),
\]

and the upper block is

\[
\bigotimes_{ij\in T_n}
\operatorname{CartesianComplexGaussian}(0,v_n/2,v_n/2).
\]

Their product is definitionally the shape of `GUE.coordinateMeasure n` once
the RMT-06 abbreviations for diagonal and upper variances are unfolded.
The resulting measure equality is the probability half of the bridge.

At the full three-sector level,
`GUE.map_realToHermitianCoordinates_gaussianProduct` checks the exact map to
`coordinateMeasure`. It applies `measurePreserving_sumPiEquivProdPi` first to
separate the diagonal from the upper sectors and again to separate upper-real
from upper-imaginary coordinates. No independence hypothesis needs to be
recovered afterward because the source and target are compared as complete
product measures.

{{< panel "info" >}}
**Why use product-measure equivalences?** Independence is already encoded by
the product measure. Transporting that exact product through measurable
equivalences preserves the complete joint law. Proving each normalized
marginal Gaussian and then asserting that the vector is the desired product
would leave an independence gap.
{{< /panel >}}

## From a common product to a scaled standard Gaussian

Let

\[
\sigma_n=\sqrt{v_n}.
\]

If \(g\sim\mathcal N(0,1)\), then

\[
\sigma_n g\sim\mathcal N(0,\sigma_n^2)
=\mathcal N(0,v_n).
\]

Thus the common-variance product \(\Pi_n\) is the coordinatewise
\(\sigma_n\)-scaling of a product of standard real Gaussians. Mathlib's
`map_pi_eq_stdGaussian` identifies the standard product, after the finite
\(\ell^2\) wrapper, with the canonical standard Gaussian on \(E_n\)
([Mathlib multivariate Gaussians](#ref-mathlib-multivariate)).

Consequently the Euclidean image of \(\Pi_n\) is

\[
(z\mapsto\sigma_n z)_*
\operatorname{stdGaussian}(E_n).
\]

`map_gaussianProduct_toLp_eq_map_smul_stdGaussian` proves this statement for
an arbitrary finite index type and arbitrary nonnegative variance. It first
maps the product coordinatewise with `Measure.pi_map_pi`, commutes scalar
multiplication with `WithLp.toLp 2`, and finishes with Mathlib's
`map_pi_eq_stdGaussian`.

Now apply the normalized Frobenius isometry
\(\Phi_n:E_n\simeq\operatorname{Herm}(n)\). Mathlib's `stdGaussian_map`
sends the unscaled standard Gaussian through a real linear isometric
equivalence without changing its canonical form. Real linearity also gives

\[
\Phi_n(\sigma_n z)=\sigma_n\Phi_n(z).
\]

The resulting intrinsic measure is therefore

\[
\Gamma_n
=(H\mapsto\sigma_n H)_*
\operatorname{stdGaussian}(\operatorname{Herm}(n)).
\]

The project names the coordinate-built intrinsic measure `GUE.intrinsicLaw`.
`GUE.instIsProbabilityMeasureIntrinsicLaw` records that it is a probability
measure, and `GUE.intrinsicLaw_eq_map_smul_stdGaussian` proves the displayed
scaled-Gaussian identity. The latter proof transports through
`RandomMatrix.normalizedHermitianLinearIsometryEquiv`; at the final
`stdGaussian_map` boundary it locally rebuilds that isometry under Mathlib's
canonical inner-product-derived real module instance. As in RMT-07, this is
typeclass alignment, not a second mathematical structure.

For positive \(n\), \(v_n=1/n\), so \(\sigma_n=1/\sqrt{n}\). This is the
Wigner-scaled intrinsic Gaussian anticipated in RMT-07. Writing the scale as
\(\sqrt{\operatorname{varianceScale}(n)}\), instead of dividing by
\(\sqrt{n}\), also makes the zero-dimensional branch total.

### Scale and shape are different responsibilities

The standard Gaussian provides the rotationally symmetric *shape*. The scalar
\(\sigma_n\) provides the ensemble's dimension-dependent *scale*. Unitary
congruence is a real linear isometry, so it preserves the first and commutes
with the second:

\[
\mathcal C_U(\sigma_n H)=\sigma_n\mathcal C_U(H).
\]

It follows that the scaled intrinsic law \(\Gamma_n\) is also invariant. The
proof is a pushforward calculation:

\[
\begin{aligned}
(\mathcal C_U)_*\Gamma_n
&=(\mathcal C_U)_*(S_{\sigma_n})_*\gamma_n\\
&=(S_{\sigma_n})_*(\mathcal C_U)_*\gamma_n\\
&=(S_{\sigma_n})_*\gamma_n\\
&=\Gamma_n,
\end{aligned}
\]

where \(S_{\sigma_n}(H)=\sigma_nH\) and RMT-07 supplies
\((\mathcal C_U)_*\gamma_n=\gamma_n\).

`GUE.map_intrinsicLaw_hermitianCongruence` is the checked version of this
calculation. It unfolds the scaled-Gaussian representation, commutes real
scalar multiplication through the real linear congruence equivalence, and
then invokes RMT-07's standard-Gaussian invariance theorem.

## Identify the coordinate-built matrix law

There are now two paths from a point in the common real product space to an
ambient matrix.

The coordinate path is

\[
I_n\text{-coordinates}
\longrightarrow
(d,u)
\longrightarrow
\operatorname{hermitianCoordinateMap}(d,u).
\]

The intrinsic path is

\[
I_n\text{-coordinates}
\longrightarrow E_n
\xrightarrow{\Phi_n}
\operatorname{Herm}(n)
\xrightarrow{\iota_n}
\operatorname{Matrix}_n(\mathbb C).
\]

`GUE.coordinateToHermitianEuclidean` is the old coordinate path with its
codomain restricted to intrinsic Hermitian space, and
`GUE.measurable_coordinateToHermitianEuclidean` proves it measurable.
`GUE.coordinateToHermitianEuclidean_realToHermitianCoordinates` checks that
this path after real decoding is the normalized Euclidean assembly. The
identity is reflexive: both definitions deliberately reuse the same direct
matrix constructor.

On a diagonal entry both paths return the real diagonal coordinate. Above the
diagonal both return \((r+\mathrm i s)/\sqrt{2}\). Below the diagonal both
return its conjugate.

Once the functions agree, the measure proof is formal but still explicit:

\[
\begin{aligned}
\operatorname{matrixLaw}(n)
&=(\operatorname{hermitianCoordinateMap})_*
  \operatorname{coordinateMeasure}(n)\\
&=(\iota_n\circ\Phi_n)_*\Pi_n\\
&=(\iota_n)_*(\Phi_n)_*\Pi_n\\
&=(\iota_n)_*\Gamma_n.
\end{aligned}
\]

Each equality has its own obligation:

- the RMT-06 definition expands `matrixLaw` as a map;
- the decoded-product theorem replaces `coordinateMeasure`;
- pointwise normalized assembly replaces one composite by the other;
- `Measure.map_map` reassociates measurable maps; and
- the scaled-Gaussian theorem identifies the intrinsic image.

This is the exact equality that RMT-07 refused to assume. Once checked, it
converts the phrase "the coordinate GUE is the scaled intrinsic Gaussian" from
motivation into a reusable theorem.

The reusable theorem is
`GUE.matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw`. It rewrites the ambient
law as the pushforward of `GUE.intrinsicLaw` through
`RandomMatrix.hermitianToMatrix`. This statement isolates all coordinate
normalization behind the intrinsic measure, leaving later ambient arguments a
single measurable inclusion to manage.

## The commuting square that transfers invariance

For a unitary \(U\), RMT-07 already proves the pointwise square

{{< mermaid >}}
flowchart LR
  H["intrinsic Hermitian H"] -->|"intrinsic congruence"| HU["intrinsic U H U*"]
  H -->|"hermitianToMatrix"| A["ambient matrix H"]
  HU -->|"hermitianToMatrix"| AU["ambient U H U*"]
  A -->|"RandomMatrix.congruence"| AU
{{< /mermaid >}}

In symbols,

\[
\iota_n\circ\mathcal C_U
=\widehat{\mathcal C}_U\circ\iota_n.
\]

The intrinsic scaled law is invariant, and the ambient GUE law is its
pushforward through \(\iota_n\). Therefore

\[
\begin{aligned}
(\widehat{\mathcal C}_U)_*\operatorname{matrixLaw}(n)
&=(\widehat{\mathcal C}_U)_*(\iota_n)_*\Gamma_n\\
&=(\iota_n)_*(\mathcal C_U)_*\Gamma_n\\
&=(\iota_n)_*\Gamma_n\\
&=\operatorname{matrixLaw}(n).
\end{aligned}
\]

The project's predicate expands to exactly this statement for every
`U : Matrix.unitaryGroup (Fin n) ℂ`:

```lean
RandomMatrix.IsUnitaryConjugationInvariant (GUE.matrixLaw n)
```

`GUE.matrixLaw_isUnitaryConjugationInvariant` checks this statement for every
natural dimension. It is the final theorem of the module.

## Physics view: a random Hamiltonian without a preferred basis

A finite quantum Hamiltonian is represented by a Hermitian matrix only after
an orthonormal basis is chosen. Replacing that basis by a unitary matrix \(U\)
changes the coordinate matrix from \(H\) to \(UHU^*\). This is a passive
change of description: the abstract operator has not changed.

The RMT-06 construction appeared to privilege one basis because it named
independent diagonal and strict-upper coordinates. The theorem proved here
says that preference disappears at the level of the assembled probability
law:

\[
H\sim\operatorname{GUE}_n
\quad\Longrightarrow\quad
UHU^*\sim\operatorname{GUE}_n.
\]

This does **not** say that an individual sample satisfies \(UHU^*=H\) for
every unitary \(U\). That much stronger pointwise statement would restrict
the matrix drastically. It says that the ensemble of possible Hamiltonians,
with its probabilities, looks identical after the same deterministic basis
change is applied to every sample.

The normalized real-coordinate bridge explains why. The independent
coordinates are not merely a convenient entry ledger; after the
\(\sqrt{2}\) correction they form an orthonormal coordinate system for the
real Hilbert space of Hermitian operators. Their common-variance Gaussian is
radial in that geometry. Unitary congruence is one of its orthogonal rotations,
so the probability measure cannot detect that rotation.

No unitary is sampled from Haar measure in this theorem, and \(UHU^*\) is not
being interpreted as Schrödinger time evolution. The result is a symmetry of
a finite probability law under deterministic basis changes. Spectral
statistics and quantum-chaos interpretations require additional theorems.
Guionnet states the classical coordinate normalization and unitary symmetry
in the surrounding random-matrix theory
([Guionnet, 2022](#ref-guionnet-2022)); the contribution here is a checked
derivation for this repository's exact measure definitions.

## Dimension zero is part of the theorem

Dimension zero is not a limit argument. It is a concrete finite case in which
all relevant index types are empty.

### Geometry

`Fin 0` is empty, and RMT-05 gives an `IsEmpty` instance for
`StrictUpperIndex 0`. Their nested sum is empty. A real function on that index
is unique, the Euclidean carrier has one point, and the intrinsic Hermitian
space contains only the empty zero matrix. The normalized analysis and
synthesis maps are the unique maps between singleton carriers, and their norm
identity is an empty-sum identity.

### Probability

Mathlib's finite product over an empty type is a Dirac measure at the unique
empty function. RMT-06 already proves that both `coordinateMeasure 0` and
`matrixLaw 0` are Dirac at zero. The scale satisfies

\[
v_0=0,
\qquad
\sigma_0=\sqrt{0}=0.
\]

Mapping any intrinsic standard Gaussian by zero scalar multiplication gives
the same Dirac mass. Because the underlying space is already a singleton,
there is no tension between this fact and the canonical standard-Gaussian
definition.

`GUE.intrinsicLaw_zero` records the resulting equality with
`Measure.dirac (0 : RandomMatrix.HermitianEuclidean 0)`. Its proof is a direct
rewrite by the scaled-standard-Gaussian representation and
`GUE.varianceScale_zero`; empty-product details have already been absorbed by
the general law theorem.

### Symmetry

Every unitary congruence fixes the zero matrix, so the final invariance equation
holds. More importantly, the general proof architecture already reduces
to that fact. There is no need to introduce the undefined expression
\(1/\sqrt{0}\), prove a positive-dimension theorem, and bolt on a disconnected
special theorem later.

{{< panel "warning" >}}
**Two different square roots.** The fixed \(\sqrt{2}\) belongs to the
orthonormalization of each off-diagonal complex coordinate and is always
nonzero. The dimension-dependent
\(\sqrt{\operatorname{varianceScale}(n)}\) scales the Gaussian law and becomes
zero at \(n=0\). Conflating them leads either to a false isometry or an
unnecessary positive-dimension hypothesis.
{{< /panel >}}

## The complete declaration map

The following table maps all thirty-five public declarations in the checked
module. Private helper lemmas, imports, namespace openings, and locally rebuilt
isometries are not counted.

| Public declaration | Checked content | Main proof mechanism |
|---|---|---|
| `HermitianRealIndex` | Diagonal plus real-upper plus imaginary-upper semantic index | Nested sum abbreviation |
| `hermitianRealIndexToPair` | Send diagonal to itself, real-upper to the upper entry, and imaginary-upper to the reflected lower entry | Sum elimination |
| `pairToHermitianRealIndex` | Classify every matrix pair as diagonal, strict upper, or reflected strict upper | Decidable order cases |
| `pairToHermitianRealIndex_toPair` | Classifying the pair represented by an index recovers that index | Sum cases and strict-order simplification |
| `hermitianRealIndexToPair_pairTo` | Representing the classification of a matrix pair recovers the pair | `lt_trichotomy` |
| `hermitianRealIndexEquivMatrixIndex` | The semantic real index is equivalent to all matrix-entry pairs | The two inverse theorems |
| `RandomMatrix.realToHermitianCoordinates` | Decode normalized real sectors into the old diagonal/complex-upper carrier | Divide upper real and imaginary sectors by `Real.sqrt 2` |
| `RandomMatrix.measurable_realToHermitianCoordinates` | The normalized decoder is measurable | Coordinatewise product and division measurability |
| `RandomMatrix.normalizedHermitianAssembly` | Assemble normalized Euclidean coordinates into intrinsic Hermitian space | Old coordinate assembly plus its pointwise Hermiticity proof |
| `RandomMatrix.normalizedHermitianAnalysis` | Read diagonal, `√2 * re`, and `√2 * im` coordinates from an intrinsic Hermitian matrix | `WithLp.toLp 2` and sum-index matching |
| `RandomMatrix.hermitianToMatrix_normalizedHermitianAssembly` | Forgetting the intrinsic subtype exposes the old coordinate matrix | Reflexivity |
| `RandomMatrix.normalizedHermitianAssembly_apply_diag` | Assembly places each diagonal sector value on the diagonal | Old diagonal assembly theorem |
| `RandomMatrix.normalizedHermitianAssembly_apply_upper` | Assembly divides upper real and imaginary sectors by `√2` | Old strict-upper assembly theorem |
| `RandomMatrix.normalizedHermitianAssembly_apply_lower` | Assembly reflects the normalized upper value by conjugation | Old lower assembly theorem |
| `RandomMatrix.normalizedHermitianAnalysis_assembly` | Analysis after assembly is the identity | Three sum-index cases and `sqrt 2 ≠ 0` |
| `RandomMatrix.normalizedHermitianAssembly_analysis` | Assembly after analysis is the identity | Matrix-entry trichotomy and Hermitian diagonal/lower identities |
| `RandomMatrix.normalizedHermitianLinearEquiv` | Normalized coordinates and intrinsic Hermitian matrices are real-linearly equivalent | Inverses plus entrywise additive and scalar proofs |
| `RandomMatrix.normalizedHermitianAssembly_inner` | Assembly preserves the real inner product exactly | Reindex matrix pairs, split sum types, and cancel the factor two |
| `RandomMatrix.normalizedHermitianLinearIsometryEquiv` | Normalized assembly is a real linear isometry onto intrinsic Hermitian space | `LinearIsometryEquiv.ofBounds` and the inner-product theorem |
| `map_gaussianProduct_toLp_eq_map_smul_stdGaussian` | A common-variance real product becomes a scalar image of Euclidean `stdGaussian` | Coordinate scaling, `Measure.pi_map_pi`, and `map_pi_eq_stdGaussian` |
| `gaussianReal_map_div_sqrt_two` | Dividing a centered real Gaussian by `√2` divides variance by two | `gaussianReal_map_div_const` and `Real.sq_sqrt` |
| `realUpperToComplex` | Pair two upper real families into a complex family after `1/√2` scaling | `Complex.equivRealProdCLM.symm` |
| `measurable_realUpperToComplex` | The paired upper-family decoder is measurable | Coordinatewise continuous-linear evaluation |
| `map_realUpperToComplex_gaussianProduct` | Two common-variance real products map to the exact Cartesian complex product law | Function/product equivalence, product mapping, and the scalar law |
| `GUE.coordinateToHermitianEuclidean` | Send the old GUE coordinate carrier into intrinsic Hermitian space | Matrix flattening and assembly Hermiticity |
| `GUE.measurable_coordinateToHermitianEuclidean` | The old coordinate-to-intrinsic map is measurable | Subtype construction, `WithLp` measurability, and entrywise assembly |
| `GUE.coordinateToHermitianEuclidean_realToHermitianCoordinates` | Old intrinsic assembly after decoding equals normalized Euclidean assembly | Reflexivity |
| `GUE.map_realToHermitianCoordinates_gaussianProduct` | One common-variance real product decodes exactly to `coordinateMeasure` | Two sum-product splits and upper-family transport |
| `GUE.intrinsicLaw` | Define GUE directly as a measure on intrinsic Hermitian space | Push forward `coordinateMeasure` through intrinsic assembly |
| `GUE.instIsProbabilityMeasureIntrinsicLaw` | The intrinsic law is a probability measure in every dimension | Probability preservation under measurable mapping |
| `GUE.intrinsicLaw_eq_map_smul_stdGaussian` | Intrinsic GUE is `sqrt (varianceScale n)` times canonical `stdGaussian` | Product-law bridge, normalized isometry, and `stdGaussian_map` |
| `GUE.intrinsicLaw_zero` | At dimension zero the intrinsic law is Dirac at the unique zero Hermitian matrix | Scaled-Gaussian formula and zero variance scale |
| `GUE.matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw` | Ambient `matrixLaw` is the intrinsic law pushed through inclusion | RMT-06 map definition and `Measure.map_map` |
| `GUE.map_intrinsicLaw_hermitianCongruence` | Every unitary congruence preserves the scaled intrinsic law | Scalar/congruence commutation and RMT-07 `stdGaussian` invariance |
| `GUE.matrixLaw_isUnitaryConjugationInvariant` | Every unitary congruence preserves the ambient finite GUE law | Ambient/intrinsic commuting square and pushforward composition |

### Checked proof order

The source follows the dependency order from geometry to probability to
symmetry:

1. define the semantic real index and Euclidean carrier;
2. define normalized decoding, synthesis, and analysis;
3. prove their pointwise formulas and inverse laws;
4. package the real linear isometry;
5. decode the common-variance product into `coordinateMeasure`;
6. identify the Euclidean common product with scaled `stdGaussian`;
7. identify `coordinateMeasure` with the scaled intrinsic law;
8. identify `matrixLaw` with the ambient image of that intrinsic law;
9. prove the scaled intrinsic law invariant; and
10. transport the equality through the commuting square to the ambient
    unitary-invariance predicate.

Reversing that order would create large goals containing nested maps,
product equivalences, subtype coercions, and congruence simultaneously. Named
intermediate measure equalities keep each seam auditable.

## Lean implementation seams encountered

### Function equality versus bundled equality

The normalized maps may appear through a `LinearEquiv`, a
`LinearIsometryEquiv`, a measurable equivalence, or a raw function. These
bundles can be pointwise identical without being definitionally the same term.
Short `change`, `funext`, or extensionality steps should expose the underlying
function before applying `Measure.map_congr` or `Measure.map_map`.

### Scalar actions on the Hermitian subtype

RMT-07 already encountered two compatible real module instances on the
intrinsic Hermitian subtype. The scaled-Gaussian proof encounters the same API
boundary and locally rebuilds the coordinate-to-Hermitian real linear isometry
under `InnerProductSpace.toNormedSpace.toModule`. That local instance alignment
is an elaboration maneuver, not an extra mathematical assumption or a new
scalar multiplication.

### Product measures need sigma-finiteness instances

The finite Gaussian factors are probability measures, hence sigma-finite.
Mathlib's measure-preserving product equivalences discover those facts through
typeclass inference. If inference stalls, exposing the individual real
Gaussian factors is more faithful than adding an unrelated global instance.

### Equality of maps needs ordinary measurability

The project distinguishes `Measurable` from `AEMeasurable`. Reassociating
pushforwards with `Measure.map_map` should use the bundled continuous linear or
isometric maps, whose ordinary measurability is available. Exact coordinate
laws alone would provide only almost-everywhere measurability and are not a
substitute.

### Normalize algebra before measure algebra

The identity

\[
v_n/(\sqrt{2})^2=v_n/2
\]

mixes reals, nonnegative reals, square roots, division, and coercions. It is
best isolated as a scalar lemma. Leaving that arithmetic inside a product-
measure rewrite makes an otherwise structural proof brittle.

## What this milestone does not prove

Even with the unitary-invariance theorem checked, the scope remains
finite and precise.

- No Lebesgue density or normalizing constant is derived.
- No Jacobian or change-of-variables formula for matrix entries is proved.
- No eigenvalue map, spectral theorem, or eigenvalue joint density is added.
- No Vandermonde determinant or eigenvalue-repulsion theorem appears.
- No trace moment, resolvent, empirical spectral measure, or Stieltjes
  transform is evaluated.
- No semicircle law, edge law, spacing statistic, or universality limit is
  proved.
- No claim identifies all unitarily invariant Hermitian laws with GUE.
- No infinite-dimensional Gaussian measure or random operator is constructed.
- No physical claim about a particular quantum Hamiltonian follows solely
  from ensemble symmetry.

What the milestone establishes is still fundamental: this exact finite
matrix probability measure, constructed from explicitly normalized
independent coordinates, is unchanged by every finite unitary basis change.

## Run the checked source

From the repository root on macOS or Linux, load elan and run the stable module
through the pinned Lake environment:

```sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleInvariance.lean
```

The direct command checks the complete RMT-08 module with warnings promoted to
errors. Run `make check` from the repository root to rebuild the full Lean
library, validate checkpoint and proof-to-prose coverage, and render every Hugo
draft with warnings fatal.

This complete Lean snippet inspects the main bridge and symmetry interfaces:

```lean
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleInvariance

open Matrix MeasureTheory ProbabilityTheory
open scoped Matrix NNReal ENNReal RealInnerProductSpace

open NonlinearDynamics.Random

#check HermitianRealIndex
#check hermitianRealIndexEquivMatrixIndex
#check RandomMatrix.normalizedHermitianLinearIsometryEquiv
#check map_realUpperToComplex_gaussianProduct
#check GUE.map_realToHermitianCoordinates_gaussianProduct
#check GUE.intrinsicLaw
#check GUE.instIsProbabilityMeasureIntrinsicLaw
#check GUE.intrinsicLaw_eq_map_smul_stdGaussian
#check GUE.intrinsicLaw_zero
#check GUE.matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw
#check GUE.map_intrinsicLaw_hermitianCongruence
#check GUE.matrixLaw_isUnitaryConjugationInvariant
```

Save it inside `formalization` and run `lake env lean` on that file. All names
are checked public declarations; the snippet contains no omitted terms or
noncompiling ellipses.

## Failure modes the bridge is designed to block

| Tempting shortcut | What goes wrong | Intended repair |
|---|---|---|
| Treat displayed upper real and imaginary parts as orthonormal | Each complex entry occurs twice in the Hermitian matrix norm | Multiply both by \(\sqrt{2}\) |
| Compare only coordinate variances | Marginals do not determine an arbitrary joint law | Transport the exact finite product measure |
| Flatten the complex upper family without tracking real/imaginary pairing | The product nesting no longer matches the Cartesian complex law | Use the pointwise function/product measurable equivalence |
| Replace product-measure transport with a density calculation | A new Lebesgue/Jacobian layer is introduced unnecessarily | Use measurable equivalences and `Measure.map` identities |
| Call the common real product `stdGaussian` definitionally | Mathlib's canonical measure lives on `EuclideanSpace`, not the raw function type | Map through `WithLp.toLp 2` and use `map_pi_eq_stdGaussian` |
| Forget the dimension scale | The result has variance one rather than variance \(1/n\) | Map intrinsic `stdGaussian` by \(\sqrt{v_n}\) |
| Divide by \(\sqrt{n}\) in the definition | Dimension zero becomes partial | Use \(\sqrt{\operatorname{varianceScale}(n)}\) |
| Transfer intrinsic invariance before identifying measures | The theorem applies to a different measure | First prove exact coordinate/intrinsic/ambient measure equalities |
| Ignore the inclusion/congruence square | Intrinsic and ambient maps have different types | Rewrite with the pointwise commuting theorem |
| Prove only the \(n\gt0\) theorem | The repository's matrix law is total on all natural dimensions | Let empty indices and zero scaling handle \(n=0\) |
| Read unitary invariance as a spectral theorem | Symmetry alone does not compute eigenvalue statistics | State spectral and asymptotic results as later milestones |

## Exercises with solutions

### Exercise 1: count the real coordinates

Why does the index
\(D_n\sqcup(T_n\sqcup T_n)\) have \(n^2\) elements?

**Solution.** There are \(n\) diagonal indices and
\(|T_n|=n(n-1)/2\) strict-upper indices. The two copies of \(T_n\) store real
and imaginary parts. Hence
\(n+2[n(n-1)/2]=n+n(n-1)=n^2\).

### Exercise 2: find the isometric normalization

Suppose one strict-upper entry is \(u=x+\mathrm i y\). Which real coordinates
make its Frobenius contribution a sum of coordinate squares?

**Solution.** The upper and lower entries contribute
\(|u|^2+|\overline u|^2=2x^2+2y^2\). The normalized real coordinates are
\(\sqrt{2}x\) and \(\sqrt{2}y\), whose squares sum to the same quantity.

### Exercise 3: check the variance conversion

If \(X\sim\mathcal N(0,v)\), what is the variance of
\(X/\sqrt{2}\)?

**Solution.** Scaling a real random variable by \(c\) multiplies variance by
\(c^2\). Here \(c=1/\sqrt{2}\), so the new variance is
\(v(1/\sqrt{2})^2=v/2\). This is why a common normalized variance \(v_n\)
decodes to the RMT-06 upper Cartesian variance \(v_n/2\).

### Exercise 4: explain the product regrouping

Why is
\((T_n\to\mathbb R)\times(T_n\to\mathbb R)\) the right intermediate type for
building a complex upper family?

**Solution.** The first function stores every real part and the second stores
every imaginary part. The canonical function/product equivalence regroups
them pointwise into \(T_n\to(\mathbb R\times\mathbb R)\). At each index, the
real-pair/complex equivalence then produces one complex number. Its
measure-preserving theorem ensures this regrouping transports the whole
product law, not just individual coordinates.

### Exercise 5: scale the intrinsic Gaussian

For \(n\gt0\), why is the intrinsic scale \(1/\sqrt{n}\)?

**Solution.** RMT-06 sets \(v_n=1/n\). A standard Gaussian coordinate has
variance one, and multiplication by \(\sigma\) produces variance
\(\sigma^2\). Choosing \(\sigma_n=\sqrt{v_n}=1/\sqrt{n}\) makes every normalized
real coordinate have variance \(1/n\).

### Exercise 6: prove scaled invariance on paper

Let \(T\) be a linear isometry with \(T_*\gamma=\gamma\). Prove that
\(T_* (S_\sigma)_*\gamma=(S_\sigma)_*\gamma\).

**Solution.** Linearity gives \(T\circ S_\sigma=S_\sigma\circ T\). Therefore
\[
T_*(S_\sigma)_*\gamma
=(T\circ S_\sigma)_*\gamma
=(S_\sigma\circ T)_*\gamma
=(S_\sigma)_*T_*\gamma
=(S_\sigma)_*\gamma.
\]

### Exercise 7: transfer through inclusion

Assume \(\iota\circ T=\widehat T\circ\iota\),
\(T_*\Gamma=\Gamma\), and \(\mu=\iota_*\Gamma\). Show that
\(\widehat T_*\mu=\mu\).

**Solution.** Reassociate pushforwards and use the commuting square:
\[
\widehat T_*\mu
=\widehat T_*\iota_*\Gamma
=(\widehat T\circ\iota)_*\Gamma
=(\iota\circ T)_*\Gamma
=\iota_*T_*\Gamma
=\iota_*\Gamma
=\mu.
\]

### Exercise 8: audit dimension zero

Why does the proof not need division by zero when \(n=0\)?

**Solution.** The only coordinate decoder division is by the fixed nonzero
number \(\sqrt{2}\). The dimension-dependent factor is represented as
\(\sqrt{v_0}=0\) and used by scalar multiplication, not division. Since the
real index is empty, the Euclidean and Hermitian spaces are singletons, and
zero scaling gives the correct Dirac law automatically.

## The next ridge

With this bridge checked, the finite GUE law finally justifies the adjective
*unitary* at the measure level. That is a structural summit, not the end of
random-matrix theory.

[The First Exact GUE Trace Moments in Lean: Centering, Energy, and Wigner
Scale]({{< relref "/development-notebook/2026/07/gue-first-exact-trace-moments" >}})
now proves the first two integrable trace moments from this bridge. The next
mathematically honest ridge is a measurable finite-spectrum interface and an
empirical spectral measure. Those layers should consume the invariant law
proved here rather than reconstructing coordinate symmetry from scratch.
Asymptotic statements such as the semicircle law require an additional limit
architecture and must remain separate from this exact finite-dimensional
theorem.

## References

The external links below were opened and checked on 2026-07-21. The pinned
local Mathlib 4.32.0 source remains the API authority for the eventual Lean
proof.

<a id="ref-guionnet-2022"></a>
**Alice Guionnet.**
["Rare Events in Random Matrix Theory"](https://ems.press/content/book-chapter-files/33150),
*Proceedings of the International Congress of Mathematicians 2022*, volume 2,
pages 1008–1052. [DOI 10.4171/ICM2022/174](https://doi.org/10.4171/ICM2022/174).
Section 1.1.1 records the classical finite GUE coordinate normalization,
matrix density convention, and unitary-conjugation invariance. This chapter
uses it for mathematical context and does not import its density or
eigenvalue conclusions into the formal claim.

<a id="ref-mathlib-release"></a>
**Mathlib contributors.**
[Mathlib 4.32.0 release](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
2026. This is the exact dependency release selected by
`formalization/lakefile.toml`.

<a id="ref-mathlib-multivariate"></a>
**Mathlib contributors.**
[Multivariate Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Multivariate.html),
Mathlib 4 documentation. This page defines `stdGaussian`, proves
`map_pi_eq_stdGaussian`, proves basis independence, and proves invariance
under real linear isometric equivalences via `stdGaussian_map`.

<a id="ref-mathlib-real-gaussian"></a>
**Mathlib contributors.**
[Real Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
Mathlib 4 documentation. This is the official interface for exact real
Gaussian scaling, including `gaussianReal_map_div_const`.

<a id="ref-mathlib-pi"></a>
**Mathlib contributors.**
[Measures on finite function spaces](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Constructions/Pi.html),
Mathlib 4 documentation. This module supplies `Measure.pi_map_pi` and the
measure-preserving sum/function-product equivalences used to rearrange finite
Gaussian blocks without a density argument.

<a id="ref-mathlib-euclidean"></a>
**Mathlib contributors.**
[Euclidean spaces and inner products](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/InnerProductSpace/PiL2.html),
Mathlib 4 documentation. This page supplies the finite \(\ell^2\) carrier and
real Euclidean geometry used by the normalized coordinate isometry.
