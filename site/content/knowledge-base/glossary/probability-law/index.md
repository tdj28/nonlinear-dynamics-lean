---
title: "Probability law"
slug: "probability-law"
summary: "The probability law of a random object records how probability is distributed over its possible values."
draft: false
pro_reviewed: false
toc: true
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
prose, equations, examples, references, and Lean interpretation is still
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

The **probability law** of a random object records the probabilities of its
possible values while forgetting which underlying outcomes produced them. It
is also called the object's **distribution**.

Suppose \(\Omega\) is the set of outcomes, \(\mathcal F\) is a collection of
measurable events in \(\Omega\), and \(\mathbb P\) is a probability measure on
those events. Let \(S\) be a measurable space of possible values. A measurable
function

\[
X:(\Omega,\mathcal F)\longrightarrow S
\]

is a random element with values in \(S\). Its law, written
\(\mathcal L(X)\) or \(X_*\mathbb P\), is the probability measure on \(S\)
defined by

\[
\mathcal L(X)(B)
=\mathbb P\bigl(X^{-1}(B)\bigr)
=\mathbb P\{\omega\in\Omega:X(\omega)\in B\}
\]

for every measurable set \(B\subseteq S\). Here \(X^{-1}(B)\) is the set of
outcomes whose values land in \(B\). This construction is the
{{< refterm "pushforward-measure" "pushforward measure" >}}
\(X_*\mathbb P\).

## What the law keeps, and what it forgets

The law keeps every probability statement that depends only on the value of
\(X\). It forgets the names and internal structure of the outcomes in
\(\Omega\).

| Layer | Question it answers | Matrix example |
|---|---|---|
| Outcome \(\omega\) | What happened in the underlying experiment? | A particular noise realization |
| Random object \(X\) | What value does that outcome produce? | The function that returns \(X(\omega)\) |
| Realization \(X(\omega)\) | Which value appeared this time? | One ordinary matrix |
| Law \(\mathcal L(X)\) | How is probability distributed across possible values? | A measure on matrix space |

Two random objects can live on completely different probability spaces and
still have the same law. If \(X\) and \(Y\) both take values in the same
measurable space \(S\), then

\[
X\mathrel{\overset{d}{=}}Y
\quad\Longleftrightarrow\quad
\mathcal L(X)=\mathcal L(Y).
\]

The notation \(X\mathrel{\overset{d}{=}}Y\) is read "equal in distribution."
It does not say that \(X=Y\) pointwise, or even that \(X\) and \(Y\) share a
sample space.

## A finite matrix example

Let the outcome space contain two points, \(\omega_0\) and \(\omega_1\), with

\[
\mathbb P\{\omega_0\}=\frac14,
\qquad
\mathbb P\{\omega_1\}=\frac34.
\]

Define two matrices

\[
A_0=
\begin{bmatrix}
1&0\\
0&-1
\end{bmatrix},
\qquad
A_1=
\begin{bmatrix}
2&0\\
0&0
\end{bmatrix},
\]

and define the random matrix \(X\) by

\[
X(\omega_0)=A_0,
\qquad
X(\omega_1)=A_1.
\]

Write \(\delta_A\) for a point mass concentrated at a matrix \(A\). Then

\[
\mathcal L(X)
=\frac14\,\delta_{A_0}+\frac34\,\delta_{A_1}.
\]

This equation is a complete description of the law. For example, let \(B\) be
the set of matrices with trace zero. The first matrix lies in \(B\) and the
second does not, so

\[
\mathcal L(X)(B)=\frac14.
\]

The numbers are exact toy probabilities, not empirical measurements. Their
job is to make the definition directly checkable.

## From a matrix law to an observable law

A scalar quantity computed from a matrix is an **observable**. If \(T\) is
another measurable space and \(f:S\to T\) is measurable, then \(f(X)\) is a
random element in \(T\), and

\[
\mathcal L(f(X))=f_*\mathcal L(X).
\]

For the matrix \(X\) above, the trace observable takes values \(0\) and \(2\)
with probabilities \(1/4\) and \(3/4\). Its law is therefore

\[
\mathcal L(\operatorname{tr}X)
=\frac14\,\delta_0+\frac34\,\delta_2.
\]

This passage from a matrix law to an observable law is how eigenvalues, traces,
norms, and other matrix statistics become ordinary probability distributions.
Measurability of the observable is a real proof obligation. A formula alone
does not automatically define a random variable.

## Lean-facing interpretation

Mathlib represents the pushforward with <code>Measure.map</code>. The checked
<code>RandomMatrices.Laws</code> module now makes the matrix law explicit:

~~~lean
noncomputable def RandomMatrix.law
    (X : RandomMatrix Ω ι ι ℂ) (_hX : Measurable X)
    (μ : Measure Ω) : Measure (Matrix ι ι ℂ) :=
  Measure.map X μ
~~~

The measurability proof is an explicit argument. This prevents the name
"law" from hiding the condition under which the usual pushforward equations
hold. For a measurable target set <code>s</code>, the checked theorem
<code>RandomMatrix.law_apply</code> states

~~~text
RandomMatrix.law X hX μ s = μ (X ⁻¹' s).
~~~

The same module proves <code>law_comp</code> for measurable matrix
endomorphisms, <code>law_isProbabilityMeasure</code> when the source measure
is a probability measure, and <code>law_dirac</code> for a point-mass source.
The bundled <code>HermitianRandomMatrix.law</code> reuses the measurability
field already stored in a Hermitian random matrix.

The source measure remains an explicit argument rather than a field of
<code>RandomMatrix</code>. That makes the dependence of the law on the chosen
measure visible. Mathlib's underlying <code>Measure.map</code> is defined as
the zero measure when its map is not almost-everywhere measurable, but the
project's <code>RandomMatrix.law</code> requires measurability and does not
silently use that fallback as a probabilistic assumption.

## Distinctions that prevent common mistakes

| Do not confuse | With | Why the difference matters |
|---|---|---|
| A random matrix \(X\) | Its law \(\mathcal L(X)\) | One is a function; the other is a measure on matrix space |
| Equal laws | Pointwise equality | Different functions, even on different spaces, can have the same law |
| A marginal entry law | The joint matrix law | Marginals do not record dependence among entries |
| Support on Hermitian matrices | {{< refterm "unitary-invariance" "unitary invariance" >}} | Hermiticity restricts possible values; invariance is a symmetry of their probabilities |
| Measurability | Integrability | A measurable observable need not have a finite expectation |

Knowing every one-entry marginal law is generally not enough to recover the
matrix law. Correlations between entries are part of the joint law. This is
especially important for a {{< refterm "hermitian-matrix" "Hermitian matrix" >}},
whose reflected off-diagonal entries are linked by complex conjugation.

{{< panel "warning" >}}
**Boundary of the current formalization.** The project now defines Gaussian
entry laws, a Wigner-scaled finite Gaussian unitary ensemble matrix law, its
coordinate product law, and exact diagonal and strict-upper marginals. It also
defines the law-level unitary-conjugation predicate. It has not proved
nontrivial GUE invariance, matrix-entry integrability, or expected trace
moments.
{{< /panel >}}

## Where to continue

The {{< refterm "random-matrix" "random matrix" >}} page separates a map from
one of its realized values. The
{{< refterm "pushforward-measure" "pushforward measure" >}} page studies the
construction \(X_*\mathbb P\) itself. The
{{< refterm "measurable-space" "measurable space" >}} page explains why
measurability must come before a law. For the full learning path, continue to
[Random Matrices: From Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}}).
The first complete named ensemble construction is developed in
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}}).

## References

**Olav Kallenberg.**
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1),
third edition, Springer, 2021. This is a standard source for random elements,
their distributions, and measurable mappings.

**Mathlib contributors.**
[Pushforward of a measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
Mathlib 4 documentation. This official implementation reference documents
<code>Measure.map</code>, <code>map_apply</code>, and the non-measurable
fallback described above.

**Greg W. Anderson, Alice Guionnet, and Ofer Zeitouni.**
[An Introduction to Random Matrices](https://doi.org/10.1017/CBO9780511801334),
Cambridge University Press, 2010. This develops matrix ensembles as probability
laws and tracks the additional symmetry and normalization assumptions needed
for the classical models.
