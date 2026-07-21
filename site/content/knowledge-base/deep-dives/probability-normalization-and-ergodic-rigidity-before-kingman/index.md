---
title: "Probability Normalization and Ergodic Rigidity Before Kingman"
slug: "probability-normalization-and-ergodic-rigidity-before-kingman"
date: 2026-07-21
summary: "A textbook separation of probability scale, ergodic invariant rigidity, and finite-horizon integrability for matrix cocycles, together with the exact Lean interfaces available before a subadditive ergodic theorem."
lead: "Mass one licenses expectation language. Ergodicity destroys nontrivial invariant information. Integrability controls finite moments. The current Lean milestone wires those roles together without pretending that a samplewise limit theorem has already been formalized."
draft: true
pro_reviewed: false
level: "Probability measures, measure-preserving dynamics, ergodicity, invariant events and observables, Bochner integrability, subadditive cocycle processes, and deterministic Fekete rates"
reading_time: "105 to 145 minutes"
prerequisites: "One-sided discrete matrix cocycles, finite-horizon log-positive envelopes, measure preservation, ordinary real-valued integrability, and the deterministic integrated Fekete rate; no ergodic theorem is assumed"
lean_module: "NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase"
toc: true
og_image: "probability-normalization-and-ergodic-rigidity-before-kingman-card.png"
og_image_alt: "An assumption map separates probability normalization, ergodic invariant rigidity, and log-positive integrability. Four checked outputs use different combinations: deterministic rate facts, a finite-horizon expectation alias, an invariant-event zero-one law, and almost-everywhere constancy of invariant observables. A blocked bridge says that no samplewise limit theorem has been proved."
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

The sixteenth random-matrix-theory milestone (RMT-16) ended with a
deterministic theorem. For the finite-horizon
log-positive envelope

\[
P_k(\omega)
{} =
\log^+\lVert C(k,\omega)\rVert_\infty,
\]

it integrated first,

\[
I_k=\int_\Omega P_k(\omega)\,d\mu(\omega),
\]

proved the real sequence \(I_k\) subadditive, and obtained the positive-time
Fekete rate

\[
\gamma_\mu^+(C)
{} =
\inf_{k\ge1}\frac{I_k}{k}.
\]

That proof removed the outcome variable before taking a limit. The next
milestone, RMT-17, now prepares the probabilistic and ergodic vocabulary needed
for later sample-dependent theorems, but it does not cross that later theorem
boundary.

The preparation has three independent axes:

1. <code>IsProbabilityMeasure μ</code> fixes total mass at one;
2. <code>Ergodic C.base μ</code> makes invariant information trivial modulo
   null sets; and
3. <code>C.HasIntegrableGeneratorLogPlus</code> controls every finite-horizon
   positive-log moment.

The new module exports one generic process-candidate structure, four
deterministic rate facts, a probability-specialized expectation definition
and equality, and two ergodic rigidity bridges. It exports no Kingman theorem,
no samplewise limit, and no Lyapunov exponent.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [The assumption matrix](#the-assumption-matrix) | See which theorem consumes which gate |
| Probability route | [Camp one: probability fixes scale](#camp-one-probability-fixes-scale) | Learn exactly what mass one does and does not buy |
| Ergodic route | [Camp two: ergodicity fixes invariant information](#camp-two-ergodicity-fixes-invariant-information) | Read the event and function forms of rigidity |
| Analytic route | [Camp three: integrability remains separate](#camp-three-integrability-remains-separate) | Package the finite process without hidden asymptotics |
| Rate route | [Camp four: four deterministic rate facts](#camp-four-four-deterministic-rate-facts) | Reuse Fekete without probability or ergodicity |
| Example route | [Four models that separate the assumptions](#four-models-that-separate-the-assumptions) | Test every tempting implication on exact spaces |
| Cocycle route | [The alternating scalar cocycle](#the-alternating-scalar-cocycle) | Compute a nonmonotone normalized expectation and a strict rate bound |
| Lean route | [The complete ten-declaration map](#the-complete-ten-declaration-map) | Audit every exported declaration in source order |
| Summit route | [The honest pre-Kingman boundary](#the-honest-pre-kingman-boundary) | Identify the missing theorem and forbid automatic limit claims |

### Learning objectives

By the summit, a reader should be able to:

1. state <code>IsProbabilityMeasure μ</code> as the equation
   \(\mu(\Omega)=1\);
2. explain why probability normalization does not imply integrability,
   ergodicity, independence, or mixing;
3. unpack <code>Ergodic T μ</code> into measure preservation and invariant-set
   rigidity;
4. distinguish a null-or-conull event conclusion from the numerical
   probability zero-one conclusion;
5. explain why the invariant-function theorem needs ergodicity but no
   probability typeclass;
6. explain why <code>HasIntegrableGeneratorLogPlus</code> is an independent
   analytic hypothesis;
7. read both fields of
   <code>IsIntegrableSubadditiveProcessCandidate</code> exactly;
8. identify what that candidate deliberately does not store;
9. derive nonnegativity of the deterministic integrated rate from convergence
   of nonnegative normalized values;
10. read the positive-index infimum theorem without accidentally including
    time zero;
11. derive the upper bound by every positive normalized horizon;
12. specialize that bound to one step;
13. explain why the expectation alias is definitionally the raw integral;
14. identify the strict invariance and measurability requirements in the
    event zero-one theorem;
15. identify the almost-everywhere invariance and strong measurability
    requirements in the function theorem;
16. use exact one-point and two-point examples to refute false implications;
17. compute the alternating scalar cocycle at horizons one, two, and three;
18. explain why ergodicity does not imply mixing;
19. separate a deterministic limit of integrated values from a samplewise
    limit; and
20. list the obligations still needed before a formal Kingman application.

## The assumption matrix

{{< reference-figure
  src="probability-ergodicity-integrability-assumption-matrix.svg"
  alt="A four-row assumption matrix maps probability, ergodicity, and integrability to the current module's outputs. Deterministic rate facts require only integrability. The finite-horizon expectation requires probability and integrability. The invariant-event zero-one result requires probability and ergodicity. Almost-everywhere constancy of an invariant observable requires only ergodicity. A lower warning says that no row proves a samplewise limit."
  caption="**Finding:** no current-module declaration consumes all three gates. Integrability alone supports the deterministic rate facts; probability joins integrability only to justify finite-horizon expectation language; probability joins ergodicity for a numerical event zero-one law; and ergodicity alone gives almost-everywhere constancy of an invariant real observable. These interfaces prepare future theorem use but do not supply Kingman's samplewise conclusion."
>}}

The matrix is more than editorial organization. It is a picture of the Lean
signatures. If probability or ergodicity were silently used in the rate
theorems, those theorems would have extra arguments. If probability were
silently needed for invariant-function rigidity, that theorem would carry a
typeclass premise. It does not.

Conversely, the expectation definition carries both probability and
integrability even though its body is the same integral as before. Those
arguments are not computational decorations. They encode the semantic and
analytic conditions under which the word “expectation” is honest.

## The common setup

Fix a measurable base space \(\Omega\), a measure \(\mu\), a finite matrix index
type \(\iota\) with decidable equality, and a bundled one-sided discrete matrix
cocycle \(C\). Its base map is

\[
T=C.\mathrm{base}:\Omega\to\Omega.
\]

The cocycle already stores that \(T\) is measurable and preserves \(\mu\), in
the sense of Mathlib's
[measure-preserving map interface](#ref-prob-erg-deep-preserving). Its
finite products satisfy the chronological split

\[
C(m+k,\omega)
{} =
C(k,T^m\omega)C(m,\omega).
\]

The selected matrix norm is the maximum absolute row-sum norm, and the
positive logarithm is

\[
\log^+x=\max(\log x,0)
\]

with the project's zero policy inherited from earlier modules. The resulting
finite process is \(P:\mathbb N\to\Omega\to\mathbb R\).

Three propositions can now be asked without answering one another:

| Question | Lean witness | What it controls |
|---|---|---|
| Does the measure have unit mass? | <code>[IsProbabilityMeasure μ]</code> | Probability vocabulary and numerical zero-one values |
| Is invariant base information trivial? | <code>hErg : Ergodic C.base μ</code> | Invariant events and invariant observables |
| Are finite positive-log moments legitimate? | <code>hC : C.HasIntegrableGeneratorLogPlus</code> | Finite-horizon integrability and deterministic rate facts |

Measure preservation is a fourth fact, already bundled in \(C\). It makes
shifted integrals agree and supports the previous scalar subadditivity proof.
It does not imply any row of this table except its own statement.

## Camp one: probability fixes scale

### The exact Mathlib class

Mathlib defines a probability measure by one field:

~~~lean
class IsProbabilityMeasure (μ : Measure α) : Prop where
  measure_univ : μ univ = 1
~~~

The official
[probability-measure typeclass documentation](#ref-prob-erg-deep-probability)
also records consequences such as finiteness and nonzeroness. In particular,
the typeclass prevents the total mass from being an arbitrary finite scalar.

This is a normalization condition on a measure. It is not a theorem about the
base map \(T\). The identity map on a two-point uniform probability space is
measure preserving but not ergodic. A periodic flip is ergodic but not mixing.
Probability alone does not distinguish them.

It is also not a theorem about a measurable function's tails. A real-valued
function may be finite at every point of a probability space and still have a
divergent absolute integral. The example \(x\mapsto1/x\) on \((0,1]\) will make
that failure explicit below.

### Why expectation needs two gates

RMT-16 defined the raw integral

\[
I_k=\int_\Omega P_k\,d\mu
\]

for an arbitrary measure. Mathlib's Bochner integral is totalized, so this
expression has a real value even if \(P_k\) is not integrable. The separate
<code>hC</code> witness prevents that value from being misread as a finite
moment.

RMT-17 introduces

~~~lean
def finiteHorizonLogPlusExpectation [IsProbabilityMeasure μ]
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (_hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) : ℝ :=
  ∫ ω, C.logPlusNormObservable k ω ∂μ
~~~

The two extra premises do different jobs:

- <code>[IsProbabilityMeasure μ]</code> makes the integral a probability
  expectation; and
- <code>_hC</code> supplies genuine finite-horizon integrability through the
  RMT-15 propagation theorem.

The underscore in <code>_hC</code> means the proof term does not occur in the
definition's computational body. It does not mean the assumption is
mathematically disposable. Its presence at the public boundary blocks callers
from applying expectation language to the totalized nonintegrable branch.

### Declaration 8: the expectation is the raw integral

The next theorem is

~~~lean
@[simp] theorem finiteHorizonLogPlusExpectation_eq_integratedLogPlusNorm
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) :
    C.finiteHorizonLogPlusExpectation hC k = C.integratedLogPlusNorm k := by
  rfl
~~~

The proof is reflexivity because both sides unfold to the same integral.
Probability normalization does not divide by total mass here. Total mass is
already one. The theorem is a semantic bridge between two names for one
scalar, not a numerical conversion formula.

This distinction matters when comparing raw measures. If the one-point base
has mass two, \(I_k\) remains defined and may be finite, but RMT-17 does not
offer the expectation name. Renormalizing that measure to mass one would be a
separate construction with correspondingly rescaled integrals.

## Camp two: ergodicity fixes invariant information

### The event definition

Mathlib separates <code>PreErgodic T μ</code> from
<code>Ergodic T μ</code>. Pre-ergodicity says that every measurable set \(A\)
with strict preimage invariance

\[
T^{-1}(A)=A
\]

is almost everywhere empty or almost everywhere universal. Ergodicity extends
that property with measure preservation. The official
[ergodic maps and measures documentation](#ref-prob-erg-deep-ergodic) is the
upstream authority for both structures.

The most primitive numerical statement is therefore not automatically
“probability zero or one.” Before normalization, the invariant set satisfies

\[
\mu(A)=0
\quad\text{or}\quad
\mu(A^c)=0.
\]

The second branch says \(A\) is conull. Its numerical mass equals the mass of
the entire space, which may be two, seven, or infinite. Only on a probability
space does the second branch become \(\mu(A)=1\).

### Declaration 9: invariant-event probability is zero or one

RMT-17 exposes exactly that normalized bridge:

~~~lean
theorem ergodicBase_invariantEvent_prob_eq_zero_or_one
    [IsProbabilityMeasure μ]
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (hErg : Ergodic C.base μ) {s : Set Ω}
    (hs : MeasurableSet s) (hinv : C.base ⁻¹' s = s) :
    μ s = 0 ∨ μ s = 1
~~~

Every premise is visible:

1. the measure has mass one;
2. the base is ergodic;
3. the event is measurable; and
4. invariance is an exact set equality.

The theorem does not accept an arbitrary event whose probability happens to
be preserved under one step. It requires the preimage set itself to be the
same set. It also does not infer measurability from invariance.

The wrapper intentionally chooses a strict-invariance theorem even though
Mathlib contains more general almost-invariant machinery through
quasi-ergodicity. A narrow exact signature is easier to teach and audit at
this stage. Future interfaces can relax the premise without pretending the
current theorem already did.

### The function form of rigidity

An invariant event is a binary observable. The same idea extends to
real-valued information. If a measurable \(g:\Omega\to\mathbb R\) satisfies
\(g\circ T=g\), then each measurable threshold event associated with \(g\) is
invariant. Ergodicity forces those threshold events to be trivial, which in
turn forces \(g\) to be essentially constant.

Mathlib proves this through a general countable-separation argument for
measurable target spaces and specializes it to almost-everywhere strongly
measurable functions into metrizable spaces. The official
[invariant-function documentation](#ref-prob-erg-deep-function) gives the
precise theorem used here.

### Declaration 10: an invariant real observable is almost everywhere constant

RMT-17's wrapper is

~~~lean
theorem ergodicBase_ae_eq_const_of_ae_invariant
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (hErg : Ergodic C.base μ) {g : Ω → ℝ}
    (hg : AEStronglyMeasurable g μ)
    (hinv : g ∘ C.base =ᵐ[μ] g) :
    ∃ c : ℝ, g =ᵐ[μ] Function.const Ω c
~~~

There is no probability premise. Ergodicity is fundamentally a
null-or-conull statement, so essential constancy makes sense for a raw
measure. On the one-point mass-two space, for example, every real observable
is genuinely constant even though the measure is not probabilistic.

There is also no integrability premise. Almost-everywhere strong measurability
is enough for this rigidity theorem. The resulting constant is not asserted
to be the expectation of \(g\), because \(g\) need not be integrable and the
measure need not have mass one.

The conclusion is existential and almost everywhere. It does not choose a
canonical constant, prove uniqueness on a zero measure, or upgrade equality
at every point. These omissions are correct. Almost-everywhere statements
ignore null sets, and on the zero measure every two functions are almost
everywhere equal.

### Why these two wrappers are matrix-dimension free

The two ergodic bridges mention a matrix cocycle only to obtain its base map.
Their proofs never inspect a matrix entry, enumerate an index type, or use
decidable matrix equality. The Lean source explicitly omits the ambient
<code>Fintype ι</code> and <code>DecidableEq ι</code> instances around these
theorems.

That is proof engineering with mathematical meaning: invariant base
information does not depend on matrix dimension. A later refactor could place
these statements on a more generic measure-preserving dynamical-system
interface without changing their content.

## Camp three: integrability remains separate

### The inherited one-step hypothesis

The proposition

~~~lean
C.HasIntegrableGeneratorLogPlus
~~~

means that the one-step positive-log envelope \(P_1\) is integrable. Earlier
modules use the cocycle inequality and a finite orbit-sum majorant to prove
that every \(P_k\) is integrable. Nothing about that propagation requires
mass one or ergodicity.

This is exactly the right separation. Integrability is a tail condition on an
observable with respect to a measure. Probability is only the normalization
of that measure. Ergodicity is only the rigidity of invariant information
under its preserved dynamics. Neither can control the size of an arbitrary
measurable generator.

### Declaration 1: the generic process candidate

RMT-17 begins with a generic predicate:

~~~lean
structure IsIntegrableSubadditiveProcessCandidate
    {Ω : Type uΩ} [MeasurableSpace Ω] (T : Ω → Ω) (μ : Measure Ω)
    (X : ℕ → Ω → ℝ) : Prop where
  integrable : ∀ k, Integrable (X k) μ
  add_le : ∀ m k ω, X (m + k) ω ≤ X k (T^[m] ω) + X m ω
~~~

The first field certifies an ordinary real-valued integral at every fixed
natural horizon. The second field preserves the time shift created by
splitting a one-sided cocycle product. In mathematical notation,

\[
X_{m+k}(\omega)
\le
X_k(T^m\omega)+X_m(\omega).
\]

The later block is evaluated at the shifted base point. Erasing that shift
would change the process being described.

The structure is a proposition. It packages evidence and contributes no new
runtime data. Its name ends in **Candidate** because it records a finite-time
shape, not a completed ergodic theorem.

### What the candidate omits

The generic package deliberately does not store:

- measurability or measure preservation of \(T\);
- probability normalization of \(\mu\);
- ergodicity of \(T\);
- independence or identical distribution;
- nonnegativity of \(X_k\);
- a two-parameter stationary process law;
- a pointwise or almost-everywhere limit;
- an integrable-norm (\(L^1\)) convergence conclusion;
- equality between an integrated rate and an integral of a limit; or
- any Lyapunov or invariant-splitting structure.

For the actual cocycle, measurability and preservation already live in \(C\),
and log-positive nonnegativity lives in the preceding observable layer. A
future Kingman theorem should take the additional assumptions it truly needs
rather than forcing this small reusable predicate to guess them.

### Declaration 2: the cocycle supplies the candidate

The constructor theorem is

~~~lean
theorem HasIntegrableGeneratorLogPlus.isIntegrableSubadditiveProcessCandidate
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) :
    IsIntegrableSubadditiveProcessCandidate C.base μ
      C.logPlusNormObservable
~~~

Its two fields come directly from checked predecessor theorems:

- <code>hC.integrable_logPlusNormObservable</code> supplies integrability at
  every horizon; and
- <code>C.logPlusNormObservable_add_le</code> supplies the shifted pointwise
  inequality.

The proof does not introduce probability or ergodicity. It simply packages
facts already established for \(P_k\).

## Camp four: four deterministic rate facts

The next four theorems sharpen the deterministic Fekete rate from RMT-16.
Every one requires <code>hC</code>. None requires probability or ergodicity.
The official
[Mathlib subadditive-sequence interface](#ref-prob-erg-deep-subadditive) supplies the
underlying positive-index infimum and comparison theorem.

### Declaration 3: the rate is nonnegative

Every normalized integrated value satisfies

\[
A_k=\frac{I_k}{k}\ge0.
\]

RMT-16 proved \(A_k\to\gamma_\mu^+(C)\). RMT-17 passes nonnegativity through
that limit:

\[
0\le\gamma_\mu^+(C).
\]

The Lean proof uses <code>ge_of_tendsto</code> with the eventually true fact
that every term is nonnegative. This is a topological limit argument, not a
probability argument.

Positive clipping is crucial. A contraction-sensitive logarithmic rate can
be negative, but \(P_k=\log^+\lVert C(k,\omega)\rVert\) cannot. The theorem is
therefore evidence about the clipped integrated rate only.

### Declaration 4: expose the exact positive-time infimum

RMT-17 unfolds the inherited definition as

\[
\gamma_\mu^+(C)
{} =
\inf\left\{A_k:k\ge1\right\}.
\]

The exact Lean right-hand side is

~~~lean
sInf (C.normalizedIntegratedLogPlusNorm '' Ici 1)
~~~

Here <code>Ici 1</code> is the set of natural horizons at least one, and the
image maps those horizons through the normalized sequence. Time zero is not
part of this set.

This theorem matters because \(A_0=0\) by totalized division. If the infimum
were taken over the full range, every nonnegative example would have infimum
zero even when every positive-time ratio were strictly positive. The
positive-index restriction carries real mathematical content.

### Declaration 5: every positive horizon is an upper bound

For every natural \(k\ne0\),

\[
\gamma_\mu^+(C)\le A_k.
\]

This follows from the Fekete infimum, but the Lean proof uses Mathlib's
<code>Subadditive.lim_le_div</code> theorem together with the lower bound on
the normalized range. The explicit premise \(k\ne0\) prevents accidental
division-by-zero interpretation.

The theorem does not say the ratios decrease. It says the limiting infimum is
below each positive ratio. A sequence can move down, then up, and still obey
that comparison. The alternating scalar example below has exactly this
shape.

### Declaration 6: the one-step moment is an upper bound

Specializing declaration 5 to \(k=1\) gives

\[
\gamma_\mu^+(C)
\le
A_1
{} =
I_1.
\]

The equality uses division by one. On a probability base, \(I_1\) may be
called \(\mathbb E[P_1]\), provided <code>hC</code> is present. On an arbitrary
raw measure it remains an integrated value.

The upper bound can be strict. Later products can cancel one-step expansion,
and positive clipping can erase the contracting half of an alternating
cycle. The two-point flip will produce
\(\gamma_\mu^+(C)=0\) while \(I_1=\log2/2\).

### What these rate facts still do not use

| Assumption | Used by declarations 3 through 6? | Reason |
|---|---|---|
| One-step log-positive integrability | Yes | It underwrites scalar subadditivity and the inherited Fekete rate |
| Measure preservation | Already inside the cocycle | It was used upstream to remove shifts inside integrals |
| Probability normalization | No | Fekete acts on a real sequence for any raw measure |
| Ergodicity | No | The outcome variable was integrated away before the limit |
| Independence | No | Subadditivity and preserved integrals suffice |
| Mixing | No | No correlation limit enters the proof |

This ledger prevents a common historical overread. A theorem may sit in a
random-cocycle namespace and be motivated by random products while remaining
entirely deterministic after integration.

## Four models that separate the assumptions

Small exact models are the quickest defense against false implication arrows.
The first three examples use finite spaces, where every set is measurable,
every finite-valued function is integrable against a finite measure, and the
invariant subsets can be listed by hand. The fourth uses a continuum to show
that probability normalization does not control integrable tails.

### Model A: probability without ergodicity

Let

\[
\Omega=\{0,1\},
\qquad
\mu(\{0\})=\mu(\{1\})=\frac12,
\qquad
T=\operatorname{id}.
\]

The measure has total mass one, and the identity preserves it. Every subset is
strictly invariant. In particular, \(A=\{0\}\) satisfies

\[
T^{-1}(A)=A,
\qquad
\mu(A)=\frac12.
\]

If the base were ergodic, declaration 9 would force this mass to be zero or
one. It is neither. Thus probability and measure preservation do not imply
ergodicity.

An invariant real observable makes the same failure visible. Define
\(g(0)=0\) and \(g(1)=1\). Since \(T\) is the identity, \(g\circ T=g\), but
\(g\) is not almost everywhere constant. The missing premise is ergodicity,
not measurability or integrability.

### Model B: ergodicity without probability

Let

\[
\Omega=\{\ast\},
\qquad
\mu(\{\ast\})=2,
\qquad
T=\operatorname{id}.
\]

The identity preserves every measure. The only subsets are empty and full,
so every measurable invariant set is null or conull. The base is ergodic.

It is not a probability base because \(\mu(\Omega)=2\). Declaration 10 still
applies: every real observable is constant. Declaration 9 does not apply, and
should not. Its full invariant event has mass two, so the numerical conclusion
“zero or one” would be false.

This model explains why <code>Ergodic T μ</code> cannot secretly include
<code>IsProbabilityMeasure μ</code> in Mathlib's design.

### Model C: probability and ergodicity without mixing

Use the uniform two-point probability measure again and define the flip

\[
T(0)=1,
\qquad
T(1)=0.
\]

The flip preserves the measure. A strictly invariant subset must contain both
points or neither, so the base is ergodic.

Now take \(A=\{0\}\). Its pullbacks alternate:

\[
T^{-n}(A)
{} =
\begin{cases}
A,& n\text{ even},\\
\{1\},& n\text{ odd}.
\end{cases}
\]

Consequently,

\[
\mu\bigl(A\cap T^{-n}(A)\bigr)
{} =
\begin{cases}
\tfrac12,& n\text{ even},\\
0,& n\text{ odd}.
\end{cases}
\]

Mixing would require this quantity to converge to
\(\mu(A)\mu(A)=1/4\). It alternates forever. The system is ergodic and not
mixing.

This is not a contradiction. Ergodicity controls time-invariant information.
Mixing controls asymptotic decorrelation, which is stronger and absent from
RMT-17.

### Model D: probability without integrability

Let \(\Omega=(0,1]\) with Lebesgue probability measure and let the base map be
the identity. Define a one-dimensional measurable generator by

\[
G(x)=\begin{bmatrix}\exp(1/x)\end{bmatrix}.
\]

Every matrix entry is finite at every base point. The one-step positive-log
envelope is

\[
P_1(x)=\frac1x.
\]

But

\[
\int_0^1\frac{dx}{x}=+\infty.
\]

Thus the probability typeclass can hold while
<code>HasIntegrableGeneratorLogPlus</code> fails. The base is also not
ergodic because the identity leaves every measurable set invariant, but that
is not responsible for the divergent moment.

Conversely, put any finite-valued generator on the mass-two, two-point
identity space. The one-step envelope is integrable automatically, while the
measure is not probabilistic and the identity is not ergodic. Integrability
does not force either dynamical property.

## The alternating scalar cocycle

The most informative calibration combines Model C's ergodic flip with a
one-dimensional cocycle. Set

\[
G(0)=\begin{bmatrix}2\end{bmatrix},
\qquad
G(1)=\begin{bmatrix}\tfrac12\end{bmatrix}.
\]

Because the base alternates, adjacent generators cancel. Starting at zero,
the products are

\[
C(1,0)=\begin{bmatrix}2\end{bmatrix},
\qquad
C(2,0)=\begin{bmatrix}1\end{bmatrix},
\qquad
C(3,0)=\begin{bmatrix}2\end{bmatrix}.
\]

Starting at one, they are

\[
C(1,1)=\begin{bmatrix}\tfrac12\end{bmatrix},
\qquad
C(2,1)=\begin{bmatrix}1\end{bmatrix},
\qquad
C(3,1)=\begin{bmatrix}\tfrac12\end{bmatrix}.
\]

Every even-horizon product is one from either starting point. At odd horizons,
the product is two from zero and one half from one. Positive logarithmic
clipping therefore gives

\[
P_{2r}(0)=P_{2r}(1)=0,
\]

and

\[
P_{2r+1}(0)=\log2,
\qquad
P_{2r+1}(1)=0.
\]

All functions are integrable because the probability space is finite. Let

\[
E_k=\mathbb E_\mu[P_k],
\qquad
Q_k=\frac{E_k}{k}
\quad(k\ge1).
\]

Then

\[
E_{2r}=0,
\qquad
E_{2r+1}=\frac{\log2}{2},
\]

so the first three normalized values are

\[
Q_1=\frac{\log2}{2},
\qquad
Q_2=0,
\qquad
Q_3=\frac{\log2}{6}.
\]

The sequence drops and then rises. Fekete convergence does not require
monotone normalized ratios.

Every even positive horizon contributes zero to the positive-index infimum,
while all normalized values are nonnegative. Hence

\[
\gamma_\mu^+(C)=0.
\]

The one-step upper bound is strict:

\[
\gamma_\mu^+(C)
{} =
0
\lt
\frac{\log2}{2}
{} =
E_1.
\]

This one model has probability normalization, ergodicity, finite-horizon
integrability, and the subadditive-process candidate. It illustrates every
new rate comparison and expectation bridge. Yet the RMT-17 Lean module proves
no convergence of \(P_k(\omega)/k\) for this model or for general cocycles.
One may perform additional arithmetic outside the module, but that cannot be
misreported as a theorem exported by RMT-17.

The model is also not mixing, as Model C showed. Thus even the full RMT-17
assumption palette does not silently contain decay of correlations.

## The complete ten-declaration map

The public interface has ten source-level declarations when the process
structure is counted once. Its two field projections are generated from that
structure and are taught under declaration 1.

| No. | Lean declaration | Explicit assumptions | Exact conclusion |
|---:|---|---|---|
| 1 | <code>IsIntegrableSubadditiveProcessCandidate</code> | A measurable base type, map, measure, and real process | Stores all-horizon integrability and the shifted subadditive inequality |
| 2 | <code>HasIntegrableGeneratorLogPlus.isIntegrableSubadditiveProcessCandidate</code> | <code>hC</code> | Packages the cocycle's log-positive process as the candidate |
| 3 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_nonneg</code> | <code>hC</code> | \(0\le\gamma_\mu^+(C)\) |
| 4 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_eq_sInf</code> | <code>hC</code> | The rate is the infimum of normalized values over \(k\ge1\) |
| 5 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_le_normalized</code> | <code>hC</code> and \(k\ne0\) | The rate is at most the \(k\)-horizon normalized integral |
| 6 | <code>HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_le_oneStep</code> | <code>hC</code> | The rate is at most the one-step integrated envelope |
| 7 | <code>finiteHorizonLogPlusExpectation</code> | Probability and <code>hC</code> | Names the finite-horizon integral as an expectation |
| 8 | <code>finiteHorizonLogPlusExpectation_eq_integratedLogPlusNorm</code> | Probability and <code>hC</code> | Proves the expectation name and raw integral are definitionally equal |
| 9 | <code>ergodicBase_invariantEvent_prob_eq_zero_or_one</code> | Probability, ergodicity, event measurability, and strict invariance | The event has probability zero or one |
| 10 | <code>ergodicBase_ae_eq_const_of_ae_invariant</code> | Ergodicity, almost-everywhere strong measurability, and almost-everywhere invariance | The real observable is almost everywhere constant |

The table has no row labeled “samplewise convergence.” That is not an omitted
documentation detail. It is an absent theorem.

## Assumption ledger by theorem family

| Property | Process candidate | Rate facts | Expectation bridge | Event bridge | Function bridge |
|---|---:|---:|---:|---:|---:|
| Measurable base space | Yes | Yes, through the cocycle | Yes | Yes | Yes |
| Base measure preservation | Not stored generically | Already in the cocycle | Already in the cocycle | Included in ergodicity and the cocycle | Included in ergodicity and the cocycle |
| Probability normalization | No | No | Yes | Yes | No |
| Base ergodicity | No | No | No | Yes | Yes |
| One-step log-positive integrability | Used for the cocycle constructor | Yes | Yes | No | No |
| Event measurability | Not applicable | Not applicable | Not applicable | Yes | Not applicable |
| Exact event invariance | Not applicable | Not applicable | Not applicable | Yes | Not applicable |
| Almost-everywhere strong measurability | Implied for each integrable process slice | Not a separate premise | Inherited from integrability | Not applicable | Yes |
| Almost-everywhere function invariance | Not applicable | Not applicable | Not applicable | Not applicable | Yes |
| Independence | No | No | No | No | No |
| Mixing | No | No | No | No | No |

“Not stored generically” is different from “false.” The generic candidate can
be paired later with a map that is measurable and measure preserving. RMT-17
simply keeps that dynamical evidence in its natural owner rather than
duplicating it inside the process predicate.

## The honest pre-Kingman boundary

### What Kingman's theorem changes

Kingman's subadditive ergodic theorem studies subadditive stochastic processes
and supplies sample-dependent asymptotic conclusions under additional
hypotheses
([Kingman, 1968](#ref-prob-erg-deep-kingman)). In a one-parameter dynamical
formulation, the characteristic finite-time inequality resembles

\[
X_{m+k}(\omega)
\le
X_k(T^m\omega)+X_m(\omega).
\]

That resemblance motivates the RMT-17 candidate. It is not itself a proof of
the theorem. A formal application still needs an exact Lean theorem with an
exact hypothesis list, codomain, measurability convention, and conclusion.

The distinction between deterministic Fekete and Kingman is an
order-of-operations distinction:

\[
\text{RMT-16 and RMT-17:}
\quad
P_k(\omega)
\longrightarrow
\int P_k\,d\mu
\longrightarrow
\lim_k\frac1k\int P_k\,d\mu,
\]

whereas a samplewise theorem would study

\[
\text{future route:}
\quad
P_k(\omega)
\longrightarrow
\lim_k\frac{P_k(\omega)}{k}
\quad\text{for almost every }\omega.
\]

The first limit is a limit of real numbers. The second is a limit of
outcome-dependent values. Neither statement logically substitutes for the
other.

### What the pinned library supplies

The pinned Mathlib revision supplies:

- probability-measure typeclasses;
- measure-preserving, pre-ergodic, and ergodic structures;
- zero-one results for invariant events;
- almost-everywhere constancy for invariant functions; and
- deterministic subadditive-sequence Fekete machinery.

The local source audit found no Kingman or subadditive ergodic theorem matching
this process. RMT-17 therefore exposes the native pieces that exist and stops.
It does not add an axiom, cite a paper as if it were Lean code, or use an
unverified theorem name.

### Obligations for a future formal theorem

Before crossing the bridge, the project must settle at least these choices:

1. **Process convention.** Decide whether the theorem consumes a one-parameter
   family \(X_k\) with a base shift or a two-parameter process \(X_{m,n}\).
2. **Measure assumptions.** State probability or finite-measure normalization
   exactly rather than hiding it behind expectation notation.
3. **Transformation assumptions.** Supply measurability and measure
   preservation, and decide whether ergodicity is required for existence or
   only for constancy of the limit.
4. **Integrability assumptions.** Match the theorem's positive- and
   negative-part hypotheses. The actual \(P_k\) is nonnegative and integrable,
   but the generic candidate does not store nonnegativity.
5. **Measurability convention.** Decide whether ordinary, almost-everywhere,
   or strong measurability is the theorem's interface.
6. **Limit codomain.** Decide whether the limit is real or extended real and
   how infinite values are ruled out.
7. **Invariant limit.** Prove the limiting observable is invariant in the
   sense required by the ergodic constancy bridge.
8. **Integrated identification.** Do not equate the integral of a limit with
   the limit of integrals without the exact convergence or uniform
   integrability result that licenses it.
9. **Cocycle interpretation.** Keep positive clipping explicit. Even a
   samplewise limit of \(P_k/k\) would still not recover negative contraction.
10. **Library integration.** Prove the theorem in Lean against the pinned interfaces
    before any Knowledge Base page reports it as formalized.

This list is not bureaucratic overhead. Each item blocks a familiar but invalid
shortcut.

### Why ergodic constancy cannot manufacture the limit

Declaration 10 has the logical form

\[
\text{measurable }g
\quad+\quad
g\circ T=g\text{ almost everywhere}
\quad\Longrightarrow\quad
g\text{ is almost everywhere constant}.
\]

It begins with a function \(g\). A future samplewise limit would first need to
be constructed, proved measurable, and proved invariant. Ergodicity can then
remove its residual dependence on \(\omega\). It cannot conjure \(g\) from a
sequence whose convergence has not been proved.

The same order appears in classical ergodic theory: existence, invariance, and
ergodic constancy are distinct proof stages. RMT-17 formalizes the last-stage
rigidity interface, not the first-stage existence theorem.

### Why the deterministic rate cannot identify a samplewise exponent

The deterministic rate is

\[
\gamma_\mu^+(C)
{} =
\lim_{k\to\infty}\frac1k\int P_k\,d\mu.
\]

Suppose a future theorem produces an almost-everywhere limit
\(L(\omega)=\lim_k P_k(\omega)/k\). The equality

\[
\int L\,d\mu=\gamma_\mu^+(C)
\]

would still need justification. Pointwise convergence alone does not permit
interchanging limit and integral. A suitable theorem may package the needed
integral conclusion, or a later proof may establish stronger convergence.
RMT-17 does neither.

Random-matrix-product history makes this destination important. Furstenberg
and Kesten study asymptotic products under probabilistic hypotheses
([Furstenberg and Kesten, 1960](#ref-prob-erg-deep-furstenberg-kesten)), while
Oseledets develops characteristic exponents and invariant splittings
([Oseledets, 1968](#ref-prob-erg-deep-oseledets)). Those results motivate the
roadmap but cannot be inherited from a finite-time candidate by vocabulary.

## Common wrong turns

### Treating probability as randomness plus independence

<code>IsProbabilityMeasure μ</code> says only that total mass is one. The
two-point identity and two-point flip share the same probability measure and
have very different dynamics. No independence relation appears in the class.

### Treating measure preservation as ergodicity

The identity preserves every measure. On a nontrivial probability space it
leaves every event invariant, so it is typically the opposite of ergodic.

### Treating ergodicity as mixing

The two-point flip is ergodic and periodic. Its event correlations alternate
instead of converging. Mixing is not a synonym for invariant-set rigidity.

### Treating ergodicity as a moment bound

Ergodicity says which invariant events are trivial. It does not bound an
arbitrary generator near a singularity or in a heavy tail. Keep
<code>hC</code> explicit.

### Calling every raw integral an expectation

An expectation is an integral against a probability measure. RMT-17 exposes
that name only under <code>[IsProbabilityMeasure μ]</code>, and retains
<code>hC</code> so the finite moment is genuine.

### Thinking the expectation equality performs normalization

The equality theorem is <code>rfl</code>. It does not divide by
\(\mu(\Omega)\). The measure is already normalized by the typeclass premise.

### Reading the process candidate as a theorem-ready black box

The candidate stores two finite-time facts. It omits preservation,
probability, ergodicity, nonnegativity, and every asymptotic conclusion. Its
name says “candidate” for a reason.

### Removing the base shift from subadditivity

The correct inequality contains \(X_k(T^m\omega)\). Preservation can remove
the shift after integration, but no pointwise theorem identifies it with
\(X_k(\omega)\).

### Including time zero in the rate infimum

The normalized definition is total and has \(A_0=0\). The rate infimum uses
only \(k\ge1\). Including zero can change a positive answer to zero.

### Saying normalized ratios decrease

The alternating scalar cocycle has \(Q_1\gt Q_2\lt Q_3\). The rate remains
below every positive ratio, but consecutive ratios need not be ordered.

### Using event rigidity to prove function constancy without measurability

Threshold events must be measurable for the invariant-set argument to work.
RMT-17 asks for almost-everywhere strong measurability of the real observable.

### Turning almost-everywhere constancy into pointwise constancy

Null sets remain invisible. The theorem returns an almost-everywhere equality,
not a universal equality.

### Claiming Kingman from the shape of the inequality

A familiar hypothesis pattern is not a checked theorem application. The
pinned library has no matching Kingman declaration, and RMT-17 states no
samplewise conclusion.

### Calling the clipped rate a Lyapunov exponent

Positive clipping maps contraction and exact collapse to zero. A full
Lyapunov theory needs contraction-sensitive logarithms and stronger
asymptotic structure.

## Exercises from base camp to theorem design

### Base camp

1. State the fields of <code>IsProbabilityMeasure μ</code> and
   <code>Ergodic T μ</code> in words.
2. Explain why a conull event need not have mass one on a raw measure.
3. List the four premises of the RMT-17 event zero-one theorem.
4. List the three premises of the invariant-function theorem after the
   cocycle is fixed.
5. Explain why no probability premise occurs in declaration 10.
6. Explain why <code>_hC</code> can be computationally unused but
   mathematically necessary in declaration 7.

### Mid-mountain

7. Enumerate the invariant subsets of the two-point identity and flip.
8. Use \(A=\{0\}\) to prove the two-point flip is not mixing.
9. On the one-point mass-two space, evaluate the masses of the empty and full
   invariant events.
10. Verify that \(1/x\) is finite pointwise but not integrable on \((0,1]\).
11. Explain why the process candidate does not need to duplicate measure
    preservation already stored by the cocycle.
12. Derive the one-step rate bound from the positive-horizon comparison.
13. Explain why the infimum theorem excludes zero even though the lower-bound
    theorem may use the full normalized range.
14. Give a second numerical subadditive sequence whose normalized ratios are
    not monotone.

### Summit

15. Compute every product in the alternating scalar cocycle through horizon
    four from both starting points.
16. Derive the formulas for \(E_{2r}\), \(E_{2r+1}\), and the rate.
17. Identify which RMT-17 theorem families survive if probability is removed.
18. Identify which theorem families survive if ergodicity is removed.
19. Design a future theorem signature that consumes the candidate, base
    preservation, and probability without assuming ergodicity. State what its
    limiting conclusion may still depend on.
20. Add ergodicity to that hypothetical signature and explain which separate
    proof would make the limit constant.
21. State a condition that could justify interchanging a samplewise limit and
    expectation, without claiming RMT-17 proves it.
22. Explain why a limit of log-positive norms would still miss negative
    contraction rates.
23. Compare the roles of Kingman, Furstenberg-Kesten, and Oseledets without
    collapsing their conclusions.
24. Audit the ten-declaration table against the Lean source and identify every
    assumption that appears in a signature but not a computational body.

## Reproduce the checked slice

From the repository root, load the pinned Lean toolchain and compile the leaf
module with warnings treated as errors:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/ProbabilityErgodicBase.lean
~~~

Build the named module and its dependency graph:

~~~sh
lake build NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase
~~~

Return to the repository root and validate the complete teaching surface:

~~~sh
cd ..
make site-check
~~~

The repository-wide gate is <code>make check</code>. Automated success does not
publish this draft. Human mathematical, source, accessibility, and editorial
reviews remain separate publication gates.

## What is established and what is not

| Topic | RMT-17 status |
|---|---|
| Generic all-horizon integrable subadditive-process candidate | Defined |
| Cocycle log-positive process satisfies the candidate | Proved under <code>hC</code> |
| Deterministic integrated rate nonnegative | Proved under <code>hC</code> |
| Rate equals the positive-index infimum | Proved under <code>hC</code> |
| Rate below every positive normalized horizon | Proved under <code>hC</code> |
| Rate below the one-step integrated envelope | Proved under <code>hC</code> |
| Finite-horizon expectation name | Defined under probability and <code>hC</code> |
| Expectation equals the raw integrated value | Proved definitionally |
| Measurable strictly invariant event has probability zero or one | Proved under probability and ergodicity |
| Almost-everywhere invariant measurable real observable is almost everywhere constant | Proved under ergodicity |
| Probability implies ergodicity | False, refuted by the two-point identity |
| Ergodicity implies probability | False, refuted by the one-point mass-two base |
| Ergodicity implies mixing | False, refuted by the two-point flip |
| Probability implies integrability | False, refuted by the \(1/x\) envelope |
| Independence or identical distribution | Not assumed or proved |
| Mixing or correlation decay | Not assumed or proved |
| Samplewise normalized limit | Not proved |
| Almost-everywhere, probability, distributional, or \(L^1\) convergence | Not proved |
| Limit-expectation interchange | Not proved |
| Kingman's subadditive ergodic theorem | Not present in the pinned library and not invoked |
| Furstenberg-Kesten random-product theorem | Not invoked |
| Lyapunov exponent or Oseledets splitting | Not defined or proved |

The exact achievement is an assumption-safe interface. Probability fixes the
scale of the measure. Ergodicity controls invariant information. Integrability
controls finite moments. The deterministic Fekete facts remain deterministic,
and the samplewise summit remains visibly ahead.

## Where to continue

The
{{< refterm "ergodic-probability-base" "ergodic probability base" >}}
entry is the compact definition, finite-example set, and caveat ledger for this
chapter.

[Integrated Log-Positive Cocycle Growth and Its Deterministic Fekete Limit]({{< relref "/knowledge-base/deep-dives/integrated-log-positive-cocycle-growth-and-fekete-limit" >}})
is the immediate predecessor. It constructs the raw integrated sequence and
proves deterministic Fekete convergence.

[Finite-Horizon Log-Positive Cocycle Integrability]({{< relref "/knowledge-base/deep-dives/finite-horizon-log-positive-cocycle-integrability" >}})
develops the one-step hypothesis and finite orbit majorant consumed by the
process-candidate constructor.

[Probability and Ergodic Base Interfaces for Matrix Cocycles]({{< relref "/development-notebook/2026/07/probability-and-ergodic-base-interfaces-for-matrix-cocycles" >}})
is the proof-to-prose Research Note paired directly with the Lean module.

The next asymptotic milestone must either formalize an exact subadditive
ergodic theorem or choose another dependency-ordered roadmap item. It must not
rename the RMT-17 candidate as Kingman convergence.

## References

<a id="ref-prob-erg-deep-probability"></a>**Mathlib contributors.**
[Probability-measure typeclasses](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Typeclasses/Probability.html),
Mathlib 4 documentation. This official source defines
<code>IsProbabilityMeasure μ</code> by \(\mu(\Omega)=1\), derives the
zero-or-probability and finite-measure instances, and records nonzeroness.

<a id="ref-prob-erg-deep-ergodic"></a>**Mathlib contributors.**
[Ergodic maps and measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/Ergodic.html),
Mathlib 4 documentation. This official source defines <code>PreErgodic</code>
and <code>Ergodic</code>, gives null-or-conull invariant-set results, and proves
the probability zero-one specialization used by RMT-17.

<a id="ref-prob-erg-deep-function"></a>**Mathlib contributors.**
[Functions invariant under an ergodic map](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/Function.html),
Mathlib 4 documentation. This official source proves that an
almost-everywhere strongly measurable, almost-everywhere invariant function
into a suitable metrizable space is almost everywhere constant.

<a id="ref-prob-erg-deep-subadditive"></a>**Mathlib contributors.**
[Subadditive and superadditive sequences](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Subadditive.html),
Mathlib 4 documentation. This official source defines the positive-index
Fekete limit, proves convergence for lower-bounded normalized sequences, and
supplies the horizon-wise upper comparison used by RMT-17.

<a id="ref-prob-erg-deep-preserving"></a>**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation. This official source defines the preservation package
already stored by the cocycle and supplies natural-iterate preservation used
upstream.

<a id="ref-prob-erg-deep-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source establishes a subadditive ergodic theorem under additional
hypotheses. RMT-17 packages finite-time inputs but does not invoke the theorem.

<a id="ref-prob-erg-deep-furstenberg-kesten"></a>**Harry Furstenberg and Harry Kesten.**
[Products of Random Matrices](https://doi.org/10.1214/aoms/1177705909),
*The Annals of Mathematical Statistics* 31(2), 457-469, 1960. This primary
source studies asymptotic growth of random matrix products. RMT-17 proves none
of its samplewise conclusions.

<a id="ref-prob-erg-deep-oseledets"></a>**V. I. Oseledets.**
[A multiplicative ergodic theorem. Characteristic Ljapunov exponents of dynamical systems](https://www.mathnet.ru/eng/mmo214),
*Transactions of the Moscow Mathematical Society* 19, 197-231, 1968. This
primary source is a future exponent and invariant-splitting destination. The
present positive-log interface does not provide its hypotheses or conclusions.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
