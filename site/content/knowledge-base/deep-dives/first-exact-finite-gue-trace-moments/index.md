---
title: "First Exact Finite Gaussian Unitary Ensemble Trace Moments"
slug: "first-exact-finite-gue-trace-moments"
date: 2026-07-21
summary: "A textbook derivation of Bochner integrability and the first two exact ordinary-trace moments of the finite Wigner-scaled Gaussian unitary ensemble, including dimension zero."
lead: "Before moments can predict a spectrum, they must first exist. This chapter proves that analytic gate and evaluates the first two finite Gaussian unitary ensemble trace powers without eigenvalues, densities, or asymptotics."
draft: true
pro_reviewed: false
level: "Finite matrix probability through exact integrable observables"
reading_time: "75 to 95 minutes"
prerequisites: "Finite matrix trace, measurable pushforwards, scalar Gaussian mean and variance, Hermitian Frobenius geometry, and normalized Hermitian coordinates; each is reviewed before use"
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleMoments"
toc: true
og_image: "first-exact-finite-gue-trace-moments-card.png"
og_image_alt: "The finite Gaussian unitary ensemble matrix law splits into a centered diagonal route for the first expected trace and a normalized-coordinate Frobenius route for the second; each route passes an explicit integrability gate and includes dimension zero."
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
prose, sources, Lean declaration map, figure, and accessibility have not yet
received the required human and Pro reviews. The page must remain a draft until
those gates are complete.
{{< /panel >}}

The finite **Gaussian unitary ensemble (GUE)** law is now fully constructed in
the repository. Its free entries have exact Gaussian laws, its normalization
is explicit, its matrix realizations are Hermitian almost everywhere, and its
ambient law is invariant under deterministic unitary changes of basis. None of
those facts alone gives a trace expectation. An observable must be measurable,
then integrable, before its integral has the intended finite probabilistic
meaning.

The ninth random-matrix-theory milestone (RMT-09) crosses that analytic
boundary. The Bochner integral is the norm-controlled integral for functions
valued in a complete normed vector space; the complex numbers are such a
space. For every natural matrix dimension \(n\), including \(n=0\), RMT-09
proves that the first two
{{< refterm "trace-power" "trace-power observables" >}} are complex Bochner
integrable under the Wigner-scaled GUE matrix law and evaluates their integrals
exactly:

\[
\mathbb E[\operatorname{Tr}(H)]=0,
\qquad
\mathbb E[\operatorname{Tr}(H^2)]=n.
\]

Here \(H\) denotes a matrix distributed according to the project's finite GUE
law, \(\operatorname{Tr}\) is the ordinary unnormalized matrix trace, and
\(\mathbb E\) denotes integration under that probability law. The theorem
statements live in ℂ because the ambient matrices and trace observable are
complex-valued.

Here *Wigner scaled* means that each orthonormal real Hermitian coordinate has
variance \(1/n\) in positive dimension. The squared Frobenius norm is the sum
of the squared magnitudes of all matrix entries. Those two definitions explain
why the second expected ordinary trace grows exactly like the dimension.

The checked module exposes exactly four public declarations: two integrability
theorems and the two integral identities they license. Its proof uses centered
diagonal marginals for the first power and normalized real Hermitian coordinates
for the second. It does not define eigenvalues, invoke a density, or pass to a
large-dimension limit.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [Two proofs in one picture](#two-proofs-in-one-picture) | See why the powers use different structures |
| Analysis route | [Why integrability is not bookkeeping](#base-camp-one-why-integrability-is-not-bookkeeping) | Understand the Bochner gate |
| Linear route | [The first trace reads the diagonal](#camp-one-the-first-trace-reads-the-diagonal) | Derive the centered first moment |
| Geometry route | [Hermitian trace square is Frobenius energy](#camp-two-hermitian-trace-square-is-frobenius-energy) | Convert the second trace power into a norm square |
| Probability route | [Move the law to normalized real coordinates](#camp-three-move-the-law-to-normalized-real-coordinates) | Reduce the second moment to scalar Gaussian squares |
| Arithmetic route | [Count the coordinates and close the normalization](#camp-five-count-the-coordinates-and-close-the-normalization) | Explain the exact dimension factor and zero branch |
| Lean route | [The four checked declarations](#the-four-checked-declarations) | Audit the final public API and proof architecture |
| Boundary route | [What has and has not been proved](#what-has-and-has-not-been-proved) | Separate finite identities from spectral context |

### Learning objectives

By the summit, you should be able to:

1. distinguish a trace-power observable from its expected trace moment;
2. state Bochner integrability for a complex-valued function;
3. explain why Mathlib's total integral makes a separate integrability theorem
   mathematically important;
4. move an integral and an integrability claim through a measurable
   pushforward without conflating the two;
5. derive the first expected trace from centered diagonal Gaussian marginals;
6. prove pointwise that the trace square of a Hermitian matrix is its
   Frobenius norm square;
7. translate that norm square into a sum of normalized real coordinate
   squares;
8. use a scalar centered Gaussian second moment to integrate the finite sum;
9. explain why linearity, not independence, closes the second calculation;
10. count the normalized coordinates using the finite index equivalence with
    all matrix positions;
11. reconcile the positive-dimensional division by \(n\) with the separate
    zero-dimensional branch;
12. audit the Wigner normalization from displayed entry variances through the
    final trace identity;
13. state all four Lean theorems with their exact codomains and measures; and
14. separate the checked finite identities from density, eigenvalue, and
    asymptotic statements.

## Two proofs in one picture

{{< reference-figure
  src="two-trace-moment-routes.svg"
  alt="The finite Gaussian unitary ensemble matrix law feeds two routes. The first writes trace as a finite sum of centered diagonal Gaussian coordinates. The second represents the matrix law as a pushforward from normalized real coordinates, moves the integral to those coordinates, rewrites Hermitian trace square as Frobenius norm square, and sums scalar Gaussian second moments over one coordinate per matrix position. Each route proves integrability before evaluating its complex integral, and both include the empty zero-size case."
  caption="**Finding:** the first two expected trace powers are not two instances of one opaque automation step. The first is linear and sees only centered diagonal marginals. The second is geometric and uses the exact normalized-coordinate pushforward together with the Hermitian trace-square identity. Both routes carry a separate integrability proof, and neither needs eigenvalues or a density."
>}}

The left route exploits how little the first power contains. Trace is already a
finite diagonal sum, so exact centered marginal laws solve the probability
problem.

The right route exploits how much the second power contains. Direct entrywise
expansion would produce diagonal squares and paired off-diagonal terms. The
Hermitian and Frobenius geometry developed in RMT-07 and the normalized
coordinate isometry from RMT-08 compress that expansion into a sum of ordinary
real squares.

Both routes end in a complex Bochner integral. The codomain does not change
merely because the values happen to be real on Hermitian matrices.

{{< checkpoint stage="Orientation" title="Finite expectation before spectral interpretation" >}}
The checked RMT-09 result is an exact identity for one finite probability
measure at each dimension. Successor RMT-10C now transports it to the first two
moments of a formalized sample empirical spectral measure. Neither milestone
asserts convergence as the dimension grows.
{{< /checkpoint >}}

## Base camp zero: fix every object and convention

For \(n\in\mathbb N\), let

\[
\mu_n=\operatorname{GUE.matrixLaw}(n)
\]

be the repository's probability measure on
\(\operatorname{Matrix}(\operatorname{Fin}(n),\operatorname{Fin}(n),\mathbb C)\).
The phrase *ambient matrix law* means that the measure lives on all complex
matrices of that size, even though RMT-07 proved that it gives full mass to the
Hermitian subset.

For a nonnegative integer \(k\), define the pointwise observable

\[
T_k(H)=\operatorname{Tr}(H^k).
\]

RMT-01 already proved that \(T_k\) is measurable. RMT-09 specializes to \(k=1\)
and \(k=2\), proves each \(T_k\) integrable under \(\mu_n\), then evaluates

\[
\int T_k(H)\,\mathrm d\mu_n(H).
\]

Three conventions are fixed:

- the trace is ordinary, not divided by dimension;
- the GUE law is Wigner scaled, with positive-dimensional variance scale
  \(s_n=1/n\); and
- the zero-dimensional variance scale is explicitly \(s_0=0\).

The project's {{< refterm "normalization-convention" "normalization ledger" >}}
is therefore part of the theorem, not background typography.

## Base camp one: why integrability is not bookkeeping

### The complex Bochner integral

The Bochner integral extends integration from real-valued functions to
functions with values in a Banach space, a complete normed vector space. The
complex numbers form such a space. For a function \(f:X\to\mathbb C\) on a
measure space \((X,\mu)\), integrability combines two conditions
([Mathlib contributors](#ref-mathlib-bochner)):

1. \(f\) is strongly measurable after changing it on a null set if necessary;
2. its norm has finite integral,

\[
\int_X \lVert f(x)\rVert\,\mathrm d\mu(x)\lt\infty.
\]

For finite-dimensional complex targets, familiar measurable functions satisfy
the strong-measurability side under the standard Borel structures. The norm
bound remains a genuine analytic obligation.

Mathlib represents the property as

~~~lean
MeasureTheory.Integrable f μ
~~~

and the Bochner integral as

~~~lean
∫ x, f x ∂μ
~~~

The integral is totalized: if the function is not integrable, its definition
returns zero ([Mathlib contributors](#ref-mathlib-bochner)). This design makes
the operation available without partial terms, but it sharpens our proof
discipline. The equation

\[
\int f\,\mathrm d\mu=0
\]

does not alone tell a reader whether \(f\) has mean zero or whether the
totalized nonintegrable branch was reached. RMT-09 publishes the integrability
theorem first in each pair.

### Measurability is necessary but weaker

Measurability lets us form a pushforward distribution and discuss the
integral. It does not control tail size. A real function can be measurable and
have infinite first absolute moment. Therefore RMT-01's measurable
<code>tracePower</code> API could not honestly be described as a moment API.

The boundary is now explicit:

| Layer | Question | RMT status |
|---|---|---|
| Pointwise algebra | What is \(\operatorname{Tr}(H^k)\)? | Defined for every finite matrix |
| Measurability | Is the observable measurable? | Checked for every finite power |
| Integrability | Is its norm integrable under this law? | Now checked for powers one and two of finite GUE |
| Expectation | What is its complex integral under the probability law? | Now evaluated exactly for powers one and two |
| Spectral limit | What happens as dimension grows? | Not formalized |

### Pushforward transport has two gates

Let \(F:X\to Y\) be measurable, let \(\nu\) be a source measure on \(X\), and
let \(\mu\) be its pushforward \(F_*\nu\). For a suitable
\(g:Y\to\mathbb C\), the
change-of-variables identity reads

\[
\int_Y g(y)\,\mathrm d(F_*\nu)(y)
=\int_X g(F(x))\,\mathrm d\nu(x).
\]

Mathlib's <code>integral_map</code> supplies this identity under the relevant
almost-everywhere measurability hypotheses. Separately,
<code>integrable_map_measure</code> relates integrability of \(g\) under the
pushforward to integrability of \(g\circ F\) under the source measure.
([Mathlib contributors](#ref-mathlib-integrable-map))

RMT-09 uses both layers for the second power. Proving only the integral rewrite
would not publish the required analytic license. Proving only source
integrability would not calculate the target expectation.

## Camp one: the first trace reads the diagonal

For every \(n\)-by-\(n\) matrix \(H\),

\[
\operatorname{Tr}(H)=\sum_{i\in\operatorname{Fin}(n)}H_{ii}.
\]

No Hermitian assumption is needed for this algebraic identity. Under finite
GUE, however, every diagonal entry is real almost surely and has the exact
centered Cartesian complex Gaussian law whose real variance is \(s_n\) and
imaginary variance is zero. The earlier theorem
<code>matrixLaw_diagonal_hasLaw</code> packages this statement for each index
\(i\) ([Mathlib contributors](#ref-mathlib-gaussian)).

That marginal law supplies two facts needed here:

- \(H\mapsto H_{ii}\) is integrable under \(\mu_n\);
- its complex mean is zero.

Because the diagonal index is finite, integrability is closed under the sum:

\[
\operatorname{Integrable}
\left(H\mapsto\sum_iH_{ii}\right).
\]

Then finite linearity of the Bochner integral gives

\[
\begin{aligned}
\int\operatorname{Tr}(H)\,\mathrm d\mu_n(H)
&=\sum_i\int H_{ii}\,\mathrm d\mu_n(H)\\
&=\sum_i0\\
&=0.
\end{aligned}
\]

This proof is deliberately local. It does not use the full normalized real
product representation, the unitary-invariance theorem, or independence among
entries. Exact centered diagonal marginals are sufficient.

### The empty first sum

When \(n=0\), <code>Fin 0</code> has no elements. Matrix trace is the sum over
the empty diagonal, so it is zero pointwise. The same generic finite-sum proof
therefore gives integrability and zero integral. No special public theorem or
division argument is needed.

## Camp two: Hermitian trace square is Frobenius energy

The second power sees off-diagonal entries, but Hermiticity organizes them.
Write \(H^*\) for conjugate transpose. If \(H\) is Hermitian, then \(H^*=H\),
equivalently \(H_{ji}=\overline{H_{ij}}\). Expand trace and matrix
multiplication:

\[
\begin{aligned}
\operatorname{Tr}(H^2)
&=\sum_i(H^2)_{ii}\\
&=\sum_{i,j}H_{ij}H_{ji}\\
&=\sum_{i,j}H_{ij}\overline{H_{ij}}\\
&=\sum_{i,j}|H_{ij}|^2\\
&=\lVert H\rVert_F^2.
\end{aligned}
\]

The last expression is the squared
{{< refterm "hermitian-frobenius-geometry" "Frobenius norm" >}}. It is real
and nonnegative, then included into ℂ in the theorem statement
([Mathlib contributors](#ref-mathlib-matrix)).

The private Lean helper <code>trace_sq_hermitianToMatrix</code> proves this
pointwise identity on the intrinsic Hermitian Euclidean carrier. Rather than
expanding two finite sums again, it consumes RMT-07's checked identity between
the Frobenius inner product and
\(\operatorname{Tr}(X^*Y)\), specializes to \(X=Y=H\), and rewrites \(H^*=H\).

This is an important reuse boundary. The moment module does not re-prove the
geometry from raw entries, and the geometry module did not pretend to prove a
probability statement.

## Camp three: move the law to normalized real coordinates

RMT-08 introduced the finite real index

\[
\mathcal I_n
=\operatorname{Fin}(n)
\sqcup I_n^{\lt}
\sqcup I_n^{\lt},
\]

where \(I_n^{\lt}\) is the set of strict-upper positions. Its three regions
hold the diagonal, normalized upper-real, and normalized upper-imaginary
coordinates. The normalized assembly map decodes a real function
\(x:\mathcal I_n\to\mathbb R\) into a Hermitian matrix by keeping the diagonal
and dividing both upper components by \(\sqrt2\).

The factor \(\sqrt2\) is forced by reflection. Every strict-upper entry appears
again as its conjugate below the diagonal. Raw upper real and imaginary parts
therefore carry twice the Frobenius weight of a diagonal coordinate. The
normalization makes assembly a real linear isometry:

\[
\lVert H(x)\rVert_F^2
=\sum_{a\in\mathcal I_n}x_a^2.
\]

RMT-08 also proved equality of the complete normalized product law with the
earlier coordinate-built GUE law. RMT-09 exposes the direct composite
<code>normalizedRealMatrixSample n</code> privately and proves

\[
\mu_n
=H_*\left(
\bigotimes_{a\in\mathcal I_n}N(0,s_n)
\right).
\]

This is an equality of whole measures, not a statement that the coordinates
merely have matching variances. It licenses the pushforward integration step.

Combining the measure equality with the pointwise norm identity gives

\[
T_2(H(x))
=\operatorname{Tr}(H(x)^2)
=\left(\sum_{a\in\mathcal I_n}x_a^2:\mathbb R\right)
\]

viewed in ℂ. In Lean, the private theorem
<code>tracePower_two_normalizedRealMatrixSample</code> is exactly this
deterministic bridge.

## Camp four: prove the sum of squares integrable

Fix one coordinate \(a\in\mathcal I_n\). Under the finite product measure,
evaluation at \(a\) has the centered real Gaussian law \(N(0,s_n)\). The
project's exact real Gaussian API supplies finite second-power membership and
hence integrability of \(x_a^2\):

\[
\int |x_a^2|\,\mathrm d\rho_n(x)\lt\infty,
\]

where \(\rho_n\) denotes the normalized real product measure.

Because \(\mathcal I_n\) is finite, the whole sum of squares is integrable:

\[
x\longmapsto\sum_{a\in\mathcal I_n}x_a^2.
\]

The Lean proof packages the scalar fact in the private helper
<code>centeredGaussian_integrable_sq</code>, applies it to each evaluation
marginal, and uses <code>integrable_finsetSum</code>. It then converts the real
integrable function to its complex inclusion and transfers integrability
through the measurable normalized assembly map.

The target statement is not about the coordinate source measure. The theorem
<code>integrable_tracePower_two</code> explicitly concludes integrability of
<code>tracePower id 2</code> under <code>matrixLaw n</code>. The proof passes
through <code>integrable_map_measure</code> and the pointwise bridge, so the
analytic result lands on the public ambient law.

### Why no independence calculation appears

The source law is a product, so its coordinates are indeed jointly
independent. But after the Frobenius identity, the observable is a finite sum
of one-coordinate squares. Linearity of integration gives

\[
\int\sum_a x_a^2\,\mathrm d\rho_n
=\sum_a\int x_a^2\,\mathrm d\rho_n
\]

without any independence hypothesis. Independence becomes essential when an
observable contains products of distinct coordinates and one wants to factor
their expectations. No such cross terms survive here.

The exact product-law theorem still matters. It establishes the source measure
and the evaluation marginals used in the calculation. The narrow claim is that
the final integration step does not invoke an independence factorization.

## Camp five: count the coordinates and close the normalization

For a centered real Gaussian \(Z\sim N(0,s_n)\),

\[
\mathbb E[Z^2]=s_n.
\]

RMT-09 derives this from the earlier exact mean and variance theorems. Its
private helper <code>centeredGaussian_integral_sq</code> does not integrate a
density by hand.

Therefore

\[
\begin{aligned}
\int\sum_{a\in\mathcal I_n}x_a^2\,\mathrm d\rho_n(x)
&=\sum_{a\in\mathcal I_n}s_n\\
&=|\mathcal I_n|s_n.
\end{aligned}
\]

RMT-08 built a finite equivalence

\[
\mathcal I_n\simeq\operatorname{Fin}(n)\times\operatorname{Fin}(n).
\]

The moment module uses that equivalence to prove

\[
|\mathcal I_n|=n^2.
\]

Now the normalization arithmetic separates cleanly into two branches.

For \(n=0\), the coordinate index is empty and \(s_0=0\), so

\[
|\mathcal I_0|s_0=0.
\]

For a successor dimension, hence positive \(n\), the variance scale is
\(s_n=1/n\), so

\[
|\mathcal I_n|s_n
=n^2\frac1n
=n.
\]

The private theorem <code>card_mul_varianceScale</code> implements exactly this
zero/successor split. The public theorem needs no assumption \(0\lt n\).

### A two-by-two audit

For \(n=2\), a Hermitian matrix has two real diagonal entries and one complex
strict-upper entry. The normalized real ledger therefore has four directions:

\[
d_1,\quad d_2,\quad \sqrt2\operatorname{Re}(u),\quad
\sqrt2\operatorname{Im}(u).
\]

Each normalized coordinate has variance \(1/2\). Their squared sum has expected
value

\[
4\cdot\frac12=2,
\]

which matches the theorem's right side. In displayed matrix entries,
\(\operatorname{Re}(u)\) and \(\operatorname{Im}(u)\) each have variance \(1/4\),
and the conjugate lower entry supplies the second Frobenius copy. This check is
small enough to do by hand and catches the most common factor-of-two error.

## The complete normalization ledger

| Convention | Dimension zero | Positive dimension | Role in RMT-09 |
|---|---|---|---|
| Matrix index | <code>Fin 0</code> is empty | <code>Fin n</code> has \(n\) indices | Controls trace sums |
| Variance scale \(s_n\) | \(0\) | \(1/n\) | Common variance of normalized real coordinates |
| Diagonal entry | Unique empty family | Real centered Gaussian with variance \(1/n\) | First moment and part of second |
| Strict-upper real part | Unique empty family | Centered Gaussian with variance \(1/(2n)\) | Displayed entry convention |
| Strict-upper imaginary part | Unique empty family | Centered Gaussian with variance \(1/(2n)\) | Displayed entry convention |
| Normalized upper coordinates | Unique empty family | Multiply displayed components by \(\sqrt2\) | Restores common variance \(1/n\) |
| Number of normalized real coordinates | \(0\) | \(n^2\) | One per ambient matrix position via a finite equivalence |
| Trace convention | Ordinary trace | Ordinary trace | Produces second moment \(n\), not \(1\) |
| Density exponent | Not defined or used | Classical context would use \(-n\operatorname{Tr}(H^2)/2\) | Explicit nonclaim |
| Spectral scale | Empty spectrum | Order-one interpretation is classical context | No finite or asymptotic spectral theorem follows |

The ledger explains three formulas that can otherwise look contradictory.
Diagonal entries have variance \(1/n\), displayed upper real and imaginary
parts each have variance \(1/(2n)\), and every **normalized** real coordinate
has variance \(1/n\). They describe the same law in different coordinate
systems.

## The four checked declarations

The public module has no new definition or instance. Its complete API is:

~~~lean
theorem GUE.integrable_tracePower_one (n : ℕ) :
    MeasureTheory.Integrable
      (RandomMatrix.tracePower
        (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ) 1)
      (GUE.matrixLaw n)

theorem GUE.integral_tracePower_one (n : ℕ) :
    ∫ H : Matrix (Fin n) (Fin n) ℂ,
        RandomMatrix.tracePower id 1 H ∂GUE.matrixLaw n = 0

theorem GUE.integrable_tracePower_two (n : ℕ) :
    MeasureTheory.Integrable
      (RandomMatrix.tracePower
        (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ) 2)
      (GUE.matrixLaw n)

theorem GUE.integral_tracePower_two (n : ℕ) :
    ∫ H : Matrix (Fin n) (Fin n) ℂ,
        RandomMatrix.tracePower id 2 H ∂GUE.matrixLaw n = (n : ℂ)
~~~

All four compile under Lean 4.32.0 with the repository's pinned Mathlib 4.32.0
revision. The theorem axiom audit reports only <code>propext</code>,
<code>Classical.choice</code>, and <code>Quot.sound</code>, the standard logical
and quotient principles inherited from Lean and Mathlib. There are no project
axioms or proof holes.

### Declaration map

| Declaration | Checked result | Main proof route | Deliberate boundary |
|---|---|---|---|
| <code>GUE.integrable_tracePower_one</code> | The first trace-power observable is complex Bochner integrable under <code>matrixLaw n</code> | Expand trace as a finite diagonal sum; use integrability from each exact diagonal marginal law | No value of the integral yet |
| <code>GUE.integral_tracePower_one</code> | The first complex integral is zero | Move integral through the finite sum; replace every diagonal mean by zero | No independence or symmetry argument |
| <code>GUE.integrable_tracePower_two</code> | The second trace-power observable is complex Bochner integrable under <code>matrixLaw n</code> | Rewrite the matrix law as a normalized real product pushforward; prove a finite sum of Gaussian squares integrable; transfer through the map | No density or eigenvalue route |
| <code>GUE.integral_tracePower_two</code> | The second complex integral is the dimension | Apply <code>integral_map</code>, rewrite pointwise to the coordinate square sum, integrate scalar second moments, count coordinates, split zero from successor dimension | No higher moment, concentration, or limit |

### Private scaffolding and why it remains private

The module contains private helpers for the deterministic trace-square identity,
scalar centered-Gaussian square integrability and expectation, the normalized
real sample map, the exact pushforward comparison, the coordinate square-sum
identity, finite-sum integration, coordinate cardinality, and normalization
arithmetic.

These are proof architecture, not a competing public theory. The reusable
geometric maps and Gaussian law interfaces already live in earlier modules.
Keeping the local compositions private leaves the public API focused on the
four analytic facts downstream code needs.

### The second integrability proof in Lean-shaped steps

The proof of <code>integrable_tracePower_two</code> follows this chain:

1. rewrite <code>matrixLaw n</code> as the map of the normalized real Gaussian
   product by <code>normalizedRealMatrixSample n</code>;
2. invoke <code>integrable_map_measure</code> with measurability of the sample
   map and strong measurability of <code>tracePower id 2</code>;
3. use the pointwise equality between the composed trace power and the complex
   inclusion of the real coordinate square sum;
4. prove the real finite sum integrable coordinate by coordinate; and
5. transfer integrability through the real-to-complex inclusion.

The integral theorem repeats the law rewrite, uses <code>integral_map</code>,
uses <code>integral_congr_ae</code> for the pointwise square-sum identity,
commutes real inclusion with integration, and applies the exact finite sum and
cardinality calculation.

## Why eigenvalues are unnecessary here

For a Hermitian matrix with real eigenvalues
\(\lambda_1,\ldots,\lambda_n\), the spectral theorem classically gives

\[
\operatorname{Tr}(H^k)=\sum_{r=1}^n\lambda_r^k.
\]

This is the finite algebraic doorway into the classical trace-moment method
([Anderson, Guionnet, and Zeitouni](#ref-agz);
[Tao](#ref-tao);
[Wigner](#ref-wigner)).

That formula motivates the name *spectral moment*, but formalizing it at the
law level would require more infrastructure: a measurable eigenvalue
enumeration or multiset, multiplicity bookkeeping, and a measurable empirical
spectral measure. None is needed for \(k=1\) or \(k=2\).

The first identity is visible from diagonal entries. The second is visible from
Hermitian Frobenius geometry. Entry coordinates already carry exact measurable
laws, so routing through eigenvalues would lengthen the proof and introduce
choices irrelevant to these two finite results.

This is not an argument against eigenvalues. They are the natural next layer
for empirical spectral measures and spectral statistics. It is an argument for
proving each theorem at the weakest sufficient interface.

## Why a density is unnecessary here

For positive \(n\), the classical Wigner-scaled GUE density is proportional to

\[
\exp\!\left(-\frac n2\operatorname{Tr}(H^2)\right)
\]

relative to a chosen Lebesgue measure on the real vector space of Hermitian
matrices ([Guionnet](#ref-guionnet)). One could in principle integrate the
first two trace powers against that density.

The repository has not formalized that density, its normalizing constant, or
the reference volume. RMT-09 does not need them. The coordinate construction
already provides a probability measure, RMT-08 identifies it with a scaled
intrinsic Gaussian, and scalar Gaussian moment theorems evaluate the required
finite sums.

Avoiding a density also keeps dimension zero honest. An empty finite product
and a Dirac law are already meaningful there, while formulas involving
positive-dimensional Lebesgue density require a separate convention.

## Physics window: what the second identity suggests

For a Hermitian Hamiltonian, \(\operatorname{Tr}(H^2)\) is the sum of squared
energy eigenvalues. The checked expectation \(n\) means that the expected
ordinary average per eigenvalue is one for positive dimension:

\[
\mathbb E\!\left[\frac1n\operatorname{Tr}(H^2)\right]=1.
\]

This is consistent with the order-one spectral scale intended by Wigner
normalization. It is one calibration check behind the semicircle regime.

The Lean theorem is narrower. It states the ordinary-trace identity for each
finite \(n\), including zero. It does not define random energy eigenvalues,
prove that an empirical measure exists measurably, or show convergence to the
semicircle distribution. The normalized positive-dimensional corollary above
is explanatory mathematics and requires \(0\lt n\); it is not one of the four
public declarations.

## Common wrong turns

### Calling measurability a moment theorem

A measurable trace power may have an infinite norm integral. Publish an
<code>Integrable</code> theorem before interpreting the Bochner integral as a
finite expectation.

### Forgetting that the Bochner integral is totalized

An integral equation with value zero is not by itself evidence of mean zero in
Mathlib. The nonintegrable branch also evaluates to zero by definition.

### Using raw upper-entry coordinates in the norm square

Every strict-upper entry is reflected below the diagonal. Raw upper real and
imaginary parts have Frobenius weight two. The normalized real coordinates
absorb that weight through the square-root-of-two correction.

### Assigning normalized-coordinate variance to displayed upper components

The normalized upper coordinates have variance \(1/n\). The displayed real
and imaginary parts after decoding each have variance \(1/(2n)\). Confusing
the two descriptions doubles the second moment.

### Expanding cross terms and demanding independence

The Hermitian trace-square identity becomes a sum of coordinate squares, not
the square of a coordinate sum. Linearity of expectation is sufficient. There
are no distinct-coordinate products to factor.

### Dividing by dimension before handling zero

The public result uses ordinary trace and includes \(n=0\). Only a later
positive-dimensional corollary may divide by \(n\).

### Inferring a semicircle law from two moments

Two exact finite moments do not determine an arbitrary probability law and do
not establish convergence of empirical spectral measures. Higher moments,
tightness or another convergence framework, and measurable spectral data are
separate prerequisites.

## Worked audit checklist

Before accepting a finite random-matrix moment formula, ask:

1. What is the exact matrix law and on which measurable space does it live?
2. Is the trace ordinary or normalized?
3. Is the matrix itself scaled, and where does the dimension enter?
4. Is the trace-power observable measurable?
5. Has its norm integrability been proved under this law?
6. Is the displayed integral real-valued or complex-valued?
7. If a pushforward is used, were both measurability and integrability moved
   through it?
8. Are entry variances stated for displayed entries or orthonormal coordinates?
9. Does a coordinate count include the diagonal and both upper real
   directions?
10. Is dimension zero included, excluded, or assigned a separate convention?
11. Did the proof actually use independence, or only scalar marginals and
    linearity?
12. Does the conclusion concern one finite dimension or a limit?

RMT-09 answers each question explicitly.

## Exercises from trailhead to summit

### Trailhead

1. Let
   \[
   H=\begin{bmatrix}a&u\\\overline u&b\end{bmatrix}
   \]
   with \(a,b\in\mathbb R\) and \(u\in\mathbb C\). Expand
   \(\operatorname{Tr}(H^2)\) and verify
   \(a^2+b^2+2|u|^2\).
2. Substitute
   \(u=(x+iy)/\sqrt2\). Show that the same expression becomes
   \(a^2+b^2+x^2+y^2\).
3. If all four normalized coordinates are centered with variance \(1/2\),
   evaluate the expected sum without using independence.

### Mid-mountain

4. Prove on paper that a finite sum of integrable complex-valued functions is
   integrable and that its Bochner integral is the sum of their integrals.
5. Give an example of a measurable real random variable that is not integrable.
   Explain what Mathlib's totalized integral returns and why the corresponding
   equation should not be advertised as an expectation theorem.
6. Write the change-of-variables identity for a pushforward measure and list
   the measurability hypotheses on the map and the integrand. Then state the
   separate integrability equivalence needed in the RMT-09 proof.
7. Count the diagonal, strict-upper real, and strict-upper imaginary regions
   directly and verify
   \(n+2\binom n2=n^2\). Compare this arithmetic proof with using a finite
   equivalence to all ordered matrix positions.

### Summit

8. For positive \(n\), derive the expected normalized second trace moment from
   the checked ordinary-trace theorem. Explain why the proof cannot simply be
   specialized to \(n=0\).
9. Expand \(\operatorname{Tr}(H^3)\) in entries. Identify where products of
   distinct coordinates appear and why centeredness and independence become
   more consequential than they were for the second power.
10. Design the next formal interface for empirical spectral measures. State
    which parts require measurable eigenvalue data and which finite trace
    identities could be reused after that bridge is checked.
11. Compare a density-based proof of the second moment with the product-law
    proof used here. List the extra reference-measure, normalization, and
    change-of-variables obligations introduced by the density route.

## Reproduce the checked slice

From the repository root, load the pinned Lean toolchain and compile the module
with warnings treated as errors:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleMoments.lean
~~~

Build the targeted module and its dependencies:

~~~sh
lake build \
  NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleMoments
~~~

Return to the repository root and build the draft teaching site:

~~~sh
cd ..
make site-check
~~~

The repository-wide milestone gate is <code>make check</code>. The page remains
a draft even when the technical gate passes because human mathematical and
editorial review are separate publication requirements.

## What has and has not been proved

| Topic | Checked status after RMT-09 |
|---|---|
| Measurability of every finite trace power | Checked earlier |
| Integrability of the first GUE trace power | Checked for every natural dimension |
| Exact first complex integral | Checked and equal to zero |
| Integrability of the second GUE trace power | Checked for every natural dimension |
| Exact second complex integral | Checked and equal to the matrix dimension |
| Dimension-zero behavior | Included in all four public theorems |
| Equality of Hermitian trace square and Frobenius norm square | Checked privately here from reusable RMT-07 geometry |
| Exact normalized product pushforward | Checked earlier and consumed here |
| Higher expected trace powers | Not checked |
| Variance or concentration of trace powers | Not checked |
| Measurable eigenvalue enumeration | Not checked |
| Empirical spectral measure | Not defined |
| Joint eigenvalue density | Not checked |
| Semicircle law or any large-dimension convergence | Not checked |
| Local spacing statistics or universality | Not checked |
| Quantum dynamics | Not checked |

The finite identities are exact and useful. Their narrowness is a strength:
the next spectral layer can consume them without inheriting an unspoken density
or positivity convention.

## Where to continue

The {{< refterm "finite-matrix-trace-moment" "finite matrix trace moment" >}}
glossary entry gives a compact operational definition and normalization audit.
Read {{< refterm "trace-power" "trace-power observable" >}} for the earlier
measurability boundary and
{{< refterm "matrix-trace" "matrix trace" >}} for the underlying finite
algebra.

[From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance]({{< relref "/knowledge-base/deep-dives/normalized-hermitian-coordinates-to-gue-invariance" >}})
constructs the exact real product pushforward consumed by the second-moment
proof. [Intrinsic Hermitian Gaussian Symmetry and Matrix-Law Support]({{< relref "/knowledge-base/deep-dives/intrinsic-hermitian-gaussian-symmetry-and-matrix-law-support" >}})
develops the Frobenius geometry, while
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}})
fixes the entrywise Wigner law.

RMT-10A supplies the algebraic finite-spectrum interface and a zero-aware
empirical spectral measure. Read
[Finite Hermitian Spectra and Empirical Measures]({{< relref "/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures" >}})
for that continuation. RMT-10B discharges its measurability premise, and
[Finite Gaussian Unitary Ensemble Empirical Spectral Laws and Normalized Moments]({{< relref "/knowledge-base/deep-dives/finite-gue-empirical-spectral-laws-and-normalized-moments" >}})
then constructs the unconditional law and transports the two exact trace
expectations into normalized sample moments. No spectral limit is claimed.

## References

<a id="ref-mathlib-bochner"></a>**Mathlib contributors.**
[Bochner integral](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Integral/Bochner/Basic.html),
Mathlib 4 documentation. This official API defines the Banach-valued integral,
its totalized nonintegrable branch, linearity, finite sums, and
<code>integral_map</code>.

<a id="ref-mathlib-integrable-map"></a>**Mathlib contributors.**
[Integrable functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Function/L1Space/Integrable.html)
and
[pushforward of a measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
Mathlib 4 documentation. These official references document the
<code>Integrable</code> interface, <code>integrable_map_measure</code>, and the
measure-map semantics used to transfer the second observable from normalized
coordinates to ambient matrices.

<a id="ref-mathlib-gaussian"></a>**Mathlib contributors.**
[Real Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
[multivariate Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Multivariate.html),
and
[finite product measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Constructions/Pi.html),
Mathlib 4 documentation. These official pages provide the exact centered
Gaussian mean and variance results, finite moments, and product-coordinate
marginals used in the proof.

<a id="ref-mathlib-matrix"></a>**Mathlib contributors.**
[Matrix trace](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Trace.html),
[Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html),
and
[Pi-L2 Euclidean spaces](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/InnerProductSpace/PiL2.html),
Mathlib 4 documentation. These official algebraic and geometric APIs underlie
the trace expansion, Hermitian conjugate symmetry, and normalized-coordinate
norm calculation.

<a id="ref-agz"></a>**Greg W. Anderson, Alice Guionnet, and Ofer Zeitouni.**
[An Introduction to Random Matrices](https://doi.org/10.1017/CBO9780511801334),
Cambridge University Press, 2010. Chapters 2 and 3 give standard treatments of
Wigner matrices, trace moments, Gaussian ensembles, and their spectral
interpretation. The project's exact entry variances and ordinary-trace
convention are stated independently because literature normalizations differ.

<a id="ref-tao"></a>**Terence Tao.**
[Topics in Random Matrix Theory](https://doi.org/10.1090/gsm/132),
American Mathematical Society, 2012. This standard monograph develops the
moment method and Wigner normalization toward the semicircle law. RMT-09 stops
at the first two exact finite identities and does not import its asymptotic
conclusions.

<a id="ref-guionnet"></a>**Alice Guionnet.**
[Rare Events in Random Matrix Theory](https://doi.org/10.4171/ICM2022/174),
in *Proceedings of the International Congress of Mathematicians 2022*, volume
2, European Mathematical Society Press, 2022, pp. 1008-1052. Section 1.1.1
records the diagonal variance \(1/n\), upper real and imaginary variances
\(1/(2n)\), and invariant density convention for Wigner-scaled GUE. The
checked proof here uses the product law, not the density.

<a id="ref-wigner"></a>**Eugene P. Wigner.**
[Characteristic Vectors of Bordered Matrices With Infinite Dimensions](https://doi.org/10.2307/1970079),
*Annals of Mathematics* 62 (1955), 548-564. This primary source supplies
historical context for the trace-moment route to large random-matrix spectra.
Its limiting theorem is not a premise or conclusion of RMT-09.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
