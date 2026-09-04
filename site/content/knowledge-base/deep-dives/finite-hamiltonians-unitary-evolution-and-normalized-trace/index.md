---
title: "Finite Hamiltonians, Unitary Evolution, and Normalized Trace"
slug: "finite-hamiltonians-unitary-evolution-and-normalized-trace"
date: 2026-08-13
summary: "A two-level diagonal Hamiltonian introduces the sign in exp(-itH), unitary time composition, reciprocal-dimension trace, and the explicit zero-dimensional boundary."
lead: "Compute one exact two-level ledger first, then separate the shared finite-system foundation from every later quantum-chaos diagnostic."
draft: true
pro_reviewed: false
level: "Introductory linear algebra and complex numbers"
reading_time: "30 to 40 minutes"
prerequisites: "Two-by-two matrices, complex conjugation, and eigenvalues are introduced through the worked example"
lean_module: "NonlinearDynamics.QuantumChaos.FiniteSystems"
lean_snapshot: "/lean/NonlinearDynamics/QuantumChaos/FiniteSystems.lean"
lean_source_sha256: "f178704b75afdb20a5bbde658d20007ec3de755e5bbe416e86c5d9b4bf8563dd"
toc: true
og_image: "finite-hamiltonians-unitary-evolution-and-normalized-trace-card.png"
og_image_alt: "A two-level Hamiltonian with energies one and minus one generates opposite phase rotations, while normalized trace and claim boundaries remain visible."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial and validation status.** This is an AI-assisted working
draft. The warning-fatal pinned-toolchain leaf, deterministic aggregator, and
exact-commit full repository gate pass. Professional review remains pending,
so `pro_reviewed` remains false.
{{< /panel >}}

## Start with a two-level Hamiltonian

Work in a two-dimensional complex state space and choose the finite
{{< refterm "finite-quantum-hamiltonian" "Hamiltonian" >}}

\[
H=\begin{pmatrix}1&0\\0&-1\end{pmatrix}.
\]

It is a {{< refterm "hermitian-matrix" "Hermitian matrix" >}} because
conjugate transposition leaves it unchanged. Its ordered real energy levels
are \(1\) and \(-1\). In units where the reduced Planck constant is
\(\hbar=1\), this project fixes the evolution convention

\[
U_H(t)=e^{-itH}.
\]

Because \(H\) is diagonal, exponentiation acts on the diagonal entries:

\[
U_H(t)=
\begin{pmatrix}e^{-it}&0\\0&e^{it}\end{pmatrix}.
\]

At \(t=\pi/2\),

\[
U_H(\pi/2)=
\begin{pmatrix}-i&0\\0&i\end{pmatrix}.
\]

Its conjugate transpose is \(\operatorname{diag}(i,-i)\), and direct matrix
multiplication gives

\[
U_H(\pi/2)^*U_H(\pi/2)=I_2.
\]

The ordinary {{< refterm "matrix-trace" "matrix trace" >}} of \(H\) is
\(1+(-1)=0\). The normalized trace divides by the dimension:

\[
\tau_2(H)=\frac12\operatorname{Tr}(H)=0.
\]

The empirical spectral measure is

\[
L_H=\frac12(\delta_1+\delta_{-1}),
\]

so its first moment is also zero. These are two descriptions of the same
finite calculation, not a statement about an ensemble or a large-dimension
limit.

{{< reference-figure
  wide="true"
  src="two-level-evolution-ledger.svg"
  alt="The diagonal Hamiltonian with levels one and minus one maps at time pi over two to diagonal phases minus i and i; multiplying the conjugate transpose by the matrix gives the identity, and both normalized trace and mean energy are zero."
  caption="**One exact ledger:** real energy levels acquire opposite complex phases. The unitary check is matrix multiplication; the normalized trace agrees with the first empirical spectral moment. No random-matrix or chaos inference is made."
>}}

## What the finite Hamiltonian carrier records

The Lean type `FiniteHamiltonian n` is an abbreviation for the project's
existing `HermitianEuclidean n`. An element contains:

- an \(n\times n\) complex matrix;
- a proof that its conjugate transpose equals itself; and
- the inherited finite Frobenius geometry already used by the random-matrix
  layer.

The abbreviation changes the mathematical role of the object without copying
its representation. Ordered eigenvalues, their continuity, and the
zero-aware {{< refterm "empirical-spectral-measure" "empirical spectral measure" >}}
remain the earlier `RandomMatrix` definitions. This prevents later
quantum-chaos modules from acquiring a second, incompatible spectrum API.

## Why the minus sign is frozen now

The source defines the Schrödinger generator as

\[
G_H(t)=-t(iH).
\]

Thus `timeEvolutionMatrix H t` is
\(\exp(G_H(t))=\exp(-itH)\). With this
choice, a state evolving by the Schrödinger equation

\[
i\frac{d}{dt}\psi(t)=H\psi(t)
\]

has the formal solution \(\psi(t)=U_H(t)\psi(0)\) for a time-independent
Hamiltonian. The candidate formalizes the finite matrix exponential and its
group law; it does not formalize differentiable state-valued solutions of the
Schrödinger equation.

Changing to \(e^{+itH}\) would reverse the time convention. Either sign may
appear when authors switch between state evolution and Heisenberg evolution
of observables. Downstream formulas must not alternate between them without
an explicit translation, so this module records one sign at the dependency
root.

## From Hermitian to unitary

Hermiticity says \(H^*=H\). Complex conjugation sends \(i\) to \(-i\), so

\[
(-itH)^*=itH=-(-itH).
\]

The exponent is therefore **skew-adjoint**. The checked source rewrites the
conjugate transpose of the exponential with `Matrix.exp_conjTranspose`, then
combines the pairs (-A+A) and (A-A) with
`Matrix.exp_add_of_commute`. Both products reduce to the identity, so the
exponential is returned as an element of
`Matrix.unitaryGroup (Fin n) ℂ`, rather than as a matrix plus an unrelated
later proof.

For one fixed \(H\), the generators at times \(s\) and \(t\) are scalar
multiples of the same matrix and commute. Therefore

\[
U_H(s+t)=U_H(s)U_H(t).
\]

Time zero gives the identity, and substituting \(s=t\), \(t=-t\) gives

\[
U_H(-t)=U_H(t)^{-1}.
\]

The commutation step matters. The identity
\(e^{A+B}=e^Ae^B\) does not hold for arbitrary noncommuting matrices \(A\)
and \(B\). The theorem here concerns two time scalings of one Hamiltonian; it
does not claim the same factorization for two different Hamiltonians.

## Normalized trace and dimension zero

For an \(n\times n\) matrix \(A\), the source defines

\[
\tau_n(A)=n^{-1}\operatorname{Tr}(A).
\]

The reciprocal is taken in the real numbers and then included in the complex
numbers. This exactly matches the earlier empirical-spectral-moment formula.
The project keeps the function total at \(n=0\): Lean's field inverse has
\(0^{-1}=0\), so

\[
\tau_0(A)=0.
\]

This is a boundary convention, not a claim that a zero-dimensional system is
a physical experiment. In positive dimension, \(\tau_n(I_n)=1\). In dimension
zero, the normalized trace and empirical spectral measure are both zero. The
exception is visible rather than hidden behind an informal division by zero.

Unitary conjugation preserves trace, hence

\[
\tau_n(UAU^*)=\tau_n(A).
\]

This is basis invariance of one scalar. It is not the probabilistic
{{< refterm "unitary-invariance" "unitary invariance" >}} of an entire matrix
law, although both use the same conjugation operation.

{{< reference-figure
  wide="true"
  src="foundation-dependency-boundary.svg"
  alt="A dependency diagram sends one Hermitian Hamiltonian to a unitary time evolution, normalized trace, ordered spectrum, and empirical spectral measure, then places a boundary before level spacings, spectral form factors, out-of-time-order correlators, ensembles, asymptotics, and quantum-chaos criteria."
  caption="**Shared foundation and stopping point:** the new module owns only Hamiltonian semantics, finite evolution, and normalized trace. Ordered spectra and empirical measures are reused. Every diagnostic beyond the boundary needs its own definition and theorem."
>}}

## A bounded standalone worksheet

The bundled **standalone tutorial** imports only `Std`. It implements
Gaussian-integer arithmetic for stored \(2\times2\) matrices, checks
\(G_H(1)+G_H(2)=G_H(3)\), multiplies the stored quarter-turn matrix by its
conjugate transpose, and checks the trace ledger \(1+(-1)=0\).

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/finite-hamiltonians-unitary-evolution-and-normalized-trace/two-level-ledger.lean
```

Its trust boundary is finite. `decide` exhausts equality of the stored integer
records. The worksheet does not define analytic complex exponentiation and
does not establish that the stored quarter-turn matrix equals
\(\exp(-i(\pi/2)H)\). That analytic identity is computed in the prose from a
diagonal exponential; the general Lean source uses Mathlib's matrix
exponential.

## In Lean

{{< lean-bridge
  human="A finite Hamiltonian is represented by the project's existing intrinsic Hermitian matrix carrier."
  math="\(H\in\{A\in M_n(\mathbb C):A^*=A\}.\)"
  lean="abbrev FiniteHamiltonian (n : ℕ) :=\n  RandomMatrix.HermitianEuclidean n"
>}}
`abbrev` creates a transparent name, `n : ℕ` is the matrix dimension, and the
existing carrier supplies both the complex matrix and its Hermitian proof.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Evolution for the same Hamiltonian over two consecutive times equals the product of the two evolutions."
  math="\(U_H(s+t)=U_H(s)U_H(t).\)"
  lean="theorem timeEvolution_add {n : ℕ}\n    (H : FiniteHamiltonian n) (s t : ℝ) :\n    timeEvolution H (s + t) =\n      timeEvolution H s * timeEvolution H t"
>}}
The multiplication on the right is multiplication in the bundled unitary
group. The proof uses `Matrix.exp_add_of_commute` only after establishing that
the two same-Hamiltonian generators commute.
{{< /lean-bridge >}}

{{< lean-bridge
  human="The normalized trace of a finite Hamiltonian is the first moment of its zero-aware empirical spectral measure."
  math="\(\tau_n(H)=\int_{\mathbb R}x\,dL_H(x).\)"
  lean="theorem normalizedTrace_hamiltonian_eq_empiricalSpectralMoment_one\n    {n : ℕ} (H : FiniteHamiltonian n) :\n    normalizedTrace (hamiltonianMatrix H) =\n      RandomMatrix.empiricalSpectralMoment 1 H"
>}}
`empiricalSpectralMoment 1` is imported from the random-matrix layer. The
equality includes the dimension-zero convention on both sides.
{{< /lean-bridge >}}

## Try the full project module

~~~lean
import NonlinearDynamics.QuantumChaos.FiniteSystems

open NonlinearDynamics.QuantumChaos

#check FiniteHamiltonian
#check hamiltonianMatrix_isHermitian
#check schrodingerGenerator_mem_skewAdjoint
#check timeEvolution
#check timeEvolution_zero
#check timeEvolution_add
#check timeEvolution_neg
#check normalizedTrace
#check normalizedTrace_zero_dimension
#check normalizedTrace_unitary_conjugation
#check normalizedTrace_hamiltonian_eq_empiricalSpectralMoment_one
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
Lean's elaborator constructs candidate proof terms and its kernel checks them
against the exact finite-matrix statements. This checks the encoded
Hermitian, exponential, group, and trace claims. It does not certify a
physical model or establish quantum chaos.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/QuantumChaos/FiniteSystems.lean
```

## Misconceptions and limits

- `FiniteHamiltonian n` reuses `HermitianEuclidean n`; it is not a second
  matrix representation.
- The convention is \(e^{-itH}\) with \(\hbar=1\). Units and sign are not
  inferred from context.
- Hermiticity is what makes the generator skew-adjoint and the exponential
  unitary.
- The exponential addition law uses two scalar multiples of one \(H\). It is
  not a product formula for arbitrary noncommuting Hamiltonians.
- Normalized trace divides the final trace; it does not rescale the matrix.
- Dimension zero returns zero by an explicit total convention.
- Basis invariance of normalized trace is not invariance of a probability
  law.
- Ordered energy levels and empirical spectral measures are finite spectral
  data. They do not by themselves establish level repulsion, universality, or
  chaotic dynamics.
- No spectral form factor, connected subtraction, out-of-time-order
  correlator, thermal state, random Hamiltonian law, ensemble average,
  large-\(n\) limit, or quantum-chaos predicate appears here.

## References

- O. Bohigas, M.-J. Giannoni, and C. Schmit, “Characterization of Chaotic
  Quantum Spectra and Universality of Level Fluctuation Laws,” *Physical
  Review Letters* 52 (1984), 1–4,
  [DOI 10.1103/PhysRevLett.52.1](https://doi.org/10.1103/PhysRevLett.52.1).
  The paper reports Gaussian-orthogonal-ensemble agreement for the level
  fluctuations of the quantum Sinai billiard; this candidate does not
  formalize that diagnostic or promote it to a general theorem.
- Jordan S. Cotler et al., “Black Holes and Random Matrices,” *Journal of High
  Energy Physics* 2017, article 118 (2017),
  [DOI 10.1007/JHEP05(2017)118](https://doi.org/10.1007/JHEP05%282017%29118).
  Its analytically continued trace diagnostics motivate later work; no
  spectral form factor is defined in this foundation.
- Mathlib contributors,
  [`Analysis.Normed.Algebra.MatrixExponential`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Normed/Algebra/MatrixExponential.lean),
  [`Algebra.Star.SelfAdjoint`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Algebra/Star/SelfAdjoint.lean), and
  [`LinearAlgebra.UnitaryGroup`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/LinearAlgebra/UnitaryGroup.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.

See the [Research Note]({{< relref
"/development-notebook/2026/08/shared-finite-dimensional-quantum-foundation-in-lean" >}})
for the declaration ledger and design decisions, or the
[glossary chapter]({{< relref
"/knowledge-base/glossary/finite-quantum-hamiltonian" >}}) for a shorter
orientation.
