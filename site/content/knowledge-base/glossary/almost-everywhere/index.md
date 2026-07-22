---
title: "Almost everywhere"
slug: "almost-everywhere"
summary: "A property holds almost everywhere when its failures are confined to a set of measure zero."
draft: true
pro_reviewed: false
toc: false
---

A statement holds **almost everywhere** with respect to a measure \(\mu\)
when the outcomes where it fails form a set of \(\mu\)-measure zero.
Analysts abbreviate this as **a.e.**

For a property \(P(\omega)\), the statement

\[
P(\omega) \text{ for }\mu\text{-almost every }\omega
\]

allows exceptional outcomes, but only inside a null set. In probability, where
\(\mu=\mathbb P\), the same idea is often called **almost sure** and
abbreviated **a.s.**

## Pointwise versus almost everywhere

| Claim | Meaning | Strength |
|---|---|---|
| \(\forall\omega,\ P(\omega)\) | No exceptions | Pointwise |
| \(P(\omega)\) for \(\mu\)-a.e. \(\omega\) | Exceptions may lie in a null set | Almost everywhere |

Every pointwise theorem immediately gives an almost-everywhere theorem. The
reverse implication generally fails because a null set can still contain
points.

For continuous probability distributions, a single outcome usually has
probability zero. That does not make the outcome impossible in a logical
sense. It means the probability measure assigns no mass to that singleton.

## In Lean

Lean writes an almost-everywhere quantifier using filter notation:

```lean
∀ᵐ ω ∂μ, P ω
```

The project's predicate for an almost-surely Hermitian random matrix is:

```lean
def IsHermitianAE (X : RandomMatrix Ω ι ι ℂ) (μ : Measure Ω) : Prop :=
  ∀ᵐ ω ∂μ, (X ω).IsHermitian
```

Because Hermitian symmetrization is proved pointwise, Lean can lift it with
`Filter.Eventually.of_forall` without any additional probabilistic argument.

{{< panel "warning" >}}
**Do not erase the measure.** A property can hold almost everywhere for one
measure and fail for another. The symbol \(\mu\) is part of the claim.
{{< /panel >}}

Related concepts: {{< refterm "measurable-space" "measurable space" >}},
{{< refterm "random-matrix" "random matrix" >}}, and
{{< refterm "hermitian-matrix" "Hermitian matrix" >}}. The
{{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}}
entry uses almost-everywhere equality twice: first to transport an observable
to a measurable representative, and then to compare the resulting convergence
events.

The
{{< refterm "finite-maximal-ergodic-inequality" "finite maximal ergodic inequality" >}}
entry uses the same distinction more locally: integrability supplies an
almost-everywhere measurable finite maximum, so its strict event is null
measurable even when the original representative of the observable is not
ordinarily measurable.

Further reading: Mathlib's
[measure-space foundations](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/MeasureSpaceDef.html)
define the almost-everywhere filter and associated notation.
