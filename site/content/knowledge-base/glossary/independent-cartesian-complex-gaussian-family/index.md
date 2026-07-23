---
title: "Independent Cartesian complex Gaussian family"
slug: "independent-cartesian-complex-gaussian-family"
summary: "An independent Cartesian complex Gaussian family is an indexed collection of measurable complex variables with explicit coordinate laws and one mutual-independence statement across the collection."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.ComplexGaussianFamilies"
og_image: "independent-complex-family-card.png"
og_image_alt: "Four fresh real Gaussian sources form two independent complex coordinates and a one-sixteenth joint quadrant event, contrasted with a dependent source-reuse construction."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

## Start with two complex coordinates

Take four mutually independent real Gaussian variables

\[
X_1,Y_1,X_2,Y_2\sim \mathcal N(0,\tfrac12)
\]

and combine them in pairs:

\[
Z_1=X_1+iY_1,
\qquad
Z_2=X_2+iY_2.
\]

Each complex coordinate has mean zero and total centered squared magnitude

\[
\mathbb E|Z_j|^2
=\mathbb E[X_j^2]+\mathbb E[Y_j^2]
=\frac12+\frac12
=1.
\]

The family statement adds more than these two marginal calculations. Because
all four real sources are mutually independent, the two complex blocks are
independent. Symmetry gives a checkable event calculation: each component is
positive with probability \(1/2\), so

\[
\mathbb P\!\left(
  \operatorname{Re}Z_1\gt 0,\operatorname{Im}Z_1\gt 0,
  \operatorname{Re}Z_2\gt 0,\operatorname{Im}Z_2\gt 0
\right)
=\left(\frac12\right)^4
=\frac1{16}.
\]

If instead \(Z_2=i\overline{Z_1}\), both coordinates still have the same
centered Cartesian Gaussian marginal law, but the second is determined by the
first. The joint law is then not a product. Correct coordinate laws are not a
substitute for family independence.

{{< reference-figure
  wide="true"
  src="two-coordinate-independent-family.svg"
  alt="Four independent centered real Gaussians with variance one half combine into two complex coordinates. Each complex coordinate has total centered squared magnitude one, and the event that all four real components are positive has probability one sixteenth. A contrasting construction reuses the first pair and makes the second complex coordinate a deterministic transform of the first."
  caption="**Finding:** the local calculation \(\mathbb E|Z_j|^2=1\) belongs to each coordinate law. The joint quadrant probability \(1/16\) uses the separate mutual-independence layer. Reusing the same two real sources preserves the marginals but destroys the product joint law."
>}}

An **independent Cartesian complex Gaussian family** is an indexed collection
of complex-valued random variables in which every coordinate has a named exact
{{< refterm "cartesian-complex-gaussian-law" "Cartesian complex Gaussian law" >}}
and all complex coordinates are mutually independent. The word *Cartesian*
keeps the real-part and imaginary-part variances visible. The word
*independent* applies across the indexed complex variables, not only inside one
real-imaginary pair.

Let \(\iota\) be an index type, let \((\Omega,\mathcal F,P)\) be a measured
space, and write

\[
Z_i:\Omega\longrightarrow\mathbb C
\qquad (i\in\iota).
\]

For each index, choose a complex mean \(m_i\) and nonnegative coordinate
variances \(v_{\mathrm R,i}\) and \(v_{\mathrm I,i}\). The project bundle
records three different obligations:

1. every map \(Z_i\) is ordinarily measurable;
2. every \(Z_i\) has the exact Cartesian law with parameters
   \((m_i,v_{\mathrm R,i},v_{\mathrm I,i})\); and
3. the family \((Z_i)_{i\in\iota}\) is mutually independent under \(P\).

{{< reference-figure
  src="independent-complex-family.svg"
  alt="Coordinate-level measurable exact laws and one family-level mutual-independence statement combine to determine an exact finite product law."
  caption="**Finding:** an independent complex Gaussian family has two scopes of evidence. Each coordinate carries measurability and an exact two-variance law; one separate family statement controls dependence across all indices. For a finite index type, those layers determine the exact product joint law. The plate does not choose equal variances, circularity, or a matrix normalization."
>}}

## The exact project definition

{{< lean-bridge
  human="Every indexed complex variable has its stated Cartesian Gaussian law, and the whole indexed family is mutually independent under P."
  math="\(\forall i,\ \mathcal L_P(Z_i)=\Gamma^{\mathrm{cart}}_{m_i;v_{\mathrm R,i},v_{\mathrm I,i}},\qquad (Z_i)_{i\in\iota}\ \text{mutually independent}.\)"
  lean="IndependentCartesianComplexGaussianFamily Z m vRe vIm P"
>}}

- <code>IndependentCartesianComplexGaussianFamily</code> is the project
  structure collecting the obligations; the name itself proves nothing until
  a term of that type is constructed.
- <code>Z : ι → Ω → ℂ</code> is a family of sample maps. Supplying an index
  <code>i</code> chooses one random variable, and supplying
  <code>ω</code> then chooses its realized value.
- <code>m : ι → ℂ</code> records one complex mean per coordinate.
- <code>vRe vIm : ι → ℝ≥0</code> retain two nonnegative component variances
  at every index.
- <code>P : Measure Ω</code> is the one source measure under which the laws
  and independence statement are interpreted.
- The complete structure below reveals the three proof fields Lean will demand:
  ordinary measurability, an exact law at every index, and
  <code>iIndepFun Z P</code>.
{{< /lean-bridge >}}

In Lean, the structure is parameterized by four functions and a base measure:

~~~lean
structure IndependentCartesianComplexGaussianFamily
    (Z : ι → Ω → ℂ) (m : ι → ℂ) (vRe vIm : ι → ℝ≥0)
    (P : Measure Ω) : Prop where
  measurable : ∀ i, Measurable (Z i)
  hasLaw : ∀ i,
    HasCartesianComplexGaussianLaw (Z i) (m i) (vRe i) (vIm i) P
  independent : iIndepFun Z P
~~~

`iIndepFun` is Mathlib's indexed mutual-independence predicate for functions.
It is stronger than listing independence for a few selected pairs. The
structure keeps it separate from the coordinate laws because a collection of
correct marginals does not determine a joint law.

The ordinary `Measurable` field is also deliberate. The exact
{{< refterm "probability-law" "probability law" >}} predicate `HasLaw` carries
almost-everywhere measurability, which ignores changes on null sets. Later
coordinatewise constructions benefit from an ordinary measurable map at each
index, so the family stores that stronger fact rather than pretending it can
be recovered from equality in law.

## Three independence questions, not one

For one variable \(Z_i=X_i+iY_i\), its Cartesian law says that \(X_i\) and
\(Y_i\) are independent real Gaussians. That is **within-coordinate
independence**.

For distinct indices, mutual independence of the complex maps says that the
blocks \(Z_i\) are independent. That is **between-coordinate independence**.
Together with the exact Cartesian laws, this yields the fully factored finite
joint law.

A third question appears when a construction begins from one real family
\((X_i)\) and another real family \((Y_i)\): are the two families independent
of each other? Separate mutual independence inside the \(X\)-family and inside
the \(Y\)-family does not answer that cross-family question.

A two-index counterexample makes the gap visible. Let \(A\) and \(B\) be
independent standard real Gaussians, and set

\[
X_1=A,\quad X_2=B,\qquad
Y_1=B,\quad Y_2=A.
\]

The \(X\)-family is independent, the \(Y\)-family is independent, and each
pair \((X_i,Y_i)\) has independent coordinates. Yet

\[
Z_1=A+iB,
\qquad
Z_2=B+iA=i\,\overline{Z_1}.
\]

The two complex variables are deterministically related, so they are not
independent. The checked constructor therefore asks for mutually independent
**pair-vectors** \((X_i,Y_i)\), each with the exact product law. It never
infers a missing cross-family hypothesis.

### Type a finite independence skeleton locally

The continuous Gaussian proof belongs to Mathlib and the project. A much
smaller <code>Std</code>-only worksheet lets a beginner verify the combinatorial
factorization behind the \(1/16\) calculation. Save this as
<code>FourIndependentSigns.lean</code> outside the project:

~~~lean
import Std

structure FourSigns where
  x1Positive : Bool
  y1Positive : Bool
  x2Positive : Bool
  y2Positive : Bool
deriving Repr, DecidableEq

def signs : List Bool := [false, true]

def outcomes : List FourSigns :=
  signs.flatMap fun x1 =>
  signs.flatMap fun y1 =>
  signs.flatMap fun x2 =>
  signs.map fun y2 =>
    { x1Positive := x1, y1Positive := y1,
      x2Positive := x2, y2Positive := y2 }

def firstQuadrantZ1 (ω : FourSigns) : Bool :=
  ω.x1Positive && ω.y1Positive

def bothFirstQuadrants (ω : FourSigns) : Bool :=
  firstQuadrantZ1 ω && ω.x2Positive && ω.y2Positive

#eval outcomes.length
#eval (outcomes.filter firstQuadrantZ1).length
#eval (outcomes.filter bothFirstQuadrants).length

example : outcomes.length = 16 := by decide
example : (outcomes.filter firstQuadrantZ1).length = 4 := by decide
example : (outcomes.filter bothFirstQuadrants).length = 1 := by decide
~~~

Run the file with the already-installed pinned compiler:

~~~sh
elan run leanprover/lean4:v4.32.0 lean FourIndependentSigns.lean
~~~

Lean prints \(16\), \(4\), and \(1\). Under the uniform law on the sixteen
rows, the first complex coordinate lands in its first quadrant with probability
\(4/16=1/4\), and both do so with probability \(1/16\). The worksheet models
four independent signs, not Gaussian magnitudes; it isolates the finite
factorization step instead of pretending to formalize continuous probability
with a list.

## Finite families have an exact product joint law

When \(\iota\) is finite, collect all coordinates into one sample map

\[
\mathbf Z(\omega)(i)=Z_i(\omega),
\qquad
\mathbf Z:\Omega\longrightarrow(\iota\to\mathbb C).
\]

The theorem `IndependentCartesianComplexGaussianFamily.jointHasLaw` identifies
its exact law:

\[
\mathcal L_P(\mathbf Z)
=\bigotimes_{i\in\iota}
  \Gamma^{\mathrm{cart}}_{m_i;
    v_{\mathrm R,i},v_{\mathrm I,i}}.
\]

In Lean the right side is `Measure.pi`. This is stronger than knowing the
coordinate means, variances, or even all pairwise laws. It fixes the
probability of every measurable event in the finite function space.

The neighboring theorem `jointHasGaussianLaw` forgets the explicit parameters
and retains qualitative Gaussianity on the finite real vector space
\(\iota\to\mathbb C\). The exact product theorem should remain the primary
statement whenever normalization data matters.

### A three-coordinate worked ledger

Take a three-element index type with labels `a`, `b`, and `c`. The following
symbolic ledger illustrates what the four parameter functions can store:

| Index | Mean | Real variance | Imaginary variance |
|---|---:|---:|---:|
| `a` | \(0\) | \(1/2\) | \(1/2\) |
| `b` | \(1+i\) | \(2\) | \(1\) |
| `c` | \(-i\) | \(0\) | \(3\) |

Coordinate `a` has equal component variances, but the family structure does
not attach a circularity theorem to that numerical coincidence. Coordinate
`b` is anisotropic. Coordinate `c` has a zero real-part variance, so its law is
supported on a vertical line through its mean. All three cases fit one family
type.

If the three complex coordinates are mutually independent, their field law is
the product of these three exact measures. Replacing the variance table with a
different schedule changes that product law without changing the family
interface. This is why `vRe` and `vIm` remain functions rather than one global
scale.

The table alone would not prove the product law. One could construct three
variables with exactly these marginal parameters while reusing hidden source
randomness across indices. The `independent` field is the additional evidence
that turns the coordinate ledger into an exact joint measure. These values are
a teaching example, not an empirical result or a selected matrix convention.

### Why the exact law matters beyond moments

Means and variances cannot identify a probability law in general. Even within
a Gaussian discussion, a list of coordinate laws does not identify their
coupling. The exact `HasLaw` statement for the complete field answers every
measurable question about the coordinate vector, not only questions built from
first and second moments.

For example, it determines probabilities of simultaneous coordinate events
and expectations of bounded measurable functions of the whole field. The
project can therefore move the family through a later measurable matrix
assembly map and obtain an exact matrix pushforward law. A parameter table
without the joint measure would not support that transport.

## Real scaling preserves the family interface

A real scale \(c_i\) acts coordinatewise by

\[
Z_i\longmapsto c_i Z_i.
\]

The mean becomes \(c_i m_i\), and both Cartesian variances acquire the same
squared factor:

\[
v_{\mathrm R,i}\longmapsto c_i^2v_{\mathrm R,i},
\qquad
v_{\mathrm I,i}\longmapsto c_i^2v_{\mathrm I,i}.
\]

The theorem `scale` preserves ordinary measurability, every exact coordinate
law, and mutual independence. Negative scales reflect both axes, while a zero
scale produces the correct Dirac coordinate. A general complex scale can mix
the displayed real and imaginary axes, so this theorem intentionally accepts
real scales only.

## The canonical product realization

For a finite index type, the measure
`cartesianComplexGaussianProductMeasure m vRe vIm` lives directly on the
function space \(\iota\to\mathbb C\). Its sample point is already a complete
coordinate assignment. Evaluation at index \(i\),

\[
\operatorname{ev}_i(z)=z(i),
\]

has the requested exact Cartesian law, and the evaluation maps are mutually
independent. The theorem
`cartesianComplexGaussianProductMeasure_independentFamily` bundles those facts
into the same family interface.

This canonical space is a convenient witness, not the only possible outcome
space. Any family on another space with the same exact joint law is
distributionally equivalent for measurable questions about the coordinate
vector.

If \(\iota\) is empty, the function space \(\iota\to\mathbb C\) contains one
function. The empty product law is therefore the Dirac measure at that unique
empty assignment. The checked theorem
`cartesianComplexGaussianProductMeasure_eq_dirac_of_isEmpty` states exactly
this boundary. It does not decide what a zero-dimensional matrix ensemble
should mean.

## Checked consequences and explicit nonclaims

### Inspect the exact project interface

In a clone with the repository's pinned Lean and Mathlib dependencies
installed, a human can type:

~~~lean
import NonlinearDynamics.Random.ComplexGaussianFamilies

#print NonlinearDynamics.Random.IndependentCartesianComplexGaussianFamily
#check NonlinearDynamics.Random.IndependentCartesianComplexGaussianFamily.jointHasLaw
#check NonlinearDynamics.Random.IndependentCartesianComplexGaussianFamily.jointHasGaussianLaw
#check NonlinearDynamics.Random.IndependentCartesianComplexGaussianFamily.scale
#check NonlinearDynamics.Random.cartesianComplexGaussianProductMeasure_independentFamily
#check NonlinearDynamics.Random.cartesianComplexGaussianProductMeasure_eq_dirac_of_isEmpty
~~~

<code>#print</code> exposes the complete structure rather than only its name.
The first two <code>#check</code> lines distinguish the exact product law from
the qualitative Gaussian consequence. The remaining checks inspect scaling,
the canonical finite product witness, and the empty-index boundary.

{{< repo-check >}}
The authoritative source is
[<code>formalization/NonlinearDynamics/Random/ComplexGaussianFamilies.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/ComplexGaussianFamilies.lean).
This is a full project check with the repository's pinned dependencies, not
part of the standalone tutorial above.
{{< /repo-check >}}

The Lean module exposes each coordinate's exact real and imaginary laws,
means, variances, finite-exponent `MemLp`, and integrability. It also checks
real scaling, construction from independent pair-vectors, the finite product
joint law, the canonical sample space, and the empty-index Dirac identity.

It does not establish any of the following:

- pairwise independence as a replacement for mutual independence;
- cross-family independence from two separately independent real families;
- equal real and imaginary variances;
- circular symmetry, properness, or a planar density;
- a dimension-dependent matrix normalization;
- a Gaussian unitary ensemble (GUE) law within this module;
- independence of every entry of a Hermitian matrix, whose lower triangle is
  determined by conjugate reflection; or
- unitary invariance, eigenvalue laws, trace moments, or asymptotics.

## Where to continue

Read {{< refterm "independence" "independence" >}} for event factorization and
the difference between pairwise and mutual claims. The
{{< refterm "cartesian-complex-gaussian-law" "Cartesian complex Gaussian law" >}}
entry develops the single-coordinate law, while
{{< refterm "normalization-convention" "normalization convention" >}}
explains why the two variance functions must remain visible.

The Deep Dive
[Finite Product Probability Spaces and Independent Gaussian Fields]({{< relref "/knowledge-base/deep-dives/finite-product-probability-spaces-and-independent-gaussian-fields" >}})
builds the product-space machinery, dependence audit, empty boundary, and
future matrix bridge in full.

The next deterministic bridge is the
{{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}.
[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}})
shows how complex strict-upper coordinates enter a Hermitian matrix without
claiming that this family supplies the real diagonal or fixes a Gaussian
matrix normalization.

[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}})
then supplies the real diagonal block, selects the Wigner variances, joins both
blocks under one product measure, and transports them to the matrix law.

## References

**Mathlib contributors.**
[Independence of functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Independence/Basic.html),
Mathlib 4 documentation. This is the official API for `IndepFun`,
`iIndepFun`, measurable coordinate transformations, and finite joint product
laws.

**Mathlib contributors.**
[Finite product measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Constructions/Pi.html),
Mathlib 4 documentation. This is the official source for `Measure.pi`,
coordinate evaluation, probability preservation, and the empty product.

**N. R. Goodman.**
[Statistical Analysis Based on a Certain Multivariate Complex Gaussian
Distribution (An Introduction)](https://doi.org/10.1214/aoms/1177704250),
*The Annals of Mathematical Statistics* 34(1), 152-177, 1963. This original
article supplies historical context for complex multivariate Gaussian laws; it
does not choose this project's normalization.

The exact upstream Lean source audited for this entry is Mathlib commit
[`81a5d257`](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by this repository.
