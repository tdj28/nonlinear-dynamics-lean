---
title: "The Guarded Real-Liminf Bridge to Log-Positive Kingman Convergence"
slug: "guarded-real-liminf-bridge-to-log-positive-kingman-convergence"
date: 2026-07-22
summary: "A concept-first ascent from rational lower-deviation events through totalized real liminf, a two-margin null cover, centered Birkhoff transfer, and the final almost-everywhere convergence of normalized log-positive cocycle growth."
lead: "Random-matrix-theory milestone 33 (RMT-33) closes the first samplewise subadditive convergence theorem in this project. The delicate step is not an algebraic squeeze. It is proving that Mathlib's total real liminf carries its intended asymptotic meaning on almost every sample. A countable rational null cover supplies both the lower-liminf inequality and the missing eventual lower bound. Centering and the pointwise Birkhoff theorem then transfer the estimate to the original process, where the prior upper-limsup theorem completes convergence."
draft: false
pro_reviewed: false
level: "Advanced measure-theoretic dynamics, subadditive processes, filters and real liminf, ergodic theory, random matrix cocycles, and intermediate Lean theorem engineering"
reading_time: "380 to 560 minutes"
prerequisites: "Shifted-subadditive processes, orbit-majorant centering, Birkhoff averages, finite bad-block estimates, rational lower-deviation events, elementary filter language, and deterministic Fekete limits"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman"
toc: true
og_image: "guarded-real-liminf-bridge-to-log-positive-kingman-convergence-card.png"
og_image_alt: "Warm-paper Deep Dive card comparing a guarded bounded alternation, an approach-to-zero sequence with no recurring rational slack, and an unguarded quadratic escape whose totalized real liminf is zero; a lower-liminf and upper-limsup rail then force convergence to the log-positive rate."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This AI-assisted working draft is published as an open
working note while human publication review and the configured external Pro
review remain pending. The checked Lean source is authoritative. The endpoint
proved here concerns the normalized real-valued log-positive envelope
\(\log^+\lVert C_n\rVert\). It is not a theorem about the signed logarithm, a
negative Lyapunov exponent, convergence in \(L^1\), or an Oseledets splitting.
{{< /panel >}}

## Start with three sequences you can calculate by hand

Before filters, null sets, or cocycles enter, write down three exact rational
sequences. They isolate three logically different questions that are easy to
blur together.

### The guarded sequence: the rational event and liminf agree

Define

\[
u_0=0,\qquad
u_n=
\begin{cases}
-\frac32,&n\text{ odd},\\[2mm]
-\frac12,&n\text{ positive and even}.
\end{cases}
\]

Take the event target \(c=-1\) and the rational witness
\(q=-5/4\). The first eleven values are

| \(n\) | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| \(u_n\) | \(0\) | \(-3/2\) | \(-1/2\) | \(-3/2\) | \(-1/2\) | \(-3/2\) | \(-1/2\) | \(-3/2\) | \(-1/2\) | \(-3/2\) | \(-1/2\) |
| \(u_n\lt q\)? | no | yes | no | yes | no | yes | no | yes | no | yes | no |

Every odd time is a witness beyond any proposed cutoff, so
\(u_n\lt q\) occurs frequently. At the same time,

\[
-\frac32\le u_n\le0
\]

for every \(n\). The eventual-lower-bound guard is therefore present, and
the ordinary answer is honest:

\[
\liminf_nu_n=-\frac32\lt-\!1=c.
\]

At the strict boundary \(c=-3/2\), however, there is no rational
\(q\lt c\) crossed frequently: the sequence never goes below \(-3/2\).
Equality with the liminf does not enter a **strict** lower-deviation event.

### The strictness near-miss: crossing the target is not enough

Now take

\[
a_0=0,\qquad a_n=-\frac1n\quad(n\gt0).
\]

Every positive term satisfies \(a_n\lt0\), but for the sample margin
\(q=-1/4\), the strict inequality \(a_n\lt q\) holds only at
\(n=1,2,3\); equality at \(n=4\) does not count. The same phenomenon holds
for every fixed rational \(q\lt0\): eventually \(q\lt a_n\lt0\). Thus

\[
\liminf_na_n=0,
\qquad
a_n\lt0\text{ frequently},
\qquad
\nexists q\in\mathbb Q,\ q\lt0\text{ and }a_n\lt q\text{ frequently}.
\]

This is why the event stores a *durable rational margin below the target*,
not just arbitrarily late strict crossings of the target itself.

### The guard near-miss: a real totalization can hide escape to \(-\infty\)

The project source uses the genuine subadditive process
\(X_n=-n^2\) on the one-point probability space. After subtracting its
one-step orbit sum and normalizing, its exact values are

\[
e_0=0,\qquad e_n=1-n\quad(n\gt0):
\qquad 0,0,-1,-2,-3,-4,\ldots
\]

At target \(c=-1\), choose \(q=-2\). Then \(q\lt c\) and
\(e_n\lt q\) for every \(n\ge4\), so the rational lower-deviation event really
occurs. But no real number lies below all sufficiently late values. For
example, the candidate bound \(-10\) survives through \(n=11\), where
\(e_{11}=-10\), and fails at \(n=12\), where \(e_{12}=-11\). Every other
finite candidate fails in the same way.

The defining set of eventual real lower bounds is empty. In the pinned
real-order implementation, its supremum is totalized:

\[
\operatorname{liminf}_{\mathbb R}e
=\sup\varnothing
=0.
\]

Consequently the unguarded implication

\[
\bigl(\exists q\lt c,\ e_n\lt q\text{ frequently}\bigr)
\Longrightarrow
\operatorname{liminf}_{\mathbb R}e\lt c
\]

would demand the false statement \(0\lt-1\). This is not a hypothetical
arbitrary-sequence objection: the paired Lean module checks the subadditive
candidate, event membership, absence of the guard, and totalized value.

{{< reference-figure
  src="guarded-sequence-trichotomy-ledger.svg"
  alt="Three exact sequence panels. The bounded alternating sequence has a lower bound and repeatedly crosses negative five quarters, so its honest liminf is negative three halves. Negative one over n crosses zero but stops crossing each fixed negative rational margin. The quadratic centered normalization decreases without a lower bound, crosses negative two forever, but the project-proved total real liminf is zero, making the unguarded conclusion false."
  caption="**Read the three panels separately.** Panel A validates the guarded bridge. Panel B tests strict rational slack. Panel C proves why total real liminf cannot be interpreted as an extended-real liminf without an eventual lower-bound witness."
>}}

### A finite squeeze that says exactly what the final theorem says

For a second hand-check, set

\[
\gamma_+=\frac32,\qquad
L_k=\gamma_+-\frac1k,\qquad
U_k=\gamma_++\frac1k,
\]

and let \(s_k\) alternate between the upper and lower rails. Then

\[
L_k\le s_k\le U_k,
\qquad
U_k-L_k=\frac2k\longrightarrow0,
\]

so \(s_k\to\gamma_+\). This is a finite-arithmetic picture of the final
proof architecture, with one essential provenance label on each rail:

- **this module supplies the lower rail**
  \(\gamma_+\le\liminf a_n(\omega)\);
- **the earlier RMT-29 module supplies the upper rail**
  \(\limsup a_n(\omega)\le\gamma_+\); and
- actual lower and upper boundedness let Mathlib turn those two inequalities
  into convergence.

The conclusion concerns

\[
a_n(\omega)
=\frac{\log^+\lVert C_n(\omega)\rVert}{n}\ge0.
\]

It does not manufacture a signed logarithm. The nearby zero-rate sequence
\(1/k\to0\) is a faithful endpoint: \(\gamma_+\) can be zero, while a
constant contraction can simultaneously have a negative **signed** rate
that the log-positive observable erases.

The actual paired-source zero probe is even simpler: its normalized process
is identically zero, its real liminf is zero, and its strict lower-liminf
deviation set at target zero is empty. The \(1/k\) row is only a visual model
of approaching the same permitted endpoint; it is not being attributed to
that source probe.

{{< reference-figure
  src="log-positive-squeeze-numeric-ledger.svg"
  alt="Exact table and graph for gamma positive equal to three halves. Lower and upper rational rails trap alternating samples and close with width two over k. A proof-flow strip labels the current lower-liminf theorem, prior RMT-29 upper-limsup theorem, two-sided boundedness, and convergence. A boundary strip shows one over k converging to zero and distinguishes negative signed contraction."
  caption="**Finding:** the endpoint is a two-source squeeze for a nonnegative observable. RMT-33 proves the lower rail and imports the prior upper rail; neither rail turns log-positive growth into a signed Lyapunov theorem."
>}}

The last step of a long proof is often described as a squeeze:

\[
\gamma
\le \liminf_{n\to\infty} a_n(\omega)
\le \limsup_{n\to\infty} a_n(\omega)
\le \gamma.
\]

That line is correct for the endpoint of RMT-33, but it hides the hardest
formal question. What does the middle real
{{< refterm "limit-inferior" "limit inferior (liminf)" >}} mean when the
codomain is only conditionally complete? Mathlib gives it a value for every
real sequence, even one that escapes to negative infinity. In such a case the
set of eventual real lower bounds is empty, and its real supremum is
totalized to zero. A naked inequality involving that value can therefore say
something very different from the intended extended asymptotic statement.

RMT-33 solves the problem constructively. It does not merely show that the
bad lower-liminf set is null. Off a related countable rational null set, it
extracts one fixed rational number below all sufficiently late normalized
centered values. That witness certifies that the real lower limit is being
used in its honest bounded-below regime.

The proof then adds back a convergent one-step Birkhoff average, identifies
the centered offset with the integrated Fekete rate, and combines the lower
estimate with the upper-limsup theorem from RMT-29. The result is the
project's first almost-everywhere Kingman-style convergence theorem:

\[
\frac{\log^+\lVert C_n(\omega)\rVert}{n}
\longrightarrow \gamma_+
\qquad\text{for almost every }\omega.
\]

The subscript \(+\) is essential. The limit sees expansion above norm one and
forgets contraction below norm one.

This chapter continues
[Rational-Slack Lower-Deviation Events and Ergodic Null Selection]({{< relref "/knowledge-base/deep-dives/rational-slack-lower-deviation-events-and-ergodic-null-selection" >}})
and
[Subadditive Upper-Limsup Bounds Before Kingman Convergence]({{< relref "/knowledge-base/deep-dives/subadditive-upper-limsup-bounds-before-kingman-convergence" >}}).
The deterministic rate was constructed in
[Integrated Log-Positive Cocycle Growth and the Fekete Limit]({{< relref "/knowledge-base/deep-dives/integrated-log-positive-cocycle-growth-and-fekete-limit" >}}).

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| Overview | [See the whole summit route](#see-the-whole-summit-route) | Understand why the proof has five bridges |
| Semantics | [Why real liminf needs a guard](#why-real-liminf-needs-a-guard) | Distinguish a total value from an extended lower limit |
| Events | [Translate arbitrarily late blocks into frequency](#translate-arbitrarily-late-blocks-into-frequency) | Read the exact event-to-filter bridge |
| Slack | [Spend two rational margins](#spend-two-rational-margins) | Build a countable cover without asking for \(\delta\lt\delta\) |
| Nullity | [Make one null cover do two jobs](#make-one-null-cover-do-two-jobs) | Obtain both an inequality and eventual boundedness |
| Transfer | [Add back the Birkhoff average](#add-back-the-birkhoff-average) | Move the centered lower estimate to the original process |
| Endpoint | [Close the log-positive squeeze](#close-the-log-positive-squeeze) | Read the final almost-everywhere convergence theorem |
| Scope | [Separate log-positive growth from signed growth](#separate-log-positive-growth-from-signed-growth) | Avoid a false Lyapunov interpretation |
| Lean | [Audit every checked interface](#audit-every-checked-interface) | Match mathematical jobs to declarations and hypotheses |
| History | [Place the result beside the classical theorems](#place-the-result-beside-the-classical-theorems) | Cite Kingman, Steele, Ruelle, and Fekete cautiously |
| Practice | [Forty solved exercises](#forty-solved-exercises) | Reconstruct the proof and test its boundaries |

## Common setup and notation

Let \((\Omega,\mu)\) be a probability space and let
\(T:\Omega\to\Omega\) preserve \(\mu\). A real process
\(X=(X_n)_{n\in\mathbb N}\) is shifted-subadditive in the convention used by
the repository when

\[
X_{m+n}(\omega)
\le X_n(T^m\omega)+X_m(\omega)
\]

for all natural \(m,n\) and all \(\omega\). Every slice \(X_n\) is assumed
integrable.

The one-step orbit sum is

\[
S_nX_1(\omega)
:=\sum_{j=0}^{n-1}X_1(T^j\omega).
\]

The centered process is

\[
Y_n(\omega):=X_n(\omega)-S_nX_1(\omega).
\]

Centering is pointwise and dynamical. It subtracts an orbit sum, not an
expectation. At every positive horizon, the one-step majorant inherited from
subadditivity gives

\[
X_n(\omega)\le S_nX_1(\omega),
\qquad
Y_n(\omega)\le 0.
\]

After total normalization, \(u_0=0\), so \(u_n\le0\) holds at every natural
time even when the unnormalized generic value \(Y_0\) is not assumed
nonpositive.

Lean packages total normalization as

\[
\operatorname{Norm}(X,n,\omega):=\frac{X_n(\omega)}{n}.
\]

At \(n=0\), real division is total and returns zero. Thus the normalized
process is defined at every natural time even when \(X_0\) is arbitrary. For
positive time this is ordinary division, and removing the zero term does not
change either lower or upper asymptotics along natural infinity.

Write

\[
u_n(\omega):=\frac{Y_n(\omega)}{n},
\qquad
v_n(\omega):=\frac{S_nX_1(\omega)}{n}.
\]

With the total convention at time zero, the exact identity is

\[
\frac{X_n(\omega)}{n}=u_n(\omega)+v_n(\omega)
\]

for every \(n\in\mathbb N\), including zero.

For the matrix-cocycle specialization, let \(C_n(\omega)\) be the ordered
finite product and set

\[
X_n(\omega):=\log^+\lVert C_n(\omega)\rVert,
\qquad
\log^+r:=\max\{0,\log r\}.
\]

The deterministic integrated sequence is

\[
A_n:=\int_\Omega X_n\,d\mu,
\]

and its Fekete rate is

\[
\gamma_+
:=\lim_{n\to\infty}\frac{A_n}{n}
=\inf_{n\ge1}\frac{A_n}{n}.
\]

The equality with the positive-horizon infimum is already checked in the
repository. RMT-33 proves that the samplewise normalized process converges to
that same real number almost everywhere.

## See the whole summit route

The proof has five bridges. Each one changes the language of the statement.

1. A bad block becomes a frequent inequality along the filter at natural
   infinity.
2. A strict real lower-liminf deviation enters a countable union of rational
   bad events.
3. Nullity of that union supplies both a lower-liminf inequality and an
   eventual lower bound.
4. The centered estimate is added to a convergent Birkhoff average.
5. A prior upper-limsup estimate and explicit boundedness close the
   convergence squeeze.

{{< reference-figure
  src="proof-roadmap.svg"
  alt="Five-stage proof route from arbitrarily late centered bad blocks through frequent inequalities, a two-rational-margin null cover, an eventual-lower-bound certificate, centered Birkhoff transfer, and the final log-positive convergence squeeze."
  caption="**Finding:** the lower-liminf inequality cannot move directly from event nullity to convergence. The same countable null cover must first certify eventual lower boundedness, after which conditional-completeness lemmas, Birkhoff transfer, and the upper-limsup theorem become valid. The route is a dependency diagram, not a claim that the five stages have equal difficulty."
>}}

The central design choice is visible at stage three. A theorem that returned
only

\[
\delta\le\liminf_n u_n(\omega)
\]

would be numerically useful but semantically incomplete. RMT-33 returns the
conjunction

\[
\left(
u_n(\omega)\text{ is eventually bounded below}
\right)
\quad\text{and}\quad
\left(
\delta\le\liminf_n u_n(\omega)
\right).
\]

That stronger interface prevents later proofs from silently treating a
totalized real lower limit as an extended-real one.

## Why real liminf needs a guard

### Mathlib's real lower limit

For a real sequence \(a:\mathbb N\to\mathbb R\), the pinned Mathlib definition
can be read as

\[
\liminf a
{} =
\sup\left\{
b\in\mathbb R:
b\le a_n\text{ eventually}
\right\}.
\]

The word *eventually* means that there is some cutoff after which the
inequality always holds. The set inside the supremum is the set of eventual
real lower bounds.

The real numbers are conditionally complete, not complete as an order. If the
sequence has no eventual lower bound, that set is empty. Mathlib nevertheless
keeps <code>liminf</code> total. In the pinned release,
<code>Real.sSup_empty</code> states

\[
\sup\varnothing=0.
\]

Consequently, the formal real lower limit of an unbounded-below sequence can
be zero.

### A checked countermodel

The module uses the process

\[
X_n=-n^2
\]

on the one-point probability space. It is subadditive because

\[
-(m+n)^2\le -m^2-n^2.
\]

Its centered process is

\[
Y_n=-n^2+n,
\]

so for positive \(n\),

\[
u_n=\frac{-n^2+n}{n}=1-n.
\]

This sequence crosses every fixed negative slope eventually and has no
eventual real lower bound. The intended extended lower limit is negative
infinity. Yet the set of eventual real lower bounds is empty, so Mathlib's
total real <code>liminf</code> is zero.

{{< reference-figure
  src="totalized-real-liminf-guard.svg"
  alt="Two sequences feed the real liminf definition. A bounded-below sequence has a nonempty set of eventual lower bounds and an informative supremum. The sequence one minus n has no eventual real lower bound, so the set is empty and real supremum totalizes to zero. An explicit lower-bound guard separates the honest branch from the totalized branch."
  caption="**Finding:** a real-valued <code>liminf</code> is always syntactically available, but it represents the usual finite lower asymptotic value only after eventual lower boundedness is established. For \(1-n\), the formal value zero is a totalization artifact, not its extended lower limit. The diagram compares logical branches and does not plot quantitative data."
>}}

The countermodel proves that the guard is necessary, not merely convenient.
Without it, membership in a rational strict lower-deviation event need not
force the total real lower limit below the event target.

### Read the guard in filter language

The Lean proposition

<code>IsBoundedUnder (· ≥ ·) atTop a</code>

means that \(a_n\) is eventually bounded below. Explicitly, there exists
\(b\in\mathbb R\) such that

\[
b\le a_n
\]

for every sufficiently large \(n\).

The orientation can feel reversed because the relation is written
\((\cdot\ge\cdot)\). The reliable reading is to expand the definition and ask
which side of \(a_n\) receives the witness. In this case the witness lies
below the eventual values.

The companion proposition

<code>IsBoundedUnder (· ≤ ·) atTop a</code>

means eventual upper boundedness.

### Time zero is not the problem

At time zero,

\[
\frac{X_0(\omega)}{0}=0
\]

under Lean's total division. This convention does not contaminate asymptotic
limits. The theorem <code>liminf_nat_add</code> removes a finite natural
prefix, and RMT-33 exposes the specialized equality

\[
\liminf_n\operatorname{Norm}(X,n+1,\omega)
{} =
\liminf_n\operatorname{Norm}(X,n,\omega).
\]

The theorem <code>normalizedProcess_update_zero</code> goes farther:
replacing the entire time-zero slice by any function leaves every normalized
value unchanged. The genuine semantic hazard is unbounded escape at late
times, not division at the first index.

## Translate arbitrarily late blocks into frequency

RMT-32 defined an arbitrarily-late centered bad-block event at slope \(q\):

\[
A_q
:=
\left\{
\omega:
\forall N,\ \exists n\ge N,\ n\gt0,\ Y_n(\omega)\lt qn
\right\}.
\]

On natural time, a property \(P(n)\) holds frequently along
<code>atTop</code> exactly when

\[
\forall N,\ \exists n\ge N,\ P(n).
\]

Positive witnesses make division legitimate, so RMT-33 proves the exact
translation

\[
\omega\in A_q
\quad\Longleftrightarrow\quad
\exists^\infty_{\mathrm{atTop}} n,\ u_n(\omega)\lt q.
\]

The symbol on the right means *frequently along natural infinity*. It does
not mean eventually always.

The rationally generated strict event at a real target \(c\) is

\[
D_c
:=
\bigcup_{\substack{q\in\mathbb Q\\q\lt c}}A_q.
\]

Its membership theorem becomes

\[
\omega\in D_c
\quad\Longleftrightarrow\quad
\exists q\in\mathbb Q,\quad
q\lt c
\quad\text{and}\quad
\exists^\infty_{\mathrm{atTop}}n,\ u_n(\omega)\lt q.
\]

This says that one durable rational margin below \(c\) is crossed
arbitrarily late.

### The guarded equivalence

Suppose \(u(\omega)\) is eventually bounded below. If \(\omega\in D_c\), then
some rational \(q\lt c\) is crossed frequently. The Mathlib theorem
<code>liminf_le_of_frequently_le</code> yields

\[
\liminf_n u_n(\omega)\le q\lt c.
\]

Conversely, suppose

\[
\liminf_nu_n(\omega)\lt c.
\]

Choose a rational \(q\) strictly between the lower limit and \(c\). Since the
normalized centered sequence is pointwise nonpositive, it has the coboundedness gate
needed by <code>frequently_lt_of_liminf_lt</code>. That theorem gives
frequent crossings below \(q\), hence membership in \(D_c\).

Therefore, under the explicit eventual-lower-bound guard,

\[
\omega\in D_c
\quad\Longleftrightarrow\quad
\liminf_nu_n(\omega)\lt c.
\]

The two directions use different order hypotheses:

| Direction | Needed fact | Reason |
|---|---|---|
| Frequent crossings imply low liminf | Eventual lower bound | Prevents empty eventual-lower-bound set |
| Low liminf implies frequent crossings | A suitable coboundedness condition | Allows values below every level above the liminf |

For the centered candidate, pointwise nonpositivity supplies the second gate.
The first gate must be constructed almost everywhere.

## Why one rational margin is not enough

Consider

\[
a_n=-\frac{1}{n}.
\]

It converges to zero and is strictly negative at every positive time. Thus

\[
\exists^\infty_{\mathrm{atTop}}n,\ a_n\lt0.
\]

However, for every fixed rational \(q\lt0\), the sequence is eventually above
\(q\). Hence

\[
\neg\left(
\exists^\infty_{\mathrm{atTop}}n,\ a_n\lt q
\right).
\]

Strict crossings at the target do not provide a durable strict gap below the
target. This is why the event is generated by rational slopes below \(c\),
not by the slope \(c\) itself.

The checked module includes this example. It simultaneously proves:

\[
\liminf a_n=0,
\qquad
a_n\lt0\text{ frequently},
\qquad
\text{no fixed rational }q\lt0\text{ is crossed frequently}.
\]

That triple is the smallest counterexample to the tempting same-threshold
shortcut.

## Spend two rational margins

Let

\[
L(\omega):=\liminf_nu_n(\omega)
\]

and fix a desired lower bound \(\delta\). We want to cover the exceptional
set

\[
E_\delta:=\{\omega:L(\omega)\lt\delta\}
\]

by RMT-32 events known to be null.

RMT-32 proves nullity of \(D_c\) when its event target \(c\) is strictly below
a deterministic lower bound \(\delta\) for all positive normalized centered
integrals. It cannot be invoked with \(c=\delta\), because that would require
the false hypothesis \(\delta\lt\delta\).

The repair uses two rational margins.

1. If \(L(\omega)\lt\delta\), choose an **outer target**
   \(c\in\mathbb Q\) with

   \[
   L(\omega)\lt c\lt\delta.
   \]

2. To prove \(\omega\in D_c\), choose an **inner witness slope**
   \(q\in\mathbb Q\) with

   \[
   L(\omega)\lt q\lt c.
   \]

The outer target makes RMT-32 applicable because \(c\lt\delta\). The inner
slope supplies the durable strict margin required by membership in \(D_c\).
The two numbers have different logical jobs and cannot safely be identified.

{{< reference-figure
  src="two-rational-margins.svg"
  alt="A horizontal order line places the lower limit to the left of an inner rational witness q, then an outer rational event target c, then the deterministic target delta. The inner gap proves frequent crossing membership, while the outer gap licenses the prior null-event theorem."
  caption="**Finding:** two density choices repair two separate strict inequalities. The inner rational \(q\) witnesses membership in \(D_c\); the outer rational \(c\) keeps the event target strictly below \(\delta\), where RMT-32 proves nullity. Positions show order only and are not intended as metric distances."
>}}

The outer exhaustion is the countable set

\[
R_\delta
:=
\bigcup_{\substack{c\in\mathbb Q\\c\lt\delta}}D_c.
\]

The two-margin argument proves

\[
E_\delta\subseteq R_\delta.
\]

Since the rational numbers are countable, RMT-32 nullity of every \(D_c\)
implies \(\mu(R_\delta)=0\), and monotonicity gives
\(\mu(E_\delta)=0\).

## Make one null cover do two jobs

The exhaustion \(R_\delta\) supports two distinct conclusions.

### Deliverable one: the lower-liminf inequality

Because \(E_\delta\subseteq R_\delta\) and \(R_\delta\) is null,

\[
\delta\le L(\omega)
\]

for almost every \(\omega\).

This is the numerical conclusion needed for the final squeeze.

### Deliverable two: an actual eventual lower bound

Take \(\omega\notin R_\delta\). Choose rationals

\[
q\lt c\lt\delta.
\]

Since \(\omega\notin D_c\), it cannot cross \(q\) frequently. The negation of
frequency along <code>atTop</code> is eventual negation, so

\[
q\le u_n(\omega)
\]

for all sufficiently large \(n\). Thus \(q\) is a concrete eventual lower
bound.

Notice that this construction does not infer boundedness from the numerical
real-liminf inequality. It builds boundedness directly from the complement of
the rational event. That direction is robust against totalization.

{{< reference-figure
  src="null-cover-two-deliverables.svg"
  alt="The complement of one countable rational null cover splits into two outputs. Excluding the lower-liminf exceptional set gives delta below the real liminf, while excluding one rational event turns not-frequently-below q into eventually-at-least q. Both outputs reunite as the guarded almost-everywhere theorem."
  caption="**Finding:** nullity is used twice. Set inclusion removes strict lower-liminf deviation, while direct negation of a frequent rational crossing constructs an eventual lower bound. The final theorem deliberately returns both facts so later real-liminf algebra cannot forget the guard."
>}}

The generic centered endpoint is therefore

\[
\text{for almost every }\omega,\qquad
\begin{cases}
u(\omega)\text{ is eventually bounded below},\\
\delta\le\liminf_nu_n(\omega).
\end{cases}
\]

This is the semantically honest lower half of the theorem.

### Where the hypotheses enter

Suppose that for every positive \(n\),

\[
\delta
\le
\frac{1}{n}\int_\Omega Y_n\,d\mu.
\]

Then each outer event \(D_c\) with \(c\lt\delta\) is null by RMT-32. That
earlier theorem uses integrability, shifted subadditivity, a
measure-preserving ergodic probability base, and the strict separation
\(c\lt\delta\). RMT-33 adds no independence assumption.

## Add back the Birkhoff average

The exact normalized decomposition is

\[
\frac{X_n(\omega)}{n}=u_n(\omega)+v_n(\omega),
\]

where

\[
v_n(\omega)
{} =
\frac{1}{n}\sum_{j=0}^{n-1}X_1(T^j\omega).
\]

On an ergodic probability base, the project's pointwise Birkhoff theorem gives

\[
v_n(\omega)
\longrightarrow
\int_\Omega X_1\,d\mu
\]

for almost every \(\omega\).

For such a sample:

- \(u_n\) is eventually bounded below by the null-cover construction;
- \(u_n\le0\) pointwise by centering;
- \(v_n\) is eventually bounded below and above because it converges;
- convergence also gives the coboundedness condition required by the
  liminf-of-sum theorem.

The pinned Mathlib theorem <code>le_liminf_add</code> then yields

\[
\liminf_nu_n+\liminf_nv_n
\le
\liminf_n(u_n+v_n).
\]

Since \(v_n\) converges,

\[
\liminf_nv_n=\int_\Omega X_1\,d\mu.
\]

Combining this equality with the centered lower estimate gives

\[
\delta+\int_\Omega X_1\,d\mu
\le
\liminf_n\frac{X_n(\omega)}{n}.
\]

{{< reference-figure
  src="birkhoff-liminf-transfer-gates.svg"
  alt="The centered normalized sequence enters a liminf-of-sum gate with an eventual lower bound and the pointwise upper bound zero. The Birkhoff sequence enters with convergence, which supplies lower, upper, and coboundedness gates. Their exact sum is the original normalized process, producing the transferred lower estimate."
  caption="**Finding:** <code>le_liminf_add</code> is not a bare algebraic inequality over arbitrary real sequences. RMT-33 supplies all four order-side conditions explicitly: two-sided boundedness for the centered and Birkhoff components in the orientations required by the pinned theorem, plus the exact centered-additive identity."
>}}

This step explains why the proof centered by the one-step orbit sum rather
than by a constant expectation. The orbit sum produces both pointwise
nonpositivity of \(Y_n\) and an exact additive component governed by Birkhoff.

## Specialize the centered offset to the Fekete rate

For the log-positive cocycle process, set

\[
I_1:=\int_\Omega X_1\,d\mu.
\]

The deterministic rate \(\gamma_+\) lies below every positive-horizon
normalized integral:

\[
\gamma_+\le\frac{1}{n}\int_\Omega X_n\,d\mu.
\]

The centered integral satisfies

\[
\int_\Omega Y_n\,d\mu
{} =
\int_\Omega X_n\,d\mu-nI_1.
\]

Therefore

\[
\gamma_+-I_1
\le
\frac{1}{n}\int_\Omega Y_n\,d\mu
\]

for every positive \(n\). Choose

\[
\delta:=\gamma_+-I_1.
\]

The generic transfer theorem gives

\[
(\gamma_+-I_1)+I_1
\le
\liminf_n\frac{X_n(\omega)}{n}.
\]

After cancellation,

\[
\gamma_+
\le
\liminf_n\frac{X_n(\omega)}{n}
\]

almost everywhere.

This cancellation is why the centered Fekete offset appears throughout
RMT-30 to RMT-33. It is not an additional rate. It is exactly the original
rate expressed in centered coordinates.

## Close the log-positive squeeze

RMT-29 already proved

\[
\limsup_n\frac{X_n(\omega)}{n}
\le\gamma_+
\]

almost everywhere. Intersect its full-measure set with the RMT-33 lower set
and the full-measure set on which the one-step Birkhoff average converges.

The pointwise normalized log-positive process is nonnegative:

\[
0\le\frac{X_n(\omega)}{n}.
\]

This supplies an eventual lower bound. The one-step orbit majorant gives, for
positive \(n\),

\[
\frac{X_n(\omega)}{n}
\le
\frac{1}{n}\sum_{j=0}^{n-1}X_1(T^j\omega).
\]

The right side converges, so it is eventually bounded above. Hence the
normalized process is eventually bounded above as well.

Now the pinned theorem
<code>tendsto_of_le_liminf_of_limsup_le</code> applies:

\[
\gamma_+
\le\liminf_n\frac{X_n(\omega)}{n},
\qquad
\limsup_n\frac{X_n(\omega)}{n}\le\gamma_+,
\]

together with explicit eventual upper and lower bounds, imply

\[
\frac{X_n(\omega)}{n}\longrightarrow\gamma_+.
\]

{{< reference-figure
  src="final-liminf-limsup-squeeze.svg"
  alt="A lower rail places the integrated log-positive growth rate below the samplewise liminf. An upper rail places the samplewise limsup below the same rate. Explicit lower boundedness comes from nonnegativity and upper boundedness comes from the convergent one-step Birkhoff majorant. The two rails close at one limit."
  caption="**Finding:** the final squeeze has four inputs, not two. The lower-liminf and upper-limsup inequalities identify the candidate limit, while eventual lower and upper bounds license the real conditional-completeness convergence theorem. Every input is proved on the same almost-everywhere sample."
>}}

The checked endpoint is:

\[
\text{for almost every }\omega,\qquad
\frac{\log^+\lVert C_n(\omega)\rVert}{n}
\longrightarrow
\gamma_+.
\]

No independent or identically distributed hypothesis appears. Dependence is
organized by a deterministic measure-preserving base transformation and the
cocycle law.

## Separate log-positive growth from signed growth

The positive logarithm is

\[
\log^+r=\max\{0,\log r\}.
\]

It has three behaviors that matter here:

\[
\log^+r=
\begin{cases}
0,&0\le r\le1,\\
\log r,&r\gt1.
\end{cases}
\]

In Mathlib, \(\log^+0=0\). Thus the observable records expansion above one
and erases contraction and singular collapse.

By contrast, a signed logarithmic growth theorem studies

\[
\frac{1}{n}\log\lVert C_n(\omega)\rVert,
\]

usually in an extended-real setting because the norm can vanish. Ruelle's
1979 matrix-product corollary permits a limit in
\(\mathbb R\cup\{-\infty\}\). RMT-33 does not.

### Constant contraction test

Let

\[
C_n=a^nI,
\qquad
0\lt a\lt1.
\]

Then the signed normalized growth is

\[
\frac{1}{n}\log\lVert C_n\rVert=\log a\lt0.
\]

But

\[
\frac{1}{n}\log^+\lVert C_n\rVert=0
\]

at every positive time. RMT-33 returns \(\gamma_+=0\), not \(\log a\).

### Zero-product test

If a finite product is the zero matrix, its signed logarithm naturally points
to negative infinity. The log-positive observable is instead zero. It carries
no record of the collapse.

{{< reference-figure
  src="log-positive-versus-signed-growth.svg"
  alt="Three matrix-product regimes compare signed log norm with log-positive norm. Expansion is retained by both. Constant contraction has a negative signed rate but zero log-positive rate. A zero product points to negative infinity in extended signed growth but remains zero under log-positive totalization."
  caption="**Finding:** RMT-33 controls an expansion envelope. It agrees with signed growth only in regimes where the norm eventually exceeds one in the relevant way. Constant contraction and zero products prove that the theorem cannot be relabeled as a signed Lyapunov exponent result."
>}}

The phrase *log-positive Kingman endpoint* is therefore a scope label. It says
that the proof architecture is subadditive and Kingman-style while the
observable is the nonnegative envelope chosen by this project.

## Seven bridges from the sequence ledger to Lean

Each bridge below has four layers: the sentence a mathematician says, the
paper formula, the exact checked Lean interface, and a token map. Read them in
order once; afterward the declaration names become a compact proof roadmap.
The literal guarded repository command appears after bridge seven.

### Bridge 1: normalize at every natural time

{{< lean-bridge
  human="Divide the process value at time n by n. At time zero, real division is totalized, so the normalized value is exactly zero."
  math="\(N_X(n,\omega)=X_n(\omega)/n,\qquad N_X(0,\omega)=0.\)"
  lean="normalizedProcess X n ω"
>}}

- <code>normalizedProcess</code> is the project definition being applied.
- <code>X</code> is the whole time-indexed real process, not one slice.
- <code>n</code> is a natural horizon whose cast is the real denominator.
- <code>ω</code> is the sample point.
- <code>normalizedProcess_zero</code> checks the zero-time statement, while
  <code>normalizedProcess_update_zero</code> proves that changing
  <code>X 0</code> changes no normalized value.
{{< /lean-bridge >}}

### Bridge 2: expose the durable rational witness

{{< lean-bridge
  human="Membership in the strict lower-deviation event means that one rational q below c is crossed arbitrarily late."
  math="\(\omega\in D_c\Longleftrightarrow\exists q\in\mathbb Q,\ q<c\ \land\ (\exists^\infty n,\ u_n(\omega)<q).\)"
  lean="mem_centeredStrictLowerDeviationSet_iff_exists_frequently_normalized_lt"
>}}

- <code>centeredStrictLowerDeviationSet T X c</code> is \(D_c\).
- <code>∃ q : ℚ</code> keeps the generator countable.
- <code>(q : ℝ) < c</code> is the strict rational slack.
- <code>∃ᶠ n in atTop</code> means “beyond every cutoff there is another
  witness,” not “all sufficiently large times are witnesses.”
- <code>normalizedCenteredProcess T X n ω < (q : ℝ)</code> is the checked
  crossing.
{{< /lean-bridge >}}

### Bridge 3: pass from the event to liminf only through the guard

{{< lean-bridge
  human="If the centered normalized sequence is eventually bounded below, a frequently crossed rational q below c forces its real liminf below c."
  math="\(\bigl[\exists b,\ b\le u_n\text{ eventually}\bigr]\land\omega\in D_c\Longrightarrow\liminf_nu_n<c.\)"
  lean="liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet hlower hω"
>}}

- <code>hlower</code> has exact type
  <code>IsBoundedUnder (· ≥ ·) atTop (fun n ↦ ...)</code>.
- The relation <code>(· ≥ ·)</code> means that a fixed witness lies **below**
  the late sequence values.
- <code>hω</code> supplies the rational \(q\) and its frequent crossings.
- <code>liminf_le_of_frequently_le</code> consumes
  <code>hlower</code>; the theorem is deliberately not callable without it.
- The quadratic-escape ledger shows the false statement that would result if
  this first argument were erased.
{{< /lean-bridge >}}

### Bridge 4: spend an outer rational target as well as an inner witness

{{< lean-bridge
  human="Every strict liminf deviation below delta lies in one rational event whose target c is itself strictly below delta."
  math="\(E_\delta=\{\liminf u\lt\delta\}\subseteq\bigcup_{c\in\mathbb Q,\ c\lt\delta}D_c.\)"
  lean="hX.centeredLowerLiminfDeviationSet_subset_rationalExhaustion δ"
>}}

- <code>hX</code> is the integrable shifted-subadditive candidate; its
  centered normalization is nonpositive.
- <code>δ</code> is the deterministic centered Fekete offset.
- <code>exists_rat_btwn</code> first chooses an outer \(c\) between the low
  liminf and \(\delta\).
- The event membership theorem chooses or exposes an inner \(q\lt c\).
- Two strict margins avoid the impossible request
  \(\delta\lt\delta\), while the rational index keeps the union countable.
{{< /lean-bridge >}}

### Bridge 5: make the null cover return two deliverables

{{< lean-bridge
  human="Almost every sample receives both an eventual real lower bound and the centered lower-liminf inequality."
  math="\(\text{a.e. }\omega,\quad [\exists b,\ b\le u_n(\omega)\text{ eventually}]\ \land\ \delta\le\liminf_nu_n(\omega).\)"
  lean="hX.ae_isBoundedUnder_ge_and_le_liminf_normalizedCenteredProcess hT δ hδ"
>}}

- <code>hT : Ergodic T μ</code> drives the prior event-nullity result.
- <code>hδ</code> says \(\delta\) lies below every positive normalized
  centered integral.
- The first component of the returned conjunction is the semantic guard.
- The second component is the numerical lower rail.
- The private helper constructs the first component from nonmembership in the
  rational exhaustion; the public theorem exposes it instead of hiding it.
{{< /lean-bridge >}}

### Bridge 6: add back the convergent Birkhoff average

{{< lean-bridge
  human="The centered lower rail plus the one-step space average lies below the liminf of the original normalized process."
  math="\(\delta+\int X_1\,d\mu\le\liminf_n X_n(\omega)/n\quad\text{a.e.}\)"
  lean="hX.ae_add_oneStepIntegral_le_liminf_normalized hT δ hδ"
>}}

- <code>normalized_eq_normalizedCenteredProcess_add_birkhoffAverage</code>
  supplies the pointwise decomposition \(X_n/n=u_n+v_n\).
- The rational null cover supplies the lower bound on \(u\).
- <code>normalizedCenteredProcess_nonpos</code> supplies an upper bound on
  \(u\).
- Birkhoff convergence supplies lower and upper bounds on \(v\) and identifies
  its liminf with \(\int X_1\,d\mu\).
- <code>le_liminf_add</code> consumes all four order gates before addition.
{{< /lean-bridge >}}

### Bridge 7: squeeze the nonnegative log-positive observable

{{< lean-bridge
  human="For almost every sample, normalized log-positive cocycle growth converges to its integrated Fekete rate."
  math="\(\frac{\log^+\lVert C_n(\omega)\rVert}{n}\longrightarrow\gamma_+\quad\text{a.e.}\)"
  lean="hC.ae_tendsto_normalizedLogPlusNormObservable hT"
>}}

- <code>hC : C.HasIntegrableGeneratorLogPlus</code> controls the one-step
  **positive** logarithmic envelope.
- This module's
  <code>ae_integratedLogPlusGrowthRate_le_liminf_normalized</code> is the
  lower rail \(\gamma_+\le\liminf a\).
- The imported RMT-29 declaration
  <code>ae_limsup_normalized_le_integratedLogPlusGrowthRate</code> is the
  prior upper rail \(\limsup a\le\gamma_+\).
- Global nonnegativity supplies the lower bound on \(a\); the convergent
  one-step Birkhoff majorant supplies its eventual upper bound.
- <code>tendsto_of_le_liminf_of_limsup_le</code> closes the squeeze.
- No token here names the signed quantity
  <code>Real.log ‖C n ω‖</code>; contractions and zero products remain
  intentionally invisible.
{{< /lean-bridge >}}

### Type-check the exact project interface

{{< repo-check module="NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman" >}}

**Resource label: pinned project plus Mathlib, approved Linux cloud compute
only.** Put the following probe in a temporary file inside
<code>formalization/</code> on the approved builder:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman

open MeasureTheory Set Filter Topology
open NonlinearDynamics.Random.RandomCocycles

#check normalizedProcess
#check normalizedProcess_zero
#check normalizedProcess_update_zero
#check liminf_normalizedProcess_succ
#check mem_centeredStrictLowerDeviationSet_iff_exists_frequently_normalized_lt
#check liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet
#check IsIntegrableSubadditiveProcessCandidate.mem_centeredStrictLowerDeviationSet_iff_liminf_normalizedCenteredProcess_lt
#check IsIntegrableSubadditiveProcessCandidate.centeredLowerLiminfDeviationSet_subset_rationalExhaustion
#check IsIntegrableSubadditiveProcessCandidate.ae_isBoundedUnder_ge_and_le_liminf_normalizedCenteredProcess
#check IsIntegrableSubadditiveProcessCandidate.ae_add_oneStepIntegral_le_liminf_normalized
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_integratedLogPlusGrowthRate_le_liminf_normalized
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedLogPlusNormObservable
~~~

From the repository root on that approved Linux host, type:

~~~sh
source "$HOME/.elan/env"
CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/Random/RandomCocycles/SubadditiveKingman.lean
~~~

This is the authoritative project/Mathlib check. It verifies the pinned
manifest and checks the complete 627-line source with warnings fatal. It may
restore or compile substantial dependencies. Do **not** run this command, raw
<code>lake</code>, or a project import on the Mac workstation.
{{< /repo-check >}}

## Run the exact finite ledger with Lean and `Std`

The project theorem needs Mathlib's filters, measures, liminf, Birkhoff
theorem, and cocycle hierarchy. Its numerical spine can be explored without
building any of that. The following standalone worksheet imports only Lean's
<code>Std</code> library and uses exact rationals throughout.

Save this block byte for byte as
<code>/tmp/GuardedRealLiminfTutorial.lean</code>:

~~~lean
import Std

namespace GuardedRealLiminfTutorial

structure SequenceRow where
  n : Nat
  value : Rat
  belowInnerQ : Bool
  deriving Repr, DecidableEq

def boundedAlternation (n : Nat) : Rat :=
  if n = 0 then 0
  else if n % 2 = 1 then (-3 : Rat) / 2
  else (-1 : Rat) / 2

def boundedRows : List SequenceRow :=
  (List.range 11).map fun n =>
    { n := n
      value := boundedAlternation n
      belowInnerQ := decide (boundedAlternation n < (-5 : Rat) / 4) }

def approachZero (n : Nat) : Rat :=
  if n = 0 then 0 else (-1 : Rat) / n

def approachRows : List SequenceRow :=
  (List.range 9).map fun n =>
    { n := n
      value := approachZero n
      belowInnerQ := decide (approachZero n < (-1 : Rat) / 4) }

def quadraticEscapeNormalized (n : Nat) : Rat :=
  if n = 0 then 0 else 1 - n

def escapeRows : List SequenceRow :=
  (List.range 9).map fun n =>
    { n := n
      value := quadraticEscapeNormalized n
      belowInnerQ := decide (quadraticEscapeNormalized n < (-2 : Rat)) }

structure EscapeBoundary where
  target : Rat
  innerQ : Rat
  innerBelowTarget : Bool
  bound : Rat
  boundHoldsThrough : Nat
  valueThere : Rat
  firstDisplayedFailure : Nat
  valueAtFailure : Rat
  boundFailsThere : Bool
  sourceProvedTotalizedRealLiminf : Rat
  unguardedConclusion : Bool
  deriving Repr, DecidableEq

def escapeBoundary : EscapeBoundary :=
  { target := -1
    innerQ := -2
    innerBelowTarget := decide ((-2 : Rat) < -1)
    bound := -10
    boundHoldsThrough := 11
    valueThere := quadraticEscapeNormalized 11
    firstDisplayedFailure := 12
    valueAtFailure := quadraticEscapeNormalized 12
    boundFailsThere := decide (quadraticEscapeNormalized 12 < (-10 : Rat))
    sourceProvedTotalizedRealLiminf := 0
    unguardedConclusion := decide ((0 : Rat) < -1) }

structure SqueezeRow where
  k : Nat
  lowerRail : Rat
  sample : Rat
  upperRail : Rat
  width : Rat
  insideRails : Bool
  deriving Repr, DecidableEq

def gamma : Rat := 3 / 2

def lowerRail (k : Nat) : Rat := gamma - 1 / k

def upperRail (k : Nat) : Rat := gamma + 1 / k

def squeezedSample (k : Nat) : Rat :=
  if k % 2 = 0 then lowerRail k else upperRail k

def squeezeRow (k : Nat) : SqueezeRow :=
  { k := k
    lowerRail := lowerRail k
    sample := squeezedSample k
    upperRail := upperRail k
    width := upperRail k - lowerRail k
    insideRails := decide
      (lowerRail k ≤ squeezedSample k ∧ squeezedSample k ≤ upperRail k) }

def squeezeRows : List SqueezeRow :=
  (List.range 8).map fun n => squeezeRow (n + 1)

def zeroRateRows : List (Nat × Rat) :=
  (List.range 6).map fun n =>
    let k := n + 1
    (k, 1 / (k : Rat))

#eval boundedRows
#eval approachRows
#eval escapeRows
#eval escapeBoundary
#eval squeezeRows
#eval zeroRateRows

example : boundedAlternation 0 = 0 := by native_decide
example : boundedAlternation 9 = (-3 : Rat) / 2 := by native_decide
example : boundedAlternation 10 = (-1 : Rat) / 2 := by native_decide
example : (List.range 11).all fun n =>
    decide ((-3 : Rat) / 2 ≤ boundedAlternation n ∧
      boundedAlternation n ≤ 0) := by native_decide
example : (List.range 5).all fun j =>
    decide (boundedAlternation (2 * j + 1) < (-5 : Rat) / 4) := by
  native_decide
example : (List.range 11).all fun n =>
    decide (¬ boundedAlternation n < (-3 : Rat) / 2) := by native_decide

example : (List.range 8).all fun n =>
    decide (approachZero (n + 1) < 0) := by native_decide
example : (List.range 5).all fun n =>
    decide (¬ approachZero (n + 4) < (-1 : Rat) / 4) := by
  native_decide

example : quadraticEscapeNormalized 11 = -10 := by native_decide
example : quadraticEscapeNormalized 12 = -11 := by native_decide
example : (List.range 5).all fun j =>
    decide (quadraticEscapeNormalized (j + 4) < (-2 : Rat)) := by
  native_decide
example : escapeBoundary.unguardedConclusion = false := by native_decide

example : (List.range 8).all fun n =>
    (squeezeRow (n + 1)).insideRails := by native_decide
example : (List.range 8).all fun n =>
    decide ((squeezeRow (n + 1)).width = 2 / ((n + 1 : Nat) : Rat)) := by
  native_decide
example : (List.range 6).all fun n =>
    decide (0 < (zeroRateRows[n]!).2) := by native_decide

end GuardedRealLiminfTutorial
~~~

Open a terminal and type:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean \
  /tmp/GuardedRealLiminfTutorial.lean
~~~

**Resource label: small standalone Lean 4.32.0 plus `Std`, suitable for an
ordinary Mac or Linux host.** This exact file ran in 3.4 seconds on the
workstation and printed the following complete transcript:

~~~text
[{ n := 0, value := 0, belowInnerQ := false },
 { n := 1, value := (-3 : Rat)/2, belowInnerQ := true },
 { n := 2, value := (-1 : Rat)/2, belowInnerQ := false },
 { n := 3, value := (-3 : Rat)/2, belowInnerQ := true },
 { n := 4, value := (-1 : Rat)/2, belowInnerQ := false },
 { n := 5, value := (-3 : Rat)/2, belowInnerQ := true },
 { n := 6, value := (-1 : Rat)/2, belowInnerQ := false },
 { n := 7, value := (-3 : Rat)/2, belowInnerQ := true },
 { n := 8, value := (-1 : Rat)/2, belowInnerQ := false },
 { n := 9, value := (-3 : Rat)/2, belowInnerQ := true },
 { n := 10, value := (-1 : Rat)/2, belowInnerQ := false }]
[{ n := 0, value := 0, belowInnerQ := false },
 { n := 1, value := -1, belowInnerQ := true },
 { n := 2, value := (-1 : Rat)/2, belowInnerQ := true },
 { n := 3, value := (-1 : Rat)/3, belowInnerQ := true },
 { n := 4, value := (-1 : Rat)/4, belowInnerQ := false },
 { n := 5, value := (-1 : Rat)/5, belowInnerQ := false },
 { n := 6, value := (-1 : Rat)/6, belowInnerQ := false },
 { n := 7, value := (-1 : Rat)/7, belowInnerQ := false },
 { n := 8, value := (-1 : Rat)/8, belowInnerQ := false }]
[{ n := 0, value := 0, belowInnerQ := false },
 { n := 1, value := 0, belowInnerQ := false },
 { n := 2, value := -1, belowInnerQ := false },
 { n := 3, value := -2, belowInnerQ := false },
 { n := 4, value := -3, belowInnerQ := true },
 { n := 5, value := -4, belowInnerQ := true },
 { n := 6, value := -5, belowInnerQ := true },
 { n := 7, value := -6, belowInnerQ := true },
 { n := 8, value := -7, belowInnerQ := true }]
{ target := -1,
  innerQ := -2,
  innerBelowTarget := true,
  bound := -10,
  boundHoldsThrough := 11,
  valueThere := -10,
  firstDisplayedFailure := 12,
  valueAtFailure := -11,
  boundFailsThere := true,
  sourceProvedTotalizedRealLiminf := 0,
  unguardedConclusion := false }
[{ k := 1, lowerRail := (1 : Rat)/2, sample := (5 : Rat)/2, upperRail := (5 : Rat)/2, width := 2, insideRails := true },
 { k := 2, lowerRail := 1, sample := 1, upperRail := 2, width := 1, insideRails := true },
 { k := 3,
   lowerRail := (7 : Rat)/6,
   sample := (11 : Rat)/6,
   upperRail := (11 : Rat)/6,
   width := (2 : Rat)/3,
   insideRails := true },
 { k := 4,
   lowerRail := (5 : Rat)/4,
   sample := (5 : Rat)/4,
   upperRail := (7 : Rat)/4,
   width := (1 : Rat)/2,
   insideRails := true },
 { k := 5,
   lowerRail := (13 : Rat)/10,
   sample := (17 : Rat)/10,
   upperRail := (17 : Rat)/10,
   width := (2 : Rat)/5,
   insideRails := true },
 { k := 6,
   lowerRail := (4 : Rat)/3,
   sample := (4 : Rat)/3,
   upperRail := (5 : Rat)/3,
   width := (1 : Rat)/3,
   insideRails := true },
 { k := 7,
   lowerRail := (19 : Rat)/14,
   sample := (23 : Rat)/14,
   upperRail := (23 : Rat)/14,
   width := (2 : Rat)/7,
   insideRails := true },
 { k := 8,
   lowerRail := (11 : Rat)/8,
   sample := (11 : Rat)/8,
   upperRail := (13 : Rat)/8,
   width := (1 : Rat)/4,
   insideRails := true }]
[(1, 1), (2, (1 : Rat)/2), (3, (1 : Rat)/3), (4, (1 : Rat)/4), (5, (1 : Rat)/5), (6, (1 : Rat)/6)]
~~~

Read the output as four separate ledgers:

1. the alternating sequence repeatedly crosses \(-5/4\) and remains between
   \(-3/2\) and zero;
2. \(-1/n\) is negative at every displayed positive time but stops strictly
   crossing \(-1/4\) at equality \(n=4\);
3. \(1-n\) keeps crossing \(-2\), defeats the displayed lower bound one step
   after equality, and makes the proposed unguarded conclusion false; and
4. the exact squeeze rows lie between their two rails with width \(2/k\),
   while the positive zero-rate rows \(1/k\) approach the allowed endpoint
   zero.

The <code>example</code> declarations kernel-check every recorded finite
identity and Boolean window. The field
<code>sourceProvedTotalizedRealLiminf := 0</code> is an explicit reference to
the paired Mathlib proof, not a reimplementation of liminf in <code>Std</code>.
The infinite frequency, eventual boundedness, totalized real-liminf, null-set,
Birkhoff, and cocycle claims remain exactly the guarded cloud-only project
interfaces above.

## Audit every checked interface

### RMT-33 declaration ledger

| Declaration | Mathematical job | Essential gate |
|---|---|---|
| <code>normalizedProcess</code> | Total normalization \(X_n/n\) | Division at zero is intentionally total |
| <code>normalizedProcess_zero</code> | Proves the zero-time value is zero | None |
| <code>normalizedProcess_update_zero</code> | Shows time-zero data is completely forgotten | Function extensionality and a zero/nonzero split |
| <code>normalizedCenteredProcess</code> | Normalizes the centered process | Inherits total normalization |
| <code>normalizedCenteredProcess_zero</code> | Proves centered normalization also vanishes at time zero | Reduces to total normalization |
| <code>liminf_normalizedProcess_succ</code> | Removes the finite zero-time prefix | <code>liminf_nat_add</code> |
| <code>normalized_eq_normalizedCenteredProcess_add_birkhoffAverage</code> | Gives the exact centered plus additive identity | Holds at every natural time |
| <code>mem_centeredArbitrarilyLateBadBlockSet_iff_frequently_normalized_lt</code> | Converts block witnesses into filter frequency | Positive witness removes division boundary |
| <code>mem_centeredStrictLowerDeviationSet_iff_exists_frequently_normalized_lt</code> | Exposes one durable rational margin | Countable rational generator |
| <code>liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet</code> | Sends event membership to low real liminf | Explicit eventual lower bound |
| <code>centeredRationalLowerDeviationExhaustionSet</code> | Unions RMT-32 events over rational targets below \(\delta\) | Countability |
| <code>mem_centeredRationalLowerDeviationExhaustionSet_iff</code> | Exposes one rational outer target below \(\delta\) and membership in its strict event | Subtype-indexed union membership |
| <code>centeredLowerLiminfDeviationSet</code> | Names the strict real-liminf exceptional set | Total real liminf is used deliberately |
| <code>mem_centeredLowerLiminfDeviationSet_iff</code> | Rewrites exceptional-set membership as its defining strict liminf inequality | Definitional equivalence |
| <code>normalizedCenteredProcess_nonpos</code> | Supplies a pointwise centered upper bound | Candidate shifted subadditivity |
| <code>mem_centeredStrictLowerDeviationSet_of_liminf_normalizedCenteredProcess_lt</code> | Sends low liminf to a rational event | Nonpositivity supplies coboundedness |
| <code>mem_centeredStrictLowerDeviationSet_iff_liminf_normalizedCenteredProcess_lt</code> | States the guarded equivalence | Eventual lower bound remains visible |
| <code>centeredLowerLiminfDeviationSet_subset_rationalExhaustion</code> | Implements the two-margin cover | Rational density twice |
| <code>measure_centeredRationalLowerDeviationExhaustionSet_eq_zero</code> | Makes the outer exhaustion null | Probability, ergodicity, integral lower bound |
| <code>measure_centeredLowerLiminfDeviationSet_eq_zero</code> | Makes strict lower-liminf deviation null | Set inclusion plus null monotonicity |
| <code>ae_isBoundedUnder_ge_and_le_liminf_normalizedCenteredProcess</code> | Returns both semantic guard and lower inequality | Complement of the rational exhaustion |
| <code>ae_add_oneStepIntegral_le_liminf_normalized</code> | Transfers the centered bound to \(X_n/n\) | Birkhoff convergence and four <code>le_liminf_add</code> gates |
| <code>ae_integratedLogPlusGrowthRate_le_liminf_normalized</code> | Identifies the cocycle lower endpoint | Centered Fekete offset and full ergodicity assembled |
| <code>ae_tendsto_normalizedLogPlusNormObservable</code> | Proves almost-everywhere convergence to \(\gamma_+\) | Lower bound, upper bound, and explicit two-sided boundedness |

The private helper
<code>ae_isBoundedUnder_ge_normalizedCenteredProcess</code> is intentionally
not public. Its content is exposed through the stronger public conjunction
theorem.

### Complete paired-source manifest

The authoritative paired file is
<code>formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveKingman.lean</code>.
At this chapter revision it has 627 lines and SHA-256 digest
<code>55680bc2afa18d0a195a7fa7426e6afb2b55fcbb3f588d3474bc6f52764025ef</code>.
It imports exactly:

1. <code>NonlinearDynamics.Random.RandomCocycles.SubadditiveLowerDeviation</code>;
   and
2. <code>NonlinearDynamics.Random.RandomCocycles.SubadditiveUpperLimsup</code>.

The 24 public declarations appear in source order in the ledger above. The
remaining named private surface is complete in the following table.

| Private source item | Role |
|---|---|
| <code>ae_isBoundedUnder_ge_normalizedCenteredProcess</code> | Extracts one eventual rational lower-bound witness off the null exhaustion |
| <code>rmt33ZeroProcess</code> | Defines the zero-process boundary |
| <code>rmt33ApproachZeroFromBelow</code> | Defines the total sequence \((-1)/n\), with value zero at time zero |
| <code>rmt33ApproachZeroFromBelow_tendsto</code> | Proves convergence to zero |
| <code>rmt33ApproachZeroFromBelow_frequently_neg</code> | Proves strict negative crossings are frequent |
| <code>rmt33ApproachZeroFromBelow_not_frequently_below</code> | Proves every fixed rational \(q\lt0\) eventually stops being crossed |
| <code>rmt33QuadraticEscapeProcess</code> | Defines the one-point process \(X_n=-n^2\) |
| <code>rmt33QuadraticEscapeProcess_candidate</code> | Checks integrability and shifted subadditivity of that process |
| <code>rmt33QuadraticEscape_centered</code> | Computes its centered numerator as \(-n^2+n\) |
| <code>rmt33QuadraticEscape_mem</code> | Checks event membership at target \(-1\) using rational witness \(-2\) |
| <code>rmt33QuadraticEscape_liminf</code> | Proves the pinned total real liminf is zero because the eventual-lower-bound set is empty |

Five anonymous <code>example</code> probes then test the public boundary:

| Probe, in source order | Exact checked boundary |
|---:|---|
| 1 | The zero process has liminf zero and an empty strict deviation set at target zero |
| 2 | Replacing the arbitrary time-zero slice leaves normalized liminf unchanged |
| 3 | \((-1)/n\) has liminf zero and is frequently negative, but crosses no fixed rational \(q\lt0\) frequently |
| 4 | The quadratic candidate belongs to the rational event at \(-1\), has no eventual lower bound, and does **not** have total real liminf below \(-1\) |
| 5 | The final convergence theorem remains well typed for the empty matrix-index type |

Finally, the source contains exactly 11 explicit axiom-audit probes:

~~~lean
#print axioms normalizedProcess_update_zero
#print axioms liminf_normalizedProcess_succ
#print axioms mem_centeredArbitrarilyLateBadBlockSet_iff_frequently_normalized_lt
#print axioms liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet
#print axioms IsIntegrableSubadditiveProcessCandidate.mem_centeredStrictLowerDeviationSet_of_liminf_normalizedCenteredProcess_lt
#print axioms IsIntegrableSubadditiveProcessCandidate.centeredLowerLiminfDeviationSet_subset_rationalExhaustion
#print axioms IsIntegrableSubadditiveProcessCandidate.measure_centeredLowerLiminfDeviationSet_eq_zero
#print axioms IsIntegrableSubadditiveProcessCandidate.ae_isBoundedUnder_ge_and_le_liminf_normalizedCenteredProcess
#print axioms IsIntegrableSubadditiveProcessCandidate.ae_add_oneStepIntegral_le_liminf_normalized
#print axioms DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_integratedLogPlusGrowthRate_le_liminf_normalized
#print axioms DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedLogPlusNormObservable
~~~

These lines are part of the source manifest, not a substitute for the guarded
cloud check. Their printed results belong to the Linux build transcript; this
chapter does not fabricate them from a workstation-only text scan.

### Pinned Mathlib API ledger

The repository pins Mathlib tag <code>v4.32.0</code>, commit
<code>81a5d257c8e410db227a6665ed08f64fea08e997</code>. These declarations are
the exact library interfaces used or audited for the bridge.

| Pinned file | Declaration | Role in the proof |
|---|---|---|
| <code>Mathlib/Order/LiminfLimsup.lean</code> | <code>Filter.liminf</code> | Supremum of eventual lower bounds |
| same | <code>liminf_congr</code> | Rewrites under eventual equality |
| same | <code>liminf_nat_add</code> | Removes a finite natural prefix |
| same | <code>liminf_le_of_frequently_le</code> | Frequent lower crossings bound liminf, with lower boundedness |
| same | <code>frequently_lt_of_liminf_lt</code> | A strict liminf gap produces frequent crossings, with coboundedness |
| same | <code>le_liminf_iff</code> | Characterizes lower bounds under boundedness and coboundedness gates |
| <code>Mathlib/Algebra/Order/Archimedean/Real/Basic.lean</code> | <code>Real.sSup_empty</code> | Explains totalization of an empty lower-bound set |
| <code>Mathlib/Topology/Order/LiminfLimsup.lean</code> | <code>Filter.Tendsto.liminf_eq</code> | Identifies liminf of the convergent Birkhoff term |
| same | <code>Filter.Tendsto.isBoundedUnder_ge</code> | Extracts eventual lower boundedness from convergence |
| same | <code>Filter.Tendsto.isBoundedUnder_le</code> | Extracts eventual upper boundedness from convergence |
| same | <code>tendsto_of_le_liminf_of_limsup_le</code> | Closes the final squeeze with two boundedness gates |
| <code>Mathlib/Topology/Algebra/Order/LiminfLimsup.lean</code> | <code>le_liminf_add</code> | Transfers centered and Birkhoff lower limits through addition |
| <code>Mathlib/Order/Filter/IsBounded.lean</code> | <code>isBoundedUnder_of</code> | Packages a global bound as a filter bound |
| same | <code>IsBoundedUnder.mono_le</code> | Transfers an upper bound through an eventual majorant |
| same | <code>IsBoundedUnder.isCoboundedUnder_ge</code> | Supplies the required dual order gate |
| same | <code>isCoboundedUnder_ge_of_le</code> | Uses the global centered upper bound |
| <code>Mathlib/Order/Filter/AtTopBot/Basic.lean</code> | <code>frequently_atTop</code> | Expands frequency into arbitrarily late witnesses |
| <code>Mathlib/MeasureTheory/OuterMeasure/Basic.lean</code> | <code>measure_iUnion_null</code> | Makes the countable rational union null |
| same | <code>measure_mono_null</code> | Transfers nullity to the lower-liminf exceptional subset |
| <code>Mathlib/MeasureTheory/OuterMeasure/AE.lean</code> | <code>measure_eq_zero_iff_ae_notMem</code> | Moves from nullity to an almost-everywhere complement |
| <code>Mathlib/Algebra/Order/Archimedean/Basic.lean</code> | <code>exists_rat_lt</code> | Chooses an outer lower rational |
| same | <code>exists_rat_btwn</code> | Chooses strict inner and outer rational margins |
| <code>Mathlib/Analysis/Subadditive.lean</code> | <code>Subadditive.lim</code> | Defines the deterministic Fekete rate |
| same | <code>Subadditive.lim_le_div</code> | Places the rate below each positive normalized horizon |
| same | <code>Subadditive.tendsto_lim</code> | Proves convergence of normalized integrated growth |
| <code>Mathlib/Analysis/SpecialFunctions/Log/PosLog.lean</code> | <code>Real.posLog</code> | Defines \(\log^+r=\max\{0,\log r\}\) |
| same | <code>Real.posLog_mul</code> | Supports log-positive subadditivity |
| <code>Mathlib/Dynamics/Ergodic/Ergodic.lean</code> | <code>PreErgodic</code> | Records ergodic rigidity without preservation |
| same | <code>Ergodic</code> | Bundles preservation with pre-ergodicity |

### Assumption ledger

| Assumption | Where it is obtained | What it licenses | What it does not license |
|---|---|---|---|
| Measurable space on \(\Omega\) | Ambient setup | Integrals, almost-everywhere statements, measurable dynamics | Probability normalization |
| Integrability of every \(X_n\) | Candidate structure | Centering, finite integrals, Birkhoff input at \(n=1\) | Independence or convergence by itself |
| Shifted subadditivity | Candidate structure | One-step orbit majorant, centered nonpositivity, prior bad-block estimates | Additivity |
| Measure preservation | Bundled in the discrete cocycle, explicit in generic ergodic input | Integral transport and Birkhoff theory | Ergodic rigidity |
| Pre-ergodicity | Final cocycle hypothesis | Combines with bundled preservation to form <code>Ergodic</code> | Preservation on its own |
| Probability normalization | Typeclass hypothesis | Expectation semantics and the RMT-32 null-branch selection | Independence |
| One-step log-positive integrability | <code>HasIntegrableGeneratorLogPlus</code> | Integrability at every horizon via the orbit majorant | Signed log integrability |
| Eventual lower boundedness | Constructed off the rational null cover | Honest real-liminf algebra | A signed or extended-real conclusion |
| Eventual upper boundedness | Centered nonpositivity or convergent Birkhoff majorant | Conditional-completeness liminf and final convergence lemmas | A uniform bound over all samples |
| Rational countability | Type-level property of \(\mathbb Q\) | Nullity of the exhaustion union | A quantitative rate of convergence |
| Rational density | Archimedean order | Two strict margins | Any probabilistic approximation |

The final theorem asks for
<code>PreErgodic C.base μ</code>, not a bare
<code>Ergodic C.base μ</code>, because the cocycle already stores
<code>C.base_preserving</code>. The proof constructs

\[
\text{Ergodic}(C.\mathrm{base},\mu)
\]

from those two pieces. Pre-ergodicity alone would not be sufficient for an
arbitrary map.

### Checked nonclaim ledger

RMT-33 does **not** prove any of the following:

- convergence in \(L^1\);
- convergence in probability as a separately packaged theorem;
- equality obtained by interchanging a samplewise limit and an integral;
- convergence of normalized integrals as a consequence of the samplewise
  theorem, although the deterministic Fekete convergence was proved earlier;
- convergence of the signed quantity
  \(n^{-1}\log\lVert C_n(\omega)\rVert\);
- detection of negative growth rates;
- a Lyapunov exponent in the usual signed sense;
- inverse-cocycle integrability or control;
- invertibility or nonzero determinant of the matrices;
- an Oseledets filtration, splitting, or multiplicity theorem;
- independence, identical distribution, or stationarity formulated as a
  stochastic-process law;
- a rate of convergence, concentration bound, or finite-sample confidence
  statement;
- a claim that the original 1923 Fekete paper states Mathlib's modern general
  subadditive-sequence theorem verbatim;
- the full matrix-product corollary stated by Ruelle in 1979;
- a nondegenerate matrix dimension requirement. The Lean theorem deliberately
  retains the empty-index boundary.

## Boundary audits

### Zero process

For \(X_n=0\), centering, normalization, liminf, limsup, and the integrated
rate are all zero. The strict lower-liminf deviation set at target zero is
empty. This checks strictness at the endpoint.

### Arbitrary time-zero replacement

Changing \(X_0\) to any function changes no normalized value because division
at zero returns zero. It therefore changes no lower limit and no convergence
statement.

### Approach zero from below

The sequence \(-1/n\) crosses zero strictly at every positive time but no
fixed rational slope below zero frequently. It checks the necessity of
durable rational slack.

### Quadratic escape

The centered normalized sequence \(1-n\) belongs to strict rational
lower-deviation events but has no eventual lower bound. Its formal real
liminf is zero because the eventual-lower-bound set is empty. It checks the
necessity of the guard.

### Empty matrix dimension

When the matrix index type is empty, the operator norm observable is
formalized so that every log-positive value is zero. The final theorem still
typechecks and yields convergence to zero. This is a Lean boundary guarantee,
not a classical theorem's advertised matrix regime.

### Constant expansion and contraction

For \(C_n=a^nI\) with \(a\gt1\), log-positive and signed normalized growth both
equal \(\log a\). For \(0\lt a\lt1\), the signed rate is \(\log a\), while the
log-positive rate is zero. This pair checks exactly where the two observables
agree and separate.

## Place the result beside the classical theorems

The historical sources illuminate the architecture, but their statements
should not be substituted for the checked Lean theorem.

### Kingman 1968

J. F. C. Kingman's
[“The Ergodic Theory of Subadditive Stochastic Processes”](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x)
appeared in volume 30, issue 3 of the *Journal of the Royal Statistical
Society, Series B*, pp. 499 to 510. Section 1 on p. 500 introduces the
stationary subadditive setting and the deterministic time constant as an
infimum of normalized expectations. Theorem 1 on p. 501 handles an upper
asymptotic quantity and mean behavior. Theorem 3 on p. 504 identifies the
invariant limit structure, and Theorem 5 on p. 506 gives existence of the
almost-sure normalized limit.

RMT-33 shares the subadditive, measure-preserving, ergodic architecture. It
does not reproduce all of Kingman's conclusions, especially mean convergence.
The publisher PDF was access-restricted during this audit; exact anchors were
checked against a scan, while the
[publisher landing page](https://academic.oup.com/jrsssb/article/30/3/499/7026968)
confirms the bibliographic record.

### Steele 1989

J. Michael Steele's
[“Kingman's subadditive ergodic theorem”](https://numdam.org/item/AIHPB_1989__25_1_93_0/)
gives an accessible compact proof in *Annales de l'Institut Henri Poincaré,
Probabilités et Statistiques* 25(1), pp. 93 to 98. The theorem is stated on
pp. 93 to 94. Section 2 centers by a one-step orbit sum on p. 94. The
interval-decomposition and bad-set estimates occupy pp. 94 to 96, and
equation (2.5) on p. 96 closes the limsup versus liminf argument.

Steele is a useful conceptual map for the project's RMT-30 through RMT-33
sequence. It is not a line-by-line source for the Lean declarations, whose
event encodings and totalized real-order guards are specific to the pinned
library.

### Ruelle 1979

David Ruelle's
[“Ergodic theory of differentiable dynamical systems”](https://doi.org/10.1007/BF02684768)
appeared in *Publications Mathématiques de l'IHÉS* 50, pp. 27 to 58.
[The open PDF](https://www.numdam.org/item/PMIHES_1979__50__27_0.pdf)
states a subadditive theorem as Theorem 1.1 on p. 29. Corollary 1.2 on
pp. 29 to 30 treats products of real matrices under integrability of the
one-step positive log norm.

That corollary concludes convergence of the **signed**, extended-real
normalized log norm and includes a normalized-integral formula. RMT-33 proves
the narrower real-valued log-positive envelope theorem. Constant contractions
and zero products show why the two statements are not interchangeable.

### Fekete 1923

Michael Fekete's
[1923 paper](https://eudml.org/doc/167739),
[DOI 10.1007/BF01504345](https://doi.org/10.1007/BF01504345), contains at
Theorem II on printed p. 233 a multiplicative convergence argument for
extremal polynomial quantities using a block and remainder decomposition.
It is a historical antecedent of the lemma now bearing his name.

The exact modern formal source used here is instead
<code>Mathlib/Analysis/Subadditive.lean</code>, whose
<code>Subadditive.lim</code>, <code>Subadditive.lim_le_div</code>, and
<code>Subadditive.tendsto_lim</code> state the general real-sequence interface
needed by the project.

### Furstenberg and Kesten 1960

H. Furstenberg and H. Kesten's
[“Products of Random Matrices”](https://doi.org/10.1214/aoms/1177705909)
appeared in *The Annals of Mathematical Statistics* 31, pp. 457 to 469.
The original full text was not accessible in this source audit, so this
chapter does not assign an unchecked theorem number or exact assumption list
to it. Ruelle's introduction on p. 28 provides an accessible primary
historical connection between the matrix-product result and Kingman's
subadditive theorem.

## What the proof teaches beyond this theorem

Several reusable formalization principles emerge.

1. **A total operation needs a semantic certificate.** Total definitions are
   convenient for rewriting, but their intended mathematical interpretation
   may require side conditions.
2. **Countable event design is theorem design.** Rational margins make the
   exceptional set both expressive enough for real strict inequalities and
   small enough for countable measure closure.
3. **A null set can carry constructive data.** Its complement may produce an
   eventual numerical witness, not merely a proposition with measure one.
4. **Centering should match the available convergence theorem.** Subtracting
   the one-step orbit sum creates a nonpositive residual and an additive
   Birkhoff component.
5. **Conditional completeness should remain visible at public interfaces.**
   RMT-33 returns boundedness beside the lower-limit inequality instead of
   burying it inside a private proof.
6. **Boundary models are part of the theorem specification.** The
   \(-1/n\), quadratic escape, contraction, zero-product, and empty-dimension
   examples each reject a different overclaim.

## Forty solved exercises

The exercises are arranged in eight ropes of five. Each rope begins with a
direct reconstruction and ends with a boundary or design problem.

### Rope I: total normalization and filter time

#### Exercise 1: prove that time-zero replacement is invisible

Let \(X:\mathbb N\to\Omega\to\mathbb R\), let \(z:\Omega\to\mathbb R\), and
replace \(X_0\) by \(z\). Prove pointwise that the total normalized process is
unchanged.

**Solution.** Fix \(n\) and \(\omega\). If \(n=0\), both normalized values are
zero because division by zero in \(\mathbb R\) is totalized to zero. The
numerators may differ, but neither survives normalization. If \(n\ne0\), a
function update at index zero does not change the \(n\)-th slice, so the
numerators and denominators agree. The two cases prove equality for every
\(n,\omega\), and function extensionality proves equality of the normalized
processes. This is the argument checked by
<code>normalizedProcess_update_zero</code>.

The result is stronger than finite-prefix invariance of a limit. It says every
normalized value is identical before any asymptotic operation is applied.

#### Exercise 2: expand frequency at natural infinity

Show that

\[
\exists^\infty_{\mathrm{atTop}}n,\ P(n)
\]

is equivalent to

\[
\forall N\in\mathbb N,\ \exists n\in\mathbb N,\quad N\le n\ \text{and}\ P(n).
\]

**Solution.** A property is frequent in a filter when its negation is not
eventual. For the natural-number <code>atTop</code> filter, eventual \(Q(n)\)
means that there is a cutoff \(N\) such that \(Q(n)\) holds whenever
\(N\le n\). Negating “eventually not \(P\)” gives: for every proposed cutoff
\(N\), there is some \(n\ge N\) at which \(P(n)\) holds. Mathlib packages this
equivalence as <code>frequently_atTop</code>.

It expresses arbitrarily late recurrence. It does not say there is a cutoff
after which \(P\) always holds.

#### Exercise 3: separate frequent from eventual

Let \(P(n)\) mean that \(n\) is even. Prove that \(P\) and its negation are
both frequent along natural infinity, while neither is eventual.

**Solution.** Given any cutoff \(N\), the number \(2N\) is at least \(N\) and
even, so \(P\) is frequent. The number \(2N+1\) is at least \(N\) and odd, so
\(\neg P\) is frequent. If \(P\) were eventual, its frequent negation would
be impossible. Likewise, if \(\neg P\) were eventual, frequent \(P\) would be
impossible.

This model explains why an arbitrarily-late bad-block event can coexist with
arbitrarily late good blocks. RMT-33 needs only recurrent strict crossings at
one fixed rational slope.

#### Exercise 4: remove a finite prefix

Suppose \(a,b:\mathbb N\to\mathbb R\) agree for every \(n\ge17\). Under the
usual library side conditions needed for real lower limits, explain why they
have the same liminf.

**Solution.** Agreement from index 17 onward is eventual equality along
<code>atTop</code>. The declaration <code>liminf_congr</code> says eventual
equality is enough to identify lower limits. One may also shift each sequence
by 17 and use <code>liminf_nat_add</code>, then identify the shifted
sequences pointwise.

For RMT-33 the first route proves that the exact centered-plus-Birkhoff
identity may be rewritten under liminf. The second route proves that the
totalized time-zero term has no asymptotic effect.

#### Exercise 5: decode the relation orientation

Translate the following filter propositions into ordinary quantified
sentences:

\[
\operatorname{IsBoundedUnder}(\ge,\mathrm{atTop},a),
\qquad
\operatorname{IsBoundedUnder}(\le,\mathrm{atTop},a).
\]

**Solution.** The first means there is \(b\in\mathbb R\) such that eventually
\(b\le a_n\). It is eventual lower boundedness. The second means there is
\(B\in\mathbb R\) such that eventually \(a_n\le B\). It is eventual upper
boundedness.

A reliable Lean-reading method is to ignore the English word “under,” expand
the relation, and locate the fixed witness. With relation \(\ge\), the
eventual assertion has the form \(a_n\ge b\), so \(b\) lies below the
sequence. With relation \(\le\), it has the form \(a_n\le B\), so \(B\) lies
above it.

### Rope II: the guarded real lower limit

#### Exercise 6: compute the totalized liminf of \(1-n\)

Let \(a_n=1-n\). Show that the set of eventual real lower bounds of \(a\) is
empty, then compute Mathlib's real liminf.

**Solution.** Fix any \(b\in\mathbb R\). By the Archimedean property, choose a
natural \(n\) with \(n\gt1-b\). Then \(1-n\lt b\). The same argument works
beyond every proposed cutoff by increasing \(n\), so \(b\le1-n\) cannot hold
eventually. Since \(b\) was arbitrary, there is no eventual real lower bound.

The defining set for real liminf is therefore empty. In the pinned real-order
implementation, <code>Real.sSup_empty</code> gives
\(\sup\varnothing=0\). Hence the formal real liminf is zero. The extended-real
lower limit would be negative infinity, so the two notions intentionally
diverge outside the bounded-below regime.

#### Exercise 7: prove event membership forces a low liminf under the guard

Assume \(u\) is eventually bounded below and there is a rational \(q\lt c\)
such that \(u_n\lt q\) frequently. Prove

\[
\liminf_nu_n\lt c.
\]

**Solution.** Frequent strict inequality implies frequent weak inequality
\(u_n\le q\). The theorem <code>liminf_le_of_frequently_le</code>, supplied
with the eventual lower-bound hypothesis, gives

\[
\liminf_nu_n\le q.
\]

Composing this weak inequality with \(q\lt c\) yields the desired strict
inequality. The rational nature of \(q\) is not used by the liminf theorem. It
is used earlier to keep the event family countable.

#### Exercise 8: prove a low liminf creates a rational event

Assume \(u_n\le0\) for every \(n\) and

\[
\liminf_nu_n\lt c.
\]

Explain how to prove membership in \(D_c\).

**Solution.** Rational density gives \(q\in\mathbb Q\) satisfying

\[
\liminf_nu_n\lt q\lt c.
\]

The global upper bound \(u_n\le0\) supplies the order-coboundedness hypothesis
needed by <code>frequently_lt_of_liminf_lt</code>. Applying that theorem to
the first strict inequality gives frequent \(u_n\lt q\). The second strict
inequality and the event membership characterization then give
\(\omega\in D_c\).

The proof uses an upper bound, not the eventual lower bound from Exercise 7.
This asymmetry is a feature of conditionally complete liminf APIs.

#### Exercise 9: locate the false unguarded implication

Use \(u_n=1-n\) and \(c=-1\) to refute

\[
\omega\in D_c
\quad\Longrightarrow\quad
\liminf_nu_n\lt c
\]

when no eventual lower bound is assumed.

**Solution.** The sequence is eventually below every fixed rational slope.
For example, \(q=-2\) satisfies \(q\lt c\), and \(1-n\lt-2\) for every
\(n\gt3\). Thus the point belongs to \(D_{-1}\).

Exercise 6 computed the total real liminf as zero. The claimed conclusion
would be \(0\lt-1\), which is false. This counterexample is also compatible
with subadditivity after using the checked quadratic-escape process, so the
problem cannot be dismissed as an artifact of an unrelated arbitrary
sequence.

#### Exercise 10: compare a real and extended-real design

What would change if the entire proof used
\(\mathbb R\cup\{-\infty,+\infty\}\) for lower limits?

**Solution.** An extended-real liminf can represent unbounded negative escape
as negative infinity, so the empty-eventual-lower-bound totalization issue
would disappear. Event membership could imply a low extended liminf without
first constructing a finite real lower bound.

Several other costs would appear. The centered-plus-Birkhoff identity would
mix extended and real arithmetic. Addition near opposing infinities requires
care. The final target \(\gamma_+\) is real, so one would still need to prove
finiteness before using a real convergence theorem. Existing project APIs for
the Birkhoff average and integrated Fekete rate are real-valued. RMT-33's
guarded-real design keeps those interfaces aligned and makes the required
finiteness witness explicit. Neither design is universally superior; the
right choice depends on whether negative-infinite behavior is part of the
intended theorem.

### Rope III: rational margins and countable event design

#### Exercise 11: construct the two margins

Given real numbers \(L\lt\delta\), prove that there are rationals \(q,c\) such
that

\[
L\lt q\lt c\lt\delta.
\]

**Solution.** First use rational density to choose
\(c\in\mathbb Q\) with \(L\lt c\lt\delta\). Apply rational density again to
the strict interval \((L,c)\) to choose
\(q\in\mathbb Q\) with \(L\lt q\lt c\). Combining the inequalities yields
the required chain.

The order of construction matters conceptually. The first choice secures an
event target where the prior nullity theorem applies. The second choice
secures a witness slope for membership in that event.

#### Exercise 12: prove the exceptional-set inclusion

Let

\[
E_\delta=\{\omega:L(\omega)\lt\delta\},
\qquad
R_\delta=\bigcup_{\substack{c\in\mathbb Q\\c\lt\delta}}D_c.
\]

Assuming the normalized centered process is nonpositive, prove
\(E_\delta\subseteq R_\delta\).

**Solution.** Fix \(\omega\in E_\delta\), so
\(L(\omega)\lt\delta\). Exercise 11 provides rational
\(q,c\) with

\[
L(\omega)\lt q\lt c\lt\delta.
\]

Normalized centered nonpositivity supplies the coboundedness gate for
<code>frequently_lt_of_liminf_lt</code>. Therefore \(u_n(\omega)\lt q\)
frequently. Since \(q\lt c\), the event characterization gives
\(\omega\in D_c\). Since \(c\lt\delta\), this particular \(D_c\) is one member
of the outer union, so \(\omega\in R_\delta\).

#### Exercise 13: pass nullity through the exhaustion

Suppose \(\mu(D_c)=0\) for every rational \(c\lt\delta\). Prove
\(\mu(R_\delta)=0\).

**Solution.** The index type

\[
\{c\in\mathbb Q:(c:\mathbb R)\lt\delta\}
\]

is a subtype of the countable type \(\mathbb Q\), hence countable. The set
\(R_\delta\) is a countable union of null sets. The measure theorem
<code>measure_iUnion_null</code> gives zero measure for the union.

No disjointness is needed. No summability estimate is needed either, because
every summand is exactly null. The countability of the rational generator is
the decisive closure property.

#### Exercise 14: diagnose the \(\delta\lt\delta\) failure

Why can the proof not simply show \(E_\delta\subseteq D_\delta\) and invoke
RMT-32 at target \(\delta\)?

**Solution.** The RMT-32 nullity theorem separates two parameters. A
deterministic \(\delta\) is assumed to lie below every positive normalized
centered integral, while the event target \(c\) must satisfy \(c\lt\delta\).
This strict gap is what makes the earlier measure ratio strictly below one
and selects the null branch.

Calling the theorem with \(c=\delta\) would demand
\(\delta\lt\delta\), an impossible hypothesis. The outer rational \(c\) is not
proof bureaucracy. It preserves the strict separation on which the prior
argument depends.

#### Exercise 15: replace rationals by another set

Could the proof use dyadic rationals instead of all rationals?

**Solution.** Yes, provided the chosen set is countable and order-dense in
\(\mathbb R\). Dyadic rationals of the form \(k/2^m\) are countable and dense,
so both rational choices can be replaced by dyadic choices. Countability
still closes the null union, and density still detects every strict real gap.

The current Lean proof uses \(\mathbb Q\) because Mathlib already provides
<code>exists_rat_lt</code> and <code>exists_rat_btwn</code>, and the RMT-32
event was defined with rational slopes. A dyadic redesign would add encoding
work without strengthening the theorem.

### Rope IV: one null cover, two outputs

#### Exercise 16: extract a concrete eventual lower bound

Fix \(\omega\notin R_\delta\). Choose rationals \(q\lt c\lt\delta\). Prove
that \(q\le u_n(\omega)\) eventually.

**Solution.** Since \(c\lt\delta\), the event \(D_c\) is included in the union
\(R_\delta\). Therefore \(\omega\notin D_c\). If
\(u_n(\omega)\lt q\) held frequently, then \(q\lt c\) and the membership
theorem would put \(\omega\) in \(D_c\), a contradiction.

Thus \(u_n(\omega)\lt q\) is not frequent. In any filter,
<code>not_frequently</code> converts this to eventual negation. Eventually
it is not true that \(u_n(\omega)\lt q\), which in a linear order is exactly
\(q\le u_n(\omega)\). The rational \(q\) is now an explicit witness for
eventual lower boundedness.

#### Exercise 17: extract the lower-liminf inequality

Assume \(\mu(E_\delta)=0\). Prove

\[
\delta\le L(\omega)
\]

almost everywhere.

**Solution.** A null set has an almost-everywhere complement. Outside
\(E_\delta\), the defining statement \(L(\omega)\lt\delta\) is false. Linear
order turns \(\neg(L(\omega)\lt\delta)\) into
\(\delta\le L(\omega)\). In Lean,
<code>measure_eq_zero_iff_ae_notMem</code> crosses from measure-zero language
to almost-everywhere nonmembership, and simplification of the set definition
finishes the order step.

#### Exercise 18: explain why Exercise 17 cannot replace Exercise 16

Why not derive eventual lower boundedness directly from the almost-everywhere
inequality \(\delta\le L(\omega)\)?

**Solution.** Because \(L\) is the total real liminf. For \(u_n=1-n\), the
formal value is zero even though no eventual lower bound exists. Taking
\(\delta=-1\) makes the numerical inequality \(-1\le0\) true, but it provides
no lower-bound witness.

Exercise 16 instead uses the logical content of avoiding a frequent rational
crossing. That content survives totalization and produces a fixed number
below all late values. The proof must therefore retain the rational
exhaustion even after it has already shown the lower-liminf exceptional set
null.

#### Exercise 19: combine the almost-everywhere statements safely

Suppose \(P(\omega)\) holds almost everywhere and \(Q(\omega)\) holds almost
everywhere. Explain why the conjunction holds almost everywhere and apply
this to RMT-33's generic centered endpoint.

**Solution.** Filters are closed under finite intersection. The
almost-everywhere filter associated with \(\mu\) therefore contains the set
where both \(P\) and \(Q\) hold. Lean's <code>filter_upwards</code> tactic
packages this operation.

Take \(P\) to be eventual lower boundedness from the complement of
\(R_\delta\). Take \(Q\) to be
\(\delta\le\liminf u\) from the complement of \(E_\delta\). Their conjunction
is the public theorem
<code>ae_isBoundedUnder_ge_and_le_liminf_normalizedCenteredProcess</code>.
The theorem records that both facts hold at the same sample, which is required
before applying <code>le_liminf_add</code>.

#### Exercise 20: identify the minimal data retained from nullity

Could the helper return only a Boolean statement that the sequence is
bounded below?

**Solution.** The proposition
<code>IsBoundedUnder (· ≥ ·) atTop u</code> is existential. Its proof contains
a lower-bound witness and an eventual proof, although later theorems normally
consume only the packaged proposition. A plain Boolean flag would lose the
logical witness and would not satisfy Mathlib's order APIs.

The proof specifically obtains a rational \(q\) and an eventual statement
\(q\le u_n\). Packaging that pair into <code>IsBoundedUnder</code> preserves
exactly the information required by <code>liminf_le_of_frequently_le</code>,
<code>le_liminf_add</code>, and the final squeeze.

### Rope V: centering and Birkhoff transfer

#### Exercise 21: derive centered nonpositivity

Starting from shifted subadditivity, prove for every positive \(n\) that

\[
X_n(\omega)\le\sum_{j=0}^{n-1}X_1(T^j\omega),
\]

then conclude \(Y_n(\omega)\le0\).

**Solution.** Write a positive horizon as \(n+1\) and induct on \(n\). At the
first positive horizon, the orbit sum is \(X_1(\omega)\), so the inequality is
equality. For the successor step, use the candidate split:

\[
X_{n+1}(\omega)
\le X_1(T^n\omega)+X_n(\omega).
\]

Apply the induction hypothesis to the earlier positive horizon, then recognize
the successor orbit sum. Subtracting that sum from both sides gives
\(Y_n(\omega)\le0\) at positive \(n\). Division by a positive natural cast
preserves nonpositivity, while normalized time zero is separately zero by
totalization. No sign claim about a generic unnormalized \(Y_0\) is needed.

#### Exercise 22: verify the normalized decomposition at zero

The identity

\[
\frac{X_n}{n}=\frac{Y_n}{n}+\frac{S_nX_1}{n}
\]

is obvious for positive \(n\). Why does it also hold at \(n=0\) in Lean?

**Solution.** Each quotient has denominator zero, so every quotient is zero.
The right side is \(0+0\), and the left side is zero. No assertion about
\(X_0\), \(Y_0\), or the empty orbit sum needs to be divided algebraically by
a nonzero number.

This total identity is valuable because <code>liminf_congr</code> can rewrite
the sum without carrying an eventual positivity guard. The positive-time
meaning is recovered separately when inequalities are divided by \(n\).

#### Exercise 23: list the four gates of <code>le_liminf_add</code>

For \(u_n=Y_n/n\) and \(v_n=S_nX_1/n\), identify the four hypotheses supplied
in RMT-33.

**Solution.** The pinned declaration requires:

1. eventual lower boundedness of \(u\);
2. eventual upper boundedness of \(u\);
3. eventual lower boundedness of \(v\);
4. the appropriate lower-side coboundedness condition for \(v\).

The rational null cover supplies item 1. Centered nonpositivity supplies the
global upper bound zero for item 2. Birkhoff convergence supplies eventual
lower and upper bounds for \(v\); the upper bound yields the needed
coboundedness statement for item 4 through the filter-order helper used in
the proof.

The theorem then concludes
\[
\liminf u+\liminf v\le\liminf(u+v).
\]

#### Exercise 24: prove convergence supplies eventual two-sided bounds

If \(v_n\to\ell\) in \(\mathbb R\), construct explicit eventual bounds.

**Solution.** Use the open interval
\((\ell-1,\ell+1)\), a neighborhood of \(\ell\). Convergence implies
\(v_n\in(\ell-1,\ell+1)\) eventually. Hence eventually

\[
\ell-1\le v_n\le\ell+1.
\]

Mathlib exposes the same conclusion abstractly through
<code>Filter.Tendsto.isBoundedUnder_ge</code> and
<code>Filter.Tendsto.isBoundedUnder_le</code>. RMT-33 uses those interfaces
instead of selecting radius one manually.

#### Exercise 25: derive the generic transferred lower bound

Assume almost everywhere that

\[
\delta\le\liminf_nu_n,
\qquad
v_n\to I_1,
\]

and that the gates from Exercise 23 hold. Prove

\[
\delta+I_1
\le
\liminf_n\frac{X_n}{n}.
\]

**Solution.** Convergence gives
\(\liminf v=I_1\). Add the assumed centered inequality to equality on the
second coordinate:

\[
\delta+I_1
\le
\liminf u+\liminf v.
\]

Apply <code>le_liminf_add</code> to bound the right side by
\(\liminf(u+v)\). Finally use eventual, in fact pointwise, equality
\[
u_n+v_n=X_n/n
\]
and <code>liminf_congr</code> to rewrite the last lower limit. Chaining the
three inequalities gives the result.

### Rope VI: deterministic Fekete rate and cocycle specialization

#### Exercise 26: prove integrated subadditivity

Let
\[
X_n(\omega)=\log^+\lVert C_n(\omega)\rVert.
\]
Explain why
\[
A_{m+n}\le A_m+A_n
\]
for \(A_n=\int X_n\,d\mu\).

**Solution.** Cocycle multiplication and submultiplicativity of the operator
norm give a shifted pointwise inequality
\[
X_{m+n}(\omega)
\le
X_n(T^m\omega)+X_m(\omega).
\]
The log-positive product inequality is the scalar bridge. Integrate both
sides. Measure preservation of \(T^m\) gives
\[
\int X_n(T^m\omega)\,d\mu
{} =
\int X_n(\omega)\,d\mu=A_n.
\]
The remaining term integrates to \(A_m\). Finite-horizon integrability
licenses integral monotonicity and addition. Thus
\(A_{m+n}\le A_n+A_m\), which is the same scalar inequality by commutativity.

#### Exercise 27: compute the centered Fekete offset

Let
\[
\delta=\gamma_+-I_1,
\qquad
I_1=\int X_1\,d\mu.
\]
Prove for positive \(n\) that
\[
\delta\le\frac{1}{n}\int Y_n\,d\mu.
\]

**Solution.** The deterministic Fekete property gives
\[
\gamma_+\le\frac{1}{n}\int X_n\,d\mu.
\]
Measure preservation and finite-sum integration give
\[
\int S_nX_1\,d\mu=nI_1.
\]
Therefore
\[
\frac{1}{n}\int Y_n\,d\mu
{} =
\frac{1}{n}\int X_n\,d\mu-I_1.
\]
Subtract \(I_1\) from the Fekete inequality to obtain
\[
\gamma_+-I_1
\le
\frac{1}{n}\int Y_n\,d\mu.
\]
The left side is \(\delta\).

#### Exercise 28: propagate one-step integrability

Assume \(X_1\) is integrable and
\[
0\le X_n(\omega)\le\sum_{j=0}^{n-1}X_1(T^j\omega).
\]
Why is every \(X_n\) integrable?

**Solution.** Measure preservation makes every pullback
\(X_1\circ T^j\) integrable. A finite sum of integrable functions is
integrable, so the orbit majorant is integrable. The observable \(X_n\) is
measurable, nonnegative, and bounded above by that integrable majorant.
The domination theorem for integrability then gives integrability of \(X_n\).

For the cocycle, one-step integrability is exactly
<code>HasIntegrableGeneratorLogPlus</code>. It controls the positive
logarithmic envelope only. It does not imply integrability of the negative
part of the signed logarithm.

#### Exercise 29: explain why independence is absent

Identify the mechanism replacing independent increments in the proof.

**Solution.** The process is generated along one deterministic dynamical
orbit. Dependence is controlled by three structural properties:

- the cocycle law splits a long product at a deterministic time;
- the base transformation preserves the measure, so shifted observables have
  the same integrals;
- ergodicity makes long additive orbit averages converge to their space
  average and drives the earlier invariant-event dichotomy.

None of these statements asserts independence. A strongly dependent
stationary process realized over an ergodic base fits the architecture. The
theorem is dynamical, not an independent-sampling limit theorem.

#### Exercise 30: audit the empty-index boundary

Why does the final theorem remain valid when the matrix index type is empty?

**Solution.** The prior matrix-observable layer explicitly proves that the
norm observable and log-positive observable reduce to their degenerate values
for an empty index. In particular,
\[
X_n(\omega)=0
\]
for every \(n,\omega\). One-step integrability is automatic, every integrated
value is zero, and \(\gamma_+=0\). The normalized process is identically zero,
so it converges to zero.

The final theorem quantifies over any finite index type and does not add a
nonemptiness hypothesis. This is a formal boundary supported by the
definitions. It should not be attributed to a classical source as an
advertised zero-dimensional matrix theorem.

### Rope VII: the final squeeze and the observable boundary

#### Exercise 31: prove global lower boundedness of the final process

Show that
\[
0\le\frac{\log^+\lVert C_n(\omega)\rVert}{n}
\]
for every natural \(n\), including zero.

**Solution.** The numerator is nonnegative by
<code>Real.posLog_nonneg</code>. The natural cast of \(n\) is also
nonnegative. Division of two nonnegative reals is nonnegative. At \(n=0\),
the quotient is zero by total division, consistent with the same inequality.

Thus zero is a global lower bound, stronger than the eventual lower bound
required by the final convergence theorem.

#### Exercise 32: produce the final upper bound

Assume
\[
\frac{X_n(\omega)}{n}\le v_n(\omega)
\]
for all positive \(n\), and \(v_n(\omega)\to I_1\). Prove the normalized
process is eventually bounded above.

**Solution.** Convergence makes \(v_n\) eventually bounded above, say by
\(B\). The majorant inequality is eventual because every sufficiently large
natural is positive. Therefore the normalized process is eventually at most
\(B\). In Lean, the proof packages the majorant as an eventual relation and
uses <code>IsBoundedUnder.mono_le</code> to transfer the Birkhoff sequence's
upper-boundedness certificate.

This upper bound is not inferred from the limsup inequality alone. It is
constructed from an actual convergent majorant.

#### Exercise 33: close convergence from four hypotheses

Let \(a:\mathbb N\to\mathbb R\). Assume

\[
\gamma\le\liminf a,
\qquad
\limsup a\le\gamma,
\]

and that \(a\) is eventually bounded both below and above. Prove
\(a_n\to\gamma\).

**Solution.** General order gives
\[
\liminf a\le\limsup a
\]
under the relevant boundedness regime. Combining all inequalities forces
\[
\liminf a=\gamma=\limsup a.
\]
A real sequence with equal finite lower and upper limits converges to their
common value. The pinned declaration
<code>tendsto_of_le_liminf_of_limsup_le</code> packages the entire argument
and asks for the two boundedness witnesses explicitly.

RMT-33 instantiates \(a_n=X_n(\omega)/n\) and
\(\gamma=\gamma_+\) on a common almost-everywhere set.

#### Exercise 34: compute constant-contraction limits

Let \(C_n=a^nI\) with \(0\lt a\lt1\) and \(\lVert I\rVert=1\). Compute the
signed and log-positive normalized limits.

**Solution.** The norm is \(a^n\). For positive \(n\),
\[
\frac{1}{n}\log\lVert C_n\rVert
{} =
\frac{1}{n}\log(a^n)
=\log a\lt0.
\]
Since \(a^n\le1\),
\[
\log^+\lVert C_n\rVert=0.
\]
Therefore
\[
\frac{1}{n}\log^+\lVert C_n\rVert=0
\]
for every positive \(n\), and its limit is zero.

This example refutes any claim that RMT-33 recovers negative Lyapunov
exponents.

#### Exercise 35: compute the zero-product observables

Suppose \(C_n(\omega)=0\) for all \(n\ge N\). Compare the signed extended log
and the real log-positive observable.

**Solution.** The norm is zero after \(N\). In an extended signed convention,
\[
\log0=-\infty,
\]
so the normalized signed value is negative infinity after the collapse. In
Mathlib's real positive logarithm,
\[
\log^+0=0.
\]
Thus the log-positive normalized observable is zero after \(N\).

The two observables answer different questions. Signed growth detects
collapse. Log-positive growth records only expansion above one. RMT-33 is
correct for the latter and silent about the former.

### Rope VIII: assumptions, sources, and next formalizations

#### Exercise 36: assemble full ergodicity

The final theorem assumes
<code>PreErgodic C.base μ</code>. Explain why Birkhoff may nevertheless use a
full <code>Ergodic C.base μ</code> instance.

**Solution.** A <code>DiscreteMatrixCocycle</code> stores
<code>C.base_preserving</code>. In pinned Mathlib,
<code>PreErgodic</code> supplies the rigidity condition but not preservation,
while <code>Ergodic</code> extends both <code>MeasurePreserving</code> and
<code>PreErgodic</code>. The proof constructs the full structure from the
bundled preservation proof and the explicit pre-ergodicity hypothesis.

For an arbitrary map without bundled preservation, pre-ergodicity alone would
not license integral transport or the pointwise Birkhoff theorem used here.

#### Exercise 37: explain why almost-sure convergence does not prove \(L^1\)
convergence

RMT-33 proves \(a_n\to\gamma_+\) almost everywhere. Why can it not conclude
\[
\int|a_n-\gamma_+|\,d\mu\to0
\]
from that statement alone?

**Solution.** Almost-everywhere convergence does not control the size of rare
large deviations. \(L^1\) convergence would follow from additional
hypotheses such as domination by one integrable function or uniform
integrability, but neither is established for the normalized sequence in
RMT-33. The one-step Birkhoff majorant is samplewise useful and convergent
almost everywhere, yet the theorem does not package an integrable dominator
uniform in \(n\).

Classical versions of Kingman's theorem may prove mean convergence under
their assumptions. That historical fact cannot be imported into the narrower
checked theorem without a formal proof.

#### Exercise 38: compare the four cited sources

Assign one careful role to each of Kingman 1968, Steele 1989, Ruelle 1979, and
Fekete 1923.

**Solution.**

- Kingman 1968 is the primary source for the subadditive ergodic theorem and
  its stationary process architecture.
- Steele 1989 gives a compact accessible proof organized around one-step
  centering, finite interval decomposition, bad sets, and a final
  limsup-liminf comparison.
- Ruelle 1979 supplies a primary matrix-cocycle specialization, but for the
  signed extended-real logarithm and with conclusions stronger than RMT-33.
- Fekete 1923 is a historical multiplicative antecedent of normalized
  subadditive convergence. The exact modern general theorem used by Lean is
  Mathlib's <code>Analysis/Subadditive</code> API.

These roles avoid claiming that any source states the present formal theorem
word for word.

#### Exercise 39: map proof moves to pinned declarations

Choose declarations for the following jobs: remove time zero, turn low liminf
into frequent crossings, turn frequent crossings into low liminf, nullify a
countable union, transfer lower limits through addition, and close
convergence.

**Solution.**

| Job | Declaration |
|---|---|
| Remove time zero | <code>liminf_nat_add</code> |
| Low liminf to frequent crossings | <code>frequently_lt_of_liminf_lt</code> |
| Frequent crossings to low liminf | <code>liminf_le_of_frequently_le</code> |
| Countable union of null sets | <code>measure_iUnion_null</code> |
| Addition lower-limit transfer | <code>le_liminf_add</code> |
| Final squeeze | <code>tendsto_of_le_liminf_of_limsup_le</code> |

The middle two order declarations have different side conditions. A correct
proof audit must record those conditions rather than treating the declarations
as unconditional converses.

#### Exercise 40: design the next signed theorem

List the new mathematical interfaces needed to turn the project from
log-positive convergence toward a signed Lyapunov growth theorem.

**Solution.** At minimum, the project would need:

1. a signed or extended-real log-norm observable that represents zero norms
   without real totalization;
2. integrability assumptions controlling the positive part, and a clear
   policy for the negative part;
3. extended-real liminf, limsup, addition, and measurability interfaces, or a
   proof that the relevant norms stay positive and the signed rate stays
   finite;
4. a signed subadditive convergence theorem with its samplewise and integral
   conclusions stated precisely;
5. boundary tests for singular products and contractions;
6. additional inverse-cocycle hypotheses if the goal includes finite
   two-sided exponents;
7. substantially more linear algebra and invariant-subspace machinery for an
   Oseledets filtration or splitting.

RMT-33 provides none of these merely by changing notation. Its reusable
contribution is the event, centering, rational-cover, and boundedness
architecture.

## Final theorem card

Under a probability measure, a discrete finite-dimensional matrix cocycle
whose base preserves the measure and is pre-ergodic, and whose one-step
log-positive generator norm is integrable, satisfies

\[
\frac{\log^+\lVert C_n(\omega)\rVert}{n}
\longrightarrow
\inf_{k\ge1}
\frac{1}{k}
\int_\Omega\log^+\lVert C_k(\eta)\rVert\,d\mu(\eta)
\]

for almost every \(\omega\).

The proof is valid because the rational null cover establishes not only the
lower-liminf inequality but also the eventual lower boundedness needed to
interpret and manipulate the real lower limit honestly.

The limit is nonnegative and expansion-only. It need not equal the signed
top Lyapunov exponent.

The next checked layer is
[The Forward-and-Inverse Tail Sandwich for Finite-Time Real Log Norms]({{< relref "/knowledge-base/deep-dives/forward-and-inverse-tail-sandwich-for-finite-time-real-log-norms" >}}).
It supplies pointwise unit and inverse-tail hypotheses that make every
finite-time signed real-log observable integrable and subadditive. It also
isolates the strictly positive-rate case where the theorem above can be
unclipped without those hypotheses. That successor still does not prove a
general signed almost-everywhere limit or an Oseledets splitting.
