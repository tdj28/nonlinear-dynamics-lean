---
title: "Birkhoff sum"
slug: "birkhoff-sum"
summary: "A Birkhoff sum adds one observable along a finite orbit; in finite-block arguments, the orbit map is a power of the base map and the observable is one complete block cost."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveFiniteBlocks"
og_image: "birkhoff-sum-card.png"
og_image_alt: "Warm-paper teaching card showing a base orbit sampled at fixed block intervals, those sampled block costs collected into one finite Birkhoff sum, and a warning that a finite sum is not a convergence theorem."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page must remain a draft until that review is complete.
{{< /panel >}}

A **Birkhoff sum** adds the values of one observable along the first finitely
many points of an orbit. It is a finite algebraic object. It becomes relevant
to ergodic theory because normalized Birkhoff sums are the quantities studied
by pointwise and mean ergodic theorems, but the definition itself contains no
limit, probability, measure preservation, integrability, or ergodicity. This
separation is explicit in Mathlib's official definition and documentation
([Mathlib Birkhoff sums](#ref-birkhoff-mathlib-basic)).

For the finite-block estimates in the eighteenth random-matrix-theory
milestone (RMT-18), the orbit map is not usually the one-step base map \(T\).
It is the powered map \(T^{b}\), where \(b\) is a chosen block length. The
observable is the complete-block cost \(X_b\). A Birkhoff sum then visits the
start of each complete block and adds the cost of a block beginning there.

{{< reference-figure
  src="powered-orbit-sampling.svg"
  alt="A seventeen-step horizon is decomposed into a two-step remainder followed by three five-step blocks. The powered base map advances from one block start to the next, and the block observable is sampled at orbit times two, seven, and twelve."
  caption="**Finding:** the remainder-first decomposition of a seventeen-step horizon with five-step blocks leaves a two-step remainder and three complete blocks. After paying the remainder at the original sample, the finite Birkhoff sum samples the five-step block cost at orbit times two, seven, and twelve. The plate explains finite indexing only. It does not assert convergence, independence, or ergodicity of the powered map."
>}}

## The exact finite definition

Let \(\Omega\) be a state space, let \(S:\Omega\to\Omega\) be a map, let
\(F:\Omega\to\mathbb R\) be an observable, let \(q\in\mathbb N\), and let
\(\omega\in\Omega\). The length-\(q\) Birkhoff sum is

\[
\operatorname{BSum}(S,F,q,\omega)
{} =
\sum_{\substack{j\in\mathbb N\\j\lt q}} F\bigl(S^j\omega\bigr).
\]

Mathlib writes this as
<code>birkhoffSum S F q ω</code> and implements the finite index set as
<code>Finset.range q</code>. Thus the first index is zero and the last index,
when \(q\) is positive, is \(q-1\). At \(q=0\), the range is empty and the
sum is zero. These are definitional finite-sum facts, not measure-theoretic
claims ([pinned Mathlib source](#ref-birkhoff-mathlib-pinned)).

The four inputs have distinct jobs:

| Input | Meaning in a general Birkhoff sum | RMT-18 block interpretation |
|---|---|---|
| \(S\) | orbit map | powered base map \(T^b\) |
| \(F\) | value sampled on the orbit | block observable \(X_b\) |
| \(q\) | number of samples | number of complete blocks |
| \(\omega\) | initial state | sample where the block train starts |

Confusing any two columns changes the theorem. In particular,
<code>birkhoffSum T (X b) q ω</code> samples the block cost after every one-step
move. RMT-18 needs <code>birkhoffSum (T^[b]) (X b) q ω</code>, which samples it
after every \(b\)-step move.

## Powered-base sampling

Fix a block length \(b\) and set \(S=T^b\). Iterating the powered map \(j\)
times advances \(bj\) one-step times:

\[
S^j\omega
{} =
\bigl(T^b\bigr)^j\omega
{} =
T^{bj}\omega.
\]

When \(q\) is positive, the block Birkhoff sum expands as

\[
\begin{aligned}
\operatorname{BSum}(T^b,X_b,q,\omega)
&= \sum_{\substack{j\in\mathbb N\\j\lt q}}
      X_b\bigl(T^{bj}\omega\bigr) \\
&= X_b(\omega)+X_b(T^b\omega)+\cdots
   +X_b\bigl(T^{b(q-1)}\omega\bigr).
\end{aligned}
\]

This sum has \(q\) terms, not \(bq\) terms. Each term already summarizes a
horizon of length \(b\). The powered map supplies the spacing between block
starts.

This is the first useful mental model: a Birkhoff sum is an **orbit sampler**.
The map determines where to sample, the observable determines what to read,
and the horizon determines how many readings to add.

## The recurrence laws expose both ends

Mathlib supplies two successor recurrences for the same finite sum
([official recurrence documentation](#ref-birkhoff-mathlib-basic)):

\[
\begin{aligned}
\operatorname{BSum}(S,F,q+1,\omega)
&= \operatorname{BSum}(S,F,q,\omega)+F(S^q\omega), \\
\operatorname{BSum}(S,F,q+1,\omega)
&= F(\omega)+\operatorname{BSum}(S,F,q,S\omega).
\end{aligned}
\]

The first equation appends the last sampled value. The second peels off the
first sampled value and shifts the initial point. Neither orientation is more
true. Each matches a different induction.

The addition law splits a longer sum after \(m\) samples:

\[
\operatorname{BSum}(S,F,m+n,\omega)
{} =
\operatorname{BSum}(S,F,m,\omega)
{} + \operatorname{BSum}(S,F,n,S^m\omega).
\]

RMT-18 uses the successor laws to align repeated subadditivity with the
powered orbit. The library identities prevent an informal index shift from
quietly changing a block start.

## From shifted subadditivity to complete blocks

Let \(X_n(\omega)\) be a real cost for a horizon of length \(n\). The RMT-17
process candidate stores the pointwise inequality

\[
X_{m+k}(\omega)
\le
X_k(T^m\omega)+X_m(\omega).
\]

It also stores integrability of each \(X_n\), but that analytic field is not
used in the pointwise block bounds. Repeatedly apply the inequality with
complete blocks of length \(b\). The complete-block terms line up at the
powered-orbit points

\[
\omega,\ T^b\omega,\ T^{2b}\omega,\ldots .
\]

Their sum is exactly a Birkhoff sum of the observable \(X_b\) under the map
\(T^b\). The Birkhoff vocabulary is useful because it packages the otherwise
error-prone finite index bookkeeping into a standard object.

## Terminal-remainder orientation

Write a horizon as \(bq+r\): first \(q\) complete blocks, then a remainder of
length \(r\). RMT-18 proves

\[
X_{bq+r}(\omega)
\le
\operatorname{BSum}(T^b,X_b,q,\omega)
{} + X_r\bigl((T^b)^q\omega\bigr).
\]

The complete blocks begin at one-step orbit times
\(0,b,2b,\ldots,(q-1)b\). The terminal remainder begins at time \(bq\).
No assumption about \(X_0\) is needed. When \(q=0\), the Birkhoff sum is empty
and the statement reduces to \(X_r(\omega)\le X_r(\omega)\).

Substituting Euclidean division gives a theorem for every natural horizon:

\[
\begin{aligned}
X_n(\omega)
\le{}&
\operatorname{BSum}\left(T^b,X_b,\left\lfloor\frac nb\right\rfloor,\omega\right) \\
&+X_{n\bmod b}\left((T^b)^{\lfloor n/b\rfloor}\omega\right).
\end{aligned}
\]

For positive \(b\), the remainder satisfies \(n\bmod b\lt b\). That strict
remainder bound needs \(0\lt b\); the inequality itself does not.

## Remainder-first orientation

The same horizon can be written as \(r+bq\): first the short remainder, then
the complete blocks. RMT-18 proves the complementary estimate

\[
X_{r+bq}(\omega)
\le
X_r(\omega)
{} + \operatorname{BSum}(T^b,X_b,q,T^r\omega).
\]

Now the remainder stays at the original sample. The block train begins after
that remainder, so its sampled block starts occur at one-step orbit times
\(r,r+b,r+2b,\ldots,r+(q-1)b\). This theorem also needs no assumption about
\(X_0\). At \(q=0\), it reduces to the same reflexive inequality as the
terminal-remainder form.

The quotient-and-remainder version is

\[
\begin{aligned}
X_n(\omega)
\le{}& X_{n\bmod b}(\omega) \\
&+\operatorname{BSum}\left(
T^b,X_b,\left\lfloor\frac nb\right\rfloor,
T^{n\bmod b}\omega\right).
\end{aligned}
\]

This orientation is often convenient when the remainder cost has a separate
finite-horizon bound at the original sample. The terminal orientation is often
convenient when an induction naturally appends the short tail. RMT-18 records
both instead of forcing every later proof to reverse the decomposition by
hand.

## Worked example: seventeen steps in blocks of five

Take \(n=17\) and \(b=5\). Natural-number division gives

\[
17=5\cdot3+2,
\qquad
17/5=3,
\qquad
17\bmod5=2.
\]

The terminal-remainder form reads

\[
\begin{aligned}
X_{17}(\omega)
\le{}& X_5(\omega)+X_5(T^5\omega)+X_5(T^{10}\omega) \\
&+X_2(T^{15}\omega).
\end{aligned}
\]

There are three complete five-step blocks beginning at times zero, five, and
ten. The two-step remainder begins at time fifteen.

The remainder-first form reads

\[
\begin{aligned}
X_{17}(\omega)
\le{}& X_2(\omega)+X_5(T^2\omega)+X_5(T^7\omega) \\
&+X_5(T^{12}\omega).
\end{aligned}
\]

Here the two-step remainder comes first. The three complete blocks then begin
at times two, seven, and twelve. Both right sides cover a seventeen-step
horizon, but they evaluate the cost functions at different orbit points. One
must not replace one by the other without the corresponding subadditive
argument.

## The zero-count boundary is exact

Shifted subadditivity at \(m=k=0\) yields

\[
X_0(\omega)
\le
X_0(\omega)+X_0(\omega),
\]

so \(X_0(\omega)\ge0\). It does not force \(X_0=0\). A constant-one process,
for example, satisfies the shifted subadditive inequality and has \(X_0=1\).

For a positive number of exact blocks, RMT-18 proves

\[
X_{bq}(\omega)
\le
\operatorname{BSum}(T^b,X_b,q,\omega)
\qquad(q\ne0)
\]

without a time-zero normalization. The induction has at least one block to
pay for.

A theorem quantified uniformly over **all** block counts includes \(q=0\).
At that boundary it asks for

\[
X_0(\omega)\le0.
\]

Combined with the forced nonnegativity, this is equivalent to \(X_0=0\).
That is the only reason the uniform exact-block theorem assumes exact
time-zero vanishing.

The distinction is easy to lose, so it is worth keeping as a table:

| Finite statement | Needs \(X_0=0\)? | What happens at zero blocks? |
|---|---:|---|
| complete blocks plus terminal remainder | no | reflexive remainder bound |
| remainder plus complete blocks | no | reflexive remainder bound |
| exact blocks with \(q\ne0\) | no | zero count excluded |
| exact blocks for every \(q\) | yes | requires \(X_0\le0\) |

The remainder-first estimate does **not** need \(X_0=0\). Adding that
assumption there would hide the actual strength of the finite algebra.

## Block length zero is defined, but degenerate

Natural-number division in Lean is total. At \(b=0\), one has \(n/0=0\) and
\(n\bmod0=n\). Each quotient-and-remainder block estimate therefore becomes a
reflexive bound:

\[
X_n(\omega)
\le
0+X_n(\omega)
\]

or the same two terms in the opposite order. The theorem remains valid, but
there are no complete positive-length blocks to interpret. A later argument
that needs the useful fact \(n\bmod b\lt b\) must add \(0\lt b\) explicitly.

Total definitions are valuable in Lean because they avoid artificial partial
functions. They do not absolve the prose from explaining when a boundary case
has become tautological.

## Pointwise algebra does not need integrability

The two block inequalities compare real numbers at a fixed sample
\(\omega\). Their proofs use shifted subadditivity, natural-number arithmetic,
iterate identities, and finite-sum recurrences. They do not integrate
anything. Consequently they need neither:

- <code>Integrable (X b) μ</code>;
- measure preservation;
- probability normalization; nor
- ergodicity.

The cocycle specializations preserve this narrow assumption boundary.
<code>logPlusNormObservable_nat_mul_le_birkhoffSum</code> and
<code>logPlusNormObservable_le_mod_add_blockBirkhoffSum</code> use the
log-positive norm process's checked subadditivity. The exact-block theorem uses
the checked time-zero identity only to include the zero block count; the
remainder-first theorem needs no such normalization. Neither theorem consumes
the one-step integrability hypothesis. Both remain valid when the finite
matrix index type is empty.

## Finite-sum integrability needs only the block map

Integrability enters when the project wants the finite Birkhoff sum itself to
be integrable. Suppose every \(X_n\) is integrable and the powered map
\(S=T^b\) preserves \(\mu\). Each summand

\[
\omega\longmapsto X_b(S^j\omega)
\]

is integrable because \(S^j\) preserves the measure. A finite sum of
integrable real functions is integrable. This is exactly the architecture of
<code>integrable_birkhoffSum_blocks</code>: it uses Mathlib's preservation of
iterates and its transport of integrability through a measure-preserving map
([measure-preserving iterates](#ref-birkhoff-mathlib-preserving),
[integrability transport](#ref-birkhoff-mathlib-integrable)).

The minimal hypothesis is

~~~lean
hTb : MeasurePreserving (T^[b]) μ μ
~~~

It is stronger than measurability and weaker than assuming a whole
probability-ergodic system. The theorem does not require that \(T\) itself
preserve \(\mu\), provided the particular block map \(T^b\) does. In the matrix
cocycle specialization, the cocycle already stores preservation of \(T\), so
Mathlib's <code>MeasurePreserving.iterate</code> supplies preservation of
\(T^b\).

This analytic conclusion is still finite-time. It certifies one finite sum as
an \(L^1\) function, meaning that its absolute value has finite integral. It
does not state that normalized sums converge.

## The two-cycle trap: an ergodic map can have a nonergodic power

Let \(\Omega=\{0,1\}\) with equal probabilities and let \(T\) exchange the two
points. The map \(T\) is ergodic: the only strictly invariant subsets are
empty and full. But \(T^2\) is the identity. Every subset is invariant under
the identity, so \(T^2\) is not ergodic.

This example blocks a common shortcut. From <code>Ergodic T μ</code>, one
cannot generally infer <code>Ergodic (T^[b]) μ</code>. Lalley's proof notes for
Kingman's theorem call out exactly this powered-map difficulty when explaining
why a naive blockwise application of Birkhoff's theorem is insufficient
([Lalley, Kingman notes](#ref-birkhoff-lalley)).

RMT-18 never needs the invalid shortcut. Its pointwise bounds need no
ergodicity. Its finite-sum integrability theorem needs only measure
preservation of the powered map, and preservation *does* pass to iterates.
Ergodicity and measure preservation must not be conflated.

## A finite Birkhoff sum is not a Birkhoff theorem

The word **Birkhoff** names both a finite orbit-sum construction and famous
asymptotic theorems. Importing the construction does not import their
conclusions. RMT-18 proves no statement about

\[
\lim_{q\to\infty}
\frac1q\operatorname{BSum}(T^b,X_b,q,\omega).
\]

It also proves no limit for \(X_n(\omega)/n\). Kingman's subadditive ergodic
theorem is designed to turn a measure-preserving integrable subadditive
process into an almost-sure normalized limit, meaning a limit outside a set
of probability zero, under additional hypotheses
([Kingman, 1968](#ref-birkhoff-kingman)). Lalley's short proof notes show how
finite block estimates participate in that much longer argument, including
the need to handle the nonergodicity of powers rather than assume it away
([Lalley](#ref-birkhoff-lalley)).

Accordingly, the RMT-18 Birkhoff-sum layer establishes none of the following:

- pointwise or almost-everywhere convergence of normalized process values;
- a Birkhoff pointwise ergodic theorem;
- Kingman's subadditive ergodic theorem;
- equality of a samplewise limit with an integrated Fekete rate;
- convergence in \(L^1\), probability, or distribution;
- independence, mixing, or decay of correlations;
- a Lyapunov exponent or Oseledets splitting; or
- ergodicity of every powered base map.

The honest role of this layer is narrower and indispensable: it freezes the
finite indexing and assumption boundaries that any later asymptotic proof must
use correctly.

## Lean landmarks

After importing the RMT-18 module, these commands expose the upstream finite
sum and the project-level block interfaces:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.SubadditiveFiniteBlocks

open NonlinearDynamics.Random.RandomCocycles

#check birkhoffSum
#check birkhoffSum_succ
#check birkhoffSum_succ'
#check IsIntegrableSubadditiveProcessCandidate.le_birkhoffSum_div_add_mod
#check IsIntegrableSubadditiveProcessCandidate.le_mod_add_birkhoffSum_div
#check IsIntegrableSubadditiveProcessCandidate.integrable_birkhoffSum_blocks
~~~

Read the long theorem names literally. <code>div_add_mod</code> signals the
terminal-remainder form. <code>mod_add</code> signals the remainder-first form.
<code>integrable</code> appears only in the theorem that actually makes an
analytic claim.

## Where to continue

[Finite Blocks Before Limits: Birkhoff Bounds for Subadditive Cocycles in Lean]({{< relref "/development-notebook/2026/07/finite-block-birkhoff-bounds-for-subadditive-cocycles" >}})
maps every RMT-18 declaration to its checked Lean proof and reproducible build
commands.

[Finite-Block Decomposition for Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-block-decomposition-for-subadditive-processes" >}})
develops the two inductions, powered-orbit identities, edge cases, and cocycle
specializations as a full textbook chapter.

The
{{< refterm "ergodic-probability-base" "ergodic probability base" >}}
entry separates probability, ergodicity, and integrability before any block
argument. The
{{< refterm "integrated-log-positive-growth-rate" "integrated log-positive growth rate" >}}
entry explains the deterministic Fekete limit of the already integrated
sequence. Neither entry turns the present finite sum into a samplewise limit.

## References

<a id="ref-birkhoff-mathlib-basic"></a>**Mathlib contributors.**
[Birkhoff sums](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Basic.html),
Mathlib 4 documentation. This official page defines <code>birkhoffSum</code>
as a finite orbit sum and records the zero, one, successor, and addition laws.

<a id="ref-birkhoff-mathlib-pinned"></a>**Mathlib contributors.**
[<code>Mathlib.Dynamics.BirkhoffSum.Basic</code> at v4.32.0](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/BirkhoffSum/Basic.lean),
pinned source used by this project. The implementation is the sum over
<code>Finset.range</code>, so the empty and successor behavior is auditable at
the exact toolchain version.

<a id="ref-birkhoff-mathlib-preserving"></a>**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation, together with the
[v4.32.0 source](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/Ergodic/MeasurePreserving.lean#L193-L196).
These official sources define measure preservation and prove that every
natural iterate of a measure-preserving self-map is measure preserving.

<a id="ref-birkhoff-mathlib-integrable"></a>**Mathlib contributors.**
[Integrability transport at v4.32.0](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/MeasureTheory/Function/L1Space/Integrable.lean#L387-L391),
pinned Mathlib source. The theorem
<code>MeasurePreserving.integrable_comp_of_integrable</code> transports an
integrable observable through a measure-preserving map.

<a id="ref-birkhoff-lalley"></a>**Steven P. Lalley.**
[Kingman's Subadditive Ergodic Theorem](https://galton.uchicago.edu/~lalley/Courses/Graz/Kingman.pdf),
lecture notes, 3 pages, accessed 2026-07-21. The notes state an ergodic form of
Kingman's theorem and explicitly explain the obstruction that \(T^m\) need not
be ergodic even when \(T\) is.

<a id="ref-birkhoff-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source develops the asymptotic subadditive ergodic theory that
the finite RMT-18 layer does not claim to formalize.

The exact upstream Mathlib revision audited for this entry is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the v4.32.0 revision pinned by <code>formalization/lake-manifest.json</code>.
