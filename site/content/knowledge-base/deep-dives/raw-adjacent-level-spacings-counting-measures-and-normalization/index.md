---
title: "Raw Adjacent Level Spacings, Counting Measures, and Normalization"
slug: "raw-adjacent-level-spacings-counting-measures-and-normalization"
date: 2026-08-17
summary: "Compute a repeated three-level example, then build the exact finite gap vector, counting measure, zero-aware empirical measure, and probability boundary used by the Lean interface."
lead: "A probability measure can have mass one without having mean spacing one. This chapter keeps that distinction visible from the first calculation."
draft: true
pro_reviewed: false
level: "Introductory linear algebra and finite measures"
reading_time: "30 to 40 minutes"
prerequisites: "Finite ordered lists, eigenvalues, and point masses are introduced through the worked example"
lean_module: "NonlinearDynamics.QuantumChaos.SpectralStatistics"
lean_snapshot: "/lean/NonlinearDynamics/QuantumChaos/SpectralStatistics.lean"
lean_source_sha256: "62a54be4b21c8b68c211ce88244a48418b7d33b99fc36c615f786216bd488941"
toc: true
og_image: "raw-adjacent-level-spacings-counting-measures-and-normalization-card.png"
og_image_alt: "Three decreasing levels two, two, and minus one yield adjacent raw gaps zero and three, an atom at each gap, and a mass-normalized empirical measure."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial and validation status.** This is a private AI-assisted source
candidate. The exact source identified by the SHA-256 field has passed the
repository's pinned Lean 4.32.0 checks. Professional review remains pending,
so `pro_reviewed` remains false.
{{< /panel >}}

## Start with all three levels

Suppose a finite {{< refterm "finite-quantum-hamiltonian" "Hamiltonian" >}}
has the decreasingly ordered spectrum

\[
\lambda_0=2,\qquad \lambda_1=2,\qquad \lambda_2=-1.
\]

“Ordered spectrum” means the eigenvalues appear with multiplicity in a fixed
rank order. The first two entries are equal. That equality is spectral
degeneracy, not a reason to delete an entry.

Because the order decreases, subtract each next entry from the current one:

\[
\Delta_0=\lambda_0-\lambda_1=0,
\qquad
\Delta_1=\lambda_1-\lambda_2=3.
\]

The ordered raw gap vector is therefore \((0,3)\). Reversing the subtraction
would produce \((0,-3)\), which conflicts with the intended nonnegative gap
convention.

{{< reference-figure
  wide="true"
  src="three-level-spacing-ledger.svg"
  alt="A vertical energy axis shows two coincident levels at energy two and one level at minus one. Rank-adjacent arrows label gap zero between the repeated levels and gap three to the lower level. The two gaps become Dirac atoms at zero and three with weights one half in the empirical measure."
  caption="**One exact ledger:** adjacency is adjacency in spectral rank. The coincident levels create a zero gap, while the lower level creates a gap of three. Both slots remain in the measure with equal counting weight."
>}}

This calculation checks the chosen example only. A general nonnegativity
theorem needs the antitonicity of the full ordered eigenvalue function, which
the project proves in Lean.

## From two numbers to a measure

A {{< refterm "measure" "measure" >}} assigns nonnegative mass to suitable
sets. The Dirac measure \(\delta_x\) assigns unit mass to any measurable set
containing \(x\) and zero mass otherwise.

Putting one Dirac atom at each available gap gives the counting measure

\[
C_H=\delta_0+\delta_3.
\]

Its total mass is two because the three-level spectrum has two adjacent
slots. The atom at zero must remain. Removing it would change the mass to one
and would replace “all adjacent slots” by “positive adjacent slots.” That is a
different statistic and would silently impose a simplicity filter.

The counting measure preserves multiplicity of gap values, but it no longer
preserves their rank order. The source therefore exposes both the function
`rawLevelSpacing H`, which keeps the index, and
`rawSpacingCountingMeasure H`, which is useful for integration.

## Mass normalization is not unfolding

Divide the counting measure by its number of slots:

\[
L_H^{\mathrm{raw}}
=\frac12 C_H
=\frac12\delta_0+\frac12\delta_3.
\]

Now the total mass is one, so this is a
{{< refterm "probability-measure" "probability measure" >}}. Its mean gap is

\[
\int_{\mathbb R}s\,dL_H^{\mathrm{raw}}(s)
=\frac12(0)+\frac12(3)
=\frac32.
\]

A mass-one measure need not have first moment one. In spectral statistics,
**unfolding** is a further change of variables intended to remove the smooth
variation of average level density. Standard unfolded nearest-neighbor
spacing conventions normalize mean spacing to one. The present interface
does not choose a smooth density, a bulk window, an edge policy, or an
unfolding map.

Dividing every gap by the sample mean would make this particular example's
mean one, but adopting that operation as the project definition would be a
new convention. It is not smuggled into the term “empirical.”

## Why there are no gaps in dimensions zero and one

An adjacent gap needs two spectral ranks. The count of adjacent slots in an
\(n\)-level spectrum is

\[
\operatorname{pred}(n)=\max(n-1,0).
\]

| Dimension | Spectrum length | Gap vector | Counting measure | Empirical raw measure |
|---:|---:|---|---|---|
| 0 | 0 | empty | zero | zero |
| 1 | 1 | empty | zero | zero |
| 2 | 2 | one gap | one Dirac atom | probability |
| 3 | 3 | two gaps | two Dirac atoms | probability |

The candidate does not insert \(\delta_0\) at dimensions zero or one. A zero
gap means two adjacent eigenvalues are equal; it does not mean no adjacent
pair exists.

{{< reference-figure
  wide="true"
  src="zero-one-two-gap-boundary.svg"
  alt="Dimension zero has no levels and no gaps; dimension one has one level and no gaps; dimension two has two levels and one adjacent gap. The first two produce zero measures, while dimension two has a probability measure after normalization."
  caption="**No fabricated boundary atom:** zero and one dimensions contain no adjacent pair, so their counting and empirical raw-spacing measures are zero. A bundled probability measure begins only when the dimension is at least two."
>}}

Schubert and Venker choose an arbitrary probability measure when their gap
denominator vanishes. The project takes a different totalization: preserve
the zero measure in the empty cases and expose `ProbabilityMeasure ℝ` only in
dimensions with an actual slot.

## What changes when the Hamiltonian changes

For fixed rank \(i\), the existing Weyl bound gives

\[
|\lambda_i(A)-\lambda_i(B)|\le\lVert A-B\rVert_F.
\]

Applying the triangle inequality to two adjacent coordinates gives

\[
|\Delta_i(A)-\Delta_i(B)|
\le 2\lVert A-B\rVert_F.
\]

This proves a safe 2-Lipschitz bound, hence continuity and Borel
measurability. The result does not claim differentiability: ordered
eigenvalues can meet at a collision.

The finite sum of measurable Dirac maps gives a measurable counting-measure
map. Scaling by the fixed reciprocal slot count gives a measurable empirical
map. This is measurability for Mathlib's Giry measurable space on measures;
it is not a claim of continuity in an unspecified weak topology.

## Basis change does not alter the statistic

If \(U\) is unitary, then \(UHU^*\) has the same ordered spectrum as \(H\).
Consequently every raw gap, the counting measure, and the empirical measure
are unchanged.

This is deterministic basis invariance of a statistic of one Hamiltonian. It
is different from {{< refterm "unitary-invariance" "unitary invariance" >}}
of a random-matrix law, which concerns the distribution of a random matrix
under conjugation.

## A bounded standalone worksheet

The bundled **standalone tutorial** imports only `Std`. It computes adjacent
integer differences for the list `[2, 2, -1]`, verifies the gap list `[0, 3]`,
checks the zero- and one-level boundaries, and checks the finite numerator and
denominator of the mean-gap calculation.

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/raw-adjacent-level-spacings-counting-measures-and-normalization/three-level-spacing-ledger.lean
```

`by decide` exhausts equality for these stored integer and list values, and
Lean's kernel checks the resulting proof terms against those exact finite
propositions. The worksheet does not compute
Mathlib's noncomputable ordered eigenvalues for a concrete matrix, construct
Giry measures, or prove the general perturbation theorems.

## In Lean

{{< lean-bridge
  human="An n-level Hamiltonian has one raw gap for each member of Fin n.pred."
  math="\(\Delta(H):\operatorname{Fin}(\operatorname{pred} n)\to\mathbb R.\)"
  lean="def rawLevelSpacing {n : ℕ}\n    (H : FiniteHamiltonian n)\n    (i : Fin n.pred) : ℝ"
>}}
`FiniteHamiltonian n` reuses the intrinsic Hermitian carrier. `i` is the
adjacent-slot rank. The implementation constructs two safe `Fin n` indices
with natural-number values `i` and `i + 1`; it does not use modular finite
addition, which could wrap.
{{< /lean-bridge >}}

{{< lean-bridge
  human="The counting measure has exactly one unit atom per adjacent slot."
  math="\(C_H(\mathbb R)=\operatorname{pred}n.\)"
  lean="@[simp] theorem rawSpacingCountingMeasure_univ\n    {n : ℕ} (H : FiniteHamiltonian n) :\n    rawSpacingCountingMeasure H Set.univ = n.pred"
>}}
`Set.univ` is the whole real line in this measure expression. The theorem
counts indices, not distinct gap values, so repeated gaps keep multiplicity.
{{< /lean-bridge >}}

{{< lean-bridge
  human="The all-dimensional empirical measure is zero or a probability measure."
  math="\(L_H^{\mathrm{raw}}=0\) or \(L_H^{\mathrm{raw}}(\mathbb R)=1.\)"
  lean="theorem empiricalRawSpacingMeasure_isZeroOrProbability\n    {n : ℕ} (H : FiniteHamiltonian n) :\n    IsZeroOrProbabilityMeasure\n      (empiricalRawSpacingMeasure H)"
>}}
The disjunction-shaped typeclass matches the total boundary. The stronger
`empiricalRawSpacingMeasure_succ_succ_isProbability` theorem assumes the
dimension is written as `n + 2` and rules out both empty cases.
{{< /lean-bridge >}}

## Try the full project module

~~~lean
import NonlinearDynamics.QuantumChaos.SpectralStatistics

open NonlinearDynamics.QuantumChaos

#check rawLevelSpacing
#check rawLevelSpacing_nonneg
#check rawLevelSpacing_hermitianCongruence
#check continuous_rawLevelSpacings
#check rawSpacingCountingMeasure
#check rawSpacingCountingMeasure_zero
#check rawSpacingCountingMeasure_one
#check rawSpacingCountingMeasure_univ
#check empiricalRawSpacingMeasure
#check empiricalRawSpacingProbability
#check measurable_empiricalRawSpacingProbability
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
Lean's elaborator constructs candidate proof terms and its kernel checks them
against the encoded finite-dimensional claims. The model-audit boundary is
separate: the check does not establish that a particular physical spectrum
belongs to a random ensemble or that its raw gaps diagnose chaos.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/QuantumChaos/SpectralStatistics.lean
```

## Misconceptions and limits

- “Nearest neighbor” means adjacent ordered rank, not a newly minimized
  geometric distance.
- A Hermitian matrix can have repeated eigenvalues. The theorem proves
  nonnegative gaps, not positive gaps.
- Zero gaps are data and are retained. Empty dimensions have no data and
  return the zero measure.
- Normalization by the number of gaps fixes total mass. It does not fix the
  mean gap.
- The empirical measure of one Hamiltonian is not its probability law under
  an ensemble.
- Coordinate continuity does not imply differentiability at level crossings.
- Measurability does not imply integrability or existence of ensemble
  averages.
- No GUE specialization, spacing limit, repulsion exponent, universality
  theorem, or chaos criterion appears in this module.

## References

- Kristina Schubert and Martin Venker, “Empirical Spacings of Unfolded
  Eigenvalues,” *Electronic Journal of Probability* 20 (2015), paper 120,
  [DOI 10.1214/EJP.v20-4436](https://doi.org/10.1214/EJP.v20-4436),
  [arXiv 1505.07664](https://arxiv.org/abs/1505.07664). Equation (1.1) is the
  adjacent-gap counting-measure model used for comparison here.
- Thomas Guhr, Axel Müller-Groeling, and Hans A. Weidenmüller,
  “Random-matrix theories in quantum physics: common concepts,” *Physics
  Reports* 299 (1998), 189–425,
  [DOI 10.1016/S0370-1573(97)00088-4](https://doi.org/10.1016/S0370-1573%2897%2900088-4),
  [arXiv cond-mat/9707301](https://arxiv.org/abs/cond-mat/9707301).
  Section III.B explains unfolding and the unit-mean normalization of the
  unfolded nearest-neighbor spacing density.
- T. Kriecherbauer and K. Schubert, “Spacings: An Example for Universality in
  Random Matrix Theory,” in *Random Matrices and Iterated Random Functions*,
  Springer Proceedings in Mathematics & Statistics 53 (2013), 45–71,
  [DOI 10.1007/978-3-642-38806-4_3](https://doi.org/10.1007/978-3-642-38806-4_3).
- Mathlib contributors,
  [`Analysis.Matrix.Spectrum`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Matrix/Spectrum.lean)
  and
  [`MeasureTheory.Measure.ProbabilityMeasure`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/ProbabilityMeasure.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.

See the [Research Note]({{< relref
"/development-notebook/2026/08/raw-finite-level-spacings-in-lean" >}}) for the
declaration ledger and design record, or the [glossary chapter]({{< relref
"/knowledge-base/glossary/raw-level-spacing" >}}) for a compact definition.
