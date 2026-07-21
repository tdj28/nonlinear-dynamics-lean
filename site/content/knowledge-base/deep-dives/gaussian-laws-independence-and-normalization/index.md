---
title: "Gaussian Laws, Independence, and Normalization"
slug: "gaussian-laws-independence-and-normalization"
date: 2026-07-20
summary: "A guided ascent from one exact real Gaussian law to finite product measures, mutually independent coordinates, and the normalization ledger required before complex Gaussian matrices."
lead: "A bell curve is only base camp. The real climb is to make laws, measurability, independence, product spaces, and scale agree without smuggling a convention into the name of a model."
draft: true
pro_reviewed: false
level: "Base camp to advanced"
reading_time: "45 to 65 minutes"
prerequisites: "Algebra and basic probability notation; no prior measure theory or Lean required"
lean_module: "NonlinearDynamics.Random.GaussianPrimitives"
toc: true
og_image: "gaussian-laws-card.png"
og_image_alt: "A warm-paper teaching card climbs from one scalar Gaussian law through an independent finite family to a product law, then stops at a highlighted normalization ledger."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The mathematical
prose, sources, Lean declaration map, figures, and accessibility have not yet
received the required human and Pro reviews. The page must remain a draft until
those gates are complete.
{{< /panel >}}

The familiar picture of a Gaussian distribution is a bell-shaped curve. That
picture is useful, but it hides nearly every distinction a formal development
must preserve. Is the object a function from outcomes, a measure on the real
line, or a finite sample? Does the second parameter mean variance or standard
deviation? Are several Gaussian coordinates mutually independent, merely
pairwise independent, or only uncorrelated? Does a list of marginal laws
determine the joint law? What happens when a variance is zero?

This chapter answers those questions in dependency order. It begins with one
exact real law, builds a family, identifies its finite joint law as a product
measure, and constructs a canonical product sample space. Only then does it
open a normalization ledger for future complex coordinates and Hermitian
matrices.

The stopping point is as important as the climb. Nothing here defines a
complex Gaussian law, a Gaussian matrix ensemble, or a Gaussian unitary
ensemble. Those names must wait until the ledger has one approved answer in
every slot.

## Choose a route up

| Route | Start with | What you will gain |
|---|---|---|
| First encounter | A random variable and its law | A precise meaning of an exact Gaussian claim |
| Probability route | Marginals and joint laws | Why independence is exactly a product-law statement |
| Analysis route | Mean, variance, and finite moments | The hypotheses behind scaling and addition |
| Lean route | <code>HasLaw</code> and <code>Measure.pi</code> | A map from Mathlib APIs to every project declaration |
| Random-matrix route | The normalization ledger | A safe boundary before complex and matrix conventions |

### Learning objectives

By the summit, you should be able to:

1. distinguish a Gaussian density, Gaussian measure, random variable, and
   observed sample;
2. explain why the zero-variance Gaussian law is a Dirac measure;
3. state what exact information
   <code>HasLaw X (gaussianReal m v) P</code> contains and what it does not;
4. explain why Gaussian marginal laws do not determine a joint law;
5. derive the finite product law of a mutually independent family;
6. read the canonical product sample space as a probability experiment, not
   just an existence proof;
7. track ordinary measurability separately from almost-everywhere
   measurability; and
8. fill a normalization ledger before constructing a complex coordinate or a
   named matrix ensemble.

## The full dependency stack

{{< reference-figure
  src="gaussian-product-law-stack.svg"
  alt="The construction adds exact scalar parameters, ordinary coordinate measurability and mutual independence, a finite product law, and finally an unresolved normalization ledger."
  caption="**Finding:** each level contributes information that the previous level does not contain. Exact marginal laws do not imply independence; independence plus finite marginal laws gives a product joint law; that product law still does not select a complex or matrix normalization. The final boundary is intentional."
>}}

The stack is asymmetric. A joint product law determines every marginal law and
its independence structure. Marginal laws alone do not determine the joint
law. A normalization convention may rescale an already valid product law, but
the word "Gaussian" does not choose that scale.

## Base camp: one random variable has three faces

Let \((\Omega,\mathcal F,\mathbb P)\) be a probability space. A real random
variable is a measurable map

\[
X:\Omega\longrightarrow\mathbb R.
\]

It has three closely related but distinct faces:

| Face | Object | Question |
|---|---|---|
| Sample map | \(X\) | Which value does each outcome produce? |
| Realization | \(X(\omega)\) | What value appeared for this outcome? |
| Law | \(\mathcal L_{\mathbb P}(X)=X_*\mathbb P\) | How is probability distributed over all possible values? |

The {{< refterm "pushforward-measure" "pushforward measure" >}}
\(X_*\mathbb P\) forgets the internal identity of outcomes while retaining all
probabilities of measurable value events. If \(B\subseteq\mathbb R\) is
measurable, then

\[
\mathcal L_{\mathbb P}(X)(B)
=\mathbb P\{\omega:X(\omega)\in B\}.
\]

An observed data set is a fourth object. It may consist of values produced by
repeated trials, but it is neither the map nor the law. Statistical procedures
can estimate or test a proposed law. A finite sample does not turn a visual
bell shape into a theorem that the underlying law is Gaussian.

{{< checkpoint stage="Base camp" title="Name the object before proving with it" >}}
If a statement says "the Gaussian," ask whether it means a measure
\(\gamma_{m,v}\), a random variable \(X\) with that law, the density of that
measure when \(v\gt 0\), or a sample from an experiment. Formalization begins by
choosing one.
{{< /checkpoint >}}

## Camp one: the exact real Gaussian measure

Write \(\gamma_{m,v}\) for the real Gaussian probability law with mean
\(m\in\mathbb R\) and variance \(v\ge0\). When \(v\gt 0\), it has density

\[
f_{m,v}(x)
=\frac{1}{\sqrt{2\pi v}}
  \exp\!\left(-\frac{(x-m)^2}{2v}\right).
\]

The parameter \(m\) shifts the center. The parameter \(v\) controls squared
spread. The standard deviation is \(\sqrt{v}\). The distinction is not
optional: if a scale coefficient is doubled, standard deviation doubles while
variance is multiplied by four.

### The zero-variance branch is a measure, not a broken density

At \(v=0\), the denominator in the density formula vanishes. The correct law
is instead

\[
\gamma_{m,0}=\delta_m,
\]

the Dirac probability measure concentrated at \(m\). A random variable with
this law equals \(m\) almost surely.

This branch is not an afterthought. Let \(X\sim\gamma_{m,v}\) and multiply by
a real constant \(c\). The transformed variable has

\[
cX\sim\gamma_{cm,c^2v}.
\]

Putting \(c=0\) must produce \(\gamma_{0,0}=\delta_0\). A definition that bans
zero variance would make an elementary deterministic scaling theorem require
an artificial side condition.

### Mathlib chooses variance as a nonnegative-real parameter

In the pinned Mathlib 4.32.0 API,

~~~lean
#check ProbabilityTheory.gaussianReal
#check ProbabilityTheory.gaussianReal_zero_var
#check ProbabilityTheory.gaussianReal_const_mul
~~~

the measure has the signature

~~~text
gaussianReal (m : ℝ) (v : ℝ≥0) : Measure ℝ
~~~

The type <code>ℝ≥0</code>, also called <code>NNReal</code>, prevents a
negative variance. Mathlib defines the zero branch as
<code>Measure.dirac m</code>, proves that every
<code>gaussianReal m v</code> is a probability measure, and proves exact
formulas for its mean, variance, finite moments, translations, scalings, and
convolution.

The page on {{< refterm "gaussian-distribution" "Gaussian distributions" >}}
works through the density and transformation formulas in detail.

## Camp two: exact law before qualitative Gaussianity

The core project definition is intentionally small:

~~~lean
def HasRealGaussianLaw (X : Ω → ℝ) (m : ℝ) (v : ℝ≥0)
    (P : Measure Ω) : Prop :=
  HasLaw X (gaussianReal m v) P
~~~

This statement says exactly which pushforward measure \(X\) has under \(P\).
It preserves the parameters needed later for normalization.

Mathlib also provides the qualitative predicate
<code>HasGaussianLaw X P</code>. For a real variable, it says that the
pushforward law is Gaussian, but its type does not retain a chosen pair
\((m,v)\) as explicit arguments. The project therefore follows this direction:

\[
\text{exact parameterized law}
\quad\Longrightarrow\quad
\text{qualitative Gaussian law}.
\]

The checked theorem <code>HasRealGaussianLaw.hasGaussianLaw</code> performs
that forgetting step. The reverse direction is not used to guess parameters.

### Why <code>HasLaw</code> includes only almost-everywhere measurability

Mathlib's <code>HasLaw X μ P</code> stores:

1. <code>AEMeasurable X P</code>, meaning \(X\) agrees
   \(P\)-almost everywhere with a measurable function; and
2. <code>P.map X = μ</code>, the exact pushforward identity.

It does not imply ordinary <code>Measurable X</code>. Changing a function on a
\(P\)-null set leaves its law unchanged, so a law-level predicate naturally
lives at the almost-everywhere layer.

The distinction becomes operational later. A product-law theorem can often use
almost-everywhere measurability. A reusable family interface may still want
ordinary measurability for coordinate transformations. The project does not
pretend these are the same proof.

### What an exact scalar law buys

From <code>hX : HasRealGaussianLaw X m v P</code>, the checked module proves:

| Declaration | Exact consequence |
|---|---|
| <code>HasRealGaussianLaw.aemeasurable</code> | <code>AEMeasurable X P</code> |
| <code>HasRealGaussianLaw.isProbabilityMeasure</code> | the source measure \(P\) has total mass one |
| <code>HasRealGaussianLaw.mean_eq</code> | \(\int X\,dP=m\) |
| <code>HasRealGaussianLaw.variance_eq</code> | \(\operatorname{Var}_P(X)=v\) after coercing \(v\) to \(\mathbb R\) |
| <code>HasRealGaussianLaw.hasGaussianLaw</code> | the qualitative Mathlib Gaussian predicate |
| <code>HasRealGaussianLaw.memLp</code> | <code>MemLp X p P</code> for every extended exponent \(p\ne\infty\), including \(p=0\) |
| <code>HasRealGaussianLaw.integrable</code> | \(X\) is integrable |
| <code>HasRealGaussianLaw.ae_eq_const_of_variance_zero</code> | the zero-variance variable equals its mean almost everywhere |
| <code>HasRealGaussianLaw.zero_variance_iff</code> | under a probability measure, the zero law is equivalent to almost-everywhere constancy |
| <code>HasRealGaussianLaw.const_mul</code> | scaling multiplies mean by \(c\) and variance by \(c^2\) |
| <code>HasRealGaussianLaw.add_of_indep</code> | independent Gaussian sums add means and variances |

The theorem list is a layer map, not a collection of redundant facts. A law
gives almost-everywhere measurability. Mean and variance require integrals.
The <code>MemLp</code> theorem justifies later finite-order moments. The
independent-sum theorem needs a joint assumption that neither marginal law
contains.

## The variance ridge: finite moments prevent a totalization trap

For a square-integrable real variable,

\[
\operatorname{Var}_P(X)
=\int_\Omega
  \left(X(\omega)-\int_\Omega X\,dP\right)^2\,dP(\omega).
\]

Mathlib first defines extended variance

~~~text
evariance X P : ℝ≥0∞
~~~

and then defines the real-valued

~~~text
variance X P : ℝ
~~~

by applying <code>ENNReal.toReal</code>. This makes the real-valued function
total, but it also means that infinite extended variance maps to zero. A bare
equation <code>Var[X; P] = 0</code> is therefore insufficient to infer
constancy unless a finite second-moment hypothesis excludes the infinite case.

Exact Gaussian laws avoid this ambiguity. Mathlib proves that the identity
function belongs to every <code>Lᵖ</code> space with exponent not equal to
infinity under <code>gaussianReal m v</code>. Transporting that result through
<code>HasLaw</code> gives the project's <code>memLp</code> theorem. The
equation

\[
\operatorname{Var}_P(X)=v
\]

then has its intended finite meaning.

The dedicated {{< refterm "variance" "variance" >}} entry develops the
totalization boundary, units, scaling, and zero-variance example.

## Camp three: two Gaussian marginals are not a joint Gaussian law

Suppose \(X\sim\gamma_{m_X,v_X}\) and
\(Y\sim\gamma_{m_Y,v_Y}\). These statements determine each marginal law. They
say nothing about how \(X\) and \(Y\) move together.

Two extreme couplings make the gap visible:

- If \(X\) and \(Y\) are independent, their joint law is
  \(\gamma_{m_X,v_X}\otimes\gamma_{m_Y,v_Y}\).
- If \(Y=X\), with matching parameters, the joint law is concentrated on the
  diagonal \(\{(x,y):x=y\}\).

The marginals can be identical in both constructions. The joint laws are not.
Any matrix model assembled from entry laws must therefore state its dependence
structure, not just repeat a Gaussian marginal formula.

### Independence is factorization for every measurable event

The real variables \(X\) and \(Y\) are independent under \(P\) when

\[
P\{X\in A,Y\in B\}
=P\{X\in A\}\,P\{Y\in B\}
\]

for every pair of measurable sets \(A,B\subseteq\mathbb R\). Equivalently,

\[
\mathcal L_P(X,Y)
=\mathcal L_P(X)\otimes\mathcal L_P(Y).
\]

Under finite second moments, independence makes covariance vanish. The
reverse implication is false in general. The product-law definition is the
right one because it controls all measurable joint events, not only a single
second-order statistic.

Mathlib names the binary property <code>IndepFun X Y P</code>. The project
theorem <code>HasRealGaussianLaw.add_of_indep</code> combines it with two exact
laws:

\[
X+Y\sim
\gamma_{m_X+m_Y,\ v_X+v_Y}.
\]

The sum is Gaussian because convolution of real Gaussian measures adds their
means and variances. Independence supplies the convolution law of the sum.

## Camp four: mutual independence for an indexed family

Let \(I\) be an index type and let \(X_i:\Omega\to\mathbb R\) for each
\(i\in I\). Mutual independence requires finite factorization: for every
finite \(J\subseteq I\) and every collection of measurable sets \(A_j\),

\[
P\!\left(\bigcap_{j\in J}\{X_j\in A_j\}\right)
=\prod_{j\in J}P\{X_j\in A_j\}.
\]

This is stronger than pairwise independence. For three or more coordinates,
checking each pair does not rule out a higher-order constraint.

Mathlib calls the family property <code>iIndepFun X P</code>. The leading
<code>i</code> denotes an indexed family, not identical distribution. The
coordinates may have different target types and different laws.

### The project bundle keeps three obligations separate

The exact project structure is:

~~~lean
structure IndependentRealGaussianFamily
    (X : ι → Ω → ℝ) (m : ι → ℝ) (v : ι → ℝ≥0)
    (P : Measure Ω) : Prop where
  measurable : ∀ i, Measurable (X i)
  hasLaw : ∀ i, HasRealGaussianLaw (X i) (m i) (v i) P
  independent : iIndepFun X P
~~~

Read the fields as three axes:

1. <code>measurable</code> certifies ordinary coordinate sample maps;
2. <code>hasLaw</code> fixes every mean and variance at the law level; and
3. <code>independent</code> fixes the joint dependence structure.

The fields are not collapsed because they answer different questions. In
particular, <code>hasLaw</code> supplies only almost-everywhere measurability.
The family stores the ordinary version explicitly so coordinatewise
transformations can use Mathlib's standard measurable-function closure lemmas.

### Coordinatewise scaling preserves the whole bundle

Given real constants \(c_i\), define

\[
Y_i=c_iX_i.
\]

Then

\[
\mathbb E[Y_i]=c_im_i,
\qquad
\operatorname{Var}(Y_i)=c_i^2v_i.
\]

Because each coordinate transformation uses only its own input, mutual
independence is preserved. The theorem
<code>IndependentRealGaussianFamily.scale</code> proves all three fields:

- ordinary measurability by measurable scalar multiplication;
- the exact law by <code>HasRealGaussianLaw.const_mul</code>; and
- mutual independence by <code>iIndepFun.comp</code>.

Zero factors are allowed. A coordinate with \(c_i=0\) becomes a Dirac
coordinate without invalidating independence of the family.

## High camp: the finite product law

Now assume \(I\) is finite. The joint sample map is

\[
\mathbf X:\Omega\longrightarrow\mathbb R^I,
\qquad
\mathbf X(\omega)(i)=X_i(\omega).
\]

For each coordinate, define the exact marginal measure

\[
\mu_i=\gamma_{m_i,v_i}.
\]

The finite product measure is

\[
\bigotimes_{i\in I}\mu_i.
\]

On a measurable rectangle \(\prod_{i\in I}A_i\), it satisfies

\[
\left(\bigotimes_{i\in I}\mu_i\right)
\left(\prod_{i\in I}A_i\right)
=\prod_{i\in I}\mu_i(A_i).
\]

This rectangle identity is the measure-level form of mutual independence.
Mathlib's <code>Measure.pi</code> constructs the finite product measure, while
<code>iIndepFun.hasLaw_pi</code> bridges independent coordinate laws to the
joint law.

The checked theorem says:

~~~text
IndependentRealGaussianFamily.jointHasLaw
  : HasLaw (fun ω i ↦ X i ω)
      (Measure.pi fun i ↦ gaussianReal (m i) (v i)) P
~~~

This theorem is the summit of the current probability slice. It upgrades a
bundle of local statements into a complete law on a finite-dimensional
function space.

### A two-coordinate law you can audit by hand

Take \(I=\{0,1\}\) with

\[
X_0\sim\gamma_{0,1},
\qquad
X_1\sim\gamma_{3,4},
\]

and assume \(X_0,X_1\) are independent. Then the joint law is

\[
\gamma_{0,1}\otimes\gamma_{3,4}.
\]

For measurable sets \(A,B\subseteq\mathbb R\),

\[
P\{X_0\in A,X_1\in B\}
=\gamma_{0,1}(A)\,\gamma_{3,4}(B).
\]

The first coordinate has mean \(0\) and variance \(1\). The second has mean
\(3\), variance \(4\), and standard deviation \(2\). No
identical-distribution assumption was needed.

If \(v_1=0\) instead, the second marginal becomes \(\delta_3\). The same product
construction remains a probability measure. It is concentrated on the slice
\(\{x\in\mathbb R^I:x_1=3\}\) and has no density with respect to full
two-dimensional Lebesgue measure. Product laws are more fundamental than
density formulas because they cover this degenerate case without repair.

### Qualitative joint Gaussianity comes after the exact product law

The project also proves
<code>IndependentRealGaussianFamily.jointHasGaussianLaw</code>. It forgets the
explicit coordinate parameters and records that the finite vector-valued
sample map has Mathlib's qualitative Gaussian law.

The order matters:

\[
\text{exact marginals + independence}
\Longrightarrow
\text{exact product law}
\Longrightarrow
\text{qualitative joint Gaussianity}.
\]

For future normalization work, the exact product law is the valuable artifact
because it still names every \(m_i\) and \(v_i\).

## A canonical product sample space, not just an abstract witness

The previous discussion began with an arbitrary probability space
\((\Omega,P)\) and a family of functions on it. Sometimes we instead want a
standard experiment that carries the desired independent coordinates by
construction.

For finite \(I\), choose the sample space itself to be

\[
\Omega_{\mathrm{prod}}=\mathbb R^I.
\]

An outcome \(x\in\mathbb R^I\) is already a coordinate vector. Equip this
space with the product measure

\[
P_{\mathrm{prod}}
=\bigotimes_{i\in I}\gamma_{m_i,v_i}.
\]

Define each random variable by coordinate evaluation:

\[
\pi_i(x)=x_i.
\]

Then each \(\pi_i\) has law \(\gamma_{m_i,v_i}\), and the family
\((\pi_i)_{i\in I}\) is mutually independent.

The project names these pieces:

| Declaration | Role |
|---|---|
| <code>gaussianProductMeasure m v</code> | the measure <code>Measure.pi fun i ↦ gaussianReal (m i) (v i)</code> on <code>ι → ℝ</code> |
| <code>instIsProbabilityMeasureGaussianProduct</code> | proof that the product has total mass one |
| <code>gaussianProductMeasure_hasLaw_eval</code> | exact Gaussian law of coordinate evaluation |
| <code>gaussianProductMeasure_iIndepFun</code> | mutual independence of all evaluations |
| <code>gaussianProductMeasure_independentFamily</code> | the complete bundled family |

The last constructor supplies ordinary measurability through
<code>measurable_pi_apply</code>. It does not infer ordinary measurability from
<code>HasLaw</code>. That detail is small in code and foundational in meaning.

When \(I\) is empty, the function space has one empty tuple and
<code>gaussianProductMeasure</code> is the Dirac measure at that tuple. This is
the correct empty-product law. It does not choose the separate policy for a
future zero-dimensional matrix constructor or for formulas containing
dimension-dependent division.

{{< checkpoint stage="High camp" title="Read product space as an experiment" >}}
An outcome of the canonical sample space is a whole real coordinate vector.
Projection reveals one coordinate. The product measure is what makes those
projections independent and gives each one its requested marginal law.
{{< /checkpoint >}}

## The exact Lean proof architecture

The module imports one upstream interface:

~~~lean
import Mathlib.Probability.Distributions.Gaussian.HasGaussianLaw.Independence
~~~

That import transitively supplies real Gaussian measures,
<code>HasLaw</code>, Gaussian finite moments, independence, finite product
measures, and joint Gaussianity of independent Gaussian families.

### Scalar proofs reuse exact transport lemmas

The project does not re-prove Gaussian integration from the density. Instead:

- <code>mean_eq</code> uses <code>HasLaw.integral_eq</code> and
  <code>integral_id_gaussianReal</code>;
- <code>variance_eq</code> uses <code>HasLaw.variance_eq</code>;
- <code>memLp</code> and <code>integrable</code> pass through qualitative
  <code>HasGaussianLaw</code>;
- the zero-variance theorems rewrite
  <code>gaussianReal_zero_var</code>;
- <code>const_mul</code> is Mathlib's exact
  <code>gaussianReal_const_mul</code>; and
- <code>add_of_indep</code> uses independent convolution together with
  <code>gaussianReal_conv_gaussianReal</code>.

This is the right proof boundary. Mathlib owns the analytic facts about the
Gaussian measure. The project owns a stable, parameter-explicit interface for
later dynamics and matrix modules.

### Family proofs preserve the layer distinctions

The family theorem <code>scale</code> proves the three structure fields
independently. The finite theorem <code>jointHasLaw</code> applies Mathlib's
<code>iIndepFun.hasLaw_pi</code> directly to the family laws. The canonical
product constructor then proves:

1. each evaluation is measure preserving onto its marginal Gaussian law;
2. evaluations are independent under <code>Measure.pi</code>; and
3. evaluations are ordinarily measurable.

No proof relies on a name such as "obvious product variables." Every property
is a declaration that later modules can consume.

### Reproduce the check

From the repository root:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/GaussianPrimitives.lean
~~~

To build the whole formalization and the paired teaching site:

~~~sh
cd ..
make check
~~~

The file contains no <code>sorry</code> or <code>admit</code>. The
warnings-as-errors invocation also guards against declarations that compile
only with unresolved warnings.

## The normalization pass: turn primitive laws into a ledger

The real product layer is general. It accepts any mean function
\(m:I\to\mathbb R\) and variance function
\(v:I\to\mathbb R_{\ge0}\). That generality is exactly what later conventions
need. It does not itself say which convention to choose.

### First ledger: a future complex coordinate

To construct \(Z=X+iY\), record:

| Question | Required declaration |
|---|---|
| Center | \(\mathbb E[X]\) and \(\mathbb E[Y]\) |
| Component spread | \(\operatorname{Var}(X)\) and \(\operatorname{Var}(Y)\) |
| Dependence | the joint law, usually including whether \(X\) and \(Y\) are independent |
| Total squared magnitude | \(\mathbb E|Z-\mathbb E Z|^2\) |
| Pseudocovariance | \(\mathbb E[(Z-\mathbb E Z)^2]\), if relevant |
| Name | whether a scale parameter means component variance, total variance, or standard deviation |

For independent standard real Gaussians \(U,V\), compare

\[
Z_A=\frac{U+iV}{\sqrt{2}}
\qquad\text{and}\qquad
Z_B=U+iV.
\]

The first has component variances \(1/2,1/2\) and
\(\mathbb E|Z_A|^2=1\). The second has component variances \(1,1\) and
\(\mathbb E|Z_B|^2=2\). Both are valid constructions. The phrase "standard
complex Gaussian" does not tell us which scale was meant.

The {{< refterm "normalization-convention" "normalization convention" >}}
entry supplies the full symbolic ledger and visualization.

### Second ledger: a future Hermitian matrix law

A matrix adds dimension-dependent slots:

| Slot | What must be fixed |
|---|---|
| Dimension | index type, matrix size \(n\), and the \(n=0\) policy |
| Diagonal primitives | exact real means and variances |
| Off-diagonal primitives | exact real and imaginary means and variances |
| Independence | precisely which upper-triangular primitive coordinates are mutually independent |
| Hermitian reflection | how lower-triangular entries are obtained by conjugation |
| Density | exponent, coefficient, and reference volume if a density description is used |
| Spectral scale | the intended scale of eigenvalues |
| Trace | raw trace or \(n^{-1}\) normalized trace |
| Observables | every further dimension factor in moments or correlations |

An entrywise constructor, an ambient Hermitian-space density, and a symmetry
description may eventually define the same law. Formal equivalence between
them is a theorem, not a naming convention.

## The deliberate RMT-02 stop before complex coordinates

At the verified stopping point represented by this chapter, we had:

- exact real Gaussian laws, including zero variance;
- probability, mean, variance, finite-moment, scaling, and independent-sum
  consequences;
- ordinarily measurable mutually independent real Gaussian families;
- coordinatewise scaling closure;
- exact finite product joint laws;
- qualitative joint Gaussianity; and
- a canonical finite product sample space.

At that stopping point, we did not yet have:

- a project definition of a complex Gaussian random variable;
- an approved variance split between real and imaginary parts;
- an upper-triangular primitive-coordinate scheme for a Hermitian matrix;
- an approved dimension scaling;
- a named Gaussian matrix law;
- a proof that an entrywise and an ambient-space description agree;
- a nontrivial proof of unitary invariance;
- eigenvalue measurability;
- expected trace moments; or
- an asymptotic spectral theorem.

{{< panel "warning" >}}
**Historical boundary and current continuation.** The scalar and finite-product
probability foundations in this chapter are checked. The subsequent
<code>NonlinearDynamics.Random.ComplexGaussian</code> module now defines an
exact two-variance Cartesian complex law. It still does not choose a named
matrix normalization or prove a Gaussian unitary ensemble law.
{{< /panel >}}

This pause protects every later theorem. If the variance convention changes
after a matrix constructor is named, scaling constants propagate into entry
laws, density exponents, trace moments, and spectral limits. Choosing once,
recording it, and proving each bridge is cheaper than repairing an invisible
convention later.

## Common wrong turns

| Wrong turn | Why it fails | Correct layer |
|---|---|---|
| "The histogram looks Gaussian" | a finite sample is not an exact law | statistical evidence, not <code>HasLaw</code> |
| "Every coordinate is Gaussian, so the vector has product law" | marginals do not encode dependence | add <code>iIndepFun</code> |
| "Pairwise independent is enough" | higher-order constraints may remain | mutual independence |
| "HasLaw makes the function measurable" | it gives only almost-everywhere measurability | store or prove <code>Measurable</code> separately |
| "Variance zero means pointwise constant" | law-level equality ignores null-set changes | almost-everywhere equality |
| "Var equals zero, so variance is finite" | Mathlib's real variance is totalized | prove <code>MemLp X 2 P</code> or use <code>evariance</code> |
| "Standard complex Gaussian fixes the scale" | component and total variance conventions differ | normalization ledger |
| "Independent entries define a Hermitian matrix" | reflected entries cannot all be independent | choose primitive triangle, then reflect |
| "A named ensemble implies invariance" | a construction and a symmetry theorem are separate | prove equality of pushed-forward laws |

## Summit checklist

Before advancing this probability layer into a complex or matrix module, check:

- [ ] Every primitive real law is exact and parameterized by variance.
- [ ] Zero variance has a declared Dirac interpretation.
- [ ] Ordinary measurability and almost-everywhere measurability are not
      conflated.
- [ ] Mutual independence is stated at the family level.
- [ ] The finite joint law is identified as <code>Measure.pi</code>.
- [ ] Every scaling theorem visibly squares the scale in variance.
- [ ] Component and total complex variances are both recorded.
- [ ] Matrix diagonal and off-diagonal component variances are separate ledger
      entries.
- [ ] Dimension, trace, density, and zero-size conventions are fixed before a
      named ensemble appears.
- [ ] No symmetry, spectral, expectation, or asymptotic result is claimed
      before its own Lean theorem exists.

## Where to continue

For individual concepts, use the linked glossary:

- {{< refterm "gaussian-distribution" "Gaussian distribution" >}} for the
  scalar measure and degenerate branch;
- {{< refterm "variance" "variance" >}} for finite-moment and totalization
  details;
- {{< refterm "independence" "independence" >}} for event factorization and
  mutual families;
- {{< refterm "normalization-convention" "normalization convention" >}} for
  the complex and matrix ledgers;
- {{< refterm "cartesian-complex-gaussian-law" "Cartesian complex Gaussian law" >}}
  for the now-checked independent real-imaginary construction;
- {{< refterm "independent-cartesian-complex-gaussian-family" "Independent Cartesian complex Gaussian family" >}}
  for mutually independent indexed complex blocks and their exact joint law;
- {{< refterm "probability-law" "probability law" >}} for the sample-map versus
  measure distinction; and
- {{< refterm "random-matrix" "random matrix" >}} for the later matrix-valued
  carrier.

The earlier chapter
[Random Matrices: From Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}})
provides the matrix-measurability, Hermitian, law, and observable foundations
that the later finite GUE constructor consumes.

Continue directly to
[Complex Gaussian Coordinates and Geometry]({{< relref "/knowledge-base/deep-dives/complex-gaussian-coordinates-and-geometry" >}})
for the exact complex law, degeneracy map, second-order geometry, normalization
conversion, and twenty checked Lean declarations.

Then continue to
[Finite Product Probability Spaces and Independent Gaussian Fields]({{< relref "/knowledge-base/deep-dives/finite-product-probability-spaces-and-independent-gaussian-fields" >}})
for the finite complex product law, canonical sample space, real scaling, and
the empty-index boundary.

The resulting matrix constructor is now checked in
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}}),
which selects the Wigner ledger, joins the diagonal and upper blocks under one
product measure, and pushes that measure through Hermitian assembly.

## References

**National Institute of Standards and Technology.**
[Normal Distribution](https://www.itl.nist.gov/div898/handbook/eda/section3/eda3661.htm),
Engineering Statistics Handbook. This official reference gives the
positive-variance density and identifies its location and scale parameters.

**Mathlib contributors.**
[Gaussian distributions over the reals](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
Mathlib 4 documentation. This official API documents
<code>gaussianReal</code>, the zero-variance Dirac branch, mean, variance,
finite moments, transformations, convolution, and independent sums.

**Mathlib contributors.**
[Law of a random variable](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/HasLaw.html),
Mathlib 4 documentation. This documents the <code>AEMeasurable</code> and
pushforward fields of <code>HasLaw</code>, plus the finite joint-law bridge.

**Mathlib contributors.**
[Independence of functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Independence/Basic.html),
Mathlib 4 documentation. This is the official reference for
<code>IndepFun</code>, <code>iIndepFun</code>, coordinatewise composition, and
finite product laws.

**Mathlib contributors.**
[Finite product measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Constructions/Pi.html),
Mathlib 4 documentation. This documents <code>Measure.pi</code>, its
probability instance, and factorization on measurable rectangles.

**Mathlib contributors.**
[Gaussian laws and independence](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/HasGaussianLaw/Independence.html),
Mathlib 4 documentation. This official source supports the qualitative joint
Gaussian theorem used after exact product laws.

**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems. I](https://doi.org/10.1063/1.1703773),
*Journal of Mathematical Physics* 3 (1962), 140-156. This primary historical
source motivates symmetry-based matrix ensembles. It is not used to infer or
approve this project's future normalization.

The exact upstream source audited for this chapter is Mathlib commit
[`81a5d257`](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision recorded in <code>formalization/lake-manifest.json</code>.
