---
title: "Limit superior"
slug: "limit-superior"
summary: "The limit superior discards every finite prefix and records the highest level a sequence can still approach arbitrarily late."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveUpperLimsup"
og_image: "limit-superior-card.png"
og_image_alt: "The sequence five, minus one, one, minus one, one and so on has global maximum five, every tail after time zero has ceiling one, limit superior one, and no ordinary limit."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working note. Human review of the
mathematics, Lean interpretation, examples, sources, figures, and accessibility
remains pending. The page is public so readers can follow the work while that
review is still open.
{{< /panel >}}

Start with one real sequence. It has a large value once, then alternates
forever:

\[
a_0=5,
\qquad
a_n=
\begin{cases}
1,&n\text{ is positive and even},\\
-1,&n\text{ is odd}.
\end{cases}
\]

Its first values are

\[
5,-1,1,-1,1,-1,1,-1,\ldots
\]

The value \(5\) is the maximum of the whole sequence, but it occurs only at
time zero. If we discard that first term, every remaining tail contains only
\(-1\) and \(1\), and it contains \(1\) infinitely many times. The eventual
upper edge is therefore \(1\), not \(5\):

\[
\boxed{\limsup_{n\to\infty}a_n=1}.
\]

The sequence does not converge. Its positive even terms are always \(1\),
while its odd terms are always \(-1\). This one example already separates
three different questions:

- the **maximum** asks for the largest value attained anywhere, which is \(5\);
- the **limit superior** asks for the highest level that survives arbitrarily
  far into the sequence, which is \(1\); and
- an **ordinary limit** would require all sufficiently late terms to gather
  around one value, which does not happen.

{{< reference-figure
  wide="true"
  src="finite-spike-limsup.svg"
  alt="The sequence starts at five, then alternates between minus one and one. Its tail ceiling is five when the tail starts at zero and one for every later start. The global maximum is therefore five, the eventual upper edge is one, and no ordinary limit exists because the two late levels remain separated."
  caption="**One spike disappears; the upper return level remains.** The full tail beginning at index zero has supremum \(5\). Every tail beginning at index \(1\) or later has supremum \(1\), because later terms never exceed \(1\) and positive even indices keep attaining it. The infimum of the tail ceilings is therefore \(1\). The maximum \(5\) is a finite-prefix fact, while the persistent alternation between \(1\) and \(-1\) prevents ordinary convergence. This is an exact toy sequence, not measured data."
>}}

## Compute the tail ceilings by hand

For each starting index \(N\in\mathbb N\), define the **tail**

\[
\{a_n:n\ge N\}
\]

and its **tail ceiling**

\[
s_N=\sup_{n\ge N}a_n.
\]

Here \(\sup\) means the least upper bound. It is the smallest number that is at
least as large as every value in that tail.

For the worked sequence:

| Tail start | Values that remain | Tail ceiling |
|---:|---|---:|
| \(N=0\) | \(5,-1,1,-1,1,\ldots\) | \(s_0=5\) |
| \(N=1\) | \(-1,1,-1,1,\ldots\) | \(s_1=1\) |
| \(N=2\) | \(1,-1,1,-1,\ldots\) | \(s_2=1\) |
| any \(N\ge1\) | only \(-1\) and \(1\), with a later \(1\) | \(s_N=1\) |

Deleting more terms can never raise a supremum, so

\[
s_{N+1}\le s_N.
\]

In this example the ceiling sequence is

\[
5,1,1,1,\ldots
\]

and its infimum is \(1\). That is the limit superior calculation:

\[
\limsup_{n\to\infty}a_n
{} =
\inf_{N\ge0}\sup_{n\ge N}a_n
{} =
\inf\{5,1,1,1,\ldots\}
{} =1.
\]

## The general definition

For a sequence \((u_n)\) valued in the extended real line
\(\mathbb R\cup\{-\infty,+\infty\}\), define

\[
\boxed{
\limsup_{n\to\infty}u_n
{} =
\inf_{N\ge0}\ \sup_{n\ge N}u_n}.
\]

The extended real line supplies genuine top and bottom values. For example,
the sequence \(u_n=-n\) has extended-real limsup \(-\infty\), while
\(u_n=n\) has extended-real limsup \(+\infty\).

For bounded real sequences, three views say the same thing:

1. **Tail-ceiling view:** take the supremum of every tail, then take the
   infimum of those ceilings.
2. **Eventual-upper-bound view:** a real number \(b\) is an eventual upper
   bound when some cutoff \(N\) satisfies \(u_n\le b\) for every \(n\ge N\).
   The limsup is the smallest such eventual ceiling.
3. **Repeated-return view:** every level strictly below the limsup is exceeded
   arbitrarily late, while every level strictly above it eventually stays
   above all terms.

Here **eventually** means “after some finite cutoff, always.” The phrase
**arbitrarily late** means “after every proposed cutoff, there is a later
witness.” Neither word assigns a probability to the set of times.

## Why neither a maximum nor one upper bound is a limit

A maximum is sensitive to the finite prefix. Changing only \(a_0\) from \(5\)
to \(5000\) would change the maximum but leave every tail beginning at
\(N\ge1\) unchanged. The limsup would remain \(1\).

A limsup need not be attained. For example, \(u_n=1-1/(n+1)\) never equals
\(1\), but its tail ceilings decrease toward \(1\), so its limsup is \(1\).
The worked alternating sequence does attain its limsup repeatedly, but that
is a feature of the example, not part of the definition.

An upper-limsup estimate

\[
\limsup_{n\to\infty}u_n\le L
\]

says that for every real \(y\gt L\), the terms eventually satisfy \(u_n\lt y\).
It does not say that \(u_n\to L\). The missing lower half is usually written

\[
L\le\liminf_{n\to\infty}u_n,
\]

where the {{< refterm "limit-inferior" "limit inferior" >}} records the
eventual lower edge. In the worked sequence,

\[
\liminf_{n\to\infty}a_n=-1
\qquad\text{and}\qquad
\limsup_{n\to\infty}a_n=1,
\]

so the gap between the two edges exposes the failure of convergence.

## Real-valued Lean needs honest boundedness gates

Mathlib's `Filter.limsup` works in a conditionally complete order such as
\(\mathbb R\). The real numbers do not contain actual elements
\(-\infty\) and \(+\infty\), but a Lean definition must still return a real
number for every real sequence.

At the pinned Mathlib revision, `Filter.limsup_eq` unfolds the real-valued
operator as

\[
\operatorname{limsup}_{\mathbb R}(u)
{} =
\inf\{b\in\mathbb R:u_n\le b\text{ eventually}\}.
\]

For \(u_n=-n\), every real \(b\) is eventually an upper bound. The set inside
the infimum is all of \(\mathbb R\), and Mathlib's total real infimum satisfies
\(\inf\mathbb R=0\). Thus real `Filter.limsup` returns \(0\) for this
unbounded-below sequence, even though its extended-real limsup is
\(-\infty\). The returned zero is a totalization default, not the sequence's
eventual upper level.

{{< panel "warning" >}}
**A real `limsup` value does not prove its own side conditions.** The useful
order characterizations request a genuine eventual lower bound and a genuine
eventual upper bound. The bounded worked sequence has both. In the project's
generic subadditive theorem, the lower bound is an explicit almost-everywhere
hypothesis; the log-positive specialization obtains it from nonnegativity.
{{< /panel >}}

## In Lean: name the eventual upper edge

{{< lean-bridge
  human="Take the limit superior of the real sequence u as natural time tends to infinity."
  math="\(\displaystyle\limsup_{n\to\infty}u_n.\)"
  lean="Filter.limsup u Filter.atTop"
>}}

- <code>Filter.limsup</code> is the two-argument operator.
- <code>u</code> is a function such as <code>u : ℕ → ℝ</code>; function
  application <code>u n</code> is the term \(u_n\).
- <code>Filter.atTop</code> describes natural indices moving beyond every
  finite cutoff.
- The codomain is inferred from <code>u</code>. With codomain \(\mathbb R\), the
  boundedness warning above applies.
{{< /lean-bridge >}}

The same expression with a convergent bounded sequence agrees with its
ordinary limit. For the alternating worked example it records the upper edge
\(1\), not a nonexistent ordinary limit.

## In Lean: turn an upper-edge claim into eventual inequalities

{{< lean-bridge
  human="Assuming the sequence has real lower and upper bounds eventually, its limsup is at most L exactly when every y larger than L is eventually strictly above every term."
  math="\(\displaystyle\limsup_{n\to\infty}u_n\le L\iff\forall y\gt L,\ \exists N,\ \forall n\ge N,\ u_n\lt y.\)"
  lean="Filter.limsup_le_iff hLower hUpper"
>}}

- <code>hLower</code> supplies the lower-coboundedness side condition needed
  by the conditionally complete real order.
- <code>hUpper</code> supplies an eventual real upper bound.
- <code>∀ᶠ n in Filter.atTop, u n &lt; y</code> is Lean's filter spelling of
  “eventually \(u_n\lt y\).” The symbol <code>∀ᶠ</code> reads “for all
  eventually.”
- <code>.2</code> selects the right-to-left direction of an equivalence when a
  proof starts from the eventual inequalities.
{{< /lean-bridge >}}

A Mathlib-backed proof can use the exact pattern

~~~lean
example {u : ℕ → ℝ} {L : ℝ}
    (hLower : Filter.IsCoboundedUnder (· ≤ ·) Filter.atTop u)
    (hUpper : Filter.IsBoundedUnder (· ≤ ·) Filter.atTop u)
    (hEventually : ∀ y > L, ∀ᶠ n in Filter.atTop, u n < y) :
    Filter.limsup u Filter.atTop ≤ L := by
  exact (Filter.limsup_le_iff hLower hUpper).2 hEventually
~~~

The comparison symbols are literal Lean syntax inside this code block. The
mathematical display above uses TeX commands so Hugo passes it safely to
KaTeX.

## Standalone tutorial

**Standalone tutorial.** The following complete file
computes the worked sequence and several finite windows. It imports
<code>Std</code>, not Mathlib or this project.

Save it as <code>LimsupScratch.lean</code>:

~~~lean
import Std

namespace LimsupScratch

def a : Nat → Int
  | 0 => 5
  | n + 1 => if n % 2 = 0 then -1 else 1

def firstTen : List Int :=
  (List.range 10).map a

def maxFromTo (start stop : Nat) : Int :=
  ((List.range (stop - start + 1)).map fun k => a (start + k)).foldl max (-100)

#eval firstTen
#eval [maxFromTo 0 9, maxFromTo 1 9, maxFromTo 4 9]

example : firstTen = [5, -1, 1, -1, 1, -1, 1, -1, 1, -1] := by
  decide

example : maxFromTo 0 9 = 5 := by decide
example : maxFromTo 1 9 = 1 := by decide
example : maxFromTo 4 9 = 1 := by decide
example : a 8 = 1 ∧ a 9 = -1 := by decide

end LimsupScratch
~~~

Run it on macOS or Linux with the pinned compiler:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean LimsupScratch.lean
~~~

The first output should be
<code>[5, -1, 1, -1, 1, -1, 1, -1, 1, -1]</code>. The second should be
<code>[5, 1, 1]</code>. These finite calculations reveal the stable tail
ceiling, while the paper argument proves the infinite statement: after index
zero every term is at most \(1\), and every tail contains a positive even
index where the value is exactly \(1\).

This worksheet deliberately does not import `Filter.limsup`. That interface
lives in Mathlib and belongs to the separate project check below. This exact
worksheet was executed successfully with the pinned Lean 4.32.0 compiler on
macOS; the same standalone command works on Linux.

## In Lean: the project's upper-limsup theorem

The project applies limsup to normalized subadditive processes. A
**subadditive process** is a time-indexed family whose cost over two
consecutive blocks is no larger than the sum of the two block costs, with the
second block evaluated after moving the base point.

{{< lean-bridge
  human="On an ergodic probability base, an integrable shifted-subadditive process with almost-everywhere lower-bounded normalized paths has normalized limsup at most the normalized integral of every positive block."
  math="\(\displaystyle\limsup_{n\to\infty}\frac{X_n(\omega)}{n}\le\frac{1}{b}\int X_b\,d\mu\quad\text{for almost every }\omega,\ b\gt0.\)"
  lean="hX.ae_limsup_normalized_le_blockIntegral_of_ae_isBoundedUnder_ge hT hXlower b hb"
>}}

- <code>hX</code> packages finite-horizon {{< refterm "integrability"
  "integrability" >}} and shifted subadditivity.
- <code>hT</code> says the base is {{< refterm "ergodicity" "ergodic" >}}
  and measure preserving; the ambient typeclass says the measure is a
  {{< refterm "probability-measure" "probability measure" >}}.
- <code>hXlower</code> supplies the normalized path's eventual real lower
  bound {{< refterm "almost-everywhere" "almost everywhere" >}}, meaning
  outside a set of measure zero.
- <code>b</code> is the block length and <code>hb : b ≠ 0</code> excludes the
  zero block before division.
- The result is only an upper-limsup inequality. Its name does not hide a
  convergence theorem.
{{< /lean-bridge >}}

The proof combines finite {{< refterm "phase-averaging" "phase averaging" >}}
with ordinary {{< refterm "birkhoff-sum" "Birkhoff-sum" >}} limits under the
original base map. It does not infer that every powered map is ergodic.

## Try the exact declarations in the project

{{< repo-check >}}
**Full project check.** This uses the repository's pinned Lean and Mathlib
dependencies and may require substantial disk space and memory.
Place the following in a project scratch file, or compare the names with the
checked module:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.SubadditiveUpperLimsup

open Filter MeasureTheory

#check Filter.limsup
#check Filter.limsup_eq
#check Filter.limsup_nat_add
#check Filter.limsup_le_iff
#check Filter.le_limsup_iff
#check Filter.Tendsto.limsup_eq
#check NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral_of_ae_isBoundedUnder_ge
#check NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_limsup_normalized_le_integratedLogPlusGrowthRate
~~~

Each <code>#check</code> asks the pinned elaborator for the declaration's exact
type. The full-project command rendered below checks the complete module on
a machine with the repository's pinned Lean and Mathlib dependencies
installed; allow substantial disk space and memory for the dependency tree.
{{< /repo-check >}}

## Boundary cases and near-misses

- **Delete a finite prefix:** the limsup is unchanged. This is why the isolated
  \(5\) disappears from the worked sequence.
- **Constant sequence:** if \(u_n=c\), every tail ceiling is \(c\), so the
  limsup and ordinary limit are both \(c\).
- **Convergent but never attaining the limit:** for
  \(u_n=1-1/(n+1)\), the limsup is \(1\) even though no term equals \(1\).
- **Unbounded above:** \(u_n=n\) has extended-real limsup \(+\infty\). A
  real-valued API cannot represent that conclusion as an ordinary real.
- **Unbounded below:** \(u_n=-n\) exposes the totalized-real warning above.
- **Upper bound without convergence:** the worked alternating tail satisfies
  \(\limsup a_n\le1\), but its lower edge is \(-1\).
- **Almost-everywhere theorem:** the project's result may exclude a
  {{< refterm "null-set" "null set" >}} of sample points. It is not a
  pointwise statement about every sample.

## What a limsup statement does not establish

An upper limsup or upper-limsup bound alone proves none of the following:

- existence of an ordinary limit;
- equality with the limit inferior;
- attainment of the limsup at a finite index;
- monotonicity of the original sequence;
- measurability, integrability, or an almost-everywhere claim;
- interchange of a limit and an integral;
- a signed logarithmic growth rate, Lyapunov exponent, invariant splitting, or
  Oseledets theorem.

Each conclusion needs its own hypotheses and proof. In the project's
subadditive program, the upper limsup is deliberately one half of a later
squeeze argument.

## Check your understanding

1. Change only \(a_0\) from \(5\) to \(5000\). Which of the maximum, limsup,
   and liminf change?
2. Why is the ceiling of every tail beginning at \(N\ge1\) exactly \(1\), not
   merely at most \(1\)?
3. What are the limsup and liminf of the sequence
   \(0,2,0,2,0,2,\ldots\)? Does it converge?
4. Give a convergent sequence whose limsup is not attained by any term.
5. In the eventual-bound characterization, why do we test every \(y\gt L\)
   instead of requiring every late term to satisfy \(u_n\le L\)?
6. Why does the real-valued sequence \(-n\) require care when interpreting
   Mathlib's total `Filter.limsup`?
7. Which additional lower-edge inequality turns an upper-limsup estimate into
   a convergence squeeze?

## Where to continue

The companion {{< refterm "limit-inferior" "limit inferior" >}} chapter
develops the lower edge and its own real-valued boundedness gate.
[Subadditive Upper Limsup Bounds Before Kingman Convergence]({{< relref "/knowledge-base/deep-dives/subadditive-upper-limsup-bounds-before-kingman-convergence" >}})
builds the full phase-averaging proof around the exact project theorem.
[The Guarded Real-Liminf Bridge to Log-Positive Kingman Convergence]({{< relref "/knowledge-base/deep-dives/guarded-real-liminf-bridge-to-log-positive-kingman-convergence" >}})
then supplies the complementary lower mechanism used in the later convergence
argument.

## Sources

**Resource label: pinned Mathlib.** The repository pins Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).
Its official
[liminf and limsup source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/LiminfLimsup.lean)
defines `Filter.limsup`, unfolds it with `Filter.limsup_eq`, proves finite-prefix
invariance with `Filter.limsup_nat_add`, and states the bounded
`Filter.limsup_le_iff` characterization used above. The official
[real-order source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Algebra/Order/Archimedean/Real/Basic.lean)
contains `Real.sInf_univ`, which explains the totalized value in the
unbounded-below example.

**Resource label: checked project source.** The repository's
[SubadditiveUpperLimsup module](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveUpperLimsup.lean)
is authoritative for the almost-everywhere fixed-block theorem, its
nonnegative compatibility wrapper, and the log-positive cocycle
specialization described on this page.
