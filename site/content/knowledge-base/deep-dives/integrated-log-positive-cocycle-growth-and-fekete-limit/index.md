---
title: "Integrated Log-Positive Cocycle Growth and Its Deterministic Fekete Limit"
slug: "integrated-log-positive-cocycle-growth-and-fekete-limit"
date: 2026-07-21
summary: "A textbook derivation of the subadditive real sequence obtained by integrating finite-horizon log-positive cocycle growth, together with its positive-time Fekete infimum and deterministic convergence theorem."
lead: "Finite-horizon integrability becomes an asymptotic theorem only after the outcome dependence has been integrated away. This chapter follows that passage declaration by declaration while keeping raw measure, totalized integrals, zero time, and samplewise nonclaims visible."
draft: true
pro_reviewed: false
level: "Matrix cocycles, Bochner integration, measure-preserving pullbacks, subadditive real sequences, normalization, infima, and deterministic Fekete convergence"
reading_time: "95 to 130 minutes"
prerequisites: "One-sided discrete matrix cocycles, finite-horizon log-positive envelopes, finite sums, measure-preserving maps, ordinary real-valued integrability, and elementary limits; no ergodic theorem is assumed"
lean_module: "NonlinearDynamics.Random.RandomCocycles.IntegratedLogPlusGrowth"
toc: true
og_image: "integrated-log-positive-cocycle-growth-and-fekete-limit-card.png"
og_image_alt: "A dependency map shows a shifted cocycle bound and finite-horizon integrability propagated from the explicit one-step hypothesis joining at the justified integral step that yields scalar subadditivity. A separate unconditional branch gives nonnegative normalized values and a lower bound. Both feed a deterministic positive-time Fekete limit, while a warning excludes samplewise and ergodic conclusions."
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

RMT-15 built a nonnegative finite-horizon envelope for a one-sided matrix
cocycle:

\[
P_k(\omega)
{} =
\log^+\lVert C(k,\omega)\rVert_\infty.
\]

It proved that one explicit assumption, integrability of \(P_1\), propagates
to \(P_k\) for every fixed natural horizon. RMT-16 asks what deterministic
asymptotic statement can be obtained from exactly that layer, without adding
probability, ergodicity, invertibility, or a negative-log hypothesis.

The answer is deliberately ordered. First integrate each horizon:

\[
I_k=\int_\Omega P_k(\omega)\,d\mu(\omega).
\]

Then prove that \(I:\mathbb N\to\mathbb R\) is subadditive. Only after that
scalar reduction define

\[
A_k=\frac{I_k}{k}
\]

and invoke Mathlib's deterministic Fekete theorem. The resulting checked limit
is

\[
A_k\longrightarrow
\gamma_\mu^+(C)
{} =
\inf_{k\ge1}\frac{I_k}{k}.
\]

This is the project's first asymptotic theorem for the integrated
log-positive cocycle envelope. It is not a theorem about the convergence of
\(P_k(\omega)/k\), not an application of Kingman, and not a Lyapunov exponent.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [The proof braid](#the-proof-braid) | See the algebraic and analytic strands merge at Fekete |
| Type route | [Three objects and three quantifier patterns](#three-objects-and-three-quantifier-patterns) | Separate functions of outcomes from deterministic numbers |
| Integral route | [Camp one: the totalized integral](#camp-one-the-totalized-integral) | Understand why a real integral value is not an integrability certificate |
| Dynamics route | [Camp two: preserved pullback integrals](#camp-two-preserved-pullback-integrals) | Remove a base shift only after integration |
| Bound route | [Camp three: integrate the finite orbit majorant](#camp-three-integrate-the-finite-orbit-majorant) | Derive the exact orbit-sum integral and linear bound |
| Sequence route | [Camp four: scalar subadditivity](#camp-four-scalar-subadditivity) | Package the integrated values for Mathlib |
| Limit route | [Summit: the deterministic Fekete limit](#summit-the-deterministic-fekete-limit) | Read the positive-index infimum and convergence statement exactly |
| Lean route | [The complete thirteen-declaration map](#the-complete-thirteen-declaration-map) | Audit every public declaration in source order |
| Integrity route | [What remains outside the theorem](#what-remains-outside-the-theorem) | Reject samplewise, probabilistic, and Lyapunov overreads |

### Learning objectives

By the summit, a reader should be able to:

1. distinguish \(P_k(\omega)\), \(I_k\), and \(A_k\) by type and quantifiers;
2. explain why Mathlib's Bochner integral is defined even when its integrand
   is not integrable;
3. identify which RMT-16 declarations are unconditional and why that does not
   make their integrals analytically meaningful;
4. explain where RMT-15's one-step integrability hypothesis enters;
5. use measure preservation to identify a shifted pullback integral;
6. integrate the finite orbit-sum majorant term by term;
7. explain why no independence hypothesis is needed;
8. derive \(I_k\le kI_1\);
9. derive \(I_{m+k}\le I_m+I_k\) without changing the cocycle product order;
10. read Mathlib's <code>Subadditive</code> predicate;
11. distinguish the formal value \(A_0=0\) from a zero-time average;
12. read <code>Subadditive.lim</code> as an infimum over positive indices;
13. explain why Fekete ratios need not be monotone;
14. distinguish a raw-measure integral from an expectation;
15. qualify finite scalar rescaling of the measure correctly;
16. explain why deterministic convergence of \(A_k\) says nothing directly
    about samplewise convergence; and
17. identify every additional direction left for ergodic and Lyapunov theory.

## The proof braid

{{< reference-figure
  src="integrated-log-positive-cocycle-growth-fekete.svg"
  alt="Three dependency lanes lead to the deterministic Fekete limit. A shifted pointwise bound, an unconditional preserved-shift integral identity, and finite-horizon integrability obtained from the explicit one-step hypothesis jointly justify the integral step that yields scalar subadditivity. Separately, log-positive nonnegativity gives normalized nonnegativity and a lower bound without an integrability hypothesis. Subadditivity and the lower bound merge at Fekete. A warning says that outcome dependence was integrated away and no samplewise limit is proved."
  caption="**Finding:** the algebraic ingredients and propagated integrability meet before scalar subadditivity: finite-horizon integrability is what licenses integral monotonicity and additivity. The lower-bound branch is different and unconditional; log-positive nonnegativity survives the totalized integral and normalization without <code>hC</code>. Fekete consumes the resulting subadditivity proof together with that lower bound. Since the outcome variable has already been integrated away, the theorem supplies no almost-everywhere, ergodic, limit-interchange, or Lyapunov conclusion."
>}}

The algebra lane supplies the shifted pointwise inequality and the
preserved-shift integral identity. RMT-15's explicit one-step hypothesis
separately propagates integrability to each finite horizon. Those dependencies
join before the integral inequality: finite-horizon integrability licenses
monotonicity and additivity, after which the shifted identity produces ordinary
scalar subadditivity.

The order lane does not depend on that integrability hypothesis. Pointwise
log-positive nonnegativity gives nonnegative totalized integrals, nonnegative
normalized values, and zero as a lower bound. Fekete needs the subadditivity
branch and this unconditional lower-bound branch: neither alone supplies the
convergence theorem used here.

## Three objects and three quantifier patterns

Fix a measurable base type \(\Omega\), a finite matrix index type \(\iota\)
with decidable equality, an arbitrary measure \(\mu\), and a bundled
<code>DiscreteMatrixCocycle μ</code>. The cocycle has a measurable base map
\(T\) preserving \(\mu\), a measurable complex matrix generator, and finite
products satisfying

\[
C(m+k,\omega)
{} =
C(k,T^m\omega)C(m,\omega).
\]

RMT-15 supplies three inherited objects:

\[
P_k(\omega)=\log^+\lVert C(k,\omega)\rVert_\infty,
\]

\[
S_k(\omega)=\sum_{j=0}^{k-1}P_1(T^j\omega),
\]

and the proposition

~~~lean
C.HasIntegrableGeneratorLogPlus
~~~

meaning exactly that \(P_1\) is integrable against \(\mu\). From it, RMT-15
proves that \(P_k\), every shifted \(P_1\), and \(S_k\) are integrable at each
fixed natural horizon.

RMT-16 adds two scalar sequences:

| Symbol | Lean expression | Type | Remaining variable |
|---|---|---|---|
| \(P_k(\omega)\) | <code>C.logPlusNormObservable k ω</code> | \(\Omega\to\mathbb R\) after fixing \(k\) | Base outcome \(\omega\) |
| \(I_k\) | <code>C.integratedLogPlusNorm k</code> | \(\mathbb R\) | Horizon \(k\) |
| \(A_k\) | <code>C.normalizedIntegratedLogPlusNorm k</code> | \(\mathbb R\) | Horizon \(k\) |

The checked arrow of construction is

\[
P_k(\omega)
\longrightarrow
I_k
\longrightarrow
A_k
\longrightarrow
\lim_{k\to\infty}A_k.
\]

The arrow

\[
P_k(\omega)
\longrightarrow
\frac{P_k(\omega)}{k}
\longrightarrow
\text{samplewise limit}
\]

belongs to another theorem. RMT-16 neither proves that route nor exchanges its
limit with an integral.

## Camp one: the totalized integral

### Declaration 1: <code>integratedLogPlusNorm</code>

The module begins with an unconditional definition:

~~~lean
def integratedLogPlusNorm
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : ℝ :=
  ∫ ω, C.logPlusNormObservable k ω ∂μ
~~~

Mathematically, this looks like \(I_k=\int P_k\,d\mu\). The Lean type is a
total function \(\mathbb N\to\mathbb R\). No <code>hC</code> argument occurs
in the definition.

That is possible because Mathlib's Bochner integral is totalized. When a
real-valued function is integrable, <code>MeasureTheory.integral</code> gives
its Bochner integral. When the function is not integrable, it returns zero.
The theorem <code>integral_undef</code> exposes this second branch.

The convention is useful for a total proof language, but it changes how the
definition should be read. A term of type \(\mathbb R\) is not evidence that
the integrand is integrable. In ordinary extended integration, a nonnegative
nonintegrable function suggests an infinite value. The totalized Bochner API
instead supplies zero because its codomain remains an ordinary real vector
space.

{{< panel "warning" >}}
**Do not infer finiteness from the codomain.** Without
<code>HasIntegrableGeneratorLogPlus</code>, the bare \(I_k\) is a total Lean
value that may be the artificial zero assigned to a nonintegrable integrand.
The shifted-pullback equality remains valid for this totalized value, but the
finite orbit-sum identity, bounds, subadditivity, rate, and convergence use the
explicit hypothesis.
{{< /panel >}}

Consider an infinite-measure base and the constant real function one. That
function is not integrable. Mathlib's totalized integral is nevertheless zero.
This stress test explains why the first definition is unconditional without
turning it into an analytic moment theorem.

### Declaration 2: <code>integratedLogPlusNorm_zero</code>

RMT-15 proves \(P_0(\omega)=0\) for every base point and every finite matrix
dimension, including the empty index type. Integration therefore gives

\[
I_0=0.
\]

No integrability premise is needed because the zero function is integrable and
its integral is zero.

### Declaration 3: <code>integratedLogPlusNorm_nonneg</code>

The finite envelope satisfies \(P_k(\omega)\ge0\), so Mathlib's
<code>integral_nonneg</code> yields

\[
0\le I_k.
\]

This theorem is also unconditional. It still does not prove integrability.
In the nonintegrable branch, Mathlib has set \(I_k=0\), and the statement
reduces to \(0\le0\).

The first camp therefore contains three sound total statements with a strict
interpretive boundary. Definition, zero value, and nonnegativity become the
analytic sequence of interest only when the RMT-15 integrability hypothesis is
available.

## Camp two: preserved pullback integrals

### Declaration 4: <code>integral_logPlusNormObservable_at_base_iterate_eq</code>

Every natural iterate \(T^j\) preserves \(\mu\). RMT-16 proves

\[
\int_\Omega P_k(T^j\omega)\,d\mu(\omega)=I_k
\]

for all natural \(k\) and \(j\), without an <code>hC</code> argument.

The proof uses the pushforward description of a change of variables. Measure
preservation gives

\[
\operatorname{Measure.map}(T^j)\,\mu=\mu.
\]

Mathlib's <code>integral_map</code> rewrites the pullback integral as an
integral against that mapped measure. The equality of measures then closes the
calculation.

There are two technical obligations worth seeing. First, \(T^j\) must be
measurable. Second, the finite envelope must be almost-everywhere strongly
measurable under the mapped measure. RMT-15's ordinary measurability theorem
supplies the second fact directly. Integrability is not required by this
particular application of <code>integral_map</code>.

Totalization explains the stronger signature. If \(P_k\) is nonintegrable,
the equality can merely identify the artificial zero on the left with the
artificial zero on the right. The theorem is still correct and useful, but its
unconditional form does not turn either side into a finite analytic moment.
Under <code>hC</code>, RMT-15 supplies integrability and the same equality has
its ordinary analytic interpretation.

The identity is not an independence statement. The functions
\(P_k\circ T^j\) may have maximal dependence along one orbit. It is not an
ergodicity statement either. Preservation alone says that integration is
unchanged by the pullback.

## Camp three: integrate the finite orbit majorant

### Declaration 5: <code>HasIntegrableGeneratorLogPlus.integral_orbitLogPlusSum_eq</code>

Recall the finite RMT-15 majorant

\[
S_k(\omega)
{} =
\sum_{j=0}^{k-1}P_1(T^j\omega).
\]

Every summand is integrable under <code>hC</code>. Finite linearity permits
term-by-term integration, and declaration 4 makes each term's integral equal
to \(I_1\):

\[
\begin{aligned}
\int_\Omega S_k(\omega)\,d\mu(\omega)
&=
\sum_{j=0}^{k-1}
\int_\Omega P_1(T^j\omega)\,d\mu(\omega)\\
&=
\sum_{j=0}^{k-1}I_1\\
&=
kI_1.
\end{aligned}
\]

The factor \(k\) is coerced to a real number in the final multiplication.
The equality includes \(k=0\), where both the empty sum and \(0I_1\) vanish.

Again, no independence is needed. Finite additivity of the integral and equal
integrals under preserved shifts are sufficient.

### Declaration 6: <code>HasIntegrableGeneratorLogPlus.integratedLogPlusNorm_le_nat_mul</code>

RMT-15's pointwise domination is

\[
P_k(\omega)\le S_k(\omega).
\]

Both sides are integrable under <code>hC</code>, so integral monotonicity and
declaration 5 give

\[
I_k
\le
\int_\Omega S_k\,d\mu
{} =
kI_1.
\]

This is a linear finite-horizon upper bound, not the limiting theorem itself.
For positive \(k\), it implies the derived inequality \(A_k\le I_1\), but the
module does not export that specialization as an additional declaration.

The majorant can be loose. It clips contracting factors before summing and
therefore cannot record cancellation between expansion and contraction. Its
purpose is to transfer one-step integrability and bound the positive tail, not
to reconstruct exact logarithmic growth.

## Camp four: scalar subadditivity

### Declaration 7: <code>HasIntegrableGeneratorLogPlus.integratedLogPlusNorm_add_le</code>

RMT-15 proves the pointwise shifted inequality

\[
P_{m+k}(\omega)
\le
P_k(T^m\omega)+P_m(\omega).
\]

Under <code>hC</code>, all three functions are integrable. The shifted
\(k\)-block is integrable because a measure-preserving pullback preserves
integrability. Integral monotonicity and integral additivity therefore give

\[
\begin{aligned}
I_{m+k}
&\le
\int_\Omega
\bigl(P_k(T^m\omega)+P_m(\omega)\bigr)\,d\mu(\omega)\\
&=
\int_\Omega P_k(T^m\omega)\,d\mu(\omega)+I_m\\
&=
I_k+I_m\\
&=
I_m+I_k.
\end{aligned}
\]

The last line uses commutativity of real addition. It does not reverse or
commute the original matrix product. The cocycle's chronological order was
already handled in the pointwise RMT-15 inequality.

### Declaration 8: <code>HasIntegrableGeneratorLogPlus.subadditive_integratedLogPlusNorm</code>

Mathlib defines

\[
\operatorname{Subadditive}(u)
\quad\Longleftrightarrow\quad
\forall m\,k,\ u(m+k)\le u(m)+u(k).
\]

Declaration 8 packages declaration 7 exactly as

~~~lean
Subadditive C.integratedLogPlusNorm
~~~

This is the conceptual crossing point. Before declaration 8, the proof carries
measurable functions, base shifts, pullbacks, and cocycle products. After it,
Mathlib sees one deterministic real sequence and no outcome variable.

## Camp five: normalize over natural time

### Declaration 9: <code>normalizedIntegratedLogPlusNorm</code>

The normalized sequence is defined by

~~~lean
def normalizedIntegratedLogPlusNorm
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : ℝ :=
  C.integratedLogPlusNorm k / k
~~~

Lean coerces the denominator from \(\mathbb N\) to \(\mathbb R\). The
definition is total over all natural numbers, including zero.

At \(k=0\), declaration 2 gives \(I_0=0\), and Lean's real division convention
gives

\[
A_0=\frac00=0.
\]

{{< panel "warning" >}}
**Time zero is not a rate.** The value \(A_0=0\) is a convenient total boundary
value. It does not mean “growth per zero steps.” The Fekete infimum excludes
zero, and convergence along <code>atTop</code> ignores every finite prefix.
{{< /panel >}}

### Declaration 10: <code>normalizedIntegratedLogPlusNorm_nonneg</code>

Declaration 3 gives \(I_k\ge0\), while the real coercion of a natural number is
nonnegative. Division therefore gives

\[
0\le A_k
\]

for every natural \(k\). Like declarations 1 through 3, this theorem is
unconditional. Without <code>hC</code>, it remains an order fact about a
totalized definition rather than a hidden integrability result.

### Declaration 11: <code>bddBelow_normalizedIntegratedLogPlusNorm</code>

Zero is a lower bound for the entire range of \(A\):

\[
\operatorname{BddBelow}(\operatorname{range} A).
\]

Mathlib's Fekete convergence theorem asks for this lower-bound property. RMT-16
proves the stronger and simpler pointwise fact \(0\le A_k\), then packages zero
as a lower bound.

The full range here does include \(A_0\). That is harmless for boundedness.
It would not be harmless for the infimum defining the rate, which is why the
next camp must inspect Mathlib's positive-index definition exactly.

## Summit: the deterministic Fekete limit

### Declaration 12: <code>integratedLogPlusGrowthRate</code>

Given <code>hC</code>, declaration 8 supplies a subadditive real sequence.
RMT-16 defines

~~~lean
def integratedLogPlusGrowthRate
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (hC : C.HasIntegrableGeneratorLogPlus) : ℝ :=
  hC.subadditive_integratedLogPlusNorm.lim
~~~

Mathlib's <code>Subadditive.lim</code> is not an unspecified abstract limit. Its
definition is

~~~lean
sInf ((fun n : ℕ => u n / n) '' Set.Ici 1)
~~~

so the RMT-16 rate has the exact semantics

\[
\gamma_\mu^+(C)
{} =
\inf\left\{\frac{I_k}{k}:k\ge1\right\}.
\]

Three words matter: **infimum**, **positive**, and **indices**.

It is an infimum, not necessarily a minimum achieved by one horizon. The
indices begin at one, so \(A_0=0\) is excluded. The set consists of normalized
scalar integrals, not pointwise normalized functions.

The zero-time distinction can alter the value. In a one-point expanding
example, every positive-time ratio may equal a constant \(r\gt0\), while
\(A_0=0\). The positive-index infimum is \(r\), but the infimum of the full
range would be zero. Any prose that says simply “the infimum of the normalized
range” is therefore false unless it explicitly restricts to positive horizons.

### Declaration 13: <code>HasIntegrableGeneratorLogPlus.tendsto_normalizedIntegratedLogPlusNorm</code>

The final theorem is

~~~lean
Tendsto C.normalizedIntegratedLogPlusNorm atTop
  (𝓝 (C.integratedLogPlusGrowthRate hC))
~~~

Mathlib's <code>Subadditive.tendsto_lim</code> consumes the subadditivity proof
and the lower-bound theorem. In conventional notation,

\[
A_k\longrightarrow\gamma_\mu^+(C)
\qquad\text{as }k\to\infty.
\]

This is ordinary convergence of a sequence in \(\mathbb R\). The theorem does
not state that \(A_k\) decreases. Subadditivity can produce normalized ratios
that fluctuate while converging to their infimum.

### Why Fekete works

The checked module invokes Mathlib rather than reproving Fekete's lemma. Its
classical proof idea is still useful. Fix a positive block length \(n\). Write
a large horizon as

\[
k=qn+r,
\qquad
0\le r\lt n.
\]

Repeated subadditivity gives a bound of the form

\[
I_k\le qI_n+I_r.
\]

After division by \(k\), the repeated blocks contribute approximately
\(I_n/n\). The remainder belongs to the finite set of indices below \(n\), so
its contribution divided by \(k\) vanishes along large horizons. This bounds
the asymptotic upper behavior by each positive ratio \(I_n/n\), hence by their
infimum. The infimum itself bounds every positive ratio from below. The two
directions meet at the limit.

This argument explains both the positive-index restriction and the absence of
monotonicity. It compares long horizons with repeated fixed blocks; it does
not order each consecutive pair of ratios.

## The complete thirteen-declaration map

| No. | Lean declaration | Assumptions beyond the cocycle | Mathematical content |
|---:|---|---|---|
| 1 | <code>integratedLogPlusNorm</code> | None | Defines totalized \(I_k=\int P_k\,d\mu\) |
| 2 | <code>integratedLogPlusNorm_zero</code> | None | \(I_0=0\) |
| 3 | <code>integratedLogPlusNorm_nonneg</code> | None | \(0\le I_k\), not integrability |
| 4 | <code>integral_logPlusNormObservable_at_base_iterate_eq</code> | None | \(\int P_k\circ T^j\,d\mu=I_k\) for the totalized integral; possibly \(0=0\) without integrability |
| 5 | <code>HasIntegrableGeneratorLogPlus.integral_orbitLogPlusSum_eq</code> | <code>hC</code> | \(\int S_k\,d\mu=kI_1\) |
| 6 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusNorm_le_nat_mul</code> | <code>hC</code> | \(I_k\le kI_1\) |
| 7 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusNorm_add_le</code> | <code>hC</code> | \(I_{m+k}\le I_m+I_k\) |
| 8 | <code>HasIntegrableGeneratorLogPlus.subadditive_integratedLogPlusNorm</code> | <code>hC</code> | Packages declaration 7 as <code>Subadditive</code> |
| 9 | <code>normalizedIntegratedLogPlusNorm</code> | None | Defines total \(A_k=I_k/k\) |
| 10 | <code>normalizedIntegratedLogPlusNorm_nonneg</code> | None | \(0\le A_k\) |
| 11 | <code>bddBelow_normalizedIntegratedLogPlusNorm</code> | None | The full range of \(A\) is bounded below by zero |
| 12 | <code>integratedLogPlusGrowthRate</code> | <code>hC</code> | Defines the Fekete infimum over \(k\ge1\) |
| 13 | <code>HasIntegrableGeneratorLogPlus.tendsto_normalizedIntegratedLogPlusNorm</code> | <code>hC</code> | Proves \(A_k\to\gamma_\mu^+(C)\) in \(\mathbb R\) |

The ordering is part of the API's integrity. Total definitions, elementary
order facts, and the preserved-pullback equality appear without
<code>hC</code>. The finite orbit-sum identity, bounds, subadditivity theorem,
rate definition, and convergence theorem carry the explicit hypothesis.

## Raw measure, probability, and finite rescaling

The cocycle structure is parameterized by an arbitrary <code>Measure Ω</code>.
It does not include <code>IsProbabilityMeasure μ</code>, a finite-mass
assumption, or a normalization by \(\mu(\Omega)\). Thus

\[
I_k=\int_\Omega P_k\,d\mu
\]

is a raw-measure integral. Calling it an expectation would silently add mass
one. Calling \(A_k\) a measure average would silently add division by the total
mass. Neither operation occurs in the checked definitions.

A safe summary is:

{{< panel "info" >}}
The construction is normalized in time but not normalized in measure.
{{< /panel >}}

Finite scalar rescaling exposes this choice. Let \(c\) be a finite
nonnegative scalar and repackage the cocycle over \(c\mu\). Mathlib proves
that measure preservation survives such scaling and that a Bochner integral
against the scaled measure is multiplied by \(c\). Subject to the corresponding
integrability facts, this gives

\[
I_k^{c\mu}=cI_k^\mu,
\qquad
A_k^{c\mu}=cA_k^\mu,
\qquad
\gamma_{c\mu}^+(C)=c\gamma_\mu^+(C).
\]

For finite \(c\gt0\), integrability is equivalent before and after scaling.
For \(c=0\), the zero measure makes every function integrable and every
integral vanishes. No claim about scaling by an infinite extended scalar should
be inferred. The phrase “depends on total mass” is also too broad when the base
measure has infinite mass.

These scaling equations are consequences of upstream Mathlib APIs after the
cocycle is re-bundled over the scaled measure. They are not among RMT-16's
thirteen named declarations.

If a future specialization proves \(\mu(\Omega)=1\), then each \(I_k\) may be
called an expectation. Even in that specialization, declaration 13 remains a
limit of expected positive envelopes. It does not become an expectation of a
samplewise limit without another theorem.

## Two calibration examples

### One point, one expanding scalar

Let the base have one point with finite, strictly positive raw mass \(q\), let
the base map be the
identity, and let the one-dimensional generator be a constant
\(\lambda\gt1\). The cocycle product is \(\lambda^k\), so

\[
P_k=k\log\lambda.
\]

Therefore

\[
I_k=qk\log\lambda,
\qquad
A_k=q\log\lambda
\quad(k\ge1),
\]

and

\[
\gamma_\mu^+(C)=q\log\lambda.
\]

This one example checks four boundaries:

1. the rate scales with finite scalar rescaling of the raw measure;
2. expectation language is justified only when \(q=1\);
3. \(A_0=0\) differs from every positive-time ratio; and
4. the Fekete infimum must exclude zero to recover the positive answer.

For \(0\lt\lambda\lt1\), the positive logarithm clips every horizon to zero.
The RMT-16 rate is then zero even though the ordinary scalar logarithmic rate
is \(\log\lambda\lt0\). This is direct evidence that the construction is not a
full Lyapunov exponent.

### One point, a nilpotent matrix

Now take the constant matrix

\[
B=
\begin{bmatrix}
0&2\\
0&0
\end{bmatrix}.
\]

Its selected maximum absolute row-sum norm is two, so the one-step envelope is
\(P_1=\log2\). But \(B^2=0\). Hence \(P_k=0\) for every \(k\ge2\), the
normalized integrated values eventually vanish, and the Fekete rate is zero.

The example records one-step expansion followed by exact annihilation. The
positive envelope sees the first event but maps the collapse itself to zero.
It therefore cannot serve as an invariant record of contraction or singular
behavior.

Both calculations are deterministic teaching examples, not measured data and
not additional formal declarations.

## Assumption and order-of-operations ledger

| Question | RMT-16 answer |
|---|---|
| Is the base measurable? | Yes, by the cocycle structure |
| Does the base preserve \(\mu\)? | Yes, including every natural iterate |
| Is \(\mu\) a probability measure? | Not assumed |
| Is \(\mu\) finite? | Not assumed |
| Is the one-step positive envelope integrable? | Explicit hypothesis <code>hC</code> |
| Is every finite-horizon envelope integrable? | Inherited RMT-15 theorem under <code>hC</code> |
| Are orbit terms independent? | Not assumed and not needed |
| Is the base ergodic? | Not assumed |
| Is the cocycle invertible? | Not assumed |
| Is the positive envelope integrated before normalization? | Yes |
| Does the rate use time zero? | No, its infimum uses \(k\ge1\) |
| Is the final convergence scalar? | Yes, in \(\mathbb R\) |
| Is any samplewise convergence proved? | No |

This ledger prevents a common proof inversion. Measure preservation does not
make \(P_1\) integrable. It transports an already supplied integrability fact.
Likewise, nonnegativity does not make a totalized integral analytically finite.
It supplies the normalized range's lower bound unconditionally. The separate
<code>hC</code> hypothesis is still needed for the substantive subadditivity
and Fekete-convergence branch.

## Common wrong turns

### Calling the integral an expectation

The measure is arbitrary. Use “integrated value” or “raw-measure integral”
unless mass one has been separately established.

### Treating a real result as a finiteness proof

Mathlib's Bochner integral returns a real even when the integrand is not
integrable. Check <code>hC</code> rather than inferring integrability from the
codomain.

### Using the full normalized range in the infimum

The range includes \(A_0=0\). Mathlib's rate uses only positive indices. A
full-range infimum would erase every strictly positive example.

### Saying the ratios decrease to the limit

Fekete proves convergence to an infimum, not consecutive monotonicity. Draw
fluctuating ratios, not a descending staircase.

### Replacing the Fekete rate by the one-step integral

The finite bound gives \(A_k\le I_1\) for positive \(k\), hence
\(\gamma_\mu^+(C)\le I_1\). Equality is not proved in general.

### Deleting the base shift pointwise

The cocycle split contains \(P_k(T^m\omega)\). Preservation removes that shift
inside an integral, not in a pointwise identity.

### Reading equal integrals as independence

Every shifted term has the same integral because \(T\) preserves \(\mu\).
The terms can remain completely dependent.

### Moving the limit through the integral

No samplewise limit is available to move. Declaration 13 takes a limit only
after each horizon has become one real number.

### Calling the rate a Lyapunov exponent

Positive clipping sends contraction, unit scale, and exact collapse to zero.
The theorem gives no negative tail, inverse growth, nonzero condition,
invariant splitting, or samplewise logarithmic limit.

### Invoking Kingman retroactively

RMT-16 invokes only Mathlib's deterministic subadditive-sequence theorem.
Kingman's theorem concerns measurable subadditive processes and samplewise
conclusions under additional hypotheses. It is a future destination, not an
unstated ingredient.

## Exercises from trailhead to summit

### Trailhead

1. Write the types of \(P_k\), \(I_k\), and \(A_k\) after fixing a cocycle.
2. Explain why \(I_k:\mathbb R\) does not by itself prove integrability.
3. Derive \(I_0=0\) from the RMT-15 time-zero envelope.
4. Explain why \(A_0=0\) is formal rather than physical.
5. Compute the one-point scalar example for \(q=3\) and \(\lambda=2\).

### Mid-mountain

6. Expand \(\int S_3\,d\mu\) term by term and identify where preservation is
   used.
7. Derive \(I_k\le kI_1\) from the orbit-sum majorant.
8. Reconstruct the four-line integral proof of scalar subadditivity.
9. Explain why the final use of commutativity does not change matrix order.
10. Give a numerical subadditive sequence whose normalized ratios are not
    monotone.
11. Show why zero lower-bounds the normalized range.
12. Explain why the positive-index infimum can differ from the full-range
    infimum.

### Summit

13. Use the division algorithm \(k=qn+r\) to outline Fekete's block argument.
14. State the exact additional assumption needed before “expectation” becomes
    valid terminology.
15. Explain the difference between a limit of expectations and an expectation
    of a samplewise limit.
16. Analyze finite rescaling by \(c\gt0\) and the separate zero-measure case.
17. Use the nilpotent example to refute the claim that the rate detects
    collapse.
18. List the hypotheses and codomain choices that a future Kingman layer must
    settle before theorem application.
19. Design a separate two-sided inverse-growth envelope and state what RMT-16
    fails to provide for it.
20. Explain why an Oseledets splitting requires much more than convergence of
    the integrated positive envelope.

## Reproduce the checked slice

From the repository root, load the pinned Lean toolchain and compile the leaf
module with warnings treated as errors:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/IntegratedLogPlusGrowth.lean
~~~

Build the named module and its dependency graph:

~~~sh
lake build NonlinearDynamics.Random.RandomCocycles.IntegratedLogPlusGrowth
~~~

Return to the repository root and validate the complete teaching surface:

~~~sh
cd ..
make site-check
~~~

The repository-wide gate is <code>make check</code>. Automated success does not
publish this draft. Human mathematical, source, accessibility, and editorial
reviews remain separate publication gates.

## What remains outside the theorem

| Topic | Status in RMT-16 |
|---|---|
| Totalized finite-horizon integral | Defined |
| Integrated time-zero value | Proved zero |
| Integrated nonnegativity | Proved, but not an integrability theorem |
| Shifted pullback integral equality | Proved unconditionally for the totalized integral; may be \(0=0\) without integrability |
| Exact finite orbit-sum integral | Proved under <code>hC</code> |
| Linear finite-horizon integral bound | Proved under <code>hC</code> |
| Scalar subadditivity | Proved under <code>hC</code> |
| Natural-time normalized sequence | Defined, including formal time zero |
| Lower bound for normalized range | Proved |
| Positive-index Fekete rate | Defined under <code>hC</code> |
| Deterministic convergence in \(\mathbb R\) | Proved under <code>hC</code> |
| Probability normalization or expectation | Not assumed or defined |
| Finite total measure | Not assumed |
| Monotonicity of normalized ratios | Not proved and not implied |
| Samplewise convergence | Not proved |
| Almost-everywhere convergence | Not proved |
| Convergence in probability, distribution, or \(L^1\) | Not proved |
| Limit-integral interchange | Not attempted |
| Ergodicity, mixing, or independence | Not assumed or proved |
| Kingman's theorem | Not invoked |
| Furstenberg-Kesten theorem | Not invoked |
| Negative logarithmic growth or collapse-sensitive rate | Deliberately erased by positive log |
| Lyapunov exponent or spectrum | Not defined or proved |
| Oseledets filtration or splitting | Not invoked |
| Two-sided or inverse cocycle growth | Not present |
| Derivative or random-Jacobian interpretation | Not connected |

The summit is exact: an explicitly integrable finite positive-growth envelope
produces a lower-bounded subadditive sequence of real integrals, and its
positive-time normalized values converge to their deterministic Fekete
infimum.

## Where to continue

The
{{< refterm "integrated-log-positive-growth-rate" "integrated log-positive growth rate" >}}
entry is the compact definition and caveat ledger for this chapter.

[Finite-Horizon Log-Positive Cocycle Integrability]({{< relref "/knowledge-base/deep-dives/finite-horizon-log-positive-cocycle-integrability" >}})
is the immediate predecessor. It constructs \(P_k\), the finite orbit sum,
and the propagated integrability hypothesis used throughout RMT-16.

[Integrated Log-Positive Growth in Lean: Subadditivity and a Deterministic Fekete Limit]({{< relref "/development-notebook/2026/07/integrated-log-positive-growth-and-deterministic-fekete-limit" >}})
is the proof-to-prose Research Note paired directly with the Lean module.

The next asymptotic layer should choose its theorem before choosing its
terminology. A Kingman route needs a precise measurable-process interface,
probability or finite-measure hypotheses as required by the chosen theorem,
and an exact statement of samplewise convergence. A Lyapunov route must also
restore contraction-sensitive logarithmic information and settle nonzero,
inverse, or singular-value policies. None of those choices is retroactively
present in RMT-16.

## References

<a id="ref-integrated-deep-subadditive"></a>**Mathlib contributors.**
[Subadditive and superadditive sequences](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Subadditive.html),
Mathlib 4 documentation. This official source defines
<code>Subadditive</code>, the positive-index <code>Subadditive.lim</code>, and
the lower-bounded convergence theorem used by RMT-16.

<a id="ref-integrated-deep-bochner"></a>**Mathlib contributors.**
[The Bochner integral](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Integral/Bochner/Basic.html),
Mathlib 4 documentation. This official source records the totalized integral,
<code>integral_undef</code>, integral monotonicity, finite linearity,
<code>integral_map</code>, and finite nonnegative measure scaling.

<a id="ref-integrated-deep-integrable"></a>**Mathlib contributors.**
[Bochner integrability](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Function/L1Space/Integrable.html),
Mathlib 4 documentation. This official source supplies the integrability
transport and finite measure-rescaling facts that qualify the raw-measure
discussion.

<a id="ref-integrated-deep-preserving"></a>**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation. This official source supplies mapped-measure equality,
natural-iterate preservation, pullback integrability, and preservation under
finite nonnegative scalar rescaling.

<a id="ref-integrated-deep-fekete"></a>**M. Fekete.**
[Über die Verteilung der Wurzeln bei gewissen algebraischen Gleichungen mit ganzzahligen Koeffizienten](https://doi.org/10.1007/BF01504345),
*Mathematische Zeitschrift* 17, 228-249, 1923. This is the historical primary
source associated with the deterministic subadditive lemma used here through
Mathlib.

<a id="ref-integrated-deep-furstenberg-kesten"></a>**Harry Furstenberg and Harry Kesten.**
[Products of Random Matrices](https://doi.org/10.1214/aoms/1177705909),
*The Annals of Mathematical Statistics* 31(2), 457-469, 1960. This primary
source motivates asymptotic random-matrix-product growth. RMT-16 proves none
of its probabilistic or samplewise conclusions.

<a id="ref-integrated-deep-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source establishes a subadditive ergodic theorem under additional
hypotheses. The present chapter invokes only deterministic Fekete convergence.

<a id="ref-integrated-deep-oseledets"></a>**V. I. Oseledets.**
[A multiplicative ergodic theorem. Characteristic Ljapunov exponents of dynamical systems](https://www.mathnet.ru/eng/mmo214),
*Transactions of the Moscow Mathematical Society* 19, 197-231, 1968. This
primary source is a later exponent and splitting destination. RMT-16 provides
neither its logarithmic hypotheses nor its conclusions.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
