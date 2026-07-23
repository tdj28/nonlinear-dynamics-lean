---
title: "Birkhoff Convergence Events Before the Pointwise Ergodic Theorem"
slug: "birkhoff-convergence-events-before-the-pointwise-ergodic-theorem"
date: 2026-07-21
summary: "Start with a two-state orbit whose averages converge to one and a bounded deterministic orbit whose averages oscillate, then climb through finite measurability, prefix invariance, convergence events, and conditional ergodic zero-one laws in Lean."
lead: "The swap a to b to a with readings zero and two has averages that converge to one from both starts. A separate zero-one observable on successively longer decimal blocks has endpoint averages tending along two subsequences to ten elevenths and one eleventh, so it does not converge. Those exact models keep the logical roles separate while the chapter builds measurable convergence events, deletes one finite prefix in both directions, and derives conditional null-or-conull and probability zero-one consequences without claiming that rigidity alone gives full measure."
draft: false
pro_reviewed: false
level: "Measure theory, filters and limits, finite orbit sums, quasi-measure-preserving dynamics, pre-ergodicity, quasi-ergodicity, and integrable subadditive-process interfaces"
reading_time: "160 to 220 minutes, including the runnable Lean worksheet"
prerequisites: "Finite sums, function iteration, real limits, measurable functions and sets, null sets, almost-everywhere equality, measure-preserving maps, and the definition of ergodicity; no pointwise ergodic theorem is assumed"
lean_module: "NonlinearDynamics.Random.RandomCocycles.BirkhoffConvergence"
toc: true
og_image: "birkhoff-convergence-events-before-the-pointwise-ergodic-theorem-card.png"
og_image_alt: "Warm-paper Deep Dive card comparing a two-state swap whose averages converge to one with a bounded decimal-block shift whose endpoint averages have subsequential limits ten elevenths and one eleventh. A bottom strip says exact prefix invariance gives a conditional null-or-conull fork and a membership theorem chooses the branch."
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
Lean declaration map, figures, sources, and accessibility have not yet passed
the required human and Pro reviews. The page is publicly available as an open
working note while those reviews remain pending.
{{< /panel >}}

## Base camp: a two-state average you can finish by hand

Let the state space be \(\Omega=\{a,b\}\). One deterministic update swaps the
states:

\[
T(a)=b,\qquad T(b)=a.
\]

An **observable** is a function that assigns a reading to each state. Take

\[
g(a)=0,\qquad g(b)=2.
\]

Starting at \(a\), the readings are \(0,2,0,2,\ldots\). Starting at \(b\),
they are \(2,0,2,0,\ldots\). Write \(S_n^g(x)\) for the sum of the first
\(n\) readings from \(x\), and \(A_n^g(x)=S_n^g(x)/n\) for \(n\gt0\). Lean's
totalized convention also sets \(A_0^g(x)=0\).

The first values are completely explicit:

| horizon \(n\) | \(0\) | \(1\) | \(2\) | \(3\) | \(4\) | \(5\) | \(6\) | \(7\) | \(8\) |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| \(A_n^g(a)\) | \(0\) | \(0\) | \(1\) | \(2/3\) | \(1\) | \(4/5\) | \(1\) | \(6/7\) | \(1\) |
| \(A_n^g(b)\) | \(0\) | \(2\) | \(1\) | \(4/3\) | \(1\) | \(6/5\) | \(1\) | \(8/7\) | \(1\) |

The table suggests a limit, but a finite table cannot prove one. The formulas
for every \(k\ge1\) do:

\[
\begin{aligned}
A_{2k}^g(a)&=A_{2k}^g(b)=1,\\
A_{2k+1}^g(a)&=\frac{2k}{2k+1}\longrightarrow1,\\
A_{2k+1}^g(b)&=\frac{2k+2}{2k+1}\longrightarrow1.
\end{aligned}
\]

Both possible starts therefore have convergent averages with limit \(1\).
The **convergence event** is the set of starting states whose full average
sequence tends to some finite real number. For this model, it is the whole
state space:

\[
E(T,g)=\{a,b\}=\Omega.
\]

That is a direct every-point calculation. It does not use ergodicity to
choose a branch of a dichotomy.

{{< reference-figure
  wide="true"
  src="two-state-birkhoff-ledger.svg"
  alt="On the two-state swap with readings zero and two, the totalized averages from a through horizon eight are zero, zero, one, two thirds, one, four fifths, one, six sevenths, one. From b they are zero, two, one, four thirds, one, six fifths, one, eight sevenths, one. A uniform-measure ledger shows finite sums and averages are measurable and integrable. Exact five-term prefix arithmetic removes and restores the first reading. Even averages equal one, and odd averages tend to one."
  caption="**Finding:** the exact formulas \(A_{2k}(a)=A_{2k}(b)=1\), \(A_{2k+1}(a)=2k/(2k+1)\), and \(A_{2k+1}(b)=(2k+2)/(2k+1)\) prove convergence to \(1\) from both starts. Under the uniform probability measure, every subset is measurable and every finite real-valued function is integrable; the displayed absolute integrals are \(0,1,2,3,4\) for the sums and \(0,1,1,1,1\) for the averages at horizons zero through four. The prefix equations are exact toy arithmetic, not sampled data or a general convergence theorem."
>}}

### A finite-horizon measurability and integrability ledger

Give \(\Omega\) its full power-set
{{< refterm "measurable-space" "measurable space" >}} and the uniform
{{< refterm "probability-measure" "probability measure" >}}
\(\mu(\{a\})=\mu(\{b\})=1/2\). Every subset is measurable, so every function
from this two-point space to \(\mathbb R\) is a
{{< refterm "measurable-function" "measurable function" >}}. Every such
function with finite values is also
{{< refterm "integrability" "integrable" >}}.

Here is the complete finite ledger through horizon four:

| \(n\) | \((S_n(a),S_n(b))\) | \((A_n(a),A_n(b))\) | \(\int |S_n|\,d\mu\) | \(\int |A_n|\,d\mu\) | measurable? | integrable? |
|---:|---:|---:|---:|---:|---:|---:|
| \(0\) | \((0,0)\) | \((0,0)\) | \(0\) | \(0\) | yes | yes |
| \(1\) | \((0,2)\) | \((0,2)\) | \(1\) | \(1\) | yes | yes |
| \(2\) | \((2,2)\) | \((1,1)\) | \(2\) | \(1\) | yes | yes |
| \(3\) | \((2,4)\) | \((2/3,4/3)\) | \(3\) | \(1\) | yes | yes |
| \(4\) | \((4,4)\) | \((1,1)\) | \(4\) | \(1\) | yes | yes |

The general Lean theorems mirror this elementary ledger. Measurability of
\(T\) and \(g\) makes every finite sum and average measurable. Measure
preservation plus integrability of \(g\) makes every finite sum and average
integrable. Those are finite-horizon statements; they do not yet discuss a
limit.

### Delete one reading, then restore it

The basic prefix identity is

\[
S_{n+1}^g(\omega)=g(\omega)+S_n^g(T\omega).
\]

For \(n=4\) and \(\omega=a\), every number is visible:

\[
S_5^g(a)=g(a)+S_4^g(Ta)=0+S_4^g(b)=0+4=4.
\]

Normalize and solve in either direction:

\[
\begin{aligned}
A_4^g(Ta)
&=\frac54A_5^g(a)-\frac{g(a)}4
=\frac54\frac45-0=1,\\
A_5^g(a)
&=\frac{g(a)}5+\frac45A_4^g(Ta)
=0+\frac45\cdot1=\frac45.
\end{aligned}
\]

The first line deletes the initial reading; the second restores it. For a
general fixed value \(g(\omega)\), its normalized contribution is divided by
a growing horizon and tends to zero. That is the mechanism behind the
same-limit theorem later in the chapter.

## A deterministic near miss: bounded readings need not settle

Now use a separate state space \(\Omega=\mathbb N\), the shift
\(T(k)=k+1\), and a bounded zero-one observable. Set \(g(0)=0\). For
\(m\ge0\), put

\[
g(k)=
\begin{cases}
1,&10^m\le k\lt10^{m+1}\text{ and }m\text{ is even},\\
0,&10^m\le k\lt10^{m+1}\text{ and }m\text{ is odd}.
\end{cases}
\]

Thus the values are \(1\) on \(1,\ldots,9\), \(0\) on \(10,\ldots,99\),
\(1\) on \(100,\ldots,999\), and so on. At the first four decimal endpoints:

| horizon \(N\) | number of ones below \(N\) | \(A_N^g(0)\) |
|---:|---:|---:|
| \(10\) | \(9\) | \(9/10=0.9\) |
| \(100\) | \(9\) | \(9/100=0.09\) |
| \(1000\) | \(909\) | \(909/1000=0.909\) |
| \(10000\) | \(909\) | \(909/10000=0.0909\) |

For \(r\ge0\), the number of ones below both \(10^{2r+1}\) and
\(10^{2r+2}\) is

\[
9\sum_{j=0}^{r}100^j=\frac{100^{r+1}-1}{11}.
\]

Dividing by the two different horizons gives

\[
A_{10^{2r+1}}^g(0)\longrightarrow\frac{10}{11},
\qquad
A_{10^{2r+2}}^g(0)\longrightarrow\frac{1}{11}.
\]

One sequence cannot converge to two distinct real limits. Hence
\(0\notin E(T,g)\). The readings are bounded; the failure comes from
successively longer blocks pulling the running mean into two different camps.
No measure has been introduced, so this example does not contradict a
pointwise ergodic theorem. It only proves that the event definition alone
cannot supply membership.

{{< reference-figure
  wide="true"
  src="decade-block-nonconvergence.svg"
  alt="For the natural-number shift, a bounded zero-one observable alternates on growing decimal blocks. The endpoint averages are nine tenths, nine hundredths, nine hundred nine thousandths, and nine hundred nine ten-thousandths. The odd decimal endpoint subsequence tends to ten elevenths, while the even decimal endpoint subsequence tends to one eleventh, so the average sequence does not converge."
  caption="**Finding:** the ones count below \(10^{2r+1}\) and \(10^{2r+2}\) is \((100^{r+1}-1)/11\). The two normalizations force distinct subsequential limits \(10/11\) and \(1/11\), so the start \(0\) is outside the convergence event. The block widths are drawn equally for readability and are explicitly not to scale. This is a designed deterministic teaching model, not empirical data and not the rising-observable boundary probe compiled in the project source."
>}}

## Why formalize the event before proving a pointwise theorem?

There is a seductive but invalid shortcut in ergodic formalization. Define the
set where the averages converge, prove that the set is invariant, invoke
ergodicity, and then speak as if convergence had been established almost
everywhere. Ergodicity does not justify that last step. It says an invariant
measurable event is trivial up to null sets. The trivial event may be the empty
one.

Random-matrix-theory milestone 22 (RMT-22) formalizes everything in that
sentence except the shortcut. It starts
with Mathlib's finite <code>birkhoffSum</code> and
<code>birkhoffAverage</code>, supplies their missing real measurability and
finite integrability lemmas, defines the convergence event, transports that
event across almost-everywhere representatives, proves a boundedness-free
finite-prefix equivalence, and derives conditional ergodic dichotomies. It
also compiles a divergent example, making it impossible to mistake the event
definition for an existence theorem.

The compact term page is
{{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}}.
The declaration-complete implementation narrative is
[Birkhoff Convergence Events and Ergodic Rigidity in Lean]({{< relref "/development-notebook/2026/07/birkhoff-convergence-events-and-ergodic-rigidity-in-lean" >}}).
The finite combinatorial predecessor is
[Finite Ordered Interval Packing for Nonpositive Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-ordered-interval-packing-for-nonpositive-subadditive-processes" >}}).

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| First encounter | [A two-state average](#base-camp-a-two-state-average-you-can-finish-by-hand) | Compute a convergent orbit and its finite measure ledger |
| Boundary route | [A deterministic near miss](#a-deterministic-near-miss-bounded-readings-need-not-settle) | Prove bounded deterministic nonconvergence from two subsequences |
| Finite route | [The object below every asymptotic theorem](#the-object-below-every-asymptotic-theorem) | Rebuild sums and totalized averages |
| Event route | [Convergence becomes a subset](#convergence-becomes-a-subset) | Understand membership without existence |
| Measure route | [Ordinary measurability gives a measurable event](#ordinary-measurability-gives-a-measurable-event) | Separate measurable from null measurable |
| Representative route | [An integrable observable is only measurable almost everywhere](#an-integrable-observable-is-only-measurable-almost-everywhere) | Follow the measurable representative safely |
| Shift route | [Delete one finite prefix without boundedness](#delete-one-finite-prefix-without-boundedness) | Prove the same-limit equivalence |
| Rigidity route | [Two ergodic routes, two precise receivers](#two-ergodic-routes-two-precise-receivers) | Distinguish pre-ergodic and quasi-ergodic paths |
| Lean translation route | [Seven Lean bridges](#in-lean-seven-bridges-from-the-ledger-to-conditional-rigidity) | Match spoken mathematics, notation, and exact project names |
| Hands-on route | [Run the worksheet](#type-both-ledgers-yourself-with-lean-and-std) | Execute the finite swap and decimal-block checks with only `Std` |
| Project route | [Thin wrappers should keep thin premises](#thin-wrappers-should-keep-thin-premises) | Read candidate and cocycle specializations |
| Lean route | [The complete thirty-seven-declaration ledger](#the-complete-thirty-seven-declaration-ledger) | Audit every public name |
| Source boundary route | [Models that test the API boundary](#models-that-test-the-api-boundary) | Test zero time, zero measure, and the compiled rising-observable divergence |
| Summit route | [The existence theorem RMT-22 leaves open](#the-existence-theorem-that-rmt-22-leaves-open) | Locate the exact analytic gap and the later project module that closes it |

### Learning objectives

By the summit, a reader should be able to:

1. define a finite Birkhoff sum and average with the correct zero-based range;
2. explain why Mathlib's time-zero average is totalized to zero;
3. prove finite measurability from measurable iterates and finite sums;
4. prove finite integrability from preservation and one-step integrability;
5. define the convergence event without asserting membership;
6. state why a real convergence event is measurable for a measurable sequence;
7. distinguish ordinary measurability, almost-everywhere measurability, and null measurability;
8. explain why integrability does not upgrade the supplied representative to ordinary measurability;
9. construct an ordinarily measurable representative with <code>AEMeasurable.mk</code>;
10. state where quasi-measure preservation enters representative transport;
11. explain the countable all-horizon intersection behind event congruence;
12. derive both positive-index finite-prefix identities;
13. prove convergence at \(\omega\) implies convergence at \(T\omega\) to the same limit;
14. prove the converse without assuming that \(T\) is invertible;
15. deduce exact preimage invariance of the event;
16. distinguish preimage invariance from image invariance;
17. explain why ordinary measurable rigidity needs only <code>PreErgodic</code>;
18. explain why the representative-safe path uses <code>QuasiErgodic</code>;
19. derive a probability zero-one corollary from an almost-everywhere dichotomy;
20. explain why zero-measure rigidity is formally valid and informationally vacuous;
21. interpret the candidate one-step event without assuming anything about \(X_0\);
22. interpret the matrix-cocycle wrapper without generator integrability;
23. explain why the empty matrix index needs no special exclusion;
24. reproduce the divergent successor-orbit example;
25. classify each of the thirty-seven public declarations by proof layer;
26. state the common axiom footprint of the high-level theorems;
27. distinguish event rigidity from convergence existence;
28. state what a pointwise ergodic theorem would add;
29. explain why this milestone does not complete Kingman's theorem;
30. identify the next analytic dependencies without overclaiming them;
31. derive the even and odd average formulas for the two-state swap;
32. prove decimal-block nonconvergence from the limits \(10/11\) and \(1/11\);
33. run the byte-identical standalone <code>Std</code> worksheet on a normal
    macOS or Linux machine; and
34. distinguish all thirty-seven public declarations from the imported helper
    APIs and twelve anonymous source probes.

## The common setup and notation ledger

Let:

- \(\Omega\) be a type equipped with a measurable space;
- \(\mu\) be a measure on \(\Omega\);
- \(T:\Omega\to\Omega\) be a discrete-time map;
- \(T^j\) be its \(j\)-fold iterate;
- \(g,h:\Omega\to\mathbb R\) be real observables;
- \(n\in\mathbb N\) be a finite horizon;
- \(\omega\in\Omega\) be a starting point; and
- \(A_n^g(\omega)\) denote the real Birkhoff average of \(g\) along the first
  \(n\) orbit positions of \(\omega\).

The almost-everywhere equality

\[
g=h\quad\mu\text{-almost everywhere}
\]

means that the set of points where the two functions differ has \(\mu\)-measure
zero. The notation \(E=F\) almost everywhere for sets means their membership
predicates agree outside a μ-null set. The
{{< refterm "almost-everywhere" "almost everywhere" >}} glossary entry gives
the foundational distinction from pointwise equality.

## The object below every asymptotic theorem

Mathlib [defines the finite Birkhoff sum](#ref-birkhoff-event-deep-basic) by

\[
S_n^g(\omega)
{} =
\sum_{\substack{j\in\mathbb N\\j\lt n}}
g\bigl(T^j\omega\bigr).
\]

The finite set <code>Finset.range n</code> contains
\(0,1,\ldots,n-1\). Thus \(S_0^g=0\), \(S_1^g(\omega)=g(\omega)\), and

\[
S_{n+1}^g(\omega)=S_n^g(\omega)+g(T^n\omega).
\]

The alternative successor law peels from the other end:

\[
S_{n+1}^g(\omega)=g(\omega)+S_n^g(T\omega).
\]

The [finite average](#ref-birkhoff-event-deep-average) is

\[
A_n^g(\omega)=n^{-1}S_n^g(\omega).
\]

Lean works in a division semiring where inversion is total. Consequently
\(0^{-1}=0\) and \(A_0^g=0\). This is a useful API convention: formulas have a
value at every natural horizon. It is not evidence about the value of a
different process \(X_0\), and it cannot turn a positive-time argument into a
time-zero theorem.

### Finite measurability

Assume \(T\) and \(g\) are measurable. The proof of
<code>measurable_birkhoffSum</code> follows the displayed sum literally:

1. <code>hT.iterate j</code> makes every finite iterate measurable;
2. <code>hg.comp</code> makes \(g\circ T^j\) measurable; and
3. <code>Finset.measurable_sum</code> closes the finite sum.

The average is a constant multiple of the sum, so
<code>measurable_birkhoffAverage</code> needs no new dynamics.
These theorems use neither \(\mu\) nor preservation.

### Finite integrability

Assume instead that \(T\) preserves \(\mu\) and \(g\) is integrable. Every iterate
\(T^j\) also preserves \(\mu\). Mathlib's
<code>MeasurePreserving.integrable_comp_of_integrable</code> therefore makes
\(g\circ T^j\) integrable. A finite sum of integrable functions is integrable,
and scalar multiplication gives the average theorem.

No finite-measure or probability typeclass is needed. Preservation, not
probability, is what moves integrability along the orbit.

{{< panel "info" >}}
**Finite does not mean assumption free.** A sum has finitely many terms, but
integrability of a composition still needs a reason. Measure preservation
supplies that reason here.
{{< /panel >}}

## Convergence becomes a subset

Define

\[
E(T,g)
{} =
\left\{\omega:\exists c\in\mathbb R,
A_n^g(\omega)\longrightarrow c\right\}.
\]

This definition packages a property of a whole sequence into a set. It has
three deliberate features.

First, the limit is existential. The event asks whether there is some finite
real limit, not whether the limit equals a chosen constant. Second, the target
is the real line. A sequence tending to positive infinity is outside the
event. Third, membership is pointwise. Measure theory enters only when one asks
whether the set is measurable or how large it is.

The simp theorem <code>mem_birkhoffConvergenceSet_iff</code> is definitionally
true, but its public name matters. It gives rewriting tools a stable boundary
and makes boundary probes readable.

The logical direction must remain visible:

\[
\text{define }E
\quad\not\Rightarrow\quad
\exists\omega,\ \omega\in E.
\]

A set-builder expression can define the set of solutions to an impossible
equation. Naming the set does not solve the equation.

## Ordinary measurability gives a measurable event

Suppose each map \(\omega\mapsto A_n^g(\omega)\) is measurable. The real line
is a completely metrizable second-countable space whose open sets are
measurable. Mathlib's
[<code>MeasureTheory.measurableSet_exists_tendsto</code>](#ref-birkhoff-event-deep-polish)
states that the set of
points where a measurable sequence converges to some target point is
measurable.

Applying it yields

\[
\operatorname{MeasurableSet}(E(T,g)).
\]

This theorem consumes only ordinary measurability of \(T\) and \(g\). It does
not consume a measure, so it cannot depend on probability, preservation,
integrability, or ergodicity.

The proof is topological as well as measurable. Convergence to some real can
be expressed through countably many accuracy and tail conditions. The
second-countability and complete-metrizability hypotheses are the library's
general route to making that description measurable. RMT-22 reuses the
general theorem instead of reconstructing a real-specific countable formula.

## An integrable observable is only measurable almost everywhere

The raw function stored in an <code>Integrable g μ</code> proof need not be
ordinarily measurable at every point. It is almost-everywhere strongly
measurable. Since the target is real, that gives almost-everywhere
measurability, but exceptional values remain possible.

The safe route begins one layer lower with

~~~lean
hg : AEMeasurable g μ
~~~

Mathlib's [representative API](#ref-birkhoff-event-deep-representative)
constructs <code>hg.mk g</code>, an ordinarily measurable function equal to
\(g\) almost everywhere. Call it \(\widetilde g\). The event
\(E(T,\widetilde g)\) is measurable by the preceding section. To transfer that
fact back to \(E(T,g)\), one must prove the two events agree almost everywhere.

### Why quasi-measure preservation appears

From \(g=\widetilde g\) almost everywhere, it does not follow for an arbitrary
map \(T\) that

\[
g(T^j\omega)=\widetilde g(T^j\omega)
\]

almost everywhere. The exceptional set is pulled back by \(T^j\). A
quasi-measure-preserving self-map sends null sets to null preimages, which is
exactly the property needed.

Mathlib already [proves fixed-horizon transport](#ref-birkhoff-event-deep-qmp):

\[
A_n^g=A_n^{\widetilde g}
\qquad\text{almost everywhere}
\]

for each \(n\). Event convergence depends on every \(n\), so RMT-22 takes the
countable intersection of these almost-everywhere facts with
<code>ae_all_iff</code>. Outside one null set, the two entire sequences agree
term by term. They therefore converge to exactly the same finite limits.

This gives

\[
E(T,g)=E(T,\widetilde g)
\qquad\text{almost everywhere}.
\]

The event for \(g\) is consequently null measurable. It agrees almost
everywhere with an ordinarily measurable event, but RMT-22 never claims the
raw representative's event is itself ordinarily measurable.

{{< reference-figure
  src="representative-transport-and-event-measurability.svg"
  alt="An almost-everywhere measurable observable is replaced by an ordinary measurable representative. Quasi-measure preservation transports equality through every finite orbit horizon. Countable all-horizon agreement then makes the two convergence events equal almost everywhere, so the raw event is null measurable."
  caption="**Finding:** the representative argument has four separate bridges. Almost-everywhere measurability supplies an ordinary representative; quasi-measure preservation protects null exceptions under orbit pullback; a countable all-horizon intersection upgrades fixed-horizon equality to equality of complete average sequences; and event congruence transfers null measurability back to the original observable. Integrability is only one sufficient source of almost-everywhere measurability."
>}}

### Three public interfaces, one proof core

RMT-22 exposes:

- <code>nullMeasurableSet_birkhoffConvergenceSet_of_aemeasurable</code>;
- <code>nullMeasurableSet_birkhoffConvergenceSet_of_aestronglyMeasurable</code>;
  and
- <code>nullMeasurableSet_birkhoffConvergenceSet_of_integrable</code>.

These are top-level theorem names, not declarations placed inside the
<code>Integrable</code> namespace as though they were upstream methods. The
suffix records the premise through which each corollary enters. The primary
mathematics lives in the almost-everywhere-measurable theorem.

## Delete one finite prefix without boundedness

The event is invariant because passing from \(\omega\) to \(T\omega\) deletes the
first orbit value. A finite prefix cannot affect convergence of normalized
averages, but formalizing that sentence requires exact coefficient control.

For every \(n\in\mathbb N\), RMT-22 proves

\[
A_{n+1}^g(T\omega)
{} =
\frac{n+2}{n+1}A_{n+2}^g(\omega)
-\frac{g(\omega)}{n+1}.
\]

If \(A_n^g(\omega)\to c\), then the shifted subsequence
\(A_{n+2}^g(\omega)\to c\). The first coefficient tends to one and the final
correction tends to zero. Hence \(A_n^g(T\omega)\to c\).

The converse identity is

\[
A_{n+2}^g(\omega)
{} =
\frac{g(\omega)}{n+2}
+\frac{n+1}{n+2}A_{n+1}^g(T\omega).
\]

If the shifted averages converge to \(c\), the correction again vanishes and
the coefficient again tends to one. Thus the original averages converge to
the same \(c\).

### Why the formulas start at positive indices

The denominators are \(n+1\) and \(n+2\), so they are nonzero. Writing the
identities directly at index \(n\) would force a separate positive-horizon
premise or invite a vacuous time-zero division. The successor form keeps the
useful theorem total in \(n\) while every displayed denominator remains
positive.

### Why no boundedness premise is needed

Mathlib already contains
[exact shifted-difference identities and boundedness-based convergence results](#ref-birkhoff-event-deep-normed)
under bounded-orbit or global boundedness hypotheses. RMT-22 does not
claim that no shift API existed upstream. Its contribution is the
boundedness-free same-limit equivalence obtained by solving the exact finite
identities in both directions and taking limits.

The proof uses only real algebra and elementary sequence limits. It needs no
measurability, measure, preservation, integrability, boundedness, or
invertibility.

## Exact preimage invariance, not image invariance

Combining both limit directions gives

\[
A_n^g(T\omega)\to c
\quad\Longleftrightarrow\quad
A_n^g(\omega)\to c.
\]

Existentially quantify \(c\). Pointwise membership then satisfies

\[
T\omega\in E(T,g)
\quad\Longleftrightarrow\quad
\omega\in E(T,g).
\]

This is exactly the set equality

\[
T^{-1}(E(T,g))=E(T,g).
\]

The theorem is stronger than almost-everywhere invariance and weaker than an
image statement. If \(T\) is constant on a two-point space, it is not
injective, yet the preimage equation remains valid. No inverse is constructed.

One must not rewrite the result as \(T(E)=E\). Image equality can fail for a
nonsurjective map because points outside the image have no predecessor. The
formal module makes no image-invariance declaration.

{{< reference-figure
  src="finite-prefix-invariance-and-ergodic-fork.svg"
  alt="The orbit from a starting point and the orbit after one base-map step differ by one deleted value. Two arrows show convergence to the same finite limit in both directions. The shared convergence event then enters an ergodic fork with null and conull branches; the diagram stops at that unresolved fork."
  caption="**Finding:** deleting or restoring one finite orbit prefix preserves the exact finite limit, so the convergence event is strictly preimage invariant even for a noninvertible map. Ergodic rigidity then leaves two branches, null or conull. A separate convergence-existence theorem is required to rule out the null branch. The plate shows logical dependence, not a proof of the pointwise ergodic theorem."
>}}

## Two ergodic routes, two precise receivers

Mathlib separates pre-ergodicity, quasi-ergodicity, and ergodicity.

- <code>PreErgodic T μ</code> says ordinarily measurable strictly invariant
  sets are almost everywhere empty or full.
- <code>QuasiErgodic T μ</code> adds quasi-measure preservation and supports
  null-measurable, almost-invariant sets.
- <code>Ergodic T μ</code> adds full measure preservation to the same
  pre-ergodic core.

The ordinarily measurable event and its exact preimage equation need only the
first receiver:

\[
\operatorname{PreErgodic}(T,\mu)
\quad\Longrightarrow\quad
E(T,g)=\varnothing\ \text{a.e.}
\ \text{or}\
E(T,g)=\Omega\ \text{a.e.}
\]

provided the event's measurability is supplied.

The representative-safe event may be only null measurable. Its generic
rigidity theorem therefore takes
[<code>QuasiErgodic T μ</code>](#ref-birkhoff-event-deep-ergodic). Exact
invariance is converted to almost-everywhere invariance, and Mathlib's
<code>QuasiErgodic.ae_empty_or_univ₀</code> closes the dichotomy.

An ordinary ergodic map can enter through <code>hT.quasiErgodic</code>. Keeping
the generic receiver weak makes the dependency visible instead of baking a
stronger project-specific assumption into the theorem.

### Probability converts conull to the number one

Under <code>[IsProbabilityMeasure μ]</code>, the full space has measure one.
An almost-everywhere-empty event has measure zero, while an
almost-everywhere-full event has measure one. RMT-22 therefore derives

\[
\mu(E(T,g))=0\quad\text{or}\quad\mu(E(T,g))=1.
\]

Probability does not create the dichotomy. Ergodic rigidity creates it;
probability converts the full branch into the numeral one.

### The zero-measure boundary

Every measurable map is quasi-ergodic for the zero measure. Every two sets are
equal almost everywhere for that measure. The null-or-conull result therefore
compiles for every observable, but it carries no information about pointwise
membership. RMT-22 includes this probe because it exposes the difference
between a valid almost-everywhere proposition and a substantive probability
statement.

## In Lean: seven bridges from the ledger to conditional rigidity

Each bridge presents one idea in spoken mathematics, paper notation, and exact
project syntax. The first two concern one finite horizon. The next three build
and shift the convergence event. The final two state exact invariance and its
conditional measure-theoretic consequences.

### Bridge 1: name one finite orbit average

{{< lean-bridge
  human="Average the first n readings of g along the orbit that starts at omega."
  math="\(A_n^g(\omega)=n^{-1}\sum_{j=0}^{n-1}g(T^j\omega).\)"
  lean="birkhoffAverage ℝ T g n ω"
>}}

- <code>birkhoffAverage</code> is Mathlib's total finite-average definition.
- The first argument <code>ℝ</code> chooses real scalar normalization.
- <code>T</code> is the update map, <code>g</code> is the observable,
  <code>n</code> is the horizon, and <code>ω</code> is the start.
- Internally, <code>birkhoffSum T g n ω</code> sums the indices in
  <code>Finset.range n</code>, namely \(0,\ldots,n-1\).
- At <code>n = 0</code>, inverse zero is totalized to zero, so the displayed
  Lean term has value zero.
{{< /lean-bridge >}}

### Bridge 2: state the finite measure ledger

{{< lean-bridge
  human="If T and g are measurable, then the horizon-n average is measurable; if T preserves the measure and g is integrable, that average is integrable."
  math="\(\operatorname{Measurable}(T),\operatorname{Measurable}(g)\Rightarrow\operatorname{Measurable}(A_n^g)\), and \(\operatorname{MeasurePreserving}(T,\mu),g\in L^1(\mu)\Rightarrow A_n^g\in L^1(\mu).\)"
  lean="measurable_birkhoffAverage hT hg n"
>}}

- In the measurable call, <code>hT : Measurable T</code> and
  <code>hg : Measurable g</code>.
- The integrable companion has exact name
  <code>integrable_birkhoffAverage</code> and is called as
  <code>integrable_birkhoffAverage hT hg n</code> with
  <code>hT : MeasurePreserving T μ μ</code> and
  <code>hg : Integrable g μ</code>.
- The sum-level companions are <code>measurable_birkhoffSum</code> and
  <code>integrable_birkhoffSum</code>.
- None of these four finite declarations states that a sequence converges.
{{< /lean-bridge >}}

### Bridge 3: turn convergence into point membership

{{< lean-bridge
  human="The start omega is in the convergence event exactly when its full average sequence approaches some finite real number."
  math="\(\omega\in E(T,g)\Longleftrightarrow\exists c\in\mathbb R,\ A_n^g(\omega)\to c.\)"
  lean="mem_birkhoffConvergenceSet_iff"
>}}

- <code>birkhoffConvergenceSet T g</code> is the set \(E(T,g)\).
- <code>∃ c : ℝ</code> in the theorem's expanded type asks for a finite real
  limit witness.
- <code>Tendsto ... atTop (nhds c)</code> means that, as natural horizons
  grow, the average enters every neighborhood of <code>c</code>.
- The theorem is a simp boundary for the definition. It does not manufacture
  a value of <code>c</code> or a member of the event.
{{< /lean-bridge >}}

### Bridge 4: transport the event across representatives

{{< lean-bridge
  human="If g and h agree almost everywhere and T pulls null sets back to null sets, then their convergence events agree almost everywhere."
  math="\(g=h\ \mu\text{-a.e.}\Longrightarrow E(T,g)=E(T,h)\ \mu\text{-a.e.}\)"
  lean="birkhoffConvergenceSet_ae_eq_of_ae_eq hT hgh"
>}}

- <code>hT : Measure.QuasiMeasurePreserving T μ μ</code> protects a null
  exceptional set when the orbit repeatedly takes preimages.
- <code>hgh : g =ᵐ[μ] h</code> is equality outside a \(\mu\)-null set.
- The proof first obtains equality of every fixed-horizon average, then uses
  <code>ae_all_iff</code> to choose one conull set where all horizons agree.
- The result is almost-everywhere equality of membership predicates, not
  literal equality of sets at every point.
{{< /lean-bridge >}}

### Bridge 5: delete or restore one prefix without changing the limit

{{< lean-bridge
  human="The averages from omega converge to c exactly when the averages from the next point T omega converge to the same c."
  math="\(A_n^g(T\omega)\to c\Longleftrightarrow A_n^g(\omega)\to c.\)"
  lean="tendsto_birkhoffAverage_apply_base_iff"
>}}

- The forward algebraic helper is
  <code>birkhoffAverage_succ_apply_base</code>:
  \(A_{n+1}(T\omega)=\frac{n+2}{n+1}A_{n+2}(\omega)
  -g(\omega)/(n+1)\).
- The reverse helper is
  <code>birkhoffAverage_succ_succ_apply</code>.
- The corresponding one-way limit theorems are
  <code>tendsto_birkhoffAverage_apply_base</code> and
  <code>tendsto_birkhoffAverage_of_apply_base</code>.
- No inverse for <code>T</code> is used. The reverse implication restores the
  deleted value algebraically.
{{< /lean-bridge >}}

### Bridge 6: express pointwise equivalence as exact set invariance

{{< lean-bridge
  human="A start belongs to the event if and only if its next orbit point belongs, so taking the preimage of the event changes nothing."
  math="\(T^{-1}(E(T,g))=E(T,g).\)"
  lean="preimage_birkhoffConvergenceSet T g"
>}}

- <code>T ⁻¹' E</code> is the set of starts whose next point lies in
  <code>E</code>.
- The equality is exact, not merely almost everywhere.
- No measurable-space, measure, preservation, injectivity, surjectivity, or
  boundedness premise occurs.
- This is a preimage statement. It does not assert <code>T '' E = E</code>.
{{< /lean-bridge >}}

### Bridge 7: keep rigidity and existence separate

{{< lean-bridge
  human="For an integrable observable and a quasi-ergodic base, the convergence event is almost everywhere empty or almost everywhere full."
  math="\(E(T,g)=\varnothing\ \mu\text{-a.e.}\ \lor\ E(T,g)=\Omega\ \mu\text{-a.e.}\)"
  lean="birkhoffConvergenceSet_ae_empty_or_univ_of_integrable hg hT"
>}}

- <code>hg : Integrable g μ</code> supplies almost-everywhere strong
  measurability; it does not supply convergence.
- <code>hT : QuasiErgodic T μ</code> supplies quasi-measure preservation and
  rigidity for null-measurable almost-invariant sets.
- With <code>[IsProbabilityMeasure μ]</code>, the separate corollary
  <code>measure_birkhoffConvergenceSet_eq_zero_or_one_of_integrable</code>
  concludes only \(\mu(E)=0\lor\mu(E)=1\).
- Neither theorem chooses the full or measure-one branch. In the two-state
  example, the explicit even-and-odd formulas choose it. In general, a
  pointwise theorem or another membership argument must do so.
{{< /lean-bridge >}}

### Try the exact declarations in the repository

{{< repo-check >}}
The authoritative source is
[<code>formalization/NonlinearDynamics/Random/RandomCocycles/BirkhoffConvergence.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/BirkhoffConvergence.lean).
For a **full project check**, put the following query block in a temporary
project scratch file after installing the repository's pinned dependencies:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.BirkhoffConvergence

open MeasureTheory Set Filter
open NonlinearDynamics.Random.RandomCocycles

#check measurable_birkhoffSum
#check measurable_birkhoffAverage
#check integrable_birkhoffSum
#check integrable_birkhoffAverage
#check birkhoffConvergenceSet
#check mem_birkhoffConvergenceSet_iff
#check measurableSet_birkhoffConvergenceSet
#check birkhoffConvergenceSet_ae_eq_of_ae_eq
#check nullMeasurableSet_birkhoffConvergenceSet_of_aemeasurable
#check nullMeasurableSet_birkhoffConvergenceSet_of_aestronglyMeasurable
#check nullMeasurableSet_birkhoffConvergenceSet_of_integrable
#check birkhoffAverage_succ_apply_base
#check tendsto_birkhoffAverage_apply_base
#check birkhoffAverage_succ_succ_apply
#check tendsto_birkhoffAverage_of_apply_base
#check tendsto_birkhoffAverage_apply_base_iff
#check preimage_birkhoffConvergenceSet
#check birkhoffConvergenceSet_ae_empty_or_univ_of_measurableSet
#check birkhoffConvergenceSet_ae_empty_or_univ_of_nullMeasurableSet
#check birkhoffConvergenceSet_ae_empty_or_univ_of_aemeasurable
#check birkhoffConvergenceSet_ae_empty_or_univ_of_aestronglyMeasurable
#check birkhoffConvergenceSet_ae_empty_or_univ_of_integrable
#check measure_birkhoffConvergenceSet_eq_zero_or_one_of_measurableSet
#check measure_birkhoffConvergenceSet_eq_zero_or_one_of_nullMeasurableSet
#check measure_birkhoffConvergenceSet_eq_zero_or_one_of_aemeasurable
#check measure_birkhoffConvergenceSet_eq_zero_or_one_of_aestronglyMeasurable
#check measure_birkhoffConvergenceSet_eq_zero_or_one_of_integrable
#check oneStepBirkhoffConvergenceSet
#check IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_oneStepBirkhoffConvergenceSet
#check IsIntegrableSubadditiveProcessCandidate.preimage_oneStepBirkhoffConvergenceSet
#check IsIntegrableSubadditiveProcessCandidate.oneStepBirkhoffConvergenceSet_ae_empty_or_univ
#check IsIntegrableSubadditiveProcessCandidate.measure_oneStepBirkhoffConvergenceSet_eq_zero_or_one
#check DiscreteMatrixCocycle.generatorLogPlusBirkhoffConvergenceSet
#check DiscreteMatrixCocycle.measurableSet_generatorLogPlusBirkhoffConvergenceSet
#check DiscreteMatrixCocycle.preimage_generatorLogPlusBirkhoffConvergenceSet
#check DiscreteMatrixCocycle.generatorLogPlusBirkhoffConvergenceSet_ae_empty_or_univ
#check DiscreteMatrixCocycle.measure_generatorLogPlusBirkhoffConvergenceSet_eq_zero_or_one
~~~

The 37 checks follow the public declarations in source order. They query exact
types; they do not create a theorem or rerun the examples by themselves.
{{< /repo-check >}}

## Type both ledgers yourself with Lean and `Std`

The next worksheet imports only Lean's small <code>Std</code> library. It
computes both starts of the two-state swap, checks the finite prefix identity,
and computes the first four decimal-block endpoints with exact rational
numbers. It does not import Mathlib, create a measure, or prove an infinite
limit.

Save this exact text as
<code>/tmp/BirkhoffConvergenceTutorial.lean</code>:

~~~lean
import Std

namespace BirkhoffConvergenceTutorial

inductive Point where
  | a
  | b
  deriving Repr, DecidableEq

def step : Point → Point
  | .a => .b
  | .b => .a

def observe : Point → Nat
  | .a => 0
  | .b => 2

def iterate : Nat → Point → Point
  | 0, p => p
  | n + 1, p => iterate n (step p)

def orbitValues (n : Nat) (p : Point) : List Nat :=
  (List.range n).map fun j => observe (iterate j p)

def orbitSum (n : Nat) (p : Point) : Nat :=
  (orbitValues n p).sum

def orbitAverage (n : Nat) (p : Point) : Rat :=
  if n = 0 then 0 else (orbitSum n p : Rat) / (n : Rat)

def decadeValueAux : Nat → Nat → Bool → Nat
  | 0, _, _ => 0
  | fuel + 1, n, oneBlock =>
      if n < 10 then
        if oneBlock then 1 else 0
      else
        decadeValueAux fuel (n / 10) (!oneBlock)

def decadeValue (n : Nat) : Nat :=
  if n = 0 then 0 else decadeValueAux (n + 1) n true

def decadeOnes (n : Nat) : Nat :=
  ((List.range n).map decadeValue).sum

def decadeAverage (n : Nat) : Rat :=
  if n = 0 then 0 else (decadeOnes n : Rat) / (n : Rat)

#eval orbitValues 8 .a
#eval orbitValues 8 .b
#eval (List.range 9).map fun n => (n, orbitSum n .a, orbitAverage n .a)
#eval (List.range 9).map fun n => (n, orbitSum n .b, orbitAverage n .b)
#eval (orbitSum 5 .a, observe .a + orbitSum 4 (step .a))
#eval (orbitAverage 4 (step .a),
  (5 : Rat) / 4 * orbitAverage 5 .a - (observe .a : Rat) / 4)
#eval [10, 100, 1000, 10000].map fun n =>
  (n, decadeOnes n, decadeAverage n)

example : orbitValues 8 .a = [0, 2, 0, 2, 0, 2, 0, 2] := by
  native_decide

example : orbitValues 8 .b = [2, 0, 2, 0, 2, 0, 2, 0] := by
  native_decide

example :
    (List.range 12).all (fun n =>
      orbitSum (n + 1) .a = observe .a + orbitSum n (step .a)) = true := by
  native_decide

example :
    [10, 100, 1000, 10000].map (fun n => decadeAverage n) =
      [9 / 10, 9 / 100, 909 / 1000, 909 / 10000] := by
  native_decide

end BirkhoffConvergenceTutorial
~~~

From the repository root or any other directory, type:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean \
  /tmp/BirkhoffConvergenceTutorial.lean
~~~

The byte-for-byte standard output is:

~~~text
[0, 2, 0, 2, 0, 2, 0, 2]
[2, 0, 2, 0, 2, 0, 2, 0]
[(0, 0, 0),
 (1, 0, 0),
 (2, 2, 1),
 (3, 2, (2 : Rat)/3),
 (4, 4, 1),
 (5, 4, (4 : Rat)/5),
 (6, 6, 1),
 (7, 6, (6 : Rat)/7),
 (8, 8, 1)]
[(0, 0, 0),
 (1, 2, 2),
 (2, 2, 1),
 (3, 4, (4 : Rat)/3),
 (4, 4, 1),
 (5, 6, (6 : Rat)/5),
 (6, 6, 1),
 (7, 8, (8 : Rat)/7),
 (8, 8, 1)]
(4, 4)
(1, 1)
[(10, 9, (9 : Rat)/10), (100, 9, (9 : Rat)/100), (1000, 909, (909 : Rat)/1000), (10000, 909, (909 : Rat)/10000)]
~~~

The first two lists are the orbit readings. The next two ledgers contain
\((n,S_n,A_n)\). The pair <code>(4, 4)</code> checks
\(S_5(a)=g(a)+S_4(Ta)\), and <code>(1, 1)</code> checks the normalized
delete-one-prefix identity. The final line reproduces every endpoint count and
fraction in the nonconvergence table.

**Standalone tutorial, suitable for a normal macOS or Linux machine.** It
imports only <code>Std</code> and never opens this project's Mathlib dependency
graph. This exact file and output were checked with the pinned Lean 4.32.0
toolchain. The full project declarations use the command in the preceding
repository box.

## Thin wrappers should keep thin premises

### Integrable subadditive-process candidates

Let \(X:\mathbb N\to\Omega\to\mathbb R\) satisfy the RMT-17 candidate
interface: every \(X_n\) is integrable and the family is shifted
subadditive. RMT-22 defines

\[
E_1(T,X)=E(T,X_1).
\]

The subadditive inequality is not used in the event definition, exact
invariance, or one-step integrability extraction. The wrapper remains useful
because it connects the project process to a standard event; the candidate
package itself does not imply convergence.

The null-measurability wrapper takes the candidate and a
quasi-measure-preserving map. The rigidity and zero-one wrappers take
<code>QuasiErgodic</code>. They do not take a stronger <code>Ergodic</code>
receiver merely because matrix-cocycle applications often have one.

The value \(X_0\) remains irrelevant. A compiled model sets \(X_0=1\) and
\(X_n=0\) for positive \(n\) over the zero measure. It satisfies the candidate
laws, and its one-step event is the whole space.

### Discrete matrix cocycles

For a discrete matrix cocycle \(C\), define

\[
E_C
{} =
E\left(C.\mathrm{base},
\omega\mapsto\log^+\lVert C(1,\omega)\rVert_\infty\right).
\]

The cocycle already stores measurability of its generator and preservation of
its base. Earlier modules prove ordinary measurability of the one-step
log-positive norm. Therefore \(E_C\) is ordinarily measurable, and exact
preimage invariance is purely pointwise.

The rigidity wrapper takes only
<code>PreErgodic C.base μ</code>. It does not require
<code>C.HasIntegrableGeneratorLogPlus</code>, because no proof step uses
integrability. It does not require <code>Nonempty ι</code>, because the
empty-index matrix observable remains measurable and the event remains
well-typed. An explicit <code>ι := Empty</code> probe calls both wrappers
without an <code>hC</code> hypothesis.

This is premise auditing in action: a natural application may possess stronger
structure, but a theorem should expose only what its proof consumes.

## The complete thirty-seven-declaration ledger

The frozen RMT-22 source is 602 lines and has SHA-256
<code>cec39333cd0751ca7b52283049cf11ec8a8a8870eff3dbeaf32bfda81d111fbd</code>.
It contains exactly thirty-seven public declarations and twelve anonymous
compiled boundary probes. The named interface appears below in source order.

### Finite measurability and integrability

| No. | Declaration | Exact role |
|---:|---|---|
| 1 | <code>measurable_birkhoffSum</code> | Finite real orbit sums are measurable from measurable \(T\) and \(g\) |
| 2 | <code>measurable_birkhoffAverage</code> | Totalized finite real averages are measurable under the same premises |
| 3 | <code>integrable_birkhoffSum</code> | Finite sums are integrable from measure preservation and integrable \(g\) |
| 4 | <code>integrable_birkhoffAverage</code> | Scalar normalization preserves finite-horizon integrability |

The first pair has no measure argument. The second pair has no probability or
ergodicity premise.

### Event and representative layer

| No. | Declaration | Exact role |
|---:|---|---|
| 5 | <code>birkhoffConvergenceSet</code> | Points where the real averages tend to some finite real |
| 6 | <code>mem_birkhoffConvergenceSet_iff</code> | Simp-normal form for membership |
| 7 | <code>measurableSet_birkhoffConvergenceSet</code> | Ordinary measurable (T,g) give an ordinarily measurable event |
| 8 | <code>birkhoffConvergenceSet_ae_eq_of_ae_eq</code> | Quasi-measure preservation transports the event across a.e.-equal observables |
| 9 | <code>nullMeasurableSet_birkhoffConvergenceSet_of_aemeasurable</code> | Primary measurable-representative theorem |
| 10 | <code>nullMeasurableSet_birkhoffConvergenceSet_of_aestronglyMeasurable</code> | Strong-measurability corollary |
| 11 | <code>nullMeasurableSet_birkhoffConvergenceSet_of_integrable</code> | Integrability corollary, using only its measurability field |

The <code>ae_eq</code> in declaration 8 refers to equality of event membership
almost everywhere. It does not produce set equality pointwise.

### Positive-index shift and exact invariance

| No. | Declaration | Exact role |
|---:|---|---|
| 12 | <code>birkhoffAverage_succ_apply_base</code> | Express \(A_{n+1}(T\omega)\) through \(A_{n+2}(\omega)\) |
| 13 | <code>tendsto_birkhoffAverage_apply_base</code> | Move convergence from \(\omega\) to \(T\omega\) |
| 14 | <code>birkhoffAverage_succ_succ_apply</code> | Express \(A_{n+2}(\omega)\) through \(A_{n+1}(T\omega)\) |
| 15 | <code>tendsto_birkhoffAverage_of_apply_base</code> | Move convergence from \(T\omega\) back to \(\omega\) |
| 16 | <code>tendsto_birkhoffAverage_apply_base_iff</code> | Same finite limit in both directions |
| 17 | <code>preimage_birkhoffConvergenceSet</code> | Exact equality \(T^{-1}E=E\) |

All six are pointwise and measure free. Declaration 17 says nothing about the
image \(T(E)\).

### Generic rigidity and probability laws

| No. | Declaration | Exact role |
|---:|---|---|
| 18 | <code>birkhoffConvergenceSet_ae_empty_or_univ_of_measurableSet</code> | Measurable event plus <code>PreErgodic</code> gives null-or-conull |
| 19 | <code>birkhoffConvergenceSet_ae_empty_or_univ_of_nullMeasurableSet</code> | Null-measurable event plus <code>QuasiErgodic</code> gives null-or-conull |
| 20 | <code>birkhoffConvergenceSet_ae_empty_or_univ_of_aemeasurable</code> | Representative-safe rigidity from <code>AEMeasurable</code> |
| 21 | <code>birkhoffConvergenceSet_ae_empty_or_univ_of_aestronglyMeasurable</code> | Strong-measurability rigidity corollary |
| 22 | <code>birkhoffConvergenceSet_ae_empty_or_univ_of_integrable</code> | Integrable rigidity corollary |
| 23 | <code>measure_birkhoffConvergenceSet_eq_zero_or_one_of_measurableSet</code> | Probability zero-one law on the measurable/pre-ergodic path |
| 24 | <code>measure_birkhoffConvergenceSet_eq_zero_or_one_of_nullMeasurableSet</code> | Probability zero-one law on the null-measurable/quasi-ergodic path |
| 25 | <code>measure_birkhoffConvergenceSet_eq_zero_or_one_of_aemeasurable</code> | Representative-safe numerical corollary |
| 26 | <code>measure_birkhoffConvergenceSet_eq_zero_or_one_of_aestronglyMeasurable</code> | Strong-measurability numerical corollary |
| 27 | <code>measure_birkhoffConvergenceSet_eq_zero_or_one_of_integrable</code> | Integrable numerical corollary |

The five numerical theorems require a probability measure. The five preceding
dichotomies do not.

### Candidate specialization

| No. | Declaration | Exact role |
|---:|---|---|
| 28 | <code>oneStepBirkhoffConvergenceSet</code> | Name \(E(T,X_1)\) at the root namespace |
| 29 | <code>IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_oneStepBirkhoffConvergenceSet</code> | Use \(X_1\) integrability and quasi-measure preservation |
| 30 | <code>IsIntegrableSubadditiveProcessCandidate.preimage_oneStepBirkhoffConvergenceSet</code> | Exact invariance without using candidate laws |
| 31 | <code>IsIntegrableSubadditiveProcessCandidate.oneStepBirkhoffConvergenceSet_ae_empty_or_univ</code> | Conditional quasi-ergodic rigidity |
| 32 | <code>IsIntegrableSubadditiveProcessCandidate.measure_oneStepBirkhoffConvergenceSet_eq_zero_or_one</code> | Conditional probability zero-one law |

The wrapper never states that \(X_n/n\) converges. It studies only ordinary
Birkhoff averages of the one-step observable \(X_1\).

### Matrix-cocycle specialization

| No. | Declaration | Exact role |
|---:|---|---|
| 33 | <code>DiscreteMatrixCocycle.generatorLogPlusBirkhoffConvergenceSet</code> | Name the event for the generator log-positive observable |
| 34 | <code>DiscreteMatrixCocycle.measurableSet_generatorLogPlusBirkhoffConvergenceSet</code> | Obtain ordinary event measurability directly from the cocycle |
| 35 | <code>DiscreteMatrixCocycle.preimage_generatorLogPlusBirkhoffConvergenceSet</code> | Exact base-preimage invariance |
| 36 | <code>DiscreteMatrixCocycle.generatorLogPlusBirkhoffConvergenceSet_ae_empty_or_univ</code> | Apply <code>PreErgodic</code> with no generator-integrability premise |
| 37 | <code>DiscreteMatrixCocycle.measure_generatorLogPlusBirkhoffConvergenceSet_eq_zero_or_one</code> | Probability zero-one corollary with the same thin premises |

The source-level count treats every declaration once. Anonymous examples and
the six <code>#print axioms</code> commands are verification surfaces, not
public API names.

### Complete proof-helper map

The module declares no private named helper theorem. Its proof bodies use
imported Mathlib interfaces and local <code>have</code> statements. The table
below accounts for those helper families and shows exactly which public
declarations consume them.

| Public declarations | Imported or bundled helper used in the proof | Exact job |
|---|---|---|
| 1-2 | <code>Measurable.iterate</code>, <code>Measurable.comp</code>, <code>Finset.measurable_sum</code>, <code>Measurable.mul</code> | Make each orbit term, finite sum, and scalar-normalized average measurable |
| 3-4 | <code>MeasurePreserving.iterate</code>, <code>MeasurePreserving.integrable_comp_of_integrable</code>, <code>integrable_finsetSum</code>, <code>Integrable.const_mul</code> | Move one-step integrability through every iterate, add finitely, then normalize |
| 5-6 | no imported proof helper; definition and <code>rfl</code> | Name the convergence predicate as a set and expose membership without asserting a witness |
| 7 | <code>MeasureTheory.measurableSet_exists_tendsto</code> | Convert a measurable real-valued sequence into a measurable set of points where some finite limit exists |
| 8 | <code>Measure.QuasiMeasurePreserving.birkhoffAverage_ae_eq_of_ae_eq</code>, <code>ae_all_iff</code>, <code>Tendsto.congr'</code> | Upgrade fixed-horizon almost-everywhere equality to one conull set carrying equality at every horizon, then preserve limits |
| 9-11 | <code>AEMeasurable.mk</code>, <code>AEMeasurable.measurable_mk</code>, <code>AEMeasurable.ae_eq_mk</code>, <code>NullMeasurableSet.congr</code> | Choose an ordinary representative and transfer its measurable convergence event back to the raw observable |
| 12 and 14 | <code>birkhoffSum_succ'</code>, <code>field_simp</code>, <code>ring_nf</code> | Peel the first orbit reading and solve the normalized identity in each direction |
| 13 and 15 | <code>tendsto_add_atTop_iff_nat</code>, <code>tendsto_add_atTop_nat</code>, <code>tendsto_one_div_add_atTop_nhds_zero_nat</code>, <code>tendsto_const_div_atTop_nhds_zero_nat</code>, <code>tendsto_natCast_div_add_atTop</code>, <code>Filter.Tendsto.mul</code>, <code>Filter.Tendsto.add</code>, <code>Filter.Tendsto.sub</code> | Shift the horizon, send the coefficient to one and the prefix correction to zero, and combine limits |
| 16-17 | declarations 13 and 15, <code>Set.ext</code>, <code>mem_birkhoffConvergenceSet_iff</code> | Package the two limit directions and turn pointwise membership equivalence into exact preimage equality |
| 18 and 23 | <code>PreErgodic.ae_empty_or_univ</code>, <code>PreErgodic.prob_eq_zero_or_one</code> | Apply ordinary measurable strict-invariance rigidity, then add probability normalization only for numerical zero-one output |
| 19 and 24 | <code>QuasiErgodic.ae_empty_or_univ₀</code>, <code>ae_eq_empty</code>, <code>measure_congr</code> | Apply null-measurable almost-invariant rigidity and convert its two branches to measures |
| 20-22 and 25-27 | <code>AEStronglyMeasurable.aemeasurable</code>, <code>Integrable.aestronglyMeasurable</code> | Expose progressively stronger ergonomic premises while reusing the almost-everywhere-measurable proof core |
| 28 | no imported proof helper; definitional abbreviation | Name the generic event for the one-step observable \(X_1\) without consuming a candidate law |
| 29-32 | <code>IsIntegrableSubadditiveProcessCandidate.integrable 1</code> plus generic declarations 11, 17, 22, and 27 | Reuse only one-step integrability and the generic event API; the shifted-subadditive field is not used |
| 33 | no imported proof helper; definitional abbreviation | Name the event for the cocycle's one-step log-positive norm observable |
| 34-37 | <code>DiscreteMatrixCocycle.base_preserving.measurable</code>, <code>DiscreteMatrixCocycle.measurable_logPlusNormObservable 1</code>, plus generic declarations 7, 17, 18, and 23 | Supply ordinary measurability from the cocycle bundle and reuse the generic event API without generator integrability |
| boundary probes 1-9 | <code>birkhoffAverage_zero</code>, <code>birkhoffAverage_of_comp_eq</code>, <code>Function.IsFixedPt.birkhoffAverage_eq</code>, zero-measure and empty-index instances | Test time zero, constants, identity dynamics, noninjectivity, representatives, zero measure, \(X_0\), and an empty matrix index |
| boundary probes 10-12 | <code>mem_birkhoffConvergenceSet_iff</code>, <code>Finset.sum_range_id_mul_two</code>, <code>tendsto_natCast_atTop_atTop</code>, <code>not_tendsto_atTop_of_tendsto_nhds</code> | Turn abstract divergence into nonmembership and compile the explicit successor-orbit formula \(A_{n+1}(0)=n/2\) |

This map distinguishes project declarations from upstream machinery. For
example, <code>birkhoffSum_succ'</code> is an imported finite-sum recurrence;
<code>birkhoffAverage_succ_apply_base</code> is this module's new solved
average identity. The 37-name ledger, this helper map, the 12-probe narrative
below, and the six axiom prints together cover every source-level proof
surface in the 602-line file.

## Proof architecture as a dependency graph

The declarations form three main routes.

### Route A: ordinary measurable observable

\[
\begin{aligned}
&T,g\text{ measurable}\\
&\quad\Longrightarrow A_n^g\text{ measurable for every }n\\
&\quad\Longrightarrow E(T,g)\text{ measurable}\\
&\quad\Longrightarrow
\bigl(\operatorname{PreErgodic}(T,\mu)
\text{ and }T^{-1}E=E\bigr)\\
&\quad\Longrightarrow E\text{ null or conull}.
\end{aligned}
\]

Probability is added only if the final conclusion must be written
\(\mu(E)=0\) or \(\mu(E)=1\).

### Route B: almost-everywhere representative

\[
\begin{aligned}
&g\text{ a.e. measurable},\quad T\text{ quasi-measure-preserving}\\
&\quad\Longrightarrow g\sim\widetilde g\text{ a.e. with }\widetilde g\text{ measurable}\\
&\quad\Longrightarrow E(T,g)\sim E(T,\widetilde g)\text{ a.e.}\\
&\quad\Longrightarrow E(T,g)\text{ null measurable}\\
&\quad\Longrightarrow
\bigl(\operatorname{QuasiErgodic}(T,\mu)
\text{ and }T^{-1}E=E\bigr)\\
&\quad\Longrightarrow E\text{ null or conull}.
\end{aligned}
\]

The quasi-measure-preserving field of <code>QuasiErgodic</code> supports both
representative transport and the null-measurable rigidity theorem.

### Route C: pointwise shift

\[
\begin{aligned}
&\text{two positive-index algebraic identities}\\
&\quad\Longrightarrow
A_n^g(\omega)\to c\iff A_n^g(T\omega)\to c\\
&\quad\Longrightarrow
T^{-1}E(T,g)=E(T,g).
\end{aligned}
\]

This route is independent of A and B. It needs no measurable space at all.
The final rigidity theorems join the pointwise shift route to either event
measurability route.

## Models that test the API boundary

The source compiles twelve anonymous probes. Each tests a possible source of
accidental strengthening.

### Probe 1: time zero

For every \(T,g,\omega\), Mathlib gives \(A_0^g(\omega)=0\). This tests the
totalized convention and prevents prose from calling it a positive-time
average.

### Probes 2 and 3: zero and constant observables

The zero observable has event \(\Omega\). A constant \(c\) also has event
\(\Omega\) even though the time-zero value is zero: the sequence is
\(0,c,c,c,\ldots\), which converges to \(c\).

### Probe 4: identity dynamics

For the identity map and arbitrary \(g\), every positive average at \(\omega\)
equals \(g(\omega)\). The event is \(\Omega\) without any measurability premise.

### Probe 5: a constant noninjective base

On the two-element Boolean type, the constant map is not injective. The exact
preimage theorem still applies. This refutes any hidden use of invertibility.

### Probe 6: representative transport

For <code>hg : AEMeasurable g μ</code>, the event for \(g\) is almost
everywhere equal to the event for <code>hg.mk g</code> under
quasi-measure-preserving dynamics. This tests the direction of
<code>ae_eq_mk</code> and the set-congruence proof.

### Probe 7: zero measure

Every measurable map is quasi-ergodic for the zero measure, so the event
dichotomy holds for arbitrary \(g\). The statement is intentionally described
as vacuous.

### Probe 8: a candidate with nonzero time zero

Set \(X_0=1\) and \(X_n=0\) for every positive \(n\), over the zero measure.
This is an integrable shifted-subadditive-process candidate. The one-step
event is \(\Omega\). Thus no theorem silently assumes \(X_0=0\).

### Probe 9: empty matrix index without generator integrability

A cocycle indexed by the empty type calls event measurability and exact
invariance without <code>HasIntegrableGeneratorLogPlus</code> and without a
nonempty-index instance.

### Probe 10: abstract nonmembership

If the average sequence is proved not to tend to any real \(c\), membership in
the convergence event is definitionally impossible. The simp theorem closes
that argument directly.

### Probes 11 and 12: an explicit divergent orbit

Take \(\Omega\) to be the natural numbers, \(T(k)=k+1\), \(g(k)=k\), and
\(\omega=0\). A
finite calculation gives

\[
\begin{aligned}
A_{n+1}^g(0)
&=\frac{1}{n+1}\sum_{j=0}^{n}j\\
&=\frac{1}{n+1}\frac{n(n+1)}{2}\\
&=\frac n2.
\end{aligned}
\]

In the first probe, the finite-sum identity establishes the exact formula. The
second proves \(n/2\to+\infty\), contradicting convergence to any finite real.
Therefore \(0\notin E(T,g)\).

## Axiom and source-integrity audit

RMT-22 prints the axioms of six representative high-level theorems:

- almost-everywhere event congruence;
- null measurability from an almost-everywhere measurable representative;
- the same-limit shift equivalence;
- integrable-observable ergodic rigidity;
- the candidate rigidity wrapper; and
- the matrix-cocycle rigidity wrapper.

Each print contains only <code>propext</code>, <code>Classical.choice</code>, and
<code>Quot.sound</code>. These are the standard logical axioms inherited from
Mathlib's classical and quotient infrastructure. There is no <code>sorry</code>,
<code>admit</code>, custom axiom, or unsafe declaration.

The source imports Mathlib's finite Birkhoff algebra, quasi-measure-preserving
transport, and the general measurable convergence-set theorem. It does not
redefine the upstream finite sum or average.

## Solved exercises

These exercises are cumulative. Try each problem before opening its solution.

### Exercise 1: expand the first three sums

Write \(S_0^g(\omega)\), \(S_1^g(\omega)\), and \(S_3^g(\omega)\).

{{< details "Solution" >}}
The range for zero is empty, so \(S_0^g(\omega)=0\). The range for one contains
only zero, so \(S_1^g(\omega)=g(\omega)\). The range for three contains zero,
one, and two, so

\[
S_3^g(\omega)=g(\omega)+g(T\omega)+g(T^2\omega).
\]
{{< /details >}}

### Exercise 2: explain the time-zero average

Why does \(A_0^g=0\) not imply \(X_0=0\) for a process \(X\)?

{{< details "Solution" >}}
The Birkhoff average is a particular totalized definition:
\(A_0^g=0^{-1}S_0^g=0\). A process \(X:\mathbb N\to\Omega\to\mathbb R\) is
separate input data. Unless its definition or hypotheses connect \(X_0\) to a
Birkhoff average, the two values are logically unrelated.
{{< /details >}}

### Exercise 3: locate the preservation premise

Which finite theorem needs measure preservation: measurability of the sum or
integrability of the sum?

{{< details "Solution" >}}
Integrability needs preservation so that integrability of \(g\) transports to
\(g\circ T^j\). Measurability needs only measurability of \(T\) and \(g\).
{{< /details >}}

### Exercise 4: definition versus witness

Does defining \(E(T,g)\) give a term of type
<code>∃ ω, ω ∈ birkhoffConvergenceSet T g</code>?

{{< details "Solution" >}}
No. The definition gives a set, meaning a predicate on ω. A nonemptiness
proof would have to construct a point and a finite real limit for its average
sequence. RMT-22 constructs neither in general.
{{< /details >}}

### Exercise 5: measurable event without a measure

Why can <code>measurableSet_birkhoffConvergenceSet</code> omit μ entirely?

{{< details "Solution" >}}
A measurable set is defined by the measurable-space structure, not by a
particular measure. The theorem assembles measurable functions and applies a
topological measurability result. Measures enter later through null sets,
almost-everywhere equality, and ergodicity.
{{< /details >}}

### Exercise 6: the representative trap

What invalid step would occur if one wrote “\(g\) is integrable, therefore
\(g\) is measurable” in the ordinary pointwise sense?

{{< details "Solution" >}}
Mathlib's integrability package supplies almost-everywhere strong
measurability. The given representative may differ on a null set from every
ordinary measurable representative. Upgrading it to ordinary measurability
would strengthen the premise without proof.
{{< /details >}}

### Exercise 7: why quasi-measure preservation

Let \(N=\{\omega:g(\omega)\ne h(\omega)\}\) be null. Where can the orbitwise
equality fail at horizon \(j\)?

{{< details "Solution" >}}
It can fail at points \(\omega\) such that \(T^j\omega\in N\), namely on
\((T^j)^{-1}(N)\). Quasi-measure preservation ensures that this preimage is
still null.
{{< /details >}}

### Exercise 8: fixed horizon versus every horizon

Why is one application of
<code>birkhoffAverage_ae_eq_of_ae_eq</code> insufficient for event congruence?

{{< details "Solution" >}}
The upstream theorem fixes one \(n\). Convergence is a property of all horizons
simultaneously. RMT-22 uses countability of the natural numbers to choose one
conull set on which the averages agree for every \(n\).
{{< /details >}}

### Exercise 9: derive the forward shift identity

Starting from
\(S_{n+2}^g(\omega)=g(\omega)+S_{n+1}^g(T\omega)\), solve for
\(A_{n+1}^g(T\omega)\).

{{< details "Solution" >}}
Since \(S_m^g=mA_m^g\) at positive \(m\),

\[
(n+2)A_{n+2}^g(\omega)
=g(\omega)+(n+1)A_{n+1}^g(T\omega).
\]

Divide by \(n+1\) and rearrange:

\[
A_{n+1}^g(T\omega)
=\frac{n+2}{n+1}A_{n+2}^g(\omega)
-\frac{g(\omega)}{n+1}.
\]
{{< /details >}}

### Exercise 10: preserve the limit value

Suppose \(A_n^g(\omega)\to c\). Why does the forward identity give limit \(c\),
not merely existence of some limit at \(T\omega\)?

{{< details "Solution" >}}
The shifted average is the product of a coefficient tending to one with a
sequence tending to \(c\), minus a correction tending to zero. Limit algebra
therefore gives \(1\cdot c-0=c\).
{{< /details >}}

### Exercise 11: no inverse map

Why does the converse shift theorem not require a point \(\upsilon\) with
\(T\upsilon=\omega\)?

{{< details "Solution" >}}
It restores the deleted first value algebraically using

\[
A_{n+2}^g(\omega)
=\frac{g(\omega)}{n+2}
+\frac{n+1}{n+2}A_{n+1}^g(T\omega).
\]

No predecessor of \(\omega\) is requested.
{{< /details >}}

### Exercise 12: preimage versus image

Translate \(T^{-1}E=E\) into a pointwise biconditional. Does it imply
\(T(E)=E\)?

{{< details "Solution" >}}
It says \(T\omega\in E\iff\omega\in E\) for every \(\omega\). It does not imply
image equality without additional surjectivity information. A point of \(E\)
outside the image of \(T\) cannot lie in \(T(E)\).
{{< /details >}}

### Exercise 13: identify the weakest ordinary receiver

Given a measurable set \(E\) and exact equality \(T^{-1}E=E\), which Mathlib
structure suffices for the null-or-conull conclusion?

{{< details "Solution" >}}
<code>PreErgodic T μ</code> suffices. Its defining field is precisely the
rigidity of ordinarily measurable strictly invariant sets.
{{< /details >}}

### Exercise 14: identify the representative-safe receiver

Why does a null-measurable event naturally pair with
<code>QuasiErgodic T μ</code>?

{{< details "Solution" >}}
The quasi-ergodic API contains quasi-measure preservation and a theorem for
null-measurable almost-invariant sets. The ordinary pre-ergodic definition is
phrased only for ordinarily measurable strictly invariant sets.
{{< /details >}}

### Exercise 15: do not choose the branch

Suppose ergodicity yields \(E=\varnothing\) almost everywhere or
\(E=\Omega\) almost everywhere. What extra fact would rule out the first
branch?

{{< details "Solution" >}}
Any proof that \(E\) has positive measure would rule out the null branch. A
pointwise ergodic theorem supplies the much stronger statement that \(E\) is
conull under its analytic hypotheses. RMT-22 supplies neither fact.
{{< /details >}}

### Exercise 16: probability's exact job

What does <code>[IsProbabilityMeasure μ]</code> add to an already proved
null-or-conull dichotomy?

{{< details "Solution" >}}
It identifies the measure of the full space with one. Thus the conull branch
has event measure one, while the null branch has measure zero. It does not
prove ergodicity or convergence.
{{< /details >}}

### Exercise 17: zero measure

Why can a set be both almost everywhere empty and almost everywhere full for
the zero measure?

{{< details "Solution" >}}
Every subset has zero measure, so every membership disagreement lies in a
null set. Almost-everywhere equality cannot distinguish any two predicates.
The result is logically consistent and informationally empty.
{{< /details >}}

### Exercise 18: constant observable and time zero

For \(g\equiv c\ne0\), list the average sequence and its limit.

{{< details "Solution" >}}
The sequence is \(0,c,c,c,\ldots\): time zero is totalized to zero, and every
positive horizon averages \(n\) copies of \(c\). The finite prefix does not
affect the limit, which is \(c\).
{{< /details >}}

### Exercise 19: successor orbit divergence

Verify that \(A_{n+1}^g(0)=n/2\) for \(T(k)=k+1\) and \(g(k)=k\).

{{< details "Solution" >}}
The orbit values are \(0,1,\ldots,n\). Their sum is \(n(n+1)/2\). Dividing by
the positive horizon \(n+1\) gives \(n/2\).
{{< /details >}}

### Exercise 20: finite real versus infinity

Why is a sequence tending to positive infinity outside the convergence event?

{{< details "Solution" >}}
Membership requires a witness \(c\in\mathbb R\) and convergence in the
neighborhood filter of that finite \(c\). Tending to the order filter at
positive infinity is incompatible with convergence to a finite real.
{{< /details >}}

### Exercise 21: candidate time zero

Which candidate field could force \(X_0=0\)?

{{< details "Solution" >}}
Neither field does. Integrability permits nonzero functions, and shifted
subadditivity at \(m=k=0\) gives only
\(X_0(\omega)\le X_0(\omega)+X_0(\omega)\). The compiled candidate with
\(X_0=1\) shows the interface is consistent with nonzero time zero.
{{< /details >}}

### Exercise 22: candidate law usage

Does <code>preimage_oneStepBirkhoffConvergenceSet</code> use integrability or
subadditivity?

{{< details "Solution" >}}
No. It is the generic pointwise preimage theorem specialized to the function
\(X_1\). Its signature therefore takes \(T\) and \(X\), not a candidate proof.
{{< /details >}}

### Exercise 23: cocycle integrability

Why is <code>HasIntegrableGeneratorLogPlus</code> absent from the cocycle event
measurability theorem?

{{< details "Solution" >}}
The cocycle's one-step log-positive norm is ordinarily measurable from the
generator and finite matrix operations. Event measurability needs ordinary
measurability, not integrability.
{{< /details >}}

### Exercise 24: empty matrix index

What breaks in the event definition when the finite matrix index is empty?

{{< details "Solution" >}}
Nothing. Earlier cocycle modules totalize the empty-dimensional norm
observable and prove it measurable. The convergence event and its preimage
equation remain meaningful, so no <code>Nonempty</code> premise is necessary.
{{< /details >}}

### Exercise 25: classify declaration 8

Is <code>birkhoffConvergenceSet_ae_eq_of_ae_eq</code> a measurability theorem,
an existence theorem, or a congruence theorem?

{{< details "Solution" >}}
It is a congruence theorem. It transports event membership almost everywhere
between two observables already known to agree almost everywhere. It neither
proves the event measurable nor proves that it has members.
{{< /details >}}

### Exercise 26: count the generic rigidity family

Why are declarations 18 through 27 ten theorems rather than one theorem with
many typeclass searches?

{{< details "Solution" >}}
The split makes the two set-measurability routes and three observable premise
levels explicit, then separately records the almost-everywhere and numerical
probability conclusions. The names expose proof dependencies and prevent
automatic inference from hiding a strengthened premise.
{{< /details >}}

### Exercise 27: axiom footprint

What would be suspicious in the printed axiom list beyond the three standard
axioms reported here?

{{< details "Solution" >}}
A project-specific axiom, a theorem introduced with <code>sorryAx</code>, or an
unexpected classical postulate would require investigation. The actual prints
contain only <code>propext</code>, <code>Classical.choice</code>, and
<code>Quot.sound</code>.
{{< /details >}}

### Exercise 28: distinguish Birkhoff from Kingman

What sequence does RMT-22 study for a candidate \(X\), and what sequence would
a subadditive ergodic theorem study?

{{< details "Solution" >}}
RMT-22 studies the ordinary Birkhoff averages of the single observable
\(X_1\): \(n^{-1}\sum_{j\lt n}X_1(T^j\omega)\).
[Kingman's theorem](#ref-birkhoff-event-deep-kingman) concerns the
normalized subadditive process values \(X_n(\omega)/n\). Earlier finite bounds
relate them, but they are not definitionally the same sequence.
{{< /details >}}

### Exercise 29: identify the missing theorem role

What logical statement would a pointwise Birkhoff theorem add to the present
event layer?

{{< details "Solution" >}}
Under its measure-preserving and integrability hypotheses, it would prove
that the Birkhoff averages converge for almost every starting point. In event
language, it would prove \(E(T,g)=\Omega\) almost everywhere, selecting the
conull branch rather than merely presenting a dichotomy.
{{< /details >}}

### Exercise 30: state the exact summit

Summarize RMT-22 in one sentence without using the words "proves Birkhoff's
theorem."

{{< details "Solution" >}}
RMT-22 builds a measurable, representative-safe, exactly preimage-invariant
event for finite-real convergence of Birkhoff averages and proves its
conditional ergodic rigidity, while leaving convergence existence to a
separate pointwise theorem.
{{< /details >}}

## Premise ledger

| Result | Minimal visible premises | Premises deliberately absent |
|---|---|---|
| Finite sum measurability | measurable \(T\), measurable \(g\) | measure, preservation, probability, integrability, ergodicity |
| Finite sum integrability | measure-preserving \(T\), integrable \(g\) | finite measure, probability, ergodicity |
| Event measurability | measurable \(T\), measurable \(g\) | preservation, integrability, probability, ergodicity |
| Event a.e. congruence | quasi-measure-preserving \(T\), \(g=h\) a.e. | measurability and integrability of either representative |
| Event null measurability | a.e. measurable \(g\), quasi-measure-preserving \(T\) | ordinary measurability of raw \(g\), probability, ergodicity |
| Same-limit shift equivalence | none beyond real-valued finite averages | measurable space, measure, boundedness, invertibility |
| Exact preimage invariance | arbitrary \(T,g\) | every analytic or dynamical premise |
| Measurable event rigidity | <code>PreErgodic</code>, event measurability | preservation beyond what a caller may possess, probability |
| Null-measurable event rigidity | <code>QuasiErgodic</code>, null measurability | full measure preservation, probability |
| Numerical zero-one law | corresponding rigidity path, probability | convergence existence |
| Candidate null measurability | candidate, quasi-measure-preserving \(T\) | \(X_0=0\), probability, ergodicity |
| Cocycle event rigidity | cocycle, <code>PreErgodic C.base μ</code> | generator integrability, nonempty matrix index, convergence |

The distinction between proof dependency and ambient structure matters. A
<code>DiscreteMatrixCocycle</code> stores a measure-preserving base even when a
specific wrapper calls only its measurability or passes an external
pre-ergodic proof. The theorem should not be described as assumption free;
its receiver still carries structure. It should be described as requiring no
additional generator-integrability or nonempty-index premise.

## Nonclaim ledger

RMT-22 does not establish:

1. that \(E(T,g)\) is nonempty for arbitrary \(T,g\);
2. that any named point belongs to the event, except in boundary examples;
3. that the event has positive measure;
4. that the conull branch of ergodic rigidity holds;
5. a maximal ergodic inequality;
6. the pointwise Birkhoff ergodic theorem;
7. convergence to a conditional expectation;
8. convergence to the space average under ergodicity;
9. convergence in integrable norm, probability, or distribution;
10. interchange of limit and integral;
11. a density or frequency theorem for marked orbit starts;
12. Kingman's subadditive ergodic theorem;
13. almost-everywhere convergence of \(X_n/n\);
14. equality of a samplewise limit with the deterministic Fekete rate;
15. ergodicity of \(T^b\) from ergodicity of \(T\);
16. mixing, independence, or correlation decay;
17. image invariance of the convergence event;
18. a signed cocycle growth limit;
19. a Lyapunov exponent; or
20. an Oseledets filtration or splitting.

The theorem that a convergence event is null or conull is genuinely useful.
It becomes decisive once another argument gives positive measure or
almost-everywhere membership. It is not a substitute for that argument.

## The existence theorem that RMT-22 leaves open

The [classical pointwise Birkhoff ergodic theorem](#ref-birkhoff-event-deep-birkhoff)
starts with a
measure-preserving transformation and an integrable observable. In a standard
probability-space formulation, it proves that the finite averages converge
almost everywhere to an invariant integrable function; under ergodicity that
limit is almost everywhere constant and agrees with the space average.

RMT-22 stops before every part of that existence statement. The pinned Mathlib
release contains finite Birkhoff algebra, quasi-measure-preserving
representative transport, ergodic rigidity, and specialized mean-ergodic
results in normed settings. The Mathlib API audited for RMT-22 did not itself
contain the measure-theoretic pointwise Birkhoff theorem needed here.

The project later built that analytic route in separate modules. RMT-23
supplies a finite Hopf-style maximal
ergodic inequality and a horizon-uniform weak estimate for strict finite
average-threshold events. The
[finite maximal Deep Dive]({{< relref "/knowledge-base/deep-dives/finite-maximal-ergodic-inequalities-from-orbit-maxima-to-threshold-events" >}})
begins that climb. The later
[Pointwise Birkhoff from Maximal Control and Dense Good Functions]({{< relref "/knowledge-base/deep-dives/pointwise-birkhoff-from-maximal-control-and-dense-good-functions" >}})
chapter reaches the project theorem
<code>ae_mem_birkhoffConvergenceSet_of_integrable</code>. Under a finite
measure, measure-preserving dynamics, and an integrable real observable, that
theorem proves almost-everywhere membership in the convergence event.

This later result does not change what RMT-22 proves. In the present module,
the null-or-conull and zero-one theorems remain conditional dichotomies. A
caller that wants the conull branch must import and apply the later pointwise
theorem or provide another membership argument. The later theorem also stops
at convergence-event membership: it does not identify the limit with a
conditional expectation or, under ergodicity, with the space average.

For the subadditive program, even a pointwise theorem for the one-step
observable is not the final summit. The RMT-20 phase estimate and RMT-21
interval packing still need a checked density or frequency input to control
marked starts and connect finite bounds to \(X_n/n\). Only after that analytic
bridge can the project proceed toward Kingman's theorem without adding an
unsupported convergence claim.

## Where to continue

The {{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}}
entry is the compact definition, boundary, and premise reference.

The {{< refterm "birkhoff-sum" "Birkhoff sum" >}} entry develops the finite
sum and powered-map block interpretation. The
{{< refterm "ergodic-probability-base" "ergodic probability base" >}}
entry separates preservation, probability, ergodicity, and integrability.

[Probability Normalization and Ergodic Rigidity Before Kingman]({{< relref "/knowledge-base/deep-dives/probability-normalization-and-ergodic-rigidity-before-kingman" >}})
is the RMT-17 foundation for the two rigidity receivers and candidate wrapper.

[Finite Ordered Interval Packing for Nonpositive Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-ordered-interval-packing-for-nonpositive-subadditive-processes" >}})
is the immediate finite predecessor. Its marked-start density gap remains open
after RMT-22.

[Birkhoff Convergence Events and Ergodic Rigidity in Lean]({{< relref "/development-notebook/2026/07/birkhoff-convergence-events-and-ergodic-rigidity-in-lean" >}})
maps all thirty-seven names to their checked proofs and build commands.

[Finite Maximal Ergodic Inequalities: From Orbit Maxima to Threshold Events]({{< relref "/knowledge-base/deep-dives/finite-maximal-ergodic-inequalities-from-orbit-maxima-to-threshold-events" >}})
continues the analytic route with strict finite running maxima,
measure-preserving cancellation, and a positive-threshold weak estimate. It
still makes no pointwise convergence claim.

[Pointwise Birkhoff from Maximal Control and Dense Good Functions]({{< relref "/knowledge-base/deep-dives/pointwise-birkhoff-from-maximal-control-and-dense-good-functions" >}})
completes the later finite-measure maximal-closure route to
<code>ae_mem_birkhoffConvergenceSet_of_integrable</code>. Read it after this
chapter to see exactly which new hypotheses and approximation machinery choose
the conull branch.

## References

All Mathlib links below use the v4.32.0 revision pinned by this project. The
local source authority is commit
<code>81a5d257c8e410db227a6665ed08f64fea08e997</code>.

<a id="ref-birkhoff-event-deep-basic"></a>**Mathlib contributors.**
[Finite Birkhoff sums](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Basic.html),
with the
[pinned definition and recurrence laws](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Basic.lean#L31-L57).
The same pinned source contains the exact shifted finite-sum difference used
to audit the new finite-prefix formulas.

<a id="ref-birkhoff-event-deep-average"></a>**Mathlib contributors.**
[Finite Birkhoff averages](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Average.html),
with the
[pinned totalized definition](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Average.lean#L46-L58)
and
[shifted-difference identity](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Average.lean#L112-L116).
RMT-22 reuses these finite objects and adds a boundedness-free same-limit
equivalence.

<a id="ref-birkhoff-event-deep-qmp"></a>**Mathlib contributors.**
[Quasi-measure-preserving Birkhoff transport](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/QuasiMeasurePreserving.html),
with the
[pinned fixed-horizon a.e. theorem](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/QuasiMeasurePreserving.lean#L35-L46).
RMT-22 takes a countable all-horizon intersection before transporting
convergence events.

<a id="ref-birkhoff-event-deep-polish"></a>**Mathlib contributors.**
[Measurable convergence sets](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Constructions/Polish/Basic.html),
with the
[pinned theorem](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Constructions/Polish/Basic.lean#L996-L1017).
This is the general topological-measure bridge used for the real event.

<a id="ref-birkhoff-event-deep-representative"></a>**Mathlib contributors.**
[Almost-everywhere measurable representatives](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/MeasureSpaceDef.html#MeasureTheory.AEMeasurable.mk),
with the
[pinned <code>AEMeasurable.mk</code>, <code>measurable_mk</code>, and
<code>ae_eq_mk</code> API](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/MeasureSpaceDef.lean#L425-L442).
The project uses this <code>AEMeasurable</code> layer as its primary theorem and
exposes strong-measurability and integrability corollaries.

<a id="ref-birkhoff-event-deep-ergodic"></a>**Mathlib contributors.**
[Ergodic maps and measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/Ergodic.html),
with the pinned
[ordinary measurable rigidity and zero-one law](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Ergodic.lean#L61-L77)
and
[null-measurable quasi-ergodic rigidity](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Ergodic.lean#L135-L162).

<a id="ref-birkhoff-event-deep-normed"></a>**Mathlib contributors.**
[Normed-space Birkhoff sums](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/NormedSpace.html),
with the
[pinned boundedness-based shift convergence results](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/NormedSpace.lean#L68-L100).
These theorems define the novelty boundary accurately: shift infrastructure
already existed, while RMT-22 supplies the real boundedness-free two-way
same-limit statement needed for exact event invariance.

<a id="ref-birkhoff-event-deep-birkhoff"></a>**George D. Birkhoff.**
[Proof of the Ergodic Theorem](https://pmc.ncbi.nlm.nih.gov/articles/PMC1076138/),
*Proceedings of the National Academy of Sciences* 17(12), 656-660, 1931,
DOI
[10.1073/pnas.17.2.656](https://doi.org/10.1073/pnas.17.2.656).
This primary source is the historical pointwise theorem. The current module
formalizes event infrastructure before that existence result.

<a id="ref-birkhoff-event-deep-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source is the later subadditive destination. RMT-22 proves none of
its normalized-process convergence conclusions.

The exact upstream revision audited for this chapter is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the v4.32.0 revision pinned by <code>formalization/lake-manifest.json</code>.
