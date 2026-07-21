---
title: "Orbit-majorant centering"
slug: "orbit-majorant-centering"
summary: "Orbit-majorant centering subtracts the additive orbit sum of a process's one-step observable, leaving a shifted-subadditive remainder that is nonpositive at positive horizons, without claiming mean zero or convergence."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveCentering"
og_image: "orbit-majorant-centering-card.png"
og_image_alt: "Warm-paper teaching card showing a finite process minus its one-step orbit sum, producing a shifted-subadditive remainder that is nonpositive at positive horizons. A comparison warns that this operation is not expectation centering and proves no limit theorem."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page must remain a draft until that review is complete.
{{< /panel >}}

**Orbit-majorant centering** is this project's name for subtracting a finite
additive orbit bound from a shifted-subadditive process. If \(X_n(\omega)\) is
the value of a process after \(n\) steps and \(T\) advances the base state, the
operation forms

\[
Y_n(\omega)
{} =
X_n(\omega)
-\sum_{j=0}^{n-1}X_1(T^j\omega).
\]

The subtracted term is the
{{< refterm "birkhoff-sum" "Birkhoff sum" >}} of the one-step observable
\(X_1\). Shifted subadditivity makes that sum a pointwise upper bound at every
positive horizon. Consequently \(Y_n\le0\) for \(n\ne0\), and the family
\(Y_n\) remains shifted-subadditive.

The word **centering** needs care. Nothing here subtracts an expectation, and
nothing here says that \(Y_n\) has mean zero. This is a finite algebraic
reduction used in standard routes toward subadditive ergodic theorems. The
term *orbit-majorant centering* is project-specific terminology chosen to keep
that operation distinct from statistical mean centering
([Karlsson and Margulis](#ref-orbit-centering-karlsson-margulis),
[Lalley](#ref-orbit-centering-lalley)).

{{< reference-figure
  src="orbit-majorant-centering-versus-mean-centering.svg"
  alt="Three labeled operations begin with the same finite process. Orbit-majorant centering subtracts the one-step orbit sum and preserves shifted subadditivity while making positive horizons nonpositive. Expectation centering on a probability base subtracts a scalar mean and targets mean zero, but supplies no pointwise sign or automatic subadditivity. Time normalization divides by the horizon and changes scale without centering."
  caption="**Finding:** orbit-majorant centering, expectation centering, and time normalization answer different questions. RMT-19 formalizes only the first operation. Its output is pointwise nonpositive at positive horizons and remains shifted-subadditive. The plate does not assert mean zero, convergence, a Birkhoff theorem, or a subadditive ergodic theorem."
>}}

## The operational definition

Let \(\Omega\) be a state space, let \(T:\Omega\to\Omega\) be a self-map, and
let \(X:\mathbb N\to\Omega\to\mathbb R\) be a real-valued finite-time process.
Mathlib defines the length-\(n\) Birkhoff sum of an observable \(f\) by

\[
\operatorname{BSum}(T,f,n,\omega)
{} =
\sum_{\substack{j\in\mathbb N\\j\lt n}}f(T^j\omega).
\]

The RMT-19 definition specializes \(f\) to \(X_1\):

\[
\operatorname{Center}(T,X,n,\omega)
{} =
X_n(\omega)-\operatorname{BSum}(T,X_1,n,\omega).
\]

Lean writes the same construction as
<code>centeredProcess T X n ω</code>. The definition needs no measurable
space, measure, probability law, or dynamical hypothesis. It subtracts two
real numbers at one sample and one finite horizon. Mathlib's finite-sum
definition, empty-sum law, successor laws, and addition law are the exact
upstream algebra used here
([official documentation](#ref-orbit-centering-mathlib-basic),
[pinned source](#ref-orbit-centering-mathlib-basic-pinned)).

There is also an exact unnormalized identity, true simply by rearranging the
definition:

\[
X_n(\omega)
{} =
Y_n(\omega)+\operatorname{BSum}(T,X_1,n,\omega).
\]

Calling the second term a **majorant** records an additional theorem, not a
feature of subtraction alone. That theorem comes from the shifted-subadditive
law

\[
X_{m+n}(\omega)
\le
X_n(T^m\omega)+X_m(\omega).
\]

Repeatedly split off one step. For positive \(n\), the resulting terms are
\(X_1(\omega),X_1(T\omega),\ldots,X_1(T^{n-1}\omega)\), so

\[
X_n(\omega)
\le
\operatorname{BSum}(T,X_1,n,\omega).
\]

Subtracting the right side gives \(Y_n(\omega)\le0\). This deduction is
pointwise. Integrability stored in the project's process-candidate structure
is not consumed by the inequality.

## Three operations that should not share a conclusion

Orbit-majorant centering is easy to misread because two familiar operations
also alter the location or scale of a quantity.

| Operation | What is removed or changed | Intended result | What does not follow automatically |
|---|---|---|---|
| orbit-majorant centering | the sample-dependent finite orbit sum of \(X_1\) | a shifted-subadditive remainder, nonpositive at positive horizons and uniformly so when \(X_0=0\) | mean zero or convergence |
| expectation centering | a scalar such as \(\mathbb E[X_n]\) | zero expectation on a probability space, when the expectation exists | pointwise nonpositivity or preservation of subadditivity |
| time normalization | division by the horizon \(n\) | a per-step scale | centering, a sign, or existence of a limit |

Expectation centering is measure-theoretic. It needs a probability measure and
enough integrability for the expectation to be meaningful. Even then,
\(X_n-\mathbb E[X_n]\) generally takes both signs. Subtracting expectations
also does not automatically preserve the original pointwise subadditive
inequality: the inequality between expectations has the wrong logical form
to justify subtracting a different scalar from each horizon.

Orbit-majorant centering is samplewise instead. The amount removed depends on
\(\omega\) through the orbit. Its useful properties come from an exact additive
cocycle law for that orbit sum. It may have a nonzero, negative, or undefined
expectation, depending on the surrounding analytic assumptions.

Time normalization changes scale rather than origin. For \(n\gt0\), it forms
\(X_n/n\). A sequence can be nonpositive without its normalized values
converging, and it can have normalized convergence without being centered in
either sense. Lean's division on real numbers is total, so the expression at
\(n=0\) exists, but totalization is not evidence about a dynamical limit.

## The two boundary times

The empty Birkhoff sum is zero. Therefore

\[
Y_0(\omega)=X_0(\omega).
\]

Shifted subadditivity at \(m=n=0\) implies only

\[
X_0(\omega)\le X_0(\omega)+X_0(\omega),
\]

which forces \(X_0(\omega)\ge0\). It does not force \(X_0=0\). Thus the
positive-horizon statement \(Y_n\le0\) needs no time-zero assumption, while a
single theorem covering every \(n\in\mathbb N\) needs the exact normalization
\(X_0=0\).

The constant-one process exposes the obstruction. Put \(X_n(\omega)=1\) for
every \(n\) and \(\omega\). It satisfies \(1\le1+1\), hence it is
shifted-subadditive, but \(Y_0=1\). No assumption-free theorem can conclude
that the centered process is nonpositive at time zero.

At one step, the opposite simplification occurs:

\[
Y_1(\omega)
{} =
X_1(\omega)-X_1(\omega)
{} =0.
\]

This identity is unconditional. It follows from the one-term Birkhoff-sum
law, not from integrability or normalization. The Lean lemmas
<code>centeredProcess_zero</code> and <code>centeredProcess_one</code> preserve
both boundaries as visible API facts.

## Why shifted subadditivity survives

The finite orbit sum is additive across a split:

\[
\begin{aligned}
\operatorname{BSum}(T,X_1,m+n,\omega)
&=\operatorname{BSum}(T,X_1,m,\omega) \\
&\quad+\operatorname{BSum}(T,X_1,n,T^m\omega).
\end{aligned}
\]

Subtract this equality from the shifted-subadditive inequality for \(X\). The
terms align exactly, giving

\[
Y_{m+n}(\omega)
\le
Y_n(T^m\omega)+Y_m(\omega).
\]

There is no limiting argument here. The proof uses
<code>birkhoffSum_add</code> and ordered-ring arithmetic. In particular, it
does not need \(X_0=0\): if a candidate begins with a positive \(X_0\), its
centered family retains that value and still satisfies the shifted law.

This preservation property is the real reason to subtract an **additive**
orbit object. An arbitrary upper bound could make \(Y_n\le0\) while destroying
the split identity needed by later subadditive arguments.

## When the centered family is integrable

Suppose each \(X_n\) is integrable with respect to a measure \(\mu\), and
suppose \(T\) preserves \(\mu\). Every iterate \(T^j\) then preserves the same
measure. Integrability of \(X_1\) transports to
\(\omega\mapsto X_1(T^j\omega)\), and a finite sum of those terms is
integrable. Finally, the difference of two integrable real functions is
integrable.

RMT-19 packages this route in
<code>integrable_centeredProcess</code> and
<code>centeredProcess_candidate</code>. The latter says that centering returns
another integrable shifted-subadditive-process candidate. Measure preservation
is used for this analytic package, not for the pointwise definition,
nonpositivity, or shifted inequality. Probability normalization and
ergodicity are unnecessary throughout this finite step
([measure-preserving iterates](#ref-orbit-centering-mathlib-preserving),
[integrability transport](#ref-orbit-centering-mathlib-integrable)).

Without a suitable condition on \(T\), composition can destroy measurability
or integrability. Storing integrability of \(X_1\) alone does not certify the
orbit terms \(X_1\circ T^j\). The explicit preservation premise records the
actual bridge used by the proof.

## An assumption ledger for the construction

The operation is easiest to reuse when each conclusion is paired with the
smallest premise that produces it. The RMT-19 API deliberately does not bundle
all assumptions into one theorem.

| Conclusion | Premise actually doing the work | Premises not needed |
|---|---|---|
| define \(Y_n\) | two real-valued finite functions at the chosen horizon | measurability, a measure, preservation, probability, ergodicity |
| \(Y_n\le0\) for \(n\ne0\) | shifted subadditivity | \(X_0=0\), integrability, preservation |
| \(Y_n\le0\) for every \(n\) | shifted subadditivity and \(X_0=0\) | probability and ergodicity |
| shifted subadditivity of \(Y\) | shifted subadditivity of \(X\) and the finite addition law | time-zero normalization and every measure-theoretic premise |
| integrability of each \(Y_n\) | integrability of \(X_n\) and preservation by \(T\) | probability and ergodicity |
| normalized decomposition | real arithmetic and the definition of Birkhoff average | every process or measure hypothesis |

This table explains why the pure definition lives outside the process-candidate
namespace, while the methods that use integrability live on the checked
candidate. It also explains the two cocycle routes. A bare cocycle already
supplies the pointwise shifted inequality and the exact zero-time identity, so
its centered process is nonpositive and subadditive without an integrability
package. The hypothesis <code>HasIntegrableGeneratorLogPlus</code> is introduced
only when the result itself promises an integrable candidate.

The word **majorant** also has a narrow scope. It says
\(X_n(\omega)\le\operatorname{BSum}(T,X_1,n,\omega)\) at the same sample and
horizon. It does not say that the two sides are close, that their difference
is bounded below, or that the orbit sum is the least possible upper bound. In
the square-root example below, the gap grows from zero to a negative remainder
of increasing magnitude. In an additive process, by contrast, the gap is
identically zero. Both behaviors satisfy the same RMT-19 interface.

Nor should the centered term be called noise or an error term without extra
structure. It is an exact algebraic remainder. Whether it is negligible after
time normalization is a new asymptotic question, not part of the definition.

## The exact normalized identity

Mathlib defines the Birkhoff average as the finite Birkhoff sum multiplied by
the inverse of the horizon. For real-valued observables,

\[
\operatorname{BAvg}(T,X_1,n,\omega)
{} =
\frac{1}{n}\operatorname{BSum}(T,X_1,n,\omega).
\]

Dividing the unnormalized decomposition by \(n\) gives RMT-19's exact identity

\[
\frac{X_n(\omega)}{n}
{} =
\frac{Y_n(\omega)}{n}
{} +
\operatorname{BAvg}(T,X_1,n,\omega).
\]

Lean proves this for every natural \(n\), with no measurability or dynamical
assumptions. At \(n=0\), real division by zero is totalized to zero and
Mathlib's zero-time Birkhoff average is also zero
([pinned average definition](#ref-orbit-centering-mathlib-average)). The
identity therefore reduces to \(0=0\). It does **not** recover \(X_0\), imply
\(X_0=0\), or license division by zero in informal field algebra.

For positive \(n\), the equation genuinely decomposes the normalized process
into a normalized nonpositive remainder and an additive orbit average. It
still says nothing about whether either term converges as \(n\to\infty\).
Birkhoff convergence is a separate theorem with measure-theoretic hypotheses;
the pinned Mathlib file imported here supplies the finite average definition,
not such a pointwise ergodic theorem.

## Worked singleton example: square-root growth

Take the one-point state space \(\Omega=\{\star\}\), let \(T\) be the identity,
and define

\[
X_n(\star)=\sqrt n.
\]

This process has \(X_0=0\) and \(X_1=1\). It is subadditive because, for
natural \(m,n\), both sides are nonnegative and

\[
(\sqrt m+\sqrt n)^2
{} =m+n+2\sqrt{mn}
\ge m+n.
\]

The one-step observable is constantly one. Since the base orbit never leaves
the singleton, its length-\(n\) Birkhoff sum is exactly \(n\). The centered
process is therefore

\[
Y_n(\star)=\sqrt n-n.
\]

The two boundary times are visible: \(Y_0=0\) and \(Y_1=0\). At \(n=4\),

\[
X_4=2,
\qquad
\operatorname{BSum}(T,X_1,4,\star)=4,
\qquad
Y_4=-2.
\]

The normalized identity becomes an arithmetic check:

\[
\frac{X_4}{4}
{} =\frac12
{} =-\frac12+1
{} =\frac{Y_4}{4}
  +\operatorname{BAvg}(T,X_1,4,\star).
\]

This example distinguishes all three operations. Orbit-majorant centering
subtracts \(n\), so the value at four becomes \(-2\). Expectation centering on
the one-point probability space would subtract \(X_4=2\), so the value would
be zero. Time normalization divides \(X_4\) by four, so the value becomes
\(1/2\). These outputs answer different questions even in the simplest
deterministic system.

The explicit formula happens to have elementary asymptotic behavior. That is
a property of this chosen example, not a conclusion of the RMT-19 interface.

## Matrix-cocycle specialization

For a discrete matrix cocycle \(C\), the process being centered is the
finite-time log-positive norm observable. Its one-step Birkhoff sum is
definitionally the previously constructed <code>orbitLogPlusSum</code>. RMT-19
defines <code>centeredLogPlusNormObservable</code> by the generic operation and
proves

\[
\begin{aligned}
&C.\operatorname{centeredLogPlusNormObservable}(n,\omega) \\
&\quad={}
C.\operatorname{logPlusNormObservable}(n,\omega)
-C.\operatorname{orbitLogPlusSum}(n,\omega).
\end{aligned}
\]

The existing pointwise orbit-sum majorant proves nonpositivity, including
time zero because the cocycle log-positive observable already vanishes there.
The centered cocycle process remains shifted-subadditive without the
one-step integrability hypothesis. Only the candidate-packaging theorem uses
<code>HasIntegrableGeneratorLogPlus</code>.

This is still a log-positive envelope. It records expansion above norm one
and does not reconstruct contraction erased by the positive logarithm. A
centered log-positive remainder is not a signed Lyapunov exponent.

## Lean landmarks

The following commands expose the generic and cocycle interfaces in source
order:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.SubadditiveCentering

open NonlinearDynamics.Random.RandomCocycles

#check centeredProcess
#check centeredProcess_zero
#check centeredProcess_one
#check IsIntegrableSubadditiveProcessCandidate.oneStepBirkhoffMajorant_of_ne_zero
#check IsIntegrableSubadditiveProcessCandidate.oneStepBirkhoffMajorant
#check IsIntegrableSubadditiveProcessCandidate.centeredProcess_nonpos_of_ne_zero
#check IsIntegrableSubadditiveProcessCandidate.centeredProcess_nonpos
#check IsIntegrableSubadditiveProcessCandidate.centeredProcess_add_le
#check IsIntegrableSubadditiveProcessCandidate.integrable_centeredProcess
#check IsIntegrableSubadditiveProcessCandidate.centeredProcess_candidate
#check normalized_eq_centered_add_birkhoffAverage
#check DiscreteMatrixCocycle.centeredLogPlusNormObservable
#check DiscreteMatrixCocycle.centeredLogPlusNormObservable_nonpos
#check DiscreteMatrixCocycle.centeredLogPlusNormObservable_add_le
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.centeredLogPlusNormObservable_candidate
#check DiscreteMatrixCocycle.logPlusNormObservable_normalized_eq_centered_add_birkhoffAverage
~~~

The theorem names encode the boundary. The suffix
<code>of_ne_zero</code> excludes only the zero horizon. The unsuffixed majorant
and nonpositivity theorem ask for \(X_0=0\). Names containing
<code>integrable</code> or <code>candidate</code> are the only generic centering
results that require measure preservation.

## What this term does not claim

Orbit-majorant centering proves a finite decomposition, a positive-horizon
pointwise upper bound, preservation of shifted subadditivity, and conditional
finite-horizon integrability. It does not prove or imply:

- expectation centering or zero mean;
- a lower bound on the centered process;
- a bound on its absolute value or negative tail;
- uniform integrability over the horizon;
- convergence pointwise, almost everywhere, in probability, in distribution,
  or in \(L^1\);
- convergence of the Birkhoff averages in the normalized identity;
- Birkhoff's pointwise ergodic theorem or a mean ergodic theorem;
- Kingman's subadditive ergodic theorem or a maximal inequality;
- invariance or almost-everywhere constancy of a limiting field;
- equality between a samplewise limit and an integrated Fekete rate;
- permission to exchange a limit and an integral;
- probability normalization, ergodicity, independence, mixing, or decay of
  correlations;
- a signed logarithmic growth rate, Lyapunov exponent, or Oseledets splitting;
  or
- recovery of contraction discarded by the log-positive observable.

Standard proofs use the same subtractive reduction as one ingredient before
later applications of Birkhoff or Kingman
([Karlsson and Margulis](#ref-orbit-centering-karlsson-margulis),
[Lalley](#ref-orbit-centering-lalley)). RMT-19 deliberately freezes only the
finite ingredient. Kingman's original theorem is cited for the asymptotic
destination, not as evidence that the present Lean module has reached it
([Kingman, 1968](#ref-orbit-centering-kingman)).

## Where to continue

The
{{< refterm "birkhoff-sum" "Birkhoff sum" >}}
entry develops the finite orbit-sum definition, successor and addition laws,
powered-map sampling, and the zero-count boundary used here.

The
[Development Notebook]({{< relref "/development-notebook/2026/07/orbit-majorant-centering-for-subadditive-cocycles" >}})
maps every declaration to its checked Lean proof. The
[full Deep Dive]({{< relref "/knowledge-base/deep-dives/orbit-majorant-centering-for-subadditive-processes" >}})
places the same reduction inside the longer route toward subadditive ergodic
infrastructure. Both remain separate from this compact definition layer.

## References

<a id="ref-orbit-centering-mathlib-basic"></a>**Mathlib contributors.**
[Birkhoff sums](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Basic.html),
Mathlib 4 documentation. This official page defines the finite orbit sum and
states its zero, one, successor, and addition laws.

<a id="ref-orbit-centering-mathlib-basic-pinned"></a>**Mathlib contributors.**
[Pinned Birkhoff-sum source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Basic.lean#L30-L57),
Mathlib commit <code>81a5d257</code>. These exact lines define
<code>birkhoffSum</code> and prove the finite identities consumed by RMT-19.

<a id="ref-orbit-centering-mathlib-average"></a>**Mathlib contributors.**
[Pinned Birkhoff-average source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Average.lean#L34-L55),
Mathlib commit <code>81a5d257</code>. The source defines normalization by the
inverse natural-number cast and proves that the zero-time average is zero.

<a id="ref-orbit-centering-mathlib-preserving"></a>**Mathlib contributors.**
[Measure-preserving iterates at the pinned revision](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/MeasurePreserving.lean#L191-L196),
Mathlib commit <code>81a5d257</code>. The theorem shows that every natural
iterate of a measure-preserving self-map preserves the same measure.

<a id="ref-orbit-centering-mathlib-integrable"></a>**Mathlib contributors.**
[Integrability transport at the pinned revision](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/L1Space/Integrable.lean#L381-L390),
Mathlib commit <code>81a5d257</code>. The theorem transports an integrable
observable through a measure-preserving map.

<a id="ref-orbit-centering-karlsson-margulis"></a>**Anders Karlsson and Gregory A. Margulis.**
[A Multiplicative Ergodic Theorem and Nonpositively Curved Spaces](https://www.unige.ch/math/folks/karlsson/kama.pdf),
*Communications in Mathematical Physics* 208(1), 107-123, 1999,
[doi:10.1007/s002200050750](https://doi.org/10.1007/s002200050750).
On printed page 117, the proof subtracts the additive one-step orbit cocycle
from a general subadditive cocycle and reduces to a nonpositive subadditive
cocycle. The paper's later ergodic conclusions are not imported into RMT-19.

<a id="ref-orbit-centering-lalley"></a>**Steven P. Lalley.**
[Kingman's Subadditive Ergodic Theorem](https://galton.uchicago.edu/~lalley/Courses/Graz/Kingman.pdf),
lecture notes, 3 pages, accessed 2026-07-21. Page 1 writes the same one-step
subtractive reduction explicitly and then uses Birkhoff's theorem only in the
later asymptotic argument.

<a id="ref-orbit-centering-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source establishes the subadditive ergodic theory that motivates
the finite reduction. RMT-19 does not formalize Kingman's convergence theorem.

The exact upstream Mathlib revision audited for this entry is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the v4.32.0 revision pinned by <code>formalization/lake-manifest.json</code>.
