---
title: "Log-positive integrability envelope"
slug: "log-positive-integrability-envelope"
summary: "Log-positive growth clips contraction at zero, leaving a nonnegative finite-horizon observable that one integrable generator bound can control along every finite orbit."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability"
og_image: "log-positive-integrability-envelope-card.png"
og_image_alt: "A four-state cycle has generator norms one half, four, one quarter, and eight. Their product has positive log two log two, while the orbit envelope is five log two and the one-step probability average is five fourths log two."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working note. Human review of the
mathematics, Lean interpretation, examples, sources, figures, and accessibility
remains pending. The page is public so readers can follow the work while that
review is still open.
{{< /panel >}}

Start with a four-state clock:

\[
\Omega=\{0,1,2,3\},
\qquad
T(i)=i+1\pmod 4.
\]

Give \(\Omega\) the discrete measurable structure, in which every subset is
an allowed event, and define

\[
\mu(\{i\})=\frac14\qquad(i=0,1,2,3).
\]

This is a {{< refterm "probability-measure" "probability measure" >}} because
the four masses add to one. The map \(T\) merely rotates those equal masses,
so it preserves \(\mu\).

At the four states, let a one-dimensional matrix cocycle use the positive
scalar generators

\[
A(0)=\begin{bmatrix}1/2\end{bmatrix},\quad
A(1)=\begin{bmatrix}4\end{bmatrix},\quad
A(2)=\begin{bmatrix}1/4\end{bmatrix},\quad
A(3)=\begin{bmatrix}8\end{bmatrix}.
\]

A one-by-one matrix is still a matrix. Its induced infinity norm is the
absolute value of its only entry. Starting at state \(0\), the chronological
norms are therefore

\[
\frac12,\qquad4,\qquad\frac14,\qquad8.
\]

The exact four-step product norm is

\[
N_4(0)
=\frac12\cdot4\cdot\frac14\cdot8
=4.
\]

Its positive logarithmic growth is

\[
P_4(0)=\log^+4=\log4=2\log2.
\]

Now clip every one-step contraction before adding:

\[
\begin{aligned}
S_4(0)
&=\log^+\!\left(\frac12\right)
  +\log^+(4)
  +\log^+\!\left(\frac14\right)
  +\log^+(8)\\
&=0+2\log2+0+3\log2\\
&=5\log2.
\end{aligned}
\]

Thus

\[
\boxed{P_4(0)=2\log2\leq5\log2=S_4(0)}.
\]

The gap is the whole point. The product remembers that the factors \(1/2\)
and \(1/4\) cancel some expansion. The **envelope** deletes those negative
logarithms, so it is easier to integrate but intentionally less precise.

{{< reference-figure
  wide="true"
  src="log-positive-envelope-worked-example.svg"
  alt="Four equally weighted states form a cycle. Their one-step matrix norms are one half, four, one quarter, and eight, with log-positive coefficients zero, two, zero, and three in units of log two. The exact product norm is four, so its positive log is two log two. The orbit envelope is five log two, and the one-step probability average is five fourths log two."
  caption="**One complete finite model:** the base map rotates four equal atoms. Two contractions disappear at the positive-log gate, while the two expansions contribute \(2\log2\) and \(3\log2\). The actual four-step positive log is \(2\log2\), below the orbit envelope \(5\log2\). The finite one-step average \(5\log2/4\) makes the integrability hypothesis visible rather than implicit."
>}}

This scalar model was chosen to expose the bookkeeping. General matrices need
not commute, but their norms still satisfy the submultiplicative inequality
that drives the same envelope estimate.

## Define the observable

A **log-positive integrability envelope** is a real-valued upper-growth
observable for a matrix cocycle. It keeps positive logarithmic expansion and
clips everything else to zero. If

\[
N_k(\omega)=\lVert C(k,\omega)\rVert_\infty
\]

is the finite-time maximum absolute row-sum norm, define

\[
P_k(\omega)
{} =
\log^+ N_k(\omega)
{} =
\max\!\left(0,\operatorname{Real.log}N_k(\omega)\right).
\]

Here \(C(k,\omega)\) is the cocycle matrix after \(k\) steps from base state
\(\omega\). The notation \(\log^+\), read “log positive,” is Mathlib's
<code>Real.posLog</code>. The result \(P_k:\Omega\to\mathbb R\) is measurable
and nonnegative.

The word **envelope** is essential. \(P_k\) controls the positive tail of norm
growth, but it does not preserve the full logarithmic dynamics. It sends exact
collapse, strict contraction, and neutral norm one to the same real value
zero.

{{< reference-figure
  src="log-positive-integrability-envelope.svg"
  alt="Exact collapse, strict contraction, and unit norm enter the same zero output of the positive-log gate, while norms above one retain their positive logarithmic size. Shifted one-step outputs are then added into a finite orbit envelope."
  caption="**Finding:** the positive-log gate preserves expansion above unit norm but deliberately merges collapse, contraction, and unit scale at zero. Summing the shifted one-step outputs gives a nonnegative finite-horizon majorant whose integrability can be inherited from one explicit generator assumption. The diagram does not recover negative growth, the extended-real bottom value, a normalized limit, or a Lyapunov exponent."
>}}

## What the gate keeps and forgets

For a nonnegative real norm \(r\), Mathlib's definition gives the piecewise
picture

\[
\log^+ r
{} =
\begin{cases}
0, & 0\le r\le 1,\\
\log r, & 1\le r.
\end{cases}
\]

The overlap at \(r=1\) is harmless because both branches equal zero. The
construction is continuous even at \(r=0\), where Lean's total real logarithm
also has value zero.

Compare it with the
{{< refterm "extended-log-norm-observable" "extended log-norm observable" >}}
\(L_k\) from RMT-14:

| Norm regime | Extended log norm \(L_k\) | Log-positive envelope \(P_k\) | Information retained by \(P_k\) |
|---|---:|---:|---|
| \(N_k=0\) | \(\bot\) | \(0\) | No record of exact collapse |
| \(0\lt N_k\lt1\) | A negative real | \(0\) | No contraction magnitude |
| \(N_k=1\) | \(0\) | \(0\) | Neutral scale is included in the same bucket |
| \(N_k\gt1\) | A positive real | \(\log N_k\) | Positive expansion size |

Thus \(P_k\) is not a replacement for \(L_k\). It is the simpler real
majorant needed to state an ordinary Bochner-integrability hypothesis for the
expanding part.

## Finite-time subadditivity

RMT-14 proves norm submultiplicativity across the one-sided cocycle split:

\[
N_{m+k}(\omega)
\le
N_k(T^m\omega)N_m(\omega).
\]

The positive logarithm is monotone on nonnegative inputs, and Mathlib proves

\[
\log^+(rs)\le \log^+r+\log^+s.
\]

Consequently RMT-15 obtains

\[
P_{m+k}(\omega)
\le
P_k(T^m\omega)+P_m(\omega).
\]

This is still a pointwise finite-time inequality. It invokes no probability,
ergodicity, expectation, or limiting theorem.

## The orbit-sum majorant

The one-step envelope is sampled along the forward base orbit and added:

\[
S_k(\omega)
{} =
\sum_{j=0}^{k-1}P_1(T^j\omega).
\]

Lean names this function <code>orbitLogPlusSum</code>. The empty sum is zero,
and extending the horizon appends the newest shifted one-step term:

\[
S_{k+1}(\omega)
{} =
S_k(\omega)+P_1(T^k\omega).
\]

Induction with finite-time subadditivity proves the domination estimate

\[
0\le P_k(\omega)\le S_k(\omega).
\]

The right side is deliberately loose. It forgets cancellation between matrix
factors and every contracting one-step contribution. Its value is that it is a
finite sum of copies of one measurable function pulled back along the base
orbit.

## The explicit integrability hypothesis

The project does not derive integrability from measure preservation. It names
the missing assumption:

~~~lean
def HasIntegrableGeneratorLogPlus
    (C : DiscreteMatrixCocycle (ι := ι) μ) : Prop :=
  Integrable (C.logPlusNormObservable 1) μ
~~~

For a real-valued function, Mathlib's
{{< refterm "integrability" "Integrable" >}} predicate is absolute Bochner
integrability with respect to the stated measure. Because \(P_1\) is
nonnegative, this asks for a finite integral of its expanding tail. The
measure \(\mu\) may be arbitrary. The definition does not assert
\(\mu(\Omega)=1\), so the integral is not automatically an expectation.

The bundled base map is a
{{< refterm "measure-preserving-transformation" "measure-preserving transformation" >}}.
Every natural iterate therefore also preserves \(\mu\), and integrability
survives pullback:

\[
P_1\text{ integrable}
\quad\Longrightarrow\quad
\omega\mapsto P_1(T^j\omega)\text{ integrable for every }j.
\]

A finite sum of those pullbacks is integrable, so \(S_k\) is integrable.
Finally, measurability and \(0\le P_k\le S_k\) transfer integrability to every
finite-horizon \(P_k\).

## How the Lean interface is layered

The sixteen exported declarations deliberately separate four claims that are
often compressed into one sentence.

First, <code>logPlusNormObservable</code> defines \(P_k\), while
<code>logPlusNormObservable_nonneg</code>,
<code>logPlusNormObservable_zero</code>,
<code>logPlusNormObservable_one</code>, and
<code>measurable_logPlusNormObservable</code> establish its elementary
pointwise and measurable behavior. The finite split theorem
<code>logPlusNormObservable_add_le</code> remains algebraic and pointwise.

Second, <code>orbitLogPlusSum</code> defines \(S_k\). Its zero and successor
theorems fix the indexing convention, and
<code>measurable_orbitLogPlusSum</code> proves the finite sum measurable.
The theorem <code>logPlusNormObservable_le_orbitLogPlusSum</code> is the
pointwise bridge \(P_k\le S_k\). None of these declarations assumes the
generator envelope is integrable.

Third, <code>HasIntegrableGeneratorLogPlus</code> names the missing one-step
hypothesis. It is a proposition attached to a cocycle, not a field silently
inserted into every cocycle and not a conclusion of measure preservation.

Fourth, the three declarations in the
<code>HasIntegrableGeneratorLogPlus</code> namespace propagate that hypothesis
to base iterates, orbit sums, and finally finite-horizon envelopes. This order
makes the proof auditable: transport, finite addition, then domination.

## In Lean: define the clipped observable

{{< lean-bridge
  human="At outcome omega and horizon k, measure the cocycle matrix, take its infinity norm, apply the real logarithm, and replace any negative result by zero."
  math="\(P_k(\omega)=\log^+\!\bigl(\lVert C(k,\omega)\rVert_\infty\bigr).\)"
  lean="C.logPlusNormObservable k ω = log⁺ (C.normObservable k ω)"
>}}

- <code>C</code> is the bundled one-sided discrete matrix cocycle.
- <code>k : ℕ</code> is the number of generator matrices in the finite product.
- <code>ω : Ω</code> is one starting state in the base space.
- <code>C.normObservable k ω</code> is the selected induced infinity norm of the
  realized <code>k</code>-step cocycle matrix.
- <code>log⁺</code> is the notation for <code>Real.posLog</code> after opening
  <code>Real</code> as a scoped namespace. It returns an ordinary real number.
- The equality is definitional: unfolding <code>logPlusNormObservable</code>
  exposes the right-hand side.
{{< /lean-bridge >}}

The exact project definition is:

~~~lean
def logPlusNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → ℝ :=
  fun ω ↦ log⁺ (C.normObservable k ω)
~~~

Read <code>fun ω ↦ ...</code> as “the function that sends \(\omega\) to
...”. The result type <code>Ω → ℝ</code> is a real-valued observable, not a
measure and not yet an integral.

## In Lean: dominate a horizon by one-step terms

{{< lean-bridge
  human="The positive log of the whole k-step product is no larger than the sum of the one-step positive logs encountered along the first k base states."
  math="\(P_k(\omega)\leq\displaystyle\sum_{j=0}^{k-1}P_1(T^j\omega)=S_k(\omega).\)"
  lean="C.logPlusNormObservable_le_orbitLogPlusSum k ω"
>}}

- The theorem is called with the cocycle <code>C</code> before the dot.
- <code>orbitLogPlusSum</code> expands to a <code>Finset</code> sum over
  <code>Finset.range k</code>, which contains exactly
  <code>0, 1, ..., k - 1</code>.
- <code>C.base^[j]</code> is Lean's notation for the <code>j</code>-fold iterate
  of the base map. Applying it to <code>ω</code> gives \(T^j\omega\).
- The conclusion is pointwise. It requires neither an integral nor a
  probability measure.
{{< /lean-bridge >}}

The definition being bounded is:

~~~lean
def orbitLogPlusSum
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → ℝ :=
  fun ω ↦ ∑ j ∈ Finset.range k,
    C.logPlusNormObservable 1 (C.base^[j] ω)
~~~

At <code>k = 0</code>, <code>Finset.range 0</code> is empty, so this sum is
zero. At <code>k + 1</code>, the new term has index <code>k</code>. That is the
same half-open indexing convention used in the paper sum.

## In Lean: propagate the integrability certificate

{{< lean-bridge
  human="If the one-step positive-log generator is integrable, then the positive-log norm at every finite horizon k is integrable."
  math="\(P_1\in L^1(\mu)\Longrightarrow P_k\in L^1(\mu)\quad\text{for every finite }k.\)"
  lean="hC.integrable_logPlusNormObservable k"
>}}

- <code>hC</code> has type
  <code>C.HasIntegrableGeneratorLogPlus</code>. After unfolding, that is proof
  evidence for <code>Integrable (C.logPlusNormObservable 1) μ</code>.
- The dot notation asks Lean to use <code>hC</code> as the theorem's first
  explicit argument.
- <code>k</code> is arbitrary but finite because its type is <code>ℕ</code>.
- The conclusion is <code>Integrable (C.logPlusNormObservable k) μ</code>.
  It does not say that the sequence converges as <code>k → ∞</code>.
{{< /lean-bridge >}}

The proof travels through two reusable intermediate certificates:

~~~lean
hC.integrable_at_base_iterate j
hC.integrable_orbitLogPlusSum k
hC.integrable_logPlusNormObservable k
~~~

They correspond, in order, to preservation under the shift, closure under a
finite sum, and domination of the target observable by that sum.

## Three common misreads

**“Zero positive log means no dynamics.”** False. It can mean exact
annihilation, strict contraction, or norm one. The full matrix can still rotate,
project, shear within unit norm, or collapse every vector.

**“An integrable expanding tail gives an integrable logarithm.”** False. The
negative tail has been deleted. A zero matrix is the sharp counterexample:
\(P_k=0\) but \(L_k=\bot\).

**“A preserved measure turns the integral into an expectation.”** False.
Preservation says that pulling an integrable function along the base does not
destroy integrability. Only a separately supplied probability normalization
would justify expectation language.

## Read the four-state integrability ledger

In the opening model, the one-step observable has four values:

| State \(i\) | Generator norm \(\lVert A(i)\rVert_\infty\) | \(P_1(i)=\log^+\lVert A(i)\rVert_\infty\) | Probability |
|---:|---:|---:|---:|
| \(0\) | \(1/2\) | \(0\) | \(1/4\) |
| \(1\) | \(4\) | \(2\log2\) | \(1/4\) |
| \(2\) | \(1/4\) | \(0\) | \(1/4\) |
| \(3\) | \(8\) | \(3\log2\) | \(1/4\) |

Every function on this finite space is measurable. All four displayed values
are finite, so the function is integrable. Its integral is

\[
\int_\Omega P_1\,d\mu
=\frac14\bigl(0+2\log2+0+3\log2\bigr)
=\frac54\log2.
\]

Because \(\mu\) is a probability measure, this integral may also be called the
{{< refterm "expectation" "expectation" >}} of \(P_1\). The project definition
does not assume probability, so its general theorem correctly says
“integrable” rather than “has finite expectation.”

Composing with the rotation only permutes the value list. For example,

\[
(P_1\circ T)(0,1,2,3)
=\bigl(2\log2,0,3\log2,0\bigr).
\]

The integral remains \(5\log2/4\). The same holds for every iterate
\(P_1\circ T^j\). Adding four such shifted functions gives an integrable orbit
sum. The theorem then uses

\[
0\le P_4\le S_4
\]

and measurability of \(P_4\) to transfer integrability from \(S_4\) to
\(P_4\). This last step is a domination argument, not another appeal to
measure preservation.

## Exact source excerpts

**Resource label: pinned project plus Mathlib.** The checked implementation is
in [<code>LogPlusIntegrability.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/LogPlusIntegrability.lean).
Its pointwise finite-horizon split first combines norm submultiplicativity,
monotonicity of positive log, and the positive-log product inequality:

~~~lean
theorem logPlusNormObservable_add_le
    (C : DiscreteMatrixCocycle (ι := ι) μ) (m k : ℕ) (ω : Ω) :
    C.logPlusNormObservable (m + k) ω ≤
      C.logPlusNormObservable k (C.base^[m] ω) +
        C.logPlusNormObservable m ω := by
  calc
    log⁺ (C.normObservable (m + k) ω) ≤
        log⁺ (C.normObservable k (C.base^[m] ω) * C.normObservable m ω) :=
      Real.posLog_le_posLog (norm_nonneg _) (C.normObservable_add_le m k ω)
    _ ≤ log⁺ (C.normObservable k (C.base^[m] ω)) +
        log⁺ (C.normObservable m ω) := Real.posLog_mul
~~~

The first line after <code>calc</code> replaces the whole-product norm by a
product of block norms. The second turns positive log of that product into a
sum. No integration occurs in this theorem.

The final integrability theorem makes the proof order explicit:

~~~lean
theorem HasIntegrableGeneratorLogPlus.integrable_logPlusNormObservable
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) :
    Integrable (C.logPlusNormObservable k) μ := by
  apply (hC.integrable_orbitLogPlusSum k).mono'
    (C.measurable_logPlusNormObservable k).aestronglyMeasurable
  filter_upwards with ω
  rw [Real.norm_eq_abs, abs_of_nonneg (C.logPlusNormObservable_nonneg k ω)]
  exact C.logPlusNormObservable_le_orbitLogPlusSum k ω
~~~

The <code>mono'</code> domination principle asks for an integrable majorant,
an almost-everywhere strongly measurable target, and an almost-everywhere norm
bound. The project has a pointwise bound, so it is strong enough to discharge
the almost-everywhere obligation.

## Tiny local Lean/Std arithmetic worksheet

**Resource label: tiny standalone check.** The real logarithm is analytic, but
the opening example uses powers of two. We can therefore record every log size
exactly by its coefficient of \(\log2\). This complete program imports only
<code>Std</code>; it does not import Mathlib or the project.

Save it as <code>LogPositiveEnvelopeScratch.lean</code>:

~~~lean
import Std

namespace LogPositiveEnvelopeScratch

-- A value e represents the scalar generator norm 2^e.
def exponents : List Int := [-1, 2, -2, 3]

-- log⁺(2^e) = max(0, e) · log 2.
def positiveLogCoeff (e : Int) : Nat :=
  e.toNat

def productExponent : Int :=
  exponents.foldl (fun total e => total + e) 0

def finiteLogPlusCoeff : Nat :=
  positiveLogCoeff productExponent

def orbitEnvelopeCoeff : Nat :=
  (exponents.map positiveLogCoeff).sum

def envelopeBoundHolds : Bool :=
  decide (finiteLogPlusCoeff ≤ orbitEnvelopeCoeff)

#eval exponents.map positiveLogCoeff
#eval productExponent
#eval finiteLogPlusCoeff
#eval orbitEnvelopeCoeff
#eval envelopeBoundHolds
#eval (orbitEnvelopeCoeff, exponents.length)

end LogPositiveEnvelopeScratch
~~~

Run exactly this small file on macOS or Linux with the pinned Lean toolchain:

~~~sh
elan run leanprover/lean4:v4.32.0 lean LogPositiveEnvelopeScratch.lean
~~~

The outputs should be
<code>[0, 2, 0, 3]</code>, <code>2</code>, <code>2</code>, <code>5</code>,
<code>true</code>, and <code>(5, 4)</code>. They encode

\[
P_4=2\log2,
\qquad
S_4=5\log2,
\qquad
\int P_1\,d\mu=\frac54\log2.
\]

The worksheet checks the finite arithmetic only. It does not pretend that a
list of integer exponents is Mathlib's matrix cocycle, measure-preserving map,
or Bochner-integrability proof.

## Try the exact declarations in the project

{{< repo-check >}}
**Resource label: pinned project plus Mathlib.** In a deliberately provisioned
copy of this repository, a reader can place these probes after the module
import:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability

open Matrix MeasureTheory
open scoped Matrix.Norms.Operator Real
open NonlinearDynamics.Random.RandomCocycles

#check Real.posLog
#check Real.posLog_nonneg
#check Real.posLog_mul
#check DiscreteMatrixCocycle.logPlusNormObservable
#check DiscreteMatrixCocycle.logPlusNormObservable_nonneg
#check DiscreteMatrixCocycle.logPlusNormObservable_zero
#check DiscreteMatrixCocycle.logPlusNormObservable_one
#check DiscreteMatrixCocycle.measurable_logPlusNormObservable
#check DiscreteMatrixCocycle.logPlusNormObservable_add_le
#check DiscreteMatrixCocycle.orbitLogPlusSum
#check DiscreteMatrixCocycle.orbitLogPlusSum_zero
#check DiscreteMatrixCocycle.orbitLogPlusSum_succ
#check DiscreteMatrixCocycle.logPlusNormObservable_le_orbitLogPlusSum
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integrable_at_base_iterate
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integrable_orbitLogPlusSum
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.integrable_logPlusNormObservable
~~~

Each <code>#check</code> asks the pinned elaborator for the exact type already
proved in the repository. It does not rerun the proof in the browser. The
guarded command below checks the complete module on approved Linux compute.
{{< /repo-check >}}

## Empty matrix dimension

When the matrix index type is empty, RMT-14 proves \(N_k=0\) at every horizon.
Because \(\log^+0=0\), RMT-15 proves

\[
P_k(\omega)=0
\]

for every \(k\) and \(\omega\). This also explains why the time-zero identity
\(P_0=0\) needs no <code>Nonempty ι</code> assumption: the inhabited branch
has norm one, while the empty branch has norm zero, and positive log sends both
to zero.

The module does not export a separate empty-dimensional theorem for every
orbit sum or integrability proposition. Those consequences can be derived
from the checked zero observable and general finite-sum facts when needed.

## What this envelope does not establish

The RMT-15 interface does not prove:

- integrability of the RMT-14 <code>EReal</code>-valued extended log norm;
- any estimate for negative logarithmic growth or inverse-matrix norms;
- that cocycle matrices are nonzero, injective, or invertible;
- a probability normalization, expectation, or distributional law;
- ergodicity, mixing, independence, or identical distribution;
- a normalized process such as \(k^{-1}P_k\) or \(k^{-1}L_k\);
- convergence, an almost-sure growth rate, or a deterministic limit;
- Kingman's subadditive ergodic theorem or the Furstenberg-Kesten theorem;
- a Lyapunov exponent, Lyapunov spectrum, or Oseledets splitting;
- a two-sided cocycle or negative-time dynamics; or
- a derivative, tangent-space, or random-Jacobian interpretation.

Most importantly, an integrable \(P_k\) can coexist with complete collapse.
If \(C(k,\omega)=0\), then \(P_k(\omega)=0\) while the extended log norm is
\(\bot\). Positive-tail integrability alone therefore says nothing about the
negative endpoint needed for a full Lyapunov analysis.

## Where to continue

RMT-34 repairs the missing negative tail under an explicit, stronger
interface. The {{< refterm "integrable-generator-log-tails" "integrable generator log tails" >}}
package combines pointwise matrix units with integrable forward and inverse
one-step log-positive norms, producing integrable lower and upper rails around
every finite-time real log norm. A checked geometric-probability example shows
that the forward moment does not imply the inverse moment. There is one
separate shortcut: if the RMT-33 log-positive rate is strictly positive, the
positive log and real log eventually agree almost everywhere without those
inverse assumptions. That shortcut proves no result in the zero or negative
rate regime.

[The integrated log-positive growth rate]({{< relref "/knowledge-base/glossary/integrated-log-positive-growth-rate" >}})
is the RMT-16 successor. It integrates each finite-horizon envelope, proves
under the same explicit one-step integrability hypothesis that the resulting
real sequence is subadditive, and applies deterministic Fekete convergence over
positive horizons. The successor still assumes no probability normalization or
ergodicity and proves no samplewise or Lyapunov limit.

[Finite-Horizon Log-Positive Cocycle Integrability]({{< relref "/knowledge-base/deep-dives/finite-horizon-log-positive-cocycle-integrability" >}})
derives the complete sixteen-declaration Lean layer, including the orbit-sum
recurrence, measure-preserving pullbacks, finite-sum integrability, and the
final domination proof.

[Finite-Time Norm and Extended-Log-Norm Observables for Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/finite-time-norm-and-extended-log-norm-cocycle-observables" >}})
develops the zero-faithful predecessor. The
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycle" >}}
entry supplies the shifted base orbit and product convention.

## References

<a id="ref-log-positive-poslog"></a>**Mathlib contributors.**
[The positive part of the logarithm](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/SpecialFunctions/Log/PosLog.html),
Mathlib 4 documentation. This official source defines <code>Real.posLog</code>,
proves nonnegativity, continuity, monotonicity on nonnegative inputs, and the
two-factor product estimate used by RMT-15.

<a id="ref-log-positive-integrable"></a>**Mathlib contributors.**
[Bochner integrability](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Function/L1Space/Integrable.html),
Mathlib 4 documentation. This official source contains integrability under a
measure-preserving pullback, finite-sum closure, and domination principles.

<a id="ref-log-positive-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source is a later asymptotic destination. The present envelope
supplies only finite-horizon measurability, domination, and integrability.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
