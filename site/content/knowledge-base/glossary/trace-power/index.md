---
title: "Trace-power observable"
slug: "trace-power"
summary: "A trace-power observable sends a matrix to the trace of one of its powers, connecting entries, closed walks, and spectral moments."
draft: true
pro_reviewed: false
toc: false
---

For a finite square matrix \(A\) and a nonnegative integer \(k\), the
**trace-power observable** is

\[
\operatorname{tr}(A^k).
\]

If \(A\) has eigenvalues \(\lambda_1,\ldots,\lambda_n\), counted
with algebraic multiplicity, then

\[
\operatorname{tr}(A^k)=\sum_{r=1}^{n}\lambda_r^k.
\]

For a {{< refterm "hermitian-matrix" "Hermitian matrix" >}}, all those
eigenvalues are real. The trace power is therefore real as well.

## A coordinate reading

Expanding matrix multiplication gives

\[
\operatorname{tr}(A^k)
=\sum_{i_0,\ldots,i_{k-1}}
A_{i_0 i_1}A_{i_1 i_2}\cdots A_{i_{k-1}i_0}.
\]

Every summand follows a closed sequence of indices and returns to its starting
point. This closed-walk picture becomes useful in the random-matrix moment
method, where independence and centering determine which index patterns have
nonzero expectation.

## Random matrices add another layer

For a matrix-valued random variable \(X\), the project defines the scalar
random variable

\[
\omega\longmapsto\operatorname{tr}(X(\omega)^k).
\]

This is an **observable** before it is a **moment**. Measurability says the
scalar function can be integrated. It does not guarantee that the integral is
finite or even that the required integrability theorem has been proved.

The corresponding expected trace moment, when it exists, is

\[
\mathbb E\big[\operatorname{tr}(X^k)\big].
\]

That expectation needs a probability measure and an integrability argument,
neither of which is part of the elementary observable definition.

RMT-09 now discharges those obligations for the first two powers of the
project's finite Wigner-scaled Gaussian unitary ensemble law. The
{{< refterm "finite-matrix-trace-moment" "finite matrix trace moment" >}}
entry separates the analytic layers, and
[First Exact Finite Gaussian Unitary Ensemble Trace Moments]({{< relref "/knowledge-base/deep-dives/first-exact-finite-gue-trace-moments" >}})
derives both checked identities.

RMT-10A now proves that the first two trace powers are also the first two
power moments of the finite Hermitian spectral counting measure. The
{{< refterm "empirical-spectral-measure" "empirical spectral measure" >}}
entry explains that bridge, its normalization, and why a random spectral law
still needs coordinatewise eigenvalue measurability.

## In Lean

The project uses:

```lean
def tracePower [Fintype ι] [DecidableEq ι]
    (X : RandomMatrix Ω ι ι ℂ) (k : ℕ) : Ω → ℂ :=
  fun ω ↦ Matrix.trace ((X ω) ^ k)
```

Finiteness makes trace and matrix multiplication finite sums. Decidable
equality is needed by the matrix identity appearing at exponent zero.

{{< panel "warning" >}}
**Do not skip normalization.** The expressions
\(\operatorname{tr}(X^k)\),
\(n^{-1}\operatorname{tr}(X^k)\), and
\(\operatorname{tr}((X/\sqrt n)^k)\) are different observables.
Their relationship depends on the chosen matrix scaling.
{{< /panel >}}

Related concepts: {{< refterm "matrix-trace" "matrix trace" >}},
{{< refterm "random-matrix" "random matrix" >}}, and
{{< refterm "empirical-spectral-measure" "empirical spectral measure" >}}.

Further reading: Terence Tao's
[Topics in Random Matrix Theory](https://doi.org/10.1090/gsm/132)
develops the moment method and its connection to the semicircle law.
