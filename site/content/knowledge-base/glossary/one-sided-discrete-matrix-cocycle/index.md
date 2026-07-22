---
title: "One-sided discrete matrix cocycle"
slug: "one-sided-discrete-matrix-cocycle"
summary: "A one-sided discrete matrix cocycle multiplies one matrix generator along forward iterates of a base map and splits every finite history into a shifted later block acting after an earlier block."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.Discrete"
og_image: "one-sided-discrete-matrix-cocycle-card.png"
og_image_alt: "One matrix generator is sampled along successive forward base states, accumulated with the newest factor on the left, and split into an earlier block followed by a shifted later block."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

A **one-sided discrete matrix cocycle** records how a matrix update accumulates
while an underlying environment advances in whole forward steps. It combines
three objects:

1. a space \(\Omega\) of environments or base states;
2. a self-map \(T:\Omega\to\Omega\) that advances the base by one step; and
3. a matrix generator \(A:\Omega\to M_\iota(\mathbb K)\) that chooses the
   one-step matrix at the current base state.

Here \(M_\iota(\mathbb K)\) is the space of square matrices over a scalar type
\(\mathbb K\), with rows and columns indexed by a finite type \(\iota\). At an
initial state \(\omega\), the base orbit is

\[
\omega,\quad T\omega,\quad T^2\omega,\quad\ldots.
\]

Sampling the generator along this orbit gives

\[
A(\omega),\quad A(T\omega),\quad A(T^2\omega),\quad\ldots.
\]

The finite cocycle value at horizon \(k\) is the
{{< refterm "forward-matrix-product" "forward matrix product" >}}

\[
\Phi(k,\omega)
{} =
A(T^{k-1}\omega)\cdots A(T\omega)A(\omega)
\]

when \(k\) is positive, with \(\Phi(0,\omega)=I\). The earliest matrix acts
first on a column vector and is written furthest to the right. The newest
matrix acts last and is written on the left.

The word **discrete** means time is indexed by natural-number steps. The word
**one-sided** means only times \(0,1,2,\ldots\) are present. No inverse base map
or negative-time value is part of the definition.

{{< reference-figure
  src="one-sided-discrete-matrix-cocycle.svg"
  alt="A starting environment advances through successive forward base states. The same matrix generator is evaluated at every visited state. Those matrices accumulate in chronological action order, with the newest factor on the left. Splitting the orbit makes the later block restart from the shifted environment and act after the earlier block."
  caption="**Finding:** one generator becomes a time-indexed matrix sequence by following the forward base orbit. A finite cocycle value multiplies those sampled matrices in chronological action order. When a history is split, the later block begins at the shifted environment and is written on the left because it acts second. The figure supplies no probability, invertibility, or long-time conclusion."
>}}

## Function iteration supplies the base orbit

Lean writes the \(j\)-fold iterate of \(T\) as <code>T^[j]</code>. The
underlying <code>Function.iterate</code> convention begins with

\[
T^0=\operatorname{id},
\qquad
T^{j+1}=T\circ T^j.
\]

Thus \(T^0\omega=\omega\), \(T^1\omega=T\omega\), and the generator observed at
time \(j\) is

\[
A(T^j\omega).
\]

The project names the resulting time-indexed family
<code>orbitMatrixSequence T A</code>. That definition is only function
composition. It does not need finite matrix indices, scalar algebra,
measurability, or a measure.

The cocycle product does need matrix multiplication. Its algebraic theorems
assume a finite matrix index type with decidable equality and a scalar
semiring. A semiring provides the finite addition and multiplication used by
matrix products.

## Zero, one, and successor horizons

The defining cases are

\[
\begin{aligned}
\Phi(0,\omega)&=I,\\
\Phi(1,\omega)&=A(\omega),\\
\Phi(k+1,\omega)&=A(T^k\omega)\Phi(k,\omega).
\end{aligned}
\]

The successor equation says that the matrix sampled at the newest base state
is multiplied on the left. Expanding gives

\[
\begin{aligned}
\Phi(2,\omega)&=A(T\omega)A(\omega),\\
\Phi(3,\omega)&=A(T^2\omega)A(T\omega)A(\omega).
\end{aligned}
\]

This order matters because matrices generally do not commute. Reversing the
factors would encode a different action convention.

## The cocycle law is a shifted split

Choose an early block of \(m\) steps and a later block of \(k\) steps. The
one-sided cocycle identity is

\[
\Phi(m+k,\omega)
{} =
\Phi(k,T^m\omega)\Phi(m,\omega).
\]

The early block \(\Phi(m,\omega)\) begins at \(\omega\) and acts first, so it
is on the right. The later block begins at the shifted state \(T^m\omega\) and
acts second, so it is on the left.

This is more than the unshifted finite-product split. It says how elapsed base
time changes the environment from which the second block must be generated.
Forgetting the shift would restart the later block at the wrong state.

## Generator-presented rather than axiom-presented

An abstract cocycle interface could store a two-argument function
\(\Phi(k,\omega)\) and require the identity and cocycle laws as fields. This
project takes a **generator-presented** route:

- store only the base map \(T\) and one-step generator \(A\);
- define every finite value by sampling \(A\) along iterates of \(T\); and
- prove the cocycle law from the ordered-product recursion.

The value at one step recovers the generator:

\[
\Phi(1,\omega)=A(\omega).
\]

For natural-number time, the complete finite family is therefore generated
from its one-step data. The checked structure does not ask users to supply a
separate cocycle-law proof.

## Measure-preserving base

The bundled Lean object also fixes a measure \(\mu\) on \(\Omega\) and requires
the base map to be **measure preserving**:

\[
T_*\mu=\mu.
\]

This condition has two components in Mathlib:

1. \(T\) is measurable; and
2. pushing \(\mu\) forward through \(T\) returns \(\mu\).

Every natural iterate preserves the same measure:

\[
(T^k)_*\mu=\mu.
\]

Measure preservation does not say that \(\mu\) has total mass one. The checked
bundle accepts an arbitrary measure, including the zero measure or an infinite
measure. It also does not imply that \(T\) is ergodic, mixing, injective,
surjective, or invertible.

## Measurability of finite values

For the measurable layer, the matrices are complex and \(\Omega\) has a
measurable-space structure. If \(T\) and \(A\) are measurable, then each orbit
factor

\[
\omega\longmapsto A(T^j\omega)
\]

is measurable by composition. A finite product of those factors is measurable
by the result developed in
{{< refterm "finite-random-matrix-product" "finite random-matrix product" >}}.

The bundled <code>DiscreteMatrixCocycle μ</code> stores
<code>MeasurePreserving base μ μ</code>, which already contains ordinary
measurability of the base, plus a separate ordinary-measurability proof for
the generator. It follows that every <code>value k</code> is measurable.

The module does not form a {{< refterm "probability-law" "probability law" >}}
of that value. It also does not assume that \(\mu\) is a probability measure.

## A three-state cycle

Let \(\Omega=\{r,g,b\}\), and let \(T\) cycle the states:

\[
r\longmapsto g,\qquad
g\longmapsto b,\qquad
b\longmapsto r.
\]

Give the three states equal mass, so \(T\) preserves that probability measure.
Use one-by-one matrices

\[
A(r)=[2],\qquad A(g)=[3],\qquad A(b)=[5].
\]

Starting at \(r\),

\[
\begin{aligned}
\Phi(1,r)&=[2],\\
\Phi(2,r)&=[3][2]=[6],\\
\Phi(3,r)&=[5][3][2]=[30],\\
\Phi(4,r)&=[2][5][3][2]=[60].
\end{aligned}
\]

Split four steps after \(m=2\). The base has moved to \(T^2r=b\). The later
two-step value is

\[
\Phi(2,b)=[2][5]=[10],
\]

so the cocycle law gives

\[
\Phi(4,r)=\Phi(2,b)\Phi(2,r)=[10][6]=[60].
\]

This scalar-matrix example checks the orbit indices and shifted start. It does
not demonstrate noncommutativity, and its equal masses are an illustrative
choice rather than a requirement of the Lean structure.

## Empty matrix dimension remains supported

The matrix coordinate type \(\iota\) may be empty. There is then exactly one
square matrix, which is the identity, so every cocycle value is that unique
matrix. The orbit sequence, measurability proofs, cocycle law, and
measure-preserving base remain meaningful.

No positive-dimension assumption is needed because this module defines no
matrix norm or identity-norm normalization.

## The checked Lean shape

The generator-presented bundle is:

~~~lean
structure DiscreteMatrixCocycle (μ : Measure Ω) where
  base : Ω → Ω
  generator : RandomMatrix Ω ι ι ℂ
  base_preserving : MeasurePreserving base μ μ
  measurable_generator : Measurable generator
~~~

Its value and cocycle law are:

~~~lean
def DiscreteMatrixCocycle.value
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    RandomMatrix Ω ι ι ℂ

theorem DiscreteMatrixCocycle.value_add
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (m k : ℕ) (ω : Ω) :
    C.value (m + k) ω =
      C.value k (C.base^[m] ω) * C.value m ω
~~~

The literal comparison and iteration syntax belongs inside Lean code. The
mathematical displays use site-safe TeX commands.

## What the definition does not supply

This finite one-sided cocycle interface does not provide:

- probability normalization of \(\mu\);
- ergodicity or mixing of the base;
- an independent-and-identically-distributed factor model;
- invertibility of the base, generator matrices, or cocycle values;
- negative-time values;
- invariance of a combined base-and-vector skew product;
- factorization of any product law;
- matrix norms, norm measurability, or logarithmic integrability;
- Lyapunov exponents, Oseledets splittings, or other asymptotic limits;
- a connection to derivative matrices or Jacobians of a nonlinear system.

Each item needs additional definitions and hypotheses. The checked object stops
at finite algebra, measurability, measure preservation of the base, and the
one-sided cocycle identity.

## Where to continue

[The Forward-and-Inverse Tail Sandwich for Finite-Time Real Log Norms]({{< relref "/knowledge-base/deep-dives/forward-and-inverse-tail-sandwich-for-finite-time-real-log-norms" >}})
adds pointwise unit generators. Those units propagate along the forward orbit,
but they do not make the base map invertible and do not create negative-time
cocycle values. Matrix inversion reverses product order, so a same-order
product of inverse generators is not the inverse of the newest-factor-left
forward value. RMT-34 therefore uses inverse norms only as finite-time lower
majorants and does not advertise a same-base inverse cocycle.

[Finite-Time Norm and Extended-Log-Norm Observables for Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/finite-time-norm-and-extended-log-norm-cocycle-observables" >}})
is the immediate analytic successor. It applies the maximum absolute row-sum
norm to each finite cocycle value, proves entrywise measurability, and uses a
zero-aware extended logarithm to derive finite-time subadditivity. The compact
{{< refterm "extended-log-norm-observable" "extended log-norm observable" >}}
entry explains its bottom-at-zero policy.

[Generator-Presented One-Sided Discrete Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/generator-presented-one-sided-discrete-matrix-cocycles" >}})
derives all sixteen public declarations and separates every assumption layer.

The {{< refterm "forward-matrix-product" "forward matrix product" >}} entry
fixes chronological order. The
{{< refterm "finite-random-matrix-product" "finite random-matrix product" >}}
entry adds pointwise measurability and pushforward laws for arbitrary
time-indexed factors. The present cocycle specializes those factors to repeated
observations of one generator along a base orbit.

## References

<a id="ref-one-sided-cocycle-iterate"></a>**Mathlib contributors.**
[Function iteration](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Logic/Function/Iterate.html),
Mathlib 4 documentation. This official source defines
<code>Function.iterate</code> and its zero, successor, and addition laws.

<a id="ref-one-sided-cocycle-preserving"></a>**Mathlib contributors.**
[Measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/MeasurePreserving.html),
Mathlib 4 documentation. This official source defines
<code>MeasurePreserving</code> as measurability plus pushforward equality and
proves preservation by every natural-number iterate.

<a id="ref-one-sided-cocycle-arnold"></a>**Ludwig Arnold.**
[Random Dynamical Systems](https://doi.org/10.1007/978-3-662-12878-7),
Springer Monographs in Mathematics, 1998. This develops cocycles over metric
dynamical systems and their later ergodic theory. The probability, invertible
base-flow, and asymptotic structures used there are not inferred here.

<a id="ref-one-sided-cocycle-oseledets"></a>**V. I. Oseledets.**
[A multiplicative ergodic theorem. Characteristic Ljapunov exponents of dynamical systems](https://www.mathnet.ru/eng/mmo214),
*Transactions of the Moscow Mathematical Society* 19 (1968), 197-231. This
primary source supplies the historical long-time destination. The finite
cocycle interface proves none of its integrability, limit, exponent, or
splitting conclusions.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
