---
title: "Extended log-norm observable"
slug: "extended-log-norm-observable"
summary: "An extended log-norm observable applies a zero-aware logarithm to a finite cocycle matrix norm, sending exact matrix collapse to bottom while turning multiplicative norm bounds into additive ones."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.NormObservables"
og_image: "extended-log-norm-observable-card.png"
og_image_alt: "A finite cocycle matrix is reduced to its largest absolute row sum and then passed through an extended logarithm, with a separate branch that sends a zero matrix exactly to the bottom value."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page must remain a draft until that review is complete.
{{< /panel >}}

An **extended log-norm observable** measures the finite-time size of a matrix
cocycle without pretending that a zero matrix has neutral logarithmic growth.
For a one-sided discrete matrix cocycle \(C\), horizon \(k\), and base state
\(\omega\), the project defines

\[
L_k(\omega)
{} =
\operatorname{Log}_{\mathrm{ext}}
\bigl(\lVert C(k,\omega)\rVert_\infty\bigr).
\]

Here \(C(k,\omega)\) is the finite cocycle matrix, and
\(\lVert\cdot\rVert_\infty\) is the
{{< refterm "induced-infinity-operator-norm" "maximum absolute row-sum operator norm" >}}.
The function \(\operatorname{Log}_{\mathrm{ext}}\) is Mathlib's
<code>ENNReal.log</code>: it takes an **extended nonnegative real** input and
returns an **extended real** value. It agrees with the usual real logarithm on
positive finite inputs and satisfies

\[
\operatorname{Log}_{\mathrm{ext}}(0)=\bot,
\]

where \(\bot\), read “bottom,” is the negative-infinity endpoint of the
extended real line.

This choice preserves a crucial distinction. A norm of one represents neutral
multiplicative size and has logarithm zero. A norm of zero represents exact
collapse and has extended logarithm bottom. Using <code>Real.log</code>
directly would erase that distinction because Mathlib's total real logarithm
uses the convention <code>Real.log 0 = 0</code>.

{{< reference-figure
  src="extended-log-norm-observable.svg"
  alt="A finite cocycle matrix is converted into absolute row totals, the largest total becomes the chosen operator norm, and an extended logarithm then separates positive norms from exact zero. Positive norms retain an ordinary finite logarithm, while a zero matrix maps to bottom."
  caption="**Finding:** the observable first compresses a finite cocycle matrix to its largest absolute row sum, then applies a logarithm whose codomain includes bottom. A positive norm keeps its ordinary real logarithm; a zero matrix maps exactly to bottom, so collapse cannot be confused with norm one. The resulting finite-horizon map is measurable and subadditive, but the figure supplies no integrability or long-time exponent."
>}}

## The norm before the logarithm

For a complex square matrix \(B=(B_{ij})\) indexed by a finite type \(\iota\),
the selected norm is

\[
\lVert B\rVert_\infty
{} =
\max_{i\in\iota}\sum_{j\in\iota}|B_{ij}|.
\]

It is the operator norm induced by the supremum norm on finite column vectors.
The project opens Mathlib's <code>Matrix.Norms.Operator</code> scope so that
<code>‖B‖</code> means this norm. It is not the Frobenius norm, the Euclidean
spectral norm, or the largest absolute matrix entry.

The finite-time norm observable is

\[
N_k(\omega)=\lVert C(k,\omega)\rVert_\infty.
\]

The theorem <code>normObservable_eq_rowSumSup</code> exposes the exact row-sum
formula rather than leaving the active norm instance implicit. This matters
both mathematically and in Lean, where several useful matrix norms coexist.

## Why two extended number systems appear

The notation can look heavier than the idea. There are three value layers:

| Layer | Lean type | Role here |
|---|---|---|
| Ordinary matrix norm | \(\mathbb R\) | \(N_k(\omega)\), a finite nonnegative real number |
| Extended nonnegative real | \(\mathbb R_{\geq0}\cup\{+\infty\}\) | Receives the extended norm notation <code>‖B‖ₑ</code> |
| Extended real | \(\mathbb R\cup\{-\infty,+\infty\}\) | Receives <code>ENNReal.log</code> and contains \(\bot\) |

Mathlib writes the middle type as <code>ℝ≥0∞</code>, or <code>ENNReal</code>,
and the final type as <code>EReal</code>. The cocycle matrix norm itself is
finite. The extended nonnegative-real layer is used because its logarithm has
the exact endpoint convention and algebraic laws needed here.

The checked definition is:

~~~lean
def logNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → EReal :=
  fun ω ↦ ENNReal.log ‖C.value k ω‖ₑ
~~~

It is a pointwise observable. It does not integrate over \(\omega\), form a
probability law, or take a limit in \(k\).

## Bottom means exactly zero matrix

The module proves the sharp equivalence

\[
L_k(\omega)=\bot
\quad\Longleftrightarrow\quad
C(k,\omega)=0.
\]

The proof combines two exact facts:

1. <code>ENNReal.log x = ⊥</code> exactly when <code>x = 0</code>;
2. the norm of a matrix is zero exactly when the matrix is zero.

Thus bottom is not a failure value, missing datum, or proof artifact. It is the
intended logarithmic record of exact finite-time collapse.

By contrast,

\[
L_k(\omega)=0
\]

means that the matrix norm is one. This does not mean the matrix is the
identity: many nonidentity matrices have operator norm one.

For a nonzero matrix value, the extended log norm is an ordinary finite real
number. Its sign records a worst-case supremum-norm amplification budget:

- \(L_k(\omega)\lt0\) means \(0\lt N_k(\omega)\lt1\);
- \(L_k(\omega)=0\) means \(N_k(\omega)=1\); and
- \(L_k(\omega)\gt0\) means \(N_k(\omega)\gt1\).

This is a statement about the selected operator norm. It does not say that
every vector expands or contracts by that exact factor. A particular vector
can experience less growth, cancellation, or annihilation.

## Multiplicative bounds become additive bounds

The one-sided cocycle law splits a history as

\[
C(m+k,\omega)
{} =
C(k,T^m\omega)C(m,\omega),
\]

with the shifted later block on the left. Matrix-norm submultiplicativity gives

\[
N_{m+k}(\omega)
\leq
N_k(T^m\omega)N_m(\omega).
\]

The extended logarithm is monotone, and it turns a product into a sum even at
zero. Therefore

\[
L_{m+k}(\omega)
\leq
L_k(T^m\omega)+L_m(\omega).
\]

This is a finite-time **subadditivity** statement. It is not an equality in
general. The matrix product can be smaller than the product of the two norms,
and a product can even be zero while both factors are nonzero.

The endpoint convention is what makes the displayed argument honest without
a nonzero-matrix hypothesis. If either factor is zero, its extended logarithm
is bottom, the matrix product is zero, and Mathlib's extended arithmetic keeps
the product-to-sum identity valid.

## Measurability is proved entry by entry

The project gives matrices a measurable structure generated by their entries.
It does not assume that opening a matrix norm scope automatically produces the
right measurable norm map. Instead, <code>measurable_normObservable</code>
proves the result from the row-sum formula:

1. every entry \(\omega\mapsto C(k,\omega)_{ij}\) is measurable;
2. its complex norm is measurable;
3. each finite sum over columns is measurable;
4. each finite maximum over rows is measurable; and
5. the row-sum formula identifies that maximum with \(N_k\).

The log observable is then measurable because the norm is measurable, the norm
embeds measurably into the extended nonnegative reals, and
<code>ENNReal.log</code> is measurable.

Measurability alone does not imply integrability. In particular, a measurable
extended log norm may have a nonintegrable positive part, may equal bottom on a
set of positive measure, or may lack the hypotheses required by an ergodic
theorem.

## Time zero and matrix dimension

At time zero, every cocycle value is the identity matrix. When the coordinate
type \(\iota\) is nonempty,

\[
N_0(\omega)=1,
\qquad
L_0(\omega)=0.
\]

Those two normalization theorems require <code>Nonempty ι</code>. The reason is
precise: for an empty coordinate type there are no rows, so the supremum of all
row sums is zero. The unique empty square matrix is simultaneously the zero
matrix and the identity matrix. Consequently, in empty dimension,

\[
N_k(\omega)=0,
\qquad
L_k(\omega)=\bot
\]

for every horizon and every base state.

The empty case is not excluded from the definitions, measurability theorems,
or split inequalities. Positive dimension is needed only when one asks for the
familiar normalized statements “identity norm equals one” and “time-zero log
norm equals zero.”

## A two-by-two check

Suppose an early cocycle block and a shifted later block have values

\[
B=
\begin{bmatrix}
1 & -1\\
0 & 2
\end{bmatrix},
\qquad
D=
\begin{bmatrix}
1 & 0\\
3 & 1
\end{bmatrix}.
\]

Their maximum absolute row sums are

\[
\lVert B\rVert_\infty=2,
\qquad
\lVert D\rVert_\infty=4.
\]

The full later-after-earlier product is

\[
DB=
\begin{bmatrix}
1 & -1\\
3 & -1
\end{bmatrix},
\qquad
\lVert DB\rVert_\infty=4.
\]

Thus the norm inequality reads \(4\leq4\cdot2\), and the log inequality reads

\[
\log 4\leq\log 4+\log 2.
\]

The bound is not exact. If the later block were the zero matrix, the full
product would be zero and both the later-block and full-product log norms would
be bottom. No special exception would be needed.

## What this observable does not establish

The checked finite-time layer does not provide:

- integrability of \(N_k\) or \(L_k\);
- finiteness of any integral or expectation;
- a probability assumption on the base measure;
- ergodicity, mixing, stationarity, or independence;
- a normalized quantity such as \(k^{-1}L_k\);
- convergence in \(k\), almost surely or otherwise;
- a Lyapunov exponent or spectrum;
- an Oseledets invariant splitting;
- invertibility or negative-time cocycle values;
- a lower norm bound, singular-value estimate, or equality case;
- a comparison with the Frobenius or Euclidean spectral norm;
- a pushforward law for either observable; or
- a theorem identifying the generator with a nonlinear Jacobian.

It is also not a matrix logarithm. Nor is it the distinct “logarithmic norm,”
sometimes called a matrix measure, used in ordinary-differential-equation
stability theory. The construction takes a scalar operator norm first and only
then applies a scalar extended logarithm.

The finite subadditive inequality is important infrastructure for later
ergodic theory, but it does not by itself satisfy the hypotheses or prove the
conclusions of a subadditive or multiplicative ergodic theorem.

## Exercises

1. Compute the largest absolute row sum of
   \(\begin{bmatrix}2&-3\\1&1\end{bmatrix}\).
2. Explain why a norm of one and a norm of zero must not receive the same
   logarithmic value.
3. Show that if either matrix factor in a product is zero, then the full
   product has extended log norm bottom.
4. Give two nonzero two-by-two matrices whose product is zero. Check how the
   subadditive inequality behaves.
5. Reconstruct the measurability proof from entries, row sums, and finite
   maxima.
6. Explain why <code>Nonempty ι</code> is needed at time zero but not in the
   definition of either observable.
7. List the extra hypotheses needed before a subadditive ergodic theorem could
   be applied.

## Where to continue

[Finite-Time Norm and Extended-Log-Norm Observables for Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/finite-time-norm-and-extended-log-norm-cocycle-observables" >}})
derives the fourteen-declaration Lean interface, including the entrywise
measurability proof, zero-safe subadditivity, and the positive-versus-empty
dimension ledger.

The
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycle" >}}
entry supplies the base orbit and later-block-left split. The
{{< refterm "induced-infinity-operator-norm" "induced infinity operator norm" >}}
entry develops the row-sum norm before it is applied to a random cocycle.

## References

<a id="ref-extended-log-norm-mathlib-matrix"></a>**Mathlib contributors.**
[Norms on finite matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Normed.html),
Mathlib 4 documentation. This official source defines the maximum absolute
row-sum matrix norm and proves its product inequality and operator-norm
interpretation.

<a id="ref-extended-log-norm-mathlib-log"></a>**Mathlib contributors.**
[Extended nonnegative-real logarithm](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/SpecialFunctions/Log/ENNRealLog.html),
Mathlib 4 documentation. This official source defines <code>ENNReal.log</code>,
its zero and bottom behavior, monotonicity, and its unconditional
product-to-sum law.

<a id="ref-extended-log-norm-mathlib-log-exp"></a>**Mathlib contributors.**
[Extended logarithm and exponential](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/SpecialFunctions/Log/ENNRealLogExp.html),
Mathlib 4 documentation. This official source packages the logarithm as an
order isomorphism and homeomorphism and proves its measurability.

<a id="ref-extended-log-norm-horn-johnson"></a>**Roger A. Horn and Charles R. Johnson.**
[Matrix Analysis, second edition](https://www.cambridge.org/highereducation/books/matrix-analysis/FDA3627DC2B9F5C3DF2FD8C3CC136B48),
Cambridge University Press, 2013, ISBN 978-0-521-54823-6. Chapter 5 develops
induced matrix norms and their submultiplicative laws. The project selects the
maximum absolute row-sum convention.

<a id="ref-extended-log-norm-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://www.jstor.org/stable/2984534),
*Journal of the Royal Statistical Society, Series B* 30(3), 1968, 499-510.
This primary source supplies a later asymptotic destination. The present
finite-time observable establishes neither Kingman's integrability and
ergodicity hypotheses nor a limiting conclusion.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
