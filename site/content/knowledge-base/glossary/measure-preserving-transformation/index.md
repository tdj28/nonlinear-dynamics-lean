---
title: "Measure-preserving transformation"
slug: "measure-preserving-transformation"
summary: "A measure-preserving transformation is measurable and leaves the entire measure unchanged, so every measurable event and its preimage have equal mass."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.BirkhoffConvergence"
og_image: "measure-preserving-transformation-card.png"
og_image_alt: "A fair four-state cycle preserves every event's mass, while a many-to-one collapse doubles the preimage mass of a singleton."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working note. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is public so readers can follow the work while that review is
still open.
{{< /panel >}}

A **measure-preserving transformation** moves outcomes without changing their
overall statistical mass. If \(T:\Omega\to\Omega\) preserves a
{{< refterm "measure" "measure" >}} \(\mu\), then every measurable
{{< refterm "event" "event" >}} \(A\) satisfies

\[
\mu\bigl(T^{-1}(A)\bigr)=\mu(A).
\]

The preimage \(T^{-1}(A)\) is the set of starting states that land in \(A\)
after one step. Preservation compares the mass of that set of starters with
the mass already assigned to the target event. The equation must hold for
every measurable event, not merely for one convenient example.

## Start with four equally weighted states

Let

\[
\Omega=\{0,1,2,3\},
\qquad
\mathbb P(\{i\})=\frac14
\quad\text{for each }i.
\]

Every subset is measurable. Define the cyclic transformation

\[
T(0)=1,\qquad
T(1)=2,\qquad
T(2)=3,\qquad
T(3)=0.
\]

Equivalently, \(T(i)=i+1\pmod 4\). Take the event

\[
A=\{0,1\}.
\]

To find its preimage, ask which starting states land in \(0\) or \(1\).
State \(3\) lands in \(0\), and state \(0\) lands in \(1\), so

\[
T^{-1}(A)=\{3,0\}.
\]

The sets are different, but their masses agree:

\[
\mathbb P\bigl(T^{-1}(A)\bigr)
=\mathbb P(\{3,0\})
=\frac24
=\frac12
=\mathbb P(A).
\]

For the singleton event \(B=\{2\}\), the preimage is
\(T^{-1}(B)=\{1\}\), and both masses are \(1/4\).

These checks are instances of a general finite argument. The cycle is a
permutation, so the preimage of every subset contains exactly as many states
as the subset itself. Uniform mass depends only on that count. Therefore

\[
\mathbb P\bigl(T^{-1}(S)\bigr)=\mathbb P(S)
\]

for every \(S\subseteq\Omega\), and \(T\) preserves \(\mathbb P\).

{{< reference-figure
  src="four-state-preservation.svg"
  alt="Four equally weighted states form a directed cycle. Event A contains states zero and one, while its preimage contains three and zero; both have mass one half. A second many-to-one map sends zero and one to zero and sends two and three to two. Under that map the singleton zero has a two-state preimage of mass one half instead of one quarter, although the event containing zero and one happens to keep mass one half."
  caption="**Finding:** the four-cycle \(T\) permutes four quarter-mass states. For \(A=\{0,1\}\), its preimage is \(\{3,0\}\), so both masses are \(2/4=1/2\); the same counting argument works for every event. The collapse \(C(0)=C(1)=0\) and \(C(2)=C(3)=2\) is measurable but fails on \(F=\{0\}\), because \(\mathbb P(C^{-1}(F))=1/2\ne1/4=\mathbb P(F)\). It happens to pass on \(E=\{0,1\}\), proving that one successful event is not enough. The final strip separates preservation from ergodicity by using the measure-preserving identity map, whose positive-mass singleton events remain invariant."
>}}

## The definition uses preimages, not images

Let \((\Omega,\mathcal F,\mu)\) be a measure space. A self-map
\(T:\Omega\to\Omega\) is measure preserving when:

1. \(T\) is measurable; and
2. the pushforward of \(\mu\) through \(T\) equals \(\mu\):

   \[
   T_*\mu=\mu.
   \]

By the definition of pushforward, the second condition says that every
measurable \(A\in\mathcal F\) obeys

\[
(T_*\mu)(A)=\mu(T^{-1}(A))=\mu(A).
\]

Preimages are essential. The direct image \(T(A)\) asks where points in \(A\)
go. The preimage asks which starting points will be observed inside the target
event \(A\), which is exactly what pushforward measure evaluates.

The definition also works between different measured spaces, with a source
measure \(\mu_a\) and target measure \(\mu_b\). In that setting preservation
means \(T_*\mu_a=\mu_b\). Dynamical systems usually use the self-map case
\(\mu_a=\mu_b=\mu\).

## A measurable collapse that fails preservation

On the same four-state probability space, define

\[
C(0)=0,\qquad
C(1)=0,\qquad
C(2)=2,\qquad
C(3)=2.
\]

Because every subset of this finite space is measurable, every function from
\(\Omega\) to itself is measurable. In particular, \(C\) is measurable.

Now test the singleton event

\[
F=\{0\}.
\]

Two states collapse into \(0\), so

\[
C^{-1}(F)=\{0,1\}.
\]

Consequently,

\[
\mathbb P\bigl(C^{-1}(F)\bigr)=\frac12
\ne\frac14=\mathbb P(F).
\]

This one failed measurable event proves that \(C\) is not measure preserving.
The pushforward law has mass \(1/2\) at \(0\), mass \(1/2\) at \(2\), and no
mass at \(1\) or \(3\). It is not the original uniform law.

The example isolates the difference:

- **measurability** guarantees that preimages of measurable events are still
  measurable;
- **measure preservation** additionally requires those preimages to have the
  correct masses.

Measurability makes the comparison legal. It does not make the equality true.

## One event cannot certify the whole measure

The same collapsing map passes a nontrivial test. Let

\[
E=\{0,1\}.
\]

Since \(C\) only takes the values \(0\) and \(2\),

\[
C^{-1}(E)=\{0,1\}=E,
\]

and hence

\[
\mathbb P(C^{-1}(E))=\frac12=\mathbb P(E).
\]

The whole-space event also always passes for any self-map:

\[
C^{-1}(\Omega)=\Omega.
\]

Neither equality proves preservation. Equality of measures means agreement on
every measurable event. A single witness can disprove preservation, as
\(F=\{0\}\) did, but a single successful event cannot prove it.

There is another distinction hiding here. An event is **invariant** when
\(T^{-1}(A)=A\) as sets. Under the four-cycle, the earlier event
\(A=\{0,1\}\) is not invariant because its preimage is \(\{3,0\}\), yet its
mass is preserved. A measure-preserving map need not fix individual events; it
must preserve the mass of all of them.

## Preservation is not ergodicity

{{< refterm "ergodicity" "Ergodicity" >}} is a rigidity property added on top
of measure preservation. A measure-preserving system is ergodic when every
measurable invariant event is null or conull.

The four-cycle is ergodic under the uniform probability measure. If a set is
unchanged by taking its one-step preimage, membership of one state forces
membership of the next state around the entire cycle. The only invariant sets
are therefore \(\varnothing\) and \(\Omega\).

But preservation alone does not imply ergodicity. The identity map

\[
I(i)=i
\]

preserves every measure, because \(I^{-1}(A)=A\) for every event. On the
four-state uniform space, each singleton is an invariant event of mass \(1/4\).
Those intermediate-mass invariant events show that the identity system is not
ergodic.

Thus the logical relationship is:

\[
\text{ergodic}
\quad\Longrightarrow\quad
\text{measure preserving},
\]

while the converse fails.

## Why orbit averages need preservation

A Birkhoff sum samples an observable \(g\) along an orbit:

\[
S_n g(\omega)=\sum_{j=0}^{n-1}g(T^j\omega).
\]

If \(T\) preserves \(\mu\), then every iterate \(T^j\) also preserves
\(\mu\). Pulling \(g\) back along \(T^j\) therefore leaves its distributional
mass controlled. In particular, if \(g\) is integrable, then
\(g\circ T^j\) is integrable. The project's finite Birkhoff-sum theorem adds
these integrable orbit terms.

This use of preservation does not assume ergodicity. Integrability of finite
orbit sums needs stable mass under the dynamics. Identifying a long-time limit
with a constant requires additional rigidity.

## In Lean: the event equation

{{< lean-bridge
  human="The outcomes that T sends into the measurable event A have exactly the same mu-mass as A."
  math="\(A\in\mathcal F\Longrightarrow\mu(T^{-1}(A))=\mu(A).\)"
  lean="μ (T ⁻¹' A) = μ A"
>}}

- <code>μ</code> has type <code>Measure Ω</code>.
- <code>T : Ω → Ω</code> is the transformation.
- <code>A : Set Ω</code> is the target event.
- <code>T ⁻¹' A</code> is Lean's preimage notation. It collects every
  <code>ω</code> for which <code>T ω ∈ A</code>. The token
  <code>⁻¹'</code> denotes a set preimage, not an inverse function.
- <code>μ (T ⁻¹' A)</code> is ordinary function application: evaluate the
  measure on the preimage set.
- <code>μ A</code> is the mass of the original event.
- A human types the displayed equality inside an <code>example</code> or
  theorem after declaring <code>μ</code>, <code>T</code>, and <code>A</code>.
  The complete worksheet below also supplies the measurability certificate.
{{< /lean-bridge >}}

Mathlib packages the global property as one proof object:

{{< lean-bridge
  human="T is measurable, and pushing the source measure mu through T returns that same measure mu."
  math="\(T\text{ is measurable}\quad\text{and}\quad T_*\mu=\mu.\)"
  lean="hT : MeasurePreserving T μ μ"
>}}

- <code>MeasurePreserving</code> is a proposition-valued structure with a
  measurability field and a pushforward-measure equality field.
- The first <code>μ</code> is the source measure and the second is the target
  measure. Repeating it expresses invariance of one measure under a self-map.
- <code>hT</code> is the human-chosen name of a proof of the entire property.
- <code>hT.measurable</code> retrieves the measurability proof.
- <code>hT.map_eq</code> retrieves the equality
  <code>Measure.map T μ = μ</code>.
- For a measurable event proof <code>hA : MeasurableSet A</code>, the human
  types <code>hT.measure_preimage hA.nullMeasurableSet</code> to obtain the
  displayed event-mass equation.
{{< /lean-bridge >}}

## Exact project usage

The project's discrete matrix cocycle stores preservation of its base map as
a field, separately from measurability of its matrix generator:

~~~lean
structure DiscreteMatrixCocycle (μ : Measure Ω) where
  base : Ω → Ω
  generator : RandomMatrix Ω ι ι ℂ
  base_preserving : MeasurePreserving base μ μ
  measurable_generator : Measurable generator
~~~

The same module proves that every natural-number iterate preserves the
measure:

~~~lean
theorem base_iterate_preserving (C : DiscreteMatrixCocycle (ι := ι) μ)
    (k : ℕ) : MeasurePreserving C.base^[k] μ μ :=
  C.base_preserving.iterate k
~~~

The Birkhoff module consumes exactly that kind of hypothesis when it proves
finite orbit sums integrable:

~~~lean
theorem integrable_birkhoffSum (hT : MeasurePreserving T μ μ)
    (hg : Integrable g μ) (n : ℕ) : Integrable (birkhoffSum T g n) μ := by
  change Integrable (fun ω ↦ ∑ j ∈ Finset.range n, g (T^[j] ω)) μ
  apply integrable_finsetSum
  intro j _hj
  change Integrable (g ∘ T^[j]) μ
  exact (hT.iterate j).integrable_comp_of_integrable hg
~~~

The last line says: preservation passes to the \(j\)-th iterate, and that
iterate preserves integrability under composition. No ergodicity hypothesis
appears in this finite theorem.

Here is a complete worksheet a human can type into a scratch <code>.lean</code>
file on a provisioned Linux build host:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.BirkhoffConvergence

open MeasureTheory Set

#check MeasurePreserving
#check MeasurePreserving.measure_preimage
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.base_preserving
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.base_iterate_preserving
#check NonlinearDynamics.Random.RandomCocycles.integrable_birkhoffSum

variable {Ω : Type*} [MeasurableSpace Ω]
variable (μ : Measure Ω) (T : Ω → Ω) (A : Set Ω)

example (hT : MeasurePreserving T μ μ) (hA : MeasurableSet A) :
    μ (T ⁻¹' A) = μ A := by
  exact hT.measure_preimage hA.nullMeasurableSet
~~~

The first two commands inspect Mathlib's global certificate and its preimage
theorem. The next three inspect the exact project fields and consumers shown
above. The final <code>example</code> turns the mathematical sentence into a
checked Lean statement: <code>hA</code> proves that \(A\) is measurable, its
<code>nullMeasurableSet</code> consequence supplies the slightly more general
hypothesis accepted by Mathlib, and <code>hT.measure_preimage</code> returns
the equality.

{{< repo-check >}}
The authoritative project sources are
[<code>formalization/NonlinearDynamics/Random/RandomCocycles/Discrete.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/Discrete.lean)
and
[<code>formalization/NonlinearDynamics/Random/RandomCocycles/BirkhoffConvergence.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/BirkhoffConvergence.lean).
The first makes base preservation part of every bundled discrete matrix
cocycle and propagates it to iterates. The second uses a
<code>MeasurePreserving T μ μ</code> hypothesis to carry integrability along
finite orbits. The worksheet imports the latter module, which reaches both
interfaces, and uses their exact checked declaration names. The repository's
guarded build command checks the complete Birkhoff module on the approved
Linux builder.
{{< /repo-check >}}

## Distinctions and failure modes

| Tempting shortcut | What is wrong | Correct repair |
|---|---|---|
| "Measurable means measure preserving" | Measurability controls which preimages are legal events, not their masses | Prove the pushforward equality in addition to measurability |
| "One event has the right mass, so the map preserves the measure" | Equality of measures requires agreement on every measurable event | Prove the global map equality or an event equality for a generating family with a valid uniqueness argument |
| "The whole space test is enough" | Every self-map has \(T^{-1}(\Omega)=\Omega\) | Test the entire measurable structure |
| "Preserving an event means fixing the event" | Equal mass does not imply \(T^{-1}(A)=A\) | Separate event-mass equality from set invariance |
| "Use the image \(T(A)\)" | Pushforward evaluates target events through preimages | Compute \(T^{-1}(A)\) |
| "A preserving map must be one-to-one" | Noninvertible maps can preserve suitable measures | Require the measure equation, not injectivity |
| "Measure preserving implies ergodic" | Identity dynamics preserve measure but retain every event | Add invariant-event rigidity |
| "Ergodicity is needed for finite Birkhoff integrability" | Preservation and integrability already control finite orbit sums | Reserve ergodicity for stronger invariant-information conclusions |

{{< panel "warning" >}}
**What preservation alone does not prove.** A measure-preserving
transformation need not be invertible, ergodic, mixing, chaotic, or
information destroying. It does not make an arbitrary observable integrable,
and it does not by itself prove convergence of an infinite sequence of orbit
averages.
{{< /panel >}}

## Where to continue

Read {{< refterm "measure" "measure" >}} for the mass assignment being
preserved and {{< refterm "event" "event" >}} for the measurable sets on which
the preimage equation is tested. Read
{{< refterm "measurable-space" "measurable space" >}} for the gate that makes
those preimages admissible. Then read
{{< refterm "ergodicity" "ergodicity" >}} for the additional condition that
collapses invariant events to null or conull ones.

The chapter
[Birkhoff Limits, Invariant Sigma Algebras, and Conditional Expectation]({{< relref "/knowledge-base/deep-dives/birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation" >}})
shows how preservation supports the orbit-average machinery before any
ergodic specialization.

## References

**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation. This official implementation reference defines
<code>MeasurePreserving</code> and states
<code>MeasurePreserving.measure_preimage</code>.

**Karl Petersen.**
[Ergodic Theory](https://doi.org/10.1017/CBO9780511608728), Cambridge
University Press, 1983. This is a standard reference for measure-preserving
transformations, invariant events, ergodicity, and orbit averages.

**Nonlinear Dynamics in Lean contributors.**
[Discrete.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/Discrete.lean)
and
[BirkhoffConvergence.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/BirkhoffConvergence.lean),
the checked project sources for the bundled measure-preserving cocycle base,
its iterates, and finite Birkhoff integrability.
