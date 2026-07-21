# Project Checkpoint

> Living handoff for the formalization. Read this first, update it before every
> coherent milestone commit, and push the green milestone to `main`.

Last updated: 2026-07-21 00:04 PDT

Audited baseline: `main` at `dded074`

Active direction: finite random-matrix foundations toward an explicit GUE law

## How to Use This Checkpoint

- Treat the verified state below as the starting point for the next session.
- Complete work in vertical slices: Lean module, Notebook companion,
  Knowledge Base integration, validation, checkpoint update, commit, push.
- Update the exact next milestone whenever a dependency or convention choice
  changes.
- Do not mark a topic complete because a directory or placeholder file exists.

## Verified State

- Lean toolchain: Lean 4.32.0 through elan.
- Library: Mathlib 4.32.0, pinned by `formalization/lakefile.toml`.
- Full validation command: `make check`.
- Last green build: 3,138 Lean jobs; five substantive modules; five complete
  draft Notebook companions; 61 Hugo pages with warnings fatal.
- Lean inventory: 98 declaration lines across the five substantive modules;
  18 one-line deterministic placeholders; three `.gitkeep`-only Random
  branches; five `.gitkeep`-only Quantum Chaos branches.
- Proof holes: none (`sorry` and `admit` absent).
- Teaching snapshot: 25,112 words across the five Notebook companions and
  18,858 words across two Deep Dives and fourteen glossary chapters.
- Publication status: all new research prose remains `draft: true` and
  `pro_reviewed: false` pending human review.
- Preview: `make blog-serve` locally or `make blog-serve-tailscale` privately on
  port 1333.

## Completed Lean Vertical Slices

| Module | Checked contribution | Paired Notebook |
|---|---|---|
| `NonlinearDynamics.Random.RandomMatrices.Basic` | Matrix-valued maps, entrywise measurable space, measurable operations, unnormalized Hermitian symmetrization | `random-matrices-as-measurable-maps` |
| `NonlinearDynamics.Random.RandomMatrices.Hermitian` | Pointwise and a.e. Hermiticity, bundled measurable Hermitian matrices, real diagonals/traces, congruence | `hermitian-random-matrices` |
| `NonlinearDynamics.Random.RandomMatrices.Laws` | Pushforward laws, composition, probability/Dirac rules, measurable congruence, unitary-invariance interface | `from-random-matrices-to-laws` |
| `NonlinearDynamics.Random.RandomMatrices.Observables` | Measurable matrix powers and trace powers, Hermitian reality pointwise and a.e. | `trace-power-observables` |
| `NonlinearDynamics.Random.GaussianPrimitives` | Exact real Gaussian laws, moments and integrability, zero-variance behavior, scaling and independent sums, measurable independent families, finite joint product laws, and a canonical product sample space | `gaussian-primitives-exact-laws-and-independence` |

The root aggregator imports all five modules. The proof-to-prose manifest and
`scripts/check_lean_notebook_coverage.py` enforce paired coverage and named
declaration visibility.

## Completed Teaching Layer

- Five comprehensive Development Notebook chapters.
- Two textbook-scale Deep Dives: *Random Matrices: From Outcomes to Spectra*
  and *Gaussian Laws, Independence, and Normalization*.
- Fourteen glossary chapters, now including Gaussian distribution, variance,
  independence, and normalization convention alongside the matrix and
  measure-theory foundations.
- Eleven deterministic 1200x630 social cards and five accessible conceptual
  SVG figures.
- Guided Hugo learning path with article orientation, progress, table of
  contents, code copy, teaching panels, glossary search, and responsive/print
  layouts. Rendered desktop and 390-pixel mobile QA found and fixed article
  overflow while retaining local scrolling for wide tables and diagrams.

## Exact Next Milestone

### RMT-03: complex Gaussian primitives with an explicit variance split

The next module is `NonlinearDynamics.Random.ComplexGaussian`. It must build a
complex law from two exact real Gaussian laws rather than rely on an ambiguous
phrase such as "standard complex Gaussian":

1. Define `cartesianComplexGaussian m vRe vIm` on `ℂ` by mapping the product of
   `gaussianReal m.re vRe` and `gaussianReal m.im vIm` through the measurable
   equivalence from `ℝ × ℝ` to `ℂ`.
2. Define an exact `HasCartesianComplexGaussianLaw Z m vRe vIm P` predicate
   around that measure. "Cartesian" records independent coordinate axes; it
   does not claim circular symmetry or properness. Keep ordinary measurability
   separate from the a.e. measurability carried by `HasLaw`, as in the real
   layer.
3. Prove the probability-measure fact and exact real-part and imaginary-part
   laws, means, variances, and independence. State only moment or qualitative
   Gaussian consequences that compile against the pinned Mathlib API.
4. Construct the complex variable `X + Y * I` from ordinarily measurable,
   independent real variables with exact Gaussian laws, and prove its exact
   complex law.
5. Keep `vRe` and `vIm` visible in every public interface. Record the two
   common symmetric choices, component variance `1/2` versus `1`, in prose,
   but do not bless either as the GUE convention yet.
6. Import the module through `NonlinearDynamics.Random`, pair it with a complete
   Notebook chapter and textbook integration, run strict validation, update
   this checkpoint, commit, and push to `main`.

This slice will still make no matrix-ensemble, GUE, density,
unitary-invariance, eigenvalue, matrix-observable expectation, trace-moment, or
asymptotic claim. The normalization ledger and zero-dimensional policy must be
approved before a GUE constructor is named.

## Dependency-Ordered Roadmap

The program order is:

1. finish finite random-matrix probability through a checked GUE law and its
   first integrable trace moments;
2. build the common deterministic discrete API, then stability, attraction,
   Lyapunov, conjugacy, chaos, coding, models, and bifurcation;
3. build ODE existence and flow infrastructure before ODE stability,
   Lyapunov theory, and concrete vector fields;
4. develop deterministic matrix products before measurable random products,
   cocycles, Lyapunov growth, and a precisely chosen stochastic-stability
   notion;
5. establish finite-dimensional quantum evolution, states, spectra, and
   empirical spectral measures; and
6. layer spectral statistics, GUE diagnostics, spectral form factors, OTOCs,
   and exact then approximate k-invariance on those foundations.

Later tracks may begin only where their definitions do not silently choose an
unresolved convention or depend on an unproved earlier interface.

### Random matrices and random dynamics

- [x] Matrix measurability and algebraic closure.
- [x] Hermitian structure and deterministic congruence.
- [x] Pushforward laws and unitary-invariance interface.
- [x] Trace-power observables before expectation.
- [x] Gaussian real primitives with exact laws and independence.
- [ ] Complex Gaussian primitives with explicit variance splitting.
- [ ] Finite independent Gaussian families and scaled-entry integrability.
- [ ] Finite-dimensional GUE constructor under an approved normalization
  ledger and an explicit `n = 0` policy.
- [ ] Hermitian support and nontrivial unitary invariance of the GUE law.
- [ ] First exact expected trace moments, then eigenvalue measurability and an
  empirical spectral measure.
- [ ] Deterministic matrix-product inequalities, then measurable random
  products.
- [ ] Random cocycles over a measure-preserving base and finite-time
  Lyapunov-growth interfaces.
- [ ] Subadditive or multiplicative-ergodic infrastructure before asymptotic
  exponents.
- [ ] One explicitly selected meaning of stochastic stability.

### Deterministic discrete dynamics

The following files exist only as one-line documentation placeholders:

- [ ] `Discrete/Stability.lean`
- [ ] `Discrete/Attraction.lean`
- [ ] `Discrete/Lyapunov.lean`
- [ ] `Discrete/Conjugacy.lean`
- [ ] `Discrete/Bifurcation.lean`
- [ ] `Chaos/Sensitivity.lean`
- [ ] `Chaos/Devaney.lean`
- [ ] `Chaos/SymbolicCoding.lean`

### ODEs and concrete models

These files are also placeholders:

- [ ] `ODE/GlobalExistence.lean`
- [ ] `ODE/ToFlow.lean`
- [ ] `ODE/Stability.lean`
- [ ] `ODE/Lyapunov.lean`
- [ ] `Models/LogisticMap.lean`
- [ ] `Models/TentMap.lean`
- [ ] `Models/LogisticODE.lean`
- [ ] `Models/Pendulum.lean`
- [ ] `Models/LotkaVolterra.lean`
- [ ] `Models/Lorenz.lean`

### Quantum chaos

Only placeholder directories currently exist:

- [ ] `QuantumChaos/SpectralStatistics`
- [ ] `QuantumChaos/GUE`
- [ ] `QuantumChaos/SpectralFormFactor`
- [ ] `QuantumChaos/OTOC`
- [ ] `QuantumChaos/KInvariance`

Core GUE probability belongs in `Random/RandomMatrices`; the quantum-chaos
track should consume it rather than redefine it.

Before those branches become substantive, add shared finite-dimensional
infrastructure for Hermitian Hamiltonians, matrix-exponential evolution,
normalized trace states, ordered spectra, and measurable empirical spectral
data. Spectral statistics precede GUE specializations; finite-matrix bounds
precede ensemble-averaged spectral form factors and OTOCs; exact moment-operator
k-invariance precedes approximation claims.

## Decision Ledger

- `RandomMatrix` is a carrier map until measurability is proved or bundled.
- The project matrix measurable space is entrywise and currently project-owned.
- Hermitian symmetrization is `X + Xᴴ`, explicitly unnormalized.
- Congruence `AHAᴴ` preserves Hermiticity for arbitrary finite `A`; this is not
  unitary or distributional invariance.
- A matrix law is a pushforward on the full ambient matrix space.
- Unitary invariance means equality of measures under every deterministic
  unitary conjugation.
- Trace powers are measurable observables, not expectations or moments until a
  probability measure and integrability are supplied.
- A real Gaussian primitive is an exact `HasLaw` for `gaussianReal m v` before
  it is treated qualitatively as Gaussian; the `NNReal` parameter is variance,
  and `v = 0` is the Dirac law at the mean.
- `HasLaw` supplies a.e. measurability, not ordinary measurability. The
  independent-family bundle records ordinary coordinate measurability
  separately.
- The empty scalar Gaussian product is the Dirac mass at the unique empty
  tuple. This does not decide the later zero-dimensional matrix policy.
- No GOE/GUE normalization has been selected yet.
- GUE construction has an open representation gate: independent entries are
  convenient for coordinates, while an isotropic Gaussian measure on the real
  Hermitian space makes unitary invariance cleaner. If both are used, their
  equivalence must be proved.
- The candidate Wigner-scaled convention, still unapproved, has diagonal
  variance `1 / n`, off-diagonal real and imaginary variances `1 / (2n)`, and
  an order-one empirical spectrum. The density, trace normalization, and
  zero-dimensional case must agree with that choice.
- The deterministic layer must choose point versus invariant-set stability,
  forward versus two-sided time, and metric versus neighborhood formulations.
- Devaney chaos must record whether sensitivity is assumed or derived under a
  no-isolated-points hypothesis; bifurcation must distinguish an abstract
  topological interface from differentiable normal forms.
- Spectrum work must choose an eigenvalue enumeration or multiset/empirical
  measure interface before defining unfolding.
- `StochasticStability` is currently ambiguous among random-Jacobian bounds,
  persistence of invariant measures under noise, and random attractors.
- Quantum diagnostics must fix raw versus normalized traces, state and unit
  conventions, connected versus unconnected spectral form factors, OTOC order
  and sign, and the norm used for approximate k-invariance.

## Open Risks and Nonclaims

- GUE conventions differ. Do not choose variances or dimension scaling
  implicitly.
- Mathlib's `Measure.map` is total and has fallback behavior outside the
  a.e.-measurable case. Keep measurability evidence explicit.
- Eigenvalue measurability, ordering, multiplicity, and spectral scaling remain
  unformalized.
- Quantum-chaos universality claims are not general theorems in this project.
- The deterministic placeholder tree has no substantive definitions yet.

## Validation Snapshot

Run before every push:

```sh
make check
git diff --check
```

For each changed module, also run:

```sh
cd formalization
lake env lean -DwarningAsError=true path/to/Module.lean
```

Checkpoint/skill milestone QA:

- official project-skill structural validator: passed;
- fresh-agent forward test: recovered RMT-02, the local API-first workflow,
  proof-to-prose contract, validation gates, and safe push procedure;
- independent repository audit: matched the substantive/placeholder inventory
  and exposed the decision gates now recorded above.
- RMT-02 Lean audit: exact-law and edge-case claims match the checked module,
  every named declaration has paired prose, warnings-as-errors checks pass,
  and no nonstandard axioms or proof holes were introduced.
- RMT-02 teaching audit: all six cards reproduce byte-for-byte, all five SVGs
  parse, KaTeX delimiters balance, Hugo renders 61 pages with warnings fatal,
  and desktop plus mobile browser QA reports no page-level overflow or broken
  rendered assets.

## Recent Pushes

- `dded074` — living checkpoint and project research/formalization skill.
- `ab28b91` — random-matrix formalization and guided learning-path milestone.
- `dcbb45e` — initial blog structure.
