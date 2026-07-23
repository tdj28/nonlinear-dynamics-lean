---
title: "Subadditive Upper Limsup Bounds Before Kingman Convergence"
slug: "subadditive-upper-limsup-bounds-before-kingman-convergence"
date: 2026-07-22
summary: "Start with an exact two-state subadditive ledger whose block-two integral bound is sharp, then climb through centering, phase averaging, ordinary-map Birkhoff convergence, the honest eventual-lower-bound gate for real limsup, and the cocycle Fekete-rate specialization."
lead: "On a uniform two-state flip, one explicit nonnegative subadditive process has normalized paths converging to one half and a block-two integral ratio equal to one half, even though the squared map is not ergodic. The same arithmetic exposes every term in the RMT-29 proof. A nearby process, Z_n = -n², then shows why Mathlib's real-valued limsup theorem needs an eventual lower bound: without it, totalization can turn an extended-real value of minus infinity into the real number zero. This chapter builds the general Lean interface from those two ledgers without claiming the missing lower-liminf half of Kingman's theorem."
draft: false
pro_reviewed: false
level: "Subadditive processes, ergodic theory, limsup, finite phase averaging, real Bochner integration, and intermediate Lean theorem reading"
reading_time: "225 to 325 minutes, including the runnable Lean worksheet"
prerequisites: "Finite sums, real integrals, almost-everywhere statements, Birkhoff convergence on ergodic probability systems, and deterministic subadditivity; Lean experience is helpful but not required"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveUpperLimsup"
toc: true
og_image: "subadditive-upper-limsup-bounds-before-kingman-convergence-card.png"
og_image_alt: "Warm-paper Deep Dive card for a two-state flip. A table shows the normalized process approaching one half and the block-two integral ratio equal to one half. A separate warning lane shows that the negative-square process has no eventual real lower bound, so the generalized real-limsup gate is essential."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This teaching chapter is published as an open working
note while human editorial, scientific-integrity, and zero-context
expert-reader review remain pending. The checked Lean source is authoritative.
The chapter deliberately omits claims beyond the checked upper-bound scope.
{{< /panel >}}

## Base camp: a fixed block computes the exact upper edge

Take the two-point probability space

\[
\Omega=\{a,b\},
\qquad
\mu(\{a\})=\mu(\{b\})=\frac12,
\]

and let \(T\) swap the points. Define a small potential

\[
\phi(a)=0,
\qquad
\phi(b)=1.
\]

Now define a real process by

\[
X_n(\omega)
{} =
\left\lceil\frac n2\right\rceil
+\phi(T^n\omega)-\phi(\omega).
\]

This is not an invented sequence of unrelated rows. The endpoint terms
telescope across a split:

\[
\begin{aligned}
X_{m+n}(\omega)
&=
\left\lceil\frac{m+n}{2}\right\rceil
+\phi(T^{m+n}\omega)-\phi(\omega)\\
&\le
\left\lceil\frac m2\right\rceil
+\left\lceil\frac n2\right\rceil
+\phi(T^m\omega)-\phi(\omega)\\
&\qquad
+\phi(T^{m+n}\omega)-\phi(T^m\omega)\\
&=X_m(\omega)+X_n(T^m\omega).
\end{aligned}
\]

The only inequality is
\(\lceil(m+n)/2\rceil\le\lceil m/2\rceil+\lceil n/2\rceil\).
Thus \(X\) is a genuine shifted-subadditive process.

### Compute both paths before generalizing

Because \(T^n\) is the identity at even \(n\) and the swap at odd \(n\),

\[
\begin{array}{c|cc}
&X_n(a)&X_n(b)\\ \hline
n\text{ even}&n/2&n/2\\
n\text{ odd}&(n+3)/2&(n-1)/2.
\end{array}
\]

Every entry is nonnegative. The first nine horizons are:

| \(n\) | \(X_n(a)\) | \(X_n(b)\) | \(X_n(a)/n\) | \(X_n(b)/n\) | \(\int X_n\,d\mu\) | \((\int X_n\,d\mu)/n\) |
|---:|---:|---:|---:|---:|---:|---:|
| 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 1 | 2 | 0 | 2 | 0 | 1 | 1 |
| 2 | 1 | 1 | \(1/2\) | \(1/2\) | 1 | \(1/2\) |
| 3 | 3 | 1 | 1 | \(1/3\) | 2 | \(2/3\) |
| 4 | 2 | 2 | \(1/2\) | \(1/2\) | 2 | \(1/2\) |
| 5 | 4 | 2 | \(4/5\) | \(2/5\) | 3 | \(3/5\) |
| 6 | 3 | 3 | \(1/2\) | \(1/2\) | 3 | \(1/2\) |
| 7 | 5 | 3 | \(5/7\) | \(3/7\) | 4 | \(4/7\) |
| 8 | 4 | 4 | \(1/2\) | \(1/2\) | 4 | \(1/2\) |

Lean totalizes division by zero, so the displayed \(n=0\) normalized values
are zero. The asymptotic claim concerns positive horizons.

At \(a\), the odd normalized values are

\[
\frac12+\frac{3}{2n};
\]

at \(b\), they are

\[
\frac12-\frac{1}{2n}.
\]

The even values are exactly \(1/2\). Hence both paths converge to \(1/2\), and
in particular

\[
\limsup_n\frac{X_n(\omega)}n=\frac12
\quad\text{for }\omega=a,b.
\]

Now choose the fixed block \(b=2\). The two block values are both one, so

\[
\frac1{2}\int_\Omega X_2\,d\mu
{} =
\frac12\cdot\frac{1+1}{2}
{} =
\frac12.
\]

The RMT-29 inequality is sharp:

\[
\boxed{\limsup_n\frac{X_n(\omega)}n
\le
\frac1{2}\int_\Omega X_2\,d\mu
=\frac12.}
\]

The direction matters. It says the eventual upper edge of the sample path
cannot exceed the block integral ratio. It does not say that every finite
normalized value is at most \(1/2\): the table contains \(2\), \(1\), and
\(4/5\).

### See the centered proof inside the same numbers

The one-step observable is

\[
X_1(a)=2,
\qquad
X_1(b)=0.
\]

Along either alternating orbit, its Birkhoff averages converge to the uniform
integral \(1\). Subtract its orbit sum:

\[
Y_n(\omega)=X_n(\omega)-S_n(X_1)(\omega).
\]

For both starting points,

\[
Y_n=-\left\lfloor\frac n2\right\rfloor,
\qquad
Y_2=-1.
\]

The centered integral identity at block two is now visible without symbols
hiding the arithmetic:

\[
\int Y_2\,d\mu
{} =
-1
{} =
\int X_2\,d\mu-2\int X_1\,d\mu
{} =
1-2.
\]

The limiting centered contribution is

\[
\frac12\int Y_2\,d\mu=-\frac12,
\]

and adding the one-step Birkhoff limit gives

\[
-\frac12+1=\frac12
=\frac12\int X_2\,d\mu.
\]

For phase averaging, write \(n=2a+r\) with \(r=0\) or \(1\). The proof keeps
the prefix \(2(a-1)\), one block shorter than the target. Its coefficient is

\[
\frac{2(a-1)}{2(2a+r)}
\longrightarrow\frac12.
\]

Both residue lanes therefore use Birkhoff averages under the original flip
\(T\). This is essential: \(T\) is ergodic, while \(T^2\) is the identity and
is not ergodic.

{{< reference-figure
  wide="true"
  src="two-state-subadditive-block-ledger.svg"
  alt="A numerical ledger for a uniform two-state flip and the subadditive process X n omega equals ceiling n over two plus phi of T to the n omega minus phi omega. The table lists both paths through horizon eight, shows normalized values approaching one half, computes the centered values minus floor n over two, and shows that the block-two integral ratio equals the limsup one half. A side panel notes that the flip is ergodic while its square is the identity."
  caption="**Finding:** one exact finite model carries the source proof. The process is nonnegative and subadditive, the two normalized paths approach \(1/2\), \(Y_2=-1\), the one-step integral is \(1\), and \((\int Y_2)/2+\int X_1=1/2=(\int X_2)/2\). Block two is sharp even though \(T^2\) is not ergodic, because the proof averages both residues under \(T\)."
>}}

The measure vocabulary is concrete here. A
{{< refterm "probability-measure" "probability measure" >}} has total mass
one. A
{{< refterm "measure-preserving-transformation" "measure-preserving transformation" >}}
keeps event masses unchanged under preimage. A statement holds
{{< refterm "almost-everywhere" "almost everywhere" >}} if it may fail only
on a {{< refterm "null-set" "null set" >}}. On this uniform two-point space,
the empty set is the only null set, so an almost-everywhere statement holds at
both points.

Let \((\Omega,\mu,T)\) be an ergodic probability-preserving system and let

\[
X_n:\Omega\to\mathbb R,
\qquad n\in\mathbb N,
\]

be an integrable subadditive process. Its defining inequality has the form

\[
X_{m+n}(\omega)
\le
X_m(\omega)+X_n(T^m\omega).
\]

The asymptotic quantity of interest is the normalized samplewise process

\[
\frac{X_n(\omega)}{n}.
\]

Kingman's theorem gives far more than this chapter: under its hypotheses it
identifies an almost-sure limit ([Kingman 1968](#ref-upper-deep-kingman)). The
RMT-29 layer stops at a precise earlier summit. Its generalized theorem assumes
that the normalized path is eventually bounded below almost everywhere. For
each positive block size \(b\), it proves

\[
\limsup_{n\to\infty}\frac{X_n(\omega)}{n}
\le
\frac{1}{b}\int_\Omega X_b\,d\mu
\quad\text{for almost every }\omega.
\]

Pointwise nonnegativity is a sufficient, simpler way to discharge that
lower-bound gate, and the module retains it as a compatibility wrapper. The
log-positive cocycle process uses that wrapper.

For the cocycle log-positive process, intersecting these full-measure events
over all blocks and taking the deterministic infimum gives

\[
\limsup_{n\to\infty}
\frac{\log^+\lVert C(n,\omega)\rVert_\infty}{n}
\le \gamma^+_\mu(C)
\quad\text{almost everywhere}.
\]

Here \(\gamma^+_\mu(C)\) is the integrated Fekete rate formalized earlier.
This is a samplewise upper estimate. It is not convergence, a lower bound, a
signed Lyapunov exponent, or an Oseledets theorem.

The immediate formal predecessors are
[Finite Phase Averaging for Nonpositive Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-phase-averaging-for-nonpositive-subadditive-processes" >}}),
[Ergodic Birkhoff Limits and Normalized Space Averages]({{< relref "/knowledge-base/deep-dives/ergodic-birkhoff-limits-and-normalized-space-averages" >}}),
and the glossary entries on {{< refterm "phase-averaging" "phase averaging" >}},
{{< refterm "limit-superior" "limit superior" >}}, and
{{< refterm "integrated-log-positive-growth-rate" "integrated log-positive growth rates" >}}.
For broader proof lineage, Steele gives a conceptually algorithmic full proof
that begins with a Birkhoff-based centering reduction and then uses an
interval-decomposition argument ([Steele 1989](#ref-upper-deep-steele)).

## Learning objectives

By the end, a reader should be able to:

1. explain why a fixed-block proof must control all residue classes;
2. derive the centered process and reconstruct the normalized original process;
3. explain why ordinary \(T\)-Birkhoff averages replace powered-map averages;
4. calculate the coefficient left by phase averaging;
5. identify where probability and the eventual-lower-bound gate enter, and
   explain why pointwise nonnegativity is only one sufficient wrapper;
6. distinguish a limsup upper bound from a convergence theorem;
7. optimize a countable family of block bounds using a deterministic Fekete rate;
8. read the RMT-29 public theorem surface and its proof obligations; and
9. audit examples that prevent stronger interpretations.

{{< reference-figure
  wide="true"
  src="generic-to-cocycle-ladder.svg"
  alt="A generic theorem ladder starts with an integrable subadditive candidate whose normalized paths are eventually bounded below almost everywhere, produces a fixed-block almost-everywhere limsup bound, enters the nonnegative wrapper for log-positive cocycle observables, intersects the block events, and takes the positive-block Fekete infimum."
  caption="The public interface has three visible levels. The generalized theorem consumes an honest almost-everywhere eventual lower bound; its nonnegative wrapper chooses lower bound zero; the cocycle theorem then enforces every positive block simultaneously and optimizes by the existing deterministic Fekete identity."
>}}

## The two obstacles

### Subadditivity is not additivity

For an observable \(f\), the Birkhoff sum

\[
S_n f(\omega)=\sum_{j=0}^{n-1}f(T^j\omega)
\]

satisfies an exact addition law. A subadditive process supplies only an upper
comparison. Its future block begins at the shifted point \(T^m\omega\), and
repeated decomposition leaves boundaries whose signs matter.

The one-step case nevertheless provides a universal majorant:

\[
X_n(\omega)\le S_n(X_1)(\omega),
\qquad n\gt0.
\]

This controls the sequence from above and later supplies the boundedness
needed by a real-valued limsup lemma.

### Ergodicity need not pass to powers

A tempting block proof studies \(X_b\) along

\[
\omega,T^b\omega,T^{2b}\omega,\ldots
\]

and invokes Birkhoff for \(T^b\). That route silently needs \(T^b\) to be
ergodic. It can fail even when \(T\) is ergodic. On the two-point probability
space, the flip is ergodic but its square is the identity, so the square has
nontrivial invariant events.

Finite phase averaging repairs the proof. It combines the \(b\) starting
phases before taking limits and rewrites the result as an ordinary Birkhoff
sum under \(T\). The asymptotic theorem is therefore applied only to the map
whose ergodicity is actually assumed. Lalley's teaching notes motivate this
ordinary-map route ([Lalley notes](#ref-upper-deep-lalley)); the limiting input
is the checked modern form of Birkhoff's theorem
([Birkhoff 1931](#ref-upper-deep-birkhoff)).

{{< reference-figure
  src="two-cycle-original-vs-square.svg"
  alt="The original Bool flip alternates two equally weighted states and is labeled ergodic. Its second iterate leaves both states fixed and is labeled nonergodic. A highlighted route sends all block phases back to Birkhoff averages under the original flip rather than applying an ergodic theorem to the square."
  caption="Ergodicity need not survive powering. Phase averaging exists here to keep the asymptotic argument under the original transformation, exactly matching the available hypothesis."
>}}

## Center before taking blocks

Define the one-step-centered process

\[
Y_n(\omega)
{} =
X_n(\omega)-S_n(X_1)(\omega).
\]

The one-step majorant gives \(Y_n\le0\) for positive \(n\). This sign is the
entry ticket to the finite phase-averaging theorem. Centering does not claim
that \(Y\) is zero, additive, or nonnegative.

The original process is recovered exactly:

\[
\begin{aligned}
\frac{X_n(\omega)}{n}
&= \frac{Y_n(\omega)}{n}+A_n(X_1)(\omega),
\end{aligned}
\]

where \(A_n\) is the ordinary Birkhoff average. The proof will bound the first
term by block averages of \(Y_b\), then let the second term converge by
RMT-28.

Integration respects this decomposition. Measure preservation and
integrability imply

\[
\int_\Omega S_b(X_1)\,d\mu
{} =
b\int_\Omega X_1\,d\mu,
\]

and hence

\[
\int_\Omega Y_b\,d\mu
{} =
\int_\Omega X_b\,d\mu
-b\int_\Omega X_1\,d\mu.
\]

The second identity is the cancellation mechanism at the end of the limit
calculation.

## Residues recover the full sequence

Fix a positive block size \(b\). Every natural time has a unique residue
modulo \(b\), so it is enough to prove an eventual estimate along every
arithmetic progression

\[
n=b a+r,
\qquad 0\le r\lt b.
\]

For large \(a\), set

\[
m=b(a-1).
\]

The finite phase theorem gives the pointwise estimate

\[
Y_{ba+r}(\omega)
\le
\frac{1}{b}S_{b(a-1)}(Y_b)(\omega).
\]

{{< reference-figure
  wide="true"
  src="block-three-residue-example.svg"
  alt="For block length three, natural times are split into residue lanes zero, one, and two. At a common large quotient a, each target time three a plus r is bounded using a centered Birkhoff prefix that is one complete block shorter. The three eventual lanes cover every sufficiently large time."
  caption="The block-three example makes the indexing visible. One complete block is retained as boundary slack, and the three residue lanes are recombined only after their separate eventual estimates are proved."
>}}

The lost block is deliberate. It absorbs the phase boundaries that cannot be
discarded merely from subadditivity. Dividing by \(ba+r\gt0\) yields

\[
\frac{Y_{ba+r}(\omega)}{ba+r}
\le
A_{b(a-1)}(Y_b)(\omega)
\frac{b(a-1)}{b(ba+r)}.
\]

There are now two independent limits:

\[
A_{b(a-1)}(Y_b)(\omega)
\longrightarrow
\int_\Omega Y_b\,d\mu,
\]

and

\[
\frac{b(a-1)}{b(ba+r)}
\longrightarrow \frac1b.
\]

The first uses ergodic Birkhoff convergence for the original map \(T\). The
second is elementary real asymptotics. Meanwhile,

\[
A_{ba+r}(X_1)(\omega)
\longrightarrow
\int_\Omega X_1\,d\mu.
\]

Adding the limits and inserting the centered integral identity gives

\[
\frac1b\left(\int X_b-b\int X_1\right)+\int X_1
{} =
\frac1b\int X_b.
\]

Because there are only finitely many residues, an eventual estimate on each
progression becomes an eventual estimate on all sufficiently large natural
times. In Lean, `Eventually.atTop_of_arithmetic` packages this passage
([pinned Mathlib source](#ref-upper-deep-mathlib-at-top)).

## From eventual estimates to limsup

The {{< refterm "limit-superior" "limsup" >}} is an order-theoretic tail
operator. In \(\mathbb R\), applying `limsup_le_iff` requires enough
boundedness to keep the result in the conditionally complete order
([pinned Mathlib source](#ref-upper-deep-mathlib-limsup)).

The upper bound comes from the one-step majorant:

\[
\frac{X_n(\omega)}{n}\le A_n(X_1)(\omega),
\]

and the Birkhoff average converges almost everywhere. The lower bound in the
generalized public theorem is supplied directly:

\[
\text{for almost every }\omega,\quad
\left(\frac{X_n(\omega)}n\right)_{n\to\infty}
\text{ is eventually bounded below in }\mathbb R.
\]

In Lean this is the
<code>IsBoundedUnder (· ≥ ·) atTop</code> premise. The relation is written
with \(\ge\) because a lower bound \(L\) satisfies
\(X_n(\omega)/n\ge L\) eventually. The nonnegative wrapper chooses \(L=0\).
The generalized theorem also accepts signed processes whose normalized paths
have some other almost-everywhere lower bound.

### The nearby countermodel: \(Z_n=-n^2\)

The lower-bound premise is not proof bureaucracy. On the one-point
probability system, set

\[
Z_n=-n^2.
\]

This process is integrable and subadditive because

\[
-(m+n)^2\le -m^2-n^2,
\]

and its normalized ledger begins

| \(n\) | \(Z_n\) | totalized \(Z_n/n\) |
|---:|---:|---:|
| 0 | 0 | 0 |
| 1 | \(-1\) | \(-1\) |
| 2 | \(-4\) | \(-2\) |
| 3 | \(-9\) | \(-3\) |
| 4 | \(-16\) | \(-4\) |
| 5 | \(-25\) | \(-5\) |
| 6 | \(-36\) | \(-6\) |

For any proposed real lower bound \(L\) and any proposed tail threshold
\(N\), choose a natural

\[
n\ge N
\quad\text{with}\quad
n\gt-L.
\]

Then \(-n\lt L\). Thus every tail contains a value below \(L\), so no tail
is bounded below.

In the extended real numbers the traditional limsup is \(-\infty\).
Mathlib's <code>Filter.limsup</code> in the conditionally complete order
\(\mathbb R\) is deliberately total. Here every real number is eventually an
upper bound for \(-n\), so its definition becomes

\[
\operatorname{sInf}(\mathbb R)=0
\]

under the pinned real instance. But the block-one integral target is

\[
\frac{\int Z_1\,d\mu}{1}=-1.
\]

Deleting the lower-bound gate would therefore demand the false real
inequality \(0\le-1\). The generalized theorem rejects the model exactly
where it should: its <code>hXlower</code> argument cannot be constructed.
The nonnegative wrapper rejects it earlier.

{{< reference-figure
  wide="true"
  src="real-limsup-lower-bound-gate.svg"
  alt="A numerical boundary ledger for the one-point process Z n equals minus n squared. The normalized values are zero, minus one, minus two, through minus six. Rows show that proposed lower bounds zero, minus one, minus five, and minus twenty are defeated at horizons one, two, six, and twenty-one. A comparison distinguishes the extended-real limsup minus infinity from Mathlib's totalized real limsup zero, and shows that omitting the lower-bound gate would falsely require zero less than or equal to the block-one target minus one."
  caption="**Finding:** \(Z_n=-n^2\) is a nearby integrable subadditive process, but \(Z_n/n=-n\) has no eventual real lower bound. The extended-real limsup is \(-\infty\); the pinned conditionally complete real operation totalizes to \(0\). Since the block-one target is \(-1\), the generalized RMT-29 lower-bound premise prevents a false \(0\le-1\) conclusion."
>}}

The cocycle specialization needs no extra signed lower-bound proof because
\(\log^+\) is pointwise nonnegative by definition; it enters through the
nonnegative wrapper.

## Why probability appears

The Birkhoff endpoint used in the block proof identifies a time average with
the ordinary integral. That exact statement is appropriate on a probability
space. For a finite measure of positive mass \(q\), with \(q\ne1\), the time
average converges to the normalized space average

\[
q^{-1}\int f\,d\mu,
\]

not the raw integral. Consequently the clean block target
\((\int X_b)/b\) is a probability-normalized theorem.

This is separate from measure preservation. Preservation proves that every
shifted copy of an integrable function has the same integral. Probability
turns the invariant constant into the raw integral rather than an integral
divided by total mass.

{{< reference-figure
  src="probability-mass-scaling.svg"
  alt="Two finite preserved systems have identical orbit geometry but positive total masses one and q. The mass-one Birkhoff target is the raw integral, while the mass-q target is the raw integral divided by q. Only the first matches the unrescaled raw-integral Fekete rate."
  caption="Changing total mass changes raw integrals but not normalized time averages. The probability premise aligns those scales; it is not shorthand for preservation, ergodicity, or independence."
>}}

## Optimize over every block

For the cocycle process

\[
X_n(\omega)=\log^+\lVert C(n,\omega)\rVert_\infty,
\]

the generic theorem gives, for every positive \(b\),

\[
L(\omega)
{} :=
\limsup_n\frac{X_n(\omega)}n
\le
\frac1b\int X_b\,d\mu
\]

outside a block-dependent null set. Natural numbers are countable, so the
intersection of these full-measure events is still full measure. At every
point in that intersection, \(L(\omega)\) is below every positive-block
normalized integral.

The earlier deterministic Fekete theorem identifies their infimum with

\[
\gamma^+_\mu(C)
{} =
\inf_{b\ge1}\frac1b\int X_b\,d\mu.
\]

The order step is `le_csInf`: exhibit one member of the set, then prove that
the limsup lies below each member. The witness \(b=1\) proves nonemptiness.
The resulting theorem compares a samplewise limsup with a deterministic
integrated rate, but it does not exchange a limit and an integral.

{{< reference-figure
  wide="true"
  src="upper-half-vs-full-kingman.svg"
  alt="A comparison panel shows RMT-29 proving that the normalized-process limsup lies below the integrated rate. A second, unfinished panel shows the missing lower-liminf inequality that would be needed to squeeze the sequence to a limit. Equality, mean convergence, signed exponents, and invariant splittings are outside both current arrows."
  caption="RMT-29 formalizes the upper half only. A full convergence theorem needs an independently justified lower mechanism and cannot be inferred from the visual similarity of a limsup estimate to Kingman's conclusion."
>}}

## In Lean: seven bridges from the finite ledger to the upper limsup

The two-state calculation used integer and rational tables. The project source
works with arbitrary real integrable shifted-subadditive processes. Read each
bridge across: spoken mathematics, paper notation, exact Lean, and then the
syntax tokens that carry the hypothesis.

### Bridge 1: split the normalized process exactly

{{< lean-bridge
  human="The normalized original process equals the normalized centered process plus the one-step Birkhoff average."
  math="\(X_n(\omega)/n=Y_n(\omega)/n+A_n(X_1)(\omega).\)"
  lean="normalized_eq_centered_add_birkhoffAverage n ω"
>}}

- <code>centeredProcess T X n ω</code> is
  \(Y_n(\omega)=X_n(\omega)-S_n(X_1)(\omega)\).
- <code>birkhoffAverage ℝ T (X 1) n ω</code> is the ordinary real average
  of the one-step observable under the original map \(T\).
- The identity is pointwise algebra. It assumes no measurable space,
  integrability, subadditivity, preservation, probability, or ergodicity.
- At <code>n = 0</code>, Lean's totalized real division makes every normalized
  term zero. The identity remains true but says nothing asymptotic.
{{< /lean-bridge >}}

### Bridge 2: integrate a finite orbit sum

{{< lean-bridge
  human="A measure-preserving map makes every shifted copy have the same integral, so the integral of n orbit terms is n times the original integral."
  math="\(\int S_nf\,d\mu=n\int f\,d\mu.\)"
  lean="integral_birkhoffSum_eq_nat_mul hT hf n"
>}}

- <code>hT : MeasurePreserving T μ μ</code> supplies measurability and the
  equality between the pushed-forward measure and \(\mu\).
- <code>hf : Integrable f μ</code> makes every finite pullback integrable.
- <code>n : ℕ</code> may be zero. The empty sum and the scalar product
  \(0\int f\) are both zero.
- No finite-mass, probability, ergodicity, or subadditivity premise occurs.
{{< /lean-bridge >}}

### Bridge 3: integrate the center

{{< lean-bridge
  human="The centered block integral is the original block integral minus b copies of the one-step integral."
  math="\(\int Y_b\,d\mu=\int X_b\,d\mu-b\int X_1\,d\mu.\)"
  lean="hX.integral_centeredProcess hT b"
>}}

- <code>hX : IsIntegrableSubadditiveProcessCandidate T μ X</code> provides
  integrability of every \(X_n\).
- <code>hT : MeasurePreserving T μ μ</code> lets Bridge 2 integrate the
  one-step orbit sum.
- The theorem does not yet assume probability or ergodicity and states no
  limit.
- In base camp at \(b=2\), the exact values are \(-1=1-2\cdot1\).
{{< /lean-bridge >}}

### Bridge 4: keep every residue lane under one ordinary-map sum

{{< lean-bridge
  human="For a positive block b, phase averaging bounds the centered target at bq+b+r by one Birkhoff sum of the centered b-block observable, divided by b."
  math="\(Y_{bq+b+r}(\omega)\le b^{-1}S_{bq}(Y_b)(\omega).\)"
  lean="hX.centeredProcess_le_birkhoffSum_phase_average_div b q r hb ω"
>}}

- <code>q</code> counts complete retained blocks and <code>r</code> is a
  residue. RMT-29 later substitutes <code>q = a - 1</code>.
- <code>hb : b ≠ 0</code> is the exact positive-block gate needed to divide
  by the natural block length.
- The sum is <code>birkhoffSum T</code>, using the original map \(T\), not
  \(T^b\).
- This imported RMT-20 theorem is finite and pointwise. It assumes neither
  probability nor ergodicity.
{{< /lean-bridge >}}

### Bridge 5: state the generalized fixed-block theorem

{{< lean-bridge
  human="If almost every normalized path has some eventual real lower bound, then its real limsup is at most the normalized integral of any chosen positive block."
  math="\(\bigl(X_n(\omega)/n\text{ eventually bounded below a.e.}\bigr)\Longrightarrow\limsup_n X_n(\omega)/n\le b^{-1}\int X_b\,d\mu\text{ a.e.}\)"
  lean="hX.ae_limsup_normalized_le_blockIntegral_of_ae_isBoundedUnder_ge hT hXlower b hb"
>}}

- <code>[IsProbabilityMeasure μ]</code> aligns the ergodic Birkhoff limit with
  the raw integral.
- <code>hT : Ergodic T μ</code> supplies preservation and the constant
  almost-everywhere Birkhoff limit under the original map.
- <code>hXlower</code> has exact type
  <code>∀ᵐ ω ∂μ, IsBoundedUnder (· ≥ ·) atTop
  (fun n ↦ X n ω / (n : ℝ))</code>.
- <code>∀ᵐ ω ∂μ</code> reads “for almost every \(\omega\) with respect to
  \(\mu\).” Inside it, <code>(· ≥ ·)</code> encodes an eventual lower bound.
- This is the generalized current interface. It accepts signed processes when
  their normalized paths meet the lower-bound gate.
{{< /lean-bridge >}}

### Bridge 6: discharge the gate with nonnegativity

{{< lean-bridge
  human="A pointwise nonnegative process has zero as a lower bound, so it inherits the same fixed-block limsup estimate."
  math="\(0\le X_n(\omega)\Longrightarrow\limsup_n X_n(\omega)/n\le b^{-1}\int X_b\,d\mu\text{ a.e.}\)"
  lean="hX.ae_limsup_normalized_le_blockIntegral hT hXnonneg b hb"
>}}

- <code>hXnonneg : ∀ n ω, 0 ≤ X n ω</code> proves that every normalized term
  is at least zero, including totalized time zero.
- The wrapper constructs <code>hXlower</code> and calls Bridge 5. It is not the
  most general theorem.
- Base camp and the log-positive cocycle process use this route.
- The negative-square countermodel satisfies subadditivity but cannot supply
  <code>hXnonneg</code> or the generalized lower-bound premise.
{{< /lean-bridge >}}

### Bridge 7: optimize the cocycle bounds over every block

{{< lean-bridge
  human="For a discrete matrix cocycle with integrable one-step log-positive growth, the samplewise normalized log-positive limsup is at most the deterministic integrated Fekete rate almost everywhere."
  math="\(\limsup_n n^{-1}\log^+\lVert C(n,\omega)\rVert_\infty\le\gamma_\mu^+(C)\text{ for }\mu\text{-almost every }\omega.\)"
  lean="hC.ae_limsup_normalized_le_integratedLogPlusGrowthRate hT"
>}}

- <code>hC : C.HasIntegrableGeneratorLogPlus</code> supplies the integrable
  subadditive candidate and its pointwise nonnegativity.
- <code>hT : Ergodic C.base μ</code> concerns the cocycle's original base map.
- <code>ae_all_iff</code> intersects the block-dependent conull events over
  all natural \(b\).
- <code>integratedLogPlusGrowthRate_eq_sInf</code> rewrites the deterministic
  rate as the infimum of positive-block ratios; <code>le_csInf</code> uses the
  blockwise inequalities.
- The result is only an upper limsup bound. It supplies neither a lower liminf
  nor convergence.
{{< /lean-bridge >}}

### Try the exact declarations in the repository

{{< repo-check >}}
The authoritative source is
[<code>formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveUpperLimsup.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveUpperLimsup.lean).
For a **full project check**, save this temporary query as
<code>formalization/NonlinearDynamics/SubadditiveUpperLimsupChecks.lean</code>:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.SubadditiveUpperLimsup

open MeasureTheory Set Filter Topology Finset Function
open NonlinearDynamics.Random.RandomCocycles

-- Imported finite bridges used by RMT-29.
#check normalized_eq_centered_add_birkhoffAverage
#check IsIntegrableSubadditiveProcessCandidate.centeredProcess_le_birkhoffSum_phase_average_div

-- The five RMT-29 public declarations, in source order.
#check integral_birkhoffSum_eq_nat_mul
#check IsIntegrableSubadditiveProcessCandidate.integral_centeredProcess
#check IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral_of_ae_isBoundedUnder_ge
#check IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_limsup_normalized_le_integratedLogPlusGrowthRate
~~~

Then type:

~~~sh
cd formalization
lake env lean NonlinearDynamics/SubadditiveUpperLimsupChecks.lean
~~~

Delete the temporary query file afterward. To compile the authoritative module
itself, type:

~~~sh
cd formalization
lake env lean NonlinearDynamics/Random/RandomCocycles/SubadditiveUpperLimsup.lean
~~~

These commands import the pinned project and Mathlib and may require
substantial disk space and memory.
{{< /repo-check >}}

## Type the finite process and lower-bound ledgers with Lean and `Std`

The next worksheet uses exact integers and rationals. It computes both paths
of the two-state process through horizon eight, its centered values, block
ratios, and phase coefficients. It also computes the negative-square ledger
and concrete witnesses defeating several proposed lower bounds.

The finite Boolean checks test subadditivity and nonnegativity through horizon
twelve; they illustrate the formula but are not the general Mathlib proof.
The worksheet does not define a measure, a filter, or an infinite limsup.
Save this exact text as
<code>/tmp/SubadditiveUpperLimsupTutorial.lean</code>:

~~~lean
import Std

namespace SubadditiveUpperLimsupTutorial

inductive Point where
  | a
  | b
  deriving Repr, DecidableEq

def step : Point → Point
  | .a => .b
  | .b => .a

def iterate : Nat → Point → Point
  | 0, p => p
  | n + 1, p => iterate n (step p)

def phi : Point → Int
  | .a => 0
  | .b => 1

def ceilHalf (n : Nat) : Nat := (n + 1) / 2

def process (n : Nat) (p : Point) : Int :=
  (ceilHalf n : Int) + phi (iterate n p) - phi p

def oneStep : Point → Int := process 1

def orbitSum (n : Nat) (f : Point → Int) (p : Point) : Int :=
  ((List.range n).map fun j => f (iterate j p)).sum

def centered (n : Nat) (p : Point) : Int :=
  process n p - orbitSum n oneStep p

def normalize (z : Int) (n : Nat) : Rat :=
  if n = 0 then 0 else (z : Rat) / (n : Rat)

def integralTwo (f : Point → Int) : Rat :=
  ((f .a : Rat) + (f .b : Rat)) / 2

def processIntegral (n : Nat) : Rat := integralTwo (process n)

def centeredIntegral (n : Nat) : Rat := integralTwo (centered n)

def blockTarget (b : Nat) : Rat :=
  if b = 0 then 0 else processIntegral b / (b : Rat)

def processLedger (n : Nat) :=
  (n, process n .a, process n .b,
    normalize (process n .a) n, normalize (process n .b) n,
    processIntegral n, blockTarget n)

def blockPrefix (b a : Nat) : Nat := b * (a - 1)

def blockCoefficient (b r a : Nat) : Rat :=
  (blockPrefix b a : Rat) / ((b : Rat) * (b * a + r : Rat))

def subadditiveThrough (bound : Nat) : Bool :=
  (List.range (bound + 1)).all fun m =>
    (List.range (bound + 1)).all fun n =>
      [.a, .b].all fun p =>
        process (m + n) p ≤ process m p + process n (iterate m p)

def nonnegativeThrough (bound : Nat) : Bool :=
  (List.range (bound + 1)).all fun n =>
    [.a, .b].all fun p => 0 ≤ process n p

def negativeProcess (n : Nat) : Int := -((n * n : Nat) : Int)

def normalizedNegative (n : Nat) : Rat := normalize (negativeProcess n) n

def lowerWitness (lower : Int) : Nat := lower.natAbs + 1

def lowerWitnessRow (lower : Int) :=
  let n := lowerWitness lower
  (lower, n, normalizedNegative n,
    decide (normalizedNegative n < (lower : Rat)))

#eval (List.range 9).map processLedger
#eval (List.range 9).map fun n => (n, centered n .a, centered n .b)
#eval (centeredIntegral 2, processIntegral 1,
  centeredIntegral 2 / 2 + processIntegral 1, blockTarget 2)
#eval (List.range 6).map fun b => (b + 1, blockTarget (b + 1))
#eval [2, 3, 4, 5, 6].map fun a =>
  (a, blockCoefficient 2 0 a, blockCoefficient 2 1 a)
#eval (List.range 7).map fun n => (n, negativeProcess n, normalizedNegative n)
#eval [0, -1, -5, -20].map lowerWitnessRow
#eval (0 : Rat) ≤ (-1 : Rat)

example : subadditiveThrough 12 = true := by native_decide
example : nonnegativeThrough 12 = true := by native_decide
example :
    (List.range 9).map (fun n => centered n .a) =
      [0, 0, -1, -1, -2, -2, -3, -3, -4] := by
  native_decide
example : blockTarget 1 = 1 := by native_decide
example : blockTarget 2 = 1 / 2 := by native_decide
example :
    [0, -1, -5, -20].all (fun lower =>
      let n := lowerWitness lower
      normalizedNegative n < (lower : Rat)) = true := by
  native_decide

end SubadditiveUpperLimsupTutorial
~~~

From any directory, type:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean \
  /tmp/SubadditiveUpperLimsupTutorial.lean
~~~

The byte-for-byte standard output emitted by Lean is:

~~~text
[(0, 0, 0, 0, 0, 0, 0),
 (1, 2, 0, 2, 0, 1, 1),
 (2, 1, 1, (1 : Rat)/2, (1 : Rat)/2, 1, (1 : Rat)/2),
 (3, 3, 1, 1, (1 : Rat)/3, 2, (2 : Rat)/3),
 (4, 2, 2, (1 : Rat)/2, (1 : Rat)/2, 2, (1 : Rat)/2),
 (5, 4, 2, (4 : Rat)/5, (2 : Rat)/5, 3, (3 : Rat)/5),
 (6, 3, 3, (1 : Rat)/2, (1 : Rat)/2, 3, (1 : Rat)/2),
 (7, 5, 3, (5 : Rat)/7, (3 : Rat)/7, 4, (4 : Rat)/7),
 (8, 4, 4, (1 : Rat)/2, (1 : Rat)/2, 4, (1 : Rat)/2)]
[(0, 0, 0), (1, 0, 0), (2, -1, -1), (3, -1, -1), (4, -2, -2), (5, -2, -2), (6, -3, -3), (7, -3, -3), (8, -4, -4)]
(-1, 1, (1 : Rat)/2, (1 : Rat)/2)
[(1, 1), (2, (1 : Rat)/2), (3, (2 : Rat)/3), (4, (1 : Rat)/2), (5, (3 : Rat)/5), (6, (1 : Rat)/2)]
[(2, (1 : Rat)/4, (1 : Rat)/5),
 (3, (1 : Rat)/3, (2 : Rat)/7),
 (4, (3 : Rat)/8, (1 : Rat)/3),
 (5, (2 : Rat)/5, (4 : Rat)/11),
 (6, (5 : Rat)/12, (5 : Rat)/13)]
[(0, 0, 0), (1, -1, -1), (2, -4, -2), (3, -9, -3), (4, -16, -4), (5, -25, -5), (6, -36, -6)]
[(0, 1, -1, true), (-1, 2, -2, true), (-5, 6, -6, true), (-20, 21, -21, true)]
false
~~~

The first ledger columns are
\((n,X_n(a),X_n(b),X_n(a)/n,X_n(b)/n,\int X_n,\int X_n/n)\).
The second is the centered ledger. The four-tuple
\((-1,1,1/2,1/2)\) is the block-two cancellation. The next outputs list the
block ratios and the two residue coefficients. Each <code>true</code> in the
negative-square witness list says that the displayed horizon falls below the
proposed lower bound. The final <code>false</code> is the invalid conclusion
\(0\le-1\).

**Standalone tutorial, suitable for a normal macOS or Linux machine.** It
imports only <code>Std</code> and never opens the project's Mathlib dependency
graph. This exact file and output were checked with the pinned Lean 4.32.0
toolchain. The exact project module uses the full project commands above.

## Complete source-order declaration, private-helper, and probe map

The checked source is 428 lines and has SHA-256
<code>c39c8b3547ab0cfe949a8859d76ad226c1bef71d3648fc61c76487bb825bf1b9</code>.
It contains five public declarations, fourteen private support items,
three anonymous compiled probes, and five axiom queries. The full sequence is:

| No. | Visibility | Source item | Exact role |
|---:|---|---|---|
| 1 | public | <code>integral_birkhoffSum_eq_nat_mul</code> | Integrates a finite orbit sum under measure preservation |
| 2 | private | <code>blockPrefix</code> | Defines the one-block-short prefix \(b(a-1)\) |
| 3 | private | <code>tendsto_blockPrefix</code> | Proves that prefix tends to infinity for \(b\ne0\) |
| 4 | private | <code>tendsto_arithmetic</code> | Proves each lane \(a\mapsto ba+r\) is cofinal |
| 5 | private | <code>tendsto_blockCoefficient</code> | Sends the phase coefficient to \(1/b\) |
| 6 | public | <code>IsIntegrableSubadditiveProcessCandidate.integral_centeredProcess</code> | Computes \(\int Y_b=\int X_b-b\int X_1\) |
| 7 | public | <code>IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral_of_ae_isBoundedUnder_ge</code> | Generalized fixed-block theorem under an almost-everywhere eventual lower bound |
| 8 | public | <code>IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral</code> | Nonnegative compatibility wrapper for item 7 |
| 9 | public | <code>DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_limsup_normalized_le_integratedLogPlusGrowthRate</code> | Intersects all block bounds and applies the Fekete infimum |
| 10 | private | <code>rmt29ZeroProcess</code> | Defines the totalized zero boundary process |
| 11 | private | <code>rmt29ZeroProcess_candidate</code> | Packages it as an integrable subadditive candidate |
| 12 | private | <code>rmt29Flip</code> | Defines the Boolean flip |
| 13 | private | <code>rmt29TwoCycleMeasure</code> | Defines the equally weighted two-point measure |
| 14 | private | probability instance | Proves the two-point measure has total mass one |
| 15 | private | <code>rmt29Flip_measurePreserving_twoCycle</code> | Proves the flip preserves the two-point measure |
| 16 | private | <code>rmt29Flip_preErgodic_twoCycle</code> | Proves invariant sets are null or conull |
| 17 | private | <code>rmt29Flip_ergodic_twoCycle</code> | Combines preservation and pre-ergodicity |
| 18 | private | <code>rmt29Flip_square_eq_id</code> | Computes the square of the flip |
| 19 | private | <code>rmt29Flip_square_not_ergodic</code> | Proves that identity square is not ergodic here |
| 20 | probe | horizon-zero integral example | Checks totality of the empty Birkhoff sum identity |
| 21 | probe | zero-process limsup example | Applies the nonnegative wrapper at block one |
| 22 | probe | ergodic-flip/block-two example | Applies the theorem although the powered map is nonergodic |
| 23 | axiom query | item 1 | Audits the finite integration theorem |
| 24 | axiom query | item 6 | Audits centered integration |
| 25 | axiom query | item 7 | Audits the generalized lower-bounded theorem |
| 26 | axiom query | item 8 | Audits the nonnegative wrapper |
| 27 | axiom query | item 9 | Audits the cocycle specialization |

The proof of item 7 first combines the supplied lower bound with the
one-step-Birkhoff upper bound so <code>limsup_le_iff</code> is legal in
\(\mathbb R\). It then enters every arithmetic lane, composes the two Birkhoff
limits with private items 3 and 4, multiplies by the coefficient from private
item 5, applies finite phase averaging, and recombines the lanes. Item 8 does
only one new thing: it constructs lower bound zero and invokes item 7.

## Boundary models

### Negative-square process and the real-limsup gate

**Status:** explanatory countermodel for the generalized signature, not one of
the three anonymous compiled probes.

The earlier \(Z_n=-n^2\) ledger is subadditive and integrable but has no
eventual real lower bound after normalization. It therefore explains why item
7 exposes <code>hXlower</code>. The module's compiled probes test totalized
zero and powered-map behavior; they do not compile this negative process.

### Positive additive one-point model

**Status:** explanatory sharpness model, not one of the three compiled
anonymous examples in the RMT-29 module.

On a one-point probability space let \(X_n=cn\) with \(c\ge0\). The process
is additive, every normalized value is \(c\), and

\[
\frac1b\int X_b\,d\mu=c.
\]

The theorem is sharp at every block size.

### Zero process and time zero

**Status:** represented by compiled boundary support and an anonymous example.

If \(X_n=0\), every conclusion is equality. The normalized expression at
time zero is also totalized by Lean's real division, but the asymptotic proof
works eventually at positive times. No growth interpretation is assigned to
division by a zero horizon.

### The flip blocks powered-map reasoning

**Status:** represented by the compiled Bool boundary and block-two example.

Let \(T\) swap two equally weighted points. Then \(T\) is ergodic while
\(T^2\) is the identity and is not ergodic. A proof that assumes Birkhoff
convergence for \(T^2\) from ergodicity of \(T\) is invalid. The RMT-29 proof
uses phase averaging and Birkhoff only for \(T\).

### Empty matrix index

**Status:** explanatory signature audit, not one of the three compiled
anonymous examples in the RMT-29 module.

The cocycle theorem does not need a positive matrix dimension. With an empty
finite index type, matrix definitions and nonnegativity remain total. This
boundary demonstrates that no hidden inhabitant is required.

## What is proved, and what is not

The checked layer proves:

- exact finite Birkhoff-sum integration under measure preservation;
- exact centered-block integration;
- a generic almost-everywhere upper limsup bound for integrable subadditive
  candidates whose normalized paths are eventually bounded below almost
  everywhere on an ergodic probability system;
- a pointwise-nonnegative compatibility wrapper for that theorem; and
- the corresponding integrated-rate bound for log-positive matrix cocycles.

It does not prove:

- a matching lower liminf bound;
- convergence of \(X_n/n\);
- the full subadditive ergodic theorem;
- equality with the integrated rate;
- convergence in \(L^1\);
- an interchange of limit and integral;
- a signed logarithmic growth theorem;
- existence of Lyapunov exponents in the usual signed sense;
- an Oseledets splitting;
- mixing, independence, or powered-map ergodicity; or
- any quantitative rate of convergence.

## Thirty-two solved exercises

### Exercise 1: check the one-step majorant

Why is \(X_n\le S_n(X_1)\) a natural induction?

**Solution.** Split the successor horizon as \(n\) followed by \(1\).
Subadditivity gives
\(X_{n+1}\le X_n+X_1\circ T^n\); the induction hypothesis appends this last
shifted one-step term to \(S_n(X_1)\). The positive-horizon induction starts at
\(n=1\), where equality holds.

### Exercise 2: determine the sign of the center

What sign does \(Y_n=X_n-S_n(X_1)\) have for positive \(n\)?

**Solution.** The one-step majorant gives \(Y_n\le0\).

### Exercise 3: reconstruct the process

Solve the definition of \(Y_n\) for \(X_n/n\).

**Solution.** Divide \(X_n=Y_n+S_n(X_1)\) by \(n\gt0\) to obtain
\(X_n/n=Y_n/n+A_n(X_1)\).

### Exercise 4: integrate an orbit sum

Why is \(\int S_bf=b\int f\)?

**Solution.** Integrate the finite sum termwise. Each iterate preserves the
measure, so every pullback term has integral \(\int f\). There are \(b\)
terms.

### Exercise 5: integrate the center

Compute \(\int Y_b\).

**Solution.** Linearity and Exercise 4 give
\(\int Y_b=\int X_b-b\int X_1\).

### Exercise 6: find the missing block

For \(n=ba+r\), why use \(m=b(a-1)\) rather than \(ba\)?

**Solution.** The finite phase theorem must retain boundary corrections. One
complete block is sacrificed so every phase row fits the common horizon.

### Exercise 7: calculate the coefficient

Evaluate
\(b(a-1)/(b(ba+r))\) as \(a\to\infty\).

**Solution.** Divide numerator and denominator by \(a\). The limit is
\(b/(b^2)=1/b\) because \(b\gt0\).

### Exercise 8: explain the residue bound

Why require \(0\le r\lt b\)?

**Solution.** Those are exactly the finitely many residues modulo \(b\), so
their arithmetic progressions cover every natural time.

### Exercise 9: prove the arithmetic map diverges

Why does \(a\mapsto ba+r\) tend to infinity?

**Solution.** Since \(b\ge1\), one has \(a\le ba\le ba+r\).

### Exercise 10: prove the prefix diverges

Why does \(a\mapsto b(a-1)\) tend to infinity?

**Solution.** Beyond any finite prefix, \(a-1\) tends to infinity, and
multiplication by the positive integer \(b\) preserves divergence.

### Exercise 11: identify the Birkhoff map

Which transformation appears in the limiting averages?

**Solution.** The original map \(T\), both for \(Y_b\) and for \(X_1\).

### Exercise 12: reject the powered-map shortcut

Why is `Ergodic T` insufficient for a direct \(T^b\) Birkhoff call?

**Solution.** Ergodicity need not pass to powers. The two-point flip with
\(b=2\) is a counterexample.

### Exercise 13: combine the limiting constants

Simplify \((\int Y_b)/b+\int X_1\).

**Solution.** Substitute the centered integral formula. The one-step terms
cancel, leaving \((\int X_b)/b\).

### Exercise 14: locate probability

Where does mass one matter?

**Solution.** It identifies the ergodic Birkhoff constant with the raw
integral rather than the integral divided by total mass.

### Exercise 15: locate measure preservation

Where is preservation used before the limit theorem?

**Solution.** It makes every shifted pullback of an integrable observable have
the same integral, yielding the finite Birkhoff-sum integral identity.

### Exercise 16: locate the generalized lower-bound gate

Where does eventual lower-boundedness enter the generalized proof?

**Solution.** Together with the one-step-Birkhoff upper bound, it supplies the
two order bounds needed to use <code>limsup_le_iff</code> in the conditionally
complete real order. Pointwise nonnegativity is used only by the wrapper to
choose the lower bound zero.

### Exercise 17: test a negative process

Show that \(X_n=-n^2\) is subadditive.

**Solution.** Since \((m+n)^2\ge m^2+n^2\), negation reverses the inequality.

### Exercise 18: normalize the negative process

What is \(X_n/n\) for positive \(n\)?

**Solution.** It is \(-n\), which is not bounded below in \(\mathbb R\).

### Exercise 19: test the zero process

What does the block theorem say for \(X_n=0\)?

**Solution.** Both limsup and block integral ratio are zero, so the inequality
is equality.

### Exercise 20: test a sharp positive process

What does the theorem say for \(X_n=cn\) with \(c\ge0\) on one point?

**Solution.** Every normalized term and every normalized block integral is
\(c\), so the estimate is sharp.

### Exercise 21: separate limsup from limit

Does \(\limsup a_n\le L\) imply \(a_n\to L\)?

**Solution.** No. The sequence alternating between \(0\) and \(1\) has
limsup \(1\) but does not converge.

### Exercise 22: identify the missing half

What kind of inequality would complement the upper bound?

**Solution.** A lower estimate of the form
\(\liminf X_n/n\ge\gamma\), together with the reverse comparison needed to
identify both quantities.

### Exercise 23: take the block infimum

If \(L\le a_b\) for every \(b\ge1\), what follows?

**Solution.** Nonemptiness plus the inequalities \(L\le a_b\) lets `le_csInf`
conclude \(L\le\inf_{b\ge1}a_b\).

### Exercise 24: witness nonemptiness

Which block is the simplest witness for the Fekete set?

**Solution.** Block \(b=1\).

### Exercise 25: intersect the events

Why can the proof enforce every positive-block inequality simultaneously?

**Solution.** Positive natural numbers are countable, and a countable
intersection of full-measure events has full measure.

### Exercise 26: inspect time zero

Why is \(X_0/0\) not an analytic premise?

**Solution.** Lean's real division is total, but the proof eventually works
only at positive times and the Fekete infimum ranges over positive blocks.

### Exercise 27: explain log-positive nonnegativity

Why does the cocycle endpoint inherit the generic lower bound?

**Solution.** By definition \(\log^+x=\max(\log x,0)\), so the observable is
pointwise nonnegative at every horizon.

### Exercise 28: reject a signed exponent claim

Why is the endpoint not a signed Lyapunov exponent theorem?

**Solution.** Positive clipping erases contraction. A negative logarithmic
growth rate can produce the identically zero log-positive process.

### Exercise 29: reject independence

Where are independent orbit samples assumed?

**Solution.** Nowhere. The proof uses deterministic subadditivity, measure
preservation, ergodicity, integrability, and finite phase averaging.

### Exercise 30: reject a limit-integral exchange

Does the cocycle endpoint prove
\(\int\lim X_n/n=\lim\int X_n/n\)?

**Solution.** No. It compares a pointwise limsup to an independently defined
deterministic infimum of finite-horizon integrals.

### Exercise 31: audit the empty index

Why need no `Nonempty ι` hypothesis in the cocycle theorem?

**Solution.** The finite-dimensional matrix and norm interfaces used by the
theorem are total for an empty finite index. The proof never chooses an index.

### Exercise 32: state the exact summit

Give the strongest honest one-sentence conclusion.

**Solution.** For an ergodic probability-base discrete matrix cocycle with an
integrable one-step log-positive envelope, the samplewise normalized
log-positive norm has limsup at most the integrated log-positive Fekete rate
almost everywhere.

## Continue to the finite lower-bound bridge

[Finite Bad-Block Measure Bounds Before Kingman's Lower Liminf]({{< relref "/knowledge-base/deep-dives/finite-bad-block-measure-bounds-before-kingman-lower-liminf" >}})
develops the next checked layer. It turns visits to strict centered short-block
failures into a finite real-measure ratio through ordered interval packing.
That chapter still stops before the ergodic lower-liminf conclusion.

[The Guarded Real-Liminf Bridge to Log-Positive Kingman Convergence]({{< relref "/knowledge-base/deep-dives/guarded-real-liminf-bridge-to-log-positive-kingman-convergence" >}})
continues through the later rational null-event layer, exposes Mathlib's exact
real-boundedness gates, and completes the log-positive convergence assembly.
This later result does not change the one-sided scope of RMT-29 itself.

## Full project check

After installing the repository's pinned dependencies, run this from the
repository root:

```sh
cd formalization
lake env lean NonlinearDynamics/Random/RandomCocycles/SubadditiveUpperLimsup.lean
```

This command may compile substantial parts of the pinned Mathlib graph and
therefore may require substantial disk space and memory. The Standalone
tutorial above remains the lighter route for following the arithmetic
interactively.

## References

<a id="ref-upper-deep-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://academic.oup.com/jrsssb/article/30/3/499/7026968),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968,
[doi:10.1111/j.2517-6161.1968.tb00749.x](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x).
This is the primary source for the full asymptotic theorem. RMT-29 formalizes
only the upper-limsup component described above.

<a id="ref-upper-deep-steele"></a>**J. Michael Steele.**
[Kingman's subadditive ergodic theorem](https://www.numdam.org/item/AIHPB_1989__25_1_93_0/),
*Annales de l'Institut Henri Poincaré, Probabilités et Statistiques* 25(1),
93-98, 1989. Steele gives a conceptually algorithmic full proof, beginning
with a Birkhoff-based centering reduction and then using an
interval-decomposition argument. It is proof-lineage context, not a Lean
dependency.

<a id="ref-upper-deep-lalley"></a>**Steven P. Lalley.**
[Kingman's Subadditive Ergodic Theorem](https://galton.uchicago.edu/~lalley/Courses/Graz/Kingman.pdf),
University of Chicago lecture notes, undated, accessed 2026-07-22. The notes
explain why \(T^b\) need not be ergodic and motivate averaging all phases so
ordinary \(T\)-Birkhoff convergence applies. They are a pedagogical source,
not a primary theorem source; RMT-20 separately audits a finite boundary
inconsistency in their displayed rows.

<a id="ref-upper-deep-birkhoff"></a>**George D. Birkhoff.**
[Proof of the Ergodic Theorem](https://doi.org/10.1073/pnas.17.2.656),
*Proceedings of the National Academy of Sciences* 17(12), 656-660, 1931.
This is the historical source for the individual ergodic theorem used only
through the repository's checked RMT-28 interface.

<a id="ref-upper-deep-mathlib-limsup"></a>**Mathlib contributors.**
[Liminf and limsup](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/LiminfLimsup.lean),
Mathlib commit `81a5d257`. The pinned source supplies `limsup_le_iff`.

<a id="ref-upper-deep-mathlib-at-top"></a>**Mathlib contributors.**
[Arithmetic progressions at `atTop`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/Filter/AtTopBot/Finite.lean),
Mathlib commit `81a5d257`. The pinned source supplies
`Eventually.atTop_of_arithmetic`.
