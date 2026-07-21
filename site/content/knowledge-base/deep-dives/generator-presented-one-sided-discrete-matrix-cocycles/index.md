---
title: "Generator-Presented One-Sided Discrete Matrix Cocycles"
slug: "generator-presented-one-sided-discrete-matrix-cocycles"
date: 2026-07-21
summary: "A textbook construction of finite matrix cocycles from one measurable generator along a measure-preserving base, including Function.iterate, the later-block-left cocycle law, exact assumption layers, and every finite-time boundary."
lead: "A time-indexed random product becomes a cocycle when its factors come from one generator observed along a moving base environment. The shift in that environment is what turns an ordinary product split into the cocycle law."
draft: true
pro_reviewed: false
level: "Discrete random dynamics, semigroup cocycles, measurable iteration, and measure-preserving bases"
reading_time: "80 to 105 minutes"
prerequisites: "Forward matrix products, measurable finite random-matrix products, function iteration, measurable maps, and pushforward measures; each new boundary is introduced before use"
lean_module: "NonlinearDynamics.Random.RandomCocycles.Discrete"
toc: true
og_image: "generator-presented-one-sided-discrete-matrix-cocycles-card.png"
og_image_alt: "A measure-preserving base advances an environment, one generator supplies matrices along that orbit, and the finite cocycle splits into an earlier block followed by a shifted later block written on the left."
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

A sequence of arbitrary random matrices gives one factor map at every time. A
cocycle imposes more structure: one base map advances an environment, and one
matrix generator is observed repeatedly along that base orbit.

Let \(\Omega\) be the base space, let \(T:\Omega\to\Omega\) advance the
environment, and let
\(A:\Omega\to M_\iota(\mathbb K)\) choose a square matrix from the current
environment. Starting from \(\omega\), the generator produces the sequence

\[
A(\omega),\quad A(T\omega),\quad A(T^2\omega),\quad\ldots.
\]

The finite cocycle value is

\[
\Phi(k,\omega)
{} =
A(T^{k-1}\omega)\cdots A(T\omega)A(\omega),
\qquad
\Phi(0,\omega)=I.
\]

The newest matrix appears on the left, matching chronological action on column
vectors. The defining structural theorem is the one-sided cocycle identity

\[
\Phi(m+k,\omega)
{} =
\Phi(k,T^m\omega)\Phi(m,\omega).
\]

The early block begins at \(\omega\) and acts first. The later block begins at
the shifted environment \(T^m\omega\) and acts second, so it is written on the
left.

The module <code>NonlinearDynamics.Random.RandomCocycles.Discrete</code>
checks this construction in sixteen public declarations. The first six build
the orbit-generated algebra. Two prove measurability. One defines the bundled
generator presentation. The remaining seven expose finite values,
measurability, the cocycle law, and preservation by every base iterate.

This milestone is finite-time and one-sided. It deliberately stops before
probability normalization, ergodicity, norm observables, logarithmic
integrability, Lyapunov exponents, or any multiplicative ergodic theorem.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [A split orbit in one picture](#a-split-orbit-in-one-picture) | See why the later block starts from a shifted environment |
| Iteration route | [Natural-number iteration builds the orbit](#base-camp-natural-number-iteration-builds-the-orbit) | Read Mathlib's function-iterate notation and laws |
| Algebra route | [One generator becomes a finite product](#camp-two-one-generator-becomes-a-finite-product) | Derive zero, one, successor, and addition identities |
| Proof route | [Why the cocycle proof needs an iterate calculation](#camp-three-why-the-cocycle-proof-needs-an-iterate-calculation) | Audit the induction and later-block-left order |
| Measure route | [What measure preserving means](#camp-six-what-measure-preserving-means) | Separate invariance of a measure from probability and ergodicity |
| Lean route | [The complete declaration map](#the-complete-declaration-map) | Audit all sixteen names and their exact assumptions |
| Boundary route | [Empty matrix dimension remains valid](#camp-eight-empty-matrix-dimension-remains-valid) | See which declarations do not need finite nonempty coordinates |
| Summit route | [What has and has not been proved](#summit-what-has-and-has-not-been-proved) | Preserve every explicit nonclaim |

### Learning objectives

By the summit, you should be able to:

1. distinguish a base state, base map, generator, orbit factor, and cocycle
   value;
2. read <code>T^[j]</code> as the \(j\)-fold natural-number iterate of \(T\);
3. explain why the orbit sequence itself needs no matrix algebra;
4. expand the cocycle values at horizons zero through three;
5. explain why the newest factor is written on the left;
6. derive the shifted later-block-left cocycle identity;
7. identify where <code>Function.iterate_add_apply</code> enters its proof;
8. distinguish a generator-presented cocycle from an axiom-presented one;
9. separate semiring algebra from complex measurability;
10. prove that each orbit factor is measurable by composition;
11. define <code>MeasurePreserving</code> as measurability plus pushforward
    equality;
12. explain why a measure-preserving base need not be probabilistic, ergodic,
    mixing, or invertible;
13. explain why every natural-number base iterate preserves the measure;
14. audit the exact four fields of <code>DiscreteMatrixCocycle</code>;
15. map every mathematical claim to one of the sixteen declarations;
16. explain why empty matrix dimension is supported; and
17. list the law, norm, integrability, asymptotic, and nonlinear-dynamics
    bridges still absent.

## A split orbit in one picture

{{< reference-figure
  src="one-sided-cocycle-two-block-split.svg"
  alt="An early block begins at the initial environment and follows the base forward to a split state. A later block begins at that shifted environment and continues forward. The composition strip writes the later block on the left and the early block on the right because the early block acts first. A side note says every natural base iterate preserves the same measure."
  caption="**Finding:** elapsed base time changes the starting environment of the later product block. The early block carries the system to the split state; the shifted later block continues from there and is written on the left because it acts second. Measure preservation survives every natural base iterate, but the figure does not assert probability normalization, ergodicity, invertibility, or asymptotic growth."
>}}

The diagram separates two kinds of composition:

- the base state advances through repeated application of \(T\); and
- matrices multiply in the order in which they act on a column state.

The cocycle identity synchronizes those two compositions.

## Base camp: natural-number iteration builds the orbit

For a self-map \(T:\Omega\to\Omega\), Mathlib's
<code>Function.iterate</code> defines \(T^j\) for each natural number \(j\).
Lean writes this as <code>T^[j]</code>.

The zeroth iterate is the identity:

\[
T^0\omega=\omega.
\]

The successor iterate applies \(T\) one more time:

\[
T^{j+1}\omega=T(T^j\omega).
\]

Iteration also adds:

\[
T^{m+k}\omega=T^k(T^m\omega)
{} =
T^m(T^k\omega).
\]

Both displayed forms are valid because they are iterates of the same map and
natural-number addition commutes. This does not say that arbitrary functions
commute.

The first declaration is:

~~~lean
def orbitMatrixSequence
    (T : Ω → Ω) (A : RandomMatrix Ω ι ι 𝕜) :
    ℕ → RandomMatrix Ω ι ι 𝕜 :=
  fun j ω => A (T^[j] ω)
~~~

At time \(j\) and initial state \(\omega\), it returns
\(A(T^j\omega)\). This definition performs only evaluation and composition.
Its elaborated public type needs no <code>Fintype ι</code>, no decidable
equality, and no semiring on \(\mathbb K\). A matrix here is merely a
two-coordinate function.

That weak interface is useful. The orbit-generated sequence exists before any
decision to multiply its values.

## Camp one: read the first orbit factors

Fix \(\omega\). The first four factors are:

\[
\begin{array}{c|c|c}
j & \text{base state} & \text{matrix factor}\\ \hline
0 & \omega & A(\omega)\\
1 & T\omega & A(T\omega)\\
2 & T^2\omega & A(T^2\omega)\\
3 & T^3\omega & A(T^3\omega)
\end{array}
\]

The initial state remains an argument. Changing \(\omega\) changes the entire
forward orbit and can change every factor.

This sequence is a special case of the arbitrary time-indexed family from
{{< refterm "finite-random-matrix-product" "finite random-matrix products" >}}.
The special feature is coherence across time: every factor comes from the same
generator after a known base iterate.

No independence follows. Two factors
\(A(T^j\omega)\) and \(A(T^\ell\omega)\) are functions of the same initial
state and the same deterministic base map.

## Camp two: one generator becomes a finite product

The definition

~~~lean
def cocycleProduct
    (T : Ω → Ω) (A : RandomMatrix Ω ι ι 𝕜) (k : ℕ) :
    RandomMatrix Ω ι ι 𝕜 :=
  MatrixProducts.sampleForwardProduct
    (orbitMatrixSequence T A) k
~~~

feeds the orbit sequence into the earlier pointwise product. This layer assumes
that \(\iota\) is finite with decidable equality and that \(\mathbb K\) is a
semiring.

The first product values are

\[
\begin{aligned}
\Phi(0,\omega)&=I,\\
\Phi(1,\omega)&=A(\omega),\\
\Phi(2,\omega)&=A(T\omega)A(\omega),\\
\Phi(3,\omega)&=A(T^2\omega)A(T\omega)A(\omega).
\end{aligned}
\]

The module exposes these facts through:

- <code>cocycleProduct_zero</code>;
- <code>cocycleProduct_succ</code>; and
- <code>cocycleProduct_one</code>.

The zero and successor equations are definitional. The one-step theorem uses
function extensionality and simplification to identify the sampled zeroth
iterate with the original generator.

At a successor horizon,

\[
\Phi(k+1,\omega)=A(T^k\omega)\Phi(k,\omega).
\]

The newest factor is on the left. This convention is inherited from
{{< refterm "forward-matrix-product" "forward matrix products" >}}, not chosen
again in the cocycle layer.

## Camp three: why the cocycle proof needs an iterate calculation

The theorem <code>cocycleProduct_add</code> states, pointwise,

\[
\Phi(m+k,\omega)
{} =
\Phi(k,T^m\omega)\Phi(m,\omega).
\]

Its proof inducts on the length \(k\) of the later block.

### Later block of length zero

When \(k=0\), the later value is the identity:

\[
\Phi(m+0,\omega)
{} =
I\Phi(m,\omega).
\]

Simplification closes the base case.

### Add one later step

Assume the theorem for \(k\). The newest factor on the full left side is

\[
A(T^{m+k}\omega).
\]

The newest factor in the shifted later product is

\[
A(T^k(T^m\omega)).
\]

These are equal by the iterate-addition law:

\[
T^{m+k}\omega=T^k(T^m\omega).
\]

Mathlib states <code>Function.iterate_add_apply</code> with a particular order
of the two natural indices. The Lean proof commutes \(m+k\) before applying
that theorem. This is an index normalization step, not a commutativity
assumption on matrices.

After the orbit states agree, the induction hypothesis replaces the shorter
product, and matrix multiplication associativity closes the successor case.
No factor is commuted across another.

The proof therefore uses exactly three structural ingredients:

1. the successor recursion for the ordered product;
2. addition of iterates of one base map; and
3. associativity of matrix multiplication.

## Camp four: a noncommuting two-state example

Let the base space be \(\Omega=\{r,b\}\). Let \(T\) swap the two states:

\[
Tr=b,\qquad Tb=r.
\]

The uniform probability measure is preserved by this swap. Define two real
matrices, viewed also as complex matrices,

\[
A(r)=
\begin{bmatrix}
1 & 1\\
0 & 1
\end{bmatrix},
\qquad
A(b)=
\begin{bmatrix}
2 & 0\\
0 & 1
\end{bmatrix}.
\]

Write \(S=A(r)\) and \(D=A(b)\). Starting at \(r\),

\[
\begin{aligned}
\Phi(1,r)&=S,\\
\Phi(2,r)&=DS
{} =
\begin{bmatrix}
2 & 2\\
0 & 1
\end{bmatrix},\\
\Phi(3,r)&=SDS
{} =
\begin{bmatrix}
2 & 3\\
0 & 1
\end{bmatrix}.
\end{aligned}
\]

Split three steps with \(m=1\) and \(k=2\). The shifted state is \(Tr=b\).
The two-step later block is

\[
\Phi(2,b)=SD
{} =
\begin{bmatrix}
2 & 1\\
0 & 1
\end{bmatrix}.
\]

The cocycle law gives

\[
\Phi(3,r)
{} =
\Phi(2,b)\Phi(1,r)
{} =
(SD)S
{} =
SDS.
\]

Reversing the blocks gives

\[
S(SD)
{} =
\begin{bmatrix}
2 & 2\\
0 & 1
\end{bmatrix},
\]

which is not \(\Phi(3,r)\). The later-block-left order is therefore
mathematically visible, not cosmetic.

This example uses a probability measure for familiarity. The Lean bundle does
not require total mass one.

## Camp five: complex measurability

Now equip \(\Omega\) with a measurable-space structure and specialize the
matrix entries to \(\mathbb C\).

If \(T\) is measurable, then every natural iterate \(T^j\) is measurable. If
the generator \(A\) is measurable, composition gives

\[
\omega\longmapsto A(T^j\omega)
\]

as a measurable matrix-valued map. The theorem
<code>measurable_orbitMatrixSequence</code> records this for every \(j\).

Its public type does not require finite matrix indices or decidable equality.
No multiplication occurs in one orbit factor.

The theorem <code>measurable_cocycleProduct</code> then applies the preceding
finite-product measurability theorem. Every factor in the required prefix is
measurable because every orbit factor is measurable. The conclusion is

\[
\omega\longmapsto\Phi(k,\omega)
\]

measurable for every finite \(k\).

This second theorem does require finite matrix indices and decidable equality
because it multiplies matrices. Its complex scope matches the project's
checked measurable multiplication interface. The theorem does not form a
pushforward law or prove integrability.

## Camp six: what measure preserving means

Let \(\mu\) be a measure on \(\Omega\). Mathlib defines
<code>MeasurePreserving T μ μ</code> as a proposition with two fields:

1. <code>Measurable T</code>; and
2. <code>Measure.map T μ = μ</code>.

Mathematically,

\[
T_*\mu=\mu.
\]

For any measurable set \(B\), this yields

\[
\mu(T^{-1}(B))=\mu(B).
\]

The base transformation redistributes points without changing the measure of
measurable events.

### Preservation is not probability normalization

Nothing in <code>MeasurePreserving T μ μ</code> says
\(\mu(\Omega)=1\). The zero measure is preserved by every measurable self-map,
and infinite measures can also be invariant. A probability interpretation
needs a separate <code>IsProbabilityMeasure μ</code> assumption or a bundled
<code>ProbabilityMeasure Ω</code>. Neither appears in RMT-13.

Measure preservation can support a later proof that a measurable observable
and its composition with a base iterate have the same raw pushforward measure.
RMT-13 does not state that law-level theorem, and without probability
normalization it does not package the orbit factors as identically distributed
random variables. Invariance of one-factor marginals would still say nothing
about independence between different times.

### Preservation is not ergodicity

Ergodicity says, roughly, that invariant measurable events are trivial up to
measure zero. Mixing asserts a stronger long-time loss of correlation.
Measure preservation alone says neither. A base map can preserve many
nontrivial invariant pieces.

### Preservation is not invertibility

A noninjective map can preserve a measure. The structure stores an ordinary
self-map, not an equivalence, so it supplies no backward orbit and no
negative-time action.

### Why one-sided time is a real boundary

Natural-number time makes every forward expression meaningful without an
inverse. The sequence

\[
\omega,\quad T\omega,\quad T^2\omega,\quad\ldots
\]

exists for every self-map. To define a value at time \(-1\), one would need to
recover a previous environment and reverse a matrix update. That generally
requires an invertible base and invertible generator values, together with a
law relating the backward and forward definitions.

None of those data can be reconstructed from measure preservation alone.
Even when a measure-preserving map is invertible almost everywhere, the
present Lean field is an ordinary function with no stored measurable inverse.
Likewise, a complex square matrix may be singular. The one-sided interface
therefore avoids choosing a false inverse or hiding an exceptional set.

A future two-sided cocycle would naturally use integer time and an invertible
measure-preserving base action. It would need an explicit inverse convention
for negative matrix products. RMT-13 does not reserve such a convention by
notation.

Keeping these distinctions visible prevents the namespace
<code>RandomCocycles</code> from smuggling in a complete metric dynamical
system.

## Camp seven: the bundled generator presentation

The central structure is:

~~~lean
structure DiscreteMatrixCocycle (μ : Measure Ω) where
  base : Ω → Ω
  generator : RandomMatrix Ω ι ι ℂ
  base_preserving : MeasurePreserving base μ μ
  measurable_generator : Measurable generator
~~~

The four fields have separate jobs:

| Field | What it stores | What it does not store |
|---|---|---|
| <code>base</code> | One forward environment update | An inverse or group action |
| <code>generator</code> | One complex matrix at each environment | A separately supplied time-indexed family |
| <code>base_preserving</code> | Base measurability and invariance of \(\mu\) | Probability, ergodicity, or mixing |
| <code>measurable_generator</code> | Ordinary measurability of the one-step matrix map | Integrability, independence, or a law |

The structure itself does not require <code>Fintype ι</code> or
<code>DecidableEq ι</code>. It can store a base and generator before asking for
finite matrix multiplication. Its <code>value</code> method does require those
finite-index assumptions because it forms products.

The bundle is **generator presented**. It does not store an independent
\(\Phi\) field and a cocycle-law field. Instead,

\[
C.\operatorname{value}(k)=
\operatorname{cocycleProduct}(C.\operatorname{base},
C.\operatorname{generator},k).
\]

The unbundled algebra then proves every value theorem.

## Camp eight: empty matrix dimension remains valid

The coordinate type \(\iota\) may be empty. It is still finite and has
decidable equality. A square matrix on that type has no entries and exactly
one value, which is the identity matrix.

Every orbit factor and cocycle value is therefore the unique matrix. The
successor and addition laws remain true. Measurability is automatic, and the
base measure-preservation statements are independent of matrix coordinates.

The theorem <code>base_iterate_preserving</code> explicitly omits finite-index
and decidable-equality assumptions because it concerns only the base map.
Likewise, <code>measurable_orbitMatrixSequence</code> needs neither assumption
because a single matrix-valued composition performs no multiplication.

No <code>Nonempty ι</code> assumption appears anywhere in the module. The
positive-dimension norm normalization from RMT-11 is irrelevant here because
RMT-13 defines no norm.

## Camp nine: bundled values inherit every finite theorem

For a bundled cocycle \(C\), the project defines
<code>C.value k</code> by the unbundled cocycle product. It publishes:

\[
\begin{aligned}
C.\operatorname{value}(0,\omega)&=I,\\
C.\operatorname{value}(1,\omega)&=C.\operatorname{generator}(\omega),\\
C.\operatorname{value}(k+1,\omega)
&=C.\operatorname{generator}(C.\operatorname{base}^k\omega)
  C.\operatorname{value}(k,\omega).
\end{aligned}
\]

The bundled addition law is

\[
C.\operatorname{value}(m+k,\omega)
{} =
C.\operatorname{value}(k,C.\operatorname{base}^m\omega)
C.\operatorname{value}(m,\omega).
\]

The zero and successor equations are definitional. The one and addition
theorems reuse their unbundled counterparts.

For measurability,
<code>C.base_preserving.measurable</code> extracts base measurability from the
preservation field. Combined with <code>C.measurable_generator</code>, it feeds
<code>measurable_cocycleProduct</code>. Thus
<code>DiscreteMatrixCocycle.measurable_value</code> proves ordinary
measurability for every finite value.

RMT-12 showed how a measurable random matrix can be pushed forward to a law.
RMT-13 does not perform that step. A later theorem may apply the earlier law
interface to <code>C.value k</code>, but no product-law declaration is exposed
here.

## Camp ten: every natural base iterate preserves the measure

From

\[
T_*\mu=\mu,
\]

composition gives

\[
(T^k)_*\mu=\mu
\]

for every natural number \(k\). At \(k=0\), the identity map preserves
\(\mu\). At a successor, the composition of two measure-preserving maps is
measure preserving.

Mathlib packages this induction as
<code>MeasurePreserving.iterate</code>. The project theorem
<code>DiscreteMatrixCocycle.base_iterate_preserving</code> applies it directly:

~~~lean
theorem base_iterate_preserving
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    MeasurePreserving C.base^[k] μ μ :=
  C.base_preserving.iterate k
~~~

This theorem says that each finite base shift retains the same measure. It
does not say that an iterate is ergodic or mixing, and it does not prove
invariance of a skew-product transformation that also updates vectors.

## The complete declaration map

The module exposes exactly sixteen public declarations.

| Declaration | Layer | Exact role |
|---|---|---|
| <code>orbitMatrixSequence</code> | Pure function layer | Evaluates one generator along every natural base iterate |
| <code>cocycleProduct</code> | Semiring algebra | Forms the newest-factor-left product of the orbit sequence |
| <code>cocycleProduct_zero</code> | Semiring algebra | The zero-horizon product is the constant identity map |
| <code>cocycleProduct_succ</code> | Semiring algebra | Samples the generator at the newest base iterate and multiplies it on the left |
| <code>cocycleProduct_one</code> | Semiring algebra | The one-step product is the generator |
| <code>cocycleProduct_add</code> | Semiring algebra | Splits a product into a shifted later block on the left and an early block on the right |
| <code>measurable_orbitMatrixSequence</code> | Complex measurability | Measurable base and generator give a measurable factor at every iterate |
| <code>measurable_cocycleProduct</code> | Complex measurability | Every finite cocycle product is measurable |
| <code>DiscreteMatrixCocycle</code> | Bundled presentation | Stores a base, complex generator, base-preservation proof, and generator-measurability proof |
| <code>DiscreteMatrixCocycle.value</code> | Bundled finite value | Builds the cocycle product from the stored base and generator |
| <code>DiscreteMatrixCocycle.value_zero</code> | Bundled algebra | The zero value is the identity map |
| <code>DiscreteMatrixCocycle.value_one</code> | Bundled algebra | The one-step value is the stored generator |
| <code>DiscreteMatrixCocycle.value_succ</code> | Bundled algebra | The newest sampled generator factor is multiplied on the left |
| <code>DiscreteMatrixCocycle.value_add</code> | Bundled algebra | The bundled value satisfies the pointwise one-sided cocycle law |
| <code>DiscreteMatrixCocycle.measurable_value</code> | Bundled measurability | Every finite bundled value is ordinarily measurable |
| <code>DiscreteMatrixCocycle.base_iterate_preserving</code> | Base dynamics | Every natural iterate of the stored base preserves \(\mu\) |

The exact assumption ledger is:

| Interface | Assumptions |
|---|---|
| <code>orbitMatrixSequence</code> | No scalar algebra, finite-index, measurable-space, or measure assumptions |
| Unbundled product algebra | Finite index type, decidable equality, scalar semiring |
| One orbit-factor measurability | Measurable space on \(\Omega\), complex matrices, measurable base and generator; no finite-index assumptions |
| Product measurability | The preceding measurable data plus finite index type and decidable equality |
| <code>DiscreteMatrixCocycle μ</code> storage | Measurable space on \(\Omega\); no finite-index assumptions and no probability normalization |
| Bundled values and value algebra | Stored cocycle plus finite index type and decidable equality |
| Bundled value measurability | Stored preservation and generator evidence plus finite index type and decidable equality |
| Base-iterate preservation | Stored cocycle only; matrix finiteness and decidable equality are omitted |

No declaration assumes a nonempty coordinate type.

## Proof architecture

The implementation is small because it composes established layers:

| Goal | Main ingredients |
|---|---|
| Orbit sequence | <code>Function.iterate</code> and function evaluation |
| Cocycle product | RMT-12 <code>sampleForwardProduct</code> |
| Zero and successor products | Definitional reduction |
| One-step product | Function extensionality, zeroth iterate, one-step product |
| Cocycle addition law | Induction on later length, iterate addition, product recursion, associativity |
| Orbit-factor measurability | <code>Measurable.iterate</code> and measurable composition |
| Product measurability | RMT-12 exact-prefix theorem applied to every orbit factor |
| Bundled values | Reuse the unbundled definitions and theorems |
| Bundled value measurability | Extract base measurability from measure preservation |
| Base-iterate preservation | Mathlib's <code>MeasurePreserving.iterate</code> |

The central design choice is vertical reuse:

\[
\text{function iteration}
\longrightarrow
\text{orbit factors}
\longrightarrow
\text{measurable finite products}
\longrightarrow
\text{generator-presented cocycle}.
\]

No parallel matrix-product abstraction is introduced.

## Why this layer matters for mathematics and physics

### Random linear systems

A random linear recurrence can be written

\[
x_{k+1}(\omega)
{} =
A(T^k\omega)x_k(\omega).
\]

Its finite solution is

\[
x_k(\omega)=\Phi(k,\omega)x_0.
\]

The cocycle identity then expresses consistency across a time split: evolve
for \(m\) steps, shift the environment, then evolve for \(k\) more.

RMT-13 defines the matrix value but no state-vector recurrence theorem. That
action bridge can be added later from existing matrix-vector multiplication.

### Transfer matrices

In finite disordered chains, a base state can encode the disorder environment
and the generator can select the local transfer matrix. Moving the base exposes
the next local environment. The product composes finite transfer steps.

This interpretation needs model-specific choices of \(\Omega\), \(T\), \(A\),
and \(\mu\). Independence, stationarity in a probabilistic sense, and physical
observables are not automatic.

### Tangent dynamics

For a differentiable nonlinear map \(f\), the derivative matrices along an
orbit formally resemble

\[
A(x)=Df(x),
\qquad
T(x)=f(x).
\]

The chain rule then turns derivatives of iterates into an ordered matrix
product. RMT-13 does not define differentiability, derivatives, invariant
domains, or that chain-rule bridge. The resemblance identifies a future
consumer of the interface, not a theorem already proved.

### Multiplicative ergodic theory

Lyapunov exponents study asymptotic logarithmic growth, often through

\[
\lim_{k\to\infty}
\frac{1}{k}\log\lVert\Phi(k,\omega)\rVert.
\]

This expression requires a chosen matrix norm, measurability of the norm
observable, policies for zero norm, logarithmic integrability, suitable
invariant probability structure, and an asymptotic theorem. Invariant
splittings need still more.

RMT-13 supplies only the finite measurable cocycle and preservation of the
base measure. It does not establish any condition in that later analytic
ledger except finite-value measurability.

## Common wrong turns

### Treating the generator as an arbitrary time sequence

There is one map \(A:\Omega\to M_\iota(\mathbb C)\). Time dependence arises by
evaluating it at \(T^j\omega\). An arbitrary family \(A_j(\omega)\) belongs to
the preceding finite-random-product layer and need not be a cocycle generator.

### Forgetting the shifted environment

The later block begins at \(T^m\omega\). Writing
\(\Phi(k,\omega)\Phi(m,\omega)\) generally repeats factors from the beginning
of the orbit.

### Putting the early block on the left

The early block acts first on column vectors and is written on the right. The
later block acts second and is written on the left.

### Reading <code>Function.iterate</code> as matrix power

<code>T^[j]</code> iterates the base function. Matrix powers use a different
operation. The generator is evaluated after function iteration and only then
are matrices multiplied.

### Assuming the bundle stores a cocycle-law axiom

The structure stores base data, generator data, and two evidence fields. Its
value and cocycle law are derived from the generator presentation.

### Equating measure preservation with probability

The source \(\mu\) is an arbitrary measure. Total mass one is not a field or
theorem of this module.

### Equating measure preservation with ergodicity or mixing

An invariant measure can support nontrivial invariant subsets and persistent
correlations. Those stronger properties need separate definitions.

### Assuming one-sided time can run backward

Natural-number iteration supplies no negative indices. The base and generator
matrices need not be invertible.

### Inferring a product-law factorization

The module defines no law of <code>C.value k</code>. Even after forming one,
matrix-factor dependence prevents a factorization without additional
hypotheses.

### Reading finite measurability as integrability

A measurable norm or log norm can fail to be integrable. RMT-13 defines
neither observable.

### Reading the cocycle law as a Lyapunov theorem

The cocycle law is finite algebra. It creates no asymptotic limit, exponent,
invariant splitting, or stability classification.

### Assuming a nonlinear Jacobian bridge

The module contains no nonlinear map, derivative, chain rule, or theorem
identifying the generator with a Jacobian matrix.

## Exercises from trailhead to summit

### Trailhead

1. Write the base states and generator factors through time four.
2. Expand \(\Phi(k,\omega)\) for \(k=0,1,2,3,4\).
3. Explain why \(A(T^0\omega)=A(\omega)\).
4. Show that <code>orbitMatrixSequence</code> needs no semiring.
5. Verify the two-state matrix products in the worked example.

### Mid-mountain

6. Split a five-step product after \(m=2\) and write every shifted factor.
7. Prove the cocycle identity directly by expanding both sides.
8. Reproduce the induction on \(k\), naming the iterate-addition and
   associativity steps.
9. Construct a measure-preserving base that is not ergodic.
10. Explain why the identity base preserves every measure but is usually not
    mixing.
11. Prove measurability of one orbit factor by composing the generator with a
    base iterate.
12. Explain why product measurability needs finite matrix indices while
    orbit-factor measurability does not.

### Summit

13. Compare the generator-presented structure with an abstract structure that
    stores \(\Phi\), normalization, and the cocycle law as fields.
14. Prove on paper that every natural iterate of a measure-preserving map
    preserves the measure.
15. Analyze the empty-coordinate-type cocycle and identify the unique matrix
    at every horizon.
16. Define a candidate skew-product map on environments and column vectors.
    List the additional measure on vector space and invariance theorem that
    RMT-13 does not provide.
17. Define a finite norm observable on paper. List norm choice,
    measurability, zero-norm, and integrability decisions needed before using
    its logarithm.
18. State the probability, invariance, and logarithmic-integrability
    hypotheses a future multiplicative ergodic theorem would need.
19. Formulate a derivative-product theorem for iterates of a differentiable
    map and list the chain-rule hypotheses absent here.

## Reproduce the checked slice

From the repository root, load the pinned Lean toolchain and compile the module
with warnings treated as errors:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/Discrete.lean
~~~

Build the module and its dependencies by library name:

~~~sh
lake build NonlinearDynamics.Random.RandomCocycles.Discrete
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
| Generator sampled along every natural base iterate | Defined |
| Newest-factor-left finite cocycle product | Defined over every scalar semiring |
| Zero, one, and successor values | Checked |
| Later-block-left pointwise one-sided cocycle identity | Checked |
| Measurability of every complex orbit factor | Checked |
| Measurability of every finite complex cocycle value | Checked |
| Generator-presented bundle over a measure-preserving base | Defined |
| Ordinary measurability of the bundled generator | Stored |
| Ordinary measurability of every bundled finite value | Checked |
| Preservation of \(\mu\) by every natural base iterate | Checked |
| Empty matrix coordinate type | Supported |
| Probability normalization of \(\mu\) | Not assumed or proved |
| Pushforward law of a cocycle value | Not defined |
| Ergodicity or mixing | Not assumed or proved |
| Independent-and-identically-distributed factor model | Not assumed or proved |
| Invertibility of base, factors, or cocycle values | Not assumed |
| Negative-time extension | Not defined |
| Two-sided group cocycle | Not defined |
| Skew-product invariance | Not stated |
| Product-law factorization | Not stated |
| Matrix norm or norm observable | Not chosen or defined |
| Norm or logarithmic-norm integrability | Not proved |
| Lyapunov exponent or asymptotic growth limit | Not defined or proved |
| Oseledets theorem or invariant splitting | Not invoked |
| Derivative or Jacobian product along a nonlinear orbit | Not connected |
| Stability, bifurcation, chaos, or physical-model theorem | Not claimed |

The new summit is structural: one measurable generator over a
measure-preserving forward base now produces a checked finite matrix cocycle.
Nothing in that sentence silently grants probability, ergodicity, analytic
growth, or asymptotic theory.

## Where to continue

[Finite-Time Norm and Extended-Log-Norm Observables for Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/finite-time-norm-and-extended-log-norm-cocycle-observables" >}})
is the immediate successor. It keeps this chapter's finite, one-sided cocycle
and adds a measurable maximum-row-sum norm observable, a zero-aware extended
log norm, and subadditivity across the shifted split. The
{{< refterm "extended-log-norm-observable" "extended log-norm observable" >}}
entry is the compact guide to the new endpoint and dimension policy.

The
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycle" >}}
glossary entry is the compact guide to the base orbit, generator presentation,
and shifted split law.

[Measurable Finite Random-Matrix Products and Proof-Carrying Pushforward Laws]({{< relref "/knowledge-base/deep-dives/measurable-finite-random-matrix-products-and-pushforward-laws" >}})
develops the immediate product and measurability layer below this cocycle.
[Ordered Finite Matrix Products and Operator-Norm Growth]({{< relref "/knowledge-base/deep-dives/ordered-finite-matrix-products-and-operator-norm-growth" >}})
develops the deterministic chronology and a specific finite norm bound.

RMT-14 now defines the finite norm and extended-log-norm observables without
claiming asymptotic exponents. Integrability, normalized growth, and the
hypotheses of subadditive or multiplicative ergodic theorems remain later
layers.

## References

<a id="ref-generator-cocycle-iterate"></a>**Mathlib contributors.**
[Function iteration](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Logic/Function/Iterate.html),
Mathlib 4 documentation. This official source defines natural-number
<code>Function.iterate</code> and its zero, successor, and addition laws.

<a id="ref-generator-cocycle-preserving"></a>**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation. This official source defines measure preservation as
measurability plus pushforward equality and proves preservation under
composition and natural-number iteration.

<a id="ref-generator-cocycle-arnold"></a>**Ludwig Arnold.**
[Random Dynamical Systems](https://doi.org/10.1007/978-3-662-12878-7),
Springer Monographs in Mathematics, 1998. This develops cocycles over metric
dynamical systems and the multiplicative ergodic setting. Its usual
probability, base-flow, integrability, and asymptotic hypotheses are future
layers here.

<a id="ref-generator-cocycle-oseledets"></a>**V. I. Oseledets.**
[A multiplicative ergodic theorem. Characteristic Ljapunov exponents of dynamical systems](https://www.mathnet.ru/eng/mmo214),
*Transactions of the Moscow Mathematical Society* 19 (1968), 197-231. This
primary source supplies the historical theorem behind Lyapunov exponents and
invariant splittings. RMT-13 establishes none of its analytic or asymptotic
hypotheses or conclusions.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
