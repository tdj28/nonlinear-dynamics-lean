---
title: "Finite Gaussian Unitary Ensemble (GUE) from Independent Gaussian Coordinates"
slug: "finite-gue-from-independent-gaussian-coordinates"
date: 2026-07-21
summary: "A textbook ascent from the Wigner variance ledger through independent finite Gaussian blocks and measurable Hermitian assembly to a checked finite Gaussian unitary ensemble matrix law."
lead: "A named matrix ensemble becomes trustworthy only when every scale, marginal, independence claim, transport map, and boundary case is visible."
draft: true
pro_reviewed: false
level: "Finite probability foundations to a matrix ensemble law"
reading_time: "60 to 80 minutes"
prerequisites: "Real and complex Gaussian laws, finite product measures, Hermitian coordinates, and pushforwards; each is reviewed before use"
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsemble"
toc: true
og_image: "finite-gue-coordinate-law-card.png"
og_image_alt: "A normalization ledger feeds a canonical Gaussian product law, exact marginal and independence theorems, Hermitian assembly, and a pushforward finite Gaussian unitary ensemble matrix law."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The mathematical
prose, sources, Lean declaration map, figures, and accessibility have not yet
received the required human and Pro reviews. The page must remain a draft until
those gates are complete.
{{< /panel >}}

A finite Gaussian unitary ensemble (GUE) matrix can be described in one
sentence: choose independent centered Gaussian free coordinates, assemble a
Hermitian matrix, and use the Wigner scale. Formalization makes that sentence
expand into its real mathematical obligations.

Which Gaussian parameter is a variance? Why does a complex upper entry use
\(1/(2n)\) for each real component instead of \(1/n\)? Which variables are
mutually independent, and which lower entries are deterministic conjugates?
What is the joint law rather than merely the list of marginals? Why can the law
be pushed through matrix assembly? What does the definition mean at
\(n=0\)? Finally, which familiar GUE facts follow only in later theorems?

The sixth random-matrix-theory milestone (RMT-06) answers the finite
law-construction questions with 26 checked declarations. It fixes one
normalization, constructs one canonical coordinate
probability measure, proves its exact laws and independence structure, pushes
it through measurable Hermitian assembly, transfers exact diagonal and upper
entry laws, and proves a Dirac boundary in dimension zero.

This chapter does not silently import the rest of random-matrix theory. A
classical density, measure-level Hermitian support, unitary invariance,
eigenvalue density, trace expectation, semicircle law, and universality remain
outside RMT-06. They appear here only as labeled mathematical or physical
context.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [Name the three spaces](#base-camp-name-the-three-spaces) | Distinguish coordinates, assembly, and a matrix law |
| Normalization route | [The Wigner ledger](#camp-one-the-wigner-ledger) | Derive every variance and the factor of two |
| Probability route | [Build the coordinate measure](#camp-three-build-the-coordinate-measure) | See why a product law contains dependence information |
| Independence route | [Three scopes of independence](#camp-four-three-scopes-of-independence) | Separate block, within-block, and cross-coordinate claims |
| Transport route | [Push the law through assembly](#camp-six-push-the-law-through-assembly) | Follow the measurable map into matrix space |
| Lean route | [The checked declaration map](#the-checked-declaration-map) | Audit all 26 public declarations |
| Boundary route | [Dimension zero](#camp-eight-dimension-zero-is-a-dirac-law) | Understand the total zero-size policy |

### Learning objectives

By the summit, you should be able to:

1. state the complete positive-dimensional GUE normalization ledger used here;
2. derive \(\mathbb E|H_{ij}|^2=1/n\) from two component variances;
3. derive the factor of two in
   \(\operatorname{Tr}(H^2)\) from Hermitian reflection;
4. distinguish scalar marginals from a finite joint product law;
5. identify block independence, mutual independence within each block, and
   cross-block coordinate independence as separate theorem shapes;
6. explain why measurable assembly is the bridge from coordinates to a matrix
   law;
7. state the full Cartesian complex law of a diagonal matrix entry, including
   its zero imaginary variance;
8. explain why reflected upper and lower entries are not independent primitive
   coordinates;
9. compute the unique zero-dimensional coordinate and matrix laws; and
10. separate all 26 checked declarations from later density, invariance,
    spectral, moment, and asymptotic work.

## The construction in one picture

{{< reference-figure
  src="gue-law-construction.svg"
  alt="The Wigner normalization feeds a product measure on real diagonal and complex strict-upper coordinates; exact laws and independence precede measurable Hermitian assembly, whose pushforward is the finite GUE matrix law, while density, invariance, spectra, moments, and asymptotics remain on a later ridge."
  caption="**Finding:** the finite matrix law is the endpoint of a dependency chain. Scale comes before product law; product law comes before exact independence interfaces; measurable Hermitian assembly comes before the pushforward law. The solid path is checked in RMT-06, including dimension zero. The dashed later ridge is deliberately not claimed by this module."
>}}

## Base camp: name the three spaces

Fix a natural number \(n\). Three spaces play different roles.

First is the {{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}

\[
\mathcal C_n
=(\operatorname{Fin}(n)\to\mathbb R)
 \times
 (I_n^{\lt}\to\mathbb C),
\]

where \(I_n^{\lt}\) contains index pairs \((i,j)\) with \(i\lt j\). A point
\(c=(d,u)\) stores a real diagonal \(d\) and a complex strict upper triangle
\(u\). It is not yet random.

Second is the ambient matrix space

\[
\mathcal M_n
=\operatorname{Matrix}(\operatorname{Fin}(n),\operatorname{Fin}(n),\mathbb C).
\]

The deterministic assembly map \(A_n:\mathcal C_n\to\mathcal M_n\) is

\[
(A_n(d,u))_{ij}
{} =
\begin{cases}
u_{ij},&i\lt j,\\
d_i,&i=j,\\
\overline{u_{ji}},&j\lt i.
\end{cases}
\]

Every output is {{< refterm "hermitian-matrix" "Hermitian" >}}, and RMT-05
proved this map measurable.

Third is a space of probability measures. A coordinate law
\(\nu_n\) is a measure on \(\mathcal C_n\). A matrix law \(\mu_n\) is a
measure on \(\mathcal M_n\). RMT-06 defines

\[
\mu_n=(A_n)_*\nu_n.
\]

This distinction prevents a common category error. A coordinate point is not
a sample map; an assembly function is not a law; a law is not a realized
matrix. Each layer needs its own definition and proof.

{{< checkpoint stage="Base camp" title="The ensemble is a measure" >}}
The finite GUE constructed here is the matrix probability measure
\(\mu_n\). Coordinates supply its source law, and assembly supplies the
measurable transport. No individual matrix is itself an ensemble.
{{< /checkpoint >}}

## Camp one: the Wigner ledger

The project stores variances in \(\mathbb R_{\ge0}\), Lean's nonnegative real
type. Define the total scale

\[
s_n=
\begin{cases}
0,&n=0,\\
1/n,&n\gt0.
\end{cases}
\]

The zero branch is a definition, not an interpretation of division by zero.
For positive \(n\), the coordinate ledger is

\[
\operatorname{Var}(d_i)=s_n=\frac1n,
\]

and, writing \(u_{ij}=x_{ij}+iy_{ij}\),

\[
\operatorname{Var}(x_{ij})
=\operatorname{Var}(y_{ij})
=\frac{s_n}{2}
=\frac{1}{2n}.
\]

All means are zero. Real and imaginary parts inside one Cartesian complex law
are independent by its product-law definition. The upper complex coordinates
are mutually independent. The diagonal real coordinates are mutually
independent. The two entire blocks are independent.

Lean gives the scale three names:

~~~lean
noncomputable def varianceScale : ℕ → ℝ≥0
  | 0 => 0
  | n + 1 => (((n + 1 : ℕ) : ℝ≥0))⁻¹

noncomputable def diagonalVariance (n : ℕ) : ℝ≥0 :=
  varianceScale n

noncomputable def upperCartesianVariance (n : ℕ) : ℝ≥0 :=
  varianceScale n / 2
~~~

The successor formulas expose the positive-dimensional meaning without a side
condition:

\[
\begin{aligned}
s_{n+1}&=\frac{1}{n+1},\\
d_{n+1}&=\frac{1}{n+1},\\
a_{n+1}&=\frac{1}{2(n+1)}.
\end{aligned}
\]

Here \(d_n\) abbreviates the diagonal variance and \(a_n\) the variance of
each displayed real coordinate of an upper entry. Named zero formulas expose
all three values at \(n=0\).

### The complex second-moment check

For a strict-upper entry \(u_{ij}=x_{ij}+iy_{ij}\),

\[
|u_{ij}|^2=x_{ij}^2+y_{ij}^2.
\]

The components are centered, so for positive \(n\),

\[
\begin{aligned}
\mathbb E|u_{ij}|^2
&=\mathbb E[x_{ij}^2]+\mathbb E[y_{ij}^2]\\
&=\operatorname{Var}(x_{ij})+\operatorname{Var}(y_{ij})\\
&=\frac{1}{2n}+\frac{1}{2n}\\
&=\frac1n.
\end{aligned}
\]

This is why the number \(1/(2n)\) belongs to each **real Cartesian part**.
Saying merely that an upper entry has variance \(1/n\) is ambiguous unless
"variance" is explicitly defined as total complex squared magnitude.

RMT-06 does not prove this expectation identity. It checks both exact
component laws. The expectation calculation is a direct mathematical
consequence once the existing complex-Gaussian integrability and second-moment
interfaces are combined, but that combination has no named theorem here.

## Camp two: the factor-of-two geometry

The Wigner ledger is also the coordinate form of the conventional quadratic
GUE density. The bridge is a geometric identity.

For a Hermitian matrix \(H\),

\[
\operatorname{Tr}(H^2)
=\sum_i(H^2)_{ii}
=\sum_i\sum_j H_{ij}H_{ji}.
\]

Hermiticity gives \(H_{ji}=\overline{H_{ij}}\), hence

\[
H_{ij}H_{ji}=|H_{ij}|^2.
\]

The diagonal terms appear once. Every unordered off-diagonal pair
\(\{i,j\}\) appears twice, once as \((i,j)\) and once as \((j,i)\). Therefore

\[
\operatorname{Tr}(H^2)
=\sum_i H_{ii}^2
 +2\sum_{i\lt j}|H_{ij}|^2.
\]

Writing \(H_{ii}=d_i\) and \(H_{ij}=x_{ij}+iy_{ij}\) above the diagonal gives

\[
\operatorname{Tr}(H^2)
=\sum_i d_i^2
 +2\sum_{i\lt j}(x_{ij}^2+y_{ij}^2).
\]

Now consider, as mathematical context, the density shape

\[
\exp\!\left(-\frac n2\operatorname{Tr}(H^2)\right).
\]

In free coordinates its exponent is

\[
-\sum_i\frac n2d_i^2
-\sum_{i\lt j}n(x_{ij}^2+y_{ij}^2).
\]

A centered real Gaussian with variance \(v\) has exponent
\(-x^2/(2v)\). Comparing coefficients gives \(v=1/n\) on the diagonal and
\(v=1/(2n)\) for each upper real part. The apparently asymmetric ledger is
exactly what the Hermitian trace geometry requires.

This derivation also identifies a formal boundary. To prove a matrix density
in Lean, the project will need a concrete real-linear model of Hermitian
matrices, a reference volume, an equivalence with coordinates, and a
change-of-variables argument. RMT-06 defines no density and proves no Jacobian.
It uses the coordinate product law directly.

## Camp three: build the coordinate measure

Let

\[
\gamma_{0,v}
\]

denote the centered real Gaussian measure with variance \(v\). For the
diagonal block, form the finite indexed product

\[
D_n=\bigotimes_{i\in\operatorname{Fin}(n)}\gamma_{0,d_n}.
\]

For one strict-upper index \(q\), the Cartesian complex law is the image of

\[
\gamma_{0,a_n}\otimes\gamma_{0,a_n}
\]

under \((x,y)\mapsto x+iy\). Form the finite product of these complex laws:

\[
U_n=\bigotimes_{q\in I_n^{\lt}}
\operatorname{CGauss}_{\mathrm{cart}}(0;a_n,a_n).
\]

The coordinate measure is the product of the two blocks:

\[
\nu_n=D_n\otimes U_n.
\]

The Lean definition mirrors this formula:

~~~lean
noncomputable def coordinateMeasure (n : ℕ) :
    Measure (HermitianCoordinateSpace n) :=
  (gaussianProductMeasure
      (fun _ : Fin n => 0)
      (fun _ => diagonalVariance n)).prod
    (cartesianComplexGaussianProductMeasure
      (fun _ : StrictUpperIndex n => 0)
      (fun _ => upperCartesianVariance n)
      (fun _ => upperCartesianVariance n))
~~~

Every scalar factor is a probability measure. A finite product of probability
measures is a probability measure, and a binary product of probability
measures is again one. The instance
<code>instIsProbabilityMeasureCoordinateMeasure</code> records this for every
\(n\), including zero.

The definition has no arbitrary sample enumeration. It is a canonical law on
the function spaces themselves. Coordinate evaluation is the random-variable
map. This makes exact marginals and independence accessible through Mathlib's
finite product-measure application programming interface (API).

## Camp four: three scopes of independence

The word "independent" can describe several families at different levels.
RMT-06 proves each needed scope explicitly.

### Scope one: the two blocks

Under \(\nu_n=D_n\otimes U_n\), the projections

\[
\pi_D(d,u)=d,
\qquad
\pi_U(d,u)=u
\]

have laws \(D_n\) and \(U_n\). The theorems
<code>coordinateMeasure_hasLaw_diagonalBlock</code> and
<code>coordinateMeasure_hasLaw_upperBlock</code> state those exact full-vector
laws. The theorem
<code>coordinateMeasure_indepFun_diagonal_upper</code> states that the two
projection functions are independent.

This is stronger than saying a particular \(d_i\) is independent of one
\(u_q\). It is independence of the sigma-algebras generated by the whole
vectors.

### Scope two: coordinates inside each block

Theorems
<code>coordinateMeasure_diagonal_iIndepFun</code> and
<code>coordinateMeasure_upper_iIndepFun</code> state mutual independence of
the evaluation families

\[
i\longmapsto((d,u)\mapsto d_i)
\]

and

\[
q\longmapsto((d,u)\mapsto u_q).
\]

Mutual independence is the finite-family property needed for arbitrary finite
subcollections, not merely pairwise independence.

### Scope three: one coordinate across blocks

For every diagonal index \(i\) and strict-upper index \(q\), the theorem
<code>coordinateMeasure_diagonal_indepFun_upper</code> proves

\[
((d,u)\mapsto d_i)
\quad\text{is independent of}\quad
((d,u)\mapsto u_q).
\]

This theorem follows by composing block independence with measurable
coordinate evaluations. It is exposed because scalar cross-block independence
is often the exact hypothesis a later calculation needs.

### What independence does not apply to

After assembly, \(H_{ji}=\overline{H_{ij}}\). These two reflected entries are
deterministically related. They are not separate primitive coordinates and
are not claimed independent. Similarly, the real and imaginary components
inside one upper entry are independent because its Cartesian complex law is a
product, but the matrix-level module does not restate that fact as a separate
entry-component theorem.

## Camp five: exact scalar coordinate laws

Full block laws imply exact marginal laws by evaluation.

For every \(i:\operatorname{Fin}(n)\),

\[
d_i\sim\gamma_{0,d_n}.
\]

This is
<code>coordinateMeasure_diagonal_hasLaw</code>, an exact
<code>HasRealGaussianLaw</code> statement. It does not merely say
"qualitatively Gaussian."

For every \(q:I_n^{\lt}\),

\[
u_q\sim
\operatorname{CGauss}_{\mathrm{cart}}(0;a_n,a_n).
\]

This is <code>coordinateMeasure_upper_hasLaw</code>, an exact
<code>HasCartesianComplexGaussianLaw</code> statement. The two equal variance
arguments remain visible. No undifferentiated "complex variance" appears.

For \(n\gt0\), substitution gives

\[
d_i\sim N(0,1/n)
\]

and

\[
\operatorname{Re}u_q,\operatorname{Im}u_q
\sim N(0,1/(2n))
\]

with independent Cartesian parts. At \(n=0\), there is no \(i\) or \(q\) at
which to instantiate these theorems. The total measure still exists and is
handled separately.

{{< checkpoint stage="Camp five" title="Marginals do not replace the joint law" >}}
The scalar theorems make computations convenient. The earlier block product
laws and independence theorems carry the joint information. Keeping both
layers avoids pretending that a list of Gaussian marginals determines a GUE.
{{< /checkpoint >}}

## Camp six: push the law through assembly

RMT-05 proved that the deterministic coordinate map \(A_n\) is measurable.
RMT-06 can therefore define the
{{< refterm "pushforward-measure" "pushforward" >}}

\[
\mu_n=(A_n)_*\nu_n
\]

without an extra measurability hypothesis from the caller.

In Lean:

~~~lean
noncomputable def matrixLaw (n : ℕ) :
    Measure (Matrix (Fin n) (Fin n) ℂ) :=
  RandomMatrix.law
    (RandomMatrix.hermitianCoordinateMap n)
    (RandomMatrix.measurable_hermitianCoordinateMap n)
    (coordinateMeasure n)
~~~

The theorem <code>matrixLaw_eq_map</code> exposes the definitional identity
with <code>Measure.map</code>. The instance
<code>instIsProbabilityMeasureMatrixLaw</code> proves the pushforward retains
total mass one.

Why define the law on the full ambient matrix type rather than a Hermitian
subtype? The existing project law API, measurable matrix entries, congruence
maps, and observables live on that ambient space. Assembly guarantees every
realized output is Hermitian pointwise, but RMT-06 does not yet package the
measure-level support theorem saying the complement of the Hermitian set has
measure zero.

That missing support declaration does not invalidate the construction. It
marks the difference between a sample map whose outputs satisfy a property and
a named theorem about the support of its pushforward law.

The follow-up RMT-07 module now supplies that named support theorem. It also
proves symmetry of the intrinsic standard Gaussian on Hermitian Frobenius
space, while leaving the coordinate-to-intrinsic comparison for RMT-08; see
[Intrinsic Hermitian Gaussian Symmetry and Matrix-Law Support]({{< relref "/knowledge-base/deep-dives/intrinsic-hermitian-gaussian-symmetry-and-matrix-law-support" >}}).

## Camp seven: transfer matrix-entry laws

The diagonal and upper entry maps composed with assembly reduce to coordinate
evaluations. That fact transfers exact laws from \(\nu_n\) to \(\mu_n\).

### The full diagonal entry, not just its real part

A diagonal entry is complex-valued in the ambient matrix type even though
assembly inserts a real coordinate. The strongest honest law statement is

\[
H_{ii}\sim
\operatorname{CGauss}_{\mathrm{cart}}(0;d_n,0).
\]

The real coordinate has variance \(d_n\). The imaginary coordinate has
variance zero, so its law is Dirac at zero. This is exactly
<code>matrixLaw_diagonal_hasLaw</code>.

For positive \(n\), \(d_n=1/n\). The theorem therefore records both
Gaussian diagonal scaling and the real-axis support of each diagonal entry at
the scalar law level. It does not prove a density on the full matrix space.

### A strict-upper entry

For \(i\lt j\),

\[
H_{ij}\sim
\operatorname{CGauss}_{\mathrm{cart}}(0;a_n,a_n),
\]

which is <code>matrixLaw_upper_hasLaw</code>. For positive \(n\), both
component variances are \(1/(2n)\).

The theorem requires a proof \(i\lt j\), exactly matching the branch where
assembly copies the primitive upper coordinate. There is no named lower-entry
law theorem in RMT-06. A later result may derive it by conjugation, but it must
not present the lower slot as a new independent Gaussian input.

### What the transfer does not prove

The two matrix-entry marginal theorems do not by themselves expose the full
matrix joint law. That joint law is already \(\mu_n\), the pushforward of the
coordinate product measure. Nor do the current declarations restate mutual
independence of matrix diagonal and strict-upper entry maps after transport.
Such theorems are mathematically reachable through assembly identities but
are not public RMT-06 claims.

## Camp eight: dimension zero is a Dirac law

At \(n=0\), both <code>Fin 0</code> and
<code>StrictUpperIndex 0</code> are empty. A function from either empty type
has one possible value. Consequently, \(\mathcal C_0\) is a singleton.

Each finite indexed product over an empty type is a Dirac measure on the
unique empty function. Their binary product is a Dirac measure on the unique
coordinate pair:

\[
\nu_0=\delta_{0_{\mathcal C_0}}.
\]

This is <code>coordinateMeasure_zero</code>.

The assembly map sends that unique coordinate to the unique empty matrix.
Mapping a Dirac measure through a measurable function gives a Dirac measure at
the image:

\[
\mu_0=\delta_{0_{\mathcal M_0}}.
\]

This is <code>matrixLaw_zero</code>.

The proof does not evaluate \(1/n\), appeal to a limiting argument, or leave a
partial constructor. The pattern-matched scale and the empty product agree on
one executable boundary policy.

## The checked declaration map

The module
<code>NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsemble</code>,
in namespace <code>NonlinearDynamics.Random.GUE</code>, exports exactly 26
public declarations.

| Declaration | Checked content | Explicit boundary |
|---|---|---|
| <code>varianceScale</code> | Total Wigner variance scale on natural dimensions | Pattern matches zero; no division-by-zero claim |
| <code>diagonalVariance</code> | Names the real diagonal variance | Does not create a law |
| <code>upperCartesianVariance</code> | Names each upper real/imaginary component variance as half the scale | Does not name total complex variance |
| <code>varianceScale_zero</code> | \(s_0=0\) | Not a positive-size reciprocal formula |
| <code>varianceScale_succ</code> | \(s_{n+1}=1/(n+1)\) | No asymptotic statement |
| <code>diagonalVariance_zero</code> | Diagonal scale is zero at size zero | There is no diagonal index at size zero |
| <code>diagonalVariance_succ</code> | Positive-size diagonal variance is \(1/(n+1)\) | No density theorem |
| <code>upperCartesianVariance_zero</code> | Upper component scale is zero at size zero | There is no upper index at size zero |
| <code>upperCartesianVariance_succ</code> | Positive-size component variance is \(1/[2(n+1)]\) | No complex second-moment theorem |
| <code>coordinateMeasure</code> | Product of the real diagonal and Cartesian complex upper product measures | No matrix assembly yet |
| <code>instIsProbabilityMeasureCoordinateMeasure</code> | Coordinate measure has total mass one | No sample algorithm or empirical claim |
| <code>coordinateMeasure_hasLaw_diagonalBlock</code> | First projection has the exact finite real Gaussian product law | Not merely scalar marginals |
| <code>coordinateMeasure_hasLaw_upperBlock</code> | Second projection has the exact finite complex Gaussian product law | No lower-triangle family |
| <code>coordinateMeasure_indepFun_diagonal_upper</code> | Full diagonal and upper projections are independent | Does not assert unitary symmetry |
| <code>coordinateMeasure_diagonal_hasLaw</code> | Every selected diagonal coordinate has exact centered real Gaussian law | No matrix-entry theorem yet |
| <code>coordinateMeasure_upper_hasLaw</code> | Every selected upper coordinate has exact centered Cartesian complex law | Both component variances remain explicit |
| <code>coordinateMeasure_diagonal_iIndepFun</code> | Diagonal evaluations are mutually independent | Stronger scope than pairwise only |
| <code>coordinateMeasure_upper_iIndepFun</code> | Upper evaluations are mutually independent | Reflected lower entries are absent |
| <code>coordinateMeasure_diagonal_indepFun_upper</code> | Any diagonal evaluation is independent of any upper evaluation | No claim about reflected matrix entries |
| <code>matrixLaw</code> | Law on ambient complex matrices obtained through checked assembly | Does not define a density or spectrum |
| <code>matrixLaw_eq_map</code> | Exposes the exact measurable pushforward formula | No invariance under a second map |
| <code>instIsProbabilityMeasureMatrixLaw</code> | Matrix law has total mass one | No support theorem |
| <code>matrixLaw_diagonal_hasLaw</code> | Full complex diagonal entry has real variance \(d_n\) and imaginary variance zero | Not just a real-part marginal |
| <code>matrixLaw_upper_hasLaw</code> | Strict-upper entry has equal component variances \(a_n\) | Requires the strict inequality branch |
| <code>coordinateMeasure_zero</code> | Zero-dimensional coordinate law is Dirac at the unique zero coordinate | No reciprocal reasoning |
| <code>matrixLaw_zero</code> | Zero-dimensional matrix law is Dirac at the empty zero matrix | No positive-dimensional limit |

All 26 declarations compile under Lean 4.32.0 and the pinned Mathlib 4.32.0
dependency with warnings treated as errors. The module contains no
<code>sorry</code> or <code>admit</code>.

### Reproduce the check

From the repository root:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsemble.lean
~~~

This command type-checks the definitions and proofs. It does not sample a
matrix, numerically inspect eigenvalues, or test any unformalized asymptotic
claim.

## Checked construction versus classical context

The classical finite GUE admits several equivalent descriptions. One uses the
independent Gaussian free entries chosen here. Another uses a density on the
real vector space of Hermitian matrices proportional to

\[
\exp\!\left(-\frac n2\operatorname{Tr}(H^2)\right).
\]

Another emphasizes invariance under

\[
H\longmapsto UHU^*
\]

for every deterministic unitary \(U\). Diagonalization then leads to an
eigenvalue density with a squared Vandermonde factor.

These equivalences are mathematics, not definitional shortcuts. The current
Lean layer has the coordinate presentation only.

| Layer | RMT-06 status | Needed later |
|---|---|---|
| Variance ledger | Checked | Nothing hidden |
| Coordinate product probability law | Checked | Optional alternate constructions |
| Coordinate marginals and independence | Checked | Matrix-level restatements as needed |
| Measurable Hermitian assembly pushforward | Checked | Named support theorem |
| Matrix diagonal and upper marginals | Checked | Lower law and integrability as needed |
| Hermitian-space density | Not checked | Real-linear geometry and reference volume |
| Unitary invariance | Not checked | Quadratic-form preservation and map equality |
| Eigenvalue law | Not checked | Measurable eigenvalue infrastructure |
| Trace expectations | Not checked | Integrability and integration |
| Semicircle behavior | Not checked | Empirical spectral measure and asymptotic proof |

The phrase "GUE matrix law" in RMT-06 refers to the explicit standard
coordinate construction. It does not claim that every classical
characterization has already been proved equivalent in Lean.

## Physics window: why the unitary class matters

In finite-dimensional quantum mechanics, a Hamiltonian \(H=H^*\) has real
expectation values and generates unitary evolution
\(e^{-itH}\). Random-matrix models do not replace a microscopic Hamiltonian;
they model statistical spectral features after detailed system-specific
structure is suppressed.

Dyson organized three symmetry classes associated with real, complex, and
quaternionic structures. The unitary class is the complex Hermitian class
appropriate when the relevant time-reversal constraint is absent. In the
classical GUE, conjugating by a deterministic unitary changes the basis but not
the law. This makes the ensemble a natural basis-neutral reference model for
that class.

RMT-06 proves the complex Hermitian coordinate law but not its basis
invariance. It also does not formalize Hamiltonians, time-reversal operators,
matrix exponentials, energy levels, level spacing, spectral form factors, or
quantum chaos. The physical story motivates the later theorem sequence; it
does not supply proofs by naming the ensemble.

The Wigner \(1/n\) variance scale keeps typical eigenvalues order one as
dimension grows. Classical results then place the limiting spectral mass on
\([-2,2]\) under the chosen convention. That statement is not a consequence
of the finite probability instance alone. It requires a measurable empirical
spectral measure and a large-\(n\) convergence proof, both beyond this module.

## Common wrong turns

### Calling Hermiticity a distribution

Hermiticity constrains entries pointwise. It does not choose Gaussian laws,
variance, independence, or any measure. RMT-05 supplies assembly; RMT-06
supplies the source probability law.

### Giving each upper component variance \(1/n\)

That choice would give \(\mathbb E|H_{ij}|^2=2/n\). The selected convention
uses \(1/(2n)\) for each component so their sum is \(1/n\).

### Treating upper and lower entries as independent

They obey \(H_{ji}=\overline{H_{ij}}\). Only the strict upper triangle is a
primitive complex family.

### Listing Gaussian marginals without a joint law

Dependent variables can have the same Gaussian marginals as independent ones.
The coordinate product measure and independence theorems carry indispensable
joint information.

### Reading `HasLaw` as a generated sample

A law is a pushforward identity between measures. It does not run a random
number generator or record an observed realization.

### Calling the matrix law unitarily invariant by its name

The classical GUE has this symmetry. RMT-06 has not proved the measure equality
under unitary conjugation. The theorem must be built, not inferred from a
namespace.

### Deriving a density without choosing reference volume

A density is relative to a measure. Hermitian-space coordinates, real-linear
geometry, and the factor-of-two quadratic form must be formalized before the
entrywise product law can be converted into the invariant density.

### Letting \(n=0\) fall through a reciprocal

The definition pattern matches zero, and the empty product laws are Dirac.
This is a total boundary policy, not a limiting slogan.

### Claiming an order-one spectrum from the probability instance

Total mass one says nothing about eigenvalue scale. The spectral statement
requires estimates or asymptotic theorems not present here.

## Exercises

1. **Ledger.** For \(n=4\), list the variance of every diagonal coordinate and
   every real Cartesian upper coordinate.
2. **Energy.** Compute \(\mathbb E|H_{12}|^2\) from the two component
   variances when \(n=4\).
3. **Geometry.** Expand \(\operatorname{Tr}(H^2)\) for a \(2\times2\)
   Hermitian matrix and locate the off-diagonal factor of two.
4. **Density context.** Match the coefficient of \(x^2\) in
   \(e^{-nx^2}\) with a centered real Gaussian variance.
5. **Scopes.** Give an example showing why scalar marginals do not imply
   independence.
6. **Transport.** Mathlib's <code>Measure.map</code> is total even for a
   nonmeasurable function. State the measurability hypothesis needed to use
   \((A_n)_*\nu_n\) as the intended pushforward and apply map evaluation or
   composition theorems.
7. **Diagonal law.** Explain why the exact complex law of \(H_{ii}\) has
   imaginary variance zero rather than omitting the imaginary coordinate.
8. **Reflection.** Explain why no independent lower-coordinate block belongs
   in \(\nu_n\).
9. **Boundary.** Prove on paper that the function space
   \(\operatorname{Fin}(0)\to\mathbb R\) has one element.
10. **Lean.** Find which declaration exposes the matrix law as a
    <code>Measure.map</code>.
11. **Nonclaim.** Write the unitary-invariance measure equality that remains to
    be proved.
12. **Roadmap.** List the new definitions needed before a semicircle theorem
    can even be stated precisely.

## Summit register

RMT-06 fixes a Wigner-scale ledger with an explicit zero branch. It builds the
canonical product law on real diagonal and complex strict-upper coordinates,
proves that law is probabilistic, exposes full block laws, exact scalar laws,
mutual independence within both blocks, and independence across blocks. It
then pushes the law through the checked measurable Hermitian assembly map,
proves the resulting matrix law is probabilistic, transfers exact diagonal and
strict-upper entry laws, and identifies both zero-dimensional laws as Dirac.

The result is the first checked finite named matrix ensemble in the project. It
is also a deliberately bounded result. No density, matrix-level support,
unitary invariance, eigenvalue law, expectation, trace moment, empirical
spectral measure, semicircle limit, or universality theorem has been added.

This boundary leaves a clean next climb. Real-linear Hermitian geometry can
connect the coordinate product density to
\(\operatorname{Tr}(H^2)\), prove support, and establish invariance under
unitary conjugation. Only after measurable spectral data and integrability are
available should trace expectations and spectral asymptotics begin.

## Where to continue

Use the
{{< refterm "gaussian-unitary-ensemble" "Gaussian unitary ensemble" >}}
glossary entry for the compact definition and normalization ledger.
[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}})
derives the deterministic assembly map.

[Finite Product Probability Spaces and Independent Gaussian Fields]({{< relref "/knowledge-base/deep-dives/finite-product-probability-spaces-and-independent-gaussian-fields" >}})
explains the finite product and independence APIs, while
[Complex Gaussian Coordinates and Geometry]({{< relref "/knowledge-base/deep-dives/complex-gaussian-coordinates-and-geometry" >}})
develops the exact two-variance complex law. Read
{{< refterm "normalization-convention" "normalization convention" >}},
{{< refterm "pushforward-measure" "pushforward measure" >}}, and
{{< refterm "unitary-invariance" "unitary invariance" >}} for the three
boundaries this construction makes most visible.

## References

**Alice Guionnet.**
[Rare Events in Random Matrix Theory](https://ems.press/content/book-chapter-files/33150),
in *Proceedings of the International Congress of Mathematicians 2022*, volume
2, European Mathematical Society Press, 2022,
[doi:10.4171/ICM2022/174](https://doi.org/10.4171/ICM2022/174),
pp. 1008-1052. Section 1.1.1
states the GUE diagonal variance \(1/n\), upper real and imaginary variances
\(1/(2n)\), and the Gaussian-ensemble density
\(\exp[-\beta n\operatorname{Tr}(H^2)/4]\). For \(\beta=2\), this is the
density context used in the factor-of-two derivation. Density and invariance
remain unformalized here.

**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems. I](https://doi.org/10.1063/1.1703773),
*Journal of Mathematical Physics* 3 (1962), 140-156. This primary paper
develops the symmetry-class framework and its quantum-spectral motivation.

**Terence Tao and Van Vu.**
[Random Matrices: Sharp Concentration of Eigenvalues](https://arxiv.org/abs/1201.4789),
arXiv:1201.4789, 2012. The normalization \(W_n=M_n/\sqrt n\) and the
order-one spectral window provide context for the scale selected here. No
spectral statement from that paper is claimed as checked by RMT-06.

**Mathlib contributors.**
[Gaussian distributions over the reals](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
[indexed product measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Constructions/Pi.html),
[independence](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Independence/Basic.html),
and
[measure maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
Mathlib 4 documentation. These official API references underlie the exact
Gaussian, finite product, independence, and pushforward proofs.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
