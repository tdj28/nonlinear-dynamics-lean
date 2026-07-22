---
title: "Subadditive Upper Limsup Bounds Before Kingman Convergence"
slug: "subadditive-upper-limsup-bounds-before-kingman-convergence"
date: 2026-07-22
summary: "A textbook derivation of how centering, finite phase averaging, ordinary-map Birkhoff convergence, and deterministic Fekete rates produce a samplewise subadditive upper limsup bound without yet proving Kingman convergence."
lead: "A subadditive process is not an additive orbit sum, and an ergodic map can have a nonergodic power. This chapter develops the finite-block route around both obstacles: subtract the one-step orbit majorant, average every residue phase, return to Birkhoff averages under the original map, and optimize the resulting family of block bounds."
draft: true
pro_reviewed: false
level: "Subadditive processes, ergodic theory, limsup, finite phase averaging, real Bochner integration, and intermediate Lean theorem reading"
reading_time: "180 to 260 minutes"
prerequisites: "Finite sums, real integrals, almost-everywhere statements, Birkhoff convergence on ergodic probability systems, and deterministic subadditivity; Lean experience is helpful but not required"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveUpperLimsup"
toc: true
og_image: "subadditive-upper-limsup-bounds-before-kingman-convergence-card.png"
og_image_alt: "Warm-paper Deep Dive card showing fixed-block residue lanes feeding original-map Birkhoff averages and an upper limsup bound, while a separate unproved lower-liminf lane prevents a full Kingman convergence claim."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is a draft teaching chapter pending human
editorial, scientific-integrity, and zero-context expert-reader review. The
checked Lean source is authoritative. The chapter deliberately omits claims
beyond the checked upper-bound scope.
{{< /panel >}}

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
RMT-29 layer stops at a precise earlier summit. For a pointwise nonnegative
integrable candidate it proves, for each positive block size \(b\),

\[
\limsup_{n\to\infty}\frac{X_n(\omega)}{n}
\le
\frac{1}{b}\int_\Omega X_b\,d\mu
\quad\text{for almost every }\omega.
\]

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
5. identify where probability and pointwise nonnegativity enter;
6. distinguish a limsup upper bound from a convergence theorem;
7. optimize a countable family of block bounds using a deterministic Fekete rate;
8. read the RMT-29 public theorem surface and its proof obligations; and
9. audit examples that prevent stronger interpretations.

{{< reference-figure
  wide="true"
  src="generic-to-cocycle-ladder.svg"
  alt="A generic theorem ladder starts with a nonnegative integrable subadditive candidate on an ergodic probability base, produces a fixed-block almost-everywhere limsup bound, specializes to log-positive cocycle observables, intersects the block events, and takes the positive-block Fekete infimum."
  caption="The public interface has two levels. The generic theorem controls any chosen positive block; the cocycle theorem supplies nonnegativity and integrability, enforces all blocks simultaneously, and optimizes by the existing deterministic Fekete identity."
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
public generic theorem comes from the explicit pointwise premise
\(0\le X_n(\omega)\). Thus every normalized term is nonnegative.

This hypothesis is not decorative. A generic integrable subadditive process
can have unbounded negative normalized values. The scalar process
\(X_n=-n^2\) is subadditive because

\[
-(m+n)^2\le -m^2-n^2,
\]

but \(X_n/n=-n\) has no real lower bound along `atTop`. In the extended reals
its traditional limsup is \(-\infty\). Mathlib's conditionally complete real
`Filter.limsup` instead totalizes this sequence to `sInf univ = 0`, because
every real is eventually an upper bound. The positive-block target is \(-b\),
so removing nonnegativity would produce the false inequality \(0\le-b\).
Nonnegativity is therefore theorem scope, not merely a convenience for
`limsup_le_iff`. The cocycle specialization needs no new assumption because
\(\log^+\) is pointwise nonnegative by definition.

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

## The exact public interface

The RMT-29 module exposes four declarations in proof dependency order:

| Declaration | Mathematical role |
|---|---|
| `integral_birkhoffSum_eq_nat_mul` | Integrates a finite Birkhoff sum as the horizon times the one-step integral |
| `IsIntegrableSubadditiveProcessCandidate.integral_centeredProcess` | Computes the integral of the centered block observable |
| `IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral` | Gives the generic almost-everywhere fixed-block upper limsup bound |
| `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_limsup_normalized_le_integratedLogPlusGrowthRate` | Optimizes the cocycle log-positive bound over all positive blocks |

The companion Development Notebook records every private helper, compiled
boundary probe, and axiom print in exact source order.

## Boundary models

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
- a generic almost-everywhere upper limsup bound for pointwise nonnegative
  integrable subadditive candidates on ergodic probability systems; and
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

### Exercise 16: locate nonnegativity

Where does \(X_n\ge0\) enter the generic proof?

**Solution.** It supplies a real lower bound for \(X_n/n\), needed by the
conditionally complete limsup interface.

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

What does the theorem say for \(X_n=cn\) on one point?

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

## Proof reproduction

From the repository root, run:

```text
cd formalization
lake build NonlinearDynamics.Random.RandomCocycles.SubadditiveUpperLimsup
```

For the complete project and teaching checks, run:

```text
make check
```

The Development Notebook gives the exact axiom reports and the source-order
declaration ledger.

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
