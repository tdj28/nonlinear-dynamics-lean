---
title: "Finite random-matrix product"
slug: "finite-random-matrix-product"
summary: "A finite random-matrix product evaluates a finite time prefix at each outcome, multiplies the newest factor on the left, proves the resulting map measurable, and only then forms its pushforward law."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.MatrixProducts.MeasurableFiniteProducts"
og_image: "finite-random-matrix-product-card.png"
og_image_alt: "Two sample paths reverse upper and lower shears, producing distinct two-step products; a law assigns weights one quarter and three quarters after the product map is proved measurable."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean examples, source interpretation, diagram, and accessibility
remains pending. The page is public so readers can follow the educational
rebuild while that review remains open.
{{< /panel >}}

Begin with two concrete \(2\) by \(2\) matrices:

\[
U=
\begin{bmatrix}
1&1\\
0&1
\end{bmatrix},
\qquad
L=
\begin{bmatrix}
1&0\\
1&1
\end{bmatrix}.
\]

The matrix \(U\) is an upper shear and \(L\) is a lower shear. Suppose one
sample path, called \(r\), selects

\[
A_0(r)=U,
\qquad
A_1(r)=L.
\]

Time \(0\) happens first. Time \(1\) happens second. For column vectors, the
first matrix action must therefore be closest to the vector:

\[
x_2=A_1(r)\bigl(A_0(r)x_0\bigr)
=\bigl(A_1(r)A_0(r)\bigr)x_0.
\]

The two-step **forward product** is consequently

\[
\Pi_2(r)=A_1(r)A_0(r)=LU.
\]

The newest factor is written on the left.

## Calculate both orders

Matrix multiplication is generally noncommutative. Compute the order selected
by the time convention:

\[
\begin{aligned}
LU
&=
\begin{bmatrix}
1&0\\
1&1
\end{bmatrix}
\begin{bmatrix}
1&1\\
0&1
\end{bmatrix}\\
&=
\begin{bmatrix}
1\cdot1+0\cdot0 & 1\cdot1+0\cdot1\\
1\cdot1+1\cdot0 & 1\cdot1+1\cdot1
\end{bmatrix}\\
&=
\begin{bmatrix}
1&1\\
1&2
\end{bmatrix}.
\end{aligned}
\]

Now reverse the order:

\[
\begin{aligned}
UL
&=
\begin{bmatrix}
1&1\\
0&1
\end{bmatrix}
\begin{bmatrix}
1&0\\
1&1
\end{bmatrix}\\
&=
\begin{bmatrix}
1\cdot1+1\cdot1 & 1\cdot0+1\cdot1\\
0\cdot1+1\cdot1 & 0\cdot0+1\cdot1
\end{bmatrix}\\
&=
\begin{bmatrix}
2&1\\
1&1
\end{bmatrix}.
\end{aligned}
\]

Therefore

\[
LU\ne UL.
\]

Reversing the written factors changes the matrix. It also changes the
chronology. Let

\[
e=
\begin{bmatrix}
1\\
0
\end{bmatrix}.
\]

Along path \(r\), the intended updates are

\[
e
\xrightarrow{\,U\,}
\begin{bmatrix}1\\0\end{bmatrix}
\xrightarrow{\,L\,}
\begin{bmatrix}1\\1\end{bmatrix}.
\]

Indeed, the first column of \(LU\) is \((1,1)^{\mathsf T}\). Reversing the
actions gives

\[
e
\xrightarrow{\,L\,}
\begin{bmatrix}1\\1\end{bmatrix}
\xrightarrow{\,U\,}
\begin{bmatrix}2\\1\end{bmatrix},
\]

the first column of \(UL\). The order difference is observable on a single
vector.

{{< reference-figure
  wide="true"
  src="finite-random-matrix-product.svg"
  alt="A red two-step path applies upper shear U at time zero and lower shear L at time one, so the forward product is L times U, equal to the matrix with rows one one and one two. A reversed blue path gives U times L, equal to the distinct matrix with rows two one and one one. A horizon ladder begins at the identity. A lower probability panel gives the red product weight one quarter and the blue product weight three quarters, while a separate gate shows that measurability enables a pushforward law but does not establish integrability."
  caption="**Finding:** time flows from \(A_0\) to \(A_1\), while the written product places the later action on the left. On path \(r\), \(U\) acts first and \(L\) acts second, so \(\Pi_2(r)=LU\). Swapping the path labels produces \(UL\), a different matrix. The lower panels keep three objects separate: one realized matrix, the outcome-to-product map, and the pushforward law that assigns weights \(1/4\) and \(3/4\) to the two possible products. Measurability certifies that law construction; integrability is a separate size condition."
>}}

## Horizon zero is the identity

A horizon counts how many factors have acted. It does not name the final
index. The first horizons are

\[
\begin{aligned}
\Pi_0(\omega)&=I,\\
\Pi_1(\omega)&=A_0(\omega),\\
\Pi_2(\omega)&=A_1(\omega)A_0(\omega),\\
\Pi_3(\omega)&=A_2(\omega)A_1(\omega)A_0(\omega).
\end{aligned}
\]

For our \(2\) by \(2\) paths,

\[
\Pi_0(\omega)=
I_2=
\begin{bmatrix}
1&0\\
0&1
\end{bmatrix}
\qquad\text{for every }\omega.
\]

There is no time-zero factor hiding in this expression. Horizon zero uses an
empty list of factors, and the product of an empty list is the multiplicative
identity. Consequently,

\[
\Pi_0(\omega)x=x.
\]

This convention makes the successor recursion uniform:

\[
\boxed{
\Pi_{k+1}(\omega)=A_k(\omega)\Pi_k(\omega)
}.
\]

It also makes a split after \(m\) factors work when either block is empty.

## Turn the two orders into a random product

Now use the outcome space

\[
\Omega=\{r,b\}.
\]

The same two matrices appear on both outcomes, but their time order differs:

| Outcome | \(A_0(\omega)\) | \(A_1(\omega)\) | \(\Pi_2(\omega)=A_1(\omega)A_0(\omega)\) |
|---|---|---|---|
| \(r\) | \(U\) | \(L\) | \(LU=\begin{bmatrix}1&1\\1&2\end{bmatrix}\) |
| \(b\) | \(L\) | \(U\) | \(UL=\begin{bmatrix}2&1\\1&1\end{bmatrix}\) |

The entire function

\[
\Pi_2:\Omega\longrightarrow M_2(\mathbb R)
\]

is the **two-step sample-product map**. Applying it to one outcome gives one
**realization**. For example,

\[
\Pi_2(r)=
\begin{bmatrix}
1&1\\
1&2
\end{bmatrix}
\]

is one ordinary matrix. It is not a probability measure.
For the project's complex-matrix law, these real entries are regarded as
complex numbers with zero imaginary part.

Give the outcomes probabilities

\[
\mu\{r\}=\frac14,
\qquad
\mu\{b\}=\frac34.
\]

The {{< refterm "probability-law" "probability law" >}} of the product map is
the measure on matrix space

\[
\begin{aligned}
\mathcal L_\mu(\Pi_2)
&=\frac14\,
\delta_{\left[\begin{smallmatrix}1&1\\1&2\end{smallmatrix}\right]}\\
&\quad+\frac34\,
\delta_{\left[\begin{smallmatrix}2&1\\1&1\end{smallmatrix}\right]}.
\end{aligned}
\]

The symbol \(\delta_M\) denotes a point mass at matrix \(M\). For instance,
let \(E\) be the set of matrices whose upper-left entry is \(1\). Only the red
product lies in \(E\), so

\[
\mathcal L_\mu(\Pi_2)(E)
=\mu\{\omega:\Pi_2(\omega)\in E\}
=\mu\{r\}
=\frac14.
\]

The realized matrix answers "what product occurred on this path?" The law
answers "how is probability distributed over all possible product values?"
Changing the source weights changes the law without changing either matrix
formula.

The factors in this toy model are not independent: once the outcome is known,
the entire two-step order is known. Independence is not required to define a
finite sample product or its pushforward law.

## The general pointwise construction

Let \(\Omega\) be an outcome type and let

\[
A_j:\Omega\longrightarrow M_\iota(\mathbb K)
\]

be a square matrix-valued map at every natural time \(j\). The project first
defines the deterministic ordered product

\[
P_B(0)=I,
\qquad
P_B(k+1)=B_kP_B(k).
\]

It then substitutes \(B_j=A_j(\omega)\):

\[
\Pi_k(\omega)=P_{j\mapsto A_j(\omega)}(k).
\]

This algebraic construction needs a finite matrix index type and semiring
scalars. A semiring supplies the finite sums, products, zero, and identity
used in matrix multiplication. It needs no measurable space, measure,
probability, independence, norm, or integral.

Splitting after \(m\) factors gives

\[
\Pi_{m+k}(\omega)
=\Pi^{(m)}_k(\omega)\Pi_m(\omega),
\]

where \(\Pi^{(m)}_k\) uses the shifted factors
\(j\mapsto A_{m+j}\). The later block is on the left because it acts after the
earlier block.

## Exact prefix measurability

To form the ordinary pushforward law in the intended regime, the map
\(\Pi_k\) must be {{< refterm "measurable-function" "measurable" >}}. The
checked hypothesis is exactly

\[
\forall j\lt k,\quad A_j\text{ is measurable}.
\]

At horizon \(2\), only \(A_0\) and \(A_1\) appear. The measurability of
\(A_2,A_3,\ldots\) is irrelevant. At horizon \(0\), the condition is vacuous
because there is no natural number \(j\lt0\).

The proof mirrors the recursion:

1. \(\Pi_0\) is the constant identity map, hence measurable.
2. If \(A_k\) and \(\Pi_k\) are measurable, then
   \(\omega\mapsto A_k(\omega)\Pi_k(\omega)\) is measurable.
3. Induction reaches every finite horizon.

Why is matrix multiplication measurable? Each output entry is a finite sum

\[
(XY)_{rc}=\sum_s X_{rs}Y_{sc}
\]

of products of measurable complex coordinate functions. The shared index type
is finite, so the sum has finitely many terms.

On the finite two-outcome space above, give every subset of \(\Omega\) the
status of an event. Every map out of that discrete measurable space is
measurable, so the prefix certificate is immediate.

## Measurability is not integrability

Measurability asks whether target events have allowed source preimages.
{{< refterm "integrability" "Integrability" >}} asks whether a measurable
quantity has finite total norm under a chosen measure. The first property does
not provide the second.

There is an even sharper product warning. On the probability space
\((0,1]\) with Lebesgue measure, set

\[
D(t)=
\begin{bmatrix}
t^{-1/2}&0\\
0&1
\end{bmatrix}
\qquad(0\lt t\le1).
\]

Use \(A_0(t)=A_1(t)=D(t)\). For the maximum absolute row-sum norm,

\[
\lVert D(t)\rVert=t^{-1/2},
\]

and

\[
\int_0^1 t^{-1/2}\,dt=2.
\]

Thus each factor has integrable norm. But

\[
\Pi_2(t)=D(t)^2=
\begin{bmatrix}
t^{-1}&0\\
0&1
\end{bmatrix},
\qquad
\lVert\Pi_2(t)\rVert=t^{-1},
\]

and

\[
\int_0^1 t^{-1}\,dt=\infty.
\]

Even integrability of each one-step norm does not automatically imply
integrability of their product. Boundedness, independence plus suitable
moments, or a direct domination argument could supply additional control, but
none is present in the finite-product measurability module. This calculus
example explains the boundary; it is not a theorem formalized in that module.

Measurability itself does not mention the source measure. Integrability is
always relative to a measure. That type-level separation is deliberate.

## From a measurable sample map to its law

Let \(\mu\) be a measure on \(\Omega\). Once \(\Pi_k\) is measurable, the
project defines

\[
\mathcal L_\mu(\Pi_k)
=(\Pi_k)_*\mu,
\]

the {{< refterm "pushforward-measure" "pushforward" >}} of \(\mu\) through the
sample-product map. For every measurable matrix set \(S\),

\[
\mathcal L_\mu(\Pi_k)(S)
=\mu\{\omega:\Pi_k(\omega)\in S\}.
\]

Mathlib's <code>Measure.map</code> is total: outside its
almost-everywhere-measurable branch it falls back to the zero measure. The
project's <code>RandomMatrix.law</code> wrapper therefore receives an explicit
ordinary measurability proof. That proof records why this use of
<code>Measure.map</code> has the intended pushforward meaning.

The raw <code>forwardProductLaw</code> accepts any source
<code>Measure Ω</code>. If \(\mu\) is a
{{< refterm "probability-measure" "probability measure" >}}, the project proves
that the result also has total mass one. It can then be bundled as a
<code>ProbabilityMeasure</code>. The wrapper changes what the type remembers;
it does not change any event probabilities.

At horizon zero, under a probability source,

\[
\mathcal L_\mu(\Pi_0)=\delta_I.
\]

At horizon one,

\[
\mathcal L_\mu(\Pi_1)=\mathcal L_\mu(A_0).
\]

The zero-horizon Dirac formula uses probability normalization. Pushing an
arbitrary measure through a constant identity map preserves its total mass,
which need not be one.

## In Lean

The successor equation is the key translation from chronological action to
syntax.

{{< lean-bridge
  human="At the next horizon, put the newest matrix on the left of the product already accumulated from earlier times."
  math="\(\Pi_{k+1}(\omega)=A_k(\omega)\Pi_k(\omega)\), with \(\Pi_0(\omega)=I\)."
  lean="sampleForwardProduct A (k + 1) = fun ω => A k ω * sampleForwardProduct A k ω"
>}}

- <code>sampleForwardProduct</code> is the outcome-to-product map.
- <code>A</code> is a time-indexed family. Thus <code>A k</code> is the map
  at time <code>k</code>, and <code>A k ω</code> is its realized matrix at
  outcome <code>ω</code>.
- <code>k + 1</code> is the successor horizon. Its newest factor has index
  <code>k</code>.
- <code>fun ω =></code> constructs a function of the outcome. It corresponds
  to the paper notation \(\omega\mapsto\cdots\).
- <code>*</code> is matrix multiplication. Its operand order is literal.
- The equality is an equality of functions, not merely an equality at one
  chosen outcome.
{{< /lean-bridge >}}

These are exact declarations from the checked project module:

~~~lean
def sampleForwardProduct (A : ℕ → RandomMatrix Ω ι ι 𝕜) (k : ℕ) :
    RandomMatrix Ω ι ι 𝕜 :=
  fun ω => forwardProduct (fun j => A j ω) k

@[simp] theorem sampleForwardProduct_zero (A : ℕ → RandomMatrix Ω ι ι 𝕜) :
    sampleForwardProduct A 0 = fun _ => 1 := rfl

@[simp] theorem sampleForwardProduct_succ
    (A : ℕ → RandomMatrix Ω ι ι 𝕜) (k : ℕ) :
    sampleForwardProduct A (k + 1) =
      fun ω => A k ω * sampleForwardProduct A k ω := rfl
~~~

The symbol <code>1</code> is the matrix identity because Lean infers its type
from the surrounding matrix-valued function. The proof <code>rfl</code>
means that the zero and successor equations follow by unfolding the recursive
definitions.

The exact-prefix theorem keeps every used assumption visible:

{{< lean-bridge
  human="If every factor whose index is strictly below k is measurable, then the k-step outcome-to-product map is measurable."
  math="\(\bigl(\forall j\lt k,\ A_j\text{ measurable}\bigr)\Longrightarrow \Pi_k\text{ measurable}.\)"
  lean="measurable_sampleForwardProduct A k hA"
>}}

- <code>hA</code> is proof evidence with type
  <code>∀ j &lt; k, Measurable (A j)</code>.
- <code>∀</code> means "for every," and <code>j &lt; k</code> selects exactly
  the finite prefix of indices \(0,\ldots,k-1\).
- <code>Measurable (A j)</code> concerns one matrix-valued factor map.
- The conclusion <code>Measurable (sampleForwardProduct A k)</code> concerns
  the whole finite product map.
- The strict comparison is typed literally as <code>&lt;</code> in Lean code.
  Paper mathematics on this site uses \(\lt\) inside TeX.
{{< /lean-bridge >}}

Here is the exact theorem and proof:

~~~lean
theorem measurable_sampleForwardProduct (A : ℕ → RandomMatrix Ω ι ι ℂ)
    (k : ℕ) (hA : ∀ j < k, Measurable (A j)) :
    Measurable (sampleForwardProduct A k) := by
  induction k with
  | zero =>
      rw [sampleForwardProduct_zero]
      exact RandomMatrix.measurable_const 1
  | succ k ih =>
      rw [sampleForwardProduct_succ]
      exact RandomMatrix.measurable_mul
        (hA k (Nat.lt_succ_self k))
        (ih fun j hj => hA j (Nat.lt_succ_of_lt hj))
~~~

The <code>zero</code> branch proves measurability of the constant identity.
The <code>succ</code> branch obtains the newest factor from <code>hA</code>,
uses the induction hypothesis for the earlier prefix, and applies measurable
matrix multiplication.

Finally, the law constructor receives that certificate:

{{< lean-bridge
  human="Transport the source measure through the certified finite product map to obtain a measure on matrices."
  math="\(\mathcal L_\mu(\Pi_k)=(\Pi_k)_*\mu\)."
  lean="forwardProductLaw μ A k hA"
>}}

- <code>μ : Measure Ω</code> is the source measure.
- <code>A</code>, <code>k</code>, and <code>hA</code> specify the same
  certified sample-product map as above.
- The result has type <code>Measure (Matrix ι ι ℂ)</code>. It is a measure on
  matrix values, not another matrix and not a function on outcomes.
- If <code>μ</code> has a probability-measure instance, a separate theorem
  proves that this raw law has total mass one.
{{< /lean-bridge >}}

The exact definition is:

~~~lean
noncomputable def forwardProductLaw (μ : Measure Ω)
    (A : ℕ → RandomMatrix Ω ι ι ℂ)
    (k : ℕ) (hA : ∀ j < k, Measurable (A j)) :
    Measure (Matrix ι ι ℂ) :=
  RandomMatrix.law (sampleForwardProduct A k)
    (measurable_sampleForwardProduct A k hA) μ
~~~

The word <code>noncomputable</code> says that Lean is defining a classical
mathematical object rather than executable code. It does not weaken the
definition or introduce an unproved proposition.

### A tiny standalone worksheet

The following complete Lean program uses only <code>Std</code>. It implements
integer \(2\) by \(2\) multiplication and folds a chronological list
<code>[A₀, A₁, ...]</code> by placing each newest factor on the left.

Save it as <code>FiniteProductWorksheet.lean</code>:

~~~lean
import Std

namespace FiniteProductWorksheet

structure Mat2 where
  a00 : Int
  a01 : Int
  a10 : Int
  a11 : Int
deriving Repr, DecidableEq

def matMul (X Y : Mat2) : Mat2 :=
  { a00 := X.a00 * Y.a00 + X.a01 * Y.a10
  , a01 := X.a00 * Y.a01 + X.a01 * Y.a11
  , a10 := X.a10 * Y.a00 + X.a11 * Y.a10
  , a11 := X.a10 * Y.a01 + X.a11 * Y.a11 }

def identity : Mat2 :=
  { a00 := 1, a01 := 0, a10 := 0, a11 := 1 }

def upperShear : Mat2 :=
  { a00 := 1, a01 := 1, a10 := 0, a11 := 1 }

def lowerShear : Mat2 :=
  { a00 := 1, a01 := 0, a10 := 1, a11 := 1 }

def lowerAfterUpper : Mat2 :=
  { a00 := 1, a01 := 1, a10 := 1, a11 := 2 }

def upperAfterLower : Mat2 :=
  { a00 := 2, a01 := 1, a10 := 1, a11 := 1 }

def forwardProduct (factors : List Mat2) : Mat2 :=
  factors.foldl (fun earlier newest => matMul newest earlier) identity

inductive Outcome where
  | red
  | blue
deriving Repr, DecidableEq

def samplePath : Outcome → List Mat2
  | .red => [upperShear, lowerShear]
  | .blue => [lowerShear, upperShear]

def realizedProduct (ω : Outcome) : Mat2 :=
  forwardProduct (samplePath ω)

#eval matMul lowerShear upperShear
#eval matMul upperShear lowerShear
#eval realizedProduct .red
#eval realizedProduct .blue
#eval forwardProduct []

example : matMul lowerShear upperShear = lowerAfterUpper := by decide
example : matMul upperShear lowerShear = upperAfterLower := by decide
example : lowerAfterUpper ≠ upperAfterLower := by decide
example : realizedProduct .red = lowerAfterUpper := by decide
example : realizedProduct .blue = upperAfterLower := by decide
example : forwardProduct [] = identity := by decide

end FiniteProductWorksheet
~~~

With Elan installed, a human opens a terminal in the directory containing the
file and types:

~~~sh
elan run leanprover/lean4:v4.32.0 lean FiniteProductWorksheet.lean
~~~

Lean prints the two distinct products twice, once by direct multiplication and
once through the two sample paths, then prints the identity for the empty
list. The six <code>example</code> declarations ask the Lean kernel to certify
the calculations and noncommutativity.

This worksheet is a small executable model. It does not import Mathlib, define
measurable spaces or measures, or construct the weighted law
\(\frac14\delta_{LU}+\frac34\delta_{UL}\).

### The checked project layer

{{< repo-check >}}
The authoritative algebraic source is
[formalization/NonlinearDynamics/Random/MatrixProducts/FiniteProducts.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/MatrixProducts/FiniteProducts.lean).
The sample-map and law source is
[formalization/NonlinearDynamics/Random/MatrixProducts/MeasurableFiniteProducts.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/MatrixProducts/MeasurableFiniteProducts.lean).

A learner can place the following exact lines in a temporary scratch file
inside the <code>formalization</code> project on an approved Linux builder:

~~~lean
import NonlinearDynamics.Random.MatrixProducts.MeasurableFiniteProducts

open Matrix MeasureTheory

#check NonlinearDynamics.Random.MatrixProducts.forwardProduct
#check NonlinearDynamics.Random.MatrixProducts.forwardProduct_zero
#check NonlinearDynamics.Random.MatrixProducts.forwardProduct_succ
#check NonlinearDynamics.Random.MatrixProducts.forwardProduct_add
#check NonlinearDynamics.Random.MatrixProducts.sampleForwardProduct
#check NonlinearDynamics.Random.MatrixProducts.sampleForwardProduct_zero
#check NonlinearDynamics.Random.MatrixProducts.sampleForwardProduct_succ
#check NonlinearDynamics.Random.MatrixProducts.measurable_sampleForwardProduct
#check NonlinearDynamics.Random.MatrixProducts.forwardProductLaw
#check NonlinearDynamics.Random.MatrixProducts.forwardProductLaw_zero
#check NonlinearDynamics.Random.MatrixProducts.forwardProductLaw_one
#check NonlinearDynamics.Random.MatrixProducts.forwardProductProbabilityLaw
~~~

<code>import</code> loads the checked project module and its pinned Mathlib
dependencies. Each <code>#check</code> asks Lean to elaborate one declaration
and print its type. It does not create a theorem or evaluate the toy matrices.

From the repository root, a human runs the authoritative warning-fatal module
check with:

~~~sh
CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/Random/MatrixProducts/MeasurableFiniteProducts.lean
~~~

That project command is for an approved Linux cloud builder. The Mac
workstation is for reading and editing source, Hugo checks, and the standalone
<code>Std</code> worksheet; it is not a Mathlib build host.
{{< /repo-check >}}

## Distinctions and boundary cases

| Do not confuse | With | Why the difference matters |
|---|---|---|
| Time order \(A_0\) then \(A_1\) | Written order \(A_1A_0\) | The earliest factor acts first on a column vector but is written furthest right |
| Horizon \(k\) | Largest factor index \(k\) | Horizon \(k\) uses indices \(0,\ldots,k-1\) |
| One realization \(\Pi_k(\omega)\) | The sample-product map \(\Pi_k\) | The first is one matrix; the second is a function from all outcomes |
| Sample-product map \(\Pi_k\) | Its law \((\Pi_k)_*\mu\) | The first returns matrices; the second assigns mass to measurable matrix sets |
| Measurability | Integrability | Allowed preimages do not imply finite expected norm |
| Integrable one-step norms | An integrable product norm | The \(D(t)\) example has two integrable factors but a nonintegrable product |
| A finite product | An infinite product or asymptotic rate | No limit follows from a fixed finite horizon |
| A law | Independence or identical distribution | Pushforward construction needs neither property |
| Raw measure | Bundled probability measure | The latter carries total-mass-one evidence in its type |

The matrix index type may be empty. There is still one empty square matrix, so
the identity, multiplication, sample product, measurability theorem, and law
remain meaningful without a <code>Nonempty ι</code> assumption. Positive
dimension enters the companion operator-norm layer because its normalized
identity theorem needs it, not because the algebraic product fails.

If the source measure has zero mass, every pushforward law has zero mass. If
the source is a Dirac measure at one outcome, the product law is a Dirac
measure at that outcome's realized product. Neither boundary changes the
pointwise product formula.

{{< panel "warning" >}}
**What this page does not prove.** The checked module constructs finite sample
products, proves their exact-prefix measurability, and packages their
pushforward laws. It proves no integrability, expectation, independence,
stationarity, invertibility, cocycle identity over a base transformation,
almost-sure growth rate, Lyapunov exponent, spectral law, density, or
long-time limit. The heavy-tail calculation is an explanatory boundary
example, not a checked theorem in this module.
{{< /panel >}}

## Where to continue

The {{< refterm "forward-matrix-product" "forward matrix product" >}} page
develops the deterministic order and split identities. The
{{< refterm "random-matrix" "random matrix" >}} page separates a matrix-valued
function from one realization. The
{{< refterm "measurable-function" "measurable function" >}},
{{< refterm "pushforward-measure" "pushforward measure" >}}, and
{{< refterm "probability-law" "probability law" >}} pages develop the three
measure-theoretic layers used here. Read
{{< refterm "integrability" "integrability" >}} for the finite-size condition
that this module deliberately does not supply.

[Measurable Finite Random-Matrix Products and Proof-Carrying Pushforward Laws]({{< relref "/knowledge-base/deep-dives/measurable-finite-random-matrix-products-and-pushforward-laws" >}})
audits every declaration in the checked source.
[Generator-Presented One-Sided Discrete Matrix Cocycles]({{< relref "/knowledge-base/deep-dives/generator-presented-one-sided-discrete-matrix-cocycles" >}})
adds one measurable generator along a base orbit and proves the corresponding
finite cocycle identity. The
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycle" >}}
glossary entry gives the intermediate concept.

## References

**Mathlib contributors.**
[Pushforward of a measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
Mathlib 4 documentation. This official implementation reference defines
<code>Measure.map</code> and its measurable-map evaluation theorem.

**Mathlib contributors.**
[Bundled probability measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/ProbabilityMeasure.html),
Mathlib 4 documentation. This source defines <code>ProbabilityMeasure</code>
and its coercion to raw measures.

**Olav Kallenberg.**
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1),
third edition, Springer, 2021. This is a standard reference for measurable
random elements, pushforward distributions, and integration.

**Ludwig Arnold.**
[Random Dynamical Systems](https://doi.org/10.1007/978-3-662-12878-7),
Springer Monographs in Mathematics, 1998. This develops the later cocycle and
ergodic setting in which long random matrix products are studied. Those
structures motivate the finite interface but are not claims of this page.

The local project uses Mathlib 4.32.0 pinned at commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).
