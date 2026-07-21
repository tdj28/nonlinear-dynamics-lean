---
title: "Finite Block Decomposition for Subadditive Processes"
slug: "finite-block-decomposition-for-subadditive-processes"
date: 2026-07-21
summary: "A textbook derivation of two finite block-and-remainder bounds, their Birkhoff-sum form, the exact time-zero boundary, and the minimal assumptions needed for integrability before any Kingman theorem."
lead: "Cut a long finite horizon into equal blocks and one short remainder. Shifted subadditivity turns that arithmetic cut into a Birkhoff-sum upper bound. The result is powerful finite infrastructure, but it is not yet a convergence theorem."
draft: true
pro_reviewed: false
level: "Natural-number quotient and remainder, function iterates, finite Birkhoff sums, measure preservation, integrability, subadditive processes, and discrete matrix cocycles"
reading_time: "105 to 145 minutes"
prerequisites: "Finite sums, natural-number division, measure-preserving maps, real-valued integrability, one-sided discrete matrix cocycles, and the log-positive norm observable; no ergodic theorem is assumed"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveFiniteBlocks"
toc: true
og_image: "finite-block-decomposition-for-subadditive-processes-card.png"
og_image_alt: "Two rows split a finite horizon into full blocks and one short remainder. The upper row places the remainder last, while the lower row places it first and shifts the full blocks. A boundary label says that both are finite upper bounds and neither is a limit theorem."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The mathematical
prose, sources, Lean declaration map, figures, and accessibility have not yet
received the required human and Pro reviews. The page must remain a draft until
those gates are complete.
{{< /panel >}}

Suppose a process assigns a real number \(X_n(\omega)\) to every finite time
\(n\in\mathbb N\) and every outcome \(\omega\) in a base space \(\Omega\).
Think of \(X_n\) as a cost, a passage time, a logarithmic growth budget, or a
finite-time matrix-product observable. The defining structural inequality is
shifted subadditivity:

\[
X_{m+k}(\omega)
\le
X_k(T^m\omega)+X_m(\omega).
\]

Here \(T:\Omega\to\Omega\) advances the environment by one step. The shift is
essential. The later \(k\)-step contribution begins after the first \(m\)
steps, so it is evaluated at \(T^m\omega\), not at the original outcome.

The eighteenth random-matrix-theory milestone (RMT-18) asks a finite question.
If a horizon \(n\) is much longer than a chosen block length \(b\), can we
upper-bound \(X_n\) by repeatedly using the same block observable \(X_b\), plus
one shorter remainder? The answer is yes, in two useful orientations. The
proof needs arithmetic, iterates, and subadditivity. Integrability enters only
when we ask whether the resulting finite sum has a legitimate integral.

This distinction sets the chapter's altitude. Finite block decomposition is a
piece of machinery used inside proofs of subadditive ergodic theorems. It does
not itself establish a limit, an almost-everywhere statement, or a Lyapunov
exponent. Kingman's theorem remains ahead, not hidden in the notation.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [One horizon, two legal cuts](#one-horizon-two-legal-cuts) | See the geometry before the symbols |
| Arithmetic route | [Quotient and remainder choose the block count](#quotient-and-remainder-choose-the-block-count) | Understand the cases \(b\gt0\), \(b=0\), and \(q=0\) |
| Algebra route | [Terminal remainder: repeat one block](#terminal-remainder-repeat-one-block) | Derive the main induction |
| Boundary route | [Time zero is not automatically zero](#time-zero-is-not-automatically-zero) | Locate the one theorem family that needs normalization |
| Analysis route | [Finite integrability has one minimal dynamical gate](#finite-integrability-has-one-minimal-dynamical-gate) | Separate pointwise algebra from integration |
| Cocycle route | [The matrix-cocycle specialization](#the-matrix-cocycle-specialization) | Apply the generic bounds without adding hypotheses |
| Physics route | [Blocking as a coarse-graining analogy](#blocking-as-a-coarse-graining-analogy) | Interpret blocks without claiming a renormalization theorem |
| Lean route | [The complete twelve-declaration map](#the-complete-twelve-declaration-map) | Audit the frozen Lean interface in source order |
| Summit route | [The exact boundary before Kingman](#the-exact-boundary-before-kingman) | State what is still missing |

### Learning objectives

By the summit, a reader should be able to:

1. state shifted subadditivity with the correct base shift;
2. define a finite Birkhoff sum and expand it term by term;
3. explain why the block map is \(T^b\) and the block observable is \(X_b\);
4. derive the terminal-remainder inequality by induction on the block count;
5. turn \(n=bq+r\) into the quotient-and-remainder theorem;
6. derive the complementary remainder-first inequality;
7. explain why neither remainder orientation needs \(X_0=0\);
8. prove that subadditivity forces \(X_0\ge0\);
9. identify why a zero-count exact-block estimate needs \(X_0=0\);
10. use a constant-one process to refute an assumption-free uniform exact-block bound;
11. explain why a positive exact block count needs no time-zero normalization;
12. read Lean's total conventions \(n/0=0\) and \(n\bmod0=n\);
13. distinguish a theorem that is meaningful for positive \(b\) from one that is merely valid at \(b=0\);
14. prove finite Birkhoff-sum integrability term by term;
15. identify preservation of \(T^b\), rather than preservation of \(T\), as the generic theorem's exact dynamical premise;
16. explain why probability and ergodicity play no role in the finite bound;
17. give an ergodic map whose square is not ergodic;
18. identify the two cocycle inequalities that use the cocycle directly;
19. identify the one cocycle theorem that consumes one-step log-positive integrability;
20. preserve the empty matrix-index boundary;
21. interpret block length as a coarse observational scale without overclaiming physics;
22. distinguish log-positive expansion control from a signed growth exponent;
23. audit all twelve public declarations in source order; and
24. list the precise asymptotic statements that RMT-18 does not prove.

## The common setup

Fix a measurable space \(\Omega\), a measure \(\mu\), a map
\(T:\Omega\to\Omega\), and a family

\[
X:\mathbb N\to\Omega\to\mathbb R.
\]

The RMT-17 structure
<code>IsIntegrableSubadditiveProcessCandidate T μ X</code> stores exactly two
facts:

1. every finite-horizon function \(X_k\) is integrable with respect to
   \(\mu\); and
2. for every \(m,k,\omega\),

\[
X_{m+k}(\omega)
\le
X_k(T^m\omega)+X_m(\omega).
\]

The structure does not store probability normalization, measure preservation,
ergodicity, stationarity as a separate law, independence, or any limiting
conclusion. The adjective “candidate” records that this is finite-time input
for later theorems, not a completed ergodic theorem.

RMT-18 deliberately uses the structure in two different ways. Its pointwise
inequalities read only the <code>add_le</code> field. Its generic integrability
theorem reads the <code>integrable</code> field and separately asks for the
specific powered map in the sum to preserve \(\mu\). This field-level ledger
matters. A convenient bundled receiver can be stronger than the mathematical
core of one method, and the prose should say so.

## One horizon, two legal cuts

Choose a block length \(b\in\mathbb N\), a block count
\(q\in\mathbb N\), and a remainder length \(r\in\mathbb N\). The same total
number of steps can be written in either order:

\[
bq+r=r+bq.
\]

Subadditivity is directional in time, so these arithmetically equal
expressions generate differently shifted upper bounds.

{{< reference-figure
  src="two-finite-block-orientations.svg"
  alt="The same finite horizon has two upper-bound decompositions. One repeats full blocks from the original sample and leaves the short remainder at the end. The other takes the short remainder first and starts the full blocks from the shifted sample. Both rows stop at finite time."
  caption="**Finding:** blocks-first and remainder-first are two valid finite upper-bound routes through the same horizon. In the upper route, the short term is evaluated after all complete blocks. In the lower route, the short term stays at the original sample and every complete block begins after that initial shift. The plate shows temporal placement only. It does not assert equality, convergence, or a preferred asymptotic orientation."
>}}

The blocks-first orientation gives

\[
X_{bq+r}(\omega)
\le
\sum_{j=0}^{q-1}X_b(T^{bj}\omega)
+X_r(T^{bq}\omega).
\]

The remainder-first orientation gives

\[
X_{r+bq}(\omega)
\le
X_r(\omega)
+\sum_{j=0}^{q-1}X_b(T^{r+bj}\omega).
\]

Because real addition is commutative, the visible order of summands is not the
issue. Their sample points are. The terminal remainder sees \(T^{bq}\omega\),
while the initial remainder sees \(\omega\) and shifts the later block orbit by
\(r\) steps.

## A Birkhoff sum is the exact finite container

For a map \(F:\Omega\to\Omega\), an observable
\(g:\Omega\to\mathbb R\), a count \(q\), and an outcome \(\omega\), Mathlib's
finite Birkhoff sum is

\[
\operatorname{birkhoffSum}(F,g,q,\omega)
{} =
\sum_{j=0}^{q-1}g(F^j\omega).
\]

This definition, its zero and successor equations, and its finite-addition
law are provided by Mathlib's official
[Birkhoff-sum documentation](#ref-finite-blocks-birkhoff). In this chapter the
map is \(F=T^b\) and the observable is \(g=X_b\). Therefore

\[
\operatorname{birkhoffSum}(T^b,X_b,q,\omega)
{} =
\sum_{j=0}^{q-1}X_b((T^b)^j\omega)
{} =
\sum_{j=0}^{q-1}X_b(T^{bj}\omega).
\]

The second equality uses the algebra of function iterates documented in
Mathlib's official [iterate documentation](#ref-finite-blocks-iterate). The key idea is
that iterating the \(b\)-step map \(j\) times advances the original map by
\(bj\) steps.

This is why “block Birkhoff sum” should not be treated as a mysterious new
universal object. It is an ordinary finite Birkhoff sum with a deliberate
choice of map and observable:

- the map advances one whole block, \(T^b\);
- the observable measures one whole block, \(X_b\); and
- the count says how many complete blocks are sampled.

The compact {{< refterm "birkhoff-sum" "Birkhoff sum" >}} entry isolates this
definition and its orientation conventions.

## Terminal remainder: repeat one block

The main induction proves

\[
X_{bq+r}(\omega)
\le
\operatorname{birkhoffSum}(T^b,X_b,q,\omega)
+X_r((T^b)^q\omega).
\]

No hypothesis about \(X_0\) is present. The reason becomes visible in the base
case.

### Base case: no complete blocks

When \(q=0\), the left side is \(X_r(\omega)\). The Birkhoff sum has no terms,
and the zeroth iterate is the identity. The right side is therefore

\[
0+X_r(\omega).
\]

The theorem reduces to reflexivity. It does not ask \(X_0\le0\), because the
remainder is still \(r\), not zero.

### Successor step: peel one full block

Assume the bound is known for \(q\) complete blocks at every starting sample.
Rewrite the next horizon as

\[
b(q+1)+r=b+(bq+r).
\]

Shifted subadditivity gives

\[
X_{b+(bq+r)}(\omega)
\le
X_{bq+r}(T^b\omega)+X_b(\omega).
\]

Apply the induction hypothesis at the shifted sample \(T^b\omega\):

\[
\begin{aligned}
X_{bq+r}(T^b\omega)
&\le
\operatorname{birkhoffSum}(T^b,X_b,q,T^b\omega) \\
&\quad+X_r((T^b)^q(T^b\omega)).
\end{aligned}
\]

Mathlib's <code>birkhoffSum_succ'</code> recurrence places the new zeroth
block \(X_b(\omega)\) in front of the Birkhoff sum evaluated at \(T^b\omega\).
The iterate successor equation advances the remainder sample from \(q\) to
\(q+1\) block steps. After rearranging real addition, the right side is exactly

\[
\operatorname{birkhoffSum}(T^b,X_b,q+1,\omega)
+X_r((T^b)^{q+1}\omega).
\]

The Lean helper generalizes over \(\omega\) before induction. That choice is
not cosmetic. The successor step needs the induction hypothesis at
\(T^b\omega\), so an induction hypothesis fixed only at the original outcome
would be too weak.

### Declaration 3: the packaged terminal theorem

The public theorem is
<code>IsIntegrableSubadditiveProcessCandidate.le_birkhoffSum_blocks_add_remainder</code>.
Its receiver supplies <code>add_le</code>; the proof delegates to the private
minimal-hypothesis induction just described. Although the receiver also stores
integrability, the pointwise proof does not use it.

This theorem is finite and universal over \(b,q,r,\omega\). It assumes neither
that \(r\lt b\) nor that \(b\gt0\). Those arithmetic properties arrive only
when quotient and remainder choose \(q\) and \(r\).

## Quotient and remainder choose the block count

For a chosen \(b\) and horizon \(n\), Lean's natural-number division gives

\[
n=b(n/b)+(n\bmod b).
\]

Mathlib exposes the identity in the orientation used by the terminal theorem
as <code>Nat.div_add_mod</code>. Its official
[natural-number division documentation](#ref-finite-blocks-nat-div) also
records the total zero-divisor conventions discussed below.

Substituting

\[
q=n/b,
\qquad
r=n\bmod b
\]

into the terminal theorem gives

\[
\begin{aligned}
X_n(\omega)
&\le
\operatorname{birkhoffSum}
  (T^b,X_b,n/b,\omega) \\
&\quad+
X_{n\bmod b}((T^b)^{n/b}\omega).
\end{aligned}
\]

This is declaration 4,
<code>le_birkhoffSum_div_add_mod</code>. Its proof is a specialization plus a
single arithmetic rewrite. The theorem does not require a proof that \(b\) is
positive.

When \(b\gt0\), the additional fact

\[
n\bmod b\lt b
\]

justifies calling the last term “short.” That strict inequality is useful for
later estimates, but RMT-18 does not need it to establish the decomposition.
Furthermore, short in time does not automatically mean small in value. A
separate bound on the finite family \(X_0,\ldots,X_{b-1}\) would be needed to
turn \(r\lt b\) into a numerical remainder estimate.

### Worked horizon: seventeen steps in blocks of five

Let \(n=17\) and \(b=5\). Then \(q=3\) and \(r=2\). The terminal form is

\[
\begin{aligned}
X_{17}(\omega)
&\le X_5(\omega)+X_5(T^5\omega)+X_5(T^{10}\omega) \\
&\quad+X_2(T^{15}\omega).
\end{aligned}
\]

Every evaluation time can be checked directly. Three complete blocks cover
the intervals beginning at times zero, five, and ten. The two-step remainder
begins at time fifteen.

This exact arithmetic example is pedagogical, not empirical. The values of
the observables remain symbolic, and no measured statistic is encoded in it.

## Remainder first: shift the block orbit instead

There is a second useful split:

\[
r+bq.
\]

Applying shifted subadditivity once at \(r\) gives

\[
X_{r+bq}(\omega)
\le
X_{bq}(T^r\omega)+X_r(\omega).
\]

If \(q\gt0\), the exact block part can be bounded at the shifted sample:

\[
X_{bq}(T^r\omega)
\le
\operatorname{birkhoffSum}(T^b,X_b,q,T^r\omega).
\]

If \(q=0\), there is no need to bound \(X_0\) separately. The original target
already simplifies to \(X_r(\omega)\le X_r(\omega)\). The Lean proof therefore
splits on \(q\): reflexivity at zero, and the positive-count exact-block helper
at a successor.

The result is declaration 7,
<code>le_remainder_add_birkhoffSum_blocks</code>:

\[
X_{r+bq}(\omega)
\le
X_r(\omega)
+\operatorname{birkhoffSum}(T^b,X_b,q,T^r\omega).
\]

This theorem has no \(X_0=0\) premise. That absence is intentional and
mathematically justified by the separate zero-count proof branch.

Expanding the Birkhoff sum shows the shifted sampling times:

\[
X_{r+bq}(\omega)
\le
X_r(\omega)
+\sum_{j=0}^{q-1}X_b(T^{r+bj}\omega).
\]

For the seventeen-step example, the remainder-first form is

\[
\begin{aligned}
X_{17}(\omega)
&\le X_2(\omega)+X_5(T^2\omega)+X_5(T^7\omega) \\
&\quad+X_5(T^{12}\omega).
\end{aligned}
\]

The full blocks now begin at times two, seven, and twelve. The terminal and
initial decompositions need not have equal right sides. Subadditivity provides
upper bounds, not a path-independence theorem for those bounds.

Using <code>Nat.mod_add_div</code> yields declaration 8,
<code>le_mod_add_birkhoffSum_div</code>:

\[
\begin{aligned}
X_n(\omega)
&\le X_{n\bmod b}(\omega) \\
&\quad+
\operatorname{birkhoffSum}
  (T^b,X_b,n/b,T^{n\bmod b}\omega).
\end{aligned}
\]

Again, no time-zero normalization is needed.

## Time zero is not automatically zero

Set \(m=k=0\) in shifted subadditivity. Since the zeroth iterate is the
identity,

\[
X_0(\omega)
\le
X_0(\omega)+X_0(\omega).
\]

Subtracting \(X_0(\omega)\) gives

\[
0\le X_0(\omega).
\]

Declaration 1, <code>zero_nonneg</code>, formalizes exactly this consequence.
Subadditivity points in the opposite direction from the tempting normalization
\(X_0\le0\). It does not force \(X_0=0\).

Declaration 2, <code>zero_eq_zero_iff_nonpos</code>, combines the derived lower
bound with a supplied upper bound:

\[
X_0=0
\quad\Longleftrightarrow\quad
\forall\omega,\ X_0(\omega)\le0.
\]

The equality is an equality of functions. The right side is pointwise
nonpositivity. One direction rewrites by the zero function; the other uses
function extensionality and antisymmetry at every outcome.

### Why exact blocks expose the boundary

An exact-block estimate would read

\[
X_{bq}(\omega)
\le
\operatorname{birkhoffSum}(T^b,X_b,q,\omega).
\]

At \(q=0\), this becomes

\[
X_0(\omega)\le0.
\]

That is precisely the missing half of \(X_0=0\). RMT-18 therefore offers two
honest variants.

Declaration 5,
<code>le_birkhoffSum_blocks_of_ne_zero</code>, assumes \(q\ne0\). Natural-number
arithmetic then writes \(q=q'+1\). Instead of setting the terminal remainder to
zero, the proof uses the last complete block itself as the remainder:

\[
b(q'+1)=bq'+b.
\]

The terminal theorem with remainder \(b\) produces exactly the successor
Birkhoff sum. No statement about \(X_0\) is required.

Declaration 6, <code>le_birkhoffSum_blocks_of_zero</code>, assumes the function
equality \(X_0=0\) and covers every \(q\). The positive successor case reuses
the same helper as declaration 5. The zero case simplifies using the supplied
normalization.

### A probability-space counterexample that blocks assumption erasure

Take a one-point probability space, let \(T\) be the identity, and define

\[
X_n(\omega)=1
\]

for every \(n\). Every \(X_n\) is integrable. Shifted subadditivity holds
because

\[
1\le1+1.
\]

The base is measure preserving and ergodic. Nevertheless, the uniform exact
block estimate at \(q=0\) would say

\[
1\le0,
\]

which is false. Probability, preservation, ergodicity, and all-horizon
integrability cannot repair the missing normalization. The failure is purely
the time-zero algebra exposed by declaration 1.

This counterexample also explains why the corrected remainder-first theorem is
stronger than a proof that first normalizes \(X_0\). At \(q=0\), it reduces to
reflexivity and remains true for the constant-one process.

## The zero block length is total but degenerate

Lean defines natural-number division and remainder at zero:

\[
n/0=0,
\qquad
n\bmod0=n.
\]

Consequently, declaration 4 at \(b=0\) says

\[
X_n(\omega)
\le
0+X_n(\omega),
\]

and declaration 8 says

\[
X_n(\omega)
\le
X_n(\omega)+0.
\]

Both are correct reflexive bounds. Neither represents useful blocking. The
strict remainder fact \(n\bmod b\lt b\) is available only when \(b\gt0\).

This is a recurring formalization lesson. A total theorem can include a
boundary case that is mathematically harmless but interpretively empty. The
theorem should preserve that totality, while the exposition names the positive
premise required for the intended reading.

## Finite integrability has one minimal dynamical gate

The pointwise block inequalities do not integrate anything. They need only the
shifted algebra. Declaration 9 asks a different question: for fixed \(b\) and
\(q\), is the function

\[
\omega\longmapsto
\operatorname{birkhoffSum}(T^b,X_b,q,\omega)
\]

integrable with respect to \(\mu\)?

Expanding the definition gives a finite sum:

\[
\sum_{j=0}^{q-1}X_b((T^b)^j\omega).
\]

The candidate already says that \(X_b\) is integrable. That does not by itself
say that \(X_b\circ(T^b)^j\) is integrable. Composition can move mass into a
heavy tail. The required bridge is measure preservation of the map being
iterated:

\[
\operatorname{MeasurePreserving}(T^b,\mu,\mu).
\]

Mathlib's official
[measure-preserving documentation](#ref-finite-blocks-preserving) packages
measurability together with equality of the pushed-forward measure, and proves
that every natural iterate of a preserving map is preserving. Its official
[integrability documentation](#ref-finite-blocks-integrable) supplies the two
operations used here: integrability survives composition with a
measure-preserving map, and a finite sum of integrable functions is
integrable.

For each \(j\) in the finite range, the proof proceeds as follows:

1. \(X_b\) is integrable by <code>hX.integrable b</code>.
2. \(T^b\) preserves \(\mu\) by the explicit premise <code>hTb</code>.
3. Therefore \((T^b)^j\) preserves \(\mu\) by
   <code>hTb.iterate j</code>.
4. Hence \(X_b\circ(T^b)^j\) is integrable by
   <code>integrable_comp_of_integrable</code>.
5. The finite sum is integrable by <code>integrable_finsetSum</code>.

That is declaration 9,
<code>IsIntegrableSubadditiveProcessCandidate.integrable_birkhoffSum_blocks</code>.
Its exact premise is preservation of \(T^b\), not preservation of \(T\).

### Why the theorem asks only about the powered map

If \(T\) preserves \(\mu\), then \(T^b\) preserves \(\mu\), so the common
application is immediate. But the generic finite sum never samples \(T\) one
step at a time. It samples the powered map. Asking directly for preservation
of \(T^b\) is therefore the weaker and more accurate signature.

This choice also clarifies the \(b=0\) boundary. The powered map \(T^0\) is the
identity, which preserves every measure. The Birkhoff sum then repeats \(X_0\)
finitely many times. Its integrability follows from integrability of \(X_0\),
even though block length zero has no useful coarse-graining interpretation.

Neither probability normalization nor ergodicity appears in declaration 9.
A raw measure is enough. A finite sum is enough. No limit theorem is hiding in
the proof.

### Why some dynamical control is necessary

Consider \(\Omega=\mathbb N\) with the probability weights

\[
\mu(\{n\})=2^{-(n+1)}.
\]

Let

\[
g(n)=2^{n/2}
\qquad\text{and}\qquad
T(n)=2n.
\]

Then

\[
\int g\,d\mu
{} =
\frac12\sum_{n=0}^{\infty}2^{-n/2}
\lt\infty.
\]

But \(g(T(n))=2^n\), so

\[
\int g\circ T\,d\mu
{} =
\frac12\sum_{n=0}^{\infty}1
{} =
\infty.
\]

The map \(T\) is not measure preserving. The example shows why integrability
of an observable cannot be transported through an arbitrary measurable map.
It is a prose counterexample to a false implication, not a declaration claimed
to be formalized by RMT-18.

## Measure preservation does not make every power ergodic

Finite integrability needs preservation of \(T^b\). A later asymptotic block
argument might be tempted to ask for ergodicity of the same power. Those are
different properties, and ergodicity of \(T\) does not generally imply
ergodicity of \(T^b\). Lalley's lecture notes on Kingman's theorem call out
this exact power-map obstruction in the fixed-block method
([Lalley, accessed 2026](#ref-finite-blocks-lalley)).

The smallest counterexample has two points. Let

\[
\Omega=\{0,1\}
\]

with uniform probability, and let \(T\) swap the two points. The only strictly
\(T\)-invariant subsets are the empty set and the full set, so \(T\) is
ergodic. Yet

\[
T^2=\operatorname{id}.
\]

Every subset is invariant under the identity. In particular, the singleton
\(\{0\}\) is \(T^2\)-invariant and has probability \(1/2\), so \(T^2\) is not
ergodic.

The finite RMT-18 theorem is unaffected. The identity still preserves the
uniform measure, so every finite block Birkhoff sum is integrable when its
observable is. What fails is an automatic ergodic conclusion for averages
under the powered map. That distinction is one reason this chapter stops
before any pointwise convergence claim.

## An additive process shows when every bound is equality

Let \(f:\Omega\to\mathbb R\), and define

\[
X_n(\omega)
{} =
\sum_{j=0}^{n-1}f(T^j\omega).
\]

This is the ordinary Birkhoff-sum process generated by \(f\). Splitting a
finite sum at time \(m\) gives the exact cocycle identity

\[
X_{m+k}(\omega)
{} =
X_k(T^m\omega)+X_m(\omega).
\]

Thus shifted subadditivity holds with equality. Both block decompositions are
then exact regroupings of the same finite sum. The terminal orientation groups
the summands into \(q\) complete blocks followed by \(r\) terms. The
remainder-first orientation groups the first \(r\) terms and then the same
number of complete blocks from a shifted origin.

This example gives a useful mental model for the general proof. A subadditive
process behaves like an additive process with possible savings whenever two
pieces are combined. Repeated splitting gives an upper bound because each
combination can lose information in the favorable direction.

## The matrix-cocycle specialization

Now let \(C\) be a one-sided discrete matrix cocycle over \(\mu\), with finite
matrix index type \(\iota\). Its base map is \(C.\mathrm{base}\), and its
finite-time log-positive norm observable is

\[
P_n(\omega)
{} =
\log^+\lVert C(n,\omega)\rVert_\infty.
\]

The earlier cocycle modules prove two facts needed for the pointwise RMT-18
specializations:

\[
P_0=0
\]

in every finite dimension, including the empty index type, and

\[
P_{m+k}(\omega)
\le
P_k(C.\mathrm{base}^m\omega)+P_m(\omega).
\]

No integrability hypothesis is needed to state either fact. Consequently, the
two public cocycle inequalities in RMT-18 take \(C\) directly.

### Declaration 10: exact multiples for the cocycle

<code>DiscreteMatrixCocycle.logPlusNormObservable_nat_mul_le_birkhoffSum</code>
states

\[
P_{bq}(\omega)
\le
\operatorname{birkhoffSum}
  (C.\mathrm{base}^b,P_b,q,\omega).
\]

Unlike the generic uniform exact-block declaration, this theorem does not ask
the caller for a separate \(P_0=0\) proof. The cocycle's checked time-zero
identity already supplies it. The proof splits on \(q\): simplification at
zero and the positive-block helper at a successor.

The theorem takes no
<code>HasIntegrableGeneratorLogPlus</code> witness. Adding that premise would
hide the fact that this is pointwise matrix algebra followed by a real
log-positive inequality.

### Declaration 11: quotient and initial remainder for the cocycle

<code>DiscreteMatrixCocycle.logPlusNormObservable_le_mod_add_blockBirkhoffSum</code>
states

\[
\begin{aligned}
P_n(\omega)
&\le P_{n\bmod b}(\omega) \\
&\quad+
\operatorname{birkhoffSum}
  (C.\mathrm{base}^b,P_b,n/b,
    C.\mathrm{base}^{n\bmod b}\omega).
\end{aligned}
\]

This theorem also takes \(C\) directly. It invokes the private
minimal-hypothesis remainder-first helper with the cocycle's subadditivity
theorem, then rewrites by quotient and remainder. It neither constructs nor
uses the RMT-17 integrable candidate.

### Declaration 12: finite block-sum integrability

The final theorem,
<code>HasIntegrableGeneratorLogPlus.integrable_blockBirkhoffSum</code>, does
need
<code>hC : C.HasIntegrableGeneratorLogPlus</code>. That hypothesis proves all
finite observables \(P_b\) integrable and packages them as the RMT-17
candidate. The cocycle already stores preservation of its one-step base map,
so

\[
C.\mathrm{base}^b
\]

is measure preserving by iteration. Declaration 9 then gives integrability of
the finite block Birkhoff sum.

This dependency split is the main interface lesson:

| Cocycle conclusion | Receiver or premise | Why |
|---|---|---|
| Exact-multiple pointwise upper bound | \(C\) only | Time-zero identity and subadditivity are already checked |
| Remainder-first quotient pointwise upper bound | \(C\) only | Shifted subadditivity and arithmetic suffice |
| Finite block-sum integrability | \(hC\) | The block observable needs an integrability witness |

Probability and ergodicity occur in none of these rows.

### The empty matrix dimension stays valid

When \(\iota\) is empty, the earlier module proves

\[
P_n(\omega)=0
\]

for every \(n\) and \(\omega\). Each RMT-18 cocycle inequality becomes
\(0\le0\), and the finite Birkhoff sum is the zero function. Integrability is
automatic once the existing one-step hypothesis is supplied to the wrapper.

There is no mathematical reason to add <code>Nonempty ι</code> to these
theorems. Positive dimension matters for some norm identities elsewhere, but
the log-positive interface has already discharged time zero and the empty
boundary uniformly.

## Two one-dimensional cocycles calibrate the observable

Take a one-dimensional constant cocycle, so the generator is the scalar
matrix \(A=[a]\) at every outcome. Then

\[
C(n)=A^n
\]

and the selected operator norm is ordinary absolute value.

### Uniform expansion

For \(a=2\),

\[
P_n=\log^+|2^n|=n\log2.
\]

At \(n=17\) and \(b=5\), the terminal decomposition reads

\[
17\log2
{} =
5\log2+5\log2+5\log2+2\log2.
\]

Both block inequalities are equalities because constant scalar multiplication
produces an additive logarithmic process.

### Uniform contraction

For \(a=1/2\),

\[
P_n=\log^+|2^{-n}|=0
\]

for every \(n\). Again every RMT-18 inequality is an equality, but it is now
the equality \(0=0\). The underlying matrices contract exponentially, yet the
log-positive observable records no negative growth.

This is not a defect in the finite-block proof. It is the designed meaning of
the envelope. The observable budgets expansion and guarantees a nonnegative
integrable majorant. It is not a signed logarithmic exponent.

## Blocking as a coarse-graining analogy

In statistical physics and dynamical systems, one often changes observational
scale. Instead of resolving every microscopic step, one groups \(b\) steps
into a single coarse step. RMT-18 has exactly that geometry:

- \(T\) is the microscopic one-step evolution;
- \(T^b\) is the coarse block evolution;
- \(X_b\) is the cost or growth assigned to one coarse block;
- \(q\) is the number of complete coarse steps; and
- \(r\) is a boundary layer that does not fill a complete block.

For transfer-matrix products, \(X_b\) can be read as a finite expansion budget
for a block of \(b\) local transfer matrices. Subadditivity says that measuring
the combined product cannot exceed the sum of the separately measured blocks
after the correct environment shift. The remainder records the unmatched
microscopic segment at one boundary.

This analogy is useful, but its limits are part of the lesson. RMT-18 does not
define a renormalization transformation on models, locate a fixed point,
derive scaling dimensions, take a thermodynamic limit, or prove universality.
Changing from \(T\) to \(T^b\) is a finite regrouping of time. Calling it
“coarse-graining” describes the bookkeeping scale, not a renormalization-group
theorem.

There are also two boundary conventions. Terminal remainder is natural when
one scans from the initial sample in equal blocks and leaves the unmatched
tail. Remainder first is useful when later estimates prefer the short term at
the original sample, leaving a uniform block orbit after a fixed initial
shift. Neither convention is physically privileged by RMT-18.

## The complete twelve-declaration map

The following table follows the Lean source exactly. Private helpers are proof
architecture, not additional public declarations.

| Number | Public declaration | Exact contribution | Assumptions actually used by the conclusion |
|---:|---|---|---|
| 1 | <code>IsIntegrableSubadditiveProcessCandidate.zero_nonneg</code> | Proves \(0\le X_0(\omega)\) | Shifted subadditivity |
| 2 | <code>IsIntegrableSubadditiveProcessCandidate.zero_eq_zero_iff_nonpos</code> | Characterizes \(X_0=0\) by pointwise nonpositivity | Declaration 1 plus function extensionality and order antisymmetry |
| 3 | <code>IsIntegrableSubadditiveProcessCandidate.le_birkhoffSum_blocks_add_remainder</code> | Blocks first, terminal remainder | Shifted subadditivity; no integrability or normalization |
| 4 | <code>IsIntegrableSubadditiveProcessCandidate.le_birkhoffSum_div_add_mod</code> | Terminal form with \(q=n/b\) and \(r=n\bmod b\) | Declaration 3 plus natural-number arithmetic |
| 5 | <code>IsIntegrableSubadditiveProcessCandidate.le_birkhoffSum_blocks_of_ne_zero</code> | Exact blocks when \(q\ne0\) | Shifted subadditivity and positive block count |
| 6 | <code>IsIntegrableSubadditiveProcessCandidate.le_birkhoffSum_blocks_of_zero</code> | Exact blocks for every \(q\) | Shifted subadditivity plus \(X_0=0\) |
| 7 | <code>IsIntegrableSubadditiveProcessCandidate.le_remainder_add_birkhoffSum_blocks</code> | Remainder first, then shifted blocks | Shifted subadditivity; no \(X_0=0\) premise |
| 8 | <code>IsIntegrableSubadditiveProcessCandidate.le_mod_add_birkhoffSum_div</code> | Remainder-first quotient form | Declaration 7 plus natural-number arithmetic |
| 9 | <code>IsIntegrableSubadditiveProcessCandidate.integrable_birkhoffSum_blocks</code> | Integrability of a fixed finite block sum | Integrability of \(X_b\) and preservation of \(T^b\) |
| 10 | <code>DiscreteMatrixCocycle.logPlusNormObservable_nat_mul_le_birkhoffSum</code> | Cocycle exact-multiple pointwise bound | \(C\) directly: cocycle log-positive subadditivity and time-zero identity |
| 11 | <code>DiscreteMatrixCocycle.logPlusNormObservable_le_mod_add_blockBirkhoffSum</code> | Cocycle remainder-first quotient pointwise bound | \(C\) directly: cocycle log-positive subadditivity |
| 12 | <code>HasIntegrableGeneratorLogPlus.integrable_blockBirkhoffSum</code> | Integrability of the cocycle block sum | \(hC\), the candidate constructor, and the cocycle's stored base preservation |

### The three private helpers

The module keeps three reusable proof engines private:

1. a terminal block-plus-remainder induction from a raw shifted-subadditivity
   hypothesis;
2. a positive-count exact-block consequence obtained by using one full block
   as the terminal remainder; and
3. a remainder-first consequence that treats the zero block count separately.

This organization makes the public methods convenient while keeping the
logical core weaker than the candidate bundle. It also lets the two cocycle
pointwise wrappers call the raw algebra directly, without manufacturing an
integrability witness they do not need.

## Assumption ledger by theorem family

| Ingredient | Zero boundary | Pointwise block bounds | Finite-sum integrability | Cocycle pointwise bounds | Cocycle integrability |
|---|---:|---:|---:|---:|---:|
| Shifted subadditivity | Yes | Yes | No | Supplied by \(C\) | Indirectly through candidate |
| All-horizon integrability | No | No | Only \(X_b\) is used | No | Derived from \(hC\) |
| \(X_0=0\) | Only for uniform exact blocks | No for remainder forms | No | Already proved for \(C\) | No additional premise |
| Preservation of \(T^b\) | No | No | Yes | No | Derived from base preservation |
| Probability | No | No | No | No | No |
| Ergodicity | No | No | No | No | No |
| Positive block length | No | No | No | No | No |
| Nonempty matrix index | Not applicable | Not applicable | Not applicable | No | No |

The table exposes two useful opportunities for future interface refinement without
claiming they are required now. First, the generic pointwise methods live on a
structure that stores more than their proofs consume. Second, generic finite
sum integrability uses only \(X_b\), even though the candidate supplies every
horizon. A later abstraction may separate these ingredients if another module
needs the weaker interfaces repeatedly. RMT-18 does not create a parallel
hierarchy solely to optimize one file.

## Common wrong turns

### Removing the shift from subadditivity

The later block starts at \(T^m\omega\). Replacing it pointwise by the original
sample changes the theorem. Measure preservation can identify integrals of a
function and its shift under suitable hypotheses, but it does not make the
pointwise values equal.

### Using \(T\) inside the block Birkhoff sum

One summand represents \(b\) original steps, so consecutive summands begin
\(b\) steps apart. The correct map is \(T^b\), not \(T\). Using \(T\) would
sample overlapping or misaligned block observables.

### Reversing the powered iterate

The \(j\)-th block term is \(X_b((T^b)^j\omega)\), corresponding to original
time \(bj\). The iterate algebra should be checked against Mathlib rather than
reconstructed from memory.

### Choosing the wrong Birkhoff successor recurrence

The induction peels the first full block and applies its hypothesis at the
shifted sample. The recurrence <code>birkhoffSum_succ'</code> matches that
orientation. A recurrence that appends the final term can also be useful, but
it does not line up as directly with this proof state.

### Demanding \(X_0=0\) for a remainder theorem

Both remainder orientations are reflexive at \(q=0\). The only exposed
zero-time obstruction is the exact-block target with no remainder. Adding a
normalization premise to declarations 3, 4, 7, or 8 would weaken the interface
without mathematical need.

### Erasing \(X_0=0\) from uniform exact blocks

The one-point constant-one process refutes that change. A positive exact block
count is enough; a zero count is not.

### Assuming \(r\lt b\) without \(b\gt0\)

Lean's quotient and remainder are total at zero. The decomposition remains
true, but the strict remainder theorem needs positive divisor evidence.

### Treating a short remainder as a bounded error

The inequality \(r\lt b\) bounds time, not the value \(X_r(\omega)\). Uniform
control of the finite remainder family is a separate analytic task.

### Transporting integrability through an arbitrary map

Composition can destroy integrability. Declaration 9 names preservation of
the exact block map that performs the transport.

### Assuming ergodicity passes to every power

The two-point flip is ergodic and has a nonergodic square. Preservation passes
to natural iterates; ergodicity need not.

### Reading finite integrability as uniform integrability

Declaration 9 concerns one fixed finite sum for each \(b,q\). It gives no
family-wide tail control, often called uniform integrability, no uniform
estimate over \(q\), no tightness, and no license to exchange a limit with an
integral.

### Calling log-positive growth a Lyapunov exponent

The observable clips negative logarithms to zero. The contracting scalar
example shows that it cannot encode a negative exponent.

### Reading an upper decomposition as equality

Equality holds for additive examples, not for a general subadditive process.
The proof may lose slack at every split.

## The exact boundary before Kingman

Kingman's 1968 theorem concerns asymptotic behavior of subadditive stochastic
processes under additional measure-theoretic hypotheses
([Kingman, 1968](#ref-finite-blocks-kingman)). Fixed finite blocks are one
ingredient in proofs, not the theorem's conclusion. Lalley's notes display the
block method and the power-map subtlety; Steele's short proof uses finite
interval decompositions in a broader proof of the theorem
([Steele, 1989](#ref-finite-blocks-steele)).

RMT-18 proves the following finite infrastructure:

- exact pointwise upper bounds for every finite block count;
- two quotient-and-remainder orientations;
- the precise time-zero normalization boundary;
- integrability of each fixed finite block Birkhoff sum under preservation of
  the powered block map; and
- pointwise and integrable specializations for the log-positive cocycle
  process.

It does not provide a measure-theoretic pointwise Birkhoff theorem for the
powered maps. The pinned Mathlib checkout contains finite Birkhoff-sum algebra
and some elementary or topological average results, but no measure-theoretic
pointwise theorem matching the use needed here. It also contains no ready-made
Kingman theorem.

### What a later asymptotic layer must still justify

A future formal theorem must state and discharge its own exact hypotheses. At
minimum, its design must account for the measurable and integrable process,
the correct stationarity relation, meaning that the relevant process laws are
unchanged by time shifts, or the corresponding measure-preserving formulation,
the shifted subadditive law, the measure's finiteness or probability
normalization as required by the selected statement, and the handling of
negative parts or lower bounds required by that formulation. If an ergodic
conclusion is desired, ergodicity must enter at the appropriate stage rather
than being inferred for every powered map.

After proving existence of a samplewise normalized limit, further work would
still be needed to show that the limit is invariant, to make it constant under
ergodicity, or to identify its integral with the deterministic Fekete rate.
Limit-integral interchange is not a free consequence of pointwise convergence.

For matrix products, the historical asymptotic destination includes the work
of Furstenberg and Kesten
([Furstenberg and Kesten, 1960](#ref-finite-blocks-furstenberg-kesten)). That
reference motivates the product-growth program. It is not evidence that the
finite RMT-18 declarations already prove their theorem.

### Exact nonclaims

RMT-18 proves none of the following:

1. almost-everywhere or everywhere convergence of \(X_n/n\);
2. convergence in probability, distribution, or mean absolute error
   (\(L^1\));
3. uniform integrability of normalized processes;
4. a measure-theoretic pointwise Birkhoff theorem;
5. a maximal ergodic inequality;
6. Kingman's subadditive ergodic theorem;
7. existence, measurability, or invariance of a limit observable;
8. almost-everywhere constancy of such a limit;
9. equality between a samplewise limit and the integrated Fekete rate;
10. exchange of a limit with an integral;
11. a lower block bound;
12. a uniform numerical remainder estimate from \(r\lt b\) alone;
13. probability normalization, independence, identical distribution, mixing,
    or invertibility;
14. ergodicity of \(T^b\) from ergodicity of \(T\);
15. a Lyapunov exponent or the Furstenberg-Kesten theorem;
16. an Oseledets invariant splitting;
17. signed-log or negative-tail control;
18. a positive matrix-dimension requirement;
19. meaningful coarse-graining at \(b=0\); or
20. a renormalization-group or thermodynamic-limit theorem.

## Exercises from first cut to theorem design

### Base camp: arithmetic and definitions

1. Expand
   \(\operatorname{birkhoffSum}(T^b,X_b,3,\omega)\) into three terms and list
   their original \(T\)-times.
2. Set \(m=k=0\) in shifted subadditivity and derive \(X_0\ge0\).
3. Prove that pointwise \(X_0\le0\) implies the function equality \(X_0=0\).
4. Simplify the terminal-remainder theorem at \(q=0\).
5. Simplify the remainder-first theorem at \(q=0\).
6. Explain why those two simplifications do not need \(X_0=0\).
7. For \(n=17\) and \(b=5\), compute \(n/b\) and \(n\bmod b\).
8. Write every evaluation time in the terminal orientation for that example.
9. Write every evaluation time in the remainder-first orientation.
10. Evaluate both quotient forms at \(b=0\) using Lean's total conventions.

### Mid-mountain: proof architecture

11. In the terminal induction, explain why the induction hypothesis must be
    generalized over \(\omega\).
12. Derive the successor step on paper and identify where
    <code>birkhoffSum_succ'</code> enters.
13. Prove the positive-count exact-block inequality by writing \(q=q'+1\) and
    using a final full block as the remainder.
14. Use the constant-one process to disprove the same statement at \(q=0\).
15. Decide which of declarations 3 through 8 use the candidate's integrability
    field.
16. Show that an additive Birkhoff-sum process makes both finite bounds
    equalities.
17. Give an example where subadditivity is strict at one split and explain how
    the slack propagates into a block upper bound.
18. Prove that if \(T^b\) preserves \(\mu\), then every \((T^b)^j\) preserves
    \(\mu\).
19. Trace the integrability proof for \(q=3\), naming the theorem used on each
    summand and on the final sum.
20. Verify the discrete heavy-tail example showing that arbitrary composition
    can destroy integrability.

### High camp: dynamics and cocycles

21. Enumerate the invariant subsets of the two-point flip and prove it is
    ergodic.
22. Show that its square is the identity and identify a nontrivial invariant
    event for the square.
23. Explain why this counterexample does not threaten declaration 9.
24. For the one-dimensional generator \(A=[2]\), compute \(P_n\) and verify the
    \(17=3\cdot5+2\) decomposition as equality.
25. Repeat for \(A=[1/2]\), then explain which dynamical information the
    log-positive observable erased.
26. Prove that every cocycle theorem in this module remains valid for an empty
    matrix index.
27. Identify exactly why declaration 10 can cover \(q=0\) without an explicit
    normalization argument from the caller.
28. Identify exactly why declaration 11 does not need
    <code>HasIntegrableGeneratorLogPlus</code>.
29. Identify the two places where declaration 12 gets its hypotheses: one from
    \(hC\), one from the cocycle bundle.

### Summit: design the next layer

30. Audit the twelve-declaration table against the Lean source and mark every
    candidate field that each proof actually reads.
31. Propose a weaker standalone signature for declaration 3 using only a raw
    shifted-subadditivity hypothesis. Compare its usability with the method
    interface without creating a second hierarchy.
32. State an additional assumption that would turn \(r\lt b\) into a uniform
    numerical bound on the remainder term for fixed \(b\).
33. Explain why finite integrability for every \(q\) is not uniform
    integrability as \(q\to\infty\).
34. List the exact ingredients still missing before a measure-theoretic
    Kingman theorem can be applied.
35. Explain why a pointwise Birkhoff theorem for \(T^b\) cannot simply inherit
    ergodicity from \(T\).
36. Design a theorem route that first obtains a possibly nonconstant invariant
    limit and only later invokes ergodicity.
37. State one condition that could justify exchanging a limit and an integral,
    without claiming RMT-18 proves it.
38. Explain why a log-positive limit, even if proved, would not automatically
    be a signed top Lyapunov exponent.
39. Separate the finite blocking analogy from an actual renormalization-group
    construction.
40. Write a one-paragraph referee report rejecting any claim that declaration
    9 is already Kingman's theorem.

## Reproduce the checked slice

From the repository root, load the pinned Lean toolchain and compile the leaf
module with warnings treated as errors:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/SubadditiveFiniteBlocks.lean
~~~

Build the named module and its dependency graph:

~~~sh
lake build NonlinearDynamics.Random.RandomCocycles.SubadditiveFiniteBlocks
~~~

Return to the repository root and validate the teaching surface:

~~~sh
cd ..
make site-check
~~~

The repository-wide gate is <code>make check</code>. Automated success does not
publish this page. Human mathematical, source, accessibility, and editorial
reviews remain separate publication gates.

## What is established and what is not

| Topic | RMT-18 status |
|---|---|
| \(X_0\ge0\) from shifted subadditivity | Proved pointwise |
| \(X_0=0\) characterized by pointwise nonpositivity | Proved |
| Blocks first plus terminal remainder | Proved for all natural parameters |
| Terminal quotient-and-remainder form | Proved, including the reflexive \(b=0\) boundary |
| Exact blocks with positive count | Proved without \(X_0=0\) |
| Exact blocks with arbitrary count | Proved under \(X_0=0\) |
| Remainder first plus shifted complete blocks | Proved without \(X_0=0\) |
| Remainder-first quotient form | Proved without \(X_0=0\) |
| Integrability of each fixed block Birkhoff sum | Proved when \(T^b\) preserves \(\mu\) |
| Cocycle exact-multiple pointwise bound | Proved from \(C\) directly |
| Cocycle remainder-first quotient bound | Proved from \(C\) directly |
| Cocycle finite block-sum integrability | Proved under \(hC\) |
| Probability or ergodicity premise | Not required anywhere in the module |
| Positive block length premise | Not required for validity; required for a strict short-remainder interpretation |
| Positive matrix dimension | Not required |
| Uniform remainder bound | Not proved |
| Pointwise or almost-everywhere normalized limit | Not proved |
| Measure-theoretic Birkhoff or Kingman theorem | Not invoked or proved |
| Limit-integral identification | Not proved |
| Lyapunov exponent or invariant splitting | Not defined or proved |

The milestone's achievement is exact finite control with a transparent
assumption ledger. It converts a long process value into repeated observations
of one block scale, while preserving every boundary case Lean can express.
That is the right foundation for later asymptotic work precisely because it
does not pretend to contain that later work.

## Where to continue

The {{< refterm "birkhoff-sum" "Birkhoff sum" >}} glossary entry is the compact
definition, powered-orbit picture, and boundary-case reference for the central
finite sum used here.

[Probability Normalization and Ergodic Rigidity Before Kingman]({{< relref "/knowledge-base/deep-dives/probability-normalization-and-ergodic-rigidity-before-kingman" >}})
is the immediate predecessor. It separates probability, ergodicity, and
finite-horizon integrability before any samplewise theorem.

[Integrated Log-Positive Cocycle Growth and Its Deterministic Fekete Limit]({{< relref "/knowledge-base/deep-dives/integrated-log-positive-cocycle-growth-and-fekete-limit" >}})
explains the distinct deterministic limit obtained only after integrating out
the sample variable.

[Finite-Horizon Log-Positive Cocycle Integrability]({{< relref "/knowledge-base/deep-dives/finite-horizon-log-positive-cocycle-integrability" >}})
constructs the one-step hypothesis used only by declaration 12's integrability
wrapper.

[Generator-Presented One-Sided Discrete Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/generator-presented-one-sided-discrete-matrix-cocycles" >}})
establishes the base-map and cocycle orientation consumed by the block proof.

[Finite Blocks Before Limits: Birkhoff Bounds for Subadditive Cocycles in Lean]({{< relref "/development-notebook/2026/07/finite-block-birkhoff-bounds-for-subadditive-cocycles" >}})
is the proof-to-prose Research Note paired directly with the RMT-18 Lean
module.

Related compact entries include the
{{< refterm "ergodic-probability-base" "ergodic probability base" >}}, the
{{< refterm "log-positive-integrability-envelope" "log-positive integrability envelope" >}}, the
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycle" >}}, the
{{< refterm "integrated-log-positive-growth-rate" "integrated log-positive growth rate" >}}, and the
{{< refterm "forward-matrix-product" "forward matrix product" >}}.

The next asymptotic milestone must formalize a precise measure-theoretic theorem
before introducing a samplewise exponent. Finite block notation is a route to
that work, not authorization to skip it.

## References

All web links below were checked on 2026-07-21. The pinned local checkout is
the authority for the exact Lean interface used by the project.

<a id="ref-finite-blocks-birkhoff"></a>**Mathlib contributors.**
[Birkhoff sums](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Basic.html),
Mathlib 4 documentation. This official page defines the finite sum and records
its zero, successor, and addition identities. The exact pinned implementation
is [lines 31 through 57 at commit 81a5d257](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Basic.lean#L31-L57).

<a id="ref-finite-blocks-iterate"></a>**Mathlib contributors.**
[Function iteration](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Logic/Function/Iterate.html),
Mathlib 4 documentation. This official page records zeroth, successor, added,
and multiplied iterate identities used to move between the powered block map
and original time. The exact pinned definitions and identities appear in
[lines 54 through 87](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Logic/Function/Iterate.lean#L54-L87).

<a id="ref-finite-blocks-nat-div"></a>**Lean and Mathlib contributors.**
[Natural-number division](https://leanprover-community.github.io/mathlib4_docs/Init/Data/Nat/Div/Basic.html),
Lean and Mathlib documentation. This official page documents
<code>Nat.div_add_mod</code>, <code>Nat.mod_add_div</code>, and the total
zero-divisor conventions used by declarations 4 and 8.

<a id="ref-finite-blocks-preserving"></a>**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation. This official page defines the preservation package
and proves preservation under natural iteration. See the pinned
[definition](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/MeasurePreserving.lean#L43-L48)
and [iterate theorem](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/MeasurePreserving.lean#L193-L196).

<a id="ref-finite-blocks-integrable"></a>**Mathlib contributors.**
[Integrable functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Function/L1Space/Integrable.html),
Mathlib 4 documentation. This official page provides preservation of
integrability under composition with a measure-preserving map and closure
under finite sums. See the pinned
[composition result](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/L1Space/Integrable.lean#L381-L390)
and [finite-sum result](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/L1Space/Integrable.lean#L439-L449).

<a id="ref-finite-blocks-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source is the asymptotic theorem context. RMT-18 proves only the
finite block infrastructure that may precede such an argument.

<a id="ref-finite-blocks-lalley"></a>**Steven P. Lalley.**
[Kingman's Subadditive Ergodic Theorem](https://galton.uchicago.edu/~lalley/Courses/Graz/Kingman.pdf),
University of Chicago lecture notes, undated, accessed 2026-07-21. These notes
present the fixed-block inequality and explicitly warn that a power of an
ergodic transformation need not be ergodic. They are a teaching reference,
not the primary source for Kingman's theorem.

<a id="ref-finite-blocks-steele"></a>**J. Michael Steele.**
[Kingman's subadditive ergodic theorem](https://www.numdam.org/item/AIHPB_1989__25_1_93_0/),
*Annales de l'Institut Henri Poincaré, Probabilités et Statistiques* 25(1),
93-98, 1989. This reference gives a full proof organized through finite
interval decompositions. It supplies proof-lineage context, not an upstream
Lean theorem used in RMT-18.

<a id="ref-finite-blocks-furstenberg-kesten"></a>**Harry Furstenberg and Harry Kesten.**
[Products of Random Matrices](https://doi.org/10.1214/aoms/1177705909),
*The Annals of Mathematical Statistics* 31(2), 457-469, 1960. This primary
source motivates the random-matrix-product destination. No Furstenberg-Kesten
samplewise conclusion is claimed in this chapter.

The exact upstream Lean revision audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
