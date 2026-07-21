---
title: "Finite-Horizon Log-Positive Cocycle Integrability"
slug: "finite-horizon-log-positive-cocycle-integrability"
date: 2026-07-21
summary: "A textbook derivation of a real nonnegative log-positive cocycle envelope, its shifted one-step orbit-sum majorant, and the propagation of one explicit generator integrability hypothesis to every finite horizon."
lead: "The full extended log norm remembers collapse and contraction, but ordinary integrability needs a manageable real majorant. The positive logarithm supplies exactly that upper-growth envelope, provided we remain honest about the information it discards and stop before any asymptotic theorem."
draft: true
pro_reviewed: false
level: "Random matrix cocycles, positive logarithms, finite orbit sums, measure-preserving pullbacks, domination, and Bochner integrability"
reading_time: "85 to 115 minutes"
prerequisites: "Finite-time cocycle norm and extended-log-norm observables, one-sided shifted cocycle products, measurable real functions, finite sums, and basic measure-theoretic integrability; no ergodic theorem is assumed"
lean_module: "NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability"
toc: true
og_image: "finite-horizon-log-positive-cocycle-integrability-card.png"
og_image_alt: "Under an explicit one-step positive-log integrability hypothesis, the observable is pulled back along a measure-preserving base orbit, assembled into a finite integrable sum, and used to dominate every finite-horizon positive-log norm, while a side branch warns that collapse and contraction were discarded."
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

RMT-14 assigned every finite value of a one-sided complex matrix cocycle two
sizes. The ordinary norm

\[
N_k(\omega)=\lVert C(k,\omega)\rVert_\infty
\]

is a nonnegative real. The zero-faithful extended log norm

\[
L_k(\omega)
{} =
\operatorname{ENNReal.log}\lVert C(k,\omega)\rVert_{\mathrm e}
\]

takes values in the extended reals and sends a zero matrix exactly to bottom.
That is the correct finite-time object for remembering contraction and
annihilation.

RMT-15 asks a narrower analytic question. What explicit one-step hypothesis is
enough to prove that the **positive part** of logarithmic norm growth is
integrable at every finite horizon? The answer uses a second observable,

\[
P_k(\omega)=\log^+N_k(\omega),
\]

and a finite orbit-sum majorant,

\[
S_k(\omega)=\sum_{j=0}^{k-1}P_1(T^j\omega).
\]

The Lean module proves \(0\le P_k\le S_k\), states ordinary integrability of
\(P_1\) as an explicit assumption, transports that assumption along every
measure-preserving base iterate, adds the finite family, and concludes that
\(P_k\) is integrable for every natural \(k\).

This is an integrability envelope, not a Lyapunov observable. It discards
negative logarithmic growth and exact collapse. The module proves no
integrability of \(L_k\), no probability normalization, no ergodicity, no
normalized limit, and no subadditive or multiplicative ergodic theorem.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [The proof pipeline in one picture](#the-proof-pipeline-in-one-picture) | See one-step integrability become a finite-horizon conclusion |
| Information route | [What positive log keeps and destroys](#camp-one-what-positive-log-keeps-and-destroys) | Distinguish an upper-tail envelope from the zero-faithful extended log norm |
| Algebra route | [Finite-time subadditivity](#camp-three-finite-time-subadditivity) | Follow the shifted later block through the positive-log product estimate |
| Orbit route | [Build the one-step orbit sum](#camp-four-build-the-one-step-orbit-sum) | Understand the empty sum, successor rule, measurability, and domination induction |
| Measure route | [State the missing assumption](#camp-five-state-the-missing-assumption) | Separate measure preservation from integrability and probability |
| Proof route | [Domination closes the finite-horizon theorem](#camp-eight-domination-closes-the-finite-horizon-theorem) | Audit the absolute-value reduction and integrable majorant |
| Lean route | [The complete sixteen-declaration map](#the-complete-sixteen-declaration-map) | Check every public name and assumption in source order |
| Integrity route | [The boundary of the result](#summit-the-boundary-of-the-result) | Reject every asymptotic or contraction-sensitive overread |

### Learning objectives

By the summit, a reader should be able to:

1. define Mathlib's positive logarithm on a nonnegative real norm;
2. explain why it is real-valued, continuous, measurable, and nonnegative;
3. identify the collapse, contraction, and unit-norm regimes that it merges;
4. distinguish \(P_k\) from the extended-real \(L_k\);
5. explain why integrability of \(P_k\) does not imply integrability of \(L_k\);
6. derive positive-log subadditivity from norm submultiplicativity;
7. preserve the later shifted base point in that inequality;
8. compute the one-step orbit sum and its successor recurrence;
9. prove the orbit sum measurable by finite-sum closure;
10. derive \(P_k\le S_k\) by induction;
11. state <code>HasIntegrableGeneratorLogPlus</code> exactly;
12. distinguish an arbitrary preserved measure from a probability measure;
13. explain how measure-preserving iterates transport integrability;
14. explain why a finite sum of shifted one-step terms is integrable;
15. follow the final domination proof in Mathlib's <code>Integrable.mono'</code> interface;
16. locate every positive- and empty-dimensional edge case; and
17. list the missing ingredients before a Lyapunov exponent or ergodic limit.

## The proof pipeline in one picture

{{< reference-figure
  src="finite-horizon-log-positive-integrability.svg"
  alt="An explicit one-step positive-log integrability hypothesis is transported along every iterate of a measure-preserving base, producing integrable pulled-back terms whose finite orbit sum dominates the finite-horizon positive-log norm. A separate warning branch states that collapse and contraction were clipped away before this pipeline began."
  caption="**Finding:** one explicit integrability assumption on the generator's positive-log norm survives every measure-preserving base pullback, finite addition builds an integrable orbit sum, and pointwise domination transfers integrability to the finite-horizon positive-log observable. The side branch is part of the theorem's meaning: collapse and contraction were already clipped to zero, so the pipeline gives no negative-growth control, extended-log integrability, normalized limit, or Lyapunov exponent."
>}}

The figure contains two logical threads. The central thread is the proof of
finite-horizon integrability. The side thread records the information loss that
makes the proof unsuitable as a complete growth theory.

## Base camp: the inherited finite-time cocycle

Fix a measurable base type \(\Omega\), a finite matrix index type \(\iota\)
with decidable equality, an arbitrary measure \(\mu\), and a bundled
<code>DiscreteMatrixCocycle μ</code>. The cocycle supplies:

- a measurable base map \(T:\Omega\to\Omega\) that preserves \(\mu\);
- a measurable complex matrix generator \(A\);
- finite products \(C(k,\omega)\) with newest factor on the left; and
- the exact split

\[
C(m+k,\omega)
{} =
C(k,T^m\omega)C(m,\omega).
\]

RMT-14 adds the maximum absolute row-sum norm \(N_k\), ordinary measurability,
and the finite bound

\[
N_{m+k}(\omega)
\le
N_k(T^m\omega)N_m(\omega).
\]

It also adds \(L_k\), the extended log norm that is bottom exactly when the
matrix is zero. RMT-15 imports this complete layer and does not redefine its
norm convention or zero policy.

## Camp one: what positive log keeps and destroys

Mathlib defines the positive logarithm by

\[
\log^+r=\max(0,\operatorname{Real.log}r).
\]

The file opens the scoped notation <code>Real</code>, so Lean prints
<code>log⁺</code>. On nonnegative inputs, the behavior is

\[
\log^+r
{} =
\begin{cases}
0, & 0\le r\le1,\\
\log r, & 1\le r.
\end{cases}
\]

This function is continuous at zero because Lean's total
<code>Real.log</code> has value zero there and positive log is identically zero
through the unit interval. Continuity makes measurability easy.

The price is information loss:

| Norm regime | Zero-faithful \(L_k\) | Envelope \(P_k\) |
|---|---:|---:|
| Exact zero | \(\bot\) | \(0\) |
| Strictly between zero and one | Negative real | \(0\) |
| Exactly one | \(0\) | \(0\) |
| Above one | Positive real log | Same positive real log |

The first three rows become indistinguishable. That is why the word
“envelope” appears throughout this chapter.

### Declaration 1: <code>logPlusNormObservable</code>

The first definition applies positive log to the real norm observable:

~~~lean
def logPlusNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → ℝ :=
  fun ω ↦ log⁺ (C.normObservable k ω)
~~~

Its codomain is \(\mathbb R\), not <code>EReal</code>. Time \(k\) remains a
fixed natural parameter. No integral or normalization is part of the
definition.

### Declaration 2: <code>logPlusNormObservable_nonneg</code>

For every horizon and outcome,

\[
0\le P_k(\omega).
\]

The proof is the upstream theorem <code>Real.posLog_nonneg</code>. This
pointwise sign fact later lets Lean rewrite the real norm
\(\lvert P_k(\omega)\rvert\) as \(P_k(\omega)\) in the domination proof.

## Camp two: zero time, one step, measurability, and empty dimension

### Declaration 3: <code>logPlusNormObservable_zero</code>

RMT-15 proves

\[
P_0(\omega)=0
\]

in every finite matrix dimension. The proof explicitly splits the index type
into empty and nonempty cases.

In nonempty dimension, \(N_0=1\), so \(\log^+1=0\). In empty dimension,
\(N_0=0\), so \(\log^+0=0\). The theorem therefore needs neither
<code>Nonempty ι</code> nor <code>IsEmpty ι</code> in its public signature.

This is convenient for the envelope but demonstrates its lossiness. The
RMT-14 extended log norm distinguishes those two branches at time zero: zero
in positive dimension and bottom in empty dimension.

### Declaration 4: <code>logPlusNormObservable_one</code>

At one step, the cocycle value is the generator, hence

\[
P_1(\omega)=\log^+\lVert A(\omega)\rVert_\infty.
\]

This equality of functions is the term named in the later integrability
assumption. No nonzero-generator hypothesis appears.

### Declaration 5: <code>measurable_logPlusNormObservable</code>

RMT-14 already proves \(N_k:\Omega\to\mathbb R\) measurable. Mathlib proves
<code>Real.continuous_posLog</code>, hence the positive logarithm is measurable.
Composition gives ordinary measurability of \(P_k\) at every fixed horizon.

This is not integrability. A measurable nonnegative function may have an
infinite integral with respect to \(\mu\).

### Declaration 6: <code>logPlusNormObservable_add_le</code>

The module turns norm submultiplicativity into

\[
P_{m+k}(\omega)
\le
P_k(T^m\omega)+P_m(\omega).
\]

Camp three derives the exact proof.

### Declaration 7: <code>logPlusNormObservable_eq_zero_of_isEmpty</code>

If \(\iota\) is empty, RMT-14 says every finite norm \(N_k\) is zero. RMT-15
simplifies the definition to prove

\[
P_k=\bigl(\omega\mapsto0\bigr)
\]

for every horizon. It does not globally assume positive matrix dimension.

## Camp three: finite-time subadditivity

Start from the checked norm inequality

\[
N_{m+k}(\omega)
\le
N_k(T^m\omega)N_m(\omega).
\]

Both sides are nonnegative. Mathlib's
<code>Real.posLog_le_posLog</code> therefore transports the inequality through
the positive logarithm. Its two-factor estimate then gives

\[
\begin{aligned}
P_{m+k}(\omega)
&\le \log^+\!\left(N_k(T^m\omega)N_m(\omega)\right)\\
&\le P_k(T^m\omega)+P_m(\omega).
\end{aligned}
\]

Unlike the extended logarithm's exact product-to-sum law, positive log only
supplies an inequality. If one factor contracts and another expands, clipping
the contracting contribution to zero enlarges the right side.

The shifted base point remains essential. The later \(k\)-step block begins
after the early \(m\)-step orbit, so its observable is evaluated at
\(T^m\omega\). Real addition is commutative, but that does not license moving
the matrix block back to the wrong base state.

## Camp four: build the one-step orbit sum

### Declaration 8: <code>orbitLogPlusSum</code>

Define

\[
S_k(\omega)
{} =
\sum_{j\in\operatorname{range}(k)}P_1(T^j\omega)
{} =
\sum_{j=0}^{k-1}P_1(T^j\omega).
\]

The sum follows the same forward base orbit used to generate the cocycle.
Each summand is the one-step expanding envelope seen at the correct shifted
environment.

### Declaration 9: <code>orbitLogPlusSum_zero</code>

The range of zero is empty, so

\[
S_0=\bigl(\omega\mapsto0\bigr).
\]

This is an equality of functions, not merely a pointwise simplification.

### Declaration 10: <code>orbitLogPlusSum_succ</code>

Extending the horizon appends the newest one-step term:

\[
S_{k+1}(\omega)
{} =
S_k(\omega)+P_1(T^k\omega).
\]

Lean obtains this from <code>Finset.sum_range_succ</code>. The index \(k\) is
the first base state not already included in the range of \(k\).

### Declaration 11: <code>measurable_orbitLogPlusSum</code>

Every base iterate \(T^j\) is measurable because the stored
measure-preserving map is measurable. Declaration 5 gives measurability of
\(P_1\). Composing them makes every summand measurable, and
<code>Finset.measurable_sum</code> closes the finite sum.

The proof does not use integrability. Measurability of \(S_k\) is unconditional
within the cocycle interface.

### Declaration 12: <code>logPlusNormObservable_le_orbitLogPlusSum</code>

The main pointwise majorization is

\[
P_k(\omega)\le S_k(\omega).
\]

The proof is induction on \(k\).

At zero, declarations 3 and 9 make both sides zero. For the successor step,
declaration 6 is applied with an early prefix of length \(k\) and a later block
of length one:

\[
P_{k+1}(\omega)
\le
P_1(T^k\omega)+P_k(\omega).
\]

The induction hypothesis replaces \(P_k\) by \(S_k\). Declaration 10 then
identifies the result with \(S_{k+1}\), after a final commutation of real
addition. The matrix product itself is never commuted.

## Camp five: state the missing assumption

### Declaration 13: <code>HasIntegrableGeneratorLogPlus</code>

The module names exactly one new hypothesis:

~~~lean
def HasIntegrableGeneratorLogPlus
    (C : DiscreteMatrixCocycle (ι := ι) μ) : Prop :=
  Integrable (C.logPlusNormObservable 1) μ
~~~

In mathematical notation,

\[
P_1\in L^1(\mu).
\]

Mathlib's <code>Integrable</code> combines almost-everywhere strong
measurability with finiteness of the integral of the norm. Declaration 5 has
already proved the stronger ordinary measurability of this particular
real-valued function. Because \(P_1\) is nonnegative, the remaining size
condition controls only the positive logarithmic tail of the generator norm.

This assumption is not derived from <code>C.base_preserving</code>. Measure
preservation says how integrals behave after composing with the base map. It
does not say the original integrand has a finite integral.

The measure remains a raw <code>Measure Ω</code>. There is no
<code>IsProbabilityMeasure μ</code> instance, no assertion
\(\mu(\Omega)=1\), and no expectation notation.

## Camp six: pull integrability along the base orbit

### Declaration 14: <code>HasIntegrableGeneratorLogPlus.integrable_at_base_iterate</code>

For every natural \(j\), the cocycle already proves

\[
T^j\text{ preserves }\mu.
\]

Mathlib's
<code>MeasurePreserving.integrable_comp_of_integrable</code> then transports
the one-step assumption:

\[
\omega\longmapsto P_1(T^j\omega)
\quad\text{is integrable with respect to }\mu.
\]

The theorem uses composition explicitly. It neither asserts independence of
the shifted terms nor gives them a joint law. Their integrals are preserved
because the base iterate preserves the same measure.

## Camp seven: add the finite majorant

### Declaration 15: <code>HasIntegrableGeneratorLogPlus.integrable_orbitLogPlusSum</code>

Declaration 14 proves each summand in \(S_k\) integrable. Mathlib's
<code>integrable_finsetSum</code> then gives

\[
S_k\in L^1(\mu)
\]

for every finite \(k\). There is no infinite series, monotone-convergence
argument, or uniform-in-\(k\) bound. The theorem closes because
<code>Finset.range k</code> is finite.

## Camp eight: domination closes the finite-horizon theorem

### Declaration 16: <code>HasIntegrableGeneratorLogPlus.integrable_logPlusNormObservable</code>

The final theorem states

\[
P_k\in L^1(\mu)
\]

for every natural \(k\), under declaration 13.

Mathlib's <code>Integrable.mono'</code> needs three ingredients:

1. an integrable real majorant, supplied by declaration 15;
2. almost-everywhere strong measurability of \(P_k\), supplied by declaration
   5; and
3. an almost-everywhere norm bound.

The third goal initially has the Banach-space form

\[
\lvert P_k(\omega)\rvert\le S_k(\omega).
\]

Declaration 2 rewrites the absolute value of the nonnegative left side to
\(P_k(\omega)\). Declaration 12 then supplies the desired pointwise inequality,
which is stronger than the almost-everywhere requirement.

This proof concludes only finite-horizon integrability. It gives no single
integrable function dominating all horizons and no statement about the
sequence after division by \(k\).

## The complete sixteen-declaration map

All declarations share a measurable base space \(\Omega\), a finite matrix
index type \(\iota\) with decidable equality, an arbitrary measure \(\mu\), and
a bundled complex <code>DiscreteMatrixCocycle</code>. The final three theorems
add only the named one-step integrability hypothesis.

| # | Declaration | Additional assumption | Checked content |
|---:|---|---|---|
| 1 | <code>logPlusNormObservable</code> | None | Defines the real positive logarithm of the finite-time cocycle norm |
| 2 | <code>logPlusNormObservable_nonneg</code> | None | Proves pointwise nonnegativity |
| 3 | <code>logPlusNormObservable_zero</code> | None | Time-zero envelope is identically zero in every finite dimension |
| 4 | <code>logPlusNormObservable_one</code> | None | One-step envelope is positive log of the generator norm |
| 5 | <code>measurable_logPlusNormObservable</code> | None | Every fixed-horizon envelope is ordinarily measurable |
| 6 | <code>logPlusNormObservable_add_le</code> | None | Positive-log growth is subadditive across the shifted cocycle split |
| 7 | <code>logPlusNormObservable_eq_zero_of_isEmpty</code> | <code>IsEmpty ι</code> | Every envelope is zero in empty matrix dimension |
| 8 | <code>orbitLogPlusSum</code> | None | Defines the finite sum of shifted one-step envelopes |
| 9 | <code>orbitLogPlusSum_zero</code> | None | Empty orbit sum is the constant zero function |
| 10 | <code>orbitLogPlusSum_succ</code> | None | A successor horizon appends the newest shifted term |
| 11 | <code>measurable_orbitLogPlusSum</code> | None | Every finite orbit sum is ordinarily measurable |
| 12 | <code>logPlusNormObservable_le_orbitLogPlusSum</code> | None | Finite-horizon envelope is pointwise bounded by the orbit sum |
| 13 | <code>HasIntegrableGeneratorLogPlus</code> | None | Names integrability of the one-step envelope as a proposition |
| 14 | <code>HasIntegrableGeneratorLogPlus.integrable_at_base_iterate</code> | Declaration 13 | Every shifted one-step pullback is integrable |
| 15 | <code>HasIntegrableGeneratorLogPlus.integrable_orbitLogPlusSum</code> | Declaration 13 | Every finite orbit sum is integrable |
| 16 | <code>HasIntegrableGeneratorLogPlus.integrable_logPlusNormObservable</code> | Declaration 13 | Every finite-horizon positive-log norm is integrable |

No declaration adds positive matrix dimension, probability normalization,
ergodicity, invertibility, nonvanishing, or a moment condition beyond the
explicit one-step positive-log integrability proposition.

## Assumption and type ledger

| Object or assumption | Type or role | What it supplies | What it does not supply |
|---|---|---|---|
| Base measure | <code>Measure Ω</code> | The measure used by preservation and integrability | Probability mass, finiteness, sigma-finiteness, or expectation |
| Base map | <code>Ω → Ω</code> with measure preservation | Measurable natural iterates and integrability-preserving pullbacks | Ergodicity, mixing, independence, or invertibility |
| Finite cocycle norm | <code>Ω → ℝ</code> | Measurable nonnegative maximum-row-sum size | A law, expectation, or limit |
| Extended log norm \(L_k\) | <code>Ω → EReal</code> | Bottom-at-zero, negative contraction, finite-time subadditivity | Integrability in RMT-15 |
| Positive-log envelope \(P_k\) | <code>Ω → ℝ</code> | Measurability, nonnegativity, finite-time subadditivity | Collapse or contraction information |
| Orbit sum \(S_k\) | <code>Ω → ℝ</code> | A finite nonnegative majorant assembled from one-step terms | Uniform-in-time or asymptotic domination |
| Generator assumption | <code>Integrable P₁ μ</code> | Integrability of every shifted term and finite horizon | Negative-log control, probability, ergodicity, or a limit theorem |

The word “integrable” here always refers to the displayed raw measure. It is
not silently upgraded to “finite expected value.”

## Why the positive tail is useful and insufficient

Long products can become large because one or more finite factors have large
operator norm. The inequality

\[
P_k(\omega)\le\sum_{j=0}^{k-1}P_1(T^j\omega)
\]

reduces control of that expanding part to repeated copies of one generator
observable. This is exactly the sort of reduction a later limit theorem may
need: it replaces a complicated \(k\)-step matrix product by a finite sum of
one-step scalar upper bounds.

The reduction is one-sided in two different senses.

First, it is an **upper-growth** estimate. Norm submultiplicativity and
positive-log clipping can only enlarge the scalar budget. Cancellation between
matrix factors, changes in maximizing directions, and contraction after
expansion all create slack.

Second, it controls only the **positive logarithmic part**. A full logarithm
can have a large negative part even when its positive part vanishes. If a
cocycle value is exactly zero, the extended logarithm is bottom while the
positive-log envelope is zero. If a nonzero value has norm very close to zero,
its extended log is a large negative real while its envelope is again zero.

These two facts explain the next dependency barrier. A theorem about a top
Lyapunov growth rate may use an integrable positive generator log as one
hypothesis, but a theorem about invertible splittings, negative exponents, or
inverse dynamics generally needs additional control. RMT-15 does not guess
that control. It exposes the positive envelope as one reusable component and
leaves every negative or inverse convention to a later module.

### Integrability without probability

The propagation proof works for an arbitrary measure because each step is a
general measure-theoretic closure law:

1. a measure-preserving pullback keeps an already integrable function
   integrable;
2. a finite sum of integrable real functions is integrable; and
3. a measurable real function dominated in norm by an integrable real
   function is integrable.

None of these principles needs total mass one. This generality is useful, but
it also limits the vocabulary. The theorem proves an integral is finite. It
does not define a mean growth rate, an expectation, or a typical random
outcome. Those notions require probability structure to be added explicitly.

## A complete one-dimensional calculation

Consider four one-dimensional generator matrices whose chronological absolute
values are

\[
\frac12,\qquad 3,\qquad \frac14,\qquad 4.
\]

Because one-dimensional matrix multiplication is scalar multiplication, the
four-step norm is

\[
N_4
{} =
\frac12\cdot3\cdot\frac14\cdot4
{} =
\frac32.
\]

The finite-horizon envelope is therefore

\[
P_4=\log\!\left(\frac32\right).
\]

The one-step positive logs are

\[
0,\qquad\log3,\qquad0,\qquad\log4,
\]

so the orbit sum is

\[
S_4=\log3+\log4=\log12.
\]

The checked style of bound gives \(P_4\le S_4\). The gap is intentional: the
envelope threw away the two negative logarithms that would have reduced the
sum. If the first factor were zero instead, then the full extended log norm
would be bottom, while both the finite-horizon positive log and the zero
factor's one-step positive log would be zero. Integrability of the envelope
would remain silent about collapse.

These values are a teaching example, not measured random-matrix data.

## Empty dimension is easier only because information was clipped

In empty matrix dimension, every finite matrix is the unique empty matrix and
its selected norm is zero. RMT-14 therefore gives \(L_k=\bot\), faithfully
recording exact collapse. RMT-15 instead gives \(P_k=0\) for all \(k\).

The orbit sum is then mathematically a finite sum of zeros. The checked module
exports the zero theorem for \(P_k\), but it does not add separate named
empty-dimension declarations for \(S_k\) or
<code>HasIntegrableGeneratorLogPlus</code>. Downstream code can derive those
specializations from the general definitions when useful.

This comparison is the cleanest warning against calling \(P_k\) a Lyapunov
observable. The envelope behaves especially well at zero precisely because it
forgets the most contracting endpoint.

## Proof architecture

The sixteen declarations form four layers.

### Positive-log observable layer

- RMT-14 supplies <code>normObservable</code> and its measurability.
- <code>Real.posLog_nonneg</code>, <code>Real.posLog_zero</code>, and
  <code>Real.posLog_one</code> settle the sign and time-zero branches.
- <code>Real.continuous_posLog.measurable</code> supplies the scalar
  measurable map.
- <code>Real.posLog_le_posLog</code> and <code>Real.posLog_mul</code> turn norm
  submultiplicativity into positive-log subadditivity.

### Orbit-sum layer

- <code>Finset.range</code> fixes the finite chronology.
- <code>Finset.sum_range_succ</code> exposes the newest term.
- finite-sum measurability builds \(S_k\).
- induction combines the successor cocycle split with the orbit-sum recurrence.

### Pullback-integrability layer

- RMT-13 supplies measure preservation for every natural base iterate.
- <code>MeasurePreserving.integrable_comp_of_integrable</code> transports the
  generator hypothesis to each shifted term.
- <code>integrable_finsetSum</code> integrates the finite orbit sum.

### Domination layer

- declaration 5 supplies almost-everywhere strong measurability;
- declaration 2 converts the real norm of \(P_k\) to \(P_k\); and
- declaration 12 supplies the bound consumed by <code>Integrable.mono'</code>.

No proof uses an infinite sum, expectation, conditional expectation,
subadditive ergodic theorem, singular value, determinant, inverse, or matrix
derivative.

## Common wrong turns

### Calling positive log the logarithm of the norm

It agrees with the ordinary log only above unit norm. At zero and below one it
is clipped to zero. Use “positive-log envelope” or “log-positive norm,” not an
unqualified “log norm,” when the distinction matters.

### Inferring extended-log integrability

The theorem concerns \(P_k:\Omega\to\mathbb R\). The predecessor
\(L_k:\Omega\to\mathrm{EReal}\) may be bottom wherever the matrix vanishes and
may have an uncontrolled negative tail. No theorem in RMT-15 transfers
integrability from \(P_k\) to \(L_k\).

### Treating measure preservation as an integrability bound

Preservation transports an integrability fact after it is supplied. It does
not make an arbitrary measurable function integrable. Declaration 13 is an
assumption for exactly this reason.

### Calling the integral an expectation

The measure is not assumed to have total mass one. An integral against a raw
measure becomes an expectation only after a probability structure or explicit
normalization is proved.

### Reading the orbit sum as an independent sum

All terms come from one base orbit. No independence or identical-distribution
hypothesis appears. Finite-sum integrability needs neither.

### Forgetting the base shift

The newest one-step term at a successor horizon is evaluated at
\(T^k\omega\). Replacing it by \(P_1(\omega)\) would describe repeated use of
one environment, not the generator sampled along the orbit.

### Claiming uniform control in time

For every fixed \(k\), a finite sum is integrable. The module gives no bound on
the integral that is uniform in \(k\) and no integrable random variable
dominating the whole sequence.

### Invoking Kingman immediately

RMT-15 supplies a finite subadditive family and a positive-tail integrability
envelope. A checked theorem application must still match the theorem's exact
codomain, stationarity convention, probability hypotheses, lower-tail policy,
and limit statement. None is invoked here.

### Calling the conclusion a Lyapunov exponent

A Lyapunov exponent is a normalized asymptotic growth quantity. RMT-15 defines
neither division by time nor a limit and proves no invariant splitting.

### Assuming a Jacobian origin

The generator remains an arbitrary measurable complex matrix map. A nonlinear
derivative interpretation needs a separately formalized state space,
differentiability, coordinate representation, and chain rule.

## Exercises from trailhead to summit

### Trailhead

1. Evaluate \(\log^+r\) at \(r=0\), \(r=1/2\), \(r=1\), and \(r=3\).
2. State which of those four values can be distinguished by the extended log
   norm but not by positive log.
3. Explain why \(P_0=0\) in both positive and empty matrix dimension.
4. Verify the four-factor scalar example and its orbit-sum upper bound.
5. Give two nonzero matrices whose product is zero, then compare the extended
   and positive log norms of the product.

### Mid-mountain

6. Derive positive-log subadditivity from norm submultiplicativity and the two
   Mathlib positive-log inequalities.
7. Expand \(S_3(\omega)\) with every shifted base point written explicitly.
8. Prove the successor identity for \(S_k\) from the finite range.
9. Reconstruct the induction proving \(P_k\le S_k\).
10. Explain which steps use ordinary measurability and which use measure
    preservation.
11. Show why integrability of \(P_1\) transports to \(P_1\circ T^j\).
12. Explain why a finite sum needs no independence assumption.

### Summit

13. Translate <code>Integrable.mono'</code> into the three obligations used by
    declaration 16.
14. Construct a cocycle with \(P_1=0\) everywhere but an extended log norm
    equal to bottom somewhere.
15. Explain why positive-tail integrability does not control inverse norms.
16. List the additional choices required before a precise Kingman theorem can
    be stated in this project.
17. List the stronger hypotheses usually associated with an Oseledets
    splitting and identify which are absent here.
18. Design a separate derivative-cocycle theorem and name the chain-rule facts
    it would need.

## Reproduce the checked slice

From the repository root, load the pinned Lean toolchain and compile the
module with warnings treated as errors:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/LogPlusIntegrability.lean
~~~

Build the named module and its dependencies:

~~~sh
lake build NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability
~~~

Return to the repository root and check the complete teaching surface:

~~~sh
cd ..
make site-check
~~~

The repository-wide gate is <code>make check</code>. Passing automated checks
does not publish this draft. Human mathematical, source, accessibility, and
editorial reviews remain separate publication gates.

## Summit: the boundary of the result

| Topic | Status in RMT-15 |
|---|---|
| Real positive-log finite-time norm | Defined |
| Pointwise nonnegativity | Checked |
| Time-zero value zero in every finite dimension | Checked |
| One-step generator identity | Checked |
| Ordinary measurability at each fixed horizon | Checked |
| Positive-log subadditivity across the shifted split | Checked |
| Empty-dimensional envelope identically zero | Checked |
| Finite shifted one-step orbit sum | Defined |
| Empty-sum and successor identities | Checked |
| Orbit-sum measurability | Checked |
| Pointwise finite-horizon domination by the orbit sum | Checked |
| One-step positive-log integrability | Explicit hypothesis |
| Integrability after every natural base iterate | Checked under the hypothesis |
| Integrability of every finite orbit sum | Checked under the hypothesis |
| Integrability of every finite-horizon positive-log norm | Checked under the hypothesis |
| Integrability of the extended-real log norm | Not proved |
| Control of contraction, bottom values, or a negative logarithmic tail | Not proved and deliberately erased by positive log |
| Inverse-norm or smallest-singular-value integrability | Not stated |
| Probability normalization or expectation | Not assumed or defined |
| Ergodicity, mixing, independence, or identical distribution | Not assumed or proved |
| Uniform-in-time integrable domination | Not proved |
| Normalized finite-time growth | Not defined |
| Almost-sure or integral convergence | Not proved |
| Kingman or Furstenberg-Kesten theorem | Not invoked |
| Lyapunov exponent or spectrum | Not defined or proved |
| Oseledets filtration or invariant splitting | Not invoked or proved |
| Two-sided time or invertible cocycle | Not assumed |
| Nonlinear derivative or random-Jacobian representation | Not connected |

The checked summit is modest but useful: one integrable generator envelope
controls the positive part of every finite-horizon norm through a completely
explicit orbit-sum proof.

## Where to continue

[Integrated Log-Positive Cocycle Growth and Its Deterministic Fekete Limit]({{< relref "/knowledge-base/deep-dives/integrated-log-positive-cocycle-growth-and-fekete-limit" >}})
is the immediate RMT-16 successor. It integrates the finite-horizon envelopes,
uses preservation under the same explicit one-step integrability hypothesis to
obtain a subadditive real sequence, and proves convergence of its positive-time
normalized values by Mathlib's deterministic Fekete theorem. It still makes no
probability, ergodic, samplewise, or Lyapunov claim.

The
{{< refterm "log-positive-integrability-envelope" "log-positive integrability envelope" >}}
glossary entry is the compact guide to clipping, the orbit majorant, and the
measure-theoretic assumption.

[Finite-Time Norm and Extended-Log-Norm Observables for Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/finite-time-norm-and-extended-log-norm-cocycle-observables" >}})
is the immediate predecessor. It develops the exact row-sum norm, the
zero-faithful extended logarithm, and finite-time subadditivity before any
integrability choice.

[Generator-Presented One-Sided Discrete Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/generator-presented-one-sided-discrete-matrix-cocycles" >}})
supplies the base orbit, measure-preserving natural iterates, and the exact
later-block-left product law.

The next asymptotic layer must choose a precise theorem and encode every one of
its hypotheses. In particular, it must decide how to handle the negative or
bottom part of \(L_k\), whether \(\mu\) becomes a probability measure, whether
ergodicity is assumed, and what kind of limit is sought. Those decisions are
not retroactively included in RMT-15.

## References

<a id="ref-log-plus-deep-poslog"></a>**Mathlib contributors.**
[The positive part of the logarithm](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/SpecialFunctions/Log/PosLog.html),
Mathlib 4 documentation. This official source defines
<code>Real.posLog</code> and proves its nonnegativity, zero and one values,
continuity, monotonicity on nonnegative inputs, and product upper bound.

<a id="ref-log-plus-deep-integrable"></a>**Mathlib contributors.**
[Bochner integrability](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Function/L1Space/Integrable.html),
Mathlib 4 documentation. This official source supplies
<code>MeasurePreserving.integrable_comp_of_integrable</code>,
<code>integrable_finsetSum</code>, and <code>Integrable.mono'</code>.

<a id="ref-log-plus-deep-measure-preserving"></a>**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation. The exact local API authority is the pinned checkout;
RMT-13 packages natural-iterate preservation for the cocycle base.

<a id="ref-log-plus-deep-furstenberg-kesten"></a>**Harry Furstenberg and Harry Kesten.**
[Products of Random Matrices](https://doi.org/10.1214/aoms/1177705909),
*The Annals of Mathematical Statistics* 31(2), 457-469, 1960. This primary
source motivates logarithmic growth of random matrix products. RMT-15 proves
none of its asymptotic conclusions.

<a id="ref-log-plus-deep-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source establishes a subadditive ergodic theorem under additional
measure-theoretic hypotheses. RMT-15 supplies only a finite-time positive-tail
integrability layer.

<a id="ref-log-plus-deep-oseledets"></a>**V. I. Oseledets.**
[A multiplicative ergodic theorem. Characteristic Ljapunov exponents of dynamical systems](https://www.mathnet.ru/eng/mmo214),
*Transactions of the Moscow Mathematical Society* 19 (1968), 197-231. This
primary source is an asymptotic destination. The present module proves no
exponent, spectrum, filtration, or splitting.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
