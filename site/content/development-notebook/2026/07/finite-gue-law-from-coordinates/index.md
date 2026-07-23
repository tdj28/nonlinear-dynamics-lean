---
title: "A Finite GUE Law in Lean: From Gaussian Coordinates to a Matrix Measure"
slug: "finite-gue-law-from-coordinates"
date: 2026-07-21
weight: 1
author: "tdj28"
summary: "A guided construction of the finite-dimensional Gaussian unitary ensemble from an explicit Wigner normalization ledger, independent Gaussian coordinate blocks, a measurable Hermitian assembly map, exact entry laws, and a total zero-dimensional Dirac boundary."
lead: |
  A random Hermitian matrix becomes a precise probability object only after every scale and independence choice is visible. This chapter builds the finite Gaussian unitary ensemble in two checked moves: put an exact product Gaussian law on the free Hermitian coordinates, then push that law through the measurable assembly map. The result is a probability measure on ambient complex matrices with exact diagonal and strict-upper entry laws, including a deliberate dimension-zero branch.
key_result: |
  Lean now defines a finite Wigner-scaled GUE matrix law in every natural dimension. For positive dimension, diagonal coordinates have variance 1/n and each real and imaginary part above the diagonal has variance 1/(2n); the two coordinate blocks and their finite families carry explicit independence theorems. The assembled matrix law is a measurable pushforward and its diagonal and strict-upper marginals are checked exactly. Density, Hermitian support as a measure theorem, unitary invariance, spectra, expectations, and asymptotics remain future work.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Finite probability measures, exact Gaussian laws, and random-matrix normalization"
reading_time: "75 to 95 minutes"
prerequisites:
  - "Hermitian matrices from a real diagonal and complex strict upper triangle"
  - "Product measures, pushforward laws, and finite mutual independence"
  - "No prior Lean proof experience required"
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsemble"
lean_source: "formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsemble.lean"
tags:
  - "Lean 4"
  - "Gaussian unitary ensemble"
  - "Random matrices"
  - "Product measures"
  - "Independence"
  - "Wigner scaling"
  - "Pushforward laws"
og_image: "finite-gue-law-from-coordinates-card.png"
og_image_alt: "Warm-paper teaching card showing a diagonal Gaussian block with variance one over n and a strict-upper complex Gaussian block whose real and imaginary variances are each one divided by twice the dimension, joined into a product coordinate law and pushed through Hermitian assembly to a matrix probability law."
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
**Abstract.** `GaussianUnitaryEnsemble.lean` makes the project's first
dimension-dependent random-matrix normalization choice. It defines an
explicit nonnegative variance scale, places centered Gaussian product laws on
the real diagonal and complex strict upper triangle, proves their block and
coordinate independence, and sends their product measure through the checked
Hermitian coordinate map.

The resulting `GUE.matrixLaw n` is a probability measure on ambient complex
matrices. The file proves the full line-supported Cartesian complex law of
each diagonal entry, the equal-variance Cartesian law of each strict-upper entry,
and Dirac formulas for both the coordinate and matrix laws at dimension zero.

**Takeaway.** The module constructs exact finite laws. The familiar density
proportional to \(\exp(-n\operatorname{Tr}(H^2)/2)\), the order-one
semicircle scale, Hermitian support at the measure level, and unitary
invariance are explanatory context, not theorems in this file.
{{< /panel >}}

This is the proof-to-prose companion to
`formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsemble.lean`.
Every named public declaration in that module appears below, with its exact
role and proof architecture.

The immediate prerequisite is
[Hermitian Coordinate Assembly]({{< relref "/development-notebook/2026/07/hermitian-coordinate-assembly" >}}),
which built the deterministic measurable map without choosing a law. The
probability ingredients were developed in
[Gaussian Primitives]({{< relref "/development-notebook/2026/07/gaussian-primitives-exact-laws-and-independence" >}}),
[Complex Gaussians]({{< relref "/development-notebook/2026/07/complex-gaussians-from-independent-real-coordinates" >}}),
and
[Independent Complex Gaussian Families]({{< relref "/development-notebook/2026/07/independent-complex-gaussian-families" >}}).

For a stable textbook treatment, see
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}}).
Reusable definitions live under
{{< refterm "gaussian-unitary-ensemble" >}},
{{< refterm "normalization-convention" "normalization convention" >}},
{{< refterm "gaussian-distribution" >}},
{{< refterm "cartesian-complex-gaussian-law" "Cartesian complex Gaussian law" >}},
{{< refterm "independence" >}},
{{< refterm "probability-law" >}},
{{< refterm "pushforward-measure" "pushforward measure" >}}, and
{{< refterm "hermitian-coordinate-space" >}}.

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| First encounter | [Why scale entries with dimension?](#why-scale-entries-with-dimension) | Understand why this convention targets an order-one spectral scale |
| Normalization route | [The ledger](#the-normalization-ledger) | Audit every variance, trace, density, and boundary convention |
| Probability route | [The coordinate product](#camp-two-one-coordinate-probability-space) | See how two finite product measures encode the free entries |
| Independence route | [Blocks to scalars](#high-camp-from-block-independence-to-coordinate-independence) | Separate block, mutual-family, and cross-coordinate independence |
| Lean route | [The declaration map](#the-complete-declaration-map) | Locate all twenty-six public declarations and their proof engines |
| Matrix-law route | [Pushforward](#summit-camp-push-the-coordinate-law-to-matrices) | Transfer exact coordinate laws through measurable Hermitian assembly |
| Edge-case route | [Dimension zero](#the-zero-dimensional-law-is-deliberate) | Follow both empty product laws to Dirac masses |

### Learning objectives

By the summit, a reader should be able to:

1. state the positive-dimensional GUE variance convention used here;
2. derive why two off-diagonal Cartesian variances of \(1/(2n)\) give
   \(\mathbb{E}|H_{ij}|^2=1/n\) as contextual mathematics;
3. recover the contextual density exponent from the coordinate Gaussian
   factors and \(\operatorname{Tr}(H^2)\);
4. explain why `varianceScale` pattern matches on zero instead of hiding a
   division-by-zero convention;
5. read `coordinateMeasure` as a product of a diagonal vector law and a
   strict-upper vector law;
6. distinguish exact marginal laws, independence of two blocks, mutual
   independence within a block, and cross-block coordinate independence;
7. explain why `matrixLaw` is a pushforward rather than a new sampling
   algorithm;
8. follow the transport of exact diagonal and upper-entry laws from the
   coordinate space to the matrix space;
9. understand why a diagonal entry is represented as a complex Gaussian with
   imaginary variance zero;
10. reduce the zero-dimensional coordinate product and matrix pushforward to
    Dirac laws; and
11. name the density, support, invariance, spectral, moment, and asymptotic
    claims that are still absent.

## The construction in one picture

{{< mermaid >}}
flowchart LR
  S["Explicit variance ledger"] --> D["Real diagonal Gaussian product"]
  S --> U["Complex strict-upper Gaussian product"]
  D --> C["Coordinate product measure"]
  U --> C
  C --> B["Block and coordinate independence"]
  C --> P["Measurable Hermitian assembly pushforward"]
  P --> M["GUE matrix law"]
  M --> E["Exact diagonal and upper-entry laws"]
  Z["Dimension zero"] --> C
  Z --> M
  M -. later .-> I["Support, density, and unitary invariance"]
  I -. later .-> Q["Spectra, moments, and asymptotics"]
{{< /mermaid >}}

<p class="figure-note"><strong>Figure.</strong> The solid arrows are checked
in this module. The diagonal and strict-upper product laws form one canonical
coordinate probability space; measurable Hermitian assembly pushes it to an
ambient matrix law, and exact entry marginals are transferred through that
map. The dotted arrows are dependency-ordered future work, not consequences
of the ensemble's name.</p>

## Why scale entries with dimension?

Imagine an \(n\)-component vector \(v\) whose Euclidean norm is one. A dense
matrix-vector product has entries of the form

\[
(Hv)_i=\sum_{j=0}^{n-1} H_{ij}v_j.
\]

If the matrix entries had variance independent of \(n\), the sum would
typically grow with dimension. Wigner scaling compensates by making a typical
entry size of order \(n^{-1/2}\), hence variance of order \(1/n\). With that
choice, each row combines many small contributions into an order-one effect.
This is the scale at which a nontrivial order-one spectral picture can emerge.

The Hermitian constraint changes how the variance is recorded. A diagonal
entry is real, so one real coordinate receives variance \(1/n\). A strict-upper
entry is complex:

\[
H_{ij}=X_{ij}+iY_{ij}, \qquad i\lt j.
\]

The chosen Cartesian convention gives each displayed coordinate half the
total:

\[
\operatorname{Var}(X_{ij})=\operatorname{Var}(Y_{ij})=\frac{1}{2n}.
\]

When the two centered coordinates are independent, the contextual moment
calculation is

\[
\mathbb{E}|H_{ij}|^2
=\mathbb{E}(X_{ij}^2+Y_{ij}^2)
=\frac{1}{2n}+\frac{1}{2n}
=\frac1n.
\]

The current Lean file records the two exact one-dimensional variances and the
independence structure. It does not introduce a named theorem for
\(\mathbb{E}|H_{ij}|^2\), because expectation and integrability of matrix
observables belong to a later slice.

### The physics intuition, with the claim boundary visible

Random Hermitian matrices entered physics as effective models for complicated
quantum Hamiltonians whose individual microscopic couplings are inaccessible
but whose statistical spectral behavior can still be studied. Hermiticity is
the structural requirement that makes a finite Hamiltonian generate unitary
time evolution. Gaussian coordinates then give a tractable quadratic model
once the scale is fixed.

The letter *U* in GUE points toward invariance under deterministic unitary
changes of basis. That symmetry is profound: a physical prediction should not
depend on an arbitrary orthonormal coordinate system. Yet the entrywise
construction alone does not certify that symmetry in Lean. The current module
constructs the law from independent entries in one basis. A later module must
prove that conjugation \(H\mapsto UHU^*\) preserves the resulting measure.

This separation is useful, not cosmetic. Entry independence is basis
dependent, while unitary invariance is a statement about the whole measure.
Conflating them would replace a theorem with a name.

## The normalization ledger

Normalization disagreements are common enough in random-matrix theory that
the convention should be treated like an interface, not an implicit custom.
Here is the full ledger for this module.

| Feature | Dimension \(n=0\) | Dimension \(n\gt0\) | Checked in this file? |
|---|---:|---:|---|
| Base scale | \(0\) | \(1/n\) | Yes, by named zero and successor theorems |
| Diagonal mean | empty block | \(0\) | Yes, exact Gaussian law |
| Diagonal real variance | empty block | \(1/n\) | Yes |
| Diagonal imaginary variance | empty block | \(0\) | Yes, in the full complex diagonal law |
| Strict-upper complex mean | empty block | \(0\) | Yes |
| Strict-upper real variance | empty block | \(1/(2n)\) | Yes |
| Strict-upper imaginary variance | empty block | \(1/(2n)\) | Yes |
| Matrix trace convention | unique empty trace | unnormalized \(\operatorname{Tr}\) | Context only |
| Matrix-coordinate density | not applicable (Dirac law) | proportional to \(\exp(-n\operatorname{Tr}(H^2)/2)\) | Context only |
| Spectral scale | empty spectrum | order one, conventionally associated with support \([-2,2]\) asymptotically | Context only |
| Coordinate law | Dirac at the unique empty pair | finite Gaussian product law | Yes |
| Matrix law | Dirac at the unique empty matrix | measurable pushforward | Yes |

The positive-dimensional convention agrees with the GUE normalization
presented by Guionnet: real and imaginary parts above the diagonal have
variance \(1/(2n)\), diagonal entries have variance \(1/n\), and the general
Gaussian-ensemble density exponent \(-\beta n\operatorname{Tr}(H^2)/4\)
becomes \(-n\operatorname{Tr}(H^2)/2\) at \(\beta=2\)
([Guionnet, 2022](#ref-guionnet-2022)). Tao and Vu use the corresponding
\(1/\sqrt n\) Wigner scale and describe the spectrum on \([-2,2]\)
([Tao and Vu, 2013](#ref-tao-vu-2013)).

### Why the density exponent matches the coordinate variances

This calculation explains the convention but is not a theorem in the module.
For \(n\gt0\), a centered real Gaussian of variance \(1/n\) contributes an
exponential factor

\[
\exp\left(-\frac n2 d_i^2\right).
\]

Each upper real coordinate has variance \(1/(2n)\), so the pair
\(z_{ij}=x_{ij}+iy_{ij}\) contributes

\[
\exp(-n x_{ij}^2)\exp(-n y_{ij}^2)
=\exp(-n|z_{ij}|^2).
\]

For a Hermitian matrix assembled from these coordinates,

\[
\operatorname{Tr}(H^2)
=\sum_i d_i^2+2\sum_{i\lt j}|z_{ij}|^2.
\]

Multiplying all coordinate factors therefore yields an exponent

\[
-\frac n2\sum_i d_i^2-n\sum_{i\lt j}|z_{ij}|^2
=-\frac n2\operatorname{Tr}(H^2).
\]

Turning that calculation into a checked density identity requires a real
Lebesgue measure on Hermitian coordinate space, a Jacobian or real-linear
equivalence for assembly, and a product-density theorem at the matrix level.
None is smuggled into `matrixLaw` here.

## Lineage, local contribution, and nonclaims

The GUE and its Wigner scaling are classical. The local contribution is a
machine-checked finite law built entirely from previously verified project
interfaces and the [pinned Mathlib 4.32.0 release](#ref-mathlib-release).
Mathlib supplies the
real Gaussian measure, binary product measures, exact-law transport, and
independence predicates
([real Gaussian API](#ref-mathlib-gaussian),
[product measures](#ref-mathlib-prod),
[laws of random variables](#ref-mathlib-haslaw),
[independence](#ref-mathlib-independence)).

This module contributes:

- a total dimension-indexed Wigner variance scale with explicit zero and
  successor equations;
- a canonical product measure on the free Hermitian coordinates;
- exact laws for both coordinate blocks and every scalar coordinate;
- block independence, finite mutual independence within each block, and
  diagonal-to-upper cross independence;
- a probability-preserving pushforward through measurable Hermitian assembly;
- exact full complex laws for diagonal and strict-upper matrix entries; and
- coordinate and matrix Dirac theorems at dimension zero.

### Not claimed

- No matrix-space density or normalization constant is proved.
- No theorem says the matrix law is supported on Hermitian matrices, although
  every output of the assembly map is pointwise Hermitian.
- No unitary-conjugation invariance is proved.
- No eigenvalue, empirical spectral measure, semicircle law, edge law, level
  statistic, or universality statement is formalized.
- No matrix expectation, covariance operator, trace moment, or integrability
  theorem appears.
- No equivalence with an isotropic Gaussian measure on the real vector space
  of Hermitian matrices is established.
- The name GUE is attached to the exact coordinate convention and its
  pushforward, not used as evidence for later properties.

## Camp one: make the scale executable

### `GUE.varianceScale`

```lean
noncomputable def varianceScale : ℕ → ℝ≥0
  | 0 => 0
  | n + 1 => (((n + 1 : ℕ) : ℝ≥0))⁻¹
```

The codomain is `ℝ≥0`, Mathlib's nonnegative reals. This is the same parameter
type used by `gaussianReal`, whose second argument is variance rather than
standard deviation. The definition does not write `n⁻¹` for all naturals and
then let an algebraic convention decide the zero case. Pattern matching makes
the scientific policy explicit: dimension zero receives scale zero.

The definition is `noncomputable` because inversion and the inherited real
number structure are used as mathematical objects, not because the theorem
contains randomness or an unimplemented algorithm.

### `GUE.diagonalVariance`

`diagonalVariance n` names `varianceScale n`. The separate name may look
redundant, but it prevents later theorem signatures from losing the semantic
role of the number. A proof about a diagonal entry should say diagonal
variance, even when its current formula equals the shared scale.

### `GUE.upperCartesianVariance`

`upperCartesianVariance n` is `varianceScale n / 2`. It is the variance of
*each displayed real coordinate* of a complex strict-upper entry. It is not the
second moment of the complex number as a whole. Keeping the word `Cartesian`
in the name blocks that common factor-of-two error.

### The six boundary formulas

The next six declarations expose both branches in simplifier-friendly form:

- `GUE.varianceScale_zero` proves `varianceScale 0 = 0` by reflexivity;
- `GUE.varianceScale_succ` exposes the reciprocal formula at `n + 1`;
- `GUE.diagonalVariance_zero` proves the diagonal zero branch;
- `GUE.diagonalVariance_succ` reuses the base successor theorem;
- `GUE.upperCartesianVariance_zero` simplifies zero divided by two; and
- `GUE.upperCartesianVariance_succ` proves the exact reciprocal
  \((2(n+1))^{-1}\).

The last proof is the only one with real algebra. It expands the definitions,
rewrites the inverse of a product, normalizes division as multiplication by an
inverse, and commutes the factors. Named formulas mean later positive-dimension
proofs can rewrite to the intended convention without unfolding a piecewise
definition.

{{< panel "info" >}}
**Indexing convention.** A theorem stated at `n + 1` is the Lean-native way to
express positive dimension without carrying a separate hypothesis `0 < n`.
Every positive natural number has that form, and the zero branch remains
disjoint and executable.
{{< /panel >}}

## Camp two: one coordinate probability space

### `GUE.coordinateMeasure`

The free Hermitian coordinate space is a pair:

\[
(\operatorname{Fin}(n)\to\mathbb R)
\times
(\operatorname{StrictUpperIndex}(n)\to\mathbb C).
\]

`coordinateMeasure n` puts one finite product measure on each component and
then takes their binary product:

```lean
noncomputable def coordinateMeasure (n : ℕ) :
    Measure (HermitianCoordinateSpace n) :=
  (gaussianProductMeasure
      (fun _ : Fin n => 0)
      (fun _ => diagonalVariance n)).prod
    (cartesianComplexGaussianProductMeasure
      (fun _ : StrictUpperIndex n => 0)
      (fun _ => upperCartesianVariance n)
      (fun _ => upperCartesianVariance n))
```

The left law is the exact joint law of a centered real Gaussian vector. The
right law is the exact joint law of centered Cartesian complex Gaussians with
equal real and imaginary variances. The outer `.prod` does two jobs at once:
it creates the joint sample space and encodes independence between the two
blocks.

This is a measure-first construction. The sample point is simply a coordinate
pair `x`, and the canonical random variables are projections and evaluations
of `x`. No pseudorandom generator or algorithmic sampler is part of the Lean
definition.

### `GUE.instIsProbabilityMeasureCoordinateMeasure`

Both finite product factors are already probability measures. Mathlib's
binary product of probability measures is again a probability measure, so the
instance unfolds `coordinateMeasure` and asks type-class inference to assemble
the proof. The result is available automatically whenever a later theorem
needs `[IsProbabilityMeasure (coordinateMeasure n)]`.

This is an important distinction: defining a `Measure` does not by itself
prove total mass one. The instance closes that gap in every dimension.

## Camp three: expose the two blocks

### `GUE.coordinateMeasure_hasLaw_diagonalBlock`

Under the product coordinate measure, `Prod.fst` returns the full diagonal
vector. Mathlib proves that the first projection of a product probability
measure is measure preserving. Calling `.hasLaw` converts that statement into
an exact `HasLaw` theorem for the canonical diagonal product measure.

The conclusion is about the entire vector, not one coordinate. This full
block law later becomes the certificate from which mutual independence of all
diagonal evaluations can be recovered.

### `GUE.coordinateMeasure_hasLaw_upperBlock`

The symmetric theorem for `Prod.snd` gives the complete strict-upper vector
its Cartesian complex Gaussian product law. Again the target is a function
space indexed by every strict-upper position, not a single entry.

### `GUE.coordinateMeasure_indepFun_diagonal_upper`

`coordinateMeasure_indepFun_diagonal_upper` states that `Prod.fst` and
`Prod.snd` are independent functions under the coordinate measure. The proof
is exactly Mathlib's `indepFun_prod measurable_id measurable_id`.

This theorem is stronger than saying that one selected diagonal coordinate is
independent of one selected upper coordinate. It separates the sigma-algebras
generated by the two full random vectors. Coordinate-level cross independence
will be derived by measurable postcomposition.

## High camp: from block independence to coordinate independence

### `GUE.coordinateMeasure_diagonal_hasLaw`

For `i : Fin n`, evaluation `x ↦ x.1 i` has the centered real Gaussian law
with variance `diagonalVariance n`. The proof starts from the existing
evaluation theorem on `gaussianProductMeasure` and composes it with the full
diagonal-block law.

The direction of composition matters. First sample the pair from
`coordinateMeasure`; then project its first component; then evaluate at `i`.
The law follows that same path.

### `GUE.coordinateMeasure_upper_hasLaw`

For `ij : StrictUpperIndex n`, evaluation `x ↦ x.2 ij` has the exact centered
Cartesian complex Gaussian law with both coordinate variances equal to
`upperCartesianVariance n`. This theorem does not abbreviate the pair of
variances to a single ambiguous "complex variance."

For positive dimension, its two real marginals therefore each have variance
\(1/(2n)\). At dimension zero no `ij` can be supplied, so the theorem is total
without making a vacuous coordinate assertion.

### `GUE.coordinateMeasure_diagonal_iIndepFun`

This theorem states mutual independence of the complete family

\[
i\longmapsto (x\longmapsto x.1_i).
\]

The proof uses `iIndepFun_iff_hasLaw_pi_pi`. In a finite family, exact scalar
laws plus the exact joint product law characterize mutual independence. After
rewriting with the scalar law theorem, the already checked diagonal-block law
is precisely the joint law required by that equivalence.

Mutual independence is stronger than pairwise independence. The theorem can
support later products of more than two diagonal observables without silently
upgrading a pairwise claim.

### `GUE.coordinateMeasure_upper_iIndepFun`

The upper family receives the same treatment. The scalar laws are Cartesian
complex Gaussian, the joint law is their finite product, and the equivalence
recovers `iIndepFun` for every strict-upper evaluation.

This family indexes each complex entry as one random variable. Independence of
its displayed real and imaginary parts was built into each Cartesian complex
law earlier; mutual independence here is across distinct strict-upper matrix
positions.

### `GUE.coordinateMeasure_diagonal_indepFun_upper`

Given one diagonal index `i` and one upper index `ij`, the theorem derives
independence of `x ↦ x.1 i` and `x ↦ x.2 ij`. It composes the full block
independence theorem with the two measurable evaluation maps.

The proof records a durable probability principle: measurable functions of
independent random objects remain independent. It does not need to expand the
definition of independent events or recompute rectangle probabilities.

{{< panel "info" >}}
**Three different scopes.** `coordinateMeasure_indepFun_diagonal_upper`
separates two full vectors. The two `iIndepFun` theorems give mutual
independence within each vector. `coordinateMeasure_diagonal_indepFun_upper`
selects one coordinate from each vector. The statements are related, but they
are not interchangeable names for the same proof obligation.
{{< /panel >}}

## Summit camp: push the coordinate law to matrices

### `GUE.matrixLaw`

```lean
noncomputable def matrixLaw (n : ℕ) :
    Measure (Matrix (Fin n) (Fin n) ℂ) :=
  RandomMatrix.law (RandomMatrix.hermitianCoordinateMap n)
    (RandomMatrix.measurable_hermitianCoordinateMap n)
    (coordinateMeasure n)
```

`matrixLaw n` does not sample entries again. It sends the already assembled
coordinate probability space through the deterministic map checked in RMT-05.
In mathematical notation,

\[
\mu_n^{\mathrm{GUE}}
=(\operatorname{hermitianCoordinateMap}(n))_*
  \mu_n^{\mathrm{coord}}.
\]

The measurability proof is an explicit argument to `RandomMatrix.law`. This
matters because Mathlib's `Measure.map` is total even outside its intended
measurable regime; carrying the proof prevents a fallback branch from being
mistaken for the desired pushforward.

### `GUE.matrixLaw_eq_map`

The named equation unfolds the project wrapper and exposes the raw
`Measure.map` expression. Its proof is reflexivity. Downstream measure algebra
can rewrite with this theorem without depending on the implementation details
of `RandomMatrix.law`.

### `GUE.instIsProbabilityMeasureMatrixLaw`

A measurable pushforward of a probability measure is a probability measure.
The instance applies the reusable theorem
`RandomMatrix.law_isProbabilityMeasure` to the coordinate map, its
measurability certificate, and the coordinate probability measure.

The type-class result confirms total mass one. It does not by itself establish
support, invariance, density, or moments.

### `GUE.matrixLaw_diagonal_hasLaw`

The diagonal theorem is deliberately stronger than a statement only about the
real part. For `i : Fin n`, it proves

\[
H_{ii}\sim
\operatorname{CartesianComplexGaussian}
\left(0,\operatorname{diagonalVariance}(n),0\right).
\]

The real coordinate has the exact diagonal Gaussian law, while the imaginary
coordinate is the constant zero with zero-variance Gaussian law. The proof
constructs that constant law, proves the real coordinate independent of a
constant, combines the pair with
`HasCartesianComplexGaussianLaw.of_indep_re_im`, and uses the deterministic
diagonal assembly formula to identify the resulting complex value.

The final transport is subtle. On the coordinate sample space, assembly is a
random matrix with law `matrixLaw n`. On the matrix sample space equipped with
that very law, the identity is another random matrix with the same law.
`HasLaw.comp_of_hasLaw_comp` transfers the diagonal-entry distribution from
the first realization to the second. Measurability of matrix entry evaluation
supplies the required observable hypothesis.

Consequently the theorem contains both facts experts expect from a Hermitian
diagonal: the entry lies on the real line in distribution, and its real
coordinate has the selected Gaussian variance. It still does not prove a
separate matrix-level support theorem.

### `GUE.matrixLaw_upper_hasLaw`

Given `hij : i < j`, the strict-upper matrix evaluation `H ↦ H i j` has the
exact centered Cartesian complex Gaussian law with equal variances
`upperCartesianVariance n`. The source coordinate is indexed by the proof
carrying value `⟨(i, j), hij⟩`.

On the coordinate space, the upper-entry simplification theorem says assembly
returns that coordinate unchanged. The proof first turns this pointwise
identity into almost-everywhere equality with `HasLaw.congr`. It then uses the
same `HasLaw.comp_of_hasLaw_comp` transport pattern as the diagonal theorem.

No lower-entry theorem is necessary in this slice. The deterministic assembly
file already proves lower entries are conjugates of their upper partners.
Transferring that law, or packaging joint conjugate-pair laws, can be added
when a downstream observable needs it.

## The zero-dimensional law is deliberate

At \(n=0\), `Fin 0` and `StrictUpperIndex 0` are empty. Each function space in
`HermitianCoordinateSpace 0` therefore has exactly one value, and their product
also has exactly one value. The selected scale is zero, but there are no scalar
coordinates on which even that degenerate law must be evaluated.

### `GUE.coordinateMeasure_zero`

The theorem proves

\[
\operatorname{coordinateMeasure}(0)
=\delta_{0}.
\]

The proof unfolds both finite product-measure abbreviations. `Measure.pi_of_empty`
turns each empty indexed product into a Dirac measure. The product of two Dirac
measures is Dirac at their pair, and `Subsingleton.elim` identifies that pair
with the zero coordinate point.

### `GUE.matrixLaw_zero`

The matrix theorem rewrites the law as a map, substitutes the coordinate Dirac
formula, maps the Dirac mass through the measurable Hermitian coordinate map,
and simplifies the assembled empty matrix to zero:

\[
\operatorname{matrixLaw}(0)
=\delta_{0_{0\times0}}.
\]

The result is not a statement about a limiting ensemble as \(n\to0\). It is a
totality theorem for the dimension-indexed API. Every natural dimension can be
passed to the same definitions without an exception or an unrecorded division
policy.

## The complete declaration map

| Public declaration | Checked content | Main proof mechanism |
|---|---|---|
| `GUE.varianceScale` | Total Wigner variance scale with explicit zero branch | Pattern match on dimension |
| `GUE.diagonalVariance` | Semantic name for diagonal variance | Definition by `varianceScale` |
| `GUE.upperCartesianVariance` | Variance of each upper real/imaginary coordinate | Divide base scale by two |
| `GUE.varianceScale_zero` | Base scale is zero at dimension zero | Reflexivity |
| `GUE.varianceScale_succ` | Positive-dimensional base scale is reciprocal dimension | Reflexivity |
| `GUE.diagonalVariance_zero` | Diagonal variance is zero at dimension zero | Reflexivity |
| `GUE.diagonalVariance_succ` | Positive diagonal variance is reciprocal dimension | Reuse scale successor theorem |
| `GUE.upperCartesianVariance_zero` | Upper Cartesian variance is zero at dimension zero | Simplification |
| `GUE.upperCartesianVariance_succ` | Positive upper Cartesian variance is reciprocal twice-dimension | Nonnegative-real inverse algebra |
| `GUE.coordinateMeasure` | Product law on real diagonal and complex strict upper coordinates | Two finite products, then binary product |
| `GUE.instIsProbabilityMeasureCoordinateMeasure` | Coordinate law has total mass one | Product probability instance |
| `GUE.coordinateMeasure_hasLaw_diagonalBlock` | First projection has the full diagonal product law | Measure-preserving first projection |
| `GUE.coordinateMeasure_hasLaw_upperBlock` | Second projection has the full upper product law | Measure-preserving second projection |
| `GUE.coordinateMeasure_indepFun_diagonal_upper` | The two full coordinate blocks are independent | Independence of product projections |
| `GUE.coordinateMeasure_diagonal_hasLaw` | Each diagonal coordinate has its exact real Gaussian law | Evaluation law composed with block law |
| `GUE.coordinateMeasure_upper_hasLaw` | Each upper coordinate has its exact Cartesian complex Gaussian law | Evaluation law composed with block law |
| `GUE.coordinateMeasure_diagonal_iIndepFun` | All diagonal evaluations are mutually independent | Joint product-law characterization |
| `GUE.coordinateMeasure_upper_iIndepFun` | All upper evaluations are mutually independent | Joint product-law characterization |
| `GUE.coordinateMeasure_diagonal_indepFun_upper` | Any diagonal coordinate is independent of any upper coordinate | Measurable postcomposition of block independence |
| `GUE.matrixLaw` | Ambient matrix law induced by Hermitian assembly | `RandomMatrix.law` pushforward |
| `GUE.matrixLaw_eq_map` | Matrix law equals the explicit `Measure.map` | Reflexivity |
| `GUE.instIsProbabilityMeasureMatrixLaw` | Matrix law has total mass one | Probability preservation under measurable map |
| `GUE.matrixLaw_diagonal_hasLaw` | Full complex diagonal law has real variance `diagonalVariance n` and imaginary variance zero | Build line-supported complex law, then exact-law transport |
| `GUE.matrixLaw_upper_hasLaw` | Strict-upper entry has equal-variance Cartesian complex Gaussian law | Assembly lookup, congruence, exact-law transport |
| `GUE.coordinateMeasure_zero` | Empty coordinate law is Dirac at zero | Empty finite products and Dirac product |
| `GUE.matrixLaw_zero` | Empty matrix law is Dirac at the zero matrix | Map Dirac through zero-dimensional assembly |

The map contains exactly twenty-six named public declarations in this version
of the module. Namespace openings, imported declarations, generated instance
machinery, and local proof terms are not counted as new public declarations.

## Run the checked source

From the repository root on macOS or Linux, load elan and invoke Lean through
the pinned Lake environment:

```sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsemble.lean
```

Starting from the repository root, build the full formalization and check the
public teaching content:

```sh
cd formalization
lake build

cd ..
make content-hygiene
make site-check
```

At this milestone the full Lean build checks 3,142 jobs. The direct command is
the narrower reproducibility test for this module. The final two commands check
the teaching content and render the Hugo site.

This complete Lean snippet inspects the main API without placeholders:

```lean
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsemble

open Matrix MeasureTheory ProbabilityTheory
open scoped NNReal ProbabilityTheory Matrix

open NonlinearDynamics.Random

#check GUE.varianceScale
#check GUE.diagonalVariance_succ
#check GUE.upperCartesianVariance_succ
#check GUE.coordinateMeasure
#check GUE.coordinateMeasure_indepFun_diagonal_upper
#check GUE.coordinateMeasure_diagonal_iIndepFun
#check GUE.coordinateMeasure_upper_iIndepFun
#check GUE.matrixLaw
#check GUE.matrixLaw_diagonal_hasLaw
#check GUE.matrixLaw_upper_hasLaw
#check GUE.coordinateMeasure_zero
#check GUE.matrixLaw_zero
```

Save it inside `formalization` and run `lake env lean` on the file. The snippet
uses the exact checked names and contains no omitted terms or noncompiling
ellipses.

## Failure modes the API is designed to expose

| Tempting shortcut | What goes wrong | Checked repair |
|---|---|---|
| Call the Gaussian parameter a standard deviation | Every scale is off by a square | Use Mathlib's documented variance parameter and semantic names |
| Give a whole complex upper entry variance \(1/(2n)\) | Its two Cartesian coordinates then total only \(1/(2n)\) | Give each real/imaginary coordinate variance \(1/(2n)\) |
| Give each upper coordinate variance \(1/n\) | The complex second moment becomes \(2/n\) | Split the target \(1/n\) equally between two displayed axes |
| Define every scale as `n⁻¹` and ignore zero | The scientific edge policy is hidden inside algebra | Pattern match and prove named zero/successor formulas |
| State scalar marginal laws only | Marginals do not determine a joint law or independence | Prove full block laws and finite `iIndepFun` theorems |
| Treat pairwise independence as mutual independence | Products of three or more observables are unsupported | Recover finite mutual independence from the joint product law |
| Infer cross-family independence from within-family results | Two internally independent blocks can still be coupled | Build a binary product measure and prove block independence |
| Define a matrix law without a measurability proof | `Measure.map` may use fallback behavior | Pass `measurable_hermitianCoordinateMap` explicitly |
| Prove only the real part of a diagonal is Gaussian | The ambient complex entry's imaginary support remains unstated | Prove the full Cartesian complex law with imaginary variance zero |
| Say assembled matrices are Hermitian, therefore the measure has a support theorem | Pointwise construction and measure-level support are different statements | Keep support as a later pushforward-a.e. theorem |
| Use "GUE" as a proof of unitary invariance | A conventional name does not establish equality of measures | Prove invariance separately through the law interface |
| Quote the density after defining a pushforward | Coordinate-product equivalence to Hermitian Lebesgue density still needs geometry | Label the density calculation contextual and defer its theorem |
| Drop dimension zero because no matrix entry exists | A dimension-indexed API becomes partial exactly at a natural boundary | Prove coordinate and matrix Dirac laws |

## Exercises with solutions

### Exercise 1: audit the two-by-two ledger

At \(n=2\), what are the diagonal and displayed upper-coordinate variances?
What is the contextual value of \(\mathbb{E}|H_{01}|^2\)?

**Solution.** Each diagonal real coordinate has variance \(1/2\). The real
and imaginary parts of the one strict-upper entry each have variance \(1/4\).
For centered independent coordinates, their second moments add, so
\(\mathbb{E}|H_{01}|^2=1/4+1/4=1/2\). The Lean file proves the exact component
laws and independence architecture, not this expectation equation as a named
theorem.

### Exercise 2: recover the density coefficient

Why does one off-diagonal complex coordinate contribute
\(\exp(-n|z|^2)\), not \(\exp(-n|z|^2/2)\)?

**Solution.** Write \(z=x+iy\). Each real coordinate has variance \(1/(2n)\),
so its Gaussian exponent is
\(-x^2/(2/(2n))=-nx^2\), and similarly for \(y\). Multiplication yields
\(\exp(-n(x^2+y^2))\). The factor of two in
\(\operatorname{Tr}(H^2)\) counts the reflected lower entry, producing the
same coefficient in \(\exp(-n\operatorname{Tr}(H^2)/2)\).

### Exercise 3: identify four independence statements

Name the declarations for independence of the two full blocks, all diagonal
coordinates, all upper coordinates, and one selected cross-block pair.

**Solution.** Use
`coordinateMeasure_indepFun_diagonal_upper`,
`coordinateMeasure_diagonal_iIndepFun`,
`coordinateMeasure_upper_iIndepFun`, and
`coordinateMeasure_diagonal_indepFun_upper`, respectively. The different
types prevent one scope from silently substituting for another.

### Exercise 4: explain the diagonal complex law

Why is `matrixLaw_diagonal_hasLaw` a Cartesian complex Gaussian theorem rather
than only a real Gaussian theorem?

**Solution.** `matrixLaw n` lives on ambient complex matrices, so `H i i` has
type `ℂ`. The theorem records the exact law in that codomain: its real part is
the chosen Gaussian, its imaginary part is the constant zero Gaussian, and the
two are independent. A real-part-only theorem would omit the line-supported
nature of the full entry.

### Exercise 5: follow the pushforward transport

Why can an entry law proved for `hermitianCoordinateMap n x` under
`coordinateMeasure n` be reused for the identity matrix variable under
`matrixLaw n`?

**Solution.** By definition, the assembled coordinate variable has law
`matrixLaw n`. The identity variable on the matrix space equipped with that
measure has the same law. `HasLaw.comp_of_hasLaw_comp` says a measurable
observable with a known law under one realization of a source law has that
same law under any other realization. Matrix-entry evaluation is the
observable.

### Exercise 6: distinguish pointwise Hermiticity from support

What additional shape would a measure-level support theorem need?

**Solution.** One honest formulation would show that the predicate
`Matrix.IsHermitian` holds almost everywhere under `matrixLaw n`, or that the
measure of the set of Hermitian matrices is one after proving that set
measurable. RMT-05 proves every assembled output Hermitian, but RMT-06 does not
package that fact into either measure statement.

### Exercise 7: collapse dimension zero

Why does `coordinateMeasure_zero` need no calculation with Gaussian density
constants?

**Solution.** Both index types are empty. A finite product over an empty type
is the Dirac mass at the unique empty function regardless of the scalar family
that would have been indexed. The binary product of those two Dirac masses is
Dirac at the unique coordinate pair. No scalar Gaussian coordinate exists.

## What the construction buys us, and what comes next

The important advance is not just that a symbol `matrixLaw` now exists. The
formalization has a complete causal chain:

1. an audited numerical convention determines exact scalar laws;
2. finite products determine exact joint block laws;
3. a binary product determines cross-block independence;
4. a measurable deterministic map assembles matrices; and
5. a pushforward transfers the coordinate probability measure to matrix
   space.

Every later random-matrix observable can now begin from one concrete
probability measure. If it needs a diagonal marginal, an upper marginal, or a
coordinate-independence fact, those are named theorems rather than informal
properties of an ensemble label.

The next ridge is genuinely geometric. To prove the familiar density and
unitary invariance, the project needs to relate the coordinate product to a
Gaussian measure on the real vector space of Hermitian matrices, prove how
the Hilbert-Schmidt quadratic form counts strict-upper coordinates, and show
unitary conjugation preserves that geometry. The factor two in the upper
triangle is exactly where a casual proof is most likely to break.

Only after support and invariance are checked should the development climb to
expectations, trace moments, eigenvalue measurability, empirical spectral
measures, and asymptotic laws. The present file is finite-dimensional and
exact. That narrowness is what makes it a reliable base camp.

## References

The external links below were opened and checked on 2026-07-21. The pinned
local Mathlib checkout remains the API authority for the Lean proofs.

<a id="ref-guionnet-2022"></a>
**Alice Guionnet.**
["Rare Events in Random Matrix Theory"](https://ems.press/content/book-chapter-files/33150),
*Proceedings of the International Congress of Mathematicians 2022*, volume 2,
pages 1008–1052. [DOI 10.4171/ICM2022/174](https://doi.org/10.4171/ICM2022/174).
Section 1.1.1 states the GUE coordinate variances and the
\(-\beta n\operatorname{Tr}(H^2)/4\) Gaussian-ensemble density convention.
This source warrants the normalization context, not a claim that the density
or invariance has already been formalized here.

<a id="ref-tao-vu-2013"></a>
**Terence Tao and Van Vu.**
["Random Matrices: Sharp Concentration of Eigenvalues"](https://arxiv.org/abs/1201.4789v4),
*Random Matrices: Theory and Applications* 2(3), 1350007, 2013.
[DOI 10.1142/S201032631350007X](https://doi.org/10.1142/S201032631350007X).
The final arXiv version was posted 2013-08-10. Its abstract explicitly uses
the \(1/\sqrt n\) Wigner normalization and the \([-2,2]\) spectral scale.
The citation supplies context only; no spectral theorem from the paper is
claimed in Lean.

<a id="ref-mathlib-release"></a>
**Mathlib contributors.**
[Mathlib 4.32.0 release](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
2026. This is the exact dependency release selected by
`formalization/lakefile.toml`.

<a id="ref-mathlib-gaussian"></a>
**Mathlib contributors.**
[Real Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
Mathlib 4 documentation. The page documents `gaussianReal`, identifies its
`ℝ≥0` parameter as variance, and states that zero variance produces a Dirac
measure.

<a id="ref-mathlib-prod"></a>
**Mathlib contributors.**
[Product measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Prod.html),
Mathlib 4 documentation. This is the official source for binary product
measures, measure-preserving projections, probability instances, and Dirac
product identities used by the coordinate and zero-dimensional proofs.

<a id="ref-mathlib-haslaw"></a>
**Mathlib contributors.**
[Laws of random variables](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/HasLaw.html),
Mathlib 4 documentation. This module defines `HasLaw` as an
almost-everywhere-measurable random variable with a specified pushforward law
and provides the finite product-law characterization of mutual independence
used here.

<a id="ref-mathlib-independence"></a>
**Mathlib contributors.**
[Independence](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Independence/Basic.html),
Mathlib 4 documentation. This is the official interface for `IndepFun`,
`iIndepFun`, independence under product measures, and measurable
postcomposition.
