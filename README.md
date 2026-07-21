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
captures the project's research-to-Lean workflow: local Mathlib reconnaissance,
primary-source discipline, normalization ledgers, proof-to-prose pairing,
strict validation, checkpoint maintenance, and frequent pushes to `main`.

Useful checkpoint commands are:

```sh
make checkpoint
make checkpoint-check
```

## Requirements

- macOS (Apple Silicon or Intel) or a recent Linux distribution
- Git, `curl`, Python 3, and [Hugo Extended](https://gohugo.io/installation/)
- At least 12 GB of free disk space for Lean, Mathlib, caches, and build
  artifacts; 15 GB is recommended for comfortable rebuild headroom

Lean versions are managed by [`elan`](https://github.com/leanprover/elan). The
formalization pins Lean and Mathlib to version 4.32.0.

For scale, the current macOS Apple Silicon setup occupies about 10.3 GB after
setup: roughly 2.6 GB for the Lean 4.32.0 toolchain and 7.7 GB under
`formalization/.lake`, including about 6.9 GB for the Mathlib checkout and its
compiled cache. Exact sizes vary by platform and filesystem.

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
below.

Install Hugo Extended with Homebrew:

```sh
brew install hugo python
```

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

## Clone, download the Lean toolchain, and build everything

```sh
git clone https://github.com/tdj28/nonlinear-dynamics-lean.git
cd nonlinear-dynamics-lean
source "$HOME/.elan/env"
elan toolchain install leanprover/lean4:v4.32.0
make setup
make check
```

The downloads happen in distinct stages:

1. `elan toolchain install leanprover/lean4:v4.32.0` downloads the exact Lean
   compiler named by [`formalization/lean-toolchain`](formalization/lean-toolchain).
   Elan stores downloaded compilers under `~/.elan/toolchains/`.
2. `make setup` runs `lake update` in `formalization/`, which downloads the
   Mathlib revision pinned in
   [`formalization/lakefile.toml`](formalization/lakefile.toml) and records the
   resolved dependencies in `lake-manifest.json`.
3. `make setup` then runs `lake exe cache get`, which downloads Mathlib's
   precompiled Lean artifacts so the whole library does not need to be rebuilt
   locally.
4. `make check` builds this project's Lean modules, verifies the living
   checkpoint and proof-to-prose coverage, runs the context-aware teaching
   source tests and scan, and validates all Hugo content.

The first setup is the largest download. Later builds reuse the toolchain and
Mathlib cache.

To perform the Lean dependency steps manually instead of using `make setup`:

```sh
cd formalization
lake update
lake exe cache get
lake build
```

Verify that the repository selected the intended compiler:

```sh
cd formalization
elan show
lean --version
```

Build only the Lean formalization:

```sh
make lean
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
internet. Tailnet access rules still apply. Override the port when needed with
`make blog-serve-tailscale BLOG_PORT=1444`. Stop either server with `Ctrl+C`.

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

This finite-dimensional foundation is deliberately earlier than asymptotic
spectral laws or quantum-chaos observables. The next milestones are:

1. Add explicit probability and ergodicity interfaces using Mathlib's native
   `[IsProbabilityMeasure μ]` and `Ergodic C.base μ` assumptions, while
   keeping raw-measure and probability statements visibly distinct.
2. Audit the exact hypotheses and available Mathlib infrastructure for a
   Kingman-style subadditive ergodic theorem before introducing any
   almost-sure limit or Lyapunov terminology.

That route gives the Random and Quantum Chaos programs a shared foundation,
then reconnects them to nonlinear stability through random Jacobians.

## The proof-to-prose contract

Every Lean module containing substantive declarations must have a paired,
comprehensive Development Notebook entry. The mapping lives in
[`site/data/lean_notebook_coverage.json`](site/data/lean_notebook_coverage.json),
and `make content-coverage` checks that:

- no substantive Lean module is missing from the mapping;
- every mapped notebook bundle exists and names the correct Lean module;
- new entries remain draft-scoped until human review;
- each entry includes references, exact run instructions, and a substantial
  teaching treatment.

`make check` runs this coverage gate, `make content-hygiene-test`, and
`make content-hygiene` automatically. The context-aware source gate masks YAML
front matter, fenced and inline code, HTML comments, `code`/`pre` HTML, and
Hugo shortcode tags while preserving source offsets and newlines. Markdown
bodies inside ordinary shortcodes remain checked; raw Mermaid bodies are
masked.

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

The guides now live at the roots of the content trees they govern. New public
content remains a draft until the required technical, editorial, and human
review gates are complete.

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
build artifacts under `formalization/.lake`.
