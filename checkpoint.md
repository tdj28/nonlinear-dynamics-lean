# Project Checkpoint

> Living handoff for the formalization. Read this first, update it before every
> coherent milestone commit, and push the green milestone to `main`.

Last updated: 2026-07-20 23:13 PDT

Audited baseline: `main` at `ab28b91`

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
- Last green build: 2,124 Lean jobs; four substantive modules; four complete
  draft Notebook companions; 49 Hugo pages with warnings fatal.
- Lean inventory: 73 declaration lines across the four substantive modules;
  18 one-line deterministic placeholders; three `.gitkeep`-only Random
  branches; five `.gitkeep`-only Quantum Chaos branches.
- Proof holes: none (`sorry` and `admit` absent).
- Teaching snapshot: 18,010 words across the four Notebook companions and
  9,861 words across one Deep Dive and ten glossary chapters.
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

The root aggregator imports all four modules. The proof-to-prose manifest and
`scripts/check_lean_notebook_coverage.py` enforce paired coverage and named
declaration visibility.

## Completed Teaching Layer

- Four comprehensive Development Notebook chapters.
- One textbook-scale Deep Dive, *Random Matrices: From Outcomes to Spectra*.
- Ten glossary chapters, including measurable space, random matrix, Hermitian
  matrix, probability law, pushforward measure, trace power, and unitary
  invariance.
- Five deterministic 1200x630 social cards.
- Guided Hugo learning path with article orientation, progress, table of
  contents, code copy, teaching panels, glossary search, and responsive/print
  layouts.

## Exact Next Milestone

### RMT-02: Gaussian primitive variables

Pinned Mathlib reconnaissance recommends
`NonlinearDynamics.Random.GaussianPrimitives`, outside the matrix namespace:

1. Define an exact `HasRealGaussianLaw` predicate around `HasLaw X
   (gaussianReal m v) P`, with `v : ℝ≥0`. Keep ordinary `Measurable X`
   separate because `HasLaw` supplies only a.e. measurability.
2. Prove the exact-law consequences already supported by Mathlib: probability
   measure, mean, variance, finite `Lᵖ` membership, and qualitative
   `HasGaussianLaw` only after the parameterized law.
3. Bundle an indexed `IndependentRealGaussianFamily` with exact coordinate
   laws and `iIndepFun`; obtain its joint finite-product law and a canonical
   Gaussian product sample space.
4. Add only compiler-supported scaling and independent-sum closure needed by
   later complex coordinates. Preserve the zero-variance Dirac case.
5. Import the module through `NonlinearDynamics.Random`, write the complete
   paired Notebook chapter, and add Gaussian, variance, independence, and
   normalization Knowledge Base material.
6. Update this checkpoint, run strict validation, commit, and push to `main`.

This slice makes no complex-Gaussian, matrix-ensemble, GUE, density,
unitary-invariance, eigenvalue, expectation, or asymptotic claim. A later
`ComplexGaussian` module will define the complex law explicitly from independent
real and imaginary parts.

The normalization ledger must be chosen before a GUE constructor is named.

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
- [ ] Gaussian real primitives with exact laws and independence.
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

## Recent Pushes

- `ab28b91` — random-matrix formalization and guided learning-path milestone.
- `dcbb45e` — initial blog structure.
