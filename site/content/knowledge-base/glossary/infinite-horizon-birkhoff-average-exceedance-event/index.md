---
title: "Infinite-horizon Birkhoff-average exceedance event"
slug: "infinite-horizon-birkhoff-average-exceedance-event"
summary: "The infinite-horizon Birkhoff-average exceedance event contains the starting points whose finite-time orbit average strictly crosses a chosen threshold at least once."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.InfiniteHopfMaximal"
og_image: "infinite-horizon-birkhoff-average-exceedance-event-card.png"
og_image_alt: "On a uniform four-cycle with readings three, minus one, minus one, minus one, strict threshold one half is crossed by x zero at times one, two, and five and by x three at time two, giving event mass one half."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working draft. Human review
of the mathematics, Lean interpretation, sources, figure, and accessibility
remains pending. Publication does not mean that the page has completed that
review.
{{< /panel >}}

Start with four equally likely states

\[
\Omega=\{x_0,x_1,x_2,x_3\},
\qquad
\mu(\{x_j\})=\frac14.
\]

The map \(T\) moves one step around the cycle

\[
x_0\longmapsto x_1\longmapsto x_2\longmapsto x_3
\longmapsto x_0,
\]

and the observable \(g:\Omega\to\mathbb R\) reads

\[
g(x_0)=3,
\qquad
g(x_1)=g(x_2)=g(x_3)=-1.
\]

An **observable** is a numerical reading attached to each state. The measure
\(\mu\) is a
{{< refterm "probability-measure" "probability measure" >}} because the four
masses add to one. Every subset of this finite space is an
{{< refterm "event" "event" >}}.

For a start \(x\), add the first \(n\) readings along its orbit and divide by
\(n\):

\[
S_n g(x)=\sum_{j=0}^{n-1}g(T^j x),
\qquad
A_n g(x)=\frac{S_n g(x)}{n}\quad(n\ge1).
\]

The first expression is a
{{< refterm "birkhoff-sum" "Birkhoff sum" >}}. The second is its finite-time
average. Fix the threshold

\[
a=\frac12.
\]

The question is deliberately modest: **does the average cross \(1/2\) at
least once at a positive finite time?**

## Work out every crossing

The exact first six averages are:

| start | \(A_1\) | \(A_2\) | \(A_3\) | \(A_4\) | \(A_5\) | \(A_6\) |
|---|---:|---:|---:|---:|---:|---:|
| \(x_0\) | **\(3\)** | **\(1\)** | \(1/3\) | \(0\) | **\(3/5\)** | \(1/3\) |
| \(x_1\) | \(-1\) | \(-1\) | \(-1\) | \(0\) | \(-1/5\) | \(-1/3\) |
| \(x_2\) | \(-1\) | \(-1\) | \(1/3\) | \(0\) | \(-1/5\) | \(-1/3\) |
| \(x_3\) | \(-1\) | **\(1\)** | \(1/3\) | \(0\) | \(-1/5\) | \(1/3\) |

Bold entries strictly exceed \(1/2\). Thus \(x_0\) crosses at times
\(1,2,5\), \(x_3\) crosses at time \(2\), and the other two starts do not
cross in this table.

The table is enough only after we rule out later crossings. Each complete
four-step block has sum

\[
3-1-1-1=0.
\]

For any starting phase, deleting complete four-step blocks leaves a partial
sum no larger than \(3\). Hence

\[
S_n g(x)\le3
\quad\Longrightarrow\quad
A_n g(x)\le\frac3n\le\frac12
\qquad(n\ge6).
\]

The last inequality is not strict at its numerical upper bound, so it still
excludes the required strict crossing. We have now checked every time, rather
than only the six displayed times.

The at-least-once event is therefore

\[
E_{1/2}(g)=\{x_0,x_3\},
\qquad
\mu(E_{1/2}(g))=\frac24=\frac12.
\]

{{< reference-figure
  wide="true"
  src="infinite-horizon-exceedance-event.svg"
  alt="An exact four-state cycle has observable values three, negative one, negative one, negative one and uniform mass one quarter. A table shows that x zero crosses the threshold one half at times one, two, and five, while x three crosses at time two. Prefix events grow from empty to x zero and then x zero plus x three. Tail-witness events shrink to empty by time six. Every four-step sum is zero, so all averages have limit superior zero. The at-least-once event has mass one half and satisfies the displayed weak bound one half less than or equal to three halves."
  caption="**Exact finite example:** the observable values \(3,-1,-1,-1\) repeat around a uniform four-cycle, and the threshold is \(a=1/2\). The highlighted cells are all strict crossings: \(x_0\) crosses at times \(1,2,5\), and \(x_3\) crosses at time \(2\). Prefix events \(E_N\) increase to \(\{x_0,x_3\}\), while tail-witness events \(F_N\) decrease to the empty set by \(N=6\). Since every complete four-step block sums to zero, all four average sequences converge to zero. Thus one crossing does not imply arbitrarily late crossings, eventual crossing at every time, or a positive limit superior. Under the uniform probability measure, \(\mu(E_{1/2})=1/2\), while the general weak estimate gives the valid but loose bound \(1/2\le(3/4)/(1/2)=3/2\). All values are exact toy-model calculations, not empirical data."
>}}

## Three questions that sound similar but are not

For a fixed positive \(N\), compare these two tail questions:

\[
F_N=
\{x:\exists n\ge N,\ A_n g(x)\gt a\},
\]

\[
G_N=
\{x:\forall n\ge N,\ A_n g(x)\gt a\}.
\]

The first says **there is at least one witness at or after \(N\)**. The second
says **every time at or after \(N\) is a witness**. A single symbol change,
\(\exists\) to \(\forall\), changes the event drastically.

In the four-cycle example,

\[
\begin{aligned}
F_1&=F_2=\{x_0,x_3\},\\
F_3&=F_4=F_5=\{x_0\},\\
F_6&=F_7=\cdots=\varnothing.
\end{aligned}
\]

The sets \(F_N\) shrink because a later lower bound gives fewer possible
witness times. Their intersection is the event of **arbitrarily late**, or
infinitely many, strict crossings:

\[
\bigcap_{N\ge1}F_N
{} =
\{x:\forall N\ge1,\ \exists n\ge N,\ A_n g(x)\gt a\}
=\varnothing.
\]

For \(G_N\), choose a multiple of four with \(n\ge N\). Its average is zero,
so it does not exceed \(1/2\). Consequently \(G_N=\varnothing\) for every
\(N\), and the **eventually always above** event is also empty:

\[
\bigcup_{N\ge1}G_N
{} =
\{x:\exists N\ge1,\ \forall n\ge N,\ A_n g(x)\gt a\}
=\varnothing.
\]

The project event asks neither tail question. It asks only

\[
\exists n\ge1,\ A_n g(x)\gt a,
\]

so it is exactly \(F_1\). In this example that event has two points even
though both stronger tail events are empty.

## Prefix unions are different from tail intersections

For a finite upper horizon \(N\), define the **prefix event**

\[
E_{N,a}(g)
{} =
\{x:\exists n,\ 1\le n\le N\text{ and }a\lt A_n g(x)\}.
\]

As \(N\) grows, a prefix search keeps all earlier witnesses, so these events
increase. In the example,

\[
E_{0,1/2}=\varnothing,
\qquad
E_{1,1/2}=\{x_0\},
\qquad
E_{N,1/2}=\{x_0,x_3\}\quad(N\ge2).
\]

The infinite-horizon event is their exact union:

\[
E_a(g)=\bigcup_{N\in\mathbb N}E_{N,a}(g).
\]

The proof is elementary in both directions:

1. If \(x\in E_a(g)\), recover its finite witness time \(n\) and choose the
   finite horizon \(N=n\).
2. If \(x\in E_{N,a}(g)\) for some \(N\), keep the same witness \(n\) and
   remove only the upper bound \(n\le N\).

No measure, measurable structure, topology, integrability, or regularity of
\(T\) is needed for this set equality.

Do not confuse the increasing prefix family \(E_{N,a}\) with the decreasing
tail family \(F_N\). Their quantifiers are

\[
1\le n\le N
\qquad\text{versus}\qquad
n\ge N.
\]

## What the limit superior can and cannot tell us

The
{{< refterm "limit-superior" "limit superior" >}}, written
\(\limsup_{n\to\infty}A_n\), records the largest value that a sequence keeps
approaching along arbitrarily late times. It is a tail notion, unlike one
early crossing.

For the four-cycle, complete four-step blocks contribute zero and every
remaining partial sum has absolute value at most \(3\). Therefore

\[
\lvert A_n g(x)\rvert
\le\frac3n,
\]

and dividing the bounded remainder by \(n\) gives

\[
A_n g(x)\longrightarrow0
\qquad\text{for every }x\in\Omega.
\]

Therefore

\[
\limsup_{n\to\infty}A_n g(x)=0\lt\frac12
\]

for all four starts, including the two points in \(E_{1/2}(g)\). This is the
central misconception guardrail: **an infinite search for one finite witness
does not describe the long-time limit**.

For a real sequence with a well-defined finite limit superior, the safe
logical implications are:

\[
\limsup_n A_n\gt a
\quad\Longrightarrow\quad
\forall N\ \exists n\ge N,\ A_n\gt a,
\]

and

\[
\forall N\ \exists n\ge N,\ A_n\gt a
\quad\Longrightarrow\quad
\limsup_n A_n\ge a.
\]

Strict inequality is lost in the reverse direction. The sequence
\(a+1/n\) crosses \(a\) forever but has limit superior exactly \(a\). The
sequence \(a-1/n\) also has limit superior \(a\) but never crosses \(a\).
Likewise, eventual strict crossing at every time implies only that the
{{< refterm "limit-inferior" "limit inferior" >}} is at least \(a\), not
necessarily strictly greater than \(a\).

## General definition

Let \(\Omega\) be any state space, let \(T:\Omega\to\Omega\) be a discrete-time
transformation, let \(g:\Omega\to\mathbb R\) be a real observable, and let
\(a\in\mathbb R\). The infinite-horizon Birkhoff-average exceedance set is

\[
E_a(g)
{} =
\left\{\omega:\exists k\in\mathbb N,\
1\le k\text{ and }a\lt A_k g(\omega)\right\}.
\]

The word **infinite-horizon** means that there is no fixed upper bound on the
search. Every successful point still comes with one ordinary finite witness
\(k\). The definition introduces no infinite-duration average and no
real-valued maximum over all times.

The comparison is strict. If \(A_k g(\omega)=a\), time \(k\) is not a
witness. Time zero is excluded because an average of zero observations should
not create membership through a totalized library convention.

## Measurability: two proof routes

A
{{< refterm "measurable-space" "measurable space" >}} specifies which
subsets may be treated as events, and a
{{< refterm "measurable-function" "measurable function" >}} has measurable
preimages of measurable value-space sets. The four-state example uses the
discrete measurable structure, so every subset and every function is
measurable.

The repository exposes two different general interfaces.

### Ordinary measurable-set route

If \(T\) and \(g\) are measurable, every finite average is measurable. Each
strict superlevel set is then measurable, and the countable prefix union is a
measurable set:

\[
T\text{ measurable},\ g\text{ measurable}
\quad\Longrightarrow\quad
E_a(g)\text{ measurable}.
\]

### Null-measurable route

Suppose instead that \(T\) is a
{{< refterm "measure-preserving-transformation" "measure-preserving transformation" >}}
for a measure \(\mu\), and \(g\) is
{{< refterm "integrability" "integrable" >}}. Then every positive-time
average has enough almost-everywhere measurability for its strict superlevel
set to agree with a measurable set outside a
{{< refterm "null-set" "null set" >}}. A countable union preserves that
property, so \(E_a(g)\) is **null measurable** with respect to \(\mu\).

This second conclusion is weaker than ordinary measurability and is stated as
such in Lean. It needs no finite total mass, probability normalization, or
ergodicity. It is an example of why
{{< refterm "almost-everywhere" "almost-everywhere" >}} language must not be
silently replaced by pointwise language.

## Measures of the increasing finite events

A measure in Mathlib returns an **extended nonnegative real**: an ordinary
nonnegative number together with a possible value \(\infty\). Continuity from
below gives

\[
\mu(E_{N,a}(g))
\longrightarrow
\mu(E_a(g))
\]

in that extended number system. For this theorem, monotonicity of the prefix
events is enough. The target may be infinite, and the checked interface does
not require the sets themselves to be measurable.

Mathlib also defines a real-valued projection

\[
\mu_{\mathbb R}(S)=\operatorname{toReal}(\mu(S)),
\]

written <code>μ.real S</code> in Lean. This totalized operation maps infinite
mass to zero. It is therefore not continuous at \(\infty\). The repository's
real-valued convergence theorem uses the clean sufficient local condition

\[
\mu(E_a(g))\ne\infty.
\]

That condition is sufficient, not necessary for every special family.

Here is the failure mode it prevents. Under counting measure on the natural
numbers, let \(H_N=\{0,\ldots,N-1\}\). Then \(H_N\uparrow\mathbb N\), but

\[
\mu_{\mathbb R}(H_N)=N
\qquad\text{while}\qquad
\mu_{\mathbb R}(\mathbb N)=0,
\]

because the union has infinite extended mass. The real sequence \(N\) does
not converge to zero.

## The weak measure bound, numerically first

Return to the uniform four-cycle. The positive part
\(g^+(x)=\max\{g(x),0\}\) equals \(3\) at \(x_0\) and \(0\) elsewhere, so

\[
\int_\Omega g^+\,d\mu
{} =3\cdot\frac14
{} =\frac34.
\]

We already found \(\mu(E_{1/2}(g))=1/2\). The multiplication form says

\[
\frac12\cdot\frac12
{} =\frac14
\le
\frac34.
\]

Dividing by the positive threshold gives

\[
\mu(E_{1/2}(g))
{} =\frac12
\le
\frac{\frac34}{\frac12}
{} =\frac32.
\]

The right side can exceed one even on a probability space. The theorem is an
upper bound, not a probability normalization formula and not an equality.

In general, if \(\mu\) is finite, \(T\) preserves \(\mu\), and \(g\) is
integrable, the checked multiplication estimate is

\[
a\,\mu_{\mathbb R}(E_a(g))
\le
\int_\Omega \max\{g(\omega),0\}\,d\mu(\omega).
\]

This form is valid for every real \(a\). Division is order preserving only
when \(a\gt0\), which yields

\[
\mu_{\mathbb R}(E_a(g))
\le
\frac{\displaystyle\int_\Omega \max\{g(\omega),0\}\,d\mu(\omega)}{a}.
\]

The numerator is the integral of the positive part, not the absolute value
and not the integral of a centered observable.

## In Lean

The definition says exactly that one positive natural time is a strict
witness.

{{< lean-bridge
  human="A starting point omega belongs when at least one positive finite-time average is strictly above the threshold a."
  math="\(\omega\in E_a(g)\Longleftrightarrow\exists k\in\mathbb N,\ 1\le k\text{ and }a\lt A_k g(\omega).\)"
  lean="ω ∈ birkhoffAverageExceedanceSet T g a ↔\n  ∃ k, 1 ≤ k ∧ a < birkhoffAverage ℝ T g k ω"
>}}

- <code>ω ∈ birkhoffAverageExceedanceSet T g a</code> is set membership.
- <code>∃ k</code> introduces one natural-number witness.
- <code>∧</code> requires both positive time and strict crossing.
- <code>1 ≤ k</code> excludes time zero.
- <code>birkhoffAverage ℝ T g k ω</code> is the real-valued average of the
  first \(k\) readings of \(g\) along the \(T\)-orbit of \(\omega\).
- The final <code>&lt;</code> is strict, so equality with the threshold does not
  count.
{{< /lean-bridge >}}

The exact checked definition and membership theorem are:

~~~lean
def birkhoffAverageExceedanceSet
    (T : Ω → Ω) (g : Ω → ℝ) (a : ℝ) : Set Ω :=
  {ω | ∃ k, 1 ≤ k ∧ a < birkhoffAverage ℝ T g k ω}

@[simp] theorem mem_birkhoffAverageExceedanceSet_iff
    {a : ℝ} {ω : Ω} :
    ω ∈ birkhoffAverageExceedanceSet T g a ↔
      ∃ k, 1 ≤ k ∧ a < birkhoffAverage ℝ T g k ω := by
  rfl
~~~

The exact prefix union is a separate theorem.

{{< lean-bridge
  human="Searching all positive times is exactly the same as taking the union of the searches through each finite horizon N."
  math="\(E_a(g)=\bigcup_{N\in\mathbb N}E_{N,a}(g).\)"
  lean="birkhoffAverageExceedanceSet T g a =\n  ⋃ N : ℕ, finiteBirkhoffAverageExceedanceSet T g N a"
>}}

- <code>⋃ N : ℕ</code> is an indexed union over every natural-number horizon.
- <code>finiteBirkhoffAverageExceedanceSet T g N a</code> scans exactly the
  times \(1\le k\le N\).
- Equality is literal set equality, not equality only up to a null set.
- The proof chooses <code>N := k</code> from an infinite-event witness in one
  direction and removes <code>k ≤ N</code> in the other.
{{< /lean-bridge >}}

Ordinary measurability records its assumptions explicitly.

{{< lean-bridge
  human="If the time-one map T and the observable g are measurable, then the infinite-horizon exceedance set is measurable."
  math="\(T,g\text{ measurable}\Longrightarrow E_a(g)\in\mathcal F.\)"
  lean="measurableSet_birkhoffAverageExceedanceSet hT hg a"
>}}

- <code>hT : Measurable T</code> is the hypothesis for the dynamics.
- <code>hg : Measurable g</code> is the hypothesis for the observable.
- <code>MeasurableSet</code> is the conclusion about the set.
- The theorem rewrites the event as the countable union and applies finite
  measurability at each horizon.
{{< /lean-bridge >}}

The measure limit stays in extended nonnegative reals unless a finite target
licenses the real projection.

{{< lean-bridge
  human="The extended measures of the increasing finite-horizon events converge to the extended measure of their union."
  math="\(\mu(E_{N,a})\to\mu(E_a).\)"
  lean="tendsto_measure_finiteBirkhoffAverageExceedanceSet (T := T) (g := g) (μ := μ) a"
>}}

- <code>Tendsto</code>, visible in the theorem's result type, is Lean's
  filter-based convergence relation.
- <code>atTop</code> means \(N\to\infty\) through natural horizons.
- <code>nhds</code> is the neighborhood filter of the target measure.
- The theorem returns convergence before <code>Measure.real</code> is applied,
  so infinite mass is allowed.
{{< /lean-bridge >}}

Finally, positivity appears exactly where the multiplication estimate is
divided by \(a\).

{{< lean-bridge
  human="On a finite measure space, if T preserves mu, g is integrable, and a is positive, then the real measure of the crossing event is at most the positive-part integral divided by a."
  math="\(0\lt a\Longrightarrow\mu_{\mathbb R}(E_a(g))\le a^{-1}\int g^+\,d\mu.\)"
  lean="measureReal_birkhoffAverageExceedanceSet_le hT hg ha"
>}}

- <code>[IsFiniteMeasure μ]</code> is the finite-total-mass typeclass
  assumption in the theorem signature.
- <code>hT : MeasurePreserving T μ μ</code> says the source and target measure
  are both \(\mu\).
- <code>hg : Integrable g μ</code> supplies integrability.
- <code>ha : 0 &lt; a</code> is the division gate.
- <code>μ.real</code> converts a finite extended measure value to a real
  number.
- <code>∫ ω, max (g ω) 0 ∂μ</code> is \(\int g^+\,d\mu\).
{{< /lean-bridge >}}

The exact checked theorem is:

~~~lean
theorem measureReal_birkhoffAverageExceedanceSet_le
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ)
    {a : ℝ} (ha : 0 < a) :
    μ.real (birkhoffAverageExceedanceSet T g a) ≤
      (∫ ω, max (g ω) 0 ∂μ) / a
~~~

## Standalone tutorial

**Standalone tutorial.** This worksheet imports only Lean's
<code>Std</code> library. It does not import Mathlib or this project. It
computes integer orbit sums for the exact four-cycle above. At positive time
\(n\), the threshold test

\[
\frac12\lt\frac{S_n}{n}
\]

is encoded without fractions as \(n\lt2S_n\).

Save this as <code>InfiniteHorizonExceedanceWorksheet.lean</code> in a
temporary directory outside the repository:

~~~lean
import Std

namespace InfiniteHorizonExceedanceWorksheet

inductive Point where
  | p0
  | p1
  | p2
  | p3
deriving Repr, DecidableEq

def points : List Point := [.p0, .p1, .p2, .p3]

def step : Point → Point
  | .p0 => .p1
  | .p1 => .p2
  | .p2 => .p3
  | .p3 => .p0

def reading : Point → Int
  | .p0 => 3
  | .p1 => -1
  | .p2 => -1
  | .p3 => -1

def sumFrom : Nat → Point → Int
  | 0, _ => 0
  | n + 1, x => reading x + sumFrom n (step x)

def crossesAt (n : Nat) (x : Point) : Bool :=
  decide (1 ≤ n ∧ Int.ofNat n < 2 * sumFrom n x)

def crossesThrough (upper : Nat) (x : Point) : Bool :=
  (List.range (upper + 1)).any fun n => crossesAt n x

def crossesBetween (lower upper : Nat) (x : Point) : Bool :=
  (List.range (upper + 1)).any fun n =>
    decide (lower ≤ n) && crossesAt n x

def firstSixSums (x : Point) : List Int :=
  (List.range 6).map fun j => sumFrom (j + 1) x

#eval firstSixSums .p0
#eval firstSixSums .p3
#eval points.filter (crossesThrough 0)
#eval points.filter (crossesThrough 1)
#eval points.filter (crossesThrough 2)
#eval points.filter (crossesBetween 3 12)
#eval points.filter (crossesBetween 6 12)

example : firstSixSums .p0 = [3, 2, 1, 0, 3, 2] := by decide
example : firstSixSums .p3 = [-1, 2, 1, 0, -1, 2] := by decide
example : points.filter (crossesThrough 0) = [] := by decide
example : points.filter (crossesThrough 1) = [.p0] := by decide
example : points.filter (crossesThrough 2) = [.p0, .p3] := by decide
example : points.filter (crossesBetween 3 12) = [.p0] := by decide
example : points.filter (crossesBetween 6 12) = [] := by decide

end InfiniteHorizonExceedanceWorksheet
~~~

From that temporary directory, a human with the pinned Lean toolchain already
installed can type:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean \
  InfiniteHorizonExceedanceWorksheet.lean
~~~

The first two evaluations print the partial sums
\([3,2,1,0,3,2]\) and \([-1,2,1,0,-1,2]\). The next three print the prefix
events \(\varnothing\), \(\{x_0\}\), and \(\{x_0,x_3\}\). The last two search
the displayed tail window: \(x_0\) still has its time-five witness when the
lower bound is three, and no point has a witness from six through twelve. The
paper bound \(S_n\le3\) proves the stronger statement for every \(n\ge6\);
the finite program is not presented as a proof about infinitely many times.
This exact worksheet was executed successfully with the pinned Lean 4.32.0
compiler; it imports only <code>Std</code> and does not load the
project or Mathlib.

## Try it in the repository

{{< repo-check >}}
**Full project check.** This uses the repository's pinned Lean and Mathlib
dependencies and may require substantial disk space and memory.
The authoritative checked
source is
[<code>formalization/NonlinearDynamics/Random/RandomCocycles/InfiniteHopfMaximal.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/InfiniteHopfMaximal.lean).
Create a temporary project probe containing:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.InfiniteHopfMaximal

open MeasureTheory Set Filter
open NonlinearDynamics.Random.RandomCocycles

#check birkhoffAverage
#check finiteBirkhoffAverageExceedanceSet
#check mem_finiteBirkhoffAverageExceedanceSet_iff
#check finiteBirkhoffAverageExceedanceSet_mono
#check birkhoffAverageExceedanceSet
#check mem_birkhoffAverageExceedanceSet_iff
#check birkhoffAverageExceedanceSet_eq_iUnion_finite
#check finiteBirkhoffAverageExceedanceSet_subset
#check measurableSet_birkhoffAverageExceedanceSet
#check nullMeasurableSet_birkhoffAverageExceedanceSet_of_integrable
#check tendsto_measure_finiteBirkhoffAverageExceedanceSet
#check tendsto_measureReal_finiteBirkhoffAverageExceedanceSet
#check birkhoffAverageExceedanceSet_posPart_bound
#check measureReal_birkhoffAverageExceedanceSet_le

#check MeasureTheory.tendsto_measure_iUnion_atTop
#check MeasureTheory.Measure.real
#check ENNReal.tendsto_toReal
~~~

Each <code>#check</code> asks the pinned elaborator to display an exact type.
The first group follows the repository proof from finite witnesses through
measurability, measure limits, and the weak bound. The final three queries
expose the pinned Mathlib interfaces for continuity from below, real-valued
measure projection, and continuity of that projection away from infinity.
The full-project command rendered below checks the complete authoritative module
with the repository's pinned Lean and Mathlib dependencies
installed.
{{< /repo-check >}}

## Boundary cases and nonclaims

- **Horizon zero:** \(E_{0,a}(g)=\varnothing\) because no natural time
  satisfies \(1\le k\le0\).
- **Equality:** \(A_k g(\omega)=a\) is not a crossing. Replacing \(\lt\) by
  \(\le\) defines a different event.
- **Zero observable:** if \(g=0\) and \(a\ge0\), the event is empty. If
  \(a\lt0\), time one witnesses every point, so the event is all of \(\Omega\).
- **Negative threshold:** the multiplication estimate remains valid, but its
  left side is nonpositive and may convey little information. Division needs
  \(a\gt0\).
- **Infinite mass:** extended-measure continuity still works. Unconditional
  passage through <code>Measure.real</code> does not.
- **Null measurability:** this is agreement with a measurable set outside a
  null set, not automatically ordinary measurability.

Membership in \(E_a(g)\) does not assert:

- convergence of the Birkhoff averages;
- any value for their limit superior or limit inferior;
- arbitrarily late or infinitely many crossings;
- eventual crossing at every time;
- invariance of the event under \(T\);
- probability zero or one;
- ergodicity, mixing, or independence;
- injectivity, surjectivity, or invertibility of \(T\);
- existence of a real-valued maximum over all times;
- a strong \(L^p\) maximal inequality;
- the pointwise Birkhoff or Kingman ergodic theorem; or
- a Lyapunov exponent or an Oseledets splitting.

The weak estimate controls the measure of one event. It does not, by itself,
prove a long-time convergence theorem.

## Where to continue

The
{{< refterm "finite-maximal-ergodic-inequality" "finite maximal ergodic inequality" >}}
supplies the uniform finite-horizon bound that is passed through the exact
increasing union. The
{{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}}
asks whether the whole average sequence converges, which is a different
predicate.

[From Finite Maximal Bounds to an Infinite Weak Estimate]({{< relref "/knowledge-base/deep-dives/from-finite-maximal-bounds-to-an-infinite-weak-estimate" >}})
develops the proof architecture as a textbook chapter. The matching checked
implementation narrative is
[Infinite-Horizon Birkhoff-Average Exceedance Bounds in Lean]({{< relref "/development-notebook/2026/07/infinite-horizon-birkhoff-average-exceedance-bounds-in-lean" >}}).

Repository milestone 24 (RMT-24) is the current formalized scope: the event,
its finite union, two measurability routes, extended and locally finite real
measure limits, and the weak measure estimate. It does not include a
pointwise ergodic theorem.

## References

**Kôsaku Yosida and Shizuo Kakutani.**
[Birkhoff's Ergodic Theorem and the Maximal Ergodic Theorem](https://doi.org/10.3792/pia/1195579375),
*Proceedings of the Imperial Academy* 15(6), 165-168, 1939. Their Theorem 2
gives the historical infinite-horizon maximal-ergodic setting. It is not
claimed as the exact source of the repository's increasing-union proof.

**Michael Keane and Karl Petersen.**
[Easy and Nearly Simultaneous Proofs of the Ergodic Theorem and Maximal Ergodic Theorem](https://doi.org/10.1214/074921706000000266),
*IMS Lecture Notes-Monograph Series* 48, 248-251, 2006, with
[arXiv:math/0608251](https://arxiv.org/abs/math/0608251). Pages 248-249 give a
close primary precedent for passing from finite strict average events to an
infinite maximal statement in a probability-space argument.

**Mathlib contributors.**
[Continuity from below for increasing sets](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/MeasureSpace.lean#L648-L654)
and
[continuity of extended-nonnegative-real conversion away from infinity](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/Instances/ENNReal/Lemmas.lean#L103-L107),
Mathlib 4.32.0. These are the exact limit interfaces used by RMT-24.

**Mathlib contributors.**
[Definition of <code>Measure.real</code>](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/MeasureSpaceDef.lean#L99-L107),
Mathlib 4.32.0. The source records explicitly that infinite measure is mapped
to zero.

The exact upstream Lean source audited for this page is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
