---
title: "Koopman operator"
slug: "koopman-operator"
summary: "A Koopman operator follows a state forward and then reads an observable there, turning possibly nonlinear state dynamics into linear composition on functions."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.KoopmanL2Mean"
og_image: "koopman-operator-card.png"
og_image_alt: "A uniform three-state cycle pulls observable values two, minus one, and four to minus one, four, and two while preserving squared L2 norm seven. A collapse to the last state instead produces four, four, four and squared norm sixteen."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note. Human review
of the mathematics, Lean interpretation, examples, sources, figures, and
accessibility remains pending. Publication does not change that review state.
{{< /panel >}}

Start with three states and a clockwise update:

\[
\Omega=\{a,b,c\},
\qquad
T(a)=b,
\quad T(b)=c,
\quad T(c)=a.
\]

An **observable** is a function that assigns a readable number to each state.
Choose

\[
f(a)=2,
\qquad f(b)=-1,
\qquad f(c)=4.
\]

The Koopman operator does not move these three numbers directly. It asks, at
each starting state, “where will the state go next, and what number does
\(f\) read there?” Its defining rule is

\[
(U_Tf)(\omega)=f(T\omega).
\]

Calculate all three values:

\[
\begin{aligned}
(U_Tf)(a)&=f(b)=-1,\\
(U_Tf)(b)&=f(c)=4,\\
(U_Tf)(c)&=f(a)=2.
\end{aligned}
\]

In the fixed order \((a,b,c)\), this is

\[
\boxed{f=(2,-1,4)\quad\longmapsto\quad U_Tf=(-1,4,2)}.
\]

The states move forward, while the table of values is **pulled back** to the
starting states.

## Pull back twice

Apply the same rule to the new observable:

\[
\begin{aligned}
(U_T^2f)(a)&=(U_Tf)(b)=4,\\
(U_T^2f)(b)&=(U_Tf)(c)=2,\\
(U_T^2f)(c)&=(U_Tf)(a)=-1.
\end{aligned}
\]

Therefore

\[
\boxed{U_T^2f=(4,2,-1)}.
\]

Following the state twice and then reading \(f\) is the same operation:

\[
U_T^2f=f\circ T^2.
\]

More generally, for every natural number \(n\),

\[
U_T^nf=f\circ T^n.
\]

Because this example is a three-cycle, \(T^3\) is the identity and
\(U_T^3f=f\).

## Check the square-integrable norm

Give each state probability \(1/3\). This uniform
{{< refterm "probability-measure" "probability measure" >}} makes the
cycle measure preserving: every state has exactly one predecessor, so the
cycle only permutes three equal masses.

For a real observable \(g\), its squared \(L^2\) norm is the uniform average
of its squared readings:

\[
\lVert g\rVert_2^2
=\frac13\left(g(a)^2+g(b)^2+g(c)^2\right).
\]

For the original observable,

\[
\lVert f\rVert_2^2
=\frac13\left(2^2+(-1)^2+4^2\right)
=\frac{21}{3}
=7.
\]

The pulled-back values are a permutation of the same three readings, so

\[
\lVert U_Tf\rVert_2^2
=\frac13\left((-1)^2+4^2+2^2\right)
=\frac{21}{3}
=7.
\]

The second pullback has the same result:

\[
\lVert U_T^2f\rVert_2^2
=\frac13\left(4^2+2^2+(-1)^2\right)
=7.
\]

Thus this finite calculation exhibits the isometry law

\[
\boxed{\lVert U_Tf\rVert_2=\lVert f\rVert_2}.
\]

An **isometry** preserves distance from zero, equivalently the norm. It need
not be onto.

{{< reference-figure
  wide="true"
  src="state-motion-observable-pullback.svg"
  alt="On a uniform three-state cycle, observable values two, minus one, and four pull back once to minus one, four, and two and twice to four, two, and minus one. Every row has squared L2 norm seven. A comparison map sends all three states to c, has preimage counts zero, zero, three instead of one, one, one, and pulls the same observable back to four, four, four with squared norm sixteen."
  caption="**One example, one failed hypothesis:** the cycle merely permutes three equal masses, so each singleton has one predecessor and the pulled-back observable keeps squared \(L^2\) norm \(7\). The collapse sends every state to \(c\), so the preimage counts become \((0,0,3)\), not \((1,1,1)\). It repeats the reading \(4\) three times and changes the squared norm from \(7\) to \(16\). The diagram is exact finite arithmetic, not empirical data. Labels, arrow styles, and patterns repeat every color distinction."
>}}

## Near-miss: composition without measure preservation

Keep the same state space, uniform probability, and observable, but replace
the cycle by the collapse map

\[
C(a)=C(b)=C(c)=c.
\]

This map is measurable on the finite space, but it does not preserve the
uniform measure. For the one-point {{< refterm "event" "event" >}}
\(A=\{c\}\),

\[
C^{-1}(A)=\Omega,
\qquad
\mu(C^{-1}(A))=1
\ne
\frac13=\mu(A).
\]

Pointwise composition still makes sense:

\[
U_Cf=(f(c),f(c),f(c))=(4,4,4).
\]

But the norm calculation is now

\[
\lVert U_Cf\rVert_2^2
=\frac13(4^2+4^2+4^2)
=16
\ne
7
=\lVert f\rVert_2^2.
\]

Nothing has gone wrong with the definition \(U_Cf=f\circ C\). The isometry
conclusion failed because its measure-preservation hypothesis failed. In the
project, one cannot construct <code>koopmanL2 hC</code> for this uniform
collapse without supplying the impossible certificate
<code>hC : MeasurePreserving C μ μ</code>.

## General definition

Let \(\Omega\) be a set of states equipped with a
{{< refterm "measurable-space" "measurable space" >}} \(\Sigma\) and a
{{< refterm "measure" "measure" >}} \(\mu\). Let
\(T:\Omega\to\Omega\) be a
{{< refterm "measurable-function" "measurable function" >}}. For an
observable \(f:\Omega\to\mathbb R\), define the pointwise composition
operator by

\[
U_Tf=f\circ T,
\qquad
(U_Tf)(\omega)=f(T\omega).
\]

The project fixes this **forward-composition convention**. Some sources for
invertible dynamics use composition with \(T^{-1}\). That is a different
operator, so the two conventions cannot be exchanged silently.

The name **pullback** describes the arrow reversal:

- the state arrow sends \(\omega\) forward to \(T\omega\); and
- the observable \(f\), which reads values at destination states, becomes the
  new observable \(f\circ T\) on starting states.

Evaluation closes the two descriptions into one equality:

\[
(U_Tf)(\omega)=f(T\omega).
\]

## Why the operator is linear

The state update \(T\) may be nonlinear. Linearity is instead a statement
about the input observable. For real numbers \(\alpha,\beta\) and observables
\(f,g\),

\[
\begin{aligned}
U_T(\alpha f+\beta g)(\omega)
&=(\alpha f+\beta g)(T\omega)\\
&=\alpha f(T\omega)+\beta g(T\omega)\\
&=\alpha U_Tf(\omega)+\beta U_Tg(\omega).
\end{aligned}
\]

Therefore

\[
U_T(\alpha f+\beta g)=\alpha U_Tf+\beta U_Tg.
\]

For example, even when a state variable obeys the nonlinear update
\(T(x)=x^2\), the rule \(U_Tf(x)=f(x^2)\) is linear in \(f\). This algebraic
fact alone says nothing about whether a chosen measure is preserved.

## From functions to real \(L^2\)

A real \(L^2(\mu)\) vector is not literally one function. It is an
{{< refterm "almost-everywhere" "almost-everywhere" >}} equivalence class of
measurable functions for which \(|f|^2\) is
{{< refterm "integrability" "integrable" >}}. Two representatives describe
the same vector when they differ only on a
{{< refterm "null-set" "null set" >}}.

Suppose \(T\) is a
{{< refterm "measure-preserving-transformation" "measure-preserving transformation" >}}:

\[
\mu(T^{-1}(A))=\mu(A)
\]

for every measurable event \(A\). Measure preservation does two jobs:

1. it transports null sets through preimages, so \([f\circ T]\) does not
   depend on the chosen representative \(f\); and
2. it gives the change-of-variables identity needed for the norm calculation.

The resulting operator on equivalence classes is

\[
U_T[f]=[f\circ T].
\]

Its exact norm identity is

\[
\begin{aligned}
\lVert U_T[f]\rVert_2^2
&=\int_\Omega |f(T\omega)|^2\,d\mu(\omega)\\
&=\int_\Omega |f(\omega)|^2\,d\mu(\omega)\\
&=\lVert[f]\rVert_2^2.
\end{aligned}
\]

No finite-total-mass, probability, ergodicity, injectivity, surjectivity, or
invertibility premise is needed for this real \(L^2\) composition isometry.
The three-state example uses a probability so that every integral reduces to
a finite weighted sum.

## Isometry does not mean unitary equivalence

The project exposes the Koopman map as a continuous linear map and proves the
assumption-safe operator-norm bound

\[
\lVert U_T\rVert\leq1.
\]

It does not claim unconditional equality with one. Under the zero measure,
real \(L^2\) is the trivial space and the operator norm is zero, even though
every vector-level norm identity remains true.

Nor does an isometry have to be surjective. On one-sided fair coin sequences,
let \(T\) discard the first bit. This shift preserves product probability.
Every function in the range of \(U_T\) depends only on the tail, so the
first-bit observable is not in the range, even modulo null sets. Thus
measure-preserving composition can be isometric without being a unitary
equivalence.

## Why physicists and dynamicists use it

The state trajectory may follow a nonlinear law, but measurements still live
in a vector space: observables can be added and scaled. Koopman composition
uses that linear structure without assuming that the original state update is
linear. Iteration produces

\[
f,\ U_Tf,\ U_T^2f,\ldots,
\]

which records how one measurement changes as the state advances. Spectral and
Hilbert-space tools can then study invariant observables and time averages.
This viewpoint transfers observables into linear operator language. It does
not turn the original nonlinear system into a finite-dimensional linear one,
nor does it supply a tractable spectral computation.

## Fixed observables and mean convergence

The fixed subspace is

\[
K=\operatorname{Fix}(U_T)
=\{f\in L^2(\mu):U_Tf=f\}.
\]

Equality here is equality in \(L^2\), hence equality almost everywhere, not
necessarily pointwise equality for every chosen representative.

Let \(P_K\) denote orthogonal projection onto \(K\). The project specializes
Mathlib's mean-ergodic theorem to prove

\[
\frac1n\sum_{j=0}^{n-1}U_T^jf
\longrightarrow P_Kf
\qquad\text{in }L^2.
\]

For the three-cycle, one complete operator average is

\[
\frac{f+U_Tf+U_T^2f}{3}
=\left(\frac53,\frac53,\frac53\right).
\]

It is constant and therefore fixed. In this particular one-cycle model, the
fixed vectors are precisely the constant functions. The general project
theorem does not identify every fixed subspace with constants. That requires
an additional ergodicity argument.

Norm convergence also does not by itself prove full-sequence pointwise
convergence. The project first obtains an almost-everywhere convergent
subsequence and develops a dense pointwise-good core using
{{< refterm "koopman-coboundary" "Koopman coboundaries" >}}. Later modules add
maximal control to reach the pointwise Birkhoff theorem.

## In Lean: apply the composition operator

{{< lean-bridge
  human="For a square-integrable observable f, applying the project Koopman operator means composing f with the measure-preserving state update T."
  math="\(U_T[f]=[f\circ T].\)"
  lean="koopmanL2 hT f = Lp.compMeasurePreserving T hT f"
>}}

- <code>hT : MeasurePreserving T μ μ</code> is the proof that the same measure
  is preserved by the state update.
- <code>f : Lp ℝ 2 μ</code> is a real square-integrable equivalence class.
- <code>koopmanL2 hT</code> is the project's continuous linear self-map on
  real \(L^2(\mu)\).
- <code>Lp.compMeasurePreserving T hT f</code> is Mathlib's bundled
  measure-preserving composition.
- The exact project theorem <code>koopmanL2_apply hT f</code> proves the
  displayed equality by definition.
{{< /lean-bridge >}}

The source definition deliberately begins with a **linear isometry** and then
drops only the extra packaging needed to expose a continuous linear map:

~~~lean
def koopmanL2 (hT : MeasurePreserving T μ μ) :
    Lp ℝ 2 μ →L[ℝ] Lp ℝ 2 μ :=
  (Lp.compMeasurePreservingₗᵢ ℝ T hT).toContinuousLinearMap
~~~

The arrow <code>→L[ℝ]</code> means a continuous real-linear map. The object
<code>compMeasurePreservingₗᵢ</code> before conversion has the stronger
linear-isometry type.

## In Lean: preserve the \(L^2\) norm

{{< lean-bridge
  human="Composing with a measure-preserving map leaves the norm of every L2 vector unchanged."
  math="\(\lVert U_Tf\rVert_2=\lVert f\rVert_2.\)"
  lean="Lp.norm_compMeasurePreserving f hT"
>}}

- <code>Lp</code> is Mathlib's space of almost-everywhere equivalence classes
  with finite \(p\)-norm.
- <code>norm_compMeasurePreserving</code> is an exact Mathlib theorem, not a
  numerical approximation.
- The argument order is the vector <code>f</code> followed by the preservation
  proof <code>hT</code>.
- Its conclusion is
  <code>‖Lp.compMeasurePreserving T hT f‖ = ‖f‖</code>.
- Combining it with <code>koopmanL2_apply</code> gives the paper isometry law
  for the project operator.
{{< /lean-bridge >}}

The operator-level statement is intentionally weaker:

{{< lean-bridge
  human="As a continuous linear operator, Koopman composition amplifies no L2 vector by a factor greater than one."
  math="\(\lVert U_T\rVert\leq1.\)"
  lean="norm_koopmanL2_le hT"
>}}

- The norm around <code>koopmanL2 hT</code> is the operator norm.
- <code>≤ 1</code> is valid even on the zero-measure boundary.
- This statement does not assert that the operator norm equals one.
- It also does not assert surjectivity or construct an inverse.
{{< /lean-bridge >}}

## In Lean: iterate state motion and observable pullback together

{{< lean-bridge
  human="Pulling an observable back n times is the same as composing it once with the n-step state update."
  math="\(U_T^nf=f\circ T^n.\)"
  lean="iterate_koopmanL2_apply hT n f"
>}}

- <code>(koopmanL2 hT)^[n]</code> is the \(n\)-fold iterate of the operator.
- <code>T^[n]</code> is the \(n\)-fold iterate of the state map.
- <code>hT.iterate n</code> proves that the \(n\)-step map still preserves
  <code>μ</code>.
- The theorem's right side is
  <code>Lp.compMeasurePreserving (T^[n]) (hT.iterate n) f</code>.
- At <code>n = 0</code>, both iterates are identities.
{{< /lean-bridge >}}

## Standalone tutorial

**Standalone tutorial.** This complete file reproduces the
three-state cycle, both pullbacks, the uniform squared-norm numerators, and the
non-preserving collapse. It imports <code>Std</code>, not Mathlib or this
project.

Save it as <code>KoopmanFiniteScratch.lean</code>:

~~~lean
import Std

namespace KoopmanFiniteScratch

inductive State where
  | a | b | c
deriving Repr, DecidableEq

def points : List State := [.a, .b, .c]

def cycle : State → State
  | .a => .b
  | .b => .c
  | .c => .a

def collapse : State → State := fun _ => .c

def observable : State → Int
  | .a => 2
  | .b => -1
  | .c => 4

def pullback (T : State → State) (f : State → Int) : State → Int :=
  fun state => f (T state)

def values (f : State → Int) : List Int :=
  points.map f

def squaredMassNumerator (f : State → Int) : Int :=
  (values f).foldl (fun total value => total + value * value) 0

def preimageCount (T : State → State) (target : State) : Nat :=
  (points.filter fun source => decide (T source = target)).length

def preimageCounts (T : State → State) : List Nat :=
  points.map (preimageCount T)

#eval values observable
#eval values (pullback cycle observable)
#eval values (pullback cycle (pullback cycle observable))
#eval squaredMassNumerator observable
#eval squaredMassNumerator (pullback cycle observable)
#eval preimageCounts cycle
#eval preimageCounts collapse
#eval values (pullback collapse observable)
#eval squaredMassNumerator (pullback collapse observable)

example : values observable = [2, -1, 4] := by decide
example : values (pullback cycle observable) = [-1, 4, 2] := by decide
example : values (pullback cycle (pullback cycle observable)) =
    [4, 2, -1] := by decide
example : squaredMassNumerator observable = 21 := by decide
example : squaredMassNumerator (pullback cycle observable) = 21 := by decide
example : preimageCounts cycle = [1, 1, 1] := by decide
example : preimageCounts collapse = [0, 0, 3] := by decide
example : values (pullback collapse observable) = [4, 4, 4] := by decide
example : squaredMassNumerator (pullback collapse observable) = 48 := by decide

end KoopmanFiniteScratch
~~~

Run exactly this small file on macOS or Linux with the pinned compiler:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean KoopmanFiniteScratch.lean
~~~

The first three output rows should be <code>[2, -1, 4]</code>,
<code>[-1, 4, 2]</code>, and <code>[4, 2, -1]</code>. The cycle has squared-mass
numerator <code>21</code> before and after pullback, and division by the three
equal masses gives squared \(L^2\) norm \(7\). The collapse has preimage counts
<code>[0, 0, 3]</code>, pulled-back values <code>[4, 4, 4]</code>, and numerator
<code>48</code>, which gives squared norm \(16\).

This worksheet checks finite function composition and integer arithmetic.
It does not instantiate Mathlib's measure, \(L^2\), or continuous-linear-map
interfaces. This exact worksheet was executed successfully with the pinned
Lean 4.32.0 compiler.

## Try the exact declarations in the project

{{< repo-check >}}
**Full project check.** This uses the repository's pinned Lean and Mathlib
dependencies and may require substantial disk space and memory.
Place the following commands in the imported module or in a separate project
scratch file:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.KoopmanL2Mean

open MeasureTheory
open NonlinearDynamics.Random.RandomCocycles

#check koopmanL2
#check koopmanL2_apply
#check Lp.norm_compMeasurePreserving
#check iterate_koopmanL2_apply
#check norm_koopmanL2_le
#check koopmanFixedSubspaceL2
#check koopmanInvariantProjectionL2
#check tendsto_birkhoffAverage_koopmanL2_projection
#check exists_subsequence_ae_tendsto_birkhoffAverage_koopmanL2_projection
~~~

Each <code>#check</code> asks the pinned elaborator for the declaration's exact
type. The full-project command printed below checks the full Mathlib-backed project
module.
{{< /repo-check >}}

## Boundary cases and common confusions

- **Identity dynamics:** if \(T\omega=\omega\), then \(U_Tf=f\) for every
  observable.
- **Constant observable:** if \(f\) has one value everywhere, then
  \(U_Tf=f\) for every state map, preserving or not.
- **Non-preserving map:** pointwise composition remains linear, but the chosen
  \(L^2(\mu)\) norm need not be preserved. The collapse example changes its
  square from \(7\) to \(16\).
- **Zero measure:** vector norms are still preserved, but the continuous
  linear operator norm is zero rather than one.
- **Noninvertible preserving map:** an isometric Koopman operator need not be
  onto. Measure preservation is not the same as bijectivity.
- **Representatives:** \((U_Tf)(\omega)=f(T\omega)\) is a pointwise formula
  for chosen representatives. The actual \(L^2\) object is an
  almost-everywhere equivalence class.
- **Iteration order:** the project uses forward composition
  \(U_Tf=f\circ T\), hence \(U_T^nf=f\circ T^n\).

## What the term does not establish

A Koopman operator by itself does not prove:

- that the state update is linear, smooth, injective, surjective, or
  invertible;
- that the composition operator is a unitary equivalence;
- that its operator norm is exactly one on a degenerate measure space;
- that every fixed observable is constant;
- that the system is ergodic, mixing, chaotic, or independent;
- that finite averages converge pointwise along the full sequence;
- that the invariant projection is already identified as conditional
  expectation; or
- a Kingman theorem, Lyapunov exponent, Lyapunov spectrum, or Oseledets
  splitting.

RMT-25 constructs the real \(L^2\) operator, its fixed subspace, its orthogonal
projection, and norm convergence of its finite means. The complete ascent is
[Mean Is Not Pointwise: Koopman Geometry, Coboundaries, and the Missing Maximal Step]({{< relref "/knowledge-base/deep-dives/mean-is-not-pointwise-koopman-geometry-coboundaries-and-the-missing-maximal-step" >}}).
The declaration-level account is
[Koopman L² Mean Convergence and a Dense Pointwise-Good Core in Lean]({{< relref "/development-notebook/2026/07/koopman-l2-mean-convergence-and-a-dense-pointwise-good-core-in-lean" >}}).

## Check your understanding

1. Starting from \(b\), what number does \(U_T^2f\) read in the three-cycle?
2. Why do the preimage counts \((1,1,1)\) certify uniform-mass preservation
   for a map on three points?
3. Recompute the collapse near-miss if every state is sent to \(a\) instead of
   \(c\). Does the norm grow or shrink?
4. Why can \(U_T\) be linear even when \(T\) is nonlinear?
5. Which hypothesis is used to turn \([f]\mapsto[f\circ T]\) into an
   isometry on \(L^2(\mu)\)?

## References

<a id="ref-koopman-operator-koopman"></a>**B. O. Koopman.**
[Hamiltonian Systems and Transformation in Hilbert Space](https://pmc.ncbi.nlm.nih.gov/articles/PMC1076052/),
*Proceedings of the National Academy of Sciences* 17(5), 315-318, 1931,
[DOI 10.1073/pnas.17.5.315](https://doi.org/10.1073/pnas.17.5.315).
Pages 315-316 construct composition operators for continuous-time Hamiltonian
flows with an invariant positive density. That historical unitary setting is
stronger than the project's discrete, potentially noninvertible interface.

<a id="ref-koopman-operator-von-neumann"></a>**John von Neumann.**
[Proof of the Quasi-Ergodic Hypothesis](https://pmc.ncbi.nlm.nih.gov/articles/PMC1076162/),
*Proceedings of the National Academy of Sciences* 18(1), 70-82, 1932,
[DOI 10.1073/pnas.18.1.70](https://doi.org/10.1073/pnas.18.1.70).
Pages 71-74 develop the Hilbert-norm projection form of mean convergence. The
project uses Mathlib's discrete contraction theorem rather than reproducing
the original continuous-time spectral argument.

<a id="ref-koopman-operator-birkhoff"></a>**George D. Birkhoff.**
[Proof of the Ergodic Theorem](https://pmc.ncbi.nlm.nih.gov/articles/PMC1076138/),
*Proceedings of the National Academy of Sciences* 17(12), 656-660, 1931,
[DOI 10.1073/pnas.17.2.656](https://doi.org/10.1073/pnas.17.2.656).
Page 656 separates convergence in the mean from the pointwise problem. The
publisher displays the DOI segment <code>17.2</code> even though the
bibliographic issue is 17(12).

<a id="ref-koopman-operator-mathlib-mean"></a>**Mathlib contributors.**
[Von Neumann mean ergodic theorem](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/InnerProductSpace/MeanErgodic.html),
with the
[pinned v4.32.0 implementation](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/InnerProductSpace/MeanErgodic.lean#L82-L94).
The theorem for a contracting continuous linear self-map is the upstream
result specialized by RMT-25.

<a id="ref-koopman-operator-mathlib-lp"></a>**Mathlib contributors.**
[Pinned measure-preserving \(L^p\) composition API](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/LpSpace/Basic.lean#L559-L633),
Mathlib v4.32.0. These declarations supply representative composition, the
iterate law, exact norm preservation, and the linear isometry used by
<code>koopmanL2</code>.

The exact upstream revision for both Mathlib references is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
