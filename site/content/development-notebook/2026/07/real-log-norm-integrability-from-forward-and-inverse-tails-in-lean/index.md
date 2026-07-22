---
title: "Real Log-Norm Integrability from Forward and Inverse Tails in Lean"
slug: "real-log-norm-integrability-from-forward-and-inverse-tails-in-lean"
date: 2026-07-22
weight: -68
author: "tdj28"
summary: "Random-matrix-theory milestone 34 (RMT-34) defines the total real logarithm of a finite cocycle norm, proves its finite-horizon integrability from pointwise units and integrable forward and inverse generator tails, packages a signed subadditive candidate, and isolates a strictly positive-rate convergence corollary that needs no invertibility."
lead: |
  Lean's total real logarithm is measurable at zero because it sends zero to zero, but that same convention erases exact collapse and can make signed subadditivity false on singular products. RMT-34 separates algebraic pointwise units from analytic tail integrability, constructs a measurable total inverse envelope through determinants and adjugates, and sandwiches each finite-time real log between integrable lower and upper rails. A separate positive-rate argument reuses RMT-33 once the log-positive envelope and real logarithm eventually agree.
key_result: |
  Pointwise generator invertibility together with integrable one-step forward and inverse log-positive norms makes every finite-horizon real log norm integrable and packages the family as an integrable shifted-subadditive process candidate. Separately, on an ergodic probability base, a strictly positive integrated log-positive rate forces almost-everywhere normalized real-log convergence to that rate without pointwise invertibility or inverse-tail integrability. Empty dimension remains valid for the finite-time package, while the positive-rate specialization is vacuous there.
draft: true
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Finite-dimensional matrix cocycles, total real logarithms, nonsingular inversion, two-sided generator moments, integrable domination, and a positive-rate convergence bridge"
reading_time: "320 to 460 minutes"
prerequisites:
  - "RMT-14 extended log-norm observables and the selected infinity operator norm"
  - "RMT-15 finite-horizon log-positive cocycle integrability"
  - "RMT-33 almost-everywhere log-positive convergence"
  - "Finite complex matrices, units, determinants, adjugates, and nonsingular inverses"
  - "Measure-preserving pullbacks, finite-sum integrability, and shifted subadditivity"
lean_module: "NonlinearDynamics.Random.RandomCocycles.RealLogNormIntegrability"
lean_source: "formalization/NonlinearDynamics/Random/RandomCocycles/RealLogNormIntegrability.lean"
lean_snapshot: "/lean/NonlinearDynamics/Random/RandomCocycles/RealLogNormIntegrability.lean"
lean_source_sha256: "ac950f8728e5fd003cff3b7a5d0750e5c36060730b3ebadc5b0e1165b54e72ea"
tags:
  - "Lean 4"
  - "Random matrix products"
  - "Matrix cocycles"
  - "Real logarithm"
  - "Pointwise invertibility"
  - "Negative tails"
  - "Integrability"
  - "Subadditive processes"
  - "Kingman theorem"
og_image: "real-log-norm-integrability-from-forward-and-inverse-tails-in-lean-card.png"
og_image_alt: "Warm-paper teaching card showing three separately stored duties: pointwise matrix units, an integrable forward expansion tail, and an integrable inverse contraction tail. The finite-time signed real log norm runs between forward and inverse integrable rails."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed Research Note. Verify claims against the cited primary
sources and any released artifacts before relying on them.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** Let \(C_n(\omega)\) be the newest-factor-left value of a
one-sided discrete complex matrix cocycle. RMT-34 defines the total real
observable

\[
R_n(\omega)=\operatorname{Real.log}\lVert C_n(\omega)\rVert.
\]

This is measurable even at a zero matrix because Mathlib defines
`Real.log 0 = 0`. That convenience is not zero-faithful. The module therefore
separates algebraic nonvanishing from analytic tail control. Pointwise units
make every finite product a unit and restore signed real-log subadditivity.
The inverse-generator positive-log observable is made measurable globally by
an entrywise determinant-adjugate proof. Along the forward base orbit, its
finite sum gives the lower rail

\[
-\sum_{j\lt n}\log^+\lVert A(T^j\omega)^{-1}\rVert
\le R_n(\omega),
\]

while the existing forward positive-log observable gives the upper rail

\[
R_n(\omega)\le\log^+\lVert C_n(\omega)\rVert.
\]

If the one-step functions defining both rails are integrable, measure
preservation and finite-sum closure make the rails integrable. Domination then
makes every \(R_n\) integrable, and the family becomes an
`IsIntegrableSubadditiveProcessCandidate`.

A separate endpoint needs none of the inverse-tail package. Under a
probability measure and `PreErgodic` base dynamics, if the RMT-33 integrated
log-positive rate is strictly positive, the positive-log and real-log
observables agree eventually almost everywhere. Their normalized limits are
therefore the same. The endpoint permits singular matrices. Its empty-index
specialization is only vacuous because the module separately proves that the
empty-dimensional rate is zero.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This declaration-complete teaching chapter is
an AI-assisted working draft. The warning-fatal Lean source is authoritative.
Human editorial acceptance and separate scientific-integrity and
zero-context expert-reader reviews remain pending. RMT-34 proves finite-time
signed integrability and one strictly positive-rate corollary. It does not
prove a general signed Kingman theorem, an inverse-cocycle exponent identity,
a Lyapunov spectrum, invariant subspaces, or an Oseledets splitting.
{{< /panel >}}

For reusable terminology, see
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycles" >}},
{{< refterm "extended-log-norm-observable" "the extended log-norm observable" >}},
{{< refterm "log-positive-integrability-envelope" "the log-positive integrability envelope" >}},
{{< refterm "integrated-log-positive-growth-rate" "the integrated log-positive growth rate" >}},
and {{< refterm "integrable-generator-log-tails" "integrable generator log tails" >}}.
The companion textbook chapter is
[The Forward-and-Inverse Tail Sandwich for Finite-Time Real Log Norms]({{< relref "/knowledge-base/deep-dives/forward-and-inverse-tail-sandwich-for-finite-time-real-log-norms" >}}).

## Orientation: one main route and one side route

RMT-33 proves almost-everywhere convergence of the normalized nonnegative
observable

\[
P_n(\omega)=\log^+\lVert C_n(\omega)\rVert.
\]

That theorem is deliberately expansion-only. If a scalar cocycle contracts by
one half at each step, then \(P_n=0\) at every horizon even though the signed
logarithmic growth is negative. RMT-34 begins recovering that missing signed
information.

There are two routes through the module.

1. The main finite-time route assumes pointwise unit generators and integrable
   forward and inverse one-step log-positive tails. It produces an integrable
   real-valued subadditive-process candidate.
2. The side route assumes the existing forward-tail package, an ergodic
   probability base, and a strictly positive integrated rate. Positivity
   eventually removes the clipping in `log⁺`, so RMT-33 already supplies the
   real-log limit.

{{< reference-figure
  wide="true"
  src="real-log-integrability-proof-ladder.svg"
  alt="A main proof ladder moves from a total real logarithm through pointwise units, a measurable total inverse envelope, integrable lower and upper rails, and a finite-time signed subadditive candidate. A separate side route starts from a strictly positive log-positive rate and reaches eventual agreement with the real logarithm."
  caption="**Two routes, two outputs:** the main route constructs finite-time signed infrastructure from pointwise units and two integrable generator tails. The side route reuses RMT-33 only in the strictly positive regime. Neither route is a general signed Kingman theorem."
>}}

The immediate predecessor is
[Log-Positive Kingman Convergence from Rational Lower Deviations in Lean]({{< relref "/development-notebook/2026/07/log-positive-kingman-convergence-from-rational-lower-deviations-in-lean" >}}).

## Prior work, this milestone's contribution, and exact nonclaims

**Historical placement.** Furstenberg and Kesten's 1960 paper is a foundational
source for products of random matrices
([Furstenberg and Kesten 1960](#ref-rmt34-furstenberg-kesten)). Kingman's 1968
paper developed the general ergodic theory of subadditive stochastic processes
([Kingman 1968](#ref-rmt34-kingman)). Oseledets' 1968 paper is the original
multiplicative ergodic theorem source
([Oseledets 1968](#ref-rmt34-oseledets)). Ruelle's 1979 paper is particularly
useful for separating a forward matrix-product theorem under a forward
positive-log moment from an invertible theorem using both forward and inverse
moments ([Ruelle 1979](#ref-rmt34-ruelle)). These sources motivate interfaces.
They do not enlarge the checked Lean result.

**Checked contribution.** The module:

- defines and measures a total real logarithmic norm observable;
- propagates pointwise generator units to every finite cocycle value;
- bridges the earlier zero-faithful extended log to the real log under the
  exact nonempty-dimensional gate;
- proves signed shifted subadditivity under pointwise units;
- proves global measurability of Mathlib's total matrix inverse through
  determinant and adjugate formulas;
- builds finite inverse-value and forward-orbit inverse-generator envelopes;
- proves a pointwise lower rail using only pointwise units;
- packages pointwise units and the two one-step integrability assumptions;
- proves finite-horizon real-log integrability by two-sided domination;
- packages the signed real-log family as an integrable subadditive candidate;
- compiles an infinite-volume inverse-tail separation and a geometric
  probability-space example showing that forward log-positive integrability
  does not imply inverse-tail or one-step signed real-log integrability; and
- proves the strictly positive-rate eventual-agreement endpoint.

**Not claimed.** The module proves no general almost-everywhere signed
real-log limit, no signed Kingman theorem for arbitrary real subadditive
processes, no convergence in \(L^1\), probability, or uniformly, no
limit-integral interchange, no concentration inequality, and no convergence
rate. It constructs no negative-time process and no same-base inverse cocycle.
It proves no equality between the inverse orbit sum and the inverse of the
finite product, no inverse-growth identity, no singular-value limit, no
Lyapunov spectrum, no invariant filtration or splitting, and no Oseledets
theorem. It formalizes no derivative cocycle, tangent bundle, stable manifold,
nonlinear stability theorem, bifurcation, turbulence claim, or physical-chaos
conclusion. It assumes no independence or mixing.

## Three logarithmic observables and their information boundaries

For a nonnegative norm \(r\), the repository now has three relevant outputs:

| Regime | Extended log | Total real log | Positive log |
|---|---:|---:|---:|
| \(r=0\) | \(\bot\) | \(0\) | \(0\) |
| \(0\lt r\lt1\) | \(\log r\lt0\) | \(\log r\lt0\) | \(0\) |
| \(r=1\) | \(0\) | \(0\) | \(0\) |
| \(r\gt1\) | \(\log r\gt0\) | \(\log r\gt0\) | \(\log r\gt0\) |

The extended log is zero-faithful at collapse because its codomain contains
bottom. The real log records finite contraction but totalizes collapse to
zero. The positive log is continuous and nonnegative but deliberately clips
both collapse and contraction.

{{< reference-figure
  wide="true"
  src="three-log-observables.svg"
  alt="Four norm regimes are compared across three observable columns. The extended logarithm alone sends collapse to bottom. The total real logarithm records contraction but sends collapse to zero. The positive logarithm sends collapse, contraction, and unit scale to zero while retaining expansion."
  caption="**Information ledger:** totality, zero-faithfulness, and a real nonnegative codomain serve different proof goals. RMT-34 uses the real log only after stating the algebraic condition that makes its signed laws honest."
>}}

The first four compiled probes make the scalar separation executable:
`Real.log 0 = 0`, `log⁺ (1 / 2) = 0`, `Real.log (1 / 2) < 0`, and
`0 < log⁺ ((1 / 2)⁻¹)`.

## Pointwise units propagate, but time remains one-sided

The definition

~~~lean
def IsPointwiseInvertible
    (C : DiscreteMatrixCocycle (ι := ι) μ) : Prop :=
  ∀ ω, IsUnit (C.generator ω)
~~~

is pointwise. It is not an almost-everywhere representative condition. It is
also algebraic rather than quantitative: it does not provide a uniform bound
on inverse norms or condition numbers.

The successor recurrence is

\[
C_{k+1}(\omega)=A(T^k\omega)C_k(\omega).
\]

The identity matrix is a unit at time zero. If the current finite product is a
unit and the newest generator is a unit, their product is a unit. Induction
therefore proves `IsPointwiseInvertible.value_isUnit`.

{{< reference-figure
  src="pointwise-units-propagate-forward.svg"
  alt="A forward sequence of base states supplies unit generator matrices. A newest-factor-left multiplication ladder combines them into unit finite products. A boundary below the ladder says that no inverse base map or negative-time value has been constructed."
  caption="**Algebra travels forward:** unit generators make every nonnegative-time value a unit. They do not make the base map invertible and do not create a two-sided cocycle."
>}}

The distinction becomes decisive when products are inverted. Mathlib proves

\[
(AB)^{-1}=B^{-1}A^{-1}.
\]

Thus a newest-factor-left forward product acquires the reverse factor order
under inversion. The compiled noncommuting-shear probe proves that the two
orders can genuinely differ.

## The nonempty bridge is semantic

Under pointwise units and `[Nonempty ι]`, every finite value is nonzero, its
selected norm is positive, and the earlier extended logarithm equals the
coercion of the real logarithm:

\[
C.\operatorname{logNormObservable}(k,\omega)
=\bigl(C.\operatorname{realLogNormObservable}(k,\omega):\mathbb E\mathbb R\bigr).
\]

The nonempty premise cannot be erased. For matrices indexed by `Empty`, the
matrix type is subsingleton. Its zero matrix equals its identity matrix, so
zero is algebraically a unit. The selected row-sup norm is nevertheless zero.
The extended log is bottom while the total real log is zero.

{{< reference-figure
  wide="true"
  src="empty-index-semantic-gate.svg"
  alt="The unique empty-index matrix splits into two semantic branches. Algebra says zero equals identity and the matrix is a unit. The selected-norm branch says the norm is zero, the extended logarithm records collapse, and the total real logarithm returns zero. A nonempty gate appears only before the extended-to-real bridge."
  caption="**Empty dimension is a theorem boundary:** it invalidates the extended-to-real coercion bridge, but the public real-valued subadditivity, lower rail, integrability package, and candidate recover an explicit all-zero branch. The positive-rate endpoint is syntactically available and mathematically vacuous."
>}}

The module consequently proves three separate simplification theorems:

- the real-log observable is identically zero for an empty index;
- it is zero at horizon zero in every finite dimension; and
- at horizon one it is the real logarithm of the generator norm.

## Signed subadditivity needs nonvanishing

The cocycle law and norm submultiplicativity give

\[
\lVert C_{m+k}(\omega)\rVert
\le
\lVert C_k(T^m\omega)\rVert\,
\lVert C_m(\omega)\rVert.
\]

Taking an ordinary logarithm is legitimate only when the relevant norms are
positive. Pointwise units provide three nonzero facts in the nonempty branch:
the later block, the earlier block, and their product. `Real.log_le_log`
handles the norm inequality and `Real.log_mul` splits the product. The empty
branch is an all-zero calculation.

The pointwise theorem is

\[
R_{m+k}(\omega)
\le R_k(T^m\omega)+R_m(\omega).
\]

The unit hypothesis is not merely proof convenience. Let

\[
A=\operatorname{diag}(1/2,0),\qquad
B=\operatorname{diag}(0,1/2).
\]

Both selected norms are one half but \(AB=0\). Total real-log subadditivity
would read

\[
0=\log\lVert AB\rVert
\le 2\log(1/2)\lt0,
\]

which is false. The module compiles exactly this counterexample.

## A measurable total inverse from entries upward

The pinned library does not provide the matrix measurability shortcut needed
by this module. RMT-34 therefore proves the route explicitly.

1. A determinant is a finite sum over permutations of finite products of
   measurable entries.
2. Updating one row by a constant row preserves entrywise measurability.
3. Every adjugate entry is a determinant of a row-updated matrix.
4. Mathlib's total nonsingular inverse satisfies
   \(A^{-1}=\det(A)^{-1}\operatorname{adj}(A)\).
5. The selected matrix norm is a finite supremum of finite row sums of entry
   norms.
6. `Real.posLog` is continuous, so it composes measurably with that pipeline.

{{< reference-figure
  wide="true"
  src="measurable-total-inverse-pipeline.svg"
  alt="Measurable matrix entries feed determinant and constant-row-update boxes. Those feed an adjugate box, then a determinant-reciprocal times adjugate box for total inversion, then a finite row-sum norm and a positive-log output. A singular branch says total inverse returns zero."
  caption="**The measurable inverse pipeline:** every arrow is a checked finite construction. On a singular matrix, the output is Mathlib's zero-valued nonsingular inverse, not a pseudoinverse and not a quantitative collapse measurement."
>}}

This gives unconditional measurability of both

\[
\omega\mapsto\log^+\lVert A(\omega)^{-1}\rVert
\]

and

\[
\omega\mapsto\log^+\lVert C_k(\omega)^{-1}\rVert.
\]

On singular inputs these functions are still measurable, but the total
inverse is zero and the positive log is zero. The word *contraction* is
warranted only under pointwise invertibility.

## Reverse order and the finite inverse orbit envelope

Define

\[
Q_k(\omega)=\log^+\lVert C_k(\omega)^{-1}\rVert
\]

and

\[
J_k(\omega)=\sum_{j=0}^{k-1}
\log^+\lVert A(T^j\omega)^{-1}\rVert.
\]

The sum has the expected zero and successor equations. The key finite bound is

\[
Q_k(\omega)\le J_k(\omega).
\]

The proof is an induction over the newest-factor-left product. It first uses
`Matrix.mul_inv_rev`, then matrix norm submultiplicativity, monotonicity of
positive log on nonnegative inputs, and `Real.posLog_mul`.

{{< reference-figure
  wide="true"
  src="inverse-product-order.svg"
  alt="A forward product places the newest factor on the left and the earliest factor on the right. Its inverse places the earliest inverse on the left and newest inverse on the right. A crossed-out lane keeps the pointwise inverses in the original order and is labeled false for noncommuting matrices."
  caption="**Order is structural:** the finite inverse bound respects reversed multiplication. A same-order product of inverse generators is a different object unless the matrices commute."
>}}

The inequality is unconditional because Mathlib's inverse and positive log are
total. It becomes an honest lower-tail majorant only when the finite product
is a unit. On a singular product, \(Q_k\) may be zero and contain no record of
collapse.

## Three separately stored fields in the tail package

The structure

~~~lean
structure HasIntegrableGeneratorLogTails
    (C : DiscreteMatrixCocycle (ι := ι) μ) : Prop where
  isPointwiseInvertible : C.IsPointwiseInvertible
  hasIntegrableGeneratorLogPlus : C.HasIntegrableGeneratorLogPlus
  integrable_inverseGeneratorLogPlus :
    Integrable C.inverseGeneratorLogPlusNormObservable μ
~~~

contains three logically distinct obligations.

| Field | What it supplies | What it does not supply |
|---|---|---|
| Pointwise units | Signed subadditivity and the lower inequality | Any moment bound or uniform conditioning |
| Forward positive-log integrability | Integrable upper rail | Control of contraction |
| Inverse positive-log integrability | Integrable lower rail | Negative time or an inverse exponent |

Measure preservation transports the inverse-generator integrability through
every nonnegative base iterate. A finite sum of those pullbacks is integrable,
so every \(J_k\) is integrable. Base invertibility is not used.

## The two-rail sandwich

For an invertible finite matrix \(A\) in nonempty dimension,

\[
1=\lVert I\rVert
=\lVert A^{-1}A\rVert
\le\lVert A^{-1}\rVert\lVert A\rVert.
\]

Taking logarithms and using

\[
\log\lVert A^{-1}\rVert
\le\log^+\lVert A^{-1}\rVert
\]

gives

\[
-\log^+\lVert A^{-1}\rVert
\le\log\lVert A\rVert.
\]

Combining this one-value inequality with \(Q_k\le J_k\) yields the public
lower rail. The empty-dimensional branch is separately zero. The upper rail
is unconditional because \(x\le\max(0,x)\):

\[
-J_k(\omega)
\le R_k(\omega)
\le P_k(\omega).
\]

{{< reference-figure
  wide="true"
  src="finite-time-integrability-sandwich.svg"
  alt="An inverse-generator orbit sum forms an integrable lower rail, a finite-time real logarithm sits in the middle, and the forward positive-log observable forms an integrable upper rail. Both rails feed a domination gate that certifies integrability of the middle observable."
  caption="**The analytic hinge:** pointwise inequalities and integrability of both rails let `integrable_of_le_of_le` certify the signed middle function. This is a finite-horizon statement for every natural time."
>}}

Mathlib's `integrable_of_le_of_le` requires an almost-everywhere strongly
measurable middle function, almost-everywhere lower and upper inequalities,
and integrability of both rails. RMT-34 supplies stronger pointwise
inequalities and unconditional ordinary measurability, then packages the
result as `integrable_realLogNormObservable`.

## The signed candidate is infrastructure, not convergence

The final main-route declaration is

~~~lean
theorem HasIntegrableGeneratorLogTails.isIntegrableSubadditiveProcessCandidate
    (hC : C.HasIntegrableGeneratorLogTails) :
    IsIntegrableSubadditiveProcessCandidate C.base μ
      C.realLogNormObservable
~~~

Its two fields are exactly the finite-horizon integrability theorem and the
pointwise-unit subadditivity theorem. It is the interface a future signed
subadditive convergence argument can consume.

It is not itself a convergence theorem. In particular, this module does not
define an integrated signed Fekete rate, repeat the lower-deviation assembly
for a general signed process, or identify an almost-everywhere signed limit.

## Forward-tail integrability does not force inverse-tail integrability

The infinite-Lebesgue probe first establishes the simplest separation. A
constant contraction by one half has a zero forward positive-log envelope and
a strictly positive inverse positive-log envelope. The zero function is
integrable on any measure, while a nonzero constant is not integrable over
Lebesgue measure on the whole real line.

That example alone would not settle the probability-space boundary because
every finite constant is integrable under a probability measure. The module
therefore compiles a genuine heavy-tail construction.

Let \(N\) have Mathlib's geometric distribution with parameter one half, so

\[
\mathbb P\{N=n\}=2^{-n-1}.
\]

On the identity base, take the invertible one-dimensional generator

\[
A(n)=\exp(-2^n).
\]

Then

\[
\log^+\lVert A(n)\rVert=0,
\qquad
\log^+\lVert A(n)^{-1}\rVert=2^n,
\qquad
\log\lVert A(n)\rVert=-2^n.
\]

The absolute inverse and signed tails have expected summands

\[
2^{-n-1}2^n=\frac12.
\]

Their series diverges. The forward positive-log observable is identically
zero and integrable. The cocycle is pointwise invertible and the base measure
is a genuine probability measure. Thus forward positive-log integrability
does not imply either inverse-generator integrability or one-step signed
real-log integrability, even in an invertible one-dimensional probability
example.

Every component of this example is Lean-checked in the module: the geometric
probability instance, matrix norm and inverse formulas, pointwise units,
observable identities, nonsummability, and the final five-part anonymous
example.

## The inverse lower rail can be strict

For

\[
A=\operatorname{diag}(1/2,1/4),
\]

the selected maximum-row-sum norm is one half, while

\[
A^{-1}=\operatorname{diag}(2,4),
\qquad
\lVert A^{-1}\rVert=4.
\]

Consequently

\[
-\log^+\lVert A^{-1}\rVert=-\log4
\lt -\log2=\log\lVert A\rVert.
\]

The inverse envelope bounds the strongest finite contraction visible to the
selected inverse norm. It does not equal the negative top log norm in this
example. No general inverse-exponent interpretation is proved.

## Strict positive rate removes clipping eventually

Assume a probability measure, `PreErgodic C.base μ`, the existing forward
generator positive-log integrability package, and

\[
0\lt\gamma_+(C).
\]

RMT-33 gives

\[
\frac{P_n(\omega)}n\longrightarrow\gamma_+(C)
\]

for almost every \(\omega\). For such a sample, the normalized value is
eventually greater than \(\gamma_+(C)/2\gt0\). At horizons \(n\ge1\),
positivity of the quotient forces \(P_n(\omega)\gt0\). Since

\[
P_n=\max(0,R_n),
\]

this forces \(R_n\gt0\) and \(P_n=R_n\). The normalized sequences are eventually
equal, so they have the same limit.

{{< reference-figure
  wide="true"
  src="positive-rate-eventual-agreement.svg"
  alt="A normalized clipped path approaches a strictly positive target band. After a marked horizon it coincides with the normalized real-log path, while earlier real-log values may be negative. A side note says singular steps remain allowed."
  caption="**The side route:** strict positivity eventually places every relevant value in the branch where clipping does nothing. This argument needs neither pointwise matrix units nor inverse-tail integrability."
>}}

A singular matrix can still have expanding top norm. The compiled matrix
`diag(2,0)` is not a unit and has norm greater than one. This is the substantive
reason not to impose invertibility on the positive endpoint. Empty dimension
is different: the module proves its integrated positive-log rate is exactly
zero, so the strict positivity premise cannot be supplied.

## Public declaration surface in exact source order

The following twenty-eight headings cover every source-level public
declaration command. The three structure fields are expanded separately under
declaration 20.

### 1. `realLogNormObservable`

This definition is the total real logarithm of the selected finite-time matrix
norm. Its codomain is `ℝ`, so it is convenient for ordinary Bochner
integrability and the generic real subadditive-process API. The definition
alone carries no nonvanishing or integrability certificate.

### 2. `IsPointwiseInvertible`

This proposition says `∀ ω, IsUnit (C.generator ω)`. It is a pointwise
algebraic interface. It is not an almost-everywhere predicate, a representative
class, a moment condition, base-map invertibility, or a quantitative inverse
bound.

### 3. `IsPointwiseInvertible.value_isUnit`

The theorem propagates generator units to `C.value k ω` for every horizon and
base point. The proof follows `value_succ`: the shifted newest generator unit
multiplies the induction hypothesis on the left.

### 4. `IsPointwiseInvertible.logNormObservable_eq_coe_realLogNormObservable`

Under `[Nonempty ι]`, the finite value unit is nonzero, its norm is positive,
and `ENNReal.log_ofReal` selects its finite branch. The earlier extended-real
observable then equals the coercion of the new real observable. Empty dimension
is excluded for the semantic reason demonstrated by compiled examples 5-7.

### 5. `measurable_realLogNormObservable`

The existing norm observable is measurable. Mathlib's total real log is
measurable globally, including at zero, so composition proves this theorem
without invertibility.

### 6. `realLogNormObservable_eq_zero_of_isEmpty`

With `[IsEmpty ι]`, every matrix entry is eliminated and every cocycle value is
the zero matrix. The row-sup norm and total real logarithm are zero. The theorem
is a function equality and carries a simp attribute.

### 7. `realLogNormObservable_zero`

At horizon zero, the theorem splits empty from nonempty index types. The empty
branch calls declaration 6. The nonempty branch uses the identity matrix norm
and `Real.log_one`. The result is the zero function in every finite dimension.

### 8. `realLogNormObservable_one`

The one-step cocycle value is the generator, so the observable simplifies to
`fun ω ↦ Real.log ‖C.generator ω‖`. This theorem also has a simp attribute.

### 9. `IsPointwiseInvertible.realLogNormObservable_add_le`

This is signed shifted subadditivity. The empty branch is zero. In the nonempty
branch, unit propagation supplies nonzero later, earlier, and product values.
Those facts justify logarithmic monotonicity and the product logarithm law.

### 10. `inverseGeneratorLogPlusNormObservable`

The definition is `fun ω ↦ log⁺ ‖(C.generator ω)⁻¹‖`. The inverse is Mathlib's
total nonsingular inverse. Under pointwise units it measures the one-step
inverse norm. At a singular generator it is zero and carries no quantitative
collapse information.

### 11. `measurable_inverseGeneratorLogPlusNormObservable`

The private determinant-adjugate and row-sup pipeline makes the total inverse
norm measurable. Continuity of positive log finishes the composition. No
invertibility hypothesis is required for this totalized function.

### 12. `inverseValueLogPlusNormObservable`

This is the corresponding envelope for the inverse of a finite cocycle value:
`fun ω ↦ log⁺ ‖(C.value k ω)⁻¹‖`. It is a genuine inverse-value envelope under
pointwise units and an information-free zero on a singular value.

### 13. `inverseValueLogPlusNormObservable_zero`

The horizon-zero inverse-value envelope is the zero function in every finite
dimension. The proof again treats the empty matrix ring separately.

### 14. `inverseValueLogPlusNormObservable_one`

At one step, the finite value is the generator, so the inverse-value envelope
equals `inverseGeneratorLogPlusNormObservable` as a function.

### 15. `measurable_inverseValueLogPlusNormObservable`

Measurability of each finite cocycle value is composed with the same total
inverse, row-sup norm, and positive-log pipeline used by declaration 11.

### 16. `inverseOrbitLogPlusSum`

This definition sums inverse-generator positive-log norms along the forward
base orbit over `Finset.range k`. It does not sample negative time and is not
defined as a cocycle value.

### 17. `inverseOrbitLogPlusSum_zero`

The finite range at horizon zero is empty, so the orbit sum is the zero
function.

### 18. `inverseOrbitLogPlusSum_succ`

`Finset.sum_range_succ` appends the inverse-generator term at `C.base^[k] ω`.
The equation mirrors the chronological order of forward base sampling.

### 19. `inverseValueLogPlusNormObservable_le_inverseOrbitLogPlusSum`

Induction reverses the newest-left product under inversion, bounds the norm of
the reversed product, applies `Real.posLog_mul`, and appends the newest orbit
term. The theorem is unconditional because both inverse and positive log are
total. Pointwise units are needed only for its later lower-tail
interpretation.

### 20. `HasIntegrableGeneratorLogTails`

The structure packages exactly three fields:

1. `isPointwiseInvertible` supplies algebraic units;
2. `hasIntegrableGeneratorLogPlus` supplies the existing integrable forward
   one-step positive-log envelope; and
3. `integrable_inverseGeneratorLogPlus` supplies integrability of the inverse
   one-step positive-log envelope.

The source stores these obligations separately and does not derive one from
another. Its checked separation is one directional: the geometric probability
example proves that the forward integrability field does not imply the inverse
field, even when pointwise units already hold. No reciprocal nonimplication is
claimed.

### 21. `measurable_inverseOrbitLogPlusSum`

Every base iterate is measurable because `C.base_preserving` includes base
measurability. Each composed inverse-generator observable is measurable, and a
finite sum remains measurable.

### 22. `HasIntegrableGeneratorLogTails.integrable_inverseGeneratorLogPlus_at_base_iterate`

Every natural iterate of the base preserves the measure. Mathlib's
`MeasurePreserving.integrable_comp_of_integrable` transports the inverse
generator's integrability through that iterate. The declaration name states
the transported observable explicitly.

### 23. `HasIntegrableGeneratorLogTails.integrable_inverseOrbitLogPlusSum`

Declaration 22 proves every summand integrable. `integrable_finsetSum` closes
the finite orbit sum.

### 24. `IsPointwiseInvertible.neg_inverseOrbitLogPlusSum_le_realLogNormObservable`

This public lower rail requires only pointwise units, not either integrability
field. In nonempty dimension it combines the private one-value lower lemma
with declaration 19 after negation. In empty dimension, both functions are
proved zero directly.

### 25. `realLogNormObservable_le_logPlusNormObservable`

Unfolding positive log reduces the statement to
`x ≤ max 0 x`. It is unconditional and remains true at norm zero.

### 26. `HasIntegrableGeneratorLogTails.integrable_realLogNormObservable`

The measurable real-log function lies between the negative inverse orbit sum
and the forward positive-log envelope. Declaration 23 makes the lower rail
integrable after negation, and the existing RMT-15 theorem makes the upper rail
integrable. `MeasureTheory.integrable_of_le_of_le` certifies the middle.

### 27. `HasIntegrableGeneratorLogTails.isIntegrableSubadditiveProcessCandidate`

The candidate's `integrable` field is declaration 26. Its `add_le` field is
declaration 9 through `hC.isPointwiseInvertible`. This theorem establishes the
finite-time input interface for later subadditive work and no limiting claim.

### 28. `HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedRealLogNormObservable_of_pos`

Under `IsProbabilityMeasure μ`, `PreErgodic C.base μ`, the existing forward
integrability package, and a strictly positive integrated positive-log rate,
RMT-33 supplies almost-everywhere convergence of the normalized clipped
observable. Eventual positivity removes the clipping. `Tendsto.congr'`
transfers the limit to the real-log observable. No pointwise units, inverse
tail, or nonempty typeclass occurs in the signature. The empty-dimensional
premise is impossible by compiled example 8.

## Private support surface in exact source order

The module contains thirty-four private source-level commands. One is an
unnamed local probability-measure instance. The remaining commands have
private names. All are covered here because they carry proof architecture or
boundary semantics even though they do not enlarge the public API.

| Line | Private item | Job |
|---:|---|---|
| 198 | `measurable_matrixDet` | Expand the determinant into measurable finite sums and products |
| 211 | `measurable_updateRow_const` | Prove entrywise measurability of a constant row replacement |
| 224 | `measurable_matrixAdjugate` | Use row-replacement determinants for every adjugate entry |
| 234 | `measurable_matrixInverse` | Apply the total determinant-adjugate inverse formula |
| 249 | `measurable_matrixNorm` | Express the chosen norm as a finite supremum of measurable row sums |
| 437 | `neg_inverseValueLogPlus_le_realLogNorm` | Prove the nonempty one-value lower inequality |
| 638 | `singularExpandingMatrix` | Store the singular expanding diagonal boundary matrix |
| 673 | `geometricTailParameter` | Fix the geometric parameter at one half in `unitInterval` |
| 676 | `geometricTailMeasure` | Instantiate Mathlib's geometric law on natural numbers |
| 679 | unnamed private instance | Register that geometric law as a probability measure |
| 683 | `geometricTailExponent` | Define the tail size \(2^n\) |
| 686 | `geometricTailMatrix` | Define the one-dimensional contraction `exp (-2^n)` |
| 689 | `geometricTailCocycle` | Bundle identity base, generator, preservation, and measurability |
| 696 | `geometricTailParameter_ne_zero` | Discharge the distribution theorem's nonzero-parameter gate |
| 702 | `geometricTailMatrix_norm` | Compute the selected norm as `exp (-2^n)` |
| 708 | `geometricTailMatrix_inv` | Compute the nonsingular inverse entry as `exp (2^n)` |
| 717 | `geometricTailMatrix_inv_norm` | Compute the inverse norm |
| 722 | `geometricTailCocycle_isPointwiseInvertible` | Prove every scalar generator is a unit |
| 728 | `geometricTail_forward_logPlus` | Prove the forward positive log is zero |
| 735 | `geometricTail_inverse_logPlus` | Prove the inverse positive log is \(2^n\) |
| 743 | `geometricTail_realLog` | Prove the signed real log is \(-2^n\) |
| 747 | `geometricTail_forward_observable` | Lift the forward scalar calculation to the cocycle observable |
| 755 | `geometricTail_inverse_observable` | Identify the inverse-generator observable with the exponent function |
| 764 | `geometricTail_real_observable` | Identify the one-step real-log observable with the negative exponent |
| 773 | `geometricTail_not_summable` | Reduce weighted absolute tails to the nonsummable constant one half |
| 792 | `geometricTail_hasIntegrableGeneratorLogPlus` | Prove the zero forward observable integrable |
| 797 | `geometricTail_not_integrable_inverse` | Apply the geometric-measure integrability criterion and nonsummability |
| 805 | `geometricTail_not_integrable_real` | Apply the same criterion to the signed real log's absolute value |
| 833 | `singularFirstContraction` | First singular contraction for failures |
| 836 | `singularSecondContraction` | Second singular contraction whose product with the first is zero |
| 876 | `twoRateContraction` | Diagonal contraction with rates one half and one quarter |
| 879 | `twoRateInverse` | Its explicit diagonal inverse |
| 914 | `upperShear` | First noncommuting unit shear |
| 917 | `lowerShear` | Second noncommuting unit shear |

The first five measurability helpers are plausible candidates for a later
generic random-matrix utility layer, but keeping them private is appropriate
for this milestone. The remaining private items exist to make semantic
boundaries compile rather than live only in prose.

## Sixteen compiled boundary examples in exact source order

1. `Real.log (0 : ℝ) = 0` records totalization.
2. `log⁺ (1 / 2 : ℝ) = 0` records contraction clipping.
3. `Real.log (1 / 2 : ℝ) < 0` records signed contraction.
4. `0 < log⁺ ((1 / 2 : ℝ)⁻¹)` records the scalar inverse tail.
5. The zero matrix on `Empty × Empty` is a unit.
6. Every empty-dimensional cocycle is pointwise invertible.
7. Empty dimension gives extended log bottom and total real log zero.
8. Empty dimension has integrated positive-log rate zero.
9. Matrix inversion reverses two-factor order.
10. `singularExpandingMatrix` is not a unit but has norm greater than one.
11. On infinite Lebesgue measure, the zero forward constant is integrable and
    the positive inverse constant is not.
12. The geometric probability cocycle is pointwise invertible and has
    integrable forward positive log, but its inverse-generator and one-step
    signed real-log observables are not integrable.
13. Total real-log subadditivity fails for two singular contractions whose
    product vanishes.
14. The inverse lower sandwich fails for a singular contraction because total
    nonsingular inverse returns zero.
15. The two-rate contraction has an explicit inverse and a strict lower-rail
    gap.
16. Noncommuting shears prove that the same-order product of inverses differs
    from the reverse-order product.

Examples 11 and 12 prove different statements. Example 11 isolates why a
finite constant can fail to be integrable on an infinite measure. Example 12
uses a genuinely unbounded tail and closes the probability-space loophole.

## Exact complete source-order map

| Source span | Contents |
|---|---|
| Lines 73-193 | Public declarations 1-10 |
| Lines 198-267 | Five private measurability helpers |
| Lines 271-433 | Public declarations 11-23 |
| Lines 437-462 | Private one-value lower lemma |
| Lines 467-577 | Public declarations 24-28 |
| Lines 581-636 | Compiled examples 1-9 |
| Lines 638-647 | Singular-expansion fixture and example 10 |
| Lines 654-671 | Infinite-volume example 11 |
| Lines 673-811 | Geometric probability private construction |
| Lines 813-831 | Probability comments and compiled certificate example 12 |
| Lines 833-874 | Singular-contraction fixtures and examples 13-14 |
| Lines 876-912 | Two-rate fixtures and example 15 |
| Lines 914-928 | Shear fixtures and example 16 |
| Lines 932-942 | Eleven axiom prints |

This map is tied to source SHA-256
`ac950f8728e5fd003cff3b7a5d0750e5c36060730b3ebadc5b0e1165b54e72ea`.
If the Lean file changes, regenerate the line map and hash rather than silently
retaining stale numbers.

## Complete local proof-step ledger

The public declarations are concise because several local proof decisions do
substantial work. This ledger keeps those decisions inspectable.

| Proof location | Local step | Why it exists |
|---|---|---|
| Unit propagation | `rw [congrFun (C.value_succ k) ω]` | Exposes the newest generator and prior product |
| Extended bridge | `norm_pos_iff.mpr hvalue` | Converts algebraic nonzero data to the positivity required by logarithms |
| Empty branches | `cases isEmpty_or_nonempty ι` | Keeps degenerate matrix semantics explicit |
| Signed subadditivity | `hleft`, `hk`, `hm` | Supplies product and factor nonzero gates separately |
| Determinant measurability | `Matrix.det_apply` | Replaces determinant notation by finite measurable operations |
| Row update | `by_cases h : a = j` | Separates constant and inherited entries |
| Adjugate | `Matrix.adjugate_apply` | Reduces each entry to a determinant |
| Total inverse | `Matrix.inv_def` | Exposes determinant reciprocal times adjugate |
| Matrix norm | `Matrix.linfty_opNorm_def` | Exposes the active norm instead of relying on topology inference |
| Inverse product | `Matrix.mul_inv_rev` | Enforces the correct noncommutative order |
| Positive-log product | `Real.posLog_mul` | Converts multiplicative control into an additive envelope |
| Pullback integrability | `base_iterate_preserving` | Uses preservation at exactly the required natural iterate |
| Lower rail | `Matrix.nonsing_inv_mul` | Rewrites inverse times value as identity under units |
| Lower rail | `neg_le_neg` | Reverses the inverse-value versus orbit-sum inequality correctly |
| Domination | `integrable_of_le_of_le` | Certifies the signed middle function from two integrable rails |
| Positive endpoint | `eventually_ge_atTop 1` | Makes division by a positive natural cast legitimate |
| Positive endpoint | `lt_max_iff` | Extracts positivity of the unclipped logarithm |
| Positive endpoint | `Tendsto.congr'` | Transfers convergence along eventual equality |
| Geometric tail | `integrable_geometricMeasure_iff` | Converts integrability to an explicit weighted summability test |
| Geometric tail | `summable_const_iff` | Closes divergence after every summand simplifies to one half |

## Lean engineering notes

### Ordinary measurability is intentionally weaker than semantic fidelity

`Real.log` and the total matrix inverse are globally defined, so their
compositions can be measurable without any unit hypothesis. That is useful for
reusable APIs. It does not mean a singular input retains the intended
contraction information. The later pointwise-unit theorem supplies that
semantic interpretation.

### `IsUnit` is the correct algebraic interface

The proof needs multiplication closure, nonzero values in the nonempty matrix
ring, determinant units, and valid inverse multiplication. `IsUnit` connects
to all of these APIs directly. A bare statement that every determinant is
nonzero would be more field-specific and less compositional.

### The public lower rail is weaker than the integrability package

The lower inequality uses only pointwise units. Its earlier receiver was the
three-field tail package, but the proof did not consume either integrability
field. The final source exposes the true dependency as
`IsPointwiseInvertible.neg_inverseOrbitLogPlusSum_le_realLogNormObservable`.

### The selected norm must remain visible

The project opens `Matrix.Norms.Operator`, so the norm is the maximum absolute
row-sum operator norm. It is not the Frobenius norm or Euclidean spectral norm.
The private measurability proof unfolds `Matrix.linfty_opNorm_def`, and the
diagonal probes compute that same norm.

### No pseudoinverse appears

Mathlib's matrix `A⁻¹` in this module is the determinant-adjugate nonsingular
inverse and is zero when no inverse exists. A Moore-Penrose pseudoinverse would
have different singular behavior and is not imported, defined, or used.

### The geometric example uses Mathlib's parameter convention

`geometricMeasure p` assigns weight \((1-p)^n p\) to natural number \(n\).
With \(p=1/2\), the mass is \(2^{-n-1}\). The example chooses tail size \(2^n\)
so each weighted absolute contribution is exactly one half. The proof uses the
pinned library's own integrability characterization rather than an informal
expectation calculation.

### “Two-sided tails” does not mean two-sided time

Both one-step functions are evaluated at the same forward base state. The
inverse-generator term measures an inverse matrix, not a past state. All orbit
sums still use `C.base^[j]` for natural \(j\).

## Axiom audit

The source prints axioms for eleven representative theorems, in this exact
order:

1. `IsPointwiseInvertible.value_isUnit`
2. `IsPointwiseInvertible.logNormObservable_eq_coe_realLogNormObservable`
3. `measurable_realLogNormObservable`
4. `IsPointwiseInvertible.realLogNormObservable_add_le`
5. `measurable_inverseGeneratorLogPlusNormObservable`
6. `inverseValueLogPlusNormObservable_le_inverseOrbitLogPlusSum`
7. `HasIntegrableGeneratorLogTails.integrable_inverseOrbitLogPlusSum`
8. `IsPointwiseInvertible.neg_inverseOrbitLogPlusSum_le_realLogNormObservable`
9. `HasIntegrableGeneratorLogTails.integrable_realLogNormObservable`
10. `HasIntegrableGeneratorLogTails.isIntegrableSubadditiveProcessCandidate`
11. `HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedRealLogNormObservable_of_pos`

The warning-fatal compile reports only the standard logical axioms `propext`,
`Classical.choice`, and `Quot.sound`. It reports no `sorryAx`, unsafe
declaration, or project-specific axiom. The compiled geometric boundary
construction is not included in the print list because it is private support,
not part of the public theorem surface.

## Reproduce the Lean and teaching artifacts

From the repository root on macOS or Linux:

~~~bash
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true NonlinearDynamics/Random/RandomCocycles/RealLogNormIntegrability.lean
lake build NonlinearDynamics.Random.RandomCocycles.RealLogNormIntegrability
cd ..
make -j1 check
~~~

The direct leaf command is the fastest way to inspect theorem and axiom output.
The named Lake build verifies module integration. `make -j1 check` builds the
whole Lean project, validates the checkpoint and proof-to-prose map, runs the
teaching-source gates, and performs the warning-fatal Hugo check.

Regenerate and verify this page's deterministic card from any working
directory:

~~~bash
site/content/development-notebook/2026/07/real-log-norm-integrability-from-forward-and-inverse-tails-in-lean/generate-card.sh
site/content/development-notebook/2026/07/real-log-norm-integrability-from-forward-and-inverse-tails-in-lean/generate-card.sh --verify
~~~

Validate the page-owned vector assets and shell script:

~~~bash
xmllint --noout site/content/development-notebook/2026/07/real-log-norm-integrability-from-forward-and-inverse-tails-in-lean/*.svg
shellcheck site/content/development-notebook/2026/07/real-log-norm-integrability-from-forward-and-inverse-tails-in-lean/generate-card.sh
make content-hygiene
make site-check
~~~

To inspect the draft interactively, run `make blog-serve` for local access or
`make blog-serve-tailscale` for the human-approved private Tailscale route.
Both use port 1333. A remote compute builder remains an acceleration mechanism,
not a second source of truth.

## Exercises with fully worked solutions

These exercises climb from scalar semantics to the finite-time sandwich and
then to the exact theorem boundary. Each solution is placed immediately after
its question so that the section can also serve as a guided second reading.

### Exercise 1. Compare the three observables at collapse

Let the matrix norm be zero. What do the extended log, total real log, and
positive log return, and which result still records collapse?

**Solution.** The extended log returns bottom, the total real log returns zero
because `Real.log 0 = 0`, and the positive log also returns zero. Only the
extended log distinguishes exact collapse from unit norm. This is why the new
real-valued observable is convenient for integration but cannot carry
zero-faithfulness by itself.

### Exercise 2. Detect a strict contraction

Evaluate the information carried by the three observables when the norm is
one half.

**Solution.** Both the extended log and total real log contain the negative
number \(\log(1/2)\). The positive log is
\(\max(0,\log(1/2))=0\). Thus the signed observables detect contraction, while
the clipped observable deliberately forgets it.

### Exercise 3. Separate neutral scale from expansion

What happens at norm one and at norm two?

**Solution.** At norm one, all three observables give zero because
\(\log 1=0\). At norm two, the ordinary logarithm is positive, so clipping has
no effect: the finite extended log, total real log, and positive log all carry
the value \(\log 2\), with the extended value embedded in its larger codomain.

### Exercise 4. Explain totality versus faithfulness

Why does global measurability of the total real-log observable not prove that
it faithfully represents singular contraction?

**Solution.** Measurability only says inverse images of measurable sets are
measurable. Mathlib's `Real.log` is a total function and assigns zero at zero,
so composition with a measurable norm is measurable without any nonzero
premise. Faithfulness is a different semantic property, and it fails because
norm zero and norm one both map to zero.

### Exercise 5. Separate measurability from integrability

Can a measurable real-valued function fail to be integrable? Give the reason
relevant to this module.

**Solution.** Yes. Integrability additionally requires a finite integral of
the norm. In the geometric probability example, the inverse-log observable is
measurable and finite at every natural number, but its weighted absolute
series has constant terms equal to one half and therefore diverges.

### Exercise 6. Propagate generator units

Assume every generator \(A(\omega)\) is a unit. Prove by induction that every
finite cocycle value \(C_n(\omega)\) is a unit.

**Solution.** At time zero, the cocycle value is the identity matrix, which is
a unit. For the successor step, the cocycle recurrence is
\(C_{n+1}(\omega)=A(T^n\omega)C_n(\omega)\). The first factor is a unit by the
pointwise hypothesis and the second by induction, so their product is a unit.

### Exercise 7. Compare pointwise and almost-everywhere units

Why is an almost-everywhere invertibility premise not a drop-in replacement
for `IsPointwiseInvertible` in the public pointwise inequalities?

**Solution.** The target inequalities quantify over every base point, and the
induction proving `value_isUnit` also evaluates the generator at specific
forward iterates. An almost-everywhere statement could support an
almost-everywhere theorem after null-set bookkeeping, but it does not supply a
unit at each requested point. The current interface intentionally avoids that
representative-management problem.

### Exercise 8. Understand the empty matrix ring

Why can the zero matrix indexed by `Empty` be a unit?

**Solution.** There is exactly one function from `Empty × Empty` to the scalar
field, so all matrices of that shape are equal. In particular, zero equals the
identity. Since the identity is a unit, the zero matrix is a unit in this
degenerate one-element ring.

### Exercise 9. Locate the nonempty gate

Why does the extended-log to real-log bridge require `[Nonempty ι]`, while
real-log subadditivity has an explicit empty branch?

**Solution.** In empty dimension, a unit matrix can still have selected norm
zero, so the extended log is bottom while `Real.log 0` is zero. The bridge is
therefore false. Signed subadditivity, however, compares three real zeros in
that branch and remains true, so its proof can split on empty versus nonempty
instead of excluding the empty case.

### Exercise 10. Compute the horizon-zero observable

Show that the total real-log norm observable is zero at horizon zero in every
finite dimension.

**Solution.** The cocycle value at zero is the identity. In nonempty dimension
the selected operator norm of the identity is one, hence its real logarithm is
zero. In empty dimension the selected norm is zero, but Mathlib's total real
logarithm again returns zero. The two branches agree as a function.

### Exercise 11. Diagnose singular subadditivity failure

Let \(A=\operatorname{diag}(1/2,0)\) and
\(B=\operatorname{diag}(0,1/2)\). Why does total real-log subadditivity fail?

**Solution.** The selected norm of each factor is one half, while \(AB=0\).
The proposed inequality becomes
\(0\le 2\log(1/2)\). Its right side is strictly negative, so the inequality is
false. The failure comes exactly from totalizing `Real.log 0` to zero.

### Exercise 12. Identify the three positivity facts

In the nonempty proof of signed subadditivity, why are nonzero facts needed
for the later block, earlier block, and their product?

**Solution.** The norm inequality is converted through logarithmic
monotonicity, which needs positive arguments. The product logarithm law also
needs the factor norms to be nonzero. Unit propagation supplies a unit, hence
a nonzero matrix and positive norm, for each factor and for the combined
cocycle value.

### Exercise 13. Expand determinant measurability

Suppose every matrix entry depends measurably on \(\omega\). Why is the
determinant measurable?

**Solution.** The determinant is a finite sum indexed by permutations. Each
summand is a sign times a finite product of selected entries. Measurable
functions are closed under finite products, scalar multiplication, and finite
sums, so the determinant is measurable without any continuity shortcut for
the matrix space.

### Exercise 14. Handle a constant row update

Why does replacing one row of a measurable matrix-valued function by a fixed
row preserve entrywise measurability?

**Solution.** Fix an output entry. If its row index is the replaced row, the
entry is a constant function and therefore measurable. Otherwise it is the
corresponding original measurable entry. A decidable case split on equality
of the row indices completes the entrywise proof.

### Exercise 15. Make the adjugate measurable

How do determinant measurability and row-update measurability combine to
prove adjugate measurability?

**Solution.** Mathlib expresses each adjugate entry as a signed determinant of
a matrix obtained through a fixed row replacement. The updated matrix remains
entrywise measurable by Exercise 14, and its determinant is measurable by
Exercise 13. Multiplication by the fixed sign preserves measurability.

### Exercise 16. Explain total inverse measurability

Use the determinant-adjugate formula to explain why the nonsingular inverse
is measurable even at singular matrices.

**Solution.** Mathlib defines the total inverse as the determinant reciprocal
times the adjugate. The determinant and adjugate are measurable, scalar
reciprocal is measurable as a total field operation, and scalar-matrix
multiplication is entrywise measurable. At a singular matrix this definition
returns zero, so no partial-domain extension is needed.

### Exercise 17. Unfold the selected matrix norm

Why is the row-sup operator norm measurable for an entrywise measurable
finite matrix?

**Solution.** For each row, take the finite sum of the norms of its entries.
Entry norms and their finite sum are measurable. The matrix norm is the finite
supremum of these row sums, and finite suprema of measurable real functions
are measurable.

### Exercise 18. Finish the inverse-observable pipeline

How does the preceding work prove measurability of
\(\omega\mapsto\log^+\lVert A(\omega)^{-1}\rVert\)?

**Solution.** Exercise 16 gives a measurable total inverse matrix, and
Exercise 17 gives a measurable selected norm. `Real.posLog` is continuous and
therefore measurable. Composition of the three maps proves the result, with
no unit hypothesis.

### Exercise 19. Compute inverse envelopes at zero and one

What are `inverseValueLogPlusNormObservable 0` and
`inverseValueLogPlusNormObservable 1`?

**Solution.** At zero, the cocycle value is identity. Its total inverse is
identity in nonempty dimension and the unique empty matrix otherwise; in both
cases the positive log of the selected norm is zero. At one, the cocycle value
is the generator, so the finite-value envelope is definitionally the
inverse-generator envelope after the one-step simplification.

### Exercise 20. Unfold the inverse orbit sum

Derive its zero and successor equations.

**Solution.** The sum is over `Finset.range k`. At zero that range is empty,
so the sum is zero. `Finset.sum_range_succ` says the range at `k + 1` consists
of the old range plus its final index `k`, yielding the old sum plus the
inverse-generator observable at \(T^k\omega\).

### Exercise 21. Reverse a two-factor inverse

If \(C_{k+1}=A_kC_k\), in what order do the factors appear after inversion?

**Solution.** Matrix inversion reverses multiplication, so
\(C_{k+1}^{-1}=C_k^{-1}A_k^{-1}\). The order is essential because matrices
need not commute. The compiled shear example shows that retaining the
original order can change the matrix.

### Exercise 22. Prove the finite inverse majorant

Sketch the induction proving \(Q_k\le J_k\).

**Solution.** Both sides are zero at horizon zero. At a successor, reverse the
product under inversion, apply norm submultiplicativity, and use monotonicity
of positive log. `Real.posLog_mul` bounds the positive log of the product by
the sum of the two positive logs. The induction hypothesis controls the old
finite inverse term, and the remaining term is exactly the new orbit summand.

### Exercise 23. State the semantic limit of that majorant

Why is \(Q_k\le J_k\) unconditional but not informative about singular
collapse?

**Solution.** The total inverse and positive log are defined for every matrix,
so the algebraic inequality can be stated without units. For a singular
matrix, however, the total inverse is zero and \(Q_k=0\). It then says nothing
about how strongly the original matrix collapsed.

### Exercise 24. Derive the one-value lower inequality

In nonempty matrix dimension, for a unit matrix \(M\), prove
\(-\log^+\lVert M^{-1}\rVert\le\log\lVert M\rVert\).

**Solution.** Since \(M^{-1}M=I\), norm submultiplicativity gives
\(1\le\lVert M^{-1}\rVert\lVert M\rVert\). Both norms are positive. Taking
logs yields
\(0\le\log\lVert M^{-1}\rVert+\log\lVert M\rVert\). The always-valid
inequality \(\log\lVert M^{-1}\rVert\le
\log^+\lVert M^{-1}\rVert\) enlarges the first term on the right. Rearranging
the resulting inequality gives the desired lower bound.

### Exercise 25. Explain why nonempty dimension enters Exercise 24

Where does the argument use a nontrivial identity norm?

**Solution.** It uses \(\lVert I\rVert=1\) to start the product inequality. In
empty dimension, the selected norm of the unique identity matrix is zero.
The public cocycle theorem handles that case separately, where both the lower
rail and real-log observable are zero.

### Exercise 26. Build the full lower rail

Combine the one-value lower inequality and finite inverse majorant.

**Solution.** In nonempty dimension, pointwise units make \(C_k(\omega)\) a
unit, so Exercise 24 gives \(-Q_k(\omega)\le R_k(\omega)\). Exercise 22 gives
\(Q_k\le J_k\); negating reverses the inequality and yields
\(-J_k\le -Q_k\). Transitivity proves \(-J_k\le R_k\). In empty dimension,
Lean takes the separate branch from Exercise 25: \(J_k\) and \(R_k\) are both
zero, so the same public lower rail holds directly.

### Exercise 27. Prove the upper rail

Why is \(R_k\le P_k\) unconditional?

**Solution.** For any real \(x\), one has \(x\le\max(0,x)\). Substitute
\(x=\log\lVert C_k(\omega)\rVert\). This remains true when the norm is zero
because both the real log and positive log are totalized to zero there.

### Exercise 28. Transport one-step integrability along the base

Why is the inverse-generator observable composed with \(T^j\) integrable?

**Solution.** The tail package assumes the one-step inverse-generator
observable is integrable. The cocycle stores that the base map preserves the
measure, and every natural iterate of a measure-preserving map is again
measure-preserving. Integrability is preserved under composition with such an
iterate.

### Exercise 29. Integrate the inverse orbit sum

Why is \(J_k\) integrable for each finite horizon?

**Solution.** By Exercise 28, every summand indexed by `Finset.range k` is
integrable. The range is finite, and integrable functions are closed under
finite sums. Therefore the orbit sum is integrable, with no appeal to an
infinite series.

### Exercise 30. Apply two-sided domination

Complete the proof that \(R_k\) is integrable.

**Solution.** The lower rail \(-J_k\) is integrable by Exercise 29 and closure
under negation. The upper rail \(P_k\) is integrable by the existing forward
log-positive envelope theorem. The real-log observable is measurable and
satisfies \(-J_k\le R_k\le P_k\), so `integrable_of_le_of_le` makes the middle
function integrable.

### Exercise 31. Package the process candidate

Which two obligations define the signed subadditive-process candidate, and
where are they discharged?

**Solution.** The candidate asks for integrability at every horizon and the
shifted subadditive inequality. Exercise 30 supplies integrability from the
three-field tail package. Pointwise invertibility, one of those fields,
supplies signed shifted subadditivity through declaration 9.

### Exercise 32. Analyze the infinite-measure boundary

Why is the zero forward constant integrable on real Lebesgue space while a
strictly positive inverse-log constant is not?

**Solution.** The integral of the zero norm is zero on any measure space. A
positive constant has integral equal to that constant times the total mass.
Lebesgue measure of the real line is infinite, so the latter integral is
infinite and the constant is not integrable.

### Exercise 33. Analyze the geometric probability boundary

For atom \(n\), let its mass be \(2^{-n-1}\) and let the inverse-log size be
\(2^n\). Prove that the inverse-log observable is not integrable.

**Solution.** The weighted absolute contribution at every atom is
\(2^{-n-1}2^n=1/2\). The integral criterion for Mathlib's geometric measure
reduces integrability to summability of these contributions. The series of
the constant one-half sequence diverges, so the observable is not integrable
even though the total measure is one.

### Exercise 34. Verify what the geometric example does not prove

Does that example establish failure under independent sampling or under an
ergodic base?

**Solution.** No. Its base map is the identity on the natural-number sample
space. The example is a one-step tail counterexample: pointwise units and
forward positive-log integrability do not force inverse-tail or signed
one-step integrability. It makes no independence or ergodicity claim.

### Exercise 35. Interpret the two-rate diagonal gap

For \(M=\operatorname{diag}(1/2,1/4)\), compare
\(-\log^+\lVert M^{-1}\rVert\) with \(\log\lVert M\rVert\).

**Solution.** The selected norm is the maximum row sum, hence
\(\lVert M\rVert=1/2\). The inverse is
\(\operatorname{diag}(2,4)\), whose norm is four. The lower estimate is
\(-\log 4=-2\log 2\), while the real log is
\(\log(1/2)=-\log 2\). The lower rail is strict because it sees the strongest
contracting direction, while the top norm sees the least contracting one.

### Exercise 36. Use shears to reject same-order inversion

Why is a product of pointwise inverses in forward order not generally the
inverse cocycle value?

**Solution.** For noncommuting matrices \(A\) and \(B\),
\((AB)^{-1}=B^{-1}A^{-1}\), which need not equal \(A^{-1}B^{-1}\). Upper and
lower unit shears provide explicit matrices for which the two products differ
in an entry. Therefore a same-order inverse-generator product would define a
different process.

### Exercise 37. Prove eventual agreement at a positive limit

Suppose \(P_n/n\to\gamma\) almost everywhere with \(\gamma\gt0\). Why do
\(P_n/n\) and \(R_n/n\) eventually agree at almost every convergent point?

**Solution.** Choose, for example, the positive threshold \(\gamma/2\).
Convergence gives an eventual bound \(P_n/n\gt\gamma/2\), so for every
sufficiently large positive \(n\), one has \(P_n\gt0\). Since
\(P_n=\max(0,R_n)\), positivity forces \(P_n=R_n\). Dividing by the same
positive natural cast preserves equality, and eventual equality transfers the
limit.

### Exercise 38. Explain why singular matrices remain allowed

Why does the positive-rate endpoint need no pointwise-unit hypothesis?

**Solution.** Its proof only uses convergence of the clipped top-norm
observable and strict positivity of the limiting rate. A singular matrix can
still have norm greater than one, such as `diag(2,0)`, so singular steps are
compatible with top-norm expansion. Once the realized finite-time log is
positive, clipping agrees with the ordinary real log regardless of whether
the underlying matrix is a unit.

### Exercise 39. Close the empty-dimensional endpoint

Why is the positive-rate theorem harmless when the matrix index type is
empty?

**Solution.** Every finite cocycle value then has selected norm zero, so every
positive-log observable and its integral are zero. The integrated rate is
therefore zero. The theorem's strict positivity premise cannot be satisfied,
making the specialization vacuous rather than contradictory.

### Exercise 40. Design the next theorem honestly

What additional result is still required before claiming a general signed
almost-everywhere limit from the RMT-34 candidate?

**Solution.** One needs a theorem that accepts an integrable real-valued
shifted-subadditive process and proves its normalized almost-everywhere
convergence under the appropriate finite-measure and ergodic hypotheses. The
current module only builds the candidate and proves a separate positive-rate
transfer from RMT-33. Calling either result a general signed Kingman theorem
would exceed the checked source.

## Discussion: what RMT-34 changes

The conceptual gain is a clean division of labor. Algebraic pointwise units
make ordinary logarithmic identities valid. The forward moment controls
expansion. The inverse moment controls finite contraction from below. Measure
preservation moves the inverse moment along the same forward orbit. None of
these jobs is silently assigned to another assumption.

That division also clarifies the next research step. RMT-34 has produced an
integrable signed candidate with exactly the finite-time inequality expected
by a real subadditive ergodic theorem. A later milestone can target that
generic theorem without reopening matrix inversion or matrix measurability.
Only after such a theorem is checked would it be appropriate to advertise a
general signed top-growth limit.

The positive endpoint has a different logic. It does not approximate the
negative tail and does not use the new candidate. It observes that a strictly
positive asymptotic value eventually lies in the branch where positive-part
clipping is inactive. Keeping these routes separate makes both the hypotheses
and the nonclaims easier to audit.

## References

The source boundary attached to each entry states exactly how it is used here.

<a id="ref-rmt34-furstenberg-kesten"></a>**H. Furstenberg and H. Kesten.**
“Products of Random Matrices.” *The Annals of Mathematical Statistics* 31,
no. 2 (1960), 457-469.
[DOI record](https://doi.org/10.1214/aoms/1177705909) and
[Hebrew University research record](https://cris.huji.ac.il/en/publications/products-of-random-matrices/).
Used for historical placement of random matrix products, not as a claim that
RMT-34 formalizes the paper's limit theorem.

<a id="ref-rmt34-kingman"></a>**J. F. C. Kingman.**
“The Ergodic Theory of Subadditive Stochastic Processes.” *Journal of the
Royal Statistical Society: Series B* 30, no. 3 (1968), 499-510.
[Publisher record](https://academic.oup.com/jrsssb/article/30/3/499/7026968)
and [DOI](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x).
Used to place the process interface historically. RMT-34 does not claim a new
formalization of Kingman's general theorem.

<a id="ref-rmt34-oseledets"></a>**V. I. Oseledets.**
“A Multiplicative Ergodic Theorem. Characteristic Lyapunov Exponents of
Dynamical Systems.” *Transactions of the Moscow Mathematical Society* 19
(1968), 197-231.
[MathNet record](https://www.mathnet.ru/eng/mmo214).
Used to identify the later multiplicative-ergodic destination. No spectrum,
filtration, or splitting from that theorem is claimed here.

<a id="ref-rmt34-ruelle"></a>**David Ruelle.**
“Ergodic Theory of Differentiable Dynamical Systems.” *Publications
Mathématiques de l'IHÉS* 50 (1979), 27-58.
[Numdam record](https://numdam.org/articles/10.1007/BF02684768/),
[DOI](https://doi.org/10.1007/BF02684768), and
[author-hosted scan](https://www.ihes.fr/~ruelle/PUBLICATIONS/%5B59%5D.pdf).
The introduction motivates derivative-cocycle applications. Theorem 1.1 and
Corollary 1.2 use a forward positive-log condition; Theorem 1.6 permits a
lowest exponent of negative infinity in its forward filtration; and Section
3, especially Theorem 3.1, treats the invertible setting with forward and
inverse positive-log conditions. These are contextual comparisons, not
imports into Lean.

<a id="ref-rmt34-mathlib-log"></a>**Mathlib contributors.**
[Real logarithm source at pinned commit](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/SpecialFunctions/Log/Basic.lean).
This is the source boundary for total `Real.log`, including its zero value and
measurability facts.

<a id="ref-rmt34-mathlib-poslog"></a>**Mathlib contributors.**
[Positive logarithm source at pinned commit](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/SpecialFunctions/Log/PosLog.lean).
This is the source boundary for `Real.posLog`, product bounds, clipping, and
continuity.

<a id="ref-rmt34-mathlib-inverse"></a>**Mathlib contributors.**
[Nonsingular matrix inverse source at pinned commit](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/LinearAlgebra/Matrix/NonsingularInverse.lean).
This is the source boundary for determinant-adjugate total inversion,
singular-zero behavior, and reversed product inversion.

<a id="ref-rmt34-mathlib-norm"></a>**Mathlib contributors.**
[Matrix operator norm source at pinned commit](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Matrix/Normed.lean).
This identifies the finite row-sup norm unfolded by the measurability proof.

<a id="ref-rmt34-mathlib-integrable"></a>**Mathlib contributors.**
[Bochner integrability source at pinned commit](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/L1Space/Integrable.lean).
This is the source boundary for finite-sum closure and domination-based
integrability.

<a id="ref-rmt34-mathlib-geometric"></a>**Mathlib contributors.**
[Geometric distribution source at pinned commit](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Probability/Distributions/Geometric.lean).
The compiled probability boundary uses `geometricMeasure` and
`integrable_geometricMeasure_iff` from this file.

<a id="ref-rmt34-lean"></a>**This project.**
The [site-hosted checked source](/lean/NonlinearDynamics/Random/RandomCocycles/RealLogNormIntegrability.lean)
is taken directly from the formalization tree. Its repository provenance is
[commit `624c727146532d3b2656f5f23136557d5779b4fd`](https://github.com/tdj28/nonlinear-dynamics-lean/commit/624c727146532d3b2656f5f23136557d5779b4fd),
which requires repository access while the repository is private. The source
is frozen for this note at 942 lines and SHA-256
`ac950f8728e5fd003cff3b7a5d0750e5c36060730b3ebadc5b0e1165b54e72ea`.
This warning-fatal Lean file is the authority for every formal claim in the
chapter.

## Continue the ascent

Read the companion
[Knowledge Base chapter]({{< relref "/knowledge-base/deep-dives/forward-and-inverse-tail-sandwich-for-finite-time-real-log-norms" >}})
for a slower textbook treatment of the mathematics. Then return to the
[RMT-33 Development Notebook]({{< relref "/development-notebook/2026/07/log-positive-kingman-convergence-from-rational-lower-deviations-in-lean" >}})
to compare the clipped convergence route with the signed finite-time package
constructed here.
