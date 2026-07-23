---
title: "Finite-Time Norm and Extended-Log-Norm Observables for Matrix Cocycles"
slug: "finite-time-norm-and-extended-log-norm-cocycle-observables"
date: 2026-07-21
summary: "Follow one positive two-step cocycle product and one exact collapse through the row-sum norm, real positive logarithm, extended logarithm, and finite normalization without confusing their codomains or zero policies."
lead: "The positive path has norm two; two nonzero projections collapse to norm zero. Their real positive logs are log two and zero, while their extended logs are log two and bottom."
draft: false
pro_reviewed: false
level: "Exact two-by-two arithmetic through measurable cocycle observables and extended-real subadditivity"
reading_time: "110 to 140 minutes"
prerequisites: "Two-by-two matrix multiplication and absolute values; cocycles, row-sum norms, positive logarithms, extended reals, measurability, and Lean syntax are introduced as they appear"
lean_module: "NonlinearDynamics.Random.RandomCocycles.NormObservables"
toc: true
og_image: "finite-time-norm-and-extended-log-norm-cocycle-observables-card.png"
og_image_alt: "Two horizon-two cocycle paths: a shear followed by a stretch gives matrix one one; zero two with row-sum norm two and factor budget four, while two nonzero coordinate projections multiply to the zero matrix with norm zero and factor budget one."
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
prose, sources, exact examples, Lean declaration map, worksheet, figures, and
accessibility have not yet received the required human and Pro reviews. The
page is publicly available as an open working note while those reviews remain
pending.
{{< /panel >}}

## Begin with two base points and two exact products

A matrix cocycle is a rule that reads a base state, applies the matrix stored
there, moves the base state, and repeats. To make every symbol concrete, take
the four-point base

\[
\Omega=\{p_0,p_1,z_0,z_1\}.
\]

Let the base map \(T:\Omega\to\Omega\) swap \(p_0\) with \(p_1\) and swap
\(z_0\) with \(z_1\). Give each point mass \(1/4\). This uniform probability
measure is preserved because \(T\) is a permutation, and every function on
this finite discrete space is measurable.

The probability weights make the bundled cocycle legitimate, but none of the
following pointwise arithmetic uses them. At the four base points, let the
generator be

\[
\begin{aligned}
A(p_0)&=A_0=
\begin{bmatrix}
1&1\\
0&1
\end{bmatrix},
&
A(p_1)&=A_1=
\begin{bmatrix}
1&0\\
0&2
\end{bmatrix},\\[4pt]
A(z_0)&=B_0=
\begin{bmatrix}
1&0\\
0&0
\end{bmatrix},
&
A(z_1)&=B_1=
\begin{bmatrix}
0&0\\
0&1
\end{bmatrix}.
\end{aligned}
\]

Regard these integer entries as complex numbers through the standard
embedding. No genuinely complex arithmetic is needed for this example.

For a generator-presented cocycle, the two-step value is

\[
C(2,\omega)=A(T\omega)A(\omega).
\]

The matrix at the starting state acts first and therefore appears on the
right.

### The positive-norm sample

Starting from \(p_0\), the shear acts before the stretch:

\[
\begin{aligned}
C(2,p_0)
&=A_1A_0\\
&=
\begin{bmatrix}
1&0\\
0&2
\end{bmatrix}
\begin{bmatrix}
1&1\\
0&1
\end{bmatrix}\\
&=
\begin{bmatrix}
1&1\\
0&2
\end{bmatrix}.
\end{aligned}
\]

The two absolute row sums are \(2\) and \(2\). Hence its induced infinity
operator norm, the maximum absolute row sum, is

\[
N_2(p_0)=\lVert C(2,p_0)\rVert_\infty=2.
\]

Each factor has norm \(2\), so the submultiplicative theorem gives the valid
but non-sharp budget \(2\leq2\cdot2=4\).

### The exact-collapse sample

Starting from \(z_0\), the first factor keeps only the first coordinate and the
second keeps only the second coordinate:

\[
\begin{aligned}
C(2,z_0)
&=B_1B_0\\
&=
\begin{bmatrix}
0&0\\
0&1
\end{bmatrix}
\begin{bmatrix}
1&0\\
0&0
\end{bmatrix}\\
&=
\begin{bmatrix}
0&0\\
0&0
\end{bmatrix}.
\end{aligned}
\]

Both \(B_0\) and \(B_1\) are nonzero and have norm \(1\), yet their product is
zero. Thus

\[
N_2(z_0)=0\leq1\cdot1.
\]

This is the boundary that decides which logarithm the formalization needs.

{{< reference-figure
  wide="true"
  src="positive-and-collapse-cocycle-ledger.svg"
  alt="A four-state base has two two-step paths. From p zero, a shear matrix acts first and a diagonal stretch acts second, producing matrix one one; zero two with row-sum norm two and factor budget four. From z zero, projection onto the first coordinate acts before projection onto the second, producing the zero matrix with norm zero even though both factors are nonzero and have norm one."
  caption="**Two exact sample paths:** \(C(2,p_0)=A_1A_0=\left[\begin{smallmatrix}1&1\\0&2\end{smallmatrix}\right]\) has norm \(2\), while \(C(2,z_0)=B_1B_0=0\) has norm \(0\) although both projection factors are nonzero. The base dynamics chooses the later factor; matrix action fixes the later-factor-left order; the norm bounds are \(2\leq4\) and \(0\leq1\). No probability average or limiting statement is shown."
>}}

## Four finite-time values with different jobs

The target module defines the real norm observable

\[
N_k(\omega)=\lVert C(k,\omega)\rVert_\infty\in\mathbb R
\]

and the extended-real logarithm

\[
L_k(\omega)
{} =
\operatorname{ENNReal.log}
\lVert C(k,\omega)\rVert_{\infty,e}
\in\overline{\mathbb R}.
\]

Here \(\overline{\mathbb R}\), Lean's <code>EReal</code>, is the real line
with bottom \(\bot=-\infty\) and top \(\top=+\infty\). The subscript \(e\)
only records the embedding of the nonnegative norm into the extended
nonnegative reals before taking the logarithm.

The immediate successor module defines a different real-valued function,

\[
G_k(\omega)
{} =
\log^+N_k(\omega)
{} =
\max\{0,\log N_k(\omega)\}
\in\mathbb R.
\]

This positive logarithm is an integrability envelope. It keeps expansion above
one and clips contraction, neutral norm, and exact collapse to zero
([Mathlib contributors](#ref-finite-log-norm-poslog)).

At a positive horizon, one can also inspect finite quotients

\[
\widehat G_k(\omega)=\frac{G_k(\omega)}{k},
\qquad
\widehat L_k(\omega)=\frac{L_k(\omega)}{k}.
\]

The second quotient is extended-real arithmetic; dividing bottom by a positive
finite number leaves bottom
([Mathlib contributors](#ref-finite-log-norm-ereal-div)). Neither quotient is defined by
<code>NormObservables.lean</code>, and one fixed quotient is not a limit.

For the two running samples at horizon two, the entire ledger is

| Quantity | Codomain | Positive path \(p_0\) | Collapse path \(z_0\) |
|---|---|---:|---:|
| Matrix value | \(M_2(\mathbb C)\) | \(\left[\begin{smallmatrix}1&1\\0&2\end{smallmatrix}\right]\) | \(0\) |
| \(N_2\) | \(\mathbb R\) | \(2\) | \(0\) |
| \(G_2=\log^+N_2\) | \(\mathbb R\) | \(\log2\) | \(0\) |
| \(L_2=\log_eN_2\) | <code>EReal</code> | \(\log2\) | \(\bot\) |
| \(\widehat G_2=G_2/2\) | \(\mathbb R\) | \(\frac12\log2\) | \(0\) |
| \(\widehat L_2=L_2/2\) | <code>EReal</code> | \(\frac12\log2\) | \(\bot\) |

The agreement on the positive path does not identify the two logarithms. Their
zero policies are intentionally different.

{{< reference-figure
  wide="true"
  src="log-codomain-and-normalization-ledger.svg"
  alt="A four-row comparison sends norms two, one, one half, and zero through the real positive logarithm and the extended-real logarithm. Norm two gives log two in both columns. Norm one gives zero in both. Norm one half gives zero in the positive-log column and negative log two in the extended-log column. Norm zero gives zero in the positive-log column and bottom in the extended-log column. At horizon two, normalization divides finite values by two and leaves bottom at bottom."
  caption="**Codomain and zero-policy audit:** \(\log^+\) is real and nonnegative, so it clips norm \(1/2\) and norm \(0\) to the same value \(0\). The extended logarithm preserves contraction as \(-\log2\) and exact collapse as \(\bot\). At the positive horizon \(k=2\), normalization uses two factors; it does not change which information each codomain retained."
>}}

## Controlled near-misses

### Using the ordinary real logarithm at zero

Lean's total real logarithm satisfies
\(\operatorname{Real.log}(0)=0=\operatorname{Real.log}(1)\). Defining the
collapse-sensitive observable with <code>Real.log</code> would make the zero
matrix look indistinguishable from norm one. The target module therefore uses
<code>ENNReal.log</code> into <code>EReal</code>.

### Calling the positive logarithm a signed growth rate

\(\log^+(1/2)=0\), \(\log^+(1)=0\), and \(\log^+(0)=0\). That loss is useful
when proving integrability of a nonnegative upper envelope, but it cannot
represent contraction or collapse. The later log-positive observable does not
replace \(L_k\).

### Dividing by the final factor index

Horizon two contains the factors with indices zero and one. Its normalizing
factor is \(2\), not the last index \(1\). Dividing by one would double the
positive path's finite normalized value and would divide by zero at horizon
one.

### Treating time-zero totalization as growth information

Classically, \(X_0/0\) is not a normalized growth rate. Much later, the generic
real <code>normalizedProcess</code> defines the time-zero quotient to be zero
because Lean's real division is total. Its own theorem says that this value
forgets \(X_0\) completely. Positive-time asymptotics may ignore that finite
prefix; this page must not reinterpret it as a meaningful zero-step rate.

## Keep the formal layers separate

| Layer | Checked object or property | What it does not supply |
|---|---|---|
| Sample matrix | \(C(k,\omega)\) | A probability law or expectation |
| Target finite observable | \(N_k:\Omega\to\mathbb R\) | Integrability or normalized growth |
| Target extended observable | \(L_k:\Omega\to\overline{\mathbb R}\) | Almost-sure finiteness or an integral |
| Target regularity | Measurability of \(N_k\) and \(L_k\) | Integrability; measurable is weaker |
| Successor envelope | \(G_k=\log^+N_k:\Omega\to\mathbb R\) | Signed contraction or collapse data |
| Successor hypothesis | One-step integrability propagated to finite \(G_k\) | Automatic integrability from preservation |
| Probability law | A pushforward measure such as \((N_k)_*\mu\) | Not defined in either observable module |
| Positive-time normalization | A fixed quotient by \(k\) | A limit or Lyapunov exponent |
| Asymptotic theory | Kingman- or Oseledets-type conclusions under extra hypotheses | Not contained in this finite-time module |

The module
<code>NonlinearDynamics.Random.RandomCocycles.NormObservables</code> contains
fourteen public declarations. It proves finite pointwise algebra and
measurability only. Probability normalization, integrability, normalized
limits, Lyapunov exponents, and invariant splittings are separate later
decisions.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [Two exact products](#begin-with-two-base-points-and-two-exact-products) | Compute a positive norm and an exact collapse |
| Codomain route | [Four finite-time values](#four-finite-time-values-with-different-jobs) | Separate real norm, positive log, extended log, and normalized quotients |
| Near-miss route | [Controlled near-misses](#controlled-near-misses) | Audit zero policies, factor counts, and time-zero totalization |
| Norm route | [Why this particular matrix norm](#camp-one-why-this-particular-matrix-norm) | Compute the maximum absolute row sum and identify the active Lean scope |
| Measure route | [Prove norm measurability from entries](#camp-four-prove-norm-measurability-from-entries) | Audit every closure step without assuming a hidden Borel instance |
| Endpoint route | [Why the ordinary real logarithm is the wrong totalization](#camp-five-why-the-ordinary-real-logarithm-is-the-wrong-totalization) | Preserve the difference between norm one and norm zero |
| Inequality route | [The zero-safe subadditivity proof](#camp-seven-the-zero-safe-subadditivity-proof) | Follow cocycle law, norm bound, monotonicity, and product-to-sum |
| Dimension route | [Positive and empty dimensions](#camp-eight-positive-and-empty-dimensions) | See exactly where nonempty coordinates are required |
| Lean route | [Seven exact bridges](#in-lean-seven-bridges-from-finite-matrices-to-later-normalization) | Translate human claims into exact project syntax |
| Hands-on route | [Run the worksheet](#type-the-two-ledgers-yourself-with-lean-and-std) | Recheck the integer products and symbolic zero policies locally |
| Interface route | [The complete fourteen-declaration map](#the-complete-fourteen-declaration-map) | Audit every public name, assumption, and output |
| Summit route | [What has and has not been proved](#summit-what-has-and-has-not-been-proved) | Keep the finite-time boundary intact |

### Learning objectives

By the summit, you should be able to reproduce both two-step products and every
row-sum norm; distinguish \(N_k\), \(G_k\), \(L_k\), and their positive-time
quotients by codomain and zero policy; explain why two nonzero factors may
produce bottom; read seven Lean bridges token by token; run the bounded
<code>Std</code> worksheet; reconstruct norm and log-norm measurability; follow
the zero-safe subadditivity proof; audit all fourteen target declarations; and
state precisely which integrability, law-level, normalized, ergodic, and
Lyapunov conclusions remain outside this module.

## In Lean: seven bridges from finite matrices to later normalization

The first five bridges belong to the target module. Bridge six is the
real-valued positive-log successor, and bridge seven is a much later generic
normalization utility. Their separate homes are part of the lesson.

### Bridge one: the finite norm is an ordinary real

{{< lean-bridge
  human="At a fixed horizon and base state, measure the cocycle matrix by its maximum absolute row sum."
  math="\(N_k(\omega)=\lVert C(k,\omega)\rVert_\infty\in\mathbb R.\)"
  lean="C.normObservable k ω : ℝ"
>}}

- <code>C</code> is a bundled one-sided discrete complex matrix cocycle.
- <code>k</code> is a natural-number factor count.
- <code>ω</code> is one base state, not a probability distribution.
- <code>normObservable</code> returns a function
  <code>Ω → ℝ</code>; supplying <code>ω</code> evaluates it.
- The active <code>Matrix.Norms.Operator</code> scope makes the matrix norm the
  maximum absolute row sum.
{{< /lean-bridge >}}

### Bridge two: cocycle splitting gives a norm budget

{{< lean-bridge
  human="The norm of the full history is at most the shifted later-block norm times the early-block norm."
  math="\(N_{m+k}(\omega)\leq N_k(T^m\omega)N_m(\omega).\)"
  lean="C.normObservable_add_le m k ω"
>}}

- <code>m + k</code> is the total factor count.
- <code>C.base^[m] ω</code> is the base state after the early block.
- The later block is evaluated there and its matrix acts on the left.
- <code>≤</code>, rather than equality, comes from matrix-norm
  submultiplicativity.
- This theorem is pointwise and assumes neither a probability measure nor
  integrability.
{{< /lean-bridge >}}

### Bridge three: the collapse-sensitive logarithm changes codomain

{{< lean-bridge
  human="Embed the nonnegative matrix norm into the extended nonnegative reals, then take the logarithm into the extended reals."
  math="\(L_k(\omega)=\log_e\lVert C(k,\omega)\rVert_\infty\in\overline{\mathbb R}.\)"
  lean="C.logNormObservable k ω : EReal"
>}}

- <code>EReal</code> contains finite real values, bottom, and top.
- <code>‖C.value k ω‖ₑ</code> is the extended nonnegative norm input.
- <code>ENNReal.log</code> sends zero to bottom instead of using
  <code>Real.log 0 = 0</code>.
- The result is not automatically coercible to an ordinary real.
- The target module defines no normalization of this value.
{{< /lean-bridge >}}

### Bridge four: bottom means exact matrix collapse

{{< lean-bridge
  human="The extended log norm is negative infinity exactly when the complete finite cocycle matrix is zero."
  math="\(L_k(\omega)=\bot\Longleftrightarrow C(k,\omega)=0.\)"
  lean="C.logNormObservable_eq_bot_iff k ω"
>}}

- <code>⊥</code> is bottom in <code>EReal</code>, interpreted here as negative
  infinity.
- The right side says the entire matrix is the zero matrix.
- A singular but nonzero matrix does not satisfy the right side.
- The equivalence is exact and pointwise; it is not an almost-everywhere
  statement.
- For the running collapse path, this theorem turns
  <code>B1 * B0 = 0</code> into <code>L₂(z₀) = ⊥</code>.
{{< /lean-bridge >}}

### Bridge five: extended log norms are zero-safe subadditive

{{< lean-bridge
  human="Across every finite split, the full extended log norm is at most the sum of the shifted later and early extended log norms."
  math="\(L_{m+k}(\omega)\leq L_k(T^m\omega)+L_m(\omega).\)"
  lean="C.logNormObservable_add_le m k ω"
>}}

- The cocycle law first rewrites the full value as a matrix product.
- <code>nnnorm_mul_le</code> supplies the multiplicative norm upper bound.
- <code>ENNReal.log_monotone</code> preserves that inequality.
- <code>ENNReal.log_mul_add</code> changes the scalar product into a sum.
- Zero factors and zero products require no side condition; bottom arithmetic
  remains inside the codomain.
{{< /lean-bridge >}}

### Bridge six: the later positive logarithm is a real upper envelope

{{< lean-bridge
  human="The positive logarithm of every finite norm is a nonnegative real number."
  math="\(0\leq G_k(\omega)=\log^+N_k(\omega).\)"
  lean="C.logPlusNormObservable_nonneg k ω"
>}}

- This theorem lives in <code>LogPlusIntegrability.lean</code>, not the target
  module.
- <code>log⁺</code> is <code>Real.posLog</code>, defined as
  <code>max 0 (Real.log ·)</code>.
- Its codomain is <code>ℝ</code>, so there is no bottom value.
- Norms zero, one half, and one all produce the value zero.
- A separate <code>HasIntegrableGeneratorLogPlus</code> hypothesis is needed
  before the successor proves finite-horizon integrability.
{{< /lean-bridge >}}

### Bridge seven: normalization is a later real-process operation

{{< lean-bridge
  human="A later generic helper divides a real process value by the natural horizon, coerced to a real number."
  math="\(Q_k(\omega)=X_k(\omega)/k.\)"
  lean="NonlinearDynamics.Random.RandomCocycles.normalizedProcess X k ω"
>}}

- <code>X</code> must be real-valued; the helper does not normalize
  <code>EReal</code>-valued \(L_k\).
- <code>(k : ℝ)</code> is the real coercion of the natural horizon.
- At positive <code>k</code>, this is the ordinary finite quotient.
- At <code>k = 0</code>, totalized real division returns zero and forgets
  <code>X 0 ω</code>; <code>normalizedProcess_zero</code> records that boundary.
- A sequence of finite quotients is not a convergence theorem.
{{< /lean-bridge >}}

### Try the exact target interfaces

{{< repo-check >}}
**Full project check: pinned project plus Mathlib.** Use a temporary project
scratch file containing:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.NormObservables

open Matrix MeasureTheory
open scoped Matrix.Norms.Operator
open NonlinearDynamics.Random.RandomCocycles

#print DiscreteMatrixCocycle.normObservable
#check DiscreteMatrixCocycle.normObservable_eq_rowSumSup
#check DiscreteMatrixCocycle.normObservable_zero
#check DiscreteMatrixCocycle.normObservable_one
#check DiscreteMatrixCocycle.normObservable_add_le
#check DiscreteMatrixCocycle.measurable_normObservable
#print DiscreteMatrixCocycle.logNormObservable
#check DiscreteMatrixCocycle.logNormObservable_eq_bot_iff
#check DiscreteMatrixCocycle.logNormObservable_zero
#check DiscreteMatrixCocycle.logNormObservable_one
#check DiscreteMatrixCocycle.measurable_logNormObservable
#check DiscreteMatrixCocycle.logNormObservable_add_le
#check DiscreteMatrixCocycle.normObservable_eq_zero_of_isEmpty
#check DiscreteMatrixCocycle.logNormObservable_eq_bot_of_isEmpty
~~~

This is the complete fourteen-declaration target interface. The full project
command rendered below checks the authoritative module with the pinned
dependencies.
{{< /repo-check >}}

### Inspect the separate positive-log and integrability successor

{{< repo-check module="NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability" >}}
**Full project check: later pinned project module plus Mathlib.**

~~~lean
import NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability

open NonlinearDynamics.Random.RandomCocycles

#print DiscreteMatrixCocycle.logPlusNormObservable
#check DiscreteMatrixCocycle.logPlusNormObservable_nonneg
#check DiscreteMatrixCocycle.measurable_logPlusNormObservable
#check DiscreteMatrixCocycle.logPlusNormObservable_add_le
#print DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integrable_logPlusNormObservable
~~~

The successor proves measurability unconditionally and finite-horizon
integrability only from the named one-step hypothesis. It defines no
pushforward probability law and proves no asymptotic limit.
{{< /repo-check >}}

### Inspect the much later real normalization boundary

{{< repo-check module="NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman" >}}
**Full project check: much later pinned project module plus Mathlib.**

~~~lean
import NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman

open NonlinearDynamics.Random.RandomCocycles

#print normalizedProcess
#check normalizedProcess_zero
#check normalizedProcess_update_zero
~~~

These declarations explain the real time-zero policy only. The later module
contains stronger theorems under stronger hypotheses, but importing it does
not retroactively add normalization or convergence to
<code>NormObservables.lean</code>.
{{< /repo-check >}}

## The analytic pipeline in one picture

{{< reference-figure
  src="norm-to-log-subadditivity.svg"
  alt="An early cocycle block and a shifted later block combine with the later block acting second. The full finite matrix passes to the maximum absolute row-sum norm, whose multiplicative upper bound passes through a zero-aware extended logarithm and becomes additive. A final branch separates nonempty coordinates, with time-zero norm one and log value zero, from empty coordinates, with every norm zero and every log value bottom."
  caption="**Finding:** the cocycle split supplies a matrix product, the maximum absolute row-sum norm supplies a multiplicative upper budget, and the extended logarithm converts that budget into a zero-safe additive one. Nonempty coordinates recover the familiar time-zero normalization; empty coordinates remain valid but every finite matrix norm is zero and every log norm is bottom. The figure asserts no integrability, limiting growth rate, or invariant splitting."
>}}

The picture separates three structures that are often conflated:

- the base map decides where the later cocycle block begins;
- matrix multiplication decides how the blocks compose; and
- the norm and logarithm decide how to summarize the size of that composition.

Each layer has its own assumptions and its own failure modes.

## Base camp: the checked cocycle input

The preceding random-matrix-theory milestone 13 (RMT-13) fixes a type
\(\Omega\) of base states with a measurable-space structure, a finite matrix
index type \(\iota\) with decidable equality, and a measure \(\mu\) on
\(\Omega\). A bundled <code>DiscreteMatrixCocycle μ</code> stores:

- a base map \(T:\Omega\to\Omega\);
- a complex matrix generator \(A:\Omega\to M_\iota(\mathbb C)\);
- evidence that \(T\) preserves \(\mu\); and
- ordinary measurability of \(A\).

The measure-preserving field gives ordinary measurability of \(T\). RMT-13
therefore proves that every finite value

\[
\omega\longmapsto C(k,\omega)
\]

is measurable.

Random-matrix-theory milestone 14 (RMT-14), the target of this chapter,
consumes exactly that interface. It does not add a probability instance for
\(\mu\), and none of its finite-time pointwise inequalities uses measure
preservation. The stored measurable structure matters for the two observable
measurability theorems; the algebraic inequalities follow pointwise from the
cocycle law and matrix norm.

That separation is useful. A theorem about one fixed \(\omega\) should not
quietly depend on probability or ergodicity.

## Camp one: why this particular matrix norm

For a finite complex matrix \(B=(B_{ij})\), define

\[
\lVert B\rVert_\infty
{} =
\max_{i\in\iota}\sum_{j\in\iota}|B_{ij}|.
\]

For each row, add the absolute values of all entries. Then keep the largest row
total. This is the **maximum absolute row-sum norm**.

Why does it control column-vector evolution? Give \(x=(x_j)\) the supremum
norm

\[
\lVert x\rVert_\infty=\max_j|x_j|.
\]

For the \(i\)-th output coordinate,

\[
\begin{aligned}
|(Bx)_i|
&=\left|\sum_j B_{ij}x_j\right|\\
&\leq\sum_j|B_{ij}|\,|x_j|\\
&\leq\left(\sum_j|B_{ij}|\right)\lVert x\rVert_\infty.
\end{aligned}
\]

Taking the maximum over \(i\) yields

\[
\lVert Bx\rVert_\infty
\leq
\lVert B\rVert_\infty\lVert x\rVert_\infty.
\]

Mathlib proves that the row-sum formula agrees with the operator norm of the
associated continuous linear map between finite function spaces carrying the
supremum norm
([Mathlib contributors](#ref-finite-log-norm-matrix)).

This norm is not the Frobenius norm

\[
\lVert B\rVert_F
{} =
\left(\sum_{i,j}|B_{ij}|^2\right)^{1/2},
\]

and it is not the Euclidean spectral operator norm. It is chosen because
Mathlib already gives it a submultiplicative normed-ring interface and because
it naturally controls supremum-norm vector evolution.

### The Lean scope is semantic

Finite matrices admit several useful norms. Mathlib therefore does not install
one matrix norm globally as the only possible interpretation. The module opens

~~~lean
open scoped Matrix.Norms.Operator
~~~

before using <code>‖B‖</code>. Under that scope, the notation means the maximum
absolute row-sum norm. The theorem
<code>normObservable_eq_rowSumSup</code> then exposes the precise finite formula
in the public interface.

## Camp two: define the finite-time norm observable

The first declaration is

~~~lean
def normObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → ℝ :=
  fun ω ↦ ‖C.value k ω‖
~~~

Write

\[
N_k(\omega)=\lVert C(k,\omega)\rVert_\infty.
\]

The result is a real-valued function on base states. It is nonnegative because
it is a norm, but the definition does not package that fact into a nonnegative
real codomain. The later logarithm deliberately takes the extended norm
notation instead.

The second declaration states the exact formula

\[
N_k(\omega)
{} =
\max_{i\in\iota}
\sum_{j\in\iota}|C(k,\omega)_{ij}|.
\]

In Lean, the maximum is a <code>Finset.sup</code> in the nonnegative real type,
and the final value is coerced to an ordinary real. This representation has a
defined empty-family supremum, which will matter at the dimension boundary.

## Camp three: zero time, one step, and a split

The RMT-13 value equations immediately give two normalization identities.

At time one,

\[
N_1(\omega)=\lVert A(\omega)\rVert_\infty,
\]

because the one-step cocycle value is the generator. This theorem needs no
positive-dimension assumption.

At time zero, the value is the identity matrix. In nonempty dimension,

\[
N_0(\omega)=\lVert I\rVert_\infty=1.
\]

This is <code>normObservable_zero</code>, and its
<code>Nonempty ι</code> hypothesis is essential. In empty dimension the row
maximum is taken over no rows and equals zero.

For a split into \(m\) early steps and \(k\) shifted later steps, substitute
the cocycle law into the norm:

\[
\begin{aligned}
N_{m+k}(\omega)
&=\left\lVert C(k,T^m\omega)C(m,\omega)\right\rVert_\infty\\
&\leq
\lVert C(k,T^m\omega)\rVert_\infty
\lVert C(m,\omega)\rVert_\infty\\
&=N_k(T^m\omega)N_m(\omega).
\end{aligned}
\]

The theorem <code>normObservable_add_le</code> is pointwise and needs no
<code>Nonempty ι</code>. Matrix norm submultiplicativity remains true on the
trivial empty matrix space.

The order of terms mirrors matrix action. The shifted later block appears
first in the product on the right because it is the left matrix factor. Since
real multiplication commutes, the numerical product would be unchanged if
written in the other order, but keeping the cocycle order visible prevents the
underlying noncommutative statement from being forgotten.

## Camp four: prove norm measurability from entries

It is tempting to say “norms are continuous, so the norm observable is
measurable.” That shortcut would skip a project-specific seam. The random
matrix measurable space was introduced entrywise, while the matrix norm comes
from a scoped analytic instance. RMT-14 proves the connection directly rather
than silently assuming those structures coincide in the needed way.

Start with the RMT-13 theorem

\[
\omega\longmapsto C(k,\omega)
\quad\text{is measurable.}
\]

The proof of <code>measurable_normObservable</code> then climbs four finite
closure steps.

### Step one: extract a measurable entry

For fixed \(i,j\in\iota\),

\[
\omega\longmapsto C(k,\omega)_{ij}
\]

is measurable by <code>RandomMatrix.measurable_entry</code>.

### Step two: take the complex norm

The map

\[
\omega\longmapsto |C(k,\omega)_{ij}|
\]

is measurable. The Lean proof uses the nonnegative norm method
<code>.nnnorm</code>, so the values lie in the nonnegative reals.

### Step three: sum one row

For each fixed row \(i\), the finite sum

\[
\omega\longmapsto\sum_{j\in\iota}|C(k,\omega)_{ij}|
\]

is measurable by <code>Finset.measurable_sum</code>.

### Step four: take the finite supremum over rows

The proof establishes measurability for the supremum over an arbitrary finite
set of rows by induction. The empty supremum is the constant zero function.
Inserting a row replaces the previous supremum by the maximum of two
measurable functions. The <code>Measurable.max</code> closure theorem finishes
that step.

Finally, <code>Matrix.linfty_opNorm_def</code> identifies this finite supremum
with the scoped matrix norm, and coercion from nonnegative reals to reals
preserves measurability.

This proof works in empty dimension because both finite induction base cases
are explicit.

## Camp five: why the ordinary real logarithm is the wrong totalization

For a positive real \(r\), the ordinary logarithm changes multiplication into
addition:

\[
\log(rs)=\log r+\log s.
\]

The boundary \(r=0\) creates the design problem. Mathematically, one usually
thinks of \(\log r\) tending to negative infinity as \(r\) decreases to zero.
Lean's <code>Real.log</code> is a total function on all real inputs and uses

\[
\operatorname{Real.log}(0)=0.
\]

That convention is useful for total theorem statements, but it is wrong for
this observable. It would assign the same logarithmic value to norm zero and
norm one:

\[
\operatorname{Real.log}(0)=0=\operatorname{Real.log}(1).
\]

Exact matrix collapse would look like neutral size.

The module instead uses two extended number systems.

### Extended nonnegative real input

Mathlib's type <code>ℝ≥0∞</code>, also named <code>ENNReal</code>, contains all
nonnegative real numbers together with a top endpoint. The extended norm
notation <code>‖B‖ₑ</code> lands there.

### Extended real output

Mathlib's <code>EReal</code> contains the real line together with bottom and
top endpoints. The function

~~~lean
ENNReal.log : ℝ≥0∞ → EReal
~~~

satisfies

\[
\operatorname{ENNReal.log}(0)=\bot,
\qquad
\operatorname{ENNReal.log}(1)=0,
\]

is strictly increasing, and obeys an unconditional product-to-sum identity
([Mathlib contributors](#ref-finite-log-norm-ennreal-log)).

The seventh public declaration is therefore

~~~lean
def logNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → EReal :=
  fun ω ↦ ENNReal.log ‖C.value k ω‖ₑ
~~~

Write this value as \(L_k(\omega)\).

## Camp six: bottom exactly characterizes collapse

The theorem <code>logNormObservable_eq_bot_iff</code> states

\[
L_k(\omega)=\bot
\quad\Longleftrightarrow\quad
C(k,\omega)=0.
\]

This is an exact pointwise equivalence, not merely one implication. It follows
from the exact endpoint theorem

\[
\operatorname{ENNReal.log}(r)=\bot
\quad\Longleftrightarrow\quad
r=0
\]

and the zero-norm criterion.

Bottom has a semantic role. It means the finite matrix value is exactly the
zero matrix. It does not mean “unknown,” “not measurable,” “outside the
domain,” or “the proof failed.”

When the matrix value is nonzero, its norm is positive and finite, so the
extended log norm agrees with an ordinary finite real logarithm. The sign has
a direct finite-time interpretation:

\[
\begin{array}{c|c}
L_k(\omega)\lt0 & 0\lt N_k(\omega)\lt1\\
L_k(\omega)=0 & N_k(\omega)=1\\
L_k(\omega)\gt0 & N_k(\omega)\gt1.
\end{array}
\]

These are worst-case operator-norm budgets. A negative value gives a strict
supremum-norm contraction bound for the complete finite matrix, but a positive
value does not force every vector to grow, and a zero value does not identify
the matrix with the identity. A nonzero singular matrix still has a finite
log-norm value; bottom characterizes the zero matrix, not singularity.

The one-step and time-zero identities follow the norm layer:

\[
L_1(\omega)
{} =
\operatorname{ENNReal.log}\lVert A(\omega)\rVert_{\infty,e},
\]

and, when \(\iota\) is nonempty,

\[
L_0(\omega)=0.
\]

The subscript \(e\) in the first display only reminds us that the norm has
been embedded into the extended nonnegative reals. It does not select a new
matrix norm.

### Measurability of the extended log norm

The theorem <code>measurable_logNormObservable</code> composes three checked
maps:

1. the real-valued norm observable is measurable;
2. <code>ENNReal.ofReal</code> measurably embeds its nonnegative values; and
3. <code>ENNReal.log</code> is measurable.

The key Mathlib identity <code>ofReal_norm</code> reconciles the real norm
followed by <code>ENNReal.ofReal</code> with the extended norm notation used in
the definition.

Measurability reaches no further. It does not show that the extended value is
integrable, that its positive or negative parts have finite integral, or that
bottom occurs only on a null set.

## Camp seven: the zero-safe subadditivity proof

The theorem <code>logNormObservable_add_le</code> states

\[
L_{m+k}(\omega)
\leq
L_k(T^m\omega)+L_m(\omega).
\]

Its proof is a compact four-link chain.

### Link one: rewrite by the cocycle law

Replace the full matrix value with the shifted later block times the early
block:

\[
C(m+k,\omega)
{} =
C(k,T^m\omega)C(m,\omega).
\]

### Link two: apply the extended norm product bound

The chosen matrix norm is submultiplicative:

\[
\left\lVert C(k,T^m\omega)C(m,\omega)\right\rVert_{\infty,e}
\leq
\lVert C(k,T^m\omega)\rVert_{\infty,e}
\lVert C(m,\omega)\rVert_{\infty,e}.
\]

The Lean proof starts with the nonnegative norm inequality
<code>nnnorm_mul_le</code>, then coerces it into <code>ENNReal</code>.

### Link three: use logarithm monotonicity

Because <code>ENNReal.log</code> is monotone, the preceding norm inequality can
be passed through the logarithm without reversing its direction.

### Link four: turn the product into a sum

Mathlib's <code>ENNReal.log_mul_add</code> gives

\[
\operatorname{ENNReal.log}(rs)
{} =
\operatorname{ENNReal.log}(r)+
\operatorname{ENNReal.log}(s)
\]

for all extended nonnegative \(r\) and \(s\), including zero and top endpoints.
For finite matrix norms only the finite and zero cases arise, but the theorem
does not need to split them.

This makes the proof zero-safe. No assumption says that either block is
invertible or nonzero.

### Nonzero factors can still collapse

Even if both block matrices are nonzero, their product may be zero. For
example,

\[
B=
\begin{bmatrix}
1 & 0\\
0 & 0
\end{bmatrix},
\qquad
D=
\begin{bmatrix}
0 & 0\\
0 & 1
\end{bmatrix}
\]

are nonzero but \(DB=0\). Then the full log norm is bottom while both block log
norms are zero, since both block norms equal one. The inequality reads

\[
\bot\leq0+0,
\]

which is true. This example also shows why subadditivity is an inequality, not
an equality.

## Return to the two sample paths after the general theorem

Split each horizon-two path after its first factor, so \(m=k=1\). On the
positive path, the norm theorem reads

\[
2=N_2(p_0)
\leq
N_1(p_1)N_1(p_0)
=2\cdot2=4,
\]

and extended-log subadditivity reads

\[
\log2=L_2(p_0)
\leq
L_1(p_1)+L_1(p_0)
=\log2+\log2.
\]

On the collapse path,

\[
0=N_2(z_0)\leq1\cdot1,
\]

while both one-step extended logs are zero and the full extended log is
bottom:

\[
\bot=L_2(z_0)\leq0+0.
\]

The positive-log successor instead reports \(G_2(z_0)=0\). The values satisfy
their own theorems; they answer different questions.

## Type the two ledgers yourself with Lean and Std

The project modules use Mathlib's general matrices, measurable cocycles,
extended reals, and operator norm. A learner can first verify the exact integer
products, row-sum norms, and symbolic zero policies with a bounded file that
imports only <code>Std</code>.

Create a scratch directory outside <code>formalization/</code>. Save this exact
block as <code>FiniteCocycleObservablesTutorial.lean</code>:

~~~lean
import Std

namespace FiniteCocycleObservablesTutorial

structure Matrix2 where
  a00 : Int
  a01 : Int
  a10 : Int
  a11 : Int
  deriving Repr, DecidableEq

def Matrix2.mul (A B : Matrix2) : Matrix2 :=
  { a00 := A.a00 * B.a00 + A.a01 * B.a10
    a01 := A.a00 * B.a01 + A.a01 * B.a11
    a10 := A.a10 * B.a00 + A.a11 * B.a10
    a11 := A.a10 * B.a01 + A.a11 * B.a11 }

def Matrix2.linftyOpNorm (A : Matrix2) : Nat :=
  max (A.a00.natAbs + A.a01.natAbs)
      (A.a10.natAbs + A.a11.natAbs)

def A0 : Matrix2 :=
  { a00 := 1, a01 := 1, a10 := 0, a11 := 1 }

def A1 : Matrix2 :=
  { a00 := 1, a01 := 0, a10 := 0, a11 := 2 }

def B0 : Matrix2 :=
  { a00 := 1, a01 := 0, a10 := 0, a11 := 0 }

def B1 : Matrix2 :=
  { a00 := 0, a01 := 0, a10 := 0, a11 := 1 }

def positiveProduct : Matrix2 := A1.mul A0
def collapseProduct : Matrix2 := B1.mul B0

inductive LogValue where
  | bottom
  | zero
  | logOfNat (n : Nat)
  deriving Repr, DecidableEq

def positiveLogToken (n : Nat) : LogValue :=
  if n ≤ 1 then .zero else .logOfNat n

def extendedLogToken (n : Nat) : LogValue :=
  if n = 0 then .bottom
  else if n = 1 then .zero
  else .logOfNat n

structure FiniteQuotient where
  numerator : LogValue
  factorCount : Nat
  deriving Repr, DecidableEq

def normalizeAt (k : Nat) (value : LogValue) : Option FiniteQuotient :=
  if k = 0 then none else some { numerator := value, factorCount := k }

structure ObservableLedger where
  product : Matrix2
  productNorm : Nat
  factorNormBudget : Nat
  positiveLog : LogValue
  extendedLog : LogValue
  normalizedPositiveLog : Option FiniteQuotient
  normalizedExtendedLog : Option FiniteQuotient
  deriving Repr, DecidableEq

def ledger (left right : Matrix2) : ObservableLedger :=
  let product := left.mul right
  let norm := product.linftyOpNorm
  { product := product
    productNorm := norm
    factorNormBudget := left.linftyOpNorm * right.linftyOpNorm
    positiveLog := positiveLogToken norm
    extendedLog := extendedLogToken norm
    normalizedPositiveLog := normalizeAt 2 (positiveLogToken norm)
    normalizedExtendedLog := normalizeAt 2 (extendedLogToken norm) }

def positiveLedger : ObservableLedger := ledger A1 A0
def collapseLedger : ObservableLedger := ledger B1 B0

#eval [positiveProduct, collapseProduct]
#eval [A0.linftyOpNorm, A1.linftyOpNorm,
  positiveProduct.linftyOpNorm,
  B0.linftyOpNorm, B1.linftyOpNorm,
  collapseProduct.linftyOpNorm]
#eval positiveLedger
#eval collapseLedger
#eval [positiveLogToken 0, positiveLogToken 1, positiveLogToken 2]
#eval [extendedLogToken 0, extendedLogToken 1, extendedLogToken 2]
#eval normalizeAt 0 (.logOfNat 2)

example : positiveProduct =
    { a00 := 1, a01 := 1, a10 := 0, a11 := 2 } := by decide
example : collapseProduct =
    { a00 := 0, a01 := 0, a10 := 0, a11 := 0 } := by decide
example : positiveProduct.linftyOpNorm = 2 := by decide
example : collapseProduct.linftyOpNorm = 0 := by decide
example : positiveLedger.factorNormBudget = 4 := by decide
example : collapseLedger.factorNormBudget = 1 := by decide
example : positiveLedger.positiveLog = .logOfNat 2 := by decide
example : positiveLedger.extendedLog = .logOfNat 2 := by decide
example : collapseLedger.positiveLog = .zero := by decide
example : collapseLedger.extendedLog = .bottom := by decide
example : normalizeAt 0 (.logOfNat 2) = none := by decide

end FiniteCocycleObservablesTutorial
~~~

Open a terminal in that scratch directory and type:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean FiniteCocycleObservablesTutorial.lean
~~~

**Resource label: small standalone Lean tutorial, ordinary Mac or Linux.**
This exact worksheet was executed with Lean 4.32.0 and printed:

~~~text
[{ a00 := 1, a01 := 1, a10 := 0, a11 := 2 }, { a00 := 0, a01 := 0, a10 := 0, a11 := 0 }]
[2, 2, 2, 1, 1, 0]
{ product := { a00 := 1, a01 := 1, a10 := 0, a11 := 2 },
  productNorm := 2,
  factorNormBudget := 4,
  positiveLog := FiniteCocycleObservablesTutorial.LogValue.logOfNat 2,
  extendedLog := FiniteCocycleObservablesTutorial.LogValue.logOfNat 2,
  normalizedPositiveLog := some { numerator := FiniteCocycleObservablesTutorial.LogValue.logOfNat 2, factorCount := 2 },
  normalizedExtendedLog := some { numerator := FiniteCocycleObservablesTutorial.LogValue.logOfNat 2,
                             factorCount := 2 } }
{ product := { a00 := 0, a01 := 0, a10 := 0, a11 := 0 },
  productNorm := 0,
  factorNormBudget := 1,
  positiveLog := FiniteCocycleObservablesTutorial.LogValue.zero,
  extendedLog := FiniteCocycleObservablesTutorial.LogValue.bottom,
  normalizedPositiveLog := some { numerator := FiniteCocycleObservablesTutorial.LogValue.zero, factorCount := 2 },
  normalizedExtendedLog := some { numerator := FiniteCocycleObservablesTutorial.LogValue.bottom, factorCount := 2 } }
[FiniteCocycleObservablesTutorial.LogValue.zero,
 FiniteCocycleObservablesTutorial.LogValue.zero,
 FiniteCocycleObservablesTutorial.LogValue.logOfNat 2]
[FiniteCocycleObservablesTutorial.LogValue.bottom,
 FiniteCocycleObservablesTutorial.LogValue.zero,
 FiniteCocycleObservablesTutorial.LogValue.logOfNat 2]
none
~~~

Read the output in layers:

1. the two products are the positive matrix and the zero matrix;
2. the factor and product norms are \(2,2,2\) and \(1,1,0\);
3. the positive ledger stores the symbolic numerator \(\log2\) in both
   logarithm slots and the factor count two;
4. the collapse ledger stores zero for the positive logarithm and bottom for
   the extended logarithm;
5. the separate token lists expose the policies at norms zero, one, and two;
   and
6. conventional normalization at horizon zero returns <code>none</code>.

<code>LogValue.logOfNat 2</code> is a symbolic token for the exact expression
\(\log2\); the worksheet does not approximate a transcendental number.
Likewise, <code>LogValue.bottom</code> models the zero policy without
reimplementing Mathlib's <code>EReal</code>. Every integer product, norm,
budget, branch, and <code>example</code> is kernel-checked. The project-level
types and theorems remain the full project interfaces in the earlier
repository checks.

The worksheet's <code>normalizeAt 0 = none</code> intentionally models the
classical partial convention that normalization needs a positive horizon. It
is not an implementation of the much later real
<code>normalizedProcess</code>, whose explicitly totalized time-zero value is
zero.

## Camp eight: positive and empty dimensions

The module treats the matrix index type \(\iota\) as finite, but does not assume
it is inhabited unless a theorem needs the familiar identity normalization.

### Nonempty coordinate type

If \(\iota\) has at least one index, the identity matrix has one in every
diagonal position and zero elsewhere. Every row has absolute sum one, so

\[
\lVert I\rVert_\infty=1.
\]

Therefore

\[
N_0(\omega)=1,
\qquad
L_0(\omega)=0.
\]

Only <code>normObservable_zero</code> and
<code>logNormObservable_zero</code> add <code>Nonempty ι</code> to the module's
finite-index assumptions.

### Empty coordinate type

If \(\iota\) is empty, there are no matrix entries. There is exactly one square
matrix function, so the zero and identity matrices are equal. The maximum
absolute row-sum formula takes the supremum of an empty family and returns
zero. Thus, at every horizon and base state,

\[
N_k(\omega)=0,
\qquad
L_k(\omega)=\bot.
\]

The final two public theorems state those functions exactly:

- <code>normObservable_eq_zero_of_isEmpty</code>; and
- <code>logNormObservable_eq_bot_of_isEmpty</code>.

The second theorem reuses the exact bottom criterion after proving that the
unique empty matrix equals zero.

There is no contradiction between “time-zero value is the identity” and
“time-zero log norm is bottom” in empty dimension. The unique identity is also
the zero matrix, and its empty row-sum norm is zero.

## The complete fourteen-declaration map

All declarations share a measurable base space \(\Omega\), a finite matrix
index type \(\iota\) with decidable equality, an arbitrary measure \(\mu\), and a
bundled complex <code>DiscreteMatrixCocycle</code>. The table lists every
additional assumption and exact result.

| # | Declaration | Additional assumption | Checked content |
|---:|---|---|---|
| 1 | <code>normObservable</code> | None | Defines the real maximum-row-sum norm of the finite cocycle value |
| 2 | <code>normObservable_eq_rowSumSup</code> | None | Exposes the exact finite supremum of absolute row sums |
| 3 | <code>normObservable_zero</code> | <code>Nonempty ι</code> | Time-zero norm observable is the constant one function |
| 4 | <code>normObservable_one</code> | None | One-step norm is the generator norm |
| 5 | <code>normObservable_add_le</code> | None | Full norm is bounded by shifted later-block norm times early-block norm |
| 6 | <code>measurable_normObservable</code> | None | Every finite norm observable is ordinarily measurable |
| 7 | <code>logNormObservable</code> | None | Defines the <code>EReal</code>-valued extended logarithm of the extended norm |
| 8 | <code>logNormObservable_eq_bot_iff</code> | None | Extended log norm is bottom exactly when the finite matrix value is zero |
| 9 | <code>logNormObservable_zero</code> | <code>Nonempty ι</code> | Time-zero extended log norm is the constant zero function |
| 10 | <code>logNormObservable_one</code> | None | One-step value is the extended log norm of the generator |
| 11 | <code>measurable_logNormObservable</code> | None | Every finite extended log-norm observable is measurable |
| 12 | <code>logNormObservable_add_le</code> | None | Extended log norms are subadditive across every shifted cocycle split |
| 13 | <code>normObservable_eq_zero_of_isEmpty</code> | <code>IsEmpty ι</code> | Every finite norm observable is the constant zero function |
| 14 | <code>logNormObservable_eq_bot_of_isEmpty</code> | <code>IsEmpty ι</code> | Every finite log-norm observable is the constant bottom function |

The declaration order is deliberate. The row-sum formula comes before the
measurability proof that consumes it. The exact bottom criterion comes before
the empty-dimension log theorem that reuses it.

## The proof architecture

The module is short because each theorem consumes a precise upstream law.

### Norm layer

- <code>C.value_zero</code> and Mathlib's norm-one instance prove time zero in
  nonempty dimension.
- <code>C.value_one</code> proves the one-step generator identity.
- <code>C.value_add</code> plus <code>norm_mul_le</code> proves the split bound.
- <code>C.measurable_value</code>, measurable entries, finite sums, finite
  maxima, and <code>Matrix.linfty_opNorm_def</code> prove measurability.

### Extended-log layer

- <code>ENNReal.log_eq_bot_iff</code> and norm zero equivalence prove the exact
  collapse criterion.
- <code>ENNReal.log_one</code> proves the positive-dimensional zero-time law.
- <code>C.value_one</code> proves the generator identity.
- measurable embedding plus <code>Measurable.ennreal_log</code> proves
  measurability.
- cocycle splitting, <code>nnnorm_mul_le</code>, logarithm monotonicity, and
  <code>ENNReal.log_mul_add</code> prove subadditivity.

### Empty-dimension layer

Function extensionality and empty elimination show that every matrix value is
the zero matrix. The norm theorem then simplifies directly, and the log theorem
uses the exact bottom criterion.

No proof needs a matrix inverse, determinant, eigenvalue, singular value,
probability instance, integral, or limit.

## Assumption and type ledger

| Object | Type | What is known | What is not inferred |
|---|---|---|---|
| Base measure | <code>Measure Ω</code> | The cocycle base preserves it | Total mass one, ergodicity, or finiteness |
| Finite cocycle value | <code>Ω → Matrix ι ι ℂ</code> | Measurable, with zero/one/add laws | Invertibility, a law, or integrability |
| Norm observable | <code>Ω → ℝ</code> | Measurable and submultiplicative across splits | Expectation, lower bound, or normalized limit |
| Extended norm | <code>ℝ≥0∞</code> pointwise | Exact coercion of the finite norm | A new matrix norm or an infinite finite-matrix value |
| Extended log norm | <code>Ω → EReal</code> | Measurable, bottom exactly at zero, subadditive | Integrability, almost-sure finiteness, or Lyapunov exponent |

The word “observable” means a measurable function of the base state at a fixed
horizon. It does not mean a physical measurement postulate or an expectation.

## Why this layer matters

Matrix cocycle growth is the bridge between several future tracks:

- derivatives of nonlinear iterates can form matrix cocycles after a checked
  chain-rule construction;
- products of random matrices become cocycles when driven by a common base
  dynamics;
- finite norm bounds are raw material for stability and contraction criteria;
  and
- integrable log norms are among the hypotheses used in multiplicative
  ergodic theory.

But a bridge must begin with exact endpoints. Defining a real logarithm at zero
without care would corrupt every later statement about collapse or asymptotic
growth. Hiding the matrix norm would make constants and geometry ambiguous.
Assuming measurability without connecting it to the project-owned matrix
structure would leave a formal gap.

RMT-14 closes those finite-time seams and stops.

## Common wrong turns

### Calling the selected norm Frobenius

The active norm is the largest absolute row sum. Frobenius geometry sums the
squares of every entry and then takes a square root. Those norms are not equal
and support different proof interfaces.

### Assuming norm notation is globally unambiguous

The meaning of <code>‖B‖</code> depends on
<code>open scoped Matrix.Norms.Operator</code>. The explicit row-sum theorem is
the audit trail.

### Declaring measurability by continuity alone

The project's matrix measurable structure is entrywise. The module proves
measurability from measurable entries, finite sums, and finite suprema before
using the row-sum identity.

### Applying <code>Real.log</code> to the norm

Its total value at zero is zero, which would confuse exact collapse with norm
one. The checked observable uses <code>ENNReal.log</code> into
<code>EReal</code>.

### Treating bottom as an error

Bottom is the exact intended value if and only if the cocycle matrix is zero.
It is part of the mathematical codomain.

### Assuming nonzero blocks have a nonzero product

Matrices can be zero divisors. The extended-real inequality remains valid when
the full product collapses even though neither block is zero.

### Replacing subadditivity with equality

The logarithm turns a product of norm bounds into a sum, but the matrix norm is
only submultiplicative. Slack or complete collapse can occur.

### Adding an unnecessary nonempty-dimension assumption

Only the familiar time-zero normalizations need an inhabited coordinate type.
Definitions, measurability, inequalities, and explicit empty-dimension laws do
not.

### Reading measurability as integrability

A measurable extended-real function can fail every integrability condition
needed later. The module evaluates no integral.

### Reading subadditivity as Kingman's theorem

A finite pointwise inequality is one input to subadditive ergodic theory. It is
not a probability space, an integrability theorem, an ergodicity theorem, or a
limit.

### Reading a log-norm observable as a Lyapunov exponent

A Lyapunov exponent is asymptotic growth after a normalization and under
additional hypotheses. \(L_k(\omega)\) is a finite-horizon value.

### Assuming a nonlinear Jacobian origin

The generator is an arbitrary measurable complex matrix map. No nonlinear map,
derivative, chain rule, or tangent-space identification appears here.

## Exercises from trailhead to summit

### Trailhead

1. Compute the largest absolute row sum of three different two-by-two matrices.
2. Verify both running horizon-two products entry by entry.
3. Give a nonidentity matrix with maximum absolute row-sum norm one.
4. Explain in words why one output coordinate corresponds to one matrix row.
5. Compare the row-sum norm and Frobenius norm of the identity in dimensions
   one, two, and three.
6. Build the four-row norm, positive-log, and extended-log table without
   looking back at the figure.

### Mid-mountain

7. Derive matrix-vector control from the triangle inequality.
8. Derive the cocycle norm split from <code>C.value_add</code> and
   <code>norm_mul_le</code>.
9. Reconstruct the measurable-row-sum proof for a two-row matrix.
10. Generalize that proof by induction over an arbitrary finite set of rows.
11. Track the types in the composition from a real norm through
    <code>ENNReal.ofReal</code> to <code>ENNReal.log</code>.
12. Prove on paper that bottom characterizes a zero matrix.
13. Find two nonzero matrices with zero product and evaluate both sides of the
    extended log-norm inequality.
14. Explain why the norm split and log split need no probability assumption.

### Summit

15. Audit every theorem in the fourteen-declaration map against its exact
    assumptions.
16. Prove that the empty square matrix is simultaneously zero and identity.
17. Derive the constant-zero norm and constant-bottom log-norm functions in
    empty dimension.
18. State a candidate integrability hypothesis for the one-step positive log
    norm and explain why it is absent here.
19. Compare finite subadditivity with the hypotheses and conclusion of
    Kingman's subadditive ergodic theorem.
20. State the additional probability, invertibility, and integrability choices
    needed before an Oseledets theorem could even be formulated.
21. Design a separate theorem connecting the cocycle generator to a Jacobian
    along a nonlinear orbit. List the differentiability and chain-rule
    prerequisites.
22. Normalize both running logarithm ledgers at horizon two, then explain why
    the target module proves neither a normalized-process theorem nor a limit.

## Reproduce the chapter

The bounded <code>Std</code> worksheet above is a standalone tutorial for an
ordinary macOS or Linux host. The exact target and comparison modules import
Mathlib and are full project checks. From the repository root, run:

~~~sh
cd formalization
lake env lean NonlinearDynamics/Random/RandomCocycles/NormObservables.lean
lake env lean NonlinearDynamics/Random/RandomCocycles/LogPlusIntegrability.lean
lake env lean NonlinearDynamics/Random/RandomCocycles/SubadditiveKingman.lean
~~~

These commands may require substantial disk space and memory. Passing the
technical gates would still leave human mathematical,
source, accessibility, scientific-integrity, and editorial review pending.

## Summit: what has and has not been proved

| Topic | Status in this module |
|---|---|
| Finite-time maximum absolute row-sum norm observable | Defined |
| Exact finite row-sum supremum formula | Checked |
| Positive-dimensional time-zero norm one | Checked under <code>Nonempty ι</code> |
| One-step generator norm identity | Checked |
| Norm submultiplicativity across the shifted cocycle split | Checked pointwise |
| Entrywise proof of norm measurability | Checked |
| Extended-real log-norm observable | Defined through <code>ENNReal.log</code> |
| Exact bottom if and only if zero-matrix criterion | Checked |
| Positive-dimensional time-zero log value zero | Checked under <code>Nonempty ι</code> |
| One-step generator extended-log-norm identity | Checked |
| Extended log-norm measurability | Checked |
| Extended-real subadditivity across every cocycle split | Checked pointwise |
| Empty-dimensional norm identically zero | Checked under <code>IsEmpty ι</code> |
| Empty-dimensional log norm identically bottom | Checked under <code>IsEmpty ι</code> |
| Real log-positive envelope \(G_k\) | Defined only in the successor <code>LogPlusIntegrability.lean</code> |
| Integrability of finite \(G_k\) | Proved there only from an explicit one-step hypothesis |
| Positive-time quotients displayed in this chapter | Computed for the examples; not defined by the target module |
| Generic real <code>normalizedProcess</code> | Defined much later; not an <code>EReal</code> normalizer |
| Extended log norm is everywhere an ordinary real value | Not proved and false when a finite value is zero |
| Probability normalization of the base measure | Not assumed or proved |
| Ergodicity, mixing, stationarity, or independence | Not assumed or proved |
| Integrability of the norm observable | Not proved |
| Integrability or almost-sure finiteness of the extended log norm | Not proved |
| Pushforward law or expectation of either observable | Not defined |
| Continuity in the base state, moment bounds, or tail estimates | Not proved |
| Skew-product invariance or product-law factorization | Not stated |
| Target-module normalized finite-time growth | Not defined |
| Subadditive ergodic limit | Not invoked or proved |
| Lyapunov exponent or spectrum | Not defined or proved |
| Oseledets invariant splitting | Not invoked or proved |
| Invertibility or negative-time cocycle | Not assumed or defined |
| General-linear-valued generator or two-sided group cocycle | Not assumed or defined |
| Singular-value, determinant, or spectral-radius formula | Not stated |
| Norm multiplicativity, log additivity, equality, or lower product-growth bound | Not stated |
| Comparison with Frobenius or Euclidean spectral norms | Not formalized |
| Matrix logarithm or the distinct ordinary-differential-equation logarithmic norm | Not defined |
| Nonlinear derivative or random-Jacobian representation | Not connected |
| Stability, attraction, bifurcation, or chaos theorem | Not claimed |

The summit is an analytic interface, not an asymptotic theorem. Every finite
cocycle value now has a checked measurable size, every exact collapse remains
visible as bottom, and every time split obeys a zero-safe additive upper bound.

## Where to continue

[Finite-Horizon Log-Positive Cocycle Integrability]({{< relref "/knowledge-base/deep-dives/finite-horizon-log-positive-cocycle-integrability" >}})
is the immediate successor. It defines the real nonnegative
{{< refterm "log-positive-integrability-envelope" "log-positive integrability envelope" >}},
majorizes every finite horizon by shifted one-step terms, and propagates an
explicit generator integrability assumption through that finite sum. It does
not make this chapter's contraction-sensitive extended log norm integrable and
does not prove a Lyapunov exponent.

The
{{< refterm "extended-log-norm-observable" "extended log-norm observable" >}}
glossary entry is the compact guide to the type ladder, bottom convention, and
dimension boundary.

[Generator-Presented One-Sided Discrete Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/generator-presented-one-sided-discrete-matrix-cocycles" >}})
develops the exact base-orbit and later-block-left algebra consumed here.
[Ordered Finite Matrix Products and Operator-Norm Growth]({{< relref "/knowledge-base/deep-dives/ordered-finite-matrix-products-and-operator-norm-growth" >}})
develops the deterministic product and maximum-row-sum norm layer below the
cocycle.

The next asymptotic layer must state an integrability policy before
normalizing by time or invoking a subadditive or multiplicative ergodic
theorem. It must also decide whether the base measure is probabilistic and
whether ergodicity, invertibility, or one-sided time is required. None of those
choices is made retroactively here.

## References

<a id="ref-finite-log-norm-matrix"></a>**Mathlib contributors.**
[Norms on finite matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Normed.html),
Mathlib 4 documentation. This official source defines the maximum absolute
row-sum norm, proves its matrix-product and matrix-vector bounds, and identifies
it with the operator norm on finite supremum-norm function spaces.

<a id="ref-finite-log-norm-ennreal-log"></a>**Mathlib contributors.**
[Extended nonnegative-real logarithm](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/SpecialFunctions/Log/ENNRealLog.html),
Mathlib 4 documentation. This official source defines <code>ENNReal.log</code>,
including its zero-to-bottom convention, strict monotonicity, exact endpoint
criteria, and unconditional product-to-sum law.

<a id="ref-finite-log-norm-ennreal-log-exp"></a>**Mathlib contributors.**
[Extended logarithm and exponential](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/SpecialFunctions/Log/ENNRealLogExp.html),
Mathlib 4 documentation. This official source packages the logarithm as an
order isomorphism and homeomorphism and proves that it is measurable.

<a id="ref-finite-log-norm-poslog"></a>**Mathlib contributors.**
[Positive part of the real logarithm](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/SpecialFunctions/Log/PosLog.html),
Mathlib 4 documentation. This official source defines
<code>Real.posLog</code> as the maximum of zero and the real logarithm, proves
its zero policy, nonnegativity, continuity, and product upper bound.

<a id="ref-finite-log-norm-ereal-div"></a>**Mathlib contributors.**
[Extended-real inversion and division](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/EReal/Inv.html),
Mathlib 4 documentation. This official source records that bottom divided by a
positive finite extended real remains bottom. The target module itself defines
no normalized extended observable.

<a id="ref-finite-log-norm-horn-johnson"></a>**Roger A. Horn and Charles R. Johnson.**
[Matrix Analysis, second edition](https://www.cambridge.org/highereducation/books/matrix-analysis/FDA3627DC2B9F5C3DF2FD8C3CC136B48),
Cambridge University Press, 2013, International Standard Book Number (ISBN)
978-0-521-54823-6. Chapter 5 develops vector norms, induced matrix norms, and
submultiplicative product estimates.

<a id="ref-finite-log-norm-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://www.jstor.org/stable/2984534),
*Journal of the Royal Statistical Society, Series B* 30(3), 1968, 499-510.
This primary source establishes a subadditive ergodic theorem under additional
measure-theoretic hypotheses. RMT-14 supplies only the finite pointwise
subadditivity input.

<a id="ref-finite-log-norm-oseledets"></a>**V. I. Oseledets.**
[A multiplicative ergodic theorem. Characteristic Ljapunov exponents of dynamical systems](https://www.mathnet.ru/eng/mmo214),
*Transactions of the Moscow Mathematical Society* 19 (1968), 197-231. This
primary source supplies the historical long-time destination. The present
module proves none of its integrability, limit, exponent, or splitting
conclusions.

<a id="ref-finite-log-norm-arnold"></a>**Ludwig Arnold.**
[Random Dynamical Systems](https://doi.org/10.1007/978-3-662-12878-7),
Springer Monographs in Mathematics, 1998. This develops cocycles and
multiplicative ergodic theory over metric dynamical systems. Its usual
probability, invertibility, and asymptotic structures are context, not claims
of this finite-time module.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
