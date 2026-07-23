---
title: "Hermitian Spectral Perturbation, Continuity, and Measurability"
slug: "hermitian-spectral-perturbation-continuity-and-measurability"
date: 2026-07-21
summary: "An exact two-by-two perturbation opens a textbook climb from a Frobenius Weyl bound to continuous ordered eigenvalues, measurable finite spectral observables, and a carefully typed Gaussian ensemble pushforward equality."
lead: "Move two entries of a diagonal Hermitian matrix by one half and one quarter. Its ordered energy levels move by exactly those amounts, both inside one square-root-five-over-four Frobenius budget. Lean proves the all-dimensional version, then separately proves continuity, measurability, and the existing random-law pushforward bridge."
draft: false
pro_reviewed: false
level: "Finite-dimensional Hermitian perturbation, Borel spectrum maps, and measurable spectral observables"
reading_time: "120 to 150 minutes"
prerequisites: "Hermitian matrices, finite-dimensional inner-product spaces, ordered eigenvalues, Frobenius norm, elementary measure pushforwards, and the distinction between a sample observable and its probability law; every specialized step is rebuilt along the route"
lean_module: "NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity"
toc: true
og_image: "hermitian-spectral-perturbation-continuity-and-measurability-card.png"
og_image_alt: "For diagonal Hermitian matrices with ordered spectra three and negative one versus five halves and negative three quarters, the entries of B minus A are negative one half and positive one quarter. The absolute eigenvalue shifts are one half and one quarter, and the largest squared shift one quarter is bounded by the squared Frobenius distance five sixteenths."
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
prose, citations, Lean declaration map, figures, and accessibility have not yet
received the required human and Pro reviews. The page is publicly available as
an open working note while those reviews remain pending.
{{< /panel >}}

## Start with one exact two-by-two perturbation

Let

\[
A=
\begin{bmatrix}
3&0\\
0&-1
\end{bmatrix},
\qquad
B=
\begin{bmatrix}
\frac52&0\\
0&-\frac34
\end{bmatrix}.
\]

Both matrices are
{{< refterm "hermitian-matrix" "Hermitian" >}}: each equals its conjugate
transpose. Because the diagonal entries are already decreasing, their ordered
eigenvalue vectors are visible without a characteristic-polynomial
calculation:

An **eigenvalue** \(\lambda\) of a matrix \(M\) is a scalar for which
\(Mv=\lambda v\) for some nonzero vector \(v\). For a diagonal matrix, the
diagonal entries are its eigenvalues, including multiplicity.

\[
\Lambda(A)=(3,-1),
\qquad
\Lambda(B)=\left(\frac52,-\frac34\right).
\]

Match equal positions in these decreasing lists. The two level shifts are

\[
\left|3-\frac52\right|=\frac12,
\qquad
\left|-1-\left(-\frac34\right)\right|=\frac14.
\]

The matrix difference is

\[
A-B=
\begin{bmatrix}
\frac12&0\\
0&-\frac14
\end{bmatrix}.
\]

Its squared Frobenius norm is the sum of the squared entry magnitudes:

\[
\lVert A-B\rVert_F^2
=\left(\frac12\right)^2+\left(-\frac14\right)^2
=\frac14+\frac1{16}
=\frac5{16}.
\]

Therefore

\[
\lVert A-B\rVert_F=\frac{\sqrt5}{4}\approx0.559.
\]

The larger ordered shift is \(1/2=0.5\), so both coordinates satisfy

\[
\left|\lambda_i(A)-\lambda_i(B)\right|
\le \frac12
\le \frac{\sqrt5}{4}
=\lVert A-B\rVert_F.
\]

Nothing statistical happened. We selected two deterministic matrices,
computed their deterministic spectra, and checked one deterministic
inequality. Squaring is legitimate in the exact ledger because every compared
quantity is nonnegative:

\[
\left(\frac12\right)^2=\frac4{16}\le\frac5{16}.
\]

{{< reference-figure
  wide="true"
  src="exact-hermitian-perturbation-ledger.svg"
  alt="For diagonal Hermitian matrices with ordered spectra three and negative one versus five halves and negative three quarters, the entries of B minus A are negative one half and positive one quarter. The absolute eigenvalue shifts are one half and one quarter. Their squared Frobenius distance is five sixteenths, so the largest squared shift one quarter fits inside the exact budget."
  caption="**Finding:** \(B-A\) has diagonal entries \(-1/2\) and \(+1/4\), so equal decreasing ranks move in absolute value by \(1/2\) and \(1/4\). The matrix perturbation has squared Frobenius size \(5/16\), hence distance \(\sqrt5/4\), and the exact comparison \(1/4\le5/16\) verifies the larger shift after squaring. These are deterministic toy matrices, not sampled data, and the figure makes no eigenvector or probability claim."
>}}

### Two near-misses show why the hypotheses are real

#### Near-miss A: reverse one eigenvalue list

Keep the same matrix \(B\), but write its eigenvalues in the opposite order:

\[
\left(-\frac34,\frac52\right).
\]

Comparing the first slot of that list with the first slot of
\(\Lambda(A)\) produces

\[
\left|3-\left(-\frac34\right)\right|
=\frac{15}{4}
\gt\frac{\sqrt5}{4}.
\]

This is not a counterexample. The theorem compares equal positions after both
Hermitian spectra have been sorted in the same decreasing order. An unordered
multiset records which eigenvalues exist, but it does not by itself say which
one on the left corresponds to which one on the right.

#### Near-miss B: leave the Hermitian world

Now consider two real, but non-Hermitian, matrices:

\[
J=
\begin{bmatrix}
0&1\\
0&0
\end{bmatrix},
\qquad
N=
\begin{bmatrix}
0&1\\
\frac1{16}&0
\end{bmatrix}.
\]

Their Frobenius distance is only

\[
\lVert J-N\rVert_F=\frac1{16}.
\]

Both matrices are non-Hermitian, even though the eigenvalues in this exact
pair happen to be real.

The characteristic polynomial is \(\det(tI-M)\); its roots are the
eigenvalues. The characteristic polynomial of \(J\) is \(t^2\), so both
eigenvalues are zero. The characteristic polynomial of \(N\) is
\(t^2-\frac1{16}\), so its eigenvalues are \(1/4\) and \(-1/4\). Thus one
level moves by

\[
\frac14\gt\frac1{16}.
\]

The single pair proves that the Hermitian theorem's constant \(1\) cannot be
extended to all real \(2\)-by-\(2\) matrices that happen to have real spectra
when those real eigenvalues are matched in decreasing order. It says nothing
about every possible non-Hermitian spectral metric or matching convention. To
see the stronger local failure along this particular real-spectrum family, use

\[
N_\varepsilon=
\begin{bmatrix}
0&1\\
\varepsilon&0
\end{bmatrix},
\qquad \varepsilon\gt0.
\]

Then \(J=N_0\),
\(\lVert N_\varepsilon-J\rVert_F=\varepsilon\), and the roots of
\(t^2-\varepsilon\) are
\(\pm\sqrt{\varepsilon}\). The ratio of eigenvalue motion to matrix motion is

\[
\frac{\sqrt{\varepsilon}}{\varepsilon}
=\frac1{\sqrt{\varepsilon}}
\longrightarrow\infty
\qquad\text{as }\varepsilon\downarrow0.
\]

Thus, along the one-sided family
\(\{N_\varepsilon:\varepsilon\ge0\}\), no fixed finite Lipschitz constant works
in any relative neighborhood of the defective matrix \(J\) for the
decreasingly ordered real-eigenvalue map. This is a family-specific local
statement, not a global theorem about every way to compare complex spectra.
The matrix \(J\) is **defective** because it does not have enough linearly
independent eigenvectors to form a basis. Hermiticity supplies the stable
min-max geometry used by the project proof. The checked theorem makes no
non-Hermitian perturbation claim.

{{< reference-figure
  wide="true"
  src="ordering-and-hermitian-near-misses.svg"
  alt="The correct Hermitian comparison has ordered shifts one half and one quarter inside a square-root-five-over-four budget. Reversing the second spectrum creates an invalid slot shift fifteen quarters. Along the real two-by-two non-Hermitian family with nonnegative lower-left entry epsilon, matrix distance from the defective endpoint is epsilon but decreasing-real eigenvalue motion is square root epsilon, so their ratio is unbounded in every relative neighborhood of the endpoint; epsilon one sixteenth gives the executable instance one quarter versus one sixteenth."
  caption="**Finding:** the two main hypotheses do different jobs. A common decreasing order supplies the matching, so reversing one list invalidates the slot comparison without changing either matrix. Hermiticity supplies stable real order statistics. Along the one-sided real-spectrum family \(N_\varepsilon\) with \(\varepsilon\ge0\), the matrix distance from \(J\) is \(\varepsilon\) while decreasing-real eigenvalue motion is \(\sqrt{\varepsilon}\). The ratio \(1/\sqrt{\varepsilon}\) is therefore unbounded in every relative neighborhood of \(J\) inside that family. The executable instance \(\varepsilon=1/16\) gives \(1/4\gt1/16\). This family-specific non-Hermitian boundary failure is not a counterexample to the checked theorem or a global statement about complex-spectrum matchings."
>}}

## Type the exact finite ledger with Lean and <code>Std</code>

The general eigenvalue theorem imports Mathlib and must be checked on approved
Linux cloud compute. Its decisive rational arithmetic fits in a small
standalone worksheet importing only Lean's <code>Std</code> library. This
tutorial represents the two diagonal spectra directly and checks the
non-Hermitian eigenvalues by evaluating their characteristic polynomials. It
does not formalize matrix spectral theory.

Save the following exact file as
<code>/tmp/HermitianPerturbation2.lean</code> on a normal Mac or Linux host:

~~~lean
import Std

namespace HermitianPerturbation2

def sq (x : Rat) : Rat := x * x

def absRat (x : Rat) : Rat :=
  if x < 0 then -x else x

def aSpectrum : List Rat := [3, -1]

def bSpectrum : List Rat := [(5 : Rat) / 2, (-3 : Rat) / 4]

def orderedShifts : List Rat :=
  [absRat (3 - (5 : Rat) / 2), absRat (-1 - (-3 : Rat) / 4)]

def frobeniusSq : Rat :=
  sq (3 - (5 : Rat) / 2) + sq (-1 - (-3 : Rat) / 4)

def maxOrderedShift : Rat :=
  max (absRat (3 - (5 : Rat) / 2)) (absRat (-1 - (-3 : Rat) / 4))

def reversedSlotShift : Rat :=
  absRat (3 - (-3 : Rat) / 4)

structure Matrix2 where
  a11 : Rat
  a12 : Rat
  a21 : Rat
  a22 : Rat
deriving Repr, DecidableEq

def trace (M : Matrix2) : Rat := M.a11 + M.a22

def det (M : Matrix2) : Rat := M.a11 * M.a22 - M.a12 * M.a21

def charAt (M : Matrix2) (lambda : Rat) : Rat :=
  sq lambda - trace M * lambda + det M

def frobeniusSqDiff (M N : Matrix2) : Rat :=
  sq (M.a11 - N.a11) + sq (M.a12 - N.a12) +
    sq (M.a21 - N.a21) + sq (M.a22 - N.a22)

def jordan : Matrix2 :=
  { a11 := 0, a12 := 1, a21 := 0, a22 := 0 }

def perturbedJordan : Matrix2 :=
  { a11 := 0, a12 := 1, a21 := (1 : Rat) / 16, a22 := 0 }

#eval orderedShifts
#eval frobeniusSq
#eval (sq maxOrderedShift, decide (sq maxOrderedShift <= frobeniusSq))
#eval (reversedSlotShift, decide (sq reversedSlotShift <= frobeniusSq))
#eval [charAt jordan 0, charAt perturbedJordan ((1 : Rat) / 4),
  charAt perturbedJordan ((-1 : Rat) / 4)]
#eval (frobeniusSqDiff jordan perturbedJordan, sq ((1 : Rat) / 4),
  decide (sq ((1 : Rat) / 4) <= frobeniusSqDiff jordan perturbedJordan))

example : orderedShifts = [(1 : Rat) / 2, (1 : Rat) / 4] := by
  native_decide
example : frobeniusSq = (5 : Rat) / 16 := by native_decide
example : sq maxOrderedShift <= frobeniusSq := by native_decide
example : not (sq reversedSlotShift <= frobeniusSq) := by native_decide
example : charAt jordan 0 = 0 := by native_decide
example : charAt perturbedJordan ((1 : Rat) / 4) = 0 := by native_decide
example : charAt perturbedJordan ((-1 : Rat) / 4) = 0 := by native_decide
example : frobeniusSqDiff jordan perturbedJordan = (1 : Rat) / 256 := by
  native_decide
example : not (sq ((1 : Rat) / 4) <=
    frobeniusSqDiff jordan perturbedJordan) := by native_decide

end HermitianPerturbation2
~~~

Type:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean \
  /tmp/HermitianPerturbation2.lean
~~~

The exact worksheet was executed successfully with Lean 4.32.0 on the Mac
workstation. It printed:

~~~text
[(1 : Rat)/2, (1 : Rat)/4]
(5 : Rat)/16
((1 : Rat)/4, true)
((15 : Rat)/4, false)
[0, 0, 0]
((1 : Rat)/256, (1 : Rat)/16, false)
~~~

The first boolean verifies the squared Hermitian budget. The second rejects
the reversed-slot comparison. The three zeros certify that \(0\) is a root for
\(J\) and that \(1/4,-1/4\) are roots for \(N\). The last tuple compares the
squared non-Hermitian matrix distance \(1/256\) with the squared level motion
\(1/16\) and correctly returns <code>false</code>.

<code>Rat</code> provides exact rational arithmetic. <code>decide</code>
computes a boolean decision for a proposition, while
<code>native_decide</code> closes a proposition by trusted kernel-checked
reflection after native evaluation. The worksheet checks the finite ledger,
not the general eigenvalue theorem, continuity, measurability, or any
probability law.

## What the checked module proves

The preceding spectral layer attached a decreasing real eigenvalue vector to
every finite intrinsic Hermitian matrix. It then turned that vector into a
spectral counting measure and a zero-aware
{{< refterm "empirical-spectral-measure" "empirical spectral measure" >}}.
Those constructions were algebraically complete, but their measure-valued
maps were conditionally measurable: each theorem asked the caller to prove
that every ordered eigenvalue coordinate was measurable.

RMT-10B closes that seam. Its central deterministic estimate is

\[
\boxed{
\left|\lambda_i(A)-\lambda_i(B)\right|
\le \lVert A-B\rVert_F
}
\]

for two \(n\)-by-\(n\) Hermitian matrices \(A\) and \(B\), with both spectra
listed in decreasing order and \(i\in\operatorname{Fin}(n)\). The norm is the
intrinsic {{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius norm" >}}.

The estimate is strong enough to make each coordinate 1-Lipschitz and the full
ordered vector 1-Lipschitz for the finite function-space sup metric. Lipschitz
maps are continuous; continuous maps between the Borel spaces in use are
measurable. Here a Borel measurable structure is generated by the open sets of
the surrounding topology. The conditional measure-valued interfaces from
RMT-10A can therefore be discharged, including the equality between the
empirical-spectral pushforwards of the ambient and intrinsic Gaussian unitary
ensemble (GUE) laws.

The proof is deliberately finite and structural. It does not import an
operator-norm Weyl theorem. Instead it builds an ordered eigenbasis, forms top
and bottom spectral subspaces, forces them to intersect by dimension, and
uses a vector in that intersection to compare two quadratic forms. That route
makes every hypothesis and every norm visible in Lean.

### Three layers that must not collapse

The word "spectrum" can refer to several typed objects here. Keep this ledger
in view. Write \(\mathcal H_n\) for the space of \(n\)-by-\(n\) Hermitian
matrices with the intrinsic Frobenius metric. Mathlib's **Giry measurable
structure** on <code>Measure ℝ</code> is generated by the evaluation maps
\(\mu\mapsto\mu(S)\) for measurable sets \(S\). It lets a measure itself be the
output of a measurable map without first choosing a topology on the space of
measures.

| Layer | Exact object | What RMT-10B proves | What it does not yet do |
|---|---|---|---|
| Deterministic ordered spectrum | \(\Lambda:\mathcal H_n\to(\operatorname{Fin}(n)\to\mathbb R)\) | Frobenius 1-Lipschitz, continuous, and Borel measurable | Select a random matrix or define a probability law |
| Deterministic measure-valued observable | \(L:\mathcal H_n\to\operatorname{Measure}(\mathbb R)\) | Giry measurability of counting and empirical spectral maps | Prove weak or Wasserstein continuity, or produce a density |
| Random output law | \(\mu\mapsto L_*\mu\) after a source law \(\mu\) is supplied | Equality of the ambient and intrinsic GUE pushforwards already present in the API | Introduce the later dedicated name, calculate its density, or prove an asymptotic law |

A {{< refterm "measurable-function" "measurable function" >}} is a
deterministic map with a preimage property. A
{{< refterm "pushforward-measure" "pushforward" >}} uses such a map together
with an input measure to create an output measure. A
{{< refterm "probability-law" "probability law" >}} is therefore not another
word for continuity or measurability. RMT-10B proves the map properties first
and invokes the existing GUE input laws only in its final theorem.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [The exact two-by-two perturbation](#start-with-one-exact-two-by-two-perturbation) | Compute the ordered shifts and Frobenius budget before meeting the general theorem |
| Hands-on route | [The standalone worksheet](#type-the-exact-finite-ledger-with-lean-and-std) | Check the rational ledger locally without Mathlib or Lake |
| Norm route | [Frobenius control of matrix-vector multiplication](#base-camp-one-frobenius-control-of-matrix-vector-multiplication) | Prove the analytic estimate that bounds quadratic-form change |
| Spectral route | [Reindex the eigenbasis in the same order](#base-camp-two-reindex-the-eigenbasis-in-the-same-order) | Align eigenvectors with the decreasing eigenvalue API |
| Min-max route | [Top and bottom spectral subspaces](#camp-two-top-and-bottom-spectral-subspaces) | Build the nonzero intersection witness |
| Inequality route | [The one-sided Weyl estimate](#camp-four-the-one-sided-weyl-estimate) | Derive the absolute coordinate bound |
| Topology route | [From coordinates to a Lipschitz vector](#camp-five-from-coordinates-to-a-lipschitz-vector) | Separate coordinate and finite sup-metric claims |
| Probability route | [From continuity to Giry measurability](#camp-six-from-continuity-to-giry-measurability) | Remove the earlier measure-valued hypotheses |
| Physics route | [Energy levels under a Hamiltonian perturbation](#physics-camp-energy-levels-under-a-hamiltonian-perturbation) | Interpret the theorem without inventing a probabilistic result |
| Lean audit route | [The complete public API](#the-complete-public-api) | Map every public declaration to its exact role |

### Learning objectives

By the summit, you should be able to:

1. distinguish the Frobenius norm from the spectral operator norm;
2. derive the matrix-vector estimate used by the proof;
3. explain why the eigenbasis must be reindexed by the same order-preserving
   cast as the eigenvalue vector;
4. expand a Hermitian quadratic form as a weighted sum of squared eigenbasis
   coordinates;
5. define the top \(i+1\) and bottom \(n-i\) spectral subspaces;
6. prove that those two subspaces have a nonzero intersection;
7. explain why the intersection vector is the finite min-max witness;
8. derive the one-sided ordered-eigenvalue estimate;
9. obtain the absolute bound by swapping the two matrices;
10. state the coordinatewise 1-Lipschitz theorem;
11. identify the whole-vector target metric as the finite sup metric rather
    than an \(\ell^2\) eigenvalue metric;
12. follow the implication from Lipschitz to continuous to measurable;
13. explain how coordinate measurability makes a finite Dirac sum measurable;
14. state the now-unconditional counting, empirical, and ambient spectral
    measurability theorems;
15. draw the intrinsic-versus-ambient GUE pushforward square;
16. distinguish eigenvalue continuity from eigenvector continuity;
17. distinguish this theorem from Hoffman-Wielandt and Davis-Kahan; and
18. list the density, concentration, differentiability, gap, and asymptotic
    results that RMT-10B does not prove.

## The result in one picture

{{< reference-figure
  src="intersection-to-measurable-law.svg"
  alt="Top spectral modes of a first Hermitian matrix and bottom spectral modes of a second matrix overlap by dimension. A shared nonzero witness lets quadratic forms squeeze one ordered eigenvalue. Swapping the matrices gives a two-sided bound, continuity makes the counting and empirical spectral sample maps measurable, and that separate map property licenses the ambient versus intrinsic Gaussian ensemble pushforward equality."
  caption="**Finding:** the bridge from algebra to probability is earned by one deterministic witness, but it still has two distinct final steps. A dimension-forced intersection compares the same vector against both quadratic forms; the resulting coordinate bound yields continuity and then measurability of the counting and empirical spectral sample maps. Only after that map-level result does the module prove the separate ambient-versus-intrinsic Gaussian unitary ensemble pushforward equality. This proof ladder does not control eigenvectors, prove a full-spectrum Euclidean estimate, or add a Gaussian ensemble density or limit theorem."
>}}

The figure compresses three mathematical layers that must stay separate:

1. **Linear algebra:** an ordered eigenbasis and two spectral subspaces produce
   a nonzero common vector.
2. **Analysis:** a matrix-vector norm estimate bounds the change in a
   quadratic form and therefore the change in an ordered eigenvalue.
3. **Measurable probability:** continuity of the eigenvalue coordinates makes
   the finite atomic spectral observables measurable, so probability laws may
   be pushed through them without a conditional premise.

No probability distribution is used to prove the perturbation bound. GUE
enters only at the final pushforward comparison.

{{< checkpoint stage="Orientation" title="The theorem boundary in one sentence" >}}
RMT-10B proves deterministic Frobenius 1-Lipschitz control of the decreasing
Hermitian eigenvalue vector and uses it to establish measurability of existing
finite spectral observables. It does not prove stability of eigenvectors,
probabilistic concentration, a density, or any large-dimension limit.
{{< /checkpoint >}}

## Base camp zero: spaces, norms, and indexing

The source type is
<code>RandomMatrix.HermitianEuclidean n</code>. It is the real Euclidean
subspace of complex matrices satisfying \(H^*=H\), where \(H^*\) is the
conjugate transpose. Its norm is inherited from the ambient Frobenius space:

\[
\lVert H\rVert_F^2
=\sum_{j,k}|H_{jk}|^2
=\operatorname{Tr}(H^2).
\]

The last equality uses Hermiticity. It should not be transferred unchanged to
an arbitrary complex matrix.

Vectors live in <code>EuclideanSpace ℂ (Fin n)</code>, with the ordinary
complex Euclidean norm. Matrix-vector multiplication is written
<code>A *ᵥ x</code>. The conversion <code>WithLp.toLp 2</code> packages the
resulting coordinate function as the Euclidean-space value expected by the
norm and inner-product APIs.

The ordered spectrum from RMT-10A is

\[
\Lambda(H)
=\bigl(\lambda_0(H),\ldots,\lambda_{n-1}(H)\bigr),
\qquad
\lambda_0(H)\ge\cdots\ge\lambda_{n-1}(H).
\]

Indices start at zero. Thus “top through \(i\)” contains \(i+1\) slots, while
“bottom from \(i\)” contains \(n-i\) slots. This arithmetic is the engine of
the later intersection proof.

### Frobenius versus operator norm

The Frobenius norm measures the Euclidean size of all matrix entries. The
\(\ell^2\) operator norm measures the largest vector amplification:

\[
\lVert A\rVert_{\mathrm{op}}
=\sup_{\lVert x\rVert=1}\lVert Ax\rVert.
\]

For a finite matrix,

\[
\lVert A\rVert_{\mathrm{op}}\le\lVert A\rVert_F.
\]

The sharp classical Weyl perturbation theorem is commonly stated with the
operator norm. The checked module proves a Frobenius statement directly
because the project already has a carefully audited intrinsic Frobenius
geometry. Saying “Weyl bound” here therefore names the ordered-eigenvalue
perturbation pattern; the exact formal theorem uses \(\lVert\cdot\rVert_F\).
The {{< refterm "weyl-eigenvalue-bound" "Weyl eigenvalue bound" >}} entry keeps
this distinction available as a compact reference.

## Base camp one: Frobenius control of matrix-vector multiplication

The first public theorem is more general than the later Hermitian result. For
any complex square matrix \(M\) and Euclidean vector \(x\),

\[
\lVert Mx\rVert_2
\le\lVert M\rVert_F\lVert x\rVert_2.
\]

### In Lean: one matrix-vector application

{{< lean-bridge
  human="Multiplying a complex square matrix by a vector cannot produce a Euclidean norm larger than the matrix's Frobenius norm times the vector norm."
  math="\(\lVert Ax\rVert_2\le\lVert A\rVert_F\lVert x\rVert_2.\)"
  lean="RandomMatrix.norm_mulVec_le_frobenius A x"
>}}

- <code>RandomMatrix</code> is the project namespace for the finite matrix
  geometry.
- <code>A : Matrix (Fin n) (Fin n) ℂ</code> is any complex square matrix; this
  first theorem does not assume Hermiticity.
- <code>x : EuclideanSpace ℂ (Fin n)</code> is a complex Euclidean vector.
- <code>*ᵥ</code>, visible in the theorem's result, is matrix-vector
  multiplication.
- <code>WithLp.toLp 2</code> packages the coordinate function with its
  Euclidean \(2\)-norm.
- <code>matrixToFrobenius A</code> views all matrix entries as one Euclidean
  vector, so its norm is the Frobenius norm.
- Applying the declaration returns a proof of an inequality. It does not
  calculate an eigenvalue.
{{< /lean-bridge >}}

The proof reuses Mathlib's Frobenius submultiplicativity rather than expanding
every coordinate and running Cauchy-Schwarz by hand. Regard \(x\) as the single
column of an \(n\)-by-\(1\) matrix. Then

\[
Mx=M\,\operatorname{col}(x),
\]

and

\[
\begin{aligned}
\lVert Mx\rVert_2
&=\lVert M\,\operatorname{col}(x)\rVert_F\\
&\le\lVert M\rVert_F\,
     \lVert\operatorname{col}(x)\rVert_F\\
&=\lVert M\rVert_F\lVert x\rVert_2.
\end{aligned}
\]

The private lemma <code>norm_matrixToFrobenius_eq_frobenius</code> aligns the
norm on the project's flattened Frobenius carrier with Mathlib's matrix
Frobenius norm. The official matrix-norm documentation emphasizes that
Mathlib has several matrix norms and deliberately exposes them through scoped
instances; importing or opening the wrong scope would change the meaning of
the displayed norm
([Mathlib contributors](#ref-perturb-mathlib-normed)).

### The quadratic-form difference bound

For an intrinsic Hermitian matrix \(H\), define the real quadratic form

\[
q_H(x)=\operatorname{Re}\langle x,Hx\rangle.
\]

The real part makes the codomain explicit. Hermiticity implies the inner
product is real, but the ambient complex inner-product API still returns a
complex number.

Apply the matrix-vector theorem to \(A-B\), then use the inner-product
Cauchy-Schwarz inequality:

\[
\begin{aligned}
|q_A(x)-q_B(x)|
&=\left|\operatorname{Re}\langle x,(A-B)x\rangle\right|\\
&\le\left|\langle x,(A-B)x\rangle\right|\\
&\le\lVert x\rVert\,\lVert(A-B)x\rVert\\
&\le\lVert A-B\rVert_F\lVert x\rVert^2.
\end{aligned}
\]

The module keeps <code>hermitianQuadratic</code> and this difference theorem
private. They are proof architecture, not a parallel public quadratic-form
library.

## Base camp two: reindex the eigenbasis in the same order

Mathlib's finite Hermitian spectral theorem supplies an orthonormal eigenbasis
and an ordered real eigenvalue vector
([Mathlib contributors](#ref-perturb-mathlib-spectrum)). RMT-10A transported
the ordered vector from <code>Fin (Fintype.card (Fin n))</code> to
<code>Fin n</code> using an order-preserving cast.

RMT-10B must perform the same transport on the eigenbasis. Otherwise the basis
coordinate at index \(i\) and the ordered eigenvalue at index \(i\) could refer
to different slots. The private
<code>orderedHermitianEigenvectorBasis</code> reindexes Mathlib's basis by the
same finite order equivalence.

The key action theorem then reads, schematically,

\[
\widehat{Hx}_j=\lambda_j(H)\widehat{x}_j,
\]

where \(\widehat{x}_j\) is the \(j\)-th coordinate of \(x\) in the ordered
eigenbasis. This gives the weighted expansion

\[
q_H(x)=\sum_j\lambda_j(H)|\widehat{x}_j|^2.
\]

Orthonormality also gives Parseval's identity:

\[
\lVert x\rVert^2=\sum_j|\widehat{x}_j|^2.
\]

These two formulas translate ordering information into inequalities for whole
subspaces. The private helper <code>re_inner_real_mul_self</code> handles the
small complex-arithmetic step that turns the real part of an inner product
with a real scalar into a real scalar times a squared norm.

## Camp two: top and bottom spectral subspaces

Fix \(i\in\operatorname{Fin}(n)\). For the first matrix \(A\), define the top
spectral subspace

\[
T_A(i)
=\operatorname{span}\{u_j(A):j\le i\}.
\]

It contains the first \(i+1\) ordered eigenvectors, so

\[
\dim_{\mathbb C}T_A(i)=i+1.
\]

For the second matrix \(B\), define the bottom spectral subspace

\[
S_B(i)
=\operatorname{span}\{u_j(B):i\le j\}.
\]

It contains the last \(n-i\) ordered eigenvectors, so

\[
\dim_{\mathbb C}S_B(i)=n-i.
\]

The module defines these subspaces using <code>Set.Iic i</code> and
<code>Set.Ici i</code>, the closed lower and upper order intervals. It proves
their dimensions from linear independence of subsets of an orthonormal basis.

### Why top vectors bound from below

If \(x\in T_A(i)\), every eigenbasis coordinate with \(j\gt i\) is zero. For
the remaining coordinates, decreasing order gives
\(\lambda_j(A)\ge\lambda_i(A)\). Therefore

\[
\begin{aligned}
q_A(x)
&=\sum_{j\le i}\lambda_j(A)|\widehat{x}_j|^2\\
&\ge\lambda_i(A)\sum_{j\le i}|\widehat{x}_j|^2\\
&=\lambda_i(A)\lVert x\rVert^2.
\end{aligned}
\]

The private support lemma
<code>ordered_repr_eq_zero_of_mem_top</code> supplies the vanishing
coordinates.

### Why bottom vectors bound from above

If \(x\in S_B(i)\), every coordinate with \(j\lt i\) is zero. For the remaining
coordinates, \(\lambda_j(B)\le\lambda_i(B)\). Hence

\[
q_B(x)\le\lambda_i(B)\lVert x\rVert^2.
\]

This is the mirror image of the top-space argument, with
<code>ordered_repr_eq_zero_of_mem_bottom</code> supplying the support fact.

## Camp three: dimension forces a common witness

Both subspaces sit in the \(n\)-dimensional complex Euclidean space. Their
dimensions add to

\[
(i+1)+(n-i)=n+1.
\]

Two disjoint subspaces of an \(n\)-dimensional space can have total dimension
at most \(n\). Therefore

\[
T_A(i)\cap S_B(i)\ne\{0\}.
\]

Choose a nonzero vector \(x\) in the intersection. It is simultaneously a top
combination for \(A\) and a bottom combination for \(B\), so the two previous
inequalities apply to the same vector:

\[
\lambda_i(A)\lVert x\rVert^2
\le q_A(x),
\qquad
q_B(x)\le\lambda_i(B)\lVert x\rVert^2.
\]

This is the heart of the finite min-max argument. The proof does not need to
choose one eigenvector shared by \(A\) and \(B\), which generally would not
exist. It chooses a vector shared by two deliberately oversized spectral
subspaces.

In Lean, <code>ordered_top_inf_bottom_ne_bot</code> proves that the infimum of
the two submodules is not bottom. It argues by contradiction: disjointness
would invoke Mathlib's finite-rank inequality, while the already calculated
dimensions reduce that inequality to impossible natural-number arithmetic.

## Camp four: the one-sided Weyl estimate

Subtract the two quadratic inequalities:

\[
\bigl(\lambda_i(A)-\lambda_i(B)\bigr)\lVert x\rVert^2
\le q_A(x)-q_B(x).
\]

The quadratic-form difference bound gives

\[
q_A(x)-q_B(x)
\le |q_A(x)-q_B(x)|
\le\lVert A-B\rVert_F\lVert x\rVert^2.
\]

Because \(x\ne0\), its squared norm is positive and can be cancelled. The
result is

\[
\lambda_i(A)\le\lambda_i(B)+\lVert A-B\rVert_F.
\]

This is the public theorem
<code>orderedHermitianEigenvalues_le_add_frobenius</code>. The one-sided form
is a useful interface in its own right: many real-valued Lipschitz lemmas are
designed around a bound of the form \(f(A)\le f(B)+K\,d(A,B)\).

Swap \(A\) and \(B\). Symmetry of the norm gives

\[
\lambda_i(B)\le\lambda_i(A)+\lVert A-B\rVert_F.
\]

Combining both sides yields

\[
\left|\lambda_i(A)-\lambda_i(B)\right|
\le\lVert A-B\rVert_F,
\]

the public theorem
<code>abs_orderedHermitianEigenvalues_sub_le_frobenius</code>.

### In Lean: the ordered coordinate bound

{{< lean-bridge
  human="At the same decreasing rank i, the real eigenvalues of Hermitian matrices A and B differ by at most their intrinsic Frobenius distance."
  math="\(\left|\lambda_i(A)-\lambda_i(B)\right|\le\lVert A-B\rVert_F.\)"
  lean="RandomMatrix.abs_orderedHermitianEigenvalues_sub_le_frobenius A B i"
>}}

- <code>A B : RandomMatrix.HermitianEuclidean n</code> makes Hermiticity part
  of the input type rather than an after-the-fact premise.
- <code>i : Fin n</code> is one valid zero-based rank.
- <code>orderedHermitianEigenvalues</code> uses a decreasing enumeration, so
  equal indices encode the matching rule.
- <code>abs</code> appears in the declaration name because the conclusion is
  the absolute real difference.
- <code>sub</code> refers first to the eigenvalue subtraction and then, on the
  right, to the intrinsic matrix subtraction \(A-B\).
- <code>le_frobenius</code> records the exact checked norm. It does not claim
  the sharper operator-norm theorem.
{{< /lean-bridge >}}

{{< repo-check >}}
The authoritative source is
[<code>formalization/NonlinearDynamics/Random/RandomMatrices/HermitianSpectrumContinuity.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/HermitianSpectrumContinuity.lean).
On an approved Linux builder with the pinned project cache, put this exact
source in a temporary project scratch file:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity

open NonlinearDynamics.Random

#check RandomMatrix.norm_mulVec_le_frobenius
#check RandomMatrix.orderedHermitianEigenvalues_le_add_frobenius
#check RandomMatrix.abs_orderedHermitianEigenvalues_sub_le_frobenius
~~~

<code>#check</code> asks Lean to elaborate each declaration and display its
type. The guarded command rendered below checks the complete Mathlib-backed
module. It belongs on approved Linux cloud compute, not on this Mac.
{{< /repo-check >}}

### A diagonal check

Suppose \(A\) and \(B\) are already diagonal in the same basis, with
decreasing diagonals \(a_0,\ldots,a_{n-1}\) and
\(b_0,\ldots,b_{n-1}\). Then

\[
|a_i-b_i|
\le\left(\sum_j|a_j-b_j|^2\right)^{1/2}
=\lVert A-B\rVert_F.
\]

The theorem reduces to the fact that one coordinate of a Euclidean vector is
at most its total Euclidean length. The full proof earns the same conclusion
when the two matrices have unrelated eigenbases.

### Dimension zero

When \(n=0\), there is no value of type <code>Fin 0</code>. Every theorem that
takes an eigenvalue index is vacuous rather than false. The whole-vector map
lands in the unique empty function and is still 1-Lipschitz. No artificial
eigenvalue or fallback coordinate is introduced.

## Camp five: from coordinates to a Lipschitz vector

For each fixed \(i\), the absolute bound is exactly the metric inequality

\[
d_{\mathbb R}\bigl(\lambda_i(A),\lambda_i(B)\bigr)
\le 1\cdot d_F(A,B).
\]

### In Lean: scalar and vector metrics

{{< lean-bridge
  human="For one fixed rank i, the ordered eigenvalue is a 1-Lipschitz real-valued function of the intrinsic Hermitian matrix."
  math="\(d_{\mathbb R}(\lambda_i(A),\lambda_i(B))\le 1\cdot d_F(A,B).\)"
  lean="RandomMatrix.lipschitzWith_orderedHermitianEigenvalues_apply i"
>}}

- <code>lipschitzWith</code> names Mathlib's predicate
  <code>LipschitzWith</code>.
- The numeral <code>1</code> is inferred as <code>NNReal</code>, the type of
  nonnegative real constants accepted by that predicate.
- <code>_apply i</code> specializes the ordered vector to the fixed coordinate
  <code>i : Fin n</code>.
- The source metric is the norm distance on
  <code>RandomMatrix.HermitianEuclidean n</code>; the target is the usual real
  distance.
- The theorem is global: it quantifies over every pair of intrinsic Hermitian
  matrices of the fixed size.
{{< /lean-bridge >}}

The constant has type <code>NNReal</code>, a nonnegative real number. The
official <code>LipschitzWith</code> API defines the predicate by a distance
inequality and supplies continuity as a theorem
([Mathlib contributors](#ref-perturb-mathlib-lipschitz)).

The full map

\[
\Lambda:\mathcal H_n\longrightarrow(\operatorname{Fin}(n)\to\mathbb R)
\]

is also 1-Lipschitz.

{{< lean-bridge
  human="The complete decreasing eigenvalue vector is 1-Lipschitz when finite real functions carry their sup metric."
  math="\(d_{\infty}(\Lambda(A),\Lambda(B))=\max_i|\lambda_i(A)-\lambda_i(B)|\le d_F(A,B)\) for positive dimension, with the empty function handled directly at dimension zero."
  lean="RandomMatrix.lipschitzWith_orderedHermitianEigenvalues"
>}}

- The missing <code>_apply i</code> means the output is the whole function
  <code>Fin n → ℝ</code>, not one coordinate.
- <code>@orderedHermitianEigenvalues n</code>, visible in the theorem's type,
  makes the implicit dimension argument explicit.
- Mathlib's metric on a finite function space is the uniform, or sup, metric.
- The proof uses <code>dist_pi_le_iff</code> to reduce the function distance to
  all coordinate distances.
- This does not give the Euclidean \(\ell^2\) distance between the two
  eigenvalue vectors. That different conclusion belongs to
  Hoffman-Wielandt-type theory.
{{< /lean-bridge >}}

The target is an ordinary finite function type with Mathlib's uniform
function-space metric. The proof invokes <code>dist_pi_le_iff</code> and checks
the distance bound coordinate by coordinate. In familiar finite-dimensional
language, this is the sup estimate

\[
\max_i|\lambda_i(A)-\lambda_i(B)|
\le\lVert A-B\rVert_F
\]

when the index type is nonempty. The formal statement also covers the empty
index type without inventing a maximum of an empty set.

{{< repo-check >}}
On an approved Linux builder with the pinned project cache, a human can place
these exact lines in a temporary project scratch file:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity

open NonlinearDynamics.Random

#check RandomMatrix.lipschitzWith_orderedHermitianEigenvalues_apply
#check RandomMatrix.lipschitzWith_orderedHermitianEigenvalues
~~~

The first result targets \(\mathbb R\); the second targets
<code>Fin n → ℝ</code>. The guarded command rendered below type-checks their
authoritative Mathlib-backed module only on approved Linux cloud compute.
{{< /repo-check >}}

### What “1-Lipschitz” does and does not say

It says that \(1\) is a globally valid Lipschitz constant for the displayed
source and target metrics. It does not prove that \(1\) is the smallest
possible constant on every restricted subset. It does not replace the
Frobenius source norm by the operator norm. It also does not change the target
to a Euclidean \(\ell^2\) norm.

The last distinction matters. Hoffman-Wielandt controls a matched
full-spectrum \(\ell^2\) cost by the Frobenius matrix distance for normal
matrices ([Hoffman and Wielandt](#ref-perturb-hoffman-wielandt)). RMT-10B
proves a coordinate bound and packages those coordinates in the finite sup
metric. The two conclusions are related, but they are not the same theorem.

## Camp six: from continuity to Giry measurability

A Lipschitz map is continuous. The module records both coordinatewise and
whole-vector forms. These are still deterministic statements about functions
between metric spaces. No matrix has yet been sampled from a probability law.

The intrinsic Hermitian space and finite real function space carry their Borel
measurable structures. Continuity therefore supplies both coordinate and
whole-vector measurability.

### In Lean: a measurable ordered-vector map

{{< lean-bridge
  human="The function that sends an intrinsic Hermitian matrix to its complete decreasing real eigenvalue vector is Borel measurable."
  math="\(\Lambda:\mathcal H_n\to(\operatorname{Fin}(n)\to\mathbb R)\text{ is measurable}.\)"
  lean="RandomMatrix.measurable_orderedHermitianEigenvalues"
>}}

- <code>measurable</code> is Mathlib's ordinary
  <code>Measurable</code> predicate for the source and target measurable
  spaces.
- <code>orderedHermitianEigenvalues</code> returns the whole function
  <code>Fin n → ℝ</code>.
- The theorem has no measure argument. It says the deterministic map is
  measurable before any random input law is selected.
- Its proof is
  <code>continuous_orderedHermitianEigenvalues.measurable</code>: the topology
  supplies the Borel measurable structure.
- The neighboring declaration with suffix <code>_apply i</code> proves the
  corresponding scalar-coordinate statement.
{{< /lean-bridge >}}

These are ordinary <code>Measurable</code> statements, not only
almost-everywhere measurability under one selected law.

{{< repo-check >}}
On approved Linux cloud compute, put these exact lines in a temporary project
scratch file:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity

open NonlinearDynamics.Random

#check RandomMatrix.continuous_orderedHermitianEigenvalues_apply
#check RandomMatrix.continuous_orderedHermitianEigenvalues
#check RandomMatrix.measurable_orderedHermitianEigenvalues_apply
#check RandomMatrix.measurable_orderedHermitianEigenvalues
~~~

The declarations expose two independent distinctions: one coordinate versus
the whole vector, and continuity versus Borel measurability. The guarded
command below checks the pinned project module and its Mathlib dependencies in
the cloud.
{{< /repo-check >}}

### From coordinates to a measure-valued map

RMT-10A had already proved a conditional theorem. If every coordinate
\(H\mapsto\lambda_i(H)\) is measurable, then so is

\[
H\longmapsto\sum_i\delta_{\lambda_i(H)}.
\]

The reason is compositional:

1. a measurable real-valued coordinate can be inserted into the measurable
   Dirac map;
2. finitely many measurable measure-valued maps can be added; and
3. multiplication by the fixed inverse-dimension scalar is measurable.

The target <code>Measure ℝ</code> uses Mathlib's Giry measurable structure,
generated by evaluating a measure on measurable sets
([Giry](#ref-perturb-giry);
[Mathlib contributors](#ref-perturb-mathlib-giry)). Mathlib applies this
measurable-space construction to all measures, not only probability measures.
RMT-10B supplies the missing coordinate premise and exposes unconditional
theorems.

### In Lean: the empirical-measure observable is measurable

{{< lean-bridge
  human="Sending an intrinsic Hermitian matrix to its zero-aware empirical spectral measure is a measurable map into the space of real measures."
  math="\(H\mapsto L_H=\frac1n\sum_{i=0}^{n-1}\delta_{\lambda_i(H)}\text{ is Giry-measurable for }n\gt0,\text{ with }L_H=0\text{ at }n=0.\)"
  lean="RandomMatrix.measurable_empiricalSpectralMeasure"
>}}

- <code>empiricalSpectralMeasure</code> is a sample observable
  <code>HermitianEuclidean n → Measure ℝ</code>.
- <code>measurable_...</code> proves a property of that observable; it is not
  itself a probability law.
- The target <code>Measure ℝ</code> uses Mathlib's Giry measurable structure,
  not a weak, Wasserstein, or total-variation metric.
- <code>spectralCountingMeasure</code> first sums one Dirac mass per ordered
  index, including multiplicity.
- Fixed scaling by the inverse dimension produces the empirical measure.
  Dimension zero follows its explicit zero-measure policy.
- The positive-dimensional sibling
  <code>measurable_empiricalSpectralProbability n</code> targets bundled
  <code>ProbabilityMeasure ℝ</code> values from size \(n+1\) matrices.
{{< /lean-bridge >}}

The second map returns the zero measure at dimension zero. The third has source
<code>HermitianEuclidean (n + 1)</code> and returns a bundled
<code>ProbabilityMeasure ℝ</code>, so positive dimension is encoded in the
type.

This measurable result is not a continuity theorem for empirical measures in a
weak, Wasserstein, or total-variation topology. The module uses the Giry
measurable space and proves exactly the measurable statements displayed above.

{{< repo-check >}}
On an approved Linux builder, the exact measure-valued interfaces can be
inspected with:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity

open NonlinearDynamics.Random

#check RandomMatrix.measurable_spectralCountingMeasure
#check RandomMatrix.measurable_empiricalSpectralMeasure
#check RandomMatrix.measurable_empiricalSpectralProbability
~~~

These checks elaborate map measurability. They neither draw a random matrix
nor name a pushforward law. The guarded command below checks the authoritative
module on cloud compute.
{{< /repo-check >}}

## Camp seven: the ambient observable and the GUE bridge

The intrinsic empirical measure accepts only a value already certified
Hermitian. The ambient GUE matrix law lives on all complex matrices. RMT-10A
connected the two with
<code>matrixToHermitianOrZero</code>:

\[
A\longmapsto
\begin{cases}
\text{the intrinsic value represented by }A, & A\text{ Hermitian},\\
0, & A\text{ otherwise}.
\end{cases}
\]

Composing with the empirical spectral measure gives
<code>ambientEmpiricalSpectralMeasure n</code>. The fallback is an extension
policy, not a spectral calculation for a non-Hermitian matrix. RMT-10B now
proves <code>measurable_ambientEmpiricalSpectralMeasure n</code>
unconditionally. This is still a measurability theorem for one deterministic
observable on the ambient matrix space.

The earlier GUE geometry established

\[
\operatorname{GUE.matrixLaw}_n
= (\operatorname{hermitianToMatrix})_*
\operatorname{GUE.intrinsicLaw}_n.
\]

On an intrinsic Hermitian input, the ambient totalizer followed by the
empirical measure equals the intrinsic empirical measure. Measurability now
allows the pushforwards to compose honestly.

### In Lean: push forward the random input law

{{< lean-bridge
  human="Pushing the ambient finite Gaussian unitary ensemble matrix law through the Hermitian-or-zero empirical spectral observable gives the same outer law as pushing the intrinsic Hermitian law through the intrinsic empirical spectral observable."
  math="\((L_{\mathrm{ambient}})_*(\mu_n^{\mathrm{matrix}})=L_*(\mu_n^{\mathrm{intrinsic}})\text{ as measures on }\operatorname{Measure}(\mathbb R).\)"
  lean="RandomMatrix.map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw n"
>}}

- <code>GUE.matrixLaw n</code>, visible on the theorem's left side, is a
  probability measure on ambient complex matrices.
- <code>ambientEmpiricalSpectralMeasure n</code> is the measurable
  Hermitian-or-zero sample map applied before the left pushforward.
- <code>GUE.intrinsicLaw n</code> is a probability measure on the intrinsic
  Hermitian carrier.
- <code>empiricalSpectralMeasure</code> is the intrinsic sample map applied
  before the right pushforward.
- <code>Measure.map</code>, written <code>.map</code>, is pushforward. Each
  side is therefore a measure whose outcomes are themselves measures on
  \(\mathbb R\).
- The theorem proves equality of two existing outer laws. It does not define
  the later name <code>GUE.empiricalSpectralLaw</code>, compute a density, or
  establish a large-dimension limit.
{{< /lean-bridge >}}

{{< repo-check >}}
On an approved Linux builder, a reader can inspect the final measurable-map
and law-level interfaces with:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity

open NonlinearDynamics.Random

#check RandomMatrix.measurable_ambientEmpiricalSpectralMeasure
#check RandomMatrix.map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw
~~~

The first line after the import checks a map property. The second checks an
equality between two pushforward measures. The guarded command below checks
the complete pinned project module in the cloud; it does not run on this Mac.
{{< /repo-check >}}

In commuting-square form:

\[
\begin{array}{ccc}
\mathcal H_n & \xrightarrow{\operatorname{hermitianToMatrix}}
  & \mathbb C^{n\times n}\\
\downarrow L & & \downarrow L_{\mathrm{ambient}}\\
\operatorname{Measure}(\mathbb R) & = &
  \operatorname{Measure}(\mathbb R).
\end{array}
\]

The intrinsic law starts at the upper left. The ambient matrix law is its
pushforward across the top. The new theorem says that pushing down either side
produces the same measure on the space of measures.

This is an unconditional equality of two existing pushforwards. RMT-10B does
not itself introduce a dedicated name for the finite Gaussian unitary ensemble
(GUE) empirical spectral law, prove a new density for it, or compute its
normalized moments. Successor RMT-10C now names the law and checks its first
two normalized expected sample moments, while the density remains unproved.

## Physics camp: energy levels under a Hamiltonian perturbation

In finite-dimensional quantum mechanics, a Hermitian Hamiltonian \(H\)
represents an observable whose eigenvalues are possible energy levels. Add a
Hermitian perturbation \(V\), perhaps modeling a weak field, a coupling term,
or an imperfect calibration:

\[
H\longmapsto H+V.
\]

The checked bound gives

\[
\left|\lambda_i(H+V)-\lambda_i(H)\right|
\le\lVert V\rVert_F.
\]

Every ordered energy level stays inside the same deterministic energy budget.
The statement remains valid when levels cross or a degenerate level splits,
because the comparison is between decreasing order statistics rather than
between labeled eigenvectors.

For the running matrices, regard \(A\) as a two-level Hamiltonian and write

\[
B=A+V,
\qquad
V=
\begin{bmatrix}
-\frac12&0\\
0&\frac14
\end{bmatrix}.
\]

The upper energy falls by \(1/2\), the lower energy rises by \(1/4\), and the
single perturbation budget is \(\lVert V\rVert_F=\sqrt5/4\). The spectral gap
changes from

\[
3-(-1)=4
\quad\text{to}\quad
\frac52-\left(-\frac34\right)=\frac{13}{4}.
\]

That gap change is \(3/4\), but the checked theorem is not a direct spectral-gap
theorem. A gap estimate can be derived by applying the coordinate bound twice,
which gives a coarser \(2\lVert V\rVert_F\) budget. RMT-10B itself exports the
individual ordered-coordinate bounds.

That strength has a matching limitation. Near a degeneracy, an arbitrarily
small perturbation can rotate a selected eigenbasis dramatically. The energy
levels can remain close while the directions representing states change. A
Davis-Kahan theorem controls invariant subspaces using a perturbation size
divided by a spectral-gap scale
([Davis and Kahan](#ref-perturb-davis-kahan)). RMT-10B assumes no gap and proves
no such rotation estimate.

The Frobenius norm is invariant under unitary basis changes, which makes the
budget coordinate independent. It is also sensitive to dimension: many small
entrywise perturbations can accumulate into a comparatively large Frobenius
norm. The operator-norm Weyl theorem can give a sharper energy-level budget,
but that norm comparison is not the theorem formalized here.

### Random matrices enter after the deterministic theorem

For a random Hamiltonian, the perturbation inequality may later become one
ingredient in concentration or approximation arguments. RMT-10B does not take
that probabilistic step. It proves no tail bound for
\(\lVert V\rVert_F\), no rigidity of individual GUE eigenvalues, and no
semicircle law.

Its probability contribution is structural instead: it proves that the map
from a sampled Hermitian matrix to its finite empirical spectral measure is
measurable. This is what allows the sample observable to have a pushforward
law at all. Existence of that law is logically earlier than its density,
moments, concentration, or asymptotics.

## The complete public API

RMT-10B exposes fourteen public theorems. The eigenbasis, support, dimension,
intersection, and quadratic-form helpers stay private.

### Analytic and ordered-coordinate bounds

| Declaration | Exact role |
|---|---|
| <code>norm_mulVec_le_frobenius</code> | Bounds Euclidean matrix-vector multiplication by the Frobenius matrix norm for an arbitrary complex square matrix |
| <code>orderedHermitianEigenvalues_le_add_frobenius</code> | One-sided ordered-coordinate perturbation bound |
| <code>abs_orderedHermitianEigenvalues_sub_le_frobenius</code> | Two-sided absolute ordered-coordinate perturbation bound |

### Lipschitz and continuous spectrum

| Declaration | Exact role |
|---|---|
| <code>lipschitzWith_orderedHermitianEigenvalues_apply</code> | One fixed ordered coordinate is 1-Lipschitz |
| <code>lipschitzWith_orderedHermitianEigenvalues</code> | The whole ordered vector is 1-Lipschitz into the finite function-space sup metric |
| <code>continuous_orderedHermitianEigenvalues_apply</code> | Coordinatewise continuity |
| <code>continuous_orderedHermitianEigenvalues</code> | Whole-vector continuity |

### Measurable spectrum and measure-valued observables

| Declaration | Exact role |
|---|---|
| <code>measurable_orderedHermitianEigenvalues_apply</code> | Ordinary measurability of one ordered coordinate |
| <code>measurable_orderedHermitianEigenvalues</code> | Ordinary measurability of the full vector |
| <code>measurable_spectralCountingMeasure</code> | Unconditional Giry measurability of the finite Dirac sum |
| <code>measurable_empiricalSpectralMeasure</code> | Unconditional Giry measurability of the zero-aware empirical measure |
| <code>measurable_empiricalSpectralProbability</code> | Measurability of the positive-dimensional probability-measure wrapper |
| <code>measurable_ambientEmpiricalSpectralMeasure</code> | Measurability of the ambient Hermitian-or-zero spectral observable |
| <code>map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw</code> | Unconditional equality of the ambient and intrinsic GUE empirical-spectral pushforwards |

The final theorem removes the measurability argument from the conditional
RMT-10A theorem
<code>map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw_of_measurable_eigenvalues</code>.
The conditional theorem remains valuable as the compositional bridge; RMT-10B
supplies its premise.

## Private proof architecture

The private declarations fall into five groups:

| Group | Job |
|---|---|
| Ordered eigenbasis | Reindex Mathlib's orthonormal eigenbasis and prove the coordinate action of matrix-vector multiplication |
| Weighted quadratic form | Express the real quadratic form as ordered eigenvalues weighted by squared basis coordinates |
| Spectral subspaces | Define top and bottom spans, compute their dimensions, and prove coordinates outside each interval vanish |
| Intersection witness | Use finite rank to prove the top and bottom subspaces intersect nontrivially |
| Norm bridge | Align flattened and matrix Frobenius norms, then control the difference of quadratic forms |

Keeping these private prevents a proof-specific choice of eigenbasis from
becoming a long-term public dependency. The public interface depends only on
the canonical ordered eigenvalue vector, the intrinsic Frobenius geometry, and
standard topological and measurable predicates.

## Common wrong turns

### Calling the whole-vector theorem Hoffman-Wielandt

The theorem
<code>lipschitzWith_orderedHermitianEigenvalues</code> targets a finite
function space with its sup metric. Hoffman-Wielandt controls a full-spectrum
Euclidean matching cost. Do not substitute one statement for the other.

### Claiming the operator-norm Weyl theorem was formalized

The checked source norm is Frobenius. The classical operator-norm result is
sharper because
\(\lVert M\rVert_{\mathrm{op}}\le\lVert M\rVert_F\), but RMT-10B does not
define or prove that sharper interface.

### Treating eigenvalue continuity as eigenvector continuity

Repeated eigenvalues make an individual eigenbasis noncanonical. The ordered
eigenvalue vector can be globally Lipschitz while a chosen eigenvector branch
fails to be continuous. No eigenvector or spectral-projector conclusion is in
the module.

### Forgetting the target measurable structure

The measure-valued maps are measurable for Mathlib's Giry structure. The
module does not put a Wasserstein metric on measures or prove weak continuity.

### Reading an ambient fallback as non-Hermitian spectral theory

On a non-Hermitian ambient matrix,
<code>matrixToHermitianOrZero</code> returns zero in the intrinsic Hermitian
space. It does not compute complex eigenvalues of the original matrix.

### Turning deterministic stability into concentration

The inequality holds pointwise for every pair of Hermitian matrices. It gives
no probability for how large a random perturbation is and no tail estimate for
an eigenvalue.

### Inferring differentiability

A 1-Lipschitz map is continuous and measurable. It need not be differentiable
where ordered eigenvalues collide. RMT-10B proves no analytic branch, gradient,
or response coefficient.

### Inferring asymptotics

Every theorem is finite dimensional and exact. No parameter tends to infinity.
There is no semicircle law, universality statement, unfolding, local spacing
law, edge scaling, or spectral form factor.

## Nearby perturbation theorems, kept separate

| Theorem family | Typical input | Typical conclusion | Status here |
|---|---|---|---|
| Weyl ordered-eigenvalue perturbation | Two Hermitian matrices | Each ordered eigenvalue moves by at most a matrix-norm budget | Frobenius version checked |
| Hoffman-Wielandt | Two normal matrices | A permutation matches spectra with an \(\ell^2\) cost bounded by Frobenius distance | Not checked |
| Davis-Kahan | Perturbed invariant subspaces plus a spectral gap | Gap-dependent angle or projector bound | Not checked |
| Rellich-Kato perturbation theory | A parameterized self-adjoint family with regularity assumptions | Local analytic or differentiable eigenvalue and eigenvector branches | Not checked |
| Random-matrix concentration and rigidity | A probability ensemble plus distributional hypotheses | High-probability deviations from deterministic or classical locations | Not checked |

Bhatia's *Matrix Analysis* develops variational principles and spectral
variation in a unified finite-dimensional setting
([Bhatia](#ref-perturb-bhatia)). Kato's standard perturbation text develops the
regular parameter-dependent theory named in the Rellich-Kato row
([Kato](#ref-perturb-kato)). The table is a scope map, not a claim that these
results are interchangeable.

## What has and has not been proved

| Topic | Current repository status from RMT-10B onward |
|---|---|
| Generic complex matrix-vector Frobenius bound | Checked |
| Ordered orthonormal Hermitian eigenbasis for the proof | Constructed privately |
| Weighted quadratic-form expansion | Checked privately |
| Top and bottom spectral subspace dimensions | Checked privately |
| Nonzero intersection witness | Checked privately |
| One-sided ordered eigenvalue bound | Checked |
| Absolute coordinatewise Frobenius bound | Checked |
| Coordinatewise 1-Lipschitz continuity | Checked |
| Whole-vector 1-Lipschitz continuity in finite sup metric | Checked |
| Coordinate and vector Borel measurability | Checked |
| Spectral counting-measure measurability | Checked |
| Zero-aware empirical spectral-measure measurability | Checked |
| Positive-dimensional probability-wrapper measurability | Checked |
| Ambient empirical spectral observable measurability | Checked |
| Ambient/intrinsic GUE empirical-spectral pushforward equality | Checked unconditionally |
| Dedicated named finite-GUE empirical spectral law | Defined in successor RMT-10C |
| First normalized expected sample moments | Connected in successor RMT-10C |
| Operator-norm Weyl bound | Not checked |
| Hoffman-Wielandt \(\ell^2\) spectrum bound | Not checked |
| Eigenvector or invariant-subspace perturbation | Not checked |
| Spectral gap, simplicity, or differentiability | Not checked |
| Weak or Wasserstein continuity of empirical measures | Not checked |
| Joint eigenvalue density | Not checked |
| Concentration, rigidity, or extreme-value law | Not checked |
| Semicircle law or any large-dimension convergence | Not checked |

## Exercises from trailhead to summit

### Trailhead

1. For diagonal Hermitian matrices with decreasing diagonals \(a\) and \(b\),
   prove \(|a_i-b_i|\le\lVert a-b\rVert_2\). Identify the matrix Frobenius
   norm in this special case.
2. Let \(A=0\) and \(B\) have diagonal entries
   \(\varepsilon,-\varepsilon\). Check the coordinate bound and explain why an
   eigenbasis of \(A\) is noncanonical.
3. Prove that \(\lVert Mx\rVert_2\le\lVert M\rVert_F\lVert x\rVert_2\) by
   expanding coordinates and applying Cauchy-Schwarz to each row. Compare that
   route with the single-column matrix proof used in Lean.
4. Explain why sorting both spectra is a matching rule. What goes wrong if one
   side is arbitrarily reindexed?

### Mid-mountain

5. Using the weighted quadratic-form expansion, prove the lower bound on
   \(T_A(i)\) and the upper bound on \(S_B(i)\).
6. Prove the dimension formula
   \(\dim(U\cap V)\ge\dim U+\dim V-n\) in a finite vector space. Apply it to
   the two spectral subspaces.
7. Starting from a nonzero intersection vector, derive the one-sided estimate
   without normalizing the vector. Identify exactly where its nonzeroness is
   used.
8. Swap the matrices in the one-sided estimate and derive the absolute value
   theorem.
9. Explain why the same proof does not choose a common eigenvector of \(A\) and
   \(B\).

### Summit

10. Translate the absolute coordinate theorem into the definition of
    <code>LipschitzWith 1</code>.
11. Explain how <code>dist_pi_le_iff</code> turns all coordinate estimates into
    the whole-vector theorem. Why is this a sup-metric statement?
12. Build the measurable spectral counting map from measurable eigenvalue
    coordinates, measurable Dirac embedding, and finite addition.
13. Draw the ambient/intrinsic GUE pushforward square and derive the equality
    using composition of measurable maps.
14. Reconstruct the successor RMT-10C finite-GUE empirical spectral law. State
    its zero-dimensional boundary without falsely calling the zero measure a
    probability measure.
15. State a Davis-Kahan-style question that would require a gap. Explain why
    no theorem in RMT-10B answers it.
16. State a Hoffman-Wielandt \(\ell^2\) conclusion and identify the target norm
    missing from the current API.

## Reproduce the checked slice

There are two deliberately separate resource lanes.

On a normal Mac or Linux host, rerun only the bounded <code>Std</code>
worksheet from the opening:

~~~sh
elan run leanprover/lean4:v4.32.0 lean \
  /tmp/HermitianPerturbation2.lean
~~~

That command checks exact rational arithmetic and characteristic-polynomial
substitution. It does not import Mathlib or compile this project.

The authoritative module check belongs on approved Linux cloud compute with
the pinned project cache. From the repository root there, type:

~~~sh
CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/Random/RandomMatrices/HermitianSpectrumContinuity.lean
~~~

The guarded target verifies the committed manifest digest and checks the
Mathlib-backed declarations. Do not replace it with a raw
<code>lake build</code> or <code>lake env lean</code> command on the Mac.

Site authoring and static validation remain workstation-safe:

~~~sh
make content-hygiene
make site-check
~~~

The repository-wide <code>make check</code> gate is also cloud-only because it
includes the Lean project build. A green technical build does not complete
editorial review of this public working note. Human mathematical,
accessibility, and publication reviews remain pending.

## Where to continue

The {{< refterm "weyl-eigenvalue-bound" "Weyl eigenvalue bound" >}} entry is
the compact perturbation reference. The
{{< refterm "empirical-spectral-measure" "empirical spectral measure" >}}
entry explains the measure-valued target, while
{{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius geometry" >}}
explains the source norm and intrinsic matrix carrier.

[Finite Hermitian Spectra and Empirical Measures]({{< relref "/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures" >}})
constructs every algebraic and conditional interface that this chapter
discharges.
[Intrinsic Hermitian Gaussian Symmetry and Matrix-Law Support]({{< relref "/knowledge-base/deep-dives/intrinsic-hermitian-gaussian-symmetry-and-matrix-law-support" >}})
builds the intrinsic carrier and its measurable ambient inclusion.
[From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance]({{< relref "/knowledge-base/deep-dives/normalized-hermitian-coordinates-to-gue-invariance" >}})
proves the intrinsic-to-ambient GUE law identity consumed by the final
pushforward theorem.

The spectral-law successor is now available:
[Finite Gaussian Unitary Ensemble Empirical Spectral Laws and Normalized Moments]({{< relref "/knowledge-base/deep-dives/finite-gue-empirical-spectral-laws-and-normalized-moments" >}}).
It names the finite-GUE law, proves its exact dimension-zero behavior, and
connects its first two normalized sample moments to the checked finite trace
expectations. It does not claim a density, semicircle law, concentration
estimate, large-dimension convergence, or an interchange theorem for moments
of its Giry mean.

## References

<a id="ref-perturb-bhatia"></a>**Rajendra Bhatia.**
[Matrix Analysis](https://doi.org/10.1007/978-1-4612-0653-8), Graduate Texts in
Mathematics 169, Springer, 1997. The chapters on variational principles and
spectral variation supply standard finite-dimensional context for the min-max
and ordered-eigenvalue perturbation arguments. RMT-10B proves its displayed
Frobenius theorem directly.

<a id="ref-perturb-hoffman-wielandt"></a>**Alan J. Hoffman and Helmut W. Wielandt.**
[The variation of the spectrum of a normal matrix](https://doi.org/10.1215/S0012-7094-53-02004-3),
*Duke Mathematical Journal* 20 (1953), 37-39. This primary source proves the
normal-matrix full-spectrum matching inequality. It is cited to mark the
boundary between its \(\ell^2\) conclusion and the project's finite sup-metric
whole-vector theorem.

<a id="ref-perturb-davis-kahan"></a>**Chandler Davis and W. M. Kahan.**
[The Rotation of Eigenvectors by a Perturbation. III](https://doi.org/10.1137/0707001),
*SIAM Journal on Numerical Analysis* 7 (1970), 1-46. This primary source
studies gap-dependent perturbation of invariant subspaces. RMT-10B proves no
eigenvector, angle, or spectral-projector bound.

<a id="ref-perturb-kato"></a>**Tosio Kato.**
[Perturbation Theory for Linear Operators](https://doi.org/10.1007/978-3-642-66282-9),
second edition, Classics in Mathematics, Springer, 1995. This standard
monograph develops finite-dimensional, analytic, and asymptotic perturbation
theory. It is cited to distinguish those regularity conclusions from the
global Lipschitz theorem checked here.

<a id="ref-perturb-giry"></a>**Michèle Giry.**
[A categorical approach to probability theory](https://doi.org/10.1007/BFb0092872),
in *Categorical Aspects of Topology and Analysis*, Lecture Notes in
Mathematics 915, Springer, 1982, 68-85. This is the original source for the
measure-space construction that motivates the Giry terminology. The checked
implementation details come from Mathlib's official documentation below.

<a id="ref-perturb-mathlib-spectrum"></a>**Mathlib contributors.**
[Spectral theory of Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Spectrum.html),
Mathlib 4 documentation. This official page defines the ordered real
eigenvalues and orthonormal eigenbasis reindexed by the project.

<a id="ref-perturb-mathlib-normed"></a>**Mathlib contributors.**
[Matrices as a normed space](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Normed.html),
Mathlib 4 documentation. This official page distinguishes the Frobenius,
elementwise, and operator norm scopes and supplies the matrix-norm
infrastructure used by the matrix-vector proof.

<a id="ref-perturb-mathlib-lipschitz"></a>**Mathlib contributors.**
[Lipschitz continuous functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Topology/MetricSpace/Lipschitz.html),
Mathlib 4 documentation. This official page defines
<code>LipschitzWith</code> through distance inequalities and proves the
continuity consequences consumed by RMT-10B.

<a id="ref-perturb-mathlib-giry"></a>**Mathlib contributors.**
[The Giry measurable structure on measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/GiryMonad.html),
Mathlib 4 documentation. This official module equips the type of all measures
with its evaluation-generated measurable structure and provides the
measure-valued measurability infrastructure used by the spectral observables.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
