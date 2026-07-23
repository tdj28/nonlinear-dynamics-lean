---
title: "Event"
slug: "event"
summary: "A probability event is a measurable set of outcomes; it occurs when the realized outcome belongs to that set."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.BirkhoffConvergence"
og_image: "event-card.png"
og_image_alt: "A fair die separates outcomes from events and computes complement, intersection, and union probabilities with patterned sets."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean examples, source interpretation, figure, and accessibility
remains pending. It is public so readers can follow the educational rebuild
while that review is open.
{{< /panel >}}

A probability **event** is a measurable set of possible outcomes. An
experiment produces one outcome \(\omega\). The event \(A\) occurs when that
outcome belongs to the set, written \(\omega\in A\).

That distinction is small but fundamental:

- an **outcome** is one possible result;
- an **event** is a yes-or-no question represented by a set of results; and
- a **probability** is mass assigned to that measurable set.

## Start with a fair die

Roll a fair six-sided die. The outcome space is

\[
\Omega=\{1,2,3,4,5,6\},
\]

and every face has probability \(1/6\). Give this finite space the collection
of all subsets as its measurable sets, so every subset is an event.

Define two events:

\[
A=\{2,4,6\}
\quad\text{(the roll is even)},
\]

and

\[
B=\{4,5,6\}
\quad\text{(the roll is at least four)}.
\]

If the die lands on \(4\), then the outcome is the single number \(4\). Both
events occur because

\[
4\in A
\qquad\text{and}\qquad
4\in B.
\]

The event \(A\) is not the outcome \(4\). It is the three-element set
\(\{2,4,6\}\). The singleton \(\{4\}\) is yet another event, with probability
\(1/6\).

{{< reference-figure
  wide="true"
  src="die-event-operations.svg"
  alt="Six die outcomes are compared across the events A equals even rolls and B equals rolls at least four. The complement of A contains one, three, and five; the intersection of A and B contains four and six; and their union contains two, four, five, and six."
  caption="**Finding:** one realized outcome is a single face, while an event is a set of faces. Event \(A=\{2,4,6\}\) marks the even outcomes and event \(B=\{4,5,6\}\) marks outcomes at least four. Their complement, intersection, and union are \(A^{\mathsf c}=\{1,3,5\}\), \(A\cap B=\{4,6\}\), and \(A\cup B=\{2,4,5,6\}\), with probabilities \(1/2\), \(1/3\), and \(2/3\). Diagonal lines mark membership in \(A\), dots mark membership in \(B\), and crossed marks show membership in both. The six faces are exact equally likely possibilities, not six observed rolls."
>}}

## Complement means “not”

The complement of \(A\), written \(A^{\mathsf c}\), contains every outcome in
\(\Omega\) that is not in \(A\):

\[
A^{\mathsf c}=\{1,3,5\}.
\]

For any probability measure,

\[
\mathbb P(A^{\mathsf c})=1-\mathbb P(A).
\]

Here \(\mathbb P(A)=3/6=1/2\), so

\[
\mathbb P(A^{\mathsf c})=1-\frac12=\frac12.
\]

## Intersection means “and”

The intersection \(A\cap B\) contains outcomes that satisfy both questions:

\[
A\cap B=\{4,6\}.
\]

There are two equally likely faces in the intersection, hence

\[
\mathbb P(A\cap B)=\frac26=\frac13.
\]

The word “and” does not mean multiply probabilities automatically. The formula
\(\mathbb P(A\cap B)=\mathbb P(A)\mathbb P(B)\) needs independence, which has
not been assumed here. Indeed, its right-hand side would be \(1/4\), not the
correct value \(1/3\).

## Union means inclusive “or”

The union \(A\cup B\) contains outcomes that lie in \(A\), in \(B\), or in
both:

\[
A\cup B=\{2,4,5,6\}.
\]

It has probability

\[
\mathbb P(A\cup B)=\frac46=\frac23.
\]

Adding \(\mathbb P(A)\) and \(\mathbb P(B)\) counts the overlap twice. The
general two-event formula subtracts it once:

\[
\begin{aligned}
\mathbb P(A\cup B)
&=\mathbb P(A)+\mathbb P(B)-\mathbb P(A\cap B)\\
&=\frac12+\frac12-\frac13
=\frac23.
\end{aligned}
\]

No independence hypothesis is needed for this inclusion-exclusion identity.

## The exact definition and measurability gate

Let \(\Omega\) be an outcome space and let \(\mathcal F\) be a
{{< refterm "measurable-space" "measurable collection" >}} of its subsets. An
event is a set \(A\) satisfying

\[
A\subseteq\Omega
\qquad\text{and}\qquad
A\in\mathcal F.
\]

A probability measure \(\mathbb P\) then assigns \(A\) a number
\(\mathbb P(A)\in[0,1]\). The collection \(\mathcal F\) contains the whole
space and is closed under complements and countable unions. Consequently it is
also closed under intersections and all the finite set operations used in the
die example.

On a finite die, choosing every subset causes no trouble. On an uncountable
space, probability theory usually selects a smaller measurable collection.
There can be subsets outside that collection. They are still sets, but they
are not events to which the probability model assigns an ordinary probability.
The point is not to memorize a pathological example. It is to remember that
“subset” and “measurable event” become different notions in general spaces.

## Three special events

The whole space \(\Omega\) is the certain event and has probability one. The
empty set \(\varnothing\) is the impossible event and has probability zero. A
nonempty {{< refterm "null-set" "null event" >}} can also have probability
zero in a continuous model, so zero probability and logical impossibility must
not be identified.

For any event \(A\), these boundary identities hold:

\[
A\cap\varnothing=\varnothing,
\qquad
A\cup\varnothing=A,
\qquad
A\cap\Omega=A,
\qquad
A\cup\Omega=\Omega.
\]

## In Lean: a set and its certificate are separate

Lean represents a subset of \(\Omega\) by <code>Set Ω</code>. It represents the
measurability gate by a separate proposition and proof.

{{< lean-bridge
  human="A is a set of outcomes, and hA certifies that A is a measurable event."
  math="\(A\subseteq\Omega\) and \(A\in\mathcal F\)."
  lean="(A : Set Ω) (hA : MeasurableSet A)"
>}}

- <code>Ω</code> is the type of possible outcomes.
- <code>Set Ω</code> is the type of all subsets of those outcomes.
- <code>A : Set Ω</code> introduces one particular subset.
- <code>MeasurableSet A</code> is a proposition saying that <code>A</code>
  belongs to the measurable structure installed on <code>Ω</code>.
- <code>hA :</code> names evidence for that proposition. Lean keeps the set and
  the measurability proof distinct so a theorem cannot silently assume that
  every subset is measurable.
- The whole expression is valid parameter syntax inside a Lean
  <code>example</code>, definition, or theorem.
{{< /lean-bridge >}}

The elementary set operations translate directly:

| Paper | Lean | Read aloud |
|---|---|---|
| \(\omega\in A\) | <code>ω ∈ A</code> | outcome omega belongs to event A |
| \(A^{\mathsf c}\) | <code>Aᶜ</code> | the complement of A |
| \(A\cap B\) | <code>A ∩ B</code> | A and B |
| \(A\cup B\) | <code>A ∪ B</code> | A or B, including both |
| \(\{\omega\}\) | <code>{ω}</code> | the singleton event containing omega |

Mathlib's measure object can be evaluated on an arbitrary <code>Set Ω</code>
through its outer-measure foundation. The usual probability interpretation
and exact measure identities are nevertheless stated with measurability gates
where needed. A raw set term does not manufacture
<code>MeasurableSet A</code>.

### Small standalone tutorial: compute the die events

The set operations from the worked example can be checked without Mathlib.
Here a Boolean predicate decides whether each face belongs to an event. Create
<code>/tmp/DieEvents.lean</code> with these contents:

~~~lean
import Std

namespace DieEvents

def dieFaces : List Nat :=
  (List.range 6).map (fun k => k + 1)

def eventA (face : Nat) : Bool :=
  face % 2 == 0

def eventB (face : Nat) : Bool :=
  decide (4 ≤ face)

def select (P : Nat → Bool) : List Nat :=
  dieFaces.filter P

#eval select (fun face => !(eventA face))
#eval select (fun face => eventA face && eventB face)
#eval select (fun face => eventA face || eventB face)

example : select (fun face => !(eventA face)) = [1, 3, 5] := by decide
example : select (fun face => eventA face && eventB face) = [4, 6] := by decide
example : select (fun face => eventA face || eventB face) = [2, 4, 5, 6] := by
  decide

end DieEvents
~~~

From any directory on a normal macOS or Linux machine with the pinned compiler,
type exactly:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean /tmp/DieEvents.lean
~~~

This exact worksheet was executed successfully with Lean 4.32.0 while
repairing this page. It printed:

~~~text
[1, 3, 5]
[4, 6]
[2, 4, 5, 6]
~~~

These are exactly \(A^{\mathsf c}\), \(A\cap B\), and \(A\cup B\) from the
figure. Their lengths are \(3\), \(2\), and \(4\), so dividing by six gives
the displayed probabilities \(1/2\), \(1/3\), and \(2/3\). This bounded
tutorial imports only <code>Std</code>; it does not install the project's
Mathlib dependencies.

## A real project event: convergence of orbit averages

The project does not reserve “event” for elementary experiments. In
<code>BirkhoffConvergence.lean</code>, an outcome \(\omega\) is a starting point
of a dynamical system. The event contains exactly those starting points whose
finite Birkhoff averages converge to some real number.

This is the exact checked definition:

~~~lean
def birkhoffConvergenceSet (T : Ω → Ω) (g : Ω → ℝ) : Set Ω :=
  {ω | ∃ c : ℝ, Tendsto (fun n ↦ birkhoffAverage ℝ T g n ω) atTop (nhds c)}
~~~

Read the set-builder from left to right. The braces construct a set of
starting points <code>ω</code>. Membership requires a real witness
<code>c</code> and a proof that the average sequence tends to <code>c</code>.
The definition does not claim that any starting point satisfies the property.

The same module separately proves the measurability gate:

~~~lean
theorem measurableSet_birkhoffConvergenceSet
    (hT : Measurable T) (hg : Measurable g) :
    MeasurableSet (birkhoffConvergenceSet T g) := by
  exact MeasureTheory.measurableSet_exists_tendsto
    (fun n ↦ measurable_birkhoffAverage hT hg n)
~~~

The event exists as a <code>Set Ω</code> without measurability assumptions.
The theorem needs <code>hT</code> and <code>hg</code> to prove that it is a
measurable event. This definition-theorem split is the general set-versus-event
distinction made explicit in code.

{{< repo-check >}}
The authoritative checked source is
[<code>formalization/NonlinearDynamics/Random/RandomCocycles/BirkhoffConvergence.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/BirkhoffConvergence.lean).
A human can type this worksheet in a scratch buffer inside a clone with the
repository's pinned dependencies installed:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.BirkhoffConvergence

open MeasureTheory Set Filter
open NonlinearDynamics.Random.RandomCocycles

#check birkhoffConvergenceSet
#check mem_birkhoffConvergenceSet_iff
#check measurableSet_birkhoffConvergenceSet
#check preimage_birkhoffConvergenceSet

example {Ω : Type*} [MeasurableSpace Ω]
    (A B : Set Ω) (hA : MeasurableSet A) (hB : MeasurableSet B) :
    MeasurableSet (Aᶜ ∩ B) :=
  hA.compl.inter hB
~~~

The four <code>#check</code> commands ask Lean to report the checked project
interfaces. The final <code>example</code> verifies that the complement of one
measurable event intersected with another remains measurable. The full-project
command below checks the complete project module containing the convergence
event and its measurability theorem.
{{< /repo-check >}}

## Boundaries that prevent common mistakes

| Tempting shortcut | Correct statement |
|---|---|
| “An outcome is an event.” | An outcome \(\omega\) is an element. The singleton \(\{\omega\}\) may be an event. |
| “Every subset automatically has a probability.” | Only measurable subsets are events in a general probability space. |
| “And means multiply.” | \(\mathbb P(A\cap B)=\mathbb P(A)\mathbb P(B)\) requires independence. |
| “Or excludes the overlap.” | Set union is inclusive; outcomes in both events remain in the union. |
| “Probability zero means empty.” | A nonempty event can be null under a continuous probability law. |
| “Defining a convergence event proves convergence.” | A set-builder records a membership condition; a later theorem must prove points or almost every point belongs. |

{{< panel "warning" >}}
**What an event does not prove.** Naming a set as an event does not establish
that it is nonempty, likely, independent of another event, invariant under the
dynamics, or observed in data. Even proving it measurable only makes its
measure-theoretic questions legitimate. Those additional properties require
separate arguments.
{{< /panel >}}

## Where to continue

The {{< refterm "measurable-space" "measurable space" >}} entry explains the
collection \(\mathcal F\) and why it is closed under the operations used here.
The {{< refterm "probability-law" "probability distribution (law)" >}} entry
explains where probabilities on value-space events come from. The
{{< refterm "null-set" "null set" >}} and
{{< refterm "almost-everywhere" "almost-everywhere" >}} entries explain how
zero-mass exceptions enter analysis.

For the project example, continue to the
{{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}}
chapter and then to
[Birkhoff Convergence Events Before the Pointwise Ergodic Theorem]({{< relref "/knowledge-base/deep-dives/birkhoff-convergence-events-before-the-pointwise-ergodic-theorem" >}}).
They separate event definition, measurability, invariance, zero-one rigidity,
and actual convergence.

## References

**Olav Kallenberg.**
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1),
third edition, Springer, 2021. This is a standard reference for sample spaces,
events, sigma algebras, and probability measures.

**Mathlib contributors.**
[Measurable spaces and measurable sets](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/MeasurableSpace/Basic.html),
Mathlib 4 documentation. This official reference documents
<code>MeasurableSet</code> and its closure operations.

**Project source.**
[BirkhoffConvergence.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/BirkhoffConvergence.lean)
contains the checked convergence-set definition and measurability theorem used
in the Lean section.
