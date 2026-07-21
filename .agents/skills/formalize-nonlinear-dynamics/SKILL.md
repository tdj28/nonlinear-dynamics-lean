---
name: formalize-nonlinear-dynamics
description: Advance and maintain this repository's nonlinear-dynamics Lean formalization and paired Hugo research notebook. Use when implementing or reviewing Lean modules, researching mathematical or physical foundations, writing Development Notebook or Knowledge Base coverage, updating checkpoint.md, validating the proof-to-prose contract, or committing and pushing coherent milestones to main.
---

# Formalize Nonlinear Dynamics

Build one vertically complete research milestone at a time: checked Lean,
reproducible exposition, verified sources, a current checkpoint, and a pushed
commit.

## Start Every Milestone

1. Read repository-root `checkpoint.md`, `README.md`, `formalization/lean-toolchain`,
   and `formalization/lakefile.toml`.
2. Read the complete nearest `AGENTS.md` before editing Development Notebook or
   Knowledge Base content.
3. Run `git status -sb` and preserve unrelated user changes.
4. Load Lean with `source "$HOME/.elan/env"` when the shell has not already done
   so.
5. Select the first unblocked dependency-ordered item in `checkpoint.md`.

Do not start a later theorem because it looks exciting if an earlier
definition, measurability result, convention, or law-level interface is still
missing.

## Research Before Encoding

- Search the pinned local Mathlib checkout first with `rg`. Treat exact local
  declarations as the API authority.
- Use official documentation, original papers, or standard monographs for
  scientific claims. For technical searches, rely on primary sources.
- Record definitions, assumptions, normalization conventions, and negative
  results before designing the Lean interface.
- Keep a normalization ledger for every ensemble or physics convention:
  dimension, diagonal variance, off-diagonal real/imaginary variance, density
  exponent, spectral scale, and trace normalization.
- Distinguish a sample map, measurability, almost-everywhere properties,
  pushforward law, integrability, expectation, and asymptotic claims.
- Mark conjectures and physics heuristics as such. Never upgrade evidence or a
  standard expectation into a theorem.
- Use independent subagents for source gathering, API reconnaissance, and
  adversarial review when work can proceed in parallel.
- Consult an OpenAI model only through optional local tooling when useful. Read
  the key from ignored `.env`; never print, commit, or expose it.

## Design the Lean Slice

1. State the smallest mathematically honest interface that unlocks the next
   result.
2. Reuse project namespaces and upstream Mathlib concepts instead of creating
   parallel abstractions without need.
3. Keep assumptions visible and weak:
   - prefer general finite index types until dimension arithmetic needs `Fin n`;
   - separate algebra from topology, measurability, probability, and limits;
   - separate pointwise statements from almost-everywhere and law-level ones.
4. Add the module to the nearest aggregator.
5. Compile early with:

   ```sh
   cd formalization
   lake env lean -DwarningAsError=true path/to/Module.lean
   ```

6. Use no `sorry`, `admit`, hidden axioms, guessed APIs, or unsupported
   normalization.

## Maintain the Proof-to-Prose Pair

For every Lean file containing substantive declarations:

1. Add exactly one comprehensive Development Notebook bundle.
2. Map it in `site/data/lean_notebook_coverage.json`.
3. Explain every named declaration, its proof architecture, commands, failure
   modes, and explicit nonclaims.
4. Set `draft: true` and `pro_reviewed: false` until the human author completes
   the required reviews.
5. Add or update Knowledge Base glossary pages and Deep Dives when the module
   introduces reusable concepts.
6. Generate a deterministic 1200x630 page-bundle card for each Research Note
   or Deep Dive that requires one. Make generators independent of the caller's
   working directory.
7. Cite official Lean/Mathlib sources and primary mathematical or physics
   references. Do not use noncompiling Lean ellipses in executable code fences.

Never let the Lean tree outrun its public explanation.

## Update the Checkpoint

Before every milestone commit:

- update `checkpoint.md` with the verified state, newly completed artifacts,
  exact next slice, open risks, decisions, validation output, and recent push;
- mark an item complete only when its Lean and prose gates both pass;
- keep unproved claims and unresolved convention choices visible;
- retain enough detail for a fresh session to continue without reconstructing
  the project from git history.

Run `make checkpoint` to display it and `make checkpoint-check` to validate its
required structure and substantive-module inventory.

## Validate the Milestone

Run from the repository root:

```sh
make check
git diff --check
```

Also run the changed Lean file directly with warnings as errors. Check that:

- every substantive module has notebook coverage;
- Hugo builds all drafts with warnings fatal;
- no `sorry`, `admit`, secret, stale path, or accidental generated artifact is
  present;
- social-card dimensions and alt text are correct;
- mathematical prose does not claim more than Lean proves.

For every new or materially changed teaching page:

- run each page-bundle card generator with `--verify` and validate conceptual
  SVGs with `xmllint` plus a rendered visual inspection;
- inspect the built page in a browser at the default desktop width and at 390
  pixels, checking page-level overflow, locally scrollable wide content,
  lazy-loaded asset dimensions, navigation, and console-visible failures;
- compare source math delimiters with rendered KaTeX, require zero KaTeX
  errors and zero raw delimiters, and remember that Hugo's Markdown parser runs
  before KaTeX: write `\lt` and `\gt` inside TeX instead of literal `<` and `>`
  when Goldmark could mistake them for HTML; and
- when a patch passes through JavaScript or another escape-sensitive layer,
  use a raw string or explicitly preserve every backslash. Afterward scan the
  Markdown source for dropped delimiters and commands such as plain
  `(mathbb R)`, `(lambda_i)`, `(operatorname{...})`, or `(delta_x)`;
  a warning-free Hugo build alone does not detect prose that was never handed
  to KaTeX; and
- keep code-fence comparison operators literal. The TeX workaround belongs
  only in mathematical delimiters, never in Lean or shell examples.

Use a separate read-only reviewer for high-risk mathematics, normalization,
or law-versus-sample distinctions.

## Publish Frequently to Main

The user has authorized frequent direct pushes to `main` for this repository.
At each coherent green milestone:

1. Fetch `origin/main` and confirm the remote has not moved unexpectedly.
2. Inspect the full scope and stage only related files. Never stage `.env`.
3. Commit with a terse milestone description.
4. Push directly to `origin main`.
5. Verify local `HEAD` equals `refs/heads/main` on the remote and the worktree is
   clean.

If the remote moved, integrate safely and rerun validation before pushing. Do
not leave a coherent validated milestone unpushed.

## Definition of Done

A roadmap item is complete only when:

- Lean compiles with warnings as errors and no proof holes;
- definitions and normalization choices are explicit;
- the paired Notebook chapter covers every declaration;
- reusable concepts are integrated into the Knowledge Base;
- `checkpoint.md` reflects reality;
- `make check` passes; and
- the milestone is committed and pushed to `main`.
