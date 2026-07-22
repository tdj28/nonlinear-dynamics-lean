---
title: "Gaussian unitary ensemble"
slug: "gaussian-unitary-ensemble"
summary: "The Gaussian unitary ensemble is a probability law on finite complex Hermitian matrices obtained from centered independent Gaussian free coordinates with an explicit dimension-dependent scale."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsemble"
og_image: "gaussian-unitary-ensemble-card.png"
og_image_alt: "A real Gaussian diagonal block and complex Gaussian strict-upper block enter a product law, followed by measurable Hermitian assembly and a pushforward matrix law."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

The **Gaussian unitary ensemble (GUE)** is a probability law on finite complex
{{< refterm "hermitian-matrix" "Hermitian matrices" >}}. The word *Gaussian*
describes its free scalar coordinates. The word *unitary* names the symmetry
class: in the classical mathematical theory, the law is invariant under
deterministic unitary conjugation. The word *ensemble* means a probability law
over matrices, not one distinguished matrix.

This project constructs the finite GUE law from independent Gaussian
coordinates under one explicit Wigner-scale convention. For positive size
\(n\):

- each real diagonal coordinate is centered Gaussian with variance \(1/n\);
- each real and imaginary part of a strict-upper coordinate is centered
  Gaussian with variance \(1/(2n)\);
- all diagonal coordinates are mutually independent;
- all strict-upper complex coordinates are mutually independent;
- the diagonal block is independent of the strict-upper block; and
- lower entries are conjugate reflections, not additional independent inputs.

The checked Lean module in the sixth random-matrix-theory milestone (RMT-06)
proves this coordinate law, its exact marginal and
independence architecture, the measurable pushforward matrix law, and the
zero-dimensional Dirac boundary. That module by itself does **not** prove the
classical unitary-invariance theorem. At the RMT-06 milestone, "GUE"
identified the explicit standard coordinate presentation that had been
encoded, while the symmetry named by the acronym remained a separate formal
obligation.

RMT-07 proves that this matrix law assigns the measurable Hermitian locus mass
one. It also proves unitary-congruence invariance of the intrinsic standard
Gaussian on Hermitian Frobenius space. RMT-08 identifies the coordinate-built
law with the correctly scaled intrinsic Gaussian and transports that symmetry
to prove unitary invariance of <code>GUE.matrixLaw</code>. See
[From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance]({{< relref "/knowledge-base/deep-dives/normalized-hermitian-coordinates-to-gue-invariance" >}})
for the exact measure bridge.

## The normalization ledger

The following table is the complete scale specification used by the project.
The {{< refterm "normalization-convention" "normalization convention" >}}
cannot be recovered safely from the acronym alone.

| Ledger field | Project convention |
|---|---|
| Matrix size | \(n\in\mathbb N\) |
| Positive-size variance scale | \(s_n=1/n\) when \(n\gt0\) |
| Zero-size variance scale | \(s_0=0\), defined as its own branch |
| Diagonal entry | centered real Gaussian, variance \(s_n\) |
| Strict-upper entry | \(X_{ij}+iY_{ij}\) |
| Upper real-part variance | \(s_n/2\) |
| Upper imaginary-part variance | \(s_n/2\) |
| Primitive dependence | mutual independence within each block and independence between blocks |
| Lower triangle | \(H_{ji}=\overline{H_{ij}}\) when \(i\lt j\) |
| Matrix law | pushforward of the coordinate product measure |
| Matrix trace in density context | unnormalized \(\operatorname{Tr}\) |
| Spectral scale in classical context | order one as \(n\) grows |

{{< reference-figure
  src="gue-coordinate-ledger.svg"
  alt="The Wigner ledger assigns variance one over n to real diagonal coordinates and variance one over two n to each real component of a complex strict-upper coordinate, then forms a product measure and pushes it through Hermitian assembly."
  caption="**Finding:** a finite GUE law is not supplied by Hermiticity alone. The construction first fixes every primitive variance and independence relation, forms one coordinate probability measure, and only then applies measurable Hermitian assembly. The zero-dimensional branch ends at a Dirac mass on the empty matrix. The plate states the checked construction; it does not claim a density, unitary invariance, or spectral theorem."
>}}

## Why the upper components use \(1/(2n)\)

Write a strict-upper entry as \(H_{ij}=X_{ij}+iY_{ij}\). Under the project
ledger,

\[
\operatorname{Var}(X_{ij})
=\operatorname{Var}(Y_{ij})
=\frac{1}{2n}.
\]

The centered components are independent, so the complex squared magnitude has
mean

\[
\mathbb E|H_{ij}|^2
=\mathbb E[X_{ij}^2+Y_{ij}^2]
=\frac{1}{2n}+\frac{1}{2n}
=\frac{1}{n}.
\]

Thus the total off-diagonal energy is on the same \(1/n\) scale as a diagonal
variance even though it is split across two displayed real coordinates. Calling
each component variance \(1/n\) would double \(\mathbb E|H_{ij}|^2\).

The same factor of two appears in Hermitian geometry. For
\(H=H^*\), write \(H_{ii}=d_i\in\mathbb R\) and
\(H_{ij}=x_{ij}+iy_{ij}\) when \(i\lt j\). Then

\[
\operatorname{Tr}(H^2)
=\sum_i d_i^2
 +2\sum_{i\lt j}(x_{ij}^2+y_{ij}^2).
\]

Mathematically, substituting this identity into the classical density
\(\exp[-n\operatorname{Tr}(H^2)/2]\) gives exponent
\(-nd_i^2/2\) for each diagonal coordinate and
\(-n(x_{ij}^2+y_{ij}^2)\) for each upper coordinate. Those exponents correspond
to variances \(1/n\) and \(1/(2n)\), respectively. The identity explains why
the entrywise ledger and the conventional density agree. The current Lean
module formalizes neither this trace-square identity as GUE geometry nor the
density comparison.

## The canonical coordinate law

The free data live in the
{{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}

\[
\mathcal C_n
=(\operatorname{Fin}(n)\to\mathbb R)
 \times
 (I_n^{\lt}\to\mathbb C),
\]

where \(I_n^{\lt}\) is the finite set of strict-upper positions. The first
factor receives a finite product of centered real Gaussian laws. The second
receives a finite product of centered Cartesian complex Gaussian laws. The
measure <code>GUE.coordinateMeasure n</code> is the product of those two block
measures.

This one definition contains more information than a list of scalar
marginals. The module proves:

1. the whole diagonal projection has its finite Gaussian product law;
2. the whole upper projection has its finite complex Gaussian product law;
3. the two projected blocks are independent;
4. each diagonal coordinate has its exact real Gaussian law;
5. each upper coordinate has its exact Cartesian complex Gaussian law;
6. the diagonal coordinate family is mutually independent;
7. the upper coordinate family is mutually independent; and
8. any selected diagonal coordinate is independent of any selected upper
   coordinate.

These are related but distinct statements. Exact marginal laws alone would
not determine the joint law. Block independence alone would not prove mutual
independence within either block. The checked product construction supplies
all three scopes.

## From coordinates to a matrix law

Let

\[
A_n:\mathcal C_n\longrightarrow
\operatorname{Matrix}(\operatorname{Fin}(n),\operatorname{Fin}(n),\mathbb C)
\]

be the deterministic three-branch assembly map. It inserts real diagonal
coordinates, copies complex strict-upper coordinates, and conjugates them into
the reflected lower triangle. The previous module proves \(A_n\) measurable
and every output Hermitian.

The project matrix law is the
{{< refterm "pushforward-measure" "pushforward measure" >}}

\[
\mu_n=(A_n)_*\nu_n,
\]

where \(\nu_n\) is <code>GUE.coordinateMeasure n</code>. In Lean this is
<code>GUE.matrixLaw n</code>. The module proves that \(\mu_n\) is a
{{< refterm "probability-law" "probability measure" >}} and transfers exact
entry laws through assembly:

- a diagonal matrix entry has Cartesian complex Gaussian law with real
  variance \(1/n\) and imaginary variance zero; and
- a strict-upper matrix entry has Cartesian complex Gaussian law with equal
  real and imaginary variances \(1/(2n)\).

The lower entry is already the conjugate of the corresponding upper entry by
deterministic assembly. It is not a further primitive variable, and the module
does not falsely assert independence between reflected matrix entries.

## Dimension zero

When \(n=0\), both coordinate index types are empty. Each function space has
one element, so the coordinate product has one point. The target matrix type
also has one element, the empty zero matrix.

The project does not interpret \(1/0\). It defines
<code>varianceScale 0 = 0</code> by pattern matching and proves

\[
\nu_0=\delta_0,
\qquad
\mu_0=\delta_0.
\]

The two zeros inhabit different spaces: the first is the unique empty
coordinate pair; the second is the unique empty matrix. This explicit boundary
lets every public law be total in \(n\).

## Physics and random-matrix context

Random-matrix theory began in part as a statistical approach to complicated
quantum energy levels. A finite quantum Hamiltonian is represented by a
Hermitian matrix so that energies are real and Schrödinger evolution is
unitary. Dyson's symmetry classification associates the unitary class with
systems in which the relevant antiunitary time-reversal symmetry is absent.

GUE is an idealized probability model for that class, not a claim that every
physical Hamiltonian has independently Gaussian matrix elements in every
basis. In applications, the ensemble is used as a reference model for spectral
statistics after appropriate unfolding and scaling. The RMT-06 Lean module
formalizes none of that physical interpretation, no Hamiltonian dynamics, and
no spectral statistic. It establishes the finite probability law that later
formal work may analyze.

The \(1/n\) Wigner scale is chosen so that the classical large-\(n\) spectrum
is order one rather than order \(\sqrt n\). In the established theory, the
empirical spectrum converges to the semicircle distribution on \([-2,2]\)
under this convention. This is contextual motivation from the cited
literature, not a checked theorem in this repository.

## What has and has not been checked

The module
<code>NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsemble</code>
checks 26 public declarations. Together they define three scale functions,
prove six boundary formulas, construct the coordinate measure, prove its
probability status and eight law/independence interfaces, construct the matrix
law, expose its exact pushforward identity, prove its probability status and
two exact matrix-entry laws, and prove both zero-dimensional Dirac identities.

That RMT-06 module by itself does not prove:

- a density with respect to a chosen Lebesgue measure on Hermitian space;
- measure-level support on the Hermitian subset;
- {{< refterm "unitary-invariance" "unitary invariance" >}};
- an equivalence between coordinate and invariant definitions of GUE;
- measurable eigenvalues or an eigenvalue joint density;
- integrability, expectations, or exact trace moments;
- an unconditional empirical spectral law or the semicircle law; or
- any large-dimension universality statement.

Those were explicit module boundaries, not qualifications hidden in
implementation detail. Follow-up modules have since discharged three of them:
RMT-07 proves that the ambient law gives the measurable Hermitian locus mass
one and proves intrinsic standard-Gaussian symmetry; RMT-08 proves the exact
coordinate-to-intrinsic Gaussian comparison and unitary invariance of
<code>GUE.matrixLaw</code>. RMT-09 proves Bochner integrability and evaluates
the first two ordinary-trace moments exactly. RMT-10A defines ordered finite
Hermitian spectra and zero-aware empirical spectral measures, then states the
intrinsic/ambient GUE pushforward comparison under an explicit coordinatewise
eigenvalue-measurability hypothesis. RMT-10B proves that measurability and the
unconditional pushforward comparison. RMT-10C constructs the
{{< refterm "empirical-spectral-law" "empirical spectral law" >}}, its Giry
mean, and its first two normalized expected sample moments. Density and
Jacobian formulas, higher trace moments, moment interchange for the Giry mean,
and all large-dimension claims remain unchecked.

## Where to continue

[First Exact Finite Gaussian Unitary Ensemble Trace Moments]({{< relref "/knowledge-base/deep-dives/first-exact-finite-gue-trace-moments" >}})
uses the normalized real product law to prove the first two integrable complex
trace expectations, including dimension zero.

[Finite Hermitian Spectra and Empirical Measures]({{< relref "/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures" >}})
continues from trace moments to ordered finite spectra, counting measures, the
explicit empty-spectrum policy, and the conditional measure-valued GUE bridge.

[Finite Gaussian Unitary Ensemble Empirical Spectral Laws and Normalized Moments]({{< relref "/knowledge-base/deep-dives/finite-gue-empirical-spectral-laws-and-normalized-moments" >}})
continues through measurable pushforward to the unconditional finite law, its
probability packaging and Giry mean, and the first two normalized expected
sample moments.

[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}})
derives the factor-of-two geometry, builds the product probability space in
dependency order, and maps every checked declaration to its precise claim.
[Intrinsic Hermitian Gaussian Symmetry and Matrix-Law Support]({{< relref "/knowledge-base/deep-dives/intrinsic-hermitian-gaussian-symmetry-and-matrix-law-support" >}})
continues with the Frobenius geometry, support theorem, and intrinsic Gaussian
symmetry while keeping the RMT-08 comparison explicit.
[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}})
develops the deterministic assembly map that receives this coordinate law.

Read
[Finite Product Probability Spaces and Independent Gaussian Fields]({{< relref "/knowledge-base/deep-dives/finite-product-probability-spaces-and-independent-gaussian-fields" >}})
for the finite product machinery and
[Complex Gaussian Coordinates and Geometry]({{< relref "/knowledge-base/deep-dives/complex-gaussian-coordinates-and-geometry" >}})
for the two-variance complex law. The
{{< refterm "unitary-invariance" "unitary invariance" >}} entry explains the
law-level symmetry now checked in RMT-08 and the commuting pushforward route
that proves it.

## References

**Alice Guionnet.**
[Rare Events in Random Matrix Theory](https://ems.press/content/book-chapter-files/33150),
in *Proceedings of the International Congress of Mathematicians 2022*, volume
2, European Mathematical Society Press, 2022,
[doi:10.4171/ICM2022/174](https://doi.org/10.4171/ICM2022/174),
pp. 1008-1052. Section 1.1.1
states the GUE entry variances \(1/n\) and \(1/(2n)\), the Gaussian-ensemble
density convention, and unitary invariance. This project uses the entry
normalization and now formalizes the finite-law invariance statement; it has
not formalized the density statement.

**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems. I](https://doi.org/10.1063/1.1703773),
*Journal of Mathematical Physics* 3 (1962), 140-156. This primary source
develops the orthogonal, unitary, and symplectic symmetry classes and their
physical motivation.

**Terence Tao and Van Vu.**
[Random Matrices: Sharp Concentration of Eigenvalues](https://arxiv.org/abs/1201.4789),
arXiv:1201.4789, 2012. The paper uses the \(1/\sqrt n\) Wigner scaling and
records the resulting order-one spectral window. It is cited for normalization
context only, not as evidence for a checked spectral theorem here.

**Mathlib contributors.**
[Gaussian distributions over the reals](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html)
and
[indexed product measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Constructions/Pi.html),
Mathlib 4 documentation. These official API references specify that
<code>gaussianReal</code> takes a variance parameter, make zero variance a
Dirac law, and define the finite product measures used by the checked
construction.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
