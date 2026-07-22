---
title: "Uniform integrability"
slug: "uniform-integrability"
summary: "Uniform integrability gives one family-wide bound that prevents integrable mass from escaping into smaller sets or larger value tails."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoffLimit"
og_image: "uniform-integrability-card.png"
og_image_alt: "Warm-paper glossary card showing one common tail threshold applied to every member of a function family before a Vitali bridge upgrades pointwise convergence to integrable-norm convergence."
---

**Uniform integrability** is family-wide control of integrable mass. An
individual function can have finite integral while placing most of that
integral on a very small set. A uniformly integrable family rules out doing
this more and more severely as the family index changes. One threshold or one
small-set tolerance works for every member at once.

Random-matrix-theory milestone 27 (RMT-27) needs that uniform quantifier to
upgrade almost-everywhere convergence of Birkhoff averages to convergence in
\(L^1\), the integrable norm. The complete checked narrative is
[Identifying the Finite-Measure Birkhoff Limit in Lean]({{< relref "/development-notebook/2026/07/identifying-the-finite-measure-birkhoff-limit-in-lean" >}}).
The textbook chapter is
[Birkhoff Limits, Invariant Sigma Algebras, and Conditional Expectation]({{< relref "/knowledge-base/deep-dives/birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation" >}}).

{{< reference-figure
  wide="true"
  src="uniform-integrability.svg"
  alt="Every function in one family passes through the same large-value threshold. Each resulting tail has integrable norm below the same requested tolerance. Combined with almost-everywhere convergence on a finite measure space, this uniform tail control leads through the Vitali theorem to integrable-norm convergence."
  caption="**Finding:** the order of quantifiers is the content. After a tolerance is requested, one common threshold controls the large-value tail of every family member. RMT-27 obtains this for all orbit translates from identical distribution, preserves it under Cesaro averaging, and combines it with almost-everywhere convergence through Mathlib's finite-measure Vitali theorem. The diagram states logical dependencies, not measured tail sizes."
>}}

## The two Mathlib predicates

Mathlib deliberately distinguishes two related notions. Let \(\Omega\) be a
measurable space, let \(\mu\) be a measure on it, let \(I\) be an index type,
and let \(F_i:\Omega\to E\) be a family of functions into a normed additive
space \(E\). For an extended nonnegative exponent \(p\), the predicate
<code>UnifIntegrable F p μ</code> is the small-set condition

~~~lean
def UnifIntegrable (F : I → Ω → E) (p : ℝ≥0∞) (μ : Measure Ω) : Prop :=
  ∀ ⦃ε : ℝ⦄, 0 < ε →
    ∃ δ : ℝ, 0 < δ ∧
      ∀ i S, MeasurableSet S → μ S ≤ ENNReal.ofReal δ →
        eLpNorm (S.indicator (F i)) p μ ≤ ENNReal.ofReal ε
~~~

In words: for every positive tolerance \(\varepsilon\), there is one positive
measure scale \(\delta\) such that **every** family member has \(L^p\) norm at
most \(\varepsilon\) when restricted to **every** measurable set of measure at
most \(\delta\). The function
<code>S.indicator (F i)</code> agrees with \(F_i\) on \(S\) and is zero
outside \(S\). The extended value <code>eLpNorm</code> is Mathlib's
extended-nonnegative \(L^p\) norm.

The capitalized predicate used directly by RMT-27 is stronger:

~~~lean
def UniformIntegrable (F : I → Ω → E) (p : ℝ≥0∞)
    (μ : Measure Ω) : Prop :=
  (∀ i, AEStronglyMeasurable (F i) μ) ∧
  UnifIntegrable F p μ ∧
  ∃ C : ℝ≥0, ∀ i, eLpNorm (F i) p μ ≤ C
~~~

It bundles three facts:

1. every member is strongly measurable almost everywhere;
2. the small-set control is uniform across the family; and
3. all full \(L^p\) norms share one finite bound.

Mathlib's source calls the first predicate the measure-theory sense and the
capitalized predicate the probability-theory sense. The names do not impose
probability normalization. RMT-27 uses <code>UniformIntegrable</code> on an
arbitrary finite measure, whose total mass may differ from one.

The theorem that upgrades convergence consumes the small-set component. A
proof <code>h : UniformIntegrable F 1 μ</code> provides it through
<code>h.unifIntegrable</code>, while also making each family member an
\(L^1\) function through <code>h.memLp</code>.

## Equivalent tail control on a finite measure space

For finite \(\mu\) and \(1\le p\lt\infty\), Mathlib proves an equivalent
large-value-tail formulation. Up to the almost-everywhere measurability
clause, <code>UniformIntegrable F p μ</code> says that for every
\(\varepsilon\gt0\), there is one nonnegative threshold \(C\) such that

\[
\left\lVert
\mathbf 1_{\{\omega:C\le\lVert F_i(\omega)\rVert\}}F_i
\right\rVert_{L^p(\mu)}
\le\varepsilon
\qquad\text{for every }i\in I.
\]

The indicator \(\mathbf 1_A\) keeps a function on the set \(A\) and replaces
it by zero elsewhere. At \(p=1\) for real functions, the displayed norm is
the integral of \(|F_i|\) over the part where \(|F_i|\) is at least \(C\).
The important order is

\[
\forall\varepsilon\gt0\ \exists C\ge0\ \forall i.
\]

Allowing a separate threshold \(C_i\) for each member would say only that
each function is integrable. Uniform integrability requires a single
threshold after the tolerance is fixed.

The small-set and tail forms express the same obstruction from opposite
directions. One prevents mass from hiding on sets of vanishing measure. The
other prevents mass from escaping to values of growing magnitude. Finite total
measure is part of Mathlib's equivalence theorem and should not be erased when
using that API.

## Worked comparison: bounded norms are not enough

Let \(\Omega=(0,1)\) with Lebesgue measure. For every positive integer \(n\),
define

\[
F_n(x)=n\,\mathbf 1_{(0,n^{-2})}(x).
\]

Its \(L^1\) norm is

\[
\lVert F_n\rVert_1
{} =
n\cdot n^{-2}=\frac1n.
\]

The family is uniformly integrable. Given \(\varepsilon\gt0\), choose a
positive integer \(N\) with \(1/N\lt\varepsilon\), and use the common tail
threshold \(C=N\). If \(n\lt N\), then \(|F_n|=n\lt C\) everywhere, so its
large-value tail is empty. If \(n\ge N\), the tail is its support and has
integral

\[
\int_{\{|F_n|\ge C\}}|F_n|\,dx
{} =
\frac1n
\le\frac1N
\lt\varepsilon.
\]

Now compare

\[
G_n(x)=n\,\mathbf 1_{(0,n^{-1})}(x).
\]

Every member is integrable and the family has the uniform norm bound

\[
\lVert G_n\rVert_1=n\cdot n^{-1}=1.
\]

Nevertheless, it is not uniformly integrable. Given any finite threshold
\(C\), choose an integer \(n\ge C\). The full support lies in the
large-value tail, so

\[
\int_{\{|G_n|\ge C\}}|G_n|\,dx=1.
\]

No common threshold can make all tails smaller than, for example,
\(\varepsilon=1/2\).

Both sequences converge pointwise to zero for every \(x\in(0,1)\): eventually
their shrinking support no longer contains a fixed positive \(x\). Yet their
norm behavior differs:

\[
\lVert F_n-0\rVert_1=\frac1n\longrightarrow0,
\qquad
\lVert G_n-0\rVert_1=1.
\]

This is the exact gap the Vitali theorem closes. Pointwise or
almost-everywhere convergence plus bounded \(L^1\) norms does not force
\(L^1\) convergence. Uniform integrability supplies the missing no-escape
condition.

## Why measure-preserving orbit translates are uniform

Let \(T:\Omega\to\Omega\) preserve a finite measure \(\mu\), and let
\(f:\Omega\to\mathbb R\) be integrable. The orbit-translate family is

\[
F_i(\omega)=f(T^i\omega),
\qquad i\in\mathbb N.
\]

Measure preservation says that the pushforward of \(\mu\) through every
iterate \(T^i\) is again \(\mu\). Therefore every \(F_i\) has the same
distribution as \(f\). In Lean, RMT-27 first proves

~~~lean
theorem identDistrib_orbit_iterate
    (hT : MeasurePreserving T μ μ) (hf : AEMeasurable f μ) (i : ℕ) :
    IdentDistrib (fun ω ↦ f ((T^[i]) ω)) f μ μ
~~~

Identical distribution means that every measurable test event in the target
has the same measure under both functions. It transfers \(L^1\) norms and all
large-value-tail norms. Mathlib packages the family-wide consequence:

~~~lean
MemLp.uniformIntegrable_of_identDistrib
~~~

RMT-27 specializes it at \(p=1\) to obtain

~~~lean
theorem uniformIntegrable_orbit_iterate
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ) :
    UniformIntegrable (fun i ω ↦ f ((T^[i]) ω)) 1 μ
~~~

No independence assumption appears. Orbit translates are usually highly
dependent because they are values along the same trajectory. Identical
distribution is sufficient for this uniform-integrability step.

The finite-measure premise belongs to the pinned Mathlib theorem used here. It
does not say that identical distribution is conceptually meaningless on every
infinite-measure space; it records the checked route of this module.

## Cesaro averaging preserves the control

The positive-time Birkhoff averages are Cesaro means of the translates:

\[
A_nf
{} =
\frac1n\sum_{i=0}^{n-1}F_i.
\]

Uniform integrability must survive this averaging operation before it can be
combined with RMT-26's pointwise convergence theorem. Mathlib provides exactly
that closure:

~~~lean
theorem uniformIntegrable_average
    (hp : 1 ≤ p) (hF : UniformIntegrable F p μ) :
    UniformIntegrable
      (fun n ↦ (n : ℝ)⁻¹ • ∑ i ∈ Finset.range n, F i) p μ
~~~

The proof uses the triangle inequality for restricted \(L^p\) norms and the
shared full-norm bound. At horizon zero, Lean's inverse convention gives the
zero average. Adding this one zero function causes no problem and lets the
result cover the complete natural-number sequence without a special index
type.

RMT-27 aligns Mathlib's generic average with the project's
<code>birkhoffAverage</code> definition and exposes

~~~lean
theorem uniformIntegrable_birkhoffAverage
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ) :
    UniformIntegrable (fun n ↦ birkhoffAverage ℝ T f n) 1 μ
~~~

Uniform integrability of the averages does not yet prove that they converge.
It provides stability once a convergence mode such as almost-everywhere
convergence is supplied.

## The Vitali bridge in RMT-27

RMT-26 proves that for almost every \(\omega\), the sequence
\(A_nf(\omega)\) converges to the selected total representative
\(L(\omega)=\operatorname{birkhoffLimit}(T,f,\omega)\). Mathlib's
<code>UniformIntegrable.integrable_of_ae_tendsto</code> first shows that
\(L\) is integrable.

Then the finite-measure Vitali theorem

~~~lean
tendsto_Lp_finite_of_tendsto_ae
~~~

combines:

- almost-everywhere strong measurability of every average;
- membership of the limit in \(L^1\);
- <code>UnifIntegrable</code> control inherited from the stronger
  <code>UniformIntegrable</code> result; and
- almost-everywhere pointwise convergence.

Its conclusion at \(p=1\) is

\[
\left\lVert A_nf-L\right\rVert_{L^1(\mu)}\longrightarrow0.
\]

That is a stronger conclusion than RMT-26's pointwise convergence, but it is
proved rather than assumed. It allows the integral over every measurable set
to pass to the limit. RMT-27 applies this continuity on exactly invariant sets
and then invokes
{{< refterm "conditional-expectation" "conditional expectation" >}} uniqueness.

The logical chain is therefore

\[
\begin{aligned}
\text{measure-preserving translates}
&\Longrightarrow \text{identical distribution} \\
&\Longrightarrow \text{uniform integrability of translates} \\
&\Longrightarrow \text{uniform integrability of averages} \\
&\mathrel{+} \text{almost-everywhere convergence} \\
&\Longrightarrow L^1\text{ convergence} \\
&\Longrightarrow \text{passage of invariant-set integrals}.
\end{aligned}
\]

Every arrow is represented by a checked theorem. Pointwise convergence alone
would skip the indispensable middle of the argument.

## Lean interface used by RMT-27

The pinned Mathlib interface consists of:

- <code>UnifIntegrable</code>, uniform small-set \(L^p\) control;
- <code>UniformIntegrable</code>, the measurable, small-set-controlled,
  uniformly norm-bounded bundle;
- <code>uniformIntegrable_iff</code>, the finite-measure tail criterion;
- <code>MemLp.uniformIntegrable_of_identDistrib</code>, the route from one
  \(L^p\) law and identical distributions to the whole family;
- <code>uniformIntegrable_average</code>, Cesaro closure;
- <code>UniformIntegrable.integrable_of_ae_tendsto</code>, integrability of an
  almost-everywhere limit; and
- <code>tendsto_Lp_finite_of_tendsto_ae</code>, the finite-measure Vitali
  upgrade.

The project module contributes:

- <code>identDistrib_orbit_iterate</code>;
- <code>uniformIntegrable_orbit_iterate</code>;
- <code>uniformIntegrable_birkhoffAverage</code>;
- <code>integrable_birkhoffLimit</code>; and
- <code>tendsto_L1_birkhoffAverage_birkhoffLimit</code>.

These are general analytic declarations inside the additive Birkhoff layer.
They do not rely on an ergodicity premise or on a random-matrix cocycle.

## Boundaries and nonclaims

- **Uniform boundedness is not enough at \(p=1\).** The family \(G_n\) above
  has norm exactly one and still fails uniform integrability.
- **Individual integrability is not uniform integrability.** Letting the
  threshold depend on the family index loses the crucial quantifier.
- **Uniform integrability does not imply pointwise convergence.** It controls
  mass escape. A separate convergence hypothesis is still required by the
  Vitali step.
- **Pointwise convergence does not imply norm convergence.** The same
  \(G_n\) example converges pointwise to zero but not in \(L^1\).
- **Identical distribution does not mean independence.** RMT-27 uses only
  equality of pushforward laws for orbit translates.
- **No probability normalization is assumed.** The module uses a finite
  measure, and the full <code>UniformIntegrable</code> predicate is meaningful
  there even though Mathlib describes it as the probability-theory notion.
- **Finite measure is part of this checked Vitali route.** The page does not
  claim the same theorem signature for arbitrary infinite measures.
- **A dominating function is sufficient, not necessary.** A family dominated
  in norm by one integrable function is uniformly integrable, but the concept
  covers families without a single chosen pointwise dominator.
- **This is not a maximal inequality.** Uniform integrability controls a
  family of functions. The RMT-26
  {{< refterm "weak-type-one-one-maximal-bound" "weak-type (1,1) maximal bound" >}}
  controls the measure of an orbitwise exceedance event. They solve different
  steps.
- **No limit identification follows by itself.** The \(L^1\) upgrade makes
  integral passage legal; invariant measurability and
  conditional-expectation uniqueness still have to be proved.

Uniform integrability does not establish ergodicity, mixing, Kingman's
subadditive theorem, a Lyapunov exponent, or an Oseledets splitting.

## Related concepts

- {{< refterm "conditional-expectation" "Conditional expectation" >}} is the
  target identified after uniform integrability permits integral passage.
- {{< refterm "invariant-sigma-algebra" "Invariant sigma algebra" >}}
  specifies the measurable events on which those integrals must agree.
- {{< refterm "almost-everywhere" "Almost everywhere" >}} is the pointwise
  convergence mode fed into the finite-measure Vitali theorem.
- {{< refterm "probability-law" "Probability law" >}} explains the
  pushforward object whose equality gives identical distribution.
- {{< refterm "birkhoff-sum" "Birkhoff sum" >}} supplies the Cesaro averages
  whose family-wide tails are controlled.
- {{< refterm "weak-type-one-one-maximal-bound" "Weak-type (1,1) maximal bound" >}}
  is the distinct maximal-to-pointwise tool used one milestone
  earlier.

## References

<a id="ref-ui-mathlib"></a>**Mathlib contributors.**
[Uniform-integrability definitions](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/UniformIntegrable.lean#L59-L89),
[finite-measure Vitali theorem](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/UniformIntegrable.lean#L517-L534),
and
[tail equivalence and Cesaro closure](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/UniformIntegrable.lean#L876-L921),
Mathlib 4.32.0 at pinned commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).
These files are the authority for the two predicates and the exact hypotheses
of the norm-convergence step.

<a id="ref-ui-identdist"></a>**Mathlib contributors.**
[Identical distributions imply uniform integrability](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Probability/IdentDistrib.lean#L293-L340),
the pinned theorem used for the measure-preserving orbit translates.

<a id="ref-ui-vallee-poussin"></a>**Charles-Jean de la Vallée Poussin.**
[Sur l'integrale de Lebesgue](https://doi.org/10.1090/S0002-9947-1915-1501024-5),
*Transactions of the American Mathematical Society* 16(4), 435-501, 1915,
with the [official AMS scan](https://www.ams.org/tran/1915-016-04/S0002-9947-1915-1501024-5/S0002-9947-1915-1501024-5.pdf).
This is a foundational primary source in the lineage of family-wide
integrability and growth criteria. The project relies on Mathlib's stated
modern predicates and does not claim to formalize the paper directly.

<a id="ref-ui-hess"></a>**Christian Hess, Raffaello Seri, and Christine Choirat.**
[Ergodic Theorems for Extended Real-Valued Random Variables](https://doi.org/10.1016/j.spa.2010.05.008),
*Stochastic Processes and their Applications* 120(10), 1908-1919, 2010,
with the authors' [full text](https://rseri.me/publication/j007/J007.pdf).
The paper gives a modern probability-space pointwise theorem with a
conditional-expectation target. It is context for the ergodic statement, not
the source of RMT-27's repository-specific uniform-integrability route on
arbitrary finite measures.

<a id="ref-ui-project"></a>**Nonlinear Dynamics in Lean contributors.**
[`PointwiseBirkhoffLimit.lean`](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/PointwiseBirkhoffLimit.lean),
the checked source proving identical distribution, uniform integrability of
orbit translates and averages, integrability of the limit, and \(L^1\)
convergence.
