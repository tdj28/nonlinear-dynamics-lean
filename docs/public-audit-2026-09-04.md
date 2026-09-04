# Public repository audit, 4 September 2026

Reviewed baseline: [`e90ab23`](https://github.com/tdj28/nonlinear-dynamics-lean/commit/e90ab234d76772666648b50ebc2f64b12f1eb693).
This is an AI-assisted maintenance review. It is not external specialist
review and does not change any `pro_reviewed` flag.

## Findings and corrections

| Finding | Correction |
| --- | --- |
| The shared article template called every linked Lean file "checked source", including the unvalidated GUE candidate. The candidate also called its own interface checked. | Use a neutral source-snapshot label and describe GUE as proposed until compilation succeeds. |
| Several validated deterministic-model and sensitivity lessons still said compilation was pending. | Match their recorded source hashes to the successful validation records and correct the status prose. Keep expert review pending. |
| Draft lessons described themselves as private despite their source being committed to a public repository. | Remove the privacy claim and explain that `draft: true` controls website inclusion only. Publication flags are unchanged. |
| The README described the completed signed Kingman milestone as unfinished, omitted later results, and did not identify the unvalidated addition on `main`. | Replace the obsolete module narrative with a current scope table and identify the last validated commit separately from the current candidate. |
| The deployment ran the coverage checker's regression tests without running the checker against the repository. Its path filter also omitted checkpoint and validation-script changes. | Run the complete non-Lean gate on every push to `main`, and add a read-only pull-request validation workflow. |
| A warning-free Hugo build missed broken internal fragments and a mathematical expression parsed as a Markdown link. | Repair the affected sources and add a rendered HTML link/asset/fragment check with regression cases. |
| Notebook page weights made the newest chapter's Next link jump back to the oldest chapter. | Follow the chronological notebook index for Previous and Next links. |
| The CI installer extracted the downloaded Hugo binary without verifying its digest. | Share a pinned installer between workflows and verify the official release asset SHA-256 before extraction. |
| Current checkpoint summaries still reported older module and publication counts. | Reconcile the current-state sections with the source inventory and label older summaries as historical. |

The current inventory is 62 substantive Lean modules with 62 Notebook
companions, 59 Deep Dives, and 90 glossary chapters. Of the 211 teaching
bundles, 161 are included in production and 50 are drafts. The last recorded
complete project Lean validation is
[`de78075`](https://github.com/tdj28/nonlinear-dynamics-lean/commit/de78075fb10602d6c5f324a0be59f6281ad96952)
from 23 August 2026. It covers 61 substantive modules. The seven-declaration
GUE-law interface added afterward remains a candidate; the audit changes no
Lean source and provides no new compilation evidence.

## Mathematical review and limits

Representative source review covered the quantum foundation and raw-spacing
interfaces, finite GUE construction, signed Kingman and growth-rate stability,
Devaney/Banks and symbolic coding, bifurcation, ODE global-existence and
stability interfaces, Lyapunov results, and the logistic ODE.

No definite theorem-statement, sign, normalization, or boundary-case defect
was found in that sample. The reviewed choices correctly distinguish raw gap
mass normalization from unfolding, retain repeated eigenvalues, handle empty
dimensions, separate a law on measures from one sample measure, and keep the
necessary attraction and integrability hypotheses visible. This is a bounded
source audit, not an exhaustive mathematical verification or a new Lean run.

The stochastic-stability result is upper semicontinuity of an integrated
growth rate under its stated convergence and norm bounds. It is not a proof
of full continuity, stationary-measure stability, or random-attractor
stability. This choice remains mathematically coherent.

A targeted bibliography check found no metadata mismatch among six
stochastic-stability anchors and three spacing references. The primary
records include [Kingman](https://academic.oup.com/jrsssb/article/30/3/499/7026968),
[Bochi](https://www.mat.uc.cl/~jairo.bochi/docs/gzle.pdf),
[Backes, Brown, and Butler](https://www.aimsciences.org/article/doi/10.3934/jmd.2018009),
[Viana and Yang](https://link.springer.com/article/10.1007/s11856-018-1809-7),
[Alves, Araújo, and Vásquez](https://arxiv.org/abs/math/0404160),
[Robinson](https://wrap.warwick.ac.uk/id/eprint/10202/),
[Schubert and Venker](https://arxiv.org/abs/1505.07664),
[Kriecherbauer and Schubert](https://link.springer.com/chapter/10.1007/978-3-642-38806-4_3),
and [Guhr, Müller-Groeling, and Weidenmüller](https://arxiv.org/abs/cond-mat/9707301).
This does not certify every citation or every claim in those papers.

A targeted credential-pattern scan examined 2,716 reachable Git blobs
(124,425,267 bytes) and the tracked baseline tree. It found no recognizable
API tokens or private keys, and no personal absolute home paths in the
tracked baseline. Pattern matching cannot establish the absence of all
sensitive information. No history rewrite or credential rotation was
performed.

## Validation of this cleanup

`make workstation-check` passes with Hugo Extended with Deploy 0.160.1:
62/62 module-to-notebook coverage, 23 coverage tests, seven source-hygiene
tests, 12 rendered-site tests, and warning-fatal production and draft builds.
The rendered checker inspects 326 production HTML pages with 14,635 local
references and 423 draft-inclusive HTML pages with 17,157 local references;
both graphs have zero errors. Its scope is local targets, HTML fragments,
referenced assets, and selected TeX-escaping regressions, not external websites
or every browser behavior.

Representative GUE, Lorenz, and Birkhoff pages also pass desktop/mobile
browser checks for page width, status labels, and mathematics. All seven
Birkhoff paper-to-Lean formulas render as KaTeX with no generated links or
raw delimiters. The new template tests cover both native and legacy-escaped
TeX, including aligned formulas with row breaks. Workflow Actionlint and
`git diff --check` pass. No Lean source, review flag, or publication flag
changed, and no new project Lean compilation was attempted.

## Recommended sequence

1. **Close GUE validation.** Run its warning-fatal leaf, the aggregator, and
   the full gate with the pinned dependencies; repair any demonstrated
   proof failures and preserve the exact commit, source hashes, logs, and
   axiom reports. Keep the candidate status until that succeeds.
2. **Make validation easy to inspect.** Publish a small machine-readable
   manifest linking each validated source hash to a commit and validation
   receipt. Give readers a tagged, reproducible baseline. Select a project
   license before making reuse promises; no license is currently present.
3. **Add a useful finite result.** Prove that mean raw spacing equals spectral
   span divided by the number of gap slots, with dimension at least two.
   Follow it with integrability and the mean empirical GUE spacing measure,
   explicitly relating the law on measures to its barycenter.
4. **Consolidate the strongest work.** Prepare a compact review packet for
   reusable Birkhoff/Kingman lemmas: intended statement, assumptions,
   counterexamples, source references, Lean declarations, and checked
   artifacts. Seek targeted independent feedback before expanding to
   universality or quantum-chaos claims.

The priority is a reproducible mathematical result whose assumptions and
evidence are easy to inspect. Additional wrapper definitions and teaching
volume alone will not resolve the current validation and review gaps.
