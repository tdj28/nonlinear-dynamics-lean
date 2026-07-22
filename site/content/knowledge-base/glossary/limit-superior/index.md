---
title: "Limit superior"
slug: "limit-superior"
summary: "The limit superior is the eventual upper envelope of a sequence: the limit of the suprema of its tails, recording the largest value approached infinitely often."
draft: true
pro_reviewed: false
toc: false
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveUpperLimsup"
og_image: "limit-superior-card.png"
og_image_alt: "Warm-paper glossary card showing an oscillating sequence, decreasing tail ceilings, and the eventual upper level selected as the limit superior, with no convergence claim."
---

The **limit superior**, or **limsup**, of a real sequence \((a_n)\) records
its eventual upper edge. Informally, it ignores any finite prefix and asks
how high the sequence can still return arbitrarily far out.

In the extended real line it is defined by

\[
\limsup_{n\to\infty} a_n
{} =
\inf_{N\ge 0}\ \sup_{n\ge N} a_n.
\]

The tail suprema form a decreasing sequence. Their infimum is the limsup.
For a convergent real sequence, the limsup equals the ordinary limit. For an
oscillating sequence it can retain only the upper cluster value. For example,
if \(a_n=(-1)^n\), then

\[
\limsup_{n\to\infty}a_n=1,
\qquad
\liminf_{n\to\infty}a_n=-1.
\]

{{< reference-figure
  src="limsup-tail-ceiling.svg"
  alt="An oscillating sequence is viewed through successively later tails. Each tail has an upper ceiling equal to its supremum, the ceilings decrease as the starting index moves right, and their limiting level is marked as the limsup. The sequence itself continues to oscillate."
  caption="The limsup is the limit of descending tail suprema. It controls eventual upward excursions but does not assert that the original sequence converges to that level."
>}}

## Why an upper limsup bound is not convergence

A theorem of the form

\[
\limsup_{n\to\infty} a_n\le L
\]

means that for every \(y\gt L\), all sufficiently late terms lie below \(y\).
It does not show that \(a_n\) converges, that its liminf is at least \(L\), or
that \(L\) is attained. A full limit identification usually needs the
complementary lower bound

\[
L\le\liminf_{n\to\infty}a_n.
\]

This distinction is central in subadditive ergodic arguments. Finite block
estimates and ordinary Birkhoff convergence can supply an upper limsup bound
before the harder lower-bound mechanism has been formalized.

## In Lean

Mathlib writes the filter limit superior as `Filter.limsup`. For a sequence
`u : ℕ → ℝ`, the expression

```lean
Filter.limsup u Filter.atTop
```

is the limsup along natural numbers tending to infinity. A particularly useful
order characterization is `Filter.limsup_le_iff`: to prove that the limsup is
at most a proposed bound, it is enough to show that every strictly larger
number is eventually an upper bound. Proofs along arithmetic progressions can
use `Filter.Eventually.atTop_of_arithmetic` to turn an eventual statement in a
quotient index into one for the corresponding original times.

{{< panel "warning" >}}
**Check the codomain and boundedness hypotheses.** In a conditionally complete
order such as \(\mathbb R\), generic limsup lemmas may require eventual upper
and lower bounds. A pointwise nonnegative process supplies the lower bound for
its normalized sequence; that assumption is analytic content, not mere proof
bookkeeping.
{{< /panel >}}

The codomain distinction is concrete. For \(u_n=-n\), the extended-real
limsup is \(-\infty\). Without lower coboundedness, Mathlib's conditionally
complete real `Filter.limsup` instead totalizes this sequence to
`Real.sInf_univ = 0`: every real number is eventually an upper bound, so the
set whose infimum is taken is all of \(\mathbb R\). This is why an argument
cannot silently move between extended-real intuition and the real-valued API.

Related concepts: {{< refterm "almost-everywhere" "almost everywhere" >}},
{{< refterm "birkhoff-sum" "Birkhoff sums" >}},
{{< refterm "phase-averaging" "phase averaging" >}}, and
{{< refterm "integrated-log-positive-growth-rate" "integrated log-positive growth rates" >}}.

Further reading: Mathlib's pinned
[liminf and limsup source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/LiminfLimsup.lean)
defines the filter operators and their order lemmas. The pinned
[real order source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Algebra/Order/Archimedean/Real/Basic.lean)
contains `Real.sInf_univ`.
