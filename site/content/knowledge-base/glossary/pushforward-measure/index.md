---
title: "Pushforward measure"
slug: "pushforward-measure"
summary: "A pushforward measure transports mass through a measurable function by measuring preimages in the original space."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.Laws"
og_image: "pushforward-measure-card.png"
og_image_alt: "Three source atoms flow through a many-to-one map, combining masses one half and one third into target mass five sixths."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
prose, equations, examples, references, and Lean interpretation is still
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

A **pushforward measure** transports mass from one measurable space to another
through a function. Points move forward, but the mass of a target set is
computed from all source points that map into it.

Let \((S,\mathcal A)\) and \((T,\mathcal B)\) be measurable spaces. Here \(S\)
and \(T\) are sets, while \(\mathcal A\) and \(\mathcal B\) are their
collections of measurable subsets. Let \(\mu\) be a measure on \(S\), and let

\[
f:S\longrightarrow T
\]

be measurable. This means that for every measurable target set
\(B\in\mathcal B\), its preimage \(f^{-1}(B)\) belongs to the source collection
\(\mathcal A\). The **pushforward of** \(\mu\) **by** \(f\) is the measure
\(f_*\mu\) on \(T\) defined by

\[
(f_*\mu)(B)=\mu\bigl(f^{-1}(B)\bigr)
\]

for every measurable set \(B\in\mathcal B\). Other common notations are
\(\mu\circ f^{-1}\) and \(f_\#\mu\).

The inverse image is essential. Measures are evaluated on sets, while \(f\)
sends points forward. To learn how much source mass arrives in \(B\), we
collect the source points that land there and measure that collection with
\(\mu\). Measurability is exactly the guarantee that this collected source set
is an event to which the source measure applies in the ordinary measure-space
sense.

## The transport picture

| Stage | Object | Operation |
|---|---|---|
| Source | A measure \(\mu\) on \(S\) | Start with mass assigned to source sets |
| Map | A measurable function \(f:S\to T\) | Send each source point to one target point |
| Target | The measure \(f_*\mu\) on \(T\) | Assign each target set the mass of its preimage |

The two directions must be distinguished: \(f\) maps source points to target
points, while \(f^{-1}\) maps target sets to source sets. The
next example makes both directions explicit.

## A finite example with collisions

Take the source set \(S=\{a,b,c\}\) and assign masses

\[
\mu\{a\}=\frac12,
\qquad
\mu\{b\}=\frac16,
\qquad
\mu\{c\}=\frac13.
\]

Let the target set be \(T=\{0,1\}\), and define

\[
f(a)=0,
\qquad
f(b)=1,
\qquad
f(c)=0.
\]

Give both finite sets the measurable structure in which every subset is
measurable. Then \(f\) is automatically measurable: the preimage of any target
subset is a source subset.

Two source points collide at the target value \(0\). Therefore

\[
\begin{aligned}
(f_*\mu)\{0\}
&=\mu\bigl(f^{-1}\{0\}\bigr)
=\mu\{a,c\}
=\frac12+\frac13
=\frac56,\\
(f_*\mu)\{1\}
&=\mu\bigl(f^{-1}\{1\}\bigr)
=\mu\{b\}
=\frac16.
\end{aligned}
\]

{{< reference-figure
  wide="true"
  src="finite-mass-flow.svg"
  alt="Source points a, b, and c carry three sixths, one sixth, and two sixths. Arrows send a and c to target zero and b to target one. Six equal target cells show five sixths at zero and one sixth at one."
  caption="**Finding:** the map sends points forward, while the target queries pull back to source sets. The target event \(\{0\}\) has preimage \(\{a,c\}\), so its three sixths and two sixths combine into \(5/6\). The target event \(\{1\}\) has preimage \(\{b\}\), so it receives \(1/6\). The six equal cells encode the exact weights, and their hatch patterns retain the source contribution after the collision. This is an exact finite example, not six sampled observations."
>}}

The total mass remains one. The pushforward combines mass when several source
points have the same image. It does not retain whether \(a\) or \(c\)
produced the target value \(0\) if all we retain is the target value. The
colored and patterned encoding in the teaching figure retains that provenance
only so the arithmetic can be inspected; the pushforward measure itself stores
the total \(5/6\), not a source label on each part.

## Probability laws are pushforwards

Let \(X:\Omega\to S\) be a random element on a probability space
\((\Omega,\mathcal F,\mathbb P)\). Its
{{< refterm "probability-law" "probability law" >}} is exactly

\[
\mathcal L(X)=X_*\mathbb P.
\]

Thus a law is not an unrelated object added after the random variable. It is
the source probability measure transported through that random variable.

For a random matrix
\(X:\Omega\to\mathbb C^{n\times n}\), the same formula produces a measure on
matrix space:

\[
\mathcal L(X)=X_*\mathbb P.
\]

The source outcomes disappear from the target description. What remains is
the probability assigned to each measurable region of matrix space.

## A matrix observable as a second pushforward

Suppose \(\nu\) is a measure on square complex matrices, and let

\[
\tau(H)=\operatorname{tr}(H)
\]

be the {{< refterm "matrix-trace" "matrix trace" >}}. When \(\tau\) is
measurable, its pushforward \(\tau_*\nu\) is the distribution of the trace.

If \(\nu=\mathcal L(X)=X_*\mathbb P\), then the composition rule gives

\[
\mathcal L(\operatorname{tr}X)
=\tau_*\bigl(X_*\mathbb P\bigr)
=(\tau\circ X)_*\mathbb P.
\]

This identity says that the two routes agree:

1. first form the matrix law and then push it through trace; or
2. first compute trace sample by sample and then take the scalar law.

The same pattern applies to
\(H\mapsto\operatorname{tr}(H^k)\), eigenvalue maps once their measurability
is proved, matrix norms, and other observables.

## Three structural identities

Pushforward has a small algebra that is worth remembering.

### Identity map

For the identity function \(\operatorname{id}_S\),

\[
(\operatorname{id}_S)_*\mu=\mu.
\]

### Composition

If \(R\) is a third measurable space, and \(f:S\to T\) and \(g:T\to R\)
are measurable, then

\[
(g\circ f)_*\mu=g_*\bigl(f_*\mu\bigr).
\]

### Total mass

Because \(f^{-1}(T)=S\),

\[
(f_*\mu)(T)=\mu(S).
\]

In particular, the pushforward of a probability measure by a measurable
function is again a probability measure.

## Integrating after transport

Pushforward also converts an integral over the target into an integral over
the source. Under the standard measurability hypotheses, and for a nonnegative
measurable function \(\varphi:T\to[0,\infty]\),

\[
\int_T \varphi(t)\,(f_*\mu)(dt)
=\int_S \varphi(f(s))\,\mu(ds).
\]

For signed, real, or complex integrals, the corresponding integrability
hypotheses are also required. This is the abstract form of "sample first, then
average": averaging a target observable under the transported law equals
averaging its composition with the original random object.

## In Lean: the preimage remains visible

Mathlib names pushforward <code>Measure.map</code>. The project uses that
construction to define the law of a measurable random matrix. Here is the core
statement in the three languages a reader must be able to translate between.

{{< lean-bridge
  human="For every measurable set s of matrix values, the law of X assigns s exactly the source mass of the outcomes that X sends into s."
  math="\(\mathcal L_\mu(X)(s)=\mu\!\left(X^{-1}(s)\right)\)."
  lean="RandomMatrix.law X hX μ s = μ (X ⁻¹' s)"
>}}

- <code>RandomMatrix.law X hX μ</code> is the target-space measure
  <code>Measure.map X μ</code>.
- <code>X</code> sends source outcomes to matrix values.
- <code>hX : Measurable X</code> proves that measurable target sets have
  measurable source preimages.
- <code>μ</code> is the source measure. Changing it can change the pushforward
  even when <code>X</code> stays fixed.
- <code>s</code> is the target set being queried. The checked theorem also takes
  <code>hs : MeasurableSet s</code>, which certifies that this query is
  measurable.
- <code>X ⁻¹' s</code> is Lean's set-preimage notation. Read it from right to
  left: start with target set <code>s</code>, then collect the source outcomes
  whose <code>X</code>-values land there.
- The equality says the target measure and source-preimage calculation return
  exactly the same extended nonnegative real number.
{{< /lean-bridge >}}

The following definition and theorem are an exact excerpt from the checked
project source. The measurability proof is an explicit argument of
<code>law</code>, even though the definition's body is
<code>Measure.map X μ</code>.

~~~lean
noncomputable def law (X : RandomMatrix Ω ι ι ℂ) (_hX : Measurable X)
    (μ : Measure Ω) : Measure (Matrix ι ι ℂ) :=
  Measure.map X μ

theorem law_apply (X : RandomMatrix Ω ι ι ℂ) (hX : Measurable X)
    (μ : Measure Ω) {s : Set (Matrix ι ι ℂ)} (hs : MeasurableSet s) :
    law X hX μ s = μ (X ⁻¹' s) := by
  exact Measure.map_apply hX hs
~~~

The final proof line hands Mathlib the two gates its evaluation theorem needs:
<code>hX</code> proves the map measurable, and <code>hs</code> proves the target
set measurable. The conclusion then computes the pushforward by a preimage.

The same module proves composition without hiding either measurability proof:

~~~lean
theorem law_comp {X : RandomMatrix Ω ι ι ℂ} (hX : Measurable X)
    {f : Matrix ι ι ℂ → Matrix ι ι ℂ} (hf : Measurable f) (μ : Measure Ω) :
    law (f ∘ X) (hf.comp hX) μ = Measure.map f (law X hX μ) := by
  exact (Measure.map_map hf hX).symm
~~~

This is the Lean form of
\((f\circ X)_*\mu=f_*(X_*\mu)\). The proof needs
<code>hf : Measurable f</code> and <code>hX : Measurable X</code> separately;
the composition proof <code>hf.comp hX</code> certifies the left-hand map.

There is one implementation boundary to keep visible. Mathlib makes
<code>Measure.map</code> a total operation: it is the zero measure when the map
is not {{< refterm "almost-everywhere" "almost-everywhere" >}} measurable
with respect to the source measure. When the map is almost-everywhere
measurable, Mathlib chooses a measurable representative. This is useful library
engineering, but it is not permission to invent a probability law from an
unproved function. The project's public <code>RandomMatrix.law</code> interface
asks for the stronger, simpler certificate <code>Measurable X</code> before it
uses <code>Measure.map</code>.

For the deterministic congruence map \(C_A(H)=AHA^*\), the module proves
<code>measurable_congruence</code>. Its checked
<code>HermitianRandomMatrix.law_conjugateBy</code> theorem says that the law of
\(A X A^*\) is the congruence pushforward of the law of \(X\). It identifies
the transformed law; it does not assert that the transformed law equals the
original one.

### Move the three source masses locally

This bounded <code>Std</code> worksheet stores the source masses as integer
numbers of sixths. It computes preimages first and then adds the source mass
inside each one, exactly following the pushforward definition. Save it as
<code>/tmp/PushforwardScratch.lean</code> on a normal Mac or Linux computer:

~~~lean
import Std

namespace PushforwardScratch

def sourceAtoms : List String := ["a", "b", "c"]

def massSixths (source : String) : Nat :=
  if source == "a" then 3
  else if source == "b" then 1
  else 2

def target (source : String) : Nat :=
  if source == "b" then 1 else 0

def preimage (targetValue : Nat) : List String :=
  sourceAtoms.filter (fun source => target source == targetValue)

def pushMassSixths (targetValue : Nat) : Nat :=
  (preimage targetValue).foldl
    (fun total source => total + massSixths source) 0

#eval preimage 0
#eval preimage 1
#eval [pushMassSixths 0, pushMassSixths 1]
#eval pushMassSixths 0 + pushMassSixths 1

example : preimage 0 = ["a", "c"] := by decide
example : preimage 1 = ["b"] := by decide
example : pushMassSixths 0 = 5 := by decide
example : pushMassSixths 1 = 1 := by decide
example : pushMassSixths 0 + pushMassSixths 1 = 6 := by decide

end PushforwardScratch
~~~

Type these commands exactly:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean /tmp/PushforwardScratch.lean
~~~

This exact standalone worksheet was executed successfully with Lean 4.32.0. It printed:

~~~text
["a", "c"]
["b"]
[5, 1]
6
~~~

The target masses are therefore \(5/6\) and \(1/6\), and the last line checks
that transport retains total mass one. This finite ledger does not construct
Mathlib's <code>Measure.map</code>; it makes the preimage arithmetic visible
before the exact project interface below.

### Full project check

{{< repo-check >}}
The authoritative source is
[<code>formalization/NonlinearDynamics/Random/RandomMatrices/Laws.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/Laws.lean).
A human can type the following worksheet in a scratch buffer inside a clone with
the repository's pinned dependencies installed:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.Laws

#print NonlinearDynamics.Random.RandomMatrix.law
#check NonlinearDynamics.Random.RandomMatrix.law_apply
#check NonlinearDynamics.Random.RandomMatrix.law_comp
#check NonlinearDynamics.Random.HermitianRandomMatrix.law_conjugateBy
~~~

<code>#print</code> displays the checked definition behind a name.
<code>#check</code> asks Lean to elaborate a declaration and display its type;
it does not assume or prove an extra theorem. The full-project command below checks
the complete module containing the exact excerpts above.
{{< /repo-check >}}

## Distinctions and failure modes

| Tempting shortcut | What is wrong | Correct repair |
|---|---|---|
| "Push \(\mu\) forward by measuring \(f(A)\)" | Images of measurable sets are not the sets in the defining formula | Measure \(f^{-1}(B)\) for target sets \(B\) |
| "Every function gives the intended pushforward" | Measurability is needed for the preimage formula and probability interpretation | Prove measurable or almost-everywhere measurable first |
| "The inverse-image symbol means an inverse function" | A preimage exists even when the function is many-to-one or has no inverse function | Read the preimage as all source points that land in the target set |
| "Pushforward is a conditional distribution" | Conditioning changes mass using information; pushforward transports it through a function | Treat these as separate constructions |
| "The source outcome can be recovered from the pushforward" | Different source points can merge at one target point | Keep the original coupling when source-level information matters |
| "Equal observable pushforwards imply equal matrix laws" | One observable can discard most matrix information | Use a separating family of observables or prove equality of the full laws |

{{< panel "warning" >}}
**What pushforward does not prove.** Two matrix laws can have the same trace
distribution while differing in their eigenvalues, eigenvectors, or entry
dependence. Pushing forward is information-losing whenever the map is not
injective. The construction also proves no density, independence,
integrability, symmetry, or invariance of the resulting measure. Each is a
separate statement with its own hypotheses.
{{< /panel >}}

## Where to continue

Read {{< refterm "probability-law" "probability law" >}} for the special case
of transporting a probability measure through a random object. Read
{{< refterm "measurable-space" "measurable space" >}} for the source and
target structures that make the preimage rule legal. Read
{{< refterm "random-matrix" "random matrix" >}} and
{{< refterm "trace-power" "trace power" >}} for the source and observable in
the project's first examples. The chapter
[Random Matrices: From Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}})
places the construction in the full probability-to-spectrum ascent.
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}})
is the first project chapter to use this bridge on a complete Gaussian
coordinate probability measure and obtain a named matrix law.

## References

**Mathlib contributors.**
[Pushforward of a measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
Mathlib 4 documentation. This official implementation reference states the
definitions and main theorems <code>map_apply</code> and
<code>map_map</code>, including Mathlib's behavior for maps that are not
almost-everywhere measurable.

**Olav Kallenberg.**
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1),
third edition, Springer, 2021. This is a standard measure-theoretic reference
for image measures, distributions of random elements, and integration under
measurable mappings.

**Mathlib contributors.**
[Measurable spaces and measurable functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/MeasurableSpace/Basic.html),
Mathlib 4 documentation. This official source gives the measurability layer on
which <code>Measure.map</code> depends.
