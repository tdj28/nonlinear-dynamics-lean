---
title: "Koopman operator"
slug: "koopman-operator"
summary: "The Koopman operator turns forward state evolution into linear pullback of observables by composition, even when the state map itself is nonlinear."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.KoopmanL2Mean"
og_image: "koopman-operator-card.png"
og_image_alt: "Warm-paper glossary card contrasting forward motion of a state with pullback of an observable. A measure-preserving gate leads to exact real square-integrable norm preservation, while a separate warning says that an isometry need not be onto."
---

The **Koopman operator** lets dynamics act on measurements instead of directly
on states. A state moves forward from \(\omega\) to \(T\omega\). An observable
\(f\) is pulled back by composition to the new observable \(f\circ T\), whose
value at the old state is the value that \(f\) reads at the new state. This
operator on observables is linear even when the state map \(T\) is nonlinear.
The historical composition-operator viewpoint begins with Koopman's
Hamiltonian construction
([Koopman, 1931](#ref-koopman-operator-koopman)).

Random-matrix-theory milestone 25 (RMT-25) constructs this operator on real
\(L^2\), identifies its fixed subspace and orthogonal projection, and proves
norm convergence of its finite averages. The full ascent appears in
[Mean Is Not Pointwise: Koopman Geometry, Coboundaries, and the Missing Maximal Step]({{< relref "/knowledge-base/deep-dives/mean-is-not-pointwise-koopman-geometry-coboundaries-and-the-missing-maximal-step" >}}).
The declaration-level account is
[Koopman L² Mean Convergence and a Dense Pointwise-Good Core in Lean]({{< relref "/development-notebook/2026/07/koopman-l2-mean-convergence-and-a-dense-pointwise-good-core-in-lean" >}}).
Finite orbit notation is developed under
{{< refterm "birkhoff-sum" "Birkhoff sum" >}}, while the distinction between
an event and an existence theorem is developed under
{{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}}.

{{< reference-figure
  src="state-motion-observable-pullback.svg"
  alt="The upper path moves a starting state through the state update and then reads the original observable. The lower path composes the observable with the state update and reads it at the starting state. Both paths produce the same reading, while measure preservation keeps the real square-integrable norm unchanged."
  caption="**Finding:** forward state motion and observable pullback are two descriptions of the same evaluation. The composition operator is linear on observables even when the state update is nonlinear. Measure preservation makes this pullback norm-preserving on real \(L^2\), but the figure does not claim that the operator is onto or has an inverse. The plate is conceptual, not empirical data."
>}}

## Exact definition

Let \((\Omega,\Sigma,\mu)\) be a measure space. Suppose
\(T:\Omega\to\Omega\) is measurable and preserves \(\mu\), meaning

\[
\mu\bigl(T^{-1}(A)\bigr)=\mu(A)
\]

for every measurable set \(A\in\Sigma\). A real \(L^2\) vector is an
almost-everywhere equivalence class of measurable real functions whose square
is integrable. For such a class \([f]\), define

\[
U_T[f]=[f\circ T],
\qquad
(U_Tf)(\omega)=f(T\omega)
\quad\text{for a chosen representative.}
\]

The first formula is the well-defined \(L^2\) object. The second formula is a
representative-level reading and therefore holds with the appropriate
almost-everywhere interpretation. Measure preservation transports null sets
through preimages, so changing \(f\) on a null set does not change
\([f\circ T]\)
([Mathlib's \(L^p\) composition API](#ref-koopman-operator-mathlib-lp)).

RMT-25 freezes the forward-composition convention \(U_Tf=f\circ T\). Some
literature on invertible dynamics uses composition with \(T^{-1}\) instead.
Those are different conventions, and one must not switch between them inside
a proof.

## Motion and pullback point in opposite directions

The state-space arrow is

\[
\omega\longmapsto T\omega.
\]

The observable-space arrow is precomposition:

\[
f\longmapsto f\circ T.
\]

It is called a pullback because a function on the target side of the state
map becomes a function on its source side. Evaluation closes the square:

\[
(U_Tf)(\omega)=f(T\omega).
\]

For real scalars \(a,b\) and observables \(f,g\),

\[
U_T(af+bg)=aU_Tf+bU_Tg.
\]

This linearity uses only the algebra of functions. It does not assert that
\(T\) is linear, smooth, invertible, or even injective.

## What measure preservation buys

Composition preserves the real \(L^2\) norm exactly:

\[
\lVert U_Tf\rVert_2^2
{} =
\int_\Omega |f(T\omega)|^2\,d\mu(\omega)
{} =
\int_\Omega |f(\omega)|^2\,d\mu(\omega)
{} =
\lVert f\rVert_2^2.
\]

Thus \(U_T\) is an isometry on vectors and therefore also a contraction. The
project exports the unconditional operator-norm statement

\[
\lVert U_T\rVert\le 1.
\]

It deliberately does not export unconditional equality with one. For the
zero measure, real \(L^2\) is the trivial space, so the operator norm is zero
even though the vector-level norm identity is still true.

An isometry need not be surjective. For a standard concrete model, take the
one-sided fair Bernoulli sequence space and let \(T\) discard the first bit.
The shift preserves product measure. Every observable in the range of \(U_T\)
depends only on the tail coordinates, so the first-coordinate observable is
not in that range, even modulo null sets. Thus the Koopman isometry is not
onto.

Noninjectivity also survives in a degenerate finite boundary model. On the
two-point space \(\{\mathsf{false},\mathsf{true}\}\), put all mass at
\(\mathsf{false}\) and send both points to \(\mathsf{false}\). This map
preserves the Dirac measure but is not injective, and every RMT-25 theorem
still applies. The public assumptions therefore cannot justify packaging the
Koopman map as a **unitary equivalence**, even though special noninvertible
examples may happen to induce an invertible operator after quotienting by
almost-everywhere equality.

No finite-total-mass, probability, ergodicity, injectivity, surjectivity, or
invertibility premise is needed for the RMT-25 \(L^2\) operator.

## Worked example: a three-state cycle

Let \(\Omega=\{0,1,2\}\), give each point mass \(1/3\), and let
\(T(0)=1\), \(T(1)=2\), and \(T(2)=0\). For

\[
f=(2,-1,4),
\]

the pullback reads the value at the next state:

\[
U_Tf=(-1,4,2),
\qquad
U_T^2f=(4,2,-1).
\]

The norm is unchanged:

\[
\lVert f\rVert_2^2
{} =
\frac{2^2+(-1)^2+4^2}{3}
{} =
7
{} =
\lVert U_Tf\rVert_2^2.
\]

Averaging one full cycle gives

\[
\frac{f+U_Tf+U_T^2f}{3}
{} =
\left(\frac53,\frac53,\frac53\right).
\]

The output is fixed by \(U_T\). In this one-cycle example the fixed vectors
are exactly the constant functions, so the result is the orthogonal projection
of \(f\) onto the fixed subspace. The example is finite and invertible, but
those features are not hypotheses of the general theorem.

## The fixed subspace and mean convergence

The Koopman-fixed subspace is

\[
K=\operatorname{Fix}(U_T)
{} =
\{f\in L^2(\mu):U_Tf=f\}.
\]

Equality here is equality in \(L^2\), hence equality almost everywhere. It is
not automatically a pointwise identity for every chosen representative. Let
\(P_K\) be the Hilbert-space orthogonal projection onto \(K\). The RMT-25
specialization of
[Mathlib's mean-ergodic theorem](#ref-koopman-operator-mathlib-mean) states

\[
\frac1n\sum_{j=0}^{n-1}U_T^j f
\longrightarrow
P_Kf
\qquad\text{in }L^2.
\]

Von Neumann's historical theorem likewise formulates strong convergence as
Hilbert-norm convergence to a projection
([von Neumann, 1932](#ref-koopman-operator-von-neumann)); RMT-25 uses the
discrete contraction theorem above rather than that continuous-time spectral
argument.

This theorem uses the real Hilbert geometry of exponent two. It neither
identifies \(K\) with the constants nor identifies \(P_K\) with a conditional
expectation. Ergodicity and an invariant-sigma-algebra theorem would be
additional layers.

Norm convergence is also not full-sequence pointwise convergence. Birkhoff's
original paper explicitly separates the pointwise problem from convergence in
the mean ([Birkhoff, 1931](#ref-koopman-operator-birkhoff)). RMT-25 derives an
almost-everywhere convergent subsequence through convergence in measure, and
separately constructs a dense pointwise-good core using
{{< refterm "koopman-coboundary" "Koopman coboundaries" >}}. A maximal
stability argument is still required to reach the pointwise Birkhoff theorem
for every integrable observable.

## Lean interface

The central declarations are:

- <code>koopmanL2</code>, the real \(L^2\) continuous linear composition map;
- <code>koopmanL2_apply</code>, its identification with Mathlib's
  measure-preserving composition;
- <code>iterate_koopmanL2_apply</code>, the equation between operator iterates
  and composition by \(T^n\);
- <code>norm_koopmanL2_le</code>, the assumption-safe operator bound;
- <code>koopmanFixedSubspaceL2</code>, the closed fixed subspace;
- <code>koopmanInvariantProjectionL2</code>, its orthogonal projection;
- <code>tendsto_birkhoffAverage_koopmanL2_projection</code>, \(L^2\)-norm
  convergence to that projection; and
- <code>exists_subsequence_ae_tendsto_birkhoffAverage_koopmanL2_projection</code>,
  the strictly increasing almost-everywhere subsequence consequence.

All take only a <code>MeasurePreserving T μ μ</code> hypothesis beyond the
ambient measurable space and real \(L^2\) structure.

## What the term does not imply

A Koopman operator in the RMT-25 sense does not by itself imply:

- that the state map is linear, injective, surjective, or invertible;
- that the operator is a unitary equivalence;
- that its operator norm equals one on a degenerate measure space;
- that fixed vectors are constant;
- that the invariant projection is a conditional expectation;
- that finite averages converge pointwise along the full sequence;
- that the system is ergodic, mixing, chaotic, or statistically independent;
- a pointwise Birkhoff or Kingman theorem; or
- a Lyapunov exponent or Oseledets splitting.

## References

<a id="ref-koopman-operator-koopman"></a>**B. O. Koopman.**
[Hamiltonian Systems and Transformation in Hilbert Space](https://pmc.ncbi.nlm.nih.gov/articles/PMC1076052/),
*Proceedings of the National Academy of Sciences* 17(5), 315-318, 1931,
[DOI 10.1073/pnas.17.5.315](https://doi.org/10.1073/pnas.17.5.315).
Pages 315-316 construct composition operators for continuous-time Hamiltonian
flows with an invariant positive density. That original unitary setting is
historical lineage, not the exact weaker discrete noninvertible interface used
by RMT-25.

<a id="ref-koopman-operator-von-neumann"></a>**John von Neumann.**
[Proof of the Quasi-Ergodic Hypothesis](https://pmc.ncbi.nlm.nih.gov/articles/PMC1076162/),
*Proceedings of the National Academy of Sciences* 18(1), 70-82, 1932,
[DOI 10.1073/pnas.18.1.70](https://doi.org/10.1073/pnas.18.1.70).
Page 71 defines strong convergence as Hilbert-norm convergence, and pages
72-74 prove the historical projection form of the mean theorem. The project
uses Mathlib's discrete contraction theorem rather than reproducing the
original continuous-time spectral argument.

<a id="ref-koopman-operator-birkhoff"></a>**George D. Birkhoff.**
[Proof of the Ergodic Theorem](https://pmc.ncbi.nlm.nih.gov/articles/PMC1076138/),
*Proceedings of the National Academy of Sciences* 17(12), 656-660, 1931,
[DOI 10.1073/pnas.17.2.656](https://doi.org/10.1073/pnas.17.2.656).
Page 656 explicitly separates convergence in the mean from the pointwise
problem. The DOI's unusual `17.2` segment is the identifier displayed by the
publisher even though the bibliographic issue is 17(12). This source supports
the boundary, not a claim that RMT-25 has formalized Birkhoff's full theorem.

<a id="ref-koopman-operator-mathlib-mean"></a>**Mathlib contributors.**
[Von Neumann mean ergodic theorem](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/InnerProductSpace/MeanErgodic.html),
with the
[pinned v4.32.0 implementation](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/InnerProductSpace/MeanErgodic.lean#L82-L94).
The theorem for a contracting continuous linear self-map is the exact upstream
result specialized by RMT-25.

<a id="ref-koopman-operator-mathlib-lp"></a>**Mathlib contributors.**
[Pinned measure-preserving \(L^p\) composition API](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/LpSpace/Basic.lean#L559-L633),
Mathlib v4.32.0. These definitions and theorems supply the representative
formula, iterate law, linear map, and linear isometry used to define
<code>koopmanL2</code>.

The exact upstream revision for both Mathlib references is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the version pinned by <code>formalization/lake-manifest.json</code>.
