---
title: "Invariant sigma algebra"
slug: "invariant-sigma-algebra"
summary: "The invariant sigma algebra contains exactly the measurable events whose membership is unchanged when a state is pulled back through one step of the dynamics."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoffLimit"
og_image: "invariant-sigma-algebra-card.png"
og_image_alt: "Warm-paper glossary card showing measurable events passing through an exact preimage-equality gate to become invariant information."
---

The **invariant sigma algebra** is the collection of measurable questions whose
answers cannot change under the dynamics. Let \(\Omega\) be a state space,
let \(\mathcal B\) be its ambient sigma algebra of measurable sets, and let
\(T:\Omega\to\Omega\) advance a state by one discrete time step. In this
project the invariant sigma algebra is

\[
\mathcal I_T
{} =
\left\{S\in\mathcal B:T^{-1}(S)=S\right\}.
\]

The equality is literal set equality. It is not equality only after discarding
a null set. That exact choice is the central boundary of this entry.

Random-matrix-theory milestone 27 (RMT-27) identifies the pointwise Birkhoff
limit as conditional expectation onto \(\mathcal I_T\). The complete checked
narrative is
[Identifying the Finite-Measure Birkhoff Limit in Lean]({{< relref "/development-notebook/2026/07/identifying-the-finite-measure-birkhoff-limit-in-lean" >}}).
The textbook chapter is
[Birkhoff Limits, Invariant Sigma Algebras, and Conditional Expectation]({{< relref "/knowledge-base/deep-dives/birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation" >}}).

{{< reference-figure
  wide="true"
  src="invariant-sigma-algebra.svg"
  alt="A four-state map has two backward-saturated basins. The set containing both states in the upper basin is unchanged by preimage and enters the invariant sigma algebra, while the singleton containing only its fixed point gains a predecessor under preimage and fails the exact equality test."
  caption="**Finding:** invariant events are backward-saturated. In the toy map, \(\{a,b\}\) contains its fixed point and every state that enters it, so \(T^{-1}\{a,b\}=\{a,b\}\). The smaller set \(\{b\}\) omits the predecessor \(a\), so its preimage is \(\{a,b\}\) and it is not exactly invariant. This finite picture teaches the set-theoretic definition only; the displayed map does not preserve counting measure and the figure makes no ergodicity claim."
>}}

## Exact project definition

Mathlib packages the construction as a measurable space:

~~~lean
def MeasurableSpace.invariants
    [m : MeasurableSpace Ω] (T : Ω → Ω) : MeasurableSpace Ω :=
  { m ⊓ ⟨fun S ↦ T ⁻¹' S = S, by simp, by simp,
      fun F hF ↦ by simp [hF]⟩ with
    MeasurableSet' := fun S ↦ MeasurableSet[m] S ∧ T ⁻¹' S = S }
~~~

The operational membership theorem removes the implementation detail:

~~~lean
MeasurableSet[MeasurableSpace.invariants T] S ↔
  MeasurableSet S ∧ T ⁻¹' S = S
~~~

Thus a set must pass two tests:

1. It is measurable in the ambient measurable space.
2. Pulling it back through one application of \(T\) produces the same set.

The preimage notation means

\[
T^{-1}(S)=\{\omega\in\Omega:T(\omega)\in S\}.
\]

It asks whether a state is in \(S\) exactly when its next state is in \(S\).
This is the right direction even when \(T\) has no inverse function. A
noninjective or nonsurjective map still has a preimage operation on sets.

The construction really is a sigma algebra. The whole space and empty set are
fixed by preimage. Preimage commutes with complements,

\[
T^{-1}(S^{\mathsf c})=(T^{-1}S)^{\mathsf c},
\]

and with countable unions,

\[
T^{-1}\!\left(\bigcup_{j=0}^{\infty}S_j\right)
{} =
\bigcup_{j=0}^{\infty}T^{-1}(S_j).
\]

Consequently, complements and countable unions of exactly invariant measurable
sets remain exactly invariant and measurable. The raw construction needs no
measure and does not assume that \(T\) is measurable. Those hypotheses enter
later theorems about integration and orbit averages.

## Worked finite example: backward saturation

Take the four-state space

\[
\Omega=\{a,b,c,d\}
\]

with every subset measurable. Define the map by

\[
T(a)=b,\qquad T(b)=b,\qquad T(c)=d,\qquad T(d)=d.
\]

There are two basins: \(a\) enters the fixed point \(b\), and \(c\) enters
the fixed point \(d\). Consider

\[
S=\{a,b\}.
\]

A state maps into \(S\) precisely when it is \(a\) or \(b\). Therefore

\[
T^{-1}(S)=\{a,b\}=S.
\]

The complementary basin \(S^{\mathsf c}=\{c,d\}\) is invariant as well. In
fact the entire invariant sigma algebra is

\[
\mathcal I_T
{} =
\left\{\varnothing,\{a,b\},\{c,d\},\Omega\right\}.
\]

Now inspect the tempting singleton \(R=\{b\}\). Both \(a\) and \(b\) map
to \(b\), so

\[
T^{-1}(R)=\{a,b\}\ne\{b\}=R.
\]

Forward stability of the point \(b\) is not enough. An exact invariant event
must also include every predecessor that enters it. This is why "union of
fixed points" is not a reliable description for a noninvertible map.

The example deliberately isolates the set logic. Counting measure is not
preserved by this map because two points collapse into each fixed point. No
measure-preserving conclusion should be inferred from the diagram.

## What invariant measurability says about functions

A real-valued function \(g:\Omega\to\mathbb R\) is measurable from
\(\mathcal I_T\) when the inverse image of every Borel set of real numbers is
an invariant measurable event. Mathlib exposes this as

~~~lean
Measurable[MeasurableSpace.invariants T] g ↔
  Measurable g ∧
    ∀ U, MeasurableSet U → (g ∘ T) ⁻¹' U = g ⁻¹' U
~~~

For a target measurable space whose singletons are measurable, Mathlib then
proves

~~~lean
MeasurableSpace.comp_eq_of_measurable_invariants hg :
  g ∘ T = g
~~~

So invariant measurability is stronger than merely saying that \(g\) is
ambient-measurable. It means that \(g\) is literally constant along one-step
forward motion:

\[
g(T\omega)=g(\omega)
\qquad\text{for every }\omega\in\Omega.
\]

The converse also follows from the displayed measurable interface when \(g\)
is ambient-measurable: literal equality \(g\circ T=g\) makes every measurable
fiber exactly invariant.

RMT-27 uses this route for a total function named
<code>birkhoffLimit T f</code>. Its ordinary value is selected with
<code>limUnder</code>. When the averages converge, it is their unique limit;
when they do not converge, <code>limUnder</code> supplies a fixed fallback.
The module proves that both branches obey

\[
\operatorname{birkhoffLimit}(T,f,T\omega)
{} =
\operatorname{birkhoffLimit}(T,f,\omega).
\]

This pointwise fallback discipline matters. Proving invariance only on the
conull convergence set would not by itself make this chosen ordinary function
measurable for Mathlib's exact invariant sigma algebra.

## Exact invariance versus invariance modulo null sets

Once a measure \(\mu\) on \(\Omega\) is present, another common convention is
to call \(S\) invariant when

\[
\mu\bigl(T^{-1}(S)\mathbin{\triangle}S\bigr)=0,
\]

where \(A\mathbin{\triangle}B\) is the symmetric difference: the points that
belong to exactly one of \(A\) and \(B\). That is invariance **modulo null
sets**. It permits the two sets to disagree on a set of measure zero.

The two conventions must not be silently exchanged:

- Mathlib's <code>MeasurableSpace.invariants T</code> uses literal
  \(T^{-1}(S)=S\).
- A completed invariant field in a classical probability text may contain
  events that are invariant only modulo \(\mu\)-null sets.
- Exact invariance implies invariance modulo null sets, but the reverse need
  not hold for the particular representatives chosen as ordinary sets.
- Conditional expectations are themselves unique only almost everywhere, so
  different but appropriately completed sigma-algebra presentations may lead
  to almost-everywhere equivalent objects without being definitionally the
  same measurable space.

RMT-27 does not need to identify these two sigma algebras. It constructs an
exactly invariant measurable representative of the Birkhoff limit and applies
Mathlib's {{< refterm "conditional-expectation" "conditional expectation" >}}
uniqueness theorem directly to the exact field.

This also explains why the theorem

~~~lean
MeasurableSpace.le_invariants_iterate T n :
  MeasurableSpace.invariants T ≤
    MeasurableSpace.invariants (T^[n])
~~~

points in only one direction. A set unchanged by one step is unchanged by
every iterate. A set unchanged by \(n\) steps can still cycle through \(n\)
different phases and fail one-step invariance. Equality would erase real
periodic information.

## Identity, constant, and nonergodic dynamics

Three extremes prevent common overstatements.

For identity dynamics, \(T=\operatorname{id}\), every measurable set satisfies
\(T^{-1}(S)=S\). Mathlib proves

~~~lean
MeasurableSpace.invariants_id :
  MeasurableSpace.invariants id = inferInstance
~~~

The invariant sigma algebra is the full ambient sigma algebra, not the trivial
one. A conditional expectation onto it retains all measurable information.

For a constant map on a nonempty space, \(T(\omega)=c\), the only exactly
invariant sets are \(\varnothing\) and \(\Omega\). If \(c\in S\), then
\(T^{-1}(S)=\Omega\), so equality forces \(S=\Omega\). If \(c\notin S\), the
preimage is empty, so equality forces \(S=\varnothing\). This statement is
about the raw map. Whether such a map preserves a proposed measure is a
separate question. It does preserve the Dirac measure concentrated at \(c\),
which is the noninjective and nonsurjective boundary probe in RMT-27.

For a nonergodic measure-preserving system, \(\mathcal I_T\) can contain
nontrivial events of intermediate measure. The identified Birkhoff limit may
then take different values on different invariant components. The general
RMT-27 theorem intentionally preserves that information instead of replacing
the limit by one global constant.

## Lean interface used by RMT-27

The pinned Mathlib interface consists of:

- <code>MeasurableSpace.invariants</code>, the exact sigma algebra;
- <code>MeasurableSpace.measurableSet_invariants</code>, its membership
  equivalence;
- <code>MeasurableSpace.invariants_le</code>, the proof that it is a
  sub-sigma algebra of the ambient space;
- <code>MeasurableSpace.measurable_invariants_dom</code>, the measurable
  function interface;
- <code>MeasurableSpace.comp_eq_of_measurable_invariants</code>, pointwise
  invariance of functions; and
- <code>MeasurableSpace.le_invariants_iterate</code>, the one-way iterate
  inclusion.

The project module adds:

- <code>birkhoffLimit_apply_base</code>, literal invariance of the total limit
  representative;
- <code>measurable_birkhoffLimit_invariants</code>, measurability in the exact
  invariant sigma algebra;
- <code>setIntegral_orbit_iterate_eq</code>, preservation of integrals over
  exactly invariant measurable sets, using
  <code>MeasurePreserving.restrict_preimage</code> without an embedding
  premise;
- <code>setIntegral_birkhoffLimit_eq</code>, the same identity for the
  integrable limit after \(L^1\) convergence; and
- <code>ae_tendsto_birkhoffAverage_condExp</code>, convergence almost
  everywhere to conditional expectation onto the exact invariant sigma
  algebra.

## Boundaries and nonclaims

- **No measure is built into the definition.** An invariant sigma algebra can
  be formed for any self-map. Measure preservation is required by the
  Birkhoff theorem, not by <code>MeasurableSpace.invariants</code> itself.
- **Exact does not mean pointwise ergodic.** A rich exact invariant sigma
  algebra is compatible with measure preservation and pointwise convergence.
  Identity dynamics are the simplest example.
- **Invariant does not mean constant.** A function measurable for
  \(\mathcal I_T\) is constant along each forward orbit, but it can differ
  between invariant components.
- **Ergodicity is additional.** It concerns the measures of invariant events.
  RMT-27 assumes no ergodicity and proves no collapse to the trivial sigma
  algebra. RMT-28 adds the weaker pre-ergodic rigidity gate where constancy is
  all that is needed.
- **No inverse map is required.** The definition uses set preimages. It does
  not require injectivity, surjectivity, invertibility, or a measurable
  inverse.
- **One iterate can retain more sets.** Invariance under \(T^n\) does not in
  general imply invariance under \(T\).
- **A null-set completion is not implicit.** The module proves what it needs
  for the exact field and transports conclusions almost everywhere where
  conditional expectation requires it.

The invariant sigma algebra alone proves neither almost-everywhere convergence
nor integrability of the limit. It does not provide
{{< refterm "uniform-integrability" "uniform integrability" >}}, identify ergodic
components as a measurable quotient, prove mixing, or establish a Lyapunov
exponent or an Oseledets splitting.

## Related concepts

- {{< refterm "ergodicity" "Ergodicity" >}} makes exact invariant information
  trivial modulo null sets, not literally absent.
- {{< refterm "normalized-space-average" "Normalized space average" >}} is
  the constant obtained after that modulo-null collapse on finite nonzero
  mass.
- {{< refterm "conditional-expectation" "Conditional expectation" >}}
  extracts exactly the integrable information visible to a chosen sub-sigma
  algebra.
- {{< refterm "uniform-integrability" "Uniform integrability" >}} supplies
  the norm-convergence bridge used before invariant-set integrals can pass to
  the Birkhoff limit.
- {{< refterm "birkhoff-sum" "Birkhoff sum" >}} is the finite orbit quantity
  whose normalized limits become invariant.
- {{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}}
  records existence of a pointwise limit before RMT-27 identifies it.
- {{< refterm "koopman-operator" "Koopman operator" >}} sends an observable
  to its pullback along \(T\); fixed observables are the function-level face
  of invariant information.
- {{< refterm "almost-everywhere" "Almost everywhere" >}} explains the
  representative boundary between exact set equality and equality modulo a
  null set.

## References

<a id="ref-invariants-mathlib"></a>**Mathlib contributors.**
[Exact invariant measurable spaces](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/MeasurableSpace/Invariants.lean#L27-L75),
Mathlib 4.32.0 at pinned commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).
This file is the authority for the exact preimage definition and the function
interfaces quoted above.

<a id="ref-invariants-birkhoff"></a>**George D. Birkhoff.**
[Proof of the Ergodic Theorem](https://doi.org/10.1073/pnas.17.2.656),
*Proceedings of the National Academy of Sciences* 17(12), 656-660, 1931.
The original paper proves pointwise time-average convergence in its geometric
setting and separates the nontransitive limit from the later transitive
specialization. Its terminology is historical and is not Mathlib's exact
sigma-algebra API.

<a id="ref-invariants-chacon"></a>**R. V. Chacon.**
[Identification of the Limit of Operator Averages](https://iumj.org/article/1425/),
*Journal of Mathematics and Mechanics* 11(6), 961-968, 1962,
[DOI](https://doi.org/10.1512/iumj.1962.11.11054). Pages 961-963 describe the
invariant Borel field with null-set completion; pages 967-968 perform the
limit-identification step. The project cites it to expose, not blur, the
classical completion convention.

<a id="ref-invariants-hess"></a>**Christian Hess, Raffaello Seri, and Christine Choirat.**
[Ergodic Theorems for Extended Real-Valued Random Variables](https://doi.org/10.1016/j.spa.2010.05.008),
*Stochastic Processes and their Applications* 120(10), 1908-1919, 2010,
with the authors' [full text](https://rseri.me/publication/j007/J007.pdf).
Section 2 distinguishes invariant sets and invariant random variables, and
Theorem 1 states the nonergodic conditional-expectation target for a
not-necessarily-invertible measure-preserving transformation on a probability
space. RMT-27 proves its own finite-measure real-integrable formulation.

<a id="ref-invariants-project"></a>**Nonlinear Dynamics in Lean contributors.**
[`PointwiseBirkhoffLimit.lean`](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/PointwiseBirkhoffLimit.lean),
the checked source constructing the exact-invariant total limit and identifying
it almost everywhere with conditional expectation.
