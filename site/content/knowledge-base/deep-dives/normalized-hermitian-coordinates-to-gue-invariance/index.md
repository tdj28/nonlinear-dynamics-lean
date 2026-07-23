---
title: "From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance"
slug: "normalized-hermitian-coordinates-to-gue-invariance"
date: 2026-07-21
summary: "An exact size-two ledger shows why normalized Hermitian coordinates are isometric, how their full Gaussian product becomes the intrinsic and ambient Gaussian unitary ensemble laws, and why unitary invariance is equality of pushforward measures rather than pointwise fixedness."
lead: "One square root of two turns an entrywise Gaussian recipe into basis-neutral Hermitian geometry. Follow the exact matrix, the complete product law, and the commuting pushforwards before using the word invariant."
draft: false
pro_reviewed: false
level: "Concrete two-by-two calculation to finite ensemble symmetry"
reading_time: "75 to 100 minutes"
prerequisites: "Algebra with complex numbers and two-by-two matrices; Gaussian laws, product measures, intrinsic carriers, and Lean syntax are introduced as they appear"
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleInvariance"
toc: true
og_image: "normalized-coordinates-to-gue-invariance-card.png"
og_image_alt: "At size two, four normalized Gaussian coordinates of variance one half decode into the Hermitian matrix with rows two, one plus two i and one minus two i, minus one; the coordinate and Frobenius squared norms both equal fifteen."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working draft. The
mathematical prose, figures, citations, declaration map, and accessibility
remain pending human and Pro review. Statements described as checked refer to
the pinned repository modules. The small <code>Std</code> worksheet below was
executed separately with pinned Lean 4.32.0.
{{< /panel >}}

## Start with the exact size-two ledger

The repository fixes one finite Gaussian unitary ensemble (GUE) convention
before it proves any symmetry. In positive dimension \(n\), the variance scale
is

\[
v_n=\frac1n.
\]

A {{< refterm "gaussian-distribution" "Gaussian distribution" >}} is a
bell-shaped probability law determined here by its mean and
{{< refterm "variance" "variance" >}}. “Centered” means mean zero; variance
measures expected squared displacement from that mean. When this chapter says
coordinates are mutually {{< refterm "independence" "independent" >}}, it
means their joint law is the product of the listed one-coordinate laws, not
merely that their pairwise correlations vanish.

Diagonal entries have variance \(v_n\). The real and imaginary parts of each
strict-upper entry have variance \(v_n/2\). The lower triangle is not sampled
independently; it is forced by Hermitian conjugate reflection.

At \(n=2\), the ledger becomes

| Object | Number of real slots | Mean | Variance of each displayed real slot |
|---|---:|---:|---:|
| diagonal entries | 2 | 0 | \(1/2\) |
| real part of the one strict-upper entry | 1 | 0 | \(1/4\) |
| imaginary part of the one strict-upper entry | 1 | 0 | \(1/4\) |

A \(2\times2\) {{< refterm "hermitian-matrix" "Hermitian matrix" >}} has the
form

\[
H=
\begin{bmatrix}
d_0 & a+ib\\
a-ib & d_1
\end{bmatrix},
\]

where \(d_0,d_1,a,b\in\mathbb R\). “Hermitian” means
\(H^*=H\), where \(H^*\) is the
{{< refterm "conjugate-transpose" "conjugate transpose" >}}. The diagonal is
real, and the lower-left entry is the complex conjugate of the upper-right
entry.

### The four normalized real coordinates

The repository does not use \((d_0,d_1,a,b)\) as its orthonormal real
coordinates. It uses

\[
z=(d_0,d_1,r,s)
=\bigl(d_0,d_1,\sqrt2,a,\sqrt2,b\bigr).
\]

All four entries of the random vector \(z\) are mutually independent centered
Gaussians with variance \(1/2\). Decoding divides the last two by \(\sqrt2\):

\[
H(z)=
\begin{bmatrix}
d_0 & r/\sqrt2+i\,s/\sqrt2\\
r/\sqrt2-i\,s/\sqrt2 & d_1
\end{bmatrix}.
\]

Because variance scales by the square of a deterministic multiplier,

\[
\operatorname{Var}(r/\sqrt2)
=\operatorname{Var}(s/\sqrt2)
=\frac12\cdot\frac12
=\frac14.
\]

The decoder therefore recovers exactly the entrywise variance ledger above.
It does not add another normalization later.

### One concrete coordinate point

Take the deterministic point

\[
z_0=(2,-1,\sqrt2,2\sqrt2).
\]

This is one point in the coordinate space, not a claim that a continuously
distributed random vector assigns positive probability to that singleton.
The decoder gives

\[
H_0=H(z_0)=
\begin{bmatrix}
2 & 1+2i\\
1-2i & -1
\end{bmatrix}.
\]

The {{< refterm "hermitian-frobenius-geometry" "Frobenius squared norm" >}}
adds the squared complex magnitudes of all four matrix entries. Since an upper
entry and its conjugate have the same magnitude,

\[
\begin{aligned}
\lVert H_0\rVert_F^2
&=2^2+(-1)^2+|1+2i|^2+|1-2i|^2\\
&=4+1+5+5\\
&=15.
\end{aligned}
\]

The Euclidean coordinate square is

\[
\lVert z_0\rVert_2^2
=2^2+(-1)^2+(\sqrt2)^2+(2\sqrt2)^2
=4+1+2+8
=15.
\]

The equality is not a coincidence. The decoder is designed to be an isometry.

### The wrong-normalization near-miss

Suppose we omit both divisions by \(\sqrt2\) and place \(r+is\) directly
above the diagonal. The same coordinate point would produce an upper entry
\(\sqrt2+2\sqrt2 i\). Its matrix square would be

\[
4+1+2(2+8)=25,
\]

not 15. At the law level, its upper real and imaginary parts would retain
variance \(1/2\), not the repository's required \(1/4\). The near-miss fails
both the geometry test and the probability ledger.

{{< reference-figure
  wide="true"
  src="commuting-gaussian-pushforwards.svg"
  alt="At size two, four independent normalized Gaussian slots each have variance one half. The point two, minus one, square root two, two square root two decodes into a Hermitian matrix whose rows are two, one plus two i and one minus two i, minus one. The coordinate square and Frobenius square both equal fifteen; omitting the square-root-two divisions gives twenty-five and the wrong upper variances."
  caption="**Finding:** the same factor \\(1/\sqrt2\\) solves two obligations. It turns four common-variance real coordinates into the approved diagonal variance \\(1/2\\) and upper component variances \\(1/4\\), and it makes normalized Euclidean length equal Frobenius length. The numeric point is a deterministic geometry audit, not sampled data. The hatched lower panel is a deliberately wrong decoder."
>}}

{{< checkpoint stage="Exact ledger" title="Do not normalize by visual habit" >}}
The upper entry appears twice in the Frobenius sum, once above and once below
the diagonal. That duplication forces the factor two in squared norm and the
factor \(\sqrt2\) in orthonormal real coordinates.
{{< /checkpoint >}}

## Conjugate the concrete matrix by a unitary swap

A complex matrix \(U\) is **unitary** when \(U^*U=UU^*=I\). Unitary matrices
encode changes between orthonormal bases. Their action on a Hermitian matrix is
the congruence

\[
H\longmapsto UHU^*.
\]

For the exact example, choose the coordinate-swap matrix

\[
P=
\begin{bmatrix}
0&1\\
1&0
\end{bmatrix}.
\]

It satisfies \(P^*=P\) and \(P^2=I\), so it is unitary. Direct multiplication
gives

\[
PH_0P^*=
\begin{bmatrix}
-1 & 1-2i\\
1+2i & 2
\end{bmatrix}.
\]

The transformed matrix is visibly not \(H_0\). Its diagonal values have
traded places and the sign of the upper imaginary part has changed. In
normalized real coordinates, the action on this example is

\[
(d_0,d_1,r,s)
\longmapsto
(d_1,d_0,r,-s),
\]

so

\[
(2,-1,\sqrt2,2\sqrt2)
\longmapsto
(-1,2,\sqrt2,-2\sqrt2).
\]

This is a signed permutation of real coordinates. It preserves squared length:

\[
1+4+2+8=15.
\]

A phase change gives a second concrete audit. Let

\[
D=\operatorname{diag}(1,i),
\qquad
D^*=\operatorname{diag}(1,-i).
\]

Then

\[
DH_0D^*=
\begin{bmatrix}
2 & 2-i\\
2+i & -1
\end{bmatrix}.
\]

On the normalized upper pair, this action is the quarter-turn

\[
(r,s)\longmapsto(s,-r).
\]

It sends \(z_0\) to
\((2,-1,2\sqrt2,-\sqrt2)\), whose square is
\(4+1+8+2=15\). The swap was a signed permutation; this phase is a genuine
two-coordinate rotation. Both visibly move the displayed matrix while
preserving the real Frobenius geometry.

### Pointwise invariance is the wrong claim

The theorem in this chapter does **not** say

\[
UHU^*=H
\quad\text{for every sample }H.
\]

That is false for \(H_0\) and \(P\). The theorem concerns the
{{< refterm "probability-law" "probability law" >}} \(\mu_2\) of the random
matrix. A law is a measure on the value space. Pushing that law through the
congruence map means applying the deterministic basis change to every possible
matrix while transporting its probabilities. The checked equality is

\[
(H\mapsto UHU^*)_*\mu_2=\mu_2.
\]

Thus a random draw and its conjugate generally differ as matrices while having
the same distribution. The {{< refterm "pushforward-measure" "pushforward measure" >}}
is the layer at which invariance lives.

{{< reference-figure
  wide="true"
  src="swap-conjugation-law-boundary.svg"
  alt="The swap unitary changes the matrix with rows two, one plus two i and one minus two i, minus one into the matrix with rows minus one, one minus two i and one plus two i, two. The matrices are unequal but both have Frobenius square fifteen. The checked law statement says the pushforward of the Gaussian unitary ensemble matrix law under this congruence equals the original law."
  caption="**Finding:** three assertions must be separated. Pointwise fixedness fails for the displayed matrix. Frobenius norm preservation holds because unitary congruence is a real isometry on Hermitian space. Law invariance holds because the complete scaled intrinsic Gaussian is preserved and its ambient pushforward is exactly the coordinate-built matrix law. No random unitary is sampled in this calculation."
>}}

## Type and run the size-two arithmetic yourself

The exact Gaussian measures and project theorems import Mathlib and belong on
an approved Linux project builder. The finite matrix ledger can run locally.
The following worksheet imports only Lean's <code>Std</code> library. It stores
complex integers as pairs, checks Hermiticity plus the swap and phase
congruences, and records variances in quarter-units so that \(1/2\) is the
natural number 2 and \(1/4\) is 1.

Create <code>/tmp/NormalizedGUE2Tutorial.lean</code> in a text editor and type:

~~~lean
import Std

structure GaussianInt where
  re : Int
  im : Int
deriving Repr, DecidableEq

def GaussianInt.conj (z : GaussianInt) : GaussianInt :=
  ⟨z.re, -z.im⟩

def GaussianInt.normSq (z : GaussianInt) : Int :=
  z.re * z.re + z.im * z.im

def GaussianInt.mul (z w : GaussianInt) : GaussianInt :=
  ⟨z.re * w.re - z.im * w.im,
    z.re * w.im + z.im * w.re⟩

structure Matrix2 where
  a00 : GaussianInt
  a01 : GaussianInt
  a10 : GaussianInt
  a11 : GaussianInt
deriving Repr, DecidableEq

def matrixEntries (H : Matrix2) : List (Int × Int) :=
  [(H.a00.re, H.a00.im), (H.a01.re, H.a01.im),
   (H.a10.re, H.a10.im), (H.a11.re, H.a11.im)]

def isHermitian (H : Matrix2) : Bool :=
  decide (H.a00.im = 0 ∧ H.a11.im = 0 ∧
    H.a10 = H.a01.conj)

def frobeniusSq (H : Matrix2) : Int :=
  H.a00.normSq + H.a01.normSq + H.a10.normSq + H.a11.normSq

def correctH : Matrix2 :=
  ⟨⟨2, 0⟩, ⟨1, 2⟩, ⟨1, -2⟩, ⟨-1, 0⟩⟩

def swapCongruence (H : Matrix2) : Matrix2 :=
  ⟨H.a11, H.a10, H.a01, H.a00⟩

def swappedH : Matrix2 := swapCongruence correctH

def phaseCongruence (H : Matrix2) : Matrix2 :=
  let plusI : GaussianInt := ⟨0, 1⟩
  let minusI : GaussianInt := ⟨0, -1⟩
  ⟨H.a00, H.a01.mul minusI, plusI.mul H.a10, H.a11⟩

def phasedH : Matrix2 := phaseCongruence correctH

def normalizedCoordinateSquares : List Int := [4, 1, 2, 8]

def swappedCoordinateSquares : List Int := [1, 4, 2, 8]

def normalizedNormSq : Int := normalizedCoordinateSquares.sum

def swappedNormalizedNormSq : Int := swappedCoordinateSquares.sum

def wrongUnnormalizedAssemblySq : Int :=
  4 + 1 + 2 * (2 + 8)

def normalizedVarianceQuarters : List (String × Nat) :=
  [("diagonal 0", 2), ("diagonal 1", 2),
   ("upper real normalized", 2), ("upper imaginary normalized", 2)]

def decodedEntryVarianceQuarters : List (String × Nat) :=
  [("diagonal 0", 2), ("diagonal 1", 2),
   ("real part of upper entry", 1), ("imaginary part of upper entry", 1)]

#eval normalizedVarianceQuarters
#eval decodedEntryVarianceQuarters
#eval matrixEntries correctH
#eval matrixEntries swappedH
#eval matrixEntries phasedH
#eval (normalizedNormSq, frobeniusSq correctH,
  wrongUnnormalizedAssemblySq)
#eval (!decide (correctH = swappedH),
  decide (frobeniusSq correctH = frobeniusSq swappedH),
  decide (normalizedNormSq = swappedNormalizedNormSq))
#eval (isHermitian correctH, isHermitian swappedH)
#eval (isHermitian phasedH,
  decide (frobeniusSq correctH = frobeniusSq phasedH))

example : normalizedNormSq = 15 := by
  native_decide

example : frobeniusSq correctH = 15 := by
  native_decide

example : wrongUnnormalizedAssemblySq = 25 := by
  native_decide

example : swappedH =
    ⟨⟨-1, 0⟩, ⟨1, -2⟩, ⟨1, 2⟩, ⟨2, 0⟩⟩ := by
  native_decide

example : correctH ≠ swappedH := by
  native_decide

example : phasedH =
    ⟨⟨2, 0⟩, ⟨2, -1⟩, ⟨2, 1⟩, ⟨-1, 0⟩⟩ := by
  native_decide

example :
    frobeniusSq correctH = frobeniusSq swappedH ∧
      normalizedNormSq = swappedNormalizedNormSq := by
  native_decide

example : isHermitian correctH = true ∧ isHermitian swappedH = true := by
  native_decide

example : isHermitian phasedH = true ∧
    frobeniusSq correctH = frobeniusSq phasedH := by
  native_decide
~~~

Run the pinned compiler directly:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean /tmp/NormalizedGUE2Tutorial.lean
~~~

**Resource label: small standalone Lean plus <code>Std</code>, suitable for an
ordinary Mac or Linux machine.** The command neither enters the Lake project
nor downloads or builds Mathlib.

The executed output is:

~~~text
[("diagonal 0", 2), ("diagonal 1", 2), ("upper real normalized", 2), ("upper imaginary normalized", 2)]
[("diagonal 0", 2), ("diagonal 1", 2), ("real part of upper entry", 1), ("imaginary part of upper entry", 1)]
[(2, 0), (1, 2), (1, -2), (-1, 0)]
[(-1, 0), (1, -2), (1, 2), (2, 0)]
[(2, 0), (2, -1), (2, 1), (-1, 0)]
(15, 15, 25)
(true, true, true)
(true, true)
(true, true)
~~~

The first two lines separate normalized-coordinate variances from decoded
entry variances. The next three list the original, swapped, and phase-rotated
matrix entries in row-major order. The triple \((15,15,25)\) compares
coordinate square, correct Frobenius square, and wrong-decoder square. The
remaining Booleans confirm pointwise change, norm preservation,
coordinate-norm preservation, and Hermiticity for both concrete congruences.

The worksheet does **not** define a Gaussian probability measure, prove a full
product law, construct Mathlib's standard Gaussian, or establish measure
invariance. Those claims require the exact project modules below.

## Generalize the four slots to every finite dimension

Let \(T_n\) be the finite type of strict-upper positions \((i,j)\) with
\(i\lt j\). The checked normalized real index is

\[
I_n
=\operatorname{Fin}(n)\sqcup(T_n\sqcup T_n).
\]

Its sectors are semantic:

- <code>Sum.inl i</code> is diagonal coordinate \(d_i\);
- <code>Sum.inr (Sum.inl ij)</code> is normalized upper-real coordinate
  \(r_{ij}\); and
- <code>Sum.inr (Sum.inr ij)</code> is normalized upper-imaginary coordinate
  \(s_{ij}\).

The cardinality is

\[
|I_n|=n+2\binom n2=n^2,
\]

the real dimension of the Hermitian matrices. The source module does not need
to turn this into an arbitrary <code>Fin (n^2)</code> enumeration. The semantic
sum tells every decoder branch which role a coordinate has.

The definitions <code>hermitianRealIndexToPair</code> and
<code>pairToHermitianRealIndex</code> match those semantic slots with all
matrix positions. A diagonal slot maps to \((i,i)\), a real-upper slot to
\((i,j)\), and its imaginary partner to the reflected position \((j,i)\).
The two inverse theorems package this as
<code>hermitianRealIndexEquivMatrixIndex</code>. That equivalence later
reindexes the Frobenius sum without choosing a basis ordering.

## Decode, analyze, and prove the real isometry

The coordinate carrier is

\[
E_n=\operatorname{EuclideanSpace}(\mathbb R,I_n).
\]

A point in \(E_n\) is a real function on the finite index wrapped in a finite
\(\ell^2\) structure. The target is
\(\mathcal H_n\), the intrinsic real Euclidean space of Hermitian matrices
with the inherited Frobenius inner product.

Why **real**? If \(H\) is Hermitian, then \(rH\) is Hermitian for every real
\(r\). Multiplication by an arbitrary complex scalar need not preserve
\(H^*=H\). The Hermitian locus is a real subspace of the complex Frobenius
carrier, not generally a complex subspace.

The synthesis map \(\Phi_n:E_n\to\mathcal H_n\) uses

\[
(\Phi_n z)_{ii}=d_i,
\qquad
(\Phi_n z)_{ij}
=\frac{r_{ij}}{\sqrt2}+i\frac{s_{ij}}{\sqrt2}
\quad(i\lt j),
\]

and conjugate reflection below the diagonal. The analysis map reads

\[
d_i=H_{ii},
\qquad
r_{ij}=\sqrt2\operatorname{Re}(H_{ij}),
\qquad
s_{ij}=\sqrt2\operatorname{Im}(H_{ij}).
\]

The source proves both round trips, real linearity, and the stronger inner
product identity

\[
\langle\Phi_n x,\Phi_n y\rangle_F
=\langle x,y\rangle_2.
\]

The norm identity from the opening example is the case \(x=y=z_0\).

### Lean bridge: read one strict-upper entry

{{< lean-bridge
  human="Normalized Hermitian assembly divides the upper-real and upper-imaginary slots by square root two before combining them as a complex entry."
  math="\((\Phi_n x)_{ij}=x_{\mathrm{re}(ij)}/\sqrt2+i\,x_{\mathrm{im}(ij)}/\sqrt2\) for \(i\lt j\)."
  lean="(normalizedHermitianAssembly x : FrobeniusMatrix n) ij.1 = ⟨x (.inr (.inl ij)) / Real.sqrt 2, x (.inr (.inr ij)) / Real.sqrt 2⟩"
>}}

- <code>ij : StrictUpperIndex n</code> contains a pair and proof that its row
  is strictly less than its column.
- <code>.inr (.inl ij)</code> selects the real-upper sector;
  <code>.inr (.inr ij)</code> selects the imaginary-upper sector.
- <code>⟨re, im⟩</code> constructs the complex number with those two Cartesian
  coordinates.
- The exact theorem is
  <code>RandomMatrix.normalizedHermitianAssembly_apply_upper</code>.

**Run boundary.** Replay the theorem with the guarded primary-module check
near the end. The local worksheet verifies only its displayed size-two
arithmetic.
{{< /lean-bridge >}}

### Lean bridge: the decoder preserves the real inner product

{{< lean-bridge
  human="Normalized assembly preserves every real inner product, so it is an isometry onto intrinsic Hermitian space."
  math="\(\langle\Phi_nx,\Phi_ny\rangle_F=\langle x,y\rangle_2.\)"
  lean="inner ℝ (normalizedHermitianAssembly x) (normalizedHermitianAssembly y) = inner ℝ x y"
>}}

- <code>inner ℝ</code> makes the scalar field explicit. The intrinsic
  Hermitian carrier is real.
- The two appearances of <code>normalizedHermitianAssembly</code> are compared
  in the Frobenius geometry inherited by the subtype.
- The theorem is
  <code>RandomMatrix.normalizedHermitianAssembly_inner</code>.
- <code>normalizedHermitianLinearIsometryEquiv n</code> then bundles the
  inverse maps, real linearity, and norm preservation for downstream Gaussian
  transport.

**Run boundary.** The exact proof reindexes finite sums and uses Mathlib, so it
belongs to the guarded Linux project check. The numeric \(15=15\) case is safe
in the standalone worksheet.
{{< /lean-bridge >}}

## The coordinate law is a complete product law

Geometry alone does not define probability. Put the common centered Gaussian
law of variance \(v_n\) on every normalized real slot:

\[
\Pi_n=\bigotimes_{k\in I_n}\gamma_{0,v_n}.
\]

At size two this is the fourfold product of \(\gamma_{0,1/2}\). The word
**product** carries the mutual-independence structure. It is stronger than a
list of four marginal law statements.

The decoder splits \(I_n\) into the diagonal, upper-real, and upper-imaginary
families. It divides both upper families by \(\sqrt2\), pairs them pointwise as
complex numbers, and produces the earlier coordinate carrier

\[
(\operatorname{Fin}(n)\to\mathbb R)
\times(T_n\to\mathbb C).
\]

The scalar transport identity is

\[
(x\mapsto x/\sqrt2)_*\gamma_{0,v_n}
=\gamma_{0,v_n/2}.
\]

Two real upper products therefore become the exact Cartesian complex product
whose real and imaginary variances are both \(v_n/2\). At \(n=2\), this is
\(1/4\) and \(1/4\).

### Why matching marginals would not be enough

Four variables could each have law \(\gamma_{0,1/2}\) while being completely
dependent. For example, copying one Gaussian variable into all four slots
gives the right scalar marginals and the wrong joint law. RMT-08 does not infer
independence from variance calculations. It transports the complete finite
product measure through measurable sum/product equivalences.

### Lean bridge: decode the entire product at once

{{< lean-bridge
  human="The common-variance product over every normalized real slot decodes exactly to the repository's diagonal and complex-upper coordinate law."
  math="\((D_n)_*\Pi_n=\nu_n\), where \(D_n\) divides upper slots by \(\sqrt2\) and \(\nu_n\) is the full coordinate measure."
  lean="(gaussianProductMeasure (fun _ : HermitianRealIndex n ↦ 0) (fun _ ↦ varianceScale n)).map RandomMatrix.realToHermitianCoordinates = coordinateMeasure n"
>}}

- <code>gaussianProductMeasure</code> is the finite product of exact real
  Gaussian measures.
- The first function supplies mean zero at every semantic index.
- The second supplies the same variance <code>varianceScale n</code> at every
  normalized index.
- <code>.map RandomMatrix.realToHermitianCoordinates</code> is the pushforward
  through the decoder.
- <code>coordinateMeasure n</code> is the earlier nested diagonal/complex-upper
  law, including all block independence.
- The theorem is
  <code>GUE.map_realToHermitianCoordinates_gaussianProduct</code>.

**Run boundary.** This equality uses Mathlib finite product measures and must
be checked through the cloud-only repository command. No claim in the local
integer worksheet substitutes for it.
{{< /lean-bridge >}}

## Standard Gaussian transport supplies the basis-neutral shape

Mathlib's <code>stdGaussian E</code> is the canonical centered standard
Gaussian on a finite real Euclidean space \(E\). On a coordinate Euclidean
space, a product of unit-variance real Gaussians becomes this measure after
the finite \(\ell^2\) packaging. A real linear isometric equivalence transports
it to the standard Gaussian on the target Euclidean space.

For a common variance \(v\), first scale a unit-variance coordinate vector by
\(\sqrt v\). Coordinatewise,

\[
\sqrt v\,G\sim\gamma_{0,v}
\quad\text{when}\quad
G\sim\gamma_{0,1}.
\]

The source proves the full finite-product version:

\[
(\operatorname{toLp})_*\bigotimes_i\gamma_{0,v}=
(x\mapsto\sqrt v\,x)_*\operatorname{stdGaussian}(E).
\]

Now use the normalized isometry \(\Phi_n\). Standard Gaussian shape is
unchanged by an isometric coordinate change, while uniform scalar
multiplication commutes with real linear maps. The intrinsic GUE law is

\[
\Gamma_n
=(H\mapsto\sqrt{v_n}\,H)_*
  \operatorname{stdGaussian}(\mathcal H_n).
\]

At size two, the common scale is

\[
\sqrt{v_2}=\sqrt{1/2}=1/\sqrt2.
\]

The standard Gaussian supplies isotropic shape. The scalar supplies the
dimension-dependent Wigner scale. These are separate responsibilities.

### Lean bridge: identify the intrinsic law

{{< lean-bridge
  human="The intrinsic finite GUE law is the canonical standard Hermitian Gaussian uniformly scaled by the square root of the variance scale."
  math="\(\Gamma_n=(H\mapsto\sqrt{v_n}H)_*\operatorname{stdGaussian}(\mathcal H_n).\)"
  lean="GUE.intrinsicLaw n = (stdGaussian (RandomMatrix.HermitianEuclidean n)).map (fun H ↦ Real.sqrt (GUE.varianceScale n : ℝ) • H)"
>}}

- <code>GUE.intrinsicLaw n</code> is a measure whose values are intrinsically
  Hermitian points.
- <code>stdGaussian</code> supplies the canonical basis-neutral Euclidean law.
- <code>Real.sqrt (GUE.varianceScale n : ℝ)</code> converts the nonnegative
  variance parameter to its real standard-deviation scale.
- <code>• H</code> is real scalar multiplication in the intrinsic Hermitian
  space.
- The theorem is <code>GUE.intrinsicLaw_eq_map_smul_stdGaussian</code>.

**Run boundary.** The exact statement and its <code>stdGaussian_map</code>
proof belong to the cloud-only project module. The local worksheet checks the
size-two normalization but does not define <code>stdGaussian</code>.
{{< /lean-bridge >}}

## Keep coordinate, intrinsic, and ambient carriers distinct

The proof uses several spaces because each carries different useful
structure.

| Layer | Carrier | Measure or map | What the layer contributes |
|---|---|---|---|
| normalized real coordinates | \(I_n\to\mathbb R\), then \(E_n\) | common product \(\Pi_n\) | exact independent scalar law and Euclidean coordinates |
| old assembly coordinates | diagonal reals times strict-upper complexes | <code>coordinateMeasure n</code> | the repository's explicit entrywise variance convention |
| intrinsic Hermitian space | \(\mathcal H_n\) | <code>GUE.intrinsicLaw n</code> | real inner product, isometries, and standard Gaussian symmetry |
| ambient matrix space | all \(n\times n\) complex matrices | <code>GUE.matrixLaw n</code> | the public random-matrix law and its ambient congruence action |

The intrinsic carrier is a subtype: a point contains a Frobenius vector and a
proof that its matrix is Hermitian. The ambient carrier contains Hermitian and
non-Hermitian matrices alike. The inclusion

\[
\iota_n:\mathcal H_n\to\operatorname{Matrix}_n(\mathbb C)
\]

forgets the subtype proof without changing any entry.

The intrinsic law is the coordinate law pushed through intrinsic assembly.
The ambient law is the intrinsic law pushed through inclusion:

\[
\mu_n=(\iota_n)_*\Gamma_n.
\]

This equality is the bridge from basis-neutral geometry back to the exact
entrywise law defined earlier.

### Matrix-law support means full mass here

The preceding geometry module proves that the ambient Hermitian set is
measurable and

\[
\mu_n\{H:H^*=H\}=1,
\qquad
\mu_n\{H:H^*\ne H\}=0.
\]

It also states the almost-everywhere Hermitian property. These are
measure-theoretic full-mass claims. They do not identify Mathlib's topological
<code>Measure.support</code>, prove a density on the Hermitian subspace, or
show that every ambient matrix lies in the image.

### Lean bridge: move the intrinsic law into ambient matrices

{{< lean-bridge
  human="The ambient Gaussian unitary ensemble law is exactly the pushforward of the intrinsic Hermitian law through the inclusion that forgets the proof of Hermiticity."
  math="\(\mu_n=(\iota_n)_*\Gamma_n.\)"
  lean="GUE.matrixLaw n = (GUE.intrinsicLaw n).map RandomMatrix.hermitianToMatrix"
>}}

- <code>GUE.matrixLaw n</code> is a measure on all complex matrices of size
  <code>n</code>.
- <code>GUE.intrinsicLaw n</code> is a measure on the Hermitian subtype.
- <code>RandomMatrix.hermitianToMatrix</code> forgets intrinsic packaging and
  returns the same entries in ambient matrix space.
- <code>.map</code> pushes the complete measure through that measurable map.
- The theorem is
  <code>GUE.matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw</code>.

**Run boundary.** The guarded module check elaborates the exact carrier types
and measurability. The local tutorial contains only the concrete matrices.
{{< /lean-bridge >}}

## The checked route to unitary invariance

Let \(U\) be any deterministic bundled unitary matrix. RMT-07 proves that
intrinsic congruence

\[
\mathcal C_U(H)=UHU^*
\]

is a real linear isometric equivalence of \(\mathcal H_n\). Therefore the
canonical intrinsic standard Gaussian is invariant:

\[
(\mathcal C_U)_*\operatorname{stdGaussian}(\mathcal H_n)
=\operatorname{stdGaussian}(\mathcal H_n).
\]

Uniform real scaling commutes pointwise with congruence:

\[
\mathcal C_U(\sqrt{v_n}H)
=\sqrt{v_n}\,\mathcal C_U(H).
\]

Repeated use of measurable pushforward composition then gives

\[
\begin{aligned}
(\mathcal C_U)_*\Gamma_n
&=(\mathcal C_U)_*(H\mapsto\sqrt{v_n}H)_*\gamma_n\\
&=(H\mapsto\sqrt{v_n}H)_*(\mathcal C_U)_*\gamma_n\\
&=(H\mapsto\sqrt{v_n}H)_*\gamma_n\\
&=\Gamma_n,
\end{aligned}
\]

where \(\gamma_n=\operatorname{stdGaussian}(\mathcal H_n)\). This is
<code>GUE.map_intrinsicLaw_hermitianCongruence</code>.

The inclusion intertwines intrinsic and ambient congruence pointwise:

\[
\iota_n(\mathcal C_U H)
=\widehat{\mathcal C}_U(\iota_nH).
\]

Since \(\mu_n=(\iota_n)_*\Gamma_n\), another pushforward calculation gives

\[
(\widehat{\mathcal C}_U)_*\mu_n=\mu_n.
\]

Every arrow needs ordinary measurability before <code>Measure.map_map</code>
can reassociate it. Every commuting square is proved as a pointwise function
identity before it is used to rewrite a measure. The proof does not infer
measure equality from a picture.

### Lean bridge: the final law-level statement

{{< lean-bridge
  human="Every deterministic unitary congruence leaves the ambient finite Gaussian unitary ensemble probability law unchanged."
  math="\(\forall U\in\mathrm U(n),\ (H\mapsto UHU^*)_*\mu_n=\mu_n.\)"
  lean="RandomMatrix.IsUnitaryConjugationInvariant (GUE.matrixLaw n)"
>}}

- <code>IsUnitaryConjugationInvariant</code> expands to a universal statement
  over <code>U : Matrix.unitaryGroup (Fin n) ℂ</code>.
- <code>GUE.matrixLaw n</code> is the exact ambient law constructed from the
  approved coordinate measure.
- The predicate compares <code>Measure.map</code> with the original measure. It
  never asks for <code>U * H * Uᴴ = H</code> pointwise.
- The checked theorem is
  <code>GUE.matrixLaw_isUnitaryConjugationInvariant</code>.

**Run boundary.** This is the primary cloud-only repository theorem. The swap
worksheet checks one deterministic congruence but cannot establish equality
of Gaussian measures.
{{< /lean-bridge >}}

## Why no density theorem is imported

Classically, finite GUE is often presented using a density proportional to

\[
\exp\!\left(-\frac n2\operatorname{Tr}(H^2)\right)
\]

with respect to a specified Euclidean volume on Hermitian space. Unitary
congruence preserves \(\operatorname{Tr}(H^2)\), so that formula suggests
invariance. Guionnet records this normalization and symmetry in the standard
random-matrix presentation cited below.

That route would require the formal development to define the reference
volume, prove the coordinate Jacobian, normalize the density, identify the
entrywise law with that density, and prove change of variables. RMT-08 imports
none of those conclusions. Its route is instead

\[
\text{exact finite product law}
\longrightarrow
\text{real isometric decoding}
\longrightarrow
\text{scaled intrinsic standard Gaussian}
\longrightarrow
\text{commuting pushforwards}
\longrightarrow
\text{ambient law invariance}.
\]

This proves the desired measure equality without claiming a density or a
Jacobian theorem. A future density proof may identify another presentation of
the same law, but it cannot be treated as already formalized here.

## Dimension zero stays inside the same construction

At \(n=0\), <code>Fin 0</code> and the strict-upper index are empty, so
<code>HermitianRealIndex 0</code> is empty. There is one function from an empty
type to \(\mathbb R\), one empty Hermitian matrix, and one empty ambient
matrix.

The project defines

\[
v_0=0.
\]

The empty finite Gaussian product is Dirac at the unique empty coordinate
function. The coordinate, intrinsic, and ambient laws are all Dirac at their
unique zero points. The theorem
<code>GUE.intrinsicLaw_zero</code> states the intrinsic equality explicitly.

The fixed geometric factor \(\sqrt2\) and the dimension scale
\(\sqrt{v_n}\) must not be conflated. The former orthonormalizes upper entries
and is always nonzero. The latter scales the probability law and becomes zero
at dimension zero. Because the source uses <code>varianceScale</code> rather
than the partial-looking expression \(1/n\), the general invariance theorem
includes \(n=0\) without a separate positive-dimension premise.

## What is checked in each source module

The geometry predecessor establishes the carrier and symmetry before the law
comparison. The primary RMT-08 module establishes the comparison and final
transport.

| Source layer | Checked results | Explicitly absent |
|---|---|---|
| <code>GaussianUnitaryEnsembleGeometry</code> | Frobenius carrier, intrinsic real Hermitian subspace, unitary congruence isometries, intrinsic standard-Gaussian invariance, measurable Hermitian locus, full-mass ambient Hermitian law | equality with scaled intrinsic GUE, final ambient invariance, densities, spectra |
| <code>GaussianUnitaryEnsembleInvariance</code> | normalized real index, analysis/synthesis, real isometry, exact product decoding, scaled intrinsic law, intrinsic probability and zero law, ambient inclusion law, intrinsic and ambient invariance | density, Jacobian, eigenvalues, moments, asymptotics |

### Inspect the geometry and support interfaces

{{< repo-check module="NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleGeometry" >}}
**Resource label: predecessor project module plus Mathlib, cloud-only for this
project.** On an approved Linux builder, put these lines in a temporary project
scratch file:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleGeometry

open Matrix MeasureTheory ProbabilityTheory
open scoped Matrix RealInnerProductSpace
open NonlinearDynamics.Random

#check RandomMatrix.FrobeniusMatrix
#check RandomMatrix.HermitianEuclidean
#check RandomMatrix.hermitianToMatrix
#check RandomMatrix.hermitianUnitaryCongruenceLinearIsometryEquiv
#check RandomMatrix.map_stdGaussian_hermitianUnitaryCongruence
#check RandomMatrix.hermitianSet
#check RandomMatrix.measurableSet_hermitianSet
#check GUE.matrixLaw_hermitianSet
#check GUE.matrixLaw_ae_isHermitian
#check GUE.matrixLaw_compl_hermitianSet
~~~

The <code>#check</code> commands inspect existing declarations; they do not
sample a matrix. The guarded command rendered below checks the exact source
file. Do not replace it with a local project or Lake command on this Mac.
{{< /repo-check >}}

### Inspect the normalization and invariance interfaces

{{< repo-check module="NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleInvariance" >}}
**Resource label: primary project module plus Mathlib, cloud-only for this
project.** Type this exact probe on the approved Linux builder:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleInvariance

open Matrix MeasureTheory ProbabilityTheory
open scoped Matrix NNReal ENNReal RealInnerProductSpace
open NonlinearDynamics.Random

#check HermitianRealIndex
#check hermitianRealIndexEquivMatrixIndex
#check RandomMatrix.normalizedHermitianAssembly
#check RandomMatrix.normalizedHermitianAnalysis
#check RandomMatrix.normalizedHermitianAssembly_apply_upper
#check RandomMatrix.normalizedHermitianAssembly_inner
#check RandomMatrix.normalizedHermitianLinearIsometryEquiv
#check gaussianReal_map_div_sqrt_two
#check GUE.map_realToHermitianCoordinates_gaussianProduct
#check GUE.intrinsicLaw
#check GUE.intrinsicLaw_eq_map_smul_stdGaussian
#check GUE.intrinsicLaw_zero
#check GUE.matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw
#check GUE.map_intrinsicLaw_hermitianCongruence
#check GUE.matrixLaw_isUnitaryConjugationInvariant
~~~

<code>import</code> loads the pinned source and dependencies. Each
<code>#check</code> asks Lean to elaborate an exact declaration and display its
type. The guarded command below checks the whole authoritative leaf. It is not
a workstation command.
{{< /repo-check >}}

## The complete RMT-08 declaration map

The primary module exports 35 public declarations. The table records what each
one checks and prevents prose from attributing a later theorem to an earlier
definition.

| Declaration | Checked content |
|---|---|
| <code>HermitianRealIndex</code> | semantic diagonal, upper-real, and upper-imaginary index |
| <code>hermitianRealIndexToPair</code> | map each semantic real slot to one matrix position |
| <code>pairToHermitianRealIndex</code> | classify every matrix position into one semantic sector |
| <code>pairToHermitianRealIndex_toPair</code> | first index/pair round trip |
| <code>hermitianRealIndexToPair_pairTo</code> | second pair/index round trip |
| <code>hermitianRealIndexEquivMatrixIndex</code> | equivalence with all matrix-entry pairs |
| <code>RandomMatrix.realToHermitianCoordinates</code> | raw normalized decoder into the old coordinate carrier |
| <code>RandomMatrix.measurable_realToHermitianCoordinates</code> | ordinary measurability of that decoder |
| <code>RandomMatrix.normalizedHermitianAssembly</code> | normalized Euclidean coordinates to intrinsic Hermitian space |
| <code>RandomMatrix.normalizedHermitianAnalysis</code> | intrinsic Hermitian point to normalized coordinates |
| <code>RandomMatrix.hermitianToMatrix_normalizedHermitianAssembly</code> | intrinsic forgetting exposes the old assembled matrix |
| <code>RandomMatrix.normalizedHermitianAssembly_apply_diag</code> | diagonal entry formula |
| <code>RandomMatrix.normalizedHermitianAssembly_apply_upper</code> | strict-upper formula with both \(1/\sqrt2\) factors |
| <code>RandomMatrix.normalizedHermitianAssembly_apply_lower</code> | conjugate-reflected lower formula |
| <code>RandomMatrix.normalizedHermitianAnalysis_assembly</code> | analysis after assembly is identity |
| <code>RandomMatrix.normalizedHermitianAssembly_analysis</code> | assembly after analysis is identity |
| <code>RandomMatrix.normalizedHermitianLinearEquiv</code> | real linear equivalence between coordinate and intrinsic carriers |
| <code>RandomMatrix.normalizedHermitianAssembly_inner</code> | exact real inner-product preservation |
| <code>RandomMatrix.normalizedHermitianLinearIsometryEquiv</code> | bundled real linear isometric equivalence |
| <code>map_gaussianProduct_toLp_eq_map_smul_stdGaussian</code> | common-variance product becomes a scaled Euclidean standard Gaussian |
| <code>gaussianReal_map_div_sqrt_two</code> | division by \(\sqrt2\) halves centered real Gaussian variance |
| <code>realUpperToComplex</code> | pair two upper real families after normalization |
| <code>measurable_realUpperToComplex</code> | measurability of the complex pairing map |
| <code>map_realUpperToComplex_gaussianProduct</code> | exact two-real-products to Cartesian-complex-product law |
| <code>GUE.coordinateToHermitianEuclidean</code> | old GUE coordinates assembled into intrinsic space |
| <code>GUE.measurable_coordinateToHermitianEuclidean</code> | ordinary measurability of intrinsic assembly |
| <code>GUE.coordinateToHermitianEuclidean_realToHermitianCoordinates</code> | old assembly after decoding equals normalized assembly |
| <code>GUE.map_realToHermitianCoordinates_gaussianProduct</code> | full normalized product decodes to the earlier coordinate measure |
| <code>GUE.intrinsicLaw</code> | intrinsic law as a coordinate-measure pushforward |
| <code>GUE.instIsProbabilityMeasureIntrinsicLaw</code> | intrinsic law is a probability measure in every dimension |
| <code>GUE.intrinsicLaw_eq_map_smul_stdGaussian</code> | intrinsic law is scaled canonical standard Gaussian |
| <code>GUE.intrinsicLaw_zero</code> | zero-dimensional intrinsic law is Dirac at zero |
| <code>GUE.matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw</code> | ambient matrix law is the included intrinsic law |
| <code>GUE.map_intrinsicLaw_hermitianCongruence</code> | unitary congruence preserves intrinsic GUE |
| <code>GUE.matrixLaw_isUnitaryConjugationInvariant</code> | every unitary congruence preserves ambient GUE law |

The checked source has no <code>sorry</code> or <code>admit</code>. Its recorded
cloud audit compiled the leaf and aggregators with warnings treated as errors
against Lean 4.32.0 and pinned Mathlib 4.32.0. This rewrite does not claim a
fresh project build on the Mac.

## Physics window: basis neutrality, stated narrowly

A finite quantum Hamiltonian is represented by a Hermitian matrix after an
orthonormal basis is chosen. A deterministic basis change by \(U\) replaces
the coordinate matrix by \(UHU^*\). The abstract operator has not acquired
new physics; its coordinate description changed.

The entrywise GUE construction initially appears to favor one basis because it
names diagonal and upper coordinates. The normalized real-coordinate bridge
shows why that preference disappears from the probability law. After the
\(\sqrt2\) correction, the primitive variables are common-variance Gaussian
coordinates in the real Frobenius geometry. Their intrinsic law has no
preferred orthonormal real basis. Unitary congruence is one real orthogonal
transformation of that space, so the law cannot detect it.

Dyson's unitary symmetry class supplies historical physical context. The Lean
theorem is narrower: for each finite \(n\), every deterministic bundled
unitary matrix preserves the specified ambient probability measure. It does
not sample \(U\) from Haar measure, define time evolution, formalize time
reversal, unfold energy levels, or prove universal spectral statistics.

## Common wrong turns

| Wrong turn | Why it fails | Checked repair |
|---|---|---|
| Place normalized upper slots directly into the matrix. | Frobenius square becomes 25 instead of 15 in the example, and upper component variance is wrong. | Divide both upper slots by \(\sqrt2\). |
| Match all scalar variances and declare the vector laws equal. | Marginals do not encode mutual independence or the full joint law. | Transport the complete product measure. |
| Say unitary invariance means \(UHU^*=H\) for every sample. | The swap example is an explicit counterexample. | Compare the pushed-forward matrix law with itself. |
| Apply intrinsic standard-Gaussian symmetry directly to <code>matrixLaw</code>. | The measures initially live on different carriers. | Prove the intrinsic representation and ambient inclusion pushforward first. |
| Treat Hermitian space as a complex vector space. | Multiplication by a general complex scalar can destroy Hermiticity. | Use the intrinsic real submodule and real isometries. |
| Treat <code>Measure.map_map</code> as syntax-only reassociation. | The composition theorem needs measurability evidence. | Prove each deterministic map measurable before rewriting pushforwards. |
| Call full mass “topological support.” | A mass-one measurable locus is not an equality with <code>Measure.support</code>. | State the full-mass and complement-zero theorems exactly. |
| Import the classical density into the proof. | No reference volume, Jacobian, or density equivalence is formalized here. | Use finite product transport and standard-Gaussian isometries. |
| Divide by \(\sqrt n\) in the geometric decoder. | That confuses dimension scale with upper-entry orthonormalization and fails at zero. | Keep fixed \(1/\sqrt2\) decoding separate from \(\sqrt{v_n}\) law scaling. |
| Infer eigenvalue or moment results from invariance. | Law symmetry alone does not define or integrate those observables. | Build each spectral and integrability layer separately. |

## Exercises: keep the size-two matrix in view

1. **Index.** List the four semantic elements of
   <code>HermitianRealIndex 2</code> and their sum-type constructors.
2. **Decode.** Decode \((0,3,-2\sqrt2,\sqrt2)\) into a Hermitian matrix.
3. **Analyze.** Apply the inverse formulas to that matrix and recover the four
   normalized coordinates.
4. **Metric.** Compute both squared norms for the new point and verify equality.
5. **Wrong decoder.** Omit \(1/\sqrt2\) for the new point and compute the norm
   discrepancy.
6. **Variance.** Starting with normalized variance \(1/2\), derive each
   decoded entry-component variance.
7. **Dependence near-miss.** Let all four normalized coordinates equal one
   common \(\gamma_{0,1/2}\) variable. Which marginal facts remain true, and
   which product-law fact fails?
8. **Swap.** Multiply \(PH_0P\) by hand, one row and column at a time.
9. **Point versus law.** State separately the false pointwise equation, the
   true norm equation, and the checked measure equation.
10. **Phase unitary.** Try a diagonal unitary
    \(\operatorname{diag}(1,i)\). Compute how it changes the upper entry of
    \(H_0\).
11. **Real carrier.** Give one complex scalar \(c\) and one Hermitian matrix
    \(H\) for which \(cH\) is not Hermitian.
12. **Pushforward.** Write the preimage formula that defines
    \((\iota_n)_*\Gamma_n(B)\) for a measurable ambient set \(B\).
13. **Support language.** Explain why mass one on the Hermitian locus does not
    by itself identify topological support.
14. **Standard Gaussian.** Separate the shape-preserving isometry from the
    scalar \(\sqrt{v_n}\) in the intrinsic-law formula.
15. **Zero dimension.** Count every coordinate index and explain why the law
    is Dirac without evaluating \(1/\sqrt0\).
16. **Lean tokens.** Change <code>correctH</code> in the local worksheet to
    the matrix from exercise 2 and update every displayed output and example.
17. **Resource boundary.** Explain why the worksheet is local-safe but the
    two <code>repo-check</code> blocks require approved Linux compute.
18. **Density boundary.** List the reference-volume and change-of-variables
    obligations needed before the classical exponential formula could become
    a checked alternative construction.

## Summit summary

The proof dependency chain is now visible in one exact example and in the
general declarations:

\[
\begin{aligned}
&\text{common independent real Gaussian product}\\
&\quad\longrightarrow\text{normalized decoder with }1/\sqrt2\\
&\quad\longrightarrow\text{exact coordinate law and real Frobenius isometry}\\
&\quad\longrightarrow\text{scaled intrinsic standard Gaussian}\\
&\quad\longrightarrow\text{intrinsic unitary-law invariance}\\
&\quad\longrightarrow\text{ambient matrix-law invariance}.
\end{aligned}
\]

For the concrete swap, the matrix changes while its norm remains 15. For the
random ensemble, the pushforward law remains exactly the same. The first fact
illustrates a real isometry; the second is a probability theorem. Neither
requires a density, and neither should be rewritten as pointwise fixedness.

## Where to continue

- {{< refterm "normalized-hermitian-coordinates" "Normalized Hermitian coordinates" >}}
  gives the compact coordinate and factor-two ledger.
- {{< refterm "unitary-invariance" "Unitary invariance" >}} isolates the
  measure-level symmetry definition and its pointwise near-miss.
- [Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}})
  constructs the entrywise coordinate and ambient laws used here.
- [Intrinsic Hermitian Gaussian Symmetry and Matrix-Law Support]({{< relref "/knowledge-base/deep-dives/intrinsic-hermitian-gaussian-symmetry-and-matrix-law-support" >}})
  proves the geometry and full-mass Hermitian facts transported here.
- [First Exact Finite Gaussian Unitary Ensemble Trace Moments]({{< relref "/knowledge-base/deep-dives/first-exact-finite-gue-trace-moments" >}})
  adds the separate integrability and expectation layer.
- [Finite Hermitian Spectra and Empirical Measures]({{< relref "/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures" >}})
  constructs finite spectral observables without treating invariance as a
  substitute for measurability.

## References

**Mathlib contributors.**
[Multivariate Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Multivariate.html),
Mathlib 4 documentation. This is the official API source for
<code>stdGaussian</code>, <code>map_pi_eq_stdGaussian</code>, and
<code>stdGaussian_map</code> under real linear isometries.

**Mathlib contributors.**
[Real Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
[indexed product measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Constructions/Pi.html),
and
[measure maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
Mathlib 4 documentation. These official references specify variance
parameterization, scalar Gaussian transport, finite products, and measurable
pushforward composition.

**Alice Guionnet.**
[Rare Events in Random Matrix Theory](https://ems.press/content/book-chapter-files/33150),
in *Proceedings of the International Congress of Mathematicians 2022*, volume
2, European Mathematical Society Press, 2022,
[doi:10.4171/ICM2022/174](https://doi.org/10.4171/ICM2022/174),
pp. 1008-1052. Section 1.1.1 records the GUE diagonal variance \(1/n\), upper
real and imaginary variances \(1/(2n)\), invariant density convention, and
unitary symmetry. This chapter's checked proof does not use that density.

**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems. I](https://doi.org/10.1063/1.1703773),
*Journal of Mathematical Physics* 3 (1962), 140-156. This primary paper
develops the orthogonal, unitary, and symplectic symmetry-class framework and
its quantum-spectral motivation.

The exact upstream Lean source audited for this chapter is Mathlib commit
[`81a5d257`](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned in <code>formalization/lake-manifest.json</code>.
