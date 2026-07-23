---
title: "Finite Block Decomposition for Subadditive Processes"
slug: "finite-block-decomposition-for-subadditive-processes"
date: 2026-07-21
summary: "Cut an exact eleven-step process into two four-step blocks and a three-step remainder in both temporal orientations, then climb to the checked finite Birkhoff-sum bounds and their precise boundary assumptions."
lead: "Finite blocking is arithmetic plus shifted subadditivity. This chapter makes every sample point, quotient, remainder, empty sum, and integrability gate visible before any probability, ergodicity, or convergence theorem enters."
draft: false
pro_reviewed: false
level: "Natural-number quotient and remainder, powered function iterates, finite Birkhoff sums, integrability, shifted subadditivity, and discrete matrix cocycles"
reading_time: "110 to 145 minutes"
prerequisites: "Finite sums and natural-number division; iterates, measures, integrability, and Lean notation are introduced when they first appear"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveFiniteBlocks"
toc: true
og_image: "finite-block-decomposition-for-subadditive-processes-card.png"
og_image_alt: "Eleven exact weights totaling 40 are cut as four plus four plus three with sums 12, 18, and 10, and as three plus four plus four with sums 8, 15, and 17. Both orientations total 40."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note. Its
mathematical prose, Lean declaration map, figures, and accessibility have not
yet received the required human and Pro reviews. The checked Lean source is
authoritative where prose and code disagree.
{{< /panel >}}

## Begin with eleven weights and make both cuts

Take the finite state space

\[
\Omega=\{0,1,\ldots,11\}
\]

and advance one state cyclically:

\[
T(s)=s+1\pmod {12}.
\]

Attach these nonnegative one-step weights:

| state \(s\) | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| \(w(s)\) | 2 | 5 | 1 | 4 | 3 | 6 | 2 | 7 | 1 | 5 | 4 | 6 |

Interpret these integers as real weights.

Starting at state \(s\), define the finite process

\[
X_n(s)=\sum_{t=0}^{n-1}w(T^t s).
\]

The zero-step sum is empty, so \(X_0(s)=0\). This process is **additive**:

\[
X_{m+k}(s)=X_m(s)+X_k(T^m s).
\]

Every additive process is subadditive because equality implies the required
upper bound. We use additivity only to make the example's arithmetic exact.
The project theorem assumes the weaker inequality.

If this finite space is given its uniform probability measure, every displayed
finite-horizon function is integrable and the cyclic base preserves the
measure. Probability is convenient for this model, not an assumption of the
pointwise block theorems.

Choose:

\[
n=11,
\qquad
b=4.
\]

Natural-number division gives:

\[
q=n/b=11/4=2,
\qquad
r=n\bmod b=11\bmod4=3.
\]

The arithmetic identity is

\[
bq+r=4\cdot2+3=11.
\]

The eleven observed weights from state zero are

\[
2,\ 5,\ 1,\ 4,\ 3,\ 6,\ 2,\ 7,\ 1,\ 5,\ 4,
\]

and their total is

\[
X_{11}(0)=40.
\]

### Orientation one: complete blocks first

Cut the horizon as

\[
11=4+4+3.
\]

The first block starts at state \(0\), the second at \(T^4(0)=4\), and the
terminal remainder at \(T^8(0)=8\):

\[
\begin{aligned}
X_4(0)&=2+5+1+4=12,\\
X_4(T^4 0)&=3+6+2+7=18,\\
X_3(T^8 0)&=1+5+4=10.
\end{aligned}
\]

Thus

\[
X_{11}(0)=12+18+10=40.
\]

For a merely subadditive process, the checked theorem replaces this equality
with \(\le\).

### Orientation two: remainder first

The same natural number is also

\[
11=3+4+4.
\]

Now the three-step remainder stays at the original state, and the complete
blocks begin at \(T^3(0)=3\):

\[
\begin{aligned}
X_3(0)&=2+5+1=8,\\
X_4(T^3 0)&=4+3+6+2=15,\\
X_4(T^7 0)&=7+1+5+4=17.
\end{aligned}
\]

Again,

\[
X_{11}(0)=8+15+17=40.
\]

The same eleven times were partitioned differently. The real summands may be
written in any arithmetic order, but their **starting states** cannot be
moved freely.

{{< reference-figure
  wide="true"
  src="two-finite-block-orientations.svg"
  alt="The eleven weights 2, 5, 1, 4, 3, 6, 2, 7, 1, 5, 4 total 40. Blocks first groups them into four-step sums 12 and 18 plus terminal three-step sum 10. Remainder first groups them into initial three-step sum 8 plus shifted four-step sums 15 and 17. Both exact totals are 40."
  caption="**Finding:** quotient \(q=2\) and remainder \(r=3\) determine two valid temporal cuts. Blocks first samples the remainder after eight steps; remainder first begins the block orbit after three steps. Equality holds because this teaching process is additive. The checked general declarations prove upper bounds and contain no infinite-time conclusion."
>}}

## The wrong shift fails numerically

Suppose we keep the two correct block sums \(12\) and \(18\) but evaluate the
three-step terminal remainder back at the original state. That wrong term is
\(X_3(0)=8\), not \(X_3(T^8 0)=10\). The proposed bound becomes

\[
40\le12+18+8=38,
\]

which is false.

The analogous wrong remainder-first calculation also fails. If the initial
remainder is \(8\) but the two blocks incorrectly restart at states \(0\) and
\(4\), the right side is

\[
8+12+18=38.
\]

Moving a remainder from one end of the horizon to the other changes the
starting state of every later term. Shifted subadditivity records exactly that
temporal information.

### Time-zero boundary: subadditive does not mean normalized

Consider the constant process

\[
Y_n(s)=5
\]

for every horizon and state. It is subadditive:

\[
5\le5+5.
\]

On the same finite space with its uniform probability measure, every
\(Y_n\) is integrable, so this process also fits the public candidate package.

But \(Y_0(s)=5\), not zero. With zero complete blocks, an exact-block estimate
without a normalization premise would say

\[
Y_{b\cdot0}(s)\le
\operatorname{birkhoffSum}(T^b,Y_b,0,s),
\]

or

\[
5\le0.
\]

That is false. This is why the uniform exact-block theorem takes
\(X_0=0\). The two remainder theorems do not need that premise: when the block
count is zero, the remainder is the whole horizon and the inequality becomes
reflexive.

### Zero block length: valid but degenerate

Lean's natural-number operations are total:

\[
11/0=0,
\qquad
11\bmod0=11.
\]

At \(b=0\), the terminal quotient-and-remainder theorem reduces to

\[
X_{11}(s)\le0+X_{11}(s).
\]

The statement remains true, but zero is not a useful coarse-graining scale.
To claim that \(r=n\bmod b\) is strictly shorter than \(b\), one must add the
separate premise \(b\gt0\).

{{< reference-figure
  wide="true"
  src="finite-block-boundaries-and-near-miss.svg"
  alt="The correct two orientations both give the true upper bound 40 less than or equal to 40. Reusing the original remainder gives only 38 and the false statement 40 less than or equal to 38. A quotient panel shows 11 divided by 4 equals 2 with remainder 3, while division by zero gives quotient 0 and remainder 11. A constant process equal to 5 shows why zero exact blocks require X zero equal to zero."
  caption="**Finding:** three independent checks protect the theorem. Sample points must follow temporal order; positive block length is needed only for a genuinely short remainder; and a zero-count exact-block estimate needs \(X_0=0\). The finite integrability result later adds preservation of \(T^b\), but none of these checks introduces probability, ergodicity, or convergence."
>}}

## Name the objects before climbing

Fix a measurable space \(\Omega\), a measure \(\mu\), a base map
\(T:\Omega\to\Omega\), and a real process

\[
X:\mathbb N\to\Omega\to\mathbb R.
\]

| Object | Mathematics | Lean |
|---|---|---|
| Horizon-\(n\) sample value | \(X_n(\omega)\) | <code>X n ω</code> |
| \(m\)-step base shift | \(T^m\omega\) | <code>T^[m] ω</code> |
| Block map | \(T^b\) | <code>T^[b]</code> |
| Block observable | \(X_b\) | <code>X b</code> |
| \(q\)-block finite sum | \(\sum_{j=0}^{q-1}X_b(T^{bj}\omega)\) | <code>birkhoffSum (T^[b]) (X b) q ω</code> |
| Quotient | \(\lfloor n/b\rfloor\) | <code>n / b</code> |
| Remainder | \(n\bmod b\) | <code>n % b</code> |

The inherited structure

~~~lean
IsIntegrableSubadditiveProcessCandidate T μ X
~~~

stores exactly:

1. <code>Integrable (X k) μ</code> for every finite \(k\); and
2. the shifted subadditive inequality for every \(m,k,\omega\).

It does not store:

- that \(\mu\) is a {{< refterm "probability-measure" "probability measure" >}};
- that \(T\) preserves \(\mu\);
- that \(T\) is {{< refterm "ergodicity" "ergodic" >}};
- independence or mixing;
- uniform control as \(n\) varies; or
- any pointwise, almost-everywhere, or integrated limit.

The word “integrable” concerns each fixed finite function. It does not turn a
finite family into an asymptotic theorem.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| Concrete route | [The eleven weights](#begin-with-eleven-weights-and-make-both-cuts) | Reproduce both exact block ledgers |
| Error route | [The wrong shift](#the-wrong-shift-fails-numerically) | See a false upper bound caused by one misplaced sample |
| Algebra route | [Camp one](#camp-one-read-shifted-subadditivity-in-the-correct-order) | Follow the directional split used by every helper |
| Sum route | [Camp two](#camp-two-a-birkhoff-sum-is-a-finite-container) | Expand the powered-map finite sum |
| Arithmetic route | [Camp four](#camp-four-let-division-choose-q-and-r) | Read both quotient-and-remainder declarations |
| Boundary route | [Camp five](#camp-five-time-zero-needs-its-own-ledger) | Separate \(X_0\ge0\) from \(X_0=0\) |
| Analysis route | [Camp six](#camp-six-finite-integrability-needs-the-powered-map) | Identify the exact measure-preservation premise |
| Hands-on route | [Run the worksheet](#type-the-eleven-step-ledger-with-lean-and-std) | Execute all arithmetic with Lean core and <code>Std</code> |
| Audit route | [The declaration map](#the-complete-twelve-declaration-map) | Match every public name to its assumptions |

### Learning objectives

By the summit, you should be able to:

1. compute \(11/4=2\) and \(11\bmod4=3\);
2. reproduce both exact \(40\)-unit ledgers;
3. explain why their block starting states differ;
4. reject the false \(40\le38\) unshifted bound;
5. state shifted subadditivity with the later term at \(T^m\omega\);
6. expand a finite Birkhoff sum along the powered map \(T^b\);
7. derive the terminal-remainder inequality by induction on \(q\);
8. derive the remainder-first inequality by one outer split;
9. read both quotient-and-remainder identities;
10. distinguish the valid \(b=0\) statement from a short-remainder claim;
11. prove that subadditivity forces \(X_0\ge0\);
12. explain why it does not force \(X_0=0\);
13. identify which exact-block theorem avoids normalization by requiring
    \(q\ne0\);
14. identify which exact-block theorem accepts all \(q\) by assuming
    \(X_0=0\);
15. separate pointwise bounds from finite integrability;
16. explain why the generic integrability theorem asks only that \(T^b\)
    preserve \(\mu\);
17. distinguish measure preservation from probability and ergodicity;
18. run the exact local worksheet;
19. identify the three cocycle specializations and their assumptions; and
20. list every asymptotic conclusion still absent.

## Camp one: read shifted subadditivity in the correct order

The process package stores:

~~~lean
add_le : ∀ m k ω, X (m + k) ω ≤ X k (T^[m] ω) + X m ω
~~~

The early \(m\)-step value is \(X_m(\omega)\). The later \(k\)-step value
restarts at \(T^m\omega\).

### In Lean: split an early block from a later block

{{< lean-bridge
  human="Run m steps from omega, then measure the later k-step contribution from the environment reached after those m steps. The combined value is at most their sum."
  math="\(X_{m+k}(\omega)\le X_k(T^m\omega)+X_m(\omega)\)."
  lean="hX.add_le m k ω"
>}}

- <code>hX</code> is evidence that \(X\) is an
  <code>IsIntegrableSubadditiveProcessCandidate</code>.
- <code>.add_le</code> selects its shifted pointwise inequality field.
- <code>m + k</code> is the combined natural horizon.
- <code>T^[m]</code> is the \(m\)-fold function iterate of the base map.
- <code>X k (T^[m] ω)</code> is the later value at the shifted sample.
- <code>X m ω</code> is the early value at the original sample.
- This field is pointwise algebra. Its type contains no probability,
  preservation, ergodicity, or limiting quantifier.
{{< /lean-bridge >}}

The source's three private helpers read only this field. The public generic
theorems are methods on the stronger package for convenience, but their
pointwise proofs do not consume its <code>integrable</code> field.

## Camp two: a Birkhoff sum is a finite container

Mathlib defines

\[
\operatorname{birkhoffSum}(F,g,q,\omega)
=\sum_{j=0}^{q-1}g(F^j\omega).
\]

In this chapter,

\[
F=T^b,
\qquad
g=X_b.
\]

Therefore

\[
\begin{aligned}
\operatorname{birkhoffSum}(T^b,X_b,q,\omega)
&=\sum_{j=0}^{q-1}X_b((T^b)^j\omega)\\
&=\sum_{j=0}^{q-1}X_b(T^{bj}\omega).
\end{aligned}
\]

The sum is finite. At \(q=0\), its index set is empty and its value is zero.

### In Lean: sample one block observable along the powered base

{{< lean-bridge
  human="Start at omega, advance the base by one whole block between samples, evaluate the b-step process each time, and add exactly q terms."
  math="\(B_{b,q}(\omega)=\sum_{j=0}^{q-1}X_b(T^{bj}\omega)\)."
  lean="birkhoffSum (T^[b]) (X b) q ω"
>}}

- <code>birkhoffSum</code> is Mathlib's finite-orbit sum.
- <code>T^[b]</code> is the block map, not the original one-step map.
- <code>X b</code> is the block observable, a function
  \(\Omega\to\mathbb R\).
- <code>q</code> is the number of terms.
- <code>ω</code> is the starting sample.
- Iterating <code>T^[b]</code> \(j\) times reaches \(T^{bj}\omega\).
- Nothing in this expression takes a limit or divides by \(q\).
{{< /lean-bridge >}}

Mathlib exposes two useful successor recurrences:

\[
\begin{aligned}
\operatorname{birkhoffSum}(F,g,q+1,\omega)
&=\operatorname{birkhoffSum}(F,g,q,\omega)+g(F^q\omega),\\
\operatorname{birkhoffSum}(F,g,q+1,\omega)
&=g(\omega)+\operatorname{birkhoffSum}(F,g,q,F\omega).
\end{aligned}
\]

The private blocks-first induction uses the second orientation because it
peels the first block and recurses from \(T^b\omega\).

## Camp three: prove blocks first and leave the remainder last

The central private helper proves:

\[
X_{bq+r}(\omega)
\le
\operatorname{birkhoffSum}(T^b,X_b,q,\omega)
+X_r((T^b)^q\omega).
\]

### Base case: \(q=0\)

The horizon is \(r\). The Birkhoff sum is empty and
\((T^b)^0\omega=\omega\), so the goal reduces to

\[
X_r(\omega)\le0+X_r(\omega).
\]

No claim about \(X_0\) is needed.

### Successor step

For \(q+1\) blocks, arithmetic rewrites

\[
b(q+1)+r=b+(bq+r).
\]

Shifted subadditivity peels the first full block:

\[
X_{b+(bq+r)}(\omega)
\le
X_{bq+r}(T^b\omega)+X_b(\omega).
\]

Apply the induction hypothesis at \(T^b\omega\). Mathlib's
<code>birkhoffSum_succ'</code> then packages the first block with the recursive
sum, and the iterate successor identity moves the terminal remainder to the
correct final state.

### In Lean: invoke the terminal-remainder theorem

{{< lean-bridge
  human="Bound q complete b-step blocks from omega, then evaluate the r-step remainder after all q blocks have advanced the environment."
  math="\(X_{bq+r}(\omega)\le\sum_{j=0}^{q-1}X_b(T^{bj}\omega)+X_r(T^{bq}\omega)\)."
  lean="hX.le_birkhoffSum_blocks_add_remainder b q r ω"
>}}

- <code>b q r</code> are arbitrary natural numbers.
- <code>b * q + r</code> is the blocks-first horizon.
- The Birkhoff term uses <code>(T^[b])</code>, <code>(X b)</code>, and
  count <code>q</code>.
- The terminal sample is written
  <code>((T^[b])^[q] ω)</code> in the theorem statement.
- This is \(T^{bq}\omega\), not the original <code>ω</code>.
- No condition on <code>X 0</code> occurs.
- The proof uses shifted subadditivity only, despite the stronger receiver
  type of <code>hX</code>.
{{< /lean-bridge >}}

The opening example substitutes \(b=4,q=2,r=3,\omega=0\), producing the exact
right side \(12+18+10\).

## Camp four: let division choose \(q\) and \(r\)

For any naturals \(n,b\), Lean proves the total identity

\[
b(n/b)+(n\bmod b)=n.
\]

Substituting \(q=n/b\) and \(r=n\bmod b\) into the terminal theorem gives:

### In Lean: quotient form with the remainder last

{{< lean-bridge
  human="Let natural-number division choose the number of complete blocks and the leftover length, then use the blocks-first bound."
  math="\(X_n(\omega)\le\sum_{j=0}^{n/b-1}X_b(T^{bj}\omega)+X_{n\bmod b}(T^{b(n/b)}\omega)\)."
  lean="hX.le_birkhoffSum_div_add_mod b n ω"
>}}

- <code>n / b</code> is the natural quotient.
- <code>n % b</code> is the natural remainder.
- <code>Nat.div_add_mod</code> supplies
  \(b(n/b)+(n\bmod b)=n\).
- The short term is terminal and therefore evaluated after all complete
  blocks.
- At <code>b = 0</code>, quotient zero and remainder <code>n</code> make this
  a reflexive inequality.
- The strict fact <code>n % b &lt; b</code> needs a positive block-length
  premise; this theorem does not need it for validity.
{{< /lean-bridge >}}

### Remainder first

Commutativity of natural addition also gives

\[
n=(n\bmod b)+b(n/b).
\]

But we cannot merely commute two real terms after proving the terminal
formula. We must apply shifted subadditivity with the remainder as the
**early** part. Complete blocks then start from \(T^{n\bmod b}\omega\).

### In Lean: quotient form with the remainder first

{{< lean-bridge
  human="Take the leftover steps first at omega, then begin every complete block from the environment reached after that initial remainder."
  math="\(X_n(\omega)\le X_{n\bmod b}(\omega)+\sum_{j=0}^{n/b-1}X_b(T^{n\bmod b+bj}\omega)\)."
  lean="hX.le_mod_add_birkhoffSum_div b n ω"
>}}

- <code>X (n % b) ω</code> keeps the remainder at the original sample.
- <code>T^[n % b] ω</code> is the starting sample for the later block orbit.
- The Birkhoff map remains <code>T^[b]</code>.
- The block count remains <code>n / b</code>.
- <code>Nat.mod_add_div</code> supplies
  \((n\bmod b)+b(n/b)=n\).
- No <code>X 0 = 0</code> premise occurs, even when the quotient is zero.
- For \(n=11,b=4\), the right side is \(8+15+17\).
{{< /lean-bridge >}}

The generic non-quotient declaration
<code>le_remainder_add_birkhoffSum_blocks</code> takes explicit
\(r,b,q\). The quotient declaration simply chooses those values arithmetically.

## Camp five: time zero needs its own ledger

### Declaration 1: subadditivity forces nonnegativity

Set \(m=k=0\) in shifted subadditivity:

\[
X_0(\omega)\le X_0(\omega)+X_0(\omega).
\]

Subtracting \(X_0(\omega)\) gives

\[
0\le X_0(\omega).
\]

The theorem <code>zero_nonneg</code> records this pointwise fact.

### Declaration 2: nonpositive is equivalent to zero

Because subadditivity already gives \(X_0\ge0\),

\[
X_0=0
\quad\Longleftrightarrow\quad
\forall\omega,\ X_0(\omega)\le0.
\]

This is <code>zero_eq_zero_iff_nonpos</code>. The right-to-left direction
combines the stored nonnegativity with the supplied nonpositivity.

### Exact blocks with positive count

If \(q\ne0\), write \(q=q'+1\). The source proves

\[
X_{bq}(\omega)
\le
\operatorname{birkhoffSum}(T^b,X_b,q,\omega)
\]

without assuming \(X_0=0\). A positive block count lets the helper represent
an exact multiple using actual full blocks instead of an empty sum.

### Exact blocks uniformly in \(q\)

To include \(q=0\), the source requires exact time-zero normalization.

### In Lean: make the exact-block bound uniform

{{< lean-bridge
  human="If the zero-horizon process is exactly the zero function, then the complete-block bound is valid for every block count, including the empty count."
  math="\(X_0=0\Longrightarrow X_{bq}(\omega)\le\sum_{j=0}^{q-1}X_b(T^{bj}\omega)\)."
  lean="hX.le_birkhoffSum_blocks_of_zero hX0 b q ω"
>}}

- <code>hX0 : X 0 = 0</code> is equality of functions, not one sampled
  equality.
- At <code>q = 0</code>, it rewrites the left side to zero.
- The right side is the zero-term Birkhoff sum.
- At <code>q + 1</code>, the proof uses the private positive-count helper and
  does not need <code>hX0</code>.
- The theorem does not require <code>b ≠ 0</code>.
- The constant-five process shows why <code>hX0</code> cannot be erased from
  the uniform statement.
{{< /lean-bridge >}}

This is a good example of boundary-sensitive theorem design: expose a strong
positive-count theorem and a convenient all-count theorem with the exact extra
premise, rather than burdening every useful positive case.

## Camp six: finite integrability needs the powered map

The pointwise inequalities above do not integrate anything. The generic
integrability theorem starts from:

\[
\operatorname{Integrable}(X_b,\mu).
\]

The \(j\)-th Birkhoff summand is

\[
X_b\circ(T^b)^j.
\]

If \(T^b\) preserves \(\mu\), every iterate \((T^b)^j\) also preserves
\(\mu\), so composition transports integrability. A finite sum of integrable
functions is integrable.

### In Lean: prove one finite block sum is integrable

{{< lean-bridge
  human="If the b-step base map preserves mu, then composing the integrable b-step observable with each finite block iterate preserves integrability, and their q-term sum is integrable."
  math="\((T^b)_*\mu=\mu\Longrightarrow\operatorname{Integrable}(\sum_{j=0}^{q-1}X_b\circ(T^b)^j,\mu)\)."
  lean="hX.integrable_birkhoffSum_blocks b q hTb"
>}}

- <code>hX.integrable b</code> supplies integrability of the block observable.
- <code>hTb</code> has type
  <code>MeasurePreserving (T^[b]) μ μ</code>.
- <code>hTb.iterate j</code> proves that the \(j\)-fold block map preserves
  the same measure.
- <code>.integrable_comp_of_integrable</code> transports the block
  observable's integrability through that iterate.
- <code>integrable_finsetSum</code> closes the finite sum.
- The theorem does not ask that \(T\) itself preserve \(\mu\), only the map
  that actually appears in the sum.
- It also does not ask for probability, ergodicity, or independence.
{{< /lean-bridge >}}

### Preservation, probability, and ergodicity are different

A {{< refterm "measure-preserving-transformation" "measure-preserving map" >}}
satisfies \(F_*\mu=\mu\). It allows integrability to be pulled along its
iterates.

A probability measure additionally has total mass one. This normalization is
irrelevant to a finite sum's integrability.

Ergodicity says invariant measurable events are trivial up to null sets. It is
an asymptotic rigidity property and is also irrelevant to the finite
integrability proof.

Even if \(T\) is ergodic, \(T^b\) need not be ergodic. The source avoids that
false inference entirely: it asks only for preservation of \(T^b\), and the
cocycle specialization obtains it from preservation of \(T\).

### Finite integrability is not uniform integrability

For every fixed \(q\), the \(q\)-term block sum is integrable. This does not
give a bound uniform in \(q\), a
{{< refterm "uniform-integrability" "uniformly integrable family" >}}, or
permission to pass a limit through an integral.

## The matrix-cocycle specialization

Let \(C\) be the project's one-sided discrete complex matrix cocycle and set

\[
X_n(\omega)=
\log^+\lVert C(n,\omega)\rVert_\infty.
\]

RMT-15 already proved:

- the shifted subadditive inequality;
- \(X_0=0\), including empty matrix dimension; and
- finite-horizon integrability under the explicit one-step hypothesis
  <code>HasIntegrableGeneratorLogPlus</code>.

RMT-18 exports three cocycle declarations.

### Exact block multiples

~~~lean
C.logPlusNormObservable (b * q) ω ≤
  birkhoffSum (C.base^[b])
    (C.logPlusNormObservable b) q ω
~~~

This pointwise inequality is uniform in \(q\), including zero, because the
cocycle's log-positive observable has the checked time-zero identity. It takes
the cocycle directly and needs no integrability hypothesis.

### Remainder-first quotient bound

~~~lean
C.logPlusNormObservable n ω ≤
  C.logPlusNormObservable (n % b) ω +
    birkhoffSum (C.base^[b])
      (C.logPlusNormObservable b) (n / b)
      (C.base^[n % b] ω)
~~~

This is also pointwise and hypothesis-free beyond the cocycle bundle. It uses
the correct post-remainder starting sample.

### Integrability of the finite block sum

~~~lean
hC.integrable_blockBirkhoffSum b q
~~~

Only this third declaration takes <code>hC</code>. It converts the finite
log-positive family into the generic integrable subadditive candidate and uses

~~~lean
C.base_preserving.iterate b
~~~

to show that the powered block map preserves \(\mu\).

### Empty matrix dimension

When the finite matrix index type is empty, every log-positive norm observable
is zero. Both pointwise inequalities reduce to \(0\le0\), and the finite block
sum is the zero function. No positive-dimension premise appears.

This is a genuine boundary theorem, not evidence about growth in a nonempty
space.

## Type the eleven-step ledger with Lean and Std

The exact project module uses Mathlib's measurable spaces, integrability,
function iterates, Birkhoff sums, and cocycles. The opening finite arithmetic
can be checked without that dependency graph.

The worksheet below imports only Lean's <code>Std</code> library. It implements
the twelve-state base, the additive process, a finite block sum, both correct
orientations, the wrong shift, the constant-five time-zero boundary, and
Lean's division-by-zero convention.

This is a bounded local tutorial. It is suitable for a normal Mac or Linux
host and does not invoke Lake, Mathlib, or a project build.

Save the exact block below as
<code>/tmp/SubadditiveFiniteBlocksTutorial.lean</code>:

~~~lean
import Std

namespace SubadditiveFiniteBlocksTutorial

def period : Nat := 12

def base (state : Nat) : Nat :=
  (state + 1) % period

def iterateBase : Nat → Nat → Nat
  | 0, state => state
  | steps + 1, state => iterateBase steps (base state)

def weight (state : Nat) : Nat :=
  match state % period with
  | 0 => 2
  | 1 => 5
  | 2 => 1
  | 3 => 4
  | 4 => 3
  | 5 => 6
  | 6 => 2
  | 7 => 7
  | 8 => 1
  | 9 => 5
  | 10 => 4
  | _ => 6

/-- An additive process, hence a concrete subadditive process. -/
def process : Nat → Nat → Nat
  | 0, _ => 0
  | steps + 1, state => weight state + process steps (base state)

/-- The finite Birkhoff sum of one block observable along the powered base. -/
def blockSum (X : Nat → Nat → Nat) (blockLength : Nat) :
    Nat → Nat → Nat
  | 0, _ => 0
  | blocks + 1, state =>
      X blockLength state +
        blockSum X blockLength blocks (iterateBase blockLength state)

def horizon : Nat := 11
def blockLength : Nat := 4
def blockCount : Nat := horizon / blockLength
def remainderLength : Nat := horizon % blockLength
def start : Nat := 0

def terminalRemainderTotal : Nat :=
  blockSum process blockLength blockCount start +
    process remainderLength
      (iterateBase (blockLength * blockCount) start)

def initialRemainderTotal : Nat :=
  process remainderLength start +
    blockSum process blockLength blockCount
      (iterateBase remainderLength start)

def wrongUnshiftedRemainderTotal : Nat :=
  blockSum process blockLength blockCount start +
    process remainderLength start

def constantProcess (_steps _state : Nat) : Nat := 5

#eval (blockCount, remainderLength,
  blockLength * blockCount + remainderLength)

#eval (List.range horizon).map fun t =>
  weight (iterateBase t start)

#eval [process horizon start,
  process blockLength start,
  process blockLength (iterateBase blockLength start),
  process remainderLength
    (iterateBase (blockLength * blockCount) start)]

#eval [process remainderLength start,
  process blockLength (iterateBase remainderLength start),
  process blockLength
    (iterateBase (remainderLength + blockLength) start)]

#eval [terminalRemainderTotal,
  initialRemainderTotal,
  wrongUnshiftedRemainderTotal]

#eval [decide (process horizon start ≤ terminalRemainderTotal),
  decide (process horizon start ≤ initialRemainderTotal),
  decide (process horizon start ≤ wrongUnshiftedRemainderTotal)]

#eval (process 0 start,
  constantProcess 0 start,
  decide (constantProcess (blockLength * 0) start ≤
    blockSum constantProcess blockLength 0 start))

#eval (horizon / 0, horizon % 0,
  decide (process horizon start ≤
    blockSum process 0 (horizon / 0) start +
      process (horizon % 0)
        (iterateBase (0 * (horizon / 0)) start)))

example : blockCount = 2 := by decide
example : remainderLength = 3 := by decide
example : process horizon start = 40 := by decide
example : terminalRemainderTotal = 40 := by decide
example : initialRemainderTotal = 40 := by decide
example : ¬ process horizon start ≤ wrongUnshiftedRemainderTotal := by decide
example : process 0 start = 0 := by decide
example : ¬ constantProcess (blockLength * 0) start ≤
    blockSum constantProcess blockLength 0 start := by decide

end SubadditiveFiniteBlocksTutorial
~~~

Type this command:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean \
  /tmp/SubadditiveFiniteBlocksTutorial.lean
~~~

The exact worksheet above was executed successfully with Lean 4.32.0 while
editing this chapter. Its output was:

~~~text
(2, 3, 11)
[2, 5, 1, 4, 3, 6, 2, 7, 1, 5, 4]
[40, 12, 18, 10]
[8, 15, 17]
[40, 40, 38]
[true, true, false]
(0, 5, false)
(0, 11, true)
~~~

Read the lines in order:

1. quotient \(2\), remainder \(3\), and reconstructed horizon \(11\);
2. the eleven one-step weights;
3. total \(40\), two blocks \(12,18\), and terminal remainder \(10\);
4. initial remainder \(8\) and shifted blocks \(15,17\);
5. both correct totals \(40\) and the wrong-shift total \(38\);
6. the two true upper bounds and the false \(40\le38\) proposal;
7. the normalized additive process has \(X_0=0\), while the constant process
   has \(Y_0=5\) and fails the zero-count exact-block test; and
8. at \(b=0\), quotient zero and remainder eleven produce a true reflexive
   bound.

The silent <code>example</code> declarations ask Lean's kernel to certify the
same decisive facts.

This worksheet is a finite model, not the project theorem. It uses natural
weights, one twelve-state cyclic base, hand-written recursion, and decidable
concrete inequalities. It proves no result about arbitrary real processes,
Mathlib Birkhoff sums, measurable spaces, integrability, preservation, matrix
cocycles, or limits.

## The complete twelve-declaration map

The module exposes twelve public declarations. Three private helpers support
them but are not part of the public API.

| # | Declaration | Main input | Exact role |
|---:|---|---|---|
| 1 | <code>zero_nonneg</code> | <code>hX.add_le</code> | Proves \(0\le X_0(\omega)\) |
| 2 | <code>zero_eq_zero_iff_nonpos</code> | Declaration 1 | Characterizes \(X_0=0\) by pointwise nonpositivity |
| 3 | <code>le_birkhoffSum_blocks_add_remainder</code> | Shifted subadditivity | Blocks first with terminal remainder |
| 4 | <code>le_birkhoffSum_div_add_mod</code> | Declaration 3 and <code>Nat.div_add_mod</code> | Terminal quotient-and-remainder form |
| 5 | <code>le_birkhoffSum_blocks_of_ne_zero</code> | Shifted subadditivity and \(q\ne0\) | Exact blocks without time-zero normalization |
| 6 | <code>le_birkhoffSum_blocks_of_zero</code> | Shifted subadditivity and \(X_0=0\) | Exact blocks uniformly including \(q=0\) |
| 7 | <code>le_remainder_add_birkhoffSum_blocks</code> | Shifted subadditivity | Remainder first with shifted blocks |
| 8 | <code>le_mod_add_birkhoffSum_div</code> | Declaration 7 and <code>Nat.mod_add_div</code> | Remainder-first quotient form |
| 9 | <code>integrable_birkhoffSum_blocks</code> | Integrability of \(X_b\) and preservation of \(T^b\) | Integrability of one fixed finite block sum |
| 10 | <code>logPlusNormObservable_nat_mul_le_birkhoffSum</code> | Cocycle subadditivity and zero identity | Cocycle exact-multiple pointwise bound |
| 11 | <code>logPlusNormObservable_le_mod_add_blockBirkhoffSum</code> | Cocycle subadditivity | Cocycle remainder-first quotient pointwise bound |
| 12 | <code>HasIntegrableGeneratorLogPlus.integrable_blockBirkhoffSum</code> | <code>hC</code> and stored base preservation | Cocycle finite block-sum integrability |

The three private helpers are:

| Helper | Proof job |
|---|---|
| <code>le_birkhoffSum_blocks_add_remainder_of_add_le</code> | Inducts on \(q\) for the terminal remainder |
| <code>le_birkhoffSum_blocks_succ_of_add_le</code> | Converts the terminal helper with \(r=b\) into a positive exact-block count |
| <code>le_remainder_add_birkhoffSum_blocks_of_add_le</code> | Splits the initial remainder and applies the positive exact-block helper afterward |

### Assumption ledger

| Theorem family | Shifted subadditivity | \(X_0=0\) | Finite integrability | \(T^b\) preserves \(\mu\) | Probability | Ergodicity |
|---|:---:|:---:|:---:|:---:|:---:|:---:|
| Remainder bounds, declarations 3, 4, 7, 8 | Yes | No | Not used by proof | No | No | No |
| Positive-count exact blocks, declaration 5 | Yes | No | Not used by proof | No | No | No |
| All-count exact blocks, declaration 6 | Yes | Yes | Not used by proof | No | No | No |
| Generic finite-sum integrability, declaration 9 | Stored in receiver but unused | No | Yes | Yes | No | No |
| Cocycle pointwise bounds, declarations 10–11 | From cocycle | Cocycle zero used only by declaration 10 | No | No | No | No |
| Cocycle finite-sum integrability, declaration 12 | Packaged by <code>hC</code> | No | From <code>hC</code> | From stored base preservation | No | No |

The generic pointwise methods have a receiver that stores integrability, but
their proof bodies use only <code>add_le</code>. The page states that proof
dependency explicitly without pretending the public method has a weaker
receiver type than it does.

## Common wrong turns

### Removing the base shift

The later \(k\)-step value starts at \(T^m\omega\). The opening \(40\le38\)
failure shows that replacing it by the original sample can destroy the bound.

### Using \(T\) instead of \(T^b\) in the block sum

Successive block observations are \(b\) one-step updates apart. The correct
finite sum advances by the powered map.

### Reversing function-iterate roles

<code>(T^[b])^[q]</code> means apply the \(b\)-step map \(q\) times. It reaches
the same point as \(T^{bq}\), not \(T^{b+q}\).

### Treating two orientations as one commutative rewrite

Real addition commutes, but sample points do not move with it. Remainder first
requires shifting the block orbit by \(r\).

### Requiring \(X_0=0\) for every remainder theorem

At \(q=0\), the remainder is the entire horizon. Both remainder bounds become
reflexive without normalization.

### Deleting \(X_0=0\) from the all-count exact-block theorem

The constant-five process is a counterexample at \(q=0\).

### Saying \(n\bmod b\lt b\) at \(b=0\)

The strict remainder theorem needs \(b\gt0\). The project inequalities are
total and valid at zero without claiming strict shortness.

### Calling the remainder a uniformly bounded error

It has a shorter **time length** when \(b\gt0\). The module proves no numerical
bound uniform over samples or block scales.

### Pulling integrability through an arbitrary map

The composition step uses measure preservation of the powered map. Without a
suitable nonsingularity or preservation hypothesis, an integrable observable
can become nonintegrable after composition.

### Assuming ergodicity passes to powers

Preservation passes from \(T\) to every \(T^b\). Ergodicity need not. The
finite theorem asks only for the property it actually uses.

### Reading finite integrability as convergence

An integrable sum for every fixed finite \(q\) is not a theorem about
\(q\to\infty\), samplewise convergence, or exchange of limit and integral.

### Calling log-positive blocking a Lyapunov theorem

The cocycle observable uses \(\log^+\), which erases contraction and singular
collapse. Its finite block upper bound is not a signed growth exponent.

## Exercises from first cut to theorem design

### Trailhead

1. Recompute the eleven weights from the cyclic base.
2. Verify the blocks-first sums \(12,18,10\).
3. Verify the remainder-first sums \(8,15,17\).
4. Explain why the starting states are \(0,4,8\) in one orientation and
   \(0,3,7\) in the other.
5. Reproduce both false \(38\)-unit calculations.
6. Compute \(23/5\) and \(23\bmod5\), then sketch both temporal cuts.

### Mid-mountain

7. Expand
   <code>birkhoffSum (T^[4]) (X 4) 2 0</code> term by term.
8. Prove \((T^b)^q=T^{bq}\) on paper using function iteration.
9. Derive the blocks-first helper by induction on \(q\).
10. Derive the remainder-first helper by splitting \(r+bq\) once.
11. Show that \(X_0\ge0\) follows from subadditivity.
12. Give another subadditive process with \(X_0\gt0\).
13. Explain why positive \(q\) avoids the empty-sum obstruction.
14. Evaluate both quotient theorems at \(b=0\).

### Summit

15. Rewrite declaration 9 as an explicit finite sum and identify the
    integrability proof for each summand.
16. Give a finite example where \(T^b\) preserves a measure even if no premise
    about \(T\) was supplied to the theorem.
17. Explain why probability mass one is irrelevant to finite-sum
    integrability.
18. Find an ergodic measure-preserving map whose square is not ergodic.
19. State a uniform-integrability claim that declaration 9 does not prove.
20. Design a later theorem that averages the block inequality over phases.
    List every new horizon-counting obligation.
21. State a candidate almost-everywhere limit theorem and list the probability,
    preservation, ergodicity, and integrability assumptions separately.
22. Explain why a signed Lyapunov exponent needs information discarded by
    \(\log^+\).

## Inspect and check the exact project interfaces

{{< repo-check >}}
The authoritative source is
[<code>formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveFiniteBlocks.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveFiniteBlocks.lean).
On an approved Linux builder with the pinned dependencies already provisioned,
a learner can put the following in a temporary project scratch file:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.SubadditiveFiniteBlocks

open MeasureTheory
open NonlinearDynamics.Random.RandomCocycles

#check IsIntegrableSubadditiveProcessCandidate.zero_nonneg
#check IsIntegrableSubadditiveProcessCandidate.zero_eq_zero_iff_nonpos
#check IsIntegrableSubadditiveProcessCandidate.le_birkhoffSum_blocks_add_remainder
#check IsIntegrableSubadditiveProcessCandidate.le_birkhoffSum_div_add_mod
#check IsIntegrableSubadditiveProcessCandidate.le_birkhoffSum_blocks_of_ne_zero
#check IsIntegrableSubadditiveProcessCandidate.le_birkhoffSum_blocks_of_zero
#check IsIntegrableSubadditiveProcessCandidate.le_remainder_add_birkhoffSum_blocks
#check IsIntegrableSubadditiveProcessCandidate.le_mod_add_birkhoffSum_div
#check IsIntegrableSubadditiveProcessCandidate.integrable_birkhoffSum_blocks
#check DiscreteMatrixCocycle.logPlusNormObservable_nat_mul_le_birkhoffSum
#check DiscreteMatrixCocycle.logPlusNormObservable_le_mod_add_blockBirkhoffSum
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integrable_blockBirkhoffSum
~~~

These commands inspect existing declaration types. They do not prove a
Birkhoff theorem, Kingman's theorem, samplewise convergence, or a Lyapunov
exponent.

Immediately below this prose, the repository-check panel renders:

~~~sh
CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/Random/RandomCocycles/SubadditiveFiniteBlocks.lean
~~~

That exact Mathlib-backed check belongs on a human-approved, provisioned Linux
cloud builder. This Mac is for the small <code>Std</code> worksheet, source
authoring, Hugo, and static QA. It must not compile this project module.
{{< /repo-check >}}

The broader guarded Linux release gate is:

~~~sh
CLOUD_LEAN_BUILD=1 make check
~~~

Passing either technical gate would not complete the pending human or Pro
review.

## What is established and what remains outside

| Topic | Status in this module |
|---|---|
| \(X_0\ge0\) from shifted subadditivity | Proved pointwise |
| \(X_0=0\) characterized by nonpositivity | Proved |
| Blocks first plus terminal remainder | Proved for all natural parameters |
| Terminal quotient-and-remainder form | Proved, including reflexive \(b=0\) |
| Exact blocks with positive count | Proved without \(X_0=0\) |
| Exact blocks with arbitrary count | Proved under \(X_0=0\) |
| Remainder first plus shifted blocks | Proved without \(X_0=0\) |
| Remainder-first quotient form | Proved without \(X_0=0\) |
| Integrability of a fixed finite block sum | Proved when \(T^b\) preserves \(\mu\) |
| Cocycle exact-multiple pointwise bound | Proved without <code>hC</code> |
| Cocycle remainder-first quotient bound | Proved without <code>hC</code> |
| Cocycle finite block-sum integrability | Proved under <code>hC</code> |
| Probability normalization | Not required |
| Ergodicity or mixing | Not required or proved |
| Independence | Not required or proved |
| Positive block length | Not required for validity; required for strict remainder shortness |
| Positive matrix dimension | Not required |
| Uniform remainder magnitude | Not bounded |
| Uniform integrability over all counts | Not proved |
| Pointwise or almost-everywhere limit | Not proved |
| Birkhoff or Kingman ergodic theorem | Not invoked |
| Limit-integral interchange | Not attempted |
| Furstenberg-Kesten conclusion | Not invoked |
| Signed Lyapunov exponent or spectrum | Not defined or proved |
| Oseledets filtration or splitting | Not invoked |

The exact achievement is finite:

> A long shifted-subadditive process value can be upper-bounded by repeated
> observations at one block scale plus one correctly shifted remainder. With
> preservation of the powered map, each fixed finite block sum is integrable.

No limit appears in that statement.

## Where to continue

The {{< refterm "birkhoff-sum" "Birkhoff sum" >}} glossary entry is the compact
definition and powered-orbit reference for the finite sum used here.

[Probability Normalization and Ergodic Rigidity Before Kingman]({{< relref "/knowledge-base/deep-dives/probability-normalization-and-ergodic-rigidity-before-kingman" >}})
is the immediate predecessor. It keeps probability and ergodicity separate
from the finite process candidate.

[Integrated Log-Positive Cocycle Growth and Its Deterministic Fekete Limit]({{< relref "/knowledge-base/deep-dives/integrated-log-positive-cocycle-growth-and-fekete-limit" >}})
explains a distinct deterministic limit taken only after integrating out the
sample variable.

[Finite Blocks Before Limits: Birkhoff Bounds for Subadditive Cocycles in Lean]({{< relref "/development-notebook/2026/07/finite-block-birkhoff-bounds-for-subadditive-cocycles" >}})
is the paired Development Notebook entry.

[Orbit-Majorant Centering for Subadditive Processes]({{< relref "/knowledge-base/deep-dives/orbit-majorant-centering-for-subadditive-processes" >}})
is the immediate finite successor.

[Finite Phase Averaging for Nonpositive Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-phase-averaging-for-nonpositive-subadditive-processes" >}})
later combines residue phases into a sliding finite base-orbit sum. That
chapter must audit its own horizon and summand counts; the present module does
not contain a phase average.

## References

<a id="ref-finite-blocks-project"></a>**Nonlinear Dynamics in Lean.**
[SubadditiveFiniteBlocks.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveFiniteBlocks.lean).
This is the authoritative twelve-declaration source described here.

<a id="ref-finite-blocks-birkhoff"></a>**Mathlib contributors.**
[Birkhoff sums](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Basic.html),
Mathlib 4 documentation. The pinned source defines the finite sum and its
zero, successor, and addition identities.

<a id="ref-finite-blocks-iterate"></a>**Mathlib contributors.**
[Function iteration](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Logic/Function/Iterate.html),
Mathlib 4 documentation. This official source provides zeroth, successor,
added, and multiplied iterate identities.

<a id="ref-finite-blocks-nat-div"></a>**Lean and Mathlib contributors.**
[Natural-number division](https://leanprover-community.github.io/mathlib4_docs/Init/Data/Nat/Div/Basic.html),
Lean and Mathlib documentation. This is the upstream interface for
<code>Nat.div_add_mod</code>, <code>Nat.mod_add_div</code>, and the total
zero-divisor conventions.

<a id="ref-finite-blocks-preserving"></a>**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation. This source defines preservation and proves it is
stable under natural iteration.

<a id="ref-finite-blocks-integrable"></a>**Mathlib contributors.**
[Integrable functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Function/L1Space/Integrable.html),
Mathlib 4 documentation. This source provides composition with a
measure-preserving map and closure under finite sums.

<a id="ref-finite-blocks-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499–510, 1968.
This primary source supplies the asymptotic context. The current module proves
only finite block infrastructure.

<a id="ref-finite-blocks-steele"></a>**J. Michael Steele.**
[Kingman's subadditive ergodic theorem](https://www.numdam.org/item/AIHPB_1989__25_1_93_0/),
*Annales de l'Institut Henri Poincaré, Probabilités et Statistiques* 25(1),
93–98, 1989. This proof-lineage reference organizes a full argument through
finite interval decompositions; it is not an upstream Lean theorem used here.

<a id="ref-finite-blocks-furstenberg-kesten"></a>**Harry Furstenberg and Harry Kesten.**
[Products of Random Matrices](https://doi.org/10.1214/aoms/1177705909),
*The Annals of Mathematical Statistics* 31(2), 457–469, 1960. This primary
source motivates the random-matrix destination. No samplewise conclusion from
that work is claimed here.

The exact upstream Lean revision audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>. The
project source file audited during this rebuild had SHA-256
<code>07a4e6d99893d26e888d5799d15660cfd2b0c931bfdbabd6879f1d773ada2775</code>.
