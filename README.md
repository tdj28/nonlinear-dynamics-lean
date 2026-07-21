# Nonlinear Dynamics in Lean

This repository develops a machine-checked account of nonlinear dynamics and a
public teaching record alongside it. The two parts share one history but remain
separate build targets:

```text
.
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

## Requirements

- macOS (Apple Silicon or Intel) or a recent Linux distribution
- Git, `curl`, and [Hugo Extended](https://gohugo.io/installation/)
- Approximately 5 GB of free disk space for Lean, Mathlib, and build artifacts;
  10 GB is recommended

Lean versions are managed by [`elan`](https://github.com/leanprover/elan). The
formalization pins Lean and Mathlib to version 4.32.0.

## Install Lean on macOS

Check whether Apple's command-line tools are present:

```sh
git --version
```

If macOS reports that developer tools are missing:

```sh
xcode-select --install
```

Install Lean through elan:

```sh
curl https://elan.lean-lang.org/elan-init.sh -sSf | sh
source "$HOME/.elan/env"
```

Install Hugo Extended with Homebrew:

```sh
brew install hugo
```

## Install Lean on Linux

On Debian or Ubuntu:

```sh
sudo apt update
sudo apt install -y git curl
```

On Fedora:

```sh
sudo dnf install -y git curl
```

On Arch Linux:

```sh
sudo pacman -S --needed git curl
```

Install Lean through elan:

```sh
curl https://elan.lean-lang.org/elan-init.sh -sSf | sh
source "$HOME/.elan/env"
```

Install Hugo Extended using the instructions for your distribution in the
[Hugo installation guide](https://gohugo.io/installation/linux/).

## Clone and build everything

```sh
git clone https://github.com/tdj28/nonlinear-dynamics-lean.git
cd nonlinear-dynamics-lean
make setup
make check
```

`make setup` downloads the pinned Mathlib sources and precompiled cache. The
first run is the largest download.

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
make site-serve
```

Hugo prints the local URL in the terminal. Stop the server with `Ctrl+C`.

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

- [`BLOG-AGENTS.md`](BLOG-AGENTS.md) governs Development Notebook entries.
- [`KB-AGENTS.md`](KB-AGENTS.md) governs Knowledge Base glossary entries and
  deep dives.

The scoped `AGENTS.md` files under `site/content/` map those guides onto this
repository's names and paths. New public content remains a draft until the
required technical, editorial, and human review gates are complete.

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
