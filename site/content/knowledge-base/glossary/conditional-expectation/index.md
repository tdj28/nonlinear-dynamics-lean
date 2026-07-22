---
title: "Conditional expectation"
slug: "conditional-expectation"
summary: "Conditional expectation is the almost-everywhere unique integrable function visible to a chosen sub-sigma algebra that preserves the original function's integral on every event visible there."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoffLimit"
og_image: "conditional-expectation-card.png"
og_image_alt: "Warm-paper glossary card grouping four fine observable values into two visible cells and replacing each group by the value that preserves its cell integral."
---

**Conditional expectation** is an information-preserving coarse view of an
integrable observable. Let \((\Omega,\mathcal B,\mu)\) be a measure space,
let \(\mathcal G\) be a sub-sigma algebra of the ambient sigma algebra
\(\mathcal B\), and let \(f:\Omega\to\mathbb R\) be integrable. A version of
the conditional expectation

\[
\mathbb E_\mu[f\mid\mathcal G]
\]

is measurable using only the events in \(\mathcal G\), yet has the same
integral as \(f\) on every \(\mathcal G\)-measurable event. Measurability,
integrability, and those eventwise integral identities identify it uniquely
up to a \(\mu\)-null set.

Random-matrix-theory milestone 27 (RMT-27) proves that the pointwise Birkhoff
limit is conditional expectation onto the exact invariant sigma algebra. The
complete checked narrative is
[Identifying the Finite-Measure Birkhoff Limit in Lean]({{< relref "/development-notebook/2026/07/identifying-the-finite-measure-birkhoff-limit-in-lean" >}}).
The textbook chapter is
[Birkhoff Limits, Invariant Sigma Algebras, and Conditional Expectation]({{< relref "/knowledge-base/deep-dives/birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation" >}}).

{{< reference-figure
  wide="true"
  src="conditional-expectation.svg"
  alt="Four equally weighted atoms carry fine observable values 1, 3, 2, and 6. A coarse sigma algebra can distinguish only the first pair from the second pair, so conditional expectation replaces the pair values by 2 and 4. The cell totals remain 4 and 8 on both sides."
  caption="**Finding:** conditional expectation forgets variation that the chosen sigma algebra cannot see while preserving every visible-set integral. For four equally weighted atoms grouped into two cells, the values \(1,3\) become \(2,2\), and \(2,6\) become \(4,4\). Each cell total is unchanged: \(1+3=2+2=4\) and \(2+6=4+4=8\). Equal weights make these arithmetic means; unequal atom masses would produce weighted means."
>}}

## Characterization used in the project

Write \(g=\mathbb E_\mu[f\mid\mathcal G]\). On a finite measure space, the
characterization consumed by RMT-27 has three parts:

1. \(g\) is measurable with respect to \(\mathcal G\), up to modification on
   a \(\mu\)-null set.
2. \(g\) is integrable.
3. For every \(S\in\mathcal G\),

   \[
   \int_S g\,d\mu=\int_S f\,d\mu.
   \]

The third condition says that no question expressible by the coarser
information system can distinguish the total contribution of \(g\) from the
total contribution of \(f\). Taking \(S=\Omega\) gives equality of global
integrals, but global equality alone is far too weak. The identity must hold
on every visible event.

Mathlib defines a function-valued conditional expectation and supplies the
notation

~~~lean
μ[f | 𝓖]
~~~

for <code>MeasureTheory.condExp 𝓖 μ f</code>. Its uniqueness theorem is the
direction used by the project:

~~~lean
theorem ae_eq_condExp_of_forall_setIntegral_eq
    (h𝓖 : 𝓖 ≤ 𝓑) [SigmaFinite (μ.trim h𝓖)]
    (hf : Integrable f μ)
    (hg_int : ∀ S, MeasurableSet[𝓖] S → μ S < ∞ →
      IntegrableOn g S μ)
    (hg_eq : ∀ S, MeasurableSet[𝓖] S → μ S < ∞ →
      ∫ x in S, g x ∂μ = ∫ x in S, f x ∂μ)
    (hgm : AEStronglyMeasurable[𝓖] g μ) :
    g =ᵐ[μ] μ[f | 𝓖]
~~~

Here \(\mu\operatorname{.trim}(h_{\mathcal G})\) is the measure viewed on the
smaller measurable space. Sigma-finiteness of that trimmed measure is part of
the general construction. RMT-27 works under <code>IsFiniteMeasure μ</code>,
which supplies the required sigma-finiteness without assuming that
\(\mu(\Omega)=1\).

The theorem's local integrability premise ranges over finite-measure visible
sets because the general interface supports sigma-finite measures. In the
project, the Birkhoff limit is globally integrable and the whole measure is
finite, so every one of those local obligations follows immediately.

## Worked example: two visible cells

Let

\[
\Omega=\{a,b,c,d\}
\]

with counting measure, so every atom has mass one and
\(\mu(\Omega)=4\). This is a finite measure, not a probability measure. Let
the coarse sigma algebra be

\[
\mathcal G
{} =
\left\{\varnothing,\{a,b\},\{c,d\},\Omega\right\}.
\]

It can answer whether a state lies in the first pair or the second pair, but
it cannot distinguish the two states inside either pair. Define

\[
f(a)=1,\qquad f(b)=3,\qquad f(c)=2,\qquad f(d)=6.
\]

A \(\mathcal G\)-measurable real function must be constant on each visible
cell. Write its values as \(u\) on \(\{a,b\}\) and \(v\) on
\(\{c,d\}\). Integral preservation on the first cell requires

\[
2u=u+u=1+3=4,
\]

so \(u=2\). On the second cell it requires

\[
2v=v+v=2+6=8,
\]

so \(v=4\). Therefore

\[
\mathbb E_\mu[f\mid\mathcal G](a)
{} =
\mathbb E_\mu[f\mid\mathcal G](b)=2,
\]

and

\[
\mathbb E_\mu[f\mid\mathcal G](c)
{} =
\mathbb E_\mu[f\mid\mathcal G](d)=4.
\]

The empty-set identity is automatic, and adding the two cell identities gives
the whole-space identity

\[
2+2+4+4=12=1+3+2+6.
\]

With unequal atom masses, the same equations produce weighted cell averages.
For example, if \(a\) has mass one and \(b\) has mass three, then the first
cell value becomes \((1\cdot1+3\cdot3)/(1+3)=5/2\), not the unweighted mean
two. Conditional expectation is tied to the measure as well as the sigma
algebra.

## Full information and no information

The two endpoint sigma algebras calibrate the definition.

If \(\mathcal G=\mathcal B\), then an integrable \(f\) is already measurable
with respect to all the available information. Conditional expectation returns
\(f\) almost everywhere:

\[
\mathbb E_\mu[f\mid\mathcal B]=f
\quad\text{almost everywhere}.
\]

If \(\mathcal G=\{\varnothing,\Omega\}\) is the trivial sigma algebra and
\(0\lt\mu(\Omega)\lt\infty\), every \(\mathcal G\)-measurable real function
is almost everywhere constant. Integral preservation determines that constant:

\[
\mathbb E_\mu[f\mid\mathcal G]
{} =
\frac{1}{\mu(\Omega)}\int_\Omega f\,d\mu
\quad\text{almost everywhere}.
\]

Only on a probability space, where \(\mu(\Omega)=1\), does this simplify to
the unnormalized integral \(\int f\,d\mu\). RMT-27 does not assume probability
normalization, and it does not divide by total mass. The zero measure is
allowed by the theorem and would make such division invalid; its
almost-everywhere conclusion is vacuous.

For identity dynamics, the {{< refterm "invariant-sigma-algebra" "invariant sigma algebra" >}}
is the full ambient sigma algebra. Therefore the Birkhoff
target is \(f\) itself almost everywhere, exactly as positive-time identity
averages suggest. For ergodic dynamics on a positive finite measure space, a
RMT-28 shows that the invariant field is trivial modulo null sets and derives
the normalized constant as a separate specialization; see
[Ergodic Birkhoff Limits and Normalized Space Averages]({{< relref "/knowledge-base/deep-dives/ergodic-birkhoff-limits-and-normalized-space-averages" >}}).
It does not retroactively add ergodicity to RMT-27.

## Why the Birkhoff limit qualifies

Let \(T:\Omega\to\Omega\) preserve a finite measure \(\mu\), and let
\(f:\Omega\to\mathbb R\) be integrable. For a positive natural number \(n\),
the Birkhoff average is

\[
A_nf(\omega)
{} =
\frac{1}{n}\sum_{j=0}^{n-1}f(T^j\omega).
\]

RMT-26 proved that these averages converge for almost every starting state
\(\omega\). Convergence alone does not identify the limit. RMT-27 constructs
one total representative \(L=\operatorname{birkhoffLimit}(T,f)\), then proves
the three conditional-expectation obligations.

### 1. The limit sees only invariant information

The one-prefix shift identity for Birkhoff averages implies

\[
L(T\omega)=L(\omega)
\qquad\text{for every }\omega.
\]

Together with ambient measurability, this proves that \(L\) is measurable for
Mathlib's exact invariant sigma algebra
<code>MeasurableSpace.invariants T</code>. The equality is pointwise even on
the fallback branch where the averages diverge; the final identification with
conditional expectation is still only almost everywhere.

### 2. The limit is integrable

Pointwise convergence does not imply integrability of a limit. RMT-27 proves
{{< refterm "uniform-integrability" "uniform integrability" >}} of the orbit
translates and therefore of their Cesaro averages. Mathlib's finite-measure
Vitali theorem upgrades almost-everywhere convergence to convergence in
\(L^1\), the integrable norm:

\[
\left\lVert A_nf-L\right\rVert_{L^1(\mu)}\longrightarrow0.
\]

This both establishes integrability of \(L\) and creates the continuity needed
to pass integrals to the limit.

### 3. Visible-set integrals agree

Take an exactly invariant measurable set \(S\), so
\(T^{-1}(S)=S\). Measure preservation gives the same integral for every orbit
translate:

\[
\int_S f(T^j\omega)\,d\mu(\omega)
{} =
\int_S f(\omega)\,d\mu(\omega).
\]

The checked proof uses <code>MeasurePreserving.restrict_preimage</code>. This
route remains valid for a map that is neither injective nor surjective; a
generic change-of-variables theorem requiring a measurable embedding would be
too strong. Averaging the translate identities gives, for every \(n\ge1\),

\[
\int_S A_nf\,d\mu=\int_S f\,d\mu.
\]

Convergence in \(L^1\) passes the left side to the limit:

\[
\int_S L\,d\mu=\int_S f\,d\mu.
\]

Mathlib's uniqueness theorem now yields

\[
L
{} =
\mu[f\mid\operatorname{invariants}(T)]
\quad\text{almost everywhere}.
\]

Combining this equality with pointwise convergence gives the exposed theorem

~~~lean
theorem ae_tendsto_birkhoffAverage_condExp
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ) :
    ∀ᵐ ω ∂μ,
      Tendsto (fun n ↦ birkhoffAverage ℝ T f n ω) atTop
        (nhds (μ[f | MeasurableSpace.invariants T] ω))
~~~

No probability, ergodicity, injectivity, surjectivity, or invertibility
assumption appears in that signature.

## Representatives and Mathlib's total definition

Conditional expectation is mathematically unique only almost everywhere. If
two candidate functions differ on a null set, their integrals on measurable
sets agree and they represent the same \(L^1\) object. Mathlib nevertheless
defines <code>condExp</code> as an ordinary function so that it can appear in
pointwise formulas. The API therefore distinguishes literal equality from
almost-everywhere equality.

The definition is total. Mathlib returns the zero function if the requested
smaller measurable space is not below the ambient one, if the trimmed measure
is not sigma-finite, or if the input is not integrable. This makes the Lean
term meaningful for every syntactically valid input. It does **not** remove
the premises from theorems that assert the usual conditional-expectation
properties.

RMT-27 starts with a merely integrable ordinary representative \(f\), which is
only guaranteed to be strongly measurable almost everywhere. Inside the proof
it chooses a strongly measurable representative \(f'\). It proves the result
for \(f'\), then transports:

- every finite orbit average through the almost-everywhere equality
  \(f=f'\);
- the selected total Birkhoff limits through
  <code>birkhoffLimit_ae_eq_of_ae_eq</code>; and
- conditional expectations through <code>condExp_congr_ae</code>.

The exposed theorem therefore applies to the original integrable function and
does not quietly strengthen its input to ordinary everywhere measurability.

## Lean interface used by RMT-27

The pinned Mathlib conditional-expectation layer contributes:

- <code>MeasureTheory.condExp</code> and notation <code>μ[f | 𝓖]</code>;
- <code>stronglyMeasurable_condExp</code> and
  <code>integrable_condExp</code>;
- <code>setIntegral_condExp</code>, the visible-set integral identity;
- <code>ae_eq_condExp_of_forall_setIntegral_eq</code>, the uniqueness theorem
  used by RMT-27; and
- <code>condExp_congr_ae</code>, transport across a change of representative.

The project module contributes:

- <code>integrable_birkhoffLimit</code>;
- <code>measurable_birkhoffLimit_invariants</code>;
- <code>setIntegral_birkhoffAverage_eq</code> for every positive horizon;
- <code>setIntegral_birkhoffLimit_eq</code> after \(L^1\) passage;
- <code>birkhoffLimit_ae_eq_condExp</code>, the uniqueness conclusion; and
- <code>ae_tendsto_birkhoffAverage_condExp</code>, the final pointwise
  identified-limit theorem.

The private strongly measurable proof is deliberately hidden behind the
public integrable interface. It is proof architecture, not an extra premise
for downstream users.

## Boundaries and nonclaims

- **The answer depends on the sigma algebra.** Coarser information averages
  away more variation. Finer information retains more of \(f\).
- **The answer depends on the measure.** Cell means are weighted by atom
  masses. Changing \(\mu\) can change conditional expectation even when
  \(f\) and \(\mathcal G\) stay fixed.
- **Uniqueness is almost everywhere.** There is generally no theorem that two
  versions agree at every point.
- **It is not automatically constant.** Constancy needs a trivial information
  field, such as an ergodic invariant field modulo null sets. RMT-27 does not
  assume this.
- **It is not merely a global mean.** Equality of whole-space integrals does
  not characterize conditional expectation. Every visible-set integral must
  agree.
- **It is not conditioning on one event only.** Conditioning on a sigma
  algebra enforces consistency across all events in that information system.
- **The \(L^2\) projection picture has a boundary.** For square-integrable
  functions, conditional expectation is an orthogonal projection in
  \(L^2\). RMT-27 accepts every integrable real function and uses the
  \(L^1\) characterization instead.
- **A target does not prove convergence.** Naming
  \(\mu[f\mid\mathcal I_T]\) does not by itself show that Birkhoff averages
  approach it. RMT-26 provides pointwise convergence, and RMT-27 proves the
  identification.
- **The theorem is not Kingman's theorem.** It identifies additive Birkhoff
  averages. It proves no subadditive cocycle limit, Lyapunov exponent, or
  Oseledets splitting.

## Related concepts

- {{< refterm "ergodicity" "Ergodicity" >}} collapses the invariant target
  almost everywhere without claiming that the exact invariant sigma algebra
  is literally bottom.
- {{< refterm "normalized-space-average" "Normalized space average" >}} is
  the finite nonzero constant identified by the RMT-28 specialization.
- {{< refterm "invariant-sigma-algebra" "Invariant sigma algebra" >}} is the
  exact information field used as the RMT-27 conditioning target.
- {{< refterm "uniform-integrability" "Uniform integrability" >}} upgrades
  the almost-everywhere limit to \(L^1\) convergence so set integrals can pass
  to the limit.
- {{< refterm "almost-everywhere" "Almost everywhere" >}} is the equality
  notion under which conditional-expectation versions are unique.
- {{< refterm "birkhoff-sum" "Birkhoff sum" >}} supplies the orbit averages
  identified by the theorem.
- {{< refterm "koopman-operator" "Koopman operator" >}} gives the function
  pullbacks averaged along the dynamics.

## References

<a id="ref-condexp-mathlib"></a>**Mathlib contributors.**
[Conditional expectation definition and uniqueness](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/ConditionalExpectation/Basic.lean#L93-L125),
with the
[set-integral uniqueness theorem](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/ConditionalExpectation/Basic.lean#L250-L261),
Mathlib 4.32.0 at pinned commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).
These sources are the authority for totalization, notation, measurability, and
the exact uniqueness premises consumed by the project.

<a id="ref-condexp-chacon"></a>**R. V. Chacon.**
[Identification of the Limit of Operator Averages](https://iumj.org/article/1425/),
*Journal of Mathematics and Mechanics* 11(6), 961-968, 1962,
[DOI](https://doi.org/10.1512/iumj.1962.11.11054). The paper treats limit
identification as a separate theorem and characterizes the result through an
invariant Borel field and its integrals. The project uses Mathlib's modern
exact-field interface rather than claiming a line-by-line formalization.

<a id="ref-condexp-characterizations"></a>**A. N. Al-Hussaini.**
[On Characterizations of Conditional Expectation](https://doi.org/10.4153/CMB-1973-028-9),
*Canadian Mathematical Bulletin* 16(2), 161-163, 1973. The paper is a primary
source on integral and operator characterizations of conditional expectation.
Its operator setting is broader than the finite-measure Birkhoff proof here.

<a id="ref-condexp-hess"></a>**Christian Hess, Raffaello Seri, and Christine Choirat.**
[Ergodic Theorems for Extended Real-Valued Random Variables](https://doi.org/10.1016/j.spa.2010.05.008),
*Stochastic Processes and their Applications* 120(10), 1908-1919, 2010,
with the authors' [full text](https://rseri.me/publication/j007/J007.pdf).
Theorem 1 states a modern nonergodic, not-necessarily-invertible
probability-space Birkhoff target in terms of conditional expectation. RMT-27
proves a finite-measure real-integrable theorem with no probability premise.

<a id="ref-condexp-project"></a>**Nonlinear Dynamics in Lean contributors.**
[`PointwiseBirkhoffLimit.lean`](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/PointwiseBirkhoffLimit.lean),
the checked source establishing invariant measurability, integrability,
visible-set integral identities, conditional-expectation uniqueness, and the
final almost-everywhere limit.
