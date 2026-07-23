---
title: "Measurable function"
slug: "measurable-function"
summary: "A measurable function pulls every allowed target event back to an allowed source event."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.Basic"
og_image: "measurable-function-card.png"
og_image_alt: "A die-to-parity function pulls target events back to allowed source events, while an exact-face map fails under the coarse parity measurable space."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean examples, source interpretation, diagram, and accessibility
remains pending. The page is public so readers can follow the educational
rebuild while that review remains open.
{{< /panel >}}

A **measurable function** respects the information declared observable on its
source and target. Every allowed yes-or-no question about the reported value
must turn into an allowed yes-or-no question about the original outcome.

The word refers to the measurable structures around a function, not merely to
the formula used to compute it.

## Start with a die-to-parity map

Let

\[
\Omega=\{1,2,3,4,5,6\}
\]

be the possible results of one die roll. Suppose the source records only
parity. Write

\[
O=\{1,3,5\},
\qquad
E=\{2,4,6\},
\]

and give \(\Omega\) the event family

\[
\mathcal F=\{\varnothing,O,E,\Omega\}.
\]

This is the parity-only {{< refterm "measurable-space" "measurable space" >}}
from the neighboring entry. Its four sets are the only source
{{< refterm "event" "events" >}} available to this model.

Let the target be

\[
Y=\{\mathsf{odd},\mathsf{even}\},
\]

with every subset of \(Y\) measurable. Define the parity function

\[
p:\Omega\longrightarrow Y
\]

by

\[
p(1)=p(3)=p(5)=\mathsf{odd},
\qquad
p(2)=p(4)=p(6)=\mathsf{even}.
\]

There are only four target events, so we can check every one:

| Measurable target event \(B\) | Source preimage \(p^{-1}(B)\) | Is the preimage in \(\mathcal F\)? |
|---|---|---|
| \(\varnothing\) | \(\varnothing\) | Yes |
| \(\{\mathsf{odd}\}\) | \(O=\{1,3,5\}\) | Yes |
| \(\{\mathsf{even}\}\) | \(E=\{2,4,6\}\) | Yes |
| \(Y\) | \(\Omega\) | Yes |

Every allowed target question pulls back to an allowed source question.
Therefore \(p\) is measurable for these chosen structures.

{{< reference-figure
  wide="true"
  src="die-parity-preimages.svg"
  alt="A function sends odd die faces to the value odd and even die faces to the value even. Every one of the four target events pulls back to an event in the parity-only source family. In a contrast, an exact-face readout pulls the target singleton two back to source singleton two, which is not available in the parity-only source family."
  caption="**Finding:** the parity formula sends \(1,3,5\) to \(\mathsf{odd}\) and \(2,4,6\) to \(\mathsf{even}\). The target has exactly four measurable events; their preimages are \(\varnothing\), \(O\), \(E\), and \(\Omega\), all members of the source family \(\mathcal F\). That exhaustive pullback check proves \(p\) measurable. The lower contrast keeps the parity-only source family but lets the target ask the exact-face question \(\{2\}\). The exact readout pulls it back to \(\{2\}\notin\mathcal F\), so that readout is not measurable for these structures. The set \(\{2\}\) still exists; it is unavailable only as a measurable source event in this coarse model."
>}}

## A contrasting exact-face readout

Keep the same parity-only source \((\Omega,\mathcal F)\). Let the target also
be \(\Omega\), but give the target every subset as a measurable event. Define
the exact-face readout

\[
r:\Omega\longrightarrow\Omega,
\qquad
r(\omega)=\omega.
\]

The formula is the identity. Nevertheless, the target singleton
\(\{2\}\) is measurable while

\[
r^{-1}(\{2\})=\{2\}\notin\mathcal F.
\]

Thus \(r\) is not measurable from the parity-only source to the full
exact-face target.

Nothing is wrong with the set \(\{2\}\), and nothing is wrong with the identity
formula. The mismatch lies between the source and target information
structures. If the source also carried every subset as a measurable event,
the same identity formula would be measurable.

## The definition

Let \((\Omega,\mathcal F)\) and \((Y,\mathcal G)\) be measurable spaces. A
function

\[
f:\Omega\longrightarrow Y
\]

is measurable when

\[
B\in\mathcal G
\quad\Longrightarrow\quad
f^{-1}(B)\in\mathcal F
\]

for every target set \(B\). The **preimage**

\[
f^{-1}(B)=\{\omega\in\Omega:f(\omega)\in B\}
\]

collects the source outcomes that make the target event \(B\) occur.

The superscript \(-1\) in \(f^{-1}(B)\) does not assert that \(f\) has an
inverse function. Every function has a preimage operation on sets, even when
the function is many-to-one. The die parity map is many-to-one, yet its
preimages are perfectly well-defined.

Measurability uses preimages rather than forward images because inverse images
preserve complements and countable unions exactly:

\[
f^{-1}(Y\setminus B)=\Omega\setminus f^{-1}(B),
\]

and

\[
f^{-1}\!\left(\bigcup_{n=0}^{\infty}B_n\right)
{} =
\bigcup_{n=0}^{\infty}f^{-1}(B_n).
\]

Those identities align with the closure rules of sigma algebras.

## A formula is not a measurability proof

Writing down \(f(\omega)\) defines a function. It does not by itself establish
how target events pull back through the chosen measurable spaces.

| Layer | What it supplies | Die example |
|---|---|---|
| Function formula | One output for every input | \(p(\omega)\) reports odd or even |
| Source measurable space | Allowed questions about inputs | \(\mathcal F=\{\varnothing,O,E,\Omega\}\) |
| Target measurable space | Allowed questions about outputs | Every subset of \(Y\) |
| Measurability proposition | The pullback obligation | Every measurable \(B\subseteq Y\) has \(p^{-1}(B)\in\mathcal F\) |
| Measurability proof | Evidence that the obligation holds | The exhaustive four-row table |

This separation is explicit in Lean. A term
<code>f : Ω → Y</code> is the function. A separate term
<code>hf : Measurable f</code> is a proof about that function under the
measurable-space instances currently attached to <code>Ω</code> and
<code>Y</code>.

The project's {{< refterm "random-matrix" "RandomMatrix" >}} base type follows
the same pattern: it is only an outcome-to-matrix function. The theorem that
the map is measurable is a distinct hypothesis or a field of a richer bundle.

## Why probability laws need this condition

A {{< refterm "pushforward-measure" "pushforward measure" >}} assigns a target
event \(B\) the source mass of \(f^{-1}(B)\). The familiar equation is

\[
(f_*\mu)(B)=\mu\bigl(f^{-1}(B)\bigr).
\]

For the right side to be available for every measurable target event, those
preimages must be measurable source events. This is why the project's
probability-law interfaces carry measurability explicitly instead of treating
an arbitrary function as though it automatically induced a
{{< refterm "probability-law" "probability distribution" >}}.

A measurable space alone chooses admissible sets. A
{{< refterm "measure" "measure" >}} later assigns sizes to them. Measurability
of \(f\) does not itself choose either a source measure or a probability law.

## Measurable is not the same as continuous or integrable

These properties answer different questions.

| Property | Main question | What extra structure it uses |
|---|---|---|
| Measurable | Do measurable target events pull back to measurable source events? | Measurable spaces |
| Continuous | Do nearby inputs produce nearby outputs? | Topologies |
| Integrable | Does the function have finite total magnitude under a chosen measure? | A measure plus analytic structure on the values |

In the usual Borel measurable spaces on \(\mathbb R\), the step function

\[
s(x)=
\begin{cases}
0,&x\lt0,\\
1,&x\ge0
\end{cases}
\]

is measurable but is not continuous at zero. Measurability permits this jump
because the preimages of Borel target sets remain Borel.

For a different separation, put counting measure on \(\mathbb N\). The
constant function \(g(n)=1\) is measurable because every subset is measurable,
but it is not integrable over all of \(\mathbb N\):

\[
\sum_{n=0}^{\infty}|g(n)|
{} =
\sum_{n=0}^{\infty}1
{} =
\infty.
\]

So measurability is necessary for ordinary integration theory, but it is not a
finite-integral estimate.

## In Lean

The pinned Mathlib definition is almost a word-for-word rendering of the paper
definition.

{{< lean-bridge
  human="For every measurable set B of target values, the source outcomes that f sends into B form a measurable source set."
  math="\(B\in\mathcal G\Longrightarrow f^{-1}(B)\in\mathcal F.\)"
  lean="Measurable f"
>}}

- <code>Measurable f</code> is a proposition about the function
  <code>f</code> and the active measurable-space instances on its source and
  target.
- In the unfolded definition below, <code>∀</code> means "for every." The braces
  in <code>⦃B : Set β⦄</code>
  make the target set an implicit argument, so Lean can infer it from the
  following proof.
- <code>MeasurableSet B</code> says that \(B\) belongs to the target sigma
  algebra.
- <code>→</code> means that a proof of target measurability must produce the
  source-side conclusion.
- <code>f ⁻¹' B</code> is Lean's set-preimage notation. The prime is part of
  the notation and helps distinguish set preimage from other inverse-like
  operations.
- The second <code>MeasurableSet</code> is interpreted in the source type
  because <code>f ⁻¹' B</code> is a set of source points.
{{< /lean-bridge >}}

Here is the exact definition from the pinned Mathlib source:

~~~lean
def Measurable [MeasurableSpace α] [MeasurableSpace β] (f : α → β) : Prop :=
  ∀ ⦃t : Set β⦄, MeasurableSet t → MeasurableSet (f ⁻¹' t)
~~~

The bridge uses the page's names \(\Omega\), \(Y\), and \(B\); the library
uses generic type names <code>α</code>, <code>β</code>, and target-set name
<code>t</code>. Renaming bound variables does not change the proposition.

The random-matrix foundation then packages a structured use of this general
definition. This is the exact checked project theorem:

~~~lean
theorem measurable_iff_entries (X : RandomMatrix Ω ι κ 𝕜) :
    Measurable X ↔ ∀ i j, Measurable fun ω ↦ X ω i j := by
  rw [measurable_comap_iff]
  change Measurable (fun ω i j ↦ X ω i j) ↔ _
  simp only [measurable_pi_iff]
~~~

It says that a matrix-valued function is measurable exactly when every scalar
entry function is measurable. The target matrix measurable space is built
entry by entry, so the theorem turns one structured pullback condition into a
family of coordinate conditions.

### Pull back all four parity events locally

Lean Core does not include Mathlib's measure theory, but a small
<code>Std</code> program can compute the page's complete finite preimage table.
Here <code>false</code> means odd and <code>true</code> means even. Save this as
<code>/tmp/MeasurableFunctionScratch.lean</code> on a normal Mac or Linux
computer:

~~~lean
import Std

namespace MeasurableFunctionScratch

def faces : List Nat := [1, 2, 3, 4, 5, 6]

def parity (face : Nat) : Bool :=
  face % 2 == 0

def preimage (event : Bool → Bool) : List Nat :=
  faces.filter (fun face => event (parity face))

def targetEvents : List (Bool → Bool) :=
  [fun _ => false,
   fun isEven => !isEven,
   fun isEven => isEven,
   fun _ => true]

def sourceAllowed (event : List Nat) : Bool :=
  event == [] ||
  event == [1, 3, 5] ||
  event == [2, 4, 6] ||
  event == faces

def pulledBackEvents : List (List Nat) :=
  targetEvents.map preimage

def exactFaceTwo : List Nat :=
  faces.filter (fun face => face == 2)

#eval pulledBackEvents
#eval pulledBackEvents.map sourceAllowed
#eval exactFaceTwo
#eval sourceAllowed exactFaceTwo

example : pulledBackEvents =
    [[], [1, 3, 5], [2, 4, 6], [1, 2, 3, 4, 5, 6]] := by decide
example : pulledBackEvents.map sourceAllowed =
    [true, true, true, true] := by decide
example : exactFaceTwo = [2] := by decide
example : sourceAllowed exactFaceTwo = false := by decide

end MeasurableFunctionScratch
~~~

Type these commands exactly:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean /tmp/MeasurableFunctionScratch.lean
~~~

This exact standalone worksheet was executed successfully with Lean 4.32.0. It printed:

~~~text
[[], [1, 3, 5], [2, 4, 6], [1, 2, 3, 4, 5, 6]]
[true, true, true, true]
[2]
false
~~~

The first two lines exhaust every event in the two-value target and show that
all four preimages belong to the parity-only source family. The last two lines
reproduce the exact-face counterexample. This computes the finite set ledger;
it does not replace a proof of Mathlib's general
<code>Measurable f</code> proposition.

### Full project check

This Mathlib-backed file exposes the definition through a single target event
and then asks Lean for the project's coordinatewise theorem. This full project
check uses the repository's pinned Lean and Mathlib dependencies and may
require substantial disk space and memory.

~~~lean
import NonlinearDynamics.Random.RandomMatrices.Basic

universe u v

variable {Ω : Type u} {Y : Type v}
variable [MeasurableSpace Ω] [MeasurableSpace Y]
variable (f : Ω → Y)

#check Measurable
#check MeasurableSet
#check Set.preimage
#check NonlinearDynamics.Random.RandomMatrix.measurable_iff_entries

example (hf : Measurable f) {B : Set Y} (hB : MeasurableSet B) :
    MeasurableSet (f ⁻¹' B) := by
  exact hf hB
~~~

Read the example from left to right. The input <code>hf</code> is the complete
measurability proof. The input <code>hB</code> certifies one target event.
Applying <code>hf</code> to <code>hB</code> returns the required proof that
the preimage is a measurable source event.

{{< repo-check >}}
The authoritative project source is
[formalization/NonlinearDynamics/Random/RandomMatrices/Basic.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/Basic.lean).
The worksheet is pedagogical; the quoted
<code>measurable_iff_entries</code> declaration is exact project source. Put
the worksheet in a temporary <code>.lean</code> file inside
<code>formalization</code>. The full-project command below checks the
authoritative project module.
{{< /repo-check >}}

## Boundaries and nonclaims

- Measurability is relative to both measurable spaces. The same underlying
  formula can be measurable for one pair and nonmeasurable for another.
- A preimage is not an inverse function. No bijectivity is required.
- Checking a few convenient target events is not generally enough. The die
  example is complete only because all four target events were listed.
- Measurability uses inverse images. Forward images of measurable sets need not
  be measurable without additional hypotheses.
- A measurable function need not be continuous or integrable.
- A proof of <code>Measurable f</code> does not select a measure, assign
  probabilities, or prove an almost-everywhere statement.

## Where to continue

The {{< refterm "measurable-space" "measurable space" >}} page builds the
source and target event families used here. The
{{< refterm "pushforward-measure" "pushforward measure" >}} page follows the
preimage into the law construction. The
{{< refterm "almost-everywhere" "almost-everywhere" >}} page explains what
changes when a property may fail on a null set.

## Further reading

Mathlib's
[measurable-space definitions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/MeasurableSpace/Defs.html)
give the exact pinned definition used above. Olav Kallenberg's
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1)
develops measurable mappings before using them to define random elements and
their distributions.
