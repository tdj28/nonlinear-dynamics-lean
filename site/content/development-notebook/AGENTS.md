# Development Notebook entries: read this guide first

## Local scope and terminology

- This file governs `site/content/development-notebook/**`.
- In inherited examples below, **Research Note** means a **Development Notebook
  entry** in this project.
- Map `blog-source/content/posts/**` to
  `site/content/development-notebook/**`, `blog-source/content/knowledge-base/**`
  to `site/content/knowledge-base/**`, and generated `blog/**` paths to
  `public/**`.
- Praxagent names, links, studies, and article titles below are historical
  examples of the editorial standard. They are not this site's name and must
  not be copied as local branding or treated as local artifacts.
- Local build targets are `make site`, `make site-drafts`, `make blog-serve`,
  and `make blog-serve-tailscale`.

## Authoritative local automation override

This guide was adapted from a mature sibling project whose review automation
is not part of this repository. For this project, the supported automated
content gate is `make site-check`; the repository-wide gate is `make check`.

Any deeper reference to `make ci`, `make blog`, `make blog-drafts`,
`$SKILLS_REPO/**`, `scripts/**`, Prax synchronization, or a Playwright suite is
a historical example, not a runnable or mandatory local command. Do not claim
that one of those checks ran, and do not create a substitute result. The path
mapping above and the local Makefile are authoritative.

The underlying scientific-review, reader-review, citation, provenance,
accessibility, and human-signoff obligations still apply. Perform and document
them manually when no local helper exists, and keep the page a draft whenever
a required review cannot yet be completed.

## Keep contributor infrastructure out of public prose

Development Notebook entries may teach two reader-facing execution paths:

- a **standalone tutorial** that imports only Lean core or `Std` and can run on
  macOS or Linux; and
- a **full project check** that uses the repository's pinned Lean and Mathlib
  dependencies and may require substantial disk space or build time.

Use portable commands for both. Never mention the owner's workstation, RunPod,
cloud approval, contributor-only guards, private networking, retained caches,
or internal release operations in rendered Notebook prose. Those constraints
belong only in this ignored `AGENTS.md`, the project skill, and
`checkpoint.md`.

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

## What the guide covers (orientation only)

- Levels of obligation: blockers vs strong defaults vs house conventions (§0)
- Human gate and canonical AI-use disclosure (§1)
- Dual-audience writing, paragraph rhythm, glossary pages (§2)
- Required study-report structure, including the early
  **Prior work / contribution / non-claims** block (§3.2) and the required
  **Discussion** section with its epistemic-downgrade rules (§3.3)
- Figures, receipts, machine-verified numbers, accessibility, SVG rules (§4–§5)
- Reference verification and citation hygiene (§6)
- Scope, claim fidelity, controls, summary-surface consistency (§8–§9)
- The pre-handoff agent checklist (§10)

## Scope of this guide

- Applies to all of `site/content/development-notebook/**`.
- The knowledge-base glossary has its **own, separate** guide:
  `site/content/knowledge-base/AGENTS.md`. Keep them separate; do not
  merge glossary rules into post rules or vice versa.
- Hugo ignores `AGENTS.md` files (`ignoreFiles` in `site/hugo.yaml`), so this file
  never renders on the site.

# Research Note Writeup

Status: **normative style and process guide for Development Notebook entries**

This document captures how we draft and revise Research Notes: depth
without opacity, figures as first-class evidence, verified references, and a
human-owned editorial gate. It is a bootstrap for agents and collaborators. It
is not a license to ship unedited prose under a human name.

We want an **aufbau** (build-up) sequence: earlier notes establish the
vocabulary and controls; later notes may spend less ink reteaching and more
ink on the new empirical claim. Not every post must be a full primer.

But also do not assume a reader has read any prior posts. You may refer to prior posts as necessary (by providing a link to the reader).

---

## 0. Levels of Obligation (added 2026-07-15)

This guide mixes three kinds of rule. Apply them with different weights, and
when flagging a draft, say which kind you are enforcing. A review that treats
a palette deviation and a missing control as equal-prestige failures teaches
authors to ignore both.

1. **Blockers (integrity; never ship a violation).** Human sign-off and AI
   disclosure (§1); claims that match the evidence, on every summary surface
   (§9.1); controls and baselines shown beside every headline number (§9);
   explicit limitations and non-claims (§3.2); verified, primary-source
   citations (§6); receipt-backed, machine-verified provenance for every
   evidentiary number (§5); retraction marking in every pull-able artifact
   (§9) and at the article level (§9.3); embargo and confidentiality handling
   (§1, §9.2). A draft failing any of these is not "done."
2. **Strong defaults (deviate only with a stated reason).** Structure and
   ordering (§3), figure grammar and chart-not-dashboard rules (§4.1),
   paragraph rhythm (§2.1), reference-page linking (§2.2), education patterns
   (§7), accessibility beyond alt text (§4.2). Deviations are legitimate when
   the author judges the note better for it; name the deviation in the
   handoff instead of silently absorbing it.
3. **House conventions (local production standards; enforced here, not
   universal principles).** The em-dash ban, KaTeX delimiters, Hugo
   shortcodes, file paths, SVG palette and text classes, `make` targets.
   Follow them on this site without debate, but do not present them to
   outside collaborators as laws of scientific communication; they are how
   *this* site stays consistent.

When review time is scarce, spend it top-tier first: reader trust depends on
the blockers, not on formatting debt.

---

## 1. Human Gate (Non-Negotiable)

Generative tools may scaffold structure, tables, figure captions, reference
lists, and first-pass prose. The human researcher then reshapes the draft like
a sculptor: cuts, reorders, sharpens claims, checks numbers against artifacts,
and owns every sentence that ships.

Rules:

1. The published voice is the author's. The agent draft is a bootstrap.
2. AI-use disclosure belongs near the top of every note. Use the **canonical
   panel in §1.2** (verbatim). Do not invent alternate warranty boilerplate,
   "as-is" legal paragraphs, or shorter one-liners.
3. Numbers, hashes, freeze commits, and figure files must be checked against
   the experiment release before publish, not trusted because they "look
   right" in the draft.
4. Scope language (what the method can and cannot support) is an author
   decision. Agents may propose caution; they may not soften or harden claims
   after the author has locked them without asking.
5. If the author is mid-sculpt (editing live on a local Hugo server), prefer
   small precise edits over regenerating whole sections.
6. **Confidentiality boundary for agents (added 2026-07-15).** Embargoed
   studies, unpublished drafts, private-repo contents, reviewer comments, and
   any manuscript received in confidence are privileged material. Agents may
   work on them inside the author's own environment, but may not paste them
   into external tools or services (web search engines, third-party APIs,
   hosted chat), quote them in public artifacts before release, or use them
   to answer unrelated requests. If a task seems to require sending
   privileged text outside the environment, stop and ask the author. This is
   the reviewer-side twin of the author-side AI disclosure in rule 2
   (compare ICMJE guidance on AI and privileged manuscripts; link in §11.1).
7. Before the note is "done," run an **adversarial read** whose only job is to
   reject the headline: a hostile reviewer, or an agent explicitly told to
   break the main claim: find the control missing from the prose, the baseline
   that ties the method, the base-rate that explains the effect, the figure that
   omits a condition, the word ("reveals," "detects," "knows") that claims more
   than the evidence. Treat every surviving objection as a required fix. This
   gate is what catches the failure in §9 before the public does.
8. **Run two separate bounded flagship Pro publication passes after the
   complete draft and final figures exist, before human sign-off.** The reviews
   have different jobs and must not be collapsed into one generic prompt:

   1. **Scientific integrity and reference gate.** Run
      `$SKILLS_REPO/scripts/review_experiment_plan.py --review-kind research-note-scientific`.
      Submit the complete note plus only the compact result summary or figure
      receipts needed to assess its claims. The reviewer attacks factual
      accuracy, claim fidelity, statistics, control and baseline reporting, scope,
      figure-to-text agreement, missing citations, and unnecessary citations.
      It must inventory every bibliography entry, name the exact claim each
      source warrants, and recommend removal when a reference is orphaned,
      redundant, weakly related, or likely to drag the article toward a claim
      it does not make. Fix and adjudicate this gate before the reader review.

   2. **Zero-context expert-reader and narrative gate.** Run
      `$SKILLS_REPO/scripts/review_experiment_plan.py --review-kind research-note-reader`
      on the scientifically corrected draft. The reviewer is an advanced expert
      in the broad area who has never seen this project or line of work. It
      grades the conceptual ramp, narrative cohesion, scope discipline, pacing,
      and figure integration. It asks whether the note assumes zero project
      context, holds the reader's hand through sequence rather than
      simplification, and still reaches the full technical peak. This packet
      normally needs the note only, not result evidence. A requested wording
      change that would alter the scientific claim goes back through the first
      gate or to the human author; narrative polish cannot silently change the
      result.

   Preserve the two responses in separate review directories and adjudicate
   every material suggestion separately. Apply fixes that improve accuracy,
   accessibility, or clarity; record a reasoned rejection when a reviewer
   misunderstands the design. Pro is an adversarial editorial channel, not
   independent verification and not the final author.

   Do not send raw data, per-trial records, activation dumps, long logs, or
   bulky manifests to either review. Keep each packet director-level and
   normally below the helper's default `$1.25` authorization; a costly packet
   is a compaction failure, not a reason to raise the budget. For a full-length
   note, prefer Pro mode with medium reasoning effort and start with 6,000
   requested output tokens per gate. If the provider returns `incomplete` at
   `max_output_tokens` with no review text, preserve the response and actual
   usage/cost receipt; that attempt does not satisfy the gate. Permit one
   bounded retry only when the packet is already compact, the failure is
   mechanical, cumulative cost remains reasonable, and the retry explicitly
   asks for a concise response. Do not add raw evidence or start an open-ended
   review loop.

### 1.2 Canonical AI-use disclosure (added 2026-07-18)

Paste the matching panel **verbatim** as the first body block after front
matter (before the abstract). Do not retitle it "AI-use disclosure &
disclaimer," append warranty language, or paraphrase the verbs.

**Default: study-report and other empiric notes** (compute ran, artifacts
exist, numbers ship):

```markdown
{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped implement, audit, execute,
interpret, visualize, review, and draft this study. The author selected the
research question, authorized the compute, has inspected the artifacts, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed Research Note. Verify numbers against the released receipts
before relying on them.
{{< /panel >}}
```

Use this default whenever the note reports a frozen study, instrument fit,
audit recovery, or other compute-backed result. Every clause must be true:
do not claim "has inspected the artifacts" or "authorized the compute" unless
the author did.

**Teaching-only twin** (primer, glossary Deep Dive, or other note with no
study execution / no compute authorization). Same panel title and closing
discipline; swap only when the default would be false:

```markdown
{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed Research Note. Verify claims against the cited primary
sources and any released artifacts before relying on them.
{{< /panel >}}
```

For Knowledge Base Deep Dives that render disclosure from front matter
(`ai_disclosure: |`) rather than a Hugo panel, put the **same markdown body**
in that field (no `{{< panel >}}` wrapper). Prefer the genre noun **Deep Dive**
in place of **Research Note** when the page is not a Research Note. Prefer the
default study wording when the Deep Dive ships receipt-backed numbers from a
run the author authorized.

---

## 2. Dual Audience Without Dilution

Write so a careful non-specialist can follow the argument, while a specialist
still finds the math, controls, and claim boundaries intact.

**Do:**

- Open with a `lead` that states the question and the result in ordinary
  language (before-and-after pairs, not jargon like "matched clean reference"
  until the term is defined).
- Put precise abstracts, equations, and frozen design tables after the lead.
- Use teaching tables with columns such as *What we shipped / In plain
  English / For specialists* for release inventory. On **study-report** notes,
  put that full table (and sample records) in the appendix (§3.1), not under
  the abstract.
- Define symbols on first use; keep a glossary when the note introduces a
  toolkit (SAE primer, J-lens release).
- Show the math. Do not hide \(h' = h + a d_i\) behind metaphor. Immediately
  say what the symbols mean in one short prose sentence.
- Put notation gotchas and easy misreads in `{{< panel "info" >}}` blocks
  (e.g. "\(D\) is a matrix, not a nonlinear function") so they stand out
  without interrupting the derivation voice.
- Prefer concrete numbers with units of evidence (template families, holdout
  scheme, AUROC with CI) over vibes.

**Do not:**

- Replace technical content with analogies that cannot be audited.
- Drop controls, CIs, or failure modes to "keep it readable."
- Use em dashes (U+2014 `—`), anywhere. Ban them on every surface: body,
  lead, key-result, abstract, figure notes, tables, panels, captions, and
  site glossary pages. Rewrite with commas, parentheses, colons, or
  periods. The only survivor is a direct quotation that already contains
  one. Before handoff, `rg '—' path` and fix every hit that is not inside
  a quote. (En dashes in numeric ranges like `1–10` and table blanks `–`
  are fine; those are not em dashes.) This is a §0 tier-3 house convention:
  enforce it fully on this site, but do not present it to outside
  collaborators as a principle of clear writing.
- Rely on bare `$…$` for KaTeX on this site; use `\(...\)` and `\[…\]`
  (bare `$` is disabled so currency like `$1.60` survives).
- Ship walls of text. Long abstracts, panels, leads, and body sections
  need paragraph breaks at natural claim boundaries (see §2.1).

### 2.1 Paragraph breaks (no walls of text)

Readers bounce off a single unbroken abstract or panel. Default rhythm:

- **Abstract / info panels:** one short open paragraph, then a blank line
  before each numbered finding `(1)`, `(2)`, …, plus a separate
  **Takeaway** paragraph. Forced-choice codas and caveats get their own
  paragraph when they would otherwise glue two claims together.
- **Lead / key-result / body:** break when the job of the paragraph
  changes (setup → result → control → caveat). Prefer several climbable
  paragraphs over one dense block.
- **Hugo panels:** blank lines inside `{{< panel >}}…{{< /panel >}}` become
  `<p>` tags via `RenderString`; use them.

If a paragraph is longer than roughly half a screen on desktop, split it.

### 2.2 Knowledge Base glossary (`/blog/knowledge-base/glossary/`)

Praxagent ships a Hugo **Glossary** inside the Knowledge Base
(`blog-source/content/knowledge-base/glossary/<slug>/index.md` →
`/blog/knowledge-base/glossary/<slug>/`). These are short, stable definition
pages for recurring technical terms (Jacobian lens, logit lens, greedy
continuation, temperature, top-p, sampling, p-value, hidden bridge, and so on).

**Default (unless the author asks for a standalone Research Note that teaches
the term):**

1. When a note needs a technical term, add or reuse a page under
   `content/knowledge-base/glossary/<slug>/index.md` instead of reteaching it
   inline.
2. Link from the note with a markdown link or
   `{{< refterm "slug" >}}` / `{{< refterm "slug" "display text" >}}`.
3. Keep each glossary page short: definition, one concrete example when
   it helps, cross-links, no mini-paper and no post-specific result claims.
4. New compound jargon gets its own page when named in another glossary entry
   (e.g. do not leave "temperature, top-p, or other sampling" unexplained
   inside greedy-continuation; give each term a page and link them).
5. Literature citations still belong in the post's end References list
   (§6). Glossary pages are the definition layer; bibliography is the
   warrant layer.

**Glossary discovery rule:** on every drafting or revision pass, inventory
the technical terms introduced by the edited prose and search
`blog-source/content/knowledge-base/glossary/` before writing an inline
explanation.

- If a matching glossary page exists, link it at first meaningful use.
- If no matching page exists, explicitly **suggest a new glossary page** to
  the author, including the proposed slug, title, and one-sentence scope.
  Create it when the requested scope includes glossary maintenance;
  otherwise leave the suggestion in the handoff rather than silently
  expanding the note.
- Do not emit a `refterm` shortcode for a slug that does not exist.
- Do not create near-duplicates because the display wording differs. Check
  titles, slugs, and related terminology first, then extend the existing page
  when that is the same concept.
- The glossary decision is binary and visible in the handoff: **linked
  existing page** or **proposed/created new page**. A recurring technical term
  should not remain unlinked by accident.

**Exception:** if the author explicitly wants a **standalone Research Note**
that teaches the term (primer / instrument post), write that note and link
it from later posts. Do not silently expand a glossary stub into a full
Research Note.

After adding glossary pages: `make blog-drafts` (or `make blog`) so
`/blog/knowledge-base/glossary/` updates.

### When *not* to reteach everything

A later note in an aufbau sequence may:

- link prior Research Notes *and* site `/blog/knowledge-base/glossary/` pages early;
- cite primer and instrument posts in the bibliography (§6);
- assume the reader can follow SAE decoder edits and J-lens readouts at a
  working level;
- spend pages on the new forensic question, access models, and results.

It should still:

- restate the claim boundary in one place;
- define any *new* terms for this experiment (prefer a site glossary page
  plus a one-line gloss in the note);
- remain readable in the lead and in figure captions.

Full in-post glossaries and learning-objective lists are appropriate for
foundation posts; they are optional on sequel notes that explicitly stand on
those foundations and on the site References index.

---

## 3. Structure That Matches the House Style

Typical front matter and early body for a **study-report** note (empiric
experiment with freeze + release artifacts):

1. YAML: `title`, `date`, `tags`, `author`, `summary`, optional `draft`,
   required `og_image` and `og_image_alt`, a multi-line `lead: |`, and an
   optional multi-line `key_result: |` (see below).
2. Optional **key-result standout box**: `key_result` front matter renders as
   a highlighted box between the lead and the table of contents (added
   2026-07-12; `single.html` + `.key-result` CSS). Give it the single most
   notable finding in 3 to 5 plain sentences with its headline numbers *and*
   the control that supports them. Do not restate the whole abstract.
3. AI-use disclosure panel (**canonical text in §1.2**; first body block).
4. Abstract panel (precise; may keep specialist diction; **break into
   paragraphs** per §2.1, not one wall of text).
5. **Thin study-status line** (complete / in progress; freeze + release
   commit pins) with a link to the appendix, not the full inventory table.
6. Conceptual figure or claim ladder near the top.
7. Early **Prior work / contribution / non-claims** block (see §3.2).
8. Body sections with one job each (argument and evidence).
9. **Discussion** section: the bigger-picture view, explicitly downgraded
   from the audited results (see §3.3).
10. Reproducibility / artifact ledger: **compact** link table; freeze vs
    release commits separated.
11. **Appendix: release inventory** (full explication; see §3.1).
12. References with stable links and anchor IDs (`#ref-…`).

Primer / instrument notes that are not study reports may omit the appendix
and keep teaching tables in the main flow when the table *is* the lesson.

Use Hugo shortcodes already in the site:

- `{{< panel "info|warning|quote|definition" >}}…{{< /panel >}}`
- `{{< mermaid >}}…{{< /mermaid >}}` for claim ladders and pipelines
- `<p class="figure-note">Figure: …</p>` under every figure

**When to use info panels (encourage, do not spam):**

| Use an `info` panel for… | Leave in body prose when… |
|---|---|
| Notation traps (`D(f)` means matrix multiply) | Ordinary symbol introductions |
| One-sentence "why this step" asides that would break a derivation | The main derivation steps themselves |
| Scope reminders readers often miss mid-section | Claim boundaries that belong in **Not claimed** (§3.2) |
| Monte Carlo / estimator clarifications | Full worked examples |

Prefer site `/blog/knowledge-base/glossary/` pages for recurring glossary terms (§2.2);
use a `definition` panel only for a one-off aside that does not warrant its own
page. Prefer `warning` for overclaim / misuse risks, and `info` for "hold
their hand here" clarifications. Keep each panel short (a few sentences +
optional display math); do not dump whole sections into panels.

Local preview: `make blog-serve` (include `--buildDrafts` while `draft: true`).

### 3.1 Study-report appendix: full explication lives at the back

For posts that report a frozen study (SAE audits, lens forensics, confirmatory
runs, and siblings), the main article argues the claim. The **appendix carries
the full release explication** so specialists can audit every file without
making the opening read like a shipping manifest.

Canonical shape (see *Can a Jacobian Lens Detect SAE Steering?*):

| Layer | Where | What belongs |
|---|---|---|
| Status pointer | After abstract | One sentence: study complete; freeze/release SHAs; link to `#appendix-…` |
| Compact ledger | Near end, before appendix | Artifact → URL table for people who already know what they want |
| Full inventory | `## Appendix: …` before References | Teaching table + sample records + field guides |

**Appendix contents (do not put these in the top-level flow):**

1. Study-status panel restating freeze-before-outcomes and public repo pins.
2. Teaching table: *What we shipped / In plain English / For specialists*,
   with deep links into freeze and release commits.
   **Licensing is a required field, not scattered prose (added 2026-07-15):**
   every artifact row states, in a fixed place, what is shareable, under what
   license (SPDX identifier or license name plus link), with what access
   conditions (open / gated / on-request / withheld), and any restrictions.
   "Cannot release" is a legitimate value when the reason is stated (compare
   the NeurIPS checklist's justified "no"). This is the structural home for
   the §9.1 rule that "open" means open and gated weights are "publicly
   released."
3. **Open a record** samples: one abbreviated artifact per major row so a
   reader sees what "shipped" looks like before downloading JSONL.
4. Every sample uses a fixed gloss order:
   - **Plain English** first (what the file means for a careful non-specialist);
   - **Technical** second (path, fields, statistic, commit);
   - then the snippet (JSON / CSV / hash line).
5. Prompt inventory, paired clean/steered worked example, and a field guide
   for dense JSONL schemas when the release stores scorecards rather than raw
   residuals.
6. Bootstrap / CI explanations in the same plain→technical pattern (e.g.
   template-cluster intervals: resample *families*, not item rows).
7. Structural audit pass + remote-to-local hash lines.

**Voice rules for the appendix (and the whole post):**

- Write to the public reader. Do not leave chat residue ("the blob you
  pasted," "as we discussed," side-channel addresses to the author).
- Assume a technically sophisticated reader who is encountering the project
  for the first time. Write a self-contained research narrative, not an update
  to the project owner: do not refer to "the original version of this note,"
  prior conversations, private decision ceremonies, or what "we now need to
  do." Express chronology as scientific motivation and study design.
- **Assume zero project context, then climb to the full expert view.** Hand-hold
  through sequencing, not simplification: begin with the phenomenon or question,
  supply the smallest useful mental model, define each object when it becomes
  necessary, show the experiment, and only then introduce the complete metrics,
  controls, uncertainty, and claim boundaries. The destination may be as
  technical as the evidence warrants; the path to it must be gradual and
  legible. Never dumb the result down, but never make readers decode the lab's
  history before they can care about the science.
- The opening screenfuls must not be a status ledger, caveat stack, acronym
  wall, audit narrative, or list of things the study did not do. First establish
  what is being measured, why the question matters, and the intuition behind
  the comparison. Introduce qualifications beside the claims they constrain and
  move exhaustive non-claims, chronology, and provenance to later sections.
- Keep internal experiment nicknames, run IDs, recovery labels, checksum
  inventories, and revision history out of the main argument. Put identifiers
  needed for reproducibility in a clearly labeled provenance appendix or
  artifact manifest.
- Do not call a follow-up the "actual experiment" or frame the next study as an
  instruction to the author. Describe completed work on its own terms and
  future work as a scientific implication or direct extension.
- Prefer "we" / impersonal procedural voice over second-person tutoring that
  sounds like a live debug session.
- Keep the appendix dense and auditable; keep the main narrative climbable.

**Split vs the reproducibility ledger:** the ledger is a map; the appendix is
a guided tour. Do not delete the ledger because the appendix exists, and do
not paste JSONL walkthroughs into the ledger.

### 3.2 Prior work, contribution, and non-claims (NeurIPS norms, note form)

NeurIPS (formerly NIPS) does not mandate a single "Related Work" template, but
its [Paper Checklist](https://neurips.cc/public/guides/PaperChecklist)
requires that abstract and introduction **state contributions clearly**, with
assumptions and limitations, and that claims match what the results support.
Conference culture usually adds early contribution bullets and explicit limits.
Adopt those **norms** on study-report notes; do **not** paste the full NeurIPS
checklist form into a post.

Place a short block early in the body (typically under *The Question*, after
the research question is set and before the first deep figure):

1. **Prior work:** 2–5 sentences naming the closest methods and results, with
   citations. Explicitly say what this note does *not* invent when standing on
   a known instrument (e.g. J-lens, SAE steering).
2. **This note's contribution:** 3–5 bullets, scoped to model / artifact /
   protocol / access model / public ledger. Prefer operational deltas over
   "we are first."
3. **Not claimed:** 2–4 bullets that block the usual overreads
   (consciousness, provenance forensics, universal generalization, label
   ontology, etc.).

Optional: a one-line scope note that the surrounding literature is still
preprint-heavy when that is true.

**Do not:**

- bury the only contribution statement in the abstract;
- use "novel / first / new" without a prior-work search (see §6);
- replace this block with a late dump of Related Work that never states the
  delta;
- emit a NeurIPS yes/no checklist at the end of the note.

Primer notes may use a lighter version (one paragraph of lineage + one
"what this teaches" list). Study-report notes should use the three-part block.

---

### 3.3 Discussion section: take the bigger picture, on a leash (added 2026-07-18)

Study-report notes **require** a `## Discussion` section (strong default;
deviate only with a stated reason, e.g. a pure replication with nothing to
add). Interpretation sections state what the experiment established;
Discussion adds value for expert readers by asking what the result *means*:
what kind of object the instrument is, why the observed
pattern was or was not expected under a simple conceptual model, what a
better instrument would look like, and what is and is not feasible next.

A good Discussion answers questions a thoughtful reader would actually ask
after the results ("is this just a first-order Taylor term failing?", "would
a second-order lens fix it?", "is the baseline secretly strong for a
structural reason?") rather than reciting generic future work.

Rules that keep its epistemic scope explicit:

1. **Open with an explicit epistemic downgrade.** First paragraph must say,
   in substance: everything in this section is interpretation; the audited
   results stand on their own; the hypotheses here need their own
   prespecified tests. This sentence is a blocker-tier claim-scope surface
   (§9.1), not decoration.
2. **Self-contained.** Define the conceptual frame inside the section (a
   reader landing here from a link should be able to follow it). Reuse of a
   frame from the body is fine; dependence on chat context, review threads,
   or another post's notation is not.
3. **No new evidentiary numbers.** Quote census values already receipted in
   the note; any fresh quantity must be a back-of-envelope with its
   arithmetic visible inline (e.g. parameter-count or storage-scale
   estimates), clearly not a measurement.
4. **Label mechanism talk as hypothesis, and point each hypothesis at a
   test.** "Looks like saturation" must arrive with the observation that
   motivates it and the experiment that would check it. The non-claims block
   (§3.2) still binds; Discussion may not quietly re-expand scope.
5. **Feasibility bounds are welcome.** Order-of-magnitude arguments about why
   an obvious "better instrument" is or is not buildable (storage, compute,
   access) are some of the highest-value Discussion content; give the
   arithmetic.
6. **Placement:** after Interpretation, before the reproducibility ledger.
   Keep it prose-first; one info panel for a compact technical aside is
   fine, a panel dump is not.

Worked example: the Discussion in *A Linear Nudge, a Nonlinear Wake*
(`posts/2026/07/jacobian-lens-intervention-test/`) frames the Jacobian lens
as the first term of a Taylor series, explains why the fixed-J linearity
"pass" was algebraically automatic rather than evidence, separates truncation
error from expansion-point error, gives the terabyte-scale argument for why
a shipped second-order lens is impractical while Hessian-vector products are
not, and closes by re-scoping everything as hypotheses for a future frozen
test.

---

### 3.4 The featured image is a summary surface (added 2026-07-18)

Every new Research Note, and every substantially revised existing note, must
ship a featured image. The same file appears in the Research Notes menu and is
emitted as `og:image` / `twitter:image` when the page is shared. Keep one
source of truth in front matter:

```yaml
og_image: "og-card.png"
og_image_alt: "Finding-led description of the card's meaningful visual content."
```

Store the file beside the note's `index.md`. Use a PNG or JPEG that is exactly
1200 by 630 pixels (40:21). Keep meaningful labels and geometry away from the
outer 48 pixels, and inspect the card both at full size and at the menu's small
thumbnail size. The linked menu image intentionally has empty HTML alt text
because the adjacent title and summary already name the destination;
`og_image_alt` supplies the image alternative for social clients.

Treat the card like the title, lead, and abstract:

1. It inherits every hedge, scope limit, control, correction, and retraction
   from the note. Never use a retracted chart or crop away a baseline needed
   to interpret a comparison.
2. It must not introduce a number, relationship, or causal claim that the note
   does not support. The adjacent menu summary must communicate the same core
   point so understanding never depends on seeing the image.
3. Prefer a purpose-built conceptual card or a claim-safe export of the most
   representative article figure. A dense chart that becomes unreadable at
   thumbnail size is not a useful featured image.
4. If the card carries empirical data, derive it from the same generator and
   receipts as the article figure, keep that full figure in the article with
   its caption and provenance, and include the card's source figure, alt text,
   and receipts in the scientific review packet. A conceptual card needs no
   empirical receipt, but its source SVG or generator must be committed.
5. Finalize the card before the two Pro publication passes. A substantive
   change to its claim, labels, crop, or alt text requires the affected review
   gate to be rerun. Pro review of source and claims does not replace rendered
   pixel inspection.

After building, verify that the menu thumbnail resolves, the page emits the
same absolute URL in `og:image` and `twitter:image`, both social alt tags match
`og_image_alt`, and the card remains legible without overflow on desktop and
narrow layouts.

---

## 4. Figures First

Lean on figures. A dense paragraph that could be a diagram should become one.
The primary author is a visual learner: when a result has a meaningful shape
across dose, layer, time, condition, or control, show that shape rather than
asking prose to carry it. Use multiple figures when they answer distinct
questions, especially an overview plus a diagnostic or depth-resolved view.
Do not inflate the count with decorative graphics: every figure must teach a
specific relationship, expose a control, or make provenance easier to audit.

| Kind | Use for | Examples in-repo |
|---|---|---|
| Conceptual SVG | One idea, few boxes, no chart junk | `three-claims.svg`, `access-model.svg`, `claim-ladder.svg` |
| Mermaid | Process / claim ladders / forks | SAE claim ladder; access-model flowchart |
| Empiric PNG/PDF | Frozen experimental plots | `sae_jlens_*.png` from the release `figures/` dir |
| Tables | Numbers a reader might cite | AUROC tables, per-feature heterogeneity, trajectory |

Every figure needs:

- meaningful `![alt text](file.ext)`;
- a `figure-note` that states what to see and what *not* to over-read;
- if the figure plots a metric for your method, the **same metric for the
  controls / cheapest baseline on the same axes:** a method-only plot invites
  over-reading (see §9); add the control series or cut the figure;
- if any series in the figure is later retracted or invalidated, the
  retraction must live **inside the image file itself** (see §9, rule 6):
  figures travel without their captions;
- **a provenance link under every figure AND every data table AND every
  key inline statistic (added 2026-07-14):** a one-line `figure-note` (or, for
  a stats-carrying paragraph, an inline citation) linking (i) the committed
  receipt file(s) holding the plotted/tabulated/quoted values, (ii) the
  generator script, and (iii) the verification path (`--verify` / provenance
  JSON), all commit-pinned URLs, so a skeptical reader can click from any data
  display *or any number in the prose* straight to the evidence that it wasn't
  invented. Every one of these numbers is also in the post's `provenance.json`
  manifest and re-derives under the verification script (§5 machine-verified).
  If a generator is not yet committed, say so in the note rather than omitting
  it: a named gap beats a silent one, but close it before publication;
- for any "best rank / peak / max-over-positions" value, a `figure-note` that
  names it as a max-statistic and shows (or points to) the same-statistic null,
  since base-rate-common targets read high under any transport;
- files that actually live in the Hugo content bundle (copy release PNGs into
  the post directory; do not assume path-only references render).

Copy empirical figures from the experiment release; do not regenerate them
"by eye." Hash-check against the release when auditing.

**A worked exemplar of a data-figure caption** (from the praxagent BF16 Deep
Dive's cross-device GPU-divergence chart). Match this shape, not its length:

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

The anatomy, in order: finding first; the control beside the claim in the
same sentence; a visual-encoding decision explained (why a series is omitted
from a log panel); two seemingly conflicting metrics reconciled (0% match
rate versus ULP-scale magnitudes) with the mechanism signature named; the
negative result stated explicitly instead of letting the reader infer a load
effect; the claim scoped to the measured stack; clickable provenance
(generator plus receipt) last. Every sentence does one of those jobs; a
caption sentence that does none of them should be cut.

### 4.1 Empirical figure guide: make a chart, not a dashboard

An empirical figure must expose the quantitative comparison through standard
chart grammar. A collection of cards, arbitrary bar lengths, and explanatory
text boxes is an infographic, not a substitute for a plot.

**Default chart grammar:**

1. **One quantitative question per figure.** State it in the title. If the
   figure needs two conclusions, split it.
2. **Use a shared axis.** Show tick marks, scale type, direction ("lower is
   better"), and the unit or statistic. Compared series use the same axis and
   probe convention. If values are not commensurable across models, group them
   by model and say to compare only within each group.
3. **Print exact values.** Geometry shows the pattern; labels preserve the
   auditable number. Do not make readers estimate a headline statistic from a
   bar.
4. **Use a real plot for empirical data.** Prefer grouped bars, stacked bars
   for counts that sum to a total, dot/lollipop plots for ranks, lines for
   ordered trajectories, and intervals when uncertainty exists. Decorative
   cards may summarize a result below the plot, but may not replace axes.
5. **Keep interpretation outside the plotting area.** The title and one short
   subtitle establish the comparison. Put caveats, tokenization notes, and
   provenance in the markdown `figure-note`. One short takeaway strip is the
   maximum inside the SVG.
6. **Use one visual language across a note.** Reuse dimensions, margins, font
   classes, palette, series order, and axis conventions. A reader should not
   have to relearn what color or bar direction means in every figure.

**Rank and max-statistic figures:**

- Default to a logarithmic axis of the **raw rank**, with 1 at the favorable
  end and an explicit "lower is better" label. For bars drawn from rank 1,
  shorter is better; for dots, farther toward rank 1 is better.
- Do not invent an undocumented "activity" transform merely to make the
  winning bar longer. If a scientifically defined transform is necessary,
  name its formula on the figure, print the raw rank, and explain why that
  transformed quantity is the estimand.
- Show the null or cheapest baseline on the same axis. A rank without its
  identical-search null is not interpretable.
- Do not compare absolute rank heights across different tokenizers, model
  vocabularies, or independently fitted lenses unless commensurability is
  established. Prefer paired within-model groups.

**Geometry and render gates:**

1. Every `rect` must satisfy `x + width <= viewBox width` and
   `y + height <= viewBox height`. Every line, circle, annotation, and value
   label must remain inside the viewBox with visible padding.
2. Never place a label beyond the right edge and assume responsive CSS will
   rescue it. The raw SVG is the artifact.
3. Validate XML, then inspect pixels. `xmllint --noout` catches malformed XML;
   it does not catch clipped bars, overlapping labels, microscopic type, or a
   misleading scale.
4. Open the raw SVG in a browser and inspect it at the article's rendered
   width. Also inspect the figure inside the post and at a narrow/mobile
   width. A full-width desktop screenshot alone is insufficient.
5. Check that all labels remain legible without zooming, no bar or value is
   clipped, group separators are clear, and the plot can be understood before
   reading the caption.
6. After replacing one bad figure, audit **every other empirical figure in the
   note** for the same failure pattern. Shared generators often reproduce the
   same overflow or infographic mistake across several files.

**Reject the figure before handoff if any answer is yes:**

- Is this a dashboard/card layout where a bar chart should be?
- Are bar lengths based on an unexplained transform or arbitrary pixel values?
- Is an axis, scale direction, unit, series label, or exact headline value
  missing?
- Does any geometry or text extend beyond the viewBox?
- Must the caption explain how to decode the basic geometry?
- Are invalid or retracted series presented as ordinary data?
- Does a sibling figure use the same metric with a different visual
  convention?

### 4.2 Accessibility is a publication concern, not a figure garnish (added 2026-07-15)

Alt text and SVG `<title>`/`<desc>` are necessary but not sufficient. If the
note claims a public reader as its audience, the whole page must be usable by
that reader, including one using a screen reader, keyboard, or high zoom.
Standard: WCAG 2.2 level AA as the working target (WCAG and the W3C WAI
complex-images tutorial are linked in §11.1).

1. **Complex figures need a full text equivalent, not just an alt string.**
   A chart, heatmap, or multi-panel plot conveys more than one sentence of
   alt text can carry. Provide the equivalent as (in preference order) the
   data table the figure was drawn from, a structured `figure-note` that
   states the series, axes, and the actual values a reader would take away,
   or a linked long description. The provenance receipt often *is* this
   equivalent; link it as such, not only as an audit trail.
2. **Alt text states the finding, not the file.** "Bar chart" is not alt
   text. "Grouped bars: J-lens rank 3 vs identity rank 1 vs random-J rank
   12,000; lower is better" is. Retraction-first alt for retracted series
   (§9 rule 6) already follows this principle.
3. **Headings and link text describe purpose.** Section headings say what
   the section establishes; link text says where it goes ("freeze commit
   `a1b2c3d`," not "here"). Bare "click here"/"this link" fails both screen
   readers and skimming specialists.
4. **Color is never the only channel.** The semantic palette (§5) encodes
   meaning; every meaning it encodes must also be readable from labels,
   position, or pattern. Check figure text and body text against a contrast
   checker at the rendered size; the muted `.m` class especially.
5. **Interactive elements (explorers, toggles, tabs) must be keyboard
   reachable with visible focus.** If a post ships an interactive artifact,
   test it with the keyboard alone before handoff.

Checklist enforcement lives in §10. Treat items 1–3 as strong defaults and a
missing text equivalent for a data-carrying figure as a blocker: a reader who
cannot see the figure is otherwise excluded from the evidence itself.

---

## 5. Creating SVG Diagrams

House SVGs are small, print-like teaching plates, not dashboard chrome.

**Gold-standard reference plates** (author-endorsed; copy their approach
before inventing a new layout):
`jacobian-lens-sae-steering/prompt-families.svg` and `downstream-layers.svg`.
What makes them work:

- Each takes **one dense sentence from the prose and acts it out**: the fold
  diagram literally shows families as blocks landing wholly in train or test;
  the layers diagram literally shows the fingerprint bar shrinking as depth
  increases. The reader can check the diagram against the sentence.
- **Concrete instances, not abstractions**: real prompt text in the chips,
  real layer numbers and real measured values on the bars, so the plate
  doubles as evidence rather than decoration.
- A **"why it matters" or takeaway element** carries the interpretive load
  (the footer bar, the small side card), so the geometry stays clean.

### Visual system

Match the gold-standard plates above (plus
`how-to-read-an-sae-feature-id/*.svg` and `random-j-impostors.svg`):

- Background fill `#F7F4F0` (warm paper).
- **Semantic palette** (fill / stroke pairs; keep meanings consistent across
  plates so readers learn the code once):
  - Cool blue `#E8F0F7` / `#4B6787`: data objects (families, features,
    bars, the "real" artifact).
  - Cream `#FBF9F6` / `#C4B8A8` (or `#D9D0C4` for larger cards): neutral
    chips, labels, container cards.
  - Green `#EAF1E5` / `#6F8D5E`: train side, positive/kept, and the
    **footer takeaway bar**.
  - Clay/tan `#F3E8E0` / `#A67C52`: test side, held-out, highlighted or
    warning element; also arrow strokes.
  - Warm gray `#EDE8E1` / `#7F786D`: de-emphasized alternates.
  - Dashed dividers stroke `#A89B8C`, `stroke-dasharray:5 4`.
- **Standard text classes** in a `<style>` block; reuse these names:
  `.t{font-family:Inter,Arial,Helvetica,sans-serif;fill:#2C2924}`,
  `.title{font-size:15px;font-weight:700}`, `.h{font-size:13px;font-weight:700}`,
  `.s{font-size:12px}`, `.m{font-size:11px;fill:#5A544C}`.
- **Header pattern**: bold title at `x=24 y=28`, one muted supporting
  sentence at `y=48`.
- **Footer takeaway bar**: full-width green rounded rect at the bottom with
  one `.s` sentence stating the point of the plate.
- Rounded cards (`rx="10"` or `12`), light strokes (`1`–`1.6`).
- Width usually `720`–`760`; height sized to content; include `viewBox`.
- Always set `xmlns`, `role="img"`, and `<title>` / `<desc>` for a11y.
- **No math notation inside SVGs.** KaTeX does not render there; equations
  become raw text. Use words and geometry in the plate; keep the math in the
  markdown body next to it.
- Check label collisions: value labels, arrows, and annotations must not
  overlap; move a value label inside its bar or shift the arrow rather than
  letting them stack.
- **Bar direction must match a visible axis (revised 2026-07-15).** Do not
  force every winner to have the longest bar. For ordinary counts and
  magnitudes, longer means more. For rank-style data, default to a
  logarithmic **raw-rank** axis labeled "lower is better"; bars drawn from
  rank 1 are shorter when better. This is acceptable because the axis states
  the quantity directly. Avoid opaque activity/quality transforms such as
  `log2(K / rank)` unless that transformed value is itself the scientific
  estimand. If a transform is used, put the formula in the figure and print
  the raw values.

### Data integrity: figures are generated, never hand-numbered (added 2026-07-14)

An LLM hand-authoring an SVG can hallucinate a number, and a published figure
with an invented statistic is a reputation-ending failure mode. Every
data-bearing figure therefore ships with all of:

**Empirical geometry must come from code reading machine-readable evidence.**
Use Python/Matplotlib or an equivalent plotting library to read the audited raw
or compact result artifact and compute the plotted coordinates systematically.
SVG is encouraged as an output format, together with PDF and a 300-DPI PNG
fallback; it is not permission for an agent to inspect results and hand-author
SVG points, paths, bars, labels, or values. A hand-written SVG is permitted only
for a purely conceptual diagram with no empirical geometry. Never trace a chart
by eye, paste values from chat, or edit a generated SVG to make the pattern look
cleaner.

1. **A generator + verify script.** The SVG is *emitted by a script that
   computes every number from the committed receipts*; hand-typing data
   values into figure markup is forbidden. The same script has a `--verify`
   mode that regenerates from the receipts and asserts the file on disk is
   **byte-identical**; any drift (stale figure, edited number, hallucinated
   value) fails loudly. Run `--verify` as part of the pre-publish checklist.
2. **A provenance JSON next to the figures** (e.g. `fig-*-provenance.json`,
   inside the post bundle so it publishes with them): the receipt files and
   their SHA-256 hashes, every computed statistic shown in any figure, the
   generator's path and its own hash, and the repo it lives in. A reader
   (or a future agent) must be able to re-derive every number in every
   figure from that file alone.

3. **One self-contained receipt JSON per empirical figure.** Do not make a
   future auditor infer which portion of one large manifest belongs to a plot.
   Name it `<figure-stem>.receipt.json` and publish it beside the figure. It
   contains, at minimum:
   - `figure_id`, `title`, `description`, and highly descriptive `alt_text`;
   - `data_source` with artifact name, exact source fields, source SHA-256,
     row/condition selection, aggregation, and transformation;
   - `provenance` with study/run ID, generator path and SHA-256, plotting-library
     version, and hashes for every SVG/PDF/PNG output;
   - the exact derived values or a compact machine-readable plotted-data table;
   - uncertainty semantics (confidence interval, stability interval, or fixed
     census range) and claim-scope exclusions; and
   - accessibility checks, including that color is not the only channel and
     that the same alt text is embedded in supported image metadata and used at
     the article embed.

   A post-wide receipt index hashes every per-figure receipt. The plotting
   script validates expected row counts and study/target guards before drawing,
   and verification fails if the source hash, generator hash, receipt, or output
   bytes drift. The receipt is both audit evidence and the long text equivalent
   required for a complex figure under §4.2.

Pure-concept plates (no data series, no statistics) are exempt from the
generator requirement but not from the ban on invented numbers: if a number
appears, it traces to a receipt. Matplotlib figures exported from analysis
code already satisfy rule 1 by construction; they still need the provenance
entry, and regenerating them must not silently drop in-image retraction
banners (re-inject and re-validate after every regeneration).

3. **Rebuilding a lost-generator figure: re-derive, and reconcile a mismatch
   explicitly; never fit the convention to the old number (learned 2026-07-14).**
   When a published figure's plotting script was never committed and you rebuild
   it from the receipts, gate the rebuild on the *published* numbers: assert the
   recompute equals what shipped, and fail the build on any drift. If a value
   does **not** reproduce, the cause is almost always a **probe/convention
   difference, not a transcription error:** e.g. an "output head at rank 2" that
   was scored on the model's *emitted sub-word* ("Mos") while the sibling readers
   used the *merged single token* ("Moscow" = rank 92). The trap is to silently
   adopt whichever convention reproduces the old number; that is fitting the
   figure to the claim, and it is a form of fabrication. Instead: (a) put every
   compared series on **one consistent probe**, (b) report the value that
   convention gives even when it *weakens* the story, and (c) **disclose the
   alternative convention explicitly** in the figure and text (both numbers are
   often legitimate; say so). A rebuild that "passes" only because you loosened
   the probe to match a stale number has verified nothing. Also reconcile the
   **run ledger** the provenance links point to: if the ledger reported a mean
   and the figure plots a median, add a dated note naming the difference so a
   reader following the provenance link finds agreement, not a contradiction.

### Every published number is machine-verified back to a receipt (added 2026-07-14)

The rules above cover *figures and tables*. But **a number in body prose is
data too:** "self 134 vs other 279, 14/16, p=0.004", "Δ = −2.81", "rank 92".
Inline stats are the easiest place for a hallucinated or drifted number to
slip through, because no chart forces them through a generator. The standard is
therefore blunt: **every quantitative claim anywhere in the post (figure, table,
or sentence) traces to a committed receipt, and a *machine*, not a human
eyeball, confirms it.** Build the checks and balances so fabrication fails the
build instead of reaching a reader. Concretely, every data post ships with all
three of:

1. **A post-wide provenance manifest** (`provenance.json` in the post bundle),
   enumerating *every* published number (inline, table cell, and figure value)
   alike. Each entry records: the claim/label as it appears, the value, the
   **receipt path + its SHA-256**, and the exact field or computation that
   yields it (e.g. `median over div_*__nothink of probe_best_rank['Moscow']`).
   The per-figure `fig-*-provenance.json` is a subset of this; the manifest is
   the whole post's ledger. Test: *a skeptic (or a future agent) can re-derive
   every number in the post from this file plus the committed receipts alone.*
2. **A verification script that re-derives and asserts:** the generator's
   `--verify` mode, extended to the whole manifest: it recomputes each listed
   number from the receipts and fails loudly on any mismatch, and it **asserts
   every commit-pinned GitHub URL in the post resolves** (`git cat-file -e
   <sha>:<path>` for each, so a typo'd or invented SHA/path fails rather than
   404-ing for a reader). Wire it into note CI (`make check`) so a number that
   drifted, a link that rotted, or a stat someone hand-edited into the prose
   cannot pass. This is the check-and-balance: the repo, not the author, is the
   thing that certifies the numbers.
3. **A resolvable provenance link under every data display AND every inline
   statistic block** (§4). Figures and tables get their `figure-note`; a
   paragraph carrying key stats gets an inline citation to the same receipt.
   A number with no reachable receipt does not ship: a named gap ("generator
   not yet committed; receipt above holds every value") beats a silent one, but
   the gap must close before publication, not linger.

Never let convenience erode this: do not paste a number from memory, from an
earlier draft, or from a chat scrollback into the prose; pull it from the
receipt through the manifest. If you cannot point a reader at the exact bytes a
number came from, the number is not ready to publish. See EXPERIMENT_INTEGRITY
§13 (release the evidence) and GPU_COMPUTE §7 (the receipt is the provenance
root, published numbers must re-derive from it).

**Scope the ceremony to the stakes (added 2026-07-15).** The full
manifest-plus-CI treatment exists to protect the numbers reader trust rides
on. Distinguish two tiers rather than certifying every syllable:

- **Evidentiary numbers** (anything a reader could cite as a finding:
  headline stats, table cells, figure values, CIs, p-values, ranks, deltas,
  counts of successes/failures, and every number on a summary surface) get
  the full standard above: manifest entry, receipt + SHA-256, `--verify` in
  CI, resolvable provenance link.
- **Incidental numbers** (context that no claim rests on: "a 397B-parameter
  model," "three prompt families," "layer 40 of 61," publication years,
  section counts, rough runtimes given as color) need to be *correct and
  checkable* (traceable to a config, model card, or repo a reader can open)
  but do not need individual manifest entries or CI assertions.

The classification is itself an editorial act: when in doubt, or when a
number could plausibly be quoted as a result, it is evidentiary. What the
tiering may never do is downgrade a number *because* instrumenting it is
inconvenient; the test is what the reader would do with it, not what the
author would rather skip.

1. One thesis per SVG. If you need two theses, make two files.
2. Prefer 3–5 labeled regions over dense annotation.
3. Caption in the markdown `figure-note`, not a novel inside the SVG.
4. **UTF-8 only, preferably ASCII in text nodes.** Invalid encodings
   (Windows-1252 middle dots, curly quotes, corrupted deltas) cause browsers
   to refuse to paint the SVG. Use `->`, `delta`, `+/-`, and plain hyphens
   inside the file; keep fancy Unicode for the markdown body if needed.
5. Escape or avoid raw `&` in text nodes (`xmlParseEntityRef` breaks the
   whole file); write `...` instead of `& so on`, or use `&amp;`.
6. Validate and *look at* the render before ship:

```bash
python3 -c "from pathlib import Path; import xml.etree.ElementTree as ET
p=Path('access-model.svg'); p.read_text(encoding='utf-8'); ET.parse(p); print('ok')"
rsvg-convert -w 1520 -o /tmp/preview.png access-model.svg  # then inspect the PNG
```

7. Open the raw URL under Hugo (`…/access-model.svg`) as well as the post
   page; a 200 with broken bytes still fails in the browser.

### Minimal template

```svg
<svg xmlns="http://www.w3.org/2000/svg" width="760" height="280"
     viewBox="0 0 760 280" role="img"
     aria-labelledby="titleX descX">
  <title id="titleX">Short title</title>
  <desc id="descX">One-sentence description of the claim.</desc>
  <rect width="100%" height="100%" fill="#F7F4F0"/>
  <style>
    .card{fill:#E8F0F7;stroke:#4B6787;stroke-width:1.5}
    .t{font-family:Inter,Arial,Helvetica,sans-serif;fill:#2C2924}
    .h{font-size:14px;font-weight:700}.s{font-size:12px}.m{font-size:11px;fill:#5A544C}
  </style>
  <text x="24" y="28" class="t h">Headline</text>
  <text x="24" y="48" class="t m">Supporting sentence.</text>
  <rect class="card" x="24" y="70" width="340" height="160" rx="12"/>
  <!-- more regions -->
</svg>
```

Mermaid is complementary: use it for directed claim ladders and access forks;
use SVG when layout, color coding, or side-by-side panels matter.

---

## 6. References and Literature Search

References are part of the scientific claim, not decoration.

### ArXiv is suggestive, not authoritative

Treat arXiv as a distribution channel, not a quality stamp. A preprint is a
primary source for what its authors report, propose, and release; it is not
authoritative validation that their interpretation is true. Use preprints as
provisional evidence, method leads, prior art, and hypothesis generators.
Attribute unreplicated conclusions with language such as "the preprint
reports," "proposes," or "suggests." Never upgrade a preprint to "proves,"
"establishes," or scientific consensus merely because it has an arXiv page.

Do not dismiss strong work solely because it is a preprint, and do not treat
peer review as a truth guarantee. Calibrate confidence to methods, controls,
data and code availability, corrections, independent scrutiny, and replication.
For every consequential arXiv citation:

1. check the full paper rather than relying on its abstract;
2. check for a DOI, peer-reviewed successor, materially newer version,
   correction, withdrawal, retraction, or independent replication;
3. record the arXiv ID, exact version and version date, access date, and known
   publication status in reference provenance; and
4. prefer the peer-reviewed version of record when it exists, citing both only
   when a material version difference matters to the claim.

If no independent support exists, say so when the preprint is consequential to
the argument. Released code or data can make a claim more inspectable, but does
not itself turn the claim into authority.

### Process

1. **Map the claim tree** (method, controls, null interpretation, deployment
   limits, adjacent dissenting results).
2. **Search deliberately** for each node: core method papers, geometric /
   methodological caveats, alternative auditors, and results that could
   contradict a too-broad reading of *your* null or positive.
3. **Verify on the live web** (arXiv abs page, project site, GitHub, HF model
   card). Confirm title, authors, year, and URL. Do not invent authors or
   swap papers (e.g. do not attribute Latent Introspection to the wrong lab).
   **A link handed to you (even a correct arXiv ID) may not be the primary
   source you think it is.** Open it and confirm its *role*: a paper that
   *cites* X is not X (a plausible arXiv ID we were handed was a third-party
   negative-results paper, not the blog it referenced); a "paper" URL may be a
   commentary companion, not the paper (an Anthropic CDN PDF turned out to be
   invited *external commentary*, not the workspace paper itself); the primary
   source for a coined term (e.g. "logit lens") may be a blog post, and a
   same-neighborhood arXiv is not a valid substitute for it.
4. **Cite in the body** at the sentence that needs the warrant, with
   markdown links to `#ref-…` anchors.
5. **List at the end** with stable URLs. Prefer the DOI, publisher, or
   proceedings page for a peer-reviewed version of record. When only a preprint
   exists, link the arXiv abstract and record its exact version, date, access
   date, and publication status. Use commit-pinned GitHub paths for artifacts.
6. **Separate freeze from release** when linking experiment repos: protocol
   commit vs results commit.

### What "directly relevant" means

Include sources that:

- define the instrument you use (e.g. Jacobian lens / workspace paper);
- define or critique SAE features and faithfulness;
- justify or limit fixed linear steering;
- supply stronger or alternative state auditors if you claim a null for *your*
  readout family;
- warn against overreading probes and decoders.

Exclude:

- name-dropping unrelated prestige citations;
- papers you have not opened enough to know what they claim;
- rival drama that is not needed for the operational claim.

### House citation hygiene

- Anchor IDs: `<a id="ref-gurnee-2026"></a>…`
- Inline: `([Gurnee et al., 2026](#ref-gurnee-2026))`
- Cross-link prior Praxagent notes when this post sits in an aufbau sequence.
- After expert review, adopt scope rewrites that keep the narrow empirical
  claim and add missing adjacent literature; do not inflate claims to match
  the bibliography.
- **Search for prior work on your *contribution*, not only your method.**
   "New," "first," and "novel" are claims that require a search: look for anyone
   who already did the specific thing you are claiming as yours. If they exist,
   cite them and narrow the claim; do not discover them after publishing. (A
   companion-commentary search surfaced an independent open-weight replication
   that predated our own "reproduction on open weights"; the required
   correction was to cite it and reframe our contribution as the narrower
   delta.)

---

## 7. Education Patterns (From the Foundation Posts)

Steal these moves from the SAE primer and the Qwen J-lens release when the
note is foundational:

| Pattern | Purpose |
|---|---|
| Learning objectives | Tell the reader what success looks like |
| Reading paths | Let specialists skip to evidence; learners take the math path |
| Quick glossary | Shared vocabulary before history and formalism |
| Claim ladder (mermaid or SVG) | Separate descriptive, causal, and overclaimed rungs |
| Worked example | One concrete public artifact so abstractions land |
| Provenance tables | Checkpoint, revision, what is verified vs open |
| Equation then prose | Symbol block, then one sentence in English |
| Notation / gotcha `info` panels | Flag easy misreads (`D` is a matrix; MC ≠ MCMC) without derailing the climb |
| "What this is not" panels | Block consciousness / mind-reading / provenance overreach |

Sequel notes may inherit these by link rather than reprint.

---

## 8. Scope, Evidence, and Voice

- Prefer narrow operational claims: *this model, this SAE, this lens, this
  score, this access model*.
- Use mathematically exact evidentiary verbs. An ordinary computation checks
  arithmetic or selected finite cases; a verified exhaustive computation may
  establish a finite proposition when its coverage and trust boundary are
  explicit. An example illustrates or exhibits; an explicitly named
  counterexample refutes a universal claim; and a proof, theorem, or complete
  argument establishes a general result. A concrete example can establish
  existence or refute a universal claim when its role as a counterexample is
  stated explicitly. Figures explain; any proof lies in the accompanying
  argument. Lean's elaborator constructs a candidate proof term and its kernel
  checks that term against the formal statement, not the statement's fidelity
  to the intended informal theorem or physical interpretation. Avoid generic
  claims that an example, worksheet, diagram, or compiler “proves” something.
- Remove canned transitions, promotional or anthropomorphic language, and
  dismissive shortcuts such as “obvious,” “clearly,” “simply,” “trivial,” or
  “of course” when they replace a reason. Make the prose accessible by
  controlling the order of ideas, not by relaxing mathematical precision.
- Replace moralizing proxies such as “honest,” “dishonest,” “pretend,” or
  “smuggle” with the precise defect: an omitted assumption, invalid
  implication, undefined construction, unsupported claim, or scope mismatch.
- Label post-hoc analyses as post-hoc.
- Keep failed features and chance nulls in the ledger (e.g. feature 23893).
- Distinguish suggestive vendor labels from ontology.
- Avoid em dashes entirely (see §2); avoid hype adjectives.
- **Prefer inclusive alternatives to exclusionary or ableist jargon.** Where a
  precise, neutral term exists, use it:
  - *ableist metaphors* → *outcome-masked* / *outcome-independent* rather than
    "outcome-blind"; "without visibility" or "we cannot tell slow from stuck"
    rather than "flying blind";
  - *othering or race-coded naming* → *denylist* / *blocklist* rather than
    "blacklist"; *allowlist* / *safelist* rather than "whitelist";
    *primary/replica*, *leader/follower*, or *main/secondary* rather than
    "master/slave"; *main* rather than a "master" branch.

  Keep an original term (e.g. *blind*, *double-blind*, *masked*, or a `whitelist`
  flag an API actually exposes) only where it is an **established term of trade
  the field still uses**, or where you are **quoting or citing a specific source,
  identifier, or config key** that used it, then reproduce it verbatim. The rule
  is narrow: do not *coin* new jargon on this language when a clear alternative
  exists, and do not rewrite a standard term, a direct quotation, or a real code
  identifier just to avoid the word.
- First person is fine when the author is making a judgment call ("I added one
  explicitly post hoc score…").

### 8.1 Surprise is a prediction-gap claim (added 2026-07-17)

"Surprising" is relative to an informed audience's prior expectation. It is
not a synonym for large, significant, interesting, or nonlinear. When surprise
matters to a title, lead, abstract, figure caption, or conclusion, write a
compact prediction-gap ledger before drafting:

`relevant audience or benchmark | expected result | source and timing | observed result | warranted update | evidence breadth`

Then make three things legible in the article:

1. **Expectation:** what a named relevant audience, published model, frozen
   baseline, or prospectively recorded forecast would have expected, and what
   evidence supports that description;
2. **Observation:** what the study found, with the same controls, uncertainty,
   and scope used elsewhere; and
3. **Update:** what understanding should change and what remains unresolved.

Say whether the expectation was recorded prospectively, reconstructed from
prior literature or a baseline, or inferred only after the result. A frozen
decision threshold is a falsifiable benchmark, not automatically an audience
prior. If no audience prior was measured, say so rather than writing "the field
was surprised." A post-outcome explanation may be useful abductive reasoning,
but label it as a hypothesis generated by the observation. Do not rewrite it as
the study's original prediction or a confirmatory result.

Do not reverse-HARK by choosing, after seeing the outcome, whichever audience
makes the result sound most unexpected. If plausible expert audiences had
different priors, report that heterogeneity or compare the result with several
relevant baselines. Formal prior elicitation may be useful in some studies, but
it is a proposed research direction, not a validity requirement this guide
imposes.

Calibrate surprise language to both the prediction gap and the evidence behind
the observation. A single-model fixed census can establish a sharp local
mismatch without warranting field-wide or paradigm-level rhetoric. Reserve the
strongest language for genuinely independent convergence across methods,
datasets, researchers, or mechanisms. Confirmation and null results remain
publishable; do not optimize a note for surprise at the expense of truth.

---

## 9. Report the Controls, Not Just the Claim

The most expensive editing failure we have shipped against was not a wrong
number: it was a *right* number reported without its controls. A flagship claim
("the lens reveals a signal the model's output hides") survived to a near-final
draft because the controls existed in the receipts and the analysis, but not in
the prose or the figures. When the control column was finally placed beside the
headline, a plain baseline (a logit lens and the model's own output head) read
the same signal as well or better, and the claim evaporated.

This is a *writeup* lesson, distinct from running the controls (that is the
[experiment-integrity playbook](./EXPERIMENT_INTEGRITY_SKILLS.md)'s job).
Running a control and *showing* it are different acts, and only the second is
transparent to the reader.

1. **Every headline number appears beside its controls and its cheapest prior
   baseline, on the same statistic, in the same table or figure.** A reader must
   see the contrast without opening the repo. If your method's number is
   striking alone and ordinary beside a logit lens or a random null, it was
   never striking.
2. **The finding is the contrast, not the target value.** Write "X reads at rank
   3, vs identity at rank 1 and random-J at rank 12,000," not "X reads at rank 3
   (top 0.01% of vocabulary!)." An absolute number without its null is rhetoric.
3. **Name the max-statistic.** "Best rank," "peak layer," or "max over
   positions" is a minimum/maximum over many cells and drifts far from chance
   under a null; quote the null on the identical statistic. Base-rate-common
   targets (frequent tokens, near-certain completions) inflate any readout: a
   high reading of a high-prior item is mostly the prior, and the figure-note
   must say so.
4. **A method-only figure is a misleading figure.** A plot that shows only your
   instrument's trajectory, with no control series, invites over-reading. Either
   add the control/baseline series to the same axes, or cut the figure. (We
   removed two such plots from a near-final post for exactly this reason.)
5. **If the controls deflate the headline, reframe and reship; do not bury.** A
   deflated result is still a real, publishable result, and often a better one:
   "we ran the controls a prior claim skipped, and here is what survives."
   Retitle to match the controlled result (ours became "…Once You Run the
   Controls"), rewrite the lead and abstract to lead with the control-audit
   story, and demote the deflated claim in the body. Quietly dropping the post
   (or softening one sentence while keeping the exciting title) leaves the
   headline inconsistent with the evidence.
6. **A retraction that isn't inside the figure doesn't retract the figure
   (added 2026-07-14).** Figures get screenshotted, hotlinked, and reposted
   without their captions, panels, or surrounding prose: a reader can pull a
   graph and make a claim the data doesn't support, with your name on the
   plate. When data shown in a figure is later retracted or invalidated:
   - **Bake the retraction into the image file itself**: a high-contrast
     banner (ours: a red band across the top) that names *which* series are
     invalid, *why* (one clause), what the only fair comparison is, and where
     the corrected result lives. For an SVG this is a few lines injected
     before `</svg>`; re-validate the XML after.
   - **Mark the same data at every other pull-able surface**: table rows get
     inline strikethrough + a "RETRACTED (reason)" label (not just a warning
     panel nearby); alt text leads with the retraction (the alt is what
     screen readers and link previews quote); appendix/receipt samples note
     the retracted fields are kept only for auditability.
   - The test: **any single artifact (figure, table row, alt string,
     receipt excerpt) extracted alone must carry its own retraction.** A
     caveat that lives one scroll away has not marked the data.
   - Do not silently delete the figure instead: the disclosed-flaw narrative
     ("here is what we got wrong and how we caught it") is part of the
     record, and deletion invites "what did they remove?": banner it,
     don't bury it.
   - **Never close on a retracted graph: pair it, in place, with its
     corrected replacement.** A bannered figure standing alone still leaves
     the reader (and the screenshotter) with only the bad data as imagery.
     Immediately adjacent to every retracted figure, embed the legitimate
     follow-up figure from the corrected re-run, with a one-line bridge
     ("the retracted chart does not travel alone: here is its corrected
     replacement"). If part of the retracted content has no corrected
     version (a withdrawn claim), say so explicitly at the pairing: a
     withdrawn claim is not re-plotted; it is named as withdrawn.

The house value "evidence over green checks" (§8) is not just about the ledger.
It governs the prose and the figures too: the reader is entitled to see the
contrast you saw.

---

## 9.1 Reviewer-Proofing the Summary Surfaces (added 2026-07-12)

A recurring expert-review failure mode: the review finds no factual errors in
the results, yet still lands a cluster of presentational overclaims that all
share one root cause: **the body carried the required qualifications and the
summary surfaces did not.** Each item below is fixable in minutes; the point is
to catch them before a reviewer does.

1. **Claim parity: summary surfaces inherit the body's hedges.** The five
   surfaces a reader (or quoter) actually sees (title, `lead`, `key_result`
   box, abstract, and the closing answer section) must carry the same labels
   and conditionality as the body: *post hoc* stays attached to post hoc
   numbers, "in this sample" stays attached to sample-bound perfections, and
   any "X decides the outcome" claim keeps its "under this fixed
   instrument/readout" scope. If the body says it and the box drops it, the
   box is the overclaim. Superlatives may only describe the number they sit
   next to, not a stronger number elsewhere in the post.
2. **Never promise a metric you do not show.** Every metric named in the
   methods ("we report A, B, calibration...") must appear in results with a
   number, or with an explicit pointer to the receipt file that holds it. A
   promised-but-invisible metric reads as a credibility gap even when the
   data exists in the release.
3. **Label schematic math.** If a displayed definition simplifies the primary
   source (dropping an averaging dimension, a normalization step, an index),
   say so in place and cite the full version. A reviewer with the source open
   will find the difference; find it for them first.
4. **Artifact and license precision.** "Open" means open. Gated weights under
   a community or research license are "publicly released"; say which at
   first mention. Same discipline for curated releases (a vendor artifact
   with items removed or filtered before publication): note the curation
   once, early.
5. **Disclose selection circularity.** If the items under test were selected
   by a criterion aligned with the evaluation score (items chosen for a
   label, then scored with an instrument aligned to that same label), state
   that alignment explicitly, say what bounds it (matched controls, per-item
   failures), and name the missing control (semantically adjacent hard
   negatives) as future work. Bonus: check whether the circularity cuts
   *against* any null you report, a tailor-made score failing anyway is a
   stronger null, and you may say so.
6. **State what a null distinguishes.** A negative result under one
   instrument separates "task impossible" from "this instrument insufficient"
   only if a stronger comparator was run. If none was, say plainly which
   hypotheses remain open rather than letting the null read broader than it
   is.
7. **Describe your instrument at its true dimensionality.** Do not flatten a
   multivariate reader (a classifier over many inputs) into "a score," and do
   not let two analyses that use *different* readers derived from one
   instrument (say, a full multivariate detector in one regime and a
   one-number contrast in another) share the phrase "the same score" on any
   summary surface. Say which reader each result belongs to; "the same
   readout" with the reader specified per regime is accurate, while "the same
   score" is not. This is the writeup twin of the design rule that comparators
   must be capacity-matched: a reviewer who catches the mislabel will re-audit
   everything else.
8. **Headline only fair contrasts; demote mismatched arms.** A multi-arm
   preference ranking (A > B > C > D) is a strong claim. It is only as fair
   as the *weakest* step. Before any summary surface prints a ladder, check
   two writeup-visible fairness conditions (the design twin lives in
   `EXPERIMENT_INTEGRITY_SKILLS.md`):
   - **Measurement match:** the scored probe / lexicon / metric is
     semantically appropriate for *every* arm in the ladder, not only for
     the favored arm. Echo-free (words absent from prompts) is not enough if
     the word list still belongs to one arm's domain.
   - **Severity / stake match:** the interventions being ranked are the same
     *class* of threat or stake (e.g. existential vs existential), not
     existential on one side and inconvenience on the other.
   If either fails, the summary surfaces name the **primary matched
   contrast** only. Secondary arms may appear in the body as suggestive or
   as known-weak controls, with the mismatch stated in one plain sentence.
   Do not let the exciting ladder survive in the lead / key-result / abstract
   after the body has demoted it. A second model that is flat across the same
   unfair arms does not rehabilitate the ladder; it only complicates the
   artifact story.

Add these to the §1.7 adversarial read: the hostile reader should attack the
five summary surfaces *first*, then the body, and should explicitly ask "were
the winners picked by the same ruler that scored them?" and "is every step of
this preference ladder measurement-matched and severity-matched?"

---

## 9.2 Publication Day for Embargoed Studies (added 2026-07-12)

House default for experiments (see `EXPERIMENT_INTEGRITY_SKILLS.md`): the
protocol is frozen in a **private** git repo with an **embargoed** OSF
registration, and both open on the day the Research Note publishes. The post is
the trigger. If the study the post reports was embargoed, publishing the
post *is* the release event, and these steps happen together, in this order:

1. **Verify before opening.** Confirm the freeze commit SHA and
   plan-manifest SHA-256 quoted in the post match the values embedded in the
   embargoed registration text. If they do not match, stop; publishing would
   ship an unverifiable provenance claim.
2. **End the OSF embargo.** Follow
   [OSF: end an embargo early](https://help.osf.io/article/151-end-an-embargo-early)
   (registration page → End Embargo; also possible via the OSF API v2 with
   the shared `OSF_TOKEN`). Ending the embargo makes the registration and
   its original pre-outcome timestamp publicly visible; it does not change
   the timestamp.
3. **Make the study repo public** in the same sitting, so there is no window
   where the post links a 404.
4. **Check every link the post makes** to the registration and repo
   (registration URL, freeze commit URL, receipts), they were unreachable
   by outsiders until now, so they have never been link-checked in a public
   state.
5. **Update the post's status language.** While embargoed, the study was an
   *outcome-masked frozen protocol*; once the registration is visible, the
   post may say *preregistered* and must link the registration ID next to
   the freeze SHA. Do not use "preregistered" in any draft surface before
   the embargo has actually ended.

If publication is staged (draft shared privately before public release), the
embargo ends at the *public* release, not at the private preview.

---

## 9.3 Article-Level Corrections and Retractions (added 2026-07-15)

§9 rule 6 governs the *artifacts* (figures, table rows, alt text) because
those travel alone. This section governs the *page*, so the article is never
less clearly corrected than its own figures. The standard follows ICMJE
correction practice: corrections are formally issued, retractions are
prominently labeled, and original and correction link to each other in both
directions (both ICMJE pages linked in §11.1).

When any published claim, number, or figure in a note is corrected or
retracted after publication:

1. **A dated correction block at the top of the post**, before the lead,
   stating in plain language: *what changed*, *why* (one clause on the
   cause: convention mismatch, missing control, code bug), and *where the
   corrected result lives* (in-post anchor or successor post). One block
   accumulates dated entries; do not scatter corrections through the body.
2. **Retraction reaches every summary surface.** If the headline claim is
   withdrawn, the title, `summary` front matter, `lead`, and `key_result`
   box must say so; a corrected body under an uncorrected title is the
   overclaim pattern of §9.1 in reverse. For partial corrections, the
   affected surfaces carry the corrected number, not the original.
3. **Bidirectional links.** The corrected/retracted post links the successor
   or corrigendum; the successor links back to the original and names what
   it supersedes. A reader landing on either page can reach the other in
   one click.
4. **The original stays up, marked.** Do not silently delete or silently
   rewrite. Prose may be corrected in place when the correction block
   discloses the change; wholesale rewrites that erase what was originally
   claimed are not corrections, they are cover-ups. The git history of the
   post is part of the record; mention the correcting commit in the block
   when it helps an auditor.
5. **Downstream surfaces update in the same sitting:** RSS/summary text,
   `og_image` if it carries the retracted number, site index blurbs, and
   any sibling post that cited the retracted value (add a dated note at the
   citing sentence).
6. **The provenance manifest is corrected, not abandoned.** Retracted
   entries stay in `provenance.json` flagged as retracted with a pointer to
   the corrected entry, so the verification script keeps passing on the
   corrected post and a manifest reader sees the same story as a prose
   reader.

The test mirrors §9 rule 6: a reader who arrives at the *page* by any route
(search, link, RSS, index) must encounter the correction before or with the
original claim, never after.

---

## 10. Agent Checklist Before Handing Draft to the Human

- [ ] Lead is plain-language; specialist abstract follows (AI disclosure →
      abstract → thin study-status pointer)
- [ ] Abstract / long panels broken into paragraphs (§2.1); no walls of text
- [ ] Technical terms link to `/blog/knowledge-base/glossary/` pages (or a prior primer
      note); new terms get a short glossary page unless the author asked for
      a standalone teaching post (§2.2)
- [ ] Glossary inventory completed for edited prose: every technical term
      either links an existing page or has a proposed/created glossary page
      with slug, title, and scope; no nonexistent `refterm` slugs (§2.2)
- [ ] Aufbau decision explicit: teach fully, or cite prior posts / site
      glossary pages and go deep
- [ ] Study-report notes: early **Prior work / contribution / Not claimed**
      block (§3.2); no vague novelty without a search
- [ ] Study-report notes: full release inventory / sample records live in an
      appendix (§3.1), not in the opening flow; plain English then technical
- [ ] Study-report notes: `## Discussion` section present (§3.3) with the
      epistemic-downgrade opener, self-contained framing, no new evidentiary
      numbers, hypotheses labeled and pointed at future prespecified tests
- [ ] Mathematical-register pass complete: every example, counterexample,
      computation, figure, Lean check, theorem, and proof is credited with its
      exact logical role; no dismissive shortcut substitutes for a reason (§8)
- [ ] No chat residue in the post (do not address the author/editor mid-draft)
- [ ] `og_image` and `og_image_alt` are present; the page-bundle PNG/JPEG is
      exactly 1200×630 and resolves in both the menu and generated social tags
- [ ] Featured-image claim parity checked: no missing control, cropped-out
      qualifier, retracted result, or unsupported number; full-size and
      thumbnail renders inspected on desktop and narrow layouts (§3.4)
- [ ] Figures present (SVG/mermaid + empirical plots) with `figure-note`s
- [ ] Visual-learner pass complete: every meaningful dose, layer, time,
      condition, or control relationship that prose would obscure has an
      appropriate figure; no decorative figure exists without a teaching job
- [ ] SVGs are valid UTF-8 XML and render at their raw Hugo URL
- [ ] Empirical figures use real chart grammar: shared labeled axis, scale
      direction, units/statistic, series labels, and exact headline values
- [ ] No dashboard/card layout substitutes for a chart; no unexplained
      activity transform or arbitrary pixel-length encoding (§4.1)
- [ ] ViewBox bounds audited: no bar, line, circle, annotation, or text label
      clips or overflows; raw SVG, in-post desktop, and narrow render inspected
- [ ] Figure style is consistent across the note; after fixing one figure,
      all sibling figures were audited for the same generator/layout failure
- [ ] Accessibility (§4.2): every data-carrying figure has a full text
      equivalent (data table, structured figure-note, or long description),
      alt text states the finding, link text and headings describe purpose,
      no meaning carried by color alone, interactive elements keyboard-usable
- [ ] Empiric PNGs copied into the post bundle; hashes match release if claimed
- [ ] Math uses `\(...\)` / `\[…\]`
- [ ] No em dashes on any surface except inside direct quotations; `rg '—'`
      and fix survivors (§2)
- [ ] Notation gotchas and mid-derivation clarifications use `info` panels
      where they help (not every aside)
- [ ] References web-verified; authors/years/URLs correct; body cites them
- [ ] Every consequential arXiv citation has a recorded version, version date,
      access date, and publication-status check; a final peer-reviewed version
      is cited when available, and preprint-only claims are labeled and worded
      as provisional (§6)
- [ ] Literature covers method, limits, and relevant dissenters
- [ ] Freeze vs release commits not conflated
- [ ] Compact reproducibility ledger kept distinct from the deep appendix
- [ ] Every headline number appears beside its controls/baseline in prose or figure (§9)
- [ ] No method-only figure; every max-statistic is named with its null (§9)
- [ ] Retracted/invalidated data is marked INSIDE every pull-able artifact:
      in-image banner, struck table rows, retraction-first alt text (§9.6)
- [ ] Every retracted figure is PAIRED in place with its corrected
      replacement figure; withdrawn claims are named as withdrawn (§9.6)
- [ ] Bars follow a visible axis convention; rank charts default to raw ranks
      on a log axis labeled "lower is better," with exact values printed (§4.1)
- [ ] Every data-bearing figure is script-GENERATED from receipts, passes
      its `--verify` byte-identity check, and has a provenance JSON in the
      post bundle (§5 data-integrity)
- [ ] No empirical SVG geometry was hand-authored or edited by eye; Python,
      Matplotlib, or equivalent code read the audited machine-readable source
      and emitted SVG/PDF plus a 300-DPI PNG fallback (§5 data-integrity)
- [ ] Every empirical figure has its own `<stem>.receipt.json` with description,
      highly descriptive alt text, exact data fields/selection/transformation,
      source and generator hashes, derived plot data, output hashes, uncertainty
      semantics, scope exclusions, and accessibility checks; the post-wide
      receipt index verifies all of them (§5 data-integrity)
- [ ] Every figure and data table carries a provenance figure-note linking
      receipt + generator + verification at commit-pinned URLs (§4)
- [ ] **Every evidentiary number (inline prose stat included, not just figures
      and tables) is listed in the post's `provenance.json` with its receipt
      path + SHA-256 + computation, and re-derives from the committed receipts;
      incidental context numbers are traceable to an openable source even if
      not manifest-listed (§5 machine-verified + scope-the-ceremony)**
- [ ] **A verification script re-computes every manifest number and asserts
      every commit-pinned URL resolves (`git cat-file -e`); it is wired into
      note CI so a hallucinated number or a dead/typo'd link fails the build,
      not the reader (§5 machine-verified)**
- [ ] **No number was pasted from memory, an old draft, or chat scrollback:
      every stat in the prose was pulled from a receipt through the manifest (§5)**
- [ ] Novelty checked: no "new/first" without a prior-work search; overlaps cited
- [ ] Each reference confirmed to be the primary source, not a citer or commentary
- [ ] Claim parity: title / lead / key-result / abstract / answer carry the
      body's post-hoc labels, "in this sample" bounds, and readout scoping (§9.1)
- [ ] Any surprise claim states expectation, observation, and warranted update;
      names the expectation's audience or benchmark, source, and timing; avoids
      audience-shopping and reverse-HARKing; and scales rhetoric to evidence
      breadth (§8.1)
- [ ] Every metric promised in methods is shown in results or linked to its
      receipt file (§9.1)
- [ ] Simplified formulas labeled schematic with a pointer to the full form (§9.1)
- [ ] Artifact language precise: "publicly released"/gated vs open; curation
      noted once, early (§9.1); every release-inventory row carries an
      explicit license + access-conditions field (§3.1)
- [ ] Selection circularity disclosed where the test score aligns with the
      selection criterion; missing hard negatives named as future work (§9.1)
- [ ] Each null states which hypotheses it does and does not distinguish (§9.1)
- [ ] Instrument described at its true dimensionality; no "same score" across
      analyses that use different readers (§9.1)
- [ ] Multi-arm preference ladders on summary surfaces are measurement-matched
      and severity-matched; otherwise only the primary fair contrast is headlined (§9.1)
- [ ] If the study was embargoed: publication-day steps done in order (verify
      hashes → end embargo → repo public → link-check → status language says
      "preregistered" only after the embargo is actually lifted) (§9.2)
- [ ] No privileged material (embargoed studies, unpublished drafts, private
      repos, reviewer comments) was sent to external tools or quoted in public
      artifacts before release (§1.6)
- [ ] If this pass corrects a published post: dated correction block at top,
      corrected summary surfaces, bidirectional links, manifest entries
      flagged not deleted, downstream surfaces updated (§9.3)
- [ ] Adversarial read done; surviving objections fixed, not softened
- [ ] Scientific-integrity Pro review ran with
      `--review-kind research-note-scientific` on the assembled note plus only
      compact evidence; it audited accuracy, claim scope, figures, missing
      references, and unnecessary references, and every material suggestion is
      adjudicated (§1.8)
- [ ] Zero-context expert-reader Pro review then ran with
      `--review-kind research-note-reader` on the scientifically corrected
      draft; its ramp, cohesion, scope, pacing, and figure-integration grades
      are preserved and every material suggestion is adjudicated (§1.8)
- [ ] If controls deflated the headline, the post was reframed to match them,
      not buried
- [ ] AI disclosure is the §1.2 canonical panel (verbatim study default, or
      teaching twin only when the default would be false); no warranty
      boilerplate, no paraphrased verbs, no false "has inspected" /
      "authorized the compute" (§1.2)
- [ ] Draft marked for human sculpting; do not treat agent text as final

---

## 11. Related Internal Docs

- Experiment freeze / audit / release playbook:
  [`EXPERIMENT_INTEGRITY_SKILLS.md`](./EXPERIMENT_INTEGRITY_SKILLS.md)
- Rented-GPU estimate / validate / terminate playbook:
  [`GPU_COMPUTE_SKILLS.md`](./GPU_COMPUTE_SKILLS.md)
- Hugo local serve: `make blog-serve` in the `praxagent` repo
- Public experiment repo example:
  [`tdj28/llm_selfref_pre`](https://github.com/tdj28/llm_selfref_pre)

### 11.1 External standards this guide draws on (web-verified 2026-07-15)

This guide holds notes to §6's rule that references are part of the claim, so
the standards it invokes get the same treatment. Each link below was opened
and confirmed to say what we cite it for.

- **NeurIPS Paper Checklist** — claims match evidence; contributions,
  assumptions, and limitations stated; justified "no" is acceptable for
  code/data release (§3.2, §3.1 licensing).
  <https://neurips.cc/public/guides/PaperChecklist>
- **ICMJE, Defining the Role of Authors and Contributors** — AI-assisted
  technology must be disclosed; chatbots cannot be authors because they
  cannot take responsibility; humans own accuracy, integrity, originality,
  and citations (§1). Section II.A.4 is the AI passage.
  <https://www.icmje.org/recommendations/browse/roles-and-responsibilities/defining-the-role-of-authors-and-contributors.html>
- **ICMJE, Responsibilities in the Submission and Peer-Review Process** —
  manuscripts are privileged communications; confidentiality may prohibit
  uploading material to AI tools where confidentiality cannot be assured
  (§1 rule 6).
  <https://www.icmje.org/recommendations/browse/roles-and-responsibilities/responsibilities-in-the-submission-and-peer-peview-process.html>
- **ICMJE, Corrections and Version Control** — correction notices cite the
  original, new versions detail and date changes, prior versions are
  archived and prominently note newer versions exist (§9.3 items 1, 4).
  <https://www.icmje.org/recommendations/browse/publishing-and-editorial-issues/corrections-and-version-control.html>
- **ICMJE, Scientific Misconduct, Expressions of Concern, and Retraction** —
  retractions prominently labeled, original and retraction linked in both
  directions, retracted article labeled as retracted in all its forms and
  kept in the public domain (§9.3 items 2–4).
  <https://www.icmje.org/recommendations/browse/publishing-and-editorial-issues/scientific-misconduct-expressions-of-concern-and-retraction.html>
- **Evans, Petroff, and King 2026, "Advancing science by designing for
  surprise," *Science* 393, eaej4257** — proposes making audience-relative
  expectation, observation, and update explicit while distinguishing
  evidence-supported abduction from HARKing and post-outcome audience-shopping
  (§8.1). This is an
  Expert Voices editorial used as a suggestive reporting heuristic, not an
  empirical standard or technical authority.
  <https://doi.org/10.1126/science.aej4257>
- **Shi and Evans 2023, "Surprising combinations of research contents and
  contexts are related to impact and emerge with scientific outsiders from
  distant disciplines," *Nature Communications* 14, 1641** — reports an
  observational association between measured unexpected combinations and
  citation impact. It does not show that surprise causes truth, validity, or
  impact (§8.1).
  <https://www.nature.com/articles/s41467-023-36741-4>
- **W3C, WCAG 2.2** — the working accessibility target for §4.2 (text
  alternatives, headings and labels, focus visibility, contrast, link
  purpose). <https://www.w3.org/TR/WCAG22/>
- **W3C WAI, Complex Images tutorial** — complex images (charts, graphs,
  diagrams) need long descriptions or full text equivalents beyond alt
  text, ideally available to everyone in the main content (§4.2 item 1).
  <https://www.w3.org/WAI/tutorials/images/complex/>
- **Wilkinson et al. 2016, "The FAIR Guiding Principles for scientific data
  management and stewardship," *Scientific Data* 3, 160018** — clear usage
  licenses, detailed provenance, and rich metadata as release requirements
  (§3.1 licensing field, §5 provenance).
  <https://www.nature.com/articles/sdata201618>
- **EQUATOR Network** — the precedent that reporting guidance is organized
  as a library of study-type-specific guidelines rather than one monolith;
  the model behind §0's tiering.
  <https://www.equator-network.org/>

These are cited as *norms we adopt in note form*, per §3.2: do not paste any
of these checklists or standards wholesale into a post.

---

*End of guide. If a future post invents a durable new pattern (interactive
explorers, receipt shortcodes, etc.), append a dated section here rather than
forking a second style document. Study-report appendix pattern and NeurIPS-style
prior-work / contribution / non-claims block crystallized 2026-07-11 from the
SAE × Jacobian-lens confirmatory writeup. §9.1 item 8 (headline only fair
contrasts; demote mismatched arms) added 2026-07-13. §2.1 paragraph breaks,
§2.2 site `/blog/knowledge-base/glossary/` pages, and absolute em-dash ban
updated 2026-07-15 from the Under Pressure / References work. §4.1 empirical
figure grammar, render-bound checks, sibling-figure audits, and revised raw-rank
chart guidance added 2026-07-15 after the same note exposed clipped and
infographic-like SVGs. §0 levels of obligation, §1.6 confidentiality boundary,
§4.2 accessibility standard, §5 provenance ceremony scoping, §3.1 licensing as
a required release field, and §9.3 article-level correction protocol added
2026-07-15 in response to an external critique (severity tiering, WCAG-level
accessibility, ICMJE-style correction governance and reviewer-side
confidentiality, FAIR licensing fields, and scoped rather than maximal
provenance ceremony were adopted; the proposed four-document modular split and
the demotion of the em-dash ban to advisory were considered and declined: the
ban stays enforced but is now labeled a house convention, and the guide stays
one file with §0 supplying the severity structure a split would have
provided). §11.1 web-verified external-standards references added the same
day so the guide meets its own §6 citation bar. §1.2 canonical AI-use
disclosure panel (study default + teaching-only twin) standardized 2026-07-18
from the signed-dose intervention note, replacing earlier warranty-boilerplate
variants.*
