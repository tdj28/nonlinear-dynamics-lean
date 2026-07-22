---
title: "Random matrix"
slug: "random-matrix"
summary: "A random matrix maps each outcome to one ordinary matrix; measurability and a probability law are distinct additional layers."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.Basic"
og_image: "random-matrix-card.png"
og_image_alt: "A coin outcome selects either a stretch matrix or a shear matrix, while a type ledger keeps the function separate from measurability, source probability, and its law."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
prose, equations, example, diagram, and Lean interpretation is still pending.
The page is public as an open working note while that review remains pending.
{{< /panel >}}

A **random matrix** is a rule that turns an outcome into an ordinary matrix.
The rule is the whole object. A matrix seen in one run is only one of its
realizations.

## Start with a coin-selected linear map

Let the outcome space have two points:

\[
\Omega=\{H,T\},
\]

where \(H\) means heads and \(T\) means tails. Define two real matrices

\[
A_H=
\begin{bmatrix}
2&0\\
0&\frac12
\end{bmatrix},
\qquad
A_T=
\begin{bmatrix}
1&1\\
0&1
\end{bmatrix}.
\]

The first stretches the horizontal direction and compresses the vertical
direction. The second is a shear. Define one matrix-valued function \(X\) by

\[
X(H)=A_H,
\qquad
X(T)=A_T.
\]

This function is the random matrix. If we apply the realized matrix to
\(v=(1,1)\), the two possible outputs are

\[
A_Hv=\left(2,\frac12\right),
\qquad
A_Tv=(2,1).
\]

Every number in this example is directly checkable by matrix multiplication.
Before assigning coin probabilities, \(X\) is already a perfectly good
outcome-to-matrix function. It does not yet determine how likely either output
is.

{{< reference-figure
  wide="true"
  src="outcome-to-random-matrix.svg"
  alt="Heads maps to a diagonal stretch-compress matrix and tails maps to a shear matrix. On the vector one comma one, the two realized outputs are two comma one half and two comma one. A separate ledger shows that the project RandomMatrix type stores only the function, while measurability, a source measure, and the induced law are added later."
  caption="**Finding:** the upper path is the concrete function \(X\): heads selects \(A_H\), tails selects \(A_T\), and one outcome produces one ordinary matrix realization. The vector check gives \(A_H(1,1)=(2,1/2)\) and \(A_T(1,1)=(2,1)\). The lower ledger separates what the project type stores from what later probability arguments supply. The solid green card is the bare function type. The dashed cards are a measurability proof, the fair source measure, and the resulting law with mass \(1/2\) at each matrix. Those dashed cards are not fields hidden inside \(X\)."
>}}

## Add probability without changing the function

Now equip \(\Omega\) with the fair-coin probability measure \(\mu\):

\[
\mu\{H\}=\mu\{T\}=\frac12.
\]

The function \(X\) has not changed. What we have added is a measure on its
source. Once measurability is available, the
{{< refterm "probability-law" "probability distribution (law)" >}} of \(X\)
under \(\mu\) is

\[
\mathcal L_\mu(X)
{} =
\frac12\,\delta_{A_H}+\frac12\,\delta_{A_T}.
\]

For example, let \(D\) be the set of diagonal matrices. Then \(A_H\in D\)
and \(A_T\notin D\), so

\[
\mathcal L_\mu(X)(D)=\mu\bigl(X^{-1}(D)\bigr)=\mu\{H\}=\frac12.
\]

If we keep exactly the same function \(X\) but instead choose
\(\mu\{H\}=1/4\) and \(\mu\{T\}=3/4\), its law changes. This is why the
project does not store a source measure inside its base <code>RandomMatrix</code>
type.

## Mathematical definition and project encoding

In probability theory, begin with a probability space
\((\Omega,\mathcal F,\mathbb P)\). A random matrix over scalars \(\mathbb K\)
is a measurable map

\[
X:\Omega\longrightarrow\mathbb K^{m\times n},
\]

usually with \(\mathbb K=\mathbb R\) or \(\mathbb C\). An outcome \(\omega\)
selects the ordinary matrix \(X(\omega)\). Measurability says that allowed sets
of matrices pull back to allowed events in \(\Omega\).

The project deliberately splits this definition into layers. Its base type is
only the function. A {{< refterm "measurable-space" "measurable space" >}}, a
proof that \(X\) is measurable, and a source measure are separate arguments or
hypotheses. A law is then built as a
{{< refterm "pushforward-measure" "pushforward measure" >}}.

| Layer | What it answers | Coin example | Stored in the base type? |
|---|---|---|---|
| Outcome space \(\Omega\) | Which underlying cases are possible? | \(\{H,T\}\) | It appears as a type parameter |
| Matrix-valued map \(X\) | Which matrix belongs to each outcome? | \(H\mapsto A_H\), \(T\mapsto A_T\) | Yes; this is the function itself |
| Realization \(X(\omega)\) | Which ordinary matrix appeared now? | \(A_H\) or \(A_T\) | No; it is obtained by applying \(X\) |
| Measurability proof | Are preimages of target events allowed source events? | Automatic for this finite discrete model once the structures are chosen | No |
| Source measure \(\mu\) | How likely is each outcome? | \(1/2\) and \(1/2\) | No |
| Law \(\mathcal L_\mu(X)\) | How is probability spread over matrix values? | Half at each matrix | No |

This separation keeps the same map reusable under different measures and in
deterministic arguments that do not need probability.

## Entries are scalar random variables

For a fixed row \(i\) and column \(j\), the coordinate map is

\[
\omega\longmapsto X(\omega)_{ij}.
\]

If \(X\) is measurable for the entrywise matrix measurable space, each such
coordinate is a measurable scalar random variable. Conversely, the checked
project theorem says that if every coordinate is measurable, then \(X\) is
measurable. This coordinate view is useful for constructing ensembles and
stating moment assumptions. It does not imply that different coordinates are
independent.

For example, a {{< refterm "hermitian-matrix" "Hermitian matrix" >}} satisfies
\(X(\omega)_{ji}=\overline{X(\omega)_{ij}}\) at every outcome when the
Hermitian property is pointwise. The lower-triangular entries are then
determined by the upper triangle, so declaring every coordinate independent
would contradict the symmetry.

The {{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}
makes the nonredundant primitive positions explicit: real diagonal values and
complex strict-upper values are supplied, while the lower triangle is filled
by conjugate reflection.

## Boundaries and nonexamples

- A single matrix \(A_H\) is not the random matrix \(X\). It is one possible
  value of \(X\).
- A function can inhabit the project's bare <code>RandomMatrix</code> alias
  before any measurable spaces, measurability proof, or probability measure
  have been supplied. At that stage it should not be credited with a law.
- The word "random" does not mean that entries are independent or identically
  distributed. Those are additional properties of particular ensembles.
- A law does not remember which source outcome produced a matrix. The function
  \(X\) and its law are related, but they are different typed objects.

## In Lean

The core translation is intentionally simple: the project name
<code>RandomMatrix</code> abbreviates an ordinary function type.

{{< lean-bridge
  human="A project random matrix is a rule that accepts an outcome and returns one matrix. The base type alone contains no measurability proof and no probability measure."
  math="\(X:\Omega\longrightarrow\mathbb K^{\iota\times\kappa}\)."
  lean="X : RandomMatrix Ω ι κ 𝕜"
>}}

- <code>Ω</code> is the type of outcomes.
- <code>ι</code> and <code>κ</code> are the row-index and column-index types. They
  need not yet be finite.
- <code>𝕜</code> is the scalar type, such as <code>ℝ</code> or <code>ℂ</code>.
- <code>Matrix ι κ 𝕜</code> is the type of matrices with those row indices,
  column indices, and entries.
- <code>RandomMatrix Ω ι κ 𝕜</code> unfolds to
  <code>Ω → Matrix ι κ 𝕜</code>. The arrow <code>→</code> is the same
  outcome-to-value arrow shown on paper.
- The absence of <code>Measure</code> and <code>Measurable</code> from this type
  is deliberate. They enter later as separate data and hypotheses.
{{< /lean-bridge >}}

Here is the exact base definition from the checked project module:

~~~lean
abbrev RandomMatrix
    (Ω : Type uΩ) (ι : Type uι) (κ : Type uκ) (𝕜 : Type u𝕜) :=
  Ω → Matrix ι κ 𝕜
~~~

Once measurable spaces have been supplied, the same module proves the exact
coordinate criterion:

~~~lean
theorem measurable_iff_entries (X : RandomMatrix Ω ι κ 𝕜) :
    Measurable X ↔ ∀ i j, Measurable fun ω ↦ X ω i j := by
  rw [measurable_comap_iff]
  change Measurable (fun ω i j ↦ X ω i j) ↔ _
  simp only [measurable_pi_iff]
~~~

Read the right side as: for every row index <code>i</code> and column index
<code>j</code>, the scalar function sending <code>ω</code> to the
<code>(i,j)</code> entry of <code>X ω</code> is measurable. The symbol
<code>↔</code> means the matrix-level and entry-level statements imply each
other.

{{< repo-check >}}
The authoritative source is
[`formalization/NonlinearDynamics/Random/RandomMatrices/Basic.lean`](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/Basic.lean).
These are literal commands a learner can type in a temporary Lean file on an
approved Linux builder:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.Basic

#print NonlinearDynamics.Random.RandomMatrix
#check NonlinearDynamics.Random.RandomMatrix.measurable_iff_entries
#check NonlinearDynamics.Random.RandomMatrix.measurable_entry
~~~

<code>#print</code> unfolds the abbreviation. Each <code>#check</code> asks Lean
to elaborate the named theorem and show its type. The guarded shell command
below checks the authoritative module rather than the temporary probe.
{{< /repo-check >}}

## Where to continue

The {{< refterm "probability-law" "probability distribution (law)" >}} page
shows how a measurable random object and a source measure induce a measure on
the value space. The {{< refterm "almost-everywhere" "almost-everywhere" >}}
page separates pointwise properties from statements allowed to fail on a null
set. For the deterministic assembly bridge, continue to
[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}}).

## Further reading

Terence Tao's
[Topics in Random Matrix Theory](https://doi.org/10.1090/gsm/132)
develops the finite-dimensional subject from probabilistic tools to spectral
laws. The [author's book page](https://teorth.github.io/tao-web/topics-in-random-matrix-theory.html)
links an online draft, course notes, and errata.
