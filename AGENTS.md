# Project Operating Instructions

Read `checkpoint.md` and
`.agents/skills/formalize-nonlinear-dynamics/SKILL.md` before changing the
formalization or its teaching layer. Preserve unrelated work and keep `.env`,
credentials, cloud resource identifiers, and private review artifacts out of
Git and command output.

## Separate the workstation from the build host

The Mac workstation is for source editing, research, Git, checkpoint work,
Hugo authoring, static content checks, and browser QA. It is not a Lean or
Mathlib build host.

- On macOS, never run `lake update`, `lake exe cache get`, `lake build`,
  `lake env lean`, a project `lean` command, or any other operation that can
  repopulate `formalization/.lake/packages/*/.lake/build`.
- Do not run or bypass the guarded `make setup`, `make lean`, `make lean-file`,
  `make check`, or `make lean-clean` targets on macOS. Keep their host guard
  intact.
- Reading the existing Mathlib source with `rg` is allowed. Do not restore or
  compile its local cache.
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
