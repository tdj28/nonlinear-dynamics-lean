# Nonlinear Dynamics in Lean

This repository develops a machine-checked account of nonlinear dynamics and a
public teaching record alongside it. The two parts share one history but remain
separate build targets:

```text
.
├── .agents/skills/ Project-local Codex research and formalization workflow
├── checkpoint.md  Living verified state, decisions, and exact next milestone
├── formalization/   Lean 4 definitions, theorem statements, and proofs
├── site/            Hugo source for the public learning site
└── public/          Generated site output, ignored by Git
```

The site has two main collections:

- **Development Notebook:** chronological entries connecting physical
  intuition, mathematical arguments, Lean design decisions, proof status, and
  reproducible commands.
- **Knowledge Base:** stable glossary entries and longer deep dives that can be
  reused across notebook entries.

## Project memory and research workflow

Read [`checkpoint.md`](checkpoint.md) at the start of a work session. It records
the last verified state, completed vertical slices, explicit nonclaims,
dependency-ordered roadmap, and exact next milestone. Update it before every
coherent milestone commit.

The checked-in
[`formalize-nonlinear-dynamics` skill](.agents/skills/formalize-nonlinear-dynamics/SKILL.md)
captures the project's research-to-Lean workflow: pinned Mathlib source
reconnaissance, primary-source discipline, normalization ledgers,
proof-to-prose pairing, strict validation, checkpoint maintenance, the
workstation/cloud build split, and frequent pushes to `main`.

Useful checkpoint commands are:

```sh
make checkpoint
make checkpoint-check
```

## Requirements and host roles

This project deliberately separates the two development hosts:

- **macOS workstation:** Git, research, source editing, checkpoint/static
  validation, Hugo authoring, browser QA, and small standalone Lean tutorials.
  It does not download or build a Mathlib compiled cache and does not compile
  the project.
- **human-approved Linux cloud builder:** Elan, Lean, Lake, Mathlib dependency
  and cache setup, warning-fatal module checks, and the complete repository
  gate. Set `CLOUD_LEAN_BUILD=1` only on that approved host.

Both roles need Git, `curl`, Python 3, and
[Hugo Extended](https://gohugo.io/installation/) 0.153.0 or newer. The cloud
builder should have at least 12 GB of fast ephemeral/local free space; 15 GB is
recommended for rebuild headroom. Persistent network storage is suitable for
compressed, integrity-checked cache snapshots, not for a live `.lake` tree.
For each release gate, record the workstation's exact `hugo version` output and
use the same Hugo release on the cloud builder; the compatibility floor is not
permission to mix versions within one release.

Lean versions are managed by [`elan`](https://github.com/leanprover/elan). The
formalization pins Lean and Mathlib to version 4.32.0.

The optional Lean 4.32.0 compiler already installed on the current Apple
Silicon workstation occupies roughly 2.6 GB. The former local Mathlib compiled
tree consumed about 7.3 GB and was removed on 2026-07-22; project policy is not
to restore or regenerate it. Exact sizes vary by platform and filesystem.

## Install Lean on macOS

Check whether Apple's command-line tools are present:

```sh
git --version
```

If macOS reports that developer tools are missing:

```sh
xcode-select --install
```

Install the elan toolchain manager:

```sh
curl https://elan.lean-lang.org/elan-init.sh -sSf | sh
source "$HOME/.elan/env"
```

This installs `elan`, the Lean toolchain manager. The project-specific Lean
compiler is downloaded separately after cloning the repository, as described
below. Keeping the pinned compiler locally is useful for version inspection,
and it also supports small files that import only Lean core or `Std`; it does
not authorize a local project build or Mathlib cache download.

Install Hugo Extended with Homebrew:

```sh
brew install hugo python
```

### Run one small Lean tutorial locally

After installing the pinned compiler, create a file named `TinyTutorial.lean`
in any scratch directory with these exact contents:

```lean
import Std

#eval (List.range 5).map (fun n => n * n)

example : (2 + 3 : Nat) = 5 := by
  decide
```

Then ask the pinned compiler to elaborate and run it:

```sh
elan run leanprover/lean4:v4.32.0 lean TinyTutorial.lean
```

Lean should print `[0, 1, 4, 9, 16]` and exit without an error. This is a
small compiler-and-`Std` exercise, not a Mathlib or project build. The
Knowledge Base uses exercises like this to teach syntax locally, then labels
the exact Mathlib-backed project command separately for a provisioned Linux
builder.

## Install Lean on Linux

On Debian or Ubuntu:

```sh
sudo apt update
sudo apt install -y git curl python3
```

On Fedora:

```sh
sudo dnf install -y git curl python3
```

On Arch Linux:

```sh
sudo pacman -S --needed git curl python
```

Install the elan toolchain manager:

```sh
curl https://elan.lean-lang.org/elan-init.sh -sSf | sh
source "$HOME/.elan/env"
```

Install Hugo Extended using the instructions for your distribution in the
[Hugo installation guide](https://gohugo.io/installation/linux/).

## Optional Tailscale setup for remote previews

On macOS, install the recommended standalone client using the official
[Tailscale macOS guide](https://tailscale.com/docs/install/mac), complete its
onboarding flow, and enable its command-line integration from the app's
settings. The [Tailscale CLI guide](https://tailscale.com/docs/reference/tailscale-cli?tab=macos)
shows where that setting lives.

On Linux, follow the official
[Tailscale Linux guide](https://tailscale.com/docs/install/linux), then connect
and authenticate the machine:

```sh
sudo tailscale up
```

On either system, confirm the command can see your tailnet before starting the
blog:

```sh
tailscale status
```

## Clone and use the split workstation/cloud workflow

Clone the repository on the Mac workstation:

```sh
git clone https://github.com/tdj28/nonlinear-dynamics-lean.git
cd nonlinear-dynamics-lean
source "$HOME/.elan/env"
elan toolchain install leanprover/lean4:v4.32.0
```

The last command downloads only the exact compiler named by
[`formalization/lean-toolchain`](formalization/lean-toolchain). Elan stores it
under `~/.elan/toolchains/`; it does not download Mathlib. On macOS, do not run
`make setup`, `make lean`, `make check`, `lake update`, `lake exe cache get`,
`lake build`, or `lake env lean`. Those operations can regenerate the compiled
Mathlib tree. The guarded Make targets, including `make lean-file`, refuse to
run on macOS even if
`CLOUD_LEAN_BUILD=1` is supplied.

The workstation can run all non-Lean gates:

```sh
make workstation-check
git diff --check
```

`workstation-check` validates the checkpoint, teaching-source contract,
proof-to-prose coverage, and warning-fatal Hugo render without invoking Lean or
Lake. It may fail intentionally while a source-only milestone is missing its
teaching companion; that is an honest completeness signal, not a reason to
build locally.

On a newly provisioned Linux cloud builder, first obtain the owner's explicit
approval for the proposed compute specifications and cost. Then clone or
source-only synchronize the repository. A fresh cloud clone may have its own
clean `.git`; never copy the workstation's Git metadata to the builder. Install
the exact compiler and run:

```sh
source "$HOME/.elan/env"
elan toolchain install leanprover/lean4:v4.32.0
CLOUD_LEAN_BUILD=1 make setup
CLOUD_LEAN_BUILD=1 make check
```

The cloud downloads happen in distinct stages:

1. `elan toolchain install leanprover/lean4:v4.32.0` downloads the exact Lean
   compiler named by [`formalization/lean-toolchain`](formalization/lean-toolchain).
   Elan stores downloaded compilers under `~/.elan/toolchains/`.
2. `make setup` runs `lake update` in `formalization/`, which downloads the
   Mathlib revision pinned in
   [`formalization/lakefile.toml`](formalization/lakefile.toml) and records the
   resolved dependencies in `lake-manifest.json`. The cloud runner verifies
   [`lake-manifest.sha256`](formalization/lake-manifest.sha256) both before and
   after this step, so setup fails if dependency resolution drifts.
3. `make setup` then runs `lake exe cache get`, which downloads Mathlib's
   precompiled Lean artifacts so the whole library does not need to be rebuilt
   from source on the cloud builder.
4. `make check` builds this project's Lean modules, verifies the living
   checkpoint and proof-to-prose coverage, runs the context-aware teaching
   source tests and scan, and validates all Hugo content.

The first cloud setup is the largest download. Later cloud builds may restore
the project's integrity-checked toolchain and Lake-cache snapshots from its
preserved network volume onto fast ephemeral/local disk. The network volume
must never serve as a live `.lake` tree.

An intentional dependency refresh is a separate reviewed milestone: update the
manifest on approved cloud compute, review every revision change, update its
checked digest, and commit both files together before treating any build as
authoritative. Routine work must use the guarded targets rather than raw Lake
commands:

```sh
CLOUD_LEAN_BUILD=1 make setup
CLOUD_LEAN_BUILD=1 make lean
CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/path/to/Module.lean
```

Each build and warning-fatal leaf compile checks the manifest digest before it
invokes Lake; setup also checks again after dependency resolution.

Verify that the repository selected the intended compiler:

```sh
cd formalization
elan show
lean --version
```

Build only the Lean formalization:

```sh
CLOUD_LEAN_BUILD=1 make lean
```

Build only the site:

```sh
make site
```

Run a local Hugo server that includes drafts:

```sh
make blog-serve
```

This uses `http://127.0.0.1:1333/`. To view the same live-reloading preview from
another device on your Tailscale network:

```sh
make blog-serve-tailscale
```

The target binds only the machine's Tailscale IPv4 interface, prints its
MagicDNS URL, and does not enable Funnel or publish the preview to the public
internet. The Hugo site is mounted at that URL's root, so use the printed URL
as-is and do not append `/blog`. Tailnet access rules still apply. Override the
port when needed with
`make blog-serve-tailscale BLOG_PORT=1444`. Stop either server with `Ctrl+C`.

Site builds also mount the repository's `.lean` files beneath
`/lean/NonlinearDynamics/`. A teaching page that declares `lean_module`,
`lean_snapshot`, and `lean_source_sha256` links to this site-hosted source;
`make content-coverage` reads those keys only from YAML front matter on every
content page, derives the exact URL from the module name, and verifies that the
recorded SHA-256 still matches the checked source. No `.env`, build cache, Git
metadata, or other formalization artifact is published by this mount.

## Publish with GitHub Pages

The repository includes a GitHub Actions workflow at
`.github/workflows/pages.yml`. On each relevant push to `main`, it installs the
pinned Hugo Extended 0.160.1 release, runs the workstation-safe checkpoint and
site checks, builds the production site for the repository subpath, and deploys
the result to GitHub Pages. It does **not** invoke Lean, Lake, Mathlib, or any
cloud builder.

To activate it, open the repository on GitHub and select **Settings → Pages →
Build and deployment → Source → GitHub Actions**. The expected project URL is:

```text
https://tdj28.github.io/nonlinear-dynamics-lean/
```

This first push may start the workflow before Pages is enabled and fail during
the configuration step. After selecting **GitHub Actions**, rerun that failed
workflow from the **Actions** tab or choose **Run workflow**; the workflow also
supports manual dispatch for exactly this case.

The deployment intentionally omits Hugo drafts, but the complete existing
corpus is now opted into publication: 39 Development Notebook entries, 36
Knowledge Base Deep Dives, and 59 glossary chapters have `draft: false`. They
are public working notes, not a claim that every editorial or technical review
is complete. Their `pro_reviewed: false` metadata and visible pending-review
status language remain unchanged. Future pages can still begin as drafts, and
local preview targets continue to include them.

The mounted `.lean` sources are static publication assets and are also public
under the Pages URL. Publishing an article does not change the mathematical
scope, axiom ledger, proof status, or explicit nonclaims recorded in it.

GitHub Pages sites are publicly accessible even when their source repository is
private. Never put `.env`, API keys, credentials, cloud identifiers, private
review material, or generated build caches beneath `site/` or
`formalization/NonlinearDynamics/`. Keep future unfinished pages draft-gated
unless the owner explicitly chooses to publish them as open working notes;
there is no need to add `--buildDrafts` to the workflow. See the
[GitHub Pages custom-workflow guide](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages)
and the [Hugo deployment guide](https://gohugo.io/host-and-deploy/host-on-github-pages/)
for the underlying deployment model.

## Formalization layout

```text
formalization/NonlinearDynamics/
├── Deterministic/
│   ├── Discrete/
│   ├── Chaos/
│   ├── ODE/
│   └── Models/
├── Random/
└── QuantumChaos/
```

See [`formalization/NonlinearDynamics.lean`](formalization/NonlinearDynamics.lean)
for the current root import graph.

## Where the formalization starts

The first active sequence is:

1. [`RandomMatrices/Basic.lean`](formalization/NonlinearDynamics/Random/RandomMatrices/Basic.lean)
   defines the underlying matrix-valued maps, equips matrices with their
   entrywise measurable structure, and proves that the basic matrix operations
   needed later preserve measurability. It also introduces unnormalized
   Hermitian symmetrization.
2. [`RandomMatrices/Hermitian.lean`](formalization/NonlinearDynamics/Random/RandomMatrices/Hermitian.lean)
   distinguishes measurable, pointwise-Hermitian, and almost-surely Hermitian
   matrices; bundles the strongest finite interface; and proves conjugate-entry,
   real-diagonal, trace, and congruence-transform consequences.
3. [`RandomMatrices/Laws.lean`](formalization/NonlinearDynamics/Random/RandomMatrices/Laws.lean)
   defines measurable matrix congruence, pushforward matrix laws, probability
   preservation, Dirac sanity checks, and unitary-conjugation invariance as a
   property of measures. It proves the exact bridge from samplewise
   `conjugateBy` to pushforward law, without claiming that an ensemble is
   invariant.
4. [`RandomMatrices/Observables.lean`](formalization/NonlinearDynamics/Random/RandomMatrices/Observables.lean)
   defines trace powers, proves their measurability, and proves that they are
   real-valued for Hermitian realizations. It deliberately stops before
   expectation and integrability.
5. [`GaussianPrimitives.lean`](formalization/NonlinearDynamics/Random/GaussianPrimitives.lean)
   gives real Gaussian variables exact mean and variance parameters, preserves
   the zero-variance Dirac case, proves finite-exponent `MemLp` and
   integrability, bundles measurable mutually independent families, and
   identifies their finite joint law with a Gaussian product measure.
6. [`ComplexGaussian.lean`](formalization/NonlinearDynamics/Random/ComplexGaussian.lean)
   transports a product of exact real Gaussian laws to `ℂ`, keeps the real
   and imaginary coordinate variances explicit, recovers both marginals and
   their independence, and proves integrability, the exact mean, and the
   double-zero Dirac boundary. "Cartesian" does not imply circularity or
   properness.
7. [`ComplexGaussianFamilies.lean`](formalization/NonlinearDynamics/Random/ComplexGaussianFamilies.lean)
   bundles ordinarily measurable, mutually independent complex coordinates,
   proves their exact finite product law and qualitative joint Gaussianity,
   supports coordinatewise real scaling, and realizes the interface on a
   canonical product sample space, including its empty-index Dirac boundary.
8. [`RandomMatrices/HermitianCoordinates.lean`](formalization/NonlinearDynamics/Random/RandomMatrices/HermitianCoordinates.lean)
   defines the real-diagonal and complex-strict-upper coordinate space,
   assembles it directly into a Hermitian matrix without doubling the
   diagonal, proves the entry formulas and measurability of the assembly map,
   bundles coordinate processes as Hermitian random matrices, and makes the
   zero-dimensional result explicitly equal to the empty zero matrix.
9. [`RandomMatrices/GaussianUnitaryEnsemble.lean`](formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsemble.lean)
   fixes the Wigner-scaled GUE convention, constructs the independent real
   diagonal and Cartesian complex strict-upper coordinate law, pushes it
   through measurable Hermitian assembly, proves exact entry marginals and
   the relevant independence interfaces, and reduces dimension zero to Dirac
   laws on the unique empty coordinate point and matrix.
10. [`RandomMatrices/GaussianUnitaryEnsembleGeometry.lean`](formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleGeometry.lean)
    flattens matrices into Frobenius Euclidean space, cuts out the Hermitian
    matrices as an intrinsic real subspace, packages unitary congruence as an
    isometry, proves invariance of Mathlib's standard Gaussian on that
    intrinsic space, and proves the coordinate-built ambient GUE law gives the
    measurable Hermitian locus mass one. It deliberately keeps that intrinsic
    Gaussian distinct from `GUE.matrixLaw` until their normalized coordinate
    presentations are proved equal.
11. [`RandomMatrices/GaussianUnitaryEnsembleInvariance.lean`](formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleInvariance.lean)
    builds an explicit normalized real coordinate system for Hermitian
    matrices, proves that its assembly map is a Frobenius linear isometry,
    transports the full independent Gaussian product law to a scaled intrinsic
    standard Gaussian, and then pushes intrinsic congruence symmetry through
    the Hermitian inclusion to prove unitary-conjugation invariance of the
    ambient finite GUE law in every dimension, including zero.
12. [`RandomMatrices/GaussianUnitaryEnsembleMoments.lean`](formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleMoments.lean)
    proves that the first two trace-power observables are complex Bochner
    integrable under the finite GUE law and evaluates their exact expectations:
    `E[Tr H] = 0` and `E[Tr(H^2)] = n`. The second identity is obtained from the
    normalized Frobenius coordinates, so it holds uniformly at dimension zero
    and requires neither a density nor eigenvalue machinery.
13. [`RandomMatrices/HermitianSpectrum.lean`](formalization/NonlinearDynamics/Random/RandomMatrices/HermitianSpectrum.lean)
    packages decreasingly ordered real Hermitian eigenvalues with multiplicity,
    proves the exact trace and trace-square sums and unitary-congruence
    invariance, and builds spectral counting and zero-aware empirical measures.
    It exposes a genuine probability-measure wrapper only in positive
    dimension and keeps its measure-valued measurability theorems conditional
    on the coordinatewise hypothesis discharged by the next module.
14. [`RandomMatrices/HermitianSpectrumContinuity.lean`](formalization/NonlinearDynamics/Random/RandomMatrices/HermitianSpectrumContinuity.lean)
    proves the coordinatewise Frobenius Weyl bound through ordered spectral
    subspaces and a dimension-intersection argument. It packages each ordered
    eigenvalue and the full finite vector as 1-Lipschitz, derives continuity and
    measurability, and turns the earlier conditional counting-measure,
    empirical-measure, and intrinsic/ambient GUE bridges into unconditional
    theorems. The whole-vector target uses the finite sup metric; this is not a
    Hoffman-Wielandt Euclidean eigenvalue-vector theorem.
15. [`RandomMatrices/GaussianUnitaryEnsembleSpectrum.lean`](formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleSpectrum.lean)
    names the finite-GUE law of zero-aware empirical spectral measures, proves
    its intrinsic and ambient presentations agree, packages both the raw law
    and its positive-dimensional probability-measure-valued form, and builds
    the mean empirical measure by Giry join. It connects the first two sample
    spectral moments to normalized trace powers and proves their exact GUE
    expectations, with second moment zero at dimension zero and one in every
    positive dimension.
16. [`MatrixProducts/FiniteProducts.lean`](formalization/NonlinearDynamics/Random/MatrixProducts/FiniteProducts.lean)
    fixes the forward-time product `A (k - 1) * ... * A 0`, with the newest
    factor on the left so vectors evolve chronologically. Its algebraic layer
    works over any semiring and proves splitting, constant-system powers, and
    vector-action recursions. Over real or complex scalars in positive finite
    dimension, it proves product, geometric, and vector-orbit bounds in
    Mathlib's maximum-row-sum norm induced by the vector supremum norm.
17. [`MatrixProducts/MeasurableFiniteProducts.lean`](formalization/NonlinearDynamics/Random/MatrixProducts/MeasurableFiniteProducts.lean)
    lifts that ordered product pointwise to time-indexed matrix-valued sample
    maps. The semiring algebra remains general; the complex measurable layer
    derives product measurability from exactly the finite prefix in use and
    exposes only proof-carrying pushforward laws. Probability sources give both
    a raw mass-one theorem and a bundled probability law, including empty
    matrix dimension and the zero-horizon Dirac boundary.
18. [`RandomCocycles/Discrete.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/Discrete.lean)
    samples a matrix generator along natural-number iterates of a base map and
    proves the one-sided cocycle identity with the shifted later block on the
    left. Its measurable bundle records a measure-preserving base and an
    ordinarily measurable complex generator, then exposes measurable finite
    cocycle values and preservation of every base iterate without requiring a
    probability measure or a positive matrix dimension.
19. [`RandomCocycles/NormObservables.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/NormObservables.lean)
    selects the maximum absolute row-sum operator norm, proves finite-time
    norm measurability and cocycle submultiplicativity, and defines an
    extended-real log norm whose value is exactly bottom at a zero cocycle
    matrix. Positive dimension is required only for the normalized time-zero
    identities; explicit theorems record norm zero and log bottom for the
    empty matrix dimension.
20. [`RandomCocycles/LogPlusIntegrability.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/LogPlusIntegrability.lean)
    defines the real log-positive finite-time norm as a nonnegative
    integrability envelope, proves its measurability and subadditivity, and
    bounds it by the finite sum of one-step values along the base orbit. An
    explicit one-step integrability hypothesis propagates through every base
    iterate, orbit sum, and finite horizon under measure preservation, without
    requiring a probability measure. The envelope deliberately forgets
    contraction and exact collapse, so it is not the extended log norm or a
    Lyapunov exponent.
21. [`RandomCocycles/IntegratedLogPlusGrowth.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/IntegratedLogPlusGrowth.lean)
    integrates every finite-horizon log-positive envelope against the preserved
    raw measure and proves invariance of those totalized integrals under every
    base iterate. Under RMT-15's explicit one-step integrability hypothesis, it
    evaluates the finite orbit-sum integral, obtains a linear one-step bound
    and a subadditive real sequence, and proves that the normalized sequence
    converges to Mathlib's deterministic Fekete limit. The integral is not
    called an expectation without a probability measure, and the result is
    neither almost-sure nor a Lyapunov limit.
22. [`RandomCocycles/ProbabilityErgodicBase.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/ProbabilityErgodicBase.lean)
    keeps probability normalization, ergodicity, and finite-horizon
    integrability as separate interfaces. It packages the log-positive family
    as an integrable subadditive-process candidate, exposes the deterministic
    Fekete rate's nonnegativity, positive-index infimum, and finite-horizon
    upper bounds, and gives probability-specialized expectation terminology.
    Native ergodic results provide a zero-one law for strictly invariant
    measurable events and almost-everywhere constancy for almost-everywhere
    invariant real observables. None of these declarations constructs a
    samplewise limit or a Lyapunov exponent.
23. [`RandomCocycles/SubadditiveFiniteBlocks.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveFiniteBlocks.lean)
    proves both terminal-remainder and remainder-first finite block bounds,
    their exact quotient-and-remainder forms, and finite Birkhoff-sum
    integrability under preservation of the fixed block map. It isolates the
    exact time-zero normalization needed only for the uniform exact-block
    statement, then specializes the useful pointwise and integrability
    interfaces to cocycle log-positive growth. The pointwise cocycle bounds
    require no integrability premise; the entire layer requires neither
    probability nor ergodicity and makes no convergence claim.
24. [`RandomCocycles/SubadditiveCentering.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveCentering.lean)
    subtracts the one-step Birkhoff orbit sum from a finite subadditive
    process. The residual is nonpositive at every positive horizon without a
    time-zero premise, and uniformly nonpositive under exactly `X 0 = 0`.
    Raw finite algebra preserves shifted subadditivity; one-step measure
    preservation transports integrability and repackages the residual as a
    new candidate. An exact normalized identity then separates the original
    value into a normalized residual plus a finite Birkhoff average. The
    cocycle pointwise layer needs no generator-integrability witness; only its
    candidate packaging does. This is orbit-majorant compensation, not
    expectation centering, mean zero, or an ergodic limit theorem.
25. [`RandomCocycles/SubadditivePhaseAveraging.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/SubadditivePhaseAveraging.lean)
    reindexes all residue-phase block sums as one finite sliding Birkhoff sum,
    retains the exact prefix and terminal gaps, and discards those gaps under
    positive-horizon nonpositivity. Summing the phase bounds proves a
    zero-block-safe multiplication inequality at the corrected horizon
    `b * q + b + r`; division requires `b ≠ 0`, while `r` is unrestricted.
    Centered-process specializations add no time-zero or preservation premise,
    and the cocycle theorem takes the cocycle directly without the
    generator-integrability witness. The public wrappers retain their bundled
    fields, but the proofs consume only finite algebra and nonpositivity. This
    is a finite phase estimate, not a Birkhoff or Kingman convergence theorem.
26. [`RandomCocycles/SubadditiveIntervalPacking.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveIntervalPacking.lean)
    encodes positive-length half-open natural intervals by successive gaps, so
    chronological order, disjointness, abutment, containment, and exact
    covered cardinality are structural. A leftmost greedy selector produces a
    disjoint cover of marked starts inside the enlarged horizon `H + m` and
    records both coverage and the exact origin and length of every selected
    interval. Weak and strict favorable-cost estimates then give finite bounds
    by the number of marked starts; the weak result handles empty marks when
    the enlarged horizon is positive, while the strict result requires a
    nonempty marked set and derives that positivity. The process proof uses
    only shifted subadditivity and positive-horizon nonpositivity and makes no
    density, maximal, ergodic, convergence, or Lyapunov claim.
27. [`RandomCocycles/BirkhoffConvergence.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/BirkhoffConvergence.lean)
    proves finite-horizon measurability and integrability for real Birkhoff
    sums and averages, then names the points where those averages converge.
    Ordinary measurability gives a measurable event; an almost-everywhere
    measurable representative and quasi-measure preservation give a
    null-measurable event. Two positive-index prefix identities prove that
    convergence and its limit are unchanged by applying the base map once,
    hence the event is exactly preimage-invariant without invertibility or
    even measurability of the map. Pre-ergodic and quasi-ergodic rigidity then
    yield conditional null-or-conull conclusions, and probability
    normalization turns those into zero-one laws. Thin process and cocycle
    wrappers assert neither membership nor convergence existence.
28. [`RandomCocycles/FiniteHopfMaximal.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/FiniteHopfMaximal.lean)
    takes the running maximum of real Birkhoff sums through a fixed horizon,
    including the zero sum, and isolates its strict positivity event. A
    positive maximizing index yields the pointwise indicator inequality;
    measure preservation then cancels the two shifted maximal-function
    integrals and proves that the observable has nonnegative integral over the
    event. Centering by a real threshold gives finite average-exceedance
    bounds, a horizon-uniform positive-part estimate, and a weak measure
    bound whose division exposes exactly the premise that the threshold is
    positive. The core theorem needs neither finite total mass, probability,
    sigma-finiteness, ergodicity, nor invertibility. The average-threshold
    layer uses a finite measure only to make the constant centering observable
    integrable.
29. [`RandomCocycles/InfiniteHopfMaximal.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/InfiniteHopfMaximal.lean)
    defines the positive-time infinite Birkhoff-average exceedance event and
    identifies it exactly with the increasing union of the finite events.
    Ordinary measurability and integrable/null-measurable routes remain
    separate. Continuity from below is first stated without a finiteness gate
    for extended nonnegative real measure, then passes the horizon-uniform
    positive-part estimate to the infinite event under finite total mass.
    Division by a positive threshold gives the weak maximal bound. The
    real-measure convergence corollary uses an explicit local finiteness
    premise because `Measure.real` maps infinite extended mass to zero. A
    paired boundary probe records that this premise is a clean sufficient
    route, not a necessary condition for every particular sequence: no
    ungated general conversion theorem is valid, although some infinite-mass
    families do converge after totalization. The result requires neither
    probability, ergodicity, nor invertibility and makes no pointwise
    convergence claim.
30. [`RandomCocycles/KoopmanL2Mean.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/KoopmanL2Mean.lean)
    defines the real square-integrable Koopman contraction, its fixed
    subspace and orthogonal projection, and fixed-plus-simple-coboundary
    approximants. Raw forward coboundaries telescope at every horizon,
    including the totalized zero horizon. Hilbert-space geometry gives norm
    convergence of Koopman averages to the fixed-space projection and density
    of the fixed-plus-simple-coboundary core. Representative bookkeeping then
    proves almost-everywhere full-sequence convergence on that core, while a
    general square-integrable observable receives only an almost-everywhere
    convergent subsequence. The module assumes measure preservation only for
    its square-integrable geometry and makes no probability, ergodicity,
    invertibility, full pointwise-Birkhoff, or limit-identification claim.
31. [`RandomCocycles/PointwiseBirkhoff.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/PointwiseBirkhoff.lean)
    closes the finite-measure real pointwise Birkhoff theorem. It defines
    absolute positive-time maximal-error events and fixed-scale Cauchy
    exceptional events, proves their measurable-representative interfaces,
    and confines each Cauchy failure to a maximal approximation-error event
    plus the approximant's null bad set. Arbitrarily close pointwise-good
    approximants make every positive reciprocal-scale failure event null.
    Completeness of the reals then gives full-sequence almost-everywhere
    convergence. A continuous finite-measure inclusion with dense range sends
    the RMT-25 fixed-plus-simple-coboundary core from real `L²` into a dense
    real `L¹` core, supplying the required approximants. The final theorem
    assumes finite total mass, measure preservation, and integrability, but
    no probability normalization, ergodicity, injectivity, surjectivity, or
    invertibility. It proves convergence-event membership without identifying
    the limit.
32. [`RandomCocycles/PointwiseBirkhoffLimit.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/PointwiseBirkhoffLimit.lean)
    identifies that full-sequence limit with conditional expectation onto
    Mathlib's exact invariant sigma algebra. One total `limUnder`
    representative is literally invariant even on its divergent fallback
    branch. Measure-preserving orbit translates have identical laws, which
    yields uniform integrability of their Cesaro averages; finite-measure
    Vitali convergence then supplies integrability and real `L¹` convergence
    of the chosen limit. Restricted-measure preimage transport proves the
    required integral identity on every exactly invariant measurable set
    without an inverse map, and conditional-expectation uniqueness completes
    the identification for the original integrable representative. The final
    theorem assumes neither probability normalization nor ergodicity and
    accepts zero mass, noninjective, nonsurjective, and noninvertible dynamics.
33. [`RandomCocycles/ErgodicBirkhoffLimit.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/ErgodicBirkhoffLimit.lean)
    specializes the identified invariant target to a constant. Exact
    invariant measurability makes the selected conditional expectation
    literally fixed by composition with the base map. The weaker
    `PreErgodic` rigidity interface already makes it almost everywhere
    constant; finite nonzero mass and integrability identify the constant as
    Mathlib's integral average, equivalently the total-mass-normalized
    integral. Full `Ergodic` enters only when this identification is combined
    with the RMT-27 measure-preserving Birkhoff theorem. Probability
    normalization then reduces the target to the ordinary integral. The
    module adds no injectivity, surjectivity, invertibility, mixing, rate, or
    powered-map ergodicity assumption.
34. [`RandomCocycles/SubadditiveUpperLimsup.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveUpperLimsup.lean)
    proves the upper half of a Kingman-style pointwise estimate. Exact finite
    Birkhoff-sum integration and centered-process cancellation connect the
    finite phase-average inequality to the ergodic Birkhoff limit under the
    original map. Every positive block then bounds the almost-everywhere
    normalized upper limsup of a nonnegative integrable shifted-subadditive
    process. The cocycle specialization intersects all block events and uses
    the deterministic Fekete infimum to reach the integrated log-positive
    growth rate. A compiled two-cycle records why no ergodicity of a powered
    map may be smuggled into the proof. This remains one-sided: it proves no
    lower liminf bound, samplewise convergence, signed Lyapunov exponent, or
    Oseledets splitting.
35. [`RandomCocycles/SubadditiveBadBlockMeasure.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveBadBlockMeasure.lean)
    builds the finite measure-theoretic bridge needed by the complementary
    Kingman argument. It counts visits to a set before a finite horizon,
    identifies the real count with a Birkhoff sum of an indicator, and
    integrates that count exactly under finite measure and preservation. A
    finite strict centered bad-block set supplies one bounded witness length
    at every marked orbit start; the RMT-21 greedy packing then bounds the
    enlarged-horizon centered process by the marked visit count. A lower bound
    on all positive normalized centered integrals yields the bad-set estimate
    `μ.real badSet ≤ δ / c`, with the negative-threshold reversal explicit.
    The cocycle specialization uses the integrated log-positive Fekete rate
    minus its one-step integral. Probability and ergodicity are absent, and
    the module still claims no lower liminf or samplewise convergence.
36. [`RandomCocycles/SubadditiveAllLengthBadBlockMeasure.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveAllLengthBadBlockMeasure.lean)
    removes the finite witness cap by taking the increasing union over all
    natural caps. Membership means that one strict centered bad block occurs
    at some positive finite length, not that failures occur infinitely often.
    Countable null measurability and extended-measure continuity need no
    finite-mass premise; the real-measure convergence theorem exposes the
    finite-target gate forced by `Measure.real`. On a finite measure space the
    uniform RMT-30 ratio passes unchanged to the union, including the
    log-positive cocycle specialization. A compiled preserving two-state
    countermodel shows that the raw once-bad event need not be invariant.
37. [`RandomCocycles/SubadditiveLowerDeviation.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveLowerDeviation.lean)
    replaces one finite witness by positive witnesses beyond every cutoff at
    one rational slope below the target. Centered shifted subadditivity gives
    a threshold-relaxed preimage inclusion, and rational density closes it at
    the countably generated target event. Preservation and finite mass turn
    that one-sided inclusion into almost invariance; finite-measure
    ergodicity supplies the null-or-conull fork, while probability
    normalization and the strict RMT-31 ratio select the null branch. The
    cocycle endpoint reuses a named centered Fekete-offset lower bound and
    remains valid for an empty matrix index. The exact bridge to a real
    `liminf` and the full samplewise convergence theorem for the log-positive
    envelope are supplied only by the following module.
38. [`RandomCocycles/SubadditiveKingman.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveKingman.lean)
    completes the log-positive Kingman endpoint. It defines total normalized
    original and centered processes, proves that time zero does not affect the
    lower limit, and identifies rational lower-deviation membership with
    frequent strict threshold crossings under the exact real-boundedness gates
    required by Mathlib's conditionally complete `liminf`. A two-level rational
    exhaustion turns every strict lower-liminf failure into a countable union
    of RMT-32 null events and simultaneously supplies the eventual lower bound
    needed to interpret the real lower limit honestly. The exact normalized
    centering identity and the ergodic Birkhoff limit then lift the centered
    estimate to the original process. For matrix cocycles, this lower bound
    meets RMT-29's upper-limsup bound and yields almost-everywhere convergence
    of the normalized finite real `log+` norm observable to its integrated
    Fekete rate, including an empty matrix index. The theorem does not concern
    the signed logarithm, `L¹` convergence, interchange of limit and integral,
    inverse cocycles, Lyapunov exponents, or Oseledets splittings.
39. [`RandomCocycles/RealLogNormIntegrability.lean`](formalization/NonlinearDynamics/Random/RandomCocycles/RealLogNormIntegrability.lean)
    begins the signed finite-time layer without disguising Lean's total
    convention `Real.log 0 = 0`. Pointwise generator units propagate to every
    cocycle value and give real-log subadditivity, while a measurable
    log-positive norm of Mathlib's total nonsingular inverse supplies a
    forward-orbit lower-tail majorant. An explicit package of generator units,
    forward log-positive integrability, and inverse-generator log-positive
    integrability sandwiches every finite-time real log between integrable
    lower and upper rails and packages the family as an integrable
    shifted-subadditive candidate. A checked geometric-probability example
    with an identity base and invertible one-dimensional contractions proves
    that the forward moment alone need not control either the inverse tail or
    signed-log integrability. Separately, a strictly positive RMT-33 rate makes
    the real log and log-positive observable eventually agree almost
    everywhere, without invertibility or an inverse-tail hypothesis. The
    empty-dimensional specialization of that endpoint is syntactically valid
    but vacuous because its rate is zero. The module proves neither a general
    signed Kingman theorem nor an inverse-cocycle exponent identity,
    singular-value limit, Lyapunov spectrum, or Oseledets splitting.

This finite-dimensional foundation is deliberately earlier than asymptotic
spectral laws or quantum-chaos observables. The current asymptotic route has
passed from the infinite-horizon weak maximal inequality through Koopman
square-integrable mean convergence, a dense pointwise-good core, and the
maximal-closure proof of full-sequence almost-everywhere convergence for every
real integrable observable on a finite measure-preserving base. The next
identification stage first found the general conditional-expectation target,
then isolated pre-ergodic rigidity from measure preservation, positive total
mass, and probability normalization. The additive finite-measure Birkhoff
track is therefore complete at the correctly normalized ergodic constant.
The first subadditive asymptotic stage now connects finite phase averaging to
the additive ergodic theorem and proves the normalized upper-limsup estimate.
The finite bad-block layer converts centered short-block failures into an
exact real-measure ratio through visit counting and ordered interval packing.
The next checked layer passes that uniform estimate through the increasing
union of every finite cap, while keeping the resulting once-bad event separate
from an asymptotic lower-deviation event. The countably generated layer then
uses arbitrarily-late witnesses and one durable rational margin to build that
strict event, proves its one-sided shift law and almost invariance, and selects
the null branch on an ergodic probability base.
The guarded real-`liminf` layer now converts those null events into the
complementary lower estimate, restores the one-step Birkhoff majorant, and
combines the result with the upper `limsup` theorem. The pinned Mathlib release
supplies finite Birkhoff algebra and ergodic primitives, but no ready-made
pointwise Birkhoff or Kingman theorem; the repository closes that gap for the
cocycle's finite real log-positive norm observable. RMT-34 adds the missing
finite-time signed interface. It keeps collapse semantics,
pointwise units, inverse-tail domination, and positive-rate unclipping as
separate obligations, then constructs an integrable signed subadditive
candidate. A general signed almost-everywhere limit, limit-integral
identification, Lyapunov spectrum, and Oseledets splitting remain later
milestones.

That route gives the Random and Quantum Chaos programs a shared foundation,
then reconnects them to nonlinear stability through random Jacobians.

## The proof-to-prose contract

Every Lean module containing substantive declarations must have a paired,
comprehensive Development Notebook entry. The mapping lives in
[`site/data/lean_notebook_coverage.json`](site/data/lean_notebook_coverage.json),
and `make content-coverage` checks that:

- no substantive Lean module is missing from the mapping;
- every mapped notebook bundle exists and names the correct Lean module;
- every mapped notebook records explicit boolean publication and external-review
  states without confusing publication with review completion;
- each entry includes references, exact run instructions, and a substantial
  teaching treatment;
- when an entry freezes a site-hosted Lean snapshot, its module, snapshot path,
  and SHA-256 agree and still identify the checked source byte for byte.

The cloud-only `make check` runs this coverage gate, its snapshot-contract
regression tests, `make content-hygiene-test`, and `make content-hygiene`
automatically. The context-aware source gate masks YAML front matter, fenced
and inline code, HTML comments, `code`/`pre` HTML, and Hugo shortcode tags while
preserving source offsets and newlines. Markdown bodies inside ordinary
shortcodes remain checked; raw Mermaid bodies are masked.

In rendered regions, the gate rejects unbalanced, mismatched, or nested TeX
delimiters; double-escaped delimiter candidates outside active math; literal
angle signs inside TeX; bare-dollar math; lone equality lines that Goldmark can
treat as headings; and C0 controls or high-signal dropped TeX backslashes.
Valid TeX line-break spacing such as `\\[4pt]` inside math remains allowed. A
separate style view retains metadata and shortcode attributes and rejects em
dashes everywhere except rendered Markdown blockquotes or rendered same-line
paired quotation marks; literal code and comments remain ignored. Browser
inspection stays a separate rendered-layout check.

## Optional OpenAI API key

Some editorial tooling may consult the OpenAI API. Copy the example and place
the key only in the local `.env` file:

```sh
cp .env.example .env
chmod 600 .env
```

```dotenv
OPENAI_API_KEY=your-key-here
```

The `.env` file and private review outputs are ignored by Git. Never commit an
API key or paste one into an issue, pull request, or chat.

## Editorial guides

- [`site/content/development-notebook/AGENTS.md`](site/content/development-notebook/AGENTS.md)
  governs Development Notebook entries.
- [`site/content/knowledge-base/AGENTS.md`](site/content/knowledge-base/AGENTS.md)
  governs Knowledge Base glossary entries and deep dives.

The guides now live at the roots of the content trees they govern. New content
begins draft-gated by default. The owner may explicitly publish it earlier as
an open working note by setting `draft: false` while leaving
`pro_reviewed: false`; the site labels that publication mode visibly. Set
`pro_reviewed: true` only after the configured review gate actually completes.

## Troubleshooting

If `elan`, `lean`, or `lake` is not found:

```sh
source "$HOME/.elan/env"
```

Inspect the active Lean toolchain with:

```sh
cd formalization
elan show
```

Elan stores toolchains under `~/.elan`. Lake stores project dependencies and
build artifacts under `formalization/.lake` on the cloud builder. Do not
restore, download, or compile the Mathlib cache on macOS. The repository-root
[`AGENTS.md`](AGENTS.md) contains the durable host-separation and cloud
approval policy.
