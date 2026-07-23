---
title: "Extended log-norm observable"
slug: "extended-log-norm-observable"
summary: "The signed extended log of a cocycle norm records contraction, neutral size, expansion, and exact collapse without confusing any of them."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability"
og_image: "extended-log-norm-observable-card.png"
og_image_alt: "Four diagonal matrices have infinity norms zero, one half, one, and e squared; the signed extended log distinguishes bottom, negative log two, zero, and two while log positive keeps only the final expansion."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working note. Human review of the
mathematics, Lean interpretation, sources, figures, and accessibility remains
pending. The page is public so readers can follow the work while that review
is still open.
{{< /panel >}}

An **extended log-norm observable** answers a concrete question:

> After \(k\) steps, how large is the cocycle matrix at the base state
> \(\omega\), measured on a logarithmic scale that still recognizes exact
> collapse?

For a one-sided discrete matrix cocycle \(C\), the project defines

\[
N_k(\omega)=\lVert C(k,\omega)\rVert_\infty
\]

and then

\[
L_k(\omega) {} =
\operatorname{Log}_{\mathrm{ext}}\!\left(N_k(\omega)\right).
\]

The first observable \(N_k\) is a finite nonnegative real number. The second
observable \(L_k\) takes values on the extended real line. It can therefore
say all four of the following without ambiguity:

- \(\bot=-\infty\): exact matrix collapse;
- a finite negative number: strict norm contraction;
- \(0\): norm exactly one; and
- a finite positive number: norm expansion.

That four-way distinction is the main idea. The logarithm also converts the
multiplicative estimate for cocycle norms into an additive estimate, which is
the shape later ergodic theorems expect.

## Start with four real matrices

Consider four \(2\times2\) diagonal matrices:

\[
A_0=
\begin{bmatrix}0&0\\0&0\end{bmatrix},\qquad
A_{1/2}=
\begin{bmatrix}\tfrac12&0\\0&0\end{bmatrix},\qquad
I=
\begin{bmatrix}1&0\\0&1\end{bmatrix},\qquad
A_{e^2}=
\begin{bmatrix}e^2&0\\0&0\end{bmatrix}.
\]

The project uses the {{< refterm "induced-infinity-operator-norm" "maximum absolute row-sum norm" >}}

\[
\lVert A\rVert_\infty=\max_i\sum_j|A_{ij}|.
\]

For a diagonal matrix, each row total is just the magnitude of its diagonal
entry. We therefore obtain

| Matrix | Absolute row totals | \(\lVert A\rVert_\infty\) | Signed extended log | Real log-positive value |
|---|---|---:|---:|---:|
| \(A_0\) | \(0,0\) | \(0\) | \(\bot=-\infty\) | \(0\) |
| \(A_{1/2}\) | \(1/2,0\) | \(1/2\) | \(\log(1/2)=-\log 2\) | \(0\) |
| \(I\) | \(1,1\) | \(1\) | \(0\) | \(0\) |
| \(A_{e^2}\) | \(e^2,0\) | \(e^2\) | \(2\) | \(2\) |

The two rightmost columns are deliberately different observables.

- The **signed extended log** preserves contraction and gives zero a genuine
  negative-infinity endpoint.
- The **real log-positive observable**
  \(\log^+ r=\max\{0,\log r\}\) keeps only expansion above one. It sends the
  first three rows of the table to zero.

{{< reference-figure
  wide="true"
  src="extended-log-norm-four-cases.svg"
  alt="Four diagonal two by two matrices have infinity norms zero, one half, one, and e squared. The extended log sends them to bottom, negative log two, zero, and two. The real log-positive observable sends them to zero, zero, zero, and two. A number line distinguishes bottom from finite values and from unreachable top, while a final strip turns the cocycle product inequality into log subadditivity."
  caption="**Four branches, computed:** exact collapse, contraction, neutral norm, and expansion remain distinct under the signed extended log. The log-positive envelope intentionally merges the first three into zero because it is designed to measure only the positive growth tail. The extended-real top value \(+\infty\) is shown for orientation but cannot be produced by the finite norm of a finite matrix. Patterns and labels repeat every color-coded distinction."
>}}

## Work through each row

### Zero matrix: collapse is bottom

For \(A_0\), both row sums vanish, so \(\lVert A_0\rVert_\infty=0\). The
extended logarithm uses

\[
\operatorname{Log}_{\mathrm{ext}}(0)=\bot=-\infty.
\]

This is not an error, missing value, or failed proof. It is the intended record
of exact collapse. The project proves the sharp statement

\[
L_k(\omega)=\bot
\quad\Longleftrightarrow\quad
C(k,\omega)=0.
\]

The real log-positive envelope gives \(\log^+0=0\). That is also intentional:
the envelope is not trying to remember collapse; it is isolating expansion
above one for an integrability argument.

### Norm one half: contraction is finite and negative

For \(A_{1/2}\), the row totals are \(1/2\) and \(0\), hence

\[
\lVert A_{1/2}\rVert_\infty=\frac12.
\]

Because the norm is positive and finite, the extended logarithm agrees with
the ordinary logarithm:

\[
\operatorname{Log}_{\mathrm{ext}}(1/2)
=\log(1/2)
=-\log2\lt0.
\]

But \(\log^+(1/2)=0\). This is the cleanest example of why the two observables
must not be used as synonyms: one records contraction and the other discards
it.

### Norm one: zero means neutral size

For the identity matrix, both row totals are one. Thus

\[
\operatorname{Log}_{\mathrm{ext}}\lVert I\rVert_\infty
=\operatorname{Log}_{\mathrm{ext}}1
=0.
\]

Here zero means **norm one**, not zero matrix. Many nonidentity matrices also
have operator norm one, so a zero log norm does not identify the matrix.

### Norm \(e^2\): both observables retain expansion

For \(A_{e^2}\), the largest row total is \(e^2\). Therefore

\[
\operatorname{Log}_{\mathrm{ext}}(e^2)=2
\qquad\text{and}\qquad
\log^+(e^2)=2.
\]

Above one, the ordinary log is nonnegative, so taking its positive part changes
nothing.

## Four logarithmic conventions that look deceptively similar

At a positive real input, all relevant signed logarithms agree. The zero input
is where notation must be read carefully.

| Construction | Codomain | Value at \(0\) | Value at \(1/2\) | Purpose here |
|---|---|---:|---:|---|
| Ordinary mathematical \(\log r\) on \(r\gt0\) | \(\mathbb R\) | not defined; tends to \(-\infty\) from the right | \(-\log2\) | classical positive-input logarithm |
| Mathlib <code>Real.log</code> | \(\mathbb R\) | \(0\), by totalization | \(-\log2\) | convenient total real function |
| Mathlib <code>ENNReal.log</code> | <code>EReal</code> | \(\bot=-\infty\) | finite value \(-\log2\) | zero-faithful signed growth |
| Mathlib <code>Real.posLog</code>, written <code>log⁺</code> | \(\mathbb R\) | \(0\) | \(0\) | nonnegative expansion envelope |

Mathlib defines

\[
\log^+r=\max\{0,\operatorname{Real.log}r\}.
\]

Because Mathlib also has \(\operatorname{Real.log}0=0\), its log-positive
function is continuous at zero and returns zero there. This is useful, but it
does not repair the signed information that total real log loses at a zero
norm.

Later, under a nonzero or pointwise-invertibility hypothesis and in nonempty
matrix dimension, the project can identify the extended log with the coercion
of the real signed log. Without such a hypothesis, they differ precisely at
zero.

## Bottom is not top

Two extended number systems appear in the Lean definition:

| Mathematical layer | Lean type | Endpoints | Role |
|---|---|---|---|
| finite nonnegative norm | <code>ℝ</code> | none | \(N_k(\omega)\) |
| extended nonnegative real | <code>ENNReal</code>, notation <code>ℝ≥0∞</code> | \(0,+\infty\) | input type of <code>ENNReal.log</code> |
| extended real | <code>EReal</code> | \(\bot=-\infty,\ \top=+\infty\) | output type of the signed extended log |

The endpoint rules are

\[
\operatorname{ENNReal.log}(0)=\bot,
\qquad
\operatorname{ENNReal.log}(\top)=\top.
\]

The cocycle observable cannot reach the second branch. A finite matrix has a
finite real norm, and its extended norm notation <code>‖A‖ₑ</code> embeds that
finite value into <code>ENNReal</code>; it is never <code>⊤</code>. Therefore
<code>logNormObservable</code> can be bottom or a finite real value, but not
top.

That distinction prevents a common reading error:

- <code>⊥</code> means negative infinity and comes from norm zero;
- <code>⊤</code> means positive infinity and would come from an infinite
  extended input; and
- neither symbol is the real number zero.

## Why this is the raw cocycle-growth observable

A one-sided cocycle satisfies the later-block-left split

\[
C(m+k,\omega)=C(k,T^m\omega)C(m,\omega).
\]

The induced infinity norm is submultiplicative, so

\[
N_{m+k}(\omega)
\leq
N_k(T^m\omega)N_m(\omega).
\]

The extended logarithm is monotone and turns products into sums, including at
zero. Hence

\[
\boxed{
L_{m+k}(\omega)
\leq
L_k(T^m\omega)+L_m(\omega)
}.
\]

This is the **raw** finite-time growth observable:

- it uses the actual \(k\)-step cocycle value;
- it is not divided by \(k\);
- it has not been integrated over the base space;
- it has not been replaced by a probability distribution; and
- no limit as \(k\to\infty\) has been taken.

The inequality can be strict. Matrix multiplication can produce cancellation,
and two nonzero matrices can even have zero product. In that case the left side
is bottom while the two terms on the right remain finite.

The log-positive envelope also satisfies a subadditive bound,

\[
\log^+N_{m+k}(\omega)
\leq
\log^+N_k(T^m\omega)+\log^+N_m(\omega),
\]

but it serves a different purpose: it is a nonnegative upper-tail quantity
that can be integrated once a genuine integrability hypothesis is supplied.

{{< reference-figure
  src="extended-log-norm-observable.svg"
  alt="A finite cocycle matrix is converted into absolute row totals, the largest total becomes the chosen operator norm, and an extended logarithm separates positive norms from exact zero. Positive norms retain an ordinary finite logarithm, while a zero matrix maps to bottom."
  caption="**General construction:** measurable matrix entries feed finite absolute row sums, their maximum gives the selected operator norm, and the extended logarithm preserves the zero branch. The result is a measurable finite-horizon subadditive observable, not yet an integrated or asymptotic exponent."
>}}

## Measurability: build it from visible pieces

An observable must be measurable before measure-theoretic tools can use it.
The project proves this from the finite row-sum formula rather than treating
matrix norm notation as a black box.

For fixed \(k\):

1. every coordinate map
   \(\omega\mapsto C(k,\omega)_{ij}\) is measurable;
2. complex magnitude preserves measurability;
3. a finite sum of measurable column terms is measurable;
4. a finite maximum over the rows is measurable;
5. the row-sum theorem identifies that maximum with \(N_k\); and
6. composition with measurable <code>ENNReal.log</code> gives measurable
   \(L_k\).

The log-positive observable is measurable by composing \(N_k\) with the
continuous real function <code>Real.posLog</code>.

Measurability is not integrability. A measurable growth observable can still
have an infinite integral, a nonintegrable positive tail, or bottom on a set of
positive measure. The later finite-horizon integrability module therefore
introduces an explicit hypothesis on the one-step log-positive observable; it
does not derive integrability from measurability or measure preservation.

## Time zero and the empty-coordinate edge case

At time zero, a cocycle value is the identity. If the finite coordinate type
\(\iota\) is nonempty, the familiar normalization holds:

\[
N_0(\omega)=1,
\qquad
L_0(\omega)=0.
\]

The hypothesis <code>Nonempty ι</code> matters. If \(\iota\) is empty, there
are no rows, so the supremum of the row totals is zero. The unique empty square
matrix is both the zero matrix and the identity matrix. Consequently,

\[
N_k(\omega)=0,
\qquad
L_k(\omega)=\bot
\]

for every \(k\) and \(\omega\) in that edge case. The real log-positive
observable remains zero. The definitions, measurability results, and split
inequalities all allow empty dimension; only the usual identity-norm
normalization needs positive dimension.

## A non-tight two-block calculation

Let an earlier block be

\[
B=
\begin{bmatrix}
1&-1\\
0&2
\end{bmatrix}
\]

and a shifted later block be

\[
D=
\begin{bmatrix}
1&0\\
3&1
\end{bmatrix}.
\]

Their maximum absolute row sums are

\[
\lVert B\rVert_\infty=2,
\qquad
\lVert D\rVert_\infty=4.
\]

Because the later block acts on the left,

\[
DB=
\begin{bmatrix}
1&-1\\
3&-1
\end{bmatrix},
\qquad
\lVert DB\rVert_\infty=4.
\]

Thus

\[
4\leq4\cdot2
\]

and, since all three norms are positive,

\[
\log4\leq\log4+\log2.
\]

The estimate is deliberately a budget, not an equality. If \(D\) were zero,
then \(DB=0\), both corresponding extended log norms would be bottom, and no
special nonzero exception would be required.

## In Lean: form the signed observable

{{< lean-bridge
  human="At horizon k and state omega, take the infinity norm of the cocycle matrix and then its zero-aware extended logarithm."
  math="\(L_k(\omega)=\operatorname{Log}_{\mathrm{ext}}\lVert C(k,\omega)\rVert_\infty.\)"
  lean="C.logNormObservable k ω"
>}}

The exact definition a human reads is:

~~~lean
def logNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → EReal :=
  fun ω ↦ ENNReal.log ‖C.value k ω‖ₑ
~~~

In a Lean worksheet where <code>C</code>, <code>k</code>, and <code>ω</code>
have already been declared, the human types:

~~~lean
#check C.logNormObservable k ω
~~~

Read the tokens from the inside out:

- <code>C.value k ω</code> is the matrix \(C(k,\omega)\);
- <code>‖...‖ₑ</code> is its extended nonnegative norm value;
- <code>ENNReal.log</code> maps that value into <code>EReal</code>; and
- <code>C.logNormObservable k</code> is the whole function of \(\omega\).
{{< /lean-bridge >}}

## In Lean: recognize exact collapse

{{< lean-bridge
  human="The signed observable is bottom exactly when the finite cocycle matrix is zero."
  math="\(L_k(\omega)=\bot\iff C(k,\omega)=0.\)"
  lean="C.logNormObservable_eq_bot_iff k ω"
>}}

A human asks Lean for the theorem's type by typing:

~~~lean
#check C.logNormObservable_eq_bot_iff k ω
~~~

The returned proposition has two directions. The forward direction turns a
bottom log value into a zero matrix; the reverse direction turns a zero matrix
into bottom. No probability or almost-everywhere qualifier is involved.
{{< /lean-bridge >}}

## In Lean: form the real log-positive envelope

{{< lean-bridge
  human="Keep only the positive part of finite-time logarithmic norm growth."
  math="\(L_k^+(\omega)=\max\{0,\log N_k(\omega)\}.\)"
  lean="C.logPlusNormObservable k ω"
>}}

The project definition and the Mathlib expansion rule are:

~~~lean
def logPlusNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → ℝ :=
  fun ω ↦ log⁺ (C.normObservable k ω)

#check Real.posLog_apply
#check C.logPlusNormObservable k ω
~~~

- <code>log⁺</code> is notation for <code>Real.posLog</code>;
- <code>Real.posLog_apply</code> unfolds it to
  <code>max 0 (Real.log x)</code>;
- the result is an ordinary real number, not an <code>EReal</code>; and
- <code>C.logPlusNormObservable_nonneg k ω</code> proves the result is
  nonnegative.
{{< /lean-bridge >}}

## In Lean: state measurability and the cocycle split

{{< lean-bridge
  human="At every fixed horizon, both logarithmic observables are measurable functions of the base state."
  math="\(L_k:\Omega\to\overline{\mathbb R}\) and \(L_k^+:\Omega\to\mathbb R\) are measurable."
  lean="C.measurable_logNormObservable k; C.measurable_logPlusNormObservable k"
>}}

A human types the two proof terms separately:

~~~lean
#check C.measurable_logNormObservable k
#check C.measurable_logPlusNormObservable k
~~~

The first conclusion is
<code>Measurable (C.logNormObservable k)</code>; the second has the analogous
real-valued function.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Splitting a cocycle history turns the signed log norm into a subadditive finite-time budget."
  math="\(L_{m+k}(\omega)\leq L_k(T^m\omega)+L_m(\omega).\)"
  lean="C.logNormObservable_add_le m k ω"
>}}

The exact invocation is:

~~~lean
#check C.logNormObservable_add_le m k ω
#check C.logPlusNormObservable_add_le m k ω
~~~

Argument order matters: <code>m</code> is the length of the earlier block,
while <code>k</code> is the length of the later block evaluated at
<code>C.base^[m] ω</code>. The second line asks for the parallel inequality for
the real log-positive envelope.
{{< /lean-bridge >}}

## Exact source excerpts

**Full project check.** This uses the repository's pinned Lean and Mathlib
dependencies and may require substantial disk space and memory.
The zero-faithful observable,
collapse theorem, and measurability proof are in
[<code>NormObservables.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/NormObservables.lean):

~~~lean
def logNormObservable (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → EReal :=
  fun ω ↦ ENNReal.log ‖C.value k ω‖ₑ

@[simp] theorem logNormObservable_eq_bot_iff
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) (ω : Ω) :
    C.logNormObservable k ω = ⊥ ↔ C.value k ω = 0 := by
  simp [logNormObservable]

theorem measurable_logNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    Measurable (C.logNormObservable k) := by
  have hnorm : Measurable (C.normObservable k) := C.measurable_normObservable k
  unfold logNormObservable
  unfold normObservable at hnorm
  simpa only [ofReal_norm] using hnorm.ennreal_ofReal.ennreal_log
~~~

The subadditive result first uses matrix-norm submultiplicativity and then
Mathlib's unconditional product rule <code>ENNReal.log_mul_add</code>:

~~~lean
theorem logNormObservable_add_le
    (C : DiscreteMatrixCocycle (ι := ι) μ) (m k : ℕ) (ω : Ω) :
    C.logNormObservable (m + k) ω ≤
      C.logNormObservable k (C.base^[m] ω) + C.logNormObservable m ω := by
  rw [logNormObservable, C.value_add]
  calc
    ENNReal.log ‖C.value k (C.base^[m] ω) * C.value m ω‖ₑ ≤
        ENNReal.log (‖C.value k (C.base^[m] ω)‖ₑ * ‖C.value m ω‖ₑ) := by
      apply ENNReal.log_monotone
      simpa only [enorm_eq_nnnorm, ← ENNReal.coe_mul, ENNReal.coe_le_coe] using
        (nnnorm_mul_le (C.value k (C.base^[m] ω)) (C.value m ω))
    _ = ENNReal.log ‖C.value k (C.base^[m] ω)‖ₑ +
        ENNReal.log ‖C.value m ω‖ₑ := ENNReal.log_mul_add
~~~

**Full project check.** This uses the repository's pinned Lean and Mathlib
dependencies and may require substantial disk space and memory.
The nonnegative envelope is
defined separately in
[<code>LogPlusIntegrability.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/LogPlusIntegrability.lean):

~~~lean
def logPlusNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → ℝ :=
  fun ω ↦ log⁺ (C.normObservable k ω)

theorem measurable_logPlusNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    Measurable (C.logPlusNormObservable k) :=
  Real.continuous_posLog.measurable.comp (C.measurable_normObservable k)
~~~

These excerpts establish definitions and finite-horizon infrastructure. They
do not establish an asymptotic exponent.

## Standalone tutorial: symbolic worksheet

**Standalone tutorial.** Transcendental real logarithms
belong to Mathlib, so this dependency-light worksheet uses an exact symbolic
four-case ledger. It checks the branch logic with only <code>Std</code>; it
does not implement <code>EReal</code>, matrix norms, or analytic logarithms.

Save it as <code>LogNormFourCasesScratch.lean</code>:

~~~lean
import Std

inductive NormCase where
  | zero
  | half
  | one
  | expTwo
deriving Repr, BEq

inductive ExtendedLogValue where
  | bottom
  | negLogTwo
  | zero
  | two
deriving Repr, BEq

def extendedLogTable : NormCase → ExtendedLogValue
  | .zero => .bottom
  | .half => .negLogTwo
  | .one => .zero
  | .expTwo => .two

def logPlusTable : NormCase → Nat
  | .zero => 0
  | .half => 0
  | .one => 0
  | .expTwo => 2

def cases : List NormCase :=
  [.zero, .half, .one, .expTwo]

#eval cases.map fun c => (c, extendedLogTable c, logPlusTable c)
#eval extendedLogTable .zero == .bottom
#eval extendedLogTable .half == .negLogTwo
#eval logPlusTable .half == 0
#eval logPlusTable .expTwo == 2
~~~

Run it with the repository's pinned Lean version but outside the Mathlib
project:

~~~sh
elan run leanprover/lean4:v4.32.0 lean LogNormFourCasesScratch.lean
~~~

The first output should list
<code>(zero, bottom, 0)</code>,
<code>(half, negLogTwo, 0)</code>,
<code>(one, zero, 0)</code>, and
<code>(expTwo, two, 2)</code>. The four Boolean checks should all print
<code>true</code>.

This worksheet is intentionally a teaching surrogate. The exact analytic facts
are the pinned Mathlib and project declarations checked next.

## Try the exact declarations in the project

{{< repo-check >}}
**Full project check.** This uses the repository's pinned Lean and Mathlib
dependencies and may require substantial disk space and memory.
Create a temporary project worksheet containing:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability

open Matrix MeasureTheory
open scoped Matrix.Norms.Operator Real
open NonlinearDynamics.Random.RandomCocycles

#check ENNReal.log_zero
#check ENNReal.log_one
#check ENNReal.log_top
#check ENNReal.log_mul_add
#check ENNReal.log_eq_bot_iff
#check Real.posLog_apply
#check Real.posLog_zero
#check Real.posLog_one
#check Real.continuous_posLog
#check DiscreteMatrixCocycle.normObservable
#check DiscreteMatrixCocycle.normObservable_eq_rowSumSup
#check DiscreteMatrixCocycle.measurable_normObservable
#check DiscreteMatrixCocycle.logNormObservable
#check DiscreteMatrixCocycle.logNormObservable_eq_bot_iff
#check DiscreteMatrixCocycle.logNormObservable_zero
#check DiscreteMatrixCocycle.logNormObservable_one
#check DiscreteMatrixCocycle.measurable_logNormObservable
#check DiscreteMatrixCocycle.logNormObservable_add_le
#check DiscreteMatrixCocycle.logNormObservable_eq_bot_of_isEmpty
#check DiscreteMatrixCocycle.logPlusNormObservable
#check DiscreteMatrixCocycle.logPlusNormObservable_nonneg
#check DiscreteMatrixCocycle.logPlusNormObservable_zero
#check DiscreteMatrixCocycle.logPlusNormObservable_one
#check DiscreteMatrixCocycle.measurable_logPlusNormObservable
#check DiscreteMatrixCocycle.logPlusNormObservable_add_le
#check DiscreteMatrixCocycle.logPlusNormObservable_eq_zero_of_isEmpty
~~~

Each <code>#check</code> asks the pinned elaborator for the exact declaration
type; it does not execute a numerical simulation. The full-project command is:

~~~sh
cd formalization
lake env lean NonlinearDynamics/Random/RandomCocycles/LogPlusIntegrability.lean
~~~

This full project check uses the repository's pinned Lean and Mathlib
dependencies and may require substantial disk space and memory.
{{< /repo-check >}}

## What has and has not been formalized here

The checked finite-time layer provides:

- the maximum-row-sum norm observable;
- its exact row-sum formula;
- a zero-faithful signed extended log observable;
- bottom exactly at a zero cocycle matrix;
- a real-valued nonnegative log-positive envelope;
- measurability of both logarithmic observables;
- subadditivity across every finite cocycle split;
- the positive-dimensional time-zero normalization; and
- explicit empty-dimensional behavior.

It does **not** yet provide:

- integrability merely from measurability;
- a probability assumption on the base measure;
- normalized growth \(k^{-1}L_k\);
- almost-everywhere or \(L^1\) convergence;
- a Lyapunov exponent or Lyapunov spectrum;
- an Oseledets invariant splitting;
- invertibility or negative-time dynamics;
- a lower singular-value estimate;
- a distribution of the observable; or
- an identification of the generator with a nonlinear Jacobian.

It is also not a matrix logarithm. Nor is it the distinct **logarithmic norm**
or **matrix measure** used in some ODE stability arguments. Here the order is:
take a scalar operator norm first, then apply a scalar logarithm.

## Exercises

1. Compute both logarithmic observables for
   \(\operatorname{diag}(1/4,0)\). Which information does \(\log^+\) discard?
2. Compute both observables for \(2I\). Why is the infinity norm \(2\), not
   \(4\)?
3. Explain in one sentence why <code>⊥</code> cannot mean neutral growth.
4. Give two nonzero \(2\times2\) matrices whose product is zero. What are the
   three terms in the signed subadditive inequality?
5. Starting from measurable entries, reconstruct the six-step measurability
   argument above.
6. Why can this cocycle observable never equal <code>⊤</code> even though
   <code>ENNReal.log ⊤ = ⊤</code>?
7. Explain why <code>Real.log 0 = 0</code> is convenient for total real
   functions but unsuitable for recording exact matrix collapse.
8. List the additional assumptions needed before a subadditive ergodic theorem
   could turn finite-time growth into an almost-sure asymptotic rate.

## Where to continue

[Finite-Horizon Log-Positive Cocycle Integrability]({{< relref "/knowledge-base/deep-dives/finite-horizon-log-positive-cocycle-integrability" >}})
develops the nonnegative envelope, its orbit-sum majorant, and the explicit
one-step integrability hypothesis that propagates to finite horizons.

[The Forward-and-Inverse Tail Sandwich for Finite-Time Real Log Norms]({{< relref "/knowledge-base/deep-dives/forward-and-inverse-tail-sandwich-for-finite-time-real-log-norms" >}})
returns to signed real logarithms. It explains exactly when a nonzero cocycle
value lets the extended log be read as an ordinary real log and why inverse
tails are needed to control contraction.

[Finite-Time Norm and Extended-Log-Norm Observables for Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/finite-time-norm-and-extended-log-norm-cocycle-observables" >}})
derives the complete formal interface: row-sum measurability, zero-safe
subadditivity, time-zero normalization, and the empty-dimension ledger.

The {{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycle" >}}
entry supplies the base orbit and later-block-left product law. The
{{< refterm "log-positive-integrability-envelope" "log-positive integrability envelope" >}}
entry focuses on why contraction is deliberately removed.

## References

<a id="ref-extended-log-norm-mathlib-matrix"></a>**Mathlib contributors.**
[Norms on finite matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Normed.html),
Mathlib 4 documentation. This official source defines the maximum absolute
row-sum matrix norm and proves its product inequality and operator-norm
interpretation.

<a id="ref-extended-log-norm-mathlib-log"></a>**Mathlib contributors.**
[Extended nonnegative-real logarithm](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/SpecialFunctions/Log/ENNRealLog.html),
Mathlib 4 documentation. This official source defines <code>ENNReal.log</code>,
including <code>log 0 = ⊥</code>, <code>log ⊤ = ⊤</code>, strict monotonicity,
and the unconditional product-to-sum identity.

<a id="ref-extended-log-norm-mathlib-log-exp"></a>**Mathlib contributors.**
[Extended logarithm and exponential](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/SpecialFunctions/Log/ENNRealLogExp.html),
Mathlib 4 documentation. This official source packages the logarithm as an
order isomorphism and homeomorphism and proves its measurability.

<a id="ref-extended-log-norm-mathlib-poslog"></a>**Mathlib contributors.**
[Positive part of the real logarithm](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/SpecialFunctions/Log/PosLog.html),
Mathlib 4 documentation. This official source defines <code>Real.posLog</code>,
proves continuity and nonnegativity, and develops its product estimate.

<a id="ref-extended-log-norm-horn-johnson"></a>**Roger A. Horn and Charles R. Johnson.**
[Matrix Analysis, second edition](https://www.cambridge.org/highereducation/books/matrix-analysis/FDA3627DC2B9F5C3DF2FD8C3CC136B48),
Cambridge University Press, 2013, ISBN 978-0-521-54823-6. Chapter 5 develops
induced matrix norms and submultiplicativity. The project selects the maximum
absolute row-sum convention.

<a id="ref-extended-log-norm-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://www.jstor.org/stable/2984534),
*Journal of the Royal Statistical Society, Series B* 30(3), 1968, 499–510.
This primary source supplies a later asymptotic destination. The present page
does not claim Kingman's hypotheses or conclusions.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
