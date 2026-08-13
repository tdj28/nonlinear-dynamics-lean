---
title: "A Shared Finite-Dimensional Quantum Foundation in Lean"
slug: "shared-finite-dimensional-quantum-foundation-in-lean"
date: 2026-08-13
summary: "The first QuantumChaos module reuses the checked Hermitian and spectral infrastructure, freezes exp(-itH), bundles unitary evolution, and aligns normalized trace with the zero-aware empirical spectrum."
lead: "The main result is an interface decision: one carrier, one evolution sign, one trace normalization, and one explicit dimension-zero policy before any chaos diagnostic is named."
draft: true
pro_reviewed: false
tags:
  - "Lean"
  - "Quantum chaos"
  - "Hamiltonians"
  - "Matrix exponential"
  - "Unitary evolution"
  - "Normalized trace"
lean_module: "NonlinearDynamics.QuantumChaos.FiniteSystems"
lean_source: "formalization/NonlinearDynamics/QuantumChaos/FiniteSystems.lean"
lean_snapshot: "/lean/NonlinearDynamics/QuantumChaos/FiniteSystems.lean"
lean_source_sha256: "022207ae5643acc87fc125f98974b20a8e56a24db14247f027f5547edaa1ff79"
toc: true
og_image: "shared-finite-dimensional-quantum-foundation-in-lean-card.png"
og_image_alt: "One Hermitian Hamiltonian feeds unitary evolution, normalized trace, and reused finite spectral data, with a boundary before quantum-chaos diagnostics."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed Research Note. Verify claims against the cited primary
sources and any released artifacts before relying on them.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This is a private AI-assisted working draft.
Professional review and pinned-toolchain validation remain pending, so
`pro_reviewed` remains false. The interface below is a source-only candidate.
{{< /panel >}}

## Abstract

`NonlinearDynamics.QuantumChaos.FiniteSystems` is the dependency root for the
project's later quantum-chaos branches. It does not define chaos. It chooses
the finite objects those branches must share:

- `FiniteHamiltonian n` is the existing intrinsic \(n\times n\) Hermitian
  Euclidean carrier;
- state evolution uses \(U_H(t)=\exp(-itH)\) in units \(\hbar=1\);
- evolution is bundled in `Matrix.unitaryGroup` and satisfies identity,
  addition, and time-reversal laws;
- normalized trace is \(n^{-1}\operatorname{Tr}\), totalized to zero at
  dimension zero; and
- the normalized Hamiltonian trace is identified with the first moment of the
  existing zero-aware empirical spectral measure.

The module deliberately leaves level spacings, unfolding, spectral form
factors, out-of-time-order correlators, ensemble averages, asymptotics, and
quantum-chaos criteria undefined.

## Why this interface precedes the diagnostics

The repository already contains substantial finite random-matrix
infrastructure. `HermitianEuclidean n` packages complex Hermitian matrices
with Frobenius geometry. `orderedHermitianEigenvalues` supplies a decreasing
real spectrum. `empiricalSpectralMeasure` is zero in dimension zero and a
probability measure in positive dimension. Its first two moments have exact
trace formulas, and its dependence on the matrix is measurable.

Creating parallel `QuantumHamiltonian`, `QuantumSpectrum`, and
`QuantumEmpiricalMeasure` structures would split the API before the first
diagnostic theorem. The candidate instead adds one transparent semantic alias
and uses the existing conversions and spectral observables.

{{< reference-figure
  wide="true"
  src="api-reuse-map.svg"
  alt="The existing Hermitian Euclidean carrier, ordered eigenvalue vector, and zero-aware empirical spectral measure remain in the random-matrix layer; the new finite-systems module adds only Hamiltonian semantics, the minus-i-time generator, bundled unitary evolution, and normalized trace."
  caption="**Reuse map:** checked random-matrix geometry and spectra remain authoritative. The quantum foundation adds semantic and dynamical structure without forking the carrier or spectral representation."
>}}

## Frozen decisions

| Question | Candidate decision | Boundary it prevents |
|---|---|---|
| Hamiltonian carrier | `RandomMatrix.HermitianEuclidean n` through a transparent abbreviation | Duplicate matrix and spectrum structures |
| Hermitian hypothesis | Stored in the carrier, not passed theorem by theorem | Evolution from an unchecked ambient matrix |
| State-evolution sign | \(U_H(t)=e^{-itH}\) | Silent mixing of state and observable conventions |
| Units | \(\hbar=1\) | A hidden dimensional constant in later formulas |
| Evolution result | `Matrix.unitaryGroup (Fin n) ℂ` | Separating the matrix from its unitary certificate |
| Trace convention | \(\tau_n(A)=n^{-1}\operatorname{Tr}(A)\) | Confusing raw and normalized trace |
| Dimension zero | Reciprocal is zero, so normalized trace and empirical measure are zero | Informal division by zero |
| Spectrum | Reuse ordered eigenvalues and empirical measure | A second eigenvalue ordering or multiplicity policy |

The sign and trace choices are conventions. The Hermitian-to-unitary theorem
and the trace identities are mathematical consequences once those conventions
are fixed.

## The two-level benchmark

For

\[
H=\operatorname{diag}(1,-1),
\]

the generator is

\[
G_H(t)=-itH=\operatorname{diag}(-it,it),
\]

and

\[
U_H(t)=\operatorname{diag}(e^{-it},e^{it}).
\]

At \(t=\pi/2\), the exact matrix is
\(\operatorname{diag}(-i,i)\), whose conjugate transpose times itself is the
identity. The ordered spectrum is \((1,-1)\), the normalized trace is zero,
and the empirical spectral measure
\(\frac12(\delta_1+\delta_{-1})\) has first moment zero.

The bounded `Std` worksheet checks the stored Gaussian-integer matrix
multiplication and trace ledger. It does not implement analytic matrix
exponentiation. The full project source handles arbitrary finite Hermitian
matrices through Mathlib's exponential API.

## Declaration ledger

The candidate has eighteen documented public declarations.

| Declaration | Role |
|---|---|
| `FiniteHamiltonian` | Transparent semantic alias for the existing Hermitian carrier |
| `hamiltonianMatrix` | Intrinsic-to-ambient matrix projection |
| `hamiltonianMatrix_isHermitian` | Stored Hermitian certificate |
| `schrodingerGenerator` | The real-time generator \(-t(iH)\) |
| `schrodingerGenerator_mem_skewAdjoint` | Hermitian-to-skew-adjoint bridge |
| `schrodingerGenerator_zero` | Zero-time generator identity |
| `schrodingerGenerator_add` | Additivity in time |
| `schrodingerGenerator_commute` | Same-Hamiltonian generators commute |
| `timeEvolutionMatrix` | Ambient matrix exponential |
| `timeEvolution` | Bundled unitary exponential |
| `timeEvolution_coe` | Coercion exposes the ambient exponential |
| `timeEvolution_zero` | \(U_H(0)=1\) |
| `timeEvolution_add` | \(U_H(s+t)=U_H(s)U_H(t)\) |
| `timeEvolution_neg` | \(U_H(-t)=U_H(t)^{-1}\) |
| `normalizedTrace` | Reciprocal-dimension complex trace |
| `normalizedTrace_zero_dimension` | Explicit zero-dimensional value |
| `normalizedTrace_unitary_conjugation` | Basis invariance of normalized trace |
| `normalizedTrace_hamiltonian_eq_empiricalSpectralMoment_one` | Spectral first-moment bridge |

Five `#print axioms` commands audit the main carrier, generator, evolution,
inverse, and spectral-trace endpoints. Their output remains pending the
pinned-toolchain Linux leaf check.

## Proof architecture

The central proof has four steps.

1. The carrier provides \(H^*=H\).
2. Since complex conjugation sends \(i\) to \(-i\), the matrix
   \(-t(iH)\) is skew-adjoint.
3. Mathlib's `exp_mem_unitary_of_mem_skewAdjoint` bundles its exponential as a
   unitary matrix.
4. The two generators \(G_H(s)\) and \(G_H(t)\) commute because both are
   scalar multiples of \(iH\). `Matrix.exp_add_of_commute` then gives the
   addition law.

Time reversal is derived inside the unitary group from
\(U_H(t)U_H(-t)=U_H(0)=1\). It is not a second analytic proof.

For normalized trace, cyclicity gives

\[
\operatorname{Tr}(UAU^*)
=\operatorname{Tr}(U^*UA)
=\operatorname{Tr}(A).
\]

The spectral bridge is statement reuse: the earlier theorem already identifies
the first empirical spectral moment with the same reciprocal-dimension trace
expression.

{{< reference-figure
  wide="true"
  src="proof-obligation-map.svg"
  alt="A proof map starts with Hermitian H, turns iH into a skew-adjoint generator, applies the exponential theorem to get a unitary, uses same-Hamiltonian commutation for the addition law, and separately uses trace cyclicity plus the existing empirical moment theorem."
  caption="**Two proof paths:** skew-adjointness controls evolution, while trace cyclicity and an imported spectral theorem control normalized observables. Neither path supplies a chaos diagnostic."
>}}

## Source-level risk before validation

The candidate intentionally uses Mathlib's scoped operator norm for the
matrix exponential. The public matrix-exponential lemmas hide that otherwise
noncanonical matrix-norm choice, but elaboration against the pinned revision
must still confirm the selected instances and coercions.

The most likely proof seams are statement-preserving:

- coercion between the bundled unitary and its ambient matrix;
- scalar tower normalization in \(-t(iH)\);
- orientation of the group inverse lemma; and
- trace-cycle reassociation around \(U^*U=1\).

The exact candidate still requires a warning-fatal check with the repository's
pinned Lean and Mathlib versions. The public status remains source-only
candidate until that reproducible check passes.

## In Lean

{{< lean-bridge
  human="A Hermitian Hamiltonian makes the minus-i-time generator skew-adjoint."
  math="\(H^*=H\Longrightarrow(-itH)^*=-(-itH).\)"
  lean="theorem schrodingerGenerator_mem_skewAdjoint {n : ℕ}\n    (H : FiniteHamiltonian n) (t : ℝ) :\n    schrodingerGenerator H t ∈\n      skewAdjoint (Matrix (Fin n) (Fin n) ℂ)"
>}}
Membership in `skewAdjoint` is the exact premise consumed by Mathlib's
unitary-exponential theorem.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Normalized trace is unchanged by a unitary change of basis."
  math="\(\tau_n(UAU^*)=\tau_n(A).\)"
  lean="theorem normalizedTrace_unitary_conjugation {n : ℕ}\n    (U : Matrix.unitaryGroup (Fin n) ℂ)\n    (A : Matrix (Fin n) (Fin n) ℂ) :\n    normalizedTrace ((U : Matrix (Fin n) (Fin n) ℂ) * A * Uᴴ) =\n      normalizedTrace A"
>}}
The explicit coercion turns the bundled unitary into an ambient matrix.
`Uᴴ` is its conjugate transpose, and trace cyclicity moves it next to `U`.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.QuantumChaos.FiniteSystems

open NonlinearDynamics.QuantumChaos

#print FiniteHamiltonian
#print schrodingerGenerator
#print timeEvolution
#check timeEvolution_add
#check timeEvolution_neg
#print normalizedTrace
#check normalizedTrace_unitary_conjugation
#check normalizedTrace_hamiltonian_eq_empiricalSpectralMoment_one
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
The warning-fatal leaf check will ask Lean's elaborator to construct candidate
proof terms and its kernel to check them against all eighteen declarations.
It does not audit whether a physical Hamiltonian is an adequate model, and it
does not turn finite spectral data into evidence of chaos.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/QuantumChaos/FiniteSystems.lean
```

## Scope ledger

Established by the candidate statements, once compiled:

- reuse of the checked finite Hermitian carrier;
- the \(e^{-itH}\), \(\hbar=1\) convention;
- skew-adjointness of the generator;
- unitary finite evolution;
- zero, addition, and inverse-time laws;
- total reciprocal-dimension normalized trace;
- unitary-conjugation invariance of that trace; and
- equality with the first zero-aware empirical spectral moment.

Not established:

- Schrödinger-equation existence or differentiability for state vectors;
- time-dependent Hamiltonians or time ordering;
- density matrices, thermal states, or expectation values in a chosen state;
- level spacings, unfolding, spectral rigidity, or level repulsion;
- spectral form factors, connected subtractions, or smoothing conventions;
- out-of-time-order correlators or operator-growth bounds;
- a GUE law for a chosen physical Hamiltonian;
- finite-to-asymptotic universality; or
- any predicate or theorem asserting quantum chaos.

## References

- O. Bohigas, M.-J. Giannoni, and C. Schmit, “Characterization of Chaotic
  Quantum Spectra and Universality of Level Fluctuation Laws,” *Physical
  Review Letters* 52 (1984), 1–4,
  [DOI 10.1103/PhysRevLett.52.1](https://doi.org/10.1103/PhysRevLett.52.1).
  Its finite billiard calculation motivates the later spectral-statistics
  branch; the present module does not formalize the paper's diagnostic.
- Jordan S. Cotler et al., “Black Holes and Random Matrices,” *Journal of High
  Energy Physics* 2017, article 118 (2017),
  [DOI 10.1007/JHEP05(2017)118](https://doi.org/10.1007/JHEP05%282017%29118).
  The paper's analytically continued trace quantities motivate a later
  spectral-form-factor interface, not a theorem in this candidate.
- Mathlib contributors,
  [`Analysis.Normed.Algebra.MatrixExponential`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Normed/Algebra/MatrixExponential.lean),
  [`Analysis.Normed.Algebra.Exponential`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Normed/Algebra/Exponential.lean),
  [`LinearAlgebra.Matrix.Hermitian`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/LinearAlgebra/Matrix/Hermitian.lean), and
  [`LinearAlgebra.UnitaryGroup`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/LinearAlgebra/UnitaryGroup.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.

The [Deep Dive]({{< relref
"/knowledge-base/deep-dives/finite-hamiltonians-unitary-evolution-and-normalized-trace" >}})
teaches the two-level example and bounded worksheet. The
[finite quantum Hamiltonian glossary chapter]({{< relref
"/knowledge-base/glossary/finite-quantum-hamiltonian" >}}) provides the short
definition and convention ledger.
