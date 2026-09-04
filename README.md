# Nonlinear Dynamics in Lean

This repository formalizes selected results in nonlinear dynamics in Lean 4
and develops a teaching record alongside them. Read the
[public learning site](https://tdj28.github.io/nonlinear-dynamics-lean/) or
explore the source and draft lessons here. The formalization and site share
one history but remain separate build targets:

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

## Validation and review status

The latest complete project validation recorded in
[`checkpoint.md`](checkpoint.md) is commit
[`de78075`](https://github.com/tdj28/nonlinear-dynamics-lean/commit/de78075),
checked on 2026-08-23 with Lean 4.32.0 and the committed Mathlib manifest.
The current `main` branch also contains a finite-GUE raw-spacing-law candidate
whose project Lean validation is still pending. Passing the website checks or
a standalone `Std` exercise does not validate that candidate.

The proof and teaching work is AI-assisted. The teaching pages retain
`pro_reviewed: false`: publication is permission to read working notes, not a
record of external specialist review. A checked Lean proof establishes its
formal statement; agreement with the intended mathematics and the exposition
requires a separate audit.

The [September 2026 public audit](docs/public-audit-2026-09-04.md) records
the latest corrections, validation limits, and recommended next steps.

## Project memory and research workflow

Read [`checkpoint.md`](checkpoint.md) at the start of a work session. It records
the last verified state, completed vertical slices, explicit nonclaims,
dependency-ordered roadmap, and exact next milestone. Update it before every
coherent milestone commit.

The checked-in
[`formalize-nonlinear-dynamics` skill](.agents/skills/formalize-nonlinear-dynamics/SKILL.md)
captures the project's research-to-Lean workflow: pinned Mathlib source
reconnaissance, primary-source discipline, normalization ledgers,
proof-to-prose pairing, strict validation, checkpoint maintenance, and
frequent pushes to `main`.

Useful checkpoint commands are:

```sh
make checkpoint
make checkpoint-check
```

## Requirements and disk space

For site work on macOS or Linux, install Git, `curl`, Make, Python 3, and
[Hugo Extended](https://gohugo.io/installation/). The recorded site validation
and deployment use Hugo 0.160.1; use that release when reproducing them. Lean
versions are managed by [`elan`](https://github.com/leanprover/elan). The
formalization pins Lean to 4.32.0 and records the exact Mathlib and transitive
dependency commits in [`lake-manifest.json`](formalization/lake-manifest.json).

There are two useful ways to follow the teaching material:

- A **standalone tutorial** imports only Lean core or `Std`. It needs the pinned
  Lean compiler but does not download Mathlib.
- A **full project check** imports the repository and Mathlib. The instructions
  below target Linux. Plan for at least 20 GB of free disk space, including
  temporary downloads and build output, and substantial memory for rebuilding
  dependencies. On macOS, follow the site and standalone-tutorial routes.

For scale, the Lean 4.32.0 compiler occupies roughly 2.6 GB on Apple Silicon,
and a downloaded Mathlib dependency and compiled-cache tree can add roughly
7.3 GB. Exact sizes vary by platform, filesystem, and dependency revision.

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
below. The pinned compiler can run the small files in this site that import
only Lean core or `Std`; the full project setup later adds Mathlib.

If `brew --version` is not found, install Homebrew first using its
[official installation instructions](https://docs.brew.sh/Installation):

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the shell-configuration line printed by the installer, open a new
terminal, and then install Hugo Extended and Python:

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

Then invoke the pinned Lean toolchain to elaborate the file:

```sh
elan run leanprover/lean4:v4.32.0 lean TinyTutorial.lean
```

Lean should print `[0, 1, 4, 9, 16]` and exit without an error. This is a
small compiler-and-`Std` exercise, not a Mathlib or project build. The
Knowledge Base uses exercises like this to teach syntax before moving to
full-project examples that use the pinned Mathlib dependencies.

## Install Lean on Linux

On Debian or Ubuntu:

```sh
sudo apt update
sudo apt install -y git curl make python3
```

On Fedora:

```sh
sudo dnf install -y git curl make python3
```

On Arch Linux:

```sh
sudo pacman -S --needed git curl make python
```

Install the elan toolchain manager:

```sh
curl https://elan.lean-lang.org/elan-init.sh -sSf | sh
source "$HOME/.elan/env"
```

Install Hugo Extended using the instructions for your distribution in the
[Hugo installation guide](https://gohugo.io/installation/linux/).

## Clone and set up the project

These commands are the same on macOS and Linux:

```sh
git clone https://github.com/tdj28/nonlinear-dynamics-lean.git
cd nonlinear-dynamics-lean
source "$HOME/.elan/env"
elan toolchain install leanprover/lean4:v4.32.0
```

The last command downloads only the exact compiler named by
[`formalization/lean-toolchain`](formalization/lean-toolchain). Elan stores it
under `~/.elan/toolchains/`; it does not download Mathlib.

For the full formalization on Linux, download the committed dependencies and
Mathlib's precompiled cache. Contributors should first read the repository's
[operating instructions](AGENTS.md). To reproduce the last fully validated
source in a fresh clone, select its exact commit before entering the project:

```sh
git switch --detach de78075
```

Omit that checkout only if you intend to test current development, including
the candidate described above. Then run:

```sh
cd formalization
sha256sum --check lake-manifest.sha256
lake exe cache get
sha256sum --check lake-manifest.sha256
```

Lake uses the resolved revisions in the committed manifest, and
`lake exe cache get` downloads the matching precompiled Mathlib artifacts.
The checksum checks detect a changed manifest. Do not run `lake update` as
part of reproducing this snapshot: that command resolves dependencies again
and can change the manifest. Stop and investigate any checksum mismatch.

Verify that the repository selected the intended compiler:

```sh
elan show
lean --version
```

Build only the Lean formalization:

```sh
lake build
```

Check one source file while following a chapter:

```sh
lake env lean -DwarningAsError=true NonlinearDynamics/path/to/Module.lean
```

Build only the site from the repository root. If you entered `formalization`
for the Linux commands above, return with `cd ..` first:

```sh
make site
```

Run a local Hugo server that includes drafts:

```sh
make blog-serve
```

This serves the complete learning site, including drafts, at
`http://127.0.0.1:1333/`. Stop the server with `Ctrl+C`.

Site builds also mount the repository's `.lean` files beneath
`/lean/NonlinearDynamics/`. A teaching page that declares `lean_module`,
`lean_snapshot`, and `lean_source_sha256` links to this site-hosted source;
`make content-coverage` reads those keys only from YAML front matter on every
content page, derives the exact URL from the module name, and verifies that the
recorded SHA-256 still matches the current source. This is a source-identity
check, not evidence that the file compiles. No `.env`, build cache, Git
metadata, or other formalization artifact is published by this mount.

## Publish with GitHub Pages

The repository includes a GitHub Actions workflow at
`.github/workflows/pages.yml`. On each relevant push to `main`, it installs the
pinned Hugo Extended 0.160.1 release, runs the checkpoint and site checks,
builds the production site for the repository subpath, and deploys the result
to GitHub Pages. It intentionally does not compile the Lean formalization.

To activate it, open the repository on GitHub and select **Settings → Pages →
Build and deployment → Source → GitHub Actions**. The expected project URL is:

```text
https://tdj28.github.io/nonlinear-dynamics-lean/
```

This first push may start the workflow before Pages is enabled and fail during
the configuration step. After selecting **GitHub Actions**, rerun that failed
workflow from the **Actions** tab or choose **Run workflow**; the workflow also
supports manual dispatch for exactly this case.

The deployment omits pages marked `draft: true`. Published pages marked
`draft: false` are public working notes; their `pro_reviewed: false` metadata
and visible pending-review language remain in place. Some later teaching
bundles, including the current GUE candidate, are still drafts and appear only
in draft-inclusive previews of the site. Their Markdown, Lean files, and
assets are nevertheless publicly readable in this public repository.

**A Hugo draft flag controls site inclusion, not confidentiality.** Do not
store confidential review material in any tracked file, even if the page is
a draft or absent from the production site.

The mounted `.lean` sources are static publication assets and are also public
under the Pages URL. Publishing an article does not change the mathematical
scope, axiom ledger, proof status, or explicit nonclaims recorded in it.

This repository and its GitHub Pages site are public. Never put `.env`, API
keys, credentials, infrastructure identifiers, private
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

## Mathematical scope

The module names below link to source and import graphs; the
[checkpoint](checkpoint.md) and
[notebook coverage map](site/data/lean_notebook_coverage.json) provide the
declaration-level release history and teaching companions.

| Area | Validated contribution | Main boundary |
|---|---|---|
| [Random matrices](formalization/NonlinearDynamics/Random/RandomMatrices.lean) | Finite Gaussian unitary ensemble (GUE) construction and unitary invariance, first two trace moments, ordered Hermitian spectral continuity, and empirical spectral laws | No limiting spectral distribution or universality theorem |
| [Random cocycles](formalization/NonlinearDynamics/Random/RandomCocycles.lean) | Ordered finite products; finite-measure pointwise Birkhoff theory; log-positive and signed real-log Kingman endpoints under their stated hypotheses | No Lyapunov spectrum, invariant splitting, or Oseledets theorem |
| [Discrete dynamics and chaos](formalization/NonlinearDynamics/Deterministic.lean) | Stability, attraction, Lyapunov certificates, conjugacy, bifurcation interfaces, sensitivity, the Devaney implication, and the one-sided full shift | Concrete model files do not automatically inherit every abstract chaos theorem |
| [Ordinary differential equations and models](formalization/NonlinearDynamics/Deterministic/ODE/GlobalExistence.lean) | Global-solution and flow interfaces with explicit existence, uniqueness, and continuity gates; stability and Lyapunov results; six concrete model slices | No general theorem of Lorenz chaos or global existence for every displayed model |
| [Finite quantum systems](formalization/NonlinearDynamics/QuantumChaos/FiniteSystems.lean) and [raw spectral statistics](formalization/NonlinearDynamics/QuantumChaos/SpectralStatistics.lean) | Hermitian Hamiltonians, unitary time evolution, normalized traces, nonnegative raw adjacent gaps, and measurable empirical gap measures | No unfolding, level repulsion, spectral form factor, out-of-time-order correlator, or quantum-chaos criterion |

The signed real-log Kingman milestone is complete, including its teaching
bundle and recorded full validation. Its hypotheses include a probability
preserving ergodic base, pointwise invertible generators, and integrability of
both forward and inverse log-positive generator norms.

The project's selected **stochastic stability** result is
[upper semicontinuity of the integrated signed growth rate](formalization/NonlinearDynamics/Random/RandomCocycles/GrowthRateStability.lean)
under uniform generator convergence with common forward and inverse norm
bounds over a fixed probability-preserving base. It does not assert full
continuity or stability of stationary measures or random attractors.

The next candidate,
[`QuantumChaos/GUE.lean`](formalization/NonlinearDynamics/QuantumChaos/GUE.lean),
pushes the finite GUE law through the raw-spacing measure map. The law is a
probability distribution on whole measures; in dimensions zero and one its
single atom is the zero measure. Its source and teaching artifacts are
available, but its project Lean validation is pending. Do not treat this
candidate as part of the validated results in the table.

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
  and SHA-256 agree and identify the current source byte for byte. Compilation
  and source identity are separate checks.

The repository checks include this coverage gate, its snapshot-contract
regression tests, `make content-hygiene-test`, and `make content-hygiene`. The
context-aware source gate masks YAML front matter, fenced and inline code, HTML
comments, `code`/`pre` HTML, and Hugo shortcode tags while preserving source
offsets and newlines. Markdown bodies inside ordinary shortcodes remain
checked; raw Mermaid bodies are masked.

A companion public-language gate keeps maintainer infrastructure out of the
reader experience. Teaching pages use only the portable distinction between a
standalone Lean-core/`Std` tutorial and a full project check with the pinned
Lean and Mathlib dependencies.

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
build artifacts under `formalization/.lake`. If disk usage grows unexpectedly,
inspect that directory first; deleting it is safe only when you are prepared to
download dependencies and compiled artifacts again.
