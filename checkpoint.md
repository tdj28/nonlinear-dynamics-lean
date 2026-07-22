# Project Checkpoint

> Living handoff for the formalization. Read this first, update it before every
> coherent milestone commit, and push the green milestone to `main`.

Last updated: 2026-07-22 03:55 PDT

Audited baseline: `main` at `7ecea15`

Active direction: RMT-30 has proved the finite centered bad-block measure
ratio in checked Lean and paired it with its complete teaching slice.
Warning-fatal source gates, independent theorem and teaching audits, asset
reproduction, and literal desktop/mobile rendering are green. Full local and
checksum-identical RunPod gates, checkpoint close, commit, and push are the
active release steps. RMT-31 will pass from the nested finite bad-block sets
to the all-positive-length event without falsely declaring that raw union
invariant.

## Restart Handoff

- RMT-30 adds the 497-line
  `NonlinearDynamics.Random.RandomCocycles.SubadditiveBadBlockMeasure` module
  at `Random/RandomCocycles/SubadditiveBadBlockMeasure.lean`. Its current
  SHA-256 is
  `13c9721eff1b864b552d9110218598bd6c51455f9c1fdb3dbbe12b1e77973305`.
  The public surface has nine documented declarations, supported by eleven
  private boundary items, nine compiled anonymous examples, and six source
  axiom prints.
- `finiteOrbitVisitCount` counts the first `H` orbit positions as a natural
  cardinality. Its real cast is exactly an indicator Birkhoff sum, and finite
  total mass, null measurability, and preservation give the exact identity
  `∫ N_H ∂μ = H * μ.real s`. The definition and cast identity themselves
  need no measure structure.
- `finiteCenteredBadBlockSet` uses exactly the positive finite witness window
  `Finset.Icc 1 m` and a strict threshold. At each marked orbit start the
  pointwise theorem chooses one witness, applies RMT-21's greedy disjoint
  packing, and proves
  `centeredProcess T X (H + m) ω ≤ c * finiteOrbitVisitCount ... H ω`
  for `c ≤ 0` and the genuinely necessary boundary `H + m ≠ 0`.
- If `δ` is below every positive normalized centered integral and `c < δ`,
  the time-one identity derives `c < δ ≤ 0`. Integrating the packed bound,
  substituting the exact visit integral, and sending only the auxiliary
  horizon `H` to infinity gives
  `μ.real (finiteCenteredBadBlockSet T X m c) ≤ δ / c`. Negative division
  is explicit. Probability and ergodicity are absent.
- The cocycle endpoint specializes `δ` to
  `integratedLogPlusGrowthRate hC - integratedLogPlusNorm 1` by combining the
  deterministic Fekete block lower bound with RMT-29's centered-integral
  identity. It adds no nonempty matrix-index or ergodicity premise and makes
  no signed-logarithm, Lyapunov, or Oseledets claim.
- The boundary layer covers `m = 0`, `H = 0 < m`, the zero process, a genuine
  failure at `H = m = 0`, zero measure, equality at the strict threshold,
  mass-two finite rescaling, and an empty matrix index. Its strengthened
  nonergodic Bool identity model has a genuinely nonempty singleton bad set
  of mass `1 / 2`; the theorem checks the numerical ratio `1 / 2 ≤ 2 / 3`.
  All six public axiom reports are exactly `propext`, `Classical.choice`, and
  `Quot.sound`.
- The teaching slice adds a 5,524-token declaration-complete Development
  Notebook with twenty-four solved exercises, a 4,059-token textbook Deep
  Dive with thirty solved exercises, and a 908-token finite-orbit-visit-count
  glossary. Three deterministic 1200x630 cards and thirteen accessible
  conceptual SVGs accompany the bundles. All remain `draft: true` and
  `pro_reviewed: false` pending the configured human and publication reviews.
- Warning-fatal leaf, cocycle-aggregator, and project-root compilation,
  35/35 proof-to-prose coverage, the 122-file teaching-source gate, all three
  caller-independent card reproductions, ShellCheck, XML validation, direct
  visual inspection, and a 377-page warning-fatal Hugo render are green.
  Independent 1440x1000 and 390x844 browser checks of all three routes find
  one article heading per page, exact 14+158, 36+155, and 5+34
  display-plus-inline KaTeX counts, all thirteen figures loaded, and zero page
  overflow, broken images, raw delimiters, KaTeX errors, HTTP failures, or
  console failures. Independent reviews corrected a six-pixel overlap in a
  disjoint-cover figure, strengthened the nonempty boundary model, repaired
  zero-horizon notation and cast-versus-integrability language, and fixed the
  pinned null-measurability citation.

- RMT-29 adds the 411-line
  `NonlinearDynamics.Random.RandomCocycles.SubadditiveUpperLimsup` module at
  `Random/RandomCocycles/SubadditiveUpperLimsup.lean`. Its current SHA-256 is
  `396662e201627c84e59aafd94476187ca280a00812d4df14af90994c5d5cc77a`.
  The public surface has four documented theorems. One private block-prefix
  definition and three private cofinality/coefficient lemmas isolate the
  asymptotic arithmetic; ten private boundary-support items support three
  compiled anonymous examples, followed by four source axiom prints.
- `integral_birkhoffSum_eq_nat_mul` integrates every finite Birkhoff sum under
  measure preservation, including horizon zero. The centered integral identity
  then cancels the one-step mean exactly. The fixed-block theorem combines
  RMT-20 phase averaging with two RMT-28 Birkhoff limits under the original
  map and proves, for every positive block `b`, the almost-everywhere bound
  `limsup (fun n ↦ X n ω / (n : ℝ)) atTop ≤ (∫ x, X b x ∂μ) / (b : ℝ)`.
- The generic endpoint assumes an ergodic probability base, integrability,
  shifted subadditivity, and pointwise nonnegativity. Nonnegativity supplies
  the lower-coboundedness needed by Mathlib's conditionally complete real
  `limsup`; the negative-quadratic singleton explains why deleting it makes
  the totalized real statement false. The cocycle endpoint intersects all
  positive-block events and applies the existing deterministic Fekete `sInf`
  identity to reach `integratedLogPlusGrowthRate`.
- The proof never assumes ergodicity of `T^[b]`. A uniform Bool flip compiles
  with an ergodic original map and a nonergodic square, while the block-two
  upper bound still applies. All four public axiom reports are exactly
  `propext`, `Classical.choice`, and `Quot.sound`; no proof hole, unsafe
  declaration, project axiom, powered-map premise, or convergence claim is
  present.
- The teaching slice adds a 4,327-word declaration-complete Development
  Notebook with twenty-four solved exercises, a 3,628-word textbook Deep Dive
  with thirty-two solved exercises, and a 562-word limit-superior glossary.
  Three deterministic 1200x630 cards and twelve accessible conceptual SVGs
  accompany the page bundles. All remain `draft: true` and
  `pro_reviewed: false` pending the configured human and publication reviews.
- Warning-fatal leaf and cocycle-aggregator compilation, 34/34 proof-to-prose
  coverage, the 119-file teaching-source gate, all three caller-independent
  card reproductions, ShellCheck, XML validation, and a 366-page warning-fatal
  Hugo render are green. Independent 1440x1000 and 390x844 browser checks of
  the three routes find one article heading per page, exact source-to-KaTeX
  counts, all twelve lazy figures loaded, and zero page overflow, broken
  images, raw delimiters, KaTeX errors, HTTP failures, or console failures.
  Full `make check` completes all 3,210 Lean jobs and repository gates in 6.85
  seconds on the Mac. Checksum-identical approved RunPod passes took 10.29
  seconds on the first full replay and 8.40 seconds after the final content
  corrections.

- RMT-28 adds the 367-line
  `NonlinearDynamics.Random.RandomCocycles.ErgodicBirkhoffLimit` module at
  `Random/RandomCocycles/ErgodicBirkhoffLimit.lean`. Its current SHA-256 is
  `12f28df847232be23ac76e90f0583f6f6e646ca90d300a56567892c27e0d34d1`.
  The public surface has six documented theorems, joined by one private
  constancy hinge. Four private definitions, eight private named theorem
  helpers, two private instances, five compiled boundary probes, and six
  source axiom prints keep the implementation and semantic edges visible.
- `condExp_invariants_comp` proves literal representative-level invariance of
  conditional expectation onto `MeasurableSpace.invariants T` without any
  measure-theoretic hypothesis. `PreErgodic T μ` alone then gives
  almost-everywhere constancy; measure preservation is deliberately absent
  from all three conditional-expectation identification theorems.
- Finite nonzero mass and real integrability identify the constant first as
  Mathlib's integral average `⨍ x, f x ∂μ`, then as
  `(μ.real univ)⁻¹ * ∫ x, f x ∂μ`. Probability normalization removes the
  denominator. Integrability is consumed through `setIntegral_condExp`, so
  the semantic result is not an artifact of Mathlib's totalized integral or
  conditional expectation.
- Full `Ergodic T μ` enters only in the two convergence endpoints: its
  measure-preserving projection invokes RMT-27, while its pre-ergodic
  projection identifies the target. No theorem assumes injectivity,
  surjectivity, invertibility, mixing, a rate, or ergodicity of `T^[b]`.
  Probability and mass-two Dirac systems, a pre-ergodic but nonpreserving
  Dirac system, zero measure, and a nonergodic two-atom identity system compile
  as explicit boundaries.
- The teaching slice adds a 7,886-word declaration-complete Development
  Notebook with twenty solved exercises, a 5,752-word textbook Deep Dive with
  thirty solved exercises, and 1,251-word glossary chapters on ergodicity and
  normalized space averages. Four deterministic 1200x630 cards and ten
  accessible conceptual SVGs accompany the four page bundles. All remain
  `draft: true` and `pro_reviewed: false` pending the configured human and
  publication reviews.
- Warning-fatal leaf and cocycle-aggregator compilation, 33/33 proof-to-prose
  coverage, the 116-file teaching-source gate, all four caller-independent card
  reproductions, ShellCheck, XML validation, direct visual inspection, and a
  359-page warning-fatal Hugo render are green. Literal desktop browser checks
  of all four routes find one `h1`, zero page overflow, KaTeX errors, raw
  delimiters, alt-less or eagerly broken images, missing anchors, or console
  warnings/errors; all fourteen new card and figure URLs return HTTP 200. The
  independent responsive render checks at both 1440x1000 and 390x844 pixels
  additionally find zero broken images or page-level overflow and keep wide
  math, code, and figures inside local scrolling regions. The in-app browser
  itself ignored its requested 390-pixel override, so the independent local
  headless render supplied that mobile evidence. Full `make check` passes all
  3,209 Lean jobs and repository gates both locally and on the
  checksum-identical source-only RunPod tree.

- RMT-27 adds the 407-line
  `NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoffLimit` module at
  `Random/RandomCocycles/PointwiseBirkhoffLimit.lean`. Its current SHA-256 is
  `6473ccd771ce7d913470f73549fb4a0bb675379c930d82ea8fb28979415efd0e`.
  The module has eighteen documented public declarations, one private
  strong-representative helper, five compiled boundary probes, and five source
  axiom prints.
- One total `limUnder` representative records the genuine Birkhoff limit where
  it exists and a canonical fallback elsewhere. The two one-prefix shift
  directions make both branches literally invariant, so a strongly measurable
  representative is measurable for Mathlib's exact
  `MeasurableSpace.invariants T`, not merely invariant modulo null sets.
- Measure-preserving orbit translates have identical pushforward laws.
  Integrability and finite total mass make that family uniformly integrable,
  Cesaro averaging preserves the control, and the finite-measure Vitali theorem
  upgrades RMT-26 almost-everywhere convergence to genuine real `L¹`
  convergence. Pointwise convergence alone is never used to pass an integral.
- For every exactly invariant measurable set, preservation of the restricted
  measure under each iterate gives equality of orbit-term integrals without an
  inverse or measurable embedding. Positive-time averaging and `L¹` passage
  transfer the identity to the chosen limit. Conditional-expectation uniqueness
  then identifies it, and representative transport returns the theorem from a
  strongly measurable version to the original integrable observable.
- The final theorem
  `ae_tendsto_birkhoffAverage_condExp` assumes only finite total measure,
  `MeasurePreserving T μ μ`, and real integrability of `f`. It proves
  full-sequence almost-everywhere convergence to
  `μ[f | MeasurableSpace.invariants T]`. Probability normalization,
  ergodicity, positive total mass, injectivity, surjectivity, and invertibility
  are absent. Zero measure, identity, a mass-two nonergodic identity system,
  its nonconstant target, and a noninjective/nonsurjective Dirac-preserving map
  are compiled boundaries.
- The paired teaching layer adds a 5,083-word Development Notebook with twenty
  solved exercises, an 8,545-word textbook Deep Dive with thirty solved
  exercises, and glossary chapters on invariant sigma algebras, conditional
  expectation, and uniform integrability with 2,139, 2,379, and 2,389 words.
  Five deterministic 1200x630 cards and fifteen accessible conceptual SVGs
  accompany the five page bundles. All remain `draft: true` and
  `pro_reviewed: false` pending the configured human and publication reviews.
- A fresh read-only Lean audit compiled the leaf, cocycle aggregator, an
  exact-versus-modulo-null countermodel, a noninjective restricted-measure
  transport instance, and a separate all-declaration axiom audit. It found no
  theorem, assumption, transport, Vitali, conditional-expectation, boundary,
  or axiom blocker. Every public declaration depends only on `propext`,
  `Classical.choice`, and `Quot.sound`.
- Current pre-release gates pass the warning-fatal leaf, cocycle aggregator,
  and project root, 32/32 proof-to-prose coverage, the 112-file teaching-source
  scan, all five caller-independent card reproductions, ShellCheck, XML
  validation, direct visual inspection of all fifteen figures and five cards,
  `git diff --check`, and a 347-page warning-fatal Hugo render. The literal
  browser audit passes all five routes at 1280 and 390 pixels with one `h1`,
  zero page overflow, KaTeX errors, raw delimiters, alt-less or eagerly broken
  images, suspicious generated links, or console warnings/errors. The wide
  figures retain 680-pixel canvases inside 364-pixel locally scrolling frames
  on mobile. The full local `make check` completes 3,208 Lean jobs and all
  repository gates, and a checksum-identical source-only RunPod replay passes
  the same gate. Checkpoint close, commit, and push remain the active release
  steps.

- RMT-26 adds the 580-line
  `NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoff` module at
  `Random/RandomCocycles/PointwiseBirkhoff.lean`. Its frozen pre-commit
  SHA-256 is
  `463a51c280585c932a85acab102421f70231173363fb61008c87a33f866f5253`.
  The module has twenty-nine documented public declarations, seven compiled
  anonymous boundary probes, and five source axiom prints.
- The module first derives absolute positive-time maximal control from
  RMT-24's one-sided positive-part estimate via
  `|Aₙ h| ≤ Aₙ |h|`. It defines an existential positive-time absolute
  exceedance event rather than a new supremum-valued maximal function and
  proves the exact finite-measure `μ.real` weak bound at every positive
  threshold.
- A fixed-scale Birkhoff Cauchy exceptional event records arbitrarily late
  pairs with `ε ≤ |Aₘ f - Aₙ f|`. For a pointwise-good approximant `g`, the
  event lies inside the absolute maximal-error event at threshold `ε / 3`
  together with the complement of `g`'s convergence event. The quantitative
  theorem bounds its real measure by the `L¹` error divided by `ε / 3`.
- Density makes each positive-scale exceptional event null. Avoiding the
  countable reciprocal scales `1 / (k + 1)` gives the full Cauchy property,
  and completeness of `ℝ` gives full-sequence convergence. This route is
  explicit about strict versus non-strict inequalities and excludes horizon
  zero whenever a positive-time maximal witness is needed.
- On a finite measure space, RMT-26 constructs the continuous inclusion
  `l2ToL1 : Lp ℝ 2 μ →L[ℝ] Lp ℝ 1 μ`, proves the finite-mass Hölder norm
  bound, injectivity, representative retention almost everywhere, and dense
  range through measurable finite-range simple functions. It transports the
  RMT-25 fixed-plus-simple-coboundary core into a dense `L¹` good class.
- The final theorem
  `ae_mem_birkhoffConvergenceSet_of_integrable` assumes only finite total
  measure, `MeasurePreserving T μ μ`, and real integrability of `f`. It proves
  almost-everywhere membership in the existing convergence event. Probability
  normalization, ergodicity, injectivity, surjectivity, and invertibility are
  absent, with a constant-map Dirac probe checking the nonbijective boundary.
  The theorem does not identify the limit, prove an ergodic constant, prove
  `L¹` convergence, or establish Kingman or Oseledets.
- The paired teaching layer adds a 5,280-word declaration-complete Development
  Notebook with eighteen solved exercises, a 9,493-word textbook Deep Dive
  with twenty-eight solved exercises, and two new glossary chapters of 2,126
  and 2,090 words. Four deterministic 1200x630 social cards and eleven
  accessible conceptual SVGs accompany the four page bundles. All remain
  `draft: true` and `pro_reviewed: false` pending human publication review.
- Two independent read-only reviews checked all twenty-nine declarations,
  seven probes, five axiom prints, theorem assumptions and nonclaims,
  `ε / 3` constants, reciprocal thresholds, representative transport,
  primary-source scope, references, crosslinks, and standalone figure claims.
  They caught and prompted corrections to the RMT-24/RMT-26 attribution,
  one-scale-versus-Cauchy wording, almost-everywhere qualifiers, measurable
  finite-range qualification, `μ.real` notation, and exact declaration names.
  No RMT-26 Lean, prose, citation, or standalone visual-asset blocker remains.
  A fresh 390-pixel page screenshot is still pending because the attached
  in-app browser ignored its viewport override and the independent browser
  task had no browser backend; the shared responsive templates and CSS were
  unchanged from the previously green RMT-25 mobile audit.

- RMT-25 adds the 491-line
  `Random/RandomCocycles/KoopmanL2Mean.lean`. Its frozen SHA-256 is
  `4041dd4fcbb1353c31fa26072071c2e6ee73626eb5c8b7f59ac4d76219e446ac`.
  The module has twenty documented public declarations, two private helpers,
  eleven compiled anonymous probes, and five source axiom prints.
- The raw forward-coboundary telescope is totalized honestly: horizon zero is
  a valid vacuous identity, while convergence uses bounded endpoints along
  positive horizons. This algebraic layer needs no measurable space or
  measure.
- `MeasurePreserving T μ μ` enters only for square-integrable Koopman
  geometry, density, and representative transport. The Koopman operator is
  proved contractive, `‖U‖ ≤ 1`, rather than unconditionally norm one; the
  zero-measure probe forces operator norm zero. No finite-mass, probability,
  ergodicity, injectivity, surjectivity, or invertibility premise leaks into
  the theorem signatures.
- Hilbert geometry proves only the needed one-sided inclusion of the fixed
  space's orthogonal complement in the closure of the coboundary range. Simple
  functions then generate a dense fixed-plus-simple-coboundary core. Fixed
  representatives and bounded simple-coboundary representatives have
  full-sequence almost-everywhere convergent averages, and convergence events
  close under their sums.
- Koopman averages of every square-integrable vector converge in norm to the
  fixed-space projection. That yields an almost-everywhere convergent strictly
  increasing subsequence, not full-sequence pointwise convergence. The final
  dense-core theorem proves convergence-event membership only and does not
  identify a general core sum's limit.
- Direct warning-fatal leaf, cocycle-aggregator, Random-root, and project-root
  checks are green. The printed axiom footprint is exactly `propext`,
  `Classical.choice`, and `Quot.sound`; no proof hole, unsafe declaration, or
  project axiom occurs. Independent semantic and assumption audits found no
  Lean blocker.
- The teaching layer adds a 10,911-body-token declaration-, helper-, and
  probe-complete Development Notebook with 34 solved exercises, two new
  glossary chapters, and a textbook Deep Dive with 20 solved exercises. Here
  and below “token” means the deterministic body-only regex
  `\b[\w'-]+\b`, not a model tokenizer. Four deterministic 1200x630 cards and
  twelve accessible conceptual SVGs are integrated.
- Proof-to-prose coverage passes 30/30 substantive modules; source hygiene
  passes 103 Markdown files; Hugo renders 318 pages with warnings fatal. Card
  reproduction, ShellCheck, XML parsing, and desktop/390-pixel browser QA are
  green. The Notebook, Deep Dive, Koopman-operator glossary, and
  Koopman-coboundary glossary render 296, 231, 62, and 87 KaTeX nodes with zero
  page-level overflow, KaTeX errors, raw delimiters, broken or alt-less assets,
  broken anchors, or console failures. Wide math, tables, and code scroll
  locally on mobile.
- Independent review checked the complete declaration/probe map, exact
  historical sources and DOI metadata, mean-versus-pointwise boundary,
  representative bridge, one-sided closure statement, reference reachability,
  and word-only SVG labels. No RMT-25 Lean, prose, citation, or visual blocker
  remains.
- The active RunPod builder remains up at the user's request. The fast local
  disk holds the active Lean/Mathlib build tree. The provider API reports 32
  vCPUs, 128 GB of billed memory, and a current compute rate of $1.472/hour;
  the guest's larger host-visible memory figure is not the billing tier. The
  attached 100 GB persistent network volume costs $7/month at RunPod's current
  first-terabyte rate and holds integrity-tested sequential zstd snapshots of
  Elan and Lean 4.32.0 (`736571369` bytes) and the pinned Mathlib/Lake tree
  (`2633278693` bytes). It is not used as a live metadata-heavy `.lake` tree.
  The two obsolete stopped test pods were terminated. No API key, private SSH
  key, pod address, or account-specific resource identifier belongs in the
  repository.
- The synchronized RMT-25 `make check` passes all 3,185 Lean jobs, checkpoint,
  30/30 coverage, four hygiene regression tests, the 103-file teaching scan,
  and the 318-page warning-fatal Hugo render in 11.13 seconds. The warm active
  tree is `/root/nonlinear-dynamics-lean` on the pod's fast local overlay;
  `/workspace` is persistent network storage and must remain a sequential
  snapshot location rather than a live metadata-heavy `.lake` tree. The
  builder remains retained under the owner's continuing project-scoped
  approval.
- The synchronized RMT-26 `make check` passes all 3,186 Lean jobs, checkpoint,
  31/31 proof-to-prose coverage, four hygiene regression tests, the 107-file
  teaching scan, and the 332-page warning-fatal Hugo render in 3.90 seconds on
  the warm RunPod tree. The source-only synchronization again excluded `.env`,
  Git metadata, local `.lake`, generated Hugo output, and private review files.
  The builder remains retained under the owner's continuing project-scoped
  approval.
- Provenance remains explicit: the human selected the formalization objective
  and approved project-scoped RunPod use; Codex agents performed API discovery,
  proof canonization, prose and figure production, and adversarial review.
  Checked Lean, not agent testimony, is the source of truth.

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
- Last fully green repository build: 3,211 Lean jobs on the integrated RMT-30
  tree. Its leaf, cocycle aggregator, and project root compile warning-fatally;
  35/35 coverage and every teaching gate pass; Hugo renders 377 pages with
  warnings fatal. The complete local `make check` took 15.37 seconds.
  The checksum-identical source-only replay passed on the retained RunPod
  builder in 10.76 seconds, and the final checkpoint-only replay also passed.
- Lean inventory: 652 public named declarations counted by the proof-to-prose
  checker across the thirty-five substantive modules. The tree also
  has 18 one-line deterministic placeholders, one `.gitkeep`-only Random
  branch, and five `.gitkeep`-only Quantum Chaos branches.
- Proof holes: none (`sorry` and `admit` absent).
- Teaching snapshot by the deterministic body-only regex `\b[\w'-]+\b`:
  229,055 tokens across the thirty-five Notebook companions and 275,325
  tokens across thirty-two Deep Dives (192,777) and fifty glossary chapters
  (82,548).
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
| `NonlinearDynamics.Random.RandomCocycles.NormObservables` | Maximum absolute row-sum finite-time norm, exact row-sum formula, entrywise measurability, cocycle submultiplicativity, zero-faithful extended log norm, extended-real subadditivity, and explicit positive/empty-dimension branches | `finite-time-cocycle-norm-and-extended-log-norm-observables` |
| `NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability` | Real log-positive finite-time envelope, nonnegativity, measurability, subadditivity, finite orbit-sum domination, an explicit one-step integrability hypothesis, and propagation through preserved base iterates, finite sums, and every finite horizon | `finite-horizon-log-positive-cocycle-integrability` |
| `NonlinearDynamics.Random.RandomCocycles.IntegratedLogPlusGrowth` | Raw-measure integrals of every finite-horizon log-positive envelope, shifted-integral invariance, an exact orbit-sum integral, a linear one-step bound, scalar subadditivity, positive-time normalization, and deterministic Fekete convergence | `integrated-log-positive-growth-and-deterministic-fekete-limit` |
| `NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase` | A generic integrable shifted-subadditive-process candidate, deterministic Fekete-rate bounds, probability-guarded expectation terminology, and native ergodic rigidity for invariant events and real observables, with no samplewise-limit claim | `probability-and-ergodic-base-interfaces-for-matrix-cocycles` |
| `NonlinearDynamics.Random.RandomCocycles.SubadditiveFiniteBlocks` | Both finite block-plus-remainder orientations, quotient/remainder forms, the exact time-zero normalization boundary, fixed-block Birkhoff-sum integrability under block-map preservation alone, and cocycle log-positive specializations without probability, ergodicity, or convergence claims | `finite-block-birkhoff-bounds-for-subadditive-cocycles` |
| `NonlinearDynamics.Random.RandomCocycles.SubadditiveCentering` | Orbit-majorant centering, positive-horizon and time-zero-aware nonpositivity, preserved shifted subadditivity, finite-horizon integrability under one-step preservation, an exact normalized split, and direct log-positive cocycle specializations without a limit claim | `orbit-majorant-centering-for-subadditive-cocycles` |
| `NonlinearDynamics.Random.RandomCocycles.SubadditivePhaseAveraging` | Exact residue-phase reindexing, prefix/block/tail bounds, deletion of positive-time gaps, total multiplication and positive-block division forms, centered-process phase bounds, and a direct cocycle specialization without any convergence claim | `phase-averaged-sliding-block-bounds-for-subadditive-cocycles` |
| `NonlinearDynamics.Random.RandomCocycles.SubadditiveIntervalPacking` | Gap-indexed ordered positive-length half-open interval packings, exact covered cardinality, a leftmost greedy cover with separate coverage and provenance, weak arbitrary-mark and strict nonempty-mark favorable-cost bounds, exact time-zero boundaries, and finite candidate/centered/cocycle wrappers without a density or limit claim | `ordered-disjoint-interval-packing-for-subadditive-cocycles` |
| `NonlinearDynamics.Random.RandomCocycles.BirkhoffConvergence` | Measurable and integrable finite real Birkhoff sums/averages, the convergence event and representative transport, exact one-prefix preimage invariance, conditional ergodic null/conull and probability zero-one consequences, and process/cocycle wrappers without a convergence-existence claim | `birkhoff-convergence-events-and-ergodic-rigidity-in-lean` |
| `NonlinearDynamics.Random.RandomCocycles.FiniteHopfMaximal` | Finite Birkhoff-sum maxima, strict Hopf events, the core integral nonnegativity theorem without finite mass, centered finite average-exceedance integral and positive-part bounds, and a positive-threshold weak measure estimate | `finite-hopf-maximal-ergodic-lemma-in-lean` |
| `NonlinearDynamics.Random.RandomCocycles.InfiniteHopfMaximal` | Positive-time infinite average-exceedance event, exact increasing-union representation, ordinary and null measurability routes, unconditional extended-measure continuity, locally finite real-measure continuity, an all-threshold positive-part multiplication bound, and the positive-threshold weak maximal estimate | `infinite-horizon-birkhoff-average-exceedance-bounds-in-lean` |
| `NonlinearDynamics.Random.RandomCocycles.KoopmanL2Mean` | Totalized forward-coboundary telescoping, the real square-integrable Koopman contraction and fixed-space projection, norm mean convergence, a dense fixed-plus-simple-coboundary core, generic almost-everywhere subsequences, and full-sequence convergence-event membership on the core | `koopman-l2-mean-convergence-and-a-dense-pointwise-good-core-in-lean` |
| `NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoff` | Absolute positive-time weak maximal control, measurable fixed-scale Cauchy exceptional events, the dense-good maximal-closure theorem, a finite-measure continuous and dense `L² → L¹` bridge, and full-sequence almost-everywhere convergence for every real integrable observable without identifying the limit | `finite-measure-pointwise-birkhoff-by-maximal-closure-in-lean` |
| `NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoffLimit` | One exact-invariant total limit representative, identical orbit laws, uniform integrability, finite-measure Vitali `L¹` convergence, noninvertible invariant-set integral transport, and identification with conditional expectation | `identifying-the-finite-measure-birkhoff-limit-in-lean` |
| `NonlinearDynamics.Random.RandomCocycles.ErgodicBirkhoffLimit` | Exact invariance of the conditional-expectation representative, pre-ergodic almost-everywhere constancy, finite nonzero normalized-integral identification, and full ergodic Birkhoff convergence to the ordinary integral on probability spaces | `identifying-the-ergodic-birkhoff-constant-in-lean` |
| `NonlinearDynamics.Random.RandomCocycles.SubadditiveUpperLimsup` | Exact finite Birkhoff-sum and centered-block integration, original-map phase-averaged fixed-block upper-limsup control, and the all-block log-positive cocycle bound by the deterministic integrated Fekete rate | `subadditive-upper-limsup-from-phase-averaging-in-lean` |
| `NonlinearDynamics.Random.RandomCocycles.SubadditiveBadBlockMeasure` | Finite orbit-visit counting, exact indicator-sum integration, strict finite centered bad-block sets, greedy packed pointwise control, the generic finite-measure rate ratio, and its log-positive cocycle specialization without probability or ergodicity | `finite-centered-bad-block-measure-control-in-lean` |

The root aggregator imports all thirty-five modules. The proof-to-prose manifest and
`scripts/check_lean_notebook_coverage.py` enforce paired coverage and named
declaration visibility.

## Completed Teaching Layer

- Thirty-five comprehensive Development Notebook chapters in an explicit
  dependency-ordered previous/next sequence.
- Thirty-two textbook-scale Deep Dives: *Random Matrices: From Outcomes to Spectra*,
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
  One-Sided Discrete Matrix Cocycles*, and *Finite-Time Norm and
  Extended-Log-Norm Observables for Matrix Cocycles*, and *Finite-Horizon
  Log-Positive Cocycle Integrability*, *Integrated Log-Positive Cocycle
  Growth and Its Deterministic Fekete Limit*, and *Probability Normalization
  and Ergodic Rigidity Before Kingman*, followed by *Finite Block
  Decomposition for Subadditive Processes*, *Orbit-Majorant Centering for
  Subadditive Processes*, *Finite Phase Averaging for Nonpositive Subadditive
  Processes*, and *Finite Ordered Interval Packing for Nonpositive Subadditive
  Processes*, *Birkhoff Convergence Events Before the Pointwise Ergodic
  Theorem*, and *Finite Maximal Ergodic Inequalities: From Orbit Maxima to
  Threshold Events*, followed by *From Finite Maximal Bounds to an Infinite
  Weak Estimate*, and *Mean Is Not Pointwise: Koopman Geometry,
  Coboundaries, and the Missing Maximal Step*, *Pointwise Birkhoff
  from Maximal Control and Dense Good Functions*, and *Birkhoff Limits,
  Invariant Sigma Algebras, and Conditional Expectation*, followed by
  *Ergodic Birkhoff Limits and Normalized Space Averages*, followed by
  *Subadditive Upper Limsup Bounds Before Kingman Convergence*, followed by
  *Finite Bad-Block Measure Bounds Before Kingman Lower Liminf*.
- Fifty glossary chapters, now including the finite orbit visit count, limit superior, ergodicity, normalized space
  averages, the invariant sigma algebra,
  conditional expectation, uniform integrability, the Birkhoff Cauchy exceptional
  set and weak-type (1,1) maximal bound, the Koopman operator and Koopman
  coboundary, as well as the infinite-horizon
  Birkhoff-average exceedance event, the finite maximal ergodic inequality,
  the Birkhoff convergence event,
  ordered interval packing, phase averaging,
  orbit-majorant centering, the Birkhoff sum, the ergodic probability base,
  the integrated log-positive growth rate, the log-positive integrability
  envelope, the extended log-norm
  observable, one-sided discrete matrix
  cocycles, finite random-matrix products,
  forward matrix products, and the induced infinity operator norm, as well as
  empirical spectral laws, Weyl
  eigenvalue perturbation, empirical spectral measures, finite matrix trace
  moments, and normalized Hermitian coordinates
  alongside GUE, Hermitian Frobenius geometry, scalar Gaussian, independence,
  normalization, and matrix and measure-theory foundations.
- One hundred seven deterministic 1200x630 social cards and 155 accessible
  conceptual SVG figures.
- Guided Hugo learning path with article orientation, progress, table of
  contents, code copy, teaching panels, glossary search, and responsive/print
  layouts. Rendered desktop and 390-pixel mobile QA found and fixed article
  overflow while retaining local scrolling for wide tables and diagrams.

## Exact Next Milestone

### RMT-31: all-positive-length centered bad-block control

The next module should pass from RMT-30's nested finite bad-block sets to the
event that a centered process falls below the same linear threshold at some
positive length. This is a countable-union and finite-measure-continuity
milestone. It is deliberately not an ergodic lower-liminf theorem.

The intended generic public surface is:

1. `centeredAllLengthBadBlockSet`, defined as the union over finite length
   caps of `finiteCenteredBadBlockSet T X m c`;
2. a membership theorem identifying that union with the existence of some
   positive `n` such that
   `centeredProcess T X n ω < c * (n : ℝ)`;
3. monotonicity of `finiteCenteredBadBlockSet` in its cap and an exact theorem
   expressing the all-length set as its increasing union;
4. `IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredAllLengthBadBlockSet`;
5. `IsIntegrableSubadditiveProcessCandidate.measureReal_centeredAllLengthBadBlockSet_le_rateRatio`,
   retaining RMT-30's generic blockwise lower-rate premise and conclusion
   `μ.real (centeredAllLengthBadBlockSet T X c) ≤ δ / c`; and
6. a log-positive cocycle wrapper, tentatively named
   `centeredLogPlusAllLengthBadBlockSet`, together with the corresponding
   measure-ratio theorem at
   `δ = integratedLogPlusGrowthRate hC - integratedLogPlusNorm 1`.

The proof should use only countable null measurability, nesting of the finite
caps, finite-measure continuity from below, and the uniform RMT-30 estimate.
It needs finite measure and preservation but neither probability nor
ergodicity. Keep the strict threshold and the positive-length index explicit.
Audit the empty cap, zero process, zero measure, finite rescaling, the existing
nonergodic two-atom model with a genuinely nonempty bad set, equality at the
strict threshold, and an empty matrix index.

Most importantly, do not call the raw all-length union invariant. Shifted
subadditivity gives only a threshold-relaxed, one-sided relationship, and a
negative slope makes the missing endpoint arithmetic consequential. A later
RMT-32 should instead define the countably generated asymptotic event
`liminf centeredProcess / n < c` using rational margins and arbitrarily late
positive lengths. A stricter rational margin can then yield the needed
one-sided preimage inclusion; preservation and finite measure can upgrade that
to almost invariance. RMT-32 must add probability normalization before using
ergodicity to force zero or one mass; RMT-31's ratio strictly below one can
then select the null branch. Countably many thresholds approaching the
integrated centered rate should prove the complementary lower liminf before
combining it with RMT-29.

RMT-31 itself must not claim invariance of its raw union, a lower liminf,
samplewise convergence, equality with the integrated rate, full Kingman
convergence, `L¹` convergence, limit-integral interchange, powered-map
ergodicity, a signed logarithmic rate, a Lyapunov exponent, or an Oseledets
splitting.

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
- [x] Finite-time maximum-row-sum norm and extended-log-norm observables.
- [x] Finite-horizon log-positive envelope and explicit one-step
  integrability propagation.
- [x] Integrated log-positive subadditivity and deterministic Fekete limit.
- [x] Native probability normalization and ergodic-base rigidity interfaces,
  with the finite-horizon family packaged as an integrable
  shifted-subadditive-process candidate.
- [x] Exact finite block and quotient/remainder Birkhoff bounds, including both
  remainder orientations, the time-zero boundary, block-map-only finite-sum
  integrability, and log-positive cocycle specializations.
- [x] Orbit-majorant centering by the one-step Birkhoff sum, with the exact
  positive-horizon/time-zero boundary, preserved shifted subadditivity,
  finite-horizon integrability, normalized splitting, and cocycle
  specializations.
- [x] Finite residue-phase averaging, including exact sliding-sum reindexing,
  boundary retention and deletion, zero-block totalization, positive-block
  division, centered-process bounds, and a direct cocycle specialization.
- [x] Finite ordered interval packing, including gap-indexed half-open
  geometry, exact covered cardinality, leftmost greedy selection with coverage
  and provenance, weak empty-mark and strict nonempty-mark favorable-cost
  bounds, time-zero countermodels, and finite cocycle specializations.
- [x] Real Birkhoff convergence-event measurability, representative transport,
  exact one-prefix preimage invariance, and conditional ergodic null/conull and
  probability zero-one consequences, without a convergence-existence claim.
- [x] Finite Birkhoff-sum maxima, strict Hopf events, integral nonnegativity,
  centered finite average-exceedance bounds, and the exact finite-mass and
  positive-threshold gates for weak measure estimates.
- [x] Positive-time infinite Birkhoff-average exceedance events, their exact
  increasing-union form, separate ordinary and null measurability routes,
  unconditional extended-measure continuity, a sufficient locally finite
  `Measure.real` conversion, the infinite weak maximal estimate, and paired
  infinite-mass boundary probes showing that local finiteness is not necessary
  for every particular real-measure limit.
- [x] Koopman `L²` mean convergence, dense fixed-plus-simple-coboundary core,
  and the almost-everywhere pointwise-good representative bridge.
- [x] Full finite-measure `L¹` pointwise Birkhoff theorem from density,
  absolute weak maximal control, and oscillation/Cauchy exceptional sets.
- [x] Identification of the finite-measure pointwise Birkhoff limit as
  conditional expectation onto the exact invariant sigma algebra, including
  uniform integrability, `L¹` convergence, and noninvertible invariant-set
  integral transport.
- [x] Positive-finite-mass and probability ergodic specializations identifying
  the invariant target with the correctly normalized constant, with
  pre-ergodic rigidity kept separate from measure-preserving convergence.
- [x] Kingman-style upper-limsup control from finite phase averaging and
  original-map Birkhoff limits, including the all-block log-positive cocycle
  bound by the integrated Fekete rate.
- [x] Finite centered bad-block measure control from greedy interval packing,
  including exact visit-count integration, the generic rate ratio, and the
  log-positive cocycle specialization without probability or ergodicity.
- [ ] All-positive-length bad-set continuity, the asymptotic
  lower-deviation/ergodic zero-one lower-liminf argument, and full
  log-positive Kingman convergence before asymptotic exponents.
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
- RMT-14 fixes the cocycle matrix norm to Mathlib's maximum absolute row-sum
  norm, the operator norm induced by the vector supremum norm. It exposes the
  finite supremum of absolute row sums explicitly and does not call this the
  Frobenius or Euclidean spectral norm.
- Norm measurability is reconstructed from measurable entries, complex entry
  norms, finite row sums, and finite suprema. The proof does not silently
  substitute a norm-generated Borel structure for the project's entrywise
  matrix measurable space.
- `logNormObservable` takes `ENNReal.log` of the extended nonnegative norm and
  lands in `EReal`. Its value is `⊥` exactly when the entire cocycle matrix is
  zero. Singularity alone is not enough.
- The checked RMT-14 split inequalities retain the RMT-13 order: the shifted
  later block is on the left and the earlier prefix is on the right. The
  extended-log inequality remains valid when either factor or their product
  vanishes.
- Positive matrix dimension is needed only for the time-zero norm-one and
  log-zero identities. In empty dimension every finite-time matrix has norm
  zero and extended log norm `⊥`; the definitions, measurability, and split
  inequalities remain valid.
- RMT-14 is an observable layer, not an integrability or asymptotic theorem.
  Measurability and subadditivity alone do not supply probability,
  integrability, ergodicity, normalized limits, Lyapunov exponents, or an
  Oseledets splitting.
- RMT-15 uses Mathlib's real `log⁺`, which is zero exactly when the nonnegative
  norm is at most one. It retains expanding size but deliberately identifies
  neutral size, contraction, and exact collapse at zero. It therefore cannot
  replace RMT-14's zero-faithful `EReal` log norm.
- Time-zero log-positive growth is zero in every finite dimension. The proof
  splits positive dimension, where the identity norm is one, from empty
  dimension, where the identity matrix norm is zero; no global `Nonempty ι`
  assumption is added.
- The finite orbit sum uses indices `0` through `k - 1` and appends the term at
  base iterate `k` in its successor recursion. It is a pointwise majorant for
  the whole-product envelope, not an equality or a product-law factorization.
- `HasIntegrableGeneratorLogPlus` is exactly the integrability of the one-step
  real envelope. It is explicit evidence, not a consequence of measurability,
  measure preservation, finite matrix dimension, or any probability premise.
- Measure preservation carries that one-step integrability through each
  natural base iterate. Finite sums are integrable, and pointwise domination
  then gives integrability at every fixed finite horizon.
- RMT-15 proves no integrability for the extended-real log norm, no control of
  its negative tail or of inverse matrices, and no probability, expectation,
  ergodicity, normalized limit, Lyapunov exponent, Oseledets splitting, or
  random-Jacobian statement.
- RMT-16 defines `integratedLogPlusNorm` with Mathlib's totalized Bochner
  integral. The unconditional real-valued definition and its nonnegativity do
  not prove integrability; a nonintegrable integrand is assigned integral zero.
- Ordinary measurability and measure preservation identify each shifted
  totalized integral unconditionally. Under `HasIntegrableGeneratorLogPlus`,
  every finite-horizon envelope is integrable; finite linearity evaluates the
  orbit-sum integral as the horizon times the one-step integral, and pointwise
  domination yields the linear bound.
- The integrated sequence is subadditive without independence or ergodicity.
  Its normalized time-zero value is zero by Lean's division convention, while
  Mathlib's Fekete limit is the infimum over positive horizons only. The
  normalized sequence need not be monotone and no convergence rate is proved.
- The RMT-16 integral is not an expectation without probability normalization
  and is not measure-normalized. Dependence under finite scalar rescaling is an
  upstream consequence, not one of the module's thirteen declarations.
- RMT-16 proves convergence only for the deterministic numerical sequence of
  normalized integrals. It proves no samplewise, almost-everywhere,
  in-probability, distributional, or `L¹` convergence, performs no
  limit-integral interchange, and supplies no Lyapunov exponent, Kingman
  theorem, Oseledets splitting, inverse control, or random-Jacobian statement.
- RMT-17 keeps three logically independent gates visible. The generic
  `IsIntegrableSubadditiveProcessCandidate` stores finite-horizon
  integrability and the exact shifted pointwise inequality, but stores no
  probability, measure-preservation, ergodicity, stationarity, or limit field.
- The RMT-17 deterministic rate facts retain only
  `HasIntegrableGeneratorLogPlus`. Nonnegativity, the positive-index infimum,
  and every-positive-horizon upper bound require neither probability nor
  ergodicity. Time zero remains excluded from the infimum and upper-bound
  interface.
- `finiteHorizonLogPlusExpectation` is definitionally the existing raw
  integral. Its `[IsProbabilityMeasure μ]` and explicit integrability witness
  are semantic and analytic gates; the definition performs no rescaling and
  no limit-integral interchange.
- The invariant-event wrapper uses strict measurable-set invariance and needs
  both probability normalization and `Ergodic C.base μ`. The invariant-real-
  observable wrapper uses almost-everywhere invariance and ergodicity but no
  probability typeclass. Both deliberately omit irrelevant finite matrix-index
  assumptions.
- The pinned Mathlib 4.32.0 tree supplies probability typeclasses, ergodic
  structures, invariant-event rigidity, invariant-function constancy, and
  finite Birkhoff-sum algebra, but no ready-made Kingman or pointwise Birkhoff
  theorem. RMT-17 therefore constructs no samplewise limit, Lyapunov exponent,
  or Oseledets splitting.
- RMT-18 proves both finite remainder placements directly from the shifted
  subadditive inequality. The terminal-remainder and remainder-first bounds,
  including their quotient/remainder forms, need no normalization of `X 0`.
  At block count zero the uniform exact-block estimate is equivalent to the
  extra normalization `X 0 = 0`; shifted subadditivity alone forces only
  pointwise nonnegativity of `X 0`.
- The terminal quotient/remainder formula remains reflexive at block length
  zero under Lean's total natural division. A remainder is known to be shorter
  than its block only when the block length is positive; the generic
  three-parameter theorem intentionally assumes no such relation.
- Finite integrability of the block Birkhoff sum consumes only
  `MeasurePreserving (T^[b]) μ μ` together with integrability of the fixed
  block observable. Preservation of `T` is sufficient but not necessary for
  that theorem. Ergodicity is irrelevant, and ergodicity of `T` must not be
  transferred to every power `T^[b]`.
- The two RMT-18 cocycle pointwise bounds take the cocycle `C` directly and use
  no `HasIntegrableGeneratorLogPlus` premise. Only the finite block-sum
  integrability specialization takes that witness. All three specializations
  retain the empty matrix-index boundary and require neither probability nor
  ergodicity.
- RMT-18 is finite algebra and finite integrability only. It proves no
  Birkhoff-average convergence, maximal inequality, Kingman theorem,
  samplewise growth limit, Lyapunov exponent, or Oseledets splitting.
- RMT-19 defines `centeredProcess T X n ω` by subtracting the finite one-step
  Birkhoff orbit majorant from `X n ω`. The word *centered* therefore names
  pointwise orbit-majorant compensation, not subtraction of an expectation;
  the residual need not have integral or expectation zero.
- The one-step majorant and centered nonpositivity need no time-zero premise at
  positive horizons. Their uniform versions through `n = 0` require exactly
  `X 0 = 0`. The totalized normalized identity is unconditional, but its
  zero-time branch is the vacuous field identity `0 = 0` and carries no
  information about `X 0`.
- Centered shifted subadditivity is raw finite algebra. Integrability of every
  centered horizon and candidate packaging additionally require only
  `MeasurePreserving T μ μ`; probability and ergodicity remain irrelevant.
- RMT-19's cocycle nonpositivity, subadditivity, and normalized split take the
  cocycle directly. Only the integrable-candidate packaging consumes
  `HasIntegrableGeneratorLogPlus`. All declarations remain valid for an empty
  matrix index.
- RMT-19 proves an exact finite normalized decomposition, not convergence of
  either term. It supplies no pointwise Birkhoff theorem, maximal inequality,
  Kingman theorem, samplewise growth rate, Lyapunov exponent, or Oseledets
  splitting.
- RMT-20's `sum_phase_birkhoffSum` is a pure additive-commutative-monoid
  reindexing: the `b` residue phases, each sampled `q` times under `T^[b]`,
  enumerate exactly the first `b * q` starts under `T`. No theorem applies an
  ergodic result to the powered map.
- The phase boundary geometry is
  `s + b*q + (b+r-s) = b*q+b+r` for `s < b`. Positive-horizon
  nonpositivity discards both gaps when `s > 0`; at `s = 0`, the proof uses
  the terminal-remainder bound directly and therefore never assumes
  `X 0 ≤ 0` or `X 0 = 0`.
- Summing the phase bounds gives a multiplication theorem total at `b = 0`,
  but that branch is only `0 ≤ 0`. The division theorem requires exactly
  `b ≠ 0`. The remainder parameter `r` is unrestricted and must not be called
  short or Euclidean without a separate hypothesis.
- The public candidate methods retain the measurable-space, measure, and
  integrability data bundled by `IsIntegrableSubadditiveProcessCandidate`,
  even though their proofs project only finite algebra and positive-time sign
  facts. The cocycle theorem similarly takes a cocycle whose base is already
  bundled as measure preserving, but it consumes no generator-integrability
  witness, probability, ergodicity, or nonempty-index premise.
- Lalley's page-two phase display counts `q` complete blocks plus `b + r`
  boundary positions, which fits `b*q+b+r`, while printing the shorter
  horizon and a mutually incompatible averaged boundary count. RMT-20 keeps
  the complete-block count and records the resulting finite arithmetic repair;
  this does not dispute the asymptotic theorem.
- RMT-20 itself proves no pointwise or mean Birkhoff theorem, almost-everywhere
  or `L¹` convergence, Kingman upper estimate, invariant integral, maximal
  inequality, interval packing, Lyapunov exponent, or Oseledets splitting.
- RMT-21 represents each selected interval by a nonnegative preceding gap and
  a strictly positive length. Recursive tails make chronological order,
  half-open disjointness, zero gaps, abutment, singleton intervals, and a
  terminal gap structural rather than auxiliary propositions.
- `Covers` and `SelectedFrom` are intentionally separate. Coverage yields
  `marked.card ≤ coveredLength`; selection provenance transports hypotheses at
  marked starts to the actual interval costs. Neither predicate implies the
  other, and the selector theorem returns both.
- The selector target is `H + m`: starts lie below `H`, while their positive
  prescribed lengths are at most `m`. Generic packings may end exactly at
  their horizon, but selected endpoints are strictly below the enlarged
  horizon. The leftmost filter keeps a start equal to the prior excluded
  endpoint, so abutting output is legal.
- Weak packing and greedy marked-card bounds require a nonzero horizon because
  positive-time nonpositivity does not control `X 0`. Strict marked-card bounds
  instead require `marked.Nonempty`; coverage then forces a nonempty
  positive-length packing and derives horizon positivity. Empty strict local
  hypotheses are vacuous and cannot imply `0 < 0`.
- Coverage gives a lower bound on total covered length. The final marked-card
  upper bound therefore needs `c ≤ 0`, which reverses multiplication. Packing
  cost is a sum of variable-horizon process values at selected starts, not a
  Birkhoff sum of one-step values.
- RMT-21 proves finite selection, coverage, cardinality, and process algebra
  only. It supplies no marked-set density, maximal inequality, pointwise
  Birkhoff theorem, Kingman theorem, almost-everywhere limit, signed Lyapunov
  exponent, or Oseledets splitting.
- RMT-22 defines the Birkhoff convergence event without asserting it is
  inhabited. Adding or deleting one finite orbit prefix preserves convergence
  and the same finite limit, so the event is exactly preimage-invariant for an
  arbitrary base map. This is not image invariance or a two-sided-dynamics
  claim and uses no invertibility, injectivity, surjectivity, measurability, or
  boundedness.
- Ordinary measurability of the observable gives a measurable convergence
  event. Integrability gives only an almost-everywhere strongly measurable
  representative; quasi-measure preservation transports its event back to an
  honest null-measurable event. Ergodicity then gives only the conditional
  null-or-conull fork. Nothing in RMT-22 chooses the conull branch.
- `oneStepBirkhoffConvergenceSet` uses the candidate's time-one observable.
  The totalized identity `birkhoffAverage ... 0 = 0` says nothing about a
  separate process value at time zero. The cocycle wrapper needs only the raw
  measurable generator log-positive observable, not a global integrability
  package.
- RMT-23 includes the zero Birkhoff sum in each finite running maximum. Strict
  positivity of that maximum forces a positive maximizing time, which is what
  licenses the pointwise indicator inequality. The Hopf cancellation theorem
  itself uses only measure preservation and integrability, not finite total
  mass.
- Centering by a real threshold introduces a constant integrable observable,
  so the finite threshold layer uses `[IsFiniteMeasure μ]`. Its multiplication
  estimate is valid for every real threshold. Only division into the weak
  measure estimate requires exactly `0 < a`; the zero-threshold multiplication
  identity is valid but supplies no divided bound.
- RMT-24 defines its event by an existential positive-time witness rather than
  a totalized real supremum. It is exactly the union of the nested RMT-23
  finite events, and every finite event embeds in it. These four set-level
  declarations require no measurable-space structure.
- Ordinary measurability of the infinite event follows from measurable `T`
  and `g`. The alternative null-measurable theorem uses preservation and
  integrability and deliberately adds neither ordinary measurability of the
  supplied representative nor finite total mass.
- Continuity from below is first kept in `ℝ≥0∞`, where the theorem needs only
  the increasing union and does not require set measurability, dynamics, or
  finiteness. `Measure.real` is a totalized projection with `∞.toReal = 0`, so
  it is not globally continuous on increasing unions.
- The RMT-24 real-continuity corollary assumes the target union has finite
  extended measure. This is a useful local sufficient interface, not a logical
  characterization. Under counting measure, finite initial segments exhibit
  failure at an infinite union, while an eventually universal sequence has
  totalized real measures constantly zero and therefore still converges.
- The infinite positive-part multiplication bound uses finite total mass,
  preservation, and integrability. The final weak estimate additionally uses
  a positive threshold. Neither result proves that Birkhoff averages converge,
  identifies their limit, or chooses the conull branch of the RMT-22
  convergence event.
- RMT-25 and RMT-26 separate the mean, dense-core, maximal-closure, and
  completeness stages. Square-integrable Koopman convergence supplies a dense
  pointwise-good core; absolute weak control closes that core in finite-measure
  real `L¹`. Neither stage identifies the pointwise limit.
- RMT-27 uses one total `limUnder` representative. Its fallback has no
  asymptotic meaning, but the divergent branch must be one-step stable so the
  representative is literally invariant everywhere rather than only on the
  conull convergence event.
- Mathlib's `MeasurableSpace.invariants T` means ambient-measurable sets with
  literal `T ⁻¹' s = s`. Completion modulo null sets is a related classical
  interface, not a definitional replacement. The one-way inclusion into
  `invariants (T^[i])` must not be reversed.
- Measure preservation gives identical laws of the orbit translates without a
  probability or finite-mass premise. The selected uniform-integrability and
  Vitali interfaces add finite mass and integrability. Almost-everywhere
  convergence alone never licenses passage of invariant-set integrals.
- RMT-27 transports restricted measures through exact preimages instead of
  substituting image sets. This is the canonical noninvertible route and adds
  no injectivity, surjectivity, measurable-embedding, or inverse premise.
- The public RMT-27 identification accepts raw `Integrable f μ`. A strongly
  measurable representative is private proof architecture; both the total
  Birkhoff limit and conditional expectation are transported back through
  almost-everywhere equality.
- Conditional expectation is identified by three separate locks:
  invariant-sigma-algebra measurability, integrability, and equality of
  integrals on every exactly invariant measurable set. It is not inferred from
  notation or from pointwise convergence.
- The general finite-measure limit is an invariant function, not a constant.
  Ergodicity may provide almost-everywhere constancy only in RMT-28, and
  identifying the constant by division requires positive total mass.
- RMT-29 applies RMT-20 phase averaging and RMT-28 Birkhoff convergence only
  under the original map. It does not assume that a powered map is ergodic.
  The resulting upper bound is for a nonnegative integrable subadditive
  process and specializes only to log-positive cocycle growth.
- RMT-30's strict finite bad-block set ranges over `Finset.Icc 1 m`, so the
  empty cap is honest and time zero never becomes an admissible block length.
  Its greedy pointwise estimate genuinely needs `H + m ≠ 0` and `c ≤ 0`;
  the joint zero corner is false, while the time-one centered identity derives
  the sign needed by the final rate-ratio theorem.
- RMT-30's auxiliary visit horizon is proof architecture, not part of the
  finite bad set. The final theorem needs finite measure and preservation but
  neither probability nor ergodicity. A nonergodic two-atom identity system
  checks a genuinely nonempty singleton bad set of mass `1 / 2`, rather than
  validating the endpoint only through an empty event.
- The raw union of finite centered bad-block sets over all length caps must not
  be described as invariant. RMT-31 should use increasing-union continuity
  only. The later ergodic step must instead use an asymptotic lower-deviation
  event with rational threshold slack, derive a one-sided preimage inclusion,
  justify almost invariance, and add probability normalization before invoking
  zero-one rigidity.
- For agent-assisted mathematical discovery, preserve the sourced problem,
  exact Lean statement, material exploratory decisions, and canonized
  proof-to-prose result as distinguishable artifacts. Audit definitions before
  proof search, informalize only from checked Lean, and record who selected,
  clarified, strategized, verified, and wrote each material discovery. The
  Kourovka/Aristotle paper arXiv:2607.17477 is a process precedent, not a source
  for nonlinear-dynamics mathematics.
- RunPod compute and storage remain behind a human approval gate even when an
  API key is present. The owner granted project-scoped approval on 2026-07-21
  for the active formalization goal. Keep exact resource inventory and costs
  visible, keep secrets and resource identifiers out of the repository, and
  treat the remote builder as reproducible acceleration rather than a second
  source of truth.
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
  probability packaging, generator-presented one-sided cocycles over
  measure-preserving bases, and finite-time norm and zero-faithful extended-log
  observables are formalized. The real log-positive envelope and propagation of
  an explicit one-step integrability hypothesis through every finite horizon
  are also formalized, as are integrated scalar subadditivity and its
  deterministic Fekete limit. Extended-log and negative-tail integrability,
  inverse control, normalized sample growth, Lyapunov exponents, and ergodic
  limits remain open. Probability-guarded expectation terminology and native
  invariant-event and invariant-observable rigidity are now formalized, as are
  both finite block/remainder orientations and fixed-block Birkhoff-sum
  integrability. Orbit-majorant centering, its positive-time nonpositive
  residual, preserved subadditivity, finite-horizon integrability, and exact
  normalized split are now formalized as well. Finite residue-phase averaging
  now turns all powered-map block rows into one consecutive Birkhoff sum while
  retaining the exact gap arithmetic and the block-length-zero boundary.
  Ordered interval packing and its greedy marked-start cover are now
  formalized too, including exact covered cardinality, local-cost provenance,
  weak empty-mark and strict nonempty-mark bounds, and the false horizon-zero
  countermodel. The real Birkhoff convergence event is now formalized with
  representative transport, exact preimage invariance, conditional ergodic
  rigidity, and probability zero-one consequences. Finite Birkhoff-sum maxima,
  the strict Hopf event, its integral nonnegativity theorem, and finite-horizon
  average-exceedance weak estimates are formalized too. RMT-24 now adds the
  exact positive-time infinite exceedance event, separate regularity routes,
  extended-measure continuity, the infinite positive-part estimate, and the
  weak maximal bound. RMT-25 now adds totalized forward-coboundary telescoping,
  the real square-integrable Koopman contraction, fixed-space projection and
  norm mean convergence, the one-sided coboundary-closure geometry, a dense
  fixed-plus-simple-coboundary core, generic almost-everywhere convergent
  subsequences, and full-sequence convergence-event membership on that core.
  RMT-26 now adds the absolute positive-time weak estimate, fixed-scale Cauchy
  exceptional events, the finite-measure dense `L² → L¹` bridge, and
  full-sequence almost-everywhere convergence for every real integrable
  observable. RMT-27 now adds one exact-invariant total limit representative,
  identical orbit laws, uniform integrability of orbit translates and Cesaro
  averages, finite-measure Vitali `L¹` convergence, noninvertible
  restricted-measure integral transport, and identification of the full
  pointwise limit as conditional expectation onto the exact invariant sigma
  algebra. RMT-28 now identifies that invariant target with the correctly
  total-mass-normalized constant under positive finite mass and with the raw
  integral under probability normalization. RMT-29 now adds the generic
  nonnegative subadditive upper-limsup estimate and the all-block log-positive
  cocycle bound by the integrated Fekete rate, using only Birkhoff averages
  under the original map. RMT-30 now adds exact finite orbit-visit integration,
  strict finite centered bad-block sets, greedy packed pointwise control, and
  the generic and cocycle finite bad-block rate ratios without probability or
  ergodicity.
  `Measure.real` still totalizes infinite extended measure
  to zero: local finiteness is a sufficient conversion gate, not a necessary
  condition for every individual projected limit, and no unconditional general
  real-continuity theorem is available. The existing interfaces still do not
  pass the finite estimate to the all-positive-length union, prove the
  asymptotic lower-deviation event almost invariant, establish a complementary
  lower-liminf estimate or full subadditive convergence, or construct a signed
  log-growth limit or samplewise Lyapunov exponent.
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
- RMT-14 Lean audit: all 14 public declarations implement the selected maximum
  absolute row-sum norm, its exact formula and entrywise measurability,
  finite-time norm submultiplicativity, a zero-faithful extended-real log norm,
  its measurability and subadditivity, and explicit positive/empty-dimension
  branches. The module and aggregators pass warnings as errors; the full build
  completes 3,165 jobs; no proof holes, unsafe declarations, or custom axioms
  occur; and theorem audits contain only `propext`, `Classical.choice`, and
  `Quot.sound` where needed.
- RMT-14 static teaching audit: the 6,329-word Notebook maps all 14 public
  declarations in source order; the new glossary and Deep Dive contain 1,904
  and 5,425 words and preserve the norm choice, entrywise measurable-space
  proof, extended-number types, zero boundary, dimension split, and strict
  finite-time nonclaims. All three deterministic cards reproduce byte-for-byte
  at 1200x630 from both the repository and `/private/tmp`; all three accessible
  prose-only SVGs parse and render; source hygiene passes 69 Markdown files;
  coverage passes 19/19 modules; and Hugo builds 204 pages with warnings fatal.
- Rendered RMT-14 QA: the Notebook, glossary, and Deep Dive render 91, 46, and
  85 KaTeX nodes respectively at both desktop and mobile widths. The amended
  RMT-13 Notebook, glossary, and Deep Dive remain stable at 120, 63, and 114.
  All six pages have zero KaTeX errors, raw delimiters, malformed equality
  headings, page overflow, or browser console failures; desktop documents fit
  1,280 pixels and mobile documents fit 390 pixels exactly. Cards and
  explicitly scrolled lazy SVGs load at their intrinsic dimensions, the new
  Notebook and Deep Dive render their AI-use disclosure exactly once, and all
  Notebook and reciprocal Knowledge Base links are exact.
- RMT-15 Lean audit: all 16 public declarations implement the real
  log-positive finite-time envelope, its nonnegativity, time-zero/one-step and
  empty-dimension identities, measurability and subadditivity, exact finite
  orbit sums, pointwise domination, an explicit one-step integrability
  hypothesis, and its propagation through base iterates, sums, and finite
  horizons. The module and import chain pass warnings as errors; the root build
  completes 3,167 jobs; edge tests distinguish extended-log bottom from
  log-positive zero and confirm all norms at most one map to zero; no proof
  holes or unsafe declarations occur; and all 13 theorem audits contain only
  `propext`, `Classical.choice`, and `Quot.sound`.
- RMT-15 static teaching audit: the 5,846-word Notebook maps all 16 public
  declarations in source order; the new glossary and Deep Dive contain 1,554
  and 4,956 words and preserve the envelope-versus-observable distinction,
  finite orbit indexing, explicit integrability evidence, raw-measure scope,
  and exhaustive nonclaims. All three deterministic cards reproduce
  byte-for-byte at 1200x630 from both the repository and `/private/tmp`; all
  three accessible prose-only SVGs parse and render; source hygiene passes 72
  Markdown files; coverage passes 20/20 modules; and Hugo builds 215 pages with
  warnings fatal. A visual pre-freeze pass replaced an unexplained `L1` card
  acronym with the self-contained phrase `integrability hypothesis`.
- Rendered RMT-15 QA: the Notebook article body, glossary, and Deep Dive render
  222, 65, and 133 KaTeX nodes respectively at both desktop and mobile widths.
  The Notebook table of contents intentionally repeats one heading formula, so
  its full document contains 223 nodes. The amended RMT-14 Notebook, glossary,
  and Deep Dive remain stable at 91, 46, and 85. All six pages have zero KaTeX
  errors, raw delimiters, malformed equality headings, page overflow, or
  browser console failures; desktop documents fit 1,280 pixels and mobile
  documents fit 390 pixels exactly. Cards and explicitly scrolled lazy SVGs
  load at their intrinsic dimensions, the new Notebook and Deep Dive render
  their AI-use disclosure exactly once, and all Notebook and reciprocal
  Knowledge Base links are exact.
- RMT-16 Lean audit: all 13 public declarations implement totalized raw-measure
  integrals of the finite-horizon envelope, unconditional shifted-integral
  invariance, exact orbit-sum integration, the one-step linear bound, scalar
  subadditivity, positive-time normalization, the positive-index Fekete rate,
  and deterministic convergence. Declarations 1 through 4 and 9 through 11
  are unconditional; declarations 5 through 8 and 12 through 13 carry the
  explicit `HasIntegrableGeneratorLogPlus` hypothesis. The leaf and complete
  import chain pass warnings as errors; the root build completes 3,169 jobs;
  independent smoke checks cover nonintegrable totalization, zero measure,
  identity cocycles, empty matrix dimension, time zero, and zero-rate
  convergence; no proof holes or unsafe declarations occur; and theorem axiom
  audits contain only `propext`, `Classical.choice`, and `Quot.sound` where
  needed.
- RMT-16 static teaching audit: the 7,138-word Notebook maps all 13 declarations
  in source order and contains eight claim-local links to seven unique
  references. The new 1,864-word glossary and 5,061-word Deep Dive preserve
  raw-integral versus
  expectation semantics, totalization, the exact integrability boundary,
  positive-index Fekete semantics, finite scalar rescaling, and exhaustive
  samplewise and Lyapunov nonclaims. The three deterministic cards reproduce
  byte-for-byte at 1200x630 from the repository and `/private/tmp`; all three
  accessible prose-only SVGs parse and render; source hygiene passes 75
  Markdown teaching files; coverage passes 21/21 modules; and Hugo builds 222
  pages with warnings fatal. Independent review corrected the Kingman primary
  citation, required strictly positive mass in two calibration examples, and
  made the visual dependency graph show that integrability licenses the
  subadditivity branch while normalized nonnegativity and its lower bound are
  unconditional.
- Rendered RMT-16 QA: the Notebook, glossary, and Deep Dive render 171, 73, and
  171 KaTeX nodes respectively at both desktop and mobile widths. The amended
  RMT-15 Notebook, glossary, and Deep Dive remain stable at 223, 65, and 133.
  All six pages have zero KaTeX errors, raw delimiters, malformed equality
  headings, page overflow, or browser console failures; desktop documents fit
  1,280 pixels and mobile documents fit 390 pixels exactly. Cards and
  explicitly scrolled lazy SVGs load at 1200x630, 920x620, 800x690, and
  800x760 as declared; the new Notebook and Deep Dive each render the canonical
  disclosure once; all eight Notebook citation links reach their seven unique
  reference anchors; and all Notebook and reciprocal Knowledge Base
  predecessor and successor links are exact.
- RMT-17 Lean audit: all 10 source-level public declarations implement the
  integrable shifted-subadditive-process candidate, its cocycle instance,
  deterministic rate bounds, the guarded finite-horizon expectation alias,
  and native ergodic rigidity for invariant events and real observables. The
  exported interface has 12 names when the structure's two generated
  projections are counted. The leaf, all aggregators, the actual-import smoke,
  and adversarial empty-dimension and assumption-omission checks pass with
  warnings fatal; the full build completes 3,172 jobs across 22 substantive
  modules and 402 public named declarations. No proof holes, unsafe
  declarations, or custom axioms occur, and theorem audits contain only
  `propext`, `Classical.choice`, and `Quot.sound` where needed.
- RMT-17 static teaching audit: the 8,501-word Notebook maps every declaration
  and both generated projections in source order; the new 1,780-word glossary
  and 6,875-word Deep Dive separate probability normalization, ergodic
  rigidity, finite-horizon integrability, and the deterministic Fekete rate
  without importing a samplewise theorem. All three deterministic cards
  reproduce byte-for-byte at 1200x630 from both the repository and
  `/private/tmp`; the 920x650, 800x620, and 800x720 prose-only SVGs parse and
  render. Source hygiene passes 78 Markdown teaching files, coverage passes
  22/22 modules, and Hugo builds 237 pages with warnings fatal.
- Rendered RMT-17 QA: the Notebook, glossary, and Deep Dive render 112, 36,
  and 120 KaTeX nodes respectively at both 1,280- and 390-pixel widths. The
  amended RMT-16 Notebook, glossary, and Deep Dive remain stable at 171, 73,
  and 171. All six pages have one article heading, zero KaTeX errors, raw
  delimiters, page-level overflow, broken assets, or browser console failures.
  Cards and explicitly scrolled lazy SVGs load at their declared intrinsic
  dimensions, canonical disclosures render exactly once on the new Notebook
  and Deep Dive, and the Notebook sequence and reciprocal Knowledge Base
  crosslinks are exact. Visual review also corrected finite-only wording for
  the fourth assumption-separation example before freeze.
- RMT-18 Lean audit: all 12 public declarations and three private raw helpers
  implement the two finite block/remainder orientations, quotient/remainder
  corollaries, the exact-block time-zero boundary, fixed-block Birkhoff-sum
  integrability, and three log-positive cocycle specializations. The leaf,
  aggregators, root import, and adversarial smokes pass warnings as errors; the
  complete build finishes 3,174 jobs across 23 substantive modules and 414
  public named declarations. Smokes cover `b = 0`, `q = 0`, a constant-one
  countermodel, preservation of the block map alone, both pointwise cocycle
  bounds without an integrability witness, and empty matrix dimension. No
  proof holes, unsafe declarations, or custom axioms occur; theorem audits
  contain only `propext`, `Classical.choice`, and `Quot.sound` where needed.
- RMT-18 static teaching audit: the final 7,710-word Notebook, 2,578-word
  glossary, and 7,344-word Deep Dive cover every declaration in source order,
  both orientations, all exact assumption boundaries, the two-cycle
  power-ergodicity counterexample, and exhaustive convergence nonclaims.
  Source hygiene passes 81 Markdown files, coverage passes 23/23 modules, and
  Hugo builds 246 pages with warnings fatal. All three deterministic cards
  reproduce byte-for-byte at 1200x630 from both the repository and
  `/private/tmp`; the 920x650, 600x940, and 760x420 prose-only SVGs parse and
  render. Citation audit links iterate alignment, integrability transport, and
  finite-sum integrability to their exact pinned Mathlib interfaces.
- Rendered RMT-18 QA: the Notebook, glossary, and Deep Dive render 263, 108,
  and 340 KaTeX nodes respectively at both 1,280- and 390-pixel widths. The
  amended RMT-17 Notebook, glossary, and Deep Dive remain stable at 112, 36,
  and 120. All six pages have one article heading, zero KaTeX errors, raw
  delimiters, page-level overflow, broken assets, or browser console failures.
  Cards and explicitly scrolled lazy SVGs load at their declared intrinsic
  dimensions, the canonical disclosure renders exactly once on the new
  Notebook and Deep Dive, all predecessor/successor and reciprocal Knowledge
  Base links are exact, and desktop plus mobile screenshots pass visual review.
- RMT-19 Lean audit: all 18 public declarations and two private raw helpers
  implement the one-step orbit majorant, positive-horizon and uniform centered
  nonpositivity, preserved shifted subadditivity, finite-horizon integrability,
  candidate packaging, exact normalized splitting, and log-positive cocycle
  specializations. The leaf, aggregators, root import, and public smoke pass
  warnings as errors; the complete build finishes 3,176 jobs across 24
  substantive modules and 432 public named declarations. Smokes cover constant
  one, zero horizon, zero measure, identity base, and empty matrix dimension.
  No proof holes, unsafe declarations, or custom axioms occur; theorem audits
  contain only `propext`, `Classical.choice`, and `Quot.sound` where needed.
- RMT-19 static teaching audit: the 8,733-word Notebook, 2,707-word glossary,
  and 7,664-word Deep Dive cover every public declaration and private helper in
  source order, distinguish positive-time from time-zero interfaces, separate
  orbit-majorant from expectation centering, and state exhaustive convergence
  nonclaims. Source hygiene passes 84 Markdown files, coverage passes 24/24
  modules, and Hugo builds 253 pages with warnings fatal. All three
  deterministic cards reproduce byte-for-byte at 1200x630 from both the
  repository and `/private/tmp`; all four prose-only SVGs parse, render, and
  carry accessible title and description wiring. Claim-local primary and
  pinned-Mathlib citations pass their anchor audit.
- Rendered RMT-19 QA: the Notebook, glossary, and Deep Dive render 301, 110,
  and 310 KaTeX nodes respectively at both 1,280- and 390-pixel widths. The
  amended RMT-18 Notebook, glossary, and Deep Dive render 264, 108, and 340.
  All six pages have one article heading, zero KaTeX errors, raw delimiters,
  page-level overflow, broken assets, or browser console failures. Cards and
  explicitly scrolled lazy SVGs load at their intrinsic dimensions, canonical
  disclosures render exactly once on the new Notebook and Deep Dive and not on
  the glossary, all predecessor/successor and reciprocal Knowledge Base links
  are present, and desktop plus mobile screenshots pass visual review.
- RMT-20 Lean audit: all eight public declarations, four private proof helpers,
  and three named private smoke declarations match the checked finite
  reindexing, boundary, sign, multiplication, division, centered-process, and
  cocycle claims. The leaf, branch, and root imports pass warnings as errors;
  the full build completes 3,177 jobs; and the axiom audit reports only
  `propext`, `Classical.choice`, and `Quot.sound`.
- RMT-20 teaching audit: the 7,942-word Notebook, 2,734-word glossary chapter,
  and 7,142-word Deep Dive cover the complete source order, 74 solved
  exercises, the repaired finite source count, all degenerate cases, and every
  explicit nonclaim. All three cards reproduce byte-for-byte from the project
  root and `/private/tmp`; all five SVGs parse and pass visual inspection;
  source hygiene covers 87 Markdown files; and Hugo renders 264 pages with
  warnings fatal.
- Rendered RMT-20 QA: the new Notebook, glossary, and Deep Dive render 350,
  132, and 372 KaTeX nodes. Those pages plus the six amended RMT-18 and RMT-19
  predecessors each have one article heading, zero KaTeX errors, page-level
  overflow, broken or alt-less assets, and raw TeX delimiters at both 1,280-
  and 390-pixel widths. Cards and explicitly scrolled lazy SVGs load, canonical
  and Open Graph metadata are present, the Notebook and Deep Dive each render
  one AI-use disclosure while the glossary renders none, reciprocal and
  continuation links resolve, and desktop plus mobile screenshots pass visual
  review.
- RMT-21 Lean audit: the 1,131-line module has 54 public named declarations
  including its inductive packing type, 13 private named declarations, and 35
  compiled anonymous probes. It checks the representation, decoders, exact
  covered cardinality, geometric order/disjointness, selector coverage and
  provenance, weak/strict cost transport, raw process inequality, marked-card
  bounds, and project wrappers. Leaf, branch, root, and full builds pass with
  3,178 jobs; no proof hole, unsafe declaration, or custom axiom occurs, and
  theorem prints contain only `propext`, `Classical.choice`, and `Quot.sound`.
- RMT-21 teaching audit: the 8,571-word Notebook maps all 67 named declarations
  in exact source order; the 2,834-word glossary fixes the reusable convention;
  and the 8,566-word Deep Dive supplies a textbook ascent with 44 solved
  exercises. The pages distinguish coverage from provenance, covered length
  from interval count, weak empty marks from strict nonempty marks, generic
  horizon containment from selector endpoint slack, and finite packing from
  every ergodic or Lyapunov claim. Three cards reproduce byte-for-byte at
  1200x630; five accessible SVGs parse, render, and pass visual review; source
  hygiene covers 90 Markdown files; and Hugo renders 277 pages with warnings
  fatal.
- Rendered RMT-21 QA: the Notebook, glossary, and Deep Dive render 238, 99, and
  311 KaTeX nodes. At desktop and 390-pixel widths, all three pages have zero
  KaTeX errors, raw delimiters, page-level overflow, broken assets, or console
  failures. Cards load at 1200x630, lazy SVGs load at intrinsic dimensions,
  tables and code scroll locally on mobile, Open Graph and Twitter metadata are
  complete, the Notebook and Deep Dive render their canonical AI disclosures,
  and the glossary renders none. All five figures and six page-level desktop
  and mobile views passed visual inspection.
- RMT-22 Lean audit: the 602-line frozen module has SHA-256
  `cec39333cd0751ca7b52283049cf11ec8a8a8870eff3dbeaf32bfda81d111fbd`,
  37 public declarations, and 12 compiled anonymous probes. Leaf, cocycle
  aggregator, and root warning-fatal checks pass; the root build completes
  3,180 jobs. No proof hole, unsafe declaration, or project axiom occurs, and
  the six theorem prints contain only `propext`, `Classical.choice`, and
  `Quot.sound`. A separate premise and boundary audit found no Lean blocker.
- RMT-22 teaching audit: the 8,376-word Notebook covers every declaration in
  source order and maps all 12 probes; the 1,908-word glossary and 7,025-word
  Deep Dive preserve the measurable/null-measurable distinction and the
  conditional null/conull fork, with 30 solved exercises. Three cards
  reproduce byte-for-byte at 1200x630 and five SVGs parse. Independent review
  corrected the root namespace of `oneStepBirkhoffConvergenceSet`, the exact
  `AEMeasurable.mk` source citation, orphaned reference anchors, accessibility
  expansions, and a misleading figure description before commit.
- Rendered RMT-22 QA: source hygiene passes 93 Markdown files and Hugo renders
  286 pages with warnings fatal. The Notebook, Deep Dive, and glossary render
  261, 240, and 58 KaTeX nodes at desktop width with zero errors or raw
  delimiters. Desktop and 390-pixel views have zero page-level overflow,
  broken assets, or console failures; wide displays and code scroll locally.
  Visual review caught and fixed an inherited thick stroke and collision on
  the Deep Dive card before the deterministic artifact was frozen.
- RMT-23 Lean audit: the 509-line frozen module has SHA-256
  `3f385c36fae5d0483ea592468d4d79d197e74a4e241b63f859b0aaace03a8b58`,
  25 documented public declarations, one private integration helper, and 11
  compiled anonymous probes. Leaf, cocycle aggregator, and root warning-fatal
  checks pass; the root build completes 3,181 jobs. No proof hole, unsafe
  declaration, or project axiom occurs, and theorem prints contain only
  `propext`, `Classical.choice`, and `Quot.sound`. An independent premise,
  boundary, and countermodel audit found no Lean blocker.
- RMT-23 teaching audit: the body-only regex counts 9,143 tokens in the
  Notebook, 2,141 in the glossary, and 7,475 in the Deep Dive. The Notebook
  covers all 25 public declarations, the private helper, and all 11 probes in
  source order, with 20 solved exercises; the Deep Dive has 32 solved
  exercises. Three cards reproduce byte-for-byte at 1200x630, six SVGs parse,
  ShellCheck is green, source hygiene passes 96 Markdown files, proof-to-prose
  coverage passes 28/28 modules, and Hugo renders 293 pages with warnings
  fatal. Independent source/prose review repaired historical scope, journal
  metadata, superlevel terminology, measure and threshold gates, and the
  visual assumption labels before commit.
- Rendered RMT-23 QA: the Notebook, glossary, and Deep Dive render 234, 89, and
  292 KaTeX nodes after the final repairs. At desktop and 390-pixel widths, all
  three pages have one article heading and zero KaTeX errors, raw delimiters,
  page-level overflow, broken or alt-less assets, or console failures. Cards
  load at 1200x630, all six conceptual figures pass visual inspection, and
  wide tables, math, and code scroll locally on mobile. The Notebook and Deep
  Dive each render one canonical AI-use disclosure; the glossary renders none.
- RMT-24 Lean audit: the 342-line frozen module has SHA-256
  `80b56f91d3c54b69f0ef589f9732aed3abf8ee76ba0de2e937ab86f93f054032`,
  ten documented public declarations, no private helper, and ten compiled
  anonymous probes. Leaf, cocycle aggregator, Random root, and project-root
  warning-fatal checks pass. No proof hole, unsafe declaration, or project
  axiom occurs, and theorem prints contain only `propext`,
  `Classical.choice`, and `Quot.sound`. Independent audit verified the strict
  positive-time event, exact increasing union, assumption split, paired
  infinite-mass boundary examples, and sufficient-not-necessary local
  finiteness interpretation with no remaining slice blocker.
- RMT-24 teaching audit: the deterministic body-only regex counts 9,614 tokens
  in the Notebook, 1,978 in the glossary, and 8,725 in the Deep Dive. The
  Notebook covers all ten declarations and ten probes with 24 solved
  exercises; the Deep Dive has 36 solved exercises. Three cards reproduce
  byte-for-byte at 1200x630, all seven SVGs parse and pass visual inspection,
  and all three generators pass ShellCheck. Source hygiene covers 99 Markdown
  files, proof-to-prose coverage passes 29/29 modules, and Hugo renders 304
  pages with warnings fatal. Source review completed the Yosida–Kakutani and
  Keane–Petersen assumption ledgers, removed orphaned references, and compiled
  the standalone Lean fence.
- Rendered RMT-24 QA: the Notebook, glossary, and Deep Dive render 218, 62,
  and 274 KaTeX nodes. At desktop and 390-pixel widths, all three pages have one
  article heading and zero KaTeX errors, raw delimiters, page-level overflow,
  broken or alt-less assets, or console failures. Every wide table, display,
  and code block scrolls locally on mobile; all three cards and seven
  lazy-loaded SVGs resolve at their intrinsic dimensions. Direct SVG views,
  page screenshots, Open Graph metadata, reciprocal links, and canonical
  disclosure placement pass visual review.
- RMT-24 full repository gate: the source-only worktree was synchronized to
  the authorized remote builder without `.env`, Git metadata, local `.lake`,
  generated Hugo output, or private review files. `make check` completed all
  3,182 Lean jobs, checkpoint and 29/29 coverage checks, four hygiene
  regression tests, the 99-file teaching scan, and the 304-page warning-fatal
  Hugo render in 9.542 seconds when building the new module and 3.776 seconds
  on the final cached replay.
- RMT-25 Lean audit: the 491-line frozen module has SHA-256
  `4041dd4fcbb1353c31fa26072071c2e6ee73626eb5c8b7f59ac4d76219e446ac`,
  twenty documented public declarations, two private helpers, eleven compiled
  anonymous probes, and five source axiom prints. Leaf, cocycle aggregator,
  Random root, and project-root warning-fatal checks pass. The fourteen public
  theorems use only `propext`, `Classical.choice`, and `Quot.sound`; no proof
  hole, unsafe declaration, or project axiom occurs. Independent review found
  no finite-mass, probability, sigma-finite, ergodicity, injectivity,
  surjectivity, invertibility, or norm-one leak.
- RMT-25 teaching audit: the body-only regex counts 10,911 tokens in the
  Notebook, 6,056 in the Deep Dive, 1,718 in the Koopman-operator glossary,
  and 1,798 in the Koopman-coboundary glossary. The Notebook maps every public
  declaration, private helper, and anonymous probe in source order with 34
  solved exercises; the Deep Dive has 20 solved exercises. Four cards
  reproduce byte-for-byte at
  1200x630, all twelve SVGs parse and pass word-only label and visual-fit
  review, and every generator passes ShellCheck. Source hygiene covers 103
  Markdown files, proof-to-prose coverage passes 30/30 modules, and Hugo
  renders 318 pages with warnings fatal. Independent review corrected the
  horizon-zero fixed-vector boundary, historical source scope, representative
  nonclaims, reference reachability, and raw SVG notation before the final
  gate.
- Rendered RMT-25 QA: the Notebook, Deep Dive, Koopman-operator glossary, and
  Koopman-coboundary glossary render 296, 231, 62, and 87 KaTeX nodes. At
  desktop and 390-pixel widths, all four pages have one article heading and
  zero KaTeX errors, raw delimiters, page-level overflow, broken anchors,
  broken or alt-less assets, or console failures. Wide math, tables, and code
  scroll locally on mobile; all conceptual figures lazy-load at their intrinsic
  dimensions and pass direct raster inspection.
- RMT-25 full repository gate: the source-only worktree was synchronized to
  the authorized RunPod builder's fast local cache without `.env`, Git
  metadata, local `.lake`, generated Hugo output, or private review files.
  `make check` completed all 3,185 Lean jobs, checkpoint and 30/30 coverage
  checks, four hygiene regression tests, the 103-file teaching scan, and the
  318-page warning-fatal Hugo render in 11.13 seconds. A read-only filesystem
  audit caught and corrected an initial path choice that had started a cold
  build on persistent network storage; only that disposable compilation was
  cancelled, and the retained builder remains running.
- RMT-26 Lean audit: the 580-line frozen module has SHA-256
  `463a51c280585c932a85acab102421f70231173363fb61008c87a33f866f5253`,
  twenty-nine documented public declarations, seven compiled anonymous
  probes, and five source axiom prints. Warning-fatal leaf, cocycle
  aggregator, Random root, and project-root checks pass. The five printed
  theorem footprints contain only `propext`, `Classical.choice`, and
  `Quot.sound`; no proof hole, unsafe declaration, or project axiom occurs.
  Two independent audits verified the absolute-event derivation, exact
  Cauchy-event quantifiers, `ε / 3` closure constants, `μ.real` gates,
  representative bridges, finite-mass density argument, and theorem boundary.
- RMT-26 teaching audit: the body-only regex counts 5,280 words in the
  Notebook, 9,493 in the Deep Dive, 2,126 in the Birkhoff-Cauchy-exceptional
  glossary, and 2,090 in the weak-type-(1,1) glossary. The Notebook and Deep
  Dive each map all twenty-nine public declarations and seven probes; they
  include eighteen and twenty-eight solved exercises. Four cards reproduce
  byte-for-byte at 1200x630, all eleven SVGs parse and satisfy their direct
  title, description, role, and `aria-labelledby` contracts, and every
  generator passes ShellCheck. Proof-to-prose coverage passes 31/31 modules,
  source hygiene scans 107 Markdown files, and Hugo renders 332 pages with
  warnings fatal. Independent review corrected historical attribution,
  one-scale-versus-Cauchy wording, almost-everywhere qualifiers, measurable
  finite-range scope, exact real-measure notation, figure synchronization,
  and declaration names before the release gate.
- Rendered RMT-26 QA: all four page routes, four 1200x630 cards, and eleven
  SVG routes return HTTP 200 with the expected media types from the live Hugo
  server. At a 1440-pixel browser viewport, all four pages expose one article
  heading, no page-level overflow, no alt-less image, and no overflowing code
  block. All cards and SVGs passed direct raster inspection, including the
  corrected one-scale Cauchy plate. The in-app browser did not honor a requested
  390-pixel override, and an independent task had no browser backend, so a
  fresh narrow screenshot remains explicit publication-draft QA debt. No
  template or CSS changed from the previously green RMT-25 390-pixel audit.
- RMT-26 full repository gate: the exact source-only worktree was synchronized
  to the authorized RunPod builder's fast local cache without `.env`, Git
  metadata, local `.lake`, generated Hugo output, or private review files.
  `make check` completed all 3,186 Lean jobs, checkpoint and 31/31 coverage
  checks, four hygiene regression tests, the 107-file teaching scan, and the
  332-page warning-fatal Hugo render in 3.90 seconds. The same gate is green on
  the Mac, and the retained builder remains running under the owner's
  continuing approval.
- RMT-27 Lean audit: the 407-line module has SHA-256
  `6473ccd771ce7d913470f73549fb4a0bb675379c930d82ea8fb28979415efd0e`,
  eighteen documented public declarations, one private helper, five compiled
  boundary probes, and five source axiom prints. Warning-fatal leaf, cocycle
  aggregator, and project-root checks pass. A separate exact-versus-modulo-null
  countermodel, noninjective restricted-measure transport instance, and
  all-declaration axiom audit pass. Every public declaration uses only
  `propext`, `Classical.choice`, and `Quot.sound`; no proof hole, unsafe
  declaration, project axiom, probability, ergodicity, positive-mass,
  injectivity, surjectivity, or invertibility leak remains.
- RMT-27 teaching audit: the body-only regex counts 5,083 words in the Notebook,
  8,545 in the Deep Dive, and 2,139, 2,379, and 2,389 in the invariant sigma
  algebra, conditional-expectation, and uniform-integrability glossaries. The
  Notebook and Deep Dive map all eighteen declarations and five probes in
  source order and include twenty and thirty solved exercises. Five cards
  reproduce byte-for-byte at 1200x630, all fifteen SVGs parse, every generator
  passes ShellCheck, proof-to-prose coverage passes 32/32 modules, source
  hygiene scans 112 Markdown files, and Hugo renders 347 pages with warnings
  fatal. Two independent prose/source reviews and a separate glossary/asset
  review found no remaining theorem, assumption, citation, notation, visual,
  or publication-contract blocker.
- Rendered RMT-27 QA: the Notebook, Deep Dive, and three glossary routes each
  expose exactly one article heading at 1280 and 390 pixels. They have zero
  page-level overflow, KaTeX errors, raw math delimiters, alt-less or eagerly
  broken images, suspicious generated links, and console warnings/errors.
  The browser pass caught and fixed one Markdown-generated false link in the
  Notebook key-result notation. On mobile, every opt-in wide figure keeps a
  680-pixel image inside a 364-pixel frame with `overflow-x: auto` and a
  692-pixel scroll extent while the document remains exactly 390 pixels wide.
  All six Notebook lazy figures were traversed and loaded successfully at
  desktop width.
- RMT-27 full repository gate: the local `make check` completes all 3,208 Lean
  jobs, checkpoint and 32/32 coverage checks, four hygiene regression tests,
  the 112-file teaching scan, and the 347-page warning-fatal Hugo render. The
  exact source-only tree was synchronized to the approved retained RunPod
  builder without `.env`, Git metadata, local `.lake`, generated Hugo output,
  or private review files; a checksum dry replay proved identity, and the same
  full gate passed there in 9.98 seconds. The 32-vCPU, 128-GB billed-memory
  builder and 100-GB persistent snapshot volume remain retained under the
  owner's continuing approval.
- RMT-28 Lean audit: the 367-line module has SHA-256
  `12f28df847232be23ac76e90f0583f6f6e646ca90d300a56567892c27e0d34d1`,
  six documented public theorems, one private constancy hinge, fourteen
  private boundary helpers, five compiled probes, and six source axiom prints.
  Two independent read-only reviews recompiled the leaf and aggregator and
  checked representative invariance, the `PreErgodic`/preservation split,
  genuine use of integrability, finite-mass normalization, all five semantic
  boundaries, and an independent elaborated-signature/axiom probe. No theorem,
  assumption, boundary, proof-hole, unsafe-declaration, or axiom blocker
  remains; every printed footprint is exactly `propext`, `Classical.choice`,
  and `Quot.sound`.
- RMT-28 teaching audit: the body-only regex counts 7,886 words in the
  Notebook, 5,752 in the Deep Dive, and 1,251 in each of the ergodicity and
  normalized-space-average glossaries. The Notebook maps all six public
  declarations, the private hinge, fourteen helpers, and five probes with
  twenty solved exercises; the Deep Dive has thirty solved exercises. Four
  deterministic cards reproduce byte-for-byte at 1200x630, all ten SVGs parse
  and pass visual inspection, and all generators pass ShellCheck. Exact KaTeX
  0.16.22 parsing succeeds for all 1,253 math spans across the ten changed
  teaching pages. Independent desktop and 390-pixel renders of the four new
  routes show the expected 154, 158, 37, and 39 KaTeX nodes, with one article
  heading and zero KaTeX errors, raw delimiters, page overflow, broken images,
  missing anchors, or console failures. All fourteen new asset routes return
  HTTP 200.
- RMT-28 full repository gate: `make check` completes all 3,209 Lean
  jobs, checkpoint and 33/33 coverage checks, four hygiene regression tests,
  the 116-file teaching scan, and the 359-page warning-fatal Hugo render in
  8.67 seconds on the Mac. The exact source-only tree was synchronized to the
  approved retained RunPod builder without `.env`, Git metadata, local
  `.lake`, generated Hugo output, or private review files; the checksum replay
  proved identity and the same gate passed there in 10.14 seconds. The
  32-vCPU, 128-GB billed-memory builder remains running under the owner's
  continuing approval.
- RMT-29 Lean audit: the 411-line module has SHA-256
  `396662e201627c84e59aafd94476187ca280a00812d4df14af90994c5d5cc77a`,
  four documented public declarations, four private analytic helpers, ten
  private boundary-support items, three compiled anonymous examples, and four
  source axiom prints. Two independent read-only reviews recompiled the leaf
  and aggregator and audited the finite integral transport, coefficient
  asymptotic, real-limsup boundedness gates, residue recombination, centered
  cancellation, almost-everywhere countable intersection, `sInf` direction,
  time-zero totalization, and the ergodic-flip/nonergodic-square boundary. No
  theorem, assumption, proof-hole, unsafe-declaration, or axiom blocker
  remains; every printed footprint is exactly `propext`, `Classical.choice`,
  and `Quot.sound`.
- RMT-29 teaching audit: the deterministic body-only regex counts 4,327 words
  in the Notebook, 3,628 in the Deep Dive, and 562 in the limit-superior
  glossary. The Notebook maps the complete 25-item source order and includes
  twenty-four solved exercises; the Deep Dive has thirty-two. Three
  deterministic cards reproduce byte-for-byte at 1200x630, all twelve SVGs
  parse and pass direct visual inspection, and all generators pass ShellCheck.
  An independent source-to-prose audit corrected the negative-quadratic real
  `limsup` countermodel, positive-mass normalization, successor induction,
  compiled-versus-explanatory labels, source citations, and asset callsites.
- Rendered RMT-29 QA: the Notebook, Deep Dive, and glossary routes each expose
  exactly one article heading at 1440x1000 and 390x844. Source math matches the
  rendered 15+83, 27+117, and 4+11 display-plus-inline KaTeX counts at both
  widths. All twelve lazy figures load; there are zero KaTeX errors, raw
  delimiters, page-level overflow, broken images, failed HTTP responses, or
  console failures. The rendered pass found and fixed one Goldmark-swallowed
  display whose continuation had begun with a plus sign.
- RMT-29 full repository gate: local `make check` completes all 3,210 Lean
  jobs, checkpoint and 34/34 coverage checks, four hygiene regression tests,
  the 119-file teaching scan, and the 366-page warning-fatal Hugo render in
  6.85 seconds. The exact source-only tree was synchronized to the approved
  retained RunPod builder without `.env`, Git metadata, local `.lake`,
  generated Hugo output, or private review files; every replay proved identity.
  The first full gate passed there in 10.29 seconds, the final-content replay
  passed in 8.40 seconds, and the final checkpoint-only synchronization also
  replayed green. The 32-vCPU, 128-GB billed-memory builder and 100-GB
  persistent volume remain retained under the owner's continuing approval.
- RMT-30 Lean audit: the 497-line module has SHA-256
  `13c9721eff1b864b552d9110218598bd6c51455f9c1fdb3dbbe12b1e77973305`,
  nine documented public declarations, eleven private boundary-support items,
  nine compiled examples, and six source axiom prints. Independent read-only
  review checked visit-count integration, strict positive-length indexing,
  greedy witness selection, the `H + m ≠ 0` corner, negative division, Fekete
  specialization, assumption minimality, and all boundary models. The original
  vacuous nonergodic probe was strengthened to a half-half two-atom probability
  space with a genuinely nonempty singleton bad set. No correctness,
  overclaim, proof-hole, unsafe-declaration, or axiom blocker remains; every
  printed footprint is exactly `propext`, `Classical.choice`, and `Quot.sound`.
- RMT-30 teaching audit: the body-only deterministic regex counts 5,524 tokens
  in the Notebook, 4,059 in the Deep Dive, and 908 in the finite-orbit-visit
  glossary. The Notebook maps all nine public declarations, the nested private
  proof ledger, eleven boundary-support items, nine examples, and six axiom
  reports with twenty-four solved exercises; the Deep Dive has thirty. Three
  deterministic cards reproduce byte-for-byte at 1200x630, all thirteen SVGs
  parse and pass direct visual inspection, and all generators pass ShellCheck.
  Independent audits corrected a disjoint-cover overlap, zero-horizon
  notation, cast-versus-integrability language, the private `hjbad` step, and
  one pinned Mathlib source path.
- Rendered RMT-30 QA: the Notebook, Deep Dive, and glossary routes each return
  HTTP 200 and expose exactly one article heading at literal 1440x1000 and
  390x844 viewports. Source math matches the rendered 14+158, 36+155, and 5+34
  display-plus-inline KaTeX counts at both widths. All 6/6, 6/6, and 1/1 body
  figures load; there are zero KaTeX errors, raw delimiters, page-level
  overflow, broken images, failed HTTP responses, or console failures. Direct
  mobile screenshot inspection confirms local containment for wide content.
- RMT-30 full repository gate: local `make check` completes all 3,211 Lean
  jobs, checkpoint and 35/35 coverage checks, four hygiene regression tests,
  the 122-file teaching scan, and the 377-page warning-fatal Hugo render in
  15.37 seconds. The exact source-only tree was synchronized to the approved
  retained RunPod builder without `.env`, Git metadata, local `.lake`,
  generated Hugo output, or private review files; checksum identity was proved
  before execution and the same gate passed there in 10.76 seconds. A final
  checkpoint-only source synchronization and replay also passed. The 32-vCPU,
  128-GB billed-memory builder and 100-GB persistent volume remain retained
  under the owner's continuing approval.
- Research-workflow skill audit: the project skill now incorporates the
  source-to-statement, exploratory-proof, informalization, canonization, and
  human/AI provenance lessons from arXiv:2607.17477 without creating a
  tool-specific duplicate skill. The official structural validator and a
  context-minimal fresh-agent forward test pass.

## Recent Pushes

- `7ecea15`: formalize the generic subadditive upper-limsup estimate and its
  all-block log-positive cocycle specialization, with complete teaching and
  the exact finite bad-block bridge plan.
- `7da572a`: identify finite-measure ergodic Birkhoff constants, including the
  probability-integral endpoint, complete teaching layer, and exact RMT-29
  upper-limsup plan.
- `8b1da2c`: identify the finite-measure pointwise Birkhoff limit as
  conditional expectation onto the exact invariant sigma algebra, with its
  complete Notebook, textbook Deep Dive, and glossary layer.
- `b75b5d5`: formalize finite-measure full-sequence pointwise Birkhoff
  convergence by maximal closure, with its declaration-complete Notebook,
  textbook Deep Dive, glossary integration, and exact RMT-27 limit-
  identification plan.
- `7f420f7`: checkpoint the complete RMT-25 milestone, the retained approved
  RunPod builder state, the arXiv:2607.17477 workflow integration, and the exact
  RMT-26 maximal-closure plan.
- `6e136bc`: formalize Koopman square-integrable mean convergence, the dense
  fixed-plus-simple-coboundary pointwise-good core, and the complete paired
  teaching layer.
- `9f0ee23`: checkpoint the complete RMT-24 milestone and the exact RMT-25
  Koopman mean-ergodic and dense pointwise-good-core plan.
- `5a7c96f`: formalize the infinite-horizon Birkhoff-average exceedance event,
  extended and real continuity interfaces, the weak maximal estimate, paired
  infinite-mass boundaries, and the complete teaching layer.
- `260cb51`: checkpoint the complete RMT-23 milestone and the exact RMT-24
  infinite-horizon weak-maximal plan.
- `764d247`: formalize the finite Hopf maximal ergodic lemma and its exact
  finite-mass and positive-threshold corollaries, with the complete teaching
  layer and independent source, theorem, prose, and visual audits.
- `e6c6c17`: formalize Birkhoff convergence events and their exact one-step
  preimage invariance, add the complete teaching layer, and record the
  transparent-discovery and human-approved RunPod workflows.
- `5cac6af`: correct the RMT-22 invariance boundary in the post-RMT-21
  checkpoint.
- `2a059b9`: record the complete RMT-21 checkpoint and exact RMT-22 plan.
- `f50315e`: ordered disjoint interval packing, leftmost marked-start cover,
  weak/strict finite cost bounds, exact time-zero boundaries, and teaching
  layer.
- `ebb29fb`: finite subadditive phase averaging, exact boundary bookkeeping,
  centered-process and cocycle wrappers, and teaching layer.
- `deeb964`: orbit-majorant centering, exact normalized splitting, cocycle
  specializations, and teaching layer.
- `8aac7f9`: finite subadditive block and remainder bounds, fixed-block
  Birkhoff-sum integrability, cocycle specializations, and teaching layer.
- `b40e424`: probability normalization, integrable subadditive-process
  packaging, ergodic rigidity interfaces, and teaching layer.
- `cdda319`: integrated log-positive cocycle growth, deterministic Fekete
  convergence, and teaching layer.
- `d07d18d`: finite-horizon log-positive cocycle integrability and teaching
  layer.
- `a18d568`: finite-time maximum-row-sum cocycle norms, zero-faithful
  extended-log observables, and teaching layer.
- `2cd2d67`: generator-presented one-sided matrix cocycles over
  measure-preserving bases, exact finite-time identities, and teaching layer.
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
