---
title: "Limit inferior"
slug: "limit-inferior"
summary: "The limit inferior is the eventual lower envelope of a sequence: the limit of the infima of its tails, with important boundedness gates in Mathlib's real-valued application programming interface (API)."
draft: false
pro_reviewed: false
toc: false
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman"
og_image: "limit-inferior-card.png"
og_image_alt: "Warm-paper glossary card showing an oscillating sequence, rising tail floors, and the eventual lower level selected as the limit inferior, with no convergence claim."
---

The **limit inferior**, or **liminf**, of a sequence records its eventual lower
edge. It discards every finite prefix and asks how low the sequence can still
return arbitrarily far out.

For a sequence \((a_n)\) valued in the extended real line
\(\mathbb R\cup\{-\infty,+\infty\}\), define the **tail floor**

\[
m_N = \inf_{n\ge N} a_n.
\]

Moving the starting index from \(N\) to \(N+1\) removes one candidate from the
infimum, so \(m_N\le m_{N+1}\). The limit inferior is the supremum of these
rising floors:

\[
\liminf_{n\to\infty} a_n
{} =
\sup_{N\ge 0}\ \inf_{n\ge N} a_n.
\]

The extended real line is important here. It lets a sequence that escapes
downward have liminf \(-\infty\), and a sequence that escapes upward have
liminf \(+\infty\), without inventing a finite answer.

{{< reference-figure
  src="liminf-tail-floor.svg"
  alt="An oscillating sequence is viewed through successively later tails. Each tail has a lower floor equal to its infimum, the floors rise as the starting index moves right, and their limiting level is marked as the eventual lower edge. The sequence itself can continue to oscillate above that edge."
  caption="The liminf is the limit of rising tail infima. It remembers the lowest level approached arbitrarily late. The sketch is about order, not measured data, and a lower edge alone does not say that the sequence converges."
>}}

## Three ways to read the definition

The tail-floor formula supports three equivalent intuitions when the codomain
and boundedness assumptions make the quantities honest.

1. **Tail view:** inspect every suffix \(a_N,a_{N+1},\ldots\), take its lowest
   possible level, then move \(N\) forward.
2. **Eventual-bound view:** collect the real numbers \(b\) for which
   \(b\le a_n\) eventually. Their supremum is the real-valued filter liminf
   when that supremum is meaningful.
3. **Repeated-return view:** values strictly above the liminf eventually stop
   being universal lower bounds, so the sequence must keep returning below
   them under the appropriate order-boundedness hypotheses.

Here **eventually** means that some cutoff \(N\) exists after which the claim
holds for every \(n\ge N\). **Frequently** along natural time means that every
cutoff has a later witness. In Lean notation, `∃ᶠ n in Filter.atTop, P n`
means

\[
\forall N\in\mathbb N,\ \exists n\ge N,\ P(n).
\]

These words are filter notions. They do not assign probabilities and do not
mean that a set of times has positive density.

## Examples that separate the lower edge from a limit

| Sequence | Tail-floor behavior | Liminf | Does the sequence converge? |
|---|---|---:|---|
| \(a_n=3\) | Every tail floor is \(3\). | \(3\) | Yes. |
| \(a_n=(-1)^n\) | Every tail contains \(-1\). | \(-1\) | No; the limsup is \(1\). |
| \(a_n=-1/(n+1)\) | The \(N\)-th tail floor is \(-1/(N+1)\), rising toward \(0\). | \(0\) | Yes. |
| \(a_n=-n\) | Every extended-real tail floor is \(-\infty\). | \(-\infty\) | No finite real limit. |

The alternating example is the basic warning. A liminf can be a genuine
cluster value while the sequence keeps visiting a different upper cluster
value. The companion {{< refterm "limit-superior" "limit superior" >}}
records that upper edge.

## Mathlib's real liminf is totalized

Mathlib defines `Filter.liminf` for a conditionally complete lattice. The real
numbers \(\mathbb R\) are conditionally complete, not a complete lattice with
actual top and bottom elements. Nevertheless, a Lean definition must return a
real number for every input sequence.

At the repository's pinned Mathlib commit, `Filter.liminf_eq` unfolds the
real-valued operator as

\[
\operatorname{liminf}_{\mathbb R}(u)
{} =
\sup\{b\in\mathbb R : b\le u_n\text{ eventually}\}.
\]

If \(u_n=-n\), there is no real eventual lower bound. The set inside the
supremum is empty. Mathlib's real order fixes

\[
\sup\varnothing=0,
\]

so the formal real `Filter.liminf` of this downward-escaping sequence is
\(0\), while its extended-real liminf is \(-\infty\). The value \(0\) is a
totalization default, not an asymptotic lower level.

{{< panel "warning" >}}
**A real `liminf` value does not certify its own boundedness assumptions.** For
`u : ℕ → ℝ`, `Filter.IsBoundedUnder (· ≥ ·) Filter.atTop u` means that some
real \(b\) satisfies \(b\le u_n\) eventually. Prove or obtain that fact before
reading a real-valued liminf as an extended-real conclusion.
{{< /panel >}}

An upper control is separate. Several converse lemmas use
`Filter.IsCoboundedUnder (· ≥ ·) Filter.atTop u`; a global upper bound such as
\(u_n\le0\) supplies it. In the centered subadditive process used by this
project, shifted subadditivity provides exactly that pointwise upper bound,
while a null-event argument supplies the missing eventual lower bound almost
everywhere.

## Worked boundary: a quadratic process

The random-matrix-theory milestone 33 (RMT-33) Lean module compiles a concrete
model showing why the lower-bound gate cannot be erased. Take a one-point
probability space, let the base map be the identity, and define

\[
X_n=-n^2.
\]

This is shifted subadditive because
\(-(m+n)^2\le -m^2-n^2\). Its one-step value is \(X_1=-1\). Subtracting the
one-step orbit sum gives the centered process

\[
\begin{aligned}
Y_n
&= X_n - \sum_{k=0}^{n-1}X_1 \\
&= -n^2+n.
\end{aligned}
\]

Totalized normalization sets \(u_0=0\). At every positive time,

\[
u_n=\frac{Y_n}{n}=1-n.
\]

The sequence is unbounded below. It crosses the rational level \(-2\) at every
\(n\ge4\), so it belongs to the project's rational lower-deviation event at
target \(-1\). Its extended-real liminf is \(-\infty\), but its Mathlib real
liminf is \(0\), because it has no eventual real lower bound. Therefore the
unguarded implication

\[
\text{rational lower-deviation event at }c
\quad\Longrightarrow\quad
\liminf u_n\lt c
\]

is false for real `Filter.liminf`. RMT-33 states this direction only after
requesting the actual eventual lower bound.

## Frequent crossings need a strict margin

Suppose \(u_n\to0\) through the values \(u_n=-1/n\) for positive \(n\), with
the time-zero value totalized to \(0\). Then \(u_n\lt0\) frequently. But for
every fixed rational \(q\lt0\), the inequality \(u_n\lt q\) eventually fails.
Approaching a target from below is not the same as crossing one lower target
arbitrarily late.

This is why RMT-33 uses two rational choices. From
\(\liminf u_n\lt\delta\), choose a rational outer target
\(c\lt\delta\) that still lies above the liminf. Membership in the event at
\(c\) then supplies a second rational witness \(q\lt c\) crossed frequently.
The strict gaps are mathematical content. Replacing them by the impossible
premise \(\delta\lt\delta\), or by frequent crossing at \(\delta\) itself,
would break the argument.

Two pinned API lemmas encode the two directions:

- `Filter.frequently_lt_of_liminf_lt` turns a strict liminf inequality into a
  frequent strict crossing, under its upper-coboundedness premise.
- `Filter.liminf_le_of_frequently_le` turns frequent lower crossings into an
  upper bound on the liminf, under an eventual lower-bound premise.

## The lower half of convergence

In the honest bounded regime required by `Filter.le_liminf_iff`, a statement
\(L\le\liminf a_n\) says that every level strictly below \(L\) is eventually
below every term. Both an upper-coboundedness hypothesis and an eventual real
lower bound are part of that interpretation. The inequality is only the lower
half of a convergence proof. If the same sequence also satisfies

\[
\limsup_{n\to\infty}a_n\le L,
\]

and the required real upper and lower bounds are available, then the two edges
squeeze the sequence to \(L\). Mathlib packages this step as
`tendsto_of_le_liminf_of_limsup_le`.

RMT-33 also needs to add back a convergent Birkhoff average. The pinned lemma
`le_liminf_add` gives

\[
\liminf u_n+\liminf v_n
\le
\liminf(u_n+v_n)
\]

under explicit boundedness hypotheses. This is not automatic distributivity:
the inequality and its side conditions are the usable theorem.

## Pinned Lean API

The following names were compiled against Lean and Mathlib 4.32.0:

```lean
#check Filter.liminf
#check Filter.liminf_eq
#check Filter.liminf_nat_add
#check Filter.liminf_congr
#check Filter.liminf_le_of_frequently_le
#check Filter.frequently_lt_of_liminf_lt
#check Filter.le_liminf_iff
#check Filter.Tendsto.liminf_eq
#check le_liminf_add
#check tendsto_of_le_liminf_of_limsup_le
```

`Filter.liminf_nat_add` proves that deleting a finite natural-number prefix
does not change the liminf. `Filter.liminf_congr` replaces a sequence by one
that agrees eventually. `Filter.Tendsto.liminf_eq` identifies the liminf of a
convergent sequence. `Filter.le_liminf_iff` exposes eventual lower bounds, with
both order-boundedness gates visible in the real codomain.

## What a liminf statement does not prove

A lower-liminf bound by itself proves none of the following:

- convergence of the original sequence;
- equality with the limsup;
- attainment of the lower edge at any finite time;
- integrability, almost-everywhere validity, or convergence in
  \(L^1\);
- interchange of a limit and an integral;
- a signed logarithmic growth rate, Lyapunov exponent, or Oseledets splitting.

Those conclusions need their own upper estimates, boundedness, measurability,
integrability, or multiplicative hypotheses.

Related concepts: {{< refterm "almost-everywhere" "almost everywhere" >}},
{{< refterm "birkhoff-sum" "Birkhoff sums" >}},
{{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}}, and
{{< refterm "integrated-log-positive-growth-rate" "integrated log-positive growth rates" >}}.

Continue with the textbook
[The Guarded Real-Liminf Bridge to Log-Positive Kingman Convergence]({{< relref "/knowledge-base/deep-dives/guarded-real-liminf-bridge-to-log-positive-kingman-convergence" >}})
or its declaration-by-declaration
[Development Notebook companion]({{< relref "/development-notebook/2026/07/log-positive-kingman-convergence-from-rational-lower-deviations-in-lean" >}}).

## Official sources

- The pinned Mathlib
  [order source for `liminf`, tail invariance, frequent crossings, and order characterizations](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/LiminfLimsup.lean)
  is the authoritative API source used by the formalization.
- The pinned
  [topological liminf and limsup source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/Order/LiminfLimsup.lean)
  contains convergence identification and the final squeeze theorem.
- The pinned
  [ordered-addition source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/Algebra/Order/LiminfLimsup.lean)
  states `le_liminf_add` with its exact hypotheses.
- The pinned
  [real conditional-completeness source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Algebra/Order/Archimedean/Real/Basic.lean)
  defines `Real.sSup_empty = 0`; the pinned
  [extended-real source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Data/EReal/Basic.lean)
  defines `EReal` by adjoining both endpoints to the reals.
