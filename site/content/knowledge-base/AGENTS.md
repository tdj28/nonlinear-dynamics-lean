# Knowledge Base authoring guide

## Local scope and path mapping

- This file governs `site/content/knowledge-base/**`.
- Map inherited `blog-source/content/knowledge-base/**` paths to
  `site/content/knowledge-base/**`, `blog-source/static/**` paths to
  `site/static/**`, and generated `blog/**` paths to `public/**`.
- Praxagent names, links, studies, and page titles below are historical
  examples of the editorial standard. They are not this site's name and must
  not be copied as local branding or treated as local artifacts.
- Local build targets are `make site`, `make site-drafts`, `make blog-serve`,
  and `make blog-serve-tailscale`.
- Development Notebook entries have their own guide at
  `site/content/development-notebook/AGENTS.md`. Keep the two content types and
  their review rules separate.

## Authoritative local automation override

This guide was adapted from a mature sibling project whose review automation
is not part of this repository. For this project, the supported automated
content gate is `make site-check`; the repository-wide gate is `make check`.

Any deeper reference to `make ci`, `make blog`, `make blog-drafts`,
`scripts/**`, Prax synchronization, a Playwright suite, or Prax-specific source
inputs is a historical example, not a runnable or mandatory local command. Do
not claim that one of those checks ran, and do not create a substitute result.
The path mapping above and the local Makefile are authoritative.

The underlying technical-review, citation, provenance, accessibility, visual
QA, and human-signoff obligations still apply. Perform and document them
manually when no local helper exists. When a required review is incomplete,
leave `pro_reviewed: false` and state what remains pending. Use `draft: true` by
default; an owner-authorized public working note may use `draft: false` without
implying that review is complete.

## Human-approved RunPod acceleration gate

RunPod is an optional acceleration layer for memory-heavy Lean builds and full
repository validation. It is never a second source of truth: committed source,
the pinned toolchain, reproducible artifacts, and the repository checks remain
authoritative.

- Possession of `RUNPOD_API_KEY` is not permission to incur cost or mutate a
  resource. Creating, starting, restarting, resizing, stopping, terminating,
  or deliberately retaining billed compute or storage requires explicit human
  approval for this project. Read-only inventory may precede that decision.
- The owner granted full project-scoped RunPod approval on 2026-07-21 for the
  active nonlinear-dynamics formalization goal. Until that approval is revoked,
  the gate is satisfied for managing the compute, persistent storage, and
  replacements reasonably needed to complete this goal. It does not extend to
  another project, another owner's resources, or disclosure of account data.
- Report the active specification and continuing hourly or monthly cost when
  it changes materially. Resolve exact targets before destructive operations,
  preserve any builder or volume the owner asked to retain, and terminate only
  resources that are confirmed obsolete.
- Keep API keys in ignored `.env`, use a dedicated SSH key and known-hosts
  file, transfer no broad home-directory credentials, and never commit pod
  identifiers, addresses, account metadata, secrets, or private review output.
- Build on fast ephemeral disk. Use persistent network storage for validated,
  sequential cache snapshots rather than as a live metadata-heavy Lake tree.

## Scope and ownership

These instructions apply to hand-authored glossary entries stored as leaf page
bundles:

```text
site/content/knowledge-base/glossary/<term>/index.md
```

Keep that entry's SVG, PNG social card, generator, receipt, and other page-owned
files beside `index.md` in the same `<term>/` directory. Carry the figure rules
in this file through every source and generated asset as part of the same task.

- Every glossary entry belongs at `glossary/<term>/index.md`. Never add or keep
  a loose `<term>.md` file directly under `knowledge-base/`.
- `glossary/_index.md` is the glossary menu page. Each neighboring `<term>/`
  directory is one self-contained glossary entry.
- Do not hand-edit `public/**`; regenerate it from `site/` with `make site` or
  `make site-drafts`.
- Treat `deep-dives/**` and section `_index.md` files as separate content types.
  Preserve their navigation metadata and do not apply the term-page template
  mechanically.
- The fuller figure and accessibility standard lives in the Development
  Notebook guide at `site/content/development-notebook/AGENTS.md`. Read its
  relevant sections when adding or materially changing a figure while keeping
  the glossary-specific rules in this file separate.

## Introduce terminology before use

This terminology gate applies to hand-authored glossary entries and Deep Dives,
even though the rest of this guide is primarily glossary-specific.

- Expand an acronym at its first reader-facing use on every standalone page:
  **multilayer perceptron (MLP)**, then **MLP**. Do not assume that a term is
  self-explanatory merely because it is common among specialists.
- Give unfamiliar technical shorthand a just-in-time plain-language definition
  before relying on it in an equation, example, code comment, table, diagram,
  alt text, or caption. Define every mathematical symbol on first use.
- A glossary link supplements the local definition; it does not replace the
  words a reader needs to understand the current sentence without navigating
  away.
- Audit standalone SVG `<title>` and `<desc>` text as well as visible labels.
  Expand or define an acronym inside the asset when a reader may encounter the
  figure independently of its surrounding paragraph.
- Give a term its own glossary entry when it is foundational or recurring and
  needs an operational definition, variants, caveats, or cross-links. Define an
  incidental one-off term locally instead of creating an empty stub.

Before review, scan the complete page from a newcomer's perspective and list
every acronym, symbol, and specialized noun that appears before its definition.
Resolve the list rather than relying on reviewer familiarity.

## Required educational ladder for every glossary entry and Deep Dive

The Knowledge Base is a guided course, not a reference dump. Every glossary
entry and Deep Dive must carry a reader through the same ladder while giving
each concept its own examples and visual language.

### 1. Start with one small, real situation

- Put a concrete, checkable example before sustained abstraction. Good starting
  objects include a fair die, a two-state system, a short orbit, a finite
  matrix, or a named measurable subset of a familiar space.
- Name the space, function, set, measure, assumptions, and claimed result that
  the example actually uses. Work out the decisive arithmetic or logical step;
  do not stop at “imagine that.”
- Put a nearby non-example, boundary case, or common misconception beside the
  example whenever it sharpens the rule.
- Keep a glossary example compact. Give each Deep Dive a running example and
  revisit it as the mathematics and Lean become more sophisticated.

### 2. Show the idea visually

- Every glossary entry needs at least one concept-specific, accessible teaching
  SVG unless a written exception explains why an exact equation, table, or
  executable example is clearer.
- Every Deep Dive needs a visual narrative. At minimum show the concrete model,
  the main transformation or proof architecture, and the decisive comparison
  or boundary case. One figure may do more than one job when it remains clear.
- Make all labels, values, arrows, colors, and set boundaries agree exactly with
  the worked example. A diagram is part of the mathematical claim.
- Decorative mountains, title cards, and generic pipelines do not satisfy the
  visual requirement. Captions must be complete text alternatives rather than
  merely repeating the title.

### 3. Translate human language, paper mathematics, and Lean

Every **In Lean** section must show all four of these layers together:

1. the statement a mathematician would say aloud;
2. the same statement in conventional paper notation;
3. exact Lean syntax that compiles in the pinned project environment; and
4. a short syntax map explaining the important identifiers and symbols.

For example, do not present `∀ᵐ ω ∂μ, P ω` alone. Explain that a human reads it
as “for almost every outcome `ω` with respect to `μ`, `P ω` holds,” connect it
to the complement of a null set in paper notation, and identify what `∀ᵐ`,
`∂μ`, `ω`, and `P ω` mean.

### 4. Show exactly what a human types and where

End every **In Lean** section with **Try it in the repository**:

- name the relevant `.lean` file;
- show the import plus the useful `#check`, `#print`, `example`, or `theorem`
  text a reader can type;
- distinguish a pedagogical excerpt from the exact checked project source; and
- give the literal repository command used to check the named file.

The standard single-file command is:

```sh
CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/path/to/Module.lean
```

That exact-project command belongs on an approved Linux builder or another
machine deliberately provisioned with the pinned project cache. Small,
self-contained Lean-core or `Std` tutorials may also include a local Mac/Linux
command. Label the difference and never let a “small tutorial” silently trigger
a Mathlib cache download or project compilation on this workstation. When
teaching Mathlib syntax, link it to a real project module and show the guarded
project command rather than leaving the reader with an isolated snippet and no
way to check it.

Use the shared `lean-bridge` shortcode to present the human, paper, and Lean
forms together, with a page-specific syntax map in its body. Use `repo-check`
after the copyable import and example block; it derives the file path from
`lean_module` front matter unless an explicit `module` parameter is needed.
These components enforce a recognizable teaching rhythm, but their text and
code must remain specific to the page.

### 5. Build the prerequisite vocabulary graph

Create substantive glossary entries, then link them at first use, for recurring
foundations including sample spaces, events, measures, probability measures,
null sets, measurable functions, random variables, probability distributions
or laws, almost-everywhere and almost-sure statements, integrability, and
expectation as they enter the project.

Keep neighboring ideas distinct. In particular, teach:

- a probability distribution is not necessarily a density;
- measure zero is not the same assertion as logical impossibility;
- almost everywhere is weaker than pointwise everywhere;
- a random variable is a measurable map, while its law is a pushed-forward
  probability measure;
- measurability and integrability answer different questions.

Do not create thin link targets. After adding a foundational term, scan every
glossary entry and Deep Dive for first uses that need a local definition and a
canonical `relref` link.

### 6. Audit the reader's climb

For every page, record and verify:

- its concrete example and computed result;
- each visual's teaching job and agreement with that example;
- the human-language, paper-math, and Lean versions of its core statement;
- its Lean syntax map and literal check command;
- prerequisite definitions and first-use links;
- its misconception or boundary case; and
- what the page does **not** claim.

Keep corpus-wide evidence for this audit. Headings and reusable components can
make the pattern legible, but examples, figures, translations, and limitations
must be bespoke enough to teach the actual concept rather than boilerplate.

## Definition of a good entry

A glossary entry is a compact teaching page, not a miniature paper. It should
give a careful newcomer a usable mental model while remaining precise enough
for a specialist to inspect.

Start new pages with:

```yaml
---
title: "Term"
slug: "term"
summary: "One plain-language sentence that states what the term means."
draft: true
pro_reviewed: false
---
```

Use a lowercase kebab-case bundle directory and matching slug; the page filename
inside the bundle is always `index.md`. The canonical public route follows the
same hierarchy: `/knowledge-base/glossary/<term>/`. Do not add a `url` override
or redirect aliases to a glossary page: the bundle path defines its public URL.
When a route changes, update source links to the canonical route. Search the
existing titles, slugs, and related terms before creating a page; extend an
existing entry instead of adding a near duplicate. Keep a new page in draft
unless the owner has explicitly authorized public working notes; publication
does not waive the review gate.

Use the smallest structure that teaches the concept well. The concrete worked
example, concept-specific visual, human-to-math-to-Lean translation, literal
repository command, prerequisite links, boundary case, and nonclaim required
above are part of the definition of done. Add second visuals, additional
examples, or supporting code only when they advance the reader's climb.

Keep equations and code consistent with the prose. Test executable snippets or
manually check them against every displayed example. State conventions such as
token IDs, ties, indexing, sidedness, threshold inclusion, and search scope
where they matter. Use `\(...\)` and `\[...\]` for math delimiters and define
each symbol on first use.

Goldmark parses Markdown structure before the browser receives a display-math
block. A line containing only `=` becomes a Setext heading, and a continuation
line beginning with `+`, `-`, or `*` can become a Markdown list item. Either
case splits the equation before KaTeX can render it. Keep an equals sign or
continuation operator attached to mathematical content. For multiline
equalities, prefer `aligned` with `&=` rather than a bare operator line:

```latex
\[
\begin{aligned}
f(x)
&= x^2 + x \\
&= x(x+1).
\end{aligned}
\]
```

Do not trust source inspection alone. The Playwright suite discovers every
knowledge-base page bundle containing display math, opens the rendered page in
Chromium, compares the number of source blocks with rendered KaTeX displays,
and rejects raw TeX, KaTeX errors, or accidental `<h1>` elements inside the
article body. Install it once with `npm ci` and `npx playwright install
chromium`, then run `npm run test:browser`. The standard `make check` and
`make ci` targets run this browser suite automatically.

### Format matrices as mathematics

- Never imitate a matrix with a Markdown or HTML table. Tables are for tabular
  data; matrix notation belongs in KaTeX.
- Put a worked matrix equation in one display-math block so the operands,
  operator, and result form a single readable expression. Use `bmatrix`, `&`
  between columns, and `\\` between rows:

  ```latex
  \[
  A=
  \begin{bmatrix}
  1 & 2 \\
  3 & 4
  \end{bmatrix}
  \qquad
  B=
  \begin{bmatrix}
  5 & 6 \\
  7 & 8
  \end{bmatrix},
  \qquad
  AB=
  \begin{bmatrix}
  19 & 22 \\
  43 & 50
  \end{bmatrix}.
  \]
  ```

- Use `\(...\)` only for short matrix references such as \(A\in
  \mathbb{R}^{m\times n}\). Use `\[...\]` for an actual matrix unless it is
  genuinely tiny and remains readable within a sentence.
- Keep punctuation inside the math block when the display completes a sentence.
  Build the draft site and inspect the rendered desktop and narrow layouts;
  source that looks aligned in Markdown can still overflow after KaTeX renders.

Prefer narrow claims: this model, readout, prompt position, tokenizer, test, or
experiment. Do not silently turn a site-specific observation into a universal
claim. In particular:

- distinguish an internal state from an analyst-applied readout;
- distinguish a score or rank from a calibrated probability;
- distinguish prediction or association from causal control and mechanism;
- distinguish observed rows from independent or exchangeable population draws;
- for statistics, name pairing, dependence, ties, sidedness, selection,
  effect size, and the population to which a claim may generalize;
- for token-level examples, account for tokenization and allowed variants;
- never invent a source, citation, measurement, or empirical result.

Use primary sources for technical claims that are version-specific, unstable,
or easy to misstate. Verify author names, dates, URLs, and direct quotations.
Avoid hype, chat residue, and em dashes except inside a direct quotation.

## Design the visual teaching path

Humans are visual learners. For every new glossary entry, and every substantive
revision of an existing entry, design at least one teaching visualization before
deciding the page is complete. The default is to publish a useful visual that
acts out the concept's central relationship: structure, transformation,
selection, dependence, a boundary rule, or a comparison that is hard to hold in
prose.

Omitting a visual is an exception, not an unexamined default. It is acceptable
only when an exact equation, table, or code example teaches the concept more
clearly than any honest diagram. Record that reason in the handoff and include
it in the Pro-review request. Never satisfy this gate with decoration or a
diagram that merely repeats a one-sentence definition.

Connected entries need complementary visuals. Give each figure a distinct
teaching job instead of cloning the same pipeline under several terms. For
example, an MLP figure can show one vector's intermediate-width transformation,
an FFN figure can show parameter sharing across token positions, and a
Transformer figure can show how attention and an FFN sit on a residual path.

Choose the lightest suitable format:

- Mermaid for a simple process, fork, or claim ladder.
- A conceptual SVG for a small teaching plate whose layout or visual grouping
  matters (bit layouts, pipeline diagrams, selection cartoons).
- A table for exact values a reader may want to cite.
- A real chart for empirical or dense quantitative series: generate a
  **high-resolution PNG** (or PDF) directly from the data in Python
  (Matplotlib, etc.). Do **not** hand-trace dense time series, scatter clouds,
  or many-point curves into SVG; that invites geometry and label errors.

For data-heavy plots, commit the generator, a receipt (or checksum) for the
plotted values, and the rendered PNG. Prefer `dpi=200` or higher. Point
`reference-figure` at the PNG. Keep a short conceptual SVG only when the
teaching job is structure, not a long numeric series.

Keep page-owned assets together. A Deep Dive's figures, generators, receipts,
datasets, notebooks, and derived artifacts belong in its page bundle beside
`index.md`. Use `blog-source/static/...` only for an asset that is genuinely
shared by multiple pages. A glossary entry follows the same ownership rule:
store its page-specific SVG, PNG, generator, receipt, and downloads beside its
`index.md`. Do not place a page-specific glossary asset loose under
`blog-source/static/knowledge-base/glossary/`.

Each conceptual SVG must:

- make one claim, usually with three to five clearly labeled regions;
- use the established warm-paper visual system and direct labels;
- set `xmlns`, `width`, `height`, `viewBox`, and `role="img"`;
- contain nonempty, direct-child `<title id="...">` and `<desc id="...">`
  elements and an `aria-labelledby` value containing both IDs;
- use labels, position, borders, or patterns so color is never the only signal;
- meet WCAG 2.2 AA contrast at the rendered text size, checking muted text in
  particular;
- keep text, arrows, bars, and annotations inside the viewBox without overlap;
- keep math in the Markdown body because KaTeX does not render inside SVGs;
- use valid UTF-8 and preferably ASCII text nodes, with no em dashes;
- preserve encoded geometry when objects are only being reordered or compared;
- avoid arbitrary bar lengths, unexplained transforms, and dashboard-like cards
  in place of a quantitative chart.

Do not hand-type empirical values into an SVG. A data-bearing figure requires
committed receipts, a generator with a byte-for-byte verification mode, a
provenance manifest, and a visible provenance link. Purely conceptual examples
may use clearly labeled toy values, but they must agree with the surrounding
worked example and must not look like measurements.

Embed SVGs with the shared shortcode:

```go-html-template
{{< reference-figure
  src="example.svg"
  alt="Finding-led description of the diagram's main point."
  caption="Complete visible explanation of every relationship or value a nonvisual reader needs, followed by the limits of the illustration."
>}}
```

For a page-bundle resource, use only the local filename in `src`; the shortcode
resolves it through the current page. Use a site-relative path only for an
asset intentionally shared from `blog-source/static/`.

The `alt` text states the finding, not the file type. The visible caption is the
full text equivalent for a complex figure and says what not to over-read. Do not
put essential caveats only inside the image.

A worked exemplar of a data-figure caption (from the BF16 Deep Dive's
cross-device divergence chart). Match this shape, not its length:

> **Finding:** four GPU generations (Turing, Ampere, Ada, Blackwell) produce
> nearly interchangeable divergence curves for the same operation and input
> bytes, while the CPU control is bit-identical on all 435 pairs at every size
> (zero divergence, omitted from the log-scale right panel). The exact-match
> rate collapses to about 0% by 32x32 output even though the divergence
> magnitudes stay at the scale of the last representable bit: observed maxima
> are exact powers of two (for example \(2^{-23}\approx1.19\times10^{-7}\)),
> the signature of reordered FP32 additions. The background-matmul arm
> (dashed) overlaps idle, so divergence persists under load but load was not
> shown to increase it. Values are stack-scoped observations, not universal
> constants. Generated by
> [plot_grid_sample_divergence.py](plot_grid_sample_divergence.py) from the
> [receipt](receipts/grid-sample-divergence.json).

Why it works, in order: it leads with the finding; it puts the control beside
the claim in the same sentence; it explains a visual encoding decision (why a
series is omitted from a log panel); it reconciles two metrics that could
seem to conflict (0% match rate versus tiny magnitudes) and names the
mechanism signature; it states the negative result explicitly rather than
letting the reader infer a load effect; it scopes the claim to the measured
stack; and it ends with clickable provenance (generator plus receipt).

Validate XML and inspect pixels. Check the raw SVG, the rendered term page at a
desktop width, and the page at a narrow mobile width. Reject figures with tiny
type, clipped geometry, label collisions, misleading scales, or meaning that
disappears without color.

## Pick a social share image for every glossary page with figures

Deep Dives have a stricter rule: every Deep Dive requires a 1200 by 630
page-bundle card for both its collection menu and social previews. Follow
`deep-dives/AGENTS.md` for that content type. The rules below cover the glossary
page bundles governed by this file.

When a page is shared on Twitter/X, iMessage, Slack, or similar, the link
unfurls using the page's Open Graph metadata. The base template
(`blog-source/layouts/_default/baseof.html`) emits `og:image` /
`twitter:image` from the `og_image` front-matter parameter and falls back to
the generic site logo when it is absent. A page whose figures carry the
finding should not unfurl as a generic logo.

For every new or substantially revised page that has at least one figure:

1. Pick the single most representative figure, preferring the data figure
   that states the page's finding over a decorative or purely structural
   plate.
2. Use a **PNG** (or JPEG), never an SVG: most link-preview scrapers do not
   render SVG. If the best figure exists only as SVG, export a PNG copy for
   the card. Landscape close to 1200x630 (roughly 1.91:1) crops best; our
   200-DPI Matplotlib PNGs at 2:1 are fine.
3. Store the card beside `index.md` and set its local filename in front matter.
   The shared featured-image helper resolves the page resource and emits an
   absolute social URL:

   ```yaml
   og_image: "example-card.png"
   ```

4. Confirm after building that the URL resolves in the generated `blog/`
   output, and sanity-check the card with a preview tool (or the platform's
   card validator) before promoting the page.

Text-only glossary stubs may keep the site-logo fallback; pages with real
figures should not.

Any interactive glossary artifact must be keyboard reachable, expose a visible
focus indicator, and retain a complete noninteractive text equivalent. Test it
with the keyboard alone before handoff.

## Pro review is a publication gate

`pro_reviewed: true` means the final connected glossary and every referenced
SVG source were reviewed for technical accuracy with the configured GPT-5.6
Sol Pro workflow. The SVG is part of the scientific content: its visible
labels, arrows, grouping, bit/geometry counts, `<title>`, `<desc>`, alt text,
and caption all belong in the review bundle as explicit `--path` inputs. Do
not claim a page is Pro-reviewed if its figures were not sent. Do not add or
retain that value merely because a page looks finished.

Pro review reads raw SVG source, which is suitable for checking claims and
accessible text but is not a substitute for inspecting rendered pixels. XML,
desktop, narrow-mobile, contrast, clipping, collision, and horizontal-scroll
checks remain separate publication gates.

This field is private editorial metadata. Do not render it as a public badge,
label, taxonomy, tooltip, or claim on the generated website.

For a new entry, start with `pro_reviewed: false` or omit the field. For an
existing reviewed entry, temporarily set it to `false` before a substantive
change to its definition, claim, equation, numeric example, code, caption, or
diagram. A spelling-only or purely presentational correction does not normally
invalidate the review.

### Glossary entries get exactly one full Pro review

A glossary entry requires exactly one full connected Pro review per publication
cycle. Include the Markdown and every referenced SVG or other reviewable figure
source in that review. A connected batch of glossary entries may share one
review bundle, provided every page and figure is named explicitly.

After that review, evaluate every finding, correct or consciously adjudicate
each clear `error` or `important` issue, and verify the corrected pages,
figures, links, equations, and examples locally. Do not submit glossary entries
for a second Pro round merely to review the corrections or obtain a `pass`
label. A continuation used only to recover an incomplete API response belongs
to the original review and does not count as another round.

When the single review is complete and no known substantive defect remains,
set `pro_reviewed: true`. Set `draft: false` only when the human has authorized
publication. If a substantive finding cannot be resolved or safely
adjudicated, keep `pro_reviewed: false` and `draft: true`, report the issue, and
ask the human for direction instead of spending money on another glossary
review.

This one-review rule applies only to glossary entries. Deep Dives and other
advanced connected bundles continue to use the multi-round stopping policy in
steps 7 through 9 below.

## Rebuild after major revisions

After any **major** content change, rebuild before continuing (Pro review,
handoff, or assuming the live `blog-serve` is healthy). Major means more than
a wording tweak: new or moved pages, new Deep Dives, new `relref` / `refterm`
targets, new shortcodes, new or relocated SVGs, Makefile / publish-path
changes, bundle-path changes, or front-matter that affects whether a page is
built (`draft`, `slug`).

Do not rely on a background Hugo server alone. Force an explicit rebuild and
read the exit status:

```bash
# Preferred when drafts must be visible (glossary stubs and draft Deep Dives):
make blog-drafts

# Or a fast Hugo-only check (include drafts when the changed pages are drafts):
hugo --source blog-source \
  --config "$(pwd)/blog-source/hugo.yaml" \
  --destination "$(pwd)/blog" \
  --buildDrafts \
  --noBuildLock
```

If `make blog-drafts` fails only on Prax sync, still run the Hugo command above
so link errors are caught. Fix every Hugo error before spending another Pro
review call. Common failure: `REF_NOT_FOUND` from a wrong `relref` path (Deep
Dives live under `knowledge-base/deep-dives/...`, not bare `deep-dives/...`).

If `blog-serve` is already running, confirm the log shows a clean rebuild after
your change (`ERROR Rebuild failed` means the site is stale until fixed).

Review workflow:

For a glossary entry, complete steps 1 through 6, then stop and apply the
single-review rule above. Steps 7 through 9 apply only to Deep Dives and other
content governed by the multi-round policy.

1. Finish the draft, cross-links, examples, code, and diagrams first.
2. Rebuild and fix Hugo / link errors (see **Rebuild after major revisions**
   above) before spending a Pro review call.
3. Build a narrow connected bundle and name every Markdown file and **every
   figure it references** (SVG and data PNGs). Always pass each figure with its
   own `--path`. Omitted figures are omitted from review; SVG source and dense
   charts often hide label, geometry, scale, or accessibility errors that prose
   review alone will miss. List them deliberately:

   ```bash
   python3 scripts/review_glossary.py \
     --path blog-source/content/knowledge-base/glossary/new-term/index.md \
     --path blog-source/content/knowledge-base/glossary/new-term/new-term.svg \
     --dry-run
   ```

   Read the printed artifact list and confirm that every referenced figure path
   is present before making an API call. Do not run Pro review on Markdown alone
   when the page embeds a figure.

4. Submit that exact connected glossary-and-figure bundle for review. Replace
   `new-term` with the term slug so private rounds remain distinguishable:

   ```bash
   python3 scripts/review_glossary.py \
     --path blog-source/content/knowledge-base/glossary/new-term/index.md \
     --path blog-source/content/knowledge-base/glossary/new-term/new-term.svg \
     --output .cache/glossary-review/new-term-round1.json
   ```

5. If the response is incomplete or contains no `output_text`, reuse its
   encrypted reasoning instead of restarting the review:

   ```bash
   python3 scripts/review_glossary.py \
     --resume-from .cache/glossary-review/new-term-round1.json \
     --output .cache/glossary-review/new-term-round1-continued.json
   ```

6. Evaluate every finding rather than applying it blindly. Correct factual,
   mathematical, code, diagram, and cross-entry problems. Verify suggested
   replacements against the sources and the worked examples.
7. For content governed by the multi-round policy, rerun the connected review
   after material fixes, using a new private output filename. Aim for a final
   verdict of `pass` with no unresolved `error` or `important` finding.
8. For content governed by the multi-round policy, **stop the review loop**
   (do not keep spending Pro calls chasing
   diminishing returns). Six rounds is far too many. Stop when any of these
   holds:

   - **Pass:** the latest verdict is `pass` and no unresolved `error` or
     `important` finding remains.
   - **Human-authorized early completion:** at least **1** full Pro review has
     completed, the author has considered its findings, and changes have been
     made in response. If the author then explicitly says the review is enough
     or directs publication, stop immediately. Do not spend money on another
     Pro call merely to chase reviewer polish or a `pass` label. Apply or
     consciously adjudicate clear substantive findings, set
     `pro_reviewed: true`, and proceed with the requested publication workflow.
     This human decision overrides the default expectation to continue toward
     three rounds.
   - **Hard cap:** you have completed **3** full review rounds on the same
     connected bundle (initial draft plus two fix-and-rerun cycles). Without a
     human-authorized earlier stop, do not stop merely because Pro is becoming
     repetitive or expensive; continue until `pass` or round 3. Never start
     round 4. At the cap, apply or consciously adjudicate every clear `error`
     and `important` finding, use editorial judgment to confirm that no known
     substantive defect remains, set `pro_reviewed: true`, and close the review
     gate even if the last response says `revise` because of polish or newly
     introduced nitpicks.

   If work stops for another reason before `pass`, explicit human authorization,
   or the three-round cap, leave `pro_reviewed: false` and `draft: true`. Hand
   off with a short summary of rounds run, the latest verdict, unresolved
   `error`/`important` findings, and why the loop stopped.
9. For content governed by the multi-round policy, after a clean `pass`, a
   human-authorized early completion, or the three-round cap, set
   `pro_reviewed: true`, rebuild the generated site, and rerun all
   checks. This metadata means the configured Pro workflow was completed under
   this policy; it does not claim that Pro returned a literal `pass` verdict.
   Remove `draft: true` or set it to `false` only with human approval to
   publish. An explicit direction such as “that is enough, push it” supplies
   both the early-completion decision and publication approval. If credentials
   or review access are unavailable before a stopping condition is reached,
   leave the page in draft, keep the internal review metadata false, and report
   the review as pending.

For round 2 and later on content governed by the multi-round policy, pass
`--review-round N`. The script then asks the reviewer to verify substantive
correctness and regressions instead of creating new stylistic or terminology
polish. A follow-up review should pass when no `error` or `important` issue
remains; optional minor refinement is not a reason to perpetuate the loop.
Never use `--review-round 2` for a glossary entry.

The script reads `OPENAI_API_KEY` or `OPENAI_KEY` from the environment or the
repository-root `.env`, sends requests with `store: false`, and confines raw
responses to `.cache/glossary-review/`.

Do not send embargoed, private-repository, reviewer-confidential, or otherwise
privileged material to the external review API without explicit authorization.
For normal public glossary drafts, summarize actionable findings for the human
when useful, but do not publish the private transcript.

Never expose, stage, commit, or publish:

- `.env` or any API key;
- raw review response files or encrypted reasoning;
- unredacted review transcripts kept as private working material;
- temporary SVG renders, contact sheets, or browser screenshots.

Before committing, confirm `.env` and the review output are ignored:

```bash
git check-ignore -v .env .cache/glossary-review/new-term-final.json
git diff --cached --name-only
```

Commit the corrected educational content, not the private review transcript.

Receipt-backed Deep Dives must satisfy the repository provenance schema, not
merely ship an informative JSON file. Their generated `provenance.json` files
must contain `generator`, `receipts`, `figures`, and `numbers`, with every
`numbers[].appears_as` string present in the neighboring `index.md`. A local
bundle must also hash-bind its generator, receipts, and empirical figures in
the format accepted by `scripts/check_provenance.py`. Fix the generator that
writes the manifest so regeneration cannot restore an invalid schema.

## Do not confuse artifact verification with repository validation

A page-specific generator can pass while repository CI still fails. Generator
verification proves that its own outputs are reproducible; it does not prove
that the output paths, manifest schema, rendered links, release-input state, or
site-wide checks satisfy the publishing repository. Treat the actual publish
repository's `make ci` result as the final technical gate.

Before copying or publishing a receipt-backed Deep Dive, confirm:

- [ ] Every page-specific figure and supporting artifact is inside the page
      bundle beside `index.md`; only genuinely shared assets live in `static/`.
- [ ] Every article, generator, review-bundle, and verification path reflects
      any asset move or rename.
- [ ] Each empirical figure is generated from committed data and hash-bound by
      a listed receipt; the generator's own `--verify` command passes.
- [ ] `provenance.json` contains `generator`, `receipts`, `figures`, and
      `numbers`, and sets `local_bundle` explicitly.
- [ ] Every listed figure exists, and every `numbers[].appears_as` string occurs
      verbatim in the neighboring `index.md`.
- [ ] `python3 scripts/check_provenance.py` passes, including local hashes.
- [ ] The complete site renders with the intended draft setting and every
      figure and download resolves at its final URL.
- [ ] After syncing to the actual publish repository, stage only the intended
      release inputs and run `make ci` there. A successful check in a drafting
      clone is useful but does not replace this final gate.

When CI finds a generated-file defect, repair the generator first and
regenerate the artifacts. Do not patch only the emitted JSON or image, because
the next reproduction run would restore the defect.

## Required handoff checks

Run these checks after the final review and regeneration:

```bash
python3 scripts/review_glossary.py --dry-run
python3 scripts/check_site.py
python3 scripts/check_provenance.py
npm run test:browser
xmllint --noout blog-source/content/knowledge-base/glossary/*/*.svg
xmllint --noout blog-source/static/knowledge-base/glossary/*.svg
make ci
git diff --check
rg -n $'\u2014' blog-source/content/knowledge-base/glossary blog-source/static/knowledge-base/glossary
```

The final `rg` command should find no em dashes outside direct quotations. A
no-match exit status is expected.

If Prax cannot be fetched but a local checkout is available, run:

```bash
make ci PRAX_DOCS_SOURCE=/absolute/path/to/prax
```

Before handoff, inspect the final diff for accidental generated churn, confirm
that `blog/` matches `blog-source/`, verify that the term appears once in the
glossary menu, and state whether the Pro review passed. Do not claim review,
accessibility, or validation that was not actually completed.
