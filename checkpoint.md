# Project Checkpoint

> Living handoff for the formalization. Read this first, update it before every
> coherent milestone commit, and push the green milestone to `main`.

Last updated: 2026-07-21 03:50 PDT

Audited baseline: `main` at `8774349`

Active direction: exact integrability and first trace moments of finite GUE

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
- Last green Lean build: 3,145 jobs. The integrated RMT-08 gate covers eleven
  substantive modules, eleven complete draft Notebook companions, and 103
  Hugo pages with warnings fatal.
- Lean inventory: 244 public declaration lines across the eleven substantive
  modules; 18 one-line deterministic placeholders; three `.gitkeep`-only
  Random branches; five `.gitkeep`-only Quantum Chaos branches.
- Proof holes: none (`sorry` and `admit` absent).
- Teaching snapshot: 59,587 words across the eleven Notebook companions and
  59,219 words across eight Deep Dives and twenty glossary chapters.
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

The root aggregator imports all eleven modules. The proof-to-prose manifest and
`scripts/check_lean_notebook_coverage.py` enforce paired coverage and named
declaration visibility.

## Completed Teaching Layer

- Eleven comprehensive Development Notebook chapters in an explicit
  dependency-ordered previous/next sequence.
- Eight textbook-scale Deep Dives: *Random Matrices: From Outcomes to Spectra*,
  *Gaussian Laws, Independence, and Normalization*, *Complex Gaussian
  Coordinates and Geometry*, *Finite Product Probability Spaces and
  Independent Gaussian Fields*, *Finite Hermitian Matrices from Coordinates*,
  *Finite GUE from Independent Gaussian Coordinates*, and *Intrinsic Hermitian
  Gaussian Symmetry and Matrix-Law Support*, followed by *From Normalized
  Hermitian Coordinates to Gaussian Unitary Ensemble Invariance*.
- Twenty glossary chapters, now including normalized Hermitian coordinates
  alongside GUE, Hermitian Frobenius geometry, scalar Gaussian, independence,
  normalization, and matrix and measure-theory foundations.
- Twenty-nine deterministic 1200x630 social cards and seventeen accessible
  conceptual SVG figures.
- Guided Hugo learning path with article orientation, progress, table of
  contents, code copy, teaching panels, glossary search, and responsive/print
  layouts. Rendered desktop and 390-pixel mobile QA found and fixed article
  overflow while retaining local scrolling for wide tables and diagrams.

## Exact Next Milestone

### RMT-09: integrability and the first exact finite-GUE trace moments

The next module is `GaussianUnitaryEnsembleMoments.lean`. Read-only API
reconnaissance produced a complete warning-clean prototype; the durable
repository slice must now turn that design into a documented, audited public
interface with four theorems:

1. `GUE.integrable_tracePower_one`: the ambient observable
   `RandomMatrix.tracePower id 1` is Bochner integrable under `GUE.matrixLaw n`.
2. `GUE.integral_tracePower_one`: its complex integral is exactly zero.
3. `GUE.integrable_tracePower_two`: `RandomMatrix.tracePower id 2` is Bochner
   integrable under the same law.
4. `GUE.integral_tracePower_two`: its complex integral is exactly `(n : ℂ)`.

The proof must hold for every natural dimension, including zero. The first
moment may sum the exact centered diagonal laws. The second should consume
RMT-08's normalized real product representation and prove pointwise that
`Tr(H^2)` equals the Frobenius norm squared and hence the sum of the `n²`
normalized real coordinate squares. Each coordinate has exact second moment
`varianceScale n`; cardinality through
`hermitianRealIndexEquivMatrixIndex n` and the explicit zero/successor split
then give `n² / n = n` without a density or eigenvalue argument.

The public statements are complex Bochner integrals. Because `GUE.matrixLaw n`
is already a probability measure, they are the corresponding expectations.
The Notebook must explain the integrability transfer through measurable
pushforwards, the distinction between pointwise trace algebra and measure-level
integration, the Wigner normalization check, and why off-diagonal independence
is not needed once the normalized Euclidean representation is available.

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
- The next moment statements use complex Bochner integrals of the already
  measurable `tracePower` observables. Integrability remains a separate theorem
  and must precede each exact integral identity.
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
- The proof-to-prose checker now recognizes declarations preceded by Lean
  attributes such as `@[simp]` and `@[fun_prop]`; its strengthened 11-module
  audit confirms that every named declaration is visible in its Notebook.
- The project skill now requires deterministic card verification, XML and
  rendered SVG inspection, desktop and 390-pixel browser QA, KaTeX/raw-math
  checks, and Markdown-safe `\lt`/`\gt` only inside TeX delimiters.

## Recent Pushes

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
