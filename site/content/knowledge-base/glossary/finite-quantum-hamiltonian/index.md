---
title: "Finite quantum Hamiltonian"
slug: "finite-quantum-hamiltonian"
summary: "A finite complex Hermitian matrix interpreted as an energy operator, with a fixed exp(-itH) time-evolution convention."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.QuantumChaos.FiniteSystems"
tags:
  - "Quantum chaos"
  - "Hamiltonians"
  - "Hermitian matrices"
  - "Unitary evolution"
  - "Normalized trace"
og_image: "finite-quantum-hamiltonian-card.png"
og_image_alt: "A two-level Hermitian Hamiltonian sends energies one and minus one to opposite unit-circle phase rotations."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this chapter. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed glossary chapter. Verify claims against the cited primary
sources and any released artifacts before relying on them.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial and validation status.** This is a private AI-assisted working
chapter. The warning-fatal pinned-toolchain leaf passes; the exact-commit full
repository gate and professional review remain pending, so
<code>pro_reviewed</code> remains false.
{{< /panel >}}

A **finite quantum Hamiltonian** in this project is an \(n\times n\) complex
{{< refterm "hermitian-matrix" "Hermitian matrix" >}} interpreted as an
energy operator. Hermitian means

\[
H^*=H,
\]

where \(H^*\) is the conjugate transpose. The condition gives real eigenvalues
and makes the fixed time-evolution convention unitary.

## A two-level example

Take

\[
H=\begin{pmatrix}1&0\\0&-1\end{pmatrix}.
\]

The two energy levels are \(1\) and \(-1\). In units where \(\hbar=1\), the
project defines

\[
U_H(t)=e^{-itH}
=\begin{pmatrix}e^{-it}&0\\0&e^{it}\end{pmatrix}.
\]

At \(t=\pi/2\), the phase factors are \(-i\) and \(i\). Their absolute values
are one, and multiplication gives \(U_H(t)^*U_H(t)=I_2\).

The normalized trace is

\[
\tau_2(H)=\frac12\operatorname{Tr}(H)
=\frac12(1-1)=0.
\]

This number also equals the mean of the two energy levels. It does not say the
Hamiltonian itself is the zero matrix.

{{< reference-figure
  wide="true"
  src="finite-hamiltonian-map.svg"
  alt="A diagonal two-level Hermitian matrix has energy levels one and minus one, which acquire opposite phase rotations under exp minus i t H; normalized trace averages the two levels to zero."
  caption="**One matrix, three views:** the Hermitian matrix stores the operator, the real eigenvalues store finite spectral data, and the unitary exponential stores time evolution. Normalized trace averages the levels without changing the matrix."
>}}

## The four conventions to keep visible

1. **Carrier.** `FiniteHamiltonian n` is a transparent abbreviation for the
   existing intrinsic Hermitian carrier. It does not duplicate the
   random-matrix representation.
2. **Time and sign.** Time is real and evolution is \(e^{-itH}\), with
   \(\hbar=1\).
3. **Trace.** `normalizedTrace A` means
   \(n^{-1}\operatorname{Tr}(A)\), not a rescaling of \(A\).
4. **Dimension zero.** The total Lean definition returns zero when \(n=0\),
   matching the project's zero empirical spectral measure.

## In Lean

{{< lean-bridge
  human="The exponential of the skew-adjoint Schrödinger generator is bundled as a unitary matrix."
  math="\(H^*=H\Longrightarrow U_H(t)=e^{-itH}\in U(n).\)"
  lean="noncomputable def timeEvolution {n : ℕ}\n    (H : FiniteHamiltonian n) (t : ℝ) :\n    Matrix.unitaryGroup (Fin n) ℂ"
>}}
`noncomputable` permits Mathlib's analytic matrix exponential,
`Matrix.unitaryGroup` stores the matrix with its unitary certificate, and
`Fin n` is the finite row and column index.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Reversing time gives the inverse evolution."
  math="\(U_H(-t)=U_H(t)^{-1}.\)"
  lean="theorem timeEvolution_neg {n : ℕ}\n    (H : FiniteHamiltonian n) (t : ℝ) :\n    timeEvolution H (-t) = (timeEvolution H t)⁻¹"
>}}
The superscript `⁻¹` is group inverse in the unitary group. The proof uses the
already established addition law at \(t+(-t)=0\).
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.QuantumChaos.FiniteSystems

open NonlinearDynamics.QuantumChaos

#check FiniteHamiltonian
#check hamiltonianMatrix_isHermitian
#check timeEvolution
#check timeEvolution_add
#check timeEvolution_neg
#check normalizedTrace
#check normalizedTrace_hamiltonian_eq_empiricalSpectralMoment_one
~~~

This is a **full project check** on macOS or Linux. It uses the pinned Lean and
Mathlib dependencies and may require substantial disk space or build time.

{{< repo-check >}}
Lean's elaborator constructs candidate proof terms and its kernel checks them
against the finite-matrix statements. It does not establish that a chosen
physical system is chaotic or that its Hamiltonian follows a random ensemble.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/QuantumChaos/FiniteSystems.lean
```

Continue with the [Deep Dive]({{< relref
"/knowledge-base/deep-dives/finite-hamiltonians-unitary-evolution-and-normalized-trace" >}})
for the two-level worksheet, exponential proof architecture, and complete
claim boundary.

## Boundary cases and nonclaims

- A non-Hermitian matrix is not accepted as a `FiniteHamiltonian`.
- The sign \(e^{-itH}\) is a convention for state evolution; formulas using
  the opposite sign require an explicit translation.
- The addition law is for one fixed Hamiltonian. Different Hamiltonians need
  a commutation hypothesis or a different argument.
- Normalized trace and matrix normalization are different operations.
- Zero dimension is a total algebraic boundary, not a physical-system claim.
- A finite energy list does not establish level repulsion, random-matrix
  universality, thermalization, or quantum chaos.

## References

- O. Bohigas, M.-J. Giannoni, and C. Schmit, “Characterization of Chaotic
  Quantum Spectra and Universality of Level Fluctuation Laws,” *Physical
  Review Letters* 52 (1984), 1–4,
  [DOI 10.1103/PhysRevLett.52.1](https://doi.org/10.1103/PhysRevLett.52.1).
- Jordan S. Cotler et al., “Black Holes and Random Matrices,” *Journal of High
  Energy Physics* 2017, article 118 (2017),
  [DOI 10.1007/JHEP05(2017)118](https://doi.org/10.1007/JHEP05%282017%29118).
- Mathlib contributors,
  [`Analysis.Normed.Algebra.MatrixExponential`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Normed/Algebra/MatrixExponential.lean)
  and
  [`LinearAlgebra.UnitaryGroup`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/LinearAlgebra/UnitaryGroup.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.
