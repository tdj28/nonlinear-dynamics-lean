# Project Checkpoint

> Living handoff for the formalization. Read this first, update it before every
> coherent milestone commit, and push the green milestone to `main`.

Last updated: 2026-08-08

Audited baseline: `main` at `dc96c86`

Active direction: **formalize the discrete logistic map as the first concrete
model.**
Candidate commit `6bf8517` and validation-record commit `b16413e` for
`NonlinearDynamics.Deterministic.Chaos.SymbolicCoding` pass their complete
exact-commit repository gates on the approved Linux builder. The verified
successful cache is preserved on retained storage, the exact task pod is
terminated, and the project network volume remains. The milestone specifies
the one-sided full shift, prefix cylinders, positive-time transitivity, dense
positive-period points, a Devaney consequence, and exact itinerary
semiconjugacy/factor gates. Its four paired teaching pages remain private
drafts with `pro_reviewed: false`. The covered module names include
`NonlinearDynamics.Deterministic.Discrete.Attraction`,
`NonlinearDynamics.Deterministic.Discrete.Bifurcation`, and
`NonlinearDynamics.Deterministic.Chaos.Devaney`, and
`NonlinearDynamics.Deterministic.Chaos.SymbolicCoding`.

The source-and-teaching milestone for
`NonlinearDynamics.Deterministic.ODE.GlobalExistence` packages the exact
continuation interface supplied by pinned Mathlib: global curves, unique
global curves, arbitrarily long local curves at one point, and one uniform
positive local-time radius through every point. Candidate commit `9f8b251` and
validation-record commit `597ba49` pass their exact-commit full repository
gates. The verified successful cache is preserved, the exact task pod is
terminated, and the project network volume remains. Desktop and literal
390-by-844 rendered QA now pass alongside every static, formal, and cloud
gate, so the GlobalExistence milestone is complete.

`NonlinearDynamics.Deterministic.ODE.Stability` is also complete. Closure
commit `33d6b6f` and validation-record commit `82a474b` pass their exact-commit
full repository gates on the approved Linux builder. The verified Stability
cache is preserved on retained storage, the exact task pod is terminated, and
the project network volume remains.

`NonlinearDynamics.Deterministic.ODE.Lyapunov` is complete at closure commit
`30172c7`. Its warning-fatal leaf, deterministic aggregator, exact-commit full
gate, paired teaching bundle, browser QA, and verified cache preservation all
pass. The exact task pod is terminated and the retained project volume
remains. The next dependency-ordered source slice is
`NonlinearDynamics.Deterministic.Models.LogisticMap`.

On 2026-08-08 the Pages production render exposed two public Stability-page
references to the still-private `flow` glossary bundle. Draft-inclusive Hugo
validation had resolved that target and therefore did not expose the broken
publication graph. The repair keeps the ToFlow teaching bundle private,
removes the two public-to-draft references, and makes the production-only
render a prerequisite of `make site-check` before the draft-inclusive render.
`make workstation-check` now passes both graphs (493 production pages and 553
pages with drafts), and the exact minified Pages build passes with Hugo
Extended 0.160.1. No Lean, Lake, Mathlib, cache, or cloud command was run for
this publication repair.

## Mathematical Editorial Register Audit

On 2026-07-23 the owner identified a representative epistemic overclaim in the
Almost Everywhere glossary chapter: “The interval example proves that the
reverse arrow is invalid.” The corrected sentence is exactly: “The interval
example shows why the reverse arrow is invalid.”

That correction triggered an adversarial review of all 150 tracked Markdown
documents:

- 137 public article bundles: 62 glossary chapters, 36 Deep Dives, and 39
  Development Notebook entries;
- all five public section indexes and `README.md`; and
- the project skill, three `AGENTS.md` guides, `checkpoint.md`, and the two
  Hugo archetypes.

The review distinguishes logical roles throughout the corpus. Ordinary
computations check arithmetic or selected finite cases; a verified exhaustive
computation may establish a finite proposition when its coverage and trust
boundary are explicit. Examples illustrate or exhibit behavior; explicit
counterexamples refute stated universal claims; concrete witnesses may
establish existence; and proofs or complete arguments establish general
results. Figures organize or explain an argument rather than replacing it.
Lean's elaborator constructs a candidate proof term and its kernel checks that
term against the formal type; neither step establishes that the type matches
the intended informal mathematics or physical interpretation.

All 62 glossary chapters received a complete register pass followed by an
independent adversarial review. All 36 Deep Dives and all 39 Notebook entries
received corpus-wide passes, with independent adversarial reviews added before
release. The edits remove repeated moralizing proxies, canned transitions,
anthropomorphic compiler language, generic hype, and dismissive shortcuts while
retaining standard terms such as “simple function” and “trivial sigma algebra.”
The established trail, camp, ridge, climb, summit, and expedition vocabulary
remains the site's intentional reader-navigation system; it does not carry
evidentiary force.

The article corpus now contains 747,119 body tokens by the checkpoint's
deterministic counter: 259,260 in the Notebook, 308,544 in the Deep Dives, and
179,315 in the glossary. No `draft` or `pro_reviewed` value changed. The
publication remains open work in progress with every article still marked
`pro_reviewed: false`.

The project skill and all three `AGENTS.md` guides now require an expert
mathematical register and an explicit adversarial prose pass. The teaching
source checker scans `README.md` plus 142 public-content Markdown files,
including reader-facing front matter and shortcode captions. Its narrow
regression gate rejects generic proof-level force attributed to examples,
models, worksheets, plates, visuals, probes, outputs, commands, experiments,
or compiler activity while preserving explicitly stated existential,
consistency, and counterexample roles.

Workstation-safe validation for this wording-only milestone:

- `make content-hygiene-test`: seven test methods pass, including the expanded
  register fixtures;
- `make content-hygiene`: 143 teaching Markdown files and 683 public source
  files pass the source and reader-infrastructure checks;
- `make site-check`: Hugo Extended 0.160.1 renders 415 pages warning-fatal;
- `make checkpoint-check`: checkpoint and substantive-module inventory pass;
  and
- `git diff --check`: clean.

No Lean, Lake, Mathlib, cache, or cloud command was run for this editorial
milestone. The macOS build-host policy remains unchanged. The project stays
paused for the owner's reading and site-sculpting phase; the exact RMT-35
release sequence below remains the next formalization milestone after the
owner resumes it.

## Probability-Zero Semantics Follow-Up

On 2026-07-23 the owner rejected the sentence “the uniform experiment can
produce the value \(1/2\), yet the event \(\{1/2\}\) has probability zero.”
The objection is mathematically substantive: “can produce” conflates
set-theoretic membership, range membership for a particular sample map,
topological support, positive mass in every neighborhood, and positive mass
for the singleton event.

The Almost Everywhere chapter now uses the canonical realization
\(\Omega=[0,1]\), \(X(\omega)=\omega\). It states separately that the fiber at
\(1/2\) is nonempty, that its probability is zero, and that every
positive-radius neighborhood has positive probability. It also explains
countable additivity: the interval is an uncountable union of null
singletons, so the countable-union theorem does not assign the interval mass
zero. A second sample map, obtained by changing the identity only at
\(\omega=1/2\), has the same uniform law while omitting \(1/2\) from its exact
range. Thus a law determines the singleton's mass but not whether a particular
null fiber is empty.

A focused scan of all public Markdown repaired the same level-confusion in the
Null Set, Event, Expectation, Random Variable, Probability Law, Empirical
Spectral Law, Hermitian Matrix, and Independence glossary chapters; six
probability and random-matrix Deep Dives; and the law-construction Notebook
chapter. The
Gaussian data example now labels its exact rows as hypothetical, and
law-support prose no longer identifies a full-mass locus with a sample map's
pointwise range.

The project skill and Knowledge Base guides now require probability prose to
name the exact level rather than say that a null outcome “can occur,” “can
happen,” or “can be produced.” The teaching-source checker has a deliberately
literal `ambiguous-uniform-experiment` regression for the original
high-signal construction. Independent review rejected a broader modal regex
because it produced both false positives and false negatives; contextual
probability semantics remain part of the required human adversarial pass.

Workstation-safe validation for this prose-only correction:

- seven teaching-hygiene test methods, including precise and rejected
  probability-language fixtures, pass;
- 143 teaching Markdown files and 683 public source files pass the source and
  reader-infrastructure checks;
- twenty-three coverage regression tests and `make checkpoint-check` pass;
- Hugo Extended 0.160.1 renders 415 pages warning-fatal;
- the Almost Everywhere and Null Set cards reproduce byte-for-byte;
- rendered Almost Everywhere checks at 1440x1000 and 390x844 show one heading,
  no page overflow, no broken or alt-less images, no KaTeX errors or raw
  delimiters, and no console warnings or errors; and
- `git diff --check` is clean.

No Lean, Lake, Mathlib, cache, or cloud command was run. The formalization
pause and workstation build-host policy are unchanged.

## Durable Build-Host Policy

Effective 2026-07-22, the Mac workstation is no longer a full project or
Mathlib build host. It may run genuinely small standalone Lean tutorials that
import only Lean core or `Std`; this is a permanent resource boundary, not a
ban on teaching readers how to run Lean.

- Keep the Mac for research, source editing, Git, checkpoint/static validation,
  Hugo authoring, deterministic asset work, browser QA, and small bounded Lean
  tutorials. Reading the pinned Mathlib source with `rg` is allowed.
- Never run a project `lean` command, `lake update`, `lake exe cache get`,
  `lake build`, `lake env lean`, or any command that can restore or regenerate
  `formalization/.lake/packages/*/.lake/build` on macOS.
- A self-contained tutorial file may run directly with `lean` when it imports
  only Lean core or `Std` and plainly cannot trigger project or dependency
  compilation. Exact Mathlib-backed examples and project modules remain cloud
  checks. Deep Dives should teach both levels and label their resource needs.
- The guarded `make setup`, `make lean`, `make lean-file`, `make lean-clean`,
  and `make check` targets reject macOS. They run only on Linux with the
  explicit `CLOUD_LEAN_BUILD=1` acknowledgement. Do not bypass the guard.
- Run non-Lean gates locally with `make workstation-check` or their individual
  checkpoint, content, Hugo, and browser commands. An expected coverage
  failure during the paused RMT-35 source-only state must remain visible.
- Every future Lean probe, dependency setup, warning-fatal compile, and full
  gate runs on freshly human-approved Linux cloud compute. State the proposed
  specifications and cost before creation. Credentials alone are not approval.
- Attach the preserved project network volume when useful, restore its
  integrity-checked snapshots onto fast ephemeral/local builder storage, and
  never use the volume as a live `.lake` tree. Source synchronization excludes
  `.env`, `.git`, `.lake`, generated Hugo output, credentials, and private
  review files; a fresh remote clone at the exact commit may create its own
  clean Git metadata, but the workstation's `.git` is never transferred.
- Every guarded cloud setup, build, and warning-fatal leaf compile verifies the
  committed `lake-manifest.json` SHA-256; setup checks before and after
  `lake update`. Raw Lake commands are not release paths, and dependency drift
  is a separate reviewed milestone. Record the workstation Hugo version and
  match it on the cloud gate.
- Record the exact source revision and cloud validation result, then terminate
  the exact compute resource unless the owner explicitly approves retaining
  it. Preserve the network volume unless the owner explicitly requests its
  deletion. Keep addresses and resource identifiers out of the repository.

Historical local build results below remain valid evidence for their recorded
commits. They are not instructions for future work.

## Public Reader / Maintainer Infrastructure Boundary

The owner corrected a public-teaching mistake on 2026-07-22: instructions such
as “put the worksheet in the approved Linux environment” describe this
project's maintainer operations, not mathematics or a reader workflow. They
must never appear in the README, rendered Notebook or Knowledge Base prose,
shared layouts, page-owned text assets, or mounted Lean source.

- Public instructions now distinguish a **standalone tutorial** that imports
  only Lean core or `Std` from a **full project check** that uses the pinned
  Lean and Mathlib dependencies and may require substantial disk space or build
  time. Both use portable macOS/Linux commands.
- The shared `repo-check` component uses `cd formalization` followed by
  `lake env lean <module-file>`. Reader prose must not name RunPod, approval
  gates, the owner's machine, private networking, retained caches,
  contributor-only Make targets, or internal release operations.
- `scripts/check_public_reader_language.py` enforces that separation across
  `README.md`, every Hugo source surface, and the mounted public Lean tree.
  Its regression tests include the original offending sentence and indirect
  variants. `make content-hygiene` and the GitHub Pages workflow run the gate.
- The actual maintainer build-host policy remains mandatory but belongs only in
  `AGENTS.md`, the project skill, and this checkpoint.

## GitHub Pages Publication Policy

- `.github/workflows/pages.yml` is the public-site release path. A relevant
  push to `main` installs pinned Hugo Extended 0.160.1, runs only
  workstation-safe checkpoint/content/Hugo checks, builds with the Pages
  action's repository-aware base URL, and deploys through the `github-pages`
  environment. It never invokes Lean, Lake, Mathlib, or paid cloud compute.
- `canonifyURLs: true` is required because the project is served beneath
  `/nonlinear-dynamics-lean/`, while the layouts contain root-relative
  navigation. Production validation must scan rendered HTML for any remaining
  single-slash-rooted `href` or `src` attributes.
- The workflow is deliberately production-only: it does not pass
  `--buildDrafts`. The owner explicitly authorized open publication on
  2026-07-22, so all 137 existing content pages now opt in with `draft: false`:
  39 Development Notebook entries, 36 Deep Dives, and 62 glossary chapters.
  The production and draft-inclusive renders both contain 415 pages.
- Publication exposes work in progress; it does not manufacture review. All
  137 pages retain `pro_reviewed: false`, and the Notebook entries retain their
  visible pending-review status language. The site-wide
  `open_working_notes` publication mode adds an **Open working note** badge to
  articles and collection cards without rendering the private review metadata.
  Legacy body text that said a page had to remain draft-gated now describes the
  owner-authorized public working-note state while preserving every pending
  human, editorial, scientific-integrity, accessibility, and Pro review.
  Future pages remain draft-gated by default until the owner explicitly chooses
  private incubation or open working publication.
- The coverage checker is publication-neutral: mapped Notebook pages must
  declare explicit unquoted boolean `draft` and `pro_reviewed` states, but the
  checker does not force either value. Publication status and review completion
  are separate axes.
- Open publication makes existing teaching debt visible. RMT-29's Notebook and
  Deep Dive remain semantically stale after the lower-bounded upper-limsup
  generalization; RMT-34's Notebook, Deep Dive, and integrable-tail glossary
  still contain future-tense handoff language; and RMT-35 has no teaching bundle
  yet even though its Lean source is mounted publicly. The formalization pause
  and the repair plan below remain in force.
- Hugo mounts checked `.lean` files from
  `formalization/NonlinearDynamics/` into the public artifact. Those source
  files are therefore public regardless of paired-article publication state.
  Secrets, `.env`, Git metadata, build caches, cloud identifiers, and private
  review material remain outside both mounted publication roots.
- The repository owner must select **Settings → Pages → Build and deployment →
  Source → GitHub Actions** once. The expected URL is
  `https://tdj28.github.io/nonlinear-dynamics-lean/`. GitHub Pages is public,
  including when the source repository itself is private. If this milestone's
  push runs before enablement, rerun its failed workflow or use its manual
  dispatch after selecting the Pages source.

## Active Educational Rebuild

The owner reviewed the published “Almost everywhere” glossary page on
2026-07-22 and correctly identified a corpus-wide teaching gap. Correct prose
and isolated Lean identifiers are not enough. Every glossary entry and Deep
Dive must now climb through a concrete checkable example, a concept-specific
accessible SVG, human language, paper mathematics, exact Lean syntax, a syntax
map, and commands that show a reader how to try it. Foundational vocabulary
must be introduced before advanced probability and ergodic arguments use it.

The first complete structural audit found:

- **52 glossary entries.** The two half-corpus audits found no page with a
  complete file-plus-command workflow. Forty-two entries have a concept SVG,
  but ten do not; five have no worked example and six more have only a partial
  one; only twenty-seven have a strong direct paper-to-Lean bridge. The
  highest-priority vocabulary
  gaps are null set, measure/probability measure, event, random variable,
  measurable function, expectation, and integrability. The existing
  `probability-law` route should teach the synonymous title “Probability
  distribution (law)” instead of creating a duplicate page.
- **36 Deep Dives, 41,491 Markdown lines, and 90 referenced conceptual SVGs.**
  No chapter opens with a complete checkable example before abstraction, and
  no chapter has the full human/paper/Lean/file/command ladder. Ten have no
  fenced Lean snippet. Nineteen have only one figure and
  `random-matrices-from-outcomes-to-spectra` has none. Existing commands need
  resource labels: small standalone tutorials may run locally, while exact
  project/Mathlib checks use a provisioned Linux host and the guarded Make
  target.

Repository and Knowledge Base `AGENTS.md` now encode this educational contract.
Shared `lean-bridge` and `repo-check` shortcodes provide the visual translation
and reproducible-command rhythm without replacing page-specific explanations.
The first exemplar wave upgrades “Almost everywhere,” retitles and rebuilds
“Probability distribution (law),” and adds the missing “Null set” foundation.
All remain public working notes with `pro_reviewed: false`. The example-first
glossary **content** pass is complete; a reproducibility/tutorial cleanup
remains active, and the Deep Dive textbook pass has begun in parallel. Continue
to validate and push small coherent batches, and do not resume RMT-35
formalization while this reader-catch-up phase is active.

The current wave brings **all 62 glossary chapters** through the full
example-first rebuild. The final three chapters make uniform integrability,
phase averaging, and ordered interval packing finite and executable. They
compare tame and concentrating spike tails at thresholds `2, 4, 8, 16`;
reindex four phase rows with sums `15, 18, 21, 24` into the consecutive
total `78` while protecting the positive time-zero boundary; and contrast a
valid half-open packing with length/union ledger `(6, 6)` against an
overlapping near-miss `(7, 6)`. Each page has exact human/paper/Lean bridges,
a numeric accessible SVG that is also its reproducible card, and a `Std`
worksheet executed with Lean 4.32.0 on the Mac. This is intentional teaching
use of local Lean; project imports, Mathlib work, dependency builds, caches,
and large proof checks remain on freshly approved Linux cloud compute.

A read-only contract audit of the first 59 completed pages found no missing
computed example, boundary case, reference figure, accessible alt/caption,
human/paper/Lean bridge, token map, repository check, module target, or public
review marker. Its reproducibility audit originally found one SVG without
explicit dimensions, twenty early pages without page-owned card generators,
fifteen existing card generators whose `--verify` comparison was stale, and
seventeen early foundational pages without a tiny local `Std` tutorial.
The first cleanup wave fixes the SVG dimensions, adds and verifies six
worked-SVG card generators, and executes five new foundational tutorials. The
second cleanup wave adds six more deterministic worked-SVG generators and
executes the exact `Std` tutorials for expectation, integrability, measurable
functions, measurable spaces, measure-preserving transformations, and
pushforward measures. The third cleanup wave supplies the final eight missing
worked-SVG generators and executes the remaining six local tutorials for
conjugate transpose, matrix trace, orbit iteration, random matrices, random
variables, and null sets. The orbit worksheet deliberately defines its own
finite recursion because Mathlib's iterate notation is not part of `Std`.
There are therefore no missing page-owned generators and no missing bounded
tutorials. The final asset-provenance wave replaces all fifteen stale generic
generators with deterministic exports of each page's exact worked SVG. A live
62-page audit now reports 62 executable generators, 62 successful `--verify`
comparisons, and 62 pinned `Std` tutorial routes. The final wording audit reruns
the five residual hypothetical-output pages: Weyl's ordered eigenvalue budget,
the invariant sigma algebra, the finite maximal inequality, the finite
ergodicity models, and the two-point trace moment. All execute successfully
with Lean 4.32.0; the only textual correction is Lean's exact rational rendering
`(5 : Rat)/2`. With their verbatim output recorded, the **62-page glossary
rebuild and reproducibility cleanup is complete**. Future semantic corrections
and human review remain welcome, but no item from this corpus audit remains
open.
The separate stale “worksheet not run” finding is also cleared: the exact
parity/Fekete `Std` file runs under Lean 4.32.0 and prints the seven recorded
ratios followed by `true` and `true`.

The Deep Dive textbook pass is now **36 of 36 chapters complete**. *Finite
Hermitian Matrices from Coordinates* carries the exact ledger
`(2, -1, 1, 2)` through conjugate reconstruction, the copied-sign
near-miss, the `n²` degree count, Frobenius squares `15` and `20`, and
cross inner product `-1`. It has three complementary accessible figures,
four human/paper/Lean bridges, a token map at each bridge, a cloud-only
project check, and a local `Std` tutorial executed successfully under Lean
4.32.0 with outputs `[true, true, false]` and `[10, 15, -1, 20]`. *Random
Matrices: From Outcomes to Spectra* now follows one fair red/blue experiment
from source events through two exact matrices, checked eigenpairs, empirical
spectral measures, the outer law on measures, and their distinct mean measure.
Its nilpotent boundary shows why equal spectra need not mean equal operators;
two accessible numeric figures and six human/paper/Lean bridges expose every
typed gate. Its `Std` worksheet was executed locally under Lean 4.32.0 and
prints the two entry ledgers, spectra, four successful eigenpair certificates,
the exact preimage `["red"]`, and the four quarter-mass atoms. The page-owned
card now derives deterministically from that exact worked figure, while both
Mathlib/project probes remain clearly cloud-only. *Complex Gaussian
Coordinates and Geometry* carries the exact law ledger with mean `1 - 2i` and
component variances `(4, 1)` through centered/full squared-modulus moments
`5/10`, real scaling by `-2` to variances `(16, 4)` and moments `20/40`, and
pseudocovariance. A copied-coordinate Gaussian near-miss separates equal
marginals from independence; the variance atlas includes planar, line, and
Dirac branches; and the prose separates Cartesian, proper, and circular claims.
Its three accessible figures, seven Lean bridges, and two guarded project
checks are paired with a local `Std` ledger executed under Lean 4.32.0. The
page-owned card reproduces its primary numeric figure byte for byte.
*Gaussian Laws, Independence, and Normalization* now separates an abstract
source outcome, the three-coordinate sample map, one realization, three data
rows, and the exact product law before introducing Gaussian abstraction. Its
rectangle event has probability `1/4`; its scaling ledger distinguishes
variance from standard deviation; and a four-row parity model is a
counterexample to the claim that pairwise checks imply mutual independence.
Six Lean bridges, three
numeric figures, a locally executed `Std` worksheet, and a guarded exact-module
check make every layer reproducible. An adversarial review corrected a
source/realization conflation, figure overflow, missing disclosure metadata,
and an unreadably small first card design. The same metadata audit restored
the canonical AI disclosure on the completed random-matrices chapter.
*Finite Product Probability Spaces and Independent Gaussian Fields* begins
with all four fair-bit outcomes and computes the marginal masses, cylinder
preimages, full joint table, and product law cell by cell. Matching-marginal
and parity counterexamples separate dependence, pairwise independence, and
mutual independence before the chapter climbs to finite complex Gaussian
fields, canonical product measures, evaluation maps, ordinary versus
almost-everywhere measurability, and the empty-index Dirac boundary. Two
numeric figures, six Lean bridges, a guarded project probe, and a second locally
executed `Std` enumeration make the path reproducible without running Mathlib
on the workstation.
*Intrinsic Hermitian Gaussian Symmetry and Matrix-Law Support* now follows the
exact matrix with rows `(1, 1 + 2i)` and `(1 - 2i, 3)` through swap congruence,
preserving trace `4` and Frobenius square `20` while visibly changing the
point. A Dirac law and a balanced two-point law then separate Hermitian support
from invariance under that swap. Three accessible figures, six Lean bridges,
and an executed `Std` worksheet expose the geometry and measure layers. The
chapter preserves the historical RMT-07 boundary while explicitly identifying
the comparison subsequently checked in RMT-08; its deterministic page-owned
card reproduces the exact congruence ledger.
*From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble
Invariance* now starts with four variance-`1/2` real slots, decodes the upper
pair by `1/sqrt(2)`, and closes the coordinate/Frobenius square ledger at `15`.
Swap and phase congruences visibly move the same matrix while preserving its
geometry; a wrong decoder yields `25`. The chapter then climbs through the
complete product law, real isometry, scaled intrinsic Gaussian, ambient
inclusion, and final law-level invariance without importing a density or
spectral claim. Six Lean bridges, two accessible numeric figures, all 35 RMT-08
declarations, and a nine-example local `Std` worksheet make the route
reproducible; exact project checks remain Linux-cloud only.
*Finite GUE from Independent Gaussian Coordinates* now builds the selected
matrix law from the exact size-two variance ledger `(1/2, 1/2, 1/4, 1/4)`.
The deterministic point `(2, -1, 1, 2)` gives a Hermitian matrix with trace
`1` and Frobenius ledger `4 + 5 + 5 + 1 = 15`, while the law-level expected
budget is `2`. Wrong reflection and unscaled-variance near-misses expose the
assembly and normalization obligations; the zero-dimensional route ends at a
Dirac law. Three accessible figures, six Lean bridges, three guarded project
checks, and a locally executed `Std` worksheet distinguish primitive
independence, reflected dependence, deterministic assembly, and pushforward
law. An independent adversarial review corrected module-boundary language and
replaced topological-support shorthand with the exact Hermitian-set mass-one
claim.
*First Exact Finite Gaussian Unitary Ensemble Trace Moments* now starts by
separating the deterministic sample values `(1, 15)` from the ensemble
expectations `(0, 2)`. Its wrong decoder, wrong observable, and wrong
probability level produce the deliberately different values `3`, `1`, and
`15`. The general climb adds the Bochner-integrability licenses, normalized
product pushforward, Hermitian/Frobenius identity, exact `n² · (1/n) = n`
ledger, and dimension-zero branch without invoking eigenvalues, density, or
asymptotics. Three figures, six Lean bridges, two guarded project probes, a
complete four-declaration RMT-09 map, and a nine-example local `Std` worksheet
make every finite arithmetic layer reproducible.
*Finite Hermitian Spectra and Empirical Measures* now diagonalizes the exact
matrix with rows `(2, 1)` and `(1, 2)`, certifies eigenpairs at `3` and `1`,
and places counting masses `(1, 1)` and empirical masses `(1/2, 1/2)` atom by
atom. The isospectral diagonal matrix `diag(3, 1)` shows precisely which basis
and entry information the spectrum forgets. A five-level type ladder then
separates ordered spectra, sample measures, measure-valued observables, laws on
measures, and their Giry mean. Three accessible figures, seven Lean bridges,
three guarded RMT-10A/B/C probes, and an executed `Std` eigenpair/atom ledger
make the current conditional-versus-unconditional measurability boundary
explicit, including the zero-dimensional inner-zero/outer-Dirac distinction.
*Finite GUE Empirical Spectral Laws and Normalized Moments* now begins with a
fair two-matrix teaching law and computes both sample measures, their outer law
on measures, the joined mean with masses `(1/4, 1/2, 1/4)`, and normalized
moment ledgers `[1, -1, 0]` and `[2, 2, 2, 2]`. The page keeps that toy source
separate from the positive-dimensional finite-GUE expectation `1`, and it
distinguishes same-valued mass questions on different carriers. Six Lean
bridges, two guarded RMT-10B/C probes, two accessible figures, a 16-example
local `Std` worksheet, and the zero-dimensional inner-mass-`0`/outer-mass-`1`
boundary expose every type change. The chapter explicitly records that the
project has not yet transported unbounded spectral moments through Giry join
and makes no asymptotic or semicircle claim.
*Ordered Finite Matrix Products and Operator-Norm Growth* now follows the
noncommuting shear/stretch history through the chronological product
`A₁ A₀ = [[1,1],[0,2]]` and the reversed product
`A₀ A₁ = [[1,2],[0,2]]`. Their induced-infinity norms `2` and `3`, the factor
budget `4`, and orbit outputs `(2,2)` and `(3,2)` make order visible. A second
near-miss distinguishes the correct two-update diagnostic `(log 2)/2` from
last-index division and any Lyapunov exponent. Two figures, seven Lean
bridges, primary/successor cloud probes, a complete thirteen-declaration API
map, and an executed `Std` worksheet separate deterministic finite algebra,
positive-dimensional norm bounds, measurable random products, and asymptotic
growth.
*Hermitian Spectral Perturbation, Continuity, and Measurability* now compares
`diag(3,-1)` with `diag(5/2,-3/4)`: ordered shifts `1/2` and `1/4` fit inside
the exact Frobenius-square budget `5/16`. Reversing one eigenvalue list breaks
rank matching, while the non-Hermitian family
`[[0,1],[ε,0]]` has matrix motion `ε`, eigenvalue motion `sqrt(ε)`, and an
unbounded ratio along that real-spectrum family. Seven Lean bridges and three
figures climb from the deterministic bound through sup-metric Lipschitzness,
continuity, Giry measurability, and a separately typed GUE pushforward
equality. A nine-example `Std` worksheet, five guarded project checks, and a
fourteen-declaration API map make the boundaries reproducible. Independent
adversarial review corrected a signed-entry card error, narrowed the Jordan
claim, and separated measurable sample maps from outer laws before release.
*Generator-Presented One-Sided Discrete Matrix Cocycles* now follows the
noninvertible base `start → middle → sink → sink` and one generator assigning
the exact matrices `D`, `S`, and `L`. Horizon ledgers at both `start` and the
shifted state `middle` make the later-block-left identity
`Φ(m+k,ω)=Φ(k,T^mω)Φ(m,ω)` concrete; the omitted-shift value `D²` and reversed
product `DS` expose the two independent failure modes. Two accessible numeric
figures, six human/paper/Lean bridges, a complete sixteen-declaration map, and
an executed `Std` worksheet separate finite semiring algebra, complex
measurability, measure preservation, and every still-absent probability,
two-sided, norm-growth, and Lyapunov layer. Exact Mathlib/project checks remain
guarded Linux-cloud commands, while the small arithmetic worksheet is the
intended local Mac/Linux learning path.
*Measurable Finite Random-Matrix Products and Proof-Carrying Pushforward Laws*
now lets one fair red/blue outcome choose one complete two-factor history. The
two chronological products `[[2,2],[0,1]]` and `[[1,0],[3,3]]`, their distinct
reverse-order products, the preimage `{red}`, and two masses `1/2` construct
the law atom by atom. An executable horizon-zero collision merges both source
outcomes into one identity atom of mass `1`; event masses
`(1/2,1/2,1/2)` versus product `1/4` prove dependence; and a swapped map
separates pointwise equality from equality in law. Three accessible figures,
seven Lean bridges, five guarded project probes, the complete twelve-name API,
and an executed `Std` worksheet make prefix measurability, Mathlib's map
fallback, raw laws, mass-one evidence, and bundled probability laws distinct.
The small finite ledger is intentionally local; all exact Mathlib/project
checks remain on approved Linux cloud compute.
*Finite-Time Norm and Extended-Log-Norm Observables for Matrix Cocycles* now
follows two horizon-two paths through the same row-sum norm interface. The
positive path has product `[[1,1],[0,2]]`, norm `2`, and factor budget `4`;
two nonzero projection factors on the collapse path multiply to zero, giving
norm `0` under budget `1`. A second exact ledger separates the real
log-positive envelope from the `EReal` extended logarithm at norms `2`, `1`,
`1/2`, and `0`, then normalizes retained information by the actual two-factor
horizon. Three accessible figures, seven Lean bridges, three guarded project
checks, the complete fourteen-declaration API, and an independently audited
local `Std` worksheet expose the ordinary-measurability, zero-divisor,
positive/empty-dimension, and zero-safe subadditivity boundaries without
claiming integrability or an asymptotic exponent. The tutorial's partial
zero-horizon result `none` is explicitly distinguished from the later
project's totalized normalized process; exact Mathlib checks remain cloud-only.
*Integrated Log-Positive Cocycle Growth and Its Deterministic Fekete Limit*
now follows a uniform amber/blue swap with scalar generators `[2]` and `[1]`.
Its two sample rows integrate to the exact scalar sequence
`Iₖ=(k/2) log 2`, whose positive-time normalization is constantly
`(1/2) log 2`; the formal Lean value `A₀=0` visibly gives the wrong infimum
if zero time is admitted. A separate candidate with
`J₁=(1/2) log 2` and `J₂=(3/2) log 2` fails subadditivity at `1+1` before any
Fekete argument can begin. Two accessible figures, six Lean bridges, the
complete thirteen-declaration map, and an executed `Std` worksheet expose the
totalized-integral, integrability, preservation, subadditivity, and
positive-index boundaries. The chapter repeatedly distinguishes convergence
of one deterministic sequence of integrals from any pointwise or
almost-everywhere sample limit, Kingman theorem, or Lyapunov exponent; its
exact Mathlib/project check remains Linux-cloud only.
*Probability Normalization and Ergodic Rigidity Before Kingman* now begins on
`Ω={a,b}` with the observable values `(0,2)`. Uniform probability weights
produce total mass `1` and integral `1`, while raw counting weights produce
mass `2` and integral `2`; the separate normalization `2/2=1` makes clear that
the Lean expectation alias does not perform hidden rescaling. A uniform swap,
uniform identity, and raw-mass swap then isolate ergodicity from probability:
the identity admits a singleton invariant event of mass `1/2` and a
nonconstant invariant observable, while the raw swap retains invariant
rigidity but has full-event mass `2`. Three accessible figures, seven Lean
bridges, two guarded module probes, the exact ten-declaration map, and an
executed `Std` worksheet make those assumptions executable. An oscillating
two-row example explicitly blocks the false inference from convergence of
integrated scalars to samplewise convergence, preserving the RMT-17 boundary
even while the chapter notes the later project-local RMT-32 endpoint.
*Finite-Horizon Log-Positive Cocycle Integrability* now follows a uniform
four-state cycle with scalar generator norms `1/2`, `2`, `1/4`, and `4`.
Its horizon-two ledger computes the exact positive-log values `(0,0,0,1)` and
the orbit budgets `(1,1,2,2)`, proving pointwise domination before averaging;
at horizon four the product logarithm cancels to zero while every orbit budget
equals `3`. A raw measure with mass `2` per state then separates finite
integrability from expectation language. The genuine countable near miss uses
mass `2⁻ⁿ⁻¹` and generator norm `exp(2ⁿ)`, so every weighted positive-log term
is `1/2` and the integral diverges despite probability normalization and
measurability. Two accessible numeric figures, seven Lean bridges, the exact
sixteen-declaration map, and an executed `Std` worksheet make the finite-tail
hypothesis and its one-sided sign boundary concrete. The worksheet is the
intended lightweight local exercise; all Mathlib-backed module checks remain
guarded Linux-cloud work.
*Finite Block Decomposition for Subadditive Processes* now cuts the same
eleven exact weights in both valid temporal orientations: blocks first gives
`12+18+10=40`, while remainder first gives `8+15+17=40`. Moving the short
piece without moving its sample point yields the explicit false proposal
`40≤38`. A constant-five process isolates the zero-count exact-block boundary,
and block length zero exposes Lean's totalized quotient/remainder convention
without adding a positivity assumption. Two accessible numeric figures,
seven Lean bridges, the complete twelve-public-declaration and three-private-
helper map, and a byte-identical executed `Std` worksheet separate pointwise
finite algebra from the additional preservation needed for finite-sum
integrability. Probability, ergodicity, independence, uniform-time control,
and convergence remain explicit nonclaims; all Mathlib/project checks remain
guarded Linux-cloud work.
*Orbit-Majorant Centering for Subadditive Processes* now follows a uniform
three-state cycle with one-step values `(9,1,2)`. The process
`Xₙ=Sₙ-n(n-1)` has horizon-three majorant `S₃=12`, process value `X₃=6`, and
centered residual `Y₃=-6` at every state. Splitting `3=1+2` at state two makes
the correct later start and bound `6≤8+2`; shifting by the later length instead
produces the explicit false inequality `6≤1+2`. Expectation centering,
reversed subtraction, unshifted repeated subtraction, and a nonnormalized
constant-one time-zero process expose four distinct nearby operations. Two
accessible numeric figures, seven Lean bridges, all eighteen public
declarations plus two private helpers, and a byte-identical executed `Std`
worksheet separate finite nonpositive slack from expectation-zero,
probability, ergodicity, and convergence claims. Exact Mathlib/project checks
remain guarded Linux-cloud work.
*Finite Phase Averaging for Nonpositive Subadditive Processes* now starts from
the ten exact weights `(-1,-2,-1,-3,-1,-2,-4,-1,-1,-2)` with block length
three. Its three residue rows have block totals `-10`, `-13`, and `-12`, so
the sliding-block total is `-35`; explicit prefix–middle–tail triples
`(0,-10,-8)`, `(-1,-13,-4)`, and `(-3,-12,-3)` each reconstruct the full
value `X₁₀=-18`. This makes the finite bound `-18≤-35/3` visible before the
general proof. The additive positive process `Yₙ=n` shows why dropping a
positive tail would falsely claim `10≤6`, while omitting the theorem's extra
full block accounts for only seven of ten time steps. Two accessible numeric
figures, seven Lean bridges, eight public declarations, four proof helpers and
three source-level boundary witnesses, two guarded project probes, and a
byte-identical executed `Std` worksheet keep finite phase arithmetic separate
from measure preservation, probability, ergodicity, and convergence.
*Finite Ordered Interval Packing for Nonpositive Subadditive Processes* now
opens with an ordered family whose length-sum/union ledger is `[6,6]` and an
overlapping near miss with `[7,6]`. Its larger leftmost-greedy example begins
from marks `{1,2,4,5,8,9}`, selects starts `1,4,8`, and decodes the disjoint
intervals `[1,4)`, `[4,6)`, `[8,12)` as gap–length–tail data
`[1,3,0,2,2,4,2]` inside the enlarged horizon `14`. Coverage separates the
three selected starts from nine covered positions, and coefficient `-2`
turns `6≤9` into `-18≤-12`; positive coefficient, empty strict sum, and
time-zero process examples fail exactly where the theorem says they should.
Two accessible numeric figures, seven shortcode Lean bridges, one guarded
project probe, a complete manifest of 54 public and 13 private declarations,
and a byte-identical executed `Std` worksheet make the finite geometry and
cost bounds runnable without making a density, ergodic, or convergence claim.
*Birkhoff Convergence Events Before the Pointwise Ergodic Theorem* now starts
with the two-state swap whose readings `(0,2)` have averages converging to one
from both starts. Its finite ledger computes every sum, average, absolute
integral, and delete/restore-prefix identity through horizon eight. A separate
bounded decimal-block observable has endpoint one-counts `9,9,909,909` and
subsequential average limits `10/11` and `1/11`, proving that the convergence
event definition alone supplies no membership. Two accessible numeric
figures, seven Lean bridges, a source-order cloud probe, all 37 public
declarations plus the helper and twelve-probe boundary map, and a
byte-identical executed `Std` worksheet separate measurable/null-measurable
event construction and conditional ergodic rigidity from the later theorem
that actually proves almost-everywhere convergence.
*Finite Maximal Ergodic Inequalities: From Orbit Maxima to Threshold Events*
now follows one uniform four-cycle with observable values `(-2,3,-4,2)`.
Although every terminal four-step sum equals `-1`, its running maxima are
`1,3,0,3`, so the strict finite Hopf event is exactly `{a,b,d}`. The atomwise
maximum-minus-shift inequalities `(-2≤-2, 3≤3, -3≤0, 2≤2)` integrate to
`0≤3/4`. At threshold one, only `{b,d}` has a strict positive-time average
crossing, giving `1/2≤5/4`; equality at one is not a witness, threshold zero
cannot be divided through, and the horizon-zero strict/nonstrict events are
empty/full. Two accessible numeric figures, seven Lean bridges, all 25 public
declarations plus the private helper and eleven compiled probes, a guarded
cloud project check, and a byte-identical executed 243-line `Std` worksheet
make the finite maximal argument runnable on an ordinary Mac or Linux machine
without compiling Mathlib or this project.
*From Finite Maximal Bounds to an Infinite Weak Estimate* now follows the
uniform five-cycle with observable values `(5,-4,0,0,-1)` at threshold one.
Its strict events grow as `E₀=∅`, `E₁={0}`, `E₂={0,4}`, and
`E_N={0,3,4}` for every `N≥3`, so the infinite event has mass `3/5` while
the positive-part integral is one. State two reaches the equality `S₄=4`
but never enters the strict event. The zero-sum cycle-remainder proof upgrades
the finite search to a genuine infinite-union calculation, while a counting-
measure example shows exactly why extended-measure continuity cannot simply be
transported through `Measure.real` without finite target mass. Two accessible
numeric figures, six Lean bridges, all ten public declarations and ten probes,
a guarded cloud interface check, and a byte-identical executed `Std` worksheet
separate the laptop learning path from the Mathlib-backed theorem module and
stop explicitly before pointwise convergence.
*Mean Is Not Pointwise: Koopman Geometry, Coboundaries, and the Missing
Maximal Step* now begins with the uniform two-state swap and `f=(1,3)`.
Koopman swaps the coordinates, projection onto the fixed diagonal gives
`P f=(2,2)`, and the residual `(-1,1)` is exactly `(U-I)u` for `u=(0,-1)`.
The first seven operator means are computed explicitly: even positive horizons
equal the projection, odd horizons are `(2-1/n,2+1/n)`, and their `L²` error
is `1/n`. A separate dyadic typewriter sequence has squared norms
`1,1/2,1/4,…` but hits `x=5/8` at indices `1,3,6,13,26,…` with zeros between;
the selected leftmost subsequence converges away from the null singleton
`{0}`. The page explicitly identifies this as a logical diagnostic rather
than a Birkhoff-average counterexample. Two accessible numeric figures, seven
Lean bridges, all twenty public declarations plus two private helpers and the
probe inventory, a guarded cloud project check, and a byte-identical executed
`Std` worksheet show exactly why Hilbert-space mean convergence supplies an
almost-everywhere subsequence but full-sequence convergence still needs
maximal closure.
*Pointwise Birkhoff from Maximal Control and Dense Good Functions* now opens
on a uniform eight-cycle with target `f=2` plus a one-third spike at state
zero, the constant approximant `g₀=2`, and scale `ε=1/4`. At the spike,
`A₁f-A₄f=1/4`; the strict error-maximal event at threshold `1/12` is exactly
`{0,6,7}`, with mass `3/8≤(1/24)/(1/12)=1/2`, while start five touches
equality and is excluded. Dyadic spike approximants `0,1/4,5/16,21/64`
shrink the `L¹` errors through `1/24,1/96,1/384,1/1536` and the closure
bounds through `1/2,1/8,1/32,1/128`; in this finite model the third bound is
already smaller than one atom. The chapter separates that rehearsal from the
true persistent Cauchy event, makes `D₀=Ω` explicit, and then climbs through
the general maximal-closure proof. Two accessible numeric figures, seven Lean
bridges, all 29 public declarations plus seven probes and five axiom queries,
a guarded cloud project check, and a byte-identical executed 258-line `Std`
worksheet make the full-sequence mechanism reproducible without running
Mathlib or the project on the workstation.
*Birkhoff Limits, Invariant Sigma Algebras, and Conditional Expectation* now
uses a four-state probability space with weights `(2/5,2/5,1/10,1/10)`, two
swapped invariant sectors, and observable values `(1,7,-3,5)`. The first six
averages converge sectorwise to four and one. Dividing each sector integral by
its mass produces the exact invariant conditional expectation `[4,4,1,1]`
and preserves the whole integral `17/5`. A trivial target, the original
full-information observable, a noninvariant singleton, and an unnormalized
atom integral fail numerically as `68/25≠80/25`, `7≠1`, `2/5≠14/5`, and
`64/25≠80/25`. Three accessible numeric figures, seven Lean bridges, all 18
public declarations plus the private helper, five probes and five axiom
queries, a guarded cloud interface check, and a byte-identical executed `Std`
worksheet lead from exact finite conditioning to the checked almost-everywhere
limit identification without confusing exact invariance with modulo-null
triviality.
*Ergodic Birkhoff Limits and Normalized Space Averages* now begins with the
uniform two-state swap and observable values `(3,7)`. Its exact averages
through horizon six make every even positive row equal five and put the two
odd rows at `5-2/n` and `5+2/n`; the probability integral is the same five.
Rescaling both atom masses to one leaves the orbit averages unchanged while
moving the raw integral from five to ten, so the normalized target remains
`10/2=5`. Identity dynamics retains separate limits three and seven, zero
mass exposes the vacuous totalized `0/0=0`, and alternating overlap masses
`1/2,0,1/2,0,...` prove that this ergodic swap is not mixing and that its
square need not be ergodic. Five accessible figures, six human/paper/Lean
bridges, the complete six-public/fifteen-private/five-probe/six-axiom source
map, a guarded cloud interface check, and a byte-identical executed `Std`
worksheet separate the ordinary-laptop learning path from the Mathlib-backed
project theorem.
*Subadditive Upper Limsup Bounds Before Kingman Convergence* now begins with
the uniform two-state flip and the exact process
`Xₙ=⌈n/2⌉+φ(Tⁿω)-φ(ω)`. Both normalized paths converge to `1/2`, the block-two
integral ratio is exactly `1/2`, and centering gives
`Yₙ=-⌊n/2⌋`; the residue coefficients visibly approach one half under the
original ergodic map even though its square is the nonergodic identity. A
separate one-point process `Zₙ=-n²` has normalized path `-n`, no eventual real
lower bound, extended-real limsup `-∞`, but Mathlib's totalized real limsup
zero—so omitting the generalized theorem's required lower-bound gate would
assert the false inequality `0≤-1`. Two accessible numeric figures, a revised
generic-to-cocycle ladder, seven Lean bridges, the full 27-item public/private/
probe/axiom map including the generalized declaration, a guarded cloud check,
and a byte-identical executed `Std` worksheet keep the upper bound distinct
from the missing lower-liminf and convergence halves of Kingman.
*Finite Bad-Block Measure Bounds Before Kingman Lower Liminf* now makes the
entire RMT-30 bridge explicit on a uniform amber/blue identity system. For
`m=5`, `c=-3/4`, only amber at length five is strictly bad, so the event has
mass `1/2`. Twelve amber visits are covered by `[0,5)`, `[5,10)`, and
`[10,15)` inside the buffered horizon 17, producing
`-16≤-12<-45/4≤-9`. Atomwise integration gives visit integral `6` and
buffered integral `-8`; the lower-rate witness `δ=-1/2` yields the finite
ratio `1/2≤δ/c=2/3`. Equality at length four, cap-zero emptiness,
threshold-zero cap dependence, and the false unreversed `1/2≥2/3` keep every
strictness and sign gate active. Two accessible figures, seven Lean bridges,
all ten public declarations, eleven private support declarations/instances,
nine boundary examples and seven axiom reports, a guarded cloud probe, and a
byte-identical executed `Std` worksheet explicitly stop before lower liminf or
Kingman convergence.
*From Finite Centered Bad-Block Bounds to All-Positive-Length Control* carries
the same uniform amber/blue process to its uncapped event. At slope `-3/4`,
caps zero through four are empty, cap five first becomes `{amber}`, every
larger cap stays there, and the union has mass `1/2≤δ/c=2/3` for
`δ=-1/2`. Equality at length four and the slope-zero cap-one/cap-two split
keep strictness visible. A separate preserving collapse with a one-shot
centered process has exactly one bad length, raw event `{amber}`, and empty
preimage; both sets have Dirac-blue mass zero, so almost-everywhere equality
does not repair setwise invariance. Two accessible numeric figures, seven Lean
bridges, all eleven public declarations plus fifteen private items, ten
examples and seven axiom reports, the unconditional extended-measure limit and
finite-target `Measure.real` gate, a guarded cloud check, and a byte-identical
executed 97-line `Std` worksheet distinguish one finite witness from recurrent
or lower-liminf deviation.
*Rational-Slack Lower-Deviation Events and Ergodic Null Selection* now opens
on the exact probability model `mu(a)=0`, `mu(b)=1`, `T(a)=b`, and `T(b)=b`.
For positive time, `X_n(a)=-2(n-1)` and `X_n(b)=-(n-1)`. At the fixed inner
slope `q=-3/2` below target `c=-5/4`, state `a` is strictly bad at every
`n>=5` while `b` never is, so the target event is the nonempty null set `{a}`.
Its preimage is literally empty; the two sets are unequal but agree almost
everywhere. The integrated lower rate `delta=-1` gives the strict branch
ceiling `delta/c=4/5<1`, selecting mass zero from the ergodic zero-or-one
fork. At target `-3/4` the event is full but the rate gate fails, while the
transient process `W_n=-1` for `n>=2` separates one bad witness, same-target
recurrence, and a durable rational margin. Three new accessible numeric
figures, seven human/paper/Lean bridges, the complete nineteen-public/
twenty-one-private/six-probe/ten-axiom source map, a guarded cloud check, and
a byte-identical executed 122-line `Std` worksheet make every quantifier and
branch-selection step inspectable on an ordinary laptop.
*The Guarded Real-Liminf Bridge to Log-Positive Kingman Convergence* now
starts with three exact normalized sequences. A bounded alternation between
`-3/2` and `-1/2` has the needed lower guard and repeatedly crosses
`q=-5/4<c=-1`; the sequence `-1/n` stays below target zero but eventually
loses every fixed negative rational margin; and the quadratic-escape
normalization `1-n` crosses `q=-2<c=-1` forever while defeating every eventual
real lower bound. The last model has Mathlib's totalized real liminf zero, so
dropping the guard would demand the false conclusion `0<-1`. An exact squeeze
with log-positive rate `3/2`, rails `3/2-1/k` and `3/2+1/k`, alternating
samples, and width `2/k` then shows how the new lower rail joins the prior
upper rail; the positive `1/k` boundary keeps zero rate legal. Two new
accessible numeric figures, seven human/paper/Lean bridges, the complete
twenty-four-public/eleven-private/five-probe/eleven-axiom manifest, a guarded
cloud interface check, and a byte-identical executed 142-line `Std` worksheet
make the totalization trap and final convergence mechanism reproducible
without building Mathlib on the workstation.
*The Forward-and-Inverse Tail Sandwich for Finite-Time Real Log Norms* now
opens on base-two exponent steps `(2,-3,1,2)`. Their signed prefixes
`(0,2,-1,0,2)`, exact positive clips `(0,2,0,0,2)`, forward rails
`(0,2,2,3,5)`, inverse-value clips `(0,0,1,0,0)`, and inverse-orbit rails
`(0,0,3,3,3)` verify `-J <= -Q <= R <= P <= U` at every horizon. The exact
noncommuting shears show `(UL)^-1 = L^-1 U^-1` and expose the wrong unreversed
product; one `2^-100` contraction makes signed log norm `-100`, forward clip
zero, and inverse tail `100`. Three new accessible numeric figures, eight
human/paper/Lean bridges, the complete twenty-eight-public/thirty-four-private/
sixteen-example/eleven-axiom source map plus all three structure fields, a
guarded cloud interface check, and a byte-identical executed `Std` worksheet
finish the 36-chapter textbook pass while keeping the RMT-35 source-only
release debt explicit. This latest wave has static Hugo and native-pixel asset
QA; a fresh live desktop/mobile browser pass remains future release QA because
the browser backend was unavailable.

## RMT-35 Green Vertical-Slice Release

On 2026-07-27 the owner resumed the random-cocycle work with an explicit
RunPod compute budget of $30 and asked that project network storage be
retained. The release used one 32-vCPU/128-GB CPU builder at $1.28/hour after
the initial oversized 256-GB selection was promptly replaced and terminated.
The approved builder ran for under one hour, leaving the combined compute
spend far below budget. The separately created 100-GB project network volume
is intentionally retained at its provider storage rate.

- `RealLogNormKingman.lean` is now 700 lines with thirty-three public named
  declarations and seven axiom prints. Its frozen source SHA-256 is
  `428cf84a18fcec75a8a2deb9aaa49e612b87706d3f39da4aa81e61b78d8e601a`.
- A private generic `Fin 1` Dirac cocycle with generator entry `exp(rate)`
  checks the exact matrix power, selected norm, real-log observable,
  two-tail package, normalized integral, and signed Fekete rate for every real
  `rate`. Anonymous examples instantiate exact rates `-1`, `0`, and `1`.
  The optional nonergodic and mass-two countermodels were judged
  disproportionate for this slice because they would duplicate already
  explicit endpoint assumptions without protecting a new public interface.
- The complete teaching bundle is
  `signed-real-log-kingman-convergence-in-lean`,
  `integrated-real-log-growth-and-signed-kingman-convergence`, and
  `integrated-real-log-growth-rate`. It adds three deterministic 1200x630
  cards, five page-owned conceptual SVGs, the full public-declaration map,
  literal standalone and project checks, exact nonclaims, and the verified
  Kingman 1968 publisher record and DOI.
- RMT-29's Notebook now documents the generalized eventual-lower-bound
  theorem, its nonnegative compatibility wrapper, all five public
  declarations, and all five axiom prints. RMT-34's Notebook, Deep Dive, and
  tail glossary now link forward to RMT-35 while preserving RMT-34's own
  finite-time nonclaims.
- The standalone `Std` scalar tutorial compiled locally under Lean 4.32.0.
  Workstation validation passed 40/40 proof-to-prose coverage, twenty-three
  coverage regressions, seven hygiene regressions, the 146-Markdown teaching
  scan, the 697-file public-language scan, deterministic card verification,
  XML parsing, and Hugo Extended with Deploy 0.160.1 rendering of 420 pages.
- Literal browser QA at 1440x1000 and 390x844 found one heading per page, no
  page-level overflow, broken or alt-less images, KaTeX errors, raw display
  delimiters, or console warnings/errors. Visual inspection caught and
  repaired one social-card subscript-font fallback before deterministic
  re-verification.
- The checksum-identical source-only tree was synchronized to the approved
  Linux builder without `.env`, Git metadata, local caches, generated Hugo
  output, credentials, or private review files. Warning-fatal RMT-29 and
  RMT-35 leaf checks passed. `CLOUD_LEAN_BUILD=1 make -j1 check` then completed
  all 3,218 Lean jobs and every static gate using the exact Hugo 0.160.1
  extended-with-deploy release. Every reported axiom footprint is
  `[propext, Classical.choice, Quot.sound]`.
- The live `.elan` and `.lake` trees remained on fast local pod storage.
  Sequential archives were written to the retained network volume, checked
  with `zstd -t`, and recorded in a SHA-256 manifest: a 730-MB Lean toolchain
  archive and a 2.5-GB pinned Lake-cache archive. After milestone commit
  `a9cc929` reached `origin/main`, the exact 128-GB compute pod was terminated;
  a post-action inventory confirms it is absent. The 100-GB network volume is
  still present and intentionally retained.

RMT-35 proves no `L¹` convergence, uniform integrability of normalized signed
growth, limit-integral interchange, sample-rate equality on arbitrary finite
mass, convergence rate, concentration inequality, singular-value or conorm
asymptotic, inverse-cocycle exponent identity, Lyapunov spectrum, invariant
filtration or splitting, Oseledets theorem, derivative-cocycle bridge, or
stable-manifold theorem.

## RMT-36 Selected Stochastic-Stability Statement

The owner selected cocycle growth-rate stability on 2026-07-27 after comparing
three distinct uses of “stochastic stability.” RMT-36 does not use the term for
zero-noise selection of stationary or physical measures, and it does not use
it for upper semicontinuity of random attractors. Those meanings require
different objects and remain separate possible future programs.

### Exact mathematical target

Fix a probability space \((\Omega,\mu)\), a measure-preserving map
\(T:\Omega\to\Omega\), a finite matrix index, and constants \(M,K\). Let
\(A_j,A:\Omega\to GL(d,\mathbb C)\) be ordinarily measurable generators with

\[
\lVert A_j(\omega)\rVert\le M,\qquad
\lVert A_j(\omega)^{-1}\rVert\le K
\]

for every \(j,\omega\), with the same bounds for \(A\). The selected
perturbation notion is uniform convergence \(A_j\to A\) on \(\Omega\), expressed
in Lean by Mathlib's `TendstoUniformly`.

For the fixed-base cocycle products

\[
A_j^{(n)}(\omega)
  =A_j(T^{n-1}\omega)\cdots A_j(\omega),
\]

define

\[
\lambda(A_j)
  =\inf_{n\ge1}\frac1n
    \int_\Omega\log\lVert A_j^{(n)}(\omega)\rVert\,d\mu(\omega).
\]

The endpoint is the strict-neighborhood form

\[
\lambda(A)<y
\quad\Longrightarrow\quad
\lambda(A_j)<y\ \text{eventually},
\]

equivalently the epsilon upper bound

\[
\lambda(A_j)\le\lambda(A)+\varepsilon
\quad\text{eventually for every }\varepsilon>0.
\]

This is upper semicontinuity only. It does not assert a matching lower bound or
full continuity.

### Proof-obligation ledger

1. Bundle ordinary measurability, pointwise invertibility, and the common
   forward/inverse norm bounds without varying the base map or measure.
2. Derive the existing two-tail integrability package from the uniform bounds
   on a finite measure space. Pointwise invertibility remains explicit because
   Mathlib's total nonsingular inverse is zero on singular matrices.
3. Prove that uniform generator convergence implies pointwise convergence of
   every fixed finite product by induction on the horizon.
4. Compose product convergence with the matrix norm and `Real.log`.
   Invertibility of the target product supplies the nonzero point required by
   continuity of the logarithm.
5. Bound the absolute finite-horizon log norm by
   \(n(\log^+ M+\log^+ K)\), using the existing forward and inverse orbit-sum
   rails.
6. Apply dominated convergence at each fixed horizon.
7. Select one positive horizon whose normalized target integral lies below a
   prescribed strict upper threshold, then use the finite-horizon convergence
   and the Fekete upper bound for every perturbed rate.

The checked source is
`NonlinearDynamics.Random.RandomCocycles.GrowthRateStability`. All seven
proof-obligation items above are implemented and pass the warning-fatal cloud
leaf check and complete repository gate.

### Literature and API anchors

- J. F. C. Kingman, “The Ergodic Theory of Subadditive Stochastic Processes,”
  *Journal of the Royal Statistical Society: Series B* 30(3), 499–510 (1968),
  DOI `10.1111/j.2517-6161.1968.tb00749.x`, supplies the historical
  subadditive-rate setting. RMT-36 uses the already formalized deterministic
  Fekete infimum, not a new invocation of Kingman's almost-everywhere theorem.
- J. Bochi, “Genericity of Zero Lyapunov Exponents,” *Ergodic Theory and
  Dynamical Systems* 22(6), 1667–1696 (2002), DOI
  `10.1017/S0143385702001165`, records the broad \(C^0\) discontinuity
  landscape that blocks an unsupported general continuity claim.
- L. Backes, A. Brown, and C. Butler, “Continuity of Lyapunov Exponents for
  Cocycles with Invariant Holonomies,” *Journal of Modern Dynamics* 12,
  223–260 (2018), DOI `10.3934/jmd.2018009`, proves continuity under additional
  invariant-holonomy structure. RMT-36 assumes no holonomies and claims only
  the infimum-driven upper direction.
- M. Viana and J. Yang, “Continuity of Lyapunov Exponents in the \(C^0\)
  Topology,” *Israel Journal of Mathematics* 229, 461–485 (2019), DOI
  `10.1007/s11856-018-1809-7`, further demonstrates that continuity behavior
  depends on the base and structural hypotheses.
- J. F. Alves, V. Araújo, and C. H. Vásquez, “Stochastic Stability of
  Diffeomorphisms with Dominated Splitting,” arXiv:`math/0404160`, studies the
  separate zero-noise stationary-measure meaning that RMT-36 does not encode.
- J. C. Robinson, “Stability of Random Attractors under
  Perturbation and Approximation,” *Journal of Differential Equations* 186(2),
  652–669 (2002), DOI `10.1016/S0022-0396(02)00038-4`, studies the separate
  random-set/Hausdorff-semidistance meaning that RMT-36 does not encode.
- Pinned Mathlib 4.32.0 provides `TendstoUniformly`,
  `Real.continuousAt_log`,
  `tendsto_integral_of_dominated_convergence`, and the real
  upper-semicontinuity interfaces. Exact source-level API authority remains
  the checked v4.32.0 dependency tree plus the warning-fatal cloud compile.

### Provenance and status

The human owner chose the nonlinear-dynamics program, requested completion of
the stochastic-stability item, approved the cocycle-rate interpretation, and
set the project compute budget. Codex compared the competing definitions,
proposed the upper-only statement, gathered sources, designed the interface,
and drafted the proof. Checked Lean, not this ledger or the draft, determines
whether the theorem is established.

### Green release validation

The source tree is based on audited `main` commit `3f11d99` and was released
in milestone commit `0765b12`. The exact SHA-256
of
`formalization/NonlinearDynamics/Random/RandomCocycles/GrowthRateStability.lean`
is
`ce7cd60eff690b86ef03d1a992be9596afdea1e8cbb1788d25212b5a61030d7f`.
The public snapshot is byte-identical. The random-cocycle aggregator imports
the module.

The checked declaration ledger is:

- `UniformlyBoundedInvertibleGenerator`;
- `UniformlyBoundedInvertibleGenerator.toCocycle`;
- `UniformlyBoundedInvertibleGenerator.hasIntegrableGeneratorLogTails`;
- `UniformlyBoundedInvertibleGenerator.integratedRealLogGrowthRate`;
- `UniformlyBoundedInvertibleGenerator.tendsto_value_of_tendstoUniformly`;
- `UniformlyBoundedInvertibleGenerator.tendsto_realLogNormObservable_of_tendstoUniformly`;
- `UniformlyBoundedInvertibleGenerator.abs_realLogNormObservable_le`;
- `UniformlyBoundedInvertibleGenerator.tendsto_integratedRealLogNorm_of_tendstoUniformly`;
- `UniformlyBoundedInvertibleGenerator.eventually_integratedRealLogGrowthRate_lt`;
  and
- `UniformlyBoundedInvertibleGenerator.eventually_integratedRealLogGrowthRate_le_add`.

The five printed proof footprints are exactly `[propext, Classical.choice,
Quot.sound]`; no footprint contains `sorryAx`.

Workstation-safe validation on macOS:

- `make workstation-check` passes;
- Lean/notebook coverage reports 41 substantive modules and 41 comprehensive
  Research Notes;
- teaching hygiene reports 149 Markdown files, and the public reader-language
  gate reports 713 files without contributor infrastructure instructions;
- Hugo Extended 0.160.1 renders 431 pages warning-fatal; and
- the three new card generators reproduce 1200x630 PNGs from their committed
  SVG sources.

Approved Linux validation used a Secure Cloud CPU builder with 16 vCPU, 64 GB
RAM, and 100 GB ephemeral root storage at $0.64 per hour, within the owner's
$30 project budget. The preserved 100 GB project network volume was attached
only for sequential, integrity-checked toolchain and Lake-cache archive
restore. The live build tree remained on fast ephemeral storage. Source-only
synchronization excluded `.git`, `.env`, credentials, local build trees,
generated Hugo output, and private review files.

- The leaf warning-fatal gate passes for
  `NonlinearDynamics/Random/RandomCocycles/GrowthRateStability.lean`.
- `CLOUD_LEAN_BUILD=1 make check` completes all 3,219 Lean build jobs and the
  full content and Hugo gate.
- The warning-fatal aggregator gate passes for
  `NonlinearDynamics/Random/RandomCocycles.lean`.
- The committed `lean-toolchain` and `lake-manifest.json` select Lean 4.32.0;
  every guarded target verifies the pinned manifest.
- The cloud content gate uses the same Hugo Extended 0.160.1 release as the
  workstation gate and renders the same 431 pages.

Milestone commit `0765b12` reached `origin/main`, after which the exact task
compute resource was terminated. A post-action inventory confirms that the
compute pod is absent and the preserved project network volume is still
present. No network storage was deleted.

## Historical Pause Handoff: RMT-35 Source Milestone

> Superseded by the green release record above. This historical section is
> retained only to explain the source-only state and recovery plan that the
> 2026-07-27 release completed.

### What is checked now

- `RealLogNormKingman.lean` is a new 576-line module with thirty-three public
  named declarations and seven source axiom prints. Its source-checkpoint
  SHA-256 is
  `ab262f7695330c30fe8f2fdf1d4831e22dcf394ddced6414ce40d27533a3669a`.
  Recompute this hash after any edit; it is not yet a frozen teaching-source
  snapshot.
- The deterministic half defines `integratedRealLogNorm`,
  `normalizedIntegratedRealLogNorm`,
  `integratedInverseGeneratorLogPlusNorm`, and
  `integratedRealLogGrowthRate`. Preservation turns pointwise signed
  subadditivity into scalar subadditivity. The integrable inverse-generator
  envelope gives a concrete finite lower floor, so Mathlib's real-valued
  Fekete theorem applies and identifies the rate with the infimum over
  positive horizons.
- The samplewise lower rail reuses RMT-33's centered rational-deviation
  theorem. The upper rail uses an explicit eventual lower-boundedness premise:
  the negative inverse-generator Birkhoff average lies below normalized
  signed growth, and finite-measure pointwise Birkhoff convergence makes that
  comparison bounded almost everywhere. On a pre-ergodic probability base,
  the lower liminf and upper limsup squeeze prove
  `HasIntegrableGeneratorLogTails.ae_tendsto_normalizedRealLogNormObservable`.
- The module also proves empty-dimensional rate zero and identifies the signed
  and log-positive rates when the latter is strictly positive by uniqueness
  of samplewise limits. It does not use limit-integral interchange.
- RMT-29's `SubadditiveUpperLimsup.lean` now exposes
  `ae_limsup_normalized_le_blockIntegral_of_ae_isBoundedUnder_ge`, whose input
  is an actual almost-everywhere eventual lower bound on the normalized
  process. Its former nonnegative theorem remains as a compatibility wrapper.
  This generalization is mathematically necessary: for `X n = -n²`, the
  normalized real sequence is not lower bounded, and Mathlib's totalized real
  `limsup` prevents the desired fixed-block inequality.
- The new module, changed RMT-29 leaf, and cocycle aggregator each pass direct
  `-DwarningAsError=true` compilation. `lake build
  NonlinearDynamics.Random.RandomCocycles.RealLogNormKingman` and `lake build
  NonlinearDynamics` pass, and the last pre-policy local `lake build` completed
  all 3,218 jobs. Every recorded axiom footprint is exactly
  `propext`, `Classical.choice`, and `Quot.sound`; no `sorry` or `admit` occurs
  in the changed Lean sources.
- An independent read-only semantic audit found no missing assumption in the
  deterministic Fekete argument, lower endpoint, upper endpoint, or final
  squeeze. It also drove three last source improvements before the pause:
  minimal assumptions on inverse-orbit-sum integration, explicit target names
  for the three inverse-tail inequalities, and a one-step rate upper bound.
- The approved RMT-35 RunPod CPU builder passed the warning-fatal generalized
  RMT-29 leaf and the pre-RMT-35 full 3,217-job Lean build, but not the final
  RMT-35 checksum-identical replay. On 2026-07-22 the owner clarified that the
  compute should be terminated while its disk should remain. The exact
  `$1.472`/hour project pod was therefore terminated through the authenticated
  RunPod REST API; a post-action inventory confirms it is absent and the
  unrelated account pod was untouched. The separately listed 100 GB
  `nonlinear-dynamics-lean-cache` network volume remains, with its sequential
  toolchain and Mathlib snapshots, at approximately `$7`/month. Any future
  builder must be freshly human-approved and attach that preserved volume.
  Keep resource identifiers and addresses out of this repository.
- The same operational pass recovered local Mac space without touching source,
  Git, Codex sessions, downloaded model weights, or the active Lean toolchain.
  It cleared the regenerable 24 GB logical `uv` cache, 5 GB npm cache, 7.3 GB
  Mathlib compiled build tree, and fourteen explicitly named inactive
  generated audit/build directories with no Git metadata. Ambiguous temporary
  directories containing nested repositories were preserved. APFS-reported
  free space rose from 3 GiB to 25 GiB; the repository shrank from 8.8 GB to
  1.4 GB while Mathlib source and the project's 98 MB build remained. Those
  removed Mathlib artifacts must not be restored or rebuilt on the Mac.

### Deliberately unfinished at the pause

- No RMT-35 scalar boundary atlas is checked yet. The next source pass should
  add one-dimensional Dirac models for contraction, neutrality, and expansion
  with exact signed rates `-1`, `0`, and `1`, plus the already proved empty-
  dimensional zero boundary. The promising generator is the constant
  `Fin 1` matrix with entry `Real.exp λ`; use `forwardProduct_const`,
  `Matrix.linfty_opNorm_def`, `Complex.norm_exp_ofReal`, and limit uniqueness.
- Recommended countermodels are still absent: a nonergodic two-atom identity
  base with slopes `-1` and `1`, and a mass-two Dirac model showing why raw
  integrated rates on a merely finite measure space are not probability-
  normalized sample rates.
- RMT-35 has no Development Notebook, Deep Dive, glossary chapter, social
  card, conceptual figures, hosted Lean snapshot, or proof-to-prose manifest
  entry. Therefore this is a source checkpoint, **not a green vertical-slice
  release**, and the complete `make check` contract is not yet claimed.
- RMT-29's existing Notebook and Deep Dive are now semantically stale: they
  still describe nonnegativity as the generic upper-limsup premise and count
  four public declarations/axiom prints. They must explain the new lower-
  bounded generic theorem, retain the nonnegative wrapper, and count five.
  Update their `limsup-boundedness-gates.svg` and
  `generic-to-cocycle-ladder.svg` accordingly.
- RMT-34 teaching has future-tense handoff language that should link forward
  to RMT-35 without weakening RMT-34's own nonclaims. Update its Notebook,
  Deep Dive, and `integrable-generator-log-tails` glossary page.
- No browser or visual QA was attempted for this partial slice. No claim is
  made about cards, SVG accessibility, KaTeX, desktop/mobile layout, Hugo page
  counts, or served source identity for RMT-35.

### Note to the next Codex session

1. Read this section first, then reread
   `.agents/skills/formalize-nonlinear-dynamics/SKILL.md` and the nearest
   teaching `AGENTS.md` files before editing prose. Inspect the actual Git
   status and latest commits; do not assume temporary files survived.
2. After obtaining approval for a Linux cloud builder, re-run the warning-fatal
   RMT-29 and RMT-35 leaves there. Complete the scalar boundary atlas and, if
   proof cost remains proportionate, the two recommended countermodels. Keep
   the theorem scoped to signed top growth in the selected matrix norm. Never
   probe or compile these files on the Mac.
3. Create the Notebook bundle at
   `site/content/development-notebook/2026/07/signed-real-log-kingman-convergence-in-lean/`,
   the Deep Dive at
   `site/content/knowledge-base/deep-dives/integrated-real-log-growth-and-signed-kingman-convergence/`,
   and the glossary bundle at
   `site/content/knowledge-base/glossary/integrated-real-log-growth-rate/`.
   Follow the exact declaration/source-order/axiom ledgers, disclosure panels,
   solved-exercise, deterministic-card, and accessible-SVG conventions.
4. Update the stale RMT-29 and forward-looking RMT-34 pages described above.
   Add `RealLogNormKingman.lean` to
   `site/data/lean_notebook_coverage.json` and publish a byte-identical source
   snapshot under `site/static/lean/NonlinearDynamics/Random/RandomCocycles/`.
5. Before citing the historical source, independently verify this candidate
   primary record: J. F. C. Kingman, *The Ergodic Theory of Subadditive
   Stochastic Processes*, JRSS Series B 30(3), 499–510 (1968), DOI
   `10.1111/j.2517-6161.1968.tb00749.x`. Do not reuse the previously suggested
   Annals DOI without separate verification.
6. Run snapshot identity, coverage and hygiene tests, deterministic card
   verification, XML/raster inspection, Hugo warnings-fatal rendering, and
   literal desktop/mobile browser QA on the Mac. On the approved Linux cloud
   builder, establish its server host key through the authenticated control
   plane, synchronize source-only without `.env`, Git metadata, caches, or
   generated output, restore caches onto fast ephemeral/local disk, run the
   warning-fatal leaf/aggregator/root Lean checks, and finish with
   `CLOUD_LEAN_BUILD=1 make -j1 check`. Never disable host verification or run
   that full gate locally. Terminate the compute after recording the result.
7. Only after all of that, replace this pause state with a complete RMT-35
   release checkpoint, commit a coherent milestone, and push `main`.

RMT-35 still proves no `L¹` convergence, uniform integrability of normalized
signed growth, limit-integral interchange, sample-rate equality on arbitrary
finite mass, convergence rate, concentration inequality, singular-value or
conorm asymptotic, inverse-cocycle exponent identity, Lyapunov spectrum,
invariant filtration or splitting, Oseledets theorem, derivative-cocycle
bridge, or stable-manifold theorem.

## Restart Handoff

- RMT-34 adds the 942-line
  `NonlinearDynamics.Random.RandomCocycles.RealLogNormIntegrability` module at
  `Random/RandomCocycles/RealLogNormIntegrability.lean`. Its frozen SHA-256 is
  `ac950f8728e5fd003cff3b7a5d0750e5c36060730b3ebadc5b0e1165b54e72ea`;
  the source-only Lean milestone is pushed at `624c727`. The public surface
  has twenty-eight declaration commands and three explicit structure fields,
  supported by thirty-four private commands, sixteen compiled anonymous
  examples, and eleven source axiom prints.
- Lean's total convention `Real.log 0 = 0` remains visible. The extended log
  norm is zero-faithful at bottom; only the bridge from an extended logarithm
  to a real logarithm needs a nonempty matrix index. Public signed results
  split the empty dimension explicitly, where the unique zero matrix is also
  the identity unit and every finite real log norm is zero.
- Pointwise generator units propagate through the ordered cocycle product and
  give real-log subadditivity. Mathlib's total nonsingular inverse is zero on
  the singular locus, and inverse products reverse order, so RMT-34 constructs
  neither a same-base inverse cocycle nor an inverse-exponent identity.
- The inverse-value log-positive observable is measurable without an
  invertibility hypothesis. Under pointwise units it is bounded by the
  forward-orbit sum of the inverse-generator observable. Separate integrable
  forward and inverse tails therefore give integrable upper and lower rails
  for every finite real log norm.
- `HasIntegrableGeneratorLogTails` packages exactly the algebraic unit guard
  and both one-step moment hypotheses. It proves finite-horizon signed
  integrability and exports the real-log family as an
  `IsIntegrableSubadditiveProcessCandidate`; it does not yet prove a general
  signed almost-everywhere limit.
- A checked identity-base geometric probability model in one dimension has
  forward log-positive observable zero while the inverse log-positive and
  signed absolute observables grow like `2^n` and are not integrable. The model
  is neither independent nor ergodic, and it is used only to refute the false
  one-tail implication.
- The positive-rate endpoint needs no units, inverse tail, or nonempty matrix
  dimension. A strictly positive RMT-33 rate makes the real log and
  log-positive observable eventually agree almost everywhere. The theorem
  permits singular matrices, while its empty-dimensional specialization is
  vacuous because that rate is zero.
- Every printed public-theorem footprint is exactly `propext`,
  `Classical.choice`, and `Quot.sound`. Warning-fatal leaf, cocycle-aggregator,
  Random-root, and project-root compilation pass with no `sorry`, `admit`,
  unsafe declaration, or project axiom. Independent semantic and
  theorem-to-prose audits found no remaining blocker.
- The teaching slice adds a 9,410-token, 1,573-line Development Notebook with
  forty solved exercises; an 11,402-token, 2,419-line textbook Deep Dive with
  forty solved exercises; and a 4,507-token, 843-line glossary chapter with
  sixteen worked mini-exercises. Three deterministic 1200x630 cards and
  seventeen accessible conceptual SVGs accompany the bundles. All remain
  `draft: true` and `pro_reviewed: false` pending human publication review.
- The three pages link to a site-hosted, byte-identical Lean snapshot. The
  proof-to-prose checker parses every content page's front matter and verifies
  that its module, exact path, and SHA-256 agree. Seventeen regression tests
  cover missing, malformed, body-only, mismatched, stale, traversing, and
  symlink-escaping metadata. Literal
  1440x1000 and 390x844 browser audits load every lazy image and render 142,
  374, and 211 KaTeX nodes in the Notebook, Deep Dive, and glossary with no
  page overflow, missing alt text, broken image or anchor, raw delimiter,
  KaTeX error, or console failure. The served source returns HTTP 200 and is
  byte-identical to the frozen 41,522-byte module.
- The retained approved RunPod builder completed an historical integrated
  pre-release gate in 11.86 seconds before the snapshot gate was generalized.
  The current complete gate—including all 3,217 Lean jobs, 39/39
  proof-to-prose coverage, seventeen snapshot-contract tests, four hygiene
  tests, the 132-file teaching scan, and the 405-page, 65-static-file
  warning-fatal Hugo render—takes 7.38 seconds locally and 4.58 seconds on the
  checksum-identical RunPod tree. Final recorded-checkpoint local and remote
  replays protect this handoff.
- RMT-34 proves no general signed Kingman limit, `L¹` convergence,
  limit-integral interchange, singular-value asymptotic, Lyapunov spectrum,
  invariant filtration, Oseledets splitting, derivative-cocycle bridge, or
  stable-manifold theorem. The inverse rail sees the strongest contraction
  and is not automatically the negative top exponent.

- RMT-33 adds the 627-line
  `NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman` module at
  `Random/RandomCocycles/SubadditiveKingman.lean`. Its current SHA-256 is
  `55680bc2afa18d0a195a7fa7426e6afb2b55fcbb3f588d3474bc6f52764025ef`.
  The public surface has twenty-four documented declarations, supported by
  eleven private declarations, five compiled anonymous boundary examples,
  and eleven source axiom prints.
- The positive-time normalization is totalized at zero without changing its
  tail. The centered normalization is nonpositive at every positive time, but
  real `Filter.liminf` still needs an explicit eventual lower bound: for a
  sequence diverging to negative infinity Mathlib's real liminf totalizes to
  zero. RMT-33 therefore proves only the semantically guarded equivalence
  between strict rational lower-deviation membership and strict liminf
  deviation.
- The proof uses two different rational margins. An outer `c < δ` makes the
  RMT-32 event null; an inner `q < c` witnesses its rational exhaustion. The
  countable cover of `{liminf < δ}` never substitutes the false premise
  `δ < δ`. The same cover both kills the lower-liminf exception and constructs
  the eventual lower bound needed by later real-liminf algebra.
- The exact identity between the original normalization, centered
  normalization, and the one-step Birkhoff average transfers the lower bound
  with `le_liminf_add`. The cocycle endpoint deliberately takes a
  `PreErgodic` hypothesis: the cocycle already carries preservation, and the
  theorem does not duplicate it as a separate argument.
- RMT-29 supplies the matching upper limsup. After proving the upper- and
  lower-boundedness premises explicitly, RMT-33 applies the real
  liminf/limsup squeeze to obtain almost-everywhere convergence of
  `C.logPlusNormObservable n ω / n` to the integrated log-positive growth
  rate. The theorem still accepts an empty matrix index.
- Compiled boundaries cover the zero process, arbitrary replacement at time
  zero, strict crossings converging to a threshold without one fixed rational
  crossing, a quadratic sequence exposing real-liminf totalization, and the
  empty matrix index. Every independent public-theorem axiom audit reports
  exactly `propext`, `Classical.choice`, and `Quot.sound`.
- The theorem is about the nonnegative log-positive envelope. It proves no
  signed logarithmic convergence, `L¹` convergence, limit-integral
  interchange, inverse-cocycle identity, Lyapunov spectrum, invariant
  subspace, or Oseledets splitting.
- The teaching slice adds an 8,166-token, 1,482-line Development Notebook with
  thirty-two solved exercises, a 10,376-token, 2,034-line textbook Deep Dive
  with forty solved exercises, and a 1,562-token limit-inferior glossary
  chapter. Three deterministic 1200x630 cards and sixteen new accessible
  conceptual SVGs accompany the bundles; the RMT-32 handoff SVG was also
  corrected. All remain `draft: true` and `pro_reviewed: false` pending human
  publication review.
- Warning-fatal leaf, cocycle-aggregator, and project-root compilation;
  38/38 proof-to-prose coverage; the 129-file teaching-source gate; card
  reproduction; ShellCheck; XML and raster inspection; a 396-page
  warning-fatal Hugo render; and literal desktop and 390x844 mobile browser
  checks are green. Source and rendered article-body math counts agree exactly
  at 157 inline plus 22 display expressions in the Notebook, 329 plus 118 in
  the Deep Dive, and 61 plus 11 in the glossary. The RunPod source-only
  preflight completes all 3,214 Lean jobs and every non-checkpoint gate in
  about ten seconds.
- RMT-34 API discovery is already compile-checked against the pinned toolchain
  in an isolated 371-line scratch file. It validates the full focused surface,
  including pointwise unit propagation, the extended-to-real logarithm bridge,
  inverse-tail measurability and integrability, the signed subadditive
  candidate, and the positive-rate endpoint. The probe strengthens the plan:
  real-log measurability and the finite inverse majorant are unconditional,
  while the positive-rate endpoint needs neither invertibility nor nonempty
  dimension. Four endpoint axiom audits again report only `propext`,
  `Classical.choice`, and `Quot.sound`; no repository file was changed by the
  probe.

- RMT-32 adds the 668-line
  `NonlinearDynamics.Random.RandomCocycles.SubadditiveLowerDeviation` module at
  `Random/RandomCocycles/SubadditiveLowerDeviation.lean`. Its current SHA-256
  is `1bdcfd6b3be654f52bae22bdb2b44c15848e66d51f3a0973ce1c8aba61db14d4`.
  The public surface has nineteen documented declarations, supported by
  twenty-one private boundary items, six compiled anonymous examples, and ten
  source axiom prints.
- `centeredArbitrarilyLateBadBlockSet T X q` means that a positive witness
  below slope `q` exists beyond every natural cutoff. The strict target event
  `centeredStrictLowerDeviationSet T X c` is the countable union over rational
  `q < c`. This durable rational margin is essential: the compiled one-shot
  model has `A_0 = {false}` while the rationally exhausted `D_0` is empty.
- Centered shifted subadditivity gives
  `Y_(n+1)(ω) ≤ Y_n(T ω)`. For `q < r`, an Archimedean cutoff makes
  `q * n < r * (n + 1)`, so `T ⁻¹' A_q ⊆ A_r`. Rational density closes that
  relaxed inclusion at the target: `T ⁻¹' D_c ⊆ D_c`. The public methods keep
  the project candidate receiver for ergonomics, although these two setwise
  proofs consume only its `add_le` field.
- Candidate integrability and preservation make the countable event null
  measurable. Preservation plus finite total mass upgrades the one-sided
  inclusion to almost-everywhere equality. Finite-measure ergodicity then gives
  the almost-empty or almost-full fork. Probability normalization is not used
  for that rigidity; it labels and ultimately selects the numerical branch.
- The inclusion `D_c ⊆ centeredAllLengthBadBlockSet T X c` imports RMT-31's
  rate ratio. The normalized lower bound at `n = 1` forces `δ ≤ 0`; `c < δ`
  gives `c < 0`, hence `δ / c < 1`. On a probability space this excludes the
  almost-full branch and proves `μ D_c = 0`.
- The cocycle endpoint names both log-positive event wrappers and proves
  nullity below the integrated centered Fekete offset. RMT-30 now exposes the
  reusable theorem
  `HasIntegrableGeneratorLogPlus.centeredFeketeOffset_le_normalizedIntegral`
  instead of rebuilding that numerical bridge inside the finite-cap wrapper.
  Empty matrix dimension remains valid.
- Six compiled boundaries cover the zero process, one-shot versus asymptotic
  separation, the missing-rational-slack trap, a nonergodic half-mass event,
  an ergodic half-Dirac full event whose real mass is still below one, and the
  empty matrix index. Every independent public-theorem axiom audit reports
  exactly `propext`, `Classical.choice`, and `Quot.sound`.
- The teaching slice adds a 7,152-token, 1,268-line Development Notebook with
  thirty solved exercises and a 6,786-token, 1,151-line textbook Deep Dive
  with thirty-six solved exercises. Two deterministic 1200x630 cards and
  twelve accessible conceptual SVGs accompany the bundles. Both remain
  `draft: true` and `pro_reviewed: false` pending human publication review.
- Warning-fatal leaf, predecessor, cocycle-aggregator, and project-root
  compilation; 37/37 proof-to-prose coverage; the 126-file teaching-source
  gate; card reproduction; ShellCheck; XML and raster inspection; a 387-page
  warning-fatal Hugo render; and literal 1440x1000 and 390x844 browser checks
  are green. The browser pass found and fixed a global mobile grid-minimum
  overflow for panels containing display mathematics.

- RMT-31 adds the 481-line
  `NonlinearDynamics.Random.RandomCocycles.SubadditiveAllLengthBadBlockMeasure`
  module at
  `Random/RandomCocycles/SubadditiveAllLengthBadBlockMeasure.lean`. Its current
  SHA-256 is
  `53438522344c078d64473316a594570993d694ada909a33184579cec6a996fb7`.
  The public surface has eleven documented declarations, supported by fifteen
  private boundary items, ten compiled anonymous examples, and seven source
  axiom prints.
- `centeredAllLengthBadBlockSet` is exactly the union of every finite cap.
  Membership is equivalent to one positive finite witness satisfying the
  strict centered inequality. Cap monotonicity and the exact union identity
  are public API. This is an unbounded existential search, not an
  infinitely-often, arbitrarily-late, or lower-liminf event.
- Candidate integrability and preservation make the countable union null
  measurable without finite total mass. Independently, continuity from below
  gives convergence of the cap measures in `ENNReal` from nesting alone, with
  no set-measurability, candidate, preservation, or finiteness premise.
  Conversion to `Measure.real` is stated separately and needs only that the
  target union have finite extended measure, because `toReal ∞ = 0`.
- On a finite measure space, `le_of_tendsto'` passes RMT-30's identical
  capwise ceiling to the union without summing the cap bounds or introducing
  a new constant:
  `μ.real (centeredAllLengthBadBlockSet T X c) ≤ δ / c`. The cocycle endpoint
  reuses the integrated log-positive Fekete offset and the cocycle's bundled
  preservation. Probability, ergodicity, and a nonempty matrix index remain
  absent.
- The boundary layer checks the empty cap, finite inclusion, zero process,
  zero measure, a nonergodic half-mass event, a strict witness appearing only
  later, cap-one strictness, mass-two finite measure, an empty matrix index,
  and raw non-invariance. In the final Bool collapse model the finite Dirac
  measure is preserved, the bad event is `{false}`, and its preimage is empty.
  Every printed footprint is exactly `propext`, `Classical.choice`, and
  `Quot.sound`.
- The paired teaching slice adds a 5,120-token Development Notebook with all
  eleven declarations, fifteen private items, ten examples, seven axiom
  reports, and twenty-four solved exercises, plus a 3,632-token textbook Deep
  Dive with thirty solved exercises. Two deterministic 1200x630 cards and ten
  accessible conceptual SVGs accompany the bundles. Both remain
  `draft: true` and `pro_reviewed: false` pending human publication and the
  configured external review.
- Warning-fatal leaf, cocycle-aggregator, and project-root compilation,
  36/36 proof-to-prose coverage, the 124-file teaching-source gate, both card
  reproductions, ShellCheck, XML validation, direct visual inspection, and a
  381-page warning-fatal Hugo render are green. Independent 1440x1000 and
  390x844 browser checks of RMT-31 and its changed predecessor pages find one
  article heading per page, exact 10+66, 18+86, 14+158, and 36+155
  display-plus-inline KaTeX counts, all 5/5, 5/5, 6/6, and 6/6 figures loaded,
  and zero overflow, broken images, raw delimiters, KaTeX errors, HTTP
  failures, page failures, or console failures. The audit added an explicit
  finite-target gate to the standalone ratio figure, separated one-sided
  inclusion from the almost-invariance upgrade in the RMT-32 design, and
  supplied a site favicon instead of waiving an automatic browser 404.
- Provenance is explicit for this milestone: the human selected the overall
  formalization and teaching objective; Codex agents performed API discovery,
  Lean implementation, exposition and asset production, and independent
  theorem/prose/visual review. The checked source, reproducible assets, and
  recorded gates, not agent testimony, are authoritative.

- RMT-30 adds the 506-line
  `NonlinearDynamics.Random.RandomCocycles.SubadditiveBadBlockMeasure` module
  at `Random/RandomCocycles/SubadditiveBadBlockMeasure.lean`. Its current
  SHA-256 is
  `a8aee618a10f8434c1c33d8e433fd77e98ed3e5c8dee399e7d6fa323c5079b28`.
  The public surface has ten documented declarations, supported by eleven
  private boundary items, nine compiled anonymous examples, and seven source
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
- The reusable centered Fekete bridge and cocycle endpoint specialize `δ` to
  `integratedLogPlusGrowthRate hC - integratedLogPlusNorm 1` by combining the
  deterministic Fekete block lower bound with RMT-29's centered-integral
  identity. It adds no nonempty matrix-index or ergodicity premise and makes
  no signed-logarithm, Lyapunov, or Oseledets claim.
- The boundary layer covers `m = 0`, `H = 0 < m`, the zero process, a genuine
  failure at `H = m = 0`, zero measure, equality at the strict threshold,
  mass-two finite rescaling, and an empty matrix index. Its strengthened
  nonergodic Bool identity model has a genuinely nonempty singleton bad set
  of mass `1 / 2`; the theorem checks the numerical ratio `1 / 2 ≤ 2 / 3`.
  All seven public axiom reports are exactly `propext`, `Classical.choice`, and
  `Quot.sound`.
- The teaching slice adds a 5,607-token declaration-complete Development
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
- The raw forward-coboundary telescope states the totalized scope explicitly:
  horizon zero is a valid vacuous identity, while convergence uses bounded
  endpoints along
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
- The RMT-25 through RMT-34 release replays used a 32-vCPU, 128-GB RunPod CPU
  builder billed at $1.472/hour. That compute was terminated on 2026-07-22 at
  the owner's request. Its separately attached 100 GB persistent network
  volume remains at approximately $7/month and holds integrity-tested
  sequential zstd snapshots of
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
  builder was retained under the owner's then-continuing project-scoped
  approval and was later terminated as recorded above.
- The synchronized RMT-26 `make check` passes all 3,186 Lean jobs, checkpoint,
  31/31 proof-to-prose coverage, four hygiene regression tests, the 107-file
  teaching scan, and the 332-page warning-fatal Hugo render in 3.90 seconds on
  the warm RunPod tree. The source-only synchronization again excluded `.env`,
  Git metadata, local `.lake`, generated Hugo output, and private review files.
  The builder was retained under the owner's then-continuing project-scoped
  approval and was later terminated as recorded above.
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
- Workstation Hugo QA version at this policy checkpoint: Hugo Extended 0.160.1;
  the next cloud release gate must use the same version.
- Full build validation command: `CLOUD_LEAN_BUILD=1 make check`, on an
  approved Linux cloud builder only. Workstation validation uses
  `make workstation-check` and never invokes Lean or Lake.
- Last fully green repository build: 3,223 Lean jobs at Symbolic Coding
  candidate commit `6bf8517` on the approved Linux builder. The warning-fatal
  leaf, deterministic aggregator, project root, 49/49 proof-to-prose coverage,
  23 coverage regression tests, seven hygiene regression tests, the 176-file
  teaching scan, the 846-surface reader-language scan, and the warning-fatal
  524-page Hugo render pass.
- Lean inventory: forty-nine substantive modules are cloud-validated and
  paired with comprehensive Notebook pages. The later ODE and model
  placeholders and the `.gitkeep`-only Quantum Chaos branches remain roadmap
  work.
- Proof holes: none (`sorry` and `admit` absent).
- Teaching snapshot by the deterministic body-only regex `\b[\w'-]+\b`:
  259,256 tokens across thirty-nine Notebook companions, 308,426 tokens across
  thirty-six Deep Dives, and 178,822 tokens across sixty-two glossary chapters,
  for 746,504 tokens across all 137 teaching bundles. Their deterministic
  visual layer contains 137 social cards and 316 conceptual SVGs.
- Publication status: all 137 teaching pages are owner-authorized public
  working notes with `draft: false` and `pro_reviewed: false` pending human
  review.
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
| `NonlinearDynamics.Random.ComplexGaussianFamilies` | Ordinarily measurable mutually independent Cartesian complex coordinates, exact real and imaginary laws and variances, coordinate means and integrability, construction from independent pair-vectors, real scaling, finite joint product and qualitative Gaussian laws, a canonical product family, and the empty-index Dirac boundary | `independent-complex-gaussian-families` |
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
| `NonlinearDynamics.Random.RandomCocycles.SubadditiveAllLengthBadBlockMeasure` | Exact all-positive-length once-bad union and membership semantics, cap monotonicity, null measurability, unconditional extended-measure continuity, finite-target real continuity, the unchanged generic and cocycle rate ratios, and a preserving raw non-invariance countermodel | `all-positive-length-centered-bad-block-control-in-lean` |
| `NonlinearDynamics.Random.RandomCocycles.SubadditiveLowerDeviation` | Arbitrarily-late fixed-slope events, rationally generated strict deviation, relaxed and same-target preimage inclusions, finite-measure almost invariance and ergodic rigidity, probability null selection, exact boundary countermodels, and the log-positive cocycle null theorem | `countably-generated-centered-lower-deviation-events-in-lean` |
| `NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman` | Total positive-time normalization, guarded real-liminf/event equivalence, double-rational null exhaustion, almost-everywhere lower-liminf control with explicit boundedness, Birkhoff addback, and full normalized log-positive cocycle convergence from the RMT-29/RMT-32 squeeze | `log-positive-kingman-convergence-from-rational-lower-deviations-in-lean` |
| `NonlinearDynamics.Random.RandomCocycles.RealLogNormIntegrability` | Total finite-time real-log norms, pointwise unit propagation, measurable total inverse envelopes, reverse-order inverse orbit majorants, integrable forward-and-inverse tail rails, a signed subadditive candidate, a checked probability-space missing-tail counterexample, and strictly positive-rate real-log convergence without invertibility | `real-log-norm-integrability-from-forward-and-inverse-tails-in-lean` |
| `NonlinearDynamics.Random.RandomCocycles.RealLogNormKingman` | Signed finite-horizon integrals, inverse-tail linear controls, a finite integrated real-log Fekete rate, lower-liminf and generalized upper-limsup sample rails, pre-ergodic probability almost-everywhere convergence, empty dimension, positive-rate identification, and exact scalar contraction/neutral/expansion boundaries | `signed-real-log-kingman-convergence-in-lean` |
| `NonlinearDynamics.Deterministic.Discrete.Stability` | Forward-orbit stability, fixed-point specialization, metric characterizations, nonexpansive criteria, and exact boundary examples | `forward-orbit-stability-for-discrete-systems-in-lean` |
| `NonlinearDynamics.Deterministic.Discrete.Attraction` | Point and nonempty-set attraction, basins, local and global attracting fixed points, asymptotic stability, and singleton bridges | `attraction-and-basins-for-discrete-systems-in-lean` |
| `NonlinearDynamics.Deterministic.Discrete.Lyapunov` | Positive-definite certificates, weak and strict descent, invariant sublevels, stability, and attraction endpoints | `lyapunov-functions-for-discrete-systems-in-lean` |
| `NonlinearDynamics.Deterministic.Discrete.Conjugacy` | Algebraic and topological semiconjugacy, factor maps, conjugacy, and transport of periodicity, attraction, and basins | `conjugacies-and-semiconjugacies-for-discrete-systems-in-lean` |
| `NonlinearDynamics.Deterministic.Discrete.Bifurcation` | Parameterized families, classifier changes, conjugacy obstructions, isolated-parameter boundaries, and an exact quadratic example | `bifurcation-interfaces-for-discrete-systems-in-lean` |
| `NonlinearDynamics.Deterministic.Chaos.Sensitivity` | Metric sensitivity, scale and neighborhood interfaces, finite/discrete obstructions, stability incompatibility, and doubling-map witnesses | `sensitivity-scales-for-discrete-systems-in-lean` |
| `NonlinearDynamics.Deterministic.Chaos.Devaney` | Positive-time transitivity, dense positive-period points, historical/reduced interfaces, and the Banks sensitivity implication | `devaney-chaos-and-the-banks-implication-in-lean` |
| `NonlinearDynamics.Deterministic.Chaos.SymbolicCoding` | One-sided full shift, prefix cylinders, splicing, periodic completion, Devaney chaos, and itinerary factor-map gates | `one-sided-symbolic-coding-and-the-full-shift-in-lean` |

The root aggregator imports all forty-nine substantive modules. The proof-to-prose manifest and
`scripts/check_lean_notebook_coverage.py` enforce paired coverage and named
declaration visibility.

## Completed Teaching Layer

- Forty-nine comprehensive Development Notebook chapters in an explicit
  dependency-ordered previous/next sequence.
- Forty-six textbook-scale Deep Dives: *Random Matrices: From Outcomes to Spectra*,
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
  *Finite Bad-Block Measure Bounds Before Kingman Lower Liminf*, followed by
  *From Finite Centered Bad-Block Bounds to All-Positive-Length Control*,
  followed by *Rational-Slack Lower-Deviation Events and Ergodic Null
  Selection*, followed by *The Guarded Real-Liminf Bridge to Log-Positive
  Kingman Convergence*, followed by *The Forward-and-Inverse Tail Sandwich for
  Finite-Time Real Log Norms*.
- Seventy-five glossary chapters, now including symbolic dynamics and cylinder
  sets alongside the integrated real-log growth
  rate, integrable generator log tails,
  the finite orbit visit count,
  limit superior, limit inferior, ergodicity, normalized space
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
- One hundred forty deterministic 1200x630 social cards and 324 accessible
  page-bundle SVG figures, plus one static SVG favicon.
- Guided Hugo learning path with article orientation, progress, table of
  contents, code copy, teaching panels, glossary search, and responsive/print
  layouts. Rendered desktop and 390-pixel mobile QA found and fixed article
  overflow while retaining local scrolling for wide tables and diagrams.

## Deterministic Discrete Stability Interface Decision

Status on 2026-08-06: the source interface and teaching layer are a green
vertical slice. No Mathlib-backed Lean, Lake, or project build ran on macOS.
The warning-fatal source leaf, deterministic aggregator, and complete guarded
repository gate pass on the approved Linux builder.

### Selected scope

The first deterministic stability slice makes four explicit choices:

1. **Reference object:** point and reference-orbit stability is primary. The
   predicate compares the orbit from a nearby initial condition with the
   reference orbit at every time. Fixed-point Lyapunov stability is a
   specialization with fixedness recorded separately. Invariant-set stability
   is deferred to the attraction layer rather than being folded into this
   first predicate.
2. **Time direction:** forward time only, indexed by `ℕ`. The time-zero map is
   included. No inverse map or two-sided `ℤ` action is assumed.
3. **Topological level:** the primary definition is uniform-space
   equicontinuity of the family of iterates. A pseudo-metric theorem exposes
   the standard epsilon-delta form. This keeps the definition general without
   hiding the metric statement readers expect.
4. **Fixed-point boundary:** orbit stability does not imply that the reference
   point is fixed. `IsLyapunovStableFixedPoint f p` therefore means both
   `Function.IsFixedPt f p` and forward stability at `p`.

The drafted public interface in
`NonlinearDynamics.Deterministic.Discrete.Stability` is:

- `IsForwardStableAt f p := EquicontinuousAt (fun n : ℕ ↦ f^[n]) p`;
- `IsLyapunovStableFixedPoint f p := IsFixedPt f p ∧ IsForwardStableAt f p`;
- an entourage-and-neighborhood unfolding;
- a metric epsilon-delta equivalence for reference orbits;
- the fixed-point metric specialization;
- continuity of the one-step map at every forward-stable point;
- forward stability of every nonexpansive self-map;
- Lyapunov stability of a fixed point of a nonexpansive map; and
- identity-map and constant-map examples;
- forward stability of real translations; and
- a checked nonzero-translation witness that is forward stable but not fixed.

This slice does not define or claim invariant-set stability, attraction,
asymptotic stability, exponential stability, structural stability, robustness
under perturbation of the map, two-sided-time stability, stable manifolds, or
a Lyapunov-function criterion. Those require different hypotheses and belong
to later roadmap modules.

### Why this definition

For a metric-space self-map, an equicontinuity point is exactly a point where
every sufficiently close initial condition remains uniformly close to the
reference orbit under all forward iterates. Ethan Akin states this orbitwise
epsilon-delta definition explicitly in the abstract of “On Chain Continuity,”
*Discrete and Continuous Dynamical Systems* 2(1), 111-120 (1996), DOI
[`10.3934/dcds.1996.2.111`](https://doi.org/10.3934/dcds.1996.2.111).

J. P. LaSalle develops difference equations as discrete semidynamical systems
in Chapter 1 of *The Stability of Dynamical Systems*, pages 1-25, SIAM CBMS 25
(1976), print ISBN 978-0-89871-022-9, online ISBN 978-1-61197-043-2, chapter
DOI
[`10.1137/1.9781611970432.ch1`](https://doi.org/10.1137/1.9781611970432.ch1).
That source anchors the forward-time fixed-point stability interpretation and
keeps it distinct from attraction.

Saber Elaydi and H. R. Farran define pointwise equicontinuity by uniform
closeness through the action time in “On Variation of Equicontinuity in
Dynamical Systems,” *Bulletin of the Australian Mathematical Society* 42(3),
391-397 (1990), DOI
[`10.1017/S0004972700028550`](https://doi.org/10.1017/S0004972700028550).
Their group-action setting also makes the sidedness decision visible: the
present module deliberately uses the natural-number semigroup instead.

Pinned Mathlib 4.32.0 at revision `81a5d257` supplies `EquicontinuousAt`,
`Metric.equicontinuousAt_iff`, `EquicontinuousAt.continuousAt`,
`LipschitzWith.iterate`, `LipschitzWith.dist_le_mul`,
`Function.IsFixedPt`, and `Function.iterate_fixed`. The local dependency
source is the exact API authority. The Linux leaf check has confirmed the
interface against that pinned toolchain.

### Release-candidate validation and teaching contract

`Stability.lean` is 153 lines with twelve public named declarations and six
axiom reports. Its frozen source SHA-256 is
`ccc2ae73a4696bdf488f64281ef53cd1db066d78b5f1e2a9a4471c3f90062186`.
Every reported footprint is `[propext, Classical.choice, Quot.sound]`; none
contains `sorryAx`. The warning-fatal leaf and deterministic aggregator pass.

The complete teaching bundle is
`forward-orbit-stability-for-discrete-systems-in-lean`,
`forward-orbit-and-fixed-point-stability-in-discrete-time`, and
`forward-stability`. It adds three deterministic 1200x630 cards, six
page-owned conceptual SVGs, the declaration-complete source map, literal
standalone and project commands, exact nonclaims, and the Akin 1996,
Elaydi--Farran 1990, and LaSalle 1976 references that support the interface
decision. The bundled `Std` translation-gap theorem compiles under Lean
4.32.0.

Workstation-safe validation passes 42/42 proof-to-prose coverage, twenty-three
coverage regressions, seven hygiene regressions, the 152-Markdown teaching
scan, the 729-file public-language scan, XML and card generation, and Hugo
Extended with Deploy 0.160.1 rendering 446 pages warning-fatal. Literal QA at
1440x1000 and 390x844 finds one heading per new page, no page overflow, broken
or alt-less images, KaTeX errors, raw display delimiters, or console
warnings/errors.

The checksum-identical Linux source tree passes
`CLOUD_LEAN_BUILD=1 make -j1 check`: all 3,219 Lean jobs complete, including
the new stability leaf and deterministic aggregator; every static gate then
passes using the same Hugo Extended with Deploy 0.160.1 release and renders
the same 446 pages. The source tree includes the tracked nonsecret
`.env.example` but excludes the real `.env` and every credential.

The owner approved one Secure Cloud CPU builder with 8 vCPU, 64 GB enforced
RAM, and 80 GB ephemeral disk at $0.44 per hour, with a hard $50 compute
ceiling while useful progress continues. The retained 100 GB project network
volume is attached only for sequential, integrity-checked cache archives. Its
Lean 4.32.0 and pinned Lake archives passed SHA-256 and `zstd -t`; live build
trees remain on ephemeral disk. Source-only synchronization excludes `.git`,
`.env`, credentials, local build trees, generated Hugo output, and private
review files. The volume must remain retained after the exact task compute
resource is terminated.

Release closure on 2026-08-06: milestone commit `07a4674` reached
`origin/main`. The successful ephemeral `.lake` tree was archived sequentially
as `lake-manifest-pinned-20260806.tar.zst` on the retained volume; both that
archive and the retained Lean 4.32.0 toolchain archive pass `zstd -t` and the
new `SHA256SUMS-20260806` manifest. The builder ran for 2,165 seconds at
$0.44 per hour, approximately $0.26 of compute spend. The exact task pod was
then terminated. A post-action inventory reports zero task pods and one
retained project network volume. No cloud resource identifier or credential
is recorded here.

## Deterministic Discrete Attraction Interface Decision

Status on 2026-08-06: the source and teaching bundle pass warning-fatal
Mathlib-backed compilation and the complete release gate on the approved Linux
builder. No project Lean, Lake, Mathlib, or cache command ran on macOS.

The candidate makes five scope choices explicit:

1. `IsAttractedTo f x p` is the topological statement that the
   natural-number orbit from `x` tends to `p`. It does not silently require
   `p` to be fixed.
2. `basinOfAttraction f p` collects exactly those initial states. A locally
   attracting fixed point adds fixedness and requires this basin to be a
   neighborhood of `p`; a global one quantifies over every start.
3. `IsAsymptoticallyStableFixedPoint f p` conjoins the already checked
   `IsLyapunovStableFixedPoint` predicate with local attraction. Attraction
   does not absorb or replace the all-time stability obligation.
4. `IsAttractedToSet f x A` uses convergence of
   `Metric.infDist (f^[n] x) A` to zero and includes `A.Nonempty` explicitly.
   Mathlib totalizes `Metric.infDist x ∅` as zero, so omitting nonemptiness
   would make every orbit vacuously attracted to the empty set.
5. A locally attracting set is nonempty, forward invariant by inclusion, and
   has a basin that is a neighborhood of each of its points. This is a
   pointwise initial-condition interface. It claims neither equality
   invariance, compactness, uniform attraction of bounded sets, nor Hausdorff
   convergence. Three singleton theorems connect point and set attraction.

LaSalle's Chapter 1 on difference equations and discrete semidynamical systems
anchors the fixed-point stability and global-asymptotic context: J. P.
LaSalle, *The Stability of Dynamical Systems*, SIAM CBMS 25 (1976), pages
1-25, DOI
[`10.1137/1.9781611970432.ch1`](https://doi.org/10.1137/1.9781611970432.ch1).
Hale's Chapter 2 treats discrete dynamical systems and global attractors:
Jack K. Hale, *Asymptotic Behavior of Dissipative Systems*, AMS Surveys and
Monographs 25 (1988), DOI
[`10.1090/surv/025`](https://doi.org/10.1090/surv/025). Pinned Mathlib 4.32.0
at revision `81a5d257` supplies the exact contraction, fixed-point-limit,
distance-limit, and infimum-distance APIs. These sources support the selected
interfaces but do not erase the documented convention choices.

The pinned contraction API also fixed a genuine typeclass boundary during the
Linux leaf check. The two Banach fixed-point endpoints now require
`MetricSpace`, because Mathlib's `ContractingWith.fixedPoint` selects a unique
fixed point and therefore needs separated points. The generic orbit-distance,
set-distance, and singleton-bridge interfaces retain `PseudoMetricSpace`, where
their statements remain valid. This is a deliberate strengthening of only the
two contraction-derived theorems, not a weakening of their conclusions.

The source exposes twenty-one public declarations and six axiom queries. Its
warning-fatal Linux-checked SHA-256 is
`b457f16d9ebf151337b65f8e429e6957a222a0f86b562e1bc52ace6e6fb939ad`.
The paired bundles are
`attraction-and-basins-for-discrete-systems-in-lean`,
`attraction-basins-and-asymptotic-stability-in-discrete-time`, and
`basin-of-attraction`. The standalone three-state tutorial imports only `Std`
and passes under Lean 4.32.0. Six conceptual SVGs pass XML validation and
render inspection; all three 1200x630 cards generate and reproduce
byte-for-byte.

Approved Linux validation used RunPod Secure Cloud with 8 vCPU, 64 GB billed
RAM, an 80 GB ephemeral disk, and the retained project network volume at
$0.44 per hour. The retained Lean 4.32.0 and pinned-manifest Lake archives
passed their SHA-256 manifests and `zstd -t`; they were restored onto fast
ephemeral disk rather than used as a live network-volume `.lake` tree. The
warning-fatal attraction leaf passed in 4.42 seconds and the warning-fatal
deterministic aggregator passed in 4.18 seconds. All six axiom queries report
only `propext`, `Classical.choice`, and `Quot.sound`; none reports `sorryAx`.
The final `CLOUD_LEAN_BUILD=1 make -j1 check` replay passes all 3,221 Lean jobs,
the checkpoint and coverage gates, 23 coverage regression tests, seven
teaching-hygiene regression tests, the 155-file teaching corpus audit, the
745-surface reader-language audit, and a warning-fatal 455-page render under
Hugo Extended with Deploy 0.160.1. The cached final replay took 13.98 seconds.

Workstation and browser validation on 2026-08-06:

- `make workstation-check` passes: the checkpoint is synchronized, all 43
  substantive Lean modules have mapped Notebook coverage, all 23 coverage
  regression tests and seven teaching-hygiene regression tests pass, 155
  teaching Markdown files and 745 public reader surfaces pass their language
  gates, and Hugo Extended 0.160.1 renders 455 pages warning-fatal;
- the Notebook, Deep Dive, and basin glossary pages each render with exactly
  one `h1` at 1440x1000 and 390x844, with no page overflow, broken or alt-less
  images, KaTeX errors, raw delimiters, or console warnings or errors; and
- responsive visual inspection confirms that prose, figures, equation panels,
  navigation, and horizontally scrollable code samples remain contained and
  legible at both breakpoints.

The temporary Hugo server was stopped after QA, the browser viewport override
was reset, and the QA tab was closed. No cloud resource was created during
these workstation checks.

Release closure on 2026-08-06: milestone commit `0fd9daa` reached
`origin/main`. The successful ephemeral `.lake` tree was archived sequentially
as `lake-manifest-pinned-attraction-20260806.tar.zst` on the retained volume
without replacing either prior validated archive. The new archive passes
`zstd -t`, and both it and the retained Lean 4.32.0 toolchain archive pass the
new `SHA256SUMS-attraction-20260806` manifest. The builder ran for 1,122 seconds
at $0.44 per hour, approximately $0.14 of compute spend. The exact task pod was
then terminated. A post-action inventory reports zero task pods and one
retained project network volume. No cloud resource identifier or credential is
recorded here.

### Deterministic discrete Lyapunov milestone

This vertical slice replaces
`NonlinearDynamics.Deterministic.Discrete.Lyapunov` and its
`Deterministic/Discrete/Lyapunov.lean` placeholder with an explicit direct-
method interface. The leaf, deterministic aggregator, and full project now
pass their approved Linux checks, so the roadmap item is complete.

The selected interface makes the following decisions explicit:

- `IsNonnegativeOn` records only a weak sign condition. The separate
  `IsPositiveDefiniteOn` requires the reference point to belong to the selected
  region, makes its value zero, and requires strict positivity at every other
  point of that region.
- `IsLocallyPositiveDefiniteAt` is a neighborhood statement. Region-level
  positivity implies it only when the region is itself a neighborhood. This
  keeps local information distinct from a global certificate.
- `IsWeakLyapunovDecreaseOn` and `IsStrictLyapunovDecreaseOn` are separate
  region-scoped predicates. Neither hides forward invariance. Strict decrease
  away from a fixed point implies weak decrease, but strict descent is not used
  as an attraction theorem.
- Weak decrease plus `Set.MapsTo f S S` preserves open and closed sublevels,
  bounds every iterate value by the initial value, and makes the scalar orbit
  antitone. These conclusions concern the certificate values, not convergence
  of the state.
- `HasSublevelControlAt` is an explicit global comparison hypothesis: every
  requested metric ball around the reference point contains a positive open
  sublevel of the certificate. Pointwise positive definiteness alone does not
  supply that uniform separation on an arbitrary noncompact or
  infinite-dimensional pseudo-metric space.
- The stability endpoint assumes fixedness, zero reference value, continuity
  at the reference point, global sublevel control, and global weak decrease.
  Its conclusion is the existing local `IsLyapunovStableFixedPoint` predicate.
- The point-attraction endpoint separately assumes that the certificate along
  the selected orbit tends to zero. Universal zero-certificate convergence
  yields the existing global-attraction predicate. The asymptotic-stability
  wrapper combines the local stability argument with that stronger universal
  limit without treating the obligations as equivalent.

Compact trapping theorems, the discrete LaSalle invariance principle,
coercive or radially unbounded global criteria, comparison-function rates,
converse Lyapunov theorems, invariant-set and periodic-orbit criteria, ODE
Lyapunov theory, stochastic robustness, stable manifolds, and Lyapunov
exponents remain outside this first slice. In particular, a strictly
decreasing real sequence can converge to a positive limit, so strict one-step
descent alone is not promoted to attraction on a noncompact space.

The mathematical anchors are J. P. LaSalle, “Difference Equations. Discrete
Semidynamical Systems,” especially sections 6, 7, and 10 of Chapter 1, pages
1–25, DOI
[`10.1137/1.9781611970432.ch1`](https://doi.org/10.1137/1.9781611970432.ch1),
and Saber Elaydi, “Stability Theory,” Chapter 4 of *An Introduction to
Difference Equations*, third edition, especially Theorems 4.20 and 4.24, DOI
[`10.1007/0-387-27602-5_4`](https://doi.org/10.1007/0-387-27602-5_4).
S. P. Gordon’s converse result, DOI
[`10.1137/0310007`](https://doi.org/10.1137/0310007), corroborates the semantic
separation between positive-definite certificates with negative-semidefinite
difference and stronger asymptotic conclusions. Pinned Mathlib 4.32.0 at
revision `81a5d257` supplies the exact `IsMinOn`, `IsLocalMin`, neighborhood,
`Set.MapsTo.iterate`, function-iterate, antitone-sequence, and metric-limit
APIs used by the checked source.

The paired public bundle is
`lyapunov-functions-for-discrete-systems-in-lean`,
`lyapunov-functions-and-the-direct-method-in-discrete-time`, and
`lyapunov-function`. It includes a `Std`-only countdown tutorial, five
conceptual figures, and three deterministic 1200x630 cards. The standalone
tutorial passes Lean 4.32.0, the Notebook coverage gate maps all 44 substantive
modules, the 158-file teaching-source audit passes, the 760-surface public
reader-language audit passes, all SVGs pass XML validation, and all three card
generators reproduce byte-for-byte. The 241-line source exposes 22 public
declarations and six axiom reports. Its warning-fatal Linux-checked SHA-256 is
`98e29093c7941935404f4bc3809fba4efd58b6ce993f31829118573165d70f5f`.
Every axiom report contains only `propext`, `Classical.choice`, and
`Quot.sound`; none contains `sorryAx`.

Approved Linux validation used RunPod Secure Cloud with 8 vCPU, an effective
32-GB cgroup RAM limit, an 80-GB ephemeral disk, and the retained project
network volume at $0.32 per hour. The retained Elan and pinned-manifest Lake
archives passed their SHA-256 manifests and `zstd -t` before being restored
sequentially onto ephemeral disk; the network volume was not used as a live
`.lake` tree. `CLOUD_LEAN_BUILD=1 make lean-file
LEAN_FILE=NonlinearDynamics/Deterministic/Discrete/Lyapunov.lean` passes
warning-fatal, as does the deterministic aggregator. The final
`CLOUD_LEAN_BUILD=1 make -j1 check` completes all 3,221 Lean jobs, the
checkpoint and 44-module coverage gates, 23 coverage regression tests, seven
teaching-hygiene regression tests, the 158-file teaching audit, the 760-surface
reader-language audit, and a warning-fatal 462-page Hugo Extended 0.160.1
render.

Workstation browser inspection passes for the Notebook, Deep Dive, and
glossary page at 1440x1000 and at a literal 390x844 viewport. Each has one
`h1`, no horizontal page overflow, no missing image alt text, no broken images
after lazy figures enter the viewport, no KaTeX or raw-delimiter errors, and no
console warnings or page errors. The mobile documents have equal 390-pixel
client and scroll widths, and direct visual inspection confirms contained,
legible responsive layouts. All five SVGs also open and render directly. The
temporary Hugo server and headless browser were stopped after QA.

Release closure on 2026-08-06: milestone commit `29f7598` reached
`origin/main`. The successful ephemeral `.lake` tree was archived sequentially
as `lake-manifest-pinned-lyapunov-20260806.tar.zst` on the retained volume
without replacing prior validated archives. The new 2.4-GB compressed archive
expands to 8,072,038,400 bytes and passes `zstd -t`; it and the retained Lean
4.32.0 toolchain archive both pass
`SHA256SUMS-lyapunov-20260806`. The builder ran for 897 seconds at $0.32 per
hour, approximately $0.08 of compute spend. The exact task pod was then
terminated. A post-action inventory reports zero task pods and one retained
project network volume. No cloud resource identifier or credential is
recorded here.

### Deterministic discrete conjugacy validated

The completed vertical slice replaces the one-line
`NonlinearDynamics.Deterministic.Discrete.Conjugacy` placeholder with an
explicit hierarchy built on Mathlib's `Function.Semiconj`.

The selected interface makes four levels distinct:

- raw `Function.Semiconj φ f g` is the algebraic commuting-square equation
  `φ (f x) = g (φ x)`. It transports each natural-number iterate, fixed points,
  and specified periods forward without a topology, but does not recover a
  source orbit from its image;
- `IsTopologicalSemiconjugacy` adds continuity but deliberately not
  surjectivity. Continuity at an orbit's limiting point is the exact local
  hypothesis used by the weaker attraction-transport theorem;
- `IsTopologicalFactorMap` adds surjectivity. That gate lets a globally
  attracting source fixed point cover every target initial state, while still
  allowing distinct source phases to collapse; and
- `IsTopologicalConjugacy` uses a specified homeomorphism, while
  `AreTopologicallyConjugate` existentially records the equivalence relation.
  The continuous inverse supplies reverse semiconjugacy, so corresponding
  fixed points, specified periods, attracted orbits, point basins, and local or
  global attracting fixed points agree in both directions.

The draft does not claim preservation of the project's moving-reference
`IsForwardStableAt` predicate. That predicate is an equicontinuity statement
on a uniform space; an arbitrary homeomorphism on a noncompact space need not
be uniformly continuous along the entire reference orbit. A later transport
theorem would need a `UniformEquiv`, explicit bi-uniform continuity, or an
appropriate compactness hypothesis. The slice also makes no claim about
distances, Lipschitz or contraction constants, convergence rates, set
`infDist`, entropy, transitivity, mixing, structural stability, measure
conjugacy, ODE flows, or algorithms for finding a conjugacy.

The primary definition anchor is Volodymyr Nekrashevych, *Groups and
Topological Dynamics*, AMS Graduate Studies in Mathematics 223 (2022), Chapter
1, section 1.1, Definition 1.1.4, page 7, DOI
[`10.1090/gsm/223`](https://doi.org/10.1090/gsm/223). It defines a
semiconjugacy as a continuous equivariant map and the homeomorphic case as a
topological conjugacy. Richard A. Holmgren, *A First Course in Discrete
Dynamical Systems*, Chapter “The Logistic Function, Part II: Topological
Conjugacy,” pages 95-103, DOI
[`10.1007/978-1-4684-0222-3`](https://doi.org/10.1007/978-1-4684-0222-3),
supplies a concrete discrete-map treatment. Pinned Mathlib 4.32.0 at revision
`81a5d257` supplies `Function.Semiconj`, `Semiconj.iterate_right`, inverse
semiconjugacy, fixed- and periodic-point transport, `Homeomorph`, and
neighborhood-image APIs.

The planned finite teaching model is the four-state clockwise direction cycle
projected onto the two-state vertical/horizontal toggle. The projection is
continuous and surjective in the discrete topology and satisfies the
commuting-square equation, but it identifies north with south and east with
west. Thus source points of least period four map to points of least period
two: a semiconjugacy preserves a specified period equation but may reduce the
least period. An invertible two-state relabeling supplies the contrasting
conjugacy example.

The paired public bundle is
`conjugacies-and-semiconjugacies-for-discrete-systems-in-lean`,
`conjugacy-semiconjugacy-and-orbit-transport-in-discrete-time`, and
`semiconjugacy-and-conjugacy`. It includes a `Std`-only four-state factor
tutorial, five conceptual figures, and three deterministic 1200x630 cards.
The standalone tutorial passes Lean 4.32.0, the Notebook coverage gate maps
all 45 substantive modules, the 161-file teaching-source audit passes, the
775-surface public reader-language audit passes, all eight SVGs pass XML
validation, and all three card generators reproduce byte-for-byte. The
252-line source exposes 20 public declarations and six axiom reports. Its
warning-fatal Linux-checked SHA-256 is
`d0ed8eadee33f2716210e12a57a15a51fc08e37a6bdab1f8d5039062d9fa9d34`.
Every axiom report contains only `propext`, `Classical.choice`, and
`Quot.sound` as applicable; none contains `sorryAx`.

Approved Linux validation used RunPod Secure Cloud with 8 vCPU, an effective
32-GB cgroup RAM limit, an 80-GB ephemeral disk, and the retained project
network volume at $0.32 per hour. The retained Elan and Lyapunov-milestone
pinned-manifest Lake archives passed their recorded SHA-256 checks, and the
Lake archive passed `zstd -t`, before both were restored sequentially onto
ephemeral disk; the network volume was not used as a live `.lake` tree. The
source-only tree is based on commit `ccff08a` with the checked Conjugacy source
checksum above. `CLOUD_LEAN_BUILD=1 make lean-file
LEAN_FILE=NonlinearDynamics/Deterministic/Discrete/Conjugacy.lean` passes
warning-fatal, as does the deterministic aggregator. The final
`CLOUD_LEAN_BUILD=1 make -j1 check` completes all 3,221 Lean jobs, the
checkpoint and 45-module coverage gates, 23 coverage regression tests, seven
teaching-hygiene regression tests, the 161-file teaching audit, the
775-surface reader-language audit, and a warning-fatal 473-page Hugo Extended
0.160.1 render.

Workstation browser inspection passes for the Notebook, Deep Dive, and
glossary page at 1440x1000 and at a literal 390x844 viewport. Each has one
`h1`, no horizontal page overflow, no missing image alt text, no broken images
after lazy figures enter the viewport, no raw TeX delimiters, and no console
warnings or page errors. The mobile documents have equal 390-pixel client and
scroll widths, and direct visual inspection confirms contained, legible
responsive layouts. All five conceptual SVGs also render directly. The
temporary Hugo server and browser session were stopped after QA.

Release closure on 2026-08-06: milestone commit `c67524d` reached
`origin/main`. The successful ephemeral `.lake` tree was archived sequentially
as `lake-manifest-pinned-conjugacy-20260806.tar.zst` on the retained volume
without replacing prior validated archives. The new 2,469,347,763-byte
compressed archive expands to an 8,073,041,920-byte tar stream and passes
`zstd -t`; it and the retained Lean 4.32.0 toolchain archive both pass
`SHA256SUMS-conjugacy-20260806`. The builder ran for 715 seconds at $0.32 per
hour, approximately $0.06 of compute spend. The exact task pod was then
terminated. A post-action inventory reports zero task pods and one retained
project network volume. No cloud resource identifier or credential is
recorded here.

## Validated ODE Lyapunov Milestone

### ODE Lyapunov interface decision and validated release

The next dependency-ordered source milestone is
`NonlinearDynamics.Deterministic.ODE.Lyapunov`. It should consume the checked
continuous-time Stability interface and introduce scalar certificates at an
equilibrium without rebuilding flows or attraction. The first interface should
separate positive definiteness from monotonicity along every nonnegative-real
orbit, weak descent from strict descent, and a stability theorem from any
stronger attraction conclusion. Research must identify the pinned Mathlib
topological and differentiable APIs before deciding whether Lie-derivative or
vector-field corollaries belong in the same slice. No derivative sign condition
should be presented as sufficient until its regularity, invariant-region, and
sublevel-control hypotheses are explicit and compile checked.

Validated release status on 2026-08-08: the placeholder now contains a
trajectory-level direct-method interface, and its paired Development Notebook,
Deep Dive, and orbital-derivative glossary bundles are private drafts with
`pro_reviewed: false`. Initial candidate commit `7032894` is on `origin/main`;
closure commit `30172c7` is on `origin/main`, and its warning-fatal source has
checksum
`50154741063f7b233ed9a3092c06747a88239a2d9cb465df0e02d447a9c12b99`.
The 53-module coverage gate, content regression tests, 190-file teaching
hygiene scan, 908-file public reader-language scan, 493-page production Hugo
graph, and 560-page draft-inclusive graph pass on the workstation. All eight
new SVGs parse, all three card generators pass ShellCheck and reproduce their
1200-by-630 PNGs byte-for-byte, and direct raster inspection found and repaired
one label collision in the proof-obligation figure. No Lean or Lake command
has run on macOS.

Approved Linux validation used a RunPod Secure Cloud CPU builder
with 8 vCPU, an effective 32-GB cgroup RAM limit, an 80-GB ephemeral disk, and
the retained project network volume at $0.32 per hour. The retained Lean 4.32.0
toolchain and ODE Stability Lake archives pass their recorded SHA-256 checks
and independent `zstd -t` validation before sequential restoration onto
ephemeral disk; the network volume is not a live `.lake` tree. Against the
checksum above, the guarded warning-fatal Lyapunov leaf passes in 3.8 seconds,
all reported axioms are limited to `propext`, `Classical.choice`, and
`Quot.sound`, and the deterministic aggregator passes in 4.0 seconds. The
repair changes only equality orientation, real-time normalization, and the
explicit `nhds` spelling; it does not change the five public interface
decisions below. The authoritative `CLOUD_LEAN_BUILD=1 make -j1 check` gate on
exact commit `30172c7` completes all 3,269 Lean jobs, the checkpoint and
53-module coverage gates, 23 coverage regression tests, seven teaching-hygiene
regression tests, the 190-file teaching audit, the 908-file reader-language
audit, and warning-fatal 493-page production plus 560-page draft-inclusive Hugo
Extended 0.160.1 renders.

Release closure: the successful ephemeral `.lake` tree is preserved
sequentially as
`lake-manifest-pinned-ode-lyapunov-20260808.tar.zst` on the retained volume.
The 2,475,841,621-byte compressed archive expands to an 8,092,252,160-byte tar
stream, passes `zstd -t`, and shares a passing SHA-256 ledger with the pinned
Lean 4.32.0 toolchain archive. The builder ran for 1,159 seconds at $0.32 per
hour, approximately $0.10 of compute spend under the $5 ceiling. The exact
task pod was then terminated; its direct lookup is absent, and a post-action
inventory reports zero task pods and one retained project network volume. No
cloud resource identifier or credential is recorded here.

Rendered browser QA passes for all three draft teaching pages at 1440x1000
and a literal 390x844 viewport. Each page has exactly one `h1`, no horizontal
page overflow, no broken image, no KaTeX error or raw TeX residue, and no
browser-console warning or error. Code blocks remain contained at the mobile
breakpoint, and direct visual inspection confirms legible responsive titles,
metadata, source panels, and conceptual figures. This browser pass used only
the workstation-safe Hugo draft server; it did not invoke Lean or Lake.

The candidate records five interface decisions:

1. **Shared spatial certificates:** nonnegativity, positive definiteness,
   local positive definiteness, and quantitative sublevel control are aliases
   of the checked discrete predicates because none depends on the time
   parameter. Continuous-time descent is defined separately.
2. **Exact forward-time quantifier:** weak descent quantifies over every real
   `t ≥ 0`; strict descent excludes time zero and uses every `t > 0`. A
   forward-invariant region remains a distinct input. Weak descent preserves
   its open and closed sublevels and makes the orbital scalar trace antitone on
   the complete nonnegative half-line.
3. **Separate endpoints:** continuity at an equilibrium, zero scalar value,
   sublevel control, and global weak descent prove the existing
   `IsLyapunovStableEquilibrium` predicate. Attraction is not inferred from
   descent; it comes from the separate limit
   `V (ϕ t x) → 0`, either for one orbit, a neighborhood, or every state.
   The asymptotic-stability theorem consumes both paths explicitly.
4. **Derivative boundary:** `lyapunovDerivativeAlong` is the ordinary real
   derivative of `t ↦ V (ϕ t x)`. The weak sign bridge carries
   differentiability explicitly and uses pinned Mathlib's
   `antitone_of_deriv_nonpos`; the strict bridge uses
   `strictAnti_of_deriv_neg`. A manifold Lie derivative and the chain rule
   from `IsIntegralCurveFlow` to `DV[F]` are deferred until their scalar and
   manifold regularity hypotheses receive a separate checked interface.
5. **Strict-descent nonimplication:** the translation flow with `V x = -x`
   strictly decreases at every positive time but has no equilibrium. This
   checked candidate boundary targets only the invalid implication from strict
   scalar descent alone; it does not weaken a theorem that assumes equilibrium,
   positivity, regularity, and sublevel control.

The mathematical authorities are Bhatia and Szegő, *Dynamical Systems:
Stability Theory and Applications*, Lecture Notes in Mathematics 35, Springer
(1967), especially the second-method treatment on pages 246–367, DOI
[`10.1007/BFb0080630`](https://doi.org/10.1007/BFb0080630), and J. P. LaSalle,
*The Stability of Dynamical Systems*, SIAM CBMS 25 (1976), DOI
[`10.1137/1.9781611970432`](https://doi.org/10.1137/1.9781611970432). The
formal API authorities are pinned Mathlib 4.32.0
[`Analysis.Calculus.Deriv.MeanValue`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Analysis/Calculus/Deriv/MeanValue.lean)
and
[`Dynamics.Flow`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/Flow.lean).

## Exact Next Milestone

### Formalize the discrete logistic map

The next dependency-ordered source milestone is
`NonlinearDynamics.Deterministic.Models.LogisticMap`. Begin from the exact real
polynomial map `x ↦ r * x * (1 - x)` and audit pinned Mathlib's interval,
polynomial, derivative, and fixed-point APIs before freezing the interface.
The first slice should prove its named fixed points with all parameter
side-conditions visible, establish a precisely scoped invariant-interval
regime, and connect only those stability, attraction, bifurcation, or symbolic
claims that the existing checked interfaces genuinely discharge. Parameter
boundaries such as `r = 0`, coincident fixed points, and escape outside the
invariant regime must remain explicit. A complete Notebook, concrete diagram,
Deep Dive or glossary integration, warning-fatal Linux checks, and a boundary
countermodel are required before marking the model complete.

## Earlier Milestone Records

### ODE stability interface decision and validated release

Status on 2026-08-08: repaired closure commit `33d6b6f` and validation-record
commit `82a474b` pass their exact complete guarded repository gates. The
warning-fatal leaf, deterministic aggregator, workstation gate, deterministic
asset checks, and desktop/mobile browser inspection are green. The successful
cache is preserved and verified on retained storage, the exact task pod is
terminated, and the roadmap item is complete.

The candidate consumes Mathlib's structured `Flow ℝ X` interface and makes
four choices explicit:

1. **Reference object:** `IsForwardStableAt ϕ p` is stability of a reference
   orbit, defined as equicontinuity at `p` of the family of time maps. It does
   not require `p` to be stationary. `IsEquilibrium ϕ p` is a separate
   predicate, and `IsLyapunovStableEquilibrium ϕ p` is their conjunction.
2. **Time domain:** the stability family is indexed by
   `AddSubmonoid.nonneg ℝ`, so one neighborhood controls every real time
   `t ≥ 0`, including zero. Negative-time maps exist in the ambient real flow
   but are not included in the forward-stability quantifier. Attraction uses
   the real order filter `atTop`, not a natural-number sampling of the orbit.
3. **Topological level:** the primary stability definition uses uniform-space
   equicontinuity. A pseudo-metric equivalence exposes the standard
   epsilon-delta statement. The attraction definition needs only the topology;
   the theorem that an orbit limit is an equilibrium adds Hausdorff separation
   and deliberately consumes continuity and the additive flow law.
4. **Conjunction boundary:** local attraction means that the point basin is a
   neighborhood of an equilibrium. Asymptotic stability means Lyapunov
   stability plus that local basin condition. Neither stability nor attraction
   is silently substituted for the other.

The source candidate adds exact translation and identity boundaries. A
constant-velocity nonzero translation flow is forward stable at every
reference point but has no equilibrium. Every point of the identity flow is a
Lyapunov-stable equilibrium, while a distinct constant orbit is not attracted
to it. A common `LipschitzWith 1` bound on all nonnegative-time maps is recorded
as a sufficient criterion for forward stability. For a Hausdorff flow, a
finite forward orbit limit is proved to be an equilibrium by transporting the
limit through a fixed-time map, rewriting with `Flow.map_add`, and comparing
with the time-translated original limit.

This interface does not define invariant-set, exponential, input-to-state, or
stable-manifold theory. It fixes one deterministic flow and therefore does not
express structural stability under changes of a vector field. It also does
not alter the separately selected RMT-36 meaning of stochastic stability,
which is sequential upper semicontinuity of an integrated random-cocycle
growth rate within a specified bounded invertible generator class. The two
interfaces have different inputs, perturbation topologies, and conclusions.

The mathematical references for the decision are N. P. Bhatia and G. P.
Szegő, *Dynamical Systems: Stability Theory and Applications*, Lecture Notes
in Mathematics 35, Springer (1967), DOI
[`10.1007/BFb0080630`](https://doi.org/10.1007/BFb0080630), and J. P. LaSalle,
*The Stability of Dynamical Systems*, SIAM CBMS 25 (1976), DOI
[`10.1137/1.9781611970432`](https://doi.org/10.1137/1.9781611970432). The exact
formal API authorities are pinned Mathlib 4.32.0
[`Mathlib.Dynamics.Flow`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/Flow.lean),
[`Topology.UniformSpace.Equicontinuity`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Topology/UniformSpace/Equicontinuity.lean),
and
[`Topology.MetricSpace.Equicontinuity`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Topology/MetricSpace/Equicontinuity.lean).

The paired public working-note candidate is
`stability-and-attraction-for-ode-flows-in-lean`,
`continuous-time-stability-attraction-and-equilibria`, and
`continuous-time-stability`. It contains five page-owned accessible
conceptual SVGs and three deterministic 1200x630 cards. The complete
workstation gate passes with 52/52 Notebook coverage, 23 coverage regression
tests, seven teaching-hygiene regression tests, a 187-file teaching-source
scan, an 894-surface public reader-language scan, and a warning-fatal 553-page
Hugo Extended 0.160.1 render. All new SVGs pass XML validation and all three
card generators reproduce byte-for-byte. Literal browser QA at 1440x1000 and
390x844 passes on all three routes: every page has one `h1`, equal client and
scroll widths, complete images with nonempty alt text, no raw TeX delimiters,
no KaTeX errors, and no console warnings or errors. Wide declaration tables
and Lean commands remain inside local horizontal-scroll regions on mobile
rather than expanding the page. Direct top-and-bottom visual inspection finds
the card, conceptual figures, prose, references, and mobile navigation
contained and legible. The temporary viewport override was reset and the QA
tab and Hugo server were closed afterward. The warning-fatal Linux-checked
source SHA-256 is
`270cf7a6d17f11af10c421a4351ce4c96b1cd6df59f806713317e25237c5a6c6`.

Approved Linux validation on 2026-08-08 used RunPod Secure Cloud. Two approved
CPU3 General Purpose allocations at 8 vCPU, 32 GB RAM, 80 GB ephemeral disk,
and $0.320 per hour never obtained a container network: provider logs repeated
`network must exist`, runtime uptime remained zero, restart and stop/start did
not recover the allocation, and each exact task pod was terminated without
touching the retained project volume. The approved CPU5 replacement uses the
same vCPU, RAM, disk, and retained volume at $0.368 per hour and started
normally. The retained ToFlow toolchain and Lake archives passed their SHA-256
ledgers and full `zstd -t` checks before extraction onto ephemeral disk.

The first warning-fatal Stability leaf exposed three local API/proof defects:
the translation flow lacked the import that supplies the real topological-ring
instances, its nonexpansive proof left the reflexive absolute-value inequality
open, and the orbit-limit argument tried to compose a `ContinuousAt` theorem
with a general `Tendsto`. The repair imports
`Mathlib.Topology.Algebra.Ring.Real`, closes the metric inequality with
`le_rfl`, and composes `(continuous_toFun s).tendsto p` with the orbit limit.
The repaired warning-fatal leaf passes in one second, its nine axiom reports
contain only `propext`, `Classical.choice`, and `Quot.sound`, and none contains
`sorryAx`. The warning-fatal deterministic aggregator passes in two seconds.
The complete working-tree `CLOUD_LEAN_BUILD=1 make -j1 check` gate passes in
13 seconds under Lean 4.32.0 and checksum-verified Hugo Extended 0.160.1: all
3,269 Lean jobs, 52/52 Notebook coverage, 23 coverage regression tests, seven
teaching-hygiene regression tests, the 187-file teaching-source audit, the
894-surface public-reader audit, and the warning-fatal 553-page render pass.

Repaired closure commit `33d6b6f` reached `origin/main`. Its deterministic Git
archive has SHA-256
`13ae935d9fae0da40271bac9faead0c27168eac9b14ce7ae646136e4927129cb`.
A fresh source-only extraction of that exact commit received the verified
ephemeral cache; its manifest and Stability source hashes match the values
recorded above. The exact closure commit passes the same complete guarded gate
in nine seconds with all 3,269 Lean jobs and every source-and-teaching check
green.

The successful exact-closure `.lake` tree is archived sequentially as
`lake-manifest-pinned-ode-stability-20260808.tar.zst`. The 2,476,741,377-byte
compressed archive expands to an 8,090,163,200-byte tar stream and passes
`zstd -t` both on ephemeral disk and after its copy to retained storage. Its
SHA-256 is
`a980090c4457be1886c42a09442e15b2f7d9b8d610faac754735cbb4ef3551b7`.
The retained ledger `SHA256SUMS-ode-stability-20260808` verifies that archive
and the unchanged Lean 4.32.0 toolchain archive together. Earlier retained
archives were not replaced.

Validation-record commit `82a474b` reached `origin/main` and passes the same
exact complete guarded gate in nine seconds. The healthy CPU5 builder ran for
1,587 seconds at $0.368 per hour, approximately $0.16 of compute spend. The
two failed CPU3 allocations both reported zero runtime uptime; this checkpoint
does not infer the provider's final invoice for them. After the final gate the
exact CPU5 task pod was terminated. A post-action inventory reports zero task
pods and one retained project network volume. No cloud resource identifier,
address, or credential is recorded here.

### ODE ToFlow design decision and validated release

The substantive module
`NonlinearDynamics.Deterministic.ODE.ToFlow` selects the unique global
integral curve through each point, proves the restart identity by applying
Mathlib's time-translation lemma and the checked uniqueness interface, and
packages the resulting identity and additive-action laws. The construction of
`Flow ℝ M` takes joint continuity of the uncurried time-and-state map as an
explicit hypothesis. This is the canonical stochastic-stability-adjacent
design decision for the deterministic ODE layer: uniqueness owns the
algebraic flow laws, while continuous dependence owns the topology. The
module does not infer joint continuity from continuity of each individual
time curve and does not claim smooth parameter dependence.

On the approved Linux builder, the warning-fatal ToFlow leaf and the
warning-fatal deterministic aggregator pass. The paired private-draft
teaching bundle includes a Development Notebook, the Deep Dive "From Global
Integral Curves to Topological Flows", and substantive glossary entries for
flow and continuous dependence on initial conditions. Workstation validation
passes the 51-module coverage gate, teaching-source audit, public-reader
language audit, and warning-fatal 548-page Hugo Extended 0.160.1 render.
Browser inspection passes for all four pages at 1440 by 1000 and at a literal
390 by 844 viewport: each has one `h1`, equal client and scroll widths, loaded
lazy images with alt text, no raw TeX delimiters, and no console warnings or
errors. The warning-fatal source SHA-256 is
`01994837eefd5c21d00ff9fcd8f118db9a48d186c2a5333ef65fe9a20072ac16`.

Candidate commit `f65311e` reached `origin/main`. A deterministic SHA-256
ledger over all tracked file contents is
`f7b6886e403908042885ab3f86cb8012ab40bd496e03e10aa2e3a2ca5fc6d305`
on both the workstation and approved Linux builder. The exact candidate
passes the complete guarded gate under Lean and Mathlib 4.32.0 with Hugo
Extended 0.160.1: all 3,269 Lean jobs, 51/51 Notebook coverage, 23 coverage
regression tests, seven teaching-hygiene regression tests, the 184-file
teaching-source scan, the 880-surface public-reader language audit, and a
warning-fatal 548-page Hugo render. The ToFlow leaf passes in 3.103 seconds
and the warning-fatal deterministic aggregator passes in 2.757 seconds. The
four ToFlow axiom reports contain only `propext`, `Classical.choice`, and
`Quot.sound`; none contains `sorryAx`.

The successful ephemeral `.lake` tree was archived sequentially as
`lake-manifest-pinned-ode-to-flow-20260807.tar.zst` without replacing prior
retained archives. The 2,500,886,828-byte compressed file expands to an
8,089,333,760-byte tar stream and passes `zstd -t` both before and after its
copy to retained storage. Its SHA-256 is
`7941f2fc6e35f856fc03524464464a344f8a07889bd7be729ce76aaa14e50ae5`.
The retained Lean 4.32.0 toolchain archive remains unchanged at SHA-256
`c3597a30210c18bc87b7b3472e83204629445f15f324c65167d095caaa1a2332`;
both entries are recorded in `SHA256SUMS-ode-to-flow-20260807`.

### ODE global-existence convention and validated release

The current source candidate is
`NonlinearDynamics/Deterministic/ODE/GlobalExistence.lean`. It chooses
Mathlib's manifold integral-curve interface and separates local solution
existence from continuation to a global time domain. The continuation gate is
one uniform positive local-time radius through every point, not an unsupported
project-local linear-growth theorem. Under continuous differentiability on a
boundaryless manifold, pinned Mathlib upgrades that gate to global curves and
supplies uniqueness separately. At one initial point it identifies global
existence with curves on every symmetric finite interval. The source does not
present local regularity alone as a blanket global-existence theorem.

The paired private-draft teaching bundle contains “Global Integral Curves from
Uniform Local Time in Lean”, the Deep Dive “Local Existence, Uniform Time, and
Global Integral Curves”, and substantive vector-field and integral-curve
glossary chapters. Four deterministic social cards and four conceptual SVGs
teach the smooth finite-time blow-up boundary, quantifier order, constant
zero-field curve, and separation of existence from uniqueness. Every new page
is `draft: true` and `pro_reviewed: false`.

The warning-fatal Linux-checked source SHA-256 is
`ce3e3f6bc4aecf83dffa4b10481487cbba1ba8c8e27d0a9c47a4c6339764c862`.
The first leaf run exposed three unused-section-variable lints. The repaired
source places explicit `omit` scopes around four restriction and constant-curve
theorems whose statements do not consume the ambient manifold or separation
instances. The second warning-fatal leaf passes in 1.89 seconds. Its four axiom
reports contain only `propext`, `Classical.choice`, and `Quot.sound`; none
contains `sorryAx`, and the module contains no `sorry` or `admit`. The
warning-fatal `NonlinearDynamics/Deterministic.lean` aggregator passes in 1.38
seconds.

Candidate commit `9f8b251` reached `origin/main`. Its exact Git archive has
SHA-256 `7a0f2e00eb05ac94710967797f69fd49ff7c77c71caa9c9e3c580e53336f41f0`
on both the workstation and approved Linux builder, and its extracted ODE
source matches the documented SHA-256. The exact candidate passes the complete
guarded gate under Lean and Mathlib 4.32.0 with Hugo Extended 0.160.1: 3,268
Lean jobs, 50/50 Notebook coverage, 23 coverage regression tests, seven
teaching-hygiene tests, the 180-file teaching scan, the 862-surface public-
reader scan, and a warning-fatal 540-page render. The full gate completed in
11.92 seconds.

Validation-record commit `597ba49` reached `origin/main`. Its exact Git archive
has SHA-256
`b446b80b884e7d437d1d7e52cc45e513c1ed8819840e2ccf3defbff8c08345a6`
on both the workstation and builder, and its ODE source retains the documented
SHA-256. The exact validation record passes the same complete guarded gate:
3,268 Lean jobs, 50/50 coverage, 23 coverage tests, seven hygiene tests, the
180-file teaching scan, the 862-surface reader scan, and the warning-fatal
540-page Hugo render. That replay completed in 8.20 seconds.

Workstation-safe validation passes: 50/50 substantive-module Notebook
coverage, 23 coverage regression tests, seven teaching-hygiene tests, the
180-file teaching scan, the 862-surface public-reader scan, and a warning-fatal
Hugo Extended 0.160.1 draft render of 540 pages. The four card generators
reproduce their 1200-by-630 PNGs byte for byte, all eight SVG files pass XML
validation, and `git diff --check` is clean. Rendered QA at the browser's
1280-by-720 viewport reports one H1, equal client and scroll widths, no broken
or alt-less images, no raw TeX or KaTeX errors, and no console warnings or
errors on the Notebook, Deep Dive, and both glossary pages. A later Chrome
session supplied a literal 390-by-844 viewport for the same four routes. Each
document reports 390-pixel client and scroll widths, one H1, two complete
images with nonempty alt text, zero raw TeX delimiters, zero KaTeX errors, and
zero console warnings or errors. Every code block and table wider than its
container uses local horizontal scrolling rather than expanding the page.
Direct top-and-bottom visual inspection confirms contained, legible layouts,
and the mobile menu opens to expose all four primary links and closes again.
The temporary viewport override was reset and the browser tab and Hugo server
were closed after QA.

The successful ephemeral `.lake` tree is archived as
`lake-manifest-pinned-ode-global-existence-20260807.tar.zst`. The archive is
2,582,373,338 bytes compressed and expands to an 8,087,715,840-byte tar stream.
Its ephemeral and sequential retained-volume copies both have SHA-256
`a06793bf03da5ea1480a9bd78bf07ae32d84ebbd8718877c384955aafececa86`
and pass full `zstd -t` verification. The retained ledger
`SHA256SUMS-ode-global-existence-20260807` verifies after final naming. Earlier
archives remain intact, and the retained volume was never used as a live
`.lake` tree.

The approved builder ran for 923 seconds at $0.32 per hour, approximately
$0.08 of compute spend under the $5 ceiling. The exact task pod was terminated.
A post-action inventory reports zero task pods and one retained project network
volume. No cloud resource identifier, connection address, or credential is
recorded here.

The later `ODE/ToFlow.lean` consumer remains outside this milestone; no global flow,
invertibility, smooth parameter dependence, maximal-interval theorem,
compactness criterion, or growth criterion is claimed.

### Symbolic Coding convention and validated release

`NonlinearDynamics/Deterministic/Chaos/SymbolicCoding.lean` is now a validated
source-and-teaching candidate rather than a placeholder. It chooses one-sided
sequences `ℕ → A` and defines the time-one shift by reusing Mathlib's
`SymbolicDynamics.FullShift.shift 1`. Finite prefix cylinders are explicitly
identified with Mathlib full-shift cylinders on `Finset.range n`, so their
openness and neighborhood-basis role come from the pinned library interface
instead of a duplicate topology.

The transitivity witness splices a requested target prefix after the source
prefix. Shifting by the source-prefix length recovers the target tail, which
gives a positive hitting time after choosing a nonzero prefix length. Repeating
a finite nonempty prefix gives a point with a positive period inside every
prefix cylinder. These constructions supply positive-time topological
transitivity and dense positive-period points for the full shift. Under a
nontrivial discrete alphabet, the compatible `PiNat` metric and the already
validated Banks theorem package those results as Devaney chaos. Alphabet
finiteness is deliberately not required for that theorem; it belongs to the
customary compact finite-alphabet setting, not to the splicing argument.

For a dynamical system `f : X → X` and observation `observe : X → A`, the
candidate defines the itinerary `n ↦ observe (f^[n] x)` and proves the exact
algebraic semiconjugacy to the shift. Continuity of the itinerary is a separate
theorem requiring continuity of both `f` and `observe`; surjectivity is a
further independent hypothesis that upgrades the map to a topological factor.
No arbitrary inverse, injectivity, conjugacy, finite-type presentation, mixing,
entropy, or Markov-partition consequence is claimed. The head observation on
the full shift is the boundary check: its itinerary is the identity and is
therefore both injective and surjective.

The paired private-draft teaching bundle consists of the Notebook entry
“One-Sided Symbolic Coding and the Full Shift in Lean”, the Deep Dive
“One-Sided Full Shifts, Cylinders, and Itineraries”, and glossary chapters for
symbolic dynamics and cylinder sets. Four deterministic 1200-by-630 cards and
six conceptual SVGs accompany the prose. The pages distinguish a sequence in
the full shift from an itinerary actually attained by a particular system and
distinguish algebraic semiconjugacy, continuous semiconjugacy, and surjective
factor-map gates. All remain `draft: true` and `pro_reviewed: false`.

The current source SHA-256 is
`5cde6756c1fc0dc56a7a66ed5cc559e24a145db1f2a09e8c0e04a9414cf30014`.
It contains no `sorry` or `admit`, and its warning-fatal leaf passes on the
approved Linux builder. The leaf repair qualifies the basis type through
`TopologicalSpace`, avoids the reserved parser token `prefix`, supplies the
expected function-space type for `PiNat.metricSpace`, and removes one redundant
simp argument. Axiom reports for transitivity, dense periodic points, Devaney
chaos, and the factor map contain only `propext`, `Classical.choice`, and
`Quot.sound`; none contains `sorryAx`. Candidate commit `6bf8517` and its exact
Git archive pass the deterministic aggregator and complete guarded gate: 3,223
Lean jobs, 49/49 Notebook coverage, 23 coverage regression tests, seven
teaching-hygiene tests, the 176-file teaching scan, the 846-surface
reader-language scan, and the warning-fatal 524-page Hugo Extended 0.160.1
render. That candidate gate was followed by the validation-record exact-commit
replay and integrity-checked preservation described below.

Validation-record commit `b16413e` reached `origin/main`; its exact Git archive
passed SHA-256 identity after source-only transfer and then passed the same
complete guarded gate. The successful ephemeral `.lake` tree is archived as
`lake-manifest-pinned-symbolic-coding-20260807.tar.zst`. The
2,644,002,101-byte compressed archive expands to an 8,085,217,280-byte tar
stream. Its ephemeral copy and sequential retained-volume copy both pass
SHA-256 and `zstd -t`, and retained ledger
`SHA256SUMS-symbolic-coding-20260807` passes independently. Earlier validated
archives remain intact, and the retained volume was never used as a live
`.lake` tree. The builder ran for 1,059 seconds at $0.32 per hour,
approximately $0.09 of compute spend under the $5 ceiling. The exact task pod
was then terminated. A post-action inventory reports zero task pods and one
retained project network volume. No cloud resource identifier or credential is
recorded here.

Workstation-safe candidate validation passes: 49/49 substantive-module
Notebook coverage, 23 coverage regression tests, seven teaching-hygiene tests,
the 176-file teaching scan, the 846-surface public-reader scan, and a
warning-fatal Hugo Extended 0.160.1 draft render of 524 pages. The four cards
reproduce byte-for-byte at 1200 by 630 pixels, all ten page-owned SVGs are
well-formed, and `git diff --check` is clean. Literal browser inspection at
1440 by 1000 and 390 by 844 covers all four pages with exactly one heading per
page, no horizontal overflow, broken or alt-less images, KaTeX errors, raw math
delimiters, or console warnings or errors. These non-Lean results complement
the passing warning-fatal leaf, aggregator, and full gate.

Primary and contextual references recorded with the decision:

- Douglas Lind and Brian Marcus, *An Introduction to Symbolic Dynamics and
  Coding*, second edition, Cambridge University Press, 2021,
  <https://doi.org/10.1017/9781108899727>.
- Marston Morse and Gustav A. Hedlund, “Symbolic Dynamics,” *American Journal
  of Mathematics* 60(4) (1938), 815–866,
  <https://doi.org/10.2307/2371264>.
- Gustav A. Hedlund, “Endomorphisms and Automorphisms of the Shift Dynamical
  System,” *Mathematical Systems Theory* 3 (1969), 320–375,
  <https://doi.org/10.1007/BF01691062>.
- Pinned Mathlib 4.32.0 sources
  `Mathlib.Dynamics.SymbolicDynamics.Basic` and
  `Mathlib.Topology.MetricSpace.PiNat`, which provide the reused full-shift,
  cylinder, basis, and compatible-metric infrastructure.

### Devaney convention and candidate validation

`formalization/NonlinearDynamics/Deterministic/Chaos/Devaney.lean` now defines
positive-time `IsTopologicallyTransitive`, positive-period
`HasDensePeriodicPoints`, the continuous `HasDevaneyCore`, and the historical
three-clause `IsDevaneyChaotic`. Both open-set properties carry explicit
`Nonempty X` evidence, so empty-space vacuity is not silently accepted. The
historical predicate remains the core together with metric sensitivity; the
project does not redefine Devaney chaos by dropping its third clause.

The design follows Devaney's second-edition three-clause presentation and
records the 1992 theorem of Banks, Brooks, Cairns, Davis, and Stacey as a named
implication rather than a definitional shortcut. `HasDevaneyCore.isSensitive`
uses `[MetricSpace X] [Infinite X]`; it obtains two disjoint finite periodic
orbits, fixes one positive separation scale, and then uses density,
transitivity, continuity, period alignment, and the triangle inequality. The
scale is chosen before the reference point and neighborhood. The finite-cycle
counterexample documents why infinitude cannot be omitted. Jacelon's 2023 use
of the reduced convention and Vejnar's 2026 survey are cited to explain why the
source provides both the historical package and an equivalence theorem under
the Banks hypotheses without conflating the two conventions.

The public API also supplies nonempty-open transitivity witnesses, open-set
periodic witnesses, equality after a common positive period, assembly of the
historical package, the equivalence between the historical and reduced forms
under the Banks hypotheses, the finite-metric obstruction, and the
no-isolated-points consequence. The exact source SHA-256 is
`52fe20359c5c07407e0d3e319a26e9c2dd593c97f88f1dc6b3acf9adc1abf39f`.
The warning-fatal Devaney leaf and deterministic aggregator pass on the
approved Linux builder. Axiom reports for the principal implication,
equivalence, and finite obstruction contain only `propext`,
`Classical.choice`, and `Quot.sound`; none contains `sorryAx`.

Candidate commit `4705233` reached `origin/main` before the full release gate.
Its exact Git archive passed SHA-256 identity after source-only transfer; the
remote tree contains no workstation `.git`, `.env`, `.lake` transfer,
generated Hugo output, credentials, or private artifacts. The retained
Sensitivity archive and ledger passed SHA-256 and `zstd -t` before sequential
restoration to ephemeral disk. The official Hugo Extended 0.160.1 Linux
archive passed its published checksum and matches the workstation release.
The complete `CLOUD_LEAN_BUILD=1 make -j1 check` gate passes: all 3,222 Lean
jobs, 48/48 Notebook coverage, 23 coverage regression tests, seven
teaching-hygiene tests, the 172-file teaching scan, the 828-surface
reader-language scan, and a warning-fatal 512-page Hugo render.

The successful ephemeral `.lake` tree is archived as
`lake-manifest-pinned-devaney-20260807.tar.zst`. The 2,582,425,378-byte
compressed archive expands to an 8,083,947,520-byte tar stream. Its ephemeral
copy and sequential retained-volume copy both pass SHA-256 and `zstd -t`; the
retained `SHA256SUMS-devaney-20260807` ledger passes independently. Earlier
validated archives remain intact, and the retained volume was never used as a
live `.lake` tree. Validation-record commit `e9fc6f5` reached `origin/main` and
then passed the same complete exact-commit cloud gate. The builder ran for
2,461 seconds at $0.32 per hour, approximately $0.22 of compute spend under the
$5 ceiling. The exact task pod was then terminated. A post-action inventory
reports zero task pods and one retained project network volume. No cloud
resource identifier or credential is recorded here.

The teaching bundle contains the Notebook entry “Devaney Chaos and the Banks
Implication in Lean”, the Deep Dive “Devaney Chaos, Transitivity, and Dense
Periodic Points”, glossary chapters for Devaney chaos, topological
transitivity, and dense periodic points, six accessible conceptual SVGs, and
five deterministic social cards. It begins with an exact three-cycle boundary
example, distinguishes definition from derived consequence, explains the
metric-versus-pseudometric boundary, and gives literal pinned-project Lean
commands. The five pages remain `draft: true` and `pro_reviewed: false`; no
professional review or publication claim is made.

Workstation-safe candidate validation passes: 48/48 substantive-module
Notebook coverage, 23 coverage regression tests, seven teaching-hygiene tests,
172 teaching Markdown files, 828 public-reader surfaces, and a warning-fatal
Hugo Extended 0.160.1 draft render of 512 pages. All five cards reproduce
byte-for-byte, all new SVGs are well-formed, and `git diff --check` is clean.
Browser inspection at 1440x1000 and a literal 390x844 viewport covers all five
pages with no page overflow, broken eager images, KaTeX errors, or raw display
delimiters. A responsive-caption conflict with inline KaTeX was repaired by
using equivalent plain-language captions; the page mathematics remains in the
surrounding prose.

Primary and contextual references recorded in the teaching bundle:

- Robert L. Devaney, *An Introduction to Chaotic Dynamical Systems*, second
  edition, Westview Press, 2003.
- John Banks, Jeff Brooks, Grant Cairns, Gary Davis, and Peter Stacey, “On
  Devaney's Definition of Chaos,” *American Mathematical Monthly* 99(4)
  (1992), 332–334, <https://doi.org/10.1080/00029890.1992.11995856>.
- Bhishan Jacelon, “Chaotic tracial dynamics,” *Forum of Mathematics, Sigma*
  11 (2023), e53, <https://doi.org/10.1017/fms.2023.38>.
- Benjamin Vejnar, “Topological dynamics and chaos,” *Bulletin of Symbolic
  Logic* (2026), <https://doi.org/10.1017/bsl.2026.10158>.

### Sensitivity convention and validated release

The source-and-teaching candidate now covers
`NonlinearDynamics.Deterministic.Chaos.Sensitivity` in
`formalization/NonlinearDynamics/Deterministic/Chaos/Sensitivity.lean`. It
uses the standard metric quantifier order

\[
\exists\delta>0\;\forall x\;\forall\varepsilon>0\;\exists y\;\exists n\in
\mathbb N,\qquad
d(y,x)<\varepsilon\quad\text{and}\quad
\delta<d(f^n(x),f^n(y)).
\]

The convention is deliberately metric-first. A topology supplies
neighborhoods but no canonical global separation scale. On noncompact spaces,
sensitivity can depend on the compatible metric. Good and Macías, “What is
topological about topological dynamics?”, *Discrete and Continuous Dynamical
Systems* 38(3) (2018), 1007–1031,
<https://doi.org/10.3934/dcds.2018043>, Theorem 3.2, supplies the compact
metric/uniform/Hausdorff equivalence that explains why those forms should not
be identified without hypotheses. A uniform-space companion is therefore
deferred until a consumer needs a sensitivity entourage and the accompanying
equivalence theorem.

The strict `δ < dist ...` inequality follows the common Devaney-style
presentation used by Banks, Brooks, Cairns, Davis, and Stacey, “On Devaney's
Definition of Chaos”, *American Mathematical Monthly* 99(4) (1992), 332–334,
<https://doi.org/10.1080/00029890.1992.11995856>. A weak `δ ≤ dist ...`
version gives the same existential property only after shrinking a positive
constant; it does not preserve the same named scale. Natural-number time
includes zero, matching a standard convention, while the source proves that a
witness whose initial distance is already below the scale must have positive
time. Akin and Kolyada, “Li–Yorke sensitivity”, *Nonlinearity* 16 (2003),
1421–1433, <https://doi.org/10.1088/0951-7715/16/4/313>, §3, anchors the
distinction between pointwise instability and a global sensitivity constant.
Auslander and Yorke, “Interval maps, factors of maps, and chaos”, *Tohoku
Mathematical Journal* 32 (1980), 177–188,
<https://doi.org/10.2748/tmj/1178229634>, pp. 181–182, is the historical
pointwise stability/instability reference.

`IsSensitiveWith` explicitly contains `Nonempty X`. Without this guard the
universal state quantifier would make the empty phase space sensitive
vacuously. The theorem suite includes scale monotonicity, distinct and
positive-time witnesses, ball/neighborhood equivalence under the fixed
pseudo-metric, the isolated-singleton obstruction, failure on discrete spaces
and finite genuine metric spaces, the resulting absence of isolated points,
pointwise incompatibility with the existing forward-stability interface,
nonexpansive and identity nonexamples, and the exact sensitive real doubling
map with scale one. Continuity, compactness, and surjectivity are theorem
hypotheses rather than hidden parts of the raw predicate.

The paired draft teaching bundle consists of the Development Notebook entry
“Sensitivity Scales for Discrete Systems in Lean”, the Deep Dive “Sensitivity
Quantifiers and the Symbolic Shift”, the glossary chapter “Sensitive
Dependence on Initial Conditions”, five accessible conceptual SVGs, three
deterministic social cards, and a standalone `Std` worksheet. A positive
finite metric-state example would be mathematically impossible because finite
metric spaces are discrete. The worksheet therefore uses infinite binary
streams with finite-prefix witnesses: it copies an arbitrary requested prefix,
flips the next bit, and shifts that bit to the head. Its second theorem refutes
selecting one separation time before the prefix depth. The exact standalone
Lean 4.32.0 check passes on the workstation. The worksheet does not formalize
the Cantor metric or by itself establish metric sensitivity of the shift.

The candidate keeps sensitivity separate from positive expansivity, mixing,
entropy, numerical roundoff, and finite-time divergence. It asserts no rate,
persistent separation, Lyapunov exponent, derivative growth, bounded witness
time as neighborhoods shrink, Devaney-chaos theorem, or arbitrary
topological-conjugacy invariance on noncompact spaces. Antunes and Carvalho,
“First-time Sensitive Homeomorphisms”, *Journal of Dynamics and Differential
Equations* 37 (2025), 2281–2321,
<https://doi.org/10.1007/s10884-024-10362-x>, Definitions 1.1–1.3, provides a
reference boundary between ordinary sensitivity and first-time control.

Validated source SHA-256:
`747205ab52e00260c89da63b10b4869144d066ea49266c55639467da2e56f83d`.
The pages remain `draft: true` and `pro_reviewed: false`; owner inspection and
publication authorization for this new bundle are pending.

Workstation-safe candidate validation passes. The standalone Lean 4.32.0
worksheet checks with no output. All three social cards reproduce byte for
byte and all SVGs are well-formed. `make workstation-check` reports 47/47
substantive-module Notebook coverage, 23 coverage regression tests, seven
teaching-hygiene tests, 167 teaching Markdown files, 806 public-reader
surfaces, and a warning-fatal Hugo Extended 0.160.1 draft render of 495 pages.
`git diff --check` is clean.

Browser inspection covers the Notebook, Deep Dive, and glossary page at
1440x1000 and at a literal 390x844 viewport. Each page has one `h1`, equal
client and scroll widths, no broken or alt-less images, no KaTeX errors or raw
delimiters, and no console warnings or errors. Direct mobile inspection caught
and repaired a 680-pixel wide-figure crop and malformed HTML caused by literal
comparison characters inside two Lean-bridge parameters. The repaired
conceptual figures render at 352 pixels inside the 390-pixel viewport.

The source-and-teaching candidate reached `origin/main` at `df0dd04`. The first
warning-fatal cloud leaf check exposed one missing `Topology` namespace opening
for the neighborhood notation. Commit `c2272e6` adds that import-scope repair
and synchronizes all three reader-facing source hashes. The repaired
`CLOUD_LEAN_BUILD=1 make lean-file
LEAN_FILE=NonlinearDynamics/Deterministic/Chaos/Sensitivity.lean` check passes,
as does the warning-fatal `NonlinearDynamics/Deterministic.lean` aggregator.
The five Sensitivity axiom reports contain only `propext`, `Classical.choice`,
and `Quot.sound`; none contains `sorryAx`.

Approved Linux validation on 2026-08-07 used RunPod Secure Cloud with 8 vCPU,
32 GB billed RAM, an 80 GB ephemeral disk, and the retained project network
volume at $0.32 per hour under a $5 ceiling. The exact committed source was
transferred without workstation `.git`, `.env`, `.lake`, generated Hugo
output, credentials, or private artifacts. The retained Elan and Bifurcation
Lake archives passed their recorded SHA-256 and `zstd -t` checks before
sequential restoration onto ephemeral disk. The network volume was not used as
a live `.lake` tree. Guarded setup checked the committed manifest before and
after dependency update, and validation used pinned Lean 4.32.0 and the same
Hugo Extended 0.160.1 release as the workstation.

The complete `CLOUD_LEAN_BUILD=1 make -j1 check` gate passes at `c2272e6`: all
3,221 Lean jobs, 47/47 Notebook coverage, 23 coverage regression tests, seven
teaching-hygiene tests, the 167-file teaching audit, the 806-surface
reader-language audit, and a warning-fatal 495-page Hugo render. The successful
ephemeral `.lake` tree was archived as
`lake-manifest-pinned-sensitivity-20260807.tar.zst`. The new
2,643,712,542-byte archive and `SHA256SUMS-sensitivity-20260807` ledger pass
checksum and compressed-stream verification after their sequential copy to the
retained volume; earlier validated archives remain intact. Documentation commit
`abc494e` reached `origin/main` before shutdown. The builder ran for 657 seconds
at $0.32 per hour, approximately $0.06 of compute spend. The exact task pod was
then terminated. A post-action inventory reports zero task pods and one
retained project network volume. No cloud resource identifier or credential is
recorded here.

### Bifurcation release closure

The bifurcation source was assembled and publicly paired at candidate commit
`622f9bb`, then repaired at validation commit `99ebb98` after the warning-fatal
leaf exposed two unused binder names, an isolated-parameter equality bridge,
and one unsimplified quadratic identity. The checked source SHA-256 is
`1c9ed02764e75b136567e879da85922ac9d6013836e582e4f539a23d3c11a1d0`.
The six axiom reports contain only `propext`, `Classical.choice`, and
`Quot.sound` as applicable; none contains `sorryAx`.

Approved Linux validation on 2026-08-07 used RunPod Secure Cloud with 8 vCPU,
32 GB billed RAM, an 80 GB ephemeral disk, and the retained project network
volume at $0.32 per hour. A clean source-only tree was synchronized without
`.git`, `.env`, `.lake`, generated Hugo output, credentials, or private
tooling. The retained Conjugacy-era Elan and Lake archives passed their
recorded SHA-256 checks before sequential restoration to ephemeral disk. The
network volume was not used as a live `.lake` tree. The guarded setup verified
the committed manifest before and after `lake update`, and the cloud gate used
the same Hugo Extended 0.160.1 build as the workstation.

`CLOUD_LEAN_BUILD=1 make lean-file
LEAN_FILE=NonlinearDynamics/Deterministic/Discrete/Bifurcation.lean` passes
warning-fatal, as does the `NonlinearDynamics/Deterministic.lean` aggregator.
The complete `CLOUD_LEAN_BUILD=1 make check` gate finishes all 3,221 Lean jobs,
46/46 Notebook coverage, 23 coverage regression tests, seven teaching-hygiene
tests, the 164-file teaching audit, the 791-surface reader-language audit, and
a warning-fatal 484-page Hugo render. The successful ephemeral `.lake` tree
was archived sequentially as
`lake-manifest-pinned-bifurcation-20260807.tar.zst`; the new 2.5-GB archive and
its checksum ledger pass verification on the retained volume. The builder ran
for 669 seconds at $0.32 per hour, approximately $0.06 of compute spend. The
exact task pod was terminated after the validated release commit reached
`origin/main`. A post-action inventory reports zero task pods and one retained
project network volume. The network volume and its new verified bifurcation
archive remain available for the next approved builder. No cloud resource
identifier or credential is recorded here.

Singular values, conorms, Lyapunov spectra, Oseledets splittings, derivative
cocycles, random attractors, and stable manifolds remain separate later
milestones.

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
- [x] All-positive-length once-bad union, exact finite-witness semantics,
  null measurability, unconditional extended-measure continuity,
  finite-target real continuity, unchanged generic and cocycle ratios, and a
  preserving raw non-invariance countermodel.
- [x] Countably generated rational-slack lower-deviation events, one-sided
  preimage inclusion, finite-measure almost invariance, ergodic null/conull
  rigidity, probability null-branch selection, and the log-positive cocycle
  endpoint.
- [x] Guarded real-liminf bridge, double-rational null exhaustion, explicit
  almost-everywhere boundedness, and full normalized log-positive Kingman
  convergence before signed growth.
- [x] Real-log norm measurability and subadditivity under pointwise
  invertibility, inverse-generator negative-tail control, two-tail
  finite-horizon integrability, an integrable signed subadditive candidate,
  the geometric one-tail counterexample, and the positive-growth real-log
  endpoint.
- [x] Integrated signed growth, deterministic finite signed Fekete rate,
  two-sided normalized bounds, and general almost-everywhere real-log Kingman
  convergence under the RMT-34 two-tail package.
- [x] One explicitly selected meaning of stochastic stability: sequential
  upper semicontinuity of the signed integrated real-log growth rate under
  uniform convergence in a shared two-sided bounded invertible generator
  class over a fixed probability-preserving base.

### Deterministic discrete dynamics

The stability module is complete; the following later files remain one-line
documentation placeholders:

- [x] `Discrete/Stability.lean`: forward-orbit equicontinuity, the separate
  fixed-point specialization, metric characterizations, nonexpansive-map
  criteria, and boundary examples.
- [x] `Discrete/Attraction.lean`: orbit convergence, point and nonempty-set
  basins, local and global attracting fixed points, asymptotic stability,
  contraction-derived endpoints, and singleton point/set bridges.
- [x] `Discrete/Lyapunov.lean`: positive-definite and nonnegative
  certificates, weak and strict regional descent, invariant sublevels,
  antitone orbit values, an explicit sublevel-distance comparison, and
  separate stability and zero-certificate attraction endpoints.
- [x] `Discrete/Conjugacy.lean`: algebraic semiconjugacy, continuous
  semiconjugacy, surjective factor maps, specified and existential topological
  conjugacy, iterate and attraction transport, basin identities, local and
  global attracting-fixed-point equivalences, and relation laws.
- [x] `Discrete/Bifurcation.lean`: parameterized self-map families, fixed and
  specified-period branches, conjugacy-invariant classifier changes,
  whole-state-space conjugacy obstruction, isolated-parameter boundary, and
  the exact quadratic fixed-point family at parameter zero.
- [x] `Chaos/Sensitivity.lean`: metric-first fixed-scale sensitivity with
  explicit nonemptiness, scale monotonicity, neighborhood equivalence,
  isolated/discrete/finite obstructions, forward-stability incompatibility,
  nonexpansive nonexamples, and an exact real doubling-map witness.
- [x] `Chaos/Devaney.lean`: positive-time transitivity, dense positive-period
  points, historical and reduced Devaney interfaces, the Banks sensitivity
  implication with exact infinitude/metric hypotheses, and finite and
  isolated-point boundaries.
- [x] `Chaos/SymbolicCoding.lean`: Mathlib-backed one-sided full shift, prefix
  cylinder basis, exact splicing and periodic completion, positive-time
  transitivity, dense positive-period points, Devaney-chaos endpoint, and
  itinerary semiconjugacy and topological-factor gates.

### ODEs and concrete models

The first file is now a validated source-and-teaching milestone; the remaining
files are placeholders:

- [x] `ODE/GlobalExistence.lean`: warning-fatal leaf, deterministic aggregator,
  both exact-commit full gates, verified cache preservation, desktop QA, and
  literal 390-by-844 browser QA pass.
- [x] `ODE/ToFlow.lean`: selected unique global curves, restart and action
  laws, explicit joint-continuity gate, Mathlib `Flow ℝ M` construction,
  compatible-flow converse, full source-and-teaching gates, browser QA, and
  verified retained cache preservation.
- [x] `ODE/Stability.lean`: nonnegative-real-time equicontinuity, separate
  equilibrium and attraction predicates, metric characterizations,
  nonexpansive criteria, translation and identity boundaries, Hausdorff orbit-
  limit fixedness, both exact-commit full gates, browser QA, and verified cache
  preservation.
- [x] `ODE/Lyapunov.lean`: continuous-time weak and strict scalar descent,
  invariant sublevels, antitone orbit values, derivative-sign bridges,
  separate stability and attraction endpoints, strict-descent boundary,
  exact-commit full gate, browser QA, and verified cache preservation.
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
- The exact real-pair constructor requires a product law inside each
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
  required before any such measure identity could be stated.
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
  null-measurable event. Ergodicity then gives only the conditional
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
  empty cap is valid and time zero never becomes an admissible block length.
  Its greedy pointwise estimate genuinely needs `H + m ≠ 0` and `c ≤ 0`;
  the joint zero corner is false, while the time-one centered identity derives
  the sign needed by the final rate-ratio theorem.
- RMT-30's auxiliary visit horizon is proof architecture, not part of the
  finite bad set. The final theorem needs finite measure and preservation but
  neither probability nor ergodicity. A nonergodic two-atom identity system
  checks a genuinely nonempty singleton bad set of mass `1 / 2`, rather than
  validating the endpoint only through an empty event.
- RMT-31 records the raw all-length set as the exact increasing union of the
  finite caps. Its membership theorem means one positive finite witness. It
  must not be paraphrased as infinitely often, arbitrarily late, or a strict
  lower-liminf event.
- RMT-31 keeps two continuity interfaces separate. Extended-measure
  continuity uses only cap nesting and the exact union; real-measure
  continuity adds the local finite-target gate. The unchanged rate ratio is a
  closed-order limit of uniform capwise bounds, not a sum over caps.
- The raw once-bad union is not invariant: a compiled finite
  measure-preserving collapse model gives event `{false}` and empty preimage.
  RMT-32 therefore uses arbitrarily-late witnesses with rational threshold
  slack. Its one-sided preimage inclusion is the exact setwise statement;
  preservation and finite mass are what justify almost invariance.
- RMT-32 keeps qualitative rigidity separate from numerical branch selection.
  Finite-measure ergodicity already gives the almost-empty or almost-full fork.
  Probability normalization is needed later, because a compiled ergodic
  half-Dirac model has a full event of real mass `1 / 2 < 1`.
- The two RMT-32 preimage-inclusion methods retain the full
  `IsIntegrableSubadditiveProcessCandidate` receiver for consistency with the
  surrounding API, but their proofs project only `add_le`. Integrability first
  becomes mathematically active in the null-measurability layer.
- RMT-32's null theorem applies at every `c < δ`, not at `c = δ`. RMT-33
  covers the strict lower-limit event by an outer countable family of rational
  targets `c < δ`; membership in each target event uses a second rational
  witness `q < c`. These two margins have different jobs and must not be
  collapsed into the impossible premise `δ < δ`.
- Mathlib's real `Filter.liminf` is total. A real sequence unbounded below can
  receive a finite totalized value, so “frequently below” characterizes a
  strict real-liminf inequality only after the appropriate eventual lower
  bound is supplied. RMT-33 keeps that guard in its public equivalence and
  compiles the quadratic countermodel.
- RMT-33 deliberately extracts two deliverables from the same rational null
  exhaustion: almost-everywhere lower-liminf control and almost-everywhere
  boundedness below. The latter is a semantic premise of the real
  liminf/limsup squeeze, not disposable proof bureaucracy.
- The centered-to-original transfer adds the convergent one-step Birkhoff
  average at the liminf level. The cocycle endpoint takes `PreErgodic` rather
  than separately restating preservation because preservation is already part
  of the cocycle package.
- RMT-33 proves convergence only for the log-positive envelope. `Real.log 0 =
  0`, while the zero-faithful extended logarithm is bottom at norm zero; any
  bridge to a signed real logarithm must state the algebraic and dimensional
  hypotheses under which those observables agree.
- RMT-34 uses pointwise generator invertibility as its clean finite-log
  interface and inverse-generator log-positive integrability as a negative-tail
  majorant. Only the extended-to-real coercion bridge and its private
  one-value lower-rail proof need a nonempty matrix index. Public signed
  subadditivity, the inverse-orbit lower rail, finite-horizon integrability,
  and candidate packaging handle empty dimension through explicit zero
  branches. The positive-rate endpoint also accepts empty dimension
  syntactically, but its strict premise is impossible because the rate is
  zero there.
- RMT-34 does not construct a same-base inverse cocycle: inversion reverses
  product order, and the one-sided base map need not be invertible. Its checked
  geometric probability example uses an identity base and is a one-step tail
  counterexample, not an independent-sampling or ergodic construction. It
  proves that forward log-positive integrability does not imply either the
  inverse-generator moment or signed-log integrability.
- The inverse-generator growth rate is not generally the negative top
  exponent. In higher dimension it controls the strongest contraction, so
  RMT-34 uses it for integrability bounds but does not advertise an
  exponent identity.
- For agent-assisted mathematical discovery, preserve the sourced problem,
  exact Lean statement, material exploratory decisions, and canonized
  proof-to-prose result as distinguishable artifacts. Audit definitions before
  proof search, informalize only from checked Lean, and record who selected,
  clarified, strategized, verified, and wrote each material discovery. The
  Kourovka/Aristotle paper arXiv:2607.17477 is a process precedent, not a source
  for nonlinear-dynamics mathematics.
- RunPod compute and storage remain behind a human approval gate even when an
  API key is present. The owner granted project-scoped approval on 2026-07-21
  for the now-terminated builder; fresh compute requires fresh approval. Keep
  specifications and costs visible, keep secrets and resource identifiers out
  of the repository, and treat the Linux cloud gate as the exclusive Lean
  build path. Committed source remains the source of truth.
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
- RMT-36 selects upper stability of the signed integrated top-growth rate under
  uniform convergence inside a common forward/inverse-bounded invertible
  generator class over a fixed probability-preserving base. It does not encode
  zero-noise stationary-measure selection or random-attractor stability, and
  it does not claim lower semicontinuity or full continuity.
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
  deterministic Fekete limit. RMT-34 now adds total real-log measurability,
  unit-guarded signed subadditivity, measurable inverse-envelope control,
  separate integrable forward and inverse generator tails, finite-horizon
  signed integrability, and an integrable signed subadditive candidate.
  Normalized log-positive sample growth converges almost everywhere on an
  ergodic probability base; RMT-35's source checkpoint now proves the signed
  analogue under the explicit two-tail package. Lyapunov spectra and Oseledets
  limits remain open. Probability-guarded
  expectation terminology and native
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
  integral under probability normalization. RMT-29 now adds a generic
  lower-bounded subadditive upper-limsup estimate, retains its original
  nonnegative theorem as a compatibility wrapper, and proves the all-block
  log-positive cocycle bound by the integrated Fekete rate using only
  Birkhoff averages under the original map. RMT-30 now adds exact finite orbit-visit integration,
  strict finite centered bad-block sets, greedy packed pointwise control, and
  the generic and cocycle finite bad-block rate ratios without probability or
  ergodicity. RMT-31 now identifies their all-positive-length increasing
  union, proves its null measurability and unconditional extended-measure
  continuity, exposes the finite-target real-continuity gate, transports the
  same generic and cocycle ratios without loss, and compiles a preserving
  countermodel to raw setwise invariance. RMT-32 now constructs the
  arbitrarily-late rational-slack event, proves its threshold-relaxed and
  same-target one-sided preimage laws, upgrades the latter to almost
  invariance under finite mass and preservation, obtains finite-measure
  ergodic rigidity, and uses probability normalization plus the strict ratio
  to select the null branch. Its log-positive cocycle endpoint still accepts
  an empty matrix index. RMT-33 now identifies strict guarded real-liminf
  deviation through a double-rational exhaustion, obtains both the
  complementary lower estimate and its bounded-below gate, adds back the
  one-step Birkhoff average, and combines the result with RMT-29 to prove
  almost-everywhere normalized log-positive cocycle convergence. Its final
  theorem also accepts an empty matrix index. RMT-34 propagates pointwise
  generator units, bounds the inverse value by an inverse-generator orbit sum,
  sandwiches each finite real log norm between integrable two-tail rails, and
  exports the signed family as a generic integrable shifted-subadditive
  candidate. It separately proves positive-rate unclipping without units and
  compiles a geometric probability model showing that the forward moment does
  not imply the inverse or signed moment. RMT-35's source checkpoint integrates
  that signed family, constructs its finite deterministic Fekete rate from the
  inverse-tail lower floor, obtains the lower and upper sample endpoints, and
  proves the pre-ergodic probability almost-everywhere signed limit. Its
  proof-to-prose release remains unfinished at this pause.
  `Measure.real` still totalizes infinite extended measure
  to zero: local finiteness is a sufficient conversion gate, not a necessary
  condition for every individual projected limit, and no unconditional general
  real-continuity theorem is available. The existing interfaces now give an
  integrable finite-horizon real logarithmic norm, its finite signed Fekete
  rate, and its pre-ergodic probability almost-everywhere normalized limit
  under the explicit two-tail package. They still do not identify a limit
  integral, prove `L¹` convergence or uniform integrability, or produce a
  Lyapunov spectrum or Oseledets splitting.
- Quantum-chaos universality claims are not general theorems in this project.
- The deterministic placeholder tree has no substantive definitions yet.

## Validation Snapshot

Run before every documentation or workstation-only push:

```sh
make checkpoint-check
make workstation-check  # may expose known source/prose debt
git diff --check
```

For a formalization milestone, obtain approval for Linux cloud compute and run:

```sh
CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/path/to/Module.lean
CLOUD_LEAN_BUILD=1 make check
```

The Lean commands above are forbidden on macOS. A policy/documentation-only
milestone does not justify provisioning paid compute by itself; record which
non-Lean gates were run and leave existing formalization evidence unchanged.

Checkpoint/skill milestone QA:

- GitHub Pages open-corpus QA on 2026-07-22: after the owner authorized public
  working notes, both the production-only Hugo build and the draft-inclusive
  local review build rendered 405 pages with warnings fatal under Hugo Extended
  0.160.1. The repository-subpath production artifact contains all 127 opted-in
  content pages, no single-slash-rooted HTML `href` or `src`, its site
  CSS/JavaScript, and all 63 mounted checked Lean sources byte-for-byte.
  Notebook, Deep Dive, glossary, root, and RMT-35 Lean-source HTTP probes return
  200. All 444 page-bundle resources are emitted at their corresponding public
  routes: 210 SVG figures, 117 PNG cards, and 117 card-generator shell scripts.
  A targeted scan of the public roots finds no credential variable, private-key
  marker, API-key-shaped token, or workstation absolute path. The
  publication-neutral coverage checker reports only the two pre-existing
  RMT-35/RMT-29 proof-to-prose debts, not the 39 published Notebook states.
  Literal 1440x1000 and 390x844 browser checks of representative Notebook,
  Deep Dive, and glossary pages show the public working-note badge, exactly one
  article heading, no page-level overflow, broken images, KaTeX errors, or
  console warnings/errors.
  `make checkpoint-check`, all twenty-three coverage-contract regression tests,
  all four content-hygiene regression tests, the 132-file hygiene scan,
  `make site-check`, workflow syntax inspection, and `git diff --check` pass
  without invoking Lean. The local Mathlib compiled build tree remains absent.

- Build-host policy QA on 2026-07-22: `make lean`,
  `CLOUD_LEAN_BUILD=1 make setup`, `CLOUD_LEAN_BUILD=1 make lean-file ...`,
  and `CLOUD_LEAN_BUILD=1 make check` each refused on macOS before invoking
  Lake. The single-process cloud runner also remained safe under Make's
  ignore-errors option and a command-line attempt to replace the runner
  variable. POSIX shell syntax, ShellCheck, Make help,
  `make checkpoint-check`, seventeen coverage regression tests, four hygiene
  regression tests, the 132-file hygiene scan, the 405-page warning-fatal Hugo
  render, and `git diff --check` passed without invoking Lean. The removed
  local Mathlib `.lake/build` directory remained absent.
- The official project-skill structural validator passed after the cloud-only
  rewrite. A context-minimal fresh-agent forward test independently recovered
  the macOS command prohibitions, human approval boundary, source-only sync,
  ephemeral-disk build, network-volume snapshot role, exact cloud gate, and
  post-gate compute termination policy.
- An independent adversarial policy audit confirmed that no documented Make
  path reaches Lean or Lake on macOS. It also exposed and drove repairs for
  three reproducibility ambiguities: fresh clone versus source-only Git
  handling, manifest drift across `lake update`, and matching the exact Hugo
  release between workstation and cloud. Follow-up review closed two smaller
  holes by requiring the digest before builds and leaf probes and by
  canonicalizing leaf paths beneath `formalization/NonlinearDynamics`. The
  checked manifest SHA-256 ledger and enhanced checkpoint validator now make
  the dependency pin executable.
- `make workstation-check` stops at exactly the two already recorded RMT-35
  source-checkpoint debts: the missing `RealLogNormKingman.lean` Notebook
  mapping and the new RMT-29 declaration absent from its stale companion.
  No cloud compute was provisioned for this policy-only milestone.
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
  cancelled. The builder was retained at that checkpoint and was later
  terminated as recorded in the current pause handoff.
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
  the Mac. The builder was retained under the owner's then-continuing approval
  and was later terminated as recorded in the current pause handoff.
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
- RMT-30 Lean audit: the 506-line module has SHA-256
  `a8aee618a10f8434c1c33d8e433fd77e98ed3e5c8dee399e7d6fa323c5079b28`,
  ten documented public declarations, eleven private boundary-support items,
  nine compiled examples, and seven source axiom prints. Independent read-only
  review checked visit-count integration, strict positive-length indexing,
  greedy witness selection, the `H + m ≠ 0` corner, negative division, Fekete
  specialization, assumption minimality, and all boundary models. The original
  vacuous nonergodic probe was strengthened to a half-half two-atom probability
  space with a genuinely nonempty singleton bad set. No correctness,
  overclaim, proof-hole, unsafe-declaration, or axiom blocker remains; every
  printed footprint is exactly `propext`, `Classical.choice`, and `Quot.sound`.
- RMT-30 teaching audit: the body-only deterministic regex counts 5,607 tokens
  in the Notebook, 4,059 in the Deep Dive, and 908 in the finite-orbit-visit
  glossary. The Notebook maps all ten public declarations, the nested private
  proof ledger, eleven boundary-support items, nine examples, and seven axiom
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
- RMT-31 Lean audit: the 481-line module has SHA-256
  `53438522344c078d64473316a594570993d694ada909a33184579cec6a996fb7`,
  eleven documented public declarations, fifteen private boundary-support
  items, ten compiled examples, and seven source axiom prints. Independent
  read-only review checked the exact one-witness union semantics, cap nesting,
  regularity assumptions, unconditional extended continuity, the local
  finite-target real gate, closed-order ratio transport, cocycle assumptions,
  and the preserving non-invariance countermodel. No correctness, overclaim,
  proof-hole, unsafe-declaration, or axiom blocker remains; every printed
  footprint is exactly `propext`, `Classical.choice`, and `Quot.sound`.
- RMT-31 teaching audit: the body-only deterministic regex counts 5,120 tokens
  in the Notebook and 3,632 in the Deep Dive. The Notebook maps all eleven
  declarations, fifteen private items, ten examples, and seven axiom reports
  with twenty-four solved exercises; the Deep Dive has thirty. Two
  deterministic cards reproduce byte-for-byte at 1200x630, all ten SVGs parse
  and pass direct visual inspection, and both generators pass ShellCheck.
  Independent audits added body citations for pinned Mathlib claims, made the
  finite-target gate explicit in the standalone ratio figure, corrected the
  cocycle assumption ledger, replaced a misleading `c + ε` sketch with
  rational `q < c`, and separated one-sided inclusion from its later
  finite-measure almost-invariance upgrade.
- Rendered RMT-31 QA: the Notebook and Deep Dive routes and both changed
  predecessor routes return HTTP 200 and expose exactly one article heading at
  literal 1440x1000 and 390x844 viewports. Source math matches the rendered
  10+66, 18+86, 14+158, and 36+155 display-plus-inline KaTeX counts at both
  widths. All 5/5, 5/5, 6/6, and 6/6 body figures load; there are zero KaTeX
  errors, raw delimiters, page-level overflow, broken images, failed HTTP
  responses, page failures, or console failures. A linked static SVG favicon
  removed the browser's only automatic 404 rather than suppressing the error.
- RMT-31 full repository gate: warm local `make check` completes all 3,212
  Lean jobs, checkpoint and 36/36 coverage checks, four hygiene regression
  tests, the 124-file teaching scan, and the 381-page warning-fatal Hugo render
  in 2.91 seconds. The exact source-only tree was synchronized to the approved
  retained RunPod builder without `.env`, Git metadata, local `.lake`,
  generated Hugo output, or private review files; checksum identity was proved
  before execution and the same gate passed there in 10.74 seconds. A final
  checkpoint-inclusive source synchronization and replay also passed. The
  32-vCPU, 128-GB billed-memory builder and 100-GB persistent volume remain
  retained under the owner's continuing approval.
- RMT-32 Lean audit: the new 668-line module has SHA-256
  `1bdcfd6b3be654f52bae22bdb2b44c15848e66d51f3a0973ce1c8aba61db14d4`,
  nineteen documented public declarations, twenty-one private boundary-support
  items, six compiled examples, and ten source axiom prints. The canonized
  506-line RMT-30 predecessor has SHA-256
  `a8aee618a10f8434c1c33d8e433fd77e98ed3e5c8dee399e7d6fa323c5079b28`
  and now exposes the centered Fekete offset bridge as a tenth public theorem.
  Independent read-only review checked the exact quantifiers, rational slack,
  threshold relaxation, one-sided preimage inclusion, finite-measure almost
  invariance, ergodic rigidity, probability-only branch selection, strict
  ratio argument, cocycle specialization, and all six countermodels. No
  correctness, overclaim, proof-hole, unsafe-declaration, or axiom blocker
  remains; every printed footprint is exactly `propext`, `Classical.choice`,
  and `Quot.sound`.
- RMT-32 teaching audit: the body-only deterministic regex counts 7,152 tokens
  in the 1,268-line Notebook and 6,786 in the 1,151-line Deep Dive. The
  Notebook maps all nineteen declarations, twenty-one private items, six
  examples, and ten axiom reports with thirty solved exercises; the Deep Dive
  has thirty-six. Two deterministic cards reproduce byte-for-byte at 1200x630,
  all twelve new conceptual SVGs and the changed predecessor SVG parse and
  pass direct visual inspection, and both generators pass ShellCheck.
  Independent audits repaired one stale RMT-30 proof-ledger command, restored
  dropped TeX, corrected four canonical authors, made a wide mobile figure
  explicit, tightened the exact pinned Mathlib citation, and expanded milestone
  labels on standalone surfaces.
- Rendered RMT-32 QA: the Notebook and Deep Dive routes return HTTP 200 and
  expose exactly one article heading at literal 1440x1000 and 390x844
  viewports. Source math matches the rendered 13+210 and 39+279
  display-plus-inline KaTeX counts at both widths. All 6/6 and 8/8 figures
  load; all fourteen direct asset routes return HTTP 200; there are zero KaTeX
  errors, raw delimiters, page-level overflow, broken images, failed HTTP
  responses, or console failures. The browser pass found a real mobile
  overflow in display-math panels and fixed the global grid minimum with
  `min-width: 0` and `minmax(0, 1fr)`.
- RMT-32 full repository gate: local `make check` completes all 3,213 Lean
  jobs, checkpoint and 37/37 coverage checks, four hygiene regression tests,
  the 126-file teaching scan, and the 387-page warning-fatal Hugo render in
  25.76 seconds. The exact source-only tree was synchronized to the approved
  retained RunPod builder without `.env`, Git metadata, local `.lake`,
  generated Hugo output, or private review files; checksum identity was proved
  before execution and the same gate passed there in 15.61 seconds. A final
  checkpoint-inclusive source synchronization and replay passed in 4.34
  seconds. The 32-vCPU, 128-GB billed-memory builder and 100-GB persistent
  volume remain retained under the owner's continuing approval.
- RMT-33 Lean audit: the new 627-line module has SHA-256
  `55680bc2afa18d0a195a7fa7426e6afb2b55fcbb3f588d3474bc6f52764025ef`,
  twenty-four documented public declarations, eleven private support
  declarations, five compiled anonymous examples, and eleven source axiom
  prints. Independent review checked the real-liminf totalization guard, both
  rational margins, null-cover reuse, Birkhoff addback, boundedness gates,
  `PreErgodic` endpoint, empty-index boundary, and exact final squeeze. No
  proof hole, unsafe declaration, project axiom, or mathematical overclaim
  remains; every printed footprint is exactly `propext`,
  `Classical.choice`, and `Quot.sound`.
- RMT-33 teaching audit: the deterministic body-only regex counts 8,166
  tokens in the 1,482-line Notebook, 10,376 in the 2,034-line Deep Dive, and
  1,562 in the 282-line limit-inferior glossary. The Notebook maps all
  twenty-four public declarations, eleven private items, five examples,
  eleven axiom reports, and fifty-one interleaved source items, with
  thirty-two solved exercises; the Deep Dive has forty. Three deterministic
  cards reproduce byte-for-byte at 1200x630, all sixteen new SVGs and the
  changed predecessor handoff SVG parse and pass visual inspection, and all
  three generators pass ShellCheck. Independent adversarial review corrected
  an unguarded liminf interpretation, first-use acronym expansions, a
  log-positive-versus-signed overclaim, formal-authority attribution, and
  cross-link titles.
- Rendered RMT-33 QA: the three new routes and six changed predecessor or
  glossary routes return HTTP 200. Desktop and literal 390x844 mobile checks
  expose one article and one heading, no page-level overflow, and no broken or
  alt-less assets, raw delimiters, KaTeX errors, page failures, or console
  failures. All lazy figures load after forced visitation, with wide tables,
  figures, and display mathematics scrolling locally. Source and rendered
  article-body math agree exactly at 157 inline plus 22 display expressions
  in the Notebook, 329 plus 118 in the Deep Dive, and 61 plus 11 in the
  glossary.
- RMT-33 RunPod preflight: a checksum-identical source-only synchronization
  excluded `.env`, Git metadata, local `.lake`, generated Hugo output, and
  private review files. The retained builder completed all 3,214 Lean jobs in
  7.40 seconds, 38/38 coverage in 0.09 seconds, four hygiene regression tests
  in 0.03 seconds, the 129-file teaching scan in 2.62 seconds, and the
  396-page Hugo check in 0.33 seconds, for about ten seconds total, then
  returned to idle. The checkpoint-inclusive local `make check` then completed
  all 3,214 jobs, 38/38 coverage, four hygiene tests, the 129-file teaching
  scan, and the same 396-page render in 23.37 seconds. A checksum-identical
  checkpoint-inclusive RunPod replay passed the same complete gate in 10.53
  seconds. After the final audit corrections, a second source-identity replay
  passed in 4.41 seconds. The release candidate is green locally and remotely.
- RMT-34 Lean audit: the frozen 942-line source has SHA-256
  `ac950f8728e5fd003cff3b7a5d0750e5c36060730b3ebadc5b0e1165b54e72ea`,
  twenty-eight public declaration commands, three explicit structure fields,
  thirty-four private support commands, sixteen compiled anonymous examples,
  and eleven source axiom prints. Independent review checked total
  `Real.log 0` semantics, the empty/nonempty split, pointwise unit propagation,
  reversed inverse order, total nonsingular inverse behavior, both integrable
  rails, the geometric missing-tail model, positive-rate unclipping, and every
  nonclaim. No proof hole, unsafe declaration, project axiom, or mathematical
  overclaim remains; every printed footprint is exactly `propext`,
  `Classical.choice`, and `Quot.sound`.
- RMT-34 teaching audit: the deterministic body-only regex counts 9,410 tokens
  in the 1,573-line, 74,334-byte Notebook; 11,402 in the 2,419-line,
  85,759-byte Deep Dive; and 4,507 in the 843-line, 33,746-byte glossary. The
  Notebook maps all twenty-eight public declarations, three structure fields,
  thirty-four private items, sixteen examples, and eleven axiom reports with
  forty solved exercises; the Deep Dive also has forty, and the glossary has
  sixteen worked mini-exercises. Three deterministic cards reproduce
  byte-for-byte at 1200x630, all seventeen conceptual SVGs parse and pass
  accessibility and visual review, and all three generators pass ShellCheck.
  Independent cross-review found and repaired the last empty-index, clipped-
  rate, shifted-subadditivity, source-span, image-alt, and private-helper
  classification defects; focused re-audits pass.
- RMT-34 checked-source and rendered QA: Hugo mounts only `.lean` files from
  `formalization/NonlinearDynamics` beneath `/lean/NonlinearDynamics`; an
  optional front-matter module/snapshot/hash triple is checked on every content
  page against the exact mounted source. Seventeen adversarial regression tests
  protect parsing, pairing, module agreement, containment, and freshness. The
  live RMT-34 source route returned HTTP 200 with 41,522 bytes and
  the frozen SHA-256. Its three new routes expose one heading at literal
  1440x1000 and 390x844 viewports. All 20 page images load with alt text; there
  are zero broken images or anchors, raw delimiters, KaTeX errors, page-level
  overflow, or console failures. The Notebook, Deep Dive, and glossary render
  142, 374, and 211 KaTeX nodes at both widths.
- RMT-34 release gate: local `make -j1 check` completes all 3,217 Lean
  jobs, checkpoint and 39/39 coverage, seventeen snapshot-contract tests, four
  hygiene regression tests, the 132-file teaching scan, and the 405-page,
  65-static-file warning-fatal Hugo render in 7.38 seconds. After an exact
  source-only sync that excludes `.env`, Git metadata, local `.lake`, generated
  Hugo output, caches, and private review files, the retained RunPod completes
  the same expanded gate in 4.58 seconds. Final recorded-checkpoint local and
  checksum-identity remote replays pass and guard the release commit.
- Research-workflow skill audit: the project skill now incorporates the
  source-to-statement, exploratory-proof, informalization, canonization, and
  human/AI provenance lessons from arXiv:2607.17477 without creating a
  tool-specific duplicate skill. The official structural validator and a
  context-minimal fresh-agent forward test pass.

## Recent Pushes

- `b16413e`: record the passing Symbolic Coding exact-candidate full gate,
  complete the validated draft statuses, and synchronize the forty-nine-module
  inventory and next-milestone handoff.
- `6bf8517`: formalize one-sided symbolic coding, prove full-shift
  transitivity, dense periodic points, and the Devaney endpoint, expose exact
  itinerary factor gates, and add the four-page cited teaching bundle.
- `e9fc6f5`: record the passing exact-commit Devaney full gate, independently
  verified retained cache, final draft status, and Symbolic Coding handoff.
- `4705233`: formalize the historical and reduced Devaney interfaces, prove
  the Banks sensitivity implication with exact hypotheses, and add the five-
  page teaching bundle, conceptual figures, deterministic cards, coverage map,
  cited decision record, and candidate validation checkpoint.
- `b369347`: publish the warning-fatal bifurcation validation status, complete
  cloud gate receipt, cache-preservation record, and sensitivity-interface
  handoff.
- `99ebb98`: repair the warning-fatal bifurcation leaf by removing two unused
  binder names, making the isolated-parameter classifier transport explicit,
  and closing the quadratic fixed-point algebra identity.
- `622f9bb`: formalize deterministic discrete bifurcation interfaces and add
  the complete public Notebook, Deep Dive, glossary, standalone worksheet,
  conceptual figures, cards, coverage map, and connected-corpus links.
- `c360723`: replace ambiguous probability-zero language with explicit sample
  spaces, fibers, masses, neighborhoods, countable additivity, and law-versus-
  range distinctions; propagate the rule through the teaching corpus and
  project guides.
- `ec0dc90`: complete the 150-document mathematical-register audit across the
  glossary, Deep Dives, Development Notebook, indexes, project guides, and
  checkpoint; add independent adversarial reviews and a context-aware
  regression gate for evidentiary overreach.
- `7e5557d`: separate portable reader-facing Lean commands from maintainer-only
  build infrastructure throughout the public teaching site.
- `59ff224`: finish the 36-chapter Deep Dive textbook pass with the exact
  forward/inverse real-log-norm tail sandwich, noncommuting inverse-order
  example, three accessible figures, eight Lean bridges, and an executed
  standalone `Std` worksheet.
- `e0e04c0`: rebuild *The Guarded Real-Liminf Bridge to Log-Positive Kingman
  Convergence* around three exact sequence boundaries, the totalized-liminf
  guard, an exact closing squeeze, seven Lean bridges, and an executed local
  `Std` worksheet.
- `3307fe2`: rebuild *Rational-Slack Lower-Deviation Events and Ergodic Null
  Selection* around an exact collapse/Dirac model, fixed rational witnesses,
  literal-versus-almost invariance, strict probability branch selection,
  seven Lean bridges, and an executed local `Std` worksheet.
- `644f862`: rebuild *Ergodic Birkhoff Limits and Normalized Space Averages*
  around the exact `(3,7)` two-state orbit, probability and mass-two
  normalization, identity/zero-mass/non-mixing boundaries, six Lean bridges,
  and an executed local `Std` worksheet.
- `49b2d45`: rebuild *From Finite Centered Bad-Block Bounds to
  All-Positive-Length Control* around nested finite caps, their exact union,
  the finite-target real-measure gate, and a collapse model separating literal
  from almost-everywhere invariance, with seven Lean bridges and an executed
  local `Std` worksheet.
- `09bbc99`: rebuild *Subadditive Upper Limsup Bounds Before Kingman
  Convergence* around a sharp two-state block ledger and the `-n²`
  totalized-real-limsup boundary, with the generalized lower-bound theorem,
  seven Lean bridges, and an executed local `Std` worksheet.
- `8752826`: rebuild *Birkhoff Limits, Invariant Sigma Algebras, and
  Conditional Expectation* around a weighted four-state two-sector model,
  atomwise conditional expectation, four wrong-target boundaries, seven Lean
  bridges, and an executed local `Std` worksheet.
- `6f8c7e5`: rebuild *Pointwise Birkhoff from Maximal Control and Dense Good
  Functions* around an eight-cycle closure rehearsal, a dyadic approximation
  ladder, strict and zero-scale boundaries, seven Lean bridges, and an
  executed local `Std` worksheet.
- `46489b6`: rebuild *Mean Is Not Pointwise: Koopman Geometry,
  Coboundaries, and the Missing Maximal Step* around an exact two-state
  projection/coboundary ledger and a dyadic typewriter diagnostic, with seven
  Lean bridges and an executed local `Std` worksheet.
- `15bbb61`: rebuild *From Finite Maximal Bounds to an Infinite Weak
  Estimate* around a strict five-cycle event, its exact increasing finite
  horizons, the finite-mass `Measure.real` gate, six Lean bridges, and an
  executed local `Std` worksheet.
- `94ce44a`: rebuild *Finite Maximal Ergodic Inequalities: From Orbit Maxima
  to Threshold Events* around one four-cycle whose terminal sums hide three
  strict running-maximum witnesses, with threshold and zero-horizon
  boundaries, seven Lean bridges, and an executed local `Std` worksheet.
- `456e0cf`: rebuild *Finite Bad-Block Measure Bounds Before Kingman Lower
  Liminf* around a strict two-atom ledger, exact greedy covering and integral
  arithmetic, sign and cap boundaries, seven Lean bridges, and an executed
  local `Std` worksheet.
- `5a9e9ea`: rebuild *Birkhoff Convergence Events Before the Pointwise
  Ergodic Theorem* around one convergent finite orbit and one bounded
  nonconvergent decimal-block shift, seven Lean bridges, complete interface
  coverage, and an executed local `Std` worksheet.
- `ea48291`: rebuild *Finite Ordered Interval Packing for Nonpositive
  Subadditive Processes* around exact disjoint/overlapping ledgers, a full
  leftmost-greedy selection, gap–length–tail decoding, sign and boundary
  failures, seven Lean bridges, and an executed local `Std` worksheet.
- `ed872b1`: rebuild *Finite Phase Averaging for Nonpositive Subadditive
  Processes* around three exact residue rows, explicit prefix and tail
  boundaries, wrong-sign and missing-block near misses, seven Lean bridges,
  and an executed local `Std` worksheet.
- `f69b719`: rebuild *Orbit-Majorant Centering for Subadditive Processes*
  around a three-state majorant/residual ledger, one wrong-shift false bound,
  four nearby centering operations, seven Lean bridges, and an executed local
  `Std` worksheet.
- `9836deb`: rebuild *Finite Block Decomposition for Subadditive Processes*
  around one eleven-step ledger, two correct temporal cuts, a false
  wrong-shift bound, zero-count and zero-block-length boundaries, seven Lean
  bridges, and an executed local `Std` worksheet.
- `078b3ab`: rebuild *Finite-Horizon Log-Positive Cocycle Integrability*
  around a four-state positive-log ledger, exact finite domination, raw-measure
  scope, a genuinely nonintegrable expanding probability tail, seven Lean
  bridges, and an executed local `Std` worksheet.
- `5f7eb59`: rebuild *Probability Normalization and Ergodic Rigidity Before
  Kingman* around probability-versus-raw mass, swap and identity dynamics,
  invariant-event and invariant-function rigidity, seven Lean bridges, and an
  oscillating-row warning against inferring samplewise convergence.
- `44dfba5`: rebuild *Integrated Log-Positive Cocycle Growth and Its
  Deterministic Fekete Limit* around two exact sample rows, an active zero-time
  boundary, a failed-subadditivity near miss, six Lean bridges, and a local
  finite-ledger worksheet.
- `529fc28`: rebuild *Finite-Time Norm and Extended-Log-Norm Observables for
  Matrix Cocycles* around positive and exact-collapse paths, distinct real and
  extended logarithm policies, seven Lean bridges, and an independently
  audited local worksheet.
- `b4f0e27`: rebuild *Measurable Finite Random-Matrix Products and
  Proof-Carrying Pushforward Laws* around two complete histories, an
  atom-by-atom product law, collision merging, a numerical dependence witness,
  seven Lean bridges, and an executed local worksheet.
- `b254d6e`: rebuild *Generator-Presented One-Sided Discrete Matrix Cocycles*
  around a noninvertible three-state orbit, exact shifted later-block identity,
  two numeric near misses, six Lean bridges, and a local `Std` worksheet.
- `22bece2`: rebuild *Hermitian Spectral Perturbation, Continuity, and
  Measurability* around an exact diagonal Frobenius budget and a sharply scoped
  non-Hermitian square-root near miss, with seven Lean bridges and a local
  perturbation worksheet.
- `b970cb2`: rebuild *Ordered Finite Matrix Products and Operator-Norm Growth*
  around a noncommuting shear/stretch history, chronological-versus-reversed
  norms `2` and `3`, factor budget `4`, seven Lean bridges, and a local
  factor-count worksheet that stops before Lyapunov theory.
- `bc81ed6`: rebuild *Finite GUE Empirical Spectral Laws and Normalized
  Moments* around a fully enumerated two-matrix source, its law on measures,
  joined mean, normalized moment ledgers, six Lean bridges, and the exact
  inner-zero/outer-Dirac dimension-zero boundary.
- `cde7fad`: rebuild *Finite Hermitian Spectra and Empirical Measures* around
  two checked eigenpairs, atom-by-atom sample measures, an isospectral
  information-loss boundary, seven Lean bridges, three RMT-10 module probes,
  and an executed local eigenpair worksheet.
- `67fddfa`: rebuild *First Exact Finite Gaussian Unitary Ensemble Trace
  Moments* around sample values `(1, 15)`, ensemble expectations `(0, 2)`,
  three controlled near-misses, six Lean bridges, the exact RMT-09 declaration
  map, and a nine-example local worksheet.
- `09e1253`: rebuild *Finite GUE from Independent Gaussian Coordinates* around
  the exact size-two Wigner ledger, reflection and scale near-misses, the
  zero-dimensional Dirac branch, six Lean bridges, three figures, and an
  independently reviewed RMT-06/later-module boundary.
- `985c0a8`: rebuild *From Normalized Hermitian Coordinates to Gaussian
  Unitary Ensemble Invariance* around the exact `15`-versus-`25` isometry
  ledger, swap and phase congruences, six Lean bridges, all 35 RMT-08
  declarations, and a nine-example local worksheet.
- `aa90da4`: rebuild *Intrinsic Hermitian Gaussian Symmetry and Matrix-Law
  Support* around one exact swap congruence and contrasting Dirac/balanced
  two-point laws, with three accessible figures, six Lean bridges, an executed
  local worksheet, and an explicit historical RMT-07/current RMT-08 boundary.
- `bc77be8`: rebuild *Finite Product Probability Spaces and Independent
  Gaussian Fields* around the complete four-bit outcome table, cylinder-event
  preimages, product-law and parity boundaries, six Lean bridges, two numeric
  figures, and a locally executed `Std` enumeration.
- `da4d884`: rebuild *Gaussian Laws, Independence, and Normalization* around
  one complete experiment, exact scaling and parity ledgers, six Lean bridges,
  an executed local worksheet, and an adversarially repaired readable card.
- `cf5a1a7`: rebuild *Complex Gaussian Coordinates and Geometry* around the
  exact `1 - 2i`, `(4, 1)` law ledger, copied-coordinate dependence boundary,
  support atlas, seven Lean bridges, and a locally executed `Std` lab.
- `d7d343b`: execute the final five hypothetical-output glossary worksheets,
  record their output verbatim, correct Lean's rational display to
  `(5 : Rat)/2`, and close the complete 62-page glossary audit.
- `10efa90`: replace the final fifteen generic/stale card scripts with
  deterministic exports of their pages' exact worked SVGs; all 62 glossary
  generators now reproduce their checked cards byte for byte.
- `34d2472`: close all missing glossary tutorial and generator coverage,
  including five executed matrix/dynamics lessons, a standalone orbit-recursion
  correction, and a nonempty zero-mass null-set experiment.
- `672703a`: make expectation, integrability, measurable-function,
  measurable-space, measure-preserving, and pushforward chapters executable;
  run all six exact `Std` worksheets and add deterministic worked-figure cards.
- `861cd9c`: rebuild *Random Matrices: From Outcomes to Spectra* around one
  red/blue coin experiment, checked eigenpairs, sample measures, the outer law
  on measures, its distinct mean, and a nilpotent information-loss boundary;
  execute its local `Std` lab and derive the card from the exact figure.
- `3e99c23`: repair six foundational probability/measure teaching bundles
  with deterministic worked-SVG card generators, explicit SVG dimensions,
  and five tiny `Std` tutorials executed locally without Mathlib or Lake.
- `a78e552`: rebuild the Hermitian-coordinate Deep Dive around one exact
  two-by-two matrix, conjugate-sign and diagonal-scaling near-misses, weighted
  Frobenius geometry, four Lean bridges, three figures, and a locally
  executed `Std` reconstruction lab.
- `3136b81`: rerun the exact parity/Fekete `Std` tutorial under Lean
  4.32.0, record its seven normalized ratios and two successful finite
  checks, and clear the stale workstation-execution claim.
- `2185d11`: finish the 62-page example-first glossary content pass with
  exact spike-tail, residue-phase, and ordered-packing ledgers; execute all
  three local `Std` worksheets, regenerate their numeric cards, and record
  the remaining corpus-wide tutorial/card-provenance audit as still open.
- `effc1ae`: telescope a forward Koopman coboundary on a four-cycle and
  contrast orbit-majorant with expectation centering on a three-cycle;
  execute both local `Std` worksheets, fix the rational checks to use
  `native_decide`, and regenerate both numeric cards.
- `56c30a6`: construct a positive-time average sequence with moving
  fixed-scale Cauchy witnesses, and compute conditional expectation on every
  visible event of a four-state probability space; execute both local
  `Std` worksheets and regenerate both exact worked-example cards.
- `69be855`: calculate a normalized average from two weighted atoms, preserve
  it under fivefold measure scaling, and identify its probability
  specialization; execute the local `Std` ledger and regenerate the card.
- `6a64db2`: pull one exact observable twice around a uniform three-cycle,
  preserve its squared `L²` norm, and contrast the non-preserving collapse;
  execute the local `Std` worksheet and regenerate its numeric card.
- `3124cb4`: enumerate the full, exact invariant, and bottom sigma algebras
  of a six-state split cycle; execute the local `Std` event audit and separate
  literal invariance from modulo-null and ergodic semantics.
- `8f40965`: compute limsup from the tail ceilings of one finite-spike
  sequence and liminf from the tail floors of one exact rational two-rail
  sequence; execute both local `Std` worksheets and visualize the real-order
  totalization boundaries.
- `dec0796`: compare one six-cycle with two sealed components, compute full
  versus empty Birkhoff convergence events, and separate one strict crossing
  from long-time behavior; execute all three local `Std` worksheets and make
  their exact diagrams the reproducible cards.
- `83844af`: compute the finite maximal inequality on a four-state cycle and
  the weak-type `(1,1)` estimate on four fixed points; execute both local
  `Std` worksheets and regenerate both cards from their exact teaching SVGs.
- `2ec7ddd`: compute a four-state Birkhoff-sum ledger and a uniform
  seven-state visit-count integral; execute both local `Std` tutorials and
  turn their exact finite calculations into reproducible cards.
- `b883058`: derive a wobbling integrated Fekete rate from an exact constant
  matrix and contrast an ergodic four-cycle with a preserved split system;
  execute both finite `Std` audits and regenerate example-bearing cards.
- `36d8181`: pair the log-positive envelope with the stronger forward-and-
  inverse tail package; compute the four-state orbit and fair two-outcome
  sandwich, execute both `Std` worksheets, and make four worked cards
  reproducible from their teaching SVGs.
- `975c5a3`: rebuild the one-sided matrix-cocycle and zero-aware extended-log
  chapters around exact finite matrix calculations; execute both standalone
  `Std` worksheets and make their example diagrams the reproducible cards.
- `be3d962`: rebuild the induced infinity operator norm around one exact
  two-by-two row-sum calculation, a column-sum near-miss, an equality-attaining
  vector, finite-product growth, and an executed standalone `Std` worksheet.
- `cf9401e`: rebuild realized empirical spectral measures, their outer laws,
  finite random-matrix products, and deterministic forward products; execute
  all four local worksheets and preserve the law-versus-mean type boundary.
- `c905709`: rebuild Hermitian Frobenius geometry and the finite GUE chapter
  around explicit size-two calculations; execute both tiny local worksheets
  and regenerate their cards from the new diagrams.
- `c9f5c82`: rebuild Hermitian coordinate space and normalized coordinates;
  add exact two-point trace-moment and Weyl perturbation lessons; execute all
  four local worksheets and regenerate their explanatory social cards.
- `98ca4cb`: rebuild independence, real Gaussian laws, and Cartesian complex
  Gaussian laws around exact examples; add a two-coordinate independent-family
  lesson; execute all four tiny local worksheets and regenerate their cards.
- `a535c65`: rebuild Hermitian matrices, trace powers, unitary invariance, and
  normalization as computed visual tutorials; add the full variance Lean
  bridge; execute all five tiny local worksheets and repair the decidability
  instance that the Hermitian worksheet exposed.
- `962dd93`: add integrability, measure-preserving transformation, and
  orbit-and-iterate chapters with exact examples and diagrams; turn the
  glossary landing page into a visual dependency-ordered learning route.
- `391a086`: add the measurable-function, random-variable, and expectation
  foundations with fair-die and exact three-outcome models, accessible diagrams,
  explicit human/paper/Lean bridges, and copyable tiny local Lean worksheets.
- `bb29161`: add the event, measure, and probability-measure foundations with
  exact finite models and visual mass ledgers, and rebuild conjugate transpose
  around an entry-by-entry complex example and copyable Lean worksheet.
- `16c8eb4`: rebuild measurable space, random matrix, pushforward measure, and
  matrix trace as example-first teaching chapters; add four accessible concept
  diagrams and social cards; document a genuinely small local Lean/`Std`
  tutorial while preserving the cloud boundary for project and Mathlib work.
- `1fd3657`: codify the educational ladder and dual resource boundary, add the
  shared human/paper/Lean and repository-check components, rebuild “Almost
  everywhere” and “Probability distribution (law)” around exact examples and
  accessible SVGs, and add the new “Null set” foundation with shrinking-cover
  proof and social cards.
- `9042de6`: add the production-only GitHub Pages workflow, repository-subpath
  URL handling, publication documentation, and static deployment QA policy.
- `bf25c66`: enforce a permanent cloud-only Lean/Mathlib build policy with
  guarded Make targets, exact manifest verification, source-only cloud sync,
  and a workstation-safe validation path.
- `90576e9`: record termination of the exact project RunPod compute resource,
  preservation of its 100 GB cache-snapshot volume, conservative local disk
  cleanup, and the paused RMT-35 resume handoff.
- `c0080d4`: generalize RMT-29's upper-limsup theorem to an explicit eventual
  lower-bound gate, formalize the compile-checked RMT-35 signed Fekete and
  pre-ergodic real-log convergence core, and record the deliberate pause and
  exact resume contract.
- `624c727`: formalize pointwise finite real-log subadditivity, measurable
  inverse-tail control, two-tail finite-horizon integrability, the signed
  subadditive candidate, the geometric one-tail counterexample, and the
  positive-rate unclipping endpoint.
- `32f9473`: complete guarded log-positive Kingman convergence, including the
  rational lower-deviation exhaustion, the declaration-complete teaching
  layer, rendered QA, and exact RMT-34 negative-tail plan.
- `06da7bd`: formalize countably generated centered lower-deviation events,
  finite-measure almost invariance and ergodic rigidity, probability null
  selection, the log-positive cocycle endpoint, and the complete paired
  teaching layer.
- `ff3dba9`: identify the all-positive-length centered bad-block union, carry
  the finite-cap ratio to it without loss, compile a preserving raw
  non-invariance countermodel, and pair the module with its complete Notebook
  and textbook Deep Dive.
- `b6a6d27`: formalize finite centered bad-block measure control, its complete
  Notebook, textbook Deep Dive, glossary layer, and the exact
  all-positive-length bridge plan.
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
