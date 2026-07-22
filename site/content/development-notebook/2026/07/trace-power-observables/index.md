---
title: "Trace-Power Observables: From Matrices to Moments"
slug: "trace-power-observables"
date: 2026-07-20
weight: 40
author: "tdj28"
summary: "A line-by-line ascent through the Lean module that turns powers of finite random matrices into measurable scalar observables and proves those observables are real on Hermitian samples."
lead: |
  A random matrix is too large to inspect all at once. Raise each realization to a power, take its trace, and the matrix collapses to one scalar that still remembers its spectrum. This entry builds that observable in Lean, proves it is measurable, proves Hermitian inputs make it real, and stops exactly before expectation begins.
draft: false
pro_reviewed: false
status: "Pending human and Pro review"
level: "Base camp to research ridge"
reading_time: "45 to 60 minutes"
prerequisites:
  - "Matrix multiplication and complex conjugation"
  - "Basic probability vocabulary; measure theory is introduced as needed"
  - "No prior Lean proof experience required"
lean_module: "NonlinearDynamics.Random.RandomMatrices.Observables"
lean_source: "formalization/NonlinearDynamics/Random/RandomMatrices/Observables.lean"
tags:
  - "random matrices"
  - "trace"
  - "Hermitian matrices"
  - "measurability"
  - "Lean"
og_image: "trace-power-card.png"
og_image_alt: "Warm-paper teaching card showing a random matrix pass through matrix powers and trace to become a scalar that is real for Hermitian inputs."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The canonical
author disclosure is intentionally pending until the human author has
inspected the prose, cited sources, equations, Lean artifacts, and generated
social card. Scientific-integrity and zero-context reader reviews are also
pending. The page is published as an open working note while those reviews
remain pending.
{{< /panel >}}

Suppose a random experiment produces a square matrix \(X(\omega)\). One
outcome might produce one matrix, another outcome a different matrix. Even in
finite dimensions, the whole matrix is often the wrong scale at which to ask a
probabilistic question. We want a scalar summary that is sensitive to the
collective action of the entries.

The trace of a matrix power is one of the first such summaries:

\[
S_k(\omega)=\operatorname{tr}\!\left(X(\omega)^k\right).
\]

The matrix \(X(\omega)\) is a realization. The natural number \(k\) chooses a
power. The output \(S_k(\omega)\) is one complex number. As \(\omega\) varies,
\(S_k\) is initially only a scalar-valued map. Once \(X\) is assumed
measurable and `measurable_tracePower` is applied, it becomes a scalar random
observable in the standard measure-theoretic sense.

This module earns two facts before doing any averaging:

1. if \(X\) is measurable, then \(S_k\) is measurable;
2. if every realization of \(X\) is Hermitian, then \(S_k(\omega)\) is real
   for every outcome, with an almost-sure version for almost-sure Hermiticity.

That order matters. A formula can look like a moment without yet being one.
Expectation needs a measure, and a mathematically meaningful finite moment
needs an integrability argument. Neither is smuggled into this file.

## Choose a route up

| Route | Start at | You will leave with |
|---|---|---|
| First encounter | [Why trace?](#base-camp-why-compress-a-matrix) | A concrete picture of what \(\operatorname{tr}(X^k)\) records |
| Probability route | [Measurability](#camp-two-proving-the-observable-is-measurable) | The exact closure argument from matrix entries to a scalar random variable |
| Linear algebra route | [Hermitian reality](#high-camp-why-hermitian-trace-powers-are-real) | A proof that every trace power lies on the real axis |
| Lean route | [Declaration map](#the-entire-lean-file-as-a-proof-graph) | Every definition and theorem in `Observables.lean`, with its proof design |
| Research route | [Moment method](#the-next-ridge-expectation-and-the-moment-method) | The precise bridge from trace powers to expected spectral moments, plus the missing hypotheses |

### Learning objectives

By the summit, you should be able to:

1. distinguish a realized matrix, a trace-power observable, and its expected
   trace moment;
2. derive the trace powers of diagonal and two-by-two Hermitian matrices;
3. explain why finite matrix multiplication and trace preserve measurability;
4. read a natural-number induction proof in Lean;
5. explain why Hermitian matrix powers remain Hermitian;
6. move cleanly between pointwise and almost-everywhere statements; and
7. identify every ingredient still missing from a formal moment-method proof.

## The ascent in one picture

{{< mermaid >}}
flowchart LR
  A[Outcome omega] --> B[Matrix X of omega]
  B --> C[Power X of omega to k]
  C --> D[Trace-power scalar S k of omega]
  M[Measurable X] --> P[Measurable matrix power]
  P --> Q[Measurable trace power]
  H[Hermitian X] --> R[Hermitian matrix power]
  R --> T[Trace power has zero imaginary part]
  U[Probability measure and integrability] -. future work .-> V[Expected trace moment]
  D --> V
{{< /mermaid >}}

<p class="figure-note"><strong>Reading the route.</strong> The solid paths are formalized in <code>Observables.lean</code>. The dotted path is deliberately absent: the current file defines the pointwise observable but does not choose a probability measure, prove integrability, or take an expectation.</p>

## Where this entry begins

The preceding Knowledge Base chapter,
[Random Matrices: From Outcomes to Spectra](/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra/),
builds the lower mountain: sample spaces, entrywise measurability, matrix
operations, {{< refterm "conjugate-transpose" "conjugate transpose" >}}, and
{{< refterm "hermitian-matrix" "Hermitian symmetry" >}}. This notebook entry
starts from that established interface and follows the next Lean file closely.

The recurring vocabulary is already indexed in the Knowledge Base:

| Term | Working meaning here |
|---|---|
| {{< refterm "random-matrix" "Random matrix" >}} | A measurable map from outcomes to matrices, once measurability has been supplied |
| {{< refterm "measurable-space" "Measurable space" >}} | The event structure needed to state that a map is measurable |
| {{< refterm "hermitian-matrix" "Hermitian matrix" >}} | A square complex matrix satisfying \(H^*=H\) |
| {{< refterm "almost-everywhere" "Almost everywhere" >}} | A property allowed to fail only on a set of measure zero |

### What this entry contributes

This is a teaching account of an implementation, not a novelty claim. The
mathematics of traces, Hermitian powers, and spectral moments is classical.
The local contribution is narrower:

- one reusable definition of a trace-power observable;
- a measurable-power induction built on the project's matrix multiplication
  lemma;
- measurable trace powers for arbitrary finite index types;
- pointwise and almost-sure reality statements for Hermitian inputs; and
- a bundled API that lets later ensemble files reuse those facts without
  unpacking record fields by hand.

### Not claimed

- No Gaussian ensemble, entry distribution, independence hypothesis, or
  normalization convention is defined here.
- No expectation or integral is taken.
- No integrability or finite-moment hypothesis is proved.
- No spectral theorem, eigenvalue identity, unitary invariance, semicircle law,
  or asymptotic limit is formalized in this module.

## Base camp: why compress a matrix?

For a finite square matrix \(A=(A_{ij})\), the trace is the sum of the diagonal
entries:

\[
\operatorname{tr}(A)=\sum_i A_{ii}.
\]

That definition looks coordinate-dependent, but trace has a deeper role. It is
unchanged by a change of basis of the form \(A\mapsto UAU^{-1}\). For a
Hermitian matrix, the spectral theorem diagonalizes \(A\), and trace becomes
the sum of its real eigenvalues. The current Lean file does not prove those
spectral facts, but they explain why trace is the right scalar to preserve
([Mathlib trace API](#ref-mathlib-trace);
[Mathlib Hermitian spectrum API](#ref-mathlib-spectrum)).

Now apply trace after a matrix power:

\[
\operatorname{tr}(A^k).
\]

If \(A\) has eigenvalues \(\lambda_i\), then the spectral picture predicts

\[
\operatorname{tr}(A^k)=\sum_i \lambda_i^k.
\]

Each power asks a different question of the spectrum. Low powers capture broad
features such as total location and quadratic scale. Higher powers become more
sensitive to eigenvalues far from the origin. This is the runway to the moment
method, but it is not yet the moment method itself.

### A diagonal worked example

Let

\[
D=\operatorname{diag}(\lambda_1,\ldots,\lambda_n).
\]

Powers of a diagonal matrix are computed entrywise:

\[
D^k=\operatorname{diag}(\lambda_1^k,\ldots,\lambda_n^k).
\]

Therefore

\[
\operatorname{tr}(D^k)=\lambda_1^k+\cdots+\lambda_n^k.
\]

This is the cleanest mental model for a trace-power observable. A general
Hermitian matrix is not already diagonal, but unitary diagonalization gives the
same spectral interpretation.

### A two-by-two Hermitian worked example

Write the general two-by-two Hermitian matrix as

\[
H=
\begin{bmatrix}
a & z \\
\overline z & b
\end{bmatrix},
\qquad a,b\in\mathbb R,\quad z\in\mathbb C.
\]

The first trace power is immediate:

\[
\operatorname{tr}(H)=a+b.
\]

For the second power,

\[
H^2=
\begin{bmatrix}
a^2+z\overline z & az+zb \\
\overline z a+b\overline z & \overline z z+b^2
\end{bmatrix}.
\]

Taking the trace gives

\[
\operatorname{tr}(H^2)=a^2+b^2+2|z|^2.
\]

The expression is visibly real. The Lean proof will not expand entries like
this. It proves a structural theorem once: powers preserve Hermiticity, and the
trace of a Hermitian matrix is fixed by conjugation.

{{< panel "info" >}}
**The zeroth power is included.** Lean uses \(A^0=I\). Consequently,
\(\operatorname{tr}(A^0)=\operatorname{tr}(I)\), which is the finite dimension
of the index type. The module defines `tracePower X k` for every natural number
`k`, including zero.
{{< /panel >}}

## Camp one: the pointwise observable is not an expectation

The core definition is short:

```lean
/-- The `k`th trace-power observable of a square complex random matrix. -/
def tracePower [Fintype ι] [DecidableEq ι]
    (X : RandomMatrix Ω ι ι ℂ) (k : ℕ) : Ω → ℂ :=
  fun ω ↦ Matrix.trace ((X ω) ^ k)
```

Read the type from right to left:

- `Ω → ℂ` says the output is a complex-valued function of the sample;
- `k : ℕ` selects the matrix power;
- `X : RandomMatrix Ω ι ι ℂ` is a square complex matrix-valued map;
- `[Fintype ι]` says the row and column index set is finite; and
- `[DecidableEq ι]` lets Lean construct the identity matrix used by natural
  powers.

The definition makes no measurability claim by itself. In this project,
`RandomMatrix` is the underlying map type. A separate theorem carries the
proof that the map is measurable.

Most importantly, the definition contains no measure:

\[
\texttt{tracePower X k}:\Omega\to\mathbb C.
\]

An expectation would additionally require a measure \(\mu\) on \(\Omega\):

\[
\mathbb E_\mu[S_k]
=\int_\Omega \operatorname{tr}(X(\omega)^k)\,d\mu(\omega).
\]

That integral is not `tracePower`. It consumes `tracePower` later. Mathlib's
average API likewise keeps the measure-theoretic average distinct from the
integrability lemmas needed to reason about it
([Mathlib average API](#ref-mathlib-average)).

{{< panel "warning" >}}
**Measurable does not mean integrable.** Measurability makes the observable
eligible for measure-theoretic operations. It does not show that its absolute
value has a finite integral. A later moment API must name the probability
measure and carry the integrability hypothesis needed for a genuine finite
expectation.
{{< /panel >}}

### Pointwise, random, and averaged: keep the levels separate

| Object | Formula | What has been formalized here? |
|---|---|---|
| Realized matrix | \(X(\omega)\) | The input at one outcome |
| Realized scalar | \(\operatorname{tr}(X(\omega)^k)\) | Yes, by `tracePower` |
| Scalar random observable | \(\omega\mapsto\operatorname{tr}(X(\omega)^k)\) | Yes, with measurability proved |
| Expected trace moment | \(\mathbb E_\mu[\operatorname{tr}(X^k)]\) | No |
| Normalized expected trace moment | \(n^{-1}\mathbb E_\mu[\operatorname{tr}(X^k)]\) | No |
| Limiting spectral moment | A limit as matrix dimension grows | No |

## Camp two: proving the observable is measurable

Trace power is a composition of two operations:

1. raise a random matrix to the \(k\)th power;
2. take the trace.

The proof mirrors that decomposition. First prove matrix powers are measurable.
Then reuse the earlier theorem that trace is measurable.

### The measurable-power theorem

```lean
/-- Pointwise matrix powers preserve measurability in finite dimensions. -/
theorem measurable_matrixPow [Fintype ι] [DecidableEq ι]
    {X : RandomMatrix Ω ι ι ℂ} (hX : Measurable X) (k : ℕ) :
    Measurable fun ω ↦ (X ω) ^ k := by
  induction k with
  | zero =>
      simpa only [pow_zero] using
        (measurable_const (Ω := Ω) (1 : Matrix ι ι ℂ))
  | succ k ih =>
      simpa only [pow_succ] using measurable_mul ih hX
```

The proof is induction on the natural number \(k\). This is exactly the right
proof shape because powers are recursively generated by a base case and a
successor case. Lean's official theorem-proving text presents the same `zero`
and `succ` architecture for natural-number induction
([Lean induction and recursion](#ref-lean-induction)):

\[
A^0=I,
\qquad
A^{k+1}=A^kA.
\]

Lean exposes the same two branches.

#### Zero branch

At power zero, the random matrix disappears from the value:

\[
\omega\longmapsto X(\omega)^0=I.
\]

This is a constant matrix-valued function. The earlier `Basic` module already
proved that constant matrices are measurable. The expression
`(1 : Matrix ι ι ℂ)` tells Lean exactly which multiplicative identity is meant.

`simpa only [pow_zero]` performs one controlled simplification. It rewrites the
goal using the rule \(X^0=1\) and checks that the previously proved constant
measurability theorem has the resulting type.

#### Successor branch

The induction hypothesis `ih` says

```lean
Measurable fun ω ↦ (X ω) ^ k
```

and `hX` says the original matrix map is measurable. The earlier theorem
`measurable_mul ih hX` combines them pointwise:

\[
\omega\longmapsto X(\omega)^kX(\omega).
\]

Finally, `simpa only [pow_succ]` identifies that product with
\(X(\omega)^{k+1}\).

{{< panel "intuition" >}}
**Why finite dimensions appear.** A matrix product entry is a sum over the
shared index. `Fintype ι` turns that sum into a finite sum. Measurable scalar
products and finite sums are already available, so each output entry is
measurable. No convergence theorem for infinite series is needed.
{{< /panel >}}

### The measurable trace-power theorem

```lean
/-- Every trace-power observable of a measurable finite random matrix is
measurable. -/
theorem measurable_tracePower [Fintype ι] [DecidableEq ι]
    {X : RandomMatrix Ω ι ι ℂ} (hX : Measurable X) (k : ℕ) :
    Measurable (tracePower X k) := by
  change Measurable fun ω ↦ Matrix.trace ((X ω) ^ k)
  exact measurable_trace (measurable_matrixPow hX k)
```

This proof has two moves.

First, `change` unfolds the public name just enough to show Lean the function
that must be measurable. It does not rewrite the entire goal indiscriminately.

Second, `measurable_matrixPow hX k` proves that the matrix-valued power is
measurable. The previously established `measurable_trace` theorem then turns a
measurable finite matrix into a measurable scalar trace.

Mathematically, trace is a finite sum of diagonal coordinates:

\[
\omega\longmapsto
\sum_i \bigl(X(\omega)^k\bigr)_{ii}.
\]

Every diagonal coordinate is measurable, and a finite sum of measurable
complex functions is measurable. The one-line Lean proof hides no additional
probability assumption.

{{< checkpoint stage="Measurability camp" title="Reconstruct the closure chain" >}}

Without looking back, try to say the proof in four clauses:

1. the identity matrix is a measurable constant;
2. products of measurable finite random matrices are measurable;
3. induction therefore gives measurable matrix powers; and
4. trace is a finite sum of measurable diagonal entries.

If all four are clear, the measurable half of the file is already yours.

{{< /checkpoint >}}

## High camp: why Hermitian trace powers are real

A complex matrix can have a complex trace. The module keeps the codomain
\(\mathbb C\), then proves the imaginary part vanishes under a Hermitian
hypothesis.

This is a structural two-step argument:

1. if \(H\) is Hermitian, then \(H^k\) is Hermitian;
2. the trace of a Hermitian matrix is fixed by complex conjugation, so its
   imaginary part is zero.

### Powers preserve pointwise Hermiticity

```lean
omit [MeasurableSpace Ω] in
/-- Every power of an everywhere-Hermitian finite random matrix remains
Hermitian everywhere. -/
theorem IsHermitianEverywhere.matrixPow [Fintype ι] [DecidableEq ι]
    {X : RandomMatrix Ω ι ι ℂ} (hX : IsHermitianEverywhere X) (k : ℕ) :
    IsHermitianEverywhere fun ω ↦ (X ω) ^ k :=
  fun ω ↦ (hX ω).pow k
```

`IsHermitianEverywhere X` means

\[
\forall\omega,\quad X(\omega)^*=X(\omega).
\]

Once an outcome \(\omega\) is fixed, `hX ω` is an ordinary Mathlib proof that
the matrix \(X(\omega)\) is Hermitian. Mathlib's `Matrix.IsHermitian.pow`
theorem returns a proof that \(X(\omega)^k\) is Hermitian. The function
`fun ω ↦ ...` performs that same argument for every outcome
([Mathlib Hermitian API](#ref-mathlib-hermitian)).

Notice the wrapper:

```lean
omit [MeasurableSpace Ω] in
```

It records an important dependency fact. This theorem is purely algebraic. It
does not inspect events, measures, or measurable functions, so the measurable
space on \(\Omega\) should not appear among its logical assumptions.

### Why the trace lands on the real axis

For any finite matrix \(A\), conjugate transpose interacts with trace as

\[
\operatorname{tr}(A^*)
=\overline{\operatorname{tr}(A)}.
\]

If \(A\) is Hermitian, then \(A^*=A\), hence

\[
\overline{\operatorname{tr}(A)}
=\operatorname{tr}(A).
\]

A complex number equals its conjugate exactly when its imaginary part is zero.
The imported `Hermitian` project module packaged this bridge as
`star_trace_eq_of_isHermitian` and `IsHermitianEverywhere.trace_im_eq_zero`.

The pointwise trace-power theorem is therefore concise:

```lean
omit [MeasurableSpace Ω] in
/-- Trace-power observables of an everywhere-Hermitian finite random matrix are
real at every sample. -/
theorem IsHermitianEverywhere.tracePower_im_eq_zero [Fintype ι] [DecidableEq ι]
    {X : RandomMatrix Ω ι ι ℂ} (hX : IsHermitianEverywhere X) (k : ℕ) (ω : Ω) :
    (tracePower X k ω).im = 0 := by
  simpa only [tracePower] using (hX.matrixPow k).trace_im_eq_zero ω
```

The theorem first obtains Hermiticity of the \(k\)th power through
`hX.matrixPow k`. It then applies the already proved trace reality theorem at
the chosen sample `ω`. `simpa only [tracePower]` connects the expanded trace
expression back to the public observable name.

{{< panel "info" >}}
**The result is real-valued, but the function is still typed into \(\mathbb C\).**
The theorem proves `(tracePower X k ω).im = 0`; it does not redefine the
observable as a function into \(\mathbb R\). This keeps one definition usable
for arbitrary complex random matrices and lets Hermitian structure arrive as a
proved refinement.
{{< /panel >}}

## The almost-sure ridge

Some random-matrix constructions satisfy Hermitian symmetry only
{{< refterm "almost-everywhere" "almost everywhere" >}} with respect to a
measure \(\mu\). The file therefore proves an almost-sure reality theorem too:

```lean
/-- Trace-power observables of an almost-surely Hermitian finite random matrix
are real almost surely. -/
theorem isHermitianAE_tracePower_im_eq_zero [Fintype ι] [DecidableEq ι]
    {X : RandomMatrix Ω ι ι ℂ} {μ : Measure Ω} (hX : IsHermitianAE X μ) (k : ℕ) :
    ∀ᵐ ω ∂μ, (tracePower X k ω).im = 0 := by
  filter_upwards [hX] with ω hω
  rw [← Complex.conj_eq_iff_im, ← Complex.star_def]
  simpa only [tracePower] using star_trace_eq_of_isHermitian (hω.pow k)
```

Read the proof in three stages.

### Stage one: enter the full-measure set

`hX` says that for almost every \(\omega\), the realized matrix \(X(\omega)\) is
Hermitian. The tactic

```lean
filter_upwards [hX] with ω hω
```

moves into that full-measure set. Inside the remaining goal, `hω` is the
ordinary pointwise Hermitian proof for the current outcome.

### Stage two: replace zero imaginary part by conjugation symmetry

The rewrite

```lean
rw [← Complex.conj_eq_iff_im, ← Complex.star_def]
```

turns the scalar goal

```lean
(tracePower X k ω).im = 0
```

into the equivalent statement that complex conjugation fixes the scalar. This
is the exact form produced by `star_trace_eq_of_isHermitian`.

### Stage three: prove the realized power is Hermitian

At the current outcome, `hω.pow k` proves that \(X(\omega)^k\) is Hermitian.
The trace lemma then shows that conjugation fixes its trace. Unfolding only
`tracePower` closes the goal.

The almost-sure theorem needs a measure because the phrase "almost surely" is
measure-relative. It still does not take an expectation.

### Pointwise versus almost surely

| Hypothesis | Conclusion | Exceptions allowed? |
|---|---|---|
| `IsHermitianEverywhere X` | Imaginary part is zero for every `ω` | No |
| `IsHermitianAE X μ` | Imaginary part is zero for `μ`-almost every `ω` | Only inside a null set |

The stronger pointwise theorem can always be weakened to an almost-sure one.
The reverse direction is generally false without modifying the function on a
null set.

## Summit API: package the invariant once

The namespace changes from `RandomMatrix` to `HermitianRandomMatrix` for the
final declarations. A `HermitianRandomMatrix Ω ι` already bundles three
things:

1. the underlying square complex matrix-valued map;
2. a proof that the map is measurable; and
3. a proof that every realization is Hermitian.

That bundle lets downstream files construct a powered Hermitian random matrix
in one operation.

### Bundling matrix powers

```lean
/-- Package the pointwise `k`th power of a finite Hermitian random matrix. -/
def matrixPow [Fintype ι] [DecidableEq ι]
    (X : HermitianRandomMatrix Ω ι) (k : ℕ) : HermitianRandomMatrix Ω ι where
  toRandomMatrix := fun ω ↦ (X ω) ^ k
  measurable_toRandomMatrix := RandomMatrix.measurable_matrixPow X.measurable_toRandomMatrix k
  isHermitian := X.isHermitian.matrixPow k
```

The record constructor has one line per obligation:

| Field | Mathematical content | Proof supplied |
|---|---|---|
| `toRandomMatrix` | The new realization is \(X(\omega)^k\) | Definition |
| `measurable_toRandomMatrix` | The powered map is measurable | `RandomMatrix.measurable_matrixPow` |
| `isHermitian` | Every powered realization is Hermitian | `X.isHermitian.matrixPow k` |

This is a central formalization pattern. Prove closure theorems for the
unbundled representation first, then use them to populate a structure whose
invariants travel with the value.

### Making evaluation simplify

```lean
@[simp]
theorem matrixPow_apply [Fintype ι] [DecidableEq ι]
    (X : HermitianRandomMatrix Ω ι) (k : ℕ) (ω : Ω) :
    X.matrixPow k ω = (X ω) ^ k :=
  rfl
```

The theorem is true by reflexivity because `matrixPow` was defined pointwise.
The `@[simp]` attribute tells Lean's simplifier to erase the packaging layer
when a proof evaluates the bundled object at an outcome. Downstream proofs can
reason about the ordinary matrix expression rather than record coercions.

### Re-exporting measurability and reality

The bundle already contains every hypothesis, so the user-facing theorems need
only the matrix and the exponent:

```lean
/-- Every trace-power observable of a bundled finite Hermitian random matrix is
measurable. -/
theorem measurable_tracePower [Fintype ι] [DecidableEq ι]
    (X : HermitianRandomMatrix Ω ι) (k : ℕ) :
    Measurable (RandomMatrix.tracePower X.toRandomMatrix k) :=
  RandomMatrix.measurable_tracePower X.measurable_toRandomMatrix k
```

```lean
/-- Every trace-power observable of a bundled finite Hermitian random matrix is
real at every sample. -/
theorem tracePower_im_eq_zero [Fintype ι] [DecidableEq ι]
    (X : HermitianRandomMatrix Ω ι) (k : ℕ) (ω : Ω) :
    (RandomMatrix.tracePower X.toRandomMatrix k ω).im = 0 :=
  X.isHermitian.tracePower_im_eq_zero k ω
```

These are thin wrappers by design. They expose the strongest convenient API
while leaving the proof engine in the unbundled namespace.

{{< checkpoint stage="Summit" title="Read the bundle as a contract" >}}

Imagine a later file receives only
`X : HermitianRandomMatrix Ω ι`. Which facts can it use without new
hypotheses?

- `X.measurable_toRandomMatrix` supplies matrix measurability.
- `X.isHermitian` supplies pointwise Hermiticity.
- `X.matrixPow k` packages both facts for every natural power.
- `X.measurable_tracePower k` produces a measurable scalar observable.
- `X.tracePower_im_eq_zero k ω` proves its value is real at each sample.

The bundle is not an ensemble. It still says nothing about the law of `X`.

{{< /checkpoint >}}

## The entire Lean file as a proof graph

The module contains ten public declarations. The following table records the
job of each one and its immediate dependency.

| Declaration | Job | Main dependency |
|---|---|---|
| `RandomMatrix.tracePower` | Define \(\omega\mapsto\operatorname{tr}(X(\omega)^k)\) | Matrix power and `Matrix.trace` |
| `RandomMatrix.measurable_matrixPow` | Prove powered random matrices measurable | Induction, `measurable_const`, `measurable_mul` |
| `RandomMatrix.measurable_tracePower` | Prove the scalar observable measurable | `measurable_matrixPow`, `measurable_trace` |
| `IsHermitianEverywhere.matrixPow` | Preserve pointwise Hermiticity under powers | Mathlib `Matrix.IsHermitian.pow` |
| `IsHermitianEverywhere.tracePower_im_eq_zero` | Prove pointwise reality | Powered Hermiticity, trace reality |
| `isHermitianAE_tracePower_im_eq_zero` | Prove almost-sure reality | `filter_upwards`, conjugation criterion |
| `HermitianRandomMatrix.matrixPow` | Bundle the powered map and its invariants | Unbundled measurable and Hermitian theorems |
| `HermitianRandomMatrix.matrixPow_apply` | Simplify bundled evaluation | Definitional equality |
| `HermitianRandomMatrix.measurable_tracePower` | Offer the bundled measurability API | Unbundled trace-power theorem |
| `HermitianRandomMatrix.tracePower_im_eq_zero` | Offer the bundled reality API | Unbundled pointwise theorem |

The dependency structure is intentionally shallow:

{{< mermaid >}}
flowchart TD
  A[tracePower definition] --> C[measurable tracePower]
  B[measurable matrixPow] --> C
  D[everywhere Hermitian matrixPow] --> E[pointwise real tracePower]
  D --> F[almost-sure real tracePower proof at each good sample]
  B --> G[bundled matrixPow]
  D --> G
  G --> H[matrixPow apply simp theorem]
  C --> I[bundled measurable tracePower]
  E --> J[bundled real tracePower]
{{< /mermaid >}}

<p class="figure-note"><strong>Proof architecture.</strong> Algebraic and measurable closure facts are proved for the unbundled function first. The bundled namespace then packages or re-exports them. No expectation node appears because the file has not introduced a measure-and-integrability interface for moments.</p>

## Lean design choices worth carrying forward

### General finite index types, not only `Fin n`

The module uses an arbitrary type `ι` with `[Fintype ι]` and
`[DecidableEq ι]`. A concrete \(n\times n\) matrix can later use `Fin n`, but
theorems do not need to be reproved for other finite labels. This matters when
indices have semantic meaning or when a proof reindexes a matrix.

### Minimal imports through the project dependency chain

The file imports only:

```lean
import NonlinearDynamics.Random.RandomMatrices.Hermitian
```

That project module already imports the Mathlib trace API and the lower random
matrix foundation. The observable layer therefore builds on a clean local
interface instead of reaching around it.

### Separate algebra from measure theory

The `omit [MeasurableSpace Ω] in` wrappers are executable documentation. They
show that powered Hermiticity and pointwise reality depend only on values, not
on the event structure of the sample space.

Measurability theorems retain `[MeasurableSpace Ω]`. Almost-sure theorems also
introduce a measure `μ`. This separation keeps assumptions as weak and visible
as possible.

### Keep one complex observable, prove a real refinement

A separate real-valued function could package the proof that the imaginary
part is zero. The current file does not do that. Reusing one complex definition
avoids duplicating the observable across general and Hermitian matrices. The
tradeoff is that later real integration may need an explicit real-part map or
a bundled real-valued observable.

That is a future API decision, not a hidden consequence of the current code.

## How to run the exact module

From the repository root, load elan and ask Lake to check the file:

```sh
source "$HOME/.elan/env"
cd formalization
lake env lean NonlinearDynamics/Random/RandomMatrices/Observables.lean
```

For the stricter check used during development:

```sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomMatrices/Observables.lean
```

To build the complete Lean library from the repository root:

```sh
make lean
```

To validate both Lean and every Hugo draft:

```sh
make check
```

To read this draft locally beside the source:

```sh
make blog-serve
```

Then open `http://127.0.0.1:1333/`. For private access from another device on
the same tailnet, use `make blog-serve-tailscale`.

### What success looks like

The single-file command should exit without errors. It checks the exact module
against the pinned Lean and Mathlib toolchain. `make lean` additionally checks
that the import graph exposes the module correctly to the project library.

## The next ridge: expectation and the moment method

Everything in this section is a roadmap, not a claim about code already in the
module. The proved results stand on their own. The mathematical bridges below
need their own Lean definitions and hypotheses.

### From one realized spectrum to an empirical spectral measure

For an \(n\times n\) Hermitian matrix \(H\) with real eigenvalues
\(\lambda_1,\ldots,\lambda_n\), define its empirical spectral measure by

\[
L_H=\frac{1}{n}\sum_{i=1}^{n}\delta_{\lambda_i}.
\]

Its \(k\)th moment is

\[
\int_{\mathbb R}x^k\,dL_H(x)
=\frac{1}{n}\sum_{i=1}^{n}\lambda_i^k
=\frac{1}{n}\operatorname{tr}(H^k).
\]

This identity is the conceptual payoff of `tracePower`: normalized trace
powers are moments of the empirical eigenvalue distribution. Mathlib already
contains a finite-dimensional spectral theorem and an identity expressing the
trace of a Hermitian matrix as the sum of its eigenvalues. The current project
has not yet connected those results to `tracePower`
([Mathlib Hermitian spectrum API](#ref-mathlib-spectrum)).

### From a random spectral measure to expected moments

If \(X\) is a random Hermitian matrix under a probability measure \(\mu\), the
expected normalized trace power is

\[
m_k^{(n)}
=\mathbb E_\mu\!\left[\frac{1}{n}\operatorname{tr}(X^k)\right].
\]

To formalize this honestly, a later module must provide at least:

1. a probability measure on the sample space;
2. a dimension convention, usually an index type such as `Fin n`;
3. the chosen normalization of the matrix entries and of trace;
4. measurability, now supplied by this module;
5. integrability of the trace-power observable; and
6. a definition of expectation that does not turn a missing integrability
   proof into a silent scientific claim.

### The closed-walk expansion

For \(k\ge 1\) and a matrix indexed by a finite set, expanding the trace gives

\[
\operatorname{tr}(X^k)
=\sum_{i_0,\ldots,i_{k-1}}
X_{i_0i_1}X_{i_1i_2}\cdots X_{i_{k-1}i_0}.
\]

Every summand follows a closed walk through the index set. Under centered and
independent entry assumptions, many expected products vanish. The surviving
walk patterns encode the limiting moments that appear in Wigner-type
semicircle arguments ([Tao, 2012](#ref-tao-rmt);
[Wigner, 1958](#ref-wigner-1958)).

For \(k=0\), the power is the identity and the trace is simply the finite
dimension, so the positive-length closed-walk formula is not the right
notation for that special case.

This future proof will need considerably more than the current file:

- entry distributions and centering;
- independence strong enough to factor expectations;
- moment or tail assumptions that establish integrability;
- finite combinatorics for index walks and pairings;
- exact normalization bookkeeping; and
- an asymptotic layer if the goal concerns \(n\to\infty\).

The present module is foundational because every one of those steps acts on an
observable that must first exist and be measurable.

### Why physicists care

In quantum mechanics, a finite Hamiltonian is represented by a Hermitian
operator, so its eigenvalues are real energy levels. A trace power sums powers
of those levels without selecting an eigenbasis. Random-matrix models use such
spectral summaries to study collective statistics of complicated systems.

Raw trace powers are sensitive to scale and to shifts of the energy origin.
For example, replacing \(H\) by \(H+cI\) changes all powers except in special
combinations. A serious ensemble definition must therefore specify centering,
variance, dimension scaling, and whether trace is normalized. Hermitian
symmetry alone does not choose any of them.

### A bridge toward nonlinear dynamics

For a nonlinear map, a Jacobian describes local linear behavior. Products of
Jacobians control how perturbations propagate. A general Jacobian is not
Hermitian, so its raw trace powers do not directly provide the same real
spectral story.

Hermitian positive-semidefinite matrices such as \(J^*J\) encode squared
singular values and can support related observables. Turning that intuition
into a theorem requires new constructors, measurability proofs, and a precise
connection to stability or Lyapunov quantities. None of that is claimed by
`Observables.lean`, but the trace-power interface points toward it.

## Honest limitations of the current file

| Missing layer | Why it matters |
|---|---|
| Probability law | Without a measure, there is no expectation or distribution |
| Integrability | A measurable trace power need not have a finite moment |
| Normalized trace | Ordinary trace grows with dimension; asymptotic work usually fixes a convention |
| Eigenvalue bridge | The file does not yet prove trace power equals a sum of eigenvalue powers |
| Real-valued wrapper | Hermitian trace powers are proved real inside \(\mathbb C\), not repackaged as \(\mathbb R\)-valued functions |
| Ensemble assumptions | Gaussianity, independence, variance, and unitary invariance are absent |
| Quantitative moments | No expected low-order trace moment is computed |
| Asymptotics | No sequence of dimensions, convergence notion, or limiting law appears |

These are not defects in the proof. They are boundaries between reusable
structure and ensemble-specific analysis.

## Exercises with footholds

{{< panel "exercise" >}}
**Exercise 1: the zeroth observable.** Show on paper that for a finite index
type \(\iota\), `tracePower X 0 ω` does not depend on either `X` or `ω`.

*Foothold:* unfold `tracePower`, rewrite with `pow_zero`, then use the trace of
the identity matrix.
{{< /panel >}}

{{< panel "exercise" >}}
**Exercise 2: diagonal powers.** For a diagonal random matrix
\(X(\omega)=\operatorname{diag}(d_1(\omega),\ldots,d_n(\omega))\), derive
\(S_k(\omega)=\sum_i d_i(\omega)^k\).

*Foothold:* first prove the corresponding deterministic matrix identity.
{{< /panel >}}

{{< panel "exercise" >}}
**Exercise 3: find the finiteness assumptions.** Locate every place where
`Fintype ι` is mathematically used. Separate matrix multiplication from trace.

*Foothold:* expand one matrix-product entry and the trace definition into
finite sums.
{{< /panel >}}

{{< panel "exercise" >}}
**Exercise 4: pointwise to almost surely.** Starting from
`IsHermitianEverywhere.tracePower_im_eq_zero`, sketch an alternative proof that
the same conclusion holds almost everywhere for any measure.

*Foothold:* use `Filter.Eventually.of_forall`.
{{< /panel >}}

{{< panel "exercise" >}}
**Exercise 5: why products are special.** Two Hermitian matrices need not have
a Hermitian product. Explain why \(H^k\) is nevertheless Hermitian.

*Foothold:* all factors are the same matrix, so the order reversal caused by
conjugate transpose does not create a mismatch.
{{< /panel >}}

{{< panel "exercise" >}}
**Exercise 6: design the next API.** Propose a Lean definition for an expected
trace power that makes the measure and integrability assumption visible. Do
not implement it by merely writing an integral whose non-integrable behavior
is easy to overlook.
{{< /panel >}}

{{< panel "exercise" >}}
**Exercise 7: normalized versus ordinary trace.** Compare
\(\operatorname{tr}(I)\) with \(n^{-1}\operatorname{tr}(I)\). Explain which
quantity remains fixed as dimension grows and why a semicircle-law module must
choose explicitly.
{{< /panel >}}

{{< panel "exercise" >}}
**Exercise 8: spectral bridge.** Using Mathlib's Hermitian spectral API as a
guide, outline the theorem that should connect
`RandomMatrix.tracePower X k ω` to the sum of the \(k\)th powers of the
eigenvalues of `X ω`.
{{< /panel >}}

## Summit register

The module's achievement is precise. A measurable finite complex random matrix
has measurable trace-power observables. Hermitian structure survives every
natural power. Therefore every such observable is real at each Hermitian
sample, and it is real almost surely when Hermitian symmetry holds almost
surely. The bundled Hermitian API carries those facts forward automatically.

The next conceptual step is not to write an expectation symbol and move on. It
is to introduce a probability law, prove integrability, choose normalization,
connect trace powers to eigenvalue powers, and only then calculate moments.
That deliberate pace is what turns a familiar formula into a dependable
formal foundation.

## References

References were opened and checked against official documentation, publisher
pages, author pages, or the original article on 2026-07-20.

<a id="ref-mathlib-trace"></a>**Mathlib contributors.**
[Matrix trace documentation](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Trace.html).
Defines `Matrix.trace` and records, among other identities,
`trace_conjTranspose`. The project is pinned to Mathlib revision
[`81a5d257`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/LinearAlgebra/Matrix/Trace.lean#L45-L77).

<a id="ref-mathlib-hermitian"></a>**Mathlib contributors.**
[Hermitian matrix documentation](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html).
Defines `Matrix.IsHermitian` and includes `Matrix.IsHermitian.pow`; see the
[pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/LinearAlgebra/Matrix/Hermitian.lean#L327-L328).

<a id="ref-mathlib-spectrum"></a>**Mathlib contributors.**
[Hermitian matrix spectrum documentation](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Spectrum.html).
Documents finite-dimensional unitary diagonalization and
`Matrix.IsHermitian.trace_eq_sum_eigenvalues`. Cited for the future spectral
bridge, not as a theorem proved in `Observables.lean`.

<a id="ref-lean-induction"></a>**Lean developers.**
[Induction and Recursion](https://lean-lang.org/theorem_proving_in_lean4/Induction-and-Recursion/),
*Theorem Proving in Lean 4*. Official explanation of natural-number induction
and the `zero` and `succ` proof structure used by `measurable_matrixPow`.

<a id="ref-mathlib-average"></a>**Mathlib contributors.**
[Average value of a function](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Integral/Average.html).
Documents Mathlib's measure-theoretic average and explicitly separates the
definition from lemmas that require integrability. Cited to clarify why this
module stops before expectation.

<a id="ref-tao-rmt"></a>**Terence Tao.** *Topics in Random Matrix Theory*.
Graduate Studies in Mathematics 132, American Mathematical Society, 2012.
[Author's book page](https://teorth.github.io/tao-web/topics-in-random-matrix-theory.html)
and [publisher record](https://bookstore.ams.org/gsm-132/). The publisher
describes the book's focus on spectral distributions of Wigner ensembles,
including GUE, and independent-entry ensembles. Cited for the broader
trace-moment and random-matrix roadmap.

<a id="ref-wigner-1958"></a>**Eugene P. Wigner.** "On the Distribution of the
Roots of Certain Symmetric Matrices." *Annals of Mathematics* 67, no. 2
(1958), 325–327.
[Original journal record](https://www.jstor.org/stable/1970008),
[DOI 10.2307/1970008](https://doi.org/10.2307/1970008). This is a published
primary source in the historical development of the semicircle law. It is
cited as historical context for the future moment-method ridge, not as support
for a result already formalized here.
