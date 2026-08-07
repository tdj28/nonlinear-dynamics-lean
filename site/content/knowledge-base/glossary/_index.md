---
title: "Glossary"
summary: "A precise, searchable trail map for recurring terms in dynamics, analysis, probability, physics, and Lean."
layout: "glossary"
weight: 20
card_index: "02"
card_label: "Definitions"
card_action: "Browse the glossary"
---

Each entry gives you enough plain language to keep moving and enough precision
to use the term correctly. Follow the cross-links when a definition depends on
another idea, or continue into a Deep Dive when the concept deserves a full
derivation.

## Begin with one complete probability story

Suppose we roll a fair six-sided die and pay \(X=-1\) on an odd roll and
\(X=2\) on an even roll. One tiny experiment already contains most of the
vocabulary that later supports random matrices and ergodic theory:

- the six faces form the **sample space**;
- a collection of allowed questions forms the
  {{< refterm "measurable-space" "measurable space" >}};
- “the roll is even” is an {{< refterm "event" "event" >}};
- counting favorable faces gives a {{< refterm "probability-measure" "probability measure" >}};
- the payoff rule is a {{< refterm "random-variable" "random variable" >}};
- its two output masses form its {{< refterm "probability-law" "probability distribution" >}};
- its probability-weighted average is its {{< refterm "expectation" "expectation" >}}.

The diagram is a reading route, not merely a dependency chart. Each box names
the concrete question answered by the corresponding chapter.

{{< reference-figure
  wide="true"
  src="foundations-route.svg"
  alt="A three-level learning route begins with measurable spaces, events, measures, and probability measures; continues through measurable functions, random variables, pushforward measures, and probability laws; then reaches expectation, integrability, null sets, and almost-everywhere claims."
  caption="**Probability foundations route.** Read left to right within each band and follow the arrows downward. The first band decides which subsets can be discussed and how much mass they carry. The second sends outcomes to values and transports mass. The third summarizes size and explains which exceptional failures can be ignored."
>}}

For a first pass, take this route:

1. {{< refterm "measurable-space" "Measurable space" >}} →
   {{< refterm "event" "Event" >}} → {{< refterm "measure" "Measure" >}} →
   {{< refterm "probability-measure" "Probability measure" >}}.
2. {{< refterm "measurable-function" "Measurable function" >}} →
   {{< refterm "random-variable" "Random variable" >}} →
   {{< refterm "pushforward-measure" "Pushforward measure" >}} →
   {{< refterm "probability-law" "Probability distribution" >}}.
3. {{< refterm "expectation" "Expectation" >}} →
   {{< refterm "integrability" "Integrability" >}} →
   {{< refterm "null-set" "Null set" >}} →
   {{< refterm "almost-everywhere" "Almost everywhere" >}}.

## How every rebuilt chapter teaches

The revised entries deliberately repeat a dependable ascent:

1. a small, exact example you can calculate by hand;
2. a diagram that exposes the objects and arrows in that calculation;
3. the general mathematical definition and the nearest tempting mistake;
4. a bridge from an ordinary human sentence, to paper notation, to Lean syntax;
5. a tiny standalone Lean worksheet that is safe to run locally;
6. the exact repository import and `#check` commands for the full formalization,
   labeled as full project checks when they require the pinned Lean and Mathlib dependencies.

You do not need to understand every Lean token on the first read. Type the tiny
worksheet, change one value, observe what fails, and return to the syntax map.
Full project checks need the repository's pinned Lean and Mathlib dependencies
and may require substantial disk space and memory. Learning Lean does not: the
standalone tutorials run on ordinary macOS or Linux computers.

## Where to go after probability

The main routes then branch:

- **Random matrices:** {{< refterm "random-matrix" "random matrix" >}} →
  {{< refterm "hermitian-matrix" "Hermitian matrix" >}} →
  {{< refterm "matrix-trace" "matrix trace" >}} →
  {{< refterm "trace-power" "trace power" >}} → empirical spectra.
- **Dynamics along an orbit:** orbit and iterate → measure-preserving
  transformation → {{< refterm "ergodicity" "ergodicity" >}} →
  {{< refterm "birkhoff-sum" "Birkhoff sum" >}} → convergence events.
- **Deterministic stability:** orbit and iterate →
  {{< refterm "forward-stability" "forward stability" >}} →
  {{< refterm "basin-of-attraction" "basin of attraction" >}} →
  {{< refterm "lyapunov-function" "Lyapunov function" >}} →
  {{< refterm "semiconjugacy-and-conjugacy" "semiconjugacy and conjugacy" >}}.
- **Random products:** finite matrix products → cocycles → log-norm
  integrability → subadditive growth rates.

Those routes are being rebuilt in public. Every page marked **Open working
note** is usable teaching material, but its visible review status still matters:
publication is not a substitute for human mathematical review.
