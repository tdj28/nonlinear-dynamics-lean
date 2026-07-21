---
title: "From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance"
slug: "normalized-hermitian-coordinates-to-gue-invariance"
date: 2026-07-21
summary: "A textbook derivation of normalized real Hermitian coordinates, the full product-measure comparison with a scaled intrinsic Gaussian, commuting ambient pushforwards, and the first checked nontrivial Gaussian unitary ensemble symmetry."
lead: "The word unitary becomes a theorem only after entrywise independence and basis-neutral Gaussian geometry are proved to describe the same measure."
draft: true
pro_reviewed: false
level: "Finite Gaussian product measures through ambient ensemble symmetry"
reading_time: "75 to 95 minutes"
prerequisites: "Finite product measures, real and complex Gaussian scaling, Hermitian assembly, Frobenius geometry, and intrinsic standard-Gaussian invariance; each is reviewed before use"
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleInvariance"
toc: true
og_image: "normalized-coordinates-to-gue-invariance-card.png"
og_image_alt: "An independent normalized real Gaussian product is decoded into a scaled intrinsic Hermitian Gaussian and included into ambient matrix space; the exact commuting comparison transfers unitary symmetry to the coordinate-built Gaussian unitary ensemble law."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The mathematical
prose, sources, Lean declaration map, figures, and accessibility have not yet
received the required human and Pro reviews. The page must remain a draft until
those gates are complete.
{{< /panel >}}

The phrase *Gaussian unitary ensemble* contains two mathematical claims.
*Gaussian* says how probability is distributed. *Unitary* says that a
deterministic unitary change of basis does not alter that distribution. An
entrywise construction from independent random variables makes the first
claim visible but hides the second. An intrinsic isotropic Gaussian makes the
second claim nearly automatic but hides the exact entry variances and
independence ledger.

The eighth random-matrix-theory milestone (RMT-08) proves that these are two
presentations of the same finite law. It introduces a single family of
normalized real Hermitian coordinates, proves that decoding them is a real
linear isometric equivalence, identifies their full product Gaussian measure
with the earlier coordinate measure, identifies the Euclidean packaging with
a uniformly scaled intrinsic standard Gaussian, and proves that both
deterministic routes commute all the way to ambient matrix space.

The checked module exposes 35 public declarations: 12 definitions or
abbreviations, one probability-measure instance, and 22 theorems. The API is
mapped declaration by declaration below.

Only then does the project transport RMT-07's intrinsic Gaussian symmetry to
the previously defined <code>GUE.matrixLaw</code>. The conclusion is the first
checked nontrivial instance of ambient
{{< refterm "unitary-invariance" "unitary invariance" >}} in the repository.
No density, volume Jacobian, or spectral theorem is needed.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [The comparison in one picture](#the-comparison-in-one-picture) | See the two routes and where they meet |
| Coordinate route | [One normalized real index](#camp-one-one-normalized-real-index) | Encode every free Hermitian degree of freedom uniformly |
| Geometry route | [Decode with the metric correction](#camp-two-decode-with-the-metric-correction) | Prove a real linear isometric equivalence |
| Probability route | [Put one Gaussian scale on every slot](#camp-four-put-one-gaussian-scale-on-every-slot) | Recover the complete earlier coordinate law |
| Intrinsic route | [From the product law to a scaled standard Gaussian](#camp-six-from-the-product-law-to-a-scaled-standard-gaussian) | Identify the basis-neutral Hermitian law |
| Transport route | [The commuting ambient square](#camp-seven-the-commuting-ambient-square) | Prove equality with <code>GUE.matrixLaw</code> |
| Symmetry route | [Transport unitary symmetry](#camp-eight-transport-unitary-symmetry) | Close the first nontrivial ensemble-invariance proof |
| Lean route | [The checked declaration map](#the-checked-declaration-map) | Audit the public API against the landed module |

### Learning objectives

By the summit, you should be able to:

1. define the three-region real index for finite Hermitian coordinates;
2. decode diagonal, upper-real, and upper-imaginary coordinates into a
   Hermitian matrix;
3. recover normalized real coordinates from an intrinsic Hermitian point;
4. derive the factor-of-two metric correction and prove norm preservation;
5. explain why inverse real-linear maps plus norm preservation give a linear
   isometric equivalence;
6. distinguish equality of a full finite product law from agreement of scalar
   marginals;
7. explain how a product measure over a sum index splits into block product
   measures;
8. use scalar Gaussian transport to derive the upper component variances;
9. connect a unit-variance real product with Mathlib's
   <code>stdGaussian</code>;
10. derive the uniformly scaled intrinsic Hermitian Gaussian;
11. state the pointwise commuting identity joining normalized decoding to the
    earlier Hermitian assembly map;
12. use <code>Measure.map_map</code> to turn commuting functions into commuting
    pushforwards;
13. transport intrinsic unitary symmetry to the ambient matrix law;
14. explain why the zero-dimensional case is already contained in the same
    theorem chain; and
15. separate every checked RMT-08 result from density, eigenvalue, moment, and
    asymptotic claims.

## The comparison in one picture

{{< reference-figure
  src="commuting-gaussian-pushforwards.svg"
  alt="The coordinate route sends one independent normalized real Gaussian product through metric-corrected decoding and measurable Hermitian assembly to the coordinate-built ambient matrix law. The intrinsic route sends the standard Hermitian Gaussian through uniform Wigner scaling and ambient inclusion. An exact comparison theorem proves both routes give the same law. Intrinsic unitary symmetry commutes with scaling and inclusion, yielding ambient unitary invariance."
  caption="**Finding:** symmetry is transferred only after the full measures meet in the same ambient space. The normalized product route preserves the original entrywise variance and independence ledger; the intrinsic route exposes basis-neutral Gaussian geometry. The commuting comparison proves they are one law, so RMT-07's intrinsic symmetry becomes a theorem about the actual coordinate-built ensemble."
>}}

The top route preserves the construction history. It begins with independent
real coordinates, splits them into the three Hermitian roles, combines the two
upper components into complex entries, reflects the lower triangle, and ends
at the existing ambient matrix law.

The bottom route preserves the geometry. It begins with the canonical standard
Gaussian on intrinsic Hermitian Euclidean space, applies the common Wigner
scale in every direction, and forgets the intrinsic subtype to obtain an
ambient matrix measure.

RMT-08 proves that the endpoints are equal. Equality is stronger than saying
that both measures are Gaussian, stronger than matching all one-coordinate
variances, and stronger than showing both are supported on Hermitian matrices.

{{< checkpoint stage="Orientation" title="The proof compares constructions, not densities" >}}
The bridge is built from finite product measures, scalar Gaussian map
theorems, linear isometries, and composition of measurable pushforwards. No
Lebesgue measure on Hermitian space is selected, so there is no hidden density
normalization or Jacobian convention.
{{< /checkpoint >}}

## Base camp: the earlier endpoints

RMT-06 constructed a coordinate space

\[
\mathcal C_n
=(\operatorname{Fin}(n)\to\mathbb R)
 \times (I_n^{\lt}\to\mathbb C),
\]

a probability measure \(\nu_n\) on that space, and a measurable assembly map

\[
A_n:\mathcal C_n\to\mathcal M_n,
\]

where \(\mathcal M_n\) is ambient complex matrix space. The matrix law is

\[
\mu_n=(A_n)_*\nu_n.
\]

The coordinate measure gives diagonal variables variance \(s_n\) and the real
and imaginary parts of upper variables variance \(s_n/2\), with the exact
finite product and block-independence structure.

RMT-07 constructed the intrinsic real Euclidean space \(\mathcal H_n\) of
Hermitian matrices, its ambient inclusion

\[
J_n:\mathcal H_n\to\mathcal M_n,
\]

and the standard Gaussian \(\gamma_n=\operatorname{stdGaussian}(\mathcal H_n)\).
For every unitary \(U\), intrinsic congruence \(C_U\) is a real linear
isometry and

\[
(C_U)_*\gamma_n=\gamma_n.
\]

It also proved that \(\mu_n\) gives the measurable Hermitian locus mass one,
equivalently that an ambient draw is Hermitian almost everywhere. This is not
a claim about Mathlib's topological <code>Measure.support</code>. What remained
was the exact comparison

\[
\mu_n=(J_n)_*(S_n)_*\gamma_n,
\]

where \(S_n\) is uniform multiplication by \(\sqrt{s_n}\).

## Camp one: one normalized real index

Let \(I_n^{\lt}\) be the finite type of strict-upper positions. RMT-08 uses the
sum type

\[
\mathcal I_n
=\operatorname{Fin}(n)
 \sqcup\bigl(I_n^{\lt}\sqcup I_n^{\lt}\bigr).
\]

Read the outer left branch as diagonal coordinates, the inner left branch as
upper-real coordinates, and the inner right branch as upper-imaginary
coordinates. A function \(z:\mathcal I_n\to\mathbb R\) stores every real
degree of freedom exactly once.

The nesting is not mathematically privileged. A three-way finite tagged union
would express the same partition. The nested sum is useful in Lean because
function spaces over sum types admit explicit equivalences with products of
function spaces. Applying that equivalence twice gives

\[
(\mathcal I_n\to\mathbb R)
\simeq
(\operatorname{Fin}(n)\to\mathbb R)
\times(I_n^{\lt}\to\mathbb R)
\times(I_n^{\lt}\to\mathbb R),
\]

up to the chosen product association.

This is exactly the shape needed to compare one homogeneous real product law
with the earlier diagonal and complex-upper block law.

### Why use a function type before Euclidean packaging?

Finite product measures naturally live on ordinary function spaces. Mathlib's
<code>Measure.pi</code> takes a family of scalar measures and produces their
joint product on \(\mathcal I_n\to\mathbb R\). Euclidean geometry, by contrast,
is most convenient on

\[
\mathcal E_n
=\operatorname{EuclideanSpace}(\mathbb R,\mathcal I_n).
\]

The map <code>WithLp.toLp 2</code> changes the packaging without changing any
coordinate. RMT-08 keeps the raw function space long enough to use product-law
theorems and then moves to \(\mathcal E_n\) for isometries and
<code>stdGaussian</code>.

## Camp two: decode with the metric correction

Write the three coordinate families as

\[
a_i=z(\text{diagonal }i),
\quad
b_{ij}=z(\text{upper-real }(i,j)),
\quad
c_{ij}=z(\text{upper-imaginary }(i,j)).
\]

Normalized decoding forms the matrix

\[
H_{ii}=a_i,
\qquad
H_{ij}=\frac{b_{ij}+ic_{ij}}{\sqrt2}\quad(i\lt j),
\qquad
H_{ji}=\frac{b_{ij}-ic_{ij}}{\sqrt2}.
\]

The output is Hermitian by construction. The diagonal branch is real, and the
two off-diagonal branches are conjugates.

Why divide by \(\sqrt2\)? The normalized upper coordinates \(b_{ij},c_{ij}\)
are meant to be orthonormal coordinates of intrinsic Hermitian space. The
matrix stores each complex upper value twice: once above the diagonal and once
as its conjugate below. Without division, the Frobenius norm would give those
coordinates twice the weight of a diagonal coordinate.

The inverse analysis map takes \(H\in\mathcal H_n\) to

\[
a_i=H_{ii},
\qquad
b_{ij}=\sqrt2\operatorname{Re}(H_{ij}),
\qquad
c_{ij}=\sqrt2\operatorname{Im}(H_{ij}).
\]

Hermiticity ensures the diagonal is real. Applying analysis after decoding
returns \(a,b,c\), and decoding after analysis returns every diagonal, upper,
and lower matrix entry. These inverse proofs are entrywise; no dimension count
or choice of basis is needed.

## Camp three: prove the isometry

The Euclidean coordinate norm is

\[
\lVert z\rVert^2
=\sum_i a_i^2
 +\sum_{i\lt j}b_{ij}^2
 +\sum_{i\lt j}c_{ij}^2.
\]

The Hermitian Frobenius identity from RMT-07 gives

\[
\lVert H\rVert_F^2
=\sum_i H_{ii}^2+2\sum_{i\lt j}|H_{ij}|^2.
\]

Substituting the normalized decoding formula yields

\[
\begin{aligned}
\lVert H\rVert_F^2
&=\sum_i a_i^2
 +2\sum_{i\lt j}
   \left|\frac{b_{ij}+ic_{ij}}{\sqrt2}\right|^2\\
&=\sum_i a_i^2
 +\sum_{i\lt j}(b_{ij}^2+c_{ij}^2)\\
&=\lVert z\rVert^2.
\end{aligned}
\]

The map is real linear because every output entry is a fixed real-linear
combination of input coordinates. Together with the inverse formulas and norm
preservation, this bundles as a real linear isometric equivalence

\[
D_n:\mathcal E_n\simeq_{\mathbb R}^{\mathrm{iso}}\mathcal H_n.
\]

This one object has two later roles. It transfers the standard Gaussian by
<code>stdGaussian_map</code>, and its linearity proves that uniform scaling
commutes with decoding:

\[
D_n(rz)=rD_n(z).
\]

{{< checkpoint stage="Camp three" title="The square-root correction is now structural" >}}
The correction is no longer a variance mnemonic. It is built into an inverse
real-linear map whose norm preservation is checked. Every later probability
identity uses this same map.
{{< /checkpoint >}}

## Camp four: put one Gaussian scale on every slot

Recall the total variance scale

\[
s_n=
\begin{cases}
0,&n=0,\\
1/n,&n\gt 0.
\end{cases}
\]

Define the normalized raw product law

\[
\rho_n
=\bigotimes_{k\in\mathcal I_n}N(0,s_n).
\]

Every normalized coordinate is centered, has the same variance, and is part
of one mutually independent finite family. The homogeneous law is simpler
than the earlier coordinate measure, whose diagonal and displayed upper
components have different variances.

The difference disappears under decoding. A diagonal coordinate is unchanged,
so its variance remains \(s_n\). An upper component is multiplied by
\(1/\sqrt2\). Mathlib's scalar Gaussian map theorem gives

\[
N(0,s_n)\xrightarrow{\text{divide by }\sqrt2}N(0,s_n/2).
\]

Combining one decoded real component and one decoded imaginary component gives
the project's centered Cartesian complex Gaussian with equal component
variances \(s_n/2\).

### Why scalar marginals are not enough

Suppose one proved only that each decoded diagonal coordinate has the desired
law and that each decoded upper coordinate has the desired complex law. Those
facts would not determine the joint distribution. Dependent variables can
have exactly the same scalar marginals as independent variables.

RMT-08 instead transports the entire product measure. The proof must preserve:

1. the joint diagonal product law;
2. the joint upper-real product law;
3. the joint upper-imaginary product law;
4. independence between those three blocks;
5. the pairing of corresponding real and imaginary upper coordinates;
6. the resulting product of Cartesian complex Gaussian laws; and
7. independence between the diagonal block and the whole complex upper block.

The endpoint is not “matching coordinates.” It is an exact measure equality
with <code>GUE.coordinateMeasure n</code>.

## Camp five: split and reassemble the finite product

A function on a sum type is equivalently a pair of functions. Under the
canonical equivalence,

\[
((\alpha\sqcup\beta)\to\mathbb R)
\simeq(\alpha\to\mathbb R)\times(\beta\to\mathbb R).
\]

For finite product measures, pushing the product law on the left through this
equivalence gives the product of the two indexed product laws on the right.
Applying the result twice splits \(\rho_n\) into diagonal, upper-real, and
upper-imaginary blocks.

Next, a pointwise product-family equivalence reorganizes the two upper real
fields into a field of real pairs. The existing Cartesian complex map sends
each pair to one complex number after the upper normalization. Product-map
theorems move the scalar Gaussian equality across the whole finite family.

The proof order matters:

1. split the single sum-index product into block products;
2. transport each upper scalar law through division by \(\sqrt2\);
3. pair the real and imaginary upper families pointwise;
4. map those pairs into complex upper entries; and
5. associate the diagonal and complex-upper blocks exactly as the earlier
   coordinate measure expects.

At no stage is independence inferred from marginal equality. It comes from the
source product measure and is preserved by explicit measurable equivalences
and blockwise maps.

## Camp six: from the product law to a scaled standard Gaussian

Start with the unit product law on raw real coordinates:

\[
\rho_n^{\mathrm{std}}
=\bigotimes_{k\in\mathcal I_n}N(0,1).
\]

Mathlib proves

\[
(\operatorname{toLp})_*\rho_n^{\mathrm{std}}
=\operatorname{stdGaussian}(\mathcal E_n).
\]

This is <code>map_pi_eq_stdGaussian</code>. It is the exact bridge from a
finite product presentation to the basis-neutral Euclidean measure.

Now scale every raw coordinate by \(\sqrt{s_n}\). The scalar map theorem says

\[
(x\mapsto\sqrt{s_n}x)_*N(0,1)=N(0,s_n),
\]

because the variance is multiplied by the square of the scale. Mapping the
whole finite product coordinatewise produces \(\rho_n\). Packaging and scaling
commute pointwise, so repeated use of <code>Measure.map_map</code> yields

\[
(\operatorname{toLp})_*\rho_n
=(z\mapsto\sqrt{s_n}z)_*
  \operatorname{stdGaussian}(\mathcal E_n).
\]

Finally, the decoding isometry \(D_n\) carries the standard Gaussian on
\(\mathcal E_n\) to the standard Gaussian on \(\mathcal H_n\). Its real
linearity makes it commute with the same uniform scaling. Therefore

\[
(D_n)_*(\operatorname{toLp})_*\rho_n
=(H\mapsto\sqrt{s_n}H)_*\gamma_n.
\]

This is the scaled intrinsic Gaussian theorem.

### The local module-instance seam

As in RMT-07, the final application of <code>stdGaussian_map</code> crosses a
Mathlib typeclass seam. The Hermitian subtype's inferred real module structure
and the canonical module structure derived from its inner-product space are
mathematically the same but not definitionally identical in the needed API
context. The proof installs the canonical module locally and reconstructs the
same isometry against that instance.

This is a typeclass and definitional-equality boundary, not a new mathematical
assumption. No alternative scalar action is chosen, and no extra hypothesis is
added to the theorem.

## Camp seven: the commuting ambient square

The probability comparison is useful only if it reaches the already defined
matrix law. There are two deterministic routes from raw normalized coordinates
to an ambient matrix.

The coordinate route first creates an element of the old coordinate space:

\[
z\longmapsto
\left(
  i\mapsto a_i,
  (i,j)\mapsto\frac{b_{ij}+ic_{ij}}{\sqrt2}
\right),
\]

then applies the old Hermitian assembly map \(A_n\).

The intrinsic route packages \(z\) as a Euclidean point, applies normalized
decoding \(D_n\), and includes the intrinsic Hermitian result into ambient
matrix space using \(J_n\).

The commuting identity is

\[
A_n(\operatorname{splitDecode}(z))
=J_n(D_n(\operatorname{toLp}(z))).
\]

It is proved entrywise. On the diagonal both sides return \(a_i\). Above the
diagonal both return the normalized complex combination. Below the diagonal
both return its conjugate.

Because all maps are measurable, <code>Measure.map_map</code> converts the
pointwise identity into an equality of pushforwards. Substituting the exact
coordinate-law theorem and the scaled intrinsic theorem gives

\[
\boxed{
\mu_n
=(J_n)_*(H\mapsto\sqrt{s_n}H)_*\gamma_n}.
\]

The left side is the original <code>GUE.matrixLaw n</code>, not a newly defined
look-alike. Both sides are measures on the same ambient complex matrix space.

{{< checkpoint stage="Camp seven" title="The two Gaussian presentations are now one law" >}}
The comparison preserves the original entrywise product construction and
identifies it with a scaled basis-neutral Gaussian. The classical equivalence
has become an equality of the project's existing Lean measures.
{{< /checkpoint >}}

## Camp eight: transport unitary symmetry

Fix a deterministic unitary matrix \(U\). Let \(C_U^{\mathcal H}\) denote
congruence on intrinsic Hermitian space and \(C_U^{\mathcal M}\) congruence on
ambient matrices.

RMT-07 proved

\[
(C_U^{\mathcal H})_*\gamma_n=\gamma_n.
\]

Two pointwise commuting identities do the remaining work. First, congruence is
real linear, so it commutes with uniform scaling:

\[
C_U^{\mathcal H}(\sqrt{s_n}H)
=\sqrt{s_n}\,C_U^{\mathcal H}(H).
\]

Second, the ambient inclusion intertwines the actions:

\[
J_n(C_U^{\mathcal H}(H))
=C_U^{\mathcal M}(J_n(H)).
\]

Now calculate with pushforwards:

\[
\begin{aligned}
(C_U^{\mathcal M})_*\mu_n
&=(C_U^{\mathcal M})_*(J_n)_*(S_n)_*\gamma_n\\
&=(J_n)_*(S_n)_*(C_U^{\mathcal H})_*\gamma_n\\
&=(J_n)_*(S_n)_*\gamma_n\\
&=\mu_n.
\end{aligned}
\]

The second line uses both commuting identities plus associativity of measurable
pushforwards. The third uses intrinsic Gaussian invariance. The first and last
use the ambient law comparison.

Because \(U\) was arbitrary, this proves

\[
\operatorname{RandomMatrix.IsUnitaryConjugationInvariant}
(\operatorname{GUE.matrixLaw}(n)).
\]

The law is nontrivial in positive dimension: its entries have the exact
nondegenerate Gaussian variances fixed by RMT-06. This distinguishes the result
from the earlier interface examples for the zero measure and the point mass at
the zero matrix.

## Camp nine: dimension zero stays inside the proof

When \(n=0\), all three regions of \(\mathcal I_n\) are empty. There is one
raw coordinate function, one Euclidean point, one intrinsic Hermitian point,
one old coordinate point, and one ambient matrix.

The indexed products are empty probability products. The scale is \(s_0=0\),
and uniform multiplication by \(\sqrt{s_0}\) maps the unique point to itself.
Every decoding and inclusion map is the unique function between singleton
spaces. Thus the general comparison reduces to the previously checked Dirac
law at the empty zero matrix.

The uniform invariance theorem also covers this case: unitary congruence on the
zero-dimensional matrix space is the identity. No positive-size side
condition, reciprocal at zero, or separate density convention is required.

## The checked declaration map

The module
<code>NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleInvariance</code>
checks 35 public declarations. Six initial index declarations and five general
Gaussian-transport declarations live directly in
<code>NonlinearDynamics.Random</code>; 13 geometry declarations live in
<code>RandomMatrix</code>; and 11 ensemble-law declarations, including the
probability instance, live in <code>GUE</code>.

| Lean declaration | Exact checked role | Deliberate boundary |
|---|---|---|
| <code>HermitianRealIndex</code> | Defines the diagonal, upper-real, and upper-imaginary sum index | An index type, not yet a Euclidean carrier or law |
| <code>hermitianRealIndexToPair</code> | Sends diagonal indices to diagonal pairs, upper-real indices above the diagonal, and upper-imaginary indices to reflected lower pairs | The pair enumeration supports the inner-product sum; it is not the complex decoding formula |
| <code>pairToHermitianRealIndex</code> | Classifies every matrix-entry pair as diagonal, strict upper, or reflected strict upper | Uses finite-order trichotomy, not eigenvalue data |
| <code>pairToHermitianRealIndex_toPair</code> | Classifying the pair represented by a real coordinate returns that coordinate | One inverse direction only |
| <code>hermitianRealIndexToPair_pairTo</code> | Representing the classification of a matrix pair returns that pair | Other inverse direction only |
| <code>hermitianRealIndexEquivMatrixIndex</code> | Bundles the two classifications as an equivalence with all matrix-entry pairs | A finite indexing equivalence, not a linear map between value spaces |
| <code>RandomMatrix.realToHermitianCoordinates</code> | Repackages normalized real data into the old diagonal and complex-upper coordinates, dividing upper components by \(\sqrt2\) | Does not assemble a matrix or state a law |
| <code>RandomMatrix.measurable_realToHermitianCoordinates</code> | Proves that repackaging map measurable | No measure equality yet |
| <code>RandomMatrix.normalizedHermitianAssembly</code> | Decodes normalized Euclidean data into intrinsic Hermitian space | Geometry first; probability is added later |
| <code>RandomMatrix.normalizedHermitianAnalysis</code> | Extracts diagonal values and square-root-of-two-scaled upper components from an intrinsic Hermitian point | Uses the upper entry once; the lower entry is constrained by Hermiticity |
| <code>RandomMatrix.hermitianToMatrix_normalizedHermitianAssembly</code> | Shows ambient inclusion after normalized assembly equals the earlier coordinate matrix map | Pointwise commuting identity, not a pushforward theorem |
| <code>RandomMatrix.normalizedHermitianAssembly_apply_diag</code> | Gives the exact diagonal entry formula | No upper or lower claim |
| <code>RandomMatrix.normalizedHermitianAssembly_apply_upper</code> | Gives the exact strict-upper complex formula with divided real components | Makes the metric correction explicit |
| <code>RandomMatrix.normalizedHermitianAssembly_apply_lower</code> | Gives the reflected lower entry as the conjugate of its upper partner | Lower entries are not independent inputs |
| <code>RandomMatrix.normalizedHermitianAnalysis_assembly</code> | Analysis after assembly recovers every normalized coordinate | One inverse direction |
| <code>RandomMatrix.normalizedHermitianAssembly_analysis</code> | Assembly after analysis recovers every intrinsic Hermitian point | Uses Hermiticity for diagonal and lower branches |
| <code>RandomMatrix.normalizedHermitianLinearEquiv</code> | Bundles normalized assembly and analysis as a real linear equivalence | Correctly makes no complex-linearity claim |
| <code>RandomMatrix.normalizedHermitianAssembly_inner</code> | Proves exact preservation of the real Frobenius inner product | Geometry, not Gaussian invariance by itself |
| <code>RandomMatrix.normalizedHermitianLinearIsometryEquiv</code> | Bundles normalized decoding as a real linear isometric equivalence onto intrinsic Hermitian space | No probability law is built into the equivalence |
| <code>map_gaussianProduct_toLp_eq_map_smul_stdGaussian</code> | Identifies any finite common-variance real product, after Euclidean packaging, with the standard Gaussian under uniform square-root-variance scaling | General finite Gaussian theorem, not specific to matrices |
| <code>gaussianReal_map_div_sqrt_two</code> | Proves division by \(\sqrt2\) halves a centered real Gaussian's variance | Scalar law only |
| <code>realUpperToComplex</code> | Pairs two upper real families into complex values after the metric correction | Deterministic family map only |
| <code>measurable_realUpperToComplex</code> | Proves the normalized upper-family pairing measurable | No product-law conclusion yet |
| <code>map_realUpperToComplex_gaussianProduct</code> | Maps two common-variance independent real products to the required Cartesian complex Gaussian product | Proves the whole family law, not merely one upper marginal |
| <code>GUE.coordinateToHermitianEuclidean</code> | Sends the old diagonal and complex-upper coordinate space into intrinsic Hermitian space | Reuses the checked assembly map |
| <code>GUE.measurable_coordinateToHermitianEuclidean</code> | Proves the old-coordinate to intrinsic map measurable | Needed for the intrinsic pushforward definition |
| <code>GUE.coordinateToHermitianEuclidean_realToHermitianCoordinates</code> | Shows old-coordinate assembly after normalized repackaging equals normalized intrinsic assembly after Euclidean packaging | The core pointwise commuting identity |
| <code>GUE.map_realToHermitianCoordinates_gaussianProduct</code> | Identifies the decoded common-variance real product exactly with <code>coordinateMeasure</code> | Preserves the full block product law, not just variances |
| <code>GUE.intrinsicLaw</code> | Defines the existing coordinate GUE law transported into intrinsic Hermitian space | A pushforward of the old law, not a second unrelated ensemble |
| <code>GUE.instIsProbabilityMeasureIntrinsicLaw</code> | Proves the intrinsic law has total mass one in every dimension | No density conclusion |
| <code>GUE.intrinsicLaw_eq_map_smul_stdGaussian</code> | Identifies the intrinsic law with canonical standard Gaussian under uniform Wigner scaling | Uses the local canonical-module API alignment; adds no mathematical hypothesis |
| <code>GUE.intrinsicLaw_zero</code> | Identifies the zero-dimensional intrinsic law as Dirac at the unique zero Hermitian point | Explicit boundary theorem, not a positive-dimensional limit |
| <code>GUE.matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw</code> | Identifies the original ambient matrix law as the intrinsic law pushed through Hermitian inclusion | Exact equality with the existing <code>matrixLaw</code> |
| <code>GUE.map_intrinsicLaw_hermitianCongruence</code> | Proves the Wigner-scaled intrinsic GUE law invariant under every unitary congruence | Intrinsic measure equality before ambient transport |
| <code>GUE.matrixLaw_isUnitaryConjugationInvariant</code> | Proves <code>RandomMatrix.IsUnitaryConjugationInvariant (GUE.matrixLaw n)</code> for every \(n\) | No density, eigenvalue, moment, or asymptotic theorem |

All 35 declarations compile under Lean 4.32.0 and the pinned Mathlib 4.32.0
dependency with warnings treated as errors. The module contains no
<code>sorry</code> or <code>admit</code>.

### Reproduce the check

From the repository root:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleInvariance.lean
~~~

This command checks the normalized-coordinate, product-measure, intrinsic
Gaussian, commuting-pushforward, and unitary-invariance proofs. It does not
sample matrices, estimate a density, calculate eigenvalues, or test any
large-dimension claim.

## What changed at RMT-08

The project now has a genuine equivalence between its entrywise and intrinsic
presentations of finite GUE.

| Layer | Before RMT-08 | RMT-08 result |
|---|---|---|
| Free coordinates | Diagonal and complex upper blocks | One normalized real orthonormal ledger |
| Geometry | Factor-two Frobenius identity | Explicit real linear isometric decoding |
| Joint law | Independent entrywise Gaussian product | Same law transported from one common-variance real product |
| Intrinsic Gaussian | Invariant under unitary congruence | Identified with the coordinate law after uniform scaling |
| Ambient support | Hermitian almost everywhere | Retained under the exact comparison |
| Ambient matrix symmetry | Unchecked for nontrivial GUE | Unitary invariance checked for <code>GUE.matrixLaw</code> |
| Density | Unchecked | Still unchecked and unnecessary here |
| Spectrum and asymptotics | Unchecked | Still unchecked |

The normalization step is not cosmetic. It creates the isometry needed by the
intrinsic Gaussian API and makes the product measure homogeneous. The
commuting-square step is not cosmetic either. It proves that the intrinsic law
is the original ambient matrix law rather than a mathematically related new
definition.

## Classical density context, deliberately outside the proof

Under the selected positive-dimensional convention, the classical finite GUE
density is proportional to

\[
\exp\!\left(-\frac n2\operatorname{Tr}(H^2)\right)
\]

relative to a Lebesgue measure on the real vector space of Hermitian matrices.
In normalized orthonormal coordinates,

\[
\operatorname{Tr}(H^2)=\lVert H\rVert_F^2
\]

is the ordinary Euclidean squared norm. This makes the density's rotational
symmetry intuitive.

RMT-08 does not use or formalize this density. A density theorem would first
need a chosen reference volume measure, a normalization constant, and a proof
relating that volume to the normalized coordinate chart. The product-measure
proof avoids those obligations while still establishing exact equality of
probability laws and unitary invariance.

## Physics window: basis neutrality becomes checked

In a finite quantum system, changing an orthonormal basis transforms a
Hermitian Hamiltonian by unitary congruence. A basis-neutral ensemble should
not assign different probabilities merely because the observer uses another
orthonormal coordinate frame.

The entrywise GUE construction initially looks basis-dependent: it names a
diagonal and strict-upper triangle and places independent Gaussians there.
RMT-08 explains why that appearance is deceptive. Once the free entries are
written in normalized Hermitian coordinates, they form an isotropic real
Gaussian. Isotropy is precisely what makes every orthogonal transformation of
the real Hermitian space invisible to the law, and unitary congruence is one
such transformation.

Dyson's unitary symmetry class supplies the physical and historical context.
The Lean theorem is narrower and exact: for each finite \(n\), every
deterministic bundled unitary matrix leaves the specified ambient GUE
probability measure unchanged. It does not formalize time reversal, quantum
dynamics, energy-level unfolding, or universal spectral statistics.

## Common wrong turns

### Matching variances and declaring equality of laws

Scalar variances do not determine a joint distribution. RMT-08 transports the
whole finite product measure, including every independence relation.

### Using the naive upper real and imaginary parts as orthonormal coordinates

Each upper entry is reflected below the diagonal. The Frobenius norm counts
both copies, so the naive upper components have metric weight two. Normalized
coordinates multiply analysis by \(\sqrt2\) and divide decoding by
\(\sqrt2\).

### Scaling upper entries twice

The normalized product already gives every normalized coordinate variance
\(s_n\). Decoding alone turns the displayed upper components into variance
\(s_n/2\). Applying another upper-specific variance correction would produce
the wrong law.

### Applying standard-Gaussian invariance to the wrong measure

RMT-07's theorem concerns <code>stdGaussian</code> on intrinsic Hermitian
space. It reaches <code>GUE.matrixLaw</code> only after RMT-08 proves the scaled
ambient comparison.

### Forgetting that scaling and congruence must commute

Measure-map algebra needs pointwise function identities. The proof explicitly
uses real linearity of congruence to move uniform scaling across the action.

### Forgetting the ambient inclusion

The project's invariance predicate is stated for measures on ordinary matrix
space. An intrinsic measure equality must be pushed through
<code>hermitianToMatrix</code> before it can discharge that predicate.

### Treating <code>Measure.map</code> as unconditional composition

The useful <code>map_map</code> theorem requires measurability of both maps.
Continuity or bundled linear structure supplies those proofs, but they must be
present.

### Calling the typeclass workaround a mathematical hypothesis

Reinstalling the canonical real module locally aligns Mathlib instances. It
does not assume a new algebraic structure or restrict the theorem.

### Reading unitary invariance as a spectral theorem

The law-level symmetry does not define eigenvalues, prove their joint density,
establish integrability, or imply a semicircle limit inside Lean. Each is a
separate formal layer.

## Exercises

1. **Indexing.** List every element and its role in the normalized real index
   when \(n=2\).
2. **Decode.** Write the full \(2\times2\) Hermitian matrix obtained from four
   normalized real coordinates.
3. **Analyze.** Apply the inverse formulas to that matrix and recover all four
   coordinates.
4. **Metric.** Verify directly that the Euclidean and Frobenius squared norms
   agree in the \(2\times2\) example.
5. **Dimension.** Count the elements of \(\mathcal I_n\) and obtain \(n^2\).
6. **Scalar Gaussian.** Starting with variance \(s\), compute the variance
   after division by \(\sqrt2\).
7. **Joint law.** Give an example of dependent real variables with the same
   Gaussian marginals as an independent pair.
8. **Sum splitting.** Write the forward and inverse functions between a
   function on a two-way sum and a pair of functions.
9. **Upper pairing.** Describe the measurable equivalence between a pair of
   real upper fields and a field of real pairs.
10. **Standard product.** Explain the roles of <code>Measure.pi</code> and
    <code>WithLp.toLp 2</code> in <code>map_pi_eq_stdGaussian</code>.
11. **Uniform scale.** Prove that normalized decoding commutes with real scalar
    multiplication.
12. **Ambient square.** Check the commuting identity separately on diagonal,
    upper, and lower entries.
13. **Pushforwards.** Starting from a pointwise identity between two
    compositions, derive equality of their measure maps under measurability
    hypotheses.
14. **Symmetry chain.** Identify which line of the ambient invariance
    calculation uses RMT-07 and which lines use RMT-08.
15. **Zero dimension.** Show that every type and measure in the comparison has
    the claimed singleton or Dirac interpretation at \(n=0\).
16. **Nonclaim.** List the extra objects needed to state a Hermitian-space
    density theorem rigorously.
17. **Next layer.** Explain why unitary invariance alone does not provide an
    eigenvalue random variable or an expected trace moment.

## Summit register

RMT-08 introduces one normalized real coordinate index containing the
diagonal, upper-real, and upper-imaginary slots. Its decoding map inserts
diagonal values unchanged, divides both upper components by \(\sqrt2\), and
reflects their complex conjugates below the diagonal. The inverse analysis
rescales the displayed upper components by \(\sqrt2\). The maps are inverse,
real linear, and norm preserving, hence a real linear isometric equivalence
with intrinsic Hermitian Euclidean space.

Putting variance \(s_n\) on every normalized real coordinate creates one
homogeneous finite Gaussian product. Exact sum-index splitting, pointwise
pairing, and scalar Gaussian transport identify its decoded law with the full
RMT-06 coordinate measure. Packaging the unit product as Euclidean space gives
Mathlib's standard Gaussian; uniform multiplication by \(\sqrt{s_n}\) gives
the homogeneous product; and the decoding isometry gives the scaled intrinsic
Hermitian Gaussian.

The coordinate route and intrinsic route commute pointwise to ambient matrix
space. Their pushforwards are therefore equal, identifying the existing
<code>GUE.matrixLaw</code> with the ambient image of the scaled intrinsic
Gaussian. Scaling and inclusion commute with unitary congruence, so RMT-07's
intrinsic symmetry transports to the first nontrivial checked theorem that
<code>GUE.matrixLaw</code> is unitarily invariant.

Dimension zero remains inside the uniform construction. A density, Jacobian,
eigenvalue law, trace moment, spectral statistic, empirical spectral measure,
semicircle limit, and universality theorem all remain outside RMT-08.

## Where to continue

[First Exact Finite Gaussian Unitary Ensemble Trace Moments]({{< relref "/knowledge-base/deep-dives/first-exact-finite-gue-trace-moments" >}})
is the next checked layer. It consumes the normalized real product pushforward
to prove integrability and evaluate the first two ordinary-trace expectations.

[Finite Hermitian Spectra and Empirical Measures]({{< relref "/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures" >}})
then constructs ordered finite spectral data and compares the intrinsic and
ambient empirical-measure pushforwards under the explicit coordinatewise
eigenvalue-measurability premise.

Use the
{{< refterm "normalized-hermitian-coordinates" "Normalized Hermitian coordinates" >}}
glossary entry for the compact index, decoding, and product-law ledger.
[Intrinsic Hermitian Gaussian Symmetry and Matrix-Law Support]({{< relref "/knowledge-base/deep-dives/intrinsic-hermitian-gaussian-symmetry-and-matrix-law-support" >}})
develops the RMT-07 geometry and intrinsic symmetry transported here.

[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}})
constructs the entrywise law, while the
{{< refterm "gaussian-unitary-ensemble" "Gaussian unitary ensemble" >}}
entry records the Wigner variance ledger. Read
{{< refterm "pushforward-measure" "pushforward measure" >}} for the law-level
transport operation and
{{< refterm "unitary-invariance" "unitary invariance" >}} for the ambient
predicate finally discharged here.

## References

**Mathlib contributors.**
[Multivariate Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Multivariate.html),
Mathlib 4 documentation. The official API defines
<code>stdGaussian</code>, proves <code>map_pi_eq_stdGaussian</code> for finite
unit products, and proves <code>stdGaussian_map</code> for real linear
isometric equivalences.

**Mathlib contributors.**
[Real Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
[indexed product measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Constructions/Pi.html),
and
[measure maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
Mathlib 4 documentation. These official references specify variance
parameterization, scalar Gaussian transport, finite product construction, and
composition of measurable pushforwards.

**Alice Guionnet.**
[Rare Events in Random Matrix Theory](https://ems.press/content/book-chapter-files/33150),
in *Proceedings of the International Congress of Mathematicians 2022*, volume
2, European Mathematical Society Press, 2022,
[doi:10.4171/ICM2022/174](https://doi.org/10.4171/ICM2022/174),
pp. 1008-1052. Section 1.1.1 records the GUE diagonal variance \(1/n\), upper
real and imaginary variances \(1/(2n)\), invariant density convention, and
unitary symmetry. The RMT-08 proof checks the entrywise-to-intrinsic equivalence
through product measures rather than using the density.

**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems. I](https://doi.org/10.1063/1.1703773),
*Journal of Mathematical Physics* 3 (1962), 140-156. This primary paper
develops the orthogonal, unitary, and symplectic symmetry-class framework and
its quantum-spectral motivation.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
