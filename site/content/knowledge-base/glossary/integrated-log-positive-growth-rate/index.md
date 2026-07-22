---
title: "Integrated log-positive growth rate"
slug: "integrated-log-positive-growth-rate"
summary: "Under an explicit one-step integrability hypothesis, the integrated log-positive growth rate is the deterministic Fekete limit obtained by integrating each finite cocycle expansion envelope against a preserved raw measure and then normalizing over positive time."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.IntegratedLogPlusGrowth"
og_image: "integrated-log-positive-growth-rate-card.png"
og_image_alt: "A five-stage teaching diagram moves from a finite state-dependent positive-log envelope through raw-measure integration certified by explicit one-step integrability, scalar subadditivity, positive-time normalization, and a deterministic Fekete limit. A separate warning says that no samplewise or Lyapunov limit is proved."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page must remain a draft until that review is complete.
{{< /panel >}}

An **integrated log-positive growth rate** is a deterministic asymptotic rate
built from a matrix cocycle by integrating before taking a limit. For the
finite-horizon positive-log envelope

\[
P_k(\omega)
{} =
\log^+\lVert C(k,\omega)\rVert_\infty,
\]

RMT-16 defines the scalar sequence

\[
I_k=\int_\Omega P_k(\omega)\,d\mu(\omega)
\]

and, under the explicit one-step integrability hypothesis from RMT-15, proves

\[
I_{m+k}\le I_m+I_k.
\]

Mathlib's deterministic Fekete theorem then supplies

\[
\gamma_\mu^+(C)
{} =
\lim_{k\to\infty}\frac{I_k}{k}
{} =
\inf_{k\ge 1}\frac{I_k}{k}.
\]

The notation \(\gamma_\mu^+(C)\) is explanatory prose. Lean calls the value
<code>integratedLogPlusGrowthRate C hC</code>, where <code>hC</code> records
one-step positive-log integrability.

{{< reference-figure
  src="integrated-log-positive-growth-rate.svg"
  alt="The checked route begins with a finite state-dependent positive-log envelope, integrates it against a preserved raw measure, obtains a subadditive sequence of real numbers, divides only at positive horizons, and reaches a deterministic Fekete limit. Time zero is shown separately as a formal boundary value. A rejected side route says that samplewise normalization and a samplewise limit are not established."
  caption="**Finding:** RMT-16 integrates the finite-horizon envelope before normalization, so Fekete acts on one subadditive sequence of real numbers. Its infimum uses positive horizons only. The diagram deliberately separates the unproved samplewise route and makes no expectation, ergodic, limit-interchange, or Lyapunov claim."
>}}

## Three objects that must not be merged

| Object | Lean expression | Type | Dependence |
|---|---|---|---|
| Finite envelope \(P_k(\omega)\) | <code>C.logPlusNormObservable k ω</code> | \(\mathbb R\) | Horizon and base point |
| Integrated value \(I_k\) | <code>C.integratedLogPlusNorm k</code> | \(\mathbb R\) | Horizon only |
| Normalized value \(A_k\) | <code>C.normalizedIntegratedLogPlusNorm k</code> | \(\mathbb R\) | Horizon only |

The theorem follows the top-to-bottom direction in this table. It first
removes \(\omega\) by integration, then studies the numerical sequence
\(I_k/k\). It does not fix \(\omega\) and study \(P_k(\omega)/k\).

## The totalized-integral warning

Mathlib's real-valued Bochner integral is a total function. If its integrand
is not integrable, the integral is defined to be zero. This convention is
recorded by <code>MeasureTheory.integral_undef</code>.

Consequently, <code>integratedLogPlusNorm</code> can be defined for every
cocycle and every horizon without an integrability premise. Its codomain
\(\mathbb R\) does not by itself certify a finite analytic moment. Likewise,
the unconditional theorem \(0\le I_k\) can reduce to the harmless fact
\(0\le0\) in a nonintegrable case.

{{< panel "warning" >}}
**A defined real integral is not an integrability theorem.** Only after
<code>HasIntegrableGeneratorLogPlus</code> propagates integrability from the
one-step envelope to every finite horizon may \(I_k\) be read as a meaningful
finite integral. The shifted-pullback equality itself is unconditional, but it
can be a vacuous equality between totalized zeros outside that integrable
regime. The finite bounds, subadditivity, rate, and convergence all retain the
explicit hypothesis.
{{< /panel >}}

For example, on an infinite-measure space the constant function one need not
be integrable. Mathlib still assigns its totalized Bochner integral the real
value zero. Calling that value a finite growth moment would hide the failed
hypothesis.

## How the shift disappears

RMT-15 supplies the pointwise cocycle estimate

\[
P_{m+k}(\omega)
\le
P_k(T^m\omega)+P_m(\omega).
\]

The later block really begins at \(T^m\omega\), so the shift cannot be erased
pointwise. Every natural iterate of \(T\) preserves \(\mu\), however. Ordinary
measurability, the mapped-measure equality, and Mathlib's totalized integral
make the pullback identity unconditional:

\[
\int_\Omega P_k(T^m\omega)\,d\mu(\omega)
{} =
\int_\Omega P_k(\omega)\,d\mu(\omega)
{} =
I_k.
\]

Without integrability, both sides of this identity may only be totalized zeros.
Under <code>hC</code>, the finite envelopes are integrable, so integrating the
pointwise estimate legitimately gives \(I_{m+k}\le I_m+I_k\). Preservation has
identified shifted integrals. It has not created integrability, probability,
independence, identical distribution, or ergodicity.

The finite orbit-sum majorant from RMT-15 also integrates exactly:

\[
S_k(\omega)
{} =
\sum_{j=0}^{k-1}P_1(T^j\omega),
\qquad
\int_\Omega S_k\,d\mu=kI_1.
\]

Since \(P_k\le S_k\), RMT-16 obtains \(I_k\le kI_1\). Neither equality nor
inequality needs independent orbit terms.

## Time zero is a boundary convention

Lean defines

\[
A_k=\frac{I_k}{(k:\mathbb R)}
\]

for every natural \(k\). At time zero, \(I_0=0\) and real division is total,
so \(A_0=0/0=0\). This is a formal boundary value, not growth per zero units
of time.

Mathlib avoids that interpretation in its definition of the Fekete rate:

~~~lean
sInf ((fun n : ℕ => u n / n) '' Set.Ici 1)
~~~

Thus the infimum ranges over \(k\ge1\). It is not the infimum of the entire
range of \(A\). That difference can change the answer: because \(A_0=0\) and
every \(A_k\ge0\), the infimum of the full range would always be zero, even
when every positive-time ratio equals a positive constant.

Fekete convergence also does not say that the ratios decrease monotonically.
A subadditive sequence can have fluctuating normalized values. The result is
an infimum, not necessarily a minimum attained at one horizon.

## Raw measure is not expectation

The cocycle is parameterized by a raw measure \(\mu\). Its structure contains
no probability assumption, no finite-mass hypothesis, and no division by
\(\mu(\Omega)\). Therefore \(I_k\) is an integral, not automatically an
expectation, and \(I_k/k\) is normalized in time only.

Finite scalar rescaling makes the distinction visible. If a finite
nonnegative scalar \(c\) is used to repackage the same cocycle over
\(c\mu\), then Mathlib's measure-scaling and integral-scaling APIs imply that
the integrated values, normalized values, and resulting rate scale by \(c\),
provided the corresponding integrability conditions are handled. For
\(c\gt0\), integrability is equivalent before and after rescaling. For
\(c=0\), every integral vanishes and the rescaled measure makes every function
integrable. Scaling by an infinite extended scalar is outside this statement.

This finite-rescaling observation is an upstream consequence, not one of the
thirteen exported RMT-16 declarations. Avoid the broader phrase “scales with
total measure,” especially when \(\mu(\Omega)=\infty\).

Expectation language becomes justified only after separately establishing
that the measure has mass one. Even then, RMT-16 gives a limit of expectations
of positive envelopes, not an expectation of a proved samplewise limit.

## A one-point calculation

Take a one-point base whose raw measure has finite, strictly positive mass
\(q\), and take a
constant one-dimensional generator \(\lambda\gt1\). Then

\[
P_k=k\log\lambda,
\qquad
I_k=qk\log\lambda,
\qquad
A_k=q\log\lambda
\quad(k\ge1).
\]

Hence

\[
\gamma_\mu^+(C)=q\log\lambda.
\]

Doubling \(q\) doubles the integrated rate without changing the dynamics.
The example also isolates the time-zero trap: \(A_0=0\), but the positive-time
infimum is \(q\log\lambda\), which is strictly positive.

If instead \(0\lt\lambda\lt1\), every positive-log envelope is zero and the
RMT-16 rate is zero, while the ordinary logarithmic growth rate
\(\log\lambda\) is negative. Positive clipping has erased contraction.

A sharper collapse example uses the constant matrix

\[
B=
\begin{bmatrix}
0&2\\
0&0
\end{bmatrix}.
\]

Its selected row-sum norm is two, but \(B^2=0\). The one-step envelope is
\(\log2\), every envelope from time two onward is zero, and the integrated
log-positive growth rate is zero. One-step expansion and later exact collapse
are both compatible with a zero RMT-16 rate.

These are algebraic teaching examples, not empirical random-matrix data.

## The thirteen-declaration interface

RMT-16 exports the following declarations in source order:

| No. | Declaration | Exact role |
|---:|---|---|
| 1 | <code>integratedLogPlusNorm</code> | Defines the totalized scalar integral \(I_k\) without an integrability premise |
| 2 | <code>integratedLogPlusNorm_zero</code> | Proves \(I_0=0\) unconditionally |
| 3 | <code>integratedLogPlusNorm_nonneg</code> | Proves \(0\le I_k\) unconditionally, without proving integrability |
| 4 | <code>integral_logPlusNormObservable_at_base_iterate_eq</code> | Removes any natural base iterate inside the totalized integral unconditionally; the identity may be \(0=0\) without integrability |
| 5 | <code>HasIntegrableGeneratorLogPlus.integral_orbitLogPlusSum_eq</code> | Proves \(\int S_k\,d\mu=kI_1\) |
| 6 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusNorm_le_nat_mul</code> | Proves \(I_k\le kI_1\) |
| 7 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusNorm_add_le</code> | Proves \(I_{m+k}\le I_m+I_k\) |
| 8 | <code>HasIntegrableGeneratorLogPlus.subadditive_integratedLogPlusNorm</code> | Packages \(I\) as a Mathlib <code>Subadditive</code> sequence |
| 9 | <code>normalizedIntegratedLogPlusNorm</code> | Defines \(A_k=I_k/k\) for every natural \(k\) |
| 10 | <code>normalizedIntegratedLogPlusNorm_nonneg</code> | Proves \(0\le A_k\) unconditionally |
| 11 | <code>bddBelow_normalizedIntegratedLogPlusNorm</code> | Uses zero as a lower bound for the full normalized range |
| 12 | <code>integratedLogPlusGrowthRate</code> | Defines the positive-index Fekete infimum under <code>hC</code> |
| 13 | <code>HasIntegrableGeneratorLogPlus.tendsto_normalizedIntegratedLogPlusNorm</code> | Proves deterministic scalar convergence \(A_k\to\gamma_\mu^+(C)\) |

Declarations 1, 2, 3, 4, 9, 10, and 11 are unconditional. Their total
definitions, order properties, and preserved-pullback equality must not be
mistaken for an integrability result. The finite orbit-sum identity, bounds,
subadditivity, rate definition, and convergence all use
<code>HasIntegrableGeneratorLogPlus</code>.

## What this rate does not establish

RMT-16 proves none of the following:

- convergence of \(P_k(\omega)/k\) for any fixed \(\omega\);
- almost-everywhere, in-probability, distributional, or \(L^1\) convergence;
- interchange of a limit and the integral;
- probability normalization, stationarity in a probabilistic sense, or an
  expected samplewise limit;
- ergodicity, mixing, independence, or identical distribution;
- Kingman's subadditive ergodic theorem;
- the Furstenberg-Kesten theorem;
- a Lyapunov exponent, spectrum, filtration, or Oseledets splitting;
- contraction, inverse-norm, smallest-singular-value, or negative-log control;
- integrability or convergence for the zero-faithful extended log norm; or
- a derivative cocycle, random Jacobian, or two-sided dynamics.

The checked conclusion is narrower and exact: the sequence of integrated
positive-growth envelopes, normalized by time, converges as a deterministic
sequence of real numbers.

## Where to continue

RMT-34's
[Forward-and-Inverse Tail Sandwich]({{< relref "/knowledge-base/deep-dives/forward-and-inverse-tail-sandwich-for-finite-time-real-log-norms" >}})
adds a precisely guarded real-log endpoint. When this deterministic
log-positive rate is strictly positive, RMT-33 convergence forces the
finite-time unclipped logarithm to become positive eventually, so the
normalized real log converges almost everywhere to the same rate. The theorem
does not require matrix invertibility or an inverse-tail moment. It says
nothing about a zero or negative signed rate, and its empty-dimensional
specialization is vacuous because the present rate is then zero.

The
{{< refterm "ergodic-probability-base" "ergodic probability base" >}}
entry separates the unit-mass, invariant-rigidity, and finite-time
integrability roles that the present raw-measure rate intentionally leaves
apart.

[Probability Normalization and Ergodic Rigidity Before Kingman]({{< relref "/knowledge-base/deep-dives/probability-normalization-and-ergodic-rigidity-before-kingman" >}})
develops that next interface and explains why it still does not construct a
samplewise limit.

[Integrated Log-Positive Cocycle Growth and Its Deterministic Fekete Limit]({{< relref "/knowledge-base/deep-dives/integrated-log-positive-cocycle-growth-and-fekete-limit" >}})
derives all thirteen declarations, explains the two proof strands entering
Fekete's theorem, and audits every assumption and nonclaim.

[The Guarded Real-Liminf Bridge to Log-Positive Kingman Convergence]({{< relref "/knowledge-base/deep-dives/guarded-real-liminf-bridge-to-log-positive-kingman-convergence" >}})
shows how a later milestone proves that the samplewise normalized log-positive
observable converges almost everywhere to this already-defined deterministic
rate. That theorem adds substantial ergodic and lower-deviation hypotheses; it
does not turn any RMT-16 declaration into a samplewise or signed-growth claim.

[Finite-Horizon Log-Positive Cocycle Integrability]({{< relref "/knowledge-base/deep-dives/finite-horizon-log-positive-cocycle-integrability" >}})
develops the RMT-15 predecessor. The
{{< refterm "log-positive-integrability-envelope" "log-positive integrability envelope" >}}
entry explains the positive-log clipping and finite orbit majorant on which the
present rate depends.

## References

<a id="ref-integrated-growth-subadditive"></a>**Mathlib contributors.**
[Subadditive and superadditive sequences](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Subadditive.html),
Mathlib 4 documentation. This official source defines
<code>Subadditive.lim</code> by a positive-index infimum and proves convergence
of the normalized sequence under a lower-bound hypothesis.

<a id="ref-integrated-growth-bochner"></a>**Mathlib contributors.**
[The Bochner integral](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Integral/Bochner/Basic.html),
Mathlib 4 documentation. This official source records totalization for
nonintegrable functions and supplies integral monotonicity, finite linearity,
pullback, and finite measure-scaling results used by this layer.

<a id="ref-integrated-growth-preserving"></a>**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation. This official source gives pushforward equality,
natural-iterate preservation, and preservation after finite scalar measure
rescaling.

<a id="ref-integrated-growth-fekete"></a>**M. Fekete.**
[Über die Verteilung der Wurzeln bei gewissen algebraischen Gleichungen mit ganzzahligen Koeffizienten](https://doi.org/10.1007/BF01504345),
*Mathematische Zeitschrift* 17, 228-249, 1923. This is the historical primary
source associated with the deterministic subadditive lemma.

<a id="ref-integrated-growth-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source establishes a later stochastic theorem under additional
hypotheses. RMT-16 does not invoke it.

<a id="ref-integrated-growth-furstenberg-kesten"></a>**Harry Furstenberg and Harry Kesten.**
[Products of Random Matrices](https://doi.org/10.1214/aoms/1177705909),
*The Annals of Mathematical Statistics* 31(2), 457-469, 1960. This primary
source motivates asymptotic random-matrix-product growth; none of its
samplewise conclusions is proved here.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
