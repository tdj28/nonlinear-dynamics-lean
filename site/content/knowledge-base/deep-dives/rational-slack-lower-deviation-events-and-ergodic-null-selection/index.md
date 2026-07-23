---
title: "Rational-Slack Lower-Deviation Events and Ergodic Null Selection"
slug: "rational-slack-lower-deviation-events-and-ergodic-null-selection"
date: 2026-07-22
summary: "Start with an exact two-state probability ledger in which one zero-mass state has a durable rational lower deviation, then climb through arbitrarily-late witnesses, threshold-relaxed preimages, almost-invariance, the ergodic empty-or-full fork, and the strict four-fifths bound that selects the null branch."
lead: "On a two-state collapse with all probability mass at the fixed state, the target event is the nonempty null set {a}, its preimage is empty, and the two sets nevertheless agree almost everywhere. The centered integral floor is minus one; at target minus five quarters the inherited ratio is four fifths, so the ergodic probability fork cannot choose mass one. A transient sequence beside it shows why one witness, or even recurrence at the target line without a fixed rational margin, is not enough. This chapter turns those finite ledgers into the exact RMT-32 Lean interface without claiming the later real-liminf bridge."
draft: false
pro_reviewed: false
level: "Subadditive processes, countably generated events, null measurable sets, measure preservation, finite-measure ergodicity, probability normalization, and intermediate Lean theorem reading"
reading_time: "300 to 420 minutes, including the runnable Lean worksheet"
prerequisites: "Centered shifted-subadditive processes, finite bad-block estimates, all-positive-length once-bad events, elementary measure theory, and the meaning of almost-everywhere equality; no real-liminf API or Kingman theorem is assumed"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveLowerDeviation"
toc: true
og_image: "rational-slack-lower-deviation-events-and-ergodic-null-selection-card.png"
og_image_alt: "Warm-paper Deep Dive card for a two-state collapse. The null state a has fixed-slope witnesses from time five onward, the strict event is {a}, its preimage is empty, and the numerical chain zero less than or equal to four fifths less than one selects event mass zero from the ergodic probability fork."
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
review remain pending. The checked Lean source is authoritative. RMT-32 proves
nullity of a countably generated lower-deviation event; it does not yet identify
that event with a library-level real lower limit or prove Kingman convergence.
{{< /panel >}}

## Base camp: a nonempty event can still be the null branch

Start with the two-state space

\[
\Omega=\{a,b\}
\]

and the {{< refterm "probability-measure" "probability measure" >}}

\[
\mu(\{a\})=0,
\qquad
\mu(\{b\})=1.
\]

The point \(a\) exists in the sample space, but it is a
{{< refterm "null-set" "null state" >}}: the singleton \(\{a\}\) has measure
zero. The point \(b\) carries all probability mass. Let the dynamics collapse
the null state into the supported state and then remain there:

\[
T(a)=b,
\qquad
T(b)=b.
\]

Because the only point seen with positive probability is the fixed point
\(b\), \(T\) is {{< refterm "measure-preserving-transformation"
"measure preserving" >}} and ergodic for this measure. This does not erase
\(a\) as a set-theoretic point; it means that
{{< refterm "event" "events" >}} differing only at \(a\)
agree {{< refterm "almost-everywhere" "almost everywhere" >}}.

Define \(X_0=0\). At every positive horizon \(n\), set

\[
X_n(a)=-2(n-1),
\qquad
X_n(b)=-(n-1).
\]

The one-step observable is zero at both states. Its orbit sum is therefore
zero, so the project's centered process is exactly this process:

\[
Y_n
{} =
X_n-S_n(X_1)
{} =
X_n.
\]

### Check subadditivity before using the example

The process is not merely a table chosen to fit the conclusion. It is a
shifted-subadditive candidate. The cases with \(m=0\) or \(n=0\) are
equalities because \(X_0=0\). When \(m,n\gt0\), the supported state gives

\[
\begin{aligned}
X_{m+n}(b)
&=-(m+n-1)\\
&\le -(m-1)-(n-1)\\
&=X_m(b)+X_n(T^m b).
\end{aligned}
\]

At the null state, \(T^m a=b\) for positive \(m\), so

\[
\begin{aligned}
X_{m+n}(a)
&=-2(m+n-1)\\
&\le -2(m-1)-(n-1)\\
&=X_m(a)+X_n(T^m a).
\end{aligned}
\]

The finite `Std` worksheet later checks every triple
\((m,n,\omega)\) with \(0\le m,n\le12\); the displayed calculation proves the
formula at every horizon.

This exact two-state ledger is the chapter's pedagogical model, not one of the
six anonymous Mathlib-backed probes compiled in RMT-32. The source contains
nearby collapse, identity, half-mass, zero-process, and empty-index probes.
The complete source-order map below keeps those checked artifacts separate
from this executable teaching worksheet.

### Fix one rational margin below the target

Choose

\[
q=-\frac32,
\qquad
c=-\frac54.
\]

The margin is strict:

\[
q\lt c.
\]

At \(a\), the positive-time normalized values are

\[
\frac{X_n(a)}n=-2+\frac2n.
\]

The inequality \(X_n(a)\lt qn\) is equivalent to

\[
-2(n-1)\lt-\frac32n
\quad\Longleftrightarrow\quad
n\gt4.
\]

Thus every \(n\ge5\) is a strict \(q\)-witness. At \(b\),

\[
\frac{X_n(b)}n=-1+\frac1n\gt-1\gt-\frac54=c,
\]

so no rational threshold below \(c\) can ever be a witness there.

| \(n\) | \(X_n(a)\) | \(X_n(a)/n\) | below \(q=-3/2\)? | \(X_n(b)\) | \(X_n(b)/n\) |
|---:|---:|---:|:---:|---:|---:|
| 1 | 0 | 0 | no | 0 | 0 |
| 2 | \(-2\) | \(-1\) | no | \(-1\) | \(-1/2\) |
| 3 | \(-4\) | \(-4/3\) | no | \(-2\) | \(-2/3\) |
| 4 | \(-6\) | \(-3/2\) | equality, not strict | \(-3\) | \(-3/4\) |
| 5 | \(-8\) | \(-8/5\) | yes | \(-4\) | \(-4/5\) |
| 6 | \(-10\) | \(-5/3\) | yes | \(-5\) | \(-5/6\) |
| 7 | \(-12\) | \(-12/7\) | yes | \(-6\) | \(-6/7\) |
| 8 | \(-14\) | \(-7/4\) | yes | \(-7\) | \(-7/8\) |

The phrase *arbitrarily late* has exact quantifiers. Given any cutoff
\(N\), choose

\[
n=\max(N,5).
\]

Then \(N\le n\), \(n\gt0\), and \(X_n(a)\lt qn\). One formula answers every
possible cutoff, although the chosen witness may depend on that cutoff.

{{< reference-figure
  wide="true"
  src="two-state-rational-slack-ledger.svg"
  alt="In a two-state collapse with mass zero at a and mass one at b, the centered process equals minus two times n minus one at a and minus n minus one at b. For rational q minus three halves below target c minus five quarters, the a row first becomes strictly bad at n equals five and remains bad thereafter; b never becomes bad. A cutoff table chooses max of N and five for requested cutoffs through one hundred."
  caption="**Finding:** the raw strict event at \(c=-5/4\) is the singleton \(\{a\}\). The fixed rational \(q=-3/2\) works at \(a\) beyond every cutoff, while \(X_n(b)/n\gt-1\gt c\) rules out \(b\). Equality at \(n=4\) is not a strict witness. These are exact toy values, not sampled frequencies."
>}}

Consequently the fixed-margin and target events are

\[
A_{-3/2}=\{a\},
\qquad
D_{-5/4}=\{a\}.
\]

### Compute the preimage before saying “invariant”

No state maps to \(a\). Therefore

\[
T^{-1}D_{-5/4}=\varnothing
\subsetneq
\{a\}=D_{-5/4}.
\]

Literal invariance is false. But the symmetric difference is \(\{a\}\), a
null set, so

\[
T^{-1}D_{-5/4}
=^{\mu}_{\mathrm{ae}}
D_{-5/4}.
\]

This one example separates set inclusion, equality, and almost-everywhere
equality.

### Let the integrated rate select the branch

Integration sees only the supported point \(b\):

\[
\int_\Omega X_n\,d\mu=-(n-1).
\]

For every positive \(n\),

\[
\delta:=-1
\le
-1+\frac1n
{} =
\frac{\int_\Omega X_n\,d\mu}{n}.
\]

Our target satisfies \(c=-5/4\lt\delta=-1\). The inherited RMT-31 ratio is

\[
\frac{\delta}{c}
{} =
\frac{-1}{-5/4}
{} =
\frac45
\lt1.
\]

Ergodicity and probability normalization give the numerical fork

\[
\mu(D_c)\in\{0,1\}.
\]

The strict subunit estimate rules out \(1\), so

\[
\mu(D_{-5/4})=0.
\]

The direct set computation already told us the answer. The point of the
theorem architecture is that the same branch selection works when an event
cannot be enumerated point by point.

{{< reference-figure
  wide="true"
  src="preimage-null-selection-ledger.svg"
  alt="At target minus five quarters, the strict event is the zero-mass singleton a and its preimage is empty. Their inclusion is strict but their symmetric difference has mass zero, so they agree almost everywhere. Ergodicity gives event mass zero or one, while delta minus one divided by c minus five quarters is four fifths, strictly below one, selecting zero. At target minus three quarters the event is full, but the required inequality c less than delta is false."
  caption="**Finding:** \(T^{-1}D_c=\varnothing\subsetneq\{a\}=D_c\), yet both sides agree almost everywhere because \(\mu(\{a\})=0\). The probability fork is \(0\) or \(1\); the exact ceiling \(4/5\lt1\) selects \(0\). The same ergodic system has the full event at \(c=-3/4\), where the premise \(c\lt\delta\) correctly fails."
>}}

The full branch is not fictional. At the higher target
\(c_{\mathrm{full}}=-3/4\), state \(a\) uses margin \(-3/2\) and state \(b\)
uses margin \(-4/5\). Hence

\[
D_{-3/4}=\Omega,
\qquad
\mu(D_{-3/4})=1.
\]

There is no conflict with the strict estimate because

\[
-\frac34\lt-1
\]

is false. The hypothesis \(c\lt\delta\) is a mathematical gate, not proof
ceremony.

The lower half of a subadditive ergodic theorem has a particular logical
shape. First construct the right exceptional event. Then show that shifting
time does not change it except on a null set. Only after that may ergodicity
force the event to be almost empty or almost full. Finally, a quantitative
estimate must rule out the full branch.

Random-matrix-theory milestone 32 (RMT-32) formalizes that event-level
architecture for the centered process used
throughout this project. Its central lesson is easy to state and easy to miss:

> Strict asymptotic deviation needs one margin that survives arbitrarily far
> into time. Repeated inequalities at the target line are not enough.

The durable margin is chosen from the rational numbers. That choice preserves
the intended real threshold through density while keeping the event a
countable union, exactly the form needed by the available null-measurability
closure theorems.

This chapter is the textbook companion to the
[RMT-32 Development Notebook]({{< relref "/development-notebook/2026/07/countably-generated-centered-lower-deviation-events-in-lean" >}}).
It continues
[From Finite Centered Bad-Block Bounds to All-Positive-Length Control]({{< relref "/knowledge-base/deep-dives/from-finite-centered-bad-block-bounds-to-all-positive-length-control" >}})
and uses the quantitative estimate from
[Finite Bad-Block Measure Bounds Before Kingman Lower Liminf]({{< relref "/knowledge-base/deep-dives/finite-bad-block-measure-bounds-before-kingman-lower-liminf" >}}).
Compact background is available in
{{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}},
{{< refterm "ergodicity" "ergodicity" >}},
{{< refterm "ergodic-probability-base" "ergodic probability base" >}}, and
{{< refterm "almost-everywhere" "almost everywhere" >}}.

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| Base camp | [A nonempty event can still be the null branch](#base-camp-a-nonempty-event-can-still-be-the-null-branch) | Compute the event, preimage, fork, and \(4/5\) selector |
| Intuition | [Why one witness cannot carry an asymptotic theorem](#why-one-witness-cannot-carry-an-asymptotic-theorem) | Separate a finite accident from recurrent deviation |
| Event | [Build one fixed-margin event](#build-one-fixed-margin-event) | Read the intersection-union quantifiers |
| Slack | [Why strict rational slack is essential](#why-strict-rational-slack-is-essential) | Reject a tempting but false encoding |
| Shift | [Pull a shifted witness back one step](#pull-a-shifted-witness-back-one-step) | See the endpoint arithmetic |
| Measure | [Upgrade inclusion to almost-invariance](#upgrade-inclusion-to-almost-invariance) | Locate finite mass exactly |
| Ergodic | [Separate dichotomy from branch selection](#separate-dichotomy-from-branch-selection) | Keep ergodicity and probability distinct |
| Audit | [Walk through the boundary models](#walk-through-the-boundary-models) | Test every assumption against a concrete edge |
| Interface | [Seven Lean bridges](#in-lean-seven-bridges-from-cutoffs-to-the-null-branch) | Connect mathematics to exact Lean names and commands |
| Frontier | [Stop exactly at the RMT-32 boundary](#stop-exactly-at-the-rmt-32-boundary) | Hand the real-liminf bridge to RMT-33 |
| Practice | [Thirty-six solved exercises](#thirty-six-solved-exercises) | Rebuild the whole argument |

## Common setup and notation

Let \(\Omega\) be a type of states, let \(\mu\) be a measure on
\(\Omega\), and let \(T:\Omega\to\Omega\) advance the base dynamics by one
step. Let

\[
X_n:\Omega\to\mathbb R,
\qquad n\in\mathbb N,
\]

be a shifted-subadditive process:

\[
X_{a+b}(\omega)
\le X_b(T^a\omega)+X_a(\omega).
\]

The repository subtracts the additive orbit sum of the one-step observable:

\[
Y_n(\omega)
{} :=
X_n(\omega)-\sum_{j=0}^{n-1}X_1(T^j\omega).
\]

This is pointwise {{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}}.
It is not subtraction of an expectation. The resulting centered process has

\[
Y_1=0
\]

and remains shifted-subadditive. In particular, the split \(1+n\) gives

\[
Y_{n+1}(\omega)\le Y_n(T\omega).
\]

For positive \(n\), write the normalized centered slope as

\[
z_n(\omega):=\frac{Y_n(\omega)}{n}.
\]

RMT-32 avoids formal use of \(z_n\) and division inside its event. It writes
the equivalent positive-time inequality \(Y_n(\omega)\lt qn\). This keeps
the witnesses close to the finite bad-block machinery inherited from RMT-31.

## Why one witness cannot carry an asymptotic theorem

RMT-31 studies the all-positive-length once-bad event

\[
B_\infty(c)
{} :=
\left\{\omega:\exists n\gt0,\ Y_n(\omega)\lt cn\right\}.
\]

A point enters after one finite witness. That is exactly the right union for
passing a finite-cap measure estimate to all possible lengths. It is not the
right event for a lower asymptotic slope.

A transient defect can create one strict inequality and then disappear. If a
process has \(Y_2=-1\) but \(Y_n=-1\) for every later \(n\), then
\(z_n=-1/n\) returns to zero. At the target \(c=-2/5\), time two is bad,
but sufficiently late times are not. The point is once-bad without having a
negative lower asymptotic slope below \(-2/5\).

{{< reference-figure
  wide="true"
  src="one-witness-no-slack-boundary.svg"
  alt="For the transient sequence that is minus one from time two onward, the normalized values are minus one half, minus one third, minus one fifth, minus one ninth, minus one tenth, and minus one twentieth. At target minus two fifths only time two is bad. At target zero every later time is below the target, but a fixed margin minus one tenth stops being strict at time ten. The main two-state process instead remains below minus three halves from time five onward."
  caption="**Finding:** three quantifier patterns differ. The transient process has one \(c=-2/5\) witness, has same-target witnesses below \(0\) forever, but has no fixed rational \(q\lt0\) that survives arbitrarily late because \(-1/n\to0\). In the running model, \(q=-3/2\) works at every \(n\ge5\). The values are exact toy arithmetic, and strictness excludes the equality at \(n=10\)."
>}}

The required quantifier change is therefore

\[
\exists n\gt0
\qquad\longrightarrow\qquad
\forall N\in\mathbb N,\ \exists n\ge N,\ n\gt0.
\]

The new universal cutoff is what turns a finite incident into an asymptotic
pattern.

## Build one fixed-margin event

Fix a real slope \(q\). RMT-32 defines

\[
A_q
{} :=
\left\{\omega:
\forall N\in\mathbb N,\ \exists n\in\mathbb N,\
N\le n,\ 0\lt n,\ Y_n(\omega)\lt qn
\right\}.
\]

The Lean definition spells this out as a countable intersection over cutoffs,
followed by a countable union over candidate witness lengths, followed by a
logical guard recording \(N\le n\) and \(0\lt n\). The membership theorem
packages the nested set expression back into the readable quantifiers above.

The condition means *arbitrarily late*, not *eventually always*. For every
cutoff there is a later witness, but good lengths may occur between witnesses.
On natural-number time, this is equivalent to having an unbounded set of bad
witness lengths. It is stronger than having at least one witness and weaker
than requiring every sufficiently large length to be bad.

The positivity guard matters at cutoff zero. The normalized slope is a
positive-time object, and \(Y_0\lt q\cdot0\) would not carry the intended
information.

### Exhaust the target from below

Now fix the target \(c\in\mathbb R\). The strict lower-deviation event is

\[
D_c
{} :=
\bigcup_{\substack{q\in\mathbb Q\\q\lt c}} A_q.
\]

Thus \(\omega\in D_c\) means that one rational \(q\lt c\) works beyond every
cutoff. The same \(q\) must work throughout the argument. It may not drift
toward \(c\) as the cutoff grows.

{{< reference-figure
  src="countable-rational-event-anatomy.svg"
  alt="The event is built in three nested layers: each cutoff asks for one later positive witness at a fixed slope, all cutoffs together form one arbitrarily-late event, and a countable union over rational slopes below the target forms the strict lower-deviation event."
  caption="**Finding:** the quantifiers have three distinct jobs. The witness length may depend on the cutoff, the rational margin may not, and only the outer rational choice ranges over possible durable margins. Natural cutoffs, natural lengths, and rational margins keep every set operation countable. The boxes describe logical structure, not measured proportions."
>}}

The definition immediately gives two useful inclusions:

\[
A_q\subseteq B_\infty(q),
\qquad
D_c\subseteq B_\infty(c).
\]

For the second inclusion, choose the rational witness \(q\lt c\), take any
positive arbitrarily-late witness, and use positivity of \(n\) to obtain
\(qn\lt cn\). This bridge is where RMT-31's quantitative once-bad estimate
will later enter.

## Why strict rational slack is essential

It is tempting to define a target event using arbitrarily late inequalities
at \(c\) itself:

\[
\forall N,\ \exists n\ge N,\quad z_n(\omega)\lt c.
\]

That condition is too weak for a *strict* lower-limit conclusion. Consider

\[
z_n=c-\frac{1}{n+1}.
\]

Every term lies strictly below \(c\), so the same-threshold condition holds
at every positive time. Yet \(z_n\) converges upward to \(c\). Its lower
limit equals \(c\), not a value strictly below \(c\).

For any fixed \(q\lt c\), put \(\varepsilon=c-q\gt0\). Once
\(1/(n+1)\lt\varepsilon\), we have \(z_n\gt q\). Therefore no fixed
rational \(q\lt c\) has witnesses arbitrarily late. The event \(D_c\)
correctly rejects this sequence.

{{< reference-figure
  src="strict-below-without-durable-gap.svg"
  alt="One lane shows values remaining below a target line while closing the gap and eventually rising above every fixed lower margin, so it is rejected. The other lane revisits a fixed lower band beyond every cutoff, so one durable margin certifies membership."
  caption="**Finding:** being strictly below the target infinitely often can still leave the lower limit equal to the target. RMT-32 accepts only a pattern that repeatedly enters one fixed band below the target. The curves are qualitative countersequence sketches; their spacing and vertical scale are not data."
>}}

Why use rational rather than real margins? Two reasons coincide.

First, the rational numbers are dense: whenever a real value \(d\lt c\), one
can choose \(q\in\mathbb Q\) with \(d\lt q\lt c\). A genuine strict gap is
therefore detectable by a rational threshold.

Second, the rational numbers are countable. A union over all real
\(q\lt c\) would be uncountable, and null-measurable sets are not generally
closed under arbitrary uncountable unions. Rational density keeps the semantic
resolution while supplying the countable syntax needed by measure theory.

RMT-32 does **not** prove an equality between \(D_c\) and a Mathlib expression
involving <code>liminf</code>. The countersequence above validates the design.
The exact guarded bridge is proved in `SubadditiveKingman.lean` and explained in
the later
[RMT-33 Deep Dive]({{< relref "/knowledge-base/deep-dives/guarded-real-liminf-bridge-to-log-positive-kingman-convergence" >}}).

## Pull a shifted witness back one step

The dynamical heart of the module begins with a point
\(\omega\in T^{-1}A_q\). This means \(T\omega\in A_q\). For every large
cutoff, there is a positive \(n\) with

\[
Y_n(T\omega)\lt qn.
\]

Centered shifted subadditivity at the split \(1+n\), together with \(Y_1=0\),
gives

\[
Y_{n+1}(\omega)\le Y_n(T\omega).
\]

The witness moves back to \(\omega\), but its length changes from \(n\) to
\(n+1\). At the same threshold, the comparison between \(qn\) and
\(q(n+1)\) has the wrong direction when \(q\lt0\). Same-threshold setwise
invariance is therefore not available.

### Spend a little threshold to absorb the endpoint

Choose real slopes \(q\lt r\). The arithmetic lemma proves that some natural
cutoff \(K\) satisfies

\[
qn\lt r(n+1)
\qquad\text{whenever }K\le n.
\]

To see why, rewrite the desired inequality as

\[
-r\lt(r-q)n.
\]

Since \(r-q\gt0\), it is enough to choose a natural number larger than
\((-r)/(r-q)\). Mathlib's Archimedean theorem provides such a natural number.
No sign assumption on \(q\) or \(r\) is needed.

The supported state in base camp gives a fully numerical instance. Take

\[
q=-\frac45,
\qquad
r=-\frac{31}{40},
\qquad
q\lt r\lt-\frac34.
\]

At \(n=32\),

\[
\begin{aligned}
Y_{33}(b)=-32
&\le Y_{32}(Tb)=-31\\
&\lt q\cdot32=-\frac{128}{5}\\
&\lt r\cdot33=-\frac{1023}{40}.
\end{aligned}
\]

The final comparison is only one fortieth wide:
\(-128/5=-1024/40\lt-1023/40\). It is nevertheless strict, which is all the
set inclusion needs. Smaller horizons may fail that endpoint comparison; the
theorem promises an eventual cutoff, not a uniform inequality from time one.

Given a requested cutoff \(N\), ask the \(A_q\) hypothesis at
\(\max(N,K)\). The resulting \(n\) is late enough both for the user's cutoff
and for the endpoint arithmetic. Then

\[
Y_{n+1}(\omega)
\le Y_n(T\omega)
\lt qn
\lt r(n+1).
\]

Thus

\[
T^{-1}A_q\subseteq A_r
\qquad(q\lt r).
\]

{{< reference-figure
  src="one-step-shift-and-threshold-relaxation.svg"
  alt="A witness of length n at the shifted point pulls back to a witness of length n plus one at the original point. A finite cutoff makes the slope gap large enough to absorb the added endpoint, so the threshold must relax from q to a larger r."
  caption="**Finding:** centered subadditivity transports a shifted witness backward, but it adds one endpoint. Beyond a finite arithmetic cutoff, the strict gap from the old slope to a larger slope absorbs that endpoint. The figure labels the logical inequalities only; arrow lengths and box sizes carry no quantitative meaning."
>}}

The public theorem carrying this step has an integrable-candidate receiver
because that is the repository's reusable process interface. Its proof uses
only the centered shifted-subadditivity <code>add_le</code> field. Integrability
first does mathematical work in the null-measurability layer below. This is a
proof-dependency observation, not a claim that the public shift theorem has no
assumptions.

### Recover the same target through rational density

Suppose \(T\omega\in D_c\). Then some rational \(q\lt c\) satisfies
\(T\omega\in A_q\). Rational density supplies another rational \(r\) with

\[
q\lt r\lt c.
\]

The relaxed shift theorem gives \(\omega\in A_r\), and \(r\lt c\) puts that
event back into the same union \(D_c\). Hence

\[
T^{-1}D_c\subseteq D_c.
\]

This is a one-sided set inclusion. It is neither setwise equality nor an
almost-everywhere statement. The distinction is the hinge for the next
measure-theoretic layer.

## Establish null measurability without finite mass

Assume the public integrable shifted-subadditive candidate interface and that
\(T\) preserves \(\mu\). Every centered process value is integrable, hence
almost-everywhere measurable. Therefore each threshold set

\[
\{\omega:Y_n(\omega)\lt qn\}
\]

is null measurable. Mathlib's countable closure operations then assemble
the event:

\[
A_q
=\bigcap_N\bigcup_n(\text{guard}_{N,n}\cap\{Y_n\lt qn\}),
\]

followed by the countable rational union defining \(D_c\).

The result is <code>NullMeasurableSet</code>, not necessarily
<code>MeasurableSet</code>. Null measurability is exactly the stable language
for representatives that may differ from measurable functions or sets on a
null set.

Finite total mass, probability normalization, and ergodicity are absent from
both regularity theorems. Preservation appears because the existing
integrability theorem for the centered process transports the one-step
observable along the orbit.

## Upgrade inclusion to almost-invariance

Let \(D=D_c\). Three facts are now available:

1. \(T^{-1}D\subseteq D\);
2. \(D\) is null measurable; and
3. preservation gives \(\mu(T^{-1}D)=\mu(D)\).

If \(\mu\) is finite, the larger set cannot contain a positive-measure
remainder. Mathlib's subset-plus-measure comparison theorem yields

\[
T^{-1}D=^{\mu}_{\mathrm{ae}}D.
\]

Here \(=^{\mu}_{\mathrm{ae}}\) means that membership agrees for
\(\mu\)-almost every point. It does not mean literal set equality.

{{< reference-figure
  src="assumption-ladder-to-null-selection.svg"
  alt="An assumption ladder starts with candidate integrability and preservation for null measurability, adds finite total mass to upgrade one-sided inclusion to almost-invariance, adds ergodicity for an almost-empty or almost-full fork, and finally adds probability normalization plus the strict ratio to select the empty branch."
  caption="**Finding:** no single hypothesis performs every job. Preservation supplies equal preimage mass, finite mass turns equal mass plus inclusion into almost-equality, ergodicity creates the dichotomy, and probability normalization makes the full branch have mass one so the strict ratio can exclude it. Each rung retains the conclusions below it; the plate is a dependency map, not a claim of logical necessity in every alternative formulation."
>}}

Finite mass enters at one precise point: the target measure must not be
infinite. Without that gate, a proper subset can have the same infinite
measure as its superset. Equality \(\infty=\infty\) cannot prove that the
difference is null.

This also explains why preservation alone is not invariance. It equates
measures of a null-measurable set and its preimage. The one-sided dynamical
inclusion and finite target are the additional ingredients that turn equality
of numbers into almost-equality of sets.

## Separate dichotomy from branch selection

Assume now that \(T\) is ergodic and \(\mu\) is finite. Mathlib's
quasi-ergodic almost-invariance theorem applies to the null-measurable event:

\[
D_c=^{\mu}_{\mathrm{ae}}\varnothing
\quad\text{or}\quad
D_c=^{\mu}_{\mathrm{ae}}\Omega.
\]

This is the ergodic dichotomy. Probability normalization is **not** needed
for it. On a finite measure of total mass \(m\), the full branch has measure
\(m\), whatever \(m\) is.

If \(\mu\) is a probability measure, then \(m=1\), and the setwise dichotomy
becomes the numerical statement

\[
\mu(D_c)=0
\quad\text{or}\quad
\mu(D_c)=1.
\]

Ergodicity does not by itself tell us which branch occurs.

### Use RMT-31 to exclude the full branch

Suppose a real number \(\delta\) satisfies the uniform centered-integral lower
bound

\[
\delta
\le
\frac{\int_\Omega Y_n\,d\mu}{n}
\qquad(n\ne0),
\]

and choose \(c\lt\delta\). The time-one identity \(Y_1=0\) forces
\(\delta\le0\), hence \(c\lt0\).

The inclusion \(D_c\subseteq B_\infty(c)\) and RMT-31 give

\[
\mu_{\mathbb R}(D_c)
\le
\mu_{\mathbb R}(B_\infty(c))
\le
\frac{\delta}{c}.
\]

Because the denominator is negative, \(c\lt\delta\) is exactly what yields

\[
\frac{\delta}{c}\lt1.
\]

Therefore \(\mu_{\mathbb R}(D_c)\lt1\). This strict estimate needs finite
mass, preservation, the candidate interface, the rate premise, and
\(c\lt\delta\). It needs neither probability nor ergodicity.

On an ergodic probability space, however, the full branch would have real
mass one. The strict estimate excludes it, leaving

\[
\boxed{\mu(D_c)=0}.
\]

The order matters:

1. finite-measure ergodicity yields the almost-empty or almost-full
   dichotomy;
2. probability identifies the full branch numerically with mass one; and
3. the strict RMT-31 ratio selects the null branch.

Probability is not being used retroactively to prove almost-invariance.

## Walk through the boundary models

Boundary models are not decorative examples. Each removes one tempting
shortcut from the theorem narrative.

{{< reference-figure
  src="four-boundary-models.svg"
  alt="Four labeled boundary models separate the assumptions: a one-shot collapse is once-bad but has an empty asymptotic event; a two-point identity has an invariant half-mass event but is not ergodic; a one-point half-mass space is ergodic and full with mass below one but is not a probability space; and the zero process has no negative-slope deviation."
  caption="**Finding:** recurrence, ergodicity, and probability normalization close different loopholes. The one-shot model rejects a once-bad shortcut; the two-point identity rejects an invariance-only zero-one claim; the half-mass one-point model rejects selection from a subunit bound without probability; and the zero process checks strict negative thresholds. These are exact qualitative outcomes of the audited models, not frequencies from a simulation."
>}}

### Boundary 1: one bad block can disappear forever

On the two-point state space <code>Bool</code>, let the base map send both
points to <code>true</code> and use the Dirac measure at <code>true</code>.
The one-shot process is zero at <code>true</code>. At <code>false</code> it is
zero at short length and equals \(-1\) from length two onward.

At slope \(-2/5\), the RMT-31 once-bad event is exactly
\(\{\texttt{false}\}\): length two gives \(-1\lt-4/5\). But the normalized
value is \(-1/n\), which returns to zero. Beyond a sufficiently large cutoff
there is no witness below any fixed rational slope less than \(-2/5\).
Consequently the RMT-32 strict event is empty.

This model preserves its chosen measure and satisfies the integrable
subadditive candidate interface. It shows why one finite witness cannot be
relabelled as an asymptotic deviation.

### Boundary 1b: same-threshold recurrence can still miss strict deviation

The same checked one-shot process isolates rational slack at target zero. At
<code>false</code>, every length from two onward has centered value \(-1\), so
there are witnesses below the target line zero beyond every cutoff. The source
therefore proves

\[
A_0=\{\texttt{false}\}.
\]

But strict target membership requires some rational \(q\lt0\). For each such
fixed \(q\), the normalized values \(-1/n\) eventually rise above \(q\).
Hence

\[
D_0=\varnothing.
\]

This is the compiled counterpart of the approaching-target countersequence.
It is a set-semantic audit, not a positive-probability counterexample: under
the preserved Dirac measure at <code>true</code>, the point
<code>false</code> and the raw set \(A_0\) have measure zero.

### Boundary 2: invariant half mass is possible without ergodicity

Let \(T\) be the identity on <code>Bool</code> with equal mass on the two
points. Put

\[
X_n(\texttt{true})=0,
\qquad
X_n(\texttt{false})=-(n-1).
\]

The one-step observable is zero, so centering changes nothing. At
\(c=-3/4\), the normalized values at <code>false</code> approach \(-1\),
while those at <code>true</code> remain zero. A rational margin between
\(-1\) and \(-3/4\) works arbitrarily late at <code>false</code>. Hence

\[
D_{-3/4}=\{\texttt{false}\},
\qquad
\mu(D_{-3/4})=\frac12.
\]

The event is exactly invariant because the map is the identity. The system is
not ergodic, so invariant half-mass events are allowed. This separates
invariance from ergodic rigidity.

### Boundary 3: a subunit full event is possible without probability

Now use a one-point space with the measure
\(\frac12\delta_{()}\), the identity map, and the scalar process
\(X_n=-(n-1)\). The one-point system is ergodic, the strict event at
\(-3/4\) is the whole space, and

\[
\mu_{\mathbb R}(D_{-3/4})=\frac12\lt1.
\]

The checked numeric audit records

\[
\frac12\le\frac23\lt1.
\]

Thus the full event still obeys a strict subunit ceiling.

There is no contradiction: the total mass is \(1/2\), not one. This model
pinpoints why probability normalization is needed for null-branch selection,
even though finite-measure ergodicity already supplies the empty-or-full
dichotomy.

### Boundary 4: the zero process respects strict negative thresholds

For \(X_n=0\), the centered process is zero. If \(c\le0\), then every
rational \(q\lt c\) is negative, so \(qn\lt0\) at every positive length.
The required inequality \(0\lt qn\) is impossible. Therefore \(D_c\) is
empty at every nonpositive target.

This audit checks strictness, positivity of witness lengths, and the direction
of multiplication by a positive natural number.

### Boundary 5: an empty matrix index remains legal

The cocycle theorem works with the matrix index type <code>Empty</code>.
The proof never selects a coordinate or assumes a positive matrix dimension;
it consumes the already bundled log-positive norm process. This is an
interface boundary, not a claim that zero-dimensional matrices model a
physical random dynamical system.

### Boundary 6: approaching the target from below is rejected

The scalar sequence \(z_n=c-1/(n+1)\) is below \(c\) at every time but has no
durable margin below \(c\). It is the direct semantic audit for the rational
slack. Unlike the finite-state process models above, it is used to test the
event definition itself rather than the full candidate-and-measure interface.

## Specialize the architecture to matrix cocycles

Let \(C\) be a one-sided discrete matrix cocycle. Its process is

\[
X_n(\omega)=\log^+\lVert C(n,\omega)\rVert_\infty,
\]

where \(\log^+(x)=\max(\log x,0)\) and the norm is the induced infinity
operator norm. RMT-32 names both the fixed-margin arbitrarily-late event and
the rationally generated strict event for this process.

If <code>C.HasIntegrableGeneratorLogPlus</code>, the preceding RMT-30
canonization exposes the centered Fekete-offset lower bound

\[
\delta_C
{} :=
\gamma^+_\mu(C)-\int_\Omega X_1\,d\mu,
\]

where \(\gamma^+_\mu(C)\) is the
{{< refterm "integrated-log-positive-growth-rate" "integrated log-positive growth rate" >}}.
On an ergodic probability base, every \(c\lt\delta_C\) satisfies

\[
\mu\!\left(D_c^C\right)=0.
\]

The result concerns the centered **log-positive norm** process. It does not
construct a signed logarithmic growth rate, a Lyapunov exponent, or an
Oseledets splitting. It also does not prove pointwise convergence of the
normalized cocycle process.

## In Lean: seven bridges from cutoffs to the null branch

Base camp used two named states and exact rational numbers. The project source
works with arbitrary state types, real-valued integrable
shifted-subadditive candidates, and Mathlib measures. Read each bridge in four
layers: ordinary language, paper mathematics, exact Lean, and the tokens that
carry its assumptions.

### Bridge 1: expose every cutoff and its later witness

{{< lean-bridge
  human="A point belongs to the fixed-slope event exactly when every natural cutoff has a positive witness at or after that cutoff."
  math="\(\omega\in A_q\Longleftrightarrow\forall N\in\mathbb N,\ \exists n\in\mathbb N,\ N\le n\land0\lt n\land Y_n(\omega)\lt qn.\)"
  lean="mem_centeredArbitrarilyLateBadBlockSet_iff"
>}}

- <code>∀ N : ℕ</code> is the universal cutoff. It prevents one early witness
  from certifying an asymptotic event.
- <code>∃ n : ℕ</code> lets the witness depend on the requested cutoff.
- <code>N ≤ n</code> means *at or after*; <code>0 &lt; n</code> protects
  positive-time normalization.
- <code>centeredProcess T X n ω</code> is \(Y_n(\omega)\), not expectation
  centering.
- This membership theorem unfolds a definition. It needs no measurable space,
  measure, integrability, preservation, or ergodicity.
{{< /lean-bridge >}}

### Bridge 2: expose one durable rational margin

{{< lean-bridge
  human="A point belongs to the strict target event exactly when one rational slope below the target works beyond every cutoff."
  math="\(\omega\in D_c\Longleftrightarrow\exists q\in\mathbb Q,\ q\lt c\land\omega\in A_q.\)"
  lean="mem_centeredStrictLowerDeviationSet_iff"
>}}

- <code>q : ℚ</code> makes the outer event union countable.
- <code>(q : ℝ)</code> casts the rational threshold into the real-valued
  process inequality.
- The existential quantifier lies outside the cutoff quantifier. The proof may
  not choose a new \(q\) for each \(N\).
- <code>centeredStrictLowerDeviationSet_subset_allLength T X c</code> later
  forgets recurrence, keeps one positive witness, and embeds \(D_c\) into the
  RMT-31 once-bad event.
{{< /lean-bridge >}}

### Bridge 3: pull back a witness by relaxing its slope

{{< lean-bridge
  human="If q is strictly smaller than r, every shifted point with arbitrarily-late q-witnesses pulls back to a point with arbitrarily-late r-witnesses."
  math="\(q\lt r\Longrightarrow T^{-1}A_q\subseteq A_r.\)"
  lean="hX.preimage_centeredArbitrarilyLateBadBlockSet_subset_of_lt hqr"
>}}

- <code>hX : IsIntegrableSubadditiveProcessCandidate T μ X</code> is the public
  receiver. The proof body uses its centered shifted-subadditivity field.
- <code>hqr : q &lt; r</code> provides the positive gap that absorbs the added
  endpoint.
- <code>exists_nat_forall_mul_lt_mul_succ hqr</code> chooses a cutoff after
  which \(qn\lt r(n+1)\).
- <code>T ⁻¹' A</code> is a preimage: it contains \(\omega\) when
  \(T\omega\in A\).
- No measure operation occurs in this setwise theorem.
{{< /lean-bridge >}}

### Bridge 4: upgrade same-target inclusion to almost-invariance

{{< lean-bridge
  human="On a finite preserved measure space, the target event and its preimage agree outside a null set."
  math="\(T^{-1}D_c=^{\mu}_{\mathrm{ae}}D_c.\)"
  lean="hX.preimage_centeredStrictLowerDeviationSet_ae_eq hT c"
>}}

- <code>[IsFiniteMeasure μ]</code> prevents the uninformative comparison
  \(\infty=\infty\).
- <code>hT : MeasurePreserving T μ μ</code> makes the event and its preimage
  have equal measure.
- Rational density is already used by
  <code>preimage_centeredStrictLowerDeviationSet_subset</code> to recover the
  same target \(c\) after threshold relaxation.
- <code>=ᵐ[μ]</code> means membership agrees almost everywhere. It does not
  assert literal set equality; base camp has
  \(\varnothing\subsetneq\{a\}\).
{{< /lean-bridge >}}

### Bridge 5: let ergodicity create the fork

{{< lean-bridge
  human="A finite-measure ergodic system makes the almost-invariant target event almost empty or almost full."
  math="\(D_c=^{\mu}_{\mathrm{ae}}\varnothing\ \lor\ D_c=^{\mu}_{\mathrm{ae}}\Omega.\)"
  lean="hX.centeredStrictLowerDeviationSet_ae_empty_or_univ hT c"
>}}

- <code>hT : Ergodic T μ</code> bundles measure preservation and
  pre-ergodicity.
- <code>hT.quasiErgodic.ae_empty_or_univ₀</code> consumes null measurability
  plus almost-invariance.
- Probability normalization is absent here. On total mass \(m\), the full
  branch has mass \(m\), not automatically one.
- Under <code>[IsProbabilityMeasure μ]</code>, the companion theorem
  <code>measure_centeredStrictLowerDeviationSet_eq_zero_or_one</code> converts
  the fork into event measure \(0\) or \(1\).
{{< /lean-bridge >}}

### Bridge 6: use the strict ratio to select zero

{{< lean-bridge
  human="On an ergodic probability base, a uniform centered-integral floor delta and a target c below delta force the strict lower-deviation event to have measure zero."
  math="\(\bigl[\delta\le n^{-1}\!\int Y_n\,d\mu\ \forall n\gt0,\ c\lt\delta\bigr]\Longrightarrow\mu(D_c)=0.\)"
  lean="hX.measure_centeredStrictLowerDeviationSet_eq_zero hT δ c hδ hc"
>}}

- <code>hδ</code> has type
  <code>∀ n : ℕ, n ≠ 0 → δ ≤
  (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ)</code>.
- <code>hc : c &lt; δ</code>, together with the time-one identity, makes
  \(\delta/c\lt1\).
- <code>measureReal_centeredStrictLowerDeviationSet_lt_one</code> proves the
  strict subunit estimate without ergodicity or probability.
- The zero-or-one theorem supplies the only two probability branches; the
  strict estimate excludes one.
- Base camp instantiates the arithmetic with
  \(\delta=-1\), \(c=-5/4\), and \(\delta/c=4/5\).
{{< /lean-bridge >}}

### Bridge 7: specialize the event to log-positive cocycle growth

{{< lean-bridge
  human="Below the centered integrated log-positive Fekete offset, the cocycle's strict centered lower-deviation event is null on an ergodic probability base."
  math="\(c\lt\gamma_\mu^+(C)-\int X_1\,d\mu\Longrightarrow\mu(D_c^C)=0.\)"
  lean="hC.measure_centeredLogPlusStrictLowerDeviationSet_eq_zero hErg c hc"
>}}

- <code>hC : C.HasIntegrableGeneratorLogPlus</code> supplies the integrable
  shifted-subadditive log-positive norm process.
- <code>hErg : Ergodic C.base μ</code> refers to the original cocycle base.
- <code>C.integratedLogPlusGrowthRate hC</code> is the deterministic integrated
  Fekete rate.
- <code>C.integratedLogPlusNorm 1</code> is the one-step integral subtracted by
  orbit-majorant centering.
- Empty matrix dimension remains legal. This theorem still says nothing about
  a signed logarithm, a real liminf, or samplewise convergence.
{{< /lean-bridge >}}

### Try every public declaration in the repository

{{< repo-check >}}
The authoritative source is
[<code>formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveLowerDeviation.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveLowerDeviation.lean).
For a **full project check**, save this temporary query as
<code>formalization/NonlinearDynamics/SubadditiveLowerDeviationChecks.lean</code>:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.SubadditiveLowerDeviation

open MeasureTheory Set Filter Topology Function
open NonlinearDynamics.Random.RandomCocycles

-- The nineteen RMT-32 public declarations, in source order.
#check centeredArbitrarilyLateBadBlockSet
#check mem_centeredArbitrarilyLateBadBlockSet_iff
#check centeredStrictLowerDeviationSet
#check mem_centeredStrictLowerDeviationSet_iff
#check exists_nat_forall_mul_lt_mul_succ
#check centeredArbitrarilyLateBadBlockSet_subset_allLength
#check centeredStrictLowerDeviationSet_subset_allLength
#check IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredArbitrarilyLateBadBlockSet
#check IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredStrictLowerDeviationSet
#check IsIntegrableSubadditiveProcessCandidate.preimage_centeredArbitrarilyLateBadBlockSet_subset_of_lt
#check IsIntegrableSubadditiveProcessCandidate.preimage_centeredStrictLowerDeviationSet_subset
#check IsIntegrableSubadditiveProcessCandidate.preimage_centeredStrictLowerDeviationSet_ae_eq
#check IsIntegrableSubadditiveProcessCandidate.centeredStrictLowerDeviationSet_ae_empty_or_univ
#check IsIntegrableSubadditiveProcessCandidate.measure_centeredStrictLowerDeviationSet_eq_zero_or_one
#check IsIntegrableSubadditiveProcessCandidate.measureReal_centeredStrictLowerDeviationSet_lt_one
#check IsIntegrableSubadditiveProcessCandidate.measure_centeredStrictLowerDeviationSet_eq_zero
#check DiscreteMatrixCocycle.centeredLogPlusArbitrarilyLateBadBlockSet
#check DiscreteMatrixCocycle.centeredLogPlusStrictLowerDeviationSet
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measure_centeredLogPlusStrictLowerDeviationSet_eq_zero
~~~

Then type:

~~~sh
cd formalization
lake env lean NonlinearDynamics/SubadditiveLowerDeviationChecks.lean
~~~

Delete the temporary query file afterward. To compile the authoritative module
itself, type:

~~~sh
cd formalization
lake env lean NonlinearDynamics/Random/RandomCocycles/SubadditiveLowerDeviation.lean
~~~

These commands import the pinned project and Mathlib and may require
substantial disk space and memory.
{{< /repo-check >}}

## Type the finite witness and branch ledgers with Lean and `Std`

The next worksheet contains no Mathlib import. It computes the two-state
process, the fixed \(q=-3/2\) witnesses, the endpoint-relaxation arithmetic,
the strict preimage inclusion, the probability masses, the \(4/5\) branch
ceiling, and the transient no-slack boundary. It also checks shifted
subadditivity for every pair of horizons through twelve.

The finite Boolean search illustrates the formulas; it does not replace the
general quantified proofs or define a measure-theoretic liminf. Save this
exact text as
<code>/tmp/RationalSlackLowerDeviationTutorial.lean</code>:

~~~lean
import Std

namespace RationalSlackLowerDeviationTutorial

inductive Point where
  | a
  | b
  deriving Repr, DecidableEq, BEq

def points : List Point := [.a, .b]

def step : Point → Point
  | .a => .b
  | .b => .b

def iterate : Nat → Point → Point
  | 0, p => p
  | n + 1, p => iterate n (step p)

def weight : Point → Nat
  | .a => 2
  | .b => 1

def process (n : Nat) (p : Point) : Int :=
  -((weight p * (n - 1) : Nat) : Int)

def normalize (z : Int) (n : Nat) : Rat :=
  if n = 0 then 0 else (z : Rat) / (n : Rat)

def slope (n : Nat) (p : Point) : Rat :=
  normalize (process n p) n

def q : Rat := -3 / 2
def c : Rat := -5 / 4
def delta : Rat := -1

def strictBad (threshold : Rat) (n : Nat) (p : Point) : Bool :=
  decide (0 < n) &&
    decide ((process n p : Rat) < threshold * (n : Rat))

def badTimes (threshold : Rat) (p : Point) (horizon : Nat) : List Nat :=
  (List.range (horizon + 1)).filter fun n => strictBad threshold n p

def processRow (n : Nat) :=
  (n, process n .a, slope n .a, strictBad q n .a,
    process n .b, slope n .b, strictBad q n .b)

def recurringWitness (cutoff : Nat) : Nat := max cutoff 5

def recurringWitnessRow (cutoff : Nat) :=
  let n := recurringWitness cutoff
  (cutoff, n, process n .a, q * (n : Rat), strictBad q n .a)

def subadditiveThrough (bound : Nat) : Bool :=
  (List.range (bound + 1)).all fun m =>
    (List.range (bound + 1)).all fun n =>
      points.all fun p =>
        process (m + n) p ≤ process m p + process n (iterate m p)

def qShift : Rat := -4 / 5
def rShift : Rat := -31 / 40

def endpointLedger :=
  let n := 32
  (n, process n .b, qShift * (n : Rat), process (n + 1) .b,
    rShift * ((n + 1 : Nat) : Rat),
    decide (process (n + 1) .b ≤ process n .b),
    decide ((process n .b : Rat) < qShift * (n : Rat)),
    decide (qShift * (n : Rat) < rShift * ((n + 1 : Nat) : Rat)))

def nullEvent : List Point := [.a]
def fullEvent : List Point := points

def preimage (event : List Point) : List Point :=
  points.filter fun p => event.contains (step p)

def pointMass : Point → Rat
  | .a => 0
  | .b => 1

def eventMass (event : List Point) : Rat :=
  (event.map pointMass).sum

def transient (n : Nat) (p : Point) : Int :=
  if p == .a && decide (2 ≤ n) then -1 else 0

def transientSlope (n : Nat) (p : Point) : Rat :=
  normalize (transient n p) n

def transientBad (threshold : Rat) (n : Nat) (p : Point) : Bool :=
  decide (0 < n) &&
    decide ((transient n p : Rat) < threshold * (n : Rat))

def transientBadTimes
    (threshold : Rat) (p : Point) (horizon : Nat) : List Nat :=
  (List.range (horizon + 1)).filter fun n => transientBad threshold n p

def transientRow (n : Nat) :=
  (n, transient n .a, transientSlope n .a,
    transientBad 0 n .a, transientBad (-1 / 10) n .a)

#eval (List.range 8).map fun k => processRow (k + 1)
#eval [0, 1, 4, 5, 10, 100].map recurringWitnessRow
#eval endpointLedger
#eval (nullEvent, preimage nullEvent,
  eventMass nullEvent, eventMass (preimage nullEvent))
#eval (delta, c, delta / c, decide (delta / c < 1),
  eventMass nullEvent, eventMass fullEvent)
#eval transientBadTimes (-2 / 5) .a 12
#eval [2, 3, 5, 9, 10, 20].map transientRow
#eval subadditiveThrough 12

example : q < c := by native_decide
example : badTimes q .a 8 = [5, 6, 7, 8] := by native_decide
example : badTimes q .b 20 = [] := by native_decide
example : preimage nullEvent = [] := by native_decide
example : eventMass nullEvent = 0 := by native_decide
example : delta / c = 4 / 5 := by native_decide
example : transientBadTimes (-2 / 5) .a 12 = [2] := by native_decide
example : subadditiveThrough 12 = true := by native_decide

end RationalSlackLowerDeviationTutorial
~~~

From any directory, type:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean \
  /tmp/RationalSlackLowerDeviationTutorial.lean
~~~

The byte-for-byte standard output emitted by Lean is:

~~~text
[(1, 0, 0, false, 0, 0, false),
 (2, -2, -1, false, -1, (-1 : Rat)/2, false),
 (3, -4, (-4 : Rat)/3, false, -2, (-2 : Rat)/3, false),
 (4, -6, (-3 : Rat)/2, false, -3, (-3 : Rat)/4, false),
 (5, -8, (-8 : Rat)/5, true, -4, (-4 : Rat)/5, false),
 (6, -10, (-5 : Rat)/3, true, -5, (-5 : Rat)/6, false),
 (7, -12, (-12 : Rat)/7, true, -6, (-6 : Rat)/7, false),
 (8, -14, (-7 : Rat)/4, true, -7, (-7 : Rat)/8, false)]
[(0, 5, -8, (-15 : Rat)/2, true),
 (1, 5, -8, (-15 : Rat)/2, true),
 (4, 5, -8, (-15 : Rat)/2, true),
 (5, 5, -8, (-15 : Rat)/2, true),
 (10, 10, -18, -15, true),
 (100, 100, -198, -150, true)]
(32, -31, (-128 : Rat)/5, -32, (-1023 : Rat)/40, true, true, true)
([RationalSlackLowerDeviationTutorial.Point.a], [], 0, 0)
(-1, (-5 : Rat)/4, (4 : Rat)/5, true, 0, 1)
[2]
[(2, -1, (-1 : Rat)/2, true, true),
 (3, -1, (-1 : Rat)/3, true, true),
 (5, -1, (-1 : Rat)/5, true, true),
 (9, -1, (-1 : Rat)/9, true, true),
 (10, -1, (-1 : Rat)/10, true, false),
 (20, -1, (-1 : Rat)/20, true, false)]
true
~~~

The first ledger has columns
\((n,X_n(a),X_n(a)/n,\text{bad at }a,X_n(b),X_n(b)/n,\text{bad at }b)\).
The second turns six requested cutoffs into explicit witnesses. The three
Boolean values in the endpoint row check

\[
X_{33}(b)\le X_{32}(b)\lt q\cdot32\lt r\cdot33.
\]

The next tuple computes \(D_c=\{a\}\), \(T^{-1}D_c=\varnothing\), and the two
zero masses. The branch tuple records
\((\delta,c,\delta/c,\delta/c\lt1,\mu(D_c),\mu(\Omega))\).
The singleton list `[2]` is the transient once-bad witness, while the final
ledger shows same-target recurrence and the fixed \(-1/10\) margin expiring at
equality when \(n=10\). The last `true` is the bounded exhaustive
subadditivity check.

**Standalone tutorial, suitable for a normal macOS or Linux machine.** It
imports only <code>Std</code> and never opens the project's Mathlib dependency
graph. This exact file and output were checked with the pinned Lean 4.32.0
toolchain. The exact project module uses the full project commands above.

## Complete source-order declaration, helper, probe, and axiom map

The authoritative source is 668 lines and has SHA-256
<code>1bdcfd6b3be654f52bae22bdb2b44c15848e66d51f3a0973ce1c8aba61db14d4</code>.
It contains nineteen public declarations, twenty-one private support items,
six anonymous compiled probes, and ten axiom queries. The complete sequence is:

| No. | Visibility | Source item | Exact role |
|---:|---|---|---|
| 1 | public | <code>centeredArbitrarilyLateBadBlockSet</code> | Defines \(A_q\) as a cutoff intersection of positive-witness unions |
| 2 | public | <code>mem_centeredArbitrarilyLateBadBlockSet_iff</code> | Exposes the exact \(\forall N\exists n\) membership statement |
| 3 | public | <code>centeredStrictLowerDeviationSet</code> | Defines \(D_c\) by a rational union below \(c\) |
| 4 | public | <code>mem_centeredStrictLowerDeviationSet_iff</code> | Exposes one durable rational margin |
| 5 | public | <code>exists_nat_forall_mul_lt_mul_succ</code> | Absorbs the one-step endpoint beyond a finite cutoff |
| 6 | public | <code>centeredArbitrarilyLateBadBlockSet_subset_allLength</code> | Forgets recurrence and retains one witness at \(q\) |
| 7 | public | <code>centeredStrictLowerDeviationSet_subset_allLength</code> | Embeds \(D_c\) in the RMT-31 once-bad event at \(c\) |
| 8 | public | <code>IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredArbitrarilyLateBadBlockSet</code> | Builds null measurability for \(A_q\) |
| 9 | public | <code>IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredStrictLowerDeviationSet</code> | Takes the countable rational union |
| 10 | public | <code>IsIntegrableSubadditiveProcessCandidate.preimage_centeredArbitrarilyLateBadBlockSet_subset_of_lt</code> | Proves \(T^{-1}A_q\subseteq A_r\) when \(q\lt r\) |
| 11 | public | <code>IsIntegrableSubadditiveProcessCandidate.preimage_centeredStrictLowerDeviationSet_subset</code> | Uses rational density to recover \(T^{-1}D_c\subseteq D_c\) |
| 12 | public | <code>IsIntegrableSubadditiveProcessCandidate.preimage_centeredStrictLowerDeviationSet_ae_eq</code> | Upgrades inclusion to almost-invariance under finite preserved mass |
| 13 | public | <code>IsIntegrableSubadditiveProcessCandidate.centeredStrictLowerDeviationSet_ae_empty_or_univ</code> | Gives the finite-measure ergodic fork |
| 14 | public | <code>IsIntegrableSubadditiveProcessCandidate.measure_centeredStrictLowerDeviationSet_eq_zero_or_one</code> | Converts the fork to probability mass zero or one |
| 15 | public | <code>IsIntegrableSubadditiveProcessCandidate.measureReal_centeredStrictLowerDeviationSet_lt_one</code> | Imports the strict RMT-31 real-mass ratio |
| 16 | public | <code>IsIntegrableSubadditiveProcessCandidate.measure_centeredStrictLowerDeviationSet_eq_zero</code> | Selects the null branch |
| 17 | public | <code>DiscreteMatrixCocycle.centeredLogPlusArbitrarilyLateBadBlockSet</code> | Names the cocycle fixed-margin event |
| 18 | public | <code>DiscreteMatrixCocycle.centeredLogPlusStrictLowerDeviationSet</code> | Names the cocycle target event |
| 19 | public | <code>DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measure_centeredLogPlusStrictLowerDeviationSet_eq_zero</code> | Specializes null selection through the centered Fekete offset |
| 20 | private | <code>rmt32ZeroProcess</code> | Defines the zero-process strictness boundary |
| 21 | private | <code>rmt32Collapse</code> | Sends both Boolean states to `true` |
| 22 | private | <code>rmt32OneShotProcess</code> | Defines the transient value \(-1\) after horizon two at `false` |
| 23 | private | <code>rmt32_iterate_collapse_true</code> | Computes every iterate from `true` |
| 24 | private | <code>rmt32_iterate_collapse_of_ne_zero</code> | Computes every positive iterate from either Boolean state |
| 25 | private | <code>rmt32OneShotProcess_candidate</code> | Packages the transient process as an integrable subadditive candidate |
| 26 | private | <code>rmt32Collapse_preserving</code> | Proves preservation of the Dirac mass at `true` |
| 27 | private | <code>rmt32OneShotProcess_centered_lower_bound</code> | Proves \(-1\le Y_n(\omega)\) for every centered transient value |
| 28 | private | <code>rmt32OneShotProcess_not_mem_arbitrarilyLate_of_neg</code> | Rejects every fixed negative margin |
| 29 | probe | zero-process/nonpositive-target example | Proves \(D_c=\varnothing\) for \(c\le0\) |
| 30 | probe | one-shot/once-bad example | Gets once-bad singleton but strict event empty at \(-2/5\) |
| 31 | probe | same-target/no-slack example | Gets \(A_0=\{\texttt{false}\}\) but \(D_0=\varnothing\) |
| 32 | private | <code>rmt32TwoPointProbability</code> | Defines the uniform Boolean probability measure |
| 33 | private | probability instance | Proves the Boolean measure has total mass one |
| 34 | private | <code>rmt32Id_not_preErgodic</code> | Proves the two-point identity is not pre-ergodic |
| 35 | private | <code>rmt32TwoPointProcess</code> | Defines slopes \(0\) and \(-(n-1)\) on the identity base |
| 36 | private | <code>rmt32TwoPointProcess_candidate</code> | Packages the two-point process |
| 37 | private | <code>rmt32TwoPointStrictLowerDeviationSet</code> | Computes \(D_{-3/4}=\{\texttt{false}\}\) |
| 38 | probe | nonergodic half-mass example | Computes strict-event probability \(1/2\) |
| 39 | private | <code>rmt32HalfUnitMeasure</code> | Defines the half-mass measure on one point |
| 40 | private | finite-measure instance | Proves the half-mass measure is finite |
| 41 | private | <code>rmt32IdHalfUnit_ergodic</code> | Proves identity is ergodic on the one-point carrier |
| 42 | private | <code>rmt32UnitProcess</code> | Defines the one-point process \(-(n-1)\) |
| 43 | private | <code>rmt32UnitProcess_candidate</code> | Packages the one-point process |
| 44 | private | <code>rmt32UnitStrictLowerDeviationSet</code> | Computes \(D_{-3/4}=\Omega\) |
| 45 | probe | nonprobability full-event example | Computes mass \(1/2\le2/3\lt1\) for the full event |
| 46 | probe | empty-index cocycle example | Rechecks the endpoint at matrix index type `Empty` |
| 47 | axiom query | item 2 | Audits fixed-slope membership |
| 48 | axiom query | item 4 | Audits rational target membership |
| 49 | axiom query | item 5 | Audits the endpoint arithmetic cutoff |
| 50 | axiom query | item 7 | Audits the target-to-once-bad inclusion |
| 51 | axiom query | item 9 | Audits strict-event null measurability |
| 52 | axiom query | item 11 | Audits same-target preimage inclusion |
| 53 | axiom query | item 12 | Audits finite-measure almost-invariance |
| 54 | axiom query | item 13 | Audits the ergodic fork |
| 55 | axiom query | item 16 | Audits null-branch selection |
| 56 | axiom query | item 19 | Audits the cocycle specialization |

The module prints the axiom dependencies of the ten declarations in items
47 through 56. The checked build uses the standard classical and quotient
principles already used by Mathlib, with no <code>sorry</code>,
<code>admit</code>, or project-local axiom.

## Keep an exact assumption ledger

| Layer | Public assumptions | What the proof obtains | Still absent |
|---|---|---|---|
| Event definitions | Map, process, real target | Countably described sets | Measure, regularity, subadditivity |
| Membership | Definitions only | Readable witness quantifiers | Any analytic conclusion |
| Endpoint arithmetic | Real \(q\lt r\) | One eventual natural cutoff | Dynamics and measure |
| Set inclusions | Definitions; candidate receiver for shift transport | Asymptotic-to-once-bad and one-sided preimage inclusions | Setwise invariance |
| Regularity | Integrable candidate, measure preservation | Null measurability of \(A_q\) and \(D_c\) | Finite mass, probability, ergodicity |
| Almost-invariance | Previous layer, finite total mass | \(T^{-1}D_c=^{\mu}_{\mathrm{ae}}D_c\) | Literal set equality, probability |
| Ergodic rigidity | Previous layer, finite-measure ergodicity | Almost empty or almost full | Choice of branch, probability |
| Numerical fork | Ergodic probability measure | Event measure zero or one | Null-branch selection |
| Strict estimate | Finite measure, preservation, candidate, rate lower bound, \(c\lt\delta\) | Real event mass below one | Ergodicity, probability |
| Null selection | Ergodic probability measure plus the rate hypotheses | Extended event measure zero | Real-liminf equivalence, convergence |
| Cocycle endpoint | Finite decidable matrix index, integrable log-positive generator, ergodic probability base, threshold below centered Fekete offset | Null strict event | Nonempty index, signed logarithm, Lyapunov theory |

Two qualifications deserve emphasis.

First, both public preimage-inclusion methods are stated on the bundled
integrable candidate even though their dynamical bodies project only the
shifted-subadditivity <code>add_le</code> field. The public receiver remains an
assumption of each theorem. Integrability first enters the argument when the
threshold sets must be proved null measurable.

Second, <code>Ergodic T μ</code> supplies preservation through its bundled
interface. The prose separates the jobs of preservation and ergodicity, but
the final theorem need not ask for preservation twice.

## Stop exactly at the RMT-32 boundary

RMT-32 proves that \(D_c\) is null under the centered rate hypotheses on an
ergodic probability base. It deliberately stops before translating that set
statement into the final asymptotic theorem.

{{< reference-figure
  src="rmt32-to-rmt33-handoff.svg"
  alt="The completed RMT-32 side ends with nullity of the rationally generated strict event. The now-completed guarded bridge in RMT-33 connects a lower-liminf exceptional set to that event, then combines the lower bound with the prior upper-limsup and additive Birkhoff results. Signed logarithms, Lyapunov exponents, and Oseledets splittings remain farther away."
  caption="**Finding:** RMT-32 completes event construction, almost-invariance, ergodic dichotomy, and null-branch selection. RMT-33 subsequently closes the guarded real-liminf bridge and final log-positive Kingman assembly with the existing upper-limsup and additive Birkhoff theorems. The farther topics are explicit nonclaims, not implied consequences of the arrow."
>}}

The subsequent milestone proves a guarded bridge of the following
mathematical kind. For positive-time normalized slopes, strict lower-limit
deviation below \(c\) produces one rational \(q\lt c\) with witnesses beyond
every cutoff, and conversely the rational event implies the matching strict
lower-limit statement when the real sequence has the required eventual lower
bound. The pinned Mathlib lower-limit API makes those boundedness gates part of
the theorem rather than silent paper notation.

RMT-33 then combines:

1. the RMT-32 null lower-deviation events;
2. RMT-29's normalized upper-limsup estimate; and
3. the ergodic Birkhoff limit of the one-step orbit majorant.

RMT-32 does not prove full samplewise Kingman convergence,
\(L^1\) convergence, interchange of a limit and an integral, powered-map
ergodicity, signed logarithmic growth, a Lyapunov exponent, or an Oseledets
splitting.

The proof architecture is adapted to this repository. Steele's exposition
centers a subadditive process, obtains a one-sided shifted inequality, and
uses preservation in the almost-everywhere invariance step
([Steele 1989](#ref-rational-slack-steele)). The particular rationally
generated event \(D_c\), its Lean declaration surface, and the RMT-32/RMT-33
division are project constructions, not definitions attributed to Steele.
Kingman's original paper remains the primary source for the full subadditive
ergodic theorem that this sequence of milestones is rebuilding
([Kingman 1968](#ref-rational-slack-kingman)).

## Thirty-six solved exercises

### Exercise 1: unpack the fixed-margin event

What does \(\omega\in A_q\) say?

**Solution.** For every natural cutoff \(N\), there is a natural
\(n\ge N\) with \(n\gt0\) and \(Y_n(\omega)\lt qn\). The witness may depend
on \(N\), but the slope \(q\) is fixed.

### Exercise 2: compare arbitrarily late and eventually always

Does \(\omega\in A_q\) imply that every sufficiently large length is bad?

**Solution.** No. It only supplies at least one bad length beyond each cutoff.
Good lengths may occur between an unbounded subsequence of bad lengths.

### Exercise 3: recover a once-bad witness

Why does \(A_q\subseteq B_\infty(q)\)?

**Solution.** Apply the arbitrarily-late condition at cutoff zero. It returns
one positive \(n\) satisfying the strict inequality, which is exactly the
once-bad membership witness.

### Exercise 4: retain positive time

Why is \(0\lt n\) stated separately from \(N\le n\)?

**Solution.** The cutoff may be zero, so \(N\le n\) alone permits \(n=0\).
The slope interpretation and later division by \(n\) require positive time.

### Exercise 5: unpack the target event

What does \(\omega\in D_c\) add to fixed-margin membership?

**Solution.** It supplies one rational \(q\lt c\) such that
\(\omega\in A_q\). The rational choice is made once and survives all future
cutoffs.

### Exercise 6: reject drifting thresholds

May one choose a new \(q_N\lt c\) for every cutoff?

**Solution.** Not in \(D_c\). Such choices could approach \(c\) and encode no
uniform gap. The existential rational quantifier sits outside the universal
cutoff quantifier.

### Exercise 7: test the approaching-target sequence

For \(z_n=c-1/(n+1)\), why does the same-threshold condition hold?

**Solution.** The correction \(1/(n+1)\) is positive, so \(z_n\lt c\) for
every \(n\). In particular there is a witness beyond every cutoff at the
target \(c\).

### Exercise 8: show that no durable lower margin survives

Fix \(q\lt c\) in Exercise 7. Why are sufficiently late terms above \(q\)?

**Solution.** Let \(\varepsilon=c-q\gt0\). Eventually
\(1/(n+1)\lt\varepsilon\), so
\(z_n=c-1/(n+1)\gt c-\varepsilon=q\). Thus \(A_q\) fails.

### Exercise 9: use rational density

Suppose a real \(d\lt c\) is visited arbitrarily late by normalized slopes.
How can a rational margin record the gap?

**Solution.** Choose \(q\in\mathbb Q\) with \(d\lt q\lt c\). Every witness
with normalized slope at most \(d\) is strictly below \(q\), so the same
unbounded witness sequence certifies \(A_q\).

### Exercise 10: explain countability

Why not take the union over all real \(q\lt c\)?

**Solution.** Null-measurable sets are closed under countable unions, not
arbitrary uncountable unions. Rational density preserves every strict real
gap while keeping the outer union countable.

### Exercise 11: prove threshold monotonicity

If \(q\le r\), why is \(A_q\subseteq A_r\)?

**Solution.** Reuse every witness. Positive \(n\) gives \(qn\le rn\), so
\(Y_n\lt qn\le rn\).

### Exercise 12: embed the strict event into RMT-31

Why is \(D_c\subseteq B_\infty(c)\)?

**Solution.** Choose \(q\lt c\), then take a positive witness from \(A_q\)
at cutoff zero. Positivity gives \(qn\lt cn\), so the same length witnesses
membership in \(B_\infty(c)\).

### Exercise 13: rearrange the endpoint inequality

Show that \(qn\lt r(n+1)\) is equivalent to
\(-r\lt(r-q)n\).

**Solution.** Expand the right side as \(rn+r\), subtract \(qn\), and move
\(r\) to the other side. Both transformations preserve strict inequality
because they only add or subtract equal real quantities.

### Exercise 14: choose the arithmetic cutoff

Why does \(q\lt r\) provide a natural \(K\) that makes Exercise 13 true for
all \(n\ge K\)?

**Solution.** Since \(r-q\gt0\), it suffices that
\(n\gt(-r)/(r-q)\). The Archimedean property supplies a natural number above
that real bound, and every larger natural also works.

### Exercise 15: remove sign assumptions

Must \(q\) and \(r\) be negative in the arithmetic lemma?

**Solution.** No. Only \(r-q\gt0\) is used. The quotient
\((-r)/(r-q)\) and the Archimedean cutoff handle every sign of \(r\).

### Exercise 16: derive the centered one-step inequality

Which split of shifted subadditivity gives
\(Y_{n+1}(\omega)\le Y_n(T\omega)\)?

**Solution.** Use the split \(1+n\):
\(Y_{1+n}(\omega)\le Y_n(T\omega)+Y_1(\omega)\). Centering gives
\(Y_1=0\), and \(1+n=n+1\).

### Exercise 17: orient the preimage correctly

What does \(\omega\in T^{-1}A_q\) mean?

**Solution.** It means \(T\omega\in A_q\). The proof begins with later
witnesses at the shifted state and pulls them back to blocks one unit longer
at \(\omega\).

### Exercise 18: satisfy two cutoffs at once

Why request the shifted witness beyond \(\max(N,K)\)?

**Solution.** The witness must be beyond the user's requested cutoff \(N\)
and beyond the arithmetic cutoff \(K\). The maximum enforces both inequalities
with one natural number.

### Exercise 19: explain threshold relaxation

Why does the proof conclude \(T^{-1}A_q\subseteq A_r\) rather than
\(T^{-1}A_q\subseteq A_q\)?

**Solution.** Pulling a witness back changes its length from \(n\) to
\(n+1\). For negative \(q\), the comparison \(qn\lt q(n+1)\) is false. A
strictly larger \(r\) supplies the margin that absorbs the endpoint.

### Exercise 20: close the target event

How does rational density turn relaxed fixed-slope inclusions into
\(T^{-1}D_c\subseteq D_c\)?

**Solution.** Start with a rational \(q\lt c\) witnessing shifted membership.
Choose rational \(r\) with \(q\lt r\lt c\). Transport from \(A_q\) to
\(A_r\), which is still one of the events in the union defining \(D_c\).

### Exercise 21: build fixed-margin regularity

Which set operations appear in \(A_q\)?

**Solution.** There is a countable intersection over cutoffs and countable
unions over witness lengths and their logical guards. Each terminal strict
threshold set is null measurable, so Mathlib's countable closure theorems
assemble the result.

### Exercise 22: keep the regularity claim narrow

Does the theorem prove that \(A_q\) and \(D_c\) are ordinary measurable sets?

**Solution.** Not in the chosen representative-level interface. It proves
null measurability, which permits disagreement with a measurable set on a
null subset.

### Exercise 23: locate finite mass in regularity

Is finite total mass needed to prove null measurability?

**Solution.** No. Countable closure and almost-everywhere measurability of the
centered process values do not require \(\mu(\Omega)\lt\infty\).

### Exercise 24: turn preservation into equal event mass

Once \(D_c\) is null measurable, what does measure preservation give?

**Solution.** It gives
\(\mu(T^{-1}D_c)=\mu(D_c)\). This is equality of extended nonnegative real
numbers, not yet equality of sets.

### Exercise 25: locate finite mass in almost-invariance

Why is finite mass needed after Exercise 24?

**Solution.** With \(T^{-1}D_c\subseteq D_c\), equal finite measures force
the difference to be null. If both measures were infinite, equality would not
exclude a positive or infinite remainder.

### Exercise 26: distinguish almost and literal invariance

What exactly does the theorem conclude?

**Solution.** It concludes that the indicator memberships of
\(T^{-1}D_c\) and \(D_c\) agree almost everywhere. The underlying sets may
differ on a null set.

### Exercise 27: state the finite-measure ergodic fork

What does ergodicity add after almost-invariance?

**Solution.** It forces \(D_c\) to be almost equal either to the empty set or
to the whole space. Probability normalization is not required for this
set-level dichotomy.

### Exercise 28: convert the fork under probability

Why does a probability measure turn the alternatives into zero and one?

**Solution.** Almost equality preserves measure. The empty set has measure
zero and the whole space has total measure one under
<code>IsProbabilityMeasure</code>.

### Exercise 29: force the sign of the rate

Why does the uniform rate premise imply \(\delta\le0\)?

**Solution.** Evaluate it at \(n=1\). Since \(Y_1=0\), the normalized
integral is zero, so the premise reads \(\delta\le0\).

### Exercise 30: force the sign of the target

Why is \(c\lt0\)?

**Solution.** The hypothesis gives \(c\lt\delta\), and Exercise 29 gives
\(\delta\le0\). Transitivity yields \(c\lt0\).

### Exercise 31: obtain the strict ratio

Why does \(c\lt\delta\) imply \(\delta/c\lt1\) when \(c\lt0\)?

**Solution.** Multiplication by the negative denominator reverses the
inequality. The statement \(\delta/c\lt1\) is equivalent to
\(c\lt\delta\), exactly the assumed strict ordering.

### Exercise 32: separate the strict estimate from ergodicity

Does \(\mu_{\mathbb R}(D_c)\lt1\) require ergodicity?

**Solution.** No. It follows from inclusion into the RMT-31 once-bad event and
the finite-measure ratio. Ergodicity enters only when converting
almost-invariance into an empty-or-full fork.

### Exercise 33: diagnose the nonergodic two-point model

Why can the invariant event \(\{\texttt{false}\}\) have mass \(1/2\)?

**Solution.** The identity map preserves every subset, but the equal two-point
system is not ergodic. Invariance alone imposes no zero-one law.

### Exercise 34: diagnose the half-mass one-point model

Why does a full event of real mass \(1/2\lt1\) not contradict the strict
estimate?

**Solution.** The whole space itself has mass \(1/2\). Without probability
normalization, “full” does not mean mass one, so a subunit estimate cannot
exclude that branch.

### Exercise 35: reject the one-shot shortcut

Why is the collapse-model point once-bad at \(-2/5\) but absent from the
strict event?

**Solution.** Length two gives the strict finite witness, but later normalized
values equal \(-1/n\) and approach zero. No fixed rational slope below
\(-2/5\) receives witnesses beyond every cutoff.

### Exercise 36: name the next proof obligation

What remains before a lower-liminf theorem can use RMT-32?

**Solution.** RMT-33 proves the guarded implication and equivalence bridges
between strict lower-limit deviation and the rationally generated event using
the pinned Mathlib filter and lower-limit APIs. It then combines the null event
with the existing upper-limsup and additive Birkhoff results. RMT-32 itself
proves neither step.

## Full project check

After installing the repository's pinned dependencies, run this from the
repository root:

~~~sh
cd formalization
lake env lean NonlinearDynamics/Random/RandomCocycles/SubadditiveLowerDeviation.lean
~~~

This command may compile substantial parts of the pinned Mathlib graph and
therefore may require substantial disk space and memory. The Standalone
tutorial above remains the lighter route for following the finite arithmetic
interactively.
The paired
[Development Notebook]({{< relref "/development-notebook/2026/07/countably-generated-centered-lower-deviation-events-in-lean" >}})
contains the source-order proof ledger, compiled boundary inventory, and axiom
reports.

## Continue the learning path

[From Finite Centered Bad-Block Bounds to All-Positive-Length Control]({{< relref "/knowledge-base/deep-dives/from-finite-centered-bad-block-bounds-to-all-positive-length-control" >}})
explains the RMT-31 once-bad union and finite-target measure projection.

[Finite Bad-Block Measure Bounds Before Kingman Lower Liminf]({{< relref "/knowledge-base/deep-dives/finite-bad-block-measure-bounds-before-kingman-lower-liminf" >}})
derives the finite-cap ratio that selects the RMT-32 null branch.

[Subadditive Upper-Limsup Bounds Before Kingman Convergence]({{< relref "/knowledge-base/deep-dives/subadditive-upper-limsup-bounds-before-kingman-convergence" >}})
develops the upper half later combined with this event architecture. Continue
to [The Guarded Real-Liminf Bridge to Log-Positive Kingman Convergence]({{< relref "/knowledge-base/deep-dives/guarded-real-liminf-bridge-to-log-positive-kingman-convergence" >}})
for that completed assembly.

{{< refterm "ergodicity" "Ergodicity" >}} reviews invariant-event rigidity,
and {{< refterm "ergodic-probability-base" "ergodic probability base" >}}
separates preservation, total-mass normalization, and ergodicity.

## References

The library links below target Mathlib 4.32.0 at pinned commit
<code>81a5d257c8e410db227a6665ed08f64fea08e997</code>.

<a id="ref-rational-slack-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://academic.oup.com/jrsssb/article/30/3/499/7026968),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968,
[doi:10.1111/j.2517-6161.1968.tb00749.x](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x).
This is the version-of-record page for the full subadditive ergodic theorem;
RMT-32 proves only its countable lower-deviation event layer.

<a id="ref-rational-slack-steele"></a>**J. Michael Steele.**
[Kingman's subadditive ergodic theorem](https://www.numdam.org/item/AIHPB_1989__25_1_93_0/),
*Annales de l'Institut Henri Poincare, Probabilites et Statistiques* 25(1),
93-98, 1989. The
[archival PDF](https://www.numdam.org/item/AIHPB_1989__25_1_93_0.pdf)
shows the centered-process and one-sided-shift architecture on page 94. The
rational event in this chapter is a repository adaptation, not a
source-defined object.

<a id="ref-rational-slack-mathlib-countable"></a>**Mathlib contributors.**
[Countable unions and intersections of null-measurable sets](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/NullMeasurable.lean#L132-L148),
Mathlib 4.32.0. These closures assemble \(A_q\) and \(D_c\).

<a id="ref-rational-slack-mathlib-threshold"></a>**Mathlib contributors.**
[Null measurability of strict order events for almost-everywhere measurable functions](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Constructions/BorelSpace/Order.lean#L254-L257),
Mathlib 4.32.0. RMT-32 applies this to a centered process value and a constant
threshold.

<a id="ref-rational-slack-mathlib-archimedean"></a>**Mathlib contributors.**
[A natural number above any Archimedean value](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Algebra/Order/Archimedean/Defs.lean#L72-L78),
Mathlib 4.32.0. This theorem supplies the endpoint-absorption cutoff.

<a id="ref-rational-slack-mathlib-rational"></a>**Mathlib contributors.**
[A rational number strictly between two real numbers](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Algebra/Order/Archimedean/Basic.lean#L372-L376),
Mathlib 4.32.0. This density step restores the target event after threshold
relaxation.

<a id="ref-rational-slack-mathlib-preserving"></a>**Mathlib contributors.**
[Measure of a null-measurable preimage under a measure-preserving map](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/MeasurePreserving.lean#L143-L147),
Mathlib 4.32.0. It equates the masses of \(D_c\) and its preimage.

<a id="ref-rational-slack-mathlib-ae-equality"></a>**Mathlib contributors.**
[Almost-everywhere equality from inclusion and reverse measure comparison](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/MeasureSpace.lean#L360-L372),
Mathlib 4.32.0. The finite-target premise is the exact almost-invariance gate.

<a id="ref-rational-slack-mathlib-ergodic"></a>**Mathlib contributors.**
[Almost-empty or almost-full rigidity for a null-measurable almost-invariant set](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Ergodic.lean#L128-L140),
Mathlib 4.32.0. RMT-32 applies the quasi-ergodic form after proving
almost-invariance.

<a id="ref-rational-slack-mathlib-real-mono"></a>**Mathlib contributors.**
[Monotonicity of real-valued measure under a finite target](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/Real.lean#L88-L93),
Mathlib 4.32.0. It transfers the RMT-31 ceiling along
\(D_c\subseteq B_\infty(c)\).

<a id="ref-rational-slack-mathlib-negative-division"></a>**Mathlib contributors.**
[Division below one with a negative denominator](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Algebra/Order/Field/Basic.lean#L468-L473),
Mathlib 4.32.0. It turns \(c\lt\delta\) and \(c\lt0\) into the strict ratio
\(\delta/c\lt1\).
