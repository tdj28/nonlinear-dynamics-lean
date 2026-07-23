---
title: "Ergodicity"
slug: "ergodicity"
summary: "Ergodicity means that measure-preserving dynamics have no measurable invariant region of intermediate mass, or equivalently no nonconstant measurable invariant information after null sets are ignored."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.ErgodicBirkhoffLimit"
og_image: "ergodicity-card.png"
og_image_alt: "Two exact six-state systems with equal mass one sixth: one cycle has only empty and full invariant events and mean ten, while two sealed three-cycles retain half-mass components with means five and fifteen."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note. Human review
of the mathematics, Lean interpretation, sources, figures, and accessibility
remains pending. Publication lets readers follow the work; it does not mean
that review is complete.
{{< /panel >}}

## Start with six equally likely states

Let the space of possible states be

\[
\Omega=\{0,1,2,3,4,5\}.
\]

Give every state probability \(1/6\). Thus an
{{< refterm "event" "event" >}} \(S\subseteq\Omega\) has probability

\[
\mu(S)=\frac{|S|}{6},
\]

where \(|S|\) is the number of states in \(S\). Every subset is measurable in
this finite example.

Put the following real-valued observable on the states:

\[
\begin{array}{c|rrrrrr}
x&0&1&2&3&4&5\\ \hline
f(x)&2&5&8&11&14&20
\end{array}
\]

An **observable** is simply a quantity that can be read from the current
state. Here it is the function \(f:\Omega\to\mathbb R\).

We will keep the same states, probabilities, and observable while changing
only the time-one map.

### System A: one orbit visits all six states

Define

\[
T_{\mathrm{one}}:
0\mapsto1\mapsto2\mapsto3\mapsto4\mapsto5\mapsto0.
\]

This permutation preserves the uniform probability: the preimage of an event
has exactly as many points as the event itself. Starting at any state, six
steps visit every state exactly once. The six-step sum is

\[
2+5+8+11+14+20=60,
\]

so the six-step average is

\[
\frac{60}{6}=10.
\]

Now ask which events are unchanged by one step. An event \(S\) is **strictly
invariant** when

\[
T_{\mathrm{one}}^{-1}(S)=S.
\]

The symbol \(T^{-1}(S)\) means **preimage**, not an inverse function:

\[
x\in T^{-1}(S)
\quad\Longleftrightarrow\quad
T(x)\in S.
\]

If a strictly invariant event contains one state, moving forward around the
cycle shows that it contains all six. Therefore the complete invariant-event
list is

\[
\varnothing,\qquad \Omega,
\]

with probabilities \(0\) and \(1\). There is no invariant region holding a
proper positive fraction of the probability. The system is **ergodic**.

### System B: two sealed three-state orbits

Define instead

\[
\begin{aligned}
T_{\mathrm{split}}:\;&0\mapsto1\mapsto2\mapsto0,\\
&3\mapsto4\mapsto5\mapsto3.
\end{aligned}
\]

This map is also a permutation, so it preserves exactly the same uniform
probability. But the event

\[
L=\{0,1,2\}
\]

is now strictly invariant:

\[
T_{\mathrm{split}}^{-1}(L)=L,
\qquad
\mu(L)=\frac36=\frac12.
\]

Its complement \(R=\{3,4,5\}\) is also invariant and has probability \(1/2\).
The complete invariant-event list is

\[
\varnothing,\qquad L,\qquad R,\qquad\Omega,
\]

with probabilities \(0,1/2,1/2,1\). The half-probability events \(L\) and
\(R\) prove that this system is **not** ergodic.

The observable also exposes the split. Its average around the left orbit is

\[
\frac{2+5+8}{3}=5,
\]

while its average around the right orbit is

\[
\frac{11+14+20}{3}=15.
\]

Starting anywhere in \(L\), every complete three-step block averages to \(5\).
Starting anywhere in \(R\), every complete three-step block averages to
\(15\). The dynamics retain one bit of durable information: **which component
did the orbit start in?**

{{< reference-figure
  wide="true"
  src="finite-ergodicity-comparison.svg"
  alt="Six equally weighted states carry observable values two, five, eight, eleven, fourteen, and twenty. A single six-cycle has only empty and full invariant events, forces invariant functions to use one value, and gives every start the six-step average ten. Two separate three-cycles have invariant left and right halves of probability one half, permit an invariant function with values five and fifteen, and give component averages five and fifteen. For the single cycle, the overlap of the singleton zero with its n-step preimage is one sixth at multiples of six and zero otherwise, rather than approaching one thirty-six, so the ergodic cycle is not mixing."
  caption="**Exact finite comparison:** both maps preserve the uniform probability on six states. In the single cycle, an invariant event containing one point must contain the whole orbit, so its only invariant-event probabilities are \(0\) and \(1\); every invariant function is constant, and each full-cycle average of \(f=(2,5,8,11,14,20)\) is \(10\). In the split system, \(L=\{0,1,2\}\) and \(R=\{3,4,5\}\) are invariant events of probability \(1/2\); the function equal to \(5\) on \(L\) and \(15\) on \(R\) is invariant, and those are the two component averages. The bottom strip uses \(E=\{0\}\): its overlap with \(T_{\mathrm{one}}^{-n}E\) alternates periodically between \(1/6\) and \(0\), never approaching the mixing target \(1/36\). These are exact toy calculations, not empirical measurements or a proof for general spaces."
>}}

## What the example teaches

Ergodicity is a statement about **invariant information**, not about whether
an orbit moves.

- Both examples move every state and preserve probability.
- The one-cycle system eventually carries every start through the same six
  states.
- The split system never carries a point from \(L\) to \(R\) or from \(R\) to
  \(L\).
- The component label is therefore an invariant distinction with probability
  \(1/2\) on each side.

This page's six-state calculation complements
{{< refterm "ergodic-probability-base" "Ergodic probability base" >}}. That
entry separates probability normalization, measure preservation, and ergodic
rigidity. Here the focus is the exact information that survives, its
function-valued form, its effect on time averages, and its sharp separation
from mixing.

## The general definition

Let \((\Omega,\mathcal B)\) be a
{{< refterm "measurable-space" "measurable space" >}} and let \(\mu\) be a
measure on it:

- \(\Omega\) is the state space;
- \(\mathcal B\) is the collection of measurable events;
- \(\mu\) is a {{< refterm "measure" "measure" >}} assigning sizes to those
  events; and
- \(T:\Omega\to\Omega\) is the time-one map.

The map is
{{< refterm "measure-preserving-transformation" "measure preserving" >}} when
it is measurable and

\[
\mu(T^{-1}S)=\mu(S)
\]

for every measurable event \(S\).

The system is **ergodic** when it is measure preserving and every measurable
strictly invariant event is null or conull:

\[
T^{-1}S=S
\quad\Longrightarrow\quad
\mu(S)=0
\ \text{or}\
\mu(S^{\mathsf c})=0.
\]

Here \(S^{\mathsf c}=\Omega\setminus S\) is the complement of \(S\). A
{{< refterm "null-set" "null set" >}} has measure zero. A **conull** event has
a null complement, so it contains almost all measured states. On a
{{< refterm "probability-measure" "probability space" >}}, where
\(\mu(\Omega)=1\), the conclusion becomes

\[
\mu(S)=0
\quad\text{or}\quad
\mu(S)=1.
\]

The number \(1\) comes from probability normalization, not from ergodicity
alone. If the total mass were \(6\), a conull event would have mass \(6\).

{{< panel "warning" >}}
**The zero-one conclusion applies only to invariant measurable events.** In
the ergodic one-cycle example, \(\{0,1\}\) has probability \(1/3\). There is no
contradiction: its preimage is \(\{0,5\}\), so it is not invariant.
{{< /panel >}}

## Event form and function form

There are two closely related ways to detect invariant information.

### Invariant events

An invariant event asks a yes-or-no question whose answer never changes along
an orbit:

\[
\mathbf 1_S(Tx)=\mathbf 1_S(x).
\]

The indicator \(\mathbf 1_S\) equals \(1\) on \(S\) and \(0\) outside it. In
the split example, \(\mathbf 1_L\) records which of the two orbit components
contains \(x\).

### Invariant functions

A {{< refterm "measurable-function" "measurable function" >}}
\(g:\Omega\to\mathbb R\) is invariant when

\[
g\circ T=g,
\qquad\text{equivalently}\qquad
g(Tx)=g(x)
\]

for every \(x\). Such a function assigns one fixed value along each orbit.

For the one six-cycle, invariance forces the chain

\[
g(0)=g(1)=g(2)=g(3)=g(4)=g(5).
\]

For the split map, the function

\[
g(x)=
\begin{cases}
5,&x\in L,\\
15,&x\in R
\end{cases}
\]

is invariant and nonconstant. It stores the same component information as the
event \(L\).

In a general ergodic system, a suitably measurable invariant function is
constant {{< refterm "almost-everywhere" "almost everywhere" >}}. “Almost
everywhere” means that the equality may fail on a null set. It does not mean
pointwise equality at every state.

## Strict invariance versus invariance modulo null sets

Three set statements must be kept separate:

1. **Strict invariance:** \(T^{-1}S=S\) as literal sets.
2. **Almost invariance:** \(T^{-1}S\) and \(S\) differ only on a null set.
3. **Trivial modulo null sets:** \(S\) differs from \(\varnothing\) or
   \(\Omega\) only on a null set.

The symmetric difference

\[
\begin{aligned}
A\mathbin{\triangle}B
&=(A\setminus B)\cup(B\setminus A).
\end{aligned}
\]

contains the points on which membership in \(A\) and \(B\) disagrees.
Almost invariance can therefore be written

\[
\mu\!\left(T^{-1}S\mathbin{\triangle}S\right)=0.
\]

Equivalently, Mathlib writes equality of the sets almost everywhere:

\[
T^{-1}S =_{\mu\text{-a.e.}} S.
\]

In the finite uniform six-state model, every nonempty event has positive
probability. The only null event is \(\varnothing\), so equality modulo null
sets is exactly ordinary equality. That is why the finite list of invariant
events can be computed without qualifications.

General spaces can have nonempty null sets. Suppose \(N\) is null and \(T\)
preserves \(\mu\). Then \(T^{-1}N\) is also null, and

\[
T^{-1}N\mathbin{\triangle}N
\subseteq T^{-1}N\cup N
\]

is null. Thus \(N\) is almost invariant even if
\(T^{-1}N\ne N\) pointwise. This is not a violation of ergodicity: \(N\)
already represents the same measured event as \(\varnothing\).

Mathlib exposes this distinction deliberately:

- <code>PreErgodic</code> is defined using **strict** invariance of a
  measurable set;
- <code>QuasiErgodic.ae_empty_or_univ₀</code> accepts a
  null-measurable, **almost invariant** set; and
- every <code>Ergodic</code> map yields the needed
  <code>QuasiErgodic</code> interface through
  <code>hT.quasiErgodic</code>.

The subscript zero in these Mathlib theorem names is part of the library
identifier; it is not the probability value zero.

## Ergodic does not mean mixing

Ergodicity rules out invariant distinctions. **Strong mixing** asks for a
different, stronger property: widely separated observations should lose their
correlation. On a probability space, one standard form is

\[
\mu\!\left(E\cap T^{-n}F\right)
\longrightarrow
\mu(E)\mu(F)
\qquad(n\to\infty)
\]

for every pair of measurable events \(E,F\).

Return to the ergodic six-cycle and take

\[
E=F=\{0\}.
\]

Because the orbit returns to \(0\) exactly at multiples of six,

\[
\mu\!\left(E\cap T_{\mathrm{one}}^{-n}E\right)
{} =
\begin{cases}
1/6,&6\mid n,\\
0,&6\nmid n.
\end{cases}
\]

Here \(6\mid n\) means that \(6\) divides \(n\). The proposed mixing target is

\[
\mu(E)\mu(E)=\frac16\cdot\frac16=\frac1{36}.
\]

The overlap keeps cycling between \(1/6\) and \(0\), so it does not converge
to \(1/36\). The map is ergodic but not mixing.

There is no paradox:

- ergodicity asks whether any event is unchanged forever;
- mixing asks whether long-lag overlaps approach a product; and
- a periodic orbit can have no proper invariant event while retaining perfect
  timing information.

The same example shows that ergodicity of \(T\) need not pass to every power.
Since \(T_{\mathrm{one}}^6=\operatorname{id}\), every event is invariant under
the sixth power, so \(T_{\mathrm{one}}^6\) is not ergodic.

## Why time averages enter the story

For an observable \(f:\Omega\to\mathbb R\), the \(n\)-step Birkhoff average is

\[
\begin{aligned}
A_n f(x)
&=\frac1n\sum_{k=0}^{n-1}f(T^k x),
\end{aligned}
\qquad n\ge1.
\]

The notation \(T^k\) means apply \(T\) \(k\) times, as developed under
{{< refterm "orbit-and-iterate" "orbit and iterate" >}}. In the one six-cycle,
every block of six consecutive observations contains the same six values, so

\[
A_{6m}f(x)=10
\]

for every start \(x\) and every positive integer \(m\).

In the split system,

\[
A_{3m}f(x)=
\begin{cases}
5,&x\in L,\\
15,&x\in R.
\end{cases}
\]

The nonergodic limit is an invariant function: it is constant on each orbit
component but not globally constant. Ergodicity is exactly the rigidity that
collapses such invariant measurable targets to one almost-everywhere
constant.

The project's RMT-28 theorem applies this to the
{{< refterm "conditional-expectation" "conditional expectation" >}} onto the
{{< refterm "invariant-sigma-algebra" "invariant sigma algebra" >}}. Under an
ergodic probability measure and
{{< refterm "integrability" "integrability" >}} of \(f\), it identifies the
almost-everywhere Birkhoff limit with the ordinary integral

\[
\int_\Omega f\,d\mu.
\]

Ergodicity by itself is not a convergence theorem. The Birkhoff theorem,
measurability, integrability, and measure preservation still do real work.

{{< reference-figure
  wide="true"
  src="ergodicity-invariant-information.svg"
  alt="Measure preservation and pre-ergodic invariant-set rigidity are shown as separate inputs. Together they form full ergodicity. The rigidity input makes invariant measurable outputs constant almost everywhere, while null-set exceptions remain allowed."
  caption="**Mathlib's interface split:** <code>PreErgodic</code> supplies the invariant-information rigidity used to collapse exact invariant measurable functions almost everywhere. <code>Ergodic</code> also contains measure preservation, which is needed when the project invokes the preceding Birkhoff convergence theorem. The diagram does not assert mixing, independence, pointwise constancy, or literal equality of the invariant sigma algebra with the bottom sigma algebra."
>}}

## In Lean: the same ideas in exact syntax

### 1. Say that an event is strictly invariant

{{< lean-bridge
  human="The event S is unchanged when we pull it back through one time step T."
  math="\(\displaystyle T^{-1}(S)=S.\)"
  lean="T ⁻¹' S = S"
>}}

A human types:

~~~lean
#check T ⁻¹' S = S
~~~

The important symbols are:

- <code>T</code> is a function from states to states;
- <code>⁻¹'</code> is Lean's set-preimage operator;
- <code>S</code> is a <code>Set Ω</code>; and
- <code>=</code> is literal equality of sets, not equality modulo null sets.

No inverse function is being assumed. Lean reads
<code>x ∈ T ⁻¹' S</code> as <code>T x ∈ S</code>.
{{< /lean-bridge >}}

### 2. Separate pre-ergodic rigidity from full ergodicity

{{< lean-bridge
  human="Every measurable strictly invariant event is empty or full after null sets are ignored."
  math="\(\displaystyle T^{-1}S=S\Longrightarrow S=_{\mu\text{-a.e.}}\varnothing\ \text{or}\ S=_{\mu\text{-a.e.}}\Omega.\)"
  lean="hpre.ae_empty_or_univ hS hInv"
>}}

Mathlib's exact structures are:

~~~lean
structure PreErgodic (T : Ω → Ω) (μ : Measure Ω) : Prop where
  aeconst_set ⦃S : Set Ω⦄ :
    MeasurableSet S →
    T ⁻¹' S = S →
    EventuallyConst S (ae μ)

structure Ergodic (T : Ω → Ω) (μ : Measure Ω) : Prop extends
  MeasurePreserving T μ μ, PreErgodic T μ
~~~

The source uses implicit variables and a default measure argument; the excerpt
above renames them for readability without changing the fields. A human asks
for the interfaces and consequences with:

~~~lean
#check PreErgodic T μ
#check Ergodic T μ
#check hT.toPreErgodic
#check hT.toMeasurePreserving
#check hpre.ae_empty_or_univ hS hInv
#check hpre.measure_self_or_compl_eq_zero hS hInv
~~~

Token map:

- <code>hpre : PreErgodic T μ</code> is evidence of invariant-set rigidity;
- <code>hT : Ergodic T μ</code> contains both required fields;
- <code>hS : MeasurableSet S</code> says \(S\) belongs to the measurable
  space;
- <code>hInv : T ⁻¹' S = S</code> is strict invariance;
- <code>ae μ</code> is the filter of statements true almost everywhere with
  respect to \(\mu\); and
- <code>EventuallyConst S (ae μ)</code> says membership in \(S\) is eventually
  one constant truth value in that filter.
{{< /lean-bridge >}}

### 3. Read the probability zero-one law

{{< lean-bridge
  human="On a probability space, every measurable strictly invariant event has probability zero or probability one."
  math="\(\displaystyle T^{-1}S=S\Longrightarrow\mu(S)=0\ \text{or}\ \mu(S)=1.\)"
  lean="hpre.prob_eq_zero_or_one hS hInv"
>}}

With <code>[IsProbabilityMeasure μ]</code> in scope, a human types:

~~~lean
#check hpre.prob_eq_zero_or_one hS hInv
~~~

- Square brackets tell Lean to find the probability-normalization instance.
- <code>prob_eq_zero_or_one</code> is a theorem in the
  <code>PreErgodic</code> namespace.
- Its result is a logical disjunction, written <code>∨</code>.
- The conclusion uses \(1\) because the measure is normalized to total mass
  one.
{{< /lean-bridge >}}

### 4. Move from strict to almost invariance

{{< lean-bridge
  human="If an event differs from its one-step preimage only on a null set, ergodicity still makes it empty or full modulo null sets."
  math="\(\displaystyle T^{-1}S=_{\mu\text{-a.e.}}S\Longrightarrow S=_{\mu\text{-a.e.}}\varnothing\ \text{or}\ S=_{\mu\text{-a.e.}}\Omega.\)"
  lean="hT.quasiErgodic.ae_empty_or_univ₀ hNullMeas hAeInv"
>}}

A human types:

~~~lean
#check hT.quasiErgodic
#check hT.quasiErgodic.ae_empty_or_univ₀ hNullMeas hAeInv
~~~

- <code>hNullMeas : NullMeasurableSet S μ</code> permits changing \(S\) on a
  null set to obtain a measurable representative.
- <code>hAeInv : T ⁻¹' S =ᵐ[μ] S</code> is almost-everywhere equality of the
  two set-valued membership predicates.
- <code>=ᵐ[μ]</code> is pronounced “equal almost everywhere with respect to
  \(\mu\).”
- <code>hT.quasiErgodic</code> converts full ergodicity to the Mathlib
  interface whose theorem accepts almost invariance.
{{< /lean-bridge >}}

### 5. Collapse an invariant function

{{< lean-bridge
  human="A strongly measurable function that is unchanged almost everywhere by one time step is almost everywhere one constant."
  math="\(\displaystyle g\circ T=_{\mu\text{-a.e.}}g\Longrightarrow\exists c,\ g=_{\mu\text{-a.e.}}(x\mapsto c).\)"
  lean="hT.ae_eq_const_of_ae_eq_comp_ae hg hGInv"
>}}

For a real-valued \(g\), a human types:

~~~lean
#check hT.ae_eq_const_of_ae_eq_comp_ae hg hGInv
~~~

The inputs and output are:

- <code>hg : AEStronglyMeasurable g μ</code> is the almost-everywhere strong
  measurability certificate;
- <code>hGInv : g ∘ T =ᵐ[μ] g</code> says composition with \(T\) does not
  change \(g\), except possibly on a null set;
- <code>∘</code> is function composition, so
  <code>(g ∘ T) x</code> reduces to <code>g (T x)</code>; and
- the theorem returns <code>∃ c, g =ᵐ[μ] Function.const Ω c</code>.

This is the general version of “one value on the single six-cycle.” In the
split example the nonconstant component-label function shows exactly why the
ergodic hypothesis cannot be dropped.
{{< /lean-bridge >}}

### 6. Identify the ergodic Birkhoff limit

{{< lean-bridge
  human="For an integrable real observable on an ergodic probability system, the full sequence of time averages converges to the space average for almost every starting state."
  math="\(\displaystyle A_n f(\omega)\longrightarrow\int_\Omega f\,d\mu\quad\text{for }\mu\text{-almost every }\omega.\)"
  lean="ae_tendsto_birkhoffAverage_integral_of_ergodic hT hf"
>}}

The checked project theorem is:

~~~lean
theorem ae_tendsto_birkhoffAverage_integral_of_ergodic
    [IsProbabilityMeasure μ]
    (hT : Ergodic T μ) (hf : Integrable f μ) :
    ∀ᵐ ω ∂μ,
      Tendsto (fun n ↦ birkhoffAverage ℝ T f n ω) atTop
        (nhds (∫ x, f x ∂μ))
~~~

A human types:

~~~lean
#check ae_tendsto_birkhoffAverage_integral_of_ergodic hT hf
~~~

Read it left to right:

- <code>∀ᵐ ω ∂μ</code> means “for almost every \(\omega\) with respect to
  \(\mu\)”;
- <code>birkhoffAverage ℝ T f n ω</code> is the project's totalized
  \(n\)-step time average;
- <code>Tendsto ... atTop</code> means convergence as natural \(n\) becomes
  arbitrarily large;
- <code>nhds a</code> is the neighborhood filter around the proposed limit
  \(a\); and
- <code>∫ x, f x ∂μ</code> is the integral, equal to the ordinary probability
  {{< refterm "expectation" "expectation" >}} when \(\mu\) has total mass one.

This theorem uses full <code>Ergodic</code>. The preceding conditional-
expectation identification needs only <code>PreErgodic</code>, but the
Birkhoff convergence input needs measure preservation.
{{< /lean-bridge >}}

## Exact source excerpts

**Resource label: pinned Mathlib.** The repository's pinned
[<code>Mathlib/Dynamics/Ergodic/Ergodic.lean</code>](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Ergodic.lean#L40-L76)
contains:

~~~lean
structure PreErgodic (f : α → α) (μ : Measure α := by volume_tac) : Prop where
  aeconst_set ⦃s : Set α⦄ :
    MeasurableSet s → f ⁻¹' s = s → EventuallyConst s (ae μ)

structure Ergodic (f : α → α) (μ : Measure α := by volume_tac) : Prop extends
  MeasurePreserving f μ μ, PreErgodic f μ

theorem PreErgodic.prob_eq_zero_or_one
    [IsProbabilityMeasure μ]
    (hf : PreErgodic f μ) (hs : MeasurableSet s)
    (hs' : f ⁻¹' s = s) :
    μ s = 0 ∨ μ s = 1
~~~

The same file's almost-invariant interface is:

~~~lean
theorem QuasiErgodic.ae_empty_or_univ₀
    (hf : QuasiErgodic f μ)
    (hsm : NullMeasurableSet s μ)
    (hs : f ⁻¹' s =ᵐ[μ] s) :
    s =ᵐ[μ] (∅ : Set α) ∨ s =ᵐ[μ] Set.univ
~~~

**Resource label: pinned Mathlib.**
[<code>Mathlib/Dynamics/Ergodic/Function.lean</code>](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Function.lean#L97-L106)
contains:

~~~lean
theorem Ergodic.ae_eq_const_of_ae_eq_comp_ae
    {g : α → X} (h : Ergodic f μ)
    (hgm : AEStronglyMeasurable g μ)
    (hg_eq : g ∘ f =ᵐ[μ] g) :
    ∃ c, g =ᵐ[μ] Function.const α c
~~~

**Resource label: checked project source.**
[<code>ErgodicBirkhoffLimit.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/ErgodicBirkhoffLimit.lean)
uses the two projections separately:

~~~lean
filter_upwards
    [ae_tendsto_birkhoffAverage_condExp hT.toMeasurePreserving hf,
      condExp_invariants_ae_eq_integral_of_preErgodic
        (T := T) (f := f) hT.toPreErgodic hf]
    with ω hconv htarget
simpa only [htarget] using hconv
~~~

The first line supplies orbit-average convergence to an invariant conditional
expectation. The second collapses that invariant target to the integral. The
proof therefore records which half of ergodicity does which job.

## Tiny local Lean/Std worksheet

**Resource label: standalone finite computation.** This worksheet imports only
<code>Std</code>. It enumerates all \(64\) events, computes the invariant-event
lists for the two six-state maps, checks the component-label function, prints
six-step orbit sums, and prints the singleton-overlap pattern. It does not
formalize measure theory or prove the general ergodic theorem.

Save the following as <code>ErgodicityFiniteScratch.lean</code>:

~~~lean
import Std

def states : List Nat :=
  List.range 6

def oneCycle (x : Nat) : Nat :=
  (x + 1) % 6

def splitCycles (x : Nat) : Nat :=
  if x < 3 then
    (x + 1) % 3
  else
    3 + (x - 3 + 1) % 3

def subsets : List (List Nat) :=
  states.foldr
    (fun x acc => acc ++ acc.map (fun event => x :: event))
    [[]]

def preimage (T : Nat → Nat) (event : List Nat) : List Nat :=
  states.filter fun x => event.contains (T x)

def invariant (T : Nat → Nat) (event : List Nat) : Bool :=
  preimage T event == event

def invariantEvents (T : Nat → Nat) : List (List Nat) :=
  subsets.filter fun event => invariant T event

def observable : Nat → Int
  | 0 => 2
  | 1 => 5
  | 2 => 8
  | 3 => 11
  | 4 => 14
  | 5 => 20
  | _ => 0

def componentMean (x : Nat) : Int :=
  if x < 3 then 5 else 15

def invariantFunction (T : Nat → Nat) (g : Nat → Int) : Bool :=
  states.all fun x => decide (g (T x) = g x)

def iterate (T : Nat → Nat) : Nat → Nat → Nat
  | 0, x => x
  | n + 1, x => T (iterate T n x)

def orbitValues
    (T : Nat → Nat) (start steps : Nat) : List Int :=
  (List.range steps).map fun n => observable (iterate T n start)

def orbitSum
    (T : Nat → Nat) (start steps : Nat) : Int :=
  (orbitValues T start steps).foldl (fun total x => total + x) 0

def overlapCount
    (T : Nat → Nat) (event : List Nat) (n : Nat) : Nat :=
  ((preimage (fun x => iterate T n x) event).filter
    (fun x => event.contains x)).length

#eval invariantEvents oneCycle
#eval invariantEvents splitCycles
#eval invariantFunction oneCycle componentMean
#eval invariantFunction splitCycles componentMean
#eval states.map fun x =>
  (x, orbitValues oneCycle x 6, orbitSum oneCycle x 6)
#eval states.map fun x =>
  (x, orbitValues splitCycles x 6, orbitSum splitCycles x 6)
#eval (List.range 13).map fun n =>
  (n, overlapCount oneCycle [0] n)
~~~

Run it on an ordinary Mac or Linux machine with the pinned small toolchain:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean ErgodicityFiniteScratch.lean
~~~

This exact worksheet was executed successfully with the pinned Lean 4.32.0
compiler on the Mac and printed:

~~~text
[[], [0, 1, 2, 3, 4, 5]]
[[], [3, 4, 5], [0, 1, 2], [0, 1, 2, 3, 4, 5]]
false
true
[(0, [2, 5, 8, 11, 14, 20], 60),
 (1, [5, 8, 11, 14, 20, 2], 60),
 (2, [8, 11, 14, 20, 2, 5], 60),
 (3, [11, 14, 20, 2, 5, 8], 60),
 (4, [14, 20, 2, 5, 8, 11], 60),
 (5, [20, 2, 5, 8, 11, 14], 60)]
[(0, [2, 5, 8, 2, 5, 8], 30),
 (1, [5, 8, 2, 5, 8, 2], 30),
 (2, [8, 2, 5, 8, 2, 5], 30),
 (3, [11, 14, 20, 11, 14, 20], 90),
 (4, [14, 20, 11, 14, 20, 11], 90),
 (5, [20, 11, 14, 20, 11, 14], 90)]
[(0, 1), (1, 0), (2, 0), (3, 0), (4, 0), (5, 0), (6, 1), (7, 0), (8, 0), (9, 0), (10, 0), (11, 0), (12, 1)]
~~~

The first function check printed <code>false</code>; the second printed
<code>true</code>. Every one-cycle six-step sum is \(60\). Split starts
\(0,1,2\) have sum \(30\), and starts \(3,4,5\) have sum \(90\). The overlap
count for \(\{0\}\) is \(1\) at \(n=0,6,12\) and \(0\) at the other displayed
times.

Dividing those counts by six gives the overlap probabilities in the figure.
The worksheet is an executable audit of the finite arithmetic, not a proof
that an abstract measure-preserving system is ergodic. It imports only
<code>Std</code> and does not load the project or Mathlib.

## Try it in the repository

{{< repo-check >}}
**Resource label: pinned project plus Mathlib, cloud-only.** On an approved
Linux builder, a human can create a worksheet containing:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.ErgodicBirkhoffLimit

open MeasureTheory Set Filter Function ProbabilityTheory
open NonlinearDynamics.Random.RandomCocycles
open scoped ENNReal Topology BigOperators

universe uΩ

variable {Ω : Type uΩ} [MeasurableSpace Ω]
variable {T : Ω → Ω} {μ : Measure Ω}
variable {S : Set Ω} {f g : Ω → ℝ}
variable [IsProbabilityMeasure μ]

variable (hpre : PreErgodic T μ)
variable (hT : Ergodic T μ)
variable (hS : MeasurableSet S)
variable (hInv : T ⁻¹' S = S)
variable (hNullMeas : NullMeasurableSet S μ)
variable (hAeInv : T ⁻¹' S =ᵐ[μ] S)
variable (hg : AEStronglyMeasurable g μ)
variable (hGInv : g ∘ T =ᵐ[μ] g)
variable (hf : Integrable f μ)

#check PreErgodic
#check Ergodic
#check QuasiErgodic
#check hT.toPreErgodic
#check hT.toMeasurePreserving
#check hT.quasiErgodic
#check hpre.ae_empty_or_univ hS hInv
#check hpre.measure_self_or_compl_eq_zero hS hInv
#check hpre.prob_eq_zero_or_one hS hInv
#check hT.quasiErgodic.ae_empty_or_univ₀ hNullMeas hAeInv
#check hT.ae_eq_const_of_ae_eq_comp_ae hg hGInv
#check condExp_invariants_comp
#check condExp_invariants_ae_eq_integral_of_preErgodic
#check ae_tendsto_birkhoffAverage_integral_of_ergodic hT hf
~~~

Each <code>#check</code> asks the pinned elaborator for the declaration's exact
type. The current project leaf is checked with:

~~~sh
CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/Random/RandomCocycles/ErgodicBirkhoffLimit.lean
~~~

The full repository gate is:

~~~sh
CLOUD_LEAN_BUILD=1 make check
~~~

Per repository policy, these project and Mathlib commands belong on an
approved Linux cloud builder with the pinned cache. Do not run them on the Mac
workstation.
{{< /repo-check >}}

## Boundary cases and common traps

### Identity dynamics

If \(T=\operatorname{id}\), every event is strictly invariant. On two atoms
with positive mass, either singleton is a positive-mass invariant event with a
positive-mass complement. The system is not pre-ergodic and therefore not
ergodic. A function that assigns different values to the atoms is invariant
and nonconstant.

### A Dirac measure

A Dirac measure places all mass at one point. Every event is then null or
conull, so <code>PreErgodic T μ</code> can hold even when \(T\) does not
preserve \(\mu\). The project compiles such a boundary model. It shows why
pre-ergodic rigidity and measure preservation are distinct assumptions.

### The zero measure

Mathlib permits the zero measure to be ergodic for a measurable map. Every
event is both null and conull, and every almost-everywhere statement is
vacuous. Consequently,

\[
\text{ergodic}
\quad\not\Longrightarrow\quad
\mu\ne0.
\]

The project's finite-mass normalization theorem keeps a separate
\(\mu\ne0\) premise before it divides by total mass.

### Noninvertible maps

The notation \(T^{-1}S\) is defined for every function. Ergodicity does not
require \(T\) to have an inverse. The project includes an ergodic Dirac example
whose map is neither injective nor surjective.

### Exact invariant sigma algebra

Ergodicity says that invariant measurable information is trivial **modulo
null sets**. It does not generally prove that Mathlib's exact
{{< refterm "invariant-sigma-algebra" "invariant sigma algebra" >}} is
literally the smallest measurable space as a structure.

## What ergodicity does not establish

Ergodicity alone does not prove:

- mixing, weak mixing, decay of correlations, or statistical independence;
- ergodicity of every powered map \(T^n\);
- injectivity, surjectivity, or invertibility of \(T\);
- that null sets are empty or impossible;
- pointwise constancy rather than almost-everywhere constancy;
- literal equality of the exact invariant sigma algebra with the bottom sigma
  algebra;
- measurability or {{< refterm "integrability" "integrability" >}} of an
  arbitrary observable;
- a Birkhoff convergence theorem without its additional hypotheses;
- a convergence rate for Birkhoff averages;
- thermalization, chaos in every sense, positive entropy, or sensitive
  dependence;
- a Lyapunov exponent, an Oseledets splitting, or a Kingman limit.

The exact promise is narrower: after measurable null distinctions are
discarded, the dynamics retain no nontrivial invariant event and no
nonconstant suitably measurable invariant observable.

## Related concepts

- {{< refterm "event" "Event" >}} introduces measurable yes-or-no questions.
- {{< refterm "measurable-space" "Measurable space" >}} specifies which sets
  may be assigned measure.
- {{< refterm "measurable-function" "Measurable function" >}} is the analytic
  interface required of invariant observables.
- {{< refterm "null-set" "Null set" >}} explains why measure zero is not the
  same as logical impossibility.
- {{< refterm "almost-everywhere" "Almost everywhere" >}} formalizes equality
  after null exceptions are ignored.
- {{< refterm "measure-preserving-transformation" "Measure-preserving transformation" >}}
  supplies the dynamical half of full ergodicity.
- {{< refterm "ergodic-probability-base" "Ergodic probability base" >}}
  separates mass-one normalization, preservation, and rigidity.
- {{< refterm "invariant-sigma-algebra" "Invariant sigma algebra" >}} gathers
  exact invariant measurable events.
- {{< refterm "conditional-expectation" "Conditional expectation" >}} is the
  general Birkhoff target before ergodic rigidity collapses it.
- [Birkhoff Limits, Invariant Sigma Algebras, and Conditional Expectation]({{< relref "/knowledge-base/deep-dives/birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation" >}})
  develops the nonergodic predecessor.
- [Ergodic Birkhoff Limits and Normalized Space Averages]({{< relref "/knowledge-base/deep-dives/ergodic-birkhoff-limits-and-normalized-space-averages" >}})
  proves the probability and finite-mass endpoints used by the project.

## References

<a id="ref-ergodicity-mathlib"></a>**Mathlib contributors.**
[Ergodic structures](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Ergodic.lean#L40-L156)
and
[invariant-function theorems](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Function.lean),
Mathlib 4.32.0 at pinned commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).
These are authoritative for the exact <code>PreErgodic</code>,
<code>QuasiErgodic</code>, and <code>Ergodic</code> interfaces used here.

<a id="ref-ergodicity-pollicott-yuri"></a>**Mark Pollicott and Michiko Yuri.**
[Ergodic measures](https://doi.org/10.1017/CBO9781139173049.011), chapter 9 of
*Dynamical Systems and Ergodic Theory*, Cambridge University Press, 1998.
Textbook source for invariant sets, invariant functions, and the distinction
between ergodicity and mixing.

<a id="ref-ergodicity-project"></a>**Nonlinear Dynamics in Lean contributors.**
[ErgodicBirkhoffLimit.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/ErgodicBirkhoffLimit.lean),
the checked project source for the minimized rigidity and convergence
interfaces and their boundary probes.
