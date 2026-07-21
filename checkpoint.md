# Project Checkpoint

> Living handoff for the formalization. Read this first, update it before every
> coherent milestone commit, and push the green milestone to `main`.

Last updated: 2026-07-21 08:23 PDT

Audited baseline: `main` at `349665d`

Active direction: finite-time norm and extended-log-norm cocycle observables

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
- Last green Lean build: 3,161 jobs. The integrated RMT-13 gate covers eighteen
  substantive modules, eighteen complete draft Notebook companions, and 193
  Hugo pages with warnings fatal.
- Lean inventory: 349 public named declarations across the eighteen substantive
  modules; 18 one-line deterministic placeholders; one `.gitkeep`-only
  Random branch; five `.gitkeep`-only Quantum Chaos branches.
- Proof holes: none (`sorry` and `admit` absent).
- Teaching snapshot: 103,054 words across the eighteen Notebook companions and
  113,706 words across fifteen Deep Dives and twenty-eight glossary chapters.
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
| `NonlinearDynamics.Random.ComplexGaussian` | Exact Cartesian complex Gaussian laws with explicit coordinate variances, product and marginal laws, coordinate independence, real-Banach Gaussianity, moments and integrability, exact mean, the double-zero Dirac boundary, and construction from independent exact real coordinates | `complex-gaussians-from-independent-real-coordinates` |
| `NonlinearDynamics.Random.ComplexGaussianFamilies` | Ordinarily measurable mutually independent Cartesian complex coordinates, exact real and imaginary laws and variances, coordinate means and integrability, honest construction from independent pair-vectors, real scaling, finite joint product and qualitative Gaussian laws, a canonical product family, and the empty-index Dirac boundary | `independent-complex-gaussian-families` |
| `NonlinearDynamics.Random.RandomMatrices.HermitianCoordinates` | Finite strict-upper indices, real-diagonal/complex-upper coordinate space, direct three-branch Hermitian assembly, exact entry formulas, Hermiticity, measurability, bundled construction, and the `n = 0` zero matrix | `hermitian-coordinate-assembly` |
| `NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsemble` | Explicit Wigner variance ledger, canonical independent Gaussian coordinate law, block/scalar laws and independence, measurable Hermitian pushforward matrix law, exact diagonal and strict-upper marginals, and coordinate/matrix Dirac laws at `n = 0` | `finite-gue-law-from-coordinates` |
| `NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleGeometry` | Frobenius Euclidean matrix carrier, intrinsic real Hermitian subspace, trace pairing, ambient and intrinsic unitary-congruence isometries, intrinsic standard-Gaussian invariance, and measurable mass-one Hermitian support of the ambient GUE law | `gue-frobenius-geometry-and-hermitian-support` |
| `NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleInvariance` | Normalized real Hermitian coordinates, Frobenius linear isometric equivalence, exact full-product decoding, scaled intrinsic standard-Gaussian representation, intrinsic probability and zero-dimensional laws, and ambient unitary-conjugation invariance | `gue-unitary-invariance-from-normalized-coordinates` |
| `NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleMoments` | Complex Bochner integrability of the first two trace-power observables and the exact finite identities `E[Tr H] = 0` and `E[Tr(H²)] = n`, uniformly including dimension zero | `gue-first-exact-trace-moments` |
| `NonlinearDynamics.Random.RandomMatrices.HermitianSpectrum` | Decreasingly ordered real Hermitian eigenvalues with multiplicity, trace and trace-square sums, unitary-congruence invariance, spectral counting and zero-aware empirical measures, positive-dimensional probability packaging, and conditional Giry/ambient-law bridges | `ordered-hermitian-spectra-and-empirical-measures` |
| `NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity` | Frobenius control of every ordered Hermitian eigenvalue through a dimension-forced min-max witness, coordinate and finite-sup-vector `LipschitzWith 1`, continuity, unconditional measurability of the spectral measure maps, and the unconditional ambient/intrinsic GUE pushforward bridge | `hermitian-spectral-perturbation-and-measurability` |
| `NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleSpectrum` | Named finite-GUE empirical spectral law, all-dimensional outer probability packaging, successor-dimensional probability-measure-valued law, intrinsic/ambient agreement, zero-dimensional Dirac boundary, Giry mean measure, sample moments as normalized trace powers, integrability, and exact expected first and second moments | `finite-gue-empirical-spectral-laws-and-moments` |
| `NonlinearDynamics.Random.MatrixProducts.FiniteProducts` | Semiring-valued ordered forward products, zero/successor/one-step/constant/split identities, chronological vector action, and finite-time induced infinity operator-norm product and uniform-power bounds in positive dimension | `ordered-finite-matrix-products-and-growth-bounds` |
| `NonlinearDynamics.Random.MatrixProducts.MeasurableFiniteProducts` | Semiring-valued pointwise sample products, exact finite-prefix measurability for complex random matrices, proof-carrying pushforward laws, zero/one-horizon identities, raw mass-one evidence, and bundled probability laws without a positive-dimension restriction | `measurable-finite-matrix-products-and-pushforward-laws` |
| `NonlinearDynamics.Random.RandomCocycles.Discrete` | Generator-presented one-sided cocycles, forward-orbit factors, zero/successor/one/add identities, exact later-block-left cocycle law, complex measurability, and measure-preserving natural iterates without probability, invertibility, or positive-dimension assumptions | `one-sided-discrete-matrix-cocycles-over-measure-preserving-bases` |

The root aggregator imports all eighteen modules. The proof-to-prose manifest and
`scripts/check_lean_notebook_coverage.py` enforce paired coverage and named
declaration visibility.

## Completed Teaching Layer

- Eighteen comprehensive Development Notebook chapters in an explicit
  dependency-ordered previous/next sequence.
- Fifteen textbook-scale Deep Dives: *Random Matrices: From Outcomes to Spectra*,
  *Gaussian Laws, Independence, and Normalization*, *Complex Gaussian
  Coordinates and Geometry*, *Finite Product Probability Spaces and
  Independent Gaussian Fields*, *Finite Hermitian Matrices from Coordinates*,
  *Finite GUE from Independent Gaussian Coordinates*, and *Intrinsic Hermitian
  Gaussian Symmetry and Matrix-Law Support*, followed by *From Normalized
  Hermitian Coordinates to Gaussian Unitary Ensemble Invariance*, *First
  Exact Finite Gaussian Unitary Ensemble Trace Moments*, and *Finite Hermitian
  Spectra and Empirical Measures*, *Hermitian Spectral Perturbation,
  Continuity, and Measurability*, and *Finite Gaussian Unitary Ensemble
  Empirical Spectral Laws and Normalized Moments*, and *Ordered Finite Matrix
  Products and Operator-Norm Growth*, and *Measurable Finite Random-Matrix
  Products and Proof-Carrying Pushforward Laws*, and *Generator-Presented
  One-Sided Discrete Matrix Cocycles*.
- Twenty-eight glossary chapters, now including one-sided discrete matrix
  cocycles, finite random-matrix products,
  forward matrix products, and the induced infinity operator norm, as well as
  empirical spectral laws, Weyl
  eigenvalue perturbation, empirical spectral measures, finite matrix trace
  moments, and normalized Hermitian coordinates
  alongside GUE, Hermitian Frobenius geometry, scalar Gaussian, independence,
  normalization, and matrix and measure-theory foundations.
- Fifty-one deterministic 1200x630 social cards and thirty-five accessible
  conceptual SVG figures.
- Guided Hugo learning path with article orientation, progress, table of
  contents, code copy, teaching panels, glossary search, and responsive/print
  layouts. Rendered desktop and 390-pixel mobile QA found and fixed article
  overflow while retaining local scrolling for wide tables and diagrams.

## Exact Next Milestone

### RMT-14: finite-time norm and extended-log-norm cocycle observables

The next module is `Random/RandomCocycles/NormObservables.lean`. An independently
audited, warnings-fatal fourteen-declaration prototype has stabilized the
smallest analytic layer above RMT-13:

1. Select Mathlib's maximum absolute row-sum matrix norm, the operator norm
   induced by the vector supremum norm, and expose its exact finite row-sum
   formula.
2. Define the finite-time norm observable, prove its positive-dimensional
   time-zero normalization, one-step generator identity, cocycle
   submultiplicativity, and ordinary measurability.
3. Prove norm measurability entrywise through complex entry norms, finite row
   sums, and finite suprema. Do not silently identify the project-owned matrix
   measurable space with a Borel structure supplied by the scoped norm.
4. Define the extended log norm through `ENNReal.log ‖C.value k ω‖ₑ`, so a zero
   cocycle value maps exactly to `⊥` rather than to the artificial real
   convention `Real.log 0 = 0`.
5. Prove the exact bottom criterion, positive-dimensional time-zero and
   one-step identities, measurability, and unconditional extended-real
   subadditivity across the RMT-13 cocycle split.
6. Keep empty matrix dimension valid. Prove explicitly that every finite-time
   norm is zero and every extended log norm is bottom in that branch; require
   `Nonempty ι` only for the normalizations `‖1‖ = 1` and `log 1 = 0`.
7. Pair the complete API with a Notebook, Knowledge Base teaching, coverage,
   checkpoint update, rendered browser audit, and a green push.

RMT-14 remains finite-time. It asserts no integrability of either observable,
no normalized growth rate, no subadditive ergodic limit, no Lyapunov exponent,
no Oseledets splitting, no ergodicity or probability normalization, and no
random-Jacobian bridge. Those require a separate assumption and asymptotic
policy after the observable layer is checked.

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
- [x] Complex Gaussian primitives with explicit variance splitting.
- [x] Finite independent Cartesian complex Gaussian families, real scaling,
  and a canonical product law.
- [x] Deterministic Hermitian assembly from real diagonal and complex strict
  upper-triangular coordinates, including the `n = 0` boundary.
- [x] Finite-dimensional GUE constructor under the approved Wigner
  normalization ledger and explicit `n = 0` Dirac policy.
- [x] Hermitian support, intrinsic Frobenius geometry, and invariance of the
  canonical Hermitian standard Gaussian.
- [x] Exact coordinate-to-intrinsic-Gaussian bridge and nontrivial unitary
  invariance of the ambient GUE law.
- [x] Integrability and the first exact expected trace moments.
- [x] Algebraic ordered Hermitian spectra, spectral counting measures,
  zero-aware empirical measures, and conditional measure-valued interfaces.
- [x] A Hermitian eigenvalue perturbation bound, continuity, and unconditional
  coordinatewise measurability.
- [x] The finite-GUE empirical spectral law and its first normalized spectral
  moments.
- [x] Deterministic finite matrix products and induced infinity operator-norm
  inequalities.
- [x] Measurable finite random matrix products and proof-carrying pushforward
  laws.
- [x] Generator-presented one-sided random cocycles over a measure-preserving
  base, including the later-block-left finite-time cocycle law.
- [ ] Finite-time maximum-row-sum norm and extended-log-norm observables.
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
  tuple. RMT-06 combines the empty real and complex blocks and proves the
  resulting coordinate and matrix laws are Dirac at their unique zeros.
- A Cartesian complex Gaussian law is the product of independent real and
  imaginary Gaussian coordinates. It does not by itself mean circular or
  proper complex Gaussianity.
- Complex Gaussian coordinate variances remain a visible pair `vRe`, `vIm`.
  No single undifferentiated "complex variance" is used. RMT-06 makes the
  symmetric GUE choice `vRe = vIm = 1 / (2n)` only for strict-upper entries.
- Qualitative `IsGaussian` for the complex law is over the underlying real
  Banach space. It does not encode circularity, a density, or a matrix law.
- When both coordinate variances vanish, the complex law is Dirac at its mean.
  The generic one-zero line-supported case has no standalone primitive theorem,
  but RMT-06 proves the full matrix-diagonal Cartesian complex law with real
  variance `diagonalVariance n` and imaginary variance zero.
- Separate independence of a real family and an imaginary family is
  insufficient to pair them coordinatewise; the missing cross-family
  independence must never be inferred.
- An independent Cartesian complex Gaussian family stores ordinary coordinate
  measurability, exact coordinate laws, and `iIndepFun` as separate evidence.
  Its exact finite joint law is the product of the coordinate laws.
- The honest real-pair constructor requires an exact product law inside each
  pair and mutual independence across the pair-vectors. Separate independence
  of the real and imaginary source families does not establish either global
  block statement.
- Coordinatewise scaling is currently real only. General complex scaling can
  rotate an anisotropic Cartesian law into correlated displayed axes and needs
  covariance-aware bookkeeping.
- The empty Cartesian complex Gaussian product is Dirac at the unique empty
  coordinate function. RMT-06 now combines it with the real diagonal product
  under the explicit Wigner normalization.
- Hermitian coordinate assembly uses real diagonal values and complex
  strict-upper values directly, reflecting the latter below the diagonal.
  Reusing unnormalized `X + Xᴴ` would double the diagonal and is forbidden for
  that constructor.
- At `n = 0`, both Hermitian coordinate blocks are empty and direct assembly is
  the unique zero matrix. RMT-05 intentionally adds no inverse map or dimension
  theorem.
- The approved RMT-06 GUE convention is Wigner scaled: diagonal variance
  `1 / n`, displayed off-diagonal real and imaginary variances `1 / (2n)`,
  unnormalized matrix trace, density exponent `-n Tr(H^2) / 2`, and an
  order-one spectrum. Its total zero-dimensional scale is defined explicitly
  as zero.
- RMT-06 constructs a probability measure first on the independent coordinate
  blocks and then on ambient matrices by measurable Hermitian assembly. It
  proves full block laws, within-block mutual independence, cross-block
  independence, exact diagonal and strict-upper marginals, and both
  zero-dimensional Dirac identities.
- RMT-07 models ambient Frobenius geometry with
  `EuclideanSpace ℂ (Fin n × Fin n)` and the Hermitian locus as a real
  submodule. Hermitian matrices are not a complex submodule in general.
- The complex Frobenius pairing is `Tr (XᴴY)`. Unitary congruence is a complex
  linear isometry on the ambient Frobenius carrier and a real linear isometry
  on the intrinsic Hermitian carrier.
- Mathlib's intrinsic `stdGaussian (HermitianEuclidean n)` is invariant under
  that real isometry. RMT-08 now identifies the coordinate-built law with the
  correctly scaled intrinsic Gaussian before transferring this symmetry.
- The ambient Hermitian set is entrywise measurable, and `GUE.matrixLaw n`
  gives it mass one, is Hermitian almost everywhere, and gives its complement
  mass zero. "Support" here is measure-theoretic full mass, not an equality
  with Mathlib's topological `Measure.support`.
- The intrinsic standard-Gaussian proof locally aligns two definitionally
  different but extensionally identical real-module instances on the
  Hermitian subtype. This is a checked Mathlib API/typeclass workaround, not a
  mathematical assumption.
- RMT-08 uses the finite real index `Fin n ⊕ (StrictUpperIndex n ⊕
  StrictUpperIndex n)`, proves it equivalent to all `Fin n × Fin n` matrix
  positions, and packages normalized assembly as a real linear isometric
  equivalence onto intrinsic Hermitian space.
- The checked orthonormal free coordinates are `dᵢ`, `√2 Re uᵢⱼ`, and
  `√2 Im uᵢⱼ`, because `‖H‖_F² = Σᵢ dᵢ² + 2 Σ_{i<j} |uᵢⱼ|²`.
- RMT-08 proves equality of the whole normalized finite product law with the
  earlier diagonal/complex-upper coordinate measure. Equality of scalar
  marginals alone would not have justified the law comparison.
- `GUE.intrinsicLaw n` is a probability measure, equals the image of intrinsic
  `stdGaussian` under multiplication by `√(varianceScale n)`, and is Dirac at
  the unique zero Hermitian point when `n = 0`.
- The original ambient `GUE.matrixLaw n` is exactly the pushforward of
  `GUE.intrinsicLaw n` through `hermitianToMatrix`. It is now formally invariant
  under every deterministic unitary conjugation.
- The RMT-09 moment statements use complex Bochner integrals of the already
  measurable `tracePower` observables. Integrability remains a separate theorem
  and must precede each exact integral identity.
- RMT-09 proves `tracePower id 1` and `tracePower id 2` Bochner integrable under
  the ambient probability measure `GUE.matrixLaw n`; their exact complex
  integrals are zero and `(n : ℂ)`. The trace is ordinary and unnormalized.
- The first trace calculation needs only centered diagonal marginals. The
  second consumes RMT-08's whole normalized product-law pushforward, the
  Hermitian identity `Tr(H²) = ‖H‖_F²`, and the `n²`-coordinate variance sum.
  Independence is part of the source construction but is not used to factor
  any expectation in this two-moment proof.
- Dimension zero is included by the same finite sums and coordinate formulas:
  the relevant indices are empty and both exact integrals are zero. No
  positive-dimension hypothesis is hidden in the public API.
- RMT-10A takes its ordered spectrum from Mathlib's antitone
  `Matrix.IsHermitian.eigenvalues₀` and transports it to `Fin n` through an
  order-preserving cast. Mathlib's generally reindexed `eigenvalues` may be
  used inside permutation-invariant sums but must not be presented as sorted.
- Algebraic multiplicity is represented by repeated ordered indices. The
  spectral counting measure is the finite sum of one Dirac mass per index and
  therefore has total mass `n`; no deduplication to a set of distinct roots is
  allowed.
- The zero-dimensional spectral counting and empirical measures are both the
  zero measure. The empirical measure is zero or probabilistic in every
  dimension, while the bundled `ProbabilityMeasure ℝ` interface is exposed
  only for successor dimensions.
- RMT-10A's conditional Giry interfaces remain available with the explicit
  `_of_measurable_eigenvalues` suffix. RMT-10B discharges their hypothesis:
  ordered eigenvalue coordinates, the whole ordered vector, the counting and
  empirical measures, the successor-dimensional probability wrapper, and the
  ambient observable are now unconditionally measurable.
- RMT-10B proves the coordinate perturbation estimate with the matrix
  Frobenius norm. The full ordered vector is 1-Lipschitz for the finite-function
  sup metric. This is neither the operator-norm-optimal Weyl statement nor the
  Hoffman-Wielandt Euclidean matching inequality.
- The perturbation proof uses a private ordered eigenbasis and top/bottom
  spectral subspaces of dimensions `i + 1` and `n - i`. Their dimensions sum
  to one more than the ambient dimension, forcing the shared nonzero witness
  that compares both quadratic forms.
- The ambient spectral observable first maps a Hermitian matrix into the
  intrinsic carrier and sends every non-Hermitian matrix to zero. This is a
  measurable totalization for use with ambient laws, not a spectral theory for
  general non-Hermitian matrices.
- RMT-10B proves unconditional equality between the existing ambient and
  intrinsic GUE pushforwards of the empirical spectral observable. RMT-10C
  names that common law `GUE.empiricalSpectralLaw` and proves the intrinsic and
  ambient presentations agree.
- `GUE.empiricalSpectralLaw n` is a probability law on raw `Measure ℝ` values
  in every dimension. At `n = 0` it is `Measure.dirac 0`: the sampled empirical
  measure is zero, but its outer law still has mass one.
- `GUE.empiricalSpectralLawProbability n` bundles that all-dimensional outer
  law as `ProbabilityMeasure (Measure ℝ)`. The different
  `GUE.empiricalSpectralProbabilityLaw n` has outcomes in
  `ProbabilityMeasure ℝ` and therefore samples matrices of size `n + 1`.
- `GUE.meanEmpiricalSpectralMeasure n` is the Giry join of the raw law. It is
  zero at dimension zero and probabilistic in positive dimension. RMT-10C does
  not prove that integrating an unbounded moment against this mean measure
  equals the expected sample moment.
- Sample moments one and two are normalized trace and trace square in every
  dimension. In the raw `ℝ≥0∞` normalization, zero inverse is infinity and
  infinity scaled by the zero measure is zero; after `toReal`, the exposed field
  normalization uses `0⁻¹ = 0`.
- Under intrinsic finite GUE, the first sample moment has expectation zero in
  every dimension. The second has expectation `n⁻¹ * n`, hence zero at
  dimension zero and exactly one in positive dimension. These are finite exact
  identities, not a density or limit theorem.
- RMT-11 fixes the forward product by `P_A(0) = 1` and
  `P_A(k + 1) = A(k) P_A(k)`. New factors act on the left, and a time split
  places the shifted later block on the left of the earlier prefix. This is the
  convention future random products and cocycles must reuse.
- RMT-11 keeps the recursive product and vector-action identities over an
  arbitrary semiring. Its analytic layer specializes to real or complex
  scalars and Mathlib's maximum absolute row-sum norm, the operator norm
  induced by the vector supremum norm. It is not the Frobenius norm, Euclidean
  spectral norm, or entrywise maximum norm.
- The RMT-11 algebraic layer permits an empty matrix index. `Nonempty ι`
  appears only on the four analytic bounds because their normalized time-zero
  proof uses `‖1‖ = 1` for the chosen operator norm.
- The uniform bound theorem does not request `0 ≤ C`. At positive horizons its
  factor hypothesis already forces the needed sign information; at horizon
  zero, `C ^ 0 = 1` independently of the sign of `C`.
- RMT-11 is deterministic and finite-time. Its product and vector estimates do
  not establish measurability, independence, expected or logarithmic growth,
  a Lyapunov exponent, a subadditive limit, or a multiplicative ergodic
  theorem.
- RMT-12 separates the pointwise sample product from its law. The first five
  declarations remain algebraic over an arbitrary semiring; only the
  measurability and law layer specializes to complex matrices because that is
  the current project `RandomMatrix` measurable-multiplication interface.
- Measurability at horizon `k` assumes exactly
  `∀ j < k, Measurable (A j)`. The successor proof consumes the new factor at
  index `k` and the strict earlier prefix; no future factor is requested.
- `forwardProductLaw` is proof-carrying through `RandomMatrix.law`. It never
  exposes a proof-free bare `Measure.map` under the name law, because Mathlib's
  total map definition falls back to the zero measure when almost-everywhere
  measurability is unavailable.
- The zero-horizon law is Dirac at the identity only under a probability
  source; for an arbitrary source measure, a constant pushforward retains the
  source's total mass. The one-step law needs only measurability of `A 0` and no
  probability assumption.
- RMT-12 requires no `Nonempty ι`. Empty matrix dimension remains valid in the
  pointwise, measurable, raw-law, and bundled probability interfaces.
- `forwardProductLaw_isProbabilityMeasure` proves mass one, and
  `forwardProductProbabilityLaw` stores exactly that evidence. The wrapper
  supplies no density, support, moment, independence, stationarity, or
  asymptotic theorem.
- The pointwise shifted split is not a factorization of the product law.
  Independence, a joint-law interface, and additional hypotheses would be
  required before any such measure identity could be stated honestly.
- RMT-13 is generator-presented: one base map `T` advances an environment and
  one generator `A` supplies the factor at each forward iterate. It does not
  package an arbitrary time-indexed random sequence as a cocycle.
- Natural-time iteration uses Mathlib's `Function.iterate` convention. The
  orbit factor at index `j` is `A ((T^[j]) ω)`, and the finite product reuses
  RMT-11's newest-factor-left ordering without redefining multiplication.
- The checked cocycle split is
  `Φ(m + k, ω) = Φ(k, (T^[m]) ω) * Φ(m, ω)`. The shifted later block remains on
  the left because it acts after the earlier prefix; commuting the factors is
  neither assumed nor permitted.
- RMT-13 keeps its orbit and product algebra over an arbitrary semiring and
  specializes only the measurable layer and bundle to complex matrices. The
  bundle stores a base, generator, `MeasurePreserving base μ μ`, and ordinary
  generator measurability.
- `MeasurePreserving` supplies base measurability and preservation of the
  chosen measure, and its iterate theorem proves preservation at every natural
  time. It does not supply probability normalization, ergodicity, mixing,
  independence, invertibility, or negative-time dynamics.
- Empty matrix dimension remains valid throughout RMT-13. No `Nonempty ι`
  assumption is needed for values, identities, measurability, or base-iterate
  preservation.
- RMT-13 is one-sided and finite-time. It proves no skew-product invariant law,
  law factorization, norm or log-norm integrability, Lyapunov exponent,
  Oseledets splitting, asymptotic limit, or random-Jacobian representation.
- The density identity and order-one spectral interpretation remain explanatory
  context until their prerequisites are formalized. RMT-06 proves only the
  exact coordinate and matrix laws induced by the approved variance ledger.
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

- GUE conventions differ. Keep the approved variance, trace, density-exponent,
  and zero-dimensional ledger explicit in code and prose.
- Mathlib's `Measure.map` is total and has fallback behavior outside the
  a.e.-measurable case. Keep measurability evidence explicit.
- Ordered finite Hermitian eigenvalues, multiplicity, zero-aware empirical
  normalization, Frobenius perturbation, continuity, and measure-valued
  measurability are formalized, as are the named finite-GUE empirical spectral
  law, its first two normalized expected moments, and the Giry mean. Joint
  eigenvalue densities, higher moments, moment/barycenter interchange, and
  every large-dimension scaling theorem remain open.
- Ordered deterministic finite matrix products, induced infinity operator-norm
  bounds, exact finite-prefix measurability, proof-carrying product laws, their
  probability packaging, and generator-presented one-sided cocycles over
  measure-preserving bases are formalized. Finite-time norm and extended-log
  observables, their integrability, normalized growth, Lyapunov exponents, and
  ergodic limits remain open.
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
- RMT-03 Lean audit: all 20 public declarations match their exact-law and
  edge-case claims, warnings-as-errors passes for the module and both
  aggregators, the build completes 3,139 jobs, and only Mathlib's standard
  classical axioms appear in the audit.
- RMT-03 teaching audit: the 6,139-word Notebook covers every declaration; the
  new glossary and Deep Dive accurately separate checked Lean from density,
  support, covariance, pseudocovariance, properness, and circularity
  derivations; all three new cards reproduce byte-for-byte; both SVGs parse;
  KaTeX renders; and desktop plus 390-pixel mobile QA reports no page-level
  overflow, broken assets, or browser warnings.
- RMT-04 Lean audit: all 21 public declarations match their exact-law,
  independence, scaling, product, and empty-index claims; the module and both
  aggregators pass warnings-as-errors; the build completes 3,140 jobs; and the
  axiom audit contains only Mathlib's standard classical axioms.
- RMT-04 teaching audit: the 5,525-word Notebook covers all declarations; the
  new 1,665-word glossary and 4,778-word Deep Dive distinguish within-pair,
  across-pair, pairwise, mutual, and cross-family independence; three cards
  reproduce byte-for-byte; two SVGs parse and render; and all pages remain
  truthful drafts pending human and Pro review.
- Rendered RMT-04 QA: source display equations now render one-for-one after a
  browser pass exposed and fixed lone-equals Markdown parsing; KaTeX reports no
  errors or raw delimiters; desktop and 390-pixel mobile layouts have no
  page-level overflow; wide tables and Mermaid figures scroll locally; lazy
  assets load at their intended dimensions; and the seven Notebook chapters
  follow the dependency order through explicit navigation weights.
- RMT-05 Lean audit: all 17 public declarations implement the direct
  real-diagonal/complex-upper coordinate model; exact diagonal, upper, and
  lower entry formulas, Hermiticity, measurability, bundling, and the `n = 0`
  boundary pass warnings-as-errors; the build completes 3,141 jobs; and the
  axiom audit contains only Mathlib's standard classical axioms.
- RMT-05 teaching audit: the 4,580-word Notebook covers all declarations; the
  new 1,333-word glossary and 4,388-word Deep Dive explain the `n²` real
  coordinates, three-branch assembly, Hermiticity, measurability, physics
  context, and zero-dimensional boundary without promoting nonformalized
  claims; all three cards reproduce byte-for-byte and both SVGs parse/render.
- Rendered RMT-05 QA: all source equations render with no KaTeX errors or raw
  delimiters after replacing Markdown-sensitive literal inequalities; desktop
  and 390-pixel layouts have no page-level overflow; wide content remains
  locally contained; and lazy figures load at their declared dimensions.
- RMT-06 Lean audit: all 26 public declarations match the explicit Wigner
  ledger, block and scalar exact laws, three independence scopes, measurable
  matrix pushforward, exact full complex diagonal and strict-upper marginals,
  and both zero-dimensional Dirac identities. The changed module and all three
  aggregators pass warnings-as-errors; the full build completes 3,142 jobs; no
  proof holes or unsafe declarations occur; and the axiom audit contains only
  `propext`, `Classical.choice`, and `Quot.sound`.
- RMT-06 teaching audit: the 6,014-word Notebook maps all declarations; the
  1,815-word GUE glossary and 4,606-word Deep Dive explain normalization,
  factor-two Hermitian geometry, product laws, independence, pushforward, and
  explicit nonclaims. All three deterministic cards reproduce byte-for-byte
  at 1200x630; both SVGs parse and render; Guionnet and Tao-Vu support the
  normalization and contextual spectral scale; and all new pages remain
  truthful drafts pending human and Pro review.
- Rendered RMT-06 QA: Hugo renders 87 pages with warnings fatal. The browser
  pass found and fixed a malformed Deep Dive heading tag that static rendering
  had accepted but that swallowed the generated table of contents, suppressed
  KaTeX, and widened the mobile document. After repair, the Notebook, glossary,
  and Deep Dive render 77, 53, and 143 KaTeX nodes respectively, with zero
  KaTeX errors or raw delimiters; desktop and 390-pixel layouts have no
  page-level overflow; tables, Mermaid diagrams, and code scroll locally;
  lazy SVGs load at declared dimensions; and RMT-05/RMT-06 navigation is exact.
- RMT-07 Lean audit: all 27 public declarations match the Frobenius carrier,
  mutually inverse packaging maps, real Hermitian subspace, trace pairing,
  ambient and intrinsic unitary-congruence equivalences and isometries,
  intrinsic standard-Gaussian invariance, measurable Hermitian locus, and the
  three full-mass/almost-everywhere/null-complement support interfaces. The
  module and all three aggregators pass warnings-as-errors; the full build
  completes 3,144 jobs; no proof holes or unsafe declarations occur; and all
  13 theorem audits contain only `propext`, `Classical.choice`, and
  `Quot.sound`.
- RMT-07 teaching audit: the 5,607-word Notebook maps all 27 declarations; the
  new 1,558-word glossary and 4,987-word Deep Dive develop the real Hermitian
  Frobenius geometry, factor-two coordinate metric, two distinct theorem
  paths, Mathlib module-instance seam, support meanings, and exact RMT-08
  boundary. All three deterministic cards reproduce byte-for-byte at
  1200x630; both accessible SVGs parse and render; primary and official sources
  support the classical and Mathlib context; and the pages remain truthful
  drafts pending human and Pro review.
- Rendered RMT-07 QA: Hugo renders 96 pages with warnings fatal. A live-browser
  pass found literal `<` signs inside two TeX derivations that static Hugo had
  accepted but Goldmark partially consumed as HTML; replacing them with
  delimiter-scoped `\lt` repaired the equations. The Notebook, glossary, and
  Deep Dive now render 104, 51, and 151 KaTeX nodes respectively with zero
  KaTeX errors or raw delimiters; desktop and 390-pixel documents fit their
  viewports exactly; wide tables remain locally scrollable; lazy SVGs load at
  their declared dimensions; and RMT-06/RMT-07 navigation is exact.
- RMT-08 Lean audit: all 35 public declarations implement the `n²` real
  coordinate index, normalized Hermitian analysis and assembly, Frobenius
  linear isometric equivalence, exact common-variance product decoding,
  intrinsic probability and scaled-standard-Gaussian laws, explicit
  zero-dimensional Dirac boundary, and ambient unitary-conjugation invariance.
  The module and all three aggregators pass warnings as errors; the full build
  completes 3,145 jobs; no proof holes or unsafe declarations occur; and all
  22 theorem audits contain only `propext`, `Classical.choice`, and
  `Quot.sound`.
- RMT-08 teaching audit: the 6,598-word Notebook maps all 35 declarations; the
  new 1,692-word glossary and 5,425-word Deep Dive develop the factor-two
  normalization, full joint-product transport, intrinsic/ambient commuting
  square, zero-dimensional branch, and exact nonclaims. All three deterministic
  cards reproduce byte-for-byte at 1200x630 from both the repository and an
  unrelated working directory; both accessible prose-only SVGs parse and
  render; and the warning-fatal Hugo build produces 103 pages.
- Rendered RMT-08 QA: the Notebook, glossary, and Deep Dive render 153, 37, and
  100 KaTeX nodes respectively with zero errors or raw delimiters. Desktop
  documents fit 1280 pixels exactly. A mobile pass found a long theorem name in
  the key-result panel widening the Notebook; the reusable code-wrapping rule
  now makes all three documents fit 390 pixels exactly while tables, Mermaid
  figures, and code remain locally scrollable. Lazy SVGs load at their declared
  dimensions, and RMT-07/RMT-08 previous/next navigation is exact.
- RMT-09 Lean audit: exactly four public theorems prove Bochner integrability
  and the exact complex integrals of trace powers one and two. The changed
  module and both aggregators pass warnings as errors; the full build completes
  3,146 jobs; no proof holes or unsafe declarations occur; and all four theorem
  audits contain only `propext`, `Classical.choice`, and `Quot.sound`.
- RMT-09 teaching audit: the 5,685-word Notebook covers all four public
  declarations and twelve private proof helpers; the new 1,934-word glossary
  and 5,451-word Deep Dive separate integrability, pointwise Hermitian algebra,
  product-law transport, normalization, and exact expectation from unproved
  density or asymptotic claims. All three deterministic cards reproduce
  byte-for-byte at 1200x630 from both the repository and an unrelated working
  directory; both prose-only SVGs parse and render; and Hugo builds 116 pages
  with warnings fatal.
- Rendered RMT-09 QA: the Notebook, glossary, and Deep Dive render 102, 53, and
  138 KaTeX nodes respectively with zero errors, raw delimiters, or console
  warnings. Their desktop documents fit 1280 pixels exactly and their mobile
  documents fit 390 pixels exactly; wide code and tables remain locally
  scrollable; cards and lazy SVGs load at their intrinsic dimensions; the
  RMT-08 next link and RMT-09 previous link are exact; and the three updated
  cross-link pages remain width-clean with valid rendered mathematics.
- RMT-10A Lean audit: all 26 public declarations and both private proof helpers
  match the decreasing sorted spectrum, multiplicity, trace and trace-square,
  unitary-congruence, counting-measure, zero-aware empirical-measure,
  positive-dimensional probability, conditional Giry, ambient-totalization,
  and conditional pushforward claims. The module and all three aggregators pass
  warnings as errors; the full build completes 3,154 jobs; no proof holes or
  unsafe declarations occur; and all 20 theorem audits contain only `propext`,
  `Classical.choice`, and `Quot.sound`.
- RMT-10A teaching audit: the 7,081-word Notebook maps every public declaration
  and both private helpers; the 2,041-word glossary and 6,069-word Deep Dive
  separate an ordered sample spectrum, counting measure, empirical measure,
  and probability law over measures. All three deterministic cards reproduce
  byte-for-byte at 1200x630 from the repository and `/private/tmp`; both
  prose-only SVGs parse and render; and Hugo builds 129 pages with warnings
  fatal.
- Rendered RMT-10A QA: the Notebook, glossary, and Deep Dive render 66, 55, and
  116 KaTeX nodes respectively with zero errors, raw delimiters, or console
  warnings. Their desktop documents fit 1280 pixels exactly and their mobile
  documents fit 390 pixels exactly; wide tables remain locally scrollable;
  cards and lazy SVGs load at intrinsic dimensions; and the RMT-09/RMT-10A
  navigation is exact. The audit also corrected the extended-nonnegative-real
  zero inverse explanation and a reversed dependency arrow before freeze.
- RMT-10B Lean audit: all 14 public theorems and 18 private helpers implement
  the Frobenius matrix-vector estimate, dimension-forced spectral witness,
  coordinate Weyl bound, coordinate and finite-sup-vector Lipschitz maps,
  continuity, unconditional Giry measurability, and ambient/intrinsic GUE
  pushforward equality. The module and all three aggregators pass warnings as
  errors; the full build completes 3,155 jobs; no proof holes, unsafe
  declarations, or custom axioms occur; and every public theorem audit contains
  only `propext`, `Classical.choice`, and `Quot.sound`.
- RMT-10B teaching audit: the 5,656-word Notebook maps all 14 public theorems
  and 18 private helpers; the 1,247-word glossary and 5,490-word Deep Dive teach
  the variational intersection proof, Frobenius-versus-sup metric ledger,
  continuity-to-Giry bridge, and exact nonclaims. All three deterministic cards
  reproduce byte-for-byte at 1200x630 from both the repository and
  `/private/tmp`; both prose-only SVGs parse and render; and Hugo builds 140
  pages with warnings fatal. Independent review corrected first-use acronym and
  sample-map-versus-law wording before freeze.
- Rendered RMT-10B QA: the Notebook, glossary, and Deep Dive render 105, 35, and
  120 KaTeX nodes respectively with zero errors, raw delimiters, or browser
  warnings. Their desktop documents fit 1280 pixels exactly and their mobile
  documents fit 390 pixels exactly; wide equations, tables, diagrams, and code
  scroll locally; every card and lazy SVG loads at its intrinsic dimensions;
  the three predecessor crosslink pages remain width- and math-clean; and the
  RMT-10A/RMT-10B previous/next navigation is exact.
- RMT-10C Lean audit: all 21 public declarations and the private
  `ambientTracePower` helper implement sample empirical spectral moments, the
  named law and two probability wrappers, intrinsic/ambient equality, the
  zero-dimensional Dirac law, the Giry mean, integrability transport, and exact
  first and second normalized expectations. The module and all three
  aggregators pass warnings as errors; the full build completes 3,156 jobs; no
  proof holes, unsafe declarations, or custom axioms occur; and every public
  declaration audit contains only `propext`, `Classical.choice`, and
  `Quot.sound`.
- RMT-10C teaching audit: the 6,700-word Notebook maps all 21 public
  declarations and the private helper; the 2,219-word glossary and 7,388-word
  Deep Dive keep the sample measure, raw law, probability-valued law, Giry mean,
  and expected sample moments type-correctly separate. All three deterministic
  cards reproduce byte-for-byte at 1200x630 from both the repository and
  `/private/tmp`; both prose-only SVGs parse and render; and Hugo builds 151
  pages with warnings fatal. Independent review corrected a spectral-radius
  misnomer, first-use terminology, citation attribution and use, and card-level
  expected-moment wording before freeze.
- Rendered RMT-10C QA: the Notebook, glossary, and Deep Dive render 106, 71,
  and 165 KaTeX nodes respectively with zero errors, raw delimiters, or browser
  warnings. Their desktop documents fit 1,280 pixels exactly and their mobile
  documents fit 390 pixels exactly; wide tables and displays scroll locally;
  all cards and lazy SVGs load at 1,200x630 and their declared intrinsic
  dimensions; the six amended predecessor pages remain width- and math-clean;
  and the RMT-10B/RMT-10C Notebook navigation is exact.
- Responsive QA exposed a Goldmark/KaTeX integration hazard: a mathematical
  line containing only optional whitespace and `=` can be parsed as a Setext
  heading underline before KaTeX runs. The three affected RMT-10C Notebook
  displays and fourteen older displays were rewritten with `{} =`; the full
  teaching tree now contains no such lines, and the three older affected pages
  re-render at 117, 105, and 144 KaTeX nodes at both desktop and mobile widths
  with zero raw mathematics, page overflow, console failures, or bad headings.
- A full teaching-tree TeX source scan also replaced eighteen legacy literal
  comparison signs with `\lt` or `\gt` across seven older chapters. All seven
  re-render at both 1,280- and 390-pixel widths with stable KaTeX counts, zero
  KaTeX errors, raw delimiters, bad headings, page overflow, or browser console
  failures; the teaching tree now has no literal angle signs inside TeX.
- The proof-to-prose checker now recognizes declarations preceded by Lean
  attributes such as `@[simp]` and `@[fun_prop]`; its strengthened 15-module
  audit confirms that every named declaration is visible in its Notebook.
- The project skill now requires deterministic card verification, XML and
  rendered SVG inspection, desktop and 390-pixel browser QA, KaTeX/raw-math
  checks, Markdown-safe `\lt`/`\gt` only inside TeX delimiters, a typed ledger
  for random measures and their laws, explicit interchange theorems, and
  self-contained acronym use on standalone summary surfaces. It also requires
  the regression-tested, context-aware source gate for delimiter corruption,
  dropped TeX backslashes, literal math angles, bare dollars, C0 controls, em
  dashes outside identifiable quotations, and lone equality lines that
  Goldmark could consume as Setext headings before KaTeX sees them.
- RMT-11 Lean audit: all 13 public declarations implement the forward-product
  convention, shifted concatenation, constant-system powers, chronological
  vector action, and four induced infinity operator-norm estimates. The module
  and both aggregators pass warnings as errors; the full build completes 3,158
  jobs; no proof holes, unsafe declarations, or custom axioms occur; and every
  declaration audit contains only `propext`, `Classical.choice`, and
  `Quot.sound` where needed.
- RMT-11 static teaching audit: the 5,222-word Notebook maps all 13 public
  declarations; two new glossary chapters contain 1,523 and 1,730 words; and
  the 5,099-word Deep Dive develops the algebraic and analytic interfaces,
  empty-dimension boundary, complete assumption ledger, and exact nonclaims.
  All four deterministic cards reproduce byte-for-byte at 1200x630 from both
  the repository and `/private/tmp`; all four accessible prose-only SVGs parse
  and render; the context-aware source gate's 56 regression cases pass; and
  Hugo builds 167 pages with warnings fatal.
- Rendered RMT-11 QA: the Notebook, two glossary chapters, and Deep Dive render
  142, 43, 45, and 114 KaTeX nodes respectively at both desktop and mobile
  widths, while the amended RMT-10C predecessor remains stable at 106. All five
  pages have zero KaTeX errors, raw delimiters, malformed equality headings,
  page overflow, or browser console warnings; their cards and lazy SVGs load at
  intrinsic dimensions; the canonical Deep Dive AI disclosure renders exactly
  once at both widths; and RMT-10C/RMT-11 Notebook navigation is exact. The
  visual pass caught a leaked thick stroke on the Notebook card's final label;
  the generator and checked artifact were repaired and reverified from both
  working directories before freeze.
- RMT-12 Lean audit: all 12 public declarations implement semiring-generic
  pointwise products, exact prefix measurability for complex random matrices,
  proof-carrying raw laws, zero and one-horizon identities, raw mass-one
  evidence, and the bundled probability interface. The module and aggregators
  pass warnings as errors; the full build completes 3,159 jobs; empty matrix
  dimension compiles; no proof holes, unsafe declarations, or custom axioms
  occur; and the axiom audit contains only `propext`, `Classical.choice`, and
  `Quot.sound` where needed.
- RMT-12 static teaching audit: the 6,665-word Notebook body maps all 12 public
  declarations; the new glossary and Deep Dive contain 1,711 and 5,054 words
  and preserve the sample-map, measurability-proof, raw-law, and probability
  wrapper type distinctions. All three deterministic cards reproduce
  byte-for-byte at 1200x630 from both the repository and `/private/tmp`; all
  three accessible prose-only SVGs parse and render; source hygiene passes 63
  Markdown files; coverage passes 17/17 modules; and Hugo builds 182 pages with
  warnings fatal.
- Rendered RMT-12 QA: the Notebook, glossary, and Deep Dive render 88, 51, and
  108 KaTeX nodes respectively at both desktop and mobile widths, while the
  amended RMT-11 predecessor remains stable at 142. All four pages have zero
  KaTeX errors, raw delimiters, malformed equality headings, page overflow, or
  browser console warnings; cards and lazy SVGs load at intrinsic dimensions;
  the Notebook and Deep Dive disclosures render exactly once; and
  RMT-11/RMT-12 Notebook navigation is exact.
- RMT-13 Lean audit: all 16 public declarations implement forward-orbit
  generator factors, zero/successor/one/add product identities, the exact
  later-block-left one-sided cocycle law, finite-value measurability, the
  four-field measure-preserving bundle, and preservation by every natural base
  iterate. The module and aggregators pass warnings as errors; the full build
  completes 3,161 jobs; empty matrix dimension compiles; no proof holes,
  unsafe declarations, or custom axioms occur; and the axiom audit contains
  only `propext`, `Classical.choice`, and `Quot.sound` where needed.
- RMT-13 static teaching audit: the 6,113-word Notebook body maps all 16 public
  declarations in source order; the new glossary and Deep Dive contain 1,629
  and 5,040 words and preserve the semiring/measurable/bundled assumption
  layers, iterate convention, product order, empty-dimension boundary, and
  exhaustive nonclaims. All three deterministic cards reproduce byte-for-byte
  at 1200x630 from both the repository and `/private/tmp`; all three accessible
  prose-only SVGs parse and render; source hygiene passes 66 Markdown files;
  coverage passes 18/18 modules; and Hugo builds 193 pages with warnings fatal.
- Rendered RMT-13 QA: the Notebook, glossary, and Deep Dive render 120, 63, and
  114 KaTeX nodes respectively at both desktop and mobile widths. The amended
  RMT-12 Notebook, glossary, and Deep Dive remain stable at 88, 51, and 108.
  All six pages have zero KaTeX errors, raw delimiters, malformed equality
  headings, page overflow, or browser console warnings; desktop documents fit
  1,280 pixels and mobile documents fit 390 pixels exactly. Cards and
  explicitly scrolled lazy SVGs load at their declared intrinsic dimensions;
  canonical disclosures render exactly once where required; and all Notebook
  and reciprocal RMT-12 Knowledge Base links are exact. Independent review
  caught and repaired an over-strong Notebook assumption ledger before freeze:
  the orbit sequence needs no typeclasses, product declarations two through
  six use the finite-semiring floor, and the cocycle structure itself needs
  only the sample measurable space.

## Recent Pushes

- `349665d`: measurable finite matrix products, proof-carrying pushforward
  laws, bundled probability laws, and teaching layer.
- `23e49a3`: ordered deterministic finite matrix products, induced infinity
  operator-norm bounds, automated teaching-source hygiene, and teaching layer.
- `0a496e7`: finite GUE empirical spectral laws, normalized expected moments,
  Giry mean measure, source-hygiene repairs, and teaching layer.
- `c36903d`: Hermitian eigenvalue perturbation, continuity, unconditional
  spectral measurability, and teaching layer.
- `143f4fc`: decreasing ordered Hermitian spectra, empirical spectral measures,
  conditional Giry interfaces, and teaching layer.
- `c7b64ec`: first two exact finite GUE trace moments, integrability, and
  teaching layer.
- `10bbde4`: normalized Hermitian coordinates, exact intrinsic Gaussian
  representation, finite GUE unitary invariance, and teaching layer.
- `8774349`: intrinsic Hermitian Frobenius geometry, Gaussian symmetry, and
  mass-one measurable support with teaching layer.
- `716c0a9`: finite GUE coordinate and ambient matrix laws with teaching layer.
- `957bc4a`: deterministic Hermitian coordinate assembly and teaching layer.
- `ec96e0b`: independent complex Gaussian families and teaching layer.
- `8df3b33`: exact Cartesian complex Gaussian laws and teaching layer.
- `e36c177`: exact real Gaussian primitives, product laws, and teaching layer.
- `dded074`: living checkpoint and project research/formalization skill.
- `ab28b91`: random-matrix formalization and guided learning-path milestone.
- `dcbb45e`: initial blog structure.
