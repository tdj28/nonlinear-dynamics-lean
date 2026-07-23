---
title: "Probability distribution (law)"
slug: "probability-law"
summary: "A probability distribution, or law, is the pushforward probability measure induced by a random object on its measurable value space."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.Laws"
og_image: "probability-distribution-card.png"
og_image_alt: "Two weighted outcomes map to two matrices, and their weights become point masses in the probability distribution on matrix space."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
prose, equations, examples, references, and Lean interpretation is still
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

The **probability distribution**, or **law**, of a random object assigns mass
to measurable subsets of its value space. It is a probability measure, not the
random object itself. The two names mean the same thing on this site.

## Start with a two-atom matrix law

Let the outcome space be \(\Omega=\{\omega_0,\omega_1\}\), with

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

The calculation can be checked directly from the source outcomes:

\[
X^{-1}(B)=\{\omega_0\},
\qquad
\mathbb P\bigl(X^{-1}(B)\bigr)=\mathbb P\{\omega_0\}=\frac14.
\]

{{< reference-figure
  wide="true"
  src="two-outcome-matrix-law.svg"
  alt="The outcome omega zero has probability one quarter and maps to matrix A zero, while omega one has probability three quarters and maps to matrix A one. The induced law assigns those masses to the two matrices. The trace-zero set contains only A zero, so its law is one quarter."
  caption="**Finding:** the map \(X\) moves probability mass from outcomes to matrix values. Outcome \(\omega_0\) has mass \(1/4\) and maps to \(A_0\), while \(\omega_1\) has mass \(3/4\) and maps to \(A_1\). The target strip has one part for \(A_0\) and three equal parts for \(A_1\), encoding the exact ratio \(1:3\). For the set \(B\) of trace-zero matrices, only \(A_0\) is inside, so \(\mathcal L(X)(B)=1/4\). The four strip segments represent assigned probability mass, not four observed trials."
>}}

The numbers are exact toy probabilities, not empirical measurements. Renaming
\(\omega_0\) and \(\omega_1\) without changing their masses or matrix values
does not change the law. Changing a mass does. If both outcomes mapped to
\(A_0\), their masses would combine and the law would put total mass one at
\(A_0\).

## The general definition

Suppose \(\Omega\) is the set of outcomes, \(\mathcal F\) is the collection of
events to which probabilities may be assigned, and \(\mathbb P\) is a
probability measure on those events. Let \(S\) be a
{{< refterm "measurable-space" "measurable value space" >}}. A
measurable function

\[
X:(\Omega,\mathcal F)\longrightarrow S
\]

is a random element with values in \(S\). Its law, written
\(\mathcal L(X)\) or \(X_*\mathbb P\), is the probability measure on \(S\)
defined by

\[
\mathcal L(X)(B)
{} =
\mathbb P\bigl(X^{-1}(B)\bigr)
{} =
\mathbb P\{\omega\in\Omega:X(\omega)\in B\}
\]

for every measurable set \(B\subseteq S\). Here \(X^{-1}(B)\) is the event
consisting of outcomes whose values land in \(B\). This construction is the
{{< refterm "pushforward-measure" "pushforward measure" >}}
\(X_*\mathbb P\).

Measurability is what ensures that the preimage \(X^{-1}(B)\) is an allowed
event whenever \(B\) is a measurable target set. Without that condition, the
displayed probability may not be defined.

## What the law retains, and what it discards

The law retains every probability statement that depends only on the value of
\(X\). It discards the names and internal structure of the outcomes in
\(\Omega\).

| Layer | Question it answers | Two-matrix example |
|---|---|---|
| Outcome \(\omega\) | What happened in the underlying experiment? | Either \(\omega_0\) or \(\omega_1\) |
| Random object \(X\) | Which value does each outcome produce? | The map sending \(\omega_0\) to \(A_0\) and \(\omega_1\) to \(A_1\) |
| Realization \(X(\omega)\) | Which value appeared for this outcome? | One ordinary matrix, \(A_0\) or \(A_1\) |
| Law \(\mathcal L(X)\) | How is probability distributed across all values? | Mass \(1/4\) at \(A_0\) and \(3/4\) at \(A_1\) |

Two random objects can live on different probability spaces and still have
the same law. If \(X\) and \(Y\) both take values in the same measurable space
\(S\), then

\[
X\mathrel{\overset{d}{=}}Y
\quad\Longleftrightarrow\quad
\mathcal L(X)=\mathcal L(Y).
\]

The notation \(X\mathrel{\overset{d}{=}}Y\) is read "equal in distribution."
It does not say that \(X=Y\) pointwise, or even that \(X\) and \(Y\) share a
sample space.

## A law is not automatically a density

The law is the probability measure itself. A probability mass function, a
density, or a cumulative distribution function is a way to describe certain
laws when additional structure is available.

| Object | What it records | Does every law have one? | In the example |
|---|---|---|---|
| Law \(\mathcal L(X)\) | A probability for every measurable target set | Yes, once \(X\) is measurable | \(\frac14\delta_{A_0}+\frac34\delta_{A_1}\) |
| Probability mass function (PMF) \(p(a)=\mathbb P\{X=a\}\) | Mass at each value of a discrete random object | No; it is a discrete representation | \(p(A_0)=1/4\), \(p(A_1)=3/4\) |
| Density \(f\) relative to a reference measure \(\lambda\) | \(\mathcal L(X)(B)=\int_B f\,d\lambda\) | No; some laws have atoms and no density relative to Lebesgue measure | The two-atom law has no ordinary Lebesgue density on matrix coordinates |
| Cumulative distribution function (CDF) \(F(t)=\mathbb P\{X\le t\}\) | Probabilities of lower half-lines for a real-valued object | Only for an ordered real-valued setting | Not the natural description of a matrix-valued object |

The finite law does have a PMF on its two-point support. Equivalently, that
PMF can be viewed as a density relative to counting measure, but this does not
turn it into a density relative to every other reference measure. Always name
the reference measure when saying "density."

The distinction between a random object and its law is equally important.
The random object \(X\) is a function of an outcome. Its law
\(\mathcal L(X)\) is a measure on the value space. Knowing the law does not
reconstruct the fibers of \(X\), its exact set-theoretic range on null sets, or
which outcome was mapped to which value.

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

## In Lean

Mathlib writes a pushforward as <code>Measure.map</code>. The project wraps that
construction in <code>RandomMatrix.law</code> while keeping the measurability
proof visible.

{{< lean-bridge
  human="If a random matrix \(X\) is measurable, then the probability that its value lies in a measurable matrix set \(s\) equals the source probability of the outcomes that \(X\) sends into \(s\)."
  math="\(\mathcal L_\mu(X)(s)=\mu\!\left(X^{-1}(s)\right)\) for every measurable set \(s\)."
  lean="RandomMatrix.law X hX μ s = μ (X ⁻¹' s)"
>}}

- <code>RandomMatrix.law X hX μ</code> is the target-space measure
  <code>Measure.map X μ</code>.
- <code>X</code> is the matrix-valued function, and
  <code>hX : Measurable X</code> is the proof that preimages of measurable
  target sets are measurable source events.
- <code>μ</code> is the source measure. The same map can have different laws
  under different source measures.
- <code>s</code> is a target set, with a separate hypothesis
  <code>hs : MeasurableSet s</code> in the theorem.
- <code>X ⁻¹' s</code> is Lean's notation for the set-theoretic preimage of
  <code>s</code> under <code>X</code>. It is the Lean counterpart of
  \(X^{-1}(s)\).
{{< /lean-bridge >}}

### Small standalone tutorial: push the two quarter-weights forward

The exact matrices \(A_0\) and \(A_1\) from the worked example can be treated
as two symbolic values while Lean checks the finite probability ledger. The
source weights are stored in quarters, so \(1\) means \(1/4\) and \(3\) means
\(3/4\). Create <code>/tmp/TwoMatrixLaw.lean</code> with these contents:

~~~lean
import Std

namespace TwoMatrixLaw

inductive Outcome
  | omega0
  | omega1
  deriving DecidableEq, Repr

inductive MatrixValue
  | a0
  | a1
  deriving DecidableEq, Repr

def outcomes : List Outcome :=
  [.omega0, .omega1]

def sourceMassQuarters : Outcome → Nat
  | .omega0 => 1
  | .omega1 => 3

def randomMatrix : Outcome → MatrixValue
  | .omega0 => .a0
  | .omega1 => .a1

def traceZero : MatrixValue → Bool
  | .a0 => true
  | .a1 => false

def lawMassQuarters (targetEvent : MatrixValue → Bool) : Nat :=
  outcomes.foldl
    (fun total omega =>
      if targetEvent (randomMatrix omega) then
        total + sourceMassQuarters omega
      else
        total)
    0

#eval lawMassQuarters traceZero
#eval lawMassQuarters (fun _ => true)

example : lawMassQuarters traceZero = 1 := by decide
example : lawMassQuarters (fun _ => true) = 4 := by decide

end TwoMatrixLaw
~~~

From any directory on a normal macOS or Linux machine with the pinned compiler,
type exactly:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean /tmp/TwoMatrixLaw.lean
~~~

This exact worksheet was executed successfully with Lean 4.32.0 while
repairing this page. It printed:

~~~text
1
4
~~~

The first line says the trace-zero target event receives one quarter of the
mass because only \(\omega_0\) maps to \(A_0\). The second confirms that the
whole target space receives all four quarters. This <code>Std</code>-only
tutorial checks the finite pushforward arithmetic. It intentionally leaves
matrix algebra, measurability, and <code>Measure.map</code> to the exact
project interface below.

### Exact project and Mathlib interface

The following is an exact excerpt from the checked project module. The
definition exposes the pushforward, and the theorem reduces its value on a
measurable set to the preimage calculation used in the example.

~~~lean
noncomputable def law (X : RandomMatrix Ω ι ι ℂ) (_hX : Measurable X)
    (μ : Measure Ω) : Measure (Matrix ι ι ℂ) :=
  Measure.map X μ

theorem law_apply (X : RandomMatrix Ω ι ι ℂ) (hX : Measurable X)
    (μ : Measure Ω) {s : Set (Matrix ι ι ℂ)} (hs : MeasurableSet s) :
    law X hX μ s = μ (X ⁻¹' s) := by
  exact Measure.map_apply hX hs
~~~

The same module proves <code>law_comp</code> for measurable matrix
endomorphisms, <code>law_isProbabilityMeasure</code> when the source measure
is a probability measure, and <code>law_dirac</code> for a point-mass source.
The bundled <code>HermitianRandomMatrix.law</code> reuses the measurability
field already stored in a Hermitian random matrix.

The source measure remains an explicit argument rather than a field of
<code>RandomMatrix</code>. That makes the dependence of the law on the chosen
measure visible. Mathlib's underlying <code>Measure.map</code> is totalized to
the zero measure when its map is not almost-everywhere measurable. The
project's <code>RandomMatrix.law</code> requires measurability and does not use
that fallback as a hidden probabilistic assumption.

{{< repo-check >}}
The authoritative source is
[`formalization/NonlinearDynamics/Random/RandomMatrices/Laws.lean`](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/Laws.lean).
A learner can put these lines in a temporary scratch file inside a clone with
the repository's pinned dependencies installed:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.Laws

#print NonlinearDynamics.Random.RandomMatrix.law
#check NonlinearDynamics.Random.RandomMatrix.law_apply
~~~

<code>#print</code> shows the definition behind the name. <code>#check</code>
asks Lean to elaborate the following identifier and report its type; it does
not create a new theorem. The command below checks the authoritative project
module itself.
{{< /repo-check >}}

## Distinctions that prevent common mistakes

| Do not confuse | With | Why the difference matters |
|---|---|---|
| A {{< refterm "random-matrix" "random matrix" >}} \(X\) | Its law \(\mathcal L(X)\) | One is a function; the other is a measure on matrix space |
| Equal laws | Pointwise equality | Different functions, even on different spaces, can have the same law |
| A marginal entry law | The joint matrix law | Marginals do not record dependence among entries |
| A law | A density, PMF, or CDF | The law is a measure; the other objects are representations available in particular settings |
| Full law mass on Hermitian matrices | {{< refterm "unitary-invariance" "unitary invariance" >}} | The first makes the non-Hermitian locus null; the second is a symmetry of the law. Neither phrase alone identifies a particular sample map's pointwise range |
| Measurability | Integrability | A measurable observable need not have a finite expectation |

Knowing every one-entry marginal law is generally not enough to recover the
matrix law. Correlations between entries are part of the joint law. This is
especially important for a {{< refterm "hermitian-matrix" "Hermitian matrix" >}},
whose reflected off-diagonal entries are linked by complex conjugation.

{{< panel "warning" >}}
**What this definition does not prove.** Constructing a law proves neither
that it has a density nor that its coordinates are independent, integrable,
Gaussian, or invariant under a symmetry. Those are separate properties with
separate hypotheses and proofs. The checked <code>Laws.lean</code> bridge
defines matrix laws and proves general pushforward facts; later ensemble
modules add only the properties they prove explicitly.
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
