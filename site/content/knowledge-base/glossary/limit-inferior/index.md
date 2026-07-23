---
title: "Limit inferior"
slug: "limit-inferior"
summary: "The limit inferior is the eventual lower edge of a sequence: the rising limit of its tail infima, with explicit boundedness gates for Mathlib's real-valued definition."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman"
og_image: "limit-inferior-card.png"
og_image_alt: "The exact sequence four, minus two, seven halves, minus three halves and so on has paired tail floors rising toward minus one, while its upper rail approaches three and the sequence does not converge."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note. Human review
of the mathematics, Lean interpretation, sources, figure, and accessibility
remains pending. Publication lets readers follow the construction; it does
not certify professional review.
{{< /panel >}}

## Start with one sequence you can calculate

Consider the real sequence with two interlaced rails:

\[
a_{2k}=3+\frac{1}{k+1},
\qquad
a_{2k+1}=-1-\frac{1}{k+1},
\qquad k\in\mathbb N.
\]

Here \(\mathbb N=\{0,1,2,\ldots\}\). The first eight terms are exact
rational numbers:

| Index \(n\) | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Value \(a_n\) | \(4\) | \(-2\) | \(7/2\) | \(-3/2\) | \(10/3\) | \(-4/3\) | \(13/4\) | \(-5/4\) |

A **tail** beginning at cutoff \(N\) is the infinite list
\(a_N,a_{N+1},a_{N+2},\ldots\). Its **infimum** is the greatest real
number that is no larger than every value in that tail. For this sequence the
first tail floors are

| Cutoff \(N\) | Tail begins | Infimum of the whole tail |
|---:|---|---:|
| 0 | \(4,-2,7/2,-3/2,\ldots\) | \(-2\) |
| 1 | \(-2,7/2,-3/2,\ldots\) | \(-2\) |
| 2 | \(7/2,-3/2,10/3,-4/3,\ldots\) | \(-3/2\) |
| 3 | \(-3/2,10/3,-4/3,\ldots\) | \(-3/2\) |
| 4 or 5 | the next pair of rails | \(-4/3\) |
| 6 or 7 | the next pair of rails | \(-5/4\) |

This pattern has an exact proof. From cutoff \(2K\) or \(2K+1\), the term

\[
a_{2K+1}=-1-\frac{1}{K+1}
\]

is still present. Every later odd term is at least this large, because its
positive fraction is smaller, while every even term is larger than \(3\).
Therefore the tail floor is not merely approximated by that odd term; it is
attained there:

\[
m_{2K}=m_{2K+1}
{} =
-1-\frac{1}{K+1},
\qquad
m_N:=\inf_{n\ge N}a_n.
\]

The floors rise through

\[
-2,-2,-\frac32,-\frac32,-\frac43,-\frac43,\ldots
\]

and approach \(-1\). That eventual lower edge is the **limit inferior**, or
**liminf**:

\[
\boxed{\displaystyle \liminf_{n\to\infty}a_n=-1.}
\]

{{< reference-figure
  src="liminf-tail-floor.svg"
  wide="true"
  alt="The exact sequence 4, minus 2, seven halves, minus three halves, ten thirds, minus four thirds, thirteen fourths, minus five fourths alternates between an upper rail approaching 3 and a lower rail approaching minus 1. Its paired tail floors rise from minus 2 to minus three halves, minus four thirds, and minus five fourths toward minus 1. A separate downward-escape panel shows that the real Mathlib liminf of minus n totalizes to 0 when no eventual real lower bound exists."
  caption="**Finding:** the worked sequence has paired tail floors \(-2,-3/2,-4/3,-5/4,\ldots\), so its liminf is \(-1\), even though its upper rail approaches \(3\) and the sequence does not converge. The boundary panel contrasts this honest lower-bounded case with \(u_n=-n\): its extended-real liminf is \(-\infty\), but Mathlib's real-valued liminf totalizes to \(0\) because no real eventual lower bound exists. Every plotted value is part of this exact toy example, not empirical data."
>}}

## Why this sequence still does not converge

The even-indexed subsequence tends to \(3\):

\[
a_{2k}=3+\frac{1}{k+1}\longrightarrow3.
\]

The odd-indexed subsequence tends to \(-1\):

\[
a_{2k+1}=-1-\frac{1}{k+1}\longrightarrow-1.
\]

A convergent sequence cannot have two subsequences with different limits.
Thus \((a_n)\) does not converge. Its liminf is \(-1\), while its companion
{{< refterm "limit-superior" "limit superior" >}}, or limsup, is \(3\).
The gap between the two edges records the persistent oscillation.

This is the first misconception to retire:

{{< panel "warning" >}}
Knowing \(\liminf a_n=L\) does **not** mean that \(a_n\to L\). It identifies
the eventual lower edge only. A convergence proof also needs matching upper
control, usually \(\limsup a_n\le L\).
{{< /panel >}}

## The definition after seeing it happen

For a sequence valued in the **extended real line**
\(\mathbb R\cup\{-\infty,+\infty\}\), define one floor for each tail:

\[
m_N=\inf_{n\ge N}a_n.
\]

Advancing from \(N\) to \(N+1\) removes one candidate from the infimum. It
cannot lower the floor, so \(m_N\le m_{N+1}\). The liminf is the supremum,
meaning the least upper bound, of all those rising floors:

\[
\liminf_{n\to\infty}a_n
{} =
\sup_{N\ge0}\ \inf_{n\ge N}a_n.
\]

The extended real endpoints make this formula honest for every sequence. A
sequence escaping downward may have liminf \(-\infty\); a sequence escaping
upward may have liminf \(+\infty\). No arbitrary finite number is needed.

Three readings of the same definition are useful:

1. **Tail-floor reading:** take the infimum of every suffix and watch those
   infima rise.
2. **Eventual-lower-bound reading:** collect levels \(b\) for which
   \(b\le a_n\) from some time onward; the liminf is the highest such
   eventual floor when the real order-boundedness hypotheses hold.
3. **Repeated-return reading:** if \(y\) lies strictly above the liminf, the
   sequence must return below \(y\) arbitrarily late, again under the side
   conditions required by a conditionally complete real codomain.

Deleting finitely many initial terms changes none of these eventual
statements. That is why the prefix is irrelevant and why Mathlib provides the
tail-invariance theorem `Filter.liminf_nat_add`.

## Eventually and frequently are logical, not probabilistic

For natural-number time, a property \(P(n)\) holds **eventually** when some
cutoff works forever afterward:

\[
\exists N\in\mathbb N,\ \forall n\ge N,\ P(n).
\]

It holds **frequently** when every cutoff has a later witness:

\[
\forall N\in\mathbb N,\ \exists n\ge N,\ P(n).
\]

Lean writes the second statement as `∃ᶠ n in Filter.atTop, P n`.
`Filter.atTop` is the filter that formalizes moving toward arbitrarily large
natural numbers. These words make no claim about probability, positive
density, or how often the witnesses occur relative to all times.

For the worked sequence, every \(y\gt-1\) has values below it frequently,
because sufficiently late odd terms remain below \(y\). Every
\(b\lt-1\) is eventually a lower bound because both rails eventually lie
above \(b\).

## Mathlib's real liminf is deliberately total

The real numbers are **conditionally complete**: every nonempty set that is
bounded above has a real supremum. They do not contain actual elements
\(+\infty\) and \(-\infty\). Mathlib nevertheless defines
`Filter.liminf` so that it returns a real number for every real sequence.

At the pinned Mathlib revision, `Filter.liminf_eq` unfolds the operator as

\[
\operatorname{liminf}_{\mathbb R}(u)
{} =
\sup\{b\in\mathbb R:b\le u_n\text{ eventually}\}.
\]

Now take the near-miss \(u_n=-n\). Given any proposed real floor \(b\), choose
a natural number \(n\gt-b\). Then \(-n\lt b\), and later values only decrease.
No real number is an eventual lower bound. The set inside the supremum is
empty.

Mathlib's real order uses

\[
\sup\varnothing=0.
\]

Consequently,

\[
\operatorname{liminf}_{\mathbb R}(-n)=0,
\qquad
\liminf_{\mathrm{extended}\ \mathbb R}(-n)=-\infty.
\]

The real value \(0\) is a totalization default. It is not a hidden lower edge
of the sequence.

Two similarly named order hypotheses play different roles in the pinned API:

| Lean premise | Operational reading used here | Why it appears |
|---|---|---|
| `Filter.IsBoundedUnder (· ≥ ·) Filter.atTop u` | Some real \(b\) satisfies \(b\le u_n\) eventually. | It rules out downward escape before frequent lower crossings are converted into a real-liminf bound. |
| `Filter.IsCoboundedUnder (· ≥ ·) Filter.atTop u` | The lower-limit problem has upper control; in this project, the pointwise bound \(u_n\le0\) supplies it. | It supports the converse step from a strict liminf inequality to frequent strict crossings. |

The relation `(· ≥ ·)` makes the names easy to misread. Follow the inequality,
not an English guess about the identifier.

{{< panel "warning" >}}
For a real sequence, a displayed `Filter.liminf` value does not prove its own
order-boundedness premises. Establish the actual eventual lower bound before
interpreting the value as an extended-real asymptotic statement.
{{< /panel >}}

## The repository's quadratic boundary model

Random-matrix-theory milestone 33 (RMT-33) checks a stronger near-miss inside
the exact subadditive-process interface. On a one-point probability space,
take the identity base map and

\[
X_n=-n^2.
\]

It is shifted subadditive because

\[
-(m+n)^2\le -m^2-n^2.
\]

The one-step value is \(X_1=-1\). Subtracting its one-step orbit sum gives

\[
\begin{aligned}
Y_n
&=X_n-\sum_{k=0}^{n-1}X_1\\
&=-n^2+n.
\end{aligned}
\]

Lean's total normalization sets the time-zero value to \(0\). At every
positive time,

\[
u_n=\frac{Y_n}{n}=1-n.
\]

This sequence crosses the rational target \(-2\) at every \(n\ge4\), so it
belongs to the project's strict rational lower-deviation event at target
\(-1\). Yet it is unbounded below. Its extended-real liminf is \(-\infty\),
while its Mathlib real liminf is the totalized value \(0\).

Therefore the unguarded implication

\[
\text{membership in the lower-deviation event at }c
\quad\Longrightarrow\quad
\operatorname{liminf}_{\mathbb R}u_n\lt c
\]

is false. The checked project theorem makes the eventual lower-bound argument
an explicit input instead of hiding it.

## A second near-miss: strict margins matter

For positive \(n\), let \(v_n=-1/n\), and set the totalized time-zero value to
\(0\). Then \(v_n\to0\) and \(v_n\lt0\) frequently. But for every fixed
rational \(q\lt0\), the inequality \(v_n\lt q\) eventually stops holding.

Approaching a target from below is not the same as crossing one strictly lower
target arbitrarily late. RMT-33 therefore uses two rational gaps. Starting
from \(\liminf u_n\lt\delta\), it chooses an outer rational target
\(c\lt\delta\) that remains above the liminf. Membership in the event at
\(c\) then exposes an inner rational witness \(q\lt c\) crossed frequently.
The impossible substitution \(\delta\lt\delta\) would lose this room.

## In Lean

{{< lean-bridge
  human="The eventual lower edge of the worked sequence a is minus one."
  math="\(\displaystyle \liminf_{n\to\infty}a_n=-1.\)"
  lean="Filter.liminf a Filter.atTop = (-1 : ℝ)"
>}}
- <code>a</code> is a function from natural-number indices to real values.
- <code>Filter.atTop</code> means that the index tends through arbitrarily
  large natural numbers.
- <code>Filter.liminf a Filter.atTop</code> is Mathlib's real-valued lower
  limit along that filter.
- <code>(-1 : ℝ)</code> tells Lean that the numeral lives in the real numbers.
- This line is the exact Lean shape of the result. The small worksheet below
  checks its finite arithmetic model; the infinite real theorem belongs to
  the Mathlib-backed layer.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Before reading a real liminf geometrically, exhibit one real floor that all sufficiently late terms stay above."
  math="\(\exists b\in\mathbb R,\ \exists N\in\mathbb N,\ \forall n\ge N,\ b\le u_n.\)"
  lean="Filter.IsBoundedUnder (· ≥ ·) Filter.atTop u"
>}}
- <code>IsBoundedUnder</code> packages boundedness of the values selected by a
  filter.
- The relation <code>(· ≥ ·)</code> encodes a lower bound: late values of
  <code>u</code> are greater than or equal to one real <code>b</code>.
- <code>Filter.atTop</code> turns "late" into an eventual statement over
  natural time.
- This is genuine mathematical information. It is not inferred from the fact
  that <code>Filter.liminf u Filter.atTop</code> has type <code>ℝ</code>.
{{< /lean-bridge >}}

{{< lean-bridge
  human="With that eventual lower bound, membership in the project's rational lower-deviation event forces the normalized centered process to have real liminf below c."
  math="\(\bigl[u\text{ is eventually bounded below}\bigr]\land\bigl[\omega\in D_c\bigr]\Longrightarrow\liminf_n u_n(\omega)\lt c.\)"
  lean="liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet hlower hω"
>}}
- <code>hlower</code> is the explicit
  <code>Filter.IsBoundedUnder (· ≥ ·)</code> proof.
- <code>hω</code> proves that the sample point belongs to
  <code>centeredStrictLowerDeviationSet</code>.
- The theorem name says only <code>liminf ... &lt; c</code>. It does not assert
  convergence of the process.
- The theorem uses `Filter.liminf_le_of_frequently_le` after the event exposes
  a fixed rational level crossed frequently.
{{< /lean-bridge >}}

### A tiny standalone worksheet

**Standalone tutorial.** Save the
following as `LimitInferiorTutorial.lean`. It calculates the first eight exact
rational values and their finite-window minima. It does not import Mathlib,
define `Filter.liminf`, or prove the infinite limiting statement.

~~~lean
import Std

def upperRail (k : Nat) : Rat :=
  3 + 1 / ((k : Rat) + 1)

def lowerRail (k : Nat) : Rat :=
  -1 - 1 / ((k : Rat) + 1)

def sample (n : Nat) : Rat :=
  let k := n / 2
  if n % 2 = 0 then upperRail k else lowerRail k

def minRat (x y : Rat) : Rat :=
  if x ≤ y then x else y

def minimum? : List Rat → Option Rat
  | [] => none
  | x :: xs => some (xs.foldl minRat x)

def finiteTailMin (start stop : Nat) : Option Rat :=
  minimum? ((List.range (stop - start)).map
    (fun offset => sample (start + offset)))

#eval (List.range 8).map sample
#eval (List.range 8).map (fun start => finiteTailMin start 8)

example : sample 0 = 4 := by native_decide
example : sample 1 = -2 := by native_decide
example : sample 6 = (13 : Rat) / 4 := by native_decide
example : finiteTailMin 2 8 = some ((-3 : Rat) / 2) := by native_decide
~~~

From the directory containing the file, type:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean LimitInferiorTutorial.lean
~~~

The first evaluation should reproduce
\(4,-2,7/2,-3/2,10/3,-4/3,13/4,-5/4\). The second should report the
finite-window minima
\(-2,-2,-3/2,-3/2,-4/3,-4/3,-5/4,-5/4\). These finite minima agree with the
first four infinite tail floors because each listed lower-rail value is the
smallest value that appears after its cutoff in the full sequence. The paper
argument above, not this finite computation, proves the claim about all tails.
This exact worksheet was executed successfully with the pinned Lean 4.32.0
compiler; it imports only <code>Std</code> and does not load the
project or Mathlib.

### Try the exact declarations in the project

{{< repo-check >}}
**Full project check.** This uses the repository's pinned Lean and Mathlib
dependencies and may require substantial disk space and memory.
Place these exact queries in the RMT-33 module or a temporary project file:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman

open Filter
open NonlinearDynamics.Random.RandomCocycles

#check Filter.liminf
#check Filter.liminf_eq
#check Filter.liminf_nat_add
#check Filter.liminf_le_of_frequently_le
#check Filter.frequently_lt_of_liminf_lt
#check Filter.le_liminf_iff
#check Filter.Tendsto.liminf_eq
#check liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet
#check IsIntegrableSubadditiveProcessCandidate.mem_centeredStrictLowerDeviationSet_of_liminf_normalizedCenteredProcess_lt
#check IsIntegrableSubadditiveProcessCandidate.mem_centeredStrictLowerDeviationSet_iff_liminf_normalizedCenteredProcess_lt
#check IsIntegrableSubadditiveProcessCandidate.ae_isBoundedUnder_ge_and_le_liminf_normalizedCenteredProcess
~~~

The full-project command printed below checks the authoritative module named in
the front matter. It uses the repository's pinned Lean and Mathlib dependencies
and may require substantial disk space and memory.
{{< /repo-check >}}

## Liminf supplies only the lower half of convergence

In the bounded regime required by `Filter.le_liminf_iff`, the inequality

\[
L\le\liminf_{n\to\infty}a_n
\]

says that every real level strictly below \(L\) is eventually below every
term. It does not control the upper excursions. If one also proves

\[
\limsup_{n\to\infty}a_n\le L
\]

with the required upper and lower bounds, the two edges squeeze the sequence
to \(L\). Mathlib packages that last step as
`tendsto_of_le_liminf_of_limsup_le`.

RMT-33 also adds a convergent Birkhoff average back to a centered process. The
pinned theorem `le_liminf_add` provides

\[
\liminf u_n+\liminf v_n
\le
\liminf(u_n+v_n)
\]

under explicit boundedness hypotheses. This is an inequality with side
conditions, not unconditional distributivity of liminf over addition.

## What this page does not claim

A lower-liminf identity or inequality alone proves none of the following:

- convergence of the original sequence;
- equality with the limsup;
- attainment of the lower edge at a finite time;
- integrability or an {{< refterm "almost-everywhere" "almost-everywhere" >}}
  statement;
- convergence in \(L^1\), probability, or distribution;
- interchange of a limit and an integral;
- a signed logarithmic growth rate, Lyapunov exponent, or Oseledets splitting.

Each conclusion needs its own upper bound, measurability, integrability,
measure-theoretic, or multiplicative hypotheses.

## Where to continue

The {{< refterm "limit-superior" "limit superior" >}} entry develops the
upper edge. {{< refterm "birkhoff-sum" "Birkhoff sums" >}} explains the orbit
averages that enter the repository's centered-process identity, while
{{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}}
separates that construction from expectation centering.

Continue with the textbook
[The Guarded Real-Liminf Bridge to Log-Positive Kingman Convergence]({{< relref "/knowledge-base/deep-dives/guarded-real-liminf-bridge-to-log-positive-kingman-convergence" >}})
or its declaration-by-declaration
[Development Notebook companion]({{< relref "/development-notebook/2026/07/log-positive-kingman-convergence-from-rational-lower-deviations-in-lean" >}}).

## Official sources

- The pinned Mathlib
  [order source for `liminf`, tail invariance, frequent crossings, and order characterizations](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/LiminfLimsup.lean)
  defines the exact filter API used by the formalization.
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
