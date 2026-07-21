---
title: "Measurable Finite Random-Matrix Products and Proof-Carrying Pushforward Laws"
slug: "measurable-finite-random-matrix-products-and-pushforward-laws"
date: 2026-07-21
summary: "A textbook ascent from semiring-valued pointwise matrix products through exact finite-prefix measurability to raw pushforward laws, mass-one proofs, and bundled probability measures."
lead: "An ordered product of random matrices is not yet a probability law. First it is a function of one outcome, then it needs a finite-prefix measurability proof, and only then can its source measure be transported without hiding Mathlib's zero-measure fallback."
draft: true
pro_reviewed: false
level: "Finite random dynamics, measurable maps, and law-level interfaces"
reading_time: "70 to 95 minutes"
prerequisites: "Finite matrices, chronological forward products, measurable spaces, pushforward measures, and the distinction between a raw measure and a bundled probability measure"
lean_module: "NonlinearDynamics.Random.MatrixProducts.MeasurableFiniteProducts"
toc: true
og_image: "measurable-finite-random-matrix-products-and-pushforward-laws-card.png"
og_image_alt: "A finite prefix of outcome-dependent matrix factors becomes a pointwise ordered product, receives an exact measurability certificate, becomes a raw pushforward law, and is finally packaged with a mass-one proof."
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

Consider a time-indexed family of random square matrices

\[
A_0,A_1,A_2,\ldots,
\qquad
A_j:\Omega\to M_\iota(\mathbb C).
\]

At one outcome \(\omega\), the first \(k\) factors become ordinary matrices and
form the chronological product

\[
\Pi_k(\omega)
{} =
A_{k-1}(\omega)\cdots A_1(\omega)A_0(\omega).
\]

This expression is a matrix-valued function on the sample space. It is not yet
a measure, and the notation does not prove that it is measurable. To reach a
law, we need a precise chain:

1. define the sample product pointwise;
2. prove that only the factors in its finite prefix need to be measurable;
3. transport a chosen source measure through the certified map;
4. prove that this raw law has mass one when the source does; and
5. optionally bundle the raw law and its mass-one evidence into a probability
   measure type.

The module
<code>NonlinearDynamics.Random.MatrixProducts.MeasurableFiniteProducts</code>
checks that complete chain at every finite horizon. It exposes one definition
and four theorems in a semiring-valued sample-algebra layer, then two
definitions and five theorems in a complex measurable-law layer. There are
twelve public declarations in total.

The result is deliberately finite. It adds no independence, stationarity,
base transformation, cocycle structure, norm estimate, logarithm, or
long-time limit. That narrowness is the point. Later random dynamics should
build on a sample map and law whose finite meaning is already exact.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [Four layers in one picture](#four-layers-in-one-picture) | Separate factors, samples, laws, and bundled probability laws |
| Algebra route | [Evaluate first, multiply second](#camp-one-evaluate-first-multiply-second) | Derive zero, successor, one-step, and split identities |
| Measure route | [Measurability uses exactly one prefix](#camp-three-measurability-uses-exactly-one-prefix) | Understand the finite induction and its hypotheses |
| Lean route | [The complete declaration map](#the-complete-declaration-map) | Audit all twelve names and assumptions |
| Boundary route | [Empty dimension is not an exception](#camp-four-empty-dimension-is-not-an-exception) | See why no positive-dimension hypothesis appears |
| Law route | [A law is a certified pushforward](#camp-five-a-law-is-a-certified-pushforward) | Keep Mathlib's fallback from becoming an assumption |
| Probability route | [Raw mass-one theorem versus bundled law](#camp-seven-raw-mass-one-theorem-versus-bundled-law) | Distinguish a measure, evidence about it, and a subtype |
| Summit route | [What has and has not been proved](#summit-what-has-and-has-not-been-proved) | Preserve every explicit nonclaim |

### Learning objectives

By the summit, you should be able to:

1. distinguish a time-indexed factor family from one pointwise product;
2. expand the product at horizons zero, one, two, and three;
3. explain why the newest factor is written on the left;
4. derive the shifted finite-block split sample by sample;
5. identify the five declarations that require only a semiring;
6. state the exact prefix measurability hypothesis
   \(\forall j\lt k\);
7. prove finite-product measurability by induction;
8. explain why the measurable layer is scoped to complex matrices;
9. explain why neither layer needs a nonempty coordinate type;
10. distinguish ordinary measurability from Mathlib's
    almost-everywhere-measurable fallback for <code>Measure.map</code>;
11. explain what evidence the <code>RandomMatrix.law</code> interface requires;
12. compute the zero-step and one-step laws;
13. state why the zero-step Dirac theorem needs a probability source;
14. distinguish a raw measure with a mass-one theorem from a bundled
    <code>ProbabilityMeasure</code>;
15. explain why coercing the wrapper changes no probabilities;
16. map every claim to one of the twelve public declarations; and
17. list the independence, cocycle, growth, and asymptotic conclusions that
    remain absent.

## Four layers in one picture

{{< reference-figure
  src="finite-random-product-law-layers.svg"
  alt="A finite prefix of outcome-dependent factors enters a pointwise chronological product. Exact prefix measurability evidence certifies that product map. A chosen source measure is transported through it to a raw law. A separate mass-one proof then permits a bundled probability-law interface."
  caption="**Finding:** the construction climbs through four distinct interfaces. Pointwise multiplication is algebra, prefix certification is measurability, transport produces a raw measure, and mass-one evidence permits a bundled probability measure. The diagram does not assert factor independence, stationarity, a cocycle, or any long-time growth theorem."
>}}

The four boxes are different mathematical types:

| Layer | Mathematical object | Lean-facing shape | What it records |
|---|---|---|---|
| Factor family | A map at each natural time | <code>ℕ → RandomMatrix Ω ι ι ℂ</code> | How one outcome selects every finite-time factor |
| Sample product | One matrix-valued map | <code>RandomMatrix Ω ι ι ℂ</code> | The ordered product at a chosen horizon |
| Raw law | A measure on matrix space | <code>Measure (Matrix ι ι ℂ)</code> | How source mass is distributed over product values |
| Bundled law | A raw law plus mass-one evidence | <code>ProbabilityMeasure (Matrix ι ι ℂ)</code> | The same law with probability status in its type |

A measurability proof is evidence connecting the first two rows to the third.
An <code>IsProbabilityMeasure</code> proof is evidence connecting the third row
to the fourth. Neither proof changes a sampled matrix or a probability value.

## Base camp: fix the chronological convention

Let \(P_B(k)\) be the deterministic forward product of a matrix sequence
\(B:\mathbb N\to M_\iota(\mathbb K)\):

\[
P_B(0)=I,
\qquad
P_B(k+1)=B_kP_B(k).
\]

The first cases are

\[
\begin{aligned}
P_B(0)&=I,\\
P_B(1)&=B_0,\\
P_B(2)&=B_1B_0,\\
P_B(3)&=B_2B_1B_0.
\end{aligned}
\]

The horizon counts factors. Horizon \(k\) reads indices
\(0,\ldots,k-1\). For column vectors, \(B_0\) acts first and therefore appears
furthest to the right. The
{{< refterm "forward-matrix-product" "forward matrix product" >}} entry and
[Ordered Finite Matrix Products and Operator-Norm Growth]({{< relref "/knowledge-base/deep-dives/ordered-finite-matrix-products-and-operator-norm-growth" >}})
develop this deterministic layer in full.

The present module does not invent a second order convention. It evaluates the
existing deterministic definition at each outcome.

## Camp one: evaluate first, multiply second

For a time-indexed family \(A_j:\Omega\to M_\iota(\mathbb K)\), define

\[
\Pi_k(\omega)
{} =
P_{j\mapsto A_j(\omega)}(k).
\]

Lean calls this map <code>sampleForwardProduct A k</code>:

~~~lean
def sampleForwardProduct
    (A : ℕ → RandomMatrix Ω ι ι 𝕜) (k : ℕ) :
    RandomMatrix Ω ι ι 𝕜 :=
  fun ω => forwardProduct (fun j => A j ω) k
~~~

This is a pointwise lift. First fix \(\omega\). Then \(j\mapsto A_j(\omega)\)
is an ordinary matrix sequence, so the deterministic product can consume it.
The result varies with \(\omega\), producing another matrix-valued map.

The entire section assumes:

- \(\iota\) is a finite index type;
- equality on \(\iota\) is decidable; and
- \(\mathbb K\) is a semiring.

Finiteness and decidable equality support the finite sums in matrix
multiplication. A semiring supplies the algebra used by matrices. There is no
sample-space measurable structure, source measure, topology, norm, order,
subtraction, division, or probability assumption in this layer.

That assumption ledger matters. The name <code>RandomMatrix</code> is an
abbreviation for a function into matrix space. It does not force probability
structure into every theorem that uses the name.

## Camp two: inherit the finite algebra pointwise

Because the definition delegates to <code>forwardProduct</code>, four
identities follow outcome by outcome.

### Zero horizon

\[
\Pi_0(\omega)=I.
\]

The empty product is the constant identity map. Lean publishes
<code>sampleForwardProduct_zero</code>, and the proof is reflexivity.

### Successor horizon

\[
\Pi_{k+1}(\omega)=A_k(\omega)\Pi_k(\omega).
\]

The newest factor is prepended on the left. This is
<code>sampleForwardProduct_succ</code>, also true by reflexivity.

### One step

\[
\Pi_1=A_0.
\]

This is equality of functions, not merely equality at one outcome.
<code>sampleForwardProduct_one</code> proves it by function extensionality and
simplification of the deterministic product.

### Split after a finite prefix

Let the early block contain \(m\) factors and the later block contain \(k\)
factors. Define the shifted family \(A^{(m)}_j=A_{m+j}\). Then

\[
\Pi_{m+k}(\omega)
{} =
\Pi^{(m)}_k(\omega)\Pi_m(\omega).
\]

The earlier block is on the right because it acts first. The shifted later
block is on the left because it acts second. The theorem
<code>sampleForwardProduct_add</code> uses function extensionality and then
applies <code>forwardProduct_add</code> at the chosen outcome.

No measurability is needed for any of these equations. They are finite algebra
of functions.

## A two-outcome expedition

Use one-by-one complex matrices, written \([z]\) for the matrix whose only
entry is \(z\). Let the outcome space be
\(\Omega=\{r,b\}\), and choose

\[
\begin{array}{c|cc}
&r&b\\ \hline
A_0&[2]&[-1]\\
A_1&[3]&[4]\\
A_2&[5]&[2]
\end{array}.
\]

At the red outcome,

\[
\begin{aligned}
\Pi_0(r)&=[1],\\
\Pi_1(r)&=[2],\\
\Pi_2(r)&=[3][2]=[6],\\
\Pi_3(r)&=[5][3][2]=[30].
\end{aligned}
\]

At the blue outcome,

\[
\begin{aligned}
\Pi_0(b)&=[1],\\
\Pi_1(b)&=[-1],\\
\Pi_2(b)&=[4][-1]=[-4],\\
\Pi_3(b)&=[2][4][-1]=[-8].
\end{aligned}
\]

Split the three-step red product after \(m=1\). The later shifted block is
built from \(A_1,A_2\):

\[
\Pi^{(1)}_2(r)\Pi_1(r)
{} =
([5][3])[2]
{} =
[30]
{} =
\Pi_3(r).
\]

This arithmetic checks the order and shift. The scalar-looking example should
not hide the real issue: for larger matrices, changing the order generally
changes the product.

Now place probability \(1/4\) on \(r\) and \(3/4\) on \(b\). At horizon two,
the law is

\[
\mathcal L(\Pi_2)
{} =
\frac14\delta_{[6]}+\frac34\delta_{[-4]}.
\]

No independence statement occurs. The three factor maps are all functions of
the same outcome and are visibly dependent.

## Camp three: measurability uses exactly one prefix

Equip \(\Omega\) with a measurable space. For a fixed horizon \(k\), the
checked hypothesis is

\[
h_A:\forall j\lt k,\quad A_j\text{ is measurable}.
\]

The quantifier ends at \(k\). The sample product \(\Pi_k\) never reads a factor
at time \(k\) or later, so future measurability is irrelevant.

The theorem is:

~~~lean
theorem measurable_sampleForwardProduct
    (A : ℕ → RandomMatrix Ω ι ι ℂ)
    (k : ℕ) (hA : ∀ j < k, Measurable (A j)) :
    Measurable (sampleForwardProduct A k)
~~~

The proof is induction on \(k\).

### Base case

At horizon zero, <code>sampleForwardProduct_zero</code> rewrites the map as
the constant identity. <code>RandomMatrix.measurable_const</code> proves that
this constant matrix-valued function is measurable. The prefix premise is
vacuous because no natural number is less than zero.

### Successor case

At horizon \(k+1\),

\[
\Pi_{k+1}(\omega)=A_k(\omega)\Pi_k(\omega).
\]

The premise supplies measurability of \(A_k\) from
\(k\lt k+1\). It also restricts to every earlier \(j\lt k\), allowing the
induction hypothesis to prove that \(\Pi_k\) is measurable.
<code>RandomMatrix.measurable_mul</code> then proves measurability of the
pointwise matrix product.

The proof architecture mirrors the mathematics exactly:

| Recursive product branch | Measurability ingredient |
|---|---|
| Empty identity product | Constant maps are measurable |
| New factor times previous product | Each factor is measurable, induction handles the prefix, multiplication is measurable |

### Why complex matrices?

The semiring sample layer is fully general because it uses only finite matrix
algebra. The measurable theorem is stated for \(\mathbb C\), where the project
already has a checked measurable-space interface for finite complex matrices
and measurable multiplication.

This scope is not a theorem that complex scalars are mathematically necessary.
It is an honest statement of the interface proved in this module. A future
generalization would need suitable measurable structures and measurable
multiplication for the chosen scalar type.

## Camp four: empty dimension is not an exception

No <code>Nonempty ι</code> assumption appears. If \(\iota\) is empty, a matrix
\(\iota\to\iota\to\mathbb C\) has no entries and therefore exactly one value.
That unique matrix is the identity, and multiplying it by itself returns it.

The sample algebra still works:

\[
\Pi_k(\omega)=I
\]

for every \(k\) and every \(\omega\). The map is constant and measurable.
Under a probability source, its law is the point mass at the unique matrix.

This boundary contrasts with the deterministic maximum-row-sum norm layer.
There, positive dimension is used to normalize the identity matrix to norm
one. The present module performs no norm calculation. Finite matrix algebra,
measurability, and pushforward transport remain valid in empty dimension.

Empty dimension is therefore supported by design, not repaired by a special
fallback.

## Camp five: a law is a certified pushforward

Let \(\mu\) be any measure on \(\Omega\). Given the exact prefix proof \(h_A\),
the module defines

\[
\operatorname{Law}_{\mu,A,k,h_A}
{} =
(\Pi_k)_*\mu.
\]

In Lean:

~~~lean
noncomputable def forwardProductLaw
    (μ : Measure Ω)
    (A : ℕ → RandomMatrix Ω ι ι ℂ)
    (k : ℕ) (hA : ∀ j < k, Measurable (A j)) :
    Measure (Matrix ι ι ℂ) :=
  RandomMatrix.law (sampleForwardProduct A k)
    (measurable_sampleForwardProduct A k hA) μ
~~~

The source measure is explicit. The factor family alone cannot determine a
law because different measures on the same outcome space can assign different
weights to the same product values.

The measurability proof is also explicit. It certifies the map before the law
interface transports \(\mu\). This is the sense in which the pushforward law
is **proof-carrying**: the definition call receives evidence establishing the
map's mathematical precondition.

The result itself is still a raw <code>Measure</code>. It is not a dependent
record that exposes the measurability proof as a field. Proof irrelevance also
means that choosing a different proof of the same proposition cannot change
the transported measure.

### Why the certificate matters in Mathlib

Mathematically, the pushforward identity

\[
(f_*\mu)(B)=\mu(f^{-1}(B))
\]

is used for measurable target sets when \(f\) is suitably measurable.

Mathlib defines <code>Measure.map f μ</code> as a total function. When \(f\)
is not almost everywhere measurable with respect to \(\mu\), the definition
falls back to the zero measure. This design keeps terms total, but it creates
a semantic trap: an unproved map expression still elaborates, while its value
may no longer represent the intended transported probability.

<code>RandomMatrix.law</code> requires an ordinary measurability proof. The
finite-product definition supplies that proof from \(h_A\), so later law
identities do not silently rely on the zero fallback. Ordinary measurability
is stronger than almost-everywhere measurability and is stable across every
source measure.

{{< panel "info" >}}
**Interface distinction.** The proof argument does not make
<code>Measure.map</code> partial. It documents and establishes that this
particular call lies in the measurable regime where the usual pushforward
theorems apply.
{{< /panel >}}

## Camp six: calibrate the law at zero and one step

The first two horizons catch most convention errors.

### Zero-step law

If \(\mu\) is a probability measure, then

\[
\operatorname{Law}_{\mu,A,0}=\delta_I.
\]

The sample map at horizon zero is constant at the identity. Pushing a
probability measure through a constant map puts all unit mass at that value.
Lean names the theorem <code>forwardProductLaw_zero</code>.

The typeclass hypothesis <code>[IsProbabilityMeasure μ]</code> is essential
for this exact unit Dirac formula. For a general measure, a constant
pushforward retains the source's total mass. A source of mass \(c\) would
produce \(c\delta_I\), not necessarily \(\delta_I\).

The theorem still receives

~~~lean
hA : ∀ j < 0, Measurable (A j)
~~~

because the law definition has a uniform evidence argument. This premise is
vacuous.

### One-step law

At horizon one, the sample product is \(A_0\), so

\[
\operatorname{Law}_{\mu,A,1}
{} =
\mathcal L_\mu(A_0).
\]

Lean's <code>forwardProductLaw_one</code> states the right side with
<code>RandomMatrix.law</code> and the extracted proof
<code>hA 0 Nat.zero_lt_one</code>.

No probability hypothesis is needed. The identity compares two pushforwards
of the same raw measure by the same map. Whatever total mass \(\mu\) has, both
sides retain it.

The zero and one formulas test different things:

| Calibration | What it checks |
|---|---|
| Zero law is Dirac at identity | Empty-product convention and probability mass normalization |
| One law equals the first factor law | Horizon indexing and factor order |

## Camp seven: raw mass-one theorem versus bundled law

The definition <code>forwardProductLaw</code> accepts an arbitrary raw
<code>Measure Ω</code>. When the source has total mass one, measurable
pushforward preserves that mass. The theorem

~~~lean
theorem forwardProductLaw_isProbabilityMeasure
    (μ : Measure Ω) [IsProbabilityMeasure μ]
    (A : ℕ → RandomMatrix Ω ι ι ℂ) (k : ℕ)
    (hA : ∀ j < k, Measurable (A j)) :
    IsProbabilityMeasure (forwardProductLaw μ A k hA)
~~~

records the result as a proposition and typeclass-bearing proof. It does not
construct a different measure.

The next definition starts from a bundled source
<code>μ : ProbabilityMeasure Ω</code> and packages the target:

~~~lean
noncomputable def forwardProductProbabilityLaw
    (μ : ProbabilityMeasure Ω)
    (A : ℕ → RandomMatrix Ω ι ι ℂ) (k : ℕ)
    (hA : ∀ j < k, Measurable (A j)) :
    ProbabilityMeasure (Matrix ι ι ℂ)
~~~

A <code>ProbabilityMeasure α</code> contains:

1. a raw <code>Measure α</code>; and
2. evidence that its total mass is one.

The constructor uses <code>forwardProductLaw</code> as the raw component and
<code>forwardProductLaw_isProbabilityMeasure</code> as its evidence.

Finally,
<code>coe_forwardProductProbabilityLaw</code> proves that forgetting the
wrapper recovers the raw law:

\[
\left(\operatorname{forwardProductProbabilityLaw}(\mu,A,k,h_A)
\text{ coerced to a raw measure}\right)
{} =
\operatorname{forwardProductLaw}(\mu,A,k,h_A).
\]

The proof is reflexivity. The wrapper is transparent by construction. It adds
a guarantee to the type and no renormalization, conditioning, or change of
sample weights.

## The complete declaration map

The module exposes exactly twelve public declarations.

| Declaration | Layer | Exact role |
|---|---|---|
| <code>sampleForwardProduct</code> | Semiring sample algebra | Evaluates the factor family at one outcome and forms the deterministic forward product |
| <code>sampleForwardProduct_zero</code> | Semiring sample algebra | The zero-horizon sample map is constant at identity |
| <code>sampleForwardProduct_succ</code> | Semiring sample algebra | The newest sampled factor is multiplied on the left |
| <code>sampleForwardProduct_one</code> | Semiring sample algebra | The one-step sample product is the time-zero factor map |
| <code>sampleForwardProduct_add</code> | Semiring sample algebra | A long sample product splits into a shifted later block times the earlier block |
| <code>measurable_sampleForwardProduct</code> | Complex measurable map | Exact-prefix factor measurability implies sample-product measurability |
| <code>forwardProductLaw</code> | Raw measure | Uses the certified sample product in <code>RandomMatrix.law</code> |
| <code>forwardProductLaw_zero</code> | Raw measure calibration | Under a probability source, the empty product law is Dirac at identity |
| <code>forwardProductLaw_one</code> | Raw measure calibration | The one-step product law is the law of the time-zero factor |
| <code>forwardProductLaw_isProbabilityMeasure</code> | Mass-one evidence | A probability source gives the raw product law total mass one |
| <code>forwardProductProbabilityLaw</code> | Bundled measure | Packages the raw law and mass-one evidence as a probability measure |
| <code>coe_forwardProductProbabilityLaw</code> | Interface coherence | Coercion of the bundled law recovers the raw law definitionally |

The five declarations in the first layer work over any semiring and do not
require a measurable space on \(\Omega\). The remaining seven use a measurable
sample space and complex matrices. The zero-law and raw mass-one theorem add a
probability hypothesis on the raw source. The bundled-law constructor encodes
that source hypothesis in <code>ProbabilityMeasure Ω</code>.

No declaration assumes <code>Nonempty ι</code>.

## Proof architecture

The proof scripts are short because earlier interfaces carry the mathematical
weight:

| Goal | Main ingredients |
|---|---|
| Zero and successor sample equations | Definitional reduction |
| One-step sample equation | Function extensionality and deterministic simplification |
| Shifted split | Function extensionality and <code>forwardProduct_add</code> |
| Product measurability | Natural-number induction, measurable constant, measurable multiplication |
| Raw law | <code>RandomMatrix.law</code> applied to the proved measurable product |
| Zero law | Constant-map pushforward under a probability source |
| One law | One-step function identity and the same pushforward |
| Raw mass one | <code>RandomMatrix.law_isProbabilityMeasure</code> |
| Bundled law | Pair the raw measure with its mass-one proof |
| Coercion theorem | Reflexivity |

Short code is not shallow mathematics. The module is concise because the
deterministic product convention, finite matrix measurable structure,
measurable multiplication, pushforward law, and probability-measure subtype
were each established earlier.

## Why this finite layer matters for dynamics and physics

Finite products appear before every asymptotic theory.

### Random linear recurrences

A random recurrence

\[
x_{j+1}(\omega)=A_j(\omega)x_j(\omega)
\]

has finite solution

\[
x_k(\omega)=\Pi_k(\omega)x_0
\]

when the initial state is deterministic. Before asking for expected growth or
almost-sure stability, \(\Pi_k\) must be a measurable random matrix. The
present theorem supplies that map-level foundation for a finite prefix.

### Tangent dynamics

For a differentiable nonlinear system, derivatives along an orbit multiply in
chronological order. If the system or initial data is random, those derivative
matrices become outcome-dependent. A measurable finite-product interface is a
prerequisite for probabilistic questions about finite-time tangent
propagators.

This module does not connect \(A_j\) to derivatives, prove a chain rule, or
define a nonlinear orbit. It only provides the matrix-product layer such a
bridge would consume.

### Transfer and scattering chains

Products of transfer matrices describe finite chains in wave propagation,
statistical mechanics, and disordered media. A finite chain has a
sample-dependent transfer matrix and hence a law when the disorder variables
are measurable. Independence or a particular disorder distribution is model
data, not a consequence of multiplication.

### The road to Lyapunov exponents

Long-time random matrix theory studies quantities such as

\[
\lim_{k\to\infty}\frac{1}{k}\log\lVert\Pi_k(\omega)\rVert.
\]

That expression requires far more than a measurable finite product:

- a norm and usually invertibility or controlled degeneracy;
- logarithmic integrability;
- a stationary or measure-preserving base dynamics;
- a cocycle identity over that base;
- an almost-sure limiting theorem; and
- for invariant splittings, the full hypotheses of a multiplicative ergodic
  theorem.

RMT-12 proves none of those bullets. It ensures that the finite random object
and its law are available without guessing the earlier interface.

## Common wrong turns

### Calling the factor family a product law

The family \(A\) is a sequence of matrix-valued functions. The product
\(\Pi_k\) is another function. Its law is a measure formed only after choosing
\(\mu\) and proving measurability.

### Reversing chronological order

For column action, \(A_0\) acts first and is written on the right. The
successor product is \(A_k\Pi_k\), not \(\Pi_kA_k\).

### Forgetting the shift in the split

The later block begins at \(A_m\), not \(A_0\). Omitting
\(j\mapsto A_{m+j}\) duplicates the wrong time segment.

### Requiring every future factor to be measurable

Horizon \(k\) reads only \(A_0,\ldots,A_{k-1}\). The checked premise is exact
prefix measurability.

### Treating <code>Measure.map</code> as an unconditional probability law

Mathlib's operation is total and has a zero-measure fallback outside its
almost-everywhere-measurable regime. The project supplies ordinary
measurability explicitly before calling the law interface.

### Assuming a law definition proves mass one

<code>forwardProductLaw</code> accepts an arbitrary raw source measure. Its
mass matches the source's mass. Probability status is a separate theorem with
a source probability hypothesis.

### Reading the bundled law as renormalization

<code>forwardProductProbabilityLaw</code> wraps an already mass-one raw law.
Its coercion theorem is reflexive. No weights change.

### Smuggling in independence

Measurability of each factor does not imply that factors are independent,
identically distributed, or stationary. Their joint dependence can be
arbitrary.

### Adding positive dimension from the norm chapter

The norm chapter needs positive dimension for identity-norm normalization.
This sample and law layer does not use a norm and supports an empty coordinate
type.

### Reading finite laws as asymptotics

A law for every chosen finite \(k\) is not a limit theorem. It does not produce
a Lyapunov exponent, invariant splitting, central limit theorem, or universal
spectral law.

## Exercises from trailhead to summit

### Trailhead

1. Expand \(\Pi_k(\omega)\) for \(k=0,1,2,3,4\).
2. For a column vector, add parentheses that expose the action order at
   horizon three.
3. Explain why <code>sampleForwardProduct_zero</code> is an equality of
   functions.
4. Verify the two-outcome example at every displayed horizon.

### Mid-mountain

5. Prove <code>sampleForwardProduct_one</code> on paper from the recursive
   definition.
6. Expand both sides of the split law for \(m=2\) and \(k=3\).
7. Write the exact factor indices used by \(\Pi_k\), then justify the bound
   \(j\lt k\) in the measurability hypothesis.
8. Reproduce the measurability induction. Identify where
   \(k\lt k+1\) and \(j\lt k\Rightarrow j\lt k+1\) enter.
9. Construct two fully dependent measurable factors on a two-point space and
   compute their two-step law.
10. Give two different source probability measures on the same outcome space
    and show that the same sample product map has two different laws.

### Summit

11. For a raw source measure of finite mass \(c\), compute the pushforward of
    the zero-step product and explain why the checked Dirac theorem assumes
    \(c=1\).
12. Explain, without using the word *wrapper*, the type difference between
    <code>Measure α</code> with an external
    <code>IsProbabilityMeasure</code> proof and
    <code>ProbabilityMeasure α</code>.
13. Describe Mathlib's nonmeasurable-map fallback and explain why the explicit
    proof argument rules it out for this construction.
14. Prove that every finite product in empty matrix dimension is the unique
    identity matrix.
15. Design a later measurable cocycle structure. List the base map, cocycle
    law, source measure, and invariance hypotheses absent here.
16. State a plausible finite-time norm random variable built from \(\Pi_k\).
    List the additional norm measurability and integrability results needed
    before taking its expectation.
17. State the hypotheses of a multiplicative ergodic theorem that cannot be
    inferred from these twelve declarations.

## Reproduce the checked slice

From the repository root, load the pinned Lean toolchain and compile the module
with warnings treated as errors:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/MatrixProducts/MeasurableFiniteProducts.lean
~~~

Build the module and its dependencies by library name:

~~~sh
lake build NonlinearDynamics.Random.MatrixProducts.MeasurableFiniteProducts
~~~

Return to the repository root and check the teaching site:

~~~sh
cd ..
make site-check
~~~

The repository-wide technical gate is <code>make check</code>. Passing it does
not publish this draft. Human mathematical, source, accessibility, and
editorial reviews remain separate publication gates.

## Summit: what has and has not been proved

| Topic | Status in this module |
|---|---|
| Pointwise finite forward product of outcome-dependent factors | Defined over every semiring |
| Empty product as the identity map | Checked |
| Newest-on-left successor recursion | Checked |
| One-step product as the time-zero factor | Checked |
| Shifted split into later and earlier finite blocks | Checked |
| Exact finite-prefix measurability | Checked for complex matrices |
| Raw pushforward law with explicit source measure | Defined |
| Explicit ordinary-measurability evidence at the law interface | Required and supplied |
| Zero-step law under a probability source | Checked as Dirac at identity |
| One-step law | Checked as the law of the time-zero factor |
| Raw product law has mass one under a probability source | Checked |
| Bundled probability law | Defined |
| Coercion from the bundled law to the raw law | Checked definitionally |
| Empty coordinate dimension | Supported without a nonempty assumption |
| Independence of factors | Not assumed or proved |
| Identical distribution or stationarity | Not assumed or proved |
| Product-law factorization or convolution formula | Not stated |
| Probability-preserving base map | Not defined |
| Random cocycle over a base transformation | Not defined |
| Almost-sure equality or property | Not stated |
| Norm measurability, norm moments, or integrability | Not proved |
| Finite product or orbit growth bounds | Not part of this module |
| Invertibility or determinant statements | Not assumed or proved |
| Logarithmic integrability | Not stated |
| Lyapunov exponent or asymptotic logarithmic limit | Not defined or proved |
| Multiplicative ergodic theorem or invariant splitting | Not invoked |
| Spectral statistics, density, or universality | Not claimed |
| Derivative product along a nonlinear orbit | Not connected |
| Stability, bifurcation, chaos, or physical-model theorem | Not claimed |

The module reaches exactly one new altitude: finite ordered products are now
measurable random matrices with honest pushforward laws. Every long-time or
model-specific claim remains above the current summit.

## Where to continue

The
{{< refterm "finite-random-matrix-product" "finite random-matrix product" >}}
glossary entry is the compact version of this construction. The
{{< refterm "forward-matrix-product" "forward matrix product" >}} entry
isolates the chronology and shifted split. The
{{< refterm "measurable-space" "measurable space" >}},
{{< refterm "pushforward-measure" "pushforward measure" >}}, and
{{< refterm "probability-law" "probability law" >}} entries develop the three
measure-theoretic interfaces reused here.

[Random Matrices from Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}})
places random matrices in the wider sample, law, symmetry, and observable
landscape. [Finite Product Probability Spaces and Independent Gaussian Fields]({{< relref "/knowledge-base/deep-dives/finite-product-probability-spaces-and-independent-gaussian-fields" >}})
studies finite product measures and independence. That is a different product:
it combines coordinate probability spaces, while the present chapter
multiplies matrices in chronological order and assumes no independence.

The next checked layer is
[Generator-Presented One-Sided Discrete Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/generator-presented-one-sided-discrete-matrix-cocycles" >}}),
with a compact companion entry on the
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycle" >}}.
It introduces a measure-preserving forward base and the finite cocycle law.
Later layers can add norm observables, logarithmic integrability, and
asymptotic growth theorems as separate interfaces.

## References

<a id="ref-measurable-product-map"></a>**Mathlib contributors.**
[Pushforward of a measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
Mathlib 4 documentation. This official implementation reference documents
<code>Measure.map</code>, the hypotheses for its standard pushforward
theorems, and its totalized fallback when a map is not almost everywhere
measurable.

<a id="ref-measurable-product-probability"></a>**Mathlib contributors.**
[Bundled probability measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/ProbabilityMeasure.html),
Mathlib 4 documentation. This official source defines
<code>ProbabilityMeasure</code>, its mass-one evidence, and its coercion to a
raw measure.

<a id="ref-measurable-product-matrix"></a>**Mathlib contributors.**
[Measurable structure on finite matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Constructions/Pi.html),
Mathlib 4 documentation. This official source develops product and
function-space measurable structures used to treat finite matrices
coordinatewise.

<a id="ref-measurable-product-kallenberg"></a>**Olav Kallenberg.**
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1),
third edition, Springer, 2021. This is a standard source for measurable random
elements, distributions as pushforwards, and the separation between a random
object and its law.

<a id="ref-measurable-product-arnold"></a>**Ludwig Arnold.**
[Random Dynamical Systems](https://doi.org/10.1007/978-3-662-12878-7),
Springer Monographs in Mathematics, 1998. This develops measurable cocycles
over metric dynamical systems and the long-time random-dynamics framework that
motivates later layers. Those hypotheses are absent from the finite-law module.

<a id="ref-measurable-product-oseledets"></a>**V. I. Oseledets.**
[A multiplicative ergodic theorem. Characteristic Ljapunov exponents of dynamical systems](https://www.mathnet.ru/eng/mmo214),
*Transactions of the Moscow Mathematical Society* 19 (1968), 197-231. This
primary source is the historical asymptotic destination. The present module
does not establish its invariance, integrability, limit, exponent, or
splitting conclusions.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
