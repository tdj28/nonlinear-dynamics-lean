# Project Operating Instructions

Read `checkpoint.md` and
`.agents/skills/formalize-nonlinear-dynamics/SKILL.md` before changing the
formalization or its teaching layer. Preserve unrelated work and keep `.env`,
credentials, cloud resource identifiers, and private review artifacts out of
Git and command output.

## Separate the workstation from the build host

The Mac workstation is for source editing, research, Git, checkpoint work,
Hugo authoring, static content checks, browser QA, and genuinely small Lean
tutorials. It is not a full project or Mathlib build host.

- On macOS, never run `lake update`, `lake exe cache get`, `lake build`,
  `lake env lean`, a project `lean` command, or any other operation that can
  repopulate `formalization/.lake/packages/*/.lake/build`.
- Do not run or bypass the guarded `make setup`, `make lean`, `make lean-file`,
  `make check`, or `make lean-clean` targets on macOS. Keep their host guard
  intact.
- Reading the existing Mathlib source with `rg` is allowed. Do not restore or
  compile its local cache.
- Tiny self-contained teaching files that import only Lean core or `Std` may be
  run directly with `lean` on macOS when their memory and disk use are plainly
  bounded. Stop if they begin dependency compilation. Project imports, Mathlib
  imports, proof probes, leaf-module checks, cache restoration, and parallel or
  whole-project builds stay on approved Linux compute.
- Safe workstation targets include `make checkpoint`,
  `make checkpoint-check`, `make workstation-check`, `make site-check`,
  `make blog-serve`, and `make blog-serve-tailscale`. These do not compile
  Lean. A static gate may still fail honestly when a source-only milestone is
  missing its teaching companion.

## Build Lean only on approved Linux cloud compute

Creating or restarting paid cloud compute is always behind an explicit human
approval gate, even when provider credentials are available. Before creation,
state the proposed provider, CPU/RAM/storage, estimated hourly cost, and the
work to be run. Approval is scoped to that resource and task.

On an approved Linux cloud builder:

1. Set `CLOUD_LEAN_BUILD=1` for the guarded Make targets.
2. Attach the preserved project network volume when useful, but use it only
   for sequential, integrity-checked toolchain and Lake-cache archives.
3. Restore and build on the provider's fast ephemeral/local disk. Never use
   the network volume as a live `.lake` tree.
4. Either make a fresh remote clone at the exact approved commit or synchronize
   source only. Never transfer the workstation's `.git`; source-only sync also
   excludes `.env`, `.lake`, `public`, `site/resources/_gen`, credentials, and
   private review files.
5. Pin the repository's `lean-toolchain` and `lake-manifest.json`. Every
   guarded setup, build, and warning-fatal leaf target verifies the committed
   manifest digest; setup checks it both before and after `lake update`. Do not
   bypass these targets with raw Lake commands. Record the exact Hugo version
   used for workstation QA and use that same version for the cloud release
   gate. Run leaf checks with `make lean-file` and the full `make check` gate
   there.
6. Record the source commit/checksum and validation result in `checkpoint.md`.
7. Terminate the exact compute resource after the gate unless the owner has
   explicitly approved keeping it active. Preserve the project network volume
   unless the owner explicitly asks to delete it.

Never weaken SSH host verification, copy broad home-directory credentials, or
touch unrelated cloud resources.

## Treat the teaching layer as an educational product

The public site must teach a motivated newcomer, not merely archive correct
prose beside checked Lean. For every Knowledge Base glossary page and Deep
Dive, follow the complete educational contract in
`site/content/knowledge-base/AGENTS.md`.

- Begin with a small, real, checkable example before climbing into general
  notation or library interfaces.
- Use accessible conceptual SVGs to show the objects, transformation, and
  boundary cases that prose asks the reader to imagine. Decorative figures do
  not satisfy this requirement.
- Whenever a page says **In Lean**, pair the human statement, paper
  mathematics, exact Lean syntax, and a literal repository command the reader
  can type. Explain the important syntax token by token and label the resource
  profile: small standalone tutorials may run on a normal Mac or Linux host;
  exact project/Mathlib checks use the guarded Linux workflow. Do not remove
  useful Lean tutorials merely because this particular workstation avoids
  heavyweight builds.
- Introduce prerequisite vocabulary before use. Recurring foundations such as
  null sets, probability distributions, events, measures, random variables,
  and measurable functions require substantive glossary entries and links,
  not unexplained specialist shorthand.
- Audit the whole connected corpus after changing this contract. Do not repair
  one flagship page while leaving the same teaching gap throughout neighboring
  glossary entries and Deep Dives.

Keep publication and review separate. Owner-authorized public working notes
may use `draft: false` while retaining `pro_reviewed: false`, visible review
status, and honest limitations. Only the configured review process may change
`pro_reviewed` to true.
