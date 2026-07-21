---
title: "Orbit-Majorant Centering for Subadditive Processes"
slug: "orbit-majorant-centering-for-subadditive-processes"
date: 2026-07-21
summary: "A textbook treatment of subtracting the additive one-step orbit majorant from a subadditive process, preserving subadditivity and, under one-step measure preservation, finite-horizon integrability."
lead: "At every positive horizon, a subadditive process never exceeds the sum of its one-step costs along the orbit. Subtract that majorant and the residual is nonpositive, uniformly including time zero when the process starts exactly at zero. The split is finite algebra, not expectation centering or a limit theorem."
draft: true
pro_reviewed: false
level: "Finite Birkhoff sums, shifted subadditivity, measure preservation, integrability, normalized finite-time identities, and one-sided discrete matrix cocycles"
reading_time: "125 to 170 minutes"
prerequisites: "Natural-number induction, real inequalities, finite sums, function iterates, integrable functions, measure-preserving maps, and the log-positive norm observable; no ergodic theorem is assumed"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveCentering"
toc: true
og_image: "orbit-majorant-centering-for-subadditive-processes-card.png"
og_image_alt: "A finite process value has its additive one-step orbit sum subtracted, leaving a centered residual labeled nonpositive after time zero. A warning says the exact split does not prove convergence."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The mathematics,
Lean declaration map, sources, figures, and accessibility have not yet passed
the required human and Pro reviews. The page remains a draft until those gates
are complete.
{{< /panel >}}

The word *centering* usually suggests subtracting an expectation. That is not
the operation in this chapter. No mean is computed, no probability measure is
required, and the result is not asserted to have mean zero. We instead
subtract a pointwise additive upper bound built from the one-step observable
along the orbit. The operation is better read as **orbit-majorant
compensation**.

Fix a space of outcomes \(\Omega\), a self-map \(T:\Omega\to\Omega\), and a
real-valued process \(X_n(\omega)\), where \(n\in\mathbb N\) is a finite
horizon and \(\omega\in\Omega\) is the initial outcome. Suppose the process is
shifted-subadditive:

\[
X_{m+n}(\omega)
\le
X_n(T^m\omega)+X_m(\omega).
\]

The one-step orbit sum is

\[
A_n(\omega)
{} =
\sum_{j=0}^{n-1} X_1(T^j\omega).
\]

The centered residual is

\[
Y_n(\omega)
{} =
X_n(\omega)-A_n(\omega).
\]

Repeated subadditivity gives \(X_n(\omega)\le A_n(\omega)\) for every positive
horizon. Thus \(Y_n(\omega)\le0\) when \(n\ne0\). If the process also satisfies
the exact normalization \(X_0=0\), the same statement holds uniformly at time
zero. More surprisingly, subtracting \(A_n\) preserves shifted
subadditivity. If the original finite horizons are integrable and \(T\)
preserves the measure, every \(Y_n\) is integrable too.

These are strong finite facts. They still do not imply that \(Y_n/n\),
\(A_n/n\), or \(X_n/n\) converges. The nineteenth random-matrix-theory
milestone (RMT-19) builds a reduction that later ergodic arguments may use. It
does not smuggle an ergodic theorem into the word *average*.

## Choose a route up

| Route | Start | Destination |
|---|---|---|
| First encounter | [The finite operation in one picture](#the-finite-operation-in-one-picture) | See what is subtracted and what remains |
| Algebra route | [Why the one-step sum majorizes every positive horizon](#why-the-one-step-sum-majorizes-every-positive-horizon) | Reconstruct the induction and its exact hypotheses |
| Boundary route | [Positive time and time zero are different theorems](#positive-time-and-time-zero-are-different-theorems) | Understand the constant-one countermodel |
| Structure route | [The centered residual is still subadditive](#the-centered-residual-is-still-subadditive) | Follow cancellation through the Birkhoff-sum addition law |
| Analysis route | [Integrability enters at one narrow gate](#integrability-enters-at-one-narrow-gate) | Separate pointwise algebra from measure theory |
| Example route | [The singleton square-root process](#the-singleton-square-root-process) | Compute a strict residual by hand |
| Limit route | [An exact normalized split is not a convergence theorem](#an-exact-normalized-split-is-not-a-convergence-theorem) | Locate both unresolved asymptotic branches |
| Cocycle route | [The thin matrix-cocycle specialization](#the-thin-matrix-cocycle-specialization) | See which statements need the integrability hypothesis |
| Lean route | [The complete eighteen-declaration map](#the-complete-eighteen-declaration-map) | Audit the public source order and both private helpers |
| Summit route | [Forty solved exercises](#forty-solved-exercises) | Test definitions, proofs, countermodels, and theorem design |

### Learning objectives

By the end, a careful reader should be able to:

1. distinguish orbit-majorant compensation from subtracting an expectation;
2. define the finite one-step Birkhoff sum with the correct orbit samples;
3. derive the positive-horizon majorant directly from shifted subadditivity;
4. explain why integrability is absent from that induction;
5. identify the separate time-zero normalization needed for a uniform bound;
6. use the constant-one process as a minimal countermodel;
7. derive positive-horizon and uniform nonpositivity of the residual;
8. prove that subtracting an additive orbit sum preserves subadditivity;
9. state the exact Birkhoff-sum addition identity used in that proof;
10. explain why no probability or ergodicity premise enters the algebra;
11. locate the one-step measure-preservation premise used for integrability;
12. package the residual as another integrable subadditive candidate;
13. explain why candidate packaging does not require \(X_0=0\);
14. derive the exact normalized decomposition;
15. check the totalized \(n=0\) branch without informal division by zero;
16. compute the singleton process \(X_n=\sqrt n\);
17. explain why its residual is not mean zero under a Dirac measure;
18. recognize additive processes as the zero-residual boundary;
19. build an additive example whose orbit averages fail to converge;
20. distinguish a finite Birkhoff average from a pointwise Birkhoff theorem;
21. read the cocycle orbit-sum bridge as definitional equality;
22. identify the cocycle results that use only the cocycle object;
23. identify the single cocycle result that uses one-step integrability;
24. explain why the empty matrix index remains valid;
25. distinguish log-positive expansion control from signed logarithmic growth;
26. audit all eighteen public declarations and two private helpers in order;
27. match every theorem to the fields and premises its proof actually uses;
28. state what Kingman, Lalley, and Karlsson-Margulis contribute only as later
    context; and
29. reject every unsupported limit, exponent, or invariant-splitting claim.

## The common setup and the notation ledger

The Lean structure
<code>IsIntegrableSubadditiveProcessCandidate T μ X</code> comes from RMT-17.
It stores two fields:

- <code>integrable</code>: every function \(X_n:\Omega\to\mathbb R\) is
  integrable with respect to a measure \(\mu\); and
- <code>add_le</code>: the shifted-subadditive inequality holds pointwise.

The structure stores neither measure preservation nor probability nor
ergodicity. Those concepts remain separate so that each theorem can request
only what it consumes. This module continues that discipline.

For compact notation, write

\[
\begin{aligned}
A_n(\omega)
&= \operatorname{birkhoffSum}(T,X_1,n,\omega), \\
Y_n(\omega)
&= X_n(\omega)-A_n(\omega).
\end{aligned}
\]

Mathlib defines the Birkhoff sum as the finite sum of \(X_1\) over the first
\(n\) orbit points. It provides the zero, one, successor, and addition laws
used below ([Mathlib Birkhoff sums](#ref-centering-birkhoff-basic)). In
particular,

\[
\begin{aligned}
A_0(\omega) &= 0, \\
A_1(\omega) &= X_1(\omega), \\
A_{m+n}(\omega)
&= A_m(\omega)+A_n(T^m\omega).
\end{aligned}
\]

The last equation says that \(A\) is additive with the same shifted time
orientation used by \(X\). That exact match is why subtraction works.

The term *majorant* means pointwise upper bound. It does not mean expectation,
essential supremum, deterministic constant, uniform bound over outcomes, or
asymptotic envelope. The value \(A_n(\omega)\) depends on the entire finite
orbit segment beginning at \(\omega\).

## The finite operation in one picture

{{< reference-figure
  src="additive-majorant-and-nonpositive-residual.svg"
  alt="The finite process value lies below its additive one-step orbit sum. Subtracting that orbit sum leaves a centered residual that is nonpositive at positive horizons, with a separate time-zero normalization condition."
  caption="**Finding:** shifted subadditivity turns the sum of successive one-step observations into a pointwise upper bound for every positive finite horizon. The centered residual records the slack left after subtracting that bound, so it cannot be positive. At time zero the residual equals the original time-zero value, which is why uniform nonpositivity needs the exact normalization \(X_0=0\). The plate is finite and pointwise. It depicts no expectation, probability law, or limiting behavior."
>}}

The diagram has three distinct objects. The process value \(X_n(\omega)\) is
one number attached to the whole horizon. The orbit majorant \(A_n(\omega)\)
is a sum of \(n\) one-step numbers at successively shifted outcomes. The
residual \(Y_n(\omega)\) is their difference. Calling all three “growth” would
hide the proof structure.

At one step there is no slack:

\[
Y_1(\omega)
{} =
X_1(\omega)-X_1(\omega)
{} = 0.
\]

At zero steps there is no orbit sum, so

\[
Y_0(\omega)=X_0(\omega).
\]

Those two endpoint formulas are public simplification theorems. They are not
decorative conveniences. Together they show why “centered” cannot mean
“automatically zero at the origin”: the subtraction has nothing to remove at
time zero.

## Why the one-step sum majorizes every positive horizon

The majorant proof is induction on a positive horizon. Write a positive
natural number as \(n+1\). The base case is one step, where both sides are
\(X_1(\omega)\). For the successor step, shifted subadditivity gives

\[
X_{(n+1)+1}(\omega)
\le
X_1(T^{n+1}\omega)+X_{n+1}(\omega).
\]

Apply the induction hypothesis to the second term:

\[
X_{n+1}(\omega)
\le
A_{n+1}(\omega).
\]

Then

\[
X_{(n+1)+1}(\omega)
\le
X_1(T^{n+1}\omega)+A_{n+1}(\omega).
\]

The successor law for the Birkhoff sum identifies the right side, up to the
commutativity of real addition, with \(A_{(n+1)+1}(\omega)\). The induction
closes.

Notice what the proof never mentions: \(\mu\), measurability, integrability,
measure preservation, probability, or ergodicity. It consumes only the raw
shifted-subadditive inequality. The Lean file makes this mechanically visible
through the private helper
<code>oneStepBirkhoffMajorant_of_add_le</code>. The public method receives the
convenient candidate bundle but immediately passes only its <code>add_le</code>
field to the helper.

This field audit prevents a common formalization mistake. A theorem may be
stated as a method on a rich structure for discoverability, yet its proof may
use only one field. The documentation must report the proof's true
mathematical dependency, not every assumption available in the local context.

## Positive time and time zero are different theorems

For \(n\ne0\), the induction proves

\[
X_n(\omega)\le A_n(\omega)
\]

without any condition on \(X_0\). Consequently,

\[
Y_n(\omega)\le0
\]

at every positive horizon.

At \(n=0\), the proposed majorant reads

\[
X_0(\omega)\le A_0(\omega)=0.
\]

Shifted subadditivity by itself points in the opposite direction. Setting both
horizons to zero yields \(X_0(\omega)\le X_0(\omega)+X_0(\omega)\), hence
\(0\le X_0(\omega)\). Therefore a uniform majorant can hold only when
\(X_0(\omega)=0\) pointwise. RMT-18 already isolated that boundary; RMT-19
uses it rather than hiding it.

The constant-one process is the smallest countermodel. Take the singleton
space \(\Omega=\{\ast\}\), the identity map, and

\[
X_n(\ast)=1
\]

for every \(n\). It is subadditive because \(1\le1+1\). At a positive horizon,
\(A_n(\ast)=n\), so \(Y_n(\ast)=1-n\le0\). At time zero,
\(A_0(\ast)=0\) and \(Y_0(\ast)=1\). Thus uniform nonpositivity is false.

This example also separates candidate packaging from normalization. Under a
Dirac measure, every constant horizon is integrable. The identity map
preserves that measure. The centered family can therefore be packaged as an
integrable subadditive candidate even though \(Y_0=1\). Candidate packaging
records integrability and subadditivity, not zero initialization.

## The centered residual is still subadditive

The preservation proof is a cancellation argument. Begin with

\[
Y_{m+n}(\omega)
{} =
X_{m+n}(\omega)-A_{m+n}(\omega).
\]

Use shifted subadditivity for \(X\) and exact additivity for \(A\):

\[
\begin{aligned}
Y_{m+n}(\omega)
&\le
X_n(T^m\omega)+X_m(\omega) \\
&\qquad-
\bigl(A_m(\omega)+A_n(T^m\omega)\bigr).
\end{aligned}
\]

Regroup the real terms:

\[
Y_{m+n}(\omega)
\le
Y_n(T^m\omega)+Y_m(\omega).
\]

No sign information was used. No time-zero normalization was used. In fact,
the same algebra would preserve shifted subadditivity after subtracting any
additive process with the matching shift orientation. The one-step Birkhoff
sum is chosen because subadditivity proves it is a majorant at positive time.

Lean records this reasoning in the private helper
<code>centeredProcess_add_le_of_add_le</code>. The helper unfolds the centered
definition, rewrites the orbit sum with <code>birkhoffSum_add</code>, and lets
linear arithmetic finish from the raw <code>add_le</code> premise. Once again,
the private theorem exposes the minimal algebra even though the public method
is attached to the candidate structure.

The orientation is worth checking carefully. Mathlib's addition law is

\[
A_{m+n}(\omega)
{} =
A_m(\omega)+A_n(T^m\omega).
\]

The project structure writes its subadditive upper bound as the shifted later
term followed by the earlier term. Real addition is commutative, so their
visible order can be rearranged. Their sample points cannot. Replacing
\(A_n(T^m\omega)\) by \(A_n(\omega)\) would break the proof.

## Integrability enters at one narrow gate

Suppose now that every \(X_n\) is integrable with respect to \(\mu\), and that
\(T\) preserves \(\mu\). Each shifted one-step term

\[
\omega\longmapsto X_1(T^j\omega)
\]

is integrable because every iterate \(T^j\) preserves \(\mu\), and composition
with a measure-preserving map preserves integrability. A finite sum of such
terms is integrable. These closure properties are supplied by Mathlib's
integrability library ([pinned integrability results](#ref-centering-integrable)),
while the preservation premise is the standard Mathlib package
([pinned measure-preserving definition](#ref-centering-preserving)).

RMT-18 already proved the reusable block-sum theorem. RMT-19 invokes it with
block length one. Since \(T^1=T\), the separate premise
<code>MeasurePreserving T μ μ</code> is exactly what the proof needs. It does
not ask for probability normalization or ergodicity.

Now \(Y_n=X_n-A_n\) is the difference of two integrable real-valued functions,
so \(Y_n\) is integrable. Combining that result with the algebraic
subadditivity theorem packages \(Y\) as another
<code>IsIntegrableSubadditiveProcessCandidate</code>.

The assumptions divide cleanly:

| Result | Raw shifted subadditivity | Integrability of every \(X_n\) | \(T\) preserves \(\mu\) | \(X_0=0\) | Probability | Ergodicity |
|---|---:|---:|---:|---:|---:|---:|
| Positive majorant | Yes | No | No | No | No | No |
| Uniform majorant | Yes | No | No | Yes | No | No |
| Positive residual nonpositivity | Yes | No | No | No | No | No |
| Uniform residual nonpositivity | Yes | No | No | Yes | No | No |
| Centered subadditivity | Yes | No | No | No | No | No |
| Centered horizon integrable | No new algebra | Yes | Yes | No | No | No |
| Centered candidate | Yes | Yes | Yes | No | No | No |
| Normalized finite identity | No | No | No | No | No | No |

The phrase “No new algebra” means that the integrability theorem does not need
subadditivity to prove closure under subtraction. Its receiver is a candidate,
and it uses the receiver's integrability field. The candidate constructor then
combines that analytic result with the separately proved subadditivity result.

Zero measure is a useful boundary test. Every real function is integrable with
respect to the zero measure, and the identity map preserves the zero measure.
The centered-candidate theorem still applies. This confirms that no hidden
<code>IsProbabilityMeasure</code> premise entered through a convenient lemma.

## The singleton square-root process

Take \(\Omega=\{\ast\}\), \(T\) equal to the identity, and

\[
X_n(\ast)=\sqrt n.
\]

The elementary inequality

\[
\sqrt{m+n}\le\sqrt m+\sqrt n
\]

makes this a subadditive process. Its one-step value is \(X_1=1\), so the
orbit majorant is simply

\[
A_n(\ast)=n.
\]

The centered residual is therefore

\[
Y_n(\ast)=\sqrt n-n.
\]

At \(n=4\), the full ledger is

\[
\begin{aligned}
X_4(\ast) &= 2, \\
A_4(\ast) &= 4, \\
Y_4(\ast) &= -2.
\end{aligned}
\]

After normalization,

\[
\frac{X_4(\ast)}{4}
{} =
\frac{Y_4(\ast)}{4}+
\frac{A_4(\ast)}{4}
{} =
-\frac12+1
{} =
\frac12.
\]

This example shows three things at once. First, the additive majorant can be
strictly larger than the process. Second, the residual can have a linear
negative component even though the original process is nonnegative. Third,
“centered” does not mean mean zero. Under the Dirac probability measure at
\(\ast\), the expectation of \(Y_4\) is \(-2\), not zero.

The example happens to have limits: \(X_n/n\to0\), \(A_n/n\to1\), and
\(Y_n/n\to-1\). Those limits are proved by elementary analysis external to
RMT-19. The finite identity merely remains consistent with their cancellation.
It did not establish any of them.

At the opposite boundary, suppose \(X_n=A_n\) is itself the Birkhoff-sum
process generated by \(X_1\). Then \(Y_n=0\) for every \(n\). Additive
processes are the zero-slack examples for this chosen majorant. A strictly
subadditive process records its lost additivity in a residual that is
nonpositive at positive horizons, and also at time zero when \(X_0=0\).

## An exact normalized split is not a convergence theorem

Mathlib defines the finite Birkhoff average over the real numbers as the
Birkhoff sum scaled by the inverse of the natural-number horizon
([Mathlib Birkhoff averages](#ref-centering-birkhoff-average)). Thus the
definition is total at \(n=0\): the inverse of zero in \(\mathbb R\) is zero,
and the empty sum is zero.

For every \(n\) and \(\omega\), pure field algebra gives

\[
\begin{aligned}
\frac{X_n(\omega)}{n}
&=
\frac{Y_n(\omega)}{n}
\\
&\quad{}+\operatorname{birkhoffAverage}_{j\lt n}
  \bigl(X_1(T^j\omega)\bigr).
\end{aligned}
\]

The notation on the right denotes the average of the first \(n\) one-step
orbit observations. At \(n=0\), all three terms are zero under Lean's
totalized field operations, regardless of the value of \(X_0\). This is why
the normalized identity needs no time-zero normalization even though uniform
nonpositivity does.

{{< reference-figure
  src="normalized-split-without-a-limit.svg"
  alt="The normalized process value splits into a normalized centered residual and a one-step orbit average. Both branches retain separate unresolved convergence questions."
  caption="**Finding:** normalization rewrites each finite process value as the sum of two finite contributions. One is the normalized subadditive slack; the other is the average of the one-step observable along the orbit. The identity says nothing about whether either contribution converges, whether their limits are integrable, or whether cancellation occurs. A pointwise ergodic theorem and a subadditive ergodic theorem are additional results, not consequences of the diagram."
>}}

Why can the right branch fail to converge? Take the one-sided binary sequence
space, let \(T\) delete the first bit, and let \(g(\omega)\) read the first bit.
Choose one outcome made of alternating blocks of zeros and ones, each new block
so much longer than everything before it that the empirical frequency is near
zero after a zero block and near one after a one block. Define

\[
X_n(\omega)=\sum_{j=0}^{n-1}g(T^j\omega).
\]

This process is additive, so \(Y_n=0\). Along the chosen outcome, \(X_n/n\) is
exactly the nonconvergent empirical frequency. The normalized identity reduces
to that same Birkhoff average and cannot improve it. Measure-theoretic
hypotheses and an actual pointwise theorem would be needed to obtain an
almost-everywhere conclusion.

Kingman's original theorem belongs to that later asymptotic layer
([Kingman, 1968](#ref-centering-kingman)). Lalley's notes give a clear teaching
route through finite blocking and the eventual subadditive ergodic argument
([Lalley](#ref-centering-lalley)). RMT-19 proves only the finite compensation
identity that may be used before such a theorem. It does not instantiate,
reprove, or invoke Kingman.

## The thin matrix-cocycle specialization

Let \(C\) be the project's one-sided discrete complex matrix cocycle over a
measure-preserving base. Its finite log-positive norm observable is

\[
L_n(\omega)=\log^+\lVert C_n(\omega)\rVert.
\]

The project already proved

\[
L_{m+n}(\omega)
\le
L_n(C.\mathrm{base}^m\omega)+L_m(\omega)
\]

and the pointwise one-step orbit majorant

\[
L_n(\omega)
\le
\sum_{j=0}^{n-1}L_1(C.\mathrm{base}^j\omega).
\]

RMT-19 adds a thin specialization rather than duplicating those theorems. The
existing <code>orbitLogPlusSum</code> is definitionally the Birkhoff sum of
<code>logPlusNormObservable 1</code>. The centered cocycle observable is

\[
R_n(\omega)
{} =
L_n(\omega)-\mathrm{orbitLogPlusSum}_n(\omega).
\]

The pointwise theorem \(R_n(\omega)\le0\) uses the cocycle's already checked
majorant directly. Centered subadditivity uses the raw cocycle
<code>logPlusNormObservable_add_le</code> theorem through the private algebraic
helper. Neither result requires
<code>HasIntegrableGeneratorLogPlus</code>.

Only the candidate-packaging theorem uses the hypothesis \(hC\) that the
one-step log-positive observable is integrable. From \(hC\), the earlier module
provides integrability of every \(L_n\). From the cocycle bundle, the base map
preserves \(\mu\). Generic centered integrability then applies, and the direct
pointwise subadditivity theorem supplies the second candidate field.

The empty matrix index remains legal. In empty dimension the project's norm
observable and log-positive observable vanish at every finite horizon. The
orbit sum and centered observable vanish as well. No theorem in this slice
requires a positive dimension merely to avoid an empty finite sum.

The scalar cases clarify what the residual measures. If a constant scalar
generator expands by a factor above one at every step, log-positive growth is
additive and the centered residual is zero. If one step expands by two and a
later step contracts by one half, the two-step product has norm one, so its
log-positive value is zero, while the one-step log-positive orbit sum still
contains the positive logarithm of two. The residual records negative slack.
It does not restore the signed logarithm discarded by \(\log^+\).

That distinction blocks a premature Lyapunov claim. Even if a future theorem
proved convergence of \(L_n/n\), the result would concern the positive-log
envelope chosen for integrability, not automatically the signed top exponent
of an invertible cocycle. Invertibility, negative tails, and vector-direction
information are absent here.

Karlsson and Margulis study a far stronger geometric destination: integrable
cocycles of nonexpanding maps over an ergodic measure-preserving system and
almost-sure geodesic tracking in nonpositively curved spaces
([Karlsson and Margulis, 1999](#ref-centering-karlsson-margulis)). That work
helps locate multiplicative ergodic theory on the larger map. RMT-19 proves no
geodesic ray, tracking rate, nonpositive-curvature statement, or Oseledets
conclusion.

## The complete eighteen-declaration map

The following table follows the Lean source exactly. Names are shown without
the common namespace prefix when the table remains unambiguous.

| No. | Declaration | What it establishes | Exact boundary |
|---:|---|---|---|
| 1 | <code>centeredProcess</code> | Defines \(Y_n=X_n-A_n\) | Pure algebra; no measurable structure |
| 2 | <code>centeredProcess_zero</code> | \(Y_0=X_0\) as a function equality | Explains the time-zero boundary |
| 3 | <code>centeredProcess_one</code> | \(Y_1=0\) as a function equality | No hypothesis on \(X\) |
| 4 | <code>oneStepBirkhoffMajorant_of_ne_zero</code> | \(X_n\le A_n\) for \(n\ne0\) | Proof consumes only <code>add_le</code> |
| 5 | <code>oneStepBirkhoffMajorant</code> | \(X_n\le A_n\) for every \(n\) | Adds exactly \(X_0=0\) |
| 6 | <code>centeredProcess_nonpos_of_ne_zero</code> | \(Y_n\le0\) for \(n\ne0\) | No time-zero normalization |
| 7 | <code>centeredProcess_nonpos</code> | \(Y_n\le0\) for every \(n\) | Requires \(X_0=0\) |
| 8 | <code>centeredProcess_add_le</code> | \(Y\) remains shifted-subadditive | Uses only <code>add_le</code> |
| 9 | <code>integrable_centeredProcess</code> | Every \(Y_n\) is integrable | Uses candidate integrability and preservation of \(T\) |
| 10 | <code>centeredProcess_candidate</code> | Packages \(Y\) as another candidate | No \(X_0=0\), probability, or ergodicity |
| 11 | <code>normalized_eq_centered_add_birkhoffAverage</code> | Exact normalized finite split | Total at \(n=0\); no analytic premise |
| 12 | <code>birkhoffSum_logPlusNormObservable_one_eq_orbitLogPlusSum</code> | Identifies two existing finite sums | Definitional equality, proved by <code>rfl</code> |
| 13 | <code>centeredLogPlusNormObservable</code> | Defines the cocycle residual \(R_n\) | No integrability premise |
| 14 | <code>centeredLogPlusNormObservable_apply</code> | Unfolds \(R_n=L_n-\mathrm{orbitLogPlusSum}_n\) | Definitional equality |
| 15 | <code>centeredLogPlusNormObservable_nonpos</code> | \(R_n\le0\) pointwise | Uses \(C\) directly, including \(n=0\) |
| 16 | <code>centeredLogPlusNormObservable_add_le</code> | \(R\) remains shifted-subadditive | Uses \(C\) directly |
| 17 | <code>HasIntegrableGeneratorLogPlus.centeredLogPlusNormObservable_candidate</code> | Packages \(R\) as an integrable candidate | This is the only cocycle declaration that needs \(hC\) |
| 18 | <code>logPlusNormObservable_normalized_eq_centered_add_birkhoffAverage</code> | Specializes the exact normalized split | Pointwise; no \(hC\) |

Two private helpers make the field audit explicit:

| Source position | Private helper | Minimal input | Proof job |
|---:|---|---|---|
| first | <code>centeredProcess_add_le_of_add_le</code> | A raw shifted <code>add_le</code> inequality | Cancels the Birkhoff-sum addition law from the process inequality |
| second | <code>oneStepBirkhoffMajorant_of_add_le</code> | A raw shifted <code>add_le</code> inequality and \(n\ne0\) | Inducts over positive horizons without reading integrability |

Both helpers precede the candidate namespace. Their logical use appears later
in a different order: the majorant helper powers declarations 4 and 5, while
the subadditivity helper powers declarations 8 and 16.

## Countermodel and boundary ledger

| Probe | What compiles or computes | What it rules out |
|---|---|---|
| Constant-one process on a singleton | Positive majorant and positive residual nonpositivity; \(Y_0=1\) | Uniform nonpositivity without \(X_0=0\) |
| Zero horizon | Normalized identity reduces to \(0=0+0\) | Informal cancellation by a nonzero horizon |
| Zero measure | Centered candidate packaging still works | Hidden probability normalization |
| Identity base | Preservation is sufficient even with no mixing | Hidden ergodicity premise |
| Additive Birkhoff-sum process | Centered residual is exactly zero | Claim that centering must create strict negativity |
| Singleton square-root process | Centered residual is strictly negative for \(n\gt1\) | Claim that centered means mean zero |
| Nonconvergent binary orbit | Exact split holds while the orbit average fails to converge | Any limit inferred from algebra alone |
| Empty matrix index | Cocycle pointwise and candidate statements remain valid | Hidden positive-dimension premise |
| Expansion followed by contraction | Log-positive residual records slack but not signed loss | Identification with a signed Lyapunov exponent |

These are not random curiosities. Each probe targets a tempting but invalid
assumption deletion or conclusion upgrade. Compiling boundary examples is part
of theorem design because Lean otherwise verifies only the statement we wrote,
not the stronger informal story a reader might hear.

## Forty solved exercises

The exercises climb from direct expansion to theorem design. Each solution is
included so the section can serve as a self-study chapter rather than an answer
key hidden elsewhere.

### Base camp: compute the finite objects

#### Exercise 1: expand a three-step orbit sum

Expand \(A_3(\omega)\) and name the three sample points.

**Solution.** By the definition of a Birkhoff sum,

\[
A_3(\omega)
{} =
X_1(\omega)+X_1(T\omega)+X_1(T^2\omega).
\]

The sample points are \(\omega\), \(T\omega\), and \(T^2\omega\). The third
term is not evaluated at \(T^3\omega\), because a length-three sum uses the
indices zero, one, and two.

#### Exercise 2: compute both endpoint residuals

Show directly that \(Y_0=X_0\) and \(Y_1=0\).

**Solution.** The zero-step Birkhoff sum is empty, hence \(A_0=0\). Therefore
\(Y_0=X_0-A_0=X_0\). The one-step sum contains only the zeroth orbit point, so
\(A_1(\omega)=X_1(\omega)\). Therefore
\(Y_1(\omega)=X_1(\omega)-X_1(\omega)=0\). Neither calculation uses
subadditivity.

#### Exercise 3: compute the constant-one residual

On the singleton identity system, let \(X_n=1\). Find \(A_n\) and \(Y_n\).

**Solution.** Every one-step summand is one, and there are \(n\) summands, so
\(A_n=n\). Thus \(Y_n=1-n\). It is zero at \(n=1\), negative for \(n\gt1\),
and equal to one at \(n=0\). This one computation separates the
positive-horizon theorem from its uniform version.

#### Exercise 4: check the square-root example at four steps

For \(X_n=\sqrt n\), compute \(X_4\), \(A_4\), \(Y_4\), and all three
normalized terms.

**Solution.** Since \(X_1=1\), \(A_4=4\). Also \(X_4=2\), hence \(Y_4=-2\).
Dividing by four gives \(X_4/4=1/2\), \(Y_4/4=-1/2\), and \(A_4/4=1\).
The normalized identity is \(1/2=-1/2+1\). Under a Dirac measure, the mean of
the residual is still \(-2\).

#### Exercise 5: justify square-root subadditivity

Prove \(\sqrt{m+n}\le\sqrt m+\sqrt n\) for nonnegative \(m,n\).

**Solution.** Both sides are nonnegative. Squaring the right side gives

\[
(\sqrt m+\sqrt n)^2
{} =
m+n+2\sqrt{mn}
\ge m+n.
\]

Monotonicity of the square root on nonnegative reals then yields the desired
inequality. Natural numbers embed as nonnegative reals, so the singleton
process is subadditive.

#### Exercise 6: identify the zero-residual boundary

Suppose \(X_n(\omega)=A_n(\omega)\) for every \(n,\omega\). What is \(Y\), and
is it subadditive?

**Solution.** The definition gives \(Y_n=X_n-A_n=0\) identically. The zero
process is additive and therefore subadditive with equality at every split.
This shows that orbit-majorant centering measures slack relative to this
particular additive process; it need not create a nontrivial residual.

#### Exercise 7: compare with expectation centering

Why does \(Y_n=X_n-A_n\) not imply \(\int Y_n\,d\mu=0\)?

**Solution.** Expectation centering would subtract the scalar
\(\int X_n\,d\mu\), or another scalar chosen to match the mean. Here \(A_n\)
is a function of \(\omega\), assembled from orbit observations. There is no
identity saying its integral equals the integral of \(X_n\). The square-root
Dirac example gives an explicit mean of \(-2\) at time four.

#### Exercise 8: evaluate the normalized identity at zero

What does declaration 11 say at \(n=0\)?

**Solution.** In Lean's real field, division by zero is total and produces
zero. Mathlib's zero-step Birkhoff average is also zero because it scales an
empty sum. Thus the identity becomes \(0=0+0\), regardless of \(X_0\).
No cancellation of a nonzero denominator occurs, and no premise \(X_0=0\) is
needed.

#### Exercise 9: evaluate the normalized identity at one

Simplify declaration 11 at \(n=1\).

**Solution.** The centered residual is \(Y_1=0\). The one-step Birkhoff average
is \(X_1(\omega)\). Therefore the right side is
\(0+X_1(\omega)\), equal to the left side \(X_1(\omega)/1\). This boundary
check agrees with both public simplification theorems.

#### Exercise 10: detect an orientation error

Why is \(A_{m+n}(\omega)=A_m(\omega)+A_n(\omega)\) generally false?

**Solution.** The later \(n\) terms begin after the first \(m\) orbit steps.
Their first sample is \(T^m\omega\), not \(\omega\). The correct identity is
\(A_{m+n}(\omega)=A_m(\omega)+A_n(T^m\omega)\). The unshifted formula would
repeat the beginning of the orbit and omit its later segment.

### Mid-mountain: rebuild the proof architecture

#### Exercise 11: prove the positive majorant base case

What must be shown when the positive horizon is one?

**Solution.** One must show
\(X_1(\omega)\le A_1(\omega)\). The one-step sum is definitionally
\(X_1(\omega)\), so the goal is reflexivity. Subadditivity is not used in the
base case; it enters only when another step is appended.

#### Exercise 12: prove the positive majorant successor step

Assume \(X_{n+1}(\omega)\le A_{n+1}(\omega)\). Derive the next case.

**Solution.** Shifted subadditivity with the split \((n+1)+1\) gives

\[
X_{(n+1)+1}(\omega)
\le
X_1(T^{n+1}\omega)+X_{n+1}(\omega).
\]

Replace the last term by \(A_{n+1}(\omega)\) using the induction hypothesis.
The Birkhoff successor law says that this sum is
\(A_{(n+1)+1}(\omega)\), after commuting the two real summands.

#### Exercise 13: audit the majorant's fields

Which field of the candidate structure does declaration 4 actually read?

**Solution.** It reads only <code>add_le</code>. The public theorem passes that
field to <code>oneStepBirkhoffMajorant_of_add_le</code>. The candidate's
<code>integrable</code> field is available in the local structure but is not
used by the proof. There is no measure-preservation argument in the induction.

#### Exercise 14: extend the positive theorem uniformly

How does declaration 5 use \(X_0=0\)?

**Solution.** It splits on \(n\). When \(n=0\), rewriting by \(X_0=0\) makes
the desired bound \(0\le0\). When \(n\) is a successor, it calls the raw
positive-horizon helper and does not use the normalization. The extra
hypothesis repairs exactly one branch.

#### Exercise 15: refute uniform nonpositivity without normalization

Give the shortest counterargument.

**Solution.** Use the constant-one process on a singleton. It is integrable
and shifted-subadditive. At time zero its Birkhoff sum is empty, so
\(Y_0=1-0=1\), which is not nonpositive. The positive-horizon theorem remains
true, so the countermodel targets only the attempted uniform strengthening.

#### Exercise 16: derive centered subadditivity

Starting from the two addition laws, show the centered inequality.

**Solution.** Substitute the subadditive bound for \(X_{m+n}\) and the exact
addition formula for \(A_{m+n}\):

\[
\begin{aligned}
Y_{m+n}(\omega)
&\le X_n(T^m\omega)+X_m(\omega) \\
&\qquad-A_n(T^m\omega)-A_m(\omega) \\
&=Y_n(T^m\omega)+Y_m(\omega).
\end{aligned}
\]

Only ordered-ring algebra remains after the two structural facts are supplied.

#### Exercise 17: generalize the subtraction principle

Let \(B\) be any shifted-additive process. Does \(X-B\) remain subadditive?

**Solution.** Yes. If
\(B_{m+n}(\omega)=B_n(T^m\omega)+B_m(\omega)\), subtract that equality from
the shifted-subadditive inequality for \(X\). Regrouping gives
\((X-B)_{m+n}\le(X-B)_n\circ T^m+(X-B)_m\). The Birkhoff sum is one canonical
choice of \(B\), not the only algebraically possible one.

#### Exercise 18: trace integrability of the orbit sum

Why is \(A_n\) integrable when \(T\) preserves \(\mu\)?

**Solution.** Candidate integrability gives integrability of \(X_1\).
Measure preservation passes to every iterate \(T^j\), so each composition
\(X_1\circ T^j\) is integrable. The orbit sum contains finitely many such
terms, and integrability is closed under finite sums. No ergodicity or
probability normalization is involved.

#### Exercise 19: package the centered candidate

Which two proofs fill its fields, and why is \(X_0=0\) absent?

**Solution.** Declaration 9 fills the <code>integrable</code> field for each
centered horizon. Declaration 8 fills <code>add_le</code>. Neither field in
the candidate structure requires a time-zero value, so the constructor has no
reason to request \(X_0=0\). The constant-one candidate confirms this
boundary is intentional.

#### Exercise 20: test the zero-measure boundary

Why does centered candidate packaging work for the zero measure?

**Solution.** Every function is integrable with respect to the zero measure,
because every integral of its norm is zero. The identity map preserves the
zero measure. If the raw process is shifted-subadditive, the generic theorem
therefore packages its centered family. This test would fail if a hidden
probability instance were required.

### High camp: averages and cocycles

#### Exercise 21: construct a nonconvergent orbit average

Describe one binary orbit whose empirical frequency does not converge.

**Solution.** Concatenate a block of zeros, then a much longer block of ones,
then a much longer block of zeros, and continue, choosing each block longer
than the total preceding length by an increasing factor. At the end of a zero
block the proportion of ones is near zero; at the end of a one block it is
near one. Those two subsequences have different limits.

#### Exercise 22: explain why the exact split cannot repair that example

Take \(X_n\) to be the additive sum of the bits. What happens?

**Solution.** Because \(X\) already equals its one-step Birkhoff sum, the
centered residual is zero. Declaration 11 then says only that
\(X_n/n\) equals the finite orbit average. Along the constructed outcome that
average does not converge. An identity that leaves the entire problem in one
branch cannot prove convergence of that branch.

#### Exercise 23: compute a constant scalar expansion

Let every one-dimensional generator equal a scalar \(a\) with
\(\lvert a\rvert\gt1\). What is the centered log-positive residual?

**Solution.** The \(n\)-step product has norm \(\lvert a\rvert^n\), so its
log-positive observable is \(n\log\lvert a\rvert\). Every one-step orbit term
is \(\log\lvert a\rvert\), and their sum is the same value. The centered
residual is zero. Submultiplicativity is exact in this scalar constant case.

#### Exercise 24: compute expansion followed by contraction

Use scalar factors two and one half. What slack appears after two steps?

**Solution.** The product has norm one, whose log-positive value is zero. The
first one-step log-positive value is \(\log2\), while the contraction's
log-positive value is zero. The orbit majorant is therefore \(\log2\), and
the centered residual is \(-\log2\). The signed contraction was erased before
centering; the residual records only slack in the positive-log bound.

#### Exercise 25: audit empty matrix dimension

Why do the cocycle declarations remain meaningful when the index type is
empty?

**Solution.** The project defines its finite matrix norms and log-positive
observables uniformly over finite index types. In empty dimension the
observable is zero. Finite Birkhoff sums of zero are zero, so the centered
observable is zero and satisfies every pointwise inequality. No division by
the dimension appears in RMT-19.

#### Exercise 26: locate the only cocycle use of \(hC\)

Which declaration needs <code>HasIntegrableGeneratorLogPlus</code>, and why?

**Solution.** Declaration 17 needs \(hC\) to package the centered cocycle
family as an integrable candidate. The hypothesis propagates one-step
integrability to every finite log-positive horizon. The pointwise bridge,
definition, apply formula, nonpositivity, subadditivity, and normalized
identity do not integrate anything and therefore do not need \(hC\).

#### Exercise 27: explain the <code>rfl</code> bridge

Why can declaration 12 be proved by reflexivity?

**Solution.** The earlier <code>orbitLogPlusSum</code> definition expands to
the same finite sum as
<code>birkhoffSum C.base (C.logPlusNormObservable 1) n</code>. Their wrappers,
index range, iterate convention, and summand agree definitionally. No theorem
about matrices or measures is needed to identify them.

#### Exercise 28: separate log-positive growth from signed growth

Why can the centered observable not recover a signed Lyapunov exponent?

**Solution.** The positive logarithm maps every norm at most one to zero.
Information about contraction magnitude is already gone. Subtracting an
orbit sum of the same truncated observable can reveal slack in its additive
upper bound, but it cannot reconstruct discarded negative logarithms,
invertibility, vector directions, or invariant subspaces.

#### Exercise 29: delete probability and ergodicity

Which RMT-19 declarations survive, and what changes?

**Solution.** All eighteen public declarations survive because none assumes
either probability normalization or ergodicity. The generic integrability
statements still need an arbitrary measure and explicit preservation, and the
cocycle candidate still needs \(hC\). What disappears are only interpretations
and future routes that would call a probability-space ergodic theorem.

#### Exercise 30: place Karlsson-Margulis correctly

What does that reference contribute to this chapter?

**Solution.** It marks a later geometric destination for integrable cocycles
over ergodic measure-preserving systems, with almost-sure tracking in
nonpositively curved spaces. It supplies context for why cocycle asymptotics
matter. It supplies no lemma used by RMT-19 and authorizes no geodesic,
Oseledets, or convergence claim here.

### Summit: theorem design and review

#### Exercise 31: recite the public source partition

How are the eighteen declarations grouped?

**Solution.** Declarations 1 through 3 define and simplify the generic
residual. Declarations 4 through 10 give candidate methods for majorants,
nonpositivity, subadditivity, integrability, and repackaging. Declaration 11
is the generic normalized identity. Declarations 12 through 18 are the thin
cocycle bridge, definition, properties, candidate wrapper, and normalized
specialization.

#### Exercise 32: recite the private helper order

Which helper appears first, and why should prose record the order?

**Solution.** <code>centeredProcess_add_le_of_add_le</code> appears first;
<code>oneStepBirkhoffMajorant_of_add_le</code> appears second. The public
majorant uses the second helper before later public declarations use the
first. Recording textual source order lets readers audit the actual file
rather than reconstructing a tidier but inaccurate narrative order.

#### Exercise 33: remove integrability from the majorant

Can declaration 4 be stated using only raw algebra?

**Solution.** Yes. Its private helper already has exactly that signature: a
raw shifted-subadditive inequality, a positive horizon, and an outcome. The
public method remains attached to the candidate structure for discoverability
and reuse. The helper prevents the stronger bundle from obscuring the theorem's
true mathematical dependency.

#### Exercise 34: explain why arbitrary composition threatens integrability

Why retain measure preservation in declaration 9?

**Solution.** An integrable function need not remain integrable after
composition with an arbitrary map. For example, on natural numbers with
exponentially decaying mass, a moderately growing integrable function can
become exponentially growing after a map that sends \(k\) to \(2^k\).
Measure preservation controls the pullback integral and blocks that failure.

#### Exercise 35: remove \(X_0=0\) from candidate packaging

Is the resulting theorem still sound?

**Solution.** Yes, and declaration 10 already omits it. The centered process
remains subadditive without normalization, and its horizons remain integrable
under preservation. The constant-one example has \(Y_0=1\) yet still forms a
valid candidate. Adding \(X_0=0\) would be a convenient but unnecessary
restriction.

#### Exercise 36: write the no-limit referee report

Reject the claim “declaration 11 proves \(X_n/n\) converges.”

**Solution.** Declaration 11 is a pointwise algebraic equality at each finite
horizon. It provides no convergence theorem for the centered quotient and no
pointwise ergodic theorem for the one-step average. Either branch can retain
the whole asymptotic difficulty, as the additive nonconvergent binary example
shows. The claim must be withdrawn until separate hypotheses and limit
theorems are formalized.

#### Exercise 37: motivate phase averaging as a next finite step

Why might one study several shifted block phases next?

**Solution.** A single block decomposition privileges one starting phase.
Averaging finite inequalities over the possible offsets can spread boundary
terms across phases and prepare estimates used in classical subadditive
arguments. That remains finite combinatorics. It must be formalized with its
own exact remainder ledger before any almost-everywhere conclusion is stated.

#### Exercise 38: design an assumption-deletion test

How should a proposed weaker theorem be audited before publication?

**Solution.** Identify every field the proof reads, write a private or
standalone raw helper with only those inputs, and compile boundary probes:
zero horizon, nonnormalized time zero, zero measure, identity or periodic
base, and empty index where relevant. Then construct a countermodel for each
premise one hopes to remove. A passing happy-path example is not enough.

#### Exercise 39: reject an Oseledets upgrade

Why is an invariant splitting far beyond this module?

**Solution.** RMT-19 handles one scalar log-positive norm envelope. An
Oseledets theorem requires a multiplicative cocycle framework with substantial
measurability and integrability assumptions, almost-everywhere asymptotics,
signed growth rates, and invariant vector-space structure. None of those
objects is constructed by subtracting a finite one-step orbit sum.

#### Exercise 40: summarize the summit in one argument

What is the strongest honest description of RMT-19?

**Solution.** RMT-19 defines the residual obtained by subtracting the additive
one-step Birkhoff majorant from a finite shifted-subadditive process. It proves
positive-horizon nonpositivity, isolates the exact time-zero normalization for
a uniform form, preserves shifted subadditivity, preserves finite-horizon
integrability under one-step measure preservation, and gives a totalized
normalized identity. Its cocycle layer is pointwise except for one explicit
integrability wrapper. It proves no asymptotic theorem.

## Read and reproduce the checked Lean slice

The leaf module is
<code>NonlinearDynamics.Random.RandomCocycles.SubadditiveCentering</code>. It
imports the finite-block results from RMT-18 and Mathlib's Birkhoff-average
definition. The new public surface is intentionally small: eighteen
declarations and two private proof helpers.

From the repository root, load the pinned Lean toolchain and compile the leaf
with warnings treated as errors:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/SubadditiveCentering.lean
~~~

Build the module and its dependencies:

~~~sh
lake build NonlinearDynamics.Random.RandomCocycles.SubadditiveCentering
~~~

Compile the cocycle aggregator and root aggregator directly if auditing import
discipline:

~~~sh
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles.lean
lake env lean -DwarningAsError=true NonlinearDynamics.lean
~~~

Return to the repository root and validate teaching source plus Hugo links:

~~~sh
cd ..
python3 scripts/check_teaching_source_hygiene.py
make site-check
~~~

The repository-wide gate is <code>make check</code>. A successful build proves
that Lean accepted the declarations and that the site source passed its
automated checks. It does not perform the pending human mathematical,
accessibility, source, or editorial review, so this page remains a draft.

## What the milestone establishes

| Question | Checked answer |
|---|---|
| What is centered? | The finite process after subtracting its one-step orbit sum |
| Is the operation expectation centering? | No |
| Does the residual equal the original at time zero? | Yes |
| Does the residual vanish at one step? | Yes |
| Is the one-step sum a positive-horizon majorant? | Yes, from raw shifted subadditivity |
| Is the majorant uniform at time zero? | Yes only under \(X_0=0\) |
| Is the residual nonpositive at positive horizons? | Yes |
| Is it uniformly nonpositive? | Yes only under \(X_0=0\) |
| Does centering preserve shifted subadditivity? | Yes, by finite algebra |
| Does centering preserve finite-horizon integrability? | Yes when \(T\) preserves \(\mu\) |
| Does centered candidate packaging require \(X_0=0\)? | No |
| Does any generic result require probability? | No |
| Does any generic result require ergodicity? | No |
| Is the normalized identity valid at \(n=0\)? | Yes, under totalized field operations |
| Is the cocycle orbit sum really a Birkhoff sum? | Yes, definitionally |
| Do cocycle pointwise results require \(hC\)? | No |
| Which cocycle result requires \(hC\)? | Only centered candidate packaging |
| Does empty matrix dimension remain valid? | Yes |
| Does the slice establish convergence? | No |

## Exhaustive nonclaims

The module and this chapter do not prove or define any of the following:

1. expectation centering of \(X_n\);
2. a mean-zero property for \(Y_n\);
3. equality between \(\int A_n\,d\mu\) and \(\int X_n\,d\mu\);
4. probability normalization of \(\mu\);
5. ergodicity of \(T\);
6. invertibility of \(T\);
7. mixing, weak mixing, or independence;
8. identical distribution of one-step observations;
9. stationarity beyond the explicit orbit presentation;
10. convergence of \(A_n/n\) at any outcome;
11. almost-everywhere convergence of \(A_n/n\);
12. convergence of \(Y_n/n\);
13. almost-everywhere convergence of \(Y_n/n\);
14. convergence of \(X_n/n\);
15. almost-everywhere convergence of \(X_n/n\);
16. convergence in probability or in measure;
17. convergence in \(L^1\) or any other \(L^p\) space;
18. uniform integrability of a normalized family;
19. domination sufficient for exchanging a limit and an integral;
20. a pointwise Birkhoff ergodic theorem;
21. a mean ergodic theorem;
22. Kingman's subadditive ergodic theorem;
23. a maximal inequality;
24. a phase-averaged block estimate;
25. an invariant limiting random variable;
26. constancy of a limit under ergodicity;
27. identification of a limit with an infimum of expected rates;
28. a signed logarithmic growth process;
29. a top Lyapunov exponent;
30. a lower or negative Lyapunov exponent;
31. a Furstenberg-Kesten theorem;
32. an Oseledets multiplicative ergodic theorem;
33. an invariant filtration or splitting;
34. invertibility of cocycle matrices;
35. control of negative logarithmic tails;
36. a geodesic tracking theorem;
37. a nonpositive-curvature hypothesis or conclusion;
38. a stochastic-stability statement;
39. a thermodynamic or infinite-volume limit; or
40. any assertion that a finite identity supplies an asymptotic theorem.

The long list is deliberate. The notation \(A_n/n\) looks like an ergodic
average, and the notation \(X_n/n\) looks like a growth rate. Those visual
similarities are invitations to ask the next theorem, not licenses to assume
its conclusion.

## Where to continue

[Finite Block Decomposition for Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-block-decomposition-for-subadditive-processes" >}})
is the immediate predecessor. It proves the finite block-and-remainder bounds
from which the one-step majorant can also be viewed as the special block
length one case.

[Orbit-Majorant Centering Before Any Ergodic Limit]({{< relref "/development-notebook/2026/07/orbit-majorant-centering-for-subadditive-cocycles" >}})
is the Development Notebook companion that follows the Lean implementation
line by line, records the compiled boundary probes, and gives the exact
commands used for the milestone.

The {{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}}
glossary chapter is the compact operational definition and counterexample
reference. The {{< refterm "birkhoff-sum" "Birkhoff sum" >}} chapter isolates
the finite orbit-sum convention used throughout.

The next finite layer should investigate phase averaging across shifted block
decompositions. That work may prepare a later subadditive ergodic proof, but it
must remain explicit about finite boundary terms. A pointwise or
almost-everywhere theorem belongs only after the required measure-theoretic
infrastructure is formalized.

## References

All web links below were checked on 2026-07-21. The pinned local Mathlib
checkout is the authority for exact declaration names and definitions.

<a id="ref-centering-birkhoff-basic"></a>**Mathlib contributors.**
[Birkhoff sums](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Basic.html),
Mathlib 4 documentation. The exact pinned source defines the finite sum and
its zero, one, successor, and addition laws in
[lines 31 through 57 at commit 81a5d257](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Basic.lean#L31-L57).
These are the finite algebraic identities used by both private helpers.

<a id="ref-centering-birkhoff-average"></a>**Mathlib contributors.**
[Birkhoff averages](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Average.html),
Mathlib 4 documentation. The pinned
[definition and zero/one laws](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Average.lean#L42-L59)
record the totalized finite average used in declaration 11.

<a id="ref-centering-preserving"></a>**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation. The pinned
[definition](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/MeasurePreserving.lean#L43-L48)
is the exact analytic premise used to transport integrability along the base
orbit.

<a id="ref-centering-integrable"></a>**Mathlib contributors.**
[Integrable functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Function/L1Space/Integrable.html),
Mathlib 4 documentation. The pinned source records
[composition under measure preservation and finite-sum closure](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/L1Space/Integrable.lean#L381-L449).
Those closure results explain why the finite orbit sum and centered difference
are integrable.

<a id="ref-centering-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This is the primary asymptotic context. RMT-19 proves a finite reduction only
and neither invokes nor reproduces Kingman's theorem.

<a id="ref-centering-lalley"></a>**Steven P. Lalley.**
[Kingman's Subadditive Ergodic Theorem](https://galton.uchicago.edu/~lalley/Courses/Graz/Kingman.pdf),
University of Chicago lecture notes, undated, accessed 2026-07-21. These notes
are used only as a teaching guide to the later finite-block and ergodic proof
architecture, not as the source of an upstream Lean theorem.

<a id="ref-centering-karlsson-margulis"></a>**Anders Karlsson and Gregory A.
Margulis.**
[A Multiplicative Ergodic Theorem and Nonpositively Curved Spaces](https://doi.org/10.1007/s002200050750),
*Communications in Mathematical Physics* 208, 107-123, 1999. This paper is a
later geometric destination for integrable cocycles. Its almost-sure geodesic
tracking conclusion is not claimed, used, or formalized in RMT-19.

The exact upstream revision audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
