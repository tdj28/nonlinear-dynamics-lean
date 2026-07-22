---
title: "Hermitian Frobenius geometry"
slug: "hermitian-frobenius-geometry"
summary: "Hermitian Frobenius geometry treats complex Hermitian matrices as a finite-dimensional real Euclidean space whose off-diagonal coordinates carry the factor of two required by unitary symmetry and Gaussian normalization."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleGeometry"
og_image: "hermitian-frobenius-geometry-card.png"
og_image_alt: "An ambient Frobenius matrix space restricts to a Hermitian real subspace; reflected off-diagonal entries create a factor of two, square-root-of-two rescaling gives orthonormal coordinates, and unitary congruence preserves the geometry."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

**Hermitian Frobenius geometry** is the Euclidean geometry obtained by placing
the {{< refterm "hermitian-matrix" "Hermitian matrices" >}} inside the space
of all finite complex matrices and using the Frobenius inner product. It is the
geometry in which

\[
\langle X,Y\rangle_F
=\operatorname{Tr}(X^*Y),
\qquad
\lVert X\rVert_F^2
=\sum_{i,j}|X_{ij}|^2.
\]

The ambient matrix space is complex Euclidean. The Hermitian part is only a
**real** Euclidean subspace: if \(H=H^*\) and \(r\in\mathbb R\), then
\((rH)^*=rH\), but multiplying by \(i\) generally produces a skew-Hermitian
matrix rather than another Hermitian one.

This distinction is not bookkeeping trivia. It determines the correct
orthonormal coordinates, explains the off-diagonal factor of two in
\(\operatorname{Tr}(H^2)\), makes unitary congruence a real linear isometry,
and lets Mathlib's intrinsic standard Gaussian inherit unitary symmetry.

## The ambient Euclidean space

For matrix size \(n\), write

\[
\mathcal F_n
=\mathbb C^{\operatorname{Fin}(n)\times\operatorname{Fin}(n)}.
\]

Lean realizes this as
<code>EuclideanSpace ℂ (Fin n × Fin n)</code>, abbreviated in the project by
<code>RandomMatrix.FrobeniusMatrix n</code>. This representation carries the
finite-dimensional norm, inner product, Borel measurable space, and Gaussian
infrastructure already developed for Euclidean spaces.

An ordinary matrix and a point of \(\mathcal F_n\) contain exactly the same
entries. The maps <code>frobeniusToMatrix</code> and
<code>matrixToFrobenius</code> merely change the packaging. Their two
simplification theorems prove that the conversions are inverse, and
<code>frobeniusMatrixLinearEquiv</code> bundles that fact as a complex linear
equivalence.

The central checked identity is

\[
\langle x,y\rangle_{\mathbb C}
=\operatorname{Tr}\!\left(X^*Y\right),
\]

where \(X\) and \(Y\) are the ordinary matrices corresponding to \(x\) and
\(y\). Expanding the diagonal of \(X^*Y\) gives

\[
\operatorname{Tr}(X^*Y)
=\sum_i\sum_j \overline{X_{ji}}Y_{ji}
=\sum_{i,j}\overline{X_{ij}}Y_{ij},
\]

which is exactly the finite product-space inner product.

## The Hermitian real subspace

Define

\[
\mathcal H_n=\{x\in\mathcal F_n:X=X^*\}.
\]

Because Hermitian matrices are closed under addition and real scalar
multiplication, \(\mathcal H_n\) is a real subspace of \(\mathcal F_n\). It
inherits a real inner product and norm from the ambient space. In the Lean
module, <code>RandomMatrix.hermitianSubmodule n</code> is the bundled real
submodule and <code>RandomMatrix.HermitianEuclidean n</code> is the convenient
abbreviation for its underlying Euclidean type.

The intrinsic and ambient descriptions serve different purposes:

| Description | Type of object | Best suited to |
|---|---|---|
| Ordinary complex matrix | <code>Matrix (Fin n) (Fin n) ℂ</code> | Entry formulas, multiplication, conjugate transpose |
| Ambient Frobenius point | <code>FrobeniusMatrix n</code> | Inner products, norms, linear isometries |
| Intrinsic Hermitian point | <code>HermitianEuclidean n</code> | Real Gaussian measure and unitary action within the Hermitian space |
| Hermitian subset of ambient matrices | <code>hermitianSet n</code> | Support statements about a matrix law |

The map <code>hermitianToMatrix</code> forgets only the subtype certificate; it
does not change any entry. Its measurability lets an intrinsic Hermitian
measure be transported to ordinary matrix space in later work.

## Where the factor of two comes from

Let \(H\in\mathcal H_n\). Its diagonal entries are real; write
\(H_{ii}=d_i\). For \(i\lt j\), write

\[
H_{ij}=x_{ij}+iy_{ij},
\qquad
H_{ji}=\overline{H_{ij}}=x_{ij}-iy_{ij}.
\]

The Frobenius squared norm sums **all** matrix entries. Each diagonal
coordinate appears once, while each freely chosen upper entry reappears below
the diagonal with the same magnitude. Therefore

\[
\begin{aligned}
\lVert H\rVert_F^2
&=\sum_i |H_{ii}|^2
  +\sum_{i\lt j}\bigl(|H_{ij}|^2+|H_{ji}|^2\bigr)\\
&=\sum_i d_i^2
  +2\sum_{i\lt j}\left(x_{ij}^2+y_{ij}^2\right).
\end{aligned}
\]

Equivalently, because \(H^*=H\),

\[
\lVert H\rVert_F^2=\operatorname{Tr}(H^2).
\]

The factor of two is geometric, not an arbitrary probability convention. A
real orthonormal coordinate list for \(\mathcal H_n\) is

\[
d_i,
\qquad
\sqrt2\,x_{ij},
\qquad
\sqrt2\,y_{ij}
\quad(i\lt j).
\]

There are \(n\) diagonal coordinates and two real coordinates for each of the
\(n(n-1)/2\) strict-upper positions, for a total real dimension

\[
n+2\frac{n(n-1)}2=n^2.
\]

{{< reference-figure
  src="hermitian-frobenius-geometry.svg"
  alt="An ambient complex matrix has Frobenius squared norm equal to the sum over all entries. In the Hermitian real subspace, each upper coordinate has a conjugate reflected lower entry, producing weight two. The coordinates d i, square root of two x i j, and square root of two y i j are orthonormal, and unitary congruence preserves the geometry."
  caption="**Finding:** the same reflected entry that enforces Hermiticity also creates the metric factor of two. Once upper real and imaginary coordinates are multiplied by \(\sqrt2\), the free-coordinate ledger becomes an orthonormal real coordinate system. This identity explains the scaling needed to compare a coordinate Gaussian law with an intrinsic Euclidean Gaussian; that comparison itself is reserved for RMT-08."
>}}

## Unitary congruence is an isometry

For a fixed unitary matrix \(U\), define congruence by

\[
C_U(X)=UXU^*.
\]

It is complex linear on the ambient space. Unitarity gives
\(U^*U=UU^*=I\), and cyclicity of the
{{< refterm "matrix-trace" "matrix trace" >}} gives

\[
\begin{aligned}
\langle C_U(X),C_U(Y)\rangle_F
&=\operatorname{Tr}\!\left((UXU^*)^*(UYU^*)\right)\\
&=\operatorname{Tr}\!\left(U X^*Y U^*\right)\\
&=\operatorname{Tr}(X^*Y).
\end{aligned}
\]

Thus congruence is a complex linear isometry of \(\mathcal F_n\). It also
preserves the Hermitian condition:

\[
(UHU^*)^*=UH^*U^*=UHU^*.
\]

After restriction to \(\mathcal H_n\), the same action becomes a real linear
isometry. The module packages both levels: an ambient complex linear isometric
equivalence and an intrinsic real linear isometric equivalence.

## The intrinsic standard Gaussian

On any finite-dimensional real inner-product space \(E\), Mathlib's
<code>stdGaussian E</code> is the probability measure whose coordinates in an
orthonormal basis are independent centered real Gaussians of variance one.
The construction is intrinsic: changing the orthonormal basis does not change
the measure.

If \(f:E\simeq E\) is a real linear isometric equivalence, Mathlib proves

\[
f_*\,\gamma_E=\gamma_E,
\qquad \gamma_E=\operatorname{stdGaussian}(E).
\]

Applying that theorem to the restricted unitary congruence gives the checked
RMT-07 symmetry statement

\[
(C_U)_*\operatorname{stdGaussian}(\mathcal H_n)
=\operatorname{stdGaussian}(\mathcal H_n).
\]

This is a genuine measure equality, not merely a pointwise norm identity. It
is also an **intrinsic standard-Gaussian theorem**, not yet the unitary
invariance of the coordinate-built Gaussian unitary ensemble (GUE) matrix
law.

## Why the existing coordinate scale fits this geometry

The earlier GUE coordinate construction uses one scale \(s_n\): diagonal
coordinates have variance \(s_n\), while the real and imaginary parts of an
upper entry each have variance \(s_n/2\). In the orthonormal real coordinates
above,

\[
\operatorname{Var}(\sqrt2\,x_{ij})
=\operatorname{Var}(\sqrt2\,y_{ij})
=2\frac{s_n}{2}=s_n.
\]

Every orthonormal coordinate therefore has the same variance \(s_n\). This
calculation predicts that the coordinate-built law should equal the intrinsic
standard Gaussian scaled by \(\sqrt{s_n}\), after both are transported into a
common space.

RMT-07 does **not** prove that comparison. RMT-08 must construct the relevant
real-linear coordinate isometry, identify the two measures, and then transport
the intrinsic symmetry theorem to the actual <code>GUE.matrixLaw n</code>.
Until that bridge is checked, it would be incorrect to cite intrinsic
<code>stdGaussian</code> invariance as a proof that the coordinate-built matrix
law is unitarily invariant.

The subsequent RMT-08 module now discharges that obligation. It introduces
{{< refterm "normalized-hermitian-coordinates" "normalized Hermitian coordinates" >}},
proves the full product-measure comparison, and transports the intrinsic
symmetry to <code>GUE.matrixLaw</code>. The paragraph above remains the exact
boundary of RMT-07 itself.

## Support is a separate statement

RMT-07 also defines the measurable subset

\[
\operatorname{Herm}_n
=\{H:H=H^*\}
\]

inside ordinary complex matrix space. It proves that the existing GUE matrix
law assigns this set mass one, that a sampled matrix is Hermitian almost
everywhere, and that the complement has mass zero.

This is {{< refterm "almost-everywhere" "almost-everywhere" >}} support. It
follows because the law is a pushforward through an assembly map whose every
output is Hermitian. It does not identify a density on \(\mathcal H_n\), and
it does not imply {{< refterm "unitary-invariance" "unitary invariance" >}}.

## Checked boundary

The geometry module checks the following layers:

- equivalent packaging of finite matrices as a complex Euclidean space;
- the trace formula for the ambient Frobenius inner product;
- the Hermitian matrices as a finite-dimensional real Euclidean subspace;
- ambient and Hermitian unitary-congruence equivalences;
- preservation of the inner product and norm;
- invariance of the intrinsic Hermitian standard Gaussian;
- measurability of the ambient Hermitian set; and
- mass-one, almost-everywhere, and zero-complement support for the existing
  coordinate-built matrix law.

It does not check a coordinate-to-intrinsic Gaussian equivalence, invariance of
<code>GUE.matrixLaw</code>, a density or Jacobian formula, eigenvalues, moments,
spectral statistics, a semicircle limit, or universality.

RMT-08 now checks the first two omitted items. The density, spectral, moment,
and asymptotic items remain outside the project boundary.

## Where to continue

[Intrinsic Hermitian Gaussian Symmetry and Matrix-Law Support]({{< relref "/knowledge-base/deep-dives/intrinsic-hermitian-gaussian-symmetry-and-matrix-law-support" >}})
derives the geometry, separates the two checked theorem paths, and audits every
RMT-07 declaration.
[From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance]({{< relref "/knowledge-base/deep-dives/normalized-hermitian-coordinates-to-gue-invariance" >}})
continues through the exact comparison and ambient invariance theorem. The
{{< refterm "gaussian-unitary-ensemble" "Gaussian unitary ensemble" >}}
entry records the coordinate variance ledger, while
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}})
constructs that law. Read
{{< refterm "unitary-invariance" "unitary invariance" >}} for the distinction
between preserving Hermiticity, preserving observables, and preserving a full
probability law.

## References

**Mathlib contributors.**
[Multivariate Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Multivariate.html),
[Pi-L2 Euclidean spaces](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/InnerProductSpace/PiL2.html),
[unitary matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/UnitaryGroup.html),
and
[Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html),
Mathlib 4 documentation. The multivariate Gaussian API defines
<code>stdGaussian</code> by independent standard coordinates in an orthonormal
basis and proves its transport under real linear isometric equivalences.

**Alice Guionnet.**
[Rare Events in Random Matrix Theory](https://ems.press/content/book-chapter-files/33150),
in *Proceedings of the International Congress of Mathematicians 2022*, volume
2, European Mathematical Society Press, 2022,
[doi:10.4171/ICM2022/174](https://doi.org/10.4171/ICM2022/174),
pp. 1008-1052. Section 1.1.1 records the classical GUE variances, invariant
density, and unitary-conjugation symmetry. This page uses that source for
context and does not promote its unformalized density statement into a checked
Lean result.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
