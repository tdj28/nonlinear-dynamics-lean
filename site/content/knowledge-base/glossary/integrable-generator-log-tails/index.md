---
title: "Integrable generator log tails"
slug: "integrable-generator-log-tails"
summary: "Integrable generator log tails combine pointwise matrix invertibility with separate integrable budgets for one-step expansion and contraction, placing every finite signed log norm between two integrable bounds."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.RealLogNormIntegrability"
lean_snapshot: "/lean/NonlinearDynamics/Random/RandomCocycles/RealLogNormIntegrability.lean"
lean_source_sha256: "ac950f8728e5fd003cff3b7a5d0750e5c36060730b3ebadc5b0e1165b54e72ea"
og_image: "integrable-generator-log-tails-card.png"
og_image_alt: "Three labeled gates for pointwise units, the forward expansion tail, and the inverse contraction tail feed a finite-time sandwich with the signed real log norm between an integrable lower and upper bound."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

**Integrable generator log tails** are a three-part hypothesis for a
one-sided matrix cocycle. Every one-step generator matrix must be a unit, its
forward log-positive norm must be integrable, and the log-positive norm of its
inverse must also be integrable. Together these assumptions control both
large expansion and deep contraction without claiming a Lyapunov spectrum or
an invertible two-sided dynamical system.

The Random Matrix Theory milestone RMT-34 records the package in Lean as
follows:

~~~lean
structure HasIntegrableGeneratorLogTails
    (C : DiscreteMatrixCocycle (ι := ι) μ) : Prop where
  isPointwiseInvertible : C.IsPointwiseInvertible
  hasIntegrableGeneratorLogPlus : C.HasIntegrableGeneratorLogPlus
  integrable_inverseGeneratorLogPlus :
    Integrable C.inverseGeneratorLogPlusNormObservable μ
~~~

This is a proposition-valued proof package. It does not add data to the
cocycle, change the base measure, or manufacture inverse-time dynamics.

{{< reference-figure
  src="integrable-generator-log-tails.svg"
  alt="Pointwise matrix units, an integrable forward expansion tail, and an integrable inverse contraction tail enter as three separate gates. The algebraic gate validates a lower contraction bound, while the two analytic gates make the lower and upper finite-time bounds integrable. The signed real log norm lies between them."
  caption="**Finding:** signed finite-time cocycle growth needs three different controls. Pointwise units keep the inverse lower bound honest, the forward log-positive tail controls expansion, and the inverse log-positive tail controls contraction. Their combination makes every finite-horizon signed real log norm integrable. The plate is a finite-time assumption map. It does not assert independence, ergodicity, asymptotic convergence, a Lyapunov spectrum, or an invariant splitting."
>}}

## Setup and notation

Let \((\Omega,\mathcal F,\mu)\) be a measure space. Here \(\Omega\) is the
space of base states, \(\mathcal F\) is its collection of measurable events,
and \(\mu\) is the measure. Let \(T:\Omega\to\Omega\) be a measurable,
measure-preserving map. Let

\[
A:\Omega\longrightarrow \operatorname{Mat}_{\iota\times\iota}(\mathbb C)
\]

be a measurable generator, where \(\iota\) is a finite coordinate type and
\(\mathbb C\) is the complex field. The associated
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycle" >}}
uses the later-factor-left convention

\[
C(k,\omega)
{} =
A(T^{k-1}\omega)\cdots A(T\omega)A(\omega)
\]

for positive \(k\), while \(C(0,\omega)\) is the identity matrix. The norm
\(\lVert\cdot\rVert_\infty\) is the project's
{{< refterm "induced-infinity-operator-norm" "maximum absolute row-sum operator norm" >}}.

For a nonnegative real number \(x\), define its log-positive part by

\[
\log^+x=\max(0,\log x).
\]

Mathlib makes the real logarithm total by setting \(\log 0=0\). Therefore
\(\log^+0=0\) as well. This convention is useful for total functions, but it
means that singular behavior must be interpreted carefully.

Three one-step quantities organize the package:

\[
\begin{aligned}
F(\omega)
&= \log^+\lVert A(\omega)\rVert_\infty,\\
I(\omega)
&= \log^+\lVert A(\omega)^{-1}\rVert_\infty,\\
R_k(\omega)
&= \log\lVert C(k,\omega)\rVert_\infty.
\end{aligned}
\]

The function \(F\) is the forward expansion tail, \(I\) is the inverse
contraction tail, and \(R_k\) is the signed real log norm at horizon \(k\).
The inverse notation in \(I\) refers to Mathlib's total nonsingular matrix
inverse. It is the genuine inverse at units and the zero matrix at singular
matrices.

## The three fields answer different questions

| Lean field | Mathematical content | What it controls | What it does not control |
|---|---|---|---|
| <code>isPointwiseInvertible</code> | Every \(A(\omega)\) is a matrix unit | Unit finite products and, after a nonempty/empty split, an honest inverse lower bound | Any moment, probability law, or almost-everywhere relaxation |
| <code>hasIntegrableGeneratorLogPlus</code> | \(F\) is integrable | One-step expansion and every finite forward log-positive envelope | Contraction, singular collapse, or a signed logarithm |
| <code>integrable_inverseGeneratorLogPlus</code> | \(I\) is integrable | One-step contraction and every finite inverse orbit sum | Expansion, an inverse cocycle, or the smallest Lyapunov exponent |

For real-valued functions, **integrable** means measurable with finite
integral of the absolute value. This is the ordinary \(L^1(\mu)\) condition.
The two analytic fields are deliberately separate because one-sided growth
and one-sided contraction can have completely different tails.

### Field one: pointwise units

The project defines

~~~lean
def IsPointwiseInvertible
    (C : DiscreteMatrixCocycle (ι := ι) μ) : Prop :=
  ∀ ω, IsUnit (C.generator ω)
~~~

A matrix is a **unit** when it has a multiplicative inverse in the matrix
ring. For a finite complex square matrix this is equivalent to its determinant
being nonzero. The quantifier is pointwise: every base state must pass. It is
stronger than saying that the generator is invertible almost everywhere.

Pointwise units propagate to finite products. Since a product of units is a
unit, \(C(k,\omega)\) is invertible at every horizon and every base state. In
positive matrix dimension its norm is then strictly positive, so the ordinary
real logarithm obeys the expected product rule. This yields shifted
subadditivity:

\[
R_{m+k}(\omega)
\leq
R_k(T^m\omega)+R_m(\omega).
\]

The theorem is dimension-uniform because the implementation handles the empty
coordinate type separately. The positive-norm argument itself is used only in
the nonempty branch.

### Field two: the forward expansion tail

The existing condition <code>HasIntegrableGeneratorLogPlus</code> is exactly

~~~lean
Integrable (C.logPlusNormObservable 1) μ
~~~

and the one-step cocycle value is the generator. Thus it asks for
\(F\in L^1(\mu)\). Since \(\log^+x=0\) for \(0\leq x\leq1\), this field sees
expansion above norm one and erases every contraction below norm one.

Measure preservation transports the same integrability through each base
iterate. Norm submultiplicativity and the log-positive product inequality give

\[
\log^+\lVert C(k,\omega)\rVert_\infty
\leq
\sum_{j=0}^{k-1}F(T^j\omega).
\]

The right side is a finite sum of integrable functions, so every finite-time
forward log-positive observable is integrable. No probability or ergodicity
hypothesis is needed for this finite-horizon propagation.

### Field three: the inverse contraction tail

The inverse field asks for \(I\in L^1(\mu)\). When \(A(\omega)\) is a unit,
a large inverse norm means that the forward matrix has a strongly contracted
direction. In one dimension, if \(A=[a]\) with \(a\neq0\), then

\[
F=\max(0,\log|a|),
\qquad
I=\max(0,-\log|a|).
\]

The two functions are the positive and negative tails of the signed scalar
logarithm. In higher dimension, the interpretation is less symmetric. The
forward operator norm records the largest expansion budget, while the inverse
operator norm records the strongest contraction budget. The inverse tail is
not generally the negative of the forward top log norm.

The total inverse-generator observable is measurable even without
invertibility. RMT-34 proves this through the determinant-adjugate formula,
entrywise measurability, and measurability of the selected matrix norm. The
pointwise-unit field is needed for meaning and lower bounds, not for the bare
measurability statement.

## The finite-time sandwich

Define the inverse orbit sum

\[
S_k^-(\omega)
{} =
\sum_{j=0}^{k-1}I(T^j\omega)
\]

and the forward finite-time envelope

\[
P_k(\omega)
{} =
\log^+\lVert C(k,\omega)\rVert_\infty.
\]

Under the three fields, RMT-34 proves the pointwise sandwich

\[
-S_k^-(\omega)
\leq
R_k(\omega)
\leq
P_k(\omega).
\]

The upper bound is immediate from \(\log x\leq\log^+x\). The lower bound has
two steps.

First introduce the finite inverse-value envelope

\[
J_k(\omega)
{} =
\log^+\lVert C(k,\omega)^{-1}\rVert_\infty.
\]

Total matrix inversion, norm submultiplicativity, and the log-positive product
bound prove unconditionally that

\[
J_k(\omega)\leq S_k^-(\omega).
\]

Second, when \(\iota\) is nonempty, pointwise units make the finite product a
nonzero unit and give

\[
1
\leq
\lVert C(k,\omega)^{-1}\rVert_\infty
\lVert C(k,\omega)\rVert_\infty.
\]

In empty dimension that norm-product inequality is false: the unique matrix is
both identity and zero, and its selected norm is zero. Lean therefore proves
the public lower rail by a type-level split. It uses the displayed inequality
only in the nonempty branch; in the empty branch both \(S_k^-\) and \(R_k\)
are identically zero.

Taking logarithms and replacing the inverse logarithm by its log-positive
majorant yields

\[
-J_k(\omega)\leq R_k(\omega).
\]

Negating \(J_k\leq S_k^-\) reverses its order, so
\(-S_k^-\leq-J_k\leq R_k\).

Both outer functions are integrable. The lower function is the negative of a
finite sum of transported copies of \(I\), and the upper function \(P_k\) is
integrable by the forward field. Since \(R_k\) is measurable, Mathlib's
<code>integrable_of_le_of_le</code> theorem concludes that \(R_k\) is
integrable for every finite \(k\).

The checked Lean endpoints are:

~~~lean
hC.isPointwiseInvertible.neg_inverseOrbitLogPlusSum_le_realLogNormObservable
C.realLogNormObservable_le_logPlusNormObservable
hC.integrable_realLogNormObservable
hC.isIntegrableSubadditiveProcessCandidate
~~~

The final line packages finite-horizon integrability and shifted
subadditivity. The word <code>Candidate</code> is intentional: this is the
input shape for a later subadditive theorem, not the theorem's asymptotic
conclusion.

## Total functions have sharp boundary semantics

### Empty matrix dimension

If the coordinate type \(\iota\) is empty, there is exactly one square matrix.
That matrix is simultaneously zero and identity, so it is a unit even though
its maximum row-sum norm is zero. Consequently every empty-dimensional
cocycle has

\[
R_k=0,
\qquad
P_k=0,
\qquad
S_k^-=0.
\]

All three fields hold automatically, and the sandwich reduces to
\(0\leq0\leq0\). This is consistent with Mathlib's total real logarithm,
which has \(\log0=0\).

The
{{< refterm "extended-log-norm-observable" "extended log-norm observable" >}}
behaves differently: it sends norm zero to the bottom extended-real value.
Therefore the bridge from an invertible extended log norm to the real log norm
requires <code>Nonempty ι</code>. Pointwise unit status alone cannot provide a
positive norm in empty dimension.

### Singular matrices in positive dimension

On a singular matrix, Mathlib's total nonsingular inverse is the zero matrix.
Its norm and inverse log-positive envelope are therefore zero. This makes
\(I\) a total measurable function, but zero does not quantify the severity of
singular collapse.

For example, let

\[
A=
\begin{bmatrix}
\tfrac12&0\\
0&0
\end{bmatrix}.
\]

Then \(\lVert A\rVert_\infty=1/2\), so
\(R_1=\log(1/2)=-\log2\). The total inverse is zero, so \(I=0\). The desired
lower inequality would read \(0\leq-\log2\), which is false. The
pointwise-unit field rules out exactly this misuse.

Singularity also exposes the danger in ordinary real-log subadditivity. Take

\[
A=
\begin{bmatrix}
\tfrac12&0\\
0&0
\end{bmatrix},
\qquad
B=
\begin{bmatrix}
0&0\\
0&\tfrac12
\end{bmatrix}.
\]

Both norms are \(1/2\), but \(AB=0\). Mathlib's convention gives
\(\log\lVert AB\rVert_\infty=\log0=0\), while
\(\log\lVert A\rVert_\infty+\log\lVert B\rVert_\infty=-2\log2\lt0\).
Thus the expected real-log subadditive inequality genuinely fails without a
nonvanishing interface.

## Inversion reverses product order

The cocycle product is newest factor on the left:

\[
C(k,\omega)
{} =
A(T^{k-1}\omega)\cdots A(\omega).
\]

Matrix inversion reverses that order:

\[
C(k,\omega)^{-1}
{} =
A(\omega)^{-1}\cdots A(T^{k-1}\omega)^{-1}.
\]

RMT-34 uses Mathlib's unconditional theorem
<code>Matrix.mul_inv_rev</code>. The scalar orbit-sum bound is unaffected by
order because real addition commutes. A matrix-valued product of inverse
generators is different: placing the inverse generators in the original
newest-factor-left convention generally gives the wrong matrix for
\(C(k,\omega)^{-1}\).

The module therefore does not advertise a same-base inverse cocycle. Building
honest negative-time dynamics would require additional structure, such as an
invertible base map and an explicitly checked convention.

## A probability counterexample with a genuine negative tail

RMT-34 contains a compiled counterexample showing that the forward analytic
field does not imply the inverse field, even when the base is a probability
space and every generator is a unit.

Take \(\Omega=\mathbb N\). Give \(n\in\mathbb N\) the geometric probability

\[
\mu(\{n\})=2^{-n-1}.
\]

This is Mathlib's <code>geometricMeasure</code> with success parameter
\(p=1/2\). Let the base map be the identity, \(T(n)=n\), and use the
one-dimensional generator

\[
A(n)=
\begin{bmatrix}
\exp(-2^n)
\end{bmatrix}.
\]

Every entry is positive, so every generator is a unit. Its norm is below one,
which makes the forward tail vanish:

\[
F(n)=\log^+\exp(-2^n)=0.
\]

Thus \(F\) is integrable. The inverse has norm \(\exp(2^n)\), so

\[
I(n)=2^n,
\qquad
R_1(n)=-2^n.
\]

The absolute inverse and signed-log contributions are both

\[
\mu(\{n\})\,2^n
{} =
2^{-n-1}2^n
{} =
\frac12.
\]

Therefore

\[
\sum_{n=0}^{\infty}\mu(\{n\})I(n)
{} =
\sum_{n=0}^{\infty}\frac12
{} =
+\infty,
\]

and the same calculation shows that \(R_1\) is not integrable. The table
makes the cancellation visible:

| \(n\) | probability \(2^{-n-1}\) | inverse tail \(2^n\) | weighted absolute contribution |
|---:|---:|---:|---:|
| \(0\) | \(1/2\) | \(1\) | \(1/2\) |
| \(1\) | \(1/4\) | \(2\) | \(1/2\) |
| \(2\) | \(1/8\) | \(4\) | \(1/2\) |
| \(3\) | \(1/16\) | \(8\) | \(1/2\) |
| general \(n\) | \(2^{-n-1}\) | \(2^n\) | \(1/2\) |

The example is probability-based, but its time sequence is not an independent
and identically distributed (i.i.d.) process, and the base is not ergodic.

- Its time marginals are identically distributed, but the samples are not
  independent. A base state \(n\) is sampled once, and the identity base keeps
  returning the same generator \(A(n)\). The matrices along one orbit are
  perfectly dependent.
- It is not ergodic. Every subset of \(\mathbb N\) is invariant under the
  identity map. In particular, the invariant event \(\{0\}\) has probability
  \(1/2\), neither zero nor one.

The construction proves a logical separation between tail fields. It is not a
model of repeated independent matrix sampling, and it does not invoke an
ergodic theorem.

There is a simpler infinite-volume boundary probe in the same Lean module. On
Lebesgue measure over the real line, the constant contraction \(1/2\) has a
zero forward tail and a positive constant inverse tail. The latter is not
integrable because the space has infinite measure. That example explains why
constant functions separate the fields on infinite measure. The geometric
example is stronger because it performs the separation on a probability
space, where every finite constant would be integrable.

## The positive-rate shortcut is orthogonal

RMT-34 also proves a different endpoint. Assume a probability base, the
pre-ergodic invariant-set condition used by the preceding log-positive
theorem, and only the forward field. If the integrated
{{< refterm "integrated-log-positive-growth-rate" "log-positive growth rate" >}}
is strictly positive, then for almost every base state the normalized
log-positive observable is eventually positive. At those large horizons,

\[
\log^+\lVert C(k,\omega)\rVert_\infty
{} =
\log\lVert C(k,\omega)\rVert_\infty.
\]

The already-proved almost-everywhere log-positive convergence therefore
transfers to the normalized signed real log. This shortcut needs neither
pointwise invertibility nor inverse-tail integrability.

Strict positivity is the boundary. The integrated log-positive rate is always
nonnegative, so zero is its only nonpositive case, and eventual agreement need
not follow there. A negative signed growth rate is a different object; it is
not a possible value of this clipped rate. In empty matrix dimension the
log-positive rate is necessarily zero, so the strict-positive premise is
impossible. In positive dimension, singular finite-time values remain allowed.
Eventual positivity forces only their selected norm above one, which is enough
for the real and log-positive scalar logarithms to agree; it does not make the
matrices invertible.

The shortcut supplies almost-everywhere convergence in the positive-rate
case. It does not supply finite-horizon signed integrability from the tail
package, \(L^1\) convergence, an endpoint at zero clipped rate, or a theorem
about negative signed rates.

## Reading and checking the Lean

The relevant project source is
<code>NonlinearDynamics/Random/RandomCocycles/RealLogNormIntegrability.lean</code>.
From the repository root, compile it with the pinned Lean toolchain:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/RealLogNormIntegrability.lean
~~~

Useful declarations, in proof order, are:

| Declaration | Role |
|---|---|
| <code>IsPointwiseInvertible.value_isUnit</code> | Propagates units to every finite cocycle product |
| <code>measurable_inverseGeneratorLogPlusNormObservable</code> | Makes the total inverse tail measurable without unit assumptions |
| <code>inverseValueLogPlusNormObservable_le_inverseOrbitLogPlusSum</code> | Bounds a finite inverse norm by the one-step inverse orbit sum |
| <code>IsPointwiseInvertible.neg_inverseOrbitLogPlusSum_le_realLogNormObservable</code> | Supplies the honest lower side of the sandwich |
| <code>realLogNormObservable_le_logPlusNormObservable</code> | Supplies the unconditional upper side |
| <code>HasIntegrableGeneratorLogTails.integrable_realLogNormObservable</code> | Uses the two integrable bounds to prove finite-horizon signed integrability |
| <code>HasIntegrableGeneratorLogTails.isIntegrableSubadditiveProcessCandidate</code> | Packages integrability and shifted subadditivity |
| <code>HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedRealLogNormObservable_of_pos</code> | Transfers positive-rate log-positive convergence to the real log |

The geometric counterexample is also compiled in the module. Its helper
definitions and proofs are private, so they test the boundary without
expanding the public namespace.

## What the package does not prove

The name is intentionally narrower than a multiplicative ergodic theorem. The
three fields and their current consequences do not establish:

- a general signed version of Kingman's subadditive ergodic theorem;
- almost-everywhere convergence at zero or negative top growth rate;
- \(L^1\) convergence or uniform integrability of normalized observables;
- interchange of a limit and an integral;
- equality between inverse growth and the negative top exponent;
- a smallest Lyapunov exponent, a full Lyapunov spectrum, or multiplicities;
- singular-value limits or exterior-power asymptotics;
- measurable invariant subspaces or an Oseledets splitting;
- a same-base inverse cocycle or negative-time cocycle values;
- an invertible base transformation;
- probability normalization, ergodicity, mixing, or i.i.d. sampling;
- an almost-everywhere replacement for pointwise generator units;
- necessity or minimality of the three-field package;
- meaningful inverse-tail information on singular matrices without the unit
  field; or
- identification of the matrix generator with a derivative or Jacobian of a
  nonlinear system.

Furstenberg and Kesten's random-product theorem, Kingman's subadditive theorem,
and Oseledets' multiplicative ergodic theorem are important destinations and
comparators. RMT-34 proves only the finite-time signed interface and the
separate positive-rate shortcut stated above.

## Sixteen worked mini-exercises

Each exercise uses the maximum row-sum matrix norm and Mathlib's conventions
\(\log0=0\) and singular matrix inverse equal to zero.

1. **A scalar contraction.** Let \(A=[1/4]\). Compute all three one-step
   observables and check the sandwich.

   **Solution.** The matrix norm is \(1/4\), so
   \(F=\log^+(1/4)=0\). Its inverse is \([4]\), so \(I=\log4\). The signed
   value is \(R_1=\log(1/4)=-\log4\). At one step the sandwich is
   \(-\log4\leq-\log4\leq0\). The lower bound is exact.

2. **A scalar expansion.** Let \(A=[3]\). Repeat the calculation.

   **Solution.** Now \(F=\log3\), \(A^{-1}=[1/3]\), and \(I=0\). The signed
   value is \(R_1=\log3\). Hence \(0\leq\log3\leq\log3\). The upper bound is
   exact.

3. **A neutral complex unit.** Let \(A=[-1]\). What do the tails see?

   **Solution.** Both \(A\) and \(A^{-1}\) have norm one. Therefore
   \(F=I=R_1=0\). Unit status is algebraic and does not imply positive or
   negative growth.

4. **A two-step scalar orbit.** At a chosen base state suppose
   \(A(\omega)=[1/2]\) and \(A(T\omega)=[4]\). Compute the horizon-two
   sandwich.

   **Solution.** The later factor is on the left, so
   \(C(2,\omega)=[4][1/2]=[2]\). Thus \(R_2=P_2=\log2\). The inverse tails
   are \(\log2\) at \(\omega\) and zero at \(T\omega\), so
   \(S_2^-=\log2\). The sandwich reads
   \(-\log2\leq\log2\leq\log2\).

5. **The inverse norm sees the strongest contraction.** Take

   \[
   A=
   \begin{bmatrix}
   \tfrac12&0\\
   0&\tfrac14
   \end{bmatrix}.
   \]

   **Solution.** The maximum row-sum norm is \(1/2\), so
   \(R_1=-\log2\) and \(F=0\). The inverse is
   \(\operatorname{diag}(2,4)\), whose norm is \(4\), so \(I=\log4\). The
   lower inequality is strict:
   \(-\log4\lt-\log2=R_1\). The inverse tail reflects the \(1/4\) direction,
   not merely the negative of the top forward log norm.

6. **Reverse a noncommuting product.** Let

   \[
   A=
   \begin{bmatrix}1&1\\0&1\end{bmatrix},
   \qquad
   B=
   \begin{bmatrix}1&0\\1&1\end{bmatrix}.
   \]

   Compute \((AB)^{-1}\), \(B^{-1}A^{-1}\), and \(A^{-1}B^{-1}\).

   **Solution.** Direct inversion gives

   \[
   A^{-1}=
   \begin{bmatrix}1&-1\\0&1\end{bmatrix},
   \qquad
   B^{-1}=
   \begin{bmatrix}1&0\\-1&1\end{bmatrix}.
   \]

   Since \(AB=\begin{bmatrix}2&1\\1&1\end{bmatrix}\),

   \[
   (AB)^{-1}
   =B^{-1}A^{-1}
   =\begin{bmatrix}1&-1\\-1&2\end{bmatrix}.
   \]

   In the wrong order,
   \(A^{-1}B^{-1}=\begin{bmatrix}2&-1\\-1&1\end{bmatrix}\), a different
   matrix.

7. **Normalize the geometric measure.** Show that
   \(\mu(\{n\})=2^{-n-1}\) has total mass one.

   **Solution.** It is a geometric series:

   \[
   \sum_{n=0}^{\infty}2^{-n-1}
   =\frac12\sum_{n=0}^{\infty}\left(\frac12\right)^n
   =\frac12\frac{1}{1-1/2}
   =1.
   \]

   This is why the counterexample is genuinely probability-based.

8. **Prove inverse-tail divergence.** For the geometric example, compute the
   first four weighted inverse-tail terms and the general term.

   **Solution.** The terms are
   \((1/2)1\), \((1/4)2\), \((1/8)4\), and \((1/16)8\). Every one equals
   \(1/2\). In general,
   \(2^{-n-1}2^n=1/2\). Since a necessary condition for a real series to
   converge is that its terms tend to zero, the inverse-tail series diverges.

9. **Check the forward field in the same example.** Why is it integrable
   without summing a delicate series?

   **Solution.** For every \(n\), the generator norm is
   \(\exp(-2^n)\leq1\). Therefore its log-positive norm is exactly zero.
   The forward observable is the zero function, whose absolute integral is
   zero under any measure.

10. **Show that the identity base is not ergodic.** Use a concrete invariant
    event.

    **Solution.** Under \(T(n)=n\), the preimage of every set is itself. The
    event \(\{0\}\) is invariant and has geometric probability \(1/2\). An
    ergodic probability base allows invariant events only probability zero or
    one, so this base is not ergodic.

11. **Show that time samples are not independent.** Let \(X_j(n)=A(T^j n)\)
    in the geometric example and consider the event that the sampled matrix is
    \(A(0)\).

    **Solution.** The identity base gives \(X_0=X_1\) pointwise. The event
    \(X_0=A(0)\) has probability \(1/2\), and the joint event
    \(X_0=A(0)\) and \(X_1=A(0)\) also has probability \(1/2\). Independence
    would require the joint probability to be
    \((1/2)(1/2)=1/4\). Hence the two time samples are not independent.

12. **Audit empty dimension.** Compute the three finite-time quantities when
    \(\iota\) has no elements.

    **Solution.** The only matrix is both zero and identity. It is a unit, but
    the supremum over its empty collection of row sums is zero. The real log,
    forward log-positive norm, and inverse log-positive norm are all zero by
    totalization. Therefore \(R_k=P_k=S_k^-=0\), and the sandwich is an
    equality on both sides.

13. **Expose the singular inverse boundary.** Use
    \(A=\operatorname{diag}(1/2,0)\).

    **Solution.** The norm is \(1/2\), so \(R_1=-\log2\). The matrix is
    singular, hence Mathlib's total inverse is zero and its inverse tail is
    zero. The putative lower bound becomes \(0\leq-\log2\), which is false.
    This calculation shows why inverse-tail integrability without pointwise
    units is not enough.

14. **Break real-log subadditivity with singular factors.** Let
    \(A=\operatorname{diag}(1/2,0)\) and
    \(B=\operatorname{diag}(0,1/2)\).

    **Solution.** Both norms equal \(1/2\), but \(AB=0\). The left side of a
    proposed inequality
    \(\log\lVert AB\rVert_\infty\leq\log\lVert A\rVert_\infty+\log\lVert B\rVert_\infty\)
    is zero, while the right side is \(-2\log2\lt0\). The inequality fails.

15. **Check horizon zero.** Assume nonempty matrix dimension. What does the
    sandwich say at \(k=0\)?

    **Solution.** The cocycle value is identity, whose norm is one. Thus
    \(R_0=P_0=0\). Both orbit sums are empty sums, so \(S_0^-=0\). The
    sandwich is \(0\leq0\leq0\).

16. **Locate the positive-rate boundary.** Compare constant scalar generators
    \(A=[2]\) and \(B=[1/2]\) on a pre-ergodic,
    probability-preserving base.

    **Solution.** For \(A\), the horizon-\(k\) norm is \(2^k\), so both the
    normalized log-positive and signed real log equal \(\log2\) for positive
    \(k\). The positive-rate shortcut applies. For \(B\), the horizon-\(k\)
    norm is \(2^{-k}\). Its normalized log-positive value is zero, while its
    normalized signed real log is \(-\log2\). The shortcut's strict-positive
    premise fails, so it cannot transfer the zero log-positive limit to the
    negative signed limit.

## Where to continue

The
{{< refterm "log-positive-integrability-envelope" "log-positive integrability envelope" >}}
entry develops the forward field and its finite orbit-sum majorant. The
{{< refterm "extended-log-norm-observable" "extended log-norm observable" >}}
entry explains the zero-faithful bottom value that the total real logarithm
does not retain.

The
{{< refterm "ergodic-probability-base" "ergodic probability base" >}}
entry separates probability normalization, invariant-set rigidity, and
integrability. That separation is essential for reading the geometric
counterexample correctly. The
{{< refterm "integrated-log-positive-growth-rate" "integrated log-positive growth rate" >}}
entry supplies the deterministic rate used by the positive-rate shortcut.

[Finite-Horizon Log-Positive Cocycle Integrability]({{< relref "/knowledge-base/deep-dives/finite-horizon-log-positive-cocycle-integrability" >}})
derives the forward finite-time majorant in detail.
[Generator-Presented One-Sided Discrete Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/generator-presented-one-sided-discrete-matrix-cocycles" >}})
fixes the product order and base-orbit convention used here.

The declaration-complete
[RMT-34 Development Notebook]({{< relref "/development-notebook/2026/07/real-log-norm-integrability-from-forward-and-inverse-tails-in-lean" >}})
provides the exact source-order ledger, while
[The Forward-and-Inverse Tail Sandwich for Finite-Time Real Log Norms]({{< relref "/knowledge-base/deep-dives/forward-and-inverse-tail-sandwich-for-finite-time-real-log-norms" >}})
develops the same interface as a textbook ascent with worked exercises and
historical context.

## References

<a id="ref-integrable-log-tails-project"></a>**Nonlinear Dynamics Lean project.**
[site-hosted RMT-34 checked source](/lean/NonlinearDynamics/Random/RandomCocycles/RealLogNormIntegrability.lean),
with repository provenance at
[commit <code>624c727146532d3b2656f5f23136557d5779b4fd</code>](https://github.com/tdj28/nonlinear-dynamics-lean/commit/624c727146532d3b2656f5f23136557d5779b4fd)
for readers who have repository access,
<code>RealLogNormIntegrability.lean</code>. This is the authoritative project
source for the three-field structure, finite-time sandwich, empty and singular
boundary probes, geometric probability counterexample, and positive-rate
shortcut described on this page.

<a id="ref-integrable-log-tails-geometric"></a>**Mathlib contributors.**
[Geometric probability measures](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Probability/Distributions/Geometric.lean),
Mathlib 4. This pinned official source defines <code>geometricMeasure</code>,
proves its probability-measure instance, computes its singleton masses, and
gives <code>integrable_geometricMeasure_iff</code>, the weighted-series test
used by the compiled counterexample.

<a id="ref-integrable-log-tails-inverse"></a>**Mathlib contributors.**
[Total nonsingular matrix inverse](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/LinearAlgebra/Matrix/NonsingularInverse.lean),
Mathlib 4. This pinned official source defines the determinant-adjugate total
inverse, proves its zero value on the singular locus, characterizes matrix
units by determinant units, and proves <code>Matrix.mul_inv_rev</code>.

<a id="ref-integrable-log-tails-poslog"></a>**Mathlib contributors.**
[Positive logarithm](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/SpecialFunctions/Log/PosLog.lean),
Mathlib 4. This pinned official source defines <code>Real.posLog</code> as the
maximum of zero and the total real logarithm, and proves the product bound used
for finite orbit majorants.

<a id="ref-integrable-log-tails-integrable"></a>**Mathlib contributors.**
[Bochner integrability bounds](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/L1Space/Integrable.lean#L632-L638),
Mathlib 4. The theorem <code>integrable_of_le_of_le</code> turns measurable
pointwise control by an integrable lower and upper function into integrability
of the sandwiched real-valued observable.

<a id="ref-integrable-log-tails-kingman"></a>**J. F. C. Kingman.**
[The Ergodic Theory of Subadditive Stochastic Processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society, Series B* 30(3), 1968, 499-510.
This primary source is the classical asymptotic destination for integrable
subadditive processes. The present package prepares a candidate but does not
invoke or reprove Kingman's theorem.

<a id="ref-integrable-log-tails-furstenberg-kesten"></a>**H. Furstenberg and H. Kesten.**
[Products of Random Matrices](https://doi.org/10.1214/aoms/1177705909),
*Annals of Mathematical Statistics* 31, 1960, 457-469. This primary source
studies asymptotic norms of random matrix products. The geometric identity-base
counterexample on this page is not an i.i.d. product model.

<a id="ref-integrable-log-tails-oseledets"></a>**V. I. Oseledets.**
[A Multiplicative Ergodic Theorem: Characteristic Lyapunov Exponents of Dynamical Systems](https://www.mathnet.ru/eng/mmo214),
*Transactions of the Moscow Mathematical Society* 19, 1968, 197-231. This
primary source is the classical origin of the multiplicative ergodic theorem
and measurable Lyapunov splitting. RMT-34 proves neither a spectrum nor a
splitting.

The exact upstream Lean revision audited for this page is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
