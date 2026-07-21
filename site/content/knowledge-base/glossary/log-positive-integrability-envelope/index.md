---
title: "Log-positive integrability envelope"
slug: "log-positive-integrability-envelope"
summary: "A log-positive integrability envelope keeps only the expanding part of finite cocycle norm growth, making a real nonnegative majorant whose one-step integrability propagates to every finite horizon."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability"
og_image: "log-positive-integrability-envelope-card.png"
og_image_alt: "A finite cocycle norm enters a positive-log gate: collapse, contraction, and unit scale merge at zero while expansion remains positive, after which an explicit one-step integrability hypothesis is transported along a measure-preserving base to build an integrable finite orbit sum."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page must remain a draft until that review is complete.
{{< /panel >}}

A **log-positive integrability envelope** is a real-valued upper-growth
observable for a matrix cocycle. It keeps positive logarithmic expansion and
clips everything else to zero. If

\[
N_k(\omega)=\lVert C(k,\omega)\rVert_\infty
\]

is the finite-time maximum absolute row-sum norm from RMT-14, then RMT-15
defines

\[
P_k(\omega)
{} =
\log^+ N_k(\omega)
{} =
\max\!\left(0,\operatorname{Real.log}N_k(\omega)\right).
\]

Here \(C(k,\omega)\) is the cocycle matrix after \(k\) steps from base state
\(\omega\), and \(\log^+\), read “log positive,” is Mathlib's
<code>Real.posLog</code>. The result \(P_k:\Omega\to\mathbb R\) is measurable
and nonnegative.

The word **envelope** is essential. \(P_k\) controls the positive tail of norm
growth, but it does not preserve the full logarithmic dynamics. It sends exact
collapse, strict contraction, and neutral norm one to the same real value
zero.

{{< reference-figure
  src="log-positive-integrability-envelope.svg"
  alt="Exact collapse, strict contraction, and unit norm enter the same zero output of the positive-log gate, while norms above one retain their positive logarithmic size. Shifted one-step outputs are then added into a finite orbit envelope."
  caption="**Finding:** the positive-log gate preserves expansion above unit norm but deliberately merges collapse, contraction, and unit scale at zero. Summing the shifted one-step outputs gives a nonnegative finite-horizon majorant whose integrability can be inherited from one explicit generator assumption. The diagram does not recover negative growth, the extended-real bottom value, a normalized limit, or a Lyapunov exponent."
>}}

## What the gate keeps and forgets

For a nonnegative real norm \(r\), Mathlib's definition gives the piecewise
picture

\[
\log^+ r
{} =
\begin{cases}
0, & 0\le r\le 1,\\
\log r, & 1\le r.
\end{cases}
\]

The overlap at \(r=1\) is harmless because both branches equal zero. The
construction is continuous even at \(r=0\), where Lean's total real logarithm
also has value zero.

Compare it with the
{{< refterm "extended-log-norm-observable" "extended log-norm observable" >}}
\(L_k\) from RMT-14:

| Norm regime | Extended log norm \(L_k\) | Log-positive envelope \(P_k\) | Information retained by \(P_k\) |
|---|---:|---:|---|
| \(N_k=0\) | \(\bot\) | \(0\) | No record of exact collapse |
| \(0\lt N_k\lt1\) | A negative real | \(0\) | No contraction magnitude |
| \(N_k=1\) | \(0\) | \(0\) | Neutral scale is included in the same bucket |
| \(N_k\gt1\) | A positive real | \(\log N_k\) | Positive expansion size |

Thus \(P_k\) is not a replacement for \(L_k\). It is the simpler real
majorant needed to state an ordinary Bochner-integrability hypothesis for the
expanding part.

## Finite-time subadditivity

RMT-14 proves norm submultiplicativity across the one-sided cocycle split:

\[
N_{m+k}(\omega)
\le
N_k(T^m\omega)N_m(\omega).
\]

The positive logarithm is monotone on nonnegative inputs, and Mathlib proves

\[
\log^+(rs)\le \log^+r+\log^+s.
\]

Consequently RMT-15 obtains

\[
P_{m+k}(\omega)
\le
P_k(T^m\omega)+P_m(\omega).
\]

This is still a pointwise finite-time inequality. It invokes no probability,
ergodicity, expectation, or limiting theorem.

## The orbit-sum majorant

The one-step envelope is sampled along the forward base orbit and added:

\[
S_k(\omega)
{} =
\sum_{j=0}^{k-1}P_1(T^j\omega).
\]

Lean names this function <code>orbitLogPlusSum</code>. The empty sum is zero,
and extending the horizon appends the newest shifted one-step term:

\[
S_{k+1}(\omega)
{} =
S_k(\omega)+P_1(T^k\omega).
\]

Induction with finite-time subadditivity proves the domination estimate

\[
0\le P_k(\omega)\le S_k(\omega).
\]

The right side is deliberately loose. It forgets cancellation between matrix
factors and every contracting one-step contribution. Its value is that it is a
finite sum of copies of one measurable function pulled back along the base
orbit.

## The explicit integrability hypothesis

The project does not derive integrability from measure preservation. It names
the missing assumption:

~~~lean
def HasIntegrableGeneratorLogPlus
    (C : DiscreteMatrixCocycle (ι := ι) μ) : Prop :=
  Integrable (C.logPlusNormObservable 1) μ
~~~

For a real-valued function, Mathlib's <code>Integrable</code> is absolute
Bochner integrability with respect to the stated measure. Because \(P_1\) is
nonnegative, this asks for a finite integral of its expanding tail. The
measure \(\mu\) may be arbitrary. The definition does not assert
\(\mu(\Omega)=1\), so the integral is not automatically an expectation.

The bundled base map preserves \(\mu\). Every natural iterate therefore also
preserves \(\mu\), and integrability survives pullback:

\[
P_1\text{ integrable}
\quad\Longrightarrow\quad
\omega\mapsto P_1(T^j\omega)\text{ integrable for every }j.
\]

A finite sum of those pullbacks is integrable, so \(S_k\) is integrable.
Finally, measurability and \(0\le P_k\le S_k\) transfer integrability to every
finite-horizon \(P_k\).

## How the Lean interface is layered

The sixteen exported declarations deliberately separate four claims that are
often compressed into one sentence.

First, <code>logPlusNormObservable</code> defines \(P_k\), while
<code>logPlusNormObservable_nonneg</code>,
<code>logPlusNormObservable_zero</code>,
<code>logPlusNormObservable_one</code>, and
<code>measurable_logPlusNormObservable</code> establish its elementary
pointwise and measurable behavior. The finite split theorem
<code>logPlusNormObservable_add_le</code> remains algebraic and pointwise.

Second, <code>orbitLogPlusSum</code> defines \(S_k\). Its zero and successor
theorems fix the indexing convention, and
<code>measurable_orbitLogPlusSum</code> proves the finite sum measurable.
The theorem <code>logPlusNormObservable_le_orbitLogPlusSum</code> is the
pointwise bridge \(P_k\le S_k\). None of these declarations assumes the
generator envelope is integrable.

Third, <code>HasIntegrableGeneratorLogPlus</code> names the missing one-step
hypothesis. It is a proposition attached to a cocycle, not a field silently
inserted into every cocycle and not a conclusion of measure preservation.

Fourth, the three declarations in the
<code>HasIntegrableGeneratorLogPlus</code> namespace propagate that hypothesis
to base iterates, orbit sums, and finally finite-horizon envelopes. This order
makes the proof auditable: transport, finite addition, then domination.

## Three common misreads

**“Zero positive log means no dynamics.”** False. It can mean exact
annihilation, strict contraction, or norm one. The full matrix can still rotate,
project, shear within unit norm, or collapse every vector.

**“An integrable expanding tail gives an integrable logarithm.”** False. The
negative tail has been deleted. A zero matrix is the sharp counterexample:
\(P_k=0\) but \(L_k=\bot\).

**“A preserved measure turns the integral into an expectation.”** False.
Preservation says that pulling an integrable function along the base does not
destroy integrability. Only a separately supplied probability normalization
would justify expectation language.

## A scalar calculation

Consider a one-dimensional cocycle whose four chronological generator norms
are

\[
\frac12,\qquad 3,\qquad \frac14,\qquad 4.
\]

The exact scalar product has norm \(3/2\). Its finite-horizon positive log is

\[
P_4=\log\!\left(\frac32\right).
\]

The orbit envelope discards both contracting factors and gives

\[
S_4
{} =
0+\log 3+0+\log 4
{} =
\log 12.
\]

Therefore \(P_4\le S_4\), with substantial slack. That slack is the price of a
simple nonnegative majorant. The example is algebraic, not an empirical
measurement.

## Empty matrix dimension

When the matrix index type is empty, RMT-14 proves \(N_k=0\) at every horizon.
Because \(\log^+0=0\), RMT-15 proves

\[
P_k(\omega)=0
\]

for every \(k\) and \(\omega\). This also explains why the time-zero identity
\(P_0=0\) needs no <code>Nonempty ι</code> assumption: the inhabited branch
has norm one, while the empty branch has norm zero, and positive log sends both
to zero.

The module does not export a separate empty-dimensional theorem for every
orbit sum or integrability proposition. Those consequences can be derived
from the checked zero observable and general finite-sum facts when needed.

## What this envelope does not establish

The RMT-15 interface does not prove:

- integrability of the RMT-14 <code>EReal</code>-valued extended log norm;
- any estimate for negative logarithmic growth or inverse-matrix norms;
- that cocycle matrices are nonzero, injective, or invertible;
- a probability normalization, expectation, or distributional law;
- ergodicity, mixing, independence, or identical distribution;
- a normalized process such as \(k^{-1}P_k\) or \(k^{-1}L_k\);
- convergence, an almost-sure growth rate, or a deterministic limit;
- Kingman's subadditive ergodic theorem or the Furstenberg-Kesten theorem;
- a Lyapunov exponent, Lyapunov spectrum, or Oseledets splitting;
- a two-sided cocycle or negative-time dynamics; or
- a derivative, tangent-space, or random-Jacobian interpretation.

Most importantly, an integrable \(P_k\) can coexist with complete collapse.
If \(C(k,\omega)=0\), then \(P_k(\omega)=0\) while the extended log norm is
\(\bot\). Positive-tail integrability alone therefore says nothing about the
negative endpoint needed for a full Lyapunov analysis.

## Where to continue

[Finite-Horizon Log-Positive Cocycle Integrability]({{< relref "/knowledge-base/deep-dives/finite-horizon-log-positive-cocycle-integrability" >}})
derives the complete sixteen-declaration Lean layer, including the orbit-sum
recurrence, measure-preserving pullbacks, finite-sum integrability, and the
final domination proof.

[Finite-Time Norm and Extended-Log-Norm Observables for Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/finite-time-norm-and-extended-log-norm-cocycle-observables" >}})
develops the zero-faithful predecessor. The
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycle" >}}
entry supplies the shifted base orbit and product convention.

## References

<a id="ref-log-positive-poslog"></a>**Mathlib contributors.**
[The positive part of the logarithm](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/SpecialFunctions/Log/PosLog.html),
Mathlib 4 documentation. This official source defines <code>Real.posLog</code>,
proves nonnegativity, continuity, monotonicity on nonnegative inputs, and the
two-factor product estimate used by RMT-15.

<a id="ref-log-positive-integrable"></a>**Mathlib contributors.**
[Bochner integrability](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Function/L1Space/Integrable.html),
Mathlib 4 documentation. This official source contains integrability under a
measure-preserving pullback, finite-sum closure, and domination principles.

<a id="ref-log-positive-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source is a later asymptotic destination. The present envelope
supplies only finite-horizon measurability, domination, and integrability.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
