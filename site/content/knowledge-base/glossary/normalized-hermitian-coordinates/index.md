---
title: "Normalized Hermitian coordinates"
slug: "normalized-hermitian-coordinates"
summary: "Normalized Hermitian coordinates place diagonal, upper-real, and upper-imaginary data in one real Euclidean ledger whose decoding is an isometry and whose product Gaussian law matches the scaled intrinsic Hermitian Gaussian."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleInvariance"
og_image: "normalized-hermitian-coordinates-card.png"
og_image_alt: "A Hermitian entry ledger becomes one normalized real coordinate family, then decodes isometrically into intrinsic Hermitian Euclidean space with one common Gaussian variance."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

**Normalized Hermitian coordinates** are real coordinates for a finite
{{< refterm "hermitian-matrix" "Hermitian matrix" >}} chosen to be
orthonormal for the Frobenius inner product. They keep each real diagonal
entry unchanged and multiply the real and imaginary parts of every freely
chosen strict-upper entry by \(\sqrt2\).

Equivalently, decoding a normalized coordinate vector divides its two upper
components by \(\sqrt2\) before combining them into a complex entry. This one
correction reconciles three descriptions:

- independent real coordinates with one common variance;
- the entrywise Gaussian ledger of the Gaussian unitary ensemble (GUE); and
- the basis-neutral standard Gaussian on intrinsic Hermitian Euclidean space.

The normalization is forced by geometry. A strict-upper entry is reflected as
its complex conjugate below the diagonal, so the Frobenius norm counts its
magnitude twice.

## One finite real index

Let \(I_n^{\lt}\) denote the finite set of strict-upper positions. The normalized
real coordinate index is the disjoint union

\[
\mathcal I_n
=\operatorname{Fin}(n)
 \sqcup I_n^{\lt}
 \sqcup I_n^{\lt}.
\]

The three regions have distinct meanings:

| Region | Stored value | Matrix role |
|---|---|---|
| Diagonal | \(a_i\in\mathbb R\) | The real diagonal entry |
| Upper-real | \(b_{ij}\in\mathbb R\) | Normalized real part of the upper entry |
| Upper-imaginary | \(c_{ij}\in\mathbb R\) | Normalized imaginary part of the upper entry |

A raw coordinate vector is a function \(z:\mathcal I_n\to\mathbb R\). Its
Euclidean packaging is

\[
\operatorname{EuclideanSpace}(\mathbb R,\mathcal I_n).
\]

Using a single index matters for probability. One finite product measure over
\(\mathcal I_n\) records the joint law and mutual independence of every
normalized coordinate at once. Splitting the sum index later recovers the
diagonal, upper-real, and upper-imaginary blocks without replacing the joint
law by a list of marginals.

## Decoding into a Hermitian matrix

For \(i\lt j\), normalized decoding sets

\[
H_{ii}=a_i,
\qquad
H_{ij}=\frac{b_{ij}+i c_{ij}}{\sqrt2},
\qquad
H_{ji}=\frac{b_{ij}-i c_{ij}}{\sqrt2}.
\]

The lower entry is the conjugate reflection of the upper entry, so the result
is Hermitian by construction. The inverse analysis map extracts

\[
a_i=H_{ii},
\qquad
b_{ij}=\sqrt2\operatorname{Re}(H_{ij}),
\qquad
c_{ij}=\sqrt2\operatorname{Im}(H_{ij}).
\]

The two formulas are inverse coordinate by coordinate. Bundling them as a
real linear equivalence says more than having two convenient functions: it
records exact reconstruction and makes addition and real scaling available to
later transport proofs.

## Why decoding is an isometry

For a Hermitian matrix with normalized coordinates \(a,b,c\), the
{{< refterm "hermitian-frobenius-geometry" "Frobenius squared norm" >}} is

\[
\begin{aligned}
\lVert H\rVert_F^2
&=\sum_i a_i^2
 +2\sum_{i\lt j}|H_{ij}|^2\\
&=\sum_i a_i^2
 +2\sum_{i\lt j}
   \left|\frac{b_{ij}+ic_{ij}}{\sqrt2}\right|^2\\
&=\sum_i a_i^2
 +\sum_{i\lt j}b_{ij}^2
 +\sum_{i\lt j}c_{ij}^2.
\end{aligned}
\]

The last line is exactly the Euclidean squared norm of \(z\). Because the map
is real linear, preservation of the norm upgrades it to a real linear
isometric equivalence between normalized Euclidean coordinates and intrinsic
Hermitian Euclidean space.

{{< reference-figure
  src="normalized-hermitian-coordinate-bridge.svg"
  alt="The Hermitian entry ledger contains real diagonal entries and complex strict-upper entries. A normalized real ledger separates diagonal, upper-real, and upper-imaginary slots. The upper slots carry the metric correction caused by conjugate reflection. Decoding reaches intrinsic Hermitian Euclidean space, where all normalized directions have one common Gaussian scale."
  caption="**Finding:** normalization is simultaneously geometric and probabilistic. Reflected off-diagonal entries are counted twice by the Frobenius norm; correcting the upper coordinates makes decoding an isometry and gives every orthonormal real direction the same Gaussian variance. The resulting law comparison concerns the full finite product measure, not just scalar marginals."
>}}

## The normalized product law

Let \(s_n\) be the project's variance scale: \(s_0=0\), and
\(s_n=1/n\) for positive \(n\). Put the centered real Gaussian law with
variance \(s_n\) on **every** index in \(\mathcal I_n\):

\[
\rho_n
=\bigotimes_{k\in\mathcal I_n}N(0,s_n).
\]

After normalized decoding:

- a diagonal entry has variance \(s_n\);
- the real part of an upper entry has variance \(s_n/2\);
- the imaginary part of an upper entry has variance \(s_n/2\); and
- all primitive coordinates retain the exact block and within-block
  independence encoded by the product measure.

The upper variance follows from scalar Gaussian transport:

\[
\operatorname{Var}\!\left(\frac{Z}{\sqrt2}\right)
=\frac12\operatorname{Var}(Z)
=\frac{s_n}{2}.
\]

This recovers precisely the earlier GUE coordinate law. The essential theorem
is an equality of the transported **joint measure** with
<code>GUE.coordinateMeasure n</code>. Checking only the three displayed
variance formulas would not establish independence or equality of product
laws.

## From a standard to a scaled intrinsic Gaussian

Mathlib's <code>map_pi_eq_stdGaussian</code> identifies the product of
independent unit-variance real Gaussians, packaged in finite Euclidean space,
with <code>stdGaussian</code>. Uniform multiplication by
\(\sqrt{s_n}\) sends each unit Gaussian to variance \(s_n\). The raw product
measure still lives on the function space, so the exact equality includes the
canonical finite \(\ell^2\) packaging map:

\[
(\operatorname{WithLp.toLp}_2)_*\rho_n
=\left(z\mapsto\sqrt{s_n}\,z\right)_*
  \operatorname{stdGaussian}
  \bigl(\operatorname{EuclideanSpace}(\mathbb R,\mathcal I_n)\bigr).
\]

Let \(D_n\) denote normalized decoding from that Euclidean carrier into
intrinsic Hermitian space. It is a real linear isometric equivalence. Mathlib's
<code>stdGaussian_map</code> says that such an equivalence carries the
standard Gaussian to the standard Gaussian on its target. Consequently the
decoded law is the image of the intrinsic Hermitian standard Gaussian under
the same uniform scale:

\[
(D_n)_*(\operatorname{WithLp.toLp}_2)_*\rho_n
=\left(H\mapsto\sqrt{s_n}\,H\right)_*
  \operatorname{stdGaussian}
  (\operatorname{HermitianEuclidean}(n)).
\]

This is the coordinate-product to intrinsic-Gaussian bridge that RMT-07 left
open.

## Why pushforwards must commute

Two deterministic routes now begin from the same normalized real data.

The coordinate route splits the real ledger into a diagonal block and two
upper blocks, combines the upper blocks into complex coordinates, and applies
the earlier measurable Hermitian assembly map.

The intrinsic route packages the real ledger as Euclidean data, decodes it
isometrically into intrinsic Hermitian space, and forgets the subtype and
Euclidean packaging to obtain an ambient complex matrix.

The routes agree pointwise on every entry. Measurability and
<code>Measure.map_map</code> then make their pushforward measures agree. This
commuting-square proof is what turns the intrinsic Gaussian comparison into an
exact identity for the already defined ambient <code>GUE.matrixLaw n</code>.

## The symmetry payoff

RMT-07 proved that intrinsic <code>stdGaussian</code> is invariant under
unitary congruence. Uniform real scaling commutes with congruence, and the
intrinsic-to-ambient inclusion intertwines intrinsic congruence with the
existing ambient congruence map. Transporting through the exact law comparison
therefore proves

\[
(H\mapsto UHU^*)_*\operatorname{GUE.matrixLaw}(n)
=\operatorname{GUE.matrixLaw}(n)
\]

for every deterministic unitary \(U\). This is the first checked nontrivial
instance of the project's
{{< refterm "unitary-invariance" "unitary-invariance predicate" >}}.

## Dimension zero

At \(n=0\), the diagonal and both strict-upper index regions are empty. The
normalized real function space, intrinsic Hermitian space, coordinate space,
and ambient matrix space each have one point. Also \(s_0=0\), so uniform
scaling is the constant zero map.

The general pushforward comparison includes this case. It agrees with the
earlier explicit theorem that <code>GUE.matrixLaw 0</code> is the point mass at
the empty matrix. No reciprocal or positive-dimension assumption is hidden in
the bridge.

## Lean-facing interpretation

The checked module names the three-region index
<code>HermitianRealIndex n</code>. The maps
<code>hermitianRealIndexToPair</code> and
<code>pairToHermitianRealIndex</code> enumerate the diagonal, strict-upper, and
reflected-lower matrix positions, and
<code>hermitianRealIndexEquivMatrixIndex</code> bundles the enumeration as a
finite equivalence. This equivalence is used to reorganize the inner-product
sum; complex decoding is supplied separately.

<code>RandomMatrix.realToHermitianCoordinates</code> repackages raw normalized
real functions as the earlier diagonal and complex-upper coordinate type.
<code>RandomMatrix.normalizedHermitianAssembly</code> and
<code>RandomMatrix.normalizedHermitianAnalysis</code> are inverse, and
<code>RandomMatrix.normalizedHermitianLinearIsometryEquiv</code> bundles the
result as the real linear isometric equivalence used by Gaussian transport.

At the measure level, <code>GUE.intrinsicLaw n</code> is deliberately defined as
the old <code>coordinateMeasure n</code> pushed into intrinsic Hermitian space.
The theorem <code>GUE.intrinsicLaw_eq_map_smul_stdGaussian</code> identifies it
with the uniformly Wigner-scaled intrinsic standard Gaussian. Then
<code>GUE.matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw</code> reaches ambient
matrix space, and the final theorem is

~~~lean
theorem GUE.matrixLaw_isUnitaryConjugationInvariant (n : ℕ) :
    RandomMatrix.IsUnitaryConjugationInvariant (GUE.matrixLaw n)
~~~

The intrinsic-law proof locally reconstructs the same real linear isometry
against Mathlib's canonical inner-product-derived module instance. This
addresses a definitional typeclass mismatch in the pinned API; it is not an
additional assumption or a different scalar action.

## Checked boundary

The RMT-08 layer establishes normalized real coordinates, inverse analysis and
decoding, a real linear isometric equivalence, equality of the normalized
product law with the earlier coordinate law, equality with a uniformly scaled
intrinsic standard Gaussian, the commuting ambient pushforward, and unitary
invariance of the coordinate-built GUE matrix law.

It does not define or prove:

- a density relative to Lebesgue measure on Hermitian space;
- a volume form or Jacobian;
- measurable eigenvalues or an eigenvalue joint density;
- trace integrability or expected moments;
- an empirical spectral measure;
- a semicircle law or any large-dimension limit;
- local spectral statistics or universality; or
- any quantum-dynamical interpretation.

## Where to continue

[From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance]({{< relref "/knowledge-base/deep-dives/normalized-hermitian-coordinates-to-gue-invariance" >}})
proves the isometry and follows every measure transport to the final ambient
symmetry theorem. Read
{{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius geometry" >}}
for the factor-of-two metric and
[Intrinsic Hermitian Gaussian Symmetry and Matrix-Law Support]({{< relref "/knowledge-base/deep-dives/intrinsic-hermitian-gaussian-symmetry-and-matrix-law-support" >}})
for the two RMT-07 endpoints joined here.

The {{< refterm "gaussian-unitary-ensemble" "Gaussian unitary ensemble" >}}
entry records the original variance ledger, and
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}})
constructs the coordinate law now identified intrinsically.

## References

**Mathlib contributors.**
[Multivariate Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Multivariate.html),
[real Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
[indexed product measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Constructions/Pi.html),
and
[measure maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
Mathlib 4 documentation. These official APIs provide the finite product law,
scalar Gaussian scaling, standard-Gaussian product identity, isometry
invariance, and composition of measurable pushforwards used by the bridge.

**Alice Guionnet.**
[Rare Events in Random Matrix Theory](https://ems.press/content/book-chapter-files/33150),
in *Proceedings of the International Congress of Mathematicians 2022*, volume
2, European Mathematical Society Press, 2022,
[doi:10.4171/ICM2022/174](https://doi.org/10.4171/ICM2022/174),
pp. 1008-1052. Section 1.1.1 records the classical GUE entry variances,
invariant density, and unitary symmetry. The checked project proof obtains the
symmetry through exact product-measure transport, not through the unformalized
density.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
