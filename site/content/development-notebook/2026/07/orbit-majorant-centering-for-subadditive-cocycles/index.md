---
title: "Subtract the Orbit Majorant: Centering Subadditive Cocycles in Lean"
slug: "orbit-majorant-centering-for-subadditive-cocycles"
date: 2026-07-21
weight: -51
author: "tdj28"
summary: "An eighteen-declaration Lean reduction subtracts the one-step Birkhoff majorant from a shifted-subadditive process, preserving subadditivity, preserving finite-horizon integrability under one-step measure preservation, and proving nonpositivity at positive horizons, with a uniform time-zero result under X(0) = 0 but no mean-zero or limit theorem."
lead: |
  Centering often means subtracting an expectation. Not here. RMT-19 subtracts the additive orbit sum of the one-step observable from each finite-horizon process value. The residual is nonpositive at every positive horizon, remains shifted-subadditive, and splits the normalized process exactly into a residual term and a finite Birkhoff average. It need not have mean zero, and no convergence theorem is proved.
key_result: |
  Eighteen public declarations and two private algebraic helpers now formalize orbit-majorant centering. Positive horizons need no time-zero normalization; a uniform statement through time zero needs X(0) = 0. Shifted subadditivity survives by finite algebra, while integrability of the centered family needs only one-step measure preservation. The cocycle pointwise layer uses the cocycle directly; the generator-integrability hypothesis enters only when packaging the centered cocycle family as an integrable candidate.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Shifted subadditivity, Birkhoff sums and averages, finite-horizon integrability, and matrix-cocycle compensation"
reading_time: "105 to 150 minutes"
prerequisites:
  - "Finite block decomposition for subadditive processes"
  - "Finite Birkhoff sums and Mathlib's totalized Birkhoff average"
  - "One-sided discrete matrix cocycles and their log-positive observable"
  - "Measure preservation only for the integrability layer"
  - "No probability, ergodicity, Birkhoff limit theorem, or Kingman theorem required"
  - "No prior Lean proof experience required"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveCentering"
lean_source: "formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveCentering.lean"
tags:
  - "Lean 4"
  - "Subadditive processes"
  - "Matrix cocycles"
  - "Birkhoff sums"
  - "Birkhoff averages"
  - "Orbit-majorant centering"
  - "Integrability"
og_image: "orbit-majorant-centering-for-subadditive-cocycles-card.png"
og_image_alt: "Warm-paper teaching card showing a finite process value, its additive one-step orbit majorant, and a shifted-subadditive residual labeled nonpositive at positive time. A separate label says that this is pointwise compensation, not expectation centering or a mean-zero theorem."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed Research Note. Verify claims against the cited primary
sources and any released artifacts before relying on them.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This teaching chapter is published as an open working
note while human
editorial acceptance and the separate scientific-integrity and zero-context
expert-reader reviews are pending. The checked Lean source is authoritative
for every theorem statement.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** Let \(T:\Omega\to\Omega\) be a discrete-time base map and let
\(X_n(\omega)\) be a real-valued shifted-subadditive process:

\[
X_{m+n}(\omega)
\le
X_n\bigl(T^m\omega\bigr)+X_m(\omega).
\]

The one-step observable \(X_1\) generates an additive finite orbit sum

\[
A_n(\omega)
{} =
\sum_{\substack{j\in\mathbb N\\j\lt n}}
X_1\bigl(T^j\omega\bigr).
\]

RMT-19 defines the centered process by \(Y_n=X_n-A_n\). Repeated
subadditivity makes \(A_n\) a pointwise majorant of \(X_n\) at every positive
horizon, so \(Y_n\le0\) there. A uniform statement at \(n=0\) needs exactly
\(X_0=0\), because \(A_0=0\) while subadditivity alone permits \(X_0\gt0\).
The exact addition identity for \(A_n\) also proves that \(Y_n\) remains
shifted-subadditive.

If \(T\) preserves a measure \(\mu\), then every finite \(A_n\) is integrable
whenever the candidate supplies integrability of \(X_1\). Hence every
\(Y_n\) is integrable and the centered family is another finite-horizon
candidate. Algebraically,

\[
\begin{aligned}
\frac{X_n(\omega)}{n}
&= \frac{Y_n(\omega)}{n} \\
&\quad+\operatorname{birkhoffAverage}_{n}(T,X_1,\omega),
\end{aligned}
\]

with Lean's totalized zero-horizon interpretation. This equality is not a
limit theorem.

The final layer specializes the reduction to a one-sided matrix cocycle's
log-positive norm observable. Its pointwise results use the cocycle directly.
Only the packaged integrability result needs the existing one-step
log-positive integrability hypothesis. Nothing here subtracts an expectation,
produces mean zero, proves a pointwise Birkhoff theorem, proves Kingman's
theorem, constructs a Lyapunov exponent, or obtains an Oseledets splitting.
{{< /panel >}}

This is the proof-to-prose companion for
<code>formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveCentering.lean</code>.
It covers all eighteen public declarations and both private helpers in exact
source order. The immediate predecessor is
[Finite Blocks Before Limits: Birkhoff Bounds for Subadditive Cocycles in Lean]({{< relref "/development-notebook/2026/07/finite-block-birkhoff-bounds-for-subadditive-cocycles" >}}).
That chapter proves the exact finite-block inequalities from which the
positive-horizon and uniform one-step majorants can be understood.

Reusable foundations include the
{{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}},
the
{{< refterm "birkhoff-sum" "Birkhoff sum" >}},
the
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycle" >}},
and the
{{< refterm "log-positive-integrability-envelope" "log-positive integrability envelope" >}}.
The parallel textbook treatment is
[Orbit-Majorant Centering for Subadditive Processes]({{< relref "/knowledge-base/deep-dives/orbit-majorant-centering-for-subadditive-processes" >}}).

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| First encounter | [Why subtract an orbit majorant?](#why-subtract-an-orbit-majorant) | See the finite reduction before Lean syntax |
| Terminology route | [Centered does not mean mean zero](#centered-does-not-mean-mean-zero) | Separate two different mathematical operations |
| Worked route | [A singleton example with a strict residual](#a-singleton-example-with-a-strict-residual) | Compute every term by hand |
| Boundary route | [Zero and one are different boundaries](#zero-and-one-are-different-boundaries) | Audit \(n=0\) and \(n=1\) |
| Algebra route | [The two private engines](#the-two-private-engines) | See which assumptions the core proofs actually consume |
| API route | [The eighteen public declarations](#the-eighteen-public-declarations) | Read the complete interface in source order |
| Analysis route | [Integrability has one dynamical gate](#integrability-has-one-dynamical-gate) | Locate the sole use of measure preservation |
| Cocycle route | [The thin cocycle specialization](#the-thin-cocycle-specialization) | Distinguish direct pointwise results from the \(hC\) package |
| Integrity route | [What the exact identity does not prove](#what-the-exact-identity-does-not-prove) | Block every asymptotic overread |

### Learning objectives

By the summit, a reader should be able to:

1. define the additive one-step orbit sum \(A_n\);
2. define the residual \(Y_n=X_n-A_n\);
3. explain why this operation is pointwise compensation rather than
   expectation centering;
4. compute \(Y_0\) and \(Y_1\) exactly;
5. derive the positive-horizon one-step majorant without assuming \(X_0=0\);
6. identify the exact reason a uniform majorant through zero needs \(X_0=0\);
7. convert a majorant inequality into nonpositivity with
   <code>sub_nonpos.mpr</code>;
8. use the Birkhoff-sum addition law to show that subtracting \(A_n\)
   preserves shifted subadditivity;
9. identify both raw private helpers and the public declarations they serve;
10. explain why the algebraic helper needs no measurable structure;
11. prove finite-horizon integrability of the residual under one-step measure
    preservation;
12. explain why probability and ergodicity are absent from that proof;
13. package the residual as a new integrable subadditive-process candidate;
14. simplify the normalized identity at \(n=0\);
15. distinguish a Birkhoff average from an expectation;
16. calculate the singleton process \(X_n=\sqrt n\) at \(n=4\);
17. use that example to refute a mean-zero interpretation;
18. use the constant-one process to expose the time-zero obstruction;
19. use an additive process to see when the residual vanishes;
20. follow all eighteen public declarations in exact source order;
21. explain why the cocycle's orbit sum is definitionally a Birkhoff sum;
22. identify which cocycle theorems take \(C\) directly;
23. identify the one cocycle theorem that consumes \(hC\);
24. verify that an empty matrix index remains supported;
25. distinguish log-positive compensation from a signed Lyapunov exponent;
26. state every limit theorem that remains absent; and
27. explain why finite phase averaging is the next dependency-ordered layer.

## Why subtract an orbit majorant?

Subadditivity compares a long horizon with shorter pieces, but it does not
immediately put every \(X_n\) on one common additive scale. The one-step
observable does. Starting at \(\omega\), read \(X_1\) at the successive orbit
points

\[
\omega,\quad T\omega,\quad T^2\omega,\quad \ldots,\quad T^{n-1}\omega,
\]

and add those \(n\) readings. The resulting function is the finite Birkhoff
sum

\[
A_n(\omega)
{} =
\operatorname{birkhoffSum}(T,X_1,n,\omega).
\]

It is additive across time splits in exactly the shifted sense needed here:

\[
A_{m+n}(\omega)
{} =
A_n\bigl(T^m\omega\bigr)+A_m(\omega).
\]

The order of the two real summands can be reversed, but the sample shift
cannot. The later \(n\)-step orbit sum starts after \(m\) applications of the
base map. Mathlib's finite Birkhoff-sum definition and addition law are the
exact library interfaces used here
([pinned Birkhoff-sum API](#ref-rmt19-birkhoff-basic)).

The original process satisfies only an inequality at the same split:

\[
X_{m+n}(\omega)
\le
X_n\bigl(T^m\omega\bigr)+X_m(\omega).
\]

Subtracting the exact additive identity from this inequality produces a
residual with the same shifted-subadditive orientation. The definition is

\[
Y_n(\omega)
{} =
X_n(\omega)-A_n(\omega).
\]

Repeatedly taking one-step pieces also gives \(X_n\le A_n\) whenever
\(n\gt0\). Consequently \(Y_n\le0\) at every positive horizon. This is a
finite pointwise fact. No measure has entered, so there is no probability
statement hiding inside it. This subtractive reduction appears explicitly in
the subadditive-cocycle literature
([Karlsson and Margulis](#ref-rmt19-karlsson-margulis),
[Lalley](#ref-rmt19-lalley)); the present module freezes only its finite Lean
layer.

The residual records how much smaller the finite process is than the
particular additive upper budget generated by its one-step values. In a
matrix-cocycle application, this difference can reflect strictness in norm
submultiplicativity, cancellations, or the information discarded by the
log-positive envelope. Random matrix products are a classical asymptotic
setting for such growth questions
([Furstenberg and Kesten](#ref-rmt19-furstenberg-kesten)). Those
interpretations are useful intuitions, but the Lean theorem states only the
inequality and shifted-subadditive law.

{{< reference-figure
  src="rmt19-assumption-and-proof-route.svg"
  alt="Three proof lanes begin from subtracting the additive one-step orbit majorant. The pointwise lane obtains a nonpositive residual, with time-zero normalization needed only for a uniform statement. The algebra lane preserves shifted subadditivity without analytic assumptions. The analytic lane adds one-step measure preservation to package finite-horizon integrability. A cocycle branch distinguishes direct pointwise results from the generator-integrability package."
  caption="**Finding:** orbit-majorant centering has three assumption-separated outputs. Positive-horizon nonpositivity and preservation of shifted subadditivity are finite algebra. Uniform nonpositivity at time zero additionally needs exact time-zero normalization. Finite-horizon integrability additionally needs preservation by the one-step base map, while probability, ergodicity, and every limit theorem remain outside all three lanes. The cocycle pointwise branch uses the cocycle directly; only candidate packaging consumes the one-step integrability hypothesis."
>}}

## Centered does not mean mean zero

The word “centered” is overloaded. In probability, centering an integrable
random variable often means subtracting its expectation:

\[
Z^{\mathrm{mean}}(\omega)
{} =
Z(\omega)-\int Z\,d\mu.
\]

When \(\mu\) is a probability measure and the integral is legitimate, this
construction has mean zero. It subtracts one scalar that summarizes the whole
distribution.

RMT-19 performs a different operation:

\[
Y_n(\omega)
{} =
X_n(\omega)
-
\sum_{\substack{j\in\mathbb N\\j\lt n}}
X_1\bigl(T^j\omega\bigr).
\]

The subtracted term depends on the horizon, the sample, the base orbit, and
the one-step observable. It is a pointwise finite orbit budget, not a scalar
expectation. The definition makes sense before a measurable space or measure
has been chosen.

| Question | Orbit-majorant compensation in RMT-19 | Expectation centering |
|---|---|---|
| What is subtracted? | A finite orbit sum depending on \(n\) and \(\omega\) | One scalar integral |
| Is a measure required to define it? | No | Yes |
| Is probability normalization required? | No | Usually, for the mean interpretation |
| What is guaranteed? | Pointwise nonpositivity at positive horizons under shifted subadditivity | Mean zero under the needed integration hypotheses |
| Is convergence guaranteed? | No | No |

Calling the new process “centered” is therefore a project-level shorthand for
compensation by an additive orbit majorant. Every page, card, caption, and
summary must keep that qualifier visible. A reader who sees only
<code>centeredProcess</code> should not infer expectation subtraction.

The term “Birkhoff average” introduces another possible confusion. It means a
finite Birkhoff sum divided by its finite horizon. It is not the same object
as a space average or expectation. An ergodic theorem may later relate a
limit of orbit averages to a space average under substantial hypotheses.
RMT-19 proves no such relation.

## A singleton example with a strict residual

Take a state space with one point, let \(T\) be the identity, and define

\[
X_n=\sqrt n.
\]

The sample argument can be suppressed because there is only one outcome. The
square-root function is subadditive on nonnegative reals, so

\[
\sqrt{m+n}\le\sqrt m+\sqrt n.
\]

The one-step value is \(X_1=1\). The length-\(n\) orbit sum is therefore

\[
A_n=n.
\]

At \(n=4\),

\[
X_4=2,\qquad A_4=4,\qquad Y_4=2-4=-2.
\]

The normalized identity becomes

\[
\frac{2}{4}
{} =
\frac{-2}{4}+1.
\]

Both sides equal \(1/2\). This example demonstrates four points at once:

1. the additive orbit sum can strictly majorize the subadditive process;
2. the centered residual can be strictly negative;
3. the normalized identity can be checked without any limiting argument; and
4. the residual is not mean zero.

For the last point, equip the singleton with its Dirac probability measure.
The integral of the constant function \(Y_4=-2\) is \(-2\). Probability
normalization does not magically change orbit-majorant compensation into
expectation centering.

An additive comparison provides the opposite boundary. If

\[
X_n(\omega)=\operatorname{birkhoffSum}(T,f,n,\omega)
\]

for some one-step observable \(f\), then \(X_1=f\), the majorant \(A_n\)
equals \(X_n\), and \(Y_n=0\) at every horizon. The new construction therefore
measures finite slack relative to the one-step additive budget. It is zero
for an exactly additive process and can be negative for a strictly
subadditive one.

## Zero and one are different boundaries

At time zero, a Birkhoff sum is empty:

\[
A_0=0.
\]

Therefore

\[
Y_0=X_0.
\]

Shifted subadditivity forces \(X_0\ge0\), but it does not force \(X_0=0\).
This was proved explicitly in RMT-18. Thus a theorem asserting \(Y_n\le0\)
for every natural \(n\) needs the additional normalization \(X_0=0\).

The constant-one process is the sharp counterexample. On any nonempty state
space, define \(X_n(\omega)=1\) for every \(n\) and \(\omega\). It is
subadditive because \(1\le1+1\). For \(n\gt0\), its one-step orbit sum equals
\(n\), so

\[
Y_n=1-n\le0.
\]

At zero, however,

\[
Y_0=1\gt0.
\]

This counterexample survives on a probability space with a preserved
identity base map. Probability, preservation, and ergodicity cannot repair a
missing time-zero normalization because the obstruction is pointwise
algebra.

At time one, the behavior is entirely different:

\[
A_1(\omega)=X_1(\omega),
\qquad
Y_1(\omega)=0.
\]

This identity needs no subadditivity, measure, normalization, or probability.
It is a direct consequence of a one-term Birkhoff sum. The API records both
boundaries as simplification theorems so later proofs do not have to unfold
the definition and rediscover them.

The normalized identity has another zero-time subtlety. In Lean's real field,
division by zero is totalized, so \(x/0=0\). Mathlib also defines the
zero-length Birkhoff average as zero. Hence declaration 11 at \(n=0\) reads

\[
0=0+0.
\]

It is true without \(X_0=0\), but it says nothing about the unnormalized
value \(Y_0=X_0\). Totalized normalization erases the zero-time obstruction;
it does not solve it. The totalized definition and its zero law are visible in
Mathlib's pinned average API
([Birkhoff averages](#ref-rmt19-birkhoff-average)).

## The two private engines

The public API uses a bundled candidate because that is the project's
reusable finite-horizon interface. The strongest pointwise arguments,
however, consume only its shifted-subadditive field. RMT-19 records this fact
with two private raw helpers.

### Private helper 1: subtract an additive orbit sum

<code>centeredProcess_add_le_of_add_le</code> assumes only

\[
\forall m,n,\omega,\quad
X_{m+n}(\omega)
\le
X_n(T^m\omega)+X_m(\omega).
\]

Its conclusion is the same shifted-subadditive inequality for
<code>centeredProcess T X</code>. The Lean proof has three moves:

1. unfold <code>centeredProcess</code>;
2. rewrite the long Birkhoff sum with <code>birkhoffSum_add</code>; and
3. use <code>linarith</code> with the raw inequality.

The rewrite supplies an equality, not an estimate:

\[
A_{m+n}(\omega)
{} =
A_n(T^m\omega)+A_m(\omega).
\]

Subtracting that equality from the process inequality preserves its
orientation. No measurable-space instance appears in the helper's signature.
No integrability field, measure-preserving map, probability typeclass,
time-zero normalization, or limit is available for the proof to use.

This helper is private because the public method belongs on the existing
candidate interface. Keeping the raw engine private records assumption
minimality without creating a second public hierarchy.

### Private helper 2: build the positive-horizon majorant

<code>oneStepBirkhoffMajorant_of_add_le</code> also consumes only the raw
shifted-subadditive inequality. It takes \(n\ne0\), rewrites the horizon as a
successor, and inducts on the remaining natural number.

The base case is a one-step horizon. The process value \(X_1\) equals the
one-term Birkhoff sum. At the successor step, shifted subadditivity peels off
the newest one-step contribution:

\[
X_{n+2}(\omega)
\le
X_1(T^{n+1}\omega)+X_{n+1}(\omega).
\]

The induction hypothesis replaces \(X_{n+1}\) with its orbit-sum majorant.
The recurrence <code>birkhoffSum_succ</code> then identifies the result with
the length-\(n+2\) Birkhoff sum. Real addition is commutative, so the final
proof closes with <code>add_comm</code>.

Why not simply expose RMT-18's exact-block theorem at block length one? The
public mathematical result is the same, but the raw helper makes a stronger
API audit possible: the positive-horizon majorant depends only on
shifted-subadditivity. It does not consume the candidate's integrability
field. The helper also compiles the boundary \(n\ne0\) directly rather than
hiding it behind time-zero normalization.

## The eighteen public declarations

The source order is part of the teaching contract. Definitions and boundary
simplifications come first, then the two private engines, then the generic
candidate methods, the normalized identity, and finally the thin cocycle
specialization.

| Order | Declaration | Mathematical output | Essential input |
|---:|---|---|---|
| 1 | <code>centeredProcess</code> | \(Y_n=X_n-A_n\) | Functions only |
| 2 | <code>centeredProcess_zero</code> | \(Y_0=X_0\) | Empty finite sum |
| 3 | <code>centeredProcess_one</code> | \(Y_1=0\) | One-term finite sum |
| private A | <code>centeredProcess_add_le_of_add_le</code> | Subtracting the orbit sum preserves shifted subadditivity | Raw shifted subadditivity only |
| private B | <code>oneStepBirkhoffMajorant_of_add_le</code> | \(X_n\le A_n\) for \(n\ne0\) | Raw shifted subadditivity only |
| 4 | <code>oneStepBirkhoffMajorant_of_ne_zero</code> | \(X_n\le A_n\) for \(n\ne0\) | Shifted subadditivity |
| 5 | <code>oneStepBirkhoffMajorant</code> | \(X_n\le A_n\) for all \(n\) | Shifted subadditivity and \(X_0=0\) |
| 6 | <code>centeredProcess_nonpos_of_ne_zero</code> | \(Y_n\le0\) for \(n\ne0\) | Declaration 4 |
| 7 | <code>centeredProcess_nonpos</code> | \(Y_n\le0\) for all \(n\) | Declaration 5 |
| 8 | <code>centeredProcess_add_le</code> | \(Y\) remains shifted-subadditive | Private helper 1 |
| 9 | <code>integrable_centeredProcess</code> | Every \(Y_n\) is integrable | Candidate integrability and preservation of \(T\) |
| 10 | <code>centeredProcess_candidate</code> | \(Y\) is a new candidate | Declarations 8 and 9 |
| 11 | <code>normalized_eq_centered_add_birkhoffAverage</code> | Exact normalized split | Ring algebra |
| 12 | <code>birkhoffSum_logPlusNormObservable_one_eq_orbitLogPlusSum</code> | Generic and cocycle sum notations agree | Definitional equality |
| 13 | <code>centeredLogPlusNormObservable</code> | Define the cocycle residual | Declaration 1 |
| 14 | <code>centeredLogPlusNormObservable_apply</code> | Expose \(G_n-S_n\) | Definitional equality |
| 15 | <code>centeredLogPlusNormObservable_nonpos</code> | Cocycle residual is nonpositive | Existing pointwise majorant from \(C\) |
| 16 | <code>centeredLogPlusNormObservable_add_le</code> | Cocycle residual is shifted-subadditive | Private helper 1 and \(C\) |
| 17 | <code>centeredLogPlusNormObservable_candidate</code> | Integrable cocycle residual candidate | \(hC\) and base preservation |
| 18 | <code>logPlusNormObservable_normalized_eq_centered_add_birkhoffAverage</code> | Cocycle normalized split | Declaration 11 |

### Declaration 1: define the orbit-majorant residual

~~~lean
def centeredProcess {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ)
    (n : ℕ) (ω : Ω) : ℝ :=
  X n ω - birkhoffSum T (X 1) n ω
~~~

The definition is deliberately prior to every analytic structure. The type
\(\Omega\) need not carry a measurable space, \(T\) need not preserve
anything, and \(X\) need not satisfy subadditivity. Those hypotheses enter
only when a theorem needs them.

There are two important design choices. First, the observable in the orbit
sum is exactly \(X_1\). The definition does not select an arbitrary comparison
function. Second, the base map is \(T\), not a powered block map. RMT-18
handled a general block length \(b\); RMT-19 chooses \(b=1\) because the goal
is to separate every finite process value into a one-step additive part and a
residual.

The declaration name says <code>centeredProcess</code>, while its docstring
says “pointwise compensation, not centering by an expectation.” That
docstring is part of the mathematical interface. A short name remains useful
inside later formulas, but it must not erase the operation's meaning.

### Declaration 2: time zero retains the original value

~~~lean
@[simp] theorem centeredProcess_zero {Ω : Type uΩ} (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) :
    centeredProcess T X 0 = X 0
~~~

The theorem is an equality of functions. The proof uses
<code>funext</code> to fix an outcome and then simplifies the empty Birkhoff
sum. Registering the theorem with <code>simp</code> means that a later goal
containing <code>centeredProcess T X 0</code> exposes the true boundary
immediately.

This result prevents a common false intuition. Subtracting a majorant does not
automatically normalize time zero. The majorant contributes nothing there,
so whatever value \(X_0\) had remains visible in \(Y_0\).

### Declaration 3: one step cancels exactly

~~~lean
@[simp] theorem centeredProcess_one {Ω : Type uΩ} (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) :
    centeredProcess T X 1 = 0
~~~

Again the result is a function equality. Mathlib's
<code>birkhoffSum_one</code> says the one-term orbit sum is the observable at
the original point. Therefore \(X_1-X_1=0\).

This exact identity is stronger than nonpositivity and needs no candidate
hypothesis. It is a useful sanity check for the definition, the cocycle
specialization, and any future normalization formula.

The two private helpers occur here in the source. Their placement matters:
they are raw engines available to both the generic candidate namespace and
the later cocycle namespace.

### Declaration 4: positive time needs no zero normalization

~~~lean
theorem oneStepBirkhoffMajorant_of_ne_zero
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (n : ℕ) (hn : n ≠ 0) (ω : Ω) :
    X n ω ≤ birkhoffSum T (X 1) n ω
~~~

The method invokes <code>oneStepBirkhoffMajorant_of_add_le</code> with
<code>hX.add_le</code>. The bundled receiver contains integrability of every
horizon, but this proof does not read that field. Its mathematical core is
pure shifted subadditivity.

The explicit premise \(n\ne0\) is not clutter. It is the exact guard that
removes the constant-one obstruction. Once at least one one-step piece is
present, repeated subadditivity controls the process with no statement about
\(X_0\).

### Declaration 5: exact zero normalization gives a uniform theorem

~~~lean
theorem oneStepBirkhoffMajorant
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hX0 : X 0 = 0) (n : ℕ) (ω : Ω) :
    X n ω ≤ birkhoffSum T (X 1) n ω
~~~

The proof splits on \(n\). At zero, <code>simp [hX0]</code> closes the exact
boundary. At a successor horizon, the raw positive-time helper supplies the
inequality, so the proof never uses \(hX0\) away from zero.

This case split documents premise locality. A stronger hypothesis is attached
only to the branch that needs it. The theorem is convenient when a normalized
process already has \(X_0=0\), while declaration 4 remains the more general
interface for positive time.

### Declaration 6: positive-horizon residuals are nonpositive

~~~lean
theorem centeredProcess_nonpos_of_ne_zero
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (n : ℕ) (hn : n ≠ 0) (ω : Ω) :
    centeredProcess T X n ω ≤ 0
~~~

For real numbers, \(a-b\le0\) is equivalent to \(a\le b\).
<code>sub_nonpos.mpr</code> performs exactly that conversion. The proof is one
line because declaration 4 already has the correct pointwise inequality.

Nonpositivity is a sign statement about a residual. It does not say the
residual is a negative part, a martingale difference, a fluctuation about a
mean, or a quantity with zero integral. The theorem has no measure premise.

### Declaration 7: uniform nonpositivity includes time zero

~~~lean
theorem centeredProcess_nonpos
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hX0 : X 0 = 0) (n : ℕ) (ω : Ω) :
    centeredProcess T X n ω ≤ 0
~~~

This is the same order conversion applied to declaration 5. At \(n=0\), it
reduces to \(X_0\le0\). RMT-18 proved that subadditivity already forces
\(X_0\ge0\), so the equality \(X_0=0\) is exactly what a uniform sign theorem
requires.

Do not reverse this logic. The uniform theorem does not prove normalization
from nothing. It takes normalization as an explicit premise.

### Declaration 8: the residual remains shifted-subadditive

~~~lean
theorem centeredProcess_add_le
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (m n : ℕ) (ω : Ω) :
    centeredProcess T X (m + n) ω ≤
      centeredProcess T X n (T^[m] ω) + centeredProcess T X m ω
~~~

The public method delegates to <code>centeredProcess_add_le_of_add_le</code>
with <code>hX.add_le</code>. It does not require \(X_0=0\). It also does not
use <code>hX.integrable</code>, even though the receiver stores that field.

The general principle is worth isolating:

> subtracting a shifted-additive process from a shifted-subadditive process
> leaves a shifted-subadditive process.

Here the Birkhoff sum generated by \(X_1\) is the shifted-additive process.
The exact <code>birkhoffSum_add</code> theorem is what makes the subtraction
safe. Subtracting an arbitrary family \(B_n\) would not preserve
subadditivity unless \(B\) obeyed a compatible law.

### Declaration 9: finite-horizon integrability

~~~lean
theorem integrable_centeredProcess
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (n : ℕ) :
    Integrable (centeredProcess T X n) μ
~~~

The definition is a difference, so the proof needs two integrable functions.
The candidate supplies <code>hX.integrable n</code> for \(X_n\). RMT-18's
<code>integrable_birkhoffSum_blocks</code>, specialized to block length one,
supplies integrability of \(A_n\). The identity
<code>Function.iterate_one</code> turns preservation of \(T^{1}\) into the
given premise \(hT\).

Then <code>Integrable.sub</code> closes the proof. The assumption ledger is:

| Input | Why it appears |
|---|---|
| Integrability of \(X_n\) | The first term in \(Y_n=X_n-A_n\) |
| Integrability of \(X_1\) | Each summand in \(A_n\) |
| Preservation of \(T\) | Transport integrability through every finite iterate |
| Probability | Not used |
| Ergodicity | Not used |
| \(X_0=0\) | Not used |

Measure preservation is not needed to define the Birkhoff sum or prove its
pointwise majorant. It enters only because composition with an arbitrary map
need not preserve integrability.

### Declaration 10: package the centered candidate

~~~lean
theorem centeredProcess_candidate
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) :
    IsIntegrableSubadditiveProcessCandidate T μ (centeredProcess T X)
~~~

The constructor has two fields. Declaration 9 fills
<code>integrable</code>, and declaration 8 fills <code>add_le</code>. There
is no field asserting nonpositivity and no field asserting \(Y_0=0\).
Consequently this package needs neither \(X_0=0\) nor declaration 7.

That distinction is important for future reuse. A centered candidate is
available whenever the original candidate lives over a measure-preserving
base, even if its zero-time value is positive. Positive-horizon
nonpositivity remains separately available from declaration 6.

### Declaration 11: the normalized finite identity

~~~lean
theorem normalized_eq_centered_add_birkhoffAverage
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (n : ℕ) (ω : Ω) :
    X n ω / (n : ℝ) = centeredProcess T X n ω / (n : ℝ) +
      birkhoffAverage ℝ T (X 1) n ω
~~~

Unfolding the two definitions turns the theorem into ordinary field algebra.
The proof uses <code>ring</code>. There is no measurable-space instance in
the signature, and there are no subadditivity, integrability, preservation,
probability, or ergodicity premises.

For \(n\gt0\), the identity reads

\[
\begin{aligned}
\frac{X_n(\omega)}{n}
&= \frac{Y_n(\omega)}{n} \\
&\quad+\frac{1}{n}
\sum_{\substack{j\in\mathbb N\\j\lt n}}
X_1(T^j\omega).
\end{aligned}
\]

At \(n=0\), every displayed normalized term is totalized to zero. That branch
is a valuable compilation test, but it must not be described as division by a
positive horizon.

The equality offers a route for later asymptotic work: control the normalized
residual and control the Birkhoff average. RMT-19 does neither. An exact
decomposition of a sequence is not convergence of either term.

### Declaration 12: two names for the same cocycle orbit sum

~~~lean
@[simp] theorem birkhoffSum_logPlusNormObservable_one_eq_orbitLogPlusSum
    (C : DiscreteMatrixCocycle (ι := ι) μ) (n : ℕ) :
    birkhoffSum C.base (C.logPlusNormObservable 1) n =
      C.orbitLogPlusSum n
~~~

The proof is <code>rfl</code>. RMT-15 defined
<code>orbitLogPlusSum</code> by the same finite sum. RMT-19 does not create a
second numerical object. It adds a named bridge between generic Birkhoff
language and the established cocycle API.

This bridge is an equality of functions, so later simplification can rewrite
an entire finite observable without fixing an outcome.

### Declaration 13: define the cocycle residual

~~~lean
def centeredLogPlusNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (n : ℕ) : Ω → ℝ :=
  centeredProcess C.base C.logPlusNormObservable n
~~~

The specialization carries no new premise. A
<code>DiscreteMatrixCocycle</code> already supplies its base map and
finite-horizon log-positive observable. The residual is the generic centered
process applied to those data.

The name remains careful: this is a centered **log-positive norm observable**,
not a signed logarithmic norm and not a Lyapunov exponent.

### Declaration 14: expose the finite difference

~~~lean
@[simp] theorem centeredLogPlusNormObservable_apply
    (C : DiscreteMatrixCocycle (ι := ι) μ) (n : ℕ) (ω : Ω) :
    C.centeredLogPlusNormObservable n ω =
      C.logPlusNormObservable n ω - C.orbitLogPlusSum n ω
~~~

This theorem is also proved by <code>rfl</code>. The project definitions were
chosen to line up definitionally. No theorem about integrability or
subadditivity is needed merely to expose the expression.

### Declaration 15: cocycle nonpositivity uses \(C\), not \(hC\)

~~~lean
theorem centeredLogPlusNormObservable_nonpos
    (C : DiscreteMatrixCocycle (ι := ι) μ) (n : ℕ) (ω : Ω) :
    C.centeredLogPlusNormObservable n ω ≤ 0
~~~

RMT-15 already proved
<code>C.logPlusNormObservable_le_orbitLogPlusSum n ω</code>. Declaration 14
rewrites the residual, and <code>sub_nonpos.mpr</code> converts that existing
pointwise majorant into nonpositivity.

The result includes \(n=0\) without an explicit normalization premise because
the cocycle observable was previously proved to vanish at zero. This is an
example of a specialization discharging a generic boundary internally.

No <code>HasIntegrableGeneratorLogPlus</code> hypothesis appears. Adding one
would confuse a pointwise norm inequality with the separate analytic question
of whether the functions are integrable.

### Declaration 16: cocycle shifted subadditivity also uses \(C\) directly

~~~lean
theorem centeredLogPlusNormObservable_add_le
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (m n : ℕ) (ω : Ω) :
    C.centeredLogPlusNormObservable (m + n) ω ≤
      C.centeredLogPlusNormObservable n (C.base^[m] ω) +
        C.centeredLogPlusNormObservable m ω
~~~

The proof calls private helper 1 with
<code>C.logPlusNormObservable_add_le</code>. It deliberately bypasses the
integrable candidate wrapper. The cocycle itself already carries the raw
finite subadditivity theorem required by the algebra.

Again there is no \(hC\). This is precisely why the private raw helper was
retained.

### Declaration 17: \(hC\) enters only for candidate packaging

~~~lean
theorem HasIntegrableGeneratorLogPlus.centeredLogPlusNormObservable_candidate
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) :
    IsIntegrableSubadditiveProcessCandidate C.base μ
      C.centeredLogPlusNormObservable
~~~

The package needs integrability of every centered horizon. The hypothesis
\(hC\) supplies the existing candidate for the original log-positive family.
Declaration 9 then centers that candidate using
<code>C.base_preserving</code>. Declaration 16 supplies the shifted
subadditivity field directly.

This is the only public cocycle declaration in RMT-19 that needs \(hC\).
The distinction should remain visible in every assumption table:

| Cocycle conclusion | Receiver | Uses \(hC\)? |
|---|---|---:|
| Pointwise nonpositivity | \(C\) | No |
| Shifted subadditivity | \(C\) | No |
| Integrable candidate | \(hC\) | Yes |
| Normalized pointwise identity | \(C\) | No |

### Declaration 18: the cocycle normalized split

~~~lean
theorem logPlusNormObservable_normalized_eq_centered_add_birkhoffAverage
    (C : DiscreteMatrixCocycle (ι := ι) μ) (n : ℕ) (ω : Ω) :
    C.logPlusNormObservable n ω / (n : ℝ) =
      C.centeredLogPlusNormObservable n ω / (n : ℝ) +
        birkhoffAverage ℝ C.base (C.logPlusNormObservable 1) n ω
~~~

The proof is declaration 11 with the generic arguments inferred. The theorem
is pointwise and finite. It needs neither \(hC\) nor a probability measure.

The first term on the right is nonpositive. That sign may be useful in future
upper-bound arguments, but it does not prove that the term converges, vanishes
after normalization, or has an integrable dominating function independent of
\(n\). The second term is a finite orbit average. Its notation does not invoke
a pointwise ergodic theorem.

## Integrability has one dynamical gate

The formalization separates three questions that are often compressed in
informal arguments:

1. Is the residual defined?
2. Is it pointwise nonpositive and shifted-subadditive?
3. Is every residual horizon integrable?

The first question needs functions only. The second needs shifted
subadditivity, plus \(X_0=0\) only if the sign theorem must include zero. The
third needs analytic data: integrability from the candidate and preservation
of the one-step map.

Why preservation? The orbit sum contains functions

\[
X_1\circ T^j.
\]

Even if \(X_1\) is integrable, composition with an arbitrary map can
concentrate the domain on a nonintegrable region. A measure-preserving map
keeps the integral under control, and every natural iterate of a
measure-preserving map is measure preserving. A finite sum of the transported
integrable functions is therefore integrable. The proof uses the official
[measure-preserving iterate interface](#ref-rmt19-preserving) and
[integrability closure results](#ref-rmt19-integrable) at exactly this gate.

The result is finite in two senses. First, \(n\) is fixed when integrability is
proved. Second, the sum has exactly \(n\) terms. Nothing establishes uniform
integrability as \(n\to\infty\), an integrable envelope common to all
normalized residuals, or permission to exchange a future limit and integral.

Probability normalization is irrelevant here. The proof works for any
measure preserved by \(T\), including the zero measure and measures of
arbitrary total mass. Ergodicity is also irrelevant. It constrains invariant
objects; it is not required to transport integrability through a finite orbit.

## The thin cocycle specialization

For a discrete matrix cocycle \(C\), write

\[
G_n(\omega)
{} =
C.\operatorname{logPlusNormObservable}(n,\omega)
\]

and

\[
S_n(\omega)
{} =
C.\operatorname{orbitLogPlusSum}(n,\omega).
\]

The centered cocycle observable is

\[
H_n(\omega)=G_n(\omega)-S_n(\omega).
\]

The earlier cocycle modules already established \(G_n\le S_n\), the shifted
subadditivity of \(G_n\), base-map preservation, and the conditional
integrability package. RMT-19 should reuse those facts rather than derive them
again through a stronger interface.

The two <code>rfl</code> declarations show that the generic and cocycle
definitions align exactly. The pointwise nonpositivity theorem reads the old
majorant directly. The shifted-subadditivity theorem reads the old raw
inequality directly. Only the candidate constructor crosses the
integrability gate.

This thinness matters. A theorem that takes \(hC\) merely because a convenient
candidate object can be built from \(hC\) advertises an assumption the
mathematics does not need. The source instead uses a private raw helper and
keeps the public signatures honest.

### Empty matrix dimension

The cocycle namespace assumes <code>Fintype ι</code> and
<code>DecidableEq ι</code>. It does not assume <code>Nonempty ι</code>. When
\(\iota\) is empty, the matrices have no entries, but the previous norm and
log-positive definitions still supply total values and checked laws. All six
cocycle declarations remain meaningful.

This boundary guards against an accidental positive-dimension assumption
entering through intuition about ordinary matrices. Nothing in orbit-majorant
centering needs a row, eigenvalue, determinant, or nonzero vector.

### Two scalar calibrations

For a constant one-dimensional cocycle with multiplier \(\lambda\), the
log-positive observable illustrates what the residual can forget.

If \(|\lambda|\gt1\), then finite log-positive growth is additive:

\[
G_n=n\log|\lambda|,
\qquad
S_n=n\log|\lambda|,
\qquad
H_n=0.
\]

If \(0\lt|\lambda|\lt1\), the positive logarithm clips contraction:

\[
G_n=0,
\qquad
S_n=0,
\qquad
H_n=0.
\]

The same zero residual therefore occurs for exact expansion accounting and
for completely clipped contraction. It cannot by itself be called a signed
growth fluctuation or a Lyapunov exponent. Matrix-valued examples can produce
strictly negative residuals when the finite norm of a product is smaller than
the product of one-step norm budgets, but the theorem does not classify the
source of that slack.

## Assumption ledger

| Result family | Shifted subadditivity | \(X_0=0\) | Measure preserving \(T\) | Probability | Ergodicity | \(hC\) |
|---|---:|---:|---:|---:|---:|---:|
| Definition and zero/one simp laws | No | No | No | No | No | No |
| Positive-horizon majorant and sign | Yes | No | No | No | No | No |
| Uniform majorant and sign | Yes | Yes | No | No | No | No |
| Residual shifted subadditivity | Yes | No | No | No | No | No |
| Generic residual integrability | Candidate fields | No | Yes | No | No | Not applicable |
| Generic centered candidate | Candidate fields | No | Yes | No | No | Not applicable |
| Normalized identity | No | No | No | No | No | No |
| Cocycle pointwise sign and algebra | Stored in \(C\) | Internally discharged | Stored but not needed pointwise | No | No | No |
| Cocycle centered candidate | Stored in \(C\) | No | Stored in \(C\) | No | No | Yes |
| Cocycle normalized identity | No | No | No | No | No | No |

The phrase “candidate fields” in the analytic rows means that integrability
and shifted subadditivity come from the existing structure, while
preservation remains a separate premise. It does not mean that every field is
used by every theorem.

## Lean proofcraft

### Keep raw algebra outside analytic namespaces

Both private helpers quantify over an arbitrary type \(\Omega\). This is not
merely aesthetic generality. It makes Lean enforce the claim that their proofs
cannot use measurability, integrability, preservation, probability, or
ergodicity. The helpers accept one raw inequality and return one raw
inequality.

The public methods still live in
<code>IsIntegrableSubadditiveProcessCandidate</code>. That placement gives
users a discoverable dot-notation API without pretending every stored field is
mathematically necessary to the underlying proof.

### Match the recurrence to the peeled piece

The positive-horizon induction peels off the final one-step term
\(X_1(T^{n+1}\omega)\). Mathlib's <code>birkhoffSum_succ</code> appends exactly
that newest orbit reading. If the proof had peeled the first step instead,
<code>birkhoffSum_succ'</code> would have been the more natural recurrence.

Choosing the recurrence that matches the proof prevents unnecessary iterate
algebra. It also makes the chronological meaning of the shift visible.

### Use function equality at stable boundaries

Declarations 2, 3, and 12 state equalities of functions rather than only
pointwise equalities. The proofs use <code>funext</code> or <code>rfl</code>,
and downstream simplification can rewrite the whole observable. Declaration
14 is pointwise because its intended use immediately compares real values.

### Let totalization compile the boundary, then explain it

Lean's natural horizons and real division are total. The theorem does not need
a separate positive-horizon signature merely to be syntactically meaningful
at zero. That convenience increases the prose obligation: the zero branch
must be simplified explicitly so a reader does not mistake \(x/0=0\) for
ordinary positive-denominator algebra.

### Prove the public surface in a root import smoke test

A leaf file can compile while a declaration remains unavailable from the root
aggregator. The milestone therefore needs both a warning-fatal leaf check and
an import smoke test through <code>NonlinearDynamics</code>. The Notebook's
<code>#check</code> block below names every public declaration and catches a
missing import or namespace mismatch.

## Common wrong turns

### Calling \(Y_n\) mean zero

Nonpositivity and mean zero are different conclusions. The singleton
\(X_n=\sqrt n\) example gives \(Y_4=-2\), including under a probability
measure. Replace “mean-zero centered process” with “pointwise residual after
subtracting the additive one-step orbit majorant.”

### Subtracting \(\int X_n\,d\mu\)

That would define another process with different hypotheses and different
algebra. It would not be definitionally the RMT-19 process, and it would not
automatically preserve the same shifted-subadditive law.

### Demanding \(X_0=0\) at every theorem

The positive-horizon majorant, positive-horizon sign, preservation of
subadditivity, integrability, candidate packaging, and normalized identity do
not need this premise. It belongs only on the uniform generic majorant and
uniform generic sign theorem.

### Removing \(X_0=0\) from the uniform sign theorem

The constant-one process refutes the resulting statement at \(n=0\). Adding
probability or ergodicity does not help.

### Treating \(Y_1=0\) as a consequence of subadditivity

It is definitional finite-sum cancellation and holds for every family \(X\).
The proof should remain at the weaker assumption level.

### Requiring measure preservation for pointwise algebra

Preservation enters only to transport integrability through orbit iterates.
The finite sum, majorant, sign, and subadditive residual exist pointwise
without it.

### Requiring probability for an integral theorem

<code>Integrable</code> is defined relative to a measure of arbitrary mass.
Declaration 9 and both candidate constructors make no expectation claim, so a
probability typeclass would be gratuitous.

### Requiring ergodicity because a Birkhoff name appears

A Birkhoff sum and Birkhoff average are finite definitions. Ergodicity belongs
to some limit theorems, not to the syntax of the finite objects.

### Assuming the normalized residual tends to zero

The sign \(Y_n/n\le0\) for positive \(n\) is not a convergence result. A
nonpositive sequence can oscillate or diverge to negative infinity. A future
proof needs quantitative lower control or a separate asymptotic argument.

### Assuming the Birkhoff average converges

The module imports Mathlib's finite average definition. The pinned Mathlib
release does not supply a theorem in this module proving pointwise convergence
for the present observable and base.

### Interpreting the exact split as Kingman's theorem

An identity of three finite values does not give an almost-everywhere limit,
an invariant limit field, an integral formula, or ergodic constancy. It is a
coordinate change for later reasoning. Kingman's primary theorem is the
eventual asymptotic destination, not a result imported by this module
([Kingman, 1968](#ref-rmt19-kingman)).

### Reconstructing the cocycle proof through \(hC\)

Declarations 15 and 16 need only the cocycle's established pointwise laws.
Routing them through
<code>hC.isIntegrableSubadditiveProcessCandidate</code> would strengthen their
signatures for no mathematical reason.

### Calling the cocycle residual a signed Lyapunov fluctuation

The observable uses \(\log^+\), which discards contraction and exact collapse.
Even a future limit of it would not automatically equal a signed top Lyapunov
exponent. The residual is finite log-positive slack relative to a one-step
budget.

### Adding a positive matrix dimension

No proof selects an index or vector. The empty finite index is a legitimate
boundary and must remain accepted.

## What the exact identity does not prove

RMT-19 proves finite definitions, inequalities, integrability statements, and
identities. It proves none of the following:

1. convergence of \(Y_n/n\);
2. convergence of the finite Birkhoff averages;
3. almost-everywhere convergence of \(X_n/n\);
4. convergence in probability, measure, \(L^1\), or any \(L^p\) space;
5. a pointwise or mean Birkhoff ergodic theorem;
6. Kingman's subadditive ergodic theorem;
7. a maximal inequality;
8. invariance of a samplewise limit;
9. constancy of a limit under ergodicity;
10. equality between a samplewise limit and the deterministic Fekete rate;
11. permission to exchange a limit and an integral;
12. uniform integrability of any normalized family;
13. a rate of convergence;
14. a martingale or martingale-difference structure;
15. independence, stationarity as a separate law, or mixing;
16. expectation centering or mean zero;
17. a signed logarithmic norm observable;
18. a Furstenberg-Kesten exponent;
19. a Lyapunov exponent;
20. singular-value growth or an Oseledets splitting;
21. invertibility of the base or matrices;
22. negative-tail integrability;
23. positive matrix dimension; or
24. the finite phase-averaging identities needed by the next proof layer.

The honest achievement is still substantial. The process has been separated
into one additive orbit component and one shifted-subadditive residual that is
nonpositive at positive horizons, and uniformly nonpositive through time zero
under \(X_0=0\), with every finite-horizon analytic gate exposed. Later
asymptotic work can now state exactly which of the two normalized terms it
controls.

## Exercises with solutions

### Exercise 1: expand the orbit majorant

Write \(A_3(\omega)\) without Birkhoff notation.

**Solution.**

\[
A_3(\omega)
{} =
X_1(\omega)+X_1(T\omega)+X_1(T^2\omega).
\]

There are three readings, at orbit times zero, one, and two.

### Exercise 2: evaluate time zero

What is \(Y_0\), and which assumption is needed?

**Solution.** \(A_0=0\), so \(Y_0=X_0\). No assumption is needed. Exact
normalization is needed only if one wants to simplify this further to zero.

### Exercise 3: evaluate time one

Prove \(Y_1=0\) without subadditivity.

**Solution.** The one-term Birkhoff sum is \(A_1(\omega)=X_1(\omega)\).
Therefore \(Y_1=X_1-X_1=0\).

### Exercise 4: compute the strict singleton example

For \(X_n=\sqrt n\), compute \(X_4\), \(A_4\), and \(Y_4\).

**Solution.** \(X_4=2\), \(X_1=1\), \(A_4=4\), and \(Y_4=-2\).

### Exercise 5: reject mean zero

Put the Dirac probability measure on that singleton. What is
\(\int Y_4\,d\mu\)?

**Solution.** It is \(-2\), because \(Y_4\) is the constant function \(-2\).
Orbit-majorant centering does not imply mean zero.

### Exercise 6: find the equality case

Suppose \(X_n=\operatorname{birkhoffSum}(T,f,n)\). What is \(Y_n\)?

**Solution.** Since \(X_1=f\), the subtracted orbit sum is \(X_n\) itself.
Thus \(Y_n=0\) for every horizon.

### Exercise 7: expose the zero-time obstruction

For the constant-one process, calculate \(Y_n\).

**Solution.** At positive \(n\), \(A_n=n\) and \(Y_n=1-n\le0\). At zero,
\(Y_0=1\gt0\). This refutes an assumption-free uniform sign theorem.

### Exercise 8: derive the first positive majorant step

Use shifted subadditivity to bound \(X_2(\omega)\).

**Solution.**

\[
X_2(\omega)
\le
X_1(T\omega)+X_1(\omega)
{} =
A_2(\omega).
\]

This is the first nontrivial induction step.

### Exercise 9: locate \(X_0=0\)

Which public declarations use the premise \(X_0=0\)?

**Solution.** Declarations 5 and 7: the uniform majorant and uniform generic
nonpositivity. No other public declaration takes that premise.

### Exercise 10: convert majorization to a sign

Which order lemma turns \(X_n\le A_n\) into \(X_n-A_n\le0\)?

**Solution.** <code>sub_nonpos.mpr</code>. The reverse direction is
<code>sub_nonpos.mp</code>.

### Exercise 11: prove residual subadditivity on paper

Starting from the process inequality and the exact addition law for \(A\),
derive the inequality for \(Y\).

**Solution.**

\[
\begin{aligned}
Y_{m+n}(\omega)
&=X_{m+n}(\omega)-A_{m+n}(\omega)\\
&\le X_n(T^m\omega)+X_m(\omega)
   -A_n(T^m\omega)-A_m(\omega)\\
&=Y_n(T^m\omega)+Y_m(\omega).
\end{aligned}
\]

The middle step uses the exact shifted-additive identity for \(A\).

### Exercise 12: identify the private-helper fields

Which fields of the candidate do the two private helpers use?

**Solution.** Neither helper takes the candidate. Each takes only a raw
shifted-subadditive inequality. Public declarations pass <code>hX.add_le</code>
or the cocycle's raw inequality into them.

### Exercise 13: explain the integrability subtraction

Which two functions are subtracted in declaration 9, and why is each
integrable?

**Solution.** \(X_n\) is integrable by <code>hX.integrable n</code>. The
finite orbit sum \(A_n\) is integrable because \(X_1\) is integrable, \(T\)
preserves \(\mu\), its iterates preserve \(\mu\), and finite sums preserve
integrability.

### Exercise 14: delete probability

Would declaration 9 remain true for a nonprobability measure?

**Solution.** Yes. Its proof uses only integrability and
<code>MeasurePreserving T μ μ</code>. Total mass one never appears.

### Exercise 15: delete ergodicity

Would an identity base map invalidate any RMT-19 theorem?

**Solution.** No. If it preserves the measure, it satisfies the analytic gate.
It need not be ergodic. All pointwise algebra works regardless.

### Exercise 16: inspect the zero measure

Does declaration 10 work with the zero measure?

**Solution.** Yes. Every real-valued measurable function relevant to the
candidate is integrable against the zero measure, and every map preserves the
zero measure. No probability premise excludes this boundary.

### Exercise 17: simplify the normalized identity at zero

What does declaration 11 say when \(n=0\)?

**Solution.** Real division by zero is totalized to zero, and
<code>birkhoffAverage</code> at zero is zero. The theorem becomes \(0=0+0\).
It does not imply \(X_0=0\).

### Exercise 18: distinguish two averages

Why is <code>birkhoffAverage ℝ T (X 1) n ω</code> not an expectation?

**Solution.** It averages finitely many values along one orbit beginning at
\(\omega\). An expectation integrates over a measure on the sample space.
No measure occurs in declaration 11.

### Exercise 19: audit the first cocycle bridge

Why can declaration 12 be proved by <code>rfl</code>?

**Solution.** <code>orbitLogPlusSum</code> was defined as the Birkhoff sum of
the one-step log-positive observable along <code>C.base</code>. The two sides
reduce to the same expression.

### Exercise 20: find the unnecessary cocycle premise

Does declaration 15 need
<code>HasIntegrableGeneratorLogPlus</code>?

**Solution.** No. The established pointwise majorant belongs directly to
\(C\). The sign proof uses only that majorant and real order algebra.

### Exercise 21: find the necessary cocycle premise

Which cocycle declaration needs \(hC\), and why?

**Solution.** Declaration 17. It packages an
<code>IsIntegrableSubadditiveProcessCandidate</code>, so every centered
horizon must be integrable. The hypothesis \(hC\) supplies one-step
log-positive integrability and its propagation.

### Exercise 22: test empty matrix dimension

Which premise would exclude the empty matrix index, and is it present?

**Solution.** <code>Nonempty ι</code> would exclude it. RMT-19 assumes only a
finite decidable index, so the empty case remains supported.

### Exercise 23: reject the Lyapunov overread

Why can \(H_n=0\) fail to distinguish uniform expansion from uniform
contraction?

**Solution.** The observable uses \(\log^+\). A contracting scalar multiplier
has log-positive value zero at every horizon, while an expanding additive
scalar cocycle has exact equality with its one-step sum. Both give zero
residual for different reasons.

### Exercise 24: reject the limit overread

Suppose declaration 18 holds for every \(n\). Which convergence statement
follows immediately?

**Solution.** None. An identity at every finite index does not prove that any
of its three sequences converges. Each asymptotic term needs a separate
theorem.

### Exercise 25: design the next layer

Why is finite phase averaging a plausible next step before Kingman's theorem?

**Solution.** Finite block arguments produce Birkhoff sums for powered maps,
while the one-step reduction uses \(T\). Phase averaging can reconcile the
different starting phases without assuming that ergodicity passes from \(T\)
to every power. The needed identities and error terms must be proved before a
limit theorem is invoked.

### Exercise 26: write the referee correction

Correct the sentence “RMT-19 centers the process to mean zero and therefore
its normalized values converge.”

**Solution.** RMT-19 subtracts the pointwise additive one-step orbit majorant.
The residual is nonpositive at positive horizons, remains
shifted-subadditive, and is integrable under one-step measure preservation.
It need not have mean zero, and no normalized convergence theorem is proved.

## Reproducibility and audit ledger

| Artifact | Role | Validation |
|---|---|---|
| <code>SubadditiveCentering.lean</code> | Eighteen public declarations and two private helpers | Direct warning-fatal Lean check |
| <code>RandomCocycles.lean</code> | Aggregator import | Root-library build and import smoke test |
| This <code>index.md</code> | Declaration-complete proof-to-prose map | Coverage, source hygiene, and Hugo warnings fatal |
| <code>rmt19-assumption-and-proof-route.svg</code> | Prose-only assumption route | UTF-8 XML parse and rendered inspection |
| <code>generate-card.sh</code> | Deterministic featured-card generator | <code>--verify</code> byte comparison and 1200x630 dimension check |

From the repository root:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/SubadditiveCentering.lean
lake build NonlinearDynamics.Random.RandomCocycles.SubadditiveCentering
cd ..
python3 scripts/check_teaching_source_hygiene.py
make site-check
~~~

The public-surface smoke test is:

~~~lean
import NonlinearDynamics

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
#check DiscreteMatrixCocycle.birkhoffSum_logPlusNormObservable_one_eq_orbitLogPlusSum
#check DiscreteMatrixCocycle.centeredLogPlusNormObservable
#check DiscreteMatrixCocycle.centeredLogPlusNormObservable_apply
#check DiscreteMatrixCocycle.centeredLogPlusNormObservable_nonpos
#check DiscreteMatrixCocycle.centeredLogPlusNormObservable_add_le
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.centeredLogPlusNormObservable_candidate
#check DiscreteMatrixCocycle.logPlusNormObservable_normalized_eq_centered_add_birkhoffAverage
~~~

The article publishes as an open working note with <code>draft: false</code> and
retains <code>pro_reviewed: false</code>. Automated checks do not replace human
mathematical, source, accessibility, and editorial review.

## The next ridge

RMT-19 has changed coordinates at finite time. Every process value is now an
additive one-step orbit budget plus a shifted-subadditive residual that is
nonpositive at positive horizons, and uniformly so under the exact time-zero
normalization. The residual remains integrable under the exact finite analytic
gate, and the cocycle layer exposes the same split without strengthening its
pointwise assumptions.

The next finite layer is now
[Average the Phases: Sliding-Block Bounds for Subadditive Cocycles in Lean]({{< relref "/development-notebook/2026/07/phase-averaged-sliding-block-bounds-for-subadditive-cocycles" >}}).
Block arguments sample \(X_b\) under the powered map \(T^b\), while the
present centering uses \(X_1\) under \(T\). RMT-20 compares every residue
phase, reindexes the resulting powered-map sums as one ordinary sliding
Birkhoff sum, and does so without assuming that ergodicity of \(T\) passes to
\(T^b\), which is false in general.

Only after that shipped finite identity and the complementary interval-packing
layer are frozen should the project design the missing measure-theoretic convergence
infrastructure. That later work must state exact almost-everywhere,
integrability, stationarity, maximal-inequality, and limit-identification
hypotheses. The present Birkhoff average notation is not permission to skip
them.

For matrix products, signed Lyapunov terminology remains farther away. The
log-positive envelope controls expansion and upper-tail integrability but
clips contraction. A signed exponent may require a signed logarithmic
observable, negative-tail control, invertibility or singular-value machinery,
and eventually exterior powers. RMT-19 does not settle those choices.

## References

The links below were checked on 2026-07-21. The pinned local Mathlib 4.32.0
checkout at commit
<code>81a5d257c8e410db227a6665ed08f64fea08e997</code> is the exact authority for
Lean declarations.

<a id="ref-rmt19-birkhoff-basic"></a>
**Mathlib contributors.**
[Birkhoff sums](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Basic.html),
Mathlib 4 documentation, with the
[pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Basic.lean#L31-L57).
This official source defines the finite orbit sum and the zero, one,
successor, and addition identities used throughout RMT-19.

<a id="ref-rmt19-birkhoff-average"></a>
**Mathlib contributors.**
[Birkhoff averages](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Average.html),
Mathlib 4 documentation, with the
[pinned definition and zero/one laws](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Average.lean#L42-L59).
This official source defines the finite average by inverse natural scaling.
RMT-19 imports the definition and does not invoke a convergence theorem.

<a id="ref-rmt19-preserving"></a>
**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation. The pinned source gives the
[definition](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/MeasurePreserving.lean#L43-L48)
and
[preservation under natural iteration](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/MeasurePreserving.lean#L193-L196).
These are the exact dynamical inputs to finite orbit-sum integrability.

<a id="ref-rmt19-integrable"></a>
**Mathlib contributors.**
[Integrable functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Function/L1Space/Integrable.html),
Mathlib 4 documentation. The pinned source records
[integrability under measure-preserving composition](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/L1Space/Integrable.lean#L381-L390)
and
[closure under finite sums](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/L1Space/Integrable.lean#L439-L449).
Declaration 9 uses this finite analytic route.

<a id="ref-rmt19-karlsson-margulis"></a>
**Anders Karlsson and Gregory A. Margulis.**
[A Multiplicative Ergodic Theorem and Nonpositively Curved Spaces](https://www.unige.ch/math/folks/karlsson/kama.pdf),
*Communications in Mathematical Physics* 208, 107-123, 1999,
[DOI 10.1007/s002200050750](https://doi.org/10.1007/s002200050750).
The proof explicitly subtracts the additive one-step orbit cocycle and records
the resulting nonpositive subadditive cocycle. RMT-19 formalizes only that
finite reduction, not the paper's multiplicative ergodic conclusion.

<a id="ref-rmt19-kingman"></a>
**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source supplies the asymptotic destination and its historical
context. RMT-19 proves only a finite reduction and does not claim to formalize
Kingman's theorem.

<a id="ref-rmt19-lalley"></a>
**Steven P. Lalley.**
[Kingman's Subadditive Ergodic Theorem](https://galton.uchicago.edu/~lalley/Courses/Graz/Kingman.pdf),
University of Chicago lecture notes, undated, accessed 2026-07-21. These notes
explain a finite blocking route and warn that ergodicity of a map need not
pass to its powers. They are a teaching source, not the primary source for
Kingman's theorem and not an upstream Lean dependency.

<a id="ref-rmt19-furstenberg-kesten"></a>
**Harry Furstenberg and Harry Kesten.**
[Products of Random Matrices](https://doi.org/10.1214/aoms/1177705909),
*The Annals of Mathematical Statistics* 31(2), 457-469, 1960. This primary
source motivates the random-matrix-product destination. No samplewise
Furstenberg-Kesten conclusion is claimed in RMT-19.

The exact upstream Lean revision audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
