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
4. `make check` builds this project's Lean modules, verifies that every
   substantive Lean module has a comprehensive Development Notebook page, and
   validates all Hugo content.

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

This finite-dimensional foundation is deliberately earlier than asymptotic
spectral laws or quantum-chaos observables. The next milestones are:

1. Construct Cartesian complex Gaussian primitive variables from independent
   exact real laws, keeping real-part and imaginary-part variances explicit.
2. Define finite GOE/GUE ensembles with a visible normalization ledger.
3. Use the law-level interface to prove unitary invariance of GUE at the level
   of probability laws.
4. Establish integrability and check the first exact expected trace moments.
5. Reuse the same matrix layer for random Jacobian stability and matrix
   cocycles.

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

`make check` runs this gate automatically. This prevents the formalization from
silently outrunning its public explanation.

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
