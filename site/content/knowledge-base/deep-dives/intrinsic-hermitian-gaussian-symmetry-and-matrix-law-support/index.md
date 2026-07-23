---
title: "Intrinsic Hermitian Gaussian Symmetry and Matrix-Law Support"
slug: "intrinsic-hermitian-gaussian-symmetry-and-matrix-law-support"
date: 2026-07-21
summary: "An exact two-by-two congruence calculation grows into intrinsic Hermitian Euclidean geometry, Gaussian isometry symmetry, and the precise difference between Hermitian support and invariance of a matrix law."
lead: "Swap the coordinates of one concrete Hermitian matrix, verify every invariant by hand, then learn why a changed sample can coexist with an unchanged probability law."
draft: false
pro_reviewed: false
level: "Finite matrix probability through Euclidean Gaussian symmetry"
reading_time: "80 to 105 minutes"
prerequisites: "Complex conjugation and two-by-two matrix multiplication; Hermitian matrices, probability laws, support, Euclidean geometry, and Gaussianity are introduced or linked when needed"
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleGeometry"
toc: true
og_image: "intrinsic-hermitian-gaussian-symmetry-card.png"
og_image_alt: "A two-by-two Hermitian matrix reconstructed from coordinates changes under coordinate-swap congruence, while Hermiticity, trace four, and squared Frobenius norm twenty remain unchanged."
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
received the required human and Pro reviews. The page is publicly available as
an open working note while those reviews remain pending.
{{< /panel >}}

## Base camp: one matrix you can audit entry by entry

Start with four real coordinates:

\[
d_0=1,\qquad d_1=3,\qquad x=1,\qquad y=2.
\]

The two diagonal coordinates are real. The complex strict-upper coordinate is

\[
z=x+iy=1+2i.
\]

The {{< refterm "hermitian-matrix" "Hermitian" >}} reconstruction reflects
that entry across the diagonal and takes its complex conjugate:

\[
H=
\begin{bmatrix}
1 & 1+2i\\
1-2i & 3
\end{bmatrix}.
\]

The {{< refterm "conjugate-transpose" "conjugate transpose" >}} \(H^*\)
transposes the entries and conjugates each one. The diagonal entries remain
\(1\) and \(3\), and

\[
\overline{1+2i}=1-2i.
\]

Therefore \(H^*=H\). That equality is the definition of Hermiticity.

### Act by a concrete unitary permutation

Let

\[
P=
\begin{bmatrix}
0&1\\
1&0
\end{bmatrix}.
\]

The matrix \(P\) swaps the two coordinate axes. It is real and symmetric, so
\(P^*=P\), and direct multiplication gives

\[
P^*P=P^2=
\begin{bmatrix}
1&0\\
0&1
\end{bmatrix}.
\]

A matrix satisfying \(P^*P=PP^*=I\) is **unitary**. Its **congruence action**
on a matrix \(X\) is the two-sided map

\[
C_P(X)=PXP^*.
\]

Multiply the running example in two visible steps:

\[
PH=
\begin{bmatrix}
1-2i&3\\
1&1+2i
\end{bmatrix},
\qquad
H'=PHP^*=
\begin{bmatrix}
3&1-2i\\
1+2i&1
\end{bmatrix}.
\]

The sample changed: \(H'\ne H\), already because the upper-left entries are
\(3\) and \(1\). But \(H'\) is still Hermitian because its lower-left entry is
the conjugate of its upper-right entry.

### Verify trace and Frobenius geometry numerically

The {{< refterm "matrix-trace" "trace" >}} is the sum of diagonal entries:

\[
\operatorname{Tr}(H)=1+3=4,
\qquad
\operatorname{Tr}(H')=3+1=4.
\]

The squared {{< refterm "hermitian-frobenius-geometry" "Frobenius norm" >}}
is the sum of squared entry magnitudes. Because

\[
|1+2i|^2=|1-2i|^2=1^2+2^2=5,
\]

we obtain

\[
\begin{aligned}
\lVert H\rVert_F^2&=1+5+5+9=20,\\
\lVert H'\rVert_F^2&=9+5+5+1=20.
\end{aligned}
\]

The intrinsic real coordinate vectors make the same norm visible:

\[
q=(1,3,\sqrt2,2\sqrt2),
\qquad
q'=(3,1,\sqrt2,-2\sqrt2).
\]

Both have squared Euclidean norm

\[
1^2+3^2+(\sqrt2)^2+(2\sqrt2)^2=1+9+2+8=20.
\]

{{< reference-figure
  wide="true"
  src="two-by-two-hermitian-congruence-ledger.svg"
  alt="Coordinates one, three, and one plus two i reconstruct a Hermitian matrix; coordinate-swap congruence produces a different Hermitian matrix while both traces remain four and both squared Frobenius norms remain twenty."
  caption="**Finding:** the exact coordinates \(d_0=1,d_1=3,z=1+2i\) reconstruct \(H\). Congruence by the coordinate-swap permutation produces the distinct matrix \(H'\), with top-left entry \(3\) instead of \(1\). Both matrices remain Hermitian, both have trace \(4\), and both have squared Frobenius norm \(20\). The intrinsic vectors \(q=(1,3,\sqrt2,2\sqrt2)\) and \(q'=(3,1,\sqrt2,-2\sqrt2)\) expose the same norm preservation. These are exact toy values, not Gaussian samples."
>}}

## Pointwise change is not law change

A {{< refterm "probability-law" "probability law" >}} assigns probability
mass to measurable sets of possible matrices. If \(T=C_P\) is the congruence
map, law invariance means the exact {{< refterm "pushforward-measure"
"pushforward" >}} equality

\[
T_*\mu=\mu.
\]

This does **not** say \(T(H)=H\) for every sample. The running example proves
the opposite: \(T(H)=H'\ne H\). An invariant law may redistribute individual
points while leaving the total probability of every measurable event
unchanged.

### Support alone does not imply invariance

The **support claim used in this chapter** is the mass-one statement that a law
assigns probability \(1\) to the measurable Hermitian subset of ambient matrix
space. It says where the law lives, not how its mass is arranged there.

Consider the deterministic Dirac law \(\delta_H\), which places all mass on the
single matrix \(H\). It has Hermitian mass one. Yet

\[
T_*\delta_H=\delta_{H'}\ne\delta_H.
\]

For the measurable event \(\{H\}\), the original law gives mass \(1\), while
the pushed law gives mass \(0\). A singleton is closed, hence Borel-measurable,
in this finite-dimensional matrix space. Hermitian support has survived, but
invariance has failed.

For comparison, take the balanced two-point law

\[
\mu_{\mathrm{pair}}=\frac12\delta_H+\frac12\delta_{H'}.
\]

Because applying \(T\) swaps \(H\) and \(H'\), the two weights are exchanged:

\[
T_*\mu_{\mathrm{pair}}
=\frac12\delta_{H'}+\frac12\delta_H
=\mu_{\mathrm{pair}}.
\]

Every sampled point moves, but this law is unchanged under this one
permutation. The balanced two-point law is not Gaussian and is not claimed to
be invariant under every unitary congruence.

{{< reference-figure
  wide="true"
  src="support-versus-swap-invariance.svg"
  alt="A Dirac law with weights one and zero on two Hermitian matrices becomes weights zero and one after permutation and is not invariant, while balanced half weights remain unchanged even though the two matrices swap."
  caption="**Finding:** both toy laws assign total mass \(1\) to Hermitian matrices. The Dirac weights \((1,0)\) become \((0,1)\), so support does not imply invariance. Balanced weights \((1/2,1/2)\) remain \((1/2,1/2)\), even though every point is exchanged. This proves invariance only for the displayed permutation on this finite two-point law. It makes no Gaussian or all-unitary claim."
>}}

With the sample-versus-law distinction fixed numerically, we can climb to the
intrinsic Euclidean carrier and Mathlib's standard Gaussian.

The seventh random-matrix-theory milestone (RMT-07) supplies the geometry that
the name *Gaussian unitary ensemble* had been promising but that the earlier
coordinate construction had not proved. It equips finite complex matrices
with their Frobenius Euclidean structure, cuts out the Hermitian matrices as a
real Euclidean subspace, proves that unitary congruence acts by real linear
isometries there, and invokes Mathlib's isometry theorem to show that the
intrinsic standard Gaussian is unchanged by that action.

On a separate track, RMT-07 proves that the matrix law constructed from
independent Gaussian free coordinates assigns mass one to the measurable set
of Hermitian matrices. Equivalently, the matrix is Hermitian almost everywhere
and the non-Hermitian complement has mass zero.

Those are substantial results. They still do not prove that the
coordinate-built Gaussian unitary ensemble (GUE) matrix law is unitarily
invariant. That final implication needs a comparison theorem identifying the
coordinate law with a scaled intrinsic standard Gaussian. RMT-07 exposes the
two endpoints of that comparison and leaves the bridge to RMT-08.

{{< panel "info" >}}
**Subsequent milestone.** RMT-08 now builds that normalized-coordinate
isometry, proves the full product-measure equality, and transports the
intrinsic symmetry to the ambient matrix law. Continue to
[From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance]({{< relref "/knowledge-base/deep-dives/normalized-hermitian-coordinates-to-gue-invariance" >}}).
The remainder of this chapter preserves the exact boundary visible at RMT-07.
{{< /panel >}}

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [One auditable matrix](#base-camp-one-matrix-you-can-audit-entry-by-entry) | Reconstruct, conjugate, and verify the (n=2) ledger |
| Law route | [Pointwise change is not law change](#pointwise-change-is-not-law-change) | Separate Hermitian support from measure invariance |
| Geometry route | [Package matrices as Euclidean vectors](#camp-two-package-matrices-as-euclidean-vectors) | Recover the trace inner product and Frobenius norm |
| Factor-two route | [Read the Hermitian metric in free coordinates](#camp-four-read-the-hermitian-metric-in-free-coordinates) | Derive the square-root-of-two orthonormal rescaling |
| Symmetry route | [Unitary congruence in the ambient space](#camp-five-unitary-congruence-in-the-ambient-space) | Follow congruence to an intrinsic real isometry |
| Probability route | [The intrinsic standard Gaussian](#camp-seven-the-intrinsic-standard-gaussian) | Apply <code>stdGaussian_map</code> exactly |
| Support route | [Make the Hermitian locus measurable](#camp-one-make-the-hermitian-locus-measurable) | Prove mass one and almost-everywhere Hermiticity |
| Lean route | [The checked declaration map](#the-checked-declaration-map) | Audit all 27 public declarations |
| Next-milestone route | [The exact RMT-08 bridge](#camp-eight-the-exact-rmt-08-bridge) | Identify what remains before GUE invariance |

### Learning objectives

By the summit, you should be able to:

1. reconstruct the running \(2\times2\) Hermitian matrix from its free
   coordinates and compute its permutation congruence;
2. verify Hermiticity, trace (4), squared Frobenius norm (20), and
   pointwise change in that exact example;
3. distinguish a moved sample from an invariant probability law;
4. use the Dirac nonexample to show why Hermitian support does not imply
   invariance;
5. distinguish an ambient matrix, an ambient Frobenius vector, an intrinsic
   Hermitian vector, and the Hermitian subset of matrix space;
6. explain why Hermitian matrices form a real rather than complex subspace;
7. derive \(\langle X,Y\rangle_F=\operatorname{Tr}(X^*Y)\);
8. derive the factor of two in the Hermitian Frobenius norm;
9. identify \(d_i,\sqrt2 x_{ij},\sqrt2 y_{ij}\) as the natural real
   orthonormal coordinates;
10. prove on paper that \(X\mapsto UXU^*\) has inverse
   \(X\mapsto U^*XU\) when \(U\) is unitary;
11. explain why cyclicity of trace turns that equivalence into an isometry;
12. explain why congruence restricts to the Hermitian subspace;
13. state Mathlib's intrinsic standard-Gaussian isometry theorem;
14. separate intrinsic Gaussian invariance from invariance of an independently
    constructed coordinate law;
15. prove that a pushforward through a pointwise Hermitian map has Hermitian
    support; and
16. state the scaled-measure comparison that was still required at the RMT-07
    stopping point and is proved in RMT-08.

## Two paths and the bridge missing at RMT-07

{{< reference-figure
  src="hermitian-gaussian-symmetry.svg"
  alt="At the RMT-07 stopping point, the upper checked path sends the RMT-06 independent Gaussian coordinate law through measurable Hermitian assembly and proves the resulting ambient matrix law has Hermitian support. The lower checked path equips matrices with Frobenius geometry, restricts unitary congruence to a real isometry of the Hermitian subspace, and proves intrinsic standard Gaussian invariance. Dashed arrows mark the comparison bridge absent from the RMT-07 module; the subsequent RMT-08 milestone now checks that bridge."
  caption="**Finding:** within the RMT-07 module, support of the existing matrix law and symmetry of an intrinsic Hermitian Gaussian are proved for different measures presented on different spaces. The dashed comparison (coordinate-built GUE equals a scaled intrinsic Gaussian after the relevant transport) records the precise obligation that was missing at this stopping point and is now discharged by RMT-08. No density or Jacobian argument is smuggled across the historical module boundary."
>}}

The upper path begins with the RMT-06 coordinate probability measure
\(\nu_n\), pushes it through the measurable Hermitian assembly map \(A_n\),
and obtains the ambient matrix law

\[
\mu_n=(A_n)_*\nu_n.
\]

Because \(A_n(c)\) is Hermitian for every coordinate point \(c\), the
preimage of the Hermitian set is the entire coordinate space. That yields
\(\mu_n(\operatorname{Herm}_n)=1\).

The lower path begins with the intrinsic real Euclidean space
\(\mathcal H_n\) of Hermitian matrices. Unitary congruence acts on this space
by a real linear isometry. Mathlib's intrinsic standard Gaussian
\(\gamma_n\) is invariant under every such isometry, so

\[
(C_U)_*\gamma_n=\gamma_n.
\]

The RMT-07 module does not prove \(\mu_n=\gamma_n\), and the equality would in any case
miss the Wigner scale. The expected statement uses the scalar
\(\sqrt{s_n}\), where \(s_n\) is the RMT-06 variance scale, plus the map that
forgets the intrinsic Hermitian subtype and returns an ordinary matrix.

{{< checkpoint stage="Orientation" title="Do not join the paths early" >}}
Support says where \(\mu_n\) lives. Intrinsic symmetry says what unitary
isometries do to \(\gamma_n\). Neither statement identifies \(\mu_n\) with
\(\gamma_n\). At the RMT-07 stopping point, that comparison was still required
before the project could claim unitary invariance of
<code>GUE.matrixLaw</code>; RMT-08 now provides it.
{{< /checkpoint >}}

## Base camp: four related spaces

Fix \(n\in\mathbb N\). RMT-07 moves among four closely related objects.

The first is ordinary matrix space

\[
\mathcal M_n
=\operatorname{Matrix}(\operatorname{Fin}(n),
  \operatorname{Fin}(n),\mathbb C).
\]

This is the codomain of the existing matrix law. It is ideal for multiplication,
conjugate transpose, entry evaluation, and measurable subsets.

The second is the finite complex Euclidean space

\[
\mathcal F_n
=\operatorname{EuclideanSpace}
  (\mathbb C,\operatorname{Fin}(n)\times\operatorname{Fin}(n)).
\]

It contains the same \(n^2\) complex entries but carries bundled inner-product
and finite-dimensional structures useful to Mathlib's geometry APIs.

The third is the intrinsic Hermitian Euclidean space

\[
\mathcal H_n=\{x\in\mathcal F_n:X=X^*\}.
\]

It is a subtype of \(\mathcal F_n\), bundled as a submodule over
\(\mathbb R\). Its points carry their proof of Hermiticity with them.

The fourth is the ambient Hermitian set

\[
\operatorname{Herm}_n=\{H\in\mathcal M_n:H=H^*\}.
\]

It is not a new data type. It is a measurable set used to ask how much mass an
ambient matrix measure assigns to Hermitian matrices.

| Object | Carries Hermiticity? | Carries Euclidean structure? | RMT-07 use |
|---|---:|---:|---|
| \(\mathcal M_n\) | No | Not through this presentation | Codomain of <code>matrixLaw</code> |
| \(\mathcal F_n\) | No | Complex | Prove trace geometry and ambient isometry |
| \(\mathcal H_n\) | Yes, in the subtype | Real | Define intrinsic Gaussian and restricted unitary isometry |
| \(\operatorname{Herm}_n\subseteq\mathcal M_n\) | As membership | Not needed | State support measurably |

The conversions between them are simple, but keeping the roles distinct
prevents type-correct but mathematically misleading claims.

## Camp one: make the Hermitian locus measurable

The condition \(H=H^*\) can be checked entry by entry:

\[
\overline{H_{ji}}=H_{ij}
\qquad\text{for every }i,j.
\]

Therefore the Hermitian set is the finite intersection

\[
\operatorname{Herm}_n
=\bigcap_i\bigcap_j
\{H:\overline{H_{ji}}=H_{ij}\}.
\]

Each matrix-entry projection is measurable, complex conjugation is continuous
and hence measurable, and the equality set of two measurable functions into
\(\mathbb C\) is measurable. Finite intersections preserve measurability.
That is the complete reason the subset is measurable; no eigenvalue map or
density is needed.

The prior module defines the matrix law as a
{{< refterm "pushforward-measure" "pushforward" >}}:

\[
\mu_n=(A_n)_*\nu_n,
\]

where \(A_n\) assembles real diagonal coordinates and complex strict-upper
coordinates into a Hermitian matrix. For the measurable set
\(\operatorname{Herm}_n\), pushforward evaluation gives

\[
\begin{aligned}
\mu_n(\operatorname{Herm}_n)
&=\nu_n(A_n^{-1}(\operatorname{Herm}_n))\\
&=\nu_n(\mathcal C_n)\\
&=1.
\end{aligned}
\]

The middle equality uses the pointwise RMT-05 theorem that every assembled
matrix is Hermitian. The final equality uses the RMT-06 probability instance
for \(\nu_n\).

Three theorem interfaces expose the same support fact in useful forms:

\[
\mu_n(\operatorname{Herm}_n)=1,
\qquad
H\text{ is Hermitian for }\mu_n\text{-almost every }H,
\qquad
\mu_n(\operatorname{Herm}_n^c)=0.
\]

Mass one is convenient for direct measure calculations. The
{{< refterm "almost-everywhere" "almost-everywhere" >}} form composes with
facts stated using the almost-everywhere filter. Complement mass zero is often
the cleanest support-language interface. They are logically close, but naming
all three avoids reproving conversions downstream.

{{< checkpoint stage="Camp one" title="Support is not symmetry" >}}
The Hermitian set is preserved by unitary congruence, but assigning that set
mass one does not determine how mass is arranged inside it. A point mass at a
noncentral Hermitian matrix has Hermitian support and usually fails unitary
invariance.
{{< /checkpoint >}}

## Camp two: package matrices as Euclidean vectors

Mathlib's <code>EuclideanSpace 𝕜 ι</code> is an \(L^2\)-packaged finite
function space. RMT-07 abbreviates

~~~lean
abbrev FrobeniusMatrix (n : ℕ) :=
  EuclideanSpace ℂ (Fin n × Fin n)
~~~

and defines entry-preserving maps in both directions:

~~~lean
def frobeniusToMatrix (x : FrobeniusMatrix n) :
    Matrix (Fin n) (Fin n) ℂ :=
  fun i j => x (i, j)

def matrixToFrobenius (A : Matrix (Fin n) (Fin n) ℂ) :
    FrobeniusMatrix n :=
  WithLp.toLp 2 (fun ij => A ij.1 ij.2)
~~~

The apparent asymmetry comes only from the \(L^2\) wrapper. Both composites
reduce to the identity, and <code>frobeniusMatrixLinearEquiv</code> packages
the conversions as a complex linear equivalence.

Why not work only with ordinary matrices? The ordinary matrix type is already
a module, but the Euclidean-space presentation gives direct access to the
canonical finite \(L^2\) inner product, its induced norm, finite-dimensional
real and complex structure, Borel measurability, and the multivariate Gaussian
API. The conversion lemmas let proofs cross back into matrix algebra whenever
trace or multiplication is the natural language.

## Camp three: recover the trace inner product

For \(x,y\in\mathcal F_n\), let \(X,Y\in\mathcal M_n\) be their matrix
representatives. The Euclidean inner product expands as

\[
\langle x,y\rangle_{\mathbb C}
=\sum_{i,j}\overline{X_{ij}}Y_{ij}.
\]

Matrix multiplication gives

\[
(X^*Y)_{ii}
=\sum_j (X^*)_{ij}Y_{ji}
=\sum_j\overline{X_{ji}}Y_{ji}.
\]

Summing the diagonal and exchanging the finite summation order yields

\[
\operatorname{Tr}(X^*Y)
=\sum_i\sum_j\overline{X_{ji}}Y_{ji}
=\sum_{i,j}\overline{X_{ij}}Y_{ij}.
\]

Hence

\[
\boxed{\langle x,y\rangle_{\mathbb C}=\operatorname{Tr}(X^*Y)}.
\]

This identity is the hinge between Euclidean analysis and matrix algebra. It
lets the congruence proof use unitary identities and cyclicity of trace, then
return an exact inner-product equality to the Euclidean API.

Setting \(x=y\) gives the Frobenius norm:

\[
\lVert X\rVert_F^2
=\operatorname{Tr}(X^*X)
=\sum_{i,j}|X_{ij}|^2.
\]

The checked theorem is stated over the complex inner product. On the Hermitian
subspace, Lean uses the inherited **real** inner product. The general identity
between the two views is that the real inner product is the real part of the
complex one.

## Camp four: read the Hermitian metric in free coordinates

Write a Hermitian matrix in free real coordinates:

\[
H_{ii}=d_i\in\mathbb R,
\qquad
H_{ij}=x_{ij}+iy_{ij}\quad(i\lt j),
\qquad
H_{ji}=x_{ij}-iy_{ij}.
\]

Then

\[
\begin{aligned}
\lVert H\rVert_F^2
&=\sum_i d_i^2
 +\sum_{i\lt j}|x_{ij}+iy_{ij}|^2
 +\sum_{i\lt j}|x_{ij}-iy_{ij}|^2\\
&=\sum_i d_i^2
 +2\sum_{i\lt j}(x_{ij}^2+y_{ij}^2).
\end{aligned}
\]

The free coordinate list

\[
(d_i,x_{ij},y_{ij})
\]

is therefore not orthonormal with its naive coordinate metric. The orthonormal
list is

\[
(d_i,\sqrt2\,x_{ij},\sqrt2\,y_{ij}).
\]

This explains the exact RMT-06 variance ledger. There the diagonal variables
have variance \(s_n\), while each upper real component has variance
\(s_n/2\). Under the orthonormal rescaling,

\[
\operatorname{Var}(d_i)=s_n,
\quad
\operatorname{Var}(\sqrt2 x_{ij})=s_n,
\quad
\operatorname{Var}(\sqrt2 y_{ij})=s_n.
\]

Thus every intrinsic orthonormal coordinate has common variance \(s_n\).
This calculation is the blueprint for RMT-08. It is not itself a measure
equality: a formal comparison still needs a bundled measurable real-linear
isometry and a proof that the full joint product law transports as claimed.

### A two-by-two calculation

For

\[
H=\begin{bmatrix}
a&x+iy\\
x-iy&b
\end{bmatrix},
\]

directly summing squared magnitudes gives

\[
\lVert H\rVert_F^2
=a^2+b^2+2x^2+2y^2.
\]

The real dimension is four, with orthonormal coordinates
\((a,b,\sqrt2x,\sqrt2y)\). A standard Gaussian in this Euclidean structure
therefore has \(a,b\sim N(0,1)\) and
\(x,y\sim N(0,1/2)\) in the displayed entry coordinates. Scaling the entire
Euclidean vector by \(\sqrt{s_n}\) changes these variances to \(s_n\) and
\(s_n/2\), exactly as required.

## Camp five: unitary congruence in the ambient space

For fixed \(U\in\mathcal M_n\), define

\[
C_U(X)=UXU^*.
\]

On ambient matrix space this is complex linear. If \(U\) is unitary, then
\(U^*U=UU^*=I\), so

\[
C_{U^*}(C_U(X))
=U^*(UXU^*)U=X,
\]

and similarly \(C_U(C_{U^*}(X))=X\). Thus \(C_U\) is a complex linear
equivalence with inverse \(C_{U^*}\).

To show it is an isometry, use the trace inner product:

\[
\begin{aligned}
\langle C_U(X),C_U(Y)\rangle_F
&=\operatorname{Tr}\!\left((UXU^*)^*(UYU^*)\right)\\
&=\operatorname{Tr}\!\left(UX^*U^*UYU^*\right)\\
&=\operatorname{Tr}\!\left(UX^*YU^*\right)\\
&=\operatorname{Tr}\!\left(U^*UX^*Y\right)\\
&=\operatorname{Tr}(X^*Y).
\end{aligned}
\]

The fourth line is cyclicity of finite matrix trace. The Lean proof follows
this calculation rather than expanding four matrix products entry by entry.
The result is first a theorem about inner products and then a bundled complex
linear isometric equivalence.

Notice the hierarchy:

1. <code>frobeniusCongruence U</code> is defined for every square matrix
   \(U\);
2. invertibility uses the bundled unitary hypotheses;
3. inner-product preservation uses unitarity and trace cyclicity; and
4. the linear isometry is bundled only after those proofs exist.

This keeps algebraic definitions general while attaching stronger structure
only under the assumptions that justify it.

## Camp six: restrict the action to Hermitian space

If \(H=H^*\), then

\[
(UHU^*)^*=UH^*U^*=UHU^*.
\]

So congruence maps the Hermitian subspace into itself even when \(U\) is not
unitary. The project packages this restricted function as
<code>hermitianCongruence U</code> and proves two compatibility lemmas:

- forgetting the Hermitian subtype gives the ambient Frobenius congruence; and
- converting to an ordinary matrix gives the project's pre-existing
  <code>RandomMatrix.congruence U</code>.

For unitary \(U\), the restricted action is an equivalence. Its scalar field
is \(\mathbb R\), because the Hermitian subspace is closed only under real
scalars. The ambient complex isometry supplies the norm equality needed to
bundle the restriction as

\[
C_U:\mathcal H_n\simeq_{\mathbb R}^{\mathrm{iso}}\mathcal H_n.
\]

This is the exact object accepted by Mathlib's multivariate standard-Gaussian
transport theorem.

{{< checkpoint stage="Camp six" title="The scalar field changes at the boundary" >}}
Ambient congruence is complex linear on all matrices. Restricted congruence is
real linear on Hermitian matrices. Calling the latter complex linear would
assert closure under multiplication by \(i\), which is false in general.
{{< /checkpoint >}}

## Camp seven: the intrinsic standard Gaussian

Let \(E\) be a finite-dimensional real inner-product space. Mathlib defines
<code>stdGaussian E</code> by choosing an orthonormal basis, taking independent
standard real Gaussian coordinates, and transporting that product measure
through the basis equivalence. The resulting measure is independent of the
orthonormal basis used to construct it.

Its characteristic function is the coordinate-free expression

\[
\widehat\gamma_E(t)=\exp\!\left(-\frac12\lVert t\rVert^2\right),
\]

and its covariance form is the real inner product. These facts explain the
name *standard* and the rotational symmetry, although RMT-07 does not need to
reprove either formula.

Mathlib's theorem <code>stdGaussian_map</code> says that for a real linear
isometric equivalence \(f:E\simeq E'\),

\[
f_*\operatorname{stdGaussian}(E)
=\operatorname{stdGaussian}(E').
\]

Take \(E=E'=\mathcal H_n\) and let \(f=C_U\), the restricted unitary
congruence isometry. RMT-07 obtains

\[
\boxed{
(C_U)_*\operatorname{stdGaussian}(\mathcal H_n)
=\operatorname{stdGaussian}(\mathcal H_n)}.
\]

This theorem is valid for every natural dimension, including \(n=0\). At zero
dimension the Euclidean space has one point, so the intrinsic standard
Gaussian is necessarily concentrated there. The module's named theorem is the
uniform isometry-invariance statement; it does not add a separate zero-size
Dirac theorem for this intrinsic measure.

### A Lean engineering note

The final proof installs a local canonical \(\mathbb R\)-module instance for
the Hermitian subtype before applying <code>stdGaussian_map</code>. This
resolves a definitional-instance mismatch between the inherited inner-product
structure and the module structure expected by the theorem. It changes no
mathematics: the map remains the same real linear isometry, and the conclusion
remains exact equality of measures.

## Camp eight: the bridge absent from RMT-07

Let \(s_n\) be the RMT-06 variance scale: \(s_0=0\) and \(s_n=1/n\) for
positive \(n\). Let

\[
S_n(H)=\sqrt{s_n}\,H
\]

on \(\mathcal H_n\), and let
\(J_n:\mathcal H_n\to\mathcal M_n\) forget the subtype and Euclidean
packaging. At the RMT-07 stopping point, the required comparison had the
schematic form

\[
\boxed{
\mu_n=(J_n)_*\bigl((S_n)_*\operatorname{stdGaussian}(\mathcal H_n)\bigr)}.
\]

Several Lean interfaces could express that equality: first on coordinate
space, first on \(\mathcal H_n\), or directly in ambient matrix space. The
invariant mathematical content is the same: the diagonal and the
square-root-of-two-rescaled upper coordinates must become independent centered
Gaussians of common variance \(s_n\). RMT-08 subsequently chooses and checks a
normalized-coordinate route; its linked chapter audits that later module.

Once this equality is checked, unitary invariance of \(\mu_n\) follows because
scalar multiplication commutes with unitary congruence and the intrinsic
standard Gaussian is invariant. Schematically,

\[
\begin{aligned}
(C_U)_*\mu_n
&=(C_U)_*(J_n)_*(S_n)_*\gamma_n\\
&=(J_n)_*(S_n)_*(C_U)_*\gamma_n\\
&=(J_n)_*(S_n)_*\gamma_n\\
&=\mu_n.
\end{aligned}
\]

Every equality in that chain needs the relevant measurable-map composition or
commutation lemma. RMT-07 supplies the third equality but not the first
comparison, so the full chain is not a theorem of the RMT-07 module. The
subsequent RMT-08 module checks the missing comparison and transport.

### What the next milestone had to make visible

A trustworthy comparison should make all of the following visible:

1. the real-linear map from free coordinate data to the Hermitian Euclidean
   subtype;
2. its effect on diagonal, upper-real, and upper-imaginary coordinates;
3. the square-root-of-two metric correction for upper coordinates;
4. the common \(\sqrt{s_n}\) scale;
5. measurability or continuity of every transport;
6. the zero-dimensional branch; and
7. the final equality in the same ambient matrix space used by
   <code>GUE.matrixLaw</code>.

Invoking a familiar density is not a substitute. A density would require a
chosen Lebesgue measure on \(\mathcal H_n\), a volume normalization, and a
Jacobian calculation. The coordinate-to-intrinsic product-measure route can
prove the comparison without introducing that extra layer.

## In Lean: six bridges from entries to measure equality

Each bridge pairs a sentence a mathematician would say, the paper statement,
the exact Lean spelling, and a token map. Together they separate representation,
geometry, subtype preservation, measurability, Gaussian symmetry, and support.

### Bridge 1: flattening does not change an entry

{{< lean-bridge
  human="Package an ordinary matrix as a Frobenius vector and immediately restore it; the original matrix returns exactly."
  math="\(F^{-1}(F(A))=A.\)"
  lean="frobeniusToMatrix (matrixToFrobenius A) = A"
>}}

- <code>matrixToFrobenius A</code> stores the \(n^2\) entries in Mathlib's
  finite \(L^2\) Euclidean carrier.
- <code>frobeniusToMatrix</code> reads those entries back as an ordinary square
  matrix.
- The checked theorem
  <code>frobeniusToMatrix_matrixToFrobenius</code> proves the equality by
  definitional reduction. It does not alter a probability law or impose
  Hermiticity.
{{< /lean-bridge >}}

### Bridge 2: the Euclidean inner product is a trace

{{< lean-bridge
  human="The Frobenius inner product of x and y equals the trace of the conjugate transpose of X times Y."
  math="\(\langle x,y\rangle_{\mathbb C}=\operatorname{Tr}(X^*Y).\)"
  lean="inner_frobenius_eq_trace x y"
>}}

- <code>inner ℂ x y</code> is the complex inner product on
  <code>FrobeniusMatrix n</code>.
- <code>frobeniusToMatrix x</code> and <code>frobeniusToMatrix y</code> are the
  ordinary matrices \(X\) and \(Y\).
- <code>ᴴ</code> is Lean's postfix conjugate-transpose notation.
- <code>Matrix.trace</code> sums the diagonal after matrix multiplication.
- The theorem is geometric algebra. It contains no Gaussian or support claim.
{{< /lean-bridge >}}

### Bridge 3: congruence stays inside the Hermitian carrier

{{< lean-bridge
  human="If x carries a proof of Hermiticity, then U x U star carries one too."
  math="\(H=H^*\Longrightarrow(UHU^*)^*=UHU^*.\)"
  lean="hermitianCongruence U x : HermitianEuclidean n"
>}}

- <code>x : HermitianEuclidean n</code> contains a Frobenius vector and a proof
  that its matrix is Hermitian.
- <code>hermitianCongruence U x</code> returns the same subtype, so its result
  includes the new Hermiticity proof.
- This constructor is defined for every square \(U\). Unitarity is needed only
  when the action is bundled as an invertible isometry.
- The compatibility theorem
  <code>hermitianToMatrix_hermitianCongruence</code> says forgetting the subtype
  exposes exactly the ambient map \(H\mapsto UHU^*\).
{{< /lean-bridge >}}

### Bridge 4: unitary congruence is a measurable real isometry

{{< lean-bridge
  human="For unitary U, congruence is an invertible real-linear isometry of intrinsic Hermitian space."
  math="\(C_U:\mathcal H_n\simeq_{\mathbb R}^{\mathrm{iso}}\mathcal H_n.\)"
  lean="hermitianUnitaryCongruenceLinearIsometryEquiv U"
>}}

- <code>U : Matrix.unitaryGroup (Fin n) ℂ</code> bundles both unitary
  identities.
- <code>≃ₗᵢ[ℝ]</code>, visible in the declaration's type, means a real-linear
  isometric equivalence.
- The scalar is \(\mathbb R\), not \(\mathbb C\), because multiplying a
  nonzero Hermitian matrix by \(i\) usually destroys Hermiticity.
- A linear isometry is continuous. On these finite-dimensional Borel spaces it
  is measurable, which is the transport interface used by the Gaussian map
  theorem. The module does not add a redundant standalone measurability theorem
  for this bundled map.
{{< /lean-bridge >}}

### Bridge 5: the intrinsic standard Gaussian law is invariant

{{< lean-bridge
  human="Push the intrinsic standard Gaussian through unitary congruence; the probability measure is unchanged."
  math="\((C_U)_*\gamma_n=\gamma_n.\)"
  lean="map_stdGaussian_hermitianUnitaryCongruence U"
>}}

The exact conclusion is:

~~~lean
(stdGaussian (HermitianEuclidean n)).map
    (hermitianUnitaryCongruenceLinearIsometryEquiv U) =
  stdGaussian (HermitianEuclidean n)
~~~

- <code>stdGaussian (HermitianEuclidean n)</code> is Mathlib's canonical
  Gaussian on the real inner-product carrier.
- <code>.map</code> is pushforward by the displayed isometry.
- Equality is equality of measures, not equality of individual matrices.
- This theorem concerns the intrinsic standard Gaussian. It is not, by itself,
  a theorem about <code>GUE.matrixLaw</code>; the subsequent RMT-08 module adds
  the required comparison and transport.
{{< /lean-bridge >}}

### Bridge 6: the ambient matrix law has Hermitian mass one

{{< lean-bridge
  human="The coordinate-built matrix law assigns probability one to the measurable set of Hermitian matrices."
  math="\(\mu_n(\operatorname{Herm}_n)=1.\)"
  lean="GUE.matrixLaw_hermitianSet n"
>}}

- <code>GUE.matrixLaw n</code> is a measure on all complex \(n\times n\)
  matrices.
- <code>RandomMatrix.hermitianSet n</code> is a measurable subset of that
  ambient type, not the intrinsic subtype.
- The companion theorem <code>GUE.matrixLaw_ae_isHermitian n</code> says the
  sampled ambient matrix is Hermitian almost everywhere.
- <code>GUE.matrixLaw_compl_hermitianSet n</code> gives complement mass zero.
- None of the three support forms specifies how mass is distributed inside the
  Hermitian set.
{{< /lean-bridge >}}

### Try it locally: execute the two-by-two ledger

The exact project matrix type belongs to Mathlib, so the laptop worksheet uses
a small pair of integers for each complex entry and four fields for a
two-by-two matrix. It checks the same multiplication and weight bookkeeping
without entering the project. Save this as
`/tmp/HermitianCongruenceTutorial.lean`:

~~~lean
import Std

namespace HermitianCongruenceTutorial

structure CInt where
  re : Int
  im : Int
  deriving DecidableEq, Repr

def cAdd (z w : CInt) : CInt :=
  ⟨z.re + w.re, z.im + w.im⟩

def cMul (z w : CInt) : CInt :=
  ⟨z.re * w.re - z.im * w.im,
   z.re * w.im + z.im * w.re⟩

def cConj (z : CInt) : CInt :=
  ⟨z.re, -z.im⟩

def normSq (z : CInt) : Int :=
  z.re * z.re + z.im * z.im

structure Matrix2 where
  a00 : CInt
  a01 : CInt
  a10 : CInt
  a11 : CInt
  deriving DecidableEq, Repr

def entries (A : Matrix2) : List (Int × Int) :=
  [⟨A.a00.re, A.a00.im⟩, ⟨A.a01.re, A.a01.im⟩,
   ⟨A.a10.re, A.a10.im⟩, ⟨A.a11.re, A.a11.im⟩]

def mmul (A B : Matrix2) : Matrix2 :=
  ⟨cAdd (cMul A.a00 B.a00) (cMul A.a01 B.a10),
   cAdd (cMul A.a00 B.a01) (cMul A.a01 B.a11),
   cAdd (cMul A.a10 B.a00) (cMul A.a11 B.a10),
   cAdd (cMul A.a10 B.a01) (cMul A.a11 B.a11)⟩

def conjTranspose (A : Matrix2) : Matrix2 :=
  ⟨cConj A.a00, cConj A.a10, cConj A.a01, cConj A.a11⟩

def congruence (U H : Matrix2) : Matrix2 :=
  mmul (mmul U H) (conjTranspose U)

def isHermitian (A : Matrix2) : Bool :=
  A.a00.im == 0 && A.a11.im == 0 && A.a10 == cConj A.a01

def trace (A : Matrix2) : CInt :=
  cAdd A.a00 A.a11

def frobeniusSq (A : Matrix2) : Int :=
  normSq A.a00 + normSq A.a01 + normSq A.a10 + normSq A.a11

def H : Matrix2 :=
  ⟨⟨1, 0⟩, ⟨1, 2⟩, ⟨1, -2⟩, ⟨3, 0⟩⟩

def P : Matrix2 :=
  ⟨⟨0, 0⟩, ⟨1, 0⟩, ⟨1, 0⟩, ⟨0, 0⟩⟩

def Hswap : Matrix2 :=
  congruence P H

def diracWeights : List Nat := [1, 0]
def balancedWeights : List Nat := [1, 1]
def pushBySwap (weights : List Nat) : List Nat := weights.reverse

#eval entries H
#eval entries Hswap
#eval (isHermitian H, isHermitian Hswap, H == Hswap)
#eval ((trace H).re, (trace Hswap).re)
#eval (frobeniusSq H, frobeniusSq Hswap)
#eval (diracWeights, pushBySwap diracWeights)
#eval (balancedWeights, pushBySwap balancedWeights)

example : entries Hswap = [(3, 0), (1, -2), (1, 2), (1, 0)] := by
  decide

example : isHermitian H = true ∧ isHermitian Hswap = true := by
  decide

example : trace H = trace Hswap := by
  decide

example : frobeniusSq H = 20 ∧ frobeniusSq Hswap = 20 := by
  decide

example : pushBySwap diracWeights ≠ diracWeights := by
  decide

example : pushBySwap balancedWeights = balancedWeights := by
  decide

end HermitianCongruenceTutorial
~~~

Type these commands on a normal macOS or Linux machine with Elan installed:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean /tmp/HermitianCongruenceTutorial.lean
~~~

**Standalone tutorial: Lean plus `Std`, suitable for a normal macOS or Linux
host.** It does not import Mathlib, enter the Lake project, or check the
repository module.

The file was executed with that exact command and printed:

~~~text
[(1, 0), (1, 2), (1, -2), (3, 0)]
[(3, 0), (1, -2), (1, 2), (1, 0)]
(true, true, false)
(4, 4)
(20, 20)
([1, 0], [0, 1])
([1, 1], [1, 1])
~~~

Read the output from top to bottom: the first two lines are the entries of
\(H\) and \(H'\) in row-major order; both Hermitian checks are true while
matrix equality is false; trace and squared Frobenius norm are preserved; the
Dirac weight vector changes under the swap; and equal half-weight numerators
remain unchanged. The balanced weights use denominator \(2\), so `[1, 1]`
means \((1/2,1/2)\).

The six `example` blocks are kernel-checked finite algebra. They do not prove
that `P` inhabits Mathlib's unitary group, construct a Borel measure, define an
intrinsic Gaussian, or verify the project theorem.

### Try it in the repository: inspect the exact module

{{< repo-check >}}
The authoritative source is
[<code>formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleGeometry.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleGeometry.lean).
After installing the repository's pinned dependencies, put this probe in a
temporary project scratch file:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleGeometry

open Matrix MeasureTheory ProbabilityTheory
open scoped Matrix RealInnerProductSpace
open NonlinearDynamics.Random

#check RandomMatrix.frobeniusToMatrix_matrixToFrobenius
#check RandomMatrix.frobeniusMatrixLinearEquiv
#check RandomMatrix.hermitianSubmodule
#check RandomMatrix.measurable_hermitianToMatrix
#check RandomMatrix.inner_frobenius_eq_trace
#check RandomMatrix.frobeniusCongruence_inner
#check RandomMatrix.hermitianCongruence
#check RandomMatrix.hermitianToMatrix_hermitianCongruence
#check RandomMatrix.hermitianUnitaryCongruenceLinearIsometryEquiv
#check RandomMatrix.map_stdGaussian_hermitianUnitaryCongruence
#check RandomMatrix.measurableSet_hermitianSet
#check GUE.matrixLaw_hermitianSet
#check GUE.matrixLaw_ae_isHermitian
#check GUE.matrixLaw_compl_hermitianSet
~~~

Each `#check` asks Lean to report the exact type of a checked declaration. It
does not run a simulation or infer an unlisted density, law comparison,
coordinate-built Gaussian unitary ensemble invariance theorem, or spectral
consequence.

**Full project check: exact repository module plus Mathlib.** From the
repository root, run:

~~~sh
cd formalization
lake env lean NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleGeometry.lean
~~~

This command may compile substantial dependencies and therefore may require
substantial disk space and memory.
{{< /repo-check >}}

## The checked declaration map

The module
<code>NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleGeometry</code>
checks 27 public declarations. The first 24 live in namespace
<code>NonlinearDynamics.Random.RandomMatrix</code>; the final three support
theorems live in <code>NonlinearDynamics.Random.GUE</code>.

| Lean declaration | Exact checked role | Deliberate boundary |
|---|---|---|
| <code>FrobeniusMatrix</code> | Abbreviates the finite \(L^2\) complex array indexed by matrix positions | Does not impose Hermiticity |
| <code>frobeniusToMatrix</code> | Reads a Frobenius vector as an ordinary matrix | No measure transport yet |
| <code>matrixToFrobenius</code> | Packages an ordinary matrix as a Frobenius vector | No Hermitian certificate |
| <code>frobeniusToMatrix_matrixToFrobenius</code> | Converting matrix to Frobenius and back is identity | Entry-packaging theorem only |
| <code>matrixToFrobenius_frobeniusToMatrix</code> | Converting Frobenius to matrix and back is identity | Entry-packaging theorem only |
| <code>frobeniusMatrixLinearEquiv</code> | Bundles the conversions as a complex linear equivalence | Isometry is proved later through inner products |
| <code>hermitianSubmodule</code> | Defines Hermitian Frobenius points as a real submodule | Correctly avoids a complex-submodule claim |
| <code>HermitianEuclidean</code> | Abbreviates the intrinsic Hermitian Euclidean type | No probability law by definition |
| <code>hermitianToMatrix</code> | Forgets the subtype proof and returns the ordinary matrix | Does not change entries or scale |
| <code>measurable_hermitianToMatrix</code> | Proves the intrinsic-to-ambient matrix map measurable | Does not identify a pushed measure |
| <code>inner_frobenius_eq_trace</code> | Identifies the complex Euclidean inner product with \(\operatorname{Tr}(X^*Y)\) | No density formula |
| <code>frobeniusCongruence</code> | Defines \(x\mapsto UXU^*\) on ambient Frobenius space | Defined without assuming \(U\) unitary |
| <code>frobeniusToMatrix_frobeniusCongruence</code> | Shows Frobenius congruence converts to ordinary matrix multiplication exactly | Compatibility lemma, not invariance |
| <code>unitaryCongruenceLinearEquiv</code> | Bundles ambient congruence by a unitary matrix as a complex linear equivalence | Does not yet assert norm preservation |
| <code>frobeniusCongruence_inner</code> | Proves unitary congruence preserves the complex Frobenius inner product | Pointwise geometry, not measure equality |
| <code>unitaryCongruenceLinearIsometryEquiv</code> | Bundles ambient unitary congruence as a complex linear isometric equivalence | Still acts on all matrices |
| <code>hermitianCongruence</code> | Restricts congruence to the Hermitian subtype | Defined for every fixed matrix \(U\) |
| <code>hermitianCongruence_coe</code> | Identifies the subtype coercion with ambient Frobenius congruence | Compatibility lemma only |
| <code>hermitianToMatrix_hermitianCongruence</code> | Identifies restricted congruence in ordinary matrix space with <code>RandomMatrix.congruence</code> | Does not map a law |
| <code>hermitianUnitaryCongruenceLinearEquiv</code> | Bundles unitary congruence on Hermitian space as a real linear equivalence | Scalar field is deliberately real |
| <code>hermitianUnitaryCongruenceLinearIsometryEquiv</code> | Bundles that restriction as a real linear isometric equivalence | No Gaussian claim by itself |
| <code>map_stdGaussian_hermitianUnitaryCongruence</code> | Proves intrinsic Hermitian <code>stdGaussian</code> is invariant under unitary congruence | Not invariance of <code>GUE.matrixLaw</code> |
| <code>hermitianSet</code> | Defines the Hermitian subset of ordinary matrix space | A set, not the intrinsic subtype |
| <code>measurableSet_hermitianSet</code> | Proves that ambient Hermitian subset measurable | No support until a measure is evaluated |
| <code>GUE.matrixLaw_hermitianSet</code> | Proves the coordinate-built matrix law gives the Hermitian set mass one | Does not determine distribution within the set |
| <code>GUE.matrixLaw_ae_isHermitian</code> | Exposes Hermiticity almost everywhere under the matrix law | No pointwise statement about every ambient matrix |
| <code>GUE.matrixLaw_compl_hermitianSet</code> | Proves the non-Hermitian complement has matrix-law mass zero | No unitary-invariance theorem |

All 27 declarations compile under Lean 4.32.0 and the pinned Mathlib 4.32.0
dependency. The module contains no <code>sorry</code> or <code>admit</code>.

### Validation boundary

The preceding `repo-check` gives the copyable import, exact declaration probe,
module path, and full project command. It checks the geometry, support, and
intrinsic Gaussian symmetry proofs. The standalone worksheet checks only the
displayed two-by-two arithmetic. Neither command numerically samples a matrix,
compares empirical histograms, or turns a support theorem into a density or
law-invariance theorem.

## Checked theorem versus classical GUE context

Classically, the Wigner-scaled GUE may be characterized by independent free
Gaussian coordinates, by an invariant density proportional to

\[
\exp\!\left(-\frac n2\operatorname{Tr}(H^2)\right),
\]

or as a scaled isotropic Gaussian on the real Euclidean space of Hermitian
matrices. These descriptions are equivalent after every variance, metric, and
reference-measure convention is aligned.

RMT-07 checks the Euclidean geometry, intrinsic isotropic-Gaussian symmetry,
and support of the coordinate presentation. The RMT-07 module does not check
the equivalence between the two presentations; RMT-08 subsequently does.

| Layer | RMT-07 status | Beyond the RMT-07 module |
|---|---|---|
| Frobenius matrix inner product and norm | Checked | Optional basis lemmas |
| Hermitian real Euclidean subtype | Checked | Explicit free-coordinate isometry |
| Unitary congruence equivalence and isometry | Checked | Transport through later comparison maps |
| Intrinsic standard-Gaussian invariance | Checked | Scaling and ambient pushforward |
| Measurable ambient Hermitian set | Checked | Nothing hidden |
| Hermitian support of <code>GUE.matrixLaw</code> | Checked | Optional support packaging as a restricted measure |
| Coordinate law = scaled intrinsic Gaussian | Not checked | RMT-08 comparison theorem |
| Unitary invariance of <code>GUE.matrixLaw</code> | Not checked | Corollary after the comparison bridge |
| Hermitian-space density and volume | Not checked | Reference Lebesgue measure and Jacobian |
| Eigenvalues, moments, or asymptotics | Not checked | Separate spectral and integration infrastructure |

## Physics window: symmetry without a preferred basis

In finite-dimensional quantum mechanics, an observable or Hamiltonian is
represented by a Hermitian operator. Its eigenvalues are real, and changing an
orthonormal basis replaces \(H\) by \(UHU^*\). A probability model intended
to carry no preferred basis should assign the same law before and after every
such deterministic unitary change of coordinates.

Dyson's threefold classification distinguishes orthogonal, unitary, and
symplectic symmetry classes. The unitary class is the complex Hermitian class
associated, in the standard physical discussion, with the absence of the
relevant antiunitary time-reversal constraint. The classical GUE is the
Gaussian reference ensemble for this class.

RMT-07 formalizes neither a quantum Hamiltonian nor time-reversal symmetry. It
does something more elementary and reusable: it proves the finite-dimensional
geometric statement that basis change acts isometrically on Hermitian matrix
space, and that the intrinsic isotropic Gaussian cannot distinguish those
bases. The physical interpretation motivates the action; it does not replace
the measure comparison needed for the coordinate-built ensemble.

## Common wrong turns

### Treating Hermitian matrices as a complex vector space

If \(H=H^*\), then \((iH)^*=-iH\). Except in the zero case, \(iH\) is not
Hermitian. The intrinsic space is a real subspace, and its Gaussian and
isometry theorems must use \(\mathbb R\)-linear structure.

### Forgetting the reflected lower entry

The upper coordinate \(x_{ij}+iy_{ij}\) and lower coordinate
\(x_{ij}-iy_{ij}\) have equal magnitude. Both enter the Frobenius sum, so the
free upper real coordinates carry weight two. Missing that duplication gives
the wrong orthonormal basis and the wrong Gaussian scale.

### Proving norm preservation but claiming law preservation

A pointwise isometry preserves distances and norms. A measure is invariant
only after its pushforward under that map is proved equal to itself. RMT-07
gets the intrinsic measure equality from <code>stdGaussian_map</code>; it does
not infer invariance for every measure on the same space.

### Reading support as a full distributional description

Many different laws have mass one on the Hermitian set. Support supplies no
Gaussianity, independence, density, or unitary symmetry on its own.

### Calling the coordinate-built law intrinsic by inspection

Matching scalar variances is persuasive but insufficient. Equality of full
joint measures requires the correct bundled coordinate map, independence, and
transport theorem. This is the obligation left open by RMT-07 and discharged
in RMT-08.

### Hiding scale in the word standard

Mathlib's <code>stdGaussian</code> has variance one along orthonormal real
directions. The RMT-06 Wigner scale is \(s_n=1/n\) in positive dimension. The
comparison needs multiplication by \(\sqrt{s_n}\), not an unscaled equality.

### Deriving invariance from a density that has not been defined

The classical density is useful context. Formal density reasoning requires a
specific reference measure on Hermitian space and proof that unitary
congruence preserves it. RMT-07 uses intrinsic Gaussian transport instead and
makes no density claim.

### Confusing congruence with left multiplication

The relevant action is \(H\mapsto UHU^*\), not \(H\mapsto UH\). The two-sided
action preserves Hermiticity and represents basis change.

### Claiming spectral consequences from Euclidean symmetry

RMT-07 defines no eigenvalue random variables, joint eigenvalue density,
trace expectation, spectral form factor, empirical measure, or large-size
limit. Those require new measurable and analytic layers.

## Exercises

1. **Running reconstruction.** Starting from
   \(d_0=1,d_1=3,z=1+2i\), reconstruct \(H\), calculate \(H^*\), and multiply
   \(PHP^*\) entry by entry. Which single entry proves \(H'\ne H\)?
2. **Running invariant ledger.** Recompute both traces and both squared
   Frobenius norms without using the displayed answers. Then check the norm
   again from \(q\) and \(q'\).
3. **Running law test.** For the event \(\{H\}\), evaluate its mass under
   \(\delta_H\), \(T_*\delta_H\), \(\mu_{\mathrm{pair}}\), and
   \(T_*\mu_{\mathrm{pair}}\). Which equalities are pointwise and which are
   equalities of measures?
4. **Packaging.** Prove directly that <code>frobeniusToMatrix</code> and
   <code>matrixToFrobenius</code> preserve every entry.
5. **Trace inner product.** Expand \(\operatorname{Tr}(X^*Y)\) for
   \(2\times2\) matrices and compare it with the four-coordinate complex
   Euclidean inner product.
6. **Real subspace.** Show that Hermitian matrices are closed under real
   scalar multiplication and give a nonzero example for which multiplication
   by \(i\) takes the matrix outside the subspace.
7. **Dimension.** Count the real free coordinates of an \(n\times n\)
   Hermitian matrix and obtain \(n^2\).
8. **Factor two.** Derive the Frobenius squared norm of a \(3\times3\)
   Hermitian matrix from its diagonal and strict-upper coordinates.
9. **Orthonormalization.** Explain why multiplying both real components of
   every strict-upper coordinate by \(\sqrt2\) corrects the metric.
10. **Inverse action.** Verify \(C_{U^*}\circ C_U=\mathrm{id}\) using both
   unitary identities.
11. **Trace cycle.** Locate exactly where cyclicity of trace is used in the
   proof that congruence preserves the Frobenius inner product.
12. **Restriction.** Prove that \(UHU^*\) is Hermitian without assuming \(U\)
   unitary. Which later property does require unitarity?
13. **Gaussian scale.** If upper real and imaginary parts have variance
    \(s/2\), compute the variances after square-root-of-two rescaling.
14. **Support.** Starting from \(\mu=A_*\nu\), prove
    \(\mu(S)=1\) when \(A^{-1}(S)\) is the whole source and \(\nu\) is a
    probability measure.
15. **Counterexample.** Give a point mass with Hermitian support that is not
    invariant under every unitary congruence.
16. **Lean.** Find the declaration that connects restricted congruence to the
    pre-existing ambient <code>RandomMatrix.congruence</code> map.
17. **Boundary.** Explain what the intrinsic Gaussian and congruence action
    become at \(n=0\).
18. **RMT-07 boundary design.** Write a precise source type, target type, and
    coordinate formula for the real-linear isometry needed to identify free
    Hermitian coordinates with \(\mathcal H_n\), then compare your design with
    the linked RMT-08 chapter.

## Summit register

RMT-07 gives finite complex matrices a canonical Frobenius Euclidean model and
proves its inner product is the familiar trace expression. It identifies the
Hermitian matrices as a real Euclidean subspace, packages unitary congruence as
an ambient complex linear isometry and an intrinsic real linear isometry, and
uses Mathlib's multivariate Gaussian transport theorem to prove exact
invariance of the intrinsic Hermitian standard Gaussian.

Separately, it proves that the RMT-06 coordinate-built matrix law assigns mass
one to the measurable Hermitian locus, is Hermitian almost everywhere, and
assigns zero mass to the non-Hermitian complement.

The factor-of-two identity explains how the paths should meet. In orthonormal
Hermitian coordinates, diagonal variables remain unchanged while upper real
and imaginary variables receive a factor \(\sqrt2\). The RMT-06 variances then
all become \(s_n\), predicting a \(\sqrt{s_n}\)-scaled intrinsic standard
Gaussian. That is the equality and symmetry transport absent from the RMT-07
module and subsequently checked in RMT-08.

No density, volume Jacobian, coordinate-law unitary invariance, eigenvalue
law, moment, spectral statistic, semicircle theorem, or universality result is
claimed here.

## Where to continue

Use the
{{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius geometry" >}}
glossary entry for a compact statement of the metric and factor-two ledger.
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}})
constructs the matrix law whose support is proved here, and the
{{< refterm "gaussian-unitary-ensemble" "Gaussian unitary ensemble" >}}
entry records its normalization.

[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}})
develops the pointwise assembly map. Read
{{< refterm "unitary-invariance" "unitary invariance" >}} for the law-level
definition and counterexamples separating support, pointwise preservation, and
distributional symmetry.

## References

**Mathlib contributors.**
[Multivariate Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Multivariate.html),
Mathlib 4 documentation. The page defines <code>stdGaussian E</code> from
independent standard real coordinates in an orthonormal basis and documents
<code>stdGaussian_map</code>, which transports the measure along a real linear
isometric equivalence.

**Mathlib contributors.**
[Pi-L2 Euclidean spaces](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/InnerProductSpace/PiL2.html),
[unitary matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/UnitaryGroup.html),
and
[Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html),
Mathlib 4 documentation. These official API references underlie the ambient
Euclidean representation, bundled unitary group, and Hermitian matrix
identities used by the checked proofs.

**Alice Guionnet.**
[Rare Events in Random Matrix Theory](https://ems.press/content/book-chapter-files/33150),
in *Proceedings of the International Congress of Mathematicians 2022*, volume
2, European Mathematical Society Press, 2022,
[doi:10.4171/ICM2022/174](https://doi.org/10.4171/ICM2022/174),
pp. 1008-1052. Section 1.1.1 states the classical GUE entry variances
\(1/n\) and \(1/(2n)\), the density
\(\exp[-n\operatorname{Tr}(H^2)/2]\) under the unitary convention, and
unitary-conjugation invariance. The density and the equivalence of
presentations remain contextual here.

**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems. I](https://doi.org/10.1063/1.1703773),
*Journal of Mathematical Physics* 3 (1962), 140-156. This primary paper
develops the orthogonal, unitary, and symplectic symmetry-class framework and
its quantum-spectral motivation.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
