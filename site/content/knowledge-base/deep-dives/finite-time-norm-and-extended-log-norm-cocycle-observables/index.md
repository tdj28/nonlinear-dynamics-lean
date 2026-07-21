---
title: "Finite-Time Norm and Extended-Log-Norm Observables for Matrix Cocycles"
slug: "finite-time-norm-and-extended-log-norm-cocycle-observables"
date: 2026-07-21
summary: "A textbook construction of measurable finite-time matrix-cocycle growth observables using the maximum absolute row-sum norm and a zero-aware extended logarithm, with exact subadditivity and dimension boundaries."
lead: "The cocycle law tells us how finite histories compose. A carefully chosen norm and extended logarithm turn that algebra into measurable growth data while keeping exact collapse, empty dimension, and every missing asymptotic hypothesis visible."
draft: true
pro_reviewed: false
level: "Random matrix cocycles, finite operator norms, measurable observables, extended-real logarithms, and subadditivity"
reading_time: "85 to 115 minutes"
prerequisites: "One-sided discrete matrix cocycles, forward matrix products, finite matrix norms, measurable functions, and basic logarithms; extended number systems and all edge cases are introduced before use"
lean_module: "NonlinearDynamics.Random.RandomCocycles.NormObservables"
toc: true
og_image: "finite-time-norm-and-extended-log-norm-cocycle-observables-card.png"
og_image_alt: "A finite cocycle matrix passes through the largest absolute row-sum norm and a zero-aware extended logarithm, turning a multiplicative product bound into an additive bound while keeping the empty-dimension branch explicit."
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

A one-sided matrix cocycle already knows how to multiply a finite history. If
\(C(k,\omega)\) denotes the value after \(k\) steps from base state \(\omega\),
then the RMT-13 cocycle law is

\[
C(m+k,\omega)
{} =
C(k,T^m\omega)C(m,\omega).
\]

The early block acts first and is written on the right. The later block begins
at the shifted environment \(T^m\omega\), acts second, and is written on the
left.

RMT-14 asks the next analytic question: how large is that finite matrix value?
The answer must make four choices explicit:

1. which matrix norm measures size;
2. how its measurability follows from the project's entrywise measurable
   structure;
3. what logarithm means when the matrix value is exactly zero; and
4. which statements survive the empty matrix dimension.

The module
<code>NonlinearDynamics.Random.RandomCocycles.NormObservables</code> answers
those questions in fourteen public declarations. It chooses Mathlib's maximum
absolute row-sum operator norm, proves its finite-time observable measurable,
passes it through a zero-aware extended logarithm, and derives norm
submultiplicativity and log-norm subadditivity across every cocycle split.

This is still finite-time infrastructure. No integrability, normalized growth,
almost-sure limit, Lyapunov exponent, invariant splitting, ergodicity, or
probability normalization is smuggled into the interface.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [The analytic pipeline in one picture](#the-analytic-pipeline-in-one-picture) | See how a cocycle split becomes an additive growth budget |
| Norm route | [Why this particular matrix norm](#camp-one-why-this-particular-matrix-norm) | Compute the maximum absolute row sum and identify the active Lean scope |
| Measure route | [Prove norm measurability from entries](#camp-four-prove-norm-measurability-from-entries) | Audit every closure step without assuming a hidden Borel instance |
| Endpoint route | [Why the ordinary real logarithm is the wrong totalization](#camp-five-why-the-ordinary-real-logarithm-is-the-wrong-totalization) | Preserve the difference between norm one and norm zero |
| Inequality route | [The zero-safe subadditivity proof](#camp-seven-the-zero-safe-subadditivity-proof) | Follow cocycle law, norm bound, monotonicity, and product-to-sum |
| Dimension route | [Positive and empty dimensions](#camp-eight-positive-and-empty-dimensions) | See exactly where nonempty coordinates are required |
| Lean route | [The complete fourteen-declaration map](#the-complete-fourteen-declaration-map) | Audit every public name, assumption, and output |
| Summit route | [What has and has not been proved](#summit-what-has-and-has-not-been-proved) | Keep the finite-time boundary intact |

### Learning objectives

By the summit, you should be able to:

1. distinguish the cocycle value, norm observable, and extended log-norm
   observable by type;
2. state the maximum absolute row-sum formula;
3. explain why this norm is induced by the vector supremum norm;
4. identify the scoped Lean instance that gives <code>‖A‖</code> its meaning;
5. derive norm submultiplicativity from the later-block-left cocycle law;
6. reconstruct norm measurability from complex matrix entries;
7. distinguish real numbers, extended nonnegative reals, and extended reals;
8. explain why <code>Real.log 0 = 0</code> is unsuitable for exact collapse;
9. read \(\bot\) as the intended logarithmic value of zero norm;
10. prove that the log norm is bottom exactly when the cocycle matrix is zero;
11. derive log-norm measurability by composition;
12. follow the extended-real subadditivity proof without a nonzero hypothesis;
13. explain how nonzero factors can still have a zero product;
14. identify the two time-zero theorems that need nonempty coordinates;
15. prove that every norm is zero and every log norm is bottom in empty
    dimension;
16. map every mathematical claim to one of the fourteen checked declarations;
    and
17. list the integrability, ergodic, asymptotic, and nonlinear-Jacobian bridges
    that remain absent.

## The analytic pipeline in one picture

{{< reference-figure
  src="norm-to-log-subadditivity.svg"
  alt="An early cocycle block and a shifted later block combine with the later block acting second. The full finite matrix passes to the maximum absolute row-sum norm, whose multiplicative upper bound passes through a zero-aware extended logarithm and becomes additive. A final branch separates nonempty coordinates, with time-zero norm one and log value zero, from empty coordinates, with every norm zero and every log value bottom."
  caption="**Finding:** the cocycle split supplies a matrix product, the maximum absolute row-sum norm supplies a multiplicative upper budget, and the extended logarithm converts that budget into a zero-safe additive one. Nonempty coordinates recover the familiar time-zero normalization; empty coordinates remain valid but every finite matrix norm is zero and every log norm is bottom. The figure asserts no integrability, limiting growth rate, or invariant splitting."
>}}

The picture separates three structures that are easy to conflate:

- the base map decides where the later cocycle block begins;
- matrix multiplication decides how the blocks compose; and
- the norm and logarithm decide how to summarize the size of that composition.

Each layer has its own assumptions and its own failure modes.

## Base camp: the RMT-13 input

Fix a type \(\Omega\) of base states with a measurable-space structure, a finite
matrix index type \(\iota\) with decidable equality, and a measure \(\mu\) on
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

RMT-14 consumes exactly that interface. It does not add a probability instance
for \(\mu\), and none of its finite-time pointwise inequalities uses measure
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
in the public API.

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

## A complete two-block calculation

Take the early block

\[
B=
\begin{bmatrix}
1 & -1\\
0 & 2
\end{bmatrix}
\]

and shifted later block

\[
D=
\begin{bmatrix}
1 & 0\\
3 & 1
\end{bmatrix}.
\]

The absolute row sums of \(B\) are two and two, so

\[
\lVert B\rVert_\infty=2.
\]

The absolute row sums of \(D\) are one and four, so

\[
\lVert D\rVert_\infty=4.
\]

Because the later block acts after the early block, the full matrix is

\[
DB=
\begin{bmatrix}
1 & -1\\
3 & -1
\end{bmatrix}.
\]

Its row sums are two and four, hence

\[
\lVert DB\rVert_\infty=4
\leq
4\cdot2.
\]

All three norms are positive, so the extended logarithms agree with ordinary
real logarithms. The subadditive inequality is

\[
\log 4
\leq
\log 4+\log 2.
\]

The strict slack comes from the norm product estimate. There is no claim that
the later block realizes its largest row amplification on the output direction
created by the early block.

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

### Smuggling nonempty dimension into every theorem

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
2. Verify the two-block worked example entry by entry.
3. Give a nonidentity matrix with maximum absolute row-sum norm one.
4. Explain in words why one output coordinate corresponds to one matrix row.
5. Compare the row-sum norm and Frobenius norm of the identity in dimensions
   one, two, and three.
6. Explain why the extended logarithm sends norm one to zero and norm zero to
   bottom.

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

## Reproduce the checked slice

From the repository root, load the pinned Lean toolchain and compile the module
with warnings treated as errors:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/NormObservables.lean
~~~

Build the module and its dependencies by library name:

~~~sh
lake build NonlinearDynamics.Random.RandomCocycles.NormObservables
~~~

Return to the repository root and check the teaching site:

~~~sh
cd ..
make site-check
~~~

The repository-wide technical gate is <code>make check</code>. Passing it does
not publish this draft. Human mathematical, source, accessibility, and
editorial reviews remain separate publication gates.

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
| Extended log norm is everywhere an ordinary real value | Not proved and false when a finite value is zero |
| Probability normalization of the base measure | Not assumed or proved |
| Ergodicity, mixing, stationarity, or independence | Not assumed or proved |
| Integrability of the norm observable | Not proved |
| Integrability or almost-sure finiteness of the extended log norm | Not proved |
| Pushforward law or expectation of either observable | Not defined |
| Continuity in the base state, moment bounds, or tail estimates | Not proved |
| Skew-product invariance or product-law factorization | Not stated |
| Normalized finite-time growth | Not defined |
| Subadditive ergodic limit | Not invoked or proved |
| Lyapunov exponent or spectrum | Not defined or proved |
| Oseledets invariant splitting | Not invoked or proved |
| Invertibility or negative-time cocycle | Not assumed or defined |
| General-linear-valued generator or two-sided group cocycle | Not assumed or defined |
| Singular-value, determinant, or spectral-radius formula | Not stated |
| Norm multiplicativity, log additivity, equality, or lower product-growth bound | Not stated |
| Comparison with Frobenius or Euclidean spectral norms | Not formalized |
| Matrix logarithm or the distinct ODE logarithmic norm | Not defined |
| Nonlinear derivative or random-Jacobian representation | Not connected |
| Stability, attraction, bifurcation, or chaos theorem | Not claimed |

The summit is an analytic interface, not an asymptotic theorem. Every finite
cocycle value now has a checked measurable size, every exact collapse remains
visible as bottom, and every time split obeys a zero-safe additive upper bound.

## Where to continue

The
{{< refterm "extended-log-norm-observable" "extended log-norm observable" >}}
glossary entry is the compact guide to the type ladder, bottom convention, and
dimension boundary.

[Generator-Presented One-Sided Discrete Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/generator-presented-one-sided-discrete-matrix-cocycles" >}})
develops the exact base-orbit and later-block-left algebra consumed here.
[Ordered Finite Matrix Products and Operator-Norm Growth]({{< relref "/knowledge-base/deep-dives/ordered-finite-matrix-products-and-operator-norm-growth" >}})
develops the deterministic product and maximum-row-sum norm layer below the
cocycle.

The next honest asymptotic layer must state an integrability policy before
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

<a id="ref-finite-log-norm-horn-johnson"></a>**Roger A. Horn and Charles R. Johnson.**
[Matrix Analysis, second edition](https://www.cambridge.org/highereducation/books/matrix-analysis/FDA3627DC2B9F5C3DF2FD8C3CC136B48),
Cambridge University Press, 2013, ISBN 978-0-521-54823-6. Chapter 5 develops
vector norms, induced matrix norms, and submultiplicative product estimates.

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
