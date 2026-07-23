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
4. Identify the host before touching Lean. On macOS, version inspection and
   genuinely small teaching files that import only Lean core or `Std` are
   allowed. Do not invoke project compilation, Lake, a Mathlib import, or a
   Mathlib cache operation there. For proof probes or project builds, obtain
   approval for a Linux cloud builder and use the guarded workflow below.
5. Select the first unblocked dependency-ordered item in `checkpoint.md`.

Do not start a later theorem because it looks exciting if an earlier
definition, measurability result, convention, or law-level interface is still
missing.

## Research Before Encoding

- Search the pinned Mathlib source first with `rg`; an existing source checkout
  may be read on the workstation. Treat exact pinned declarations plus
  warning-fatal cloud compilation as the API authority. Never regenerate the
  workstation's compiled Mathlib cache for reconnaissance.
- Use official documentation, original papers, or standard monographs for
  scientific claims. For technical searches, rely on primary sources.
- Record the exact source version, theorem/section/page anchor, persistent
  identifier, relevant errata, definitions, assumptions, normalization
  conventions, and negative results before designing the Lean interface.
- Audit every imported finite index, interval, and remainder count before
  encoding a displayed formula from the literature. If a source's horizon and
  summand counts are incompatible, formalize the corrected arithmetic, keep
  the repair explicit in prose, and never silently quote the inconsistent
  display as though Lean had verified it.
- Keep a normalization ledger for every ensemble or physics convention:
  dimension, diagonal variance, off-diagonal real/imaginary variance, density
  exponent, spectral scale, and trace normalization.
- Distinguish a sample map, measurability, almost-everywhere properties,
  pushforward law, integrability, expectation, and asymptotic claims.
- For random measure-valued objects, keep a typed object ledger: a sample
  measure, a law on raw measures, a law valued in bundled probability
  measures, and a Giry barycenter are different constructions. Never infer an
  expectation/barycenter or integral-interchange identity without a checked
  theorem and its measurability and integrability hypotheses.
- Mark conjectures and physics heuristics as such. Never upgrade evidence or a
  standard expectation into a theorem.
- Use independent subagents for source gathering, API reconnaissance, and
  adversarial review when work can proceed in parallel.
- Consult an OpenAI model only through optional local tooling when useful. Read
  the key from ignored `.env`; never print, commit, or expose it.

## Run Formal Discovery Transparently

Use the workflow documented by van Doorn, Judin, Monticone, and Morrison in
[On Some Problems from the Kourovka Notebook](https://arxiv.org/abs/2607.17477)
as a methodological precedent, not as mathematical authority for nonlinear
dynamics:

1. Preserve four distinguishable artifacts: the sourced mathematical problem,
   its exact Lean statement, the exploratory proof, and the canonized
   proof-to-prose result. Keep material failed approaches and discarded
   assumptions in `checkpoint.md`; keep raw scratch proofs outside the public
   tree, and never push a broken proof state merely to preserve exploration.
2. Audit definitions and the formal statement before searching for a proof.
   Check competing meanings, hidden assumptions, boundary countermodels, and
   whether a logically equivalent low-level expansion would obstruct reusable
   theory. Prove an explicit equivalence or implication bridge to the sourced
   definition when feasible; otherwise label the result as an adaptation. Do
   not treat type-correctness as confirmation of intended meaning.
3. When a goal is difficult, request a proof outline, isolate intermediate
   lemmas, compile-probe the hard API boundaries, and try equivalent
   formulations without silently weakening the claim. Record partial progress
   and honest blockers instead of abandoning an “open-looking” theorem.
4. Informalize only from a checked formal proof. Then independently audit the
   prose against the declarations and seek domain-expert review before calling
   a genuinely new mathematical result established.
5. Run canonization as a separate pass: extract and generalize reusable lemmas,
   minimize assumptions, improve names, organization, documentation, and
   performance, identify upstream Mathlib candidates, and rerun every gate.
   Upstream acceptance is valuable but does not block a checked repository
   milestone unless the user explicitly makes it a requirement.
6. Record a provenance ledger for material discoveries: who selected and
   clarified the problem, supplied definitions or infrastructure, proposed
   proof steps, found the argument, checked the formalization, and wrote the
   exposition. Use “autonomous” only when no human supplied mathematical proof
   strategy. Keep this in `checkpoint.md` until a project-level manifest is
   introduced; a future machine-readable `formalization.yaml` should also
   record pinned versions, sources, main declarations and axioms, automation
   runs and costs, fidelity divergences, review status, and source-to-Lean
   alignment.

Feed reusable definitions and lemmas back into the repository before starting
the next discovery attempt; infrastructure growth is part of the research
output, not incidental cleanup.

## Design the Lean Slice

1. State the smallest mathematically honest interface that unlocks the next
   result.
2. Reuse project namespaces and upstream Mathlib concepts instead of creating
   parallel abstractions without need.
3. Keep assumptions visible and weak:
   - prefer general finite index types until dimension arithmetic needs `Fin n`;
   - separate algebra from topology, measurability, probability, and limits;
   - separate pointwise statements from almost-everywhere and law-level ones;
   - audit which fields of a bundled hypothesis the proof actually consumes;
     distinguish those proof dependencies from the stronger structure still
     present in the public receiver type, so prose never calls a theorem
     premise-free merely because its body projects only one field;
     when a public specialization needs only raw algebra, take the underlying
     object directly and discharge the algebra through a private helper rather
     than requiring an integrability or probability package; and
   - compile boundary countermodels before freezing the API. In particular,
     test zero horizons, zero block lengths, empty index types, degenerate
     measures, and periodic bases to distinguish necessary assumptions from
     convenient ones;
   - when a theorem is valid at every positive horizon but its time-zero case
     needs normalization, expose positive-horizon and uniform variants instead
     of forcing the time-zero premise onto the useful positive statement; and
   - audit overloaded mathematical vocabulary against the exact definition.
     For example, subtracting a pointwise orbit majorant is not expectation
     centering and does not imply mean zero.
4. For iterated dynamics, track properties of the powered map separately.
   `MeasurePreserving T μ μ` passes to `T^[b]`, but `Ergodic T μ` does not in
   general pass to `T^[b]`; never use preservation as a proxy for ergodicity.
5. Add the module to the nearest aggregator.
6. Compile early on an explicitly approved Linux cloud builder from the
   repository root with:

   ```sh
   CLOUD_LEAN_BUILD=1 make lean-file \
     LEAN_FILE=NonlinearDynamics/path/to/Module.lean
   ```

   Do not run this command on macOS. Source-only editing and `rg` searches may
   happen there, but every Lean probe belongs on the cloud builder. Do not use
   a raw Lake command to bypass the target's manifest-digest check.

7. Use no `sorry`, `admit`, hidden axioms, guessed APIs, or unsupported
   normalization.

## Maintain the Proof-to-Prose Pair

For every Lean file containing substantive declarations:

1. Add exactly one comprehensive Development Notebook bundle.
2. Map it in `site/data/lean_notebook_coverage.json`.
3. Explain every named declaration, its proof architecture, commands, failure
   modes, and explicit nonclaims.
4. Set `draft: true` and `pro_reviewed: false` until the human author completes
   the required reviews.
5. Give every new Deep Dive the canonical multiline `ai_disclosure` front
   matter consumed by the Deep Dive template; a prose warning panel is not a
   substitute for the rendered disclosure field.
6. Add or update Knowledge Base glossary pages and Deep Dives when the module
   introduces reusable concepts.
7. Generate a deterministic 1200x630 page-bundle card for each Research Note
   or Deep Dive that requires one. Make generators independent of the caller's
   working directory.
8. Cite official Lean/Mathlib sources and primary mathematical or physics
   references. Do not use noncompiling Lean ellipses in executable code fences.
9. Expand technical acronyms on each standalone summary surface, including
   cards and conceptual figures, or replace them there with self-contained
   plain language.
10. Keep maintainer infrastructure out of reader-facing prose. Public
    tutorials distinguish a portable **standalone tutorial** from a **full
    project check** that needs the pinned Lean and Mathlib dependencies. They
    must not mention the owner's workstation, RunPod, cloud approval,
    contributor-only guards, private networking, retained caches, or internal
    release operations. Keep those constraints in `AGENTS.md`, this skill, and
    `checkpoint.md`, and require `make content-hygiene` to reject future leaks.

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

Run the complete gate from the approved Linux cloud builder:

```sh
CLOUD_LEAN_BUILD=1 make check
```

On the macOS workstation, run `make workstation-check`, `git diff --check`,
deterministic asset verification, and browser QA as applicable. Do not bypass
the Makefile host guard or invoke Lean directly. On the cloud builder, also run
the changed Lean file directly with warnings as errors. Check that:

- every substantive module has notebook coverage;
- Hugo builds all drafts with warnings fatal;
- no `sorry`, `admit`, secret, stale path, or accidental generated artifact is
  present;
- social-card dimensions and alt text are correct;
- mathematical prose does not claim more than Lean proves.
- totalized boundary identities are described at their true information
  content. An equality that reduces to `0 = 0` through division by zero is
  valid but may be vacuous and must not be narrated as a positive-time
  averaging fact.

The cloud-only `make check` runs the table-driven source-hygiene regression
tests and `scripts/check_teaching_source_hygiene.py` over every teaching
Markdown file. The checker preserves offsets and newlines while masking YAML
front matter, fenced and inline code, HTML comments, `code`/`pre` HTML, Hugo
shortcode tags, and raw Mermaid bodies. It still checks Markdown bodies inside
ordinary shortcodes.

In rendered regions, require balanced, matched, non-nested `\(...\)` and
`\[...\]`; reject double-escaped delimiter candidates outside active math,
literal angle signs inside TeX, bare-dollar math, lone equality lines, C0
controls, and high-signal dropped TeX backslashes. The style view retains
metadata and shortcode attributes: allow em dashes only inside rendered
Markdown blockquotes or rendered same-line paired quotation marks, while
ignoring literal code and comments.
Valid TeX line-break spacing such as `\\[4pt]` inside math is not a delimiter
candidate. Keep the browser checks below as a separate rendered-output gate;
the source checker cannot judge layout.

For every new or materially changed teaching page:

- run each page-bundle card generator with `--verify` and validate conceptual
  SVGs with `xmllint` plus a rendered visual inspection;
- inspect the built page in a browser at the default desktop width and at 390
  pixels, checking page-level overflow, locally scrollable wide content,
  lazy-loaded asset dimensions, navigation, and console-visible failures;
- compare source math delimiters with rendered KaTeX, require zero KaTeX
  errors and zero raw delimiters, and remember that Hugo's Markdown parser runs
  before KaTeX: write `\lt` and `\gt` inside TeX instead of literal `<` and `>`
  when Goldmark could mistake them for HTML; scan for lines consisting only of
  optional whitespace and `=`, because Goldmark can parse those as Setext
  heading underlines and silently hide a display from KaTeX, and write `{} =`
  or keep the equality on an adjacent TeX line instead; and
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

## Scale Builds Safely

The macOS workstation is permanently a source, research, Hugo, static-QA, and
small standalone Lean-tutorial host for this project. It must not run Lean or
Lake commands that download, restore, compile, or regenerate a Mathlib cache.
Every Mathlib-backed proof probe, dependency setup, project module compile, and
full repository build runs on explicitly authorized Linux cloud compute. Keep
this separation mandatory, not an optional response to memory pressure:

- keep secrets in ignored `.env` and never print, copy into the repository,
  stage, or commit them;
- before creating or restarting paid compute, obtain human approval for the
  provider, CPU/RAM/storage, estimated hourly cost, and intended work; existing
  credentials do not imply approval;
- on the approved Linux host, set `CLOUD_LEAN_BUILD=1` for `make setup`,
  `make lean`, `make lean-file`, `make lean-clean`, and `make check`; the guard
  must reject every non-Linux host and must not be bypassed;
- use a dedicated SSH key and a dedicated known-hosts file for the builder;
- use either a fresh remote clone at the exact approved commit or a source-only
  transfer without `.env`, generated Hugo output, local `.lake` artifacts, Git
  metadata, or private review files. Never transfer the workstation's `.git`
  directory or broad home-directory credentials;
- build on the provider's fast ephemeral disk, because Lean and Lake create
  many small files and are poorly matched to a metadata-slow network mount;
- use persistent network storage for sequential compressed snapshots of the
  exact Elan toolchain and project `.lake` cache, written through a temporary
  filename and renamed only after archive validation;
- pin `lean-toolchain`, the checked `lake-manifest.json` digest, and the exact
  source commit/checksum. Every setup, build, and leaf compile must use the
  guarded Make target so the digest is checked. Record the exact Hugo version
  used for workstation QA and use that same release for the cloud gate;
- record cold setup, build, and full-gate timings separately from cached
  incremental timings; and
- treat the cloud `make check` result as the authoritative build evidence. The
  committed source, deterministic artifacts, workstation browser inspection,
  checkpoint, and reproducible cloud gate together define the milestone.

Resolve and terminate only exact obsolete compute resources after a read-only
inventory. Terminate the exact builder after the gate unless the owner has
explicitly approved keeping it active. Preserve the project network volume
unless the owner explicitly requests deletion, and report its continuing
monthly cost. Keep resource identifiers and addresses out of the repository.

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
- `CLOUD_LEAN_BUILD=1 make check` passes on the approved Linux cloud builder;
- applicable workstation static, deterministic-asset, and browser checks pass;
  and
- the milestone is committed and pushed to `main`.
