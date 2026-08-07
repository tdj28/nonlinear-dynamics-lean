---
title: "Cylinder set"
slug: "cylinder-set"
summary: "A cylinder set fixes finitely many coordinates of a symbolic configuration and leaves every other coordinate free."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Chaos.SymbolicCoding"
tags: ["Symbolic dynamics", "Cylinder sets", "Product topology", "Full shift"]
og_image: "cylinder-set-card.png"
og_image_alt: "Several sequence rows share the same blue two-symbol prefix and have different orange tails."
---

{{< panel "warning" >}}
**Editorial and validation status.** The warning-fatal source-module check
passes. Professional review and the complete project gate remain pending, so
<code>pro_reviewed</code> remains false.
{{< /panel >}}

A **cylinder set** fixes symbols on finitely many coordinates and leaves all
other coordinates unrestricted. For a one-sided sequence
\(x\in A^{\mathbb N}\), the length-\(n\) prefix cylinder is

\[
C_n(x)=\{y\mid y_i=x_i\text{ whenever }i\lt n\}.
\]

## A checkable example

Over the binary alphabet, the cylinder with prefix `0,1` contains

```text
0,1,0,0,0,...
0,1,1,0,1,...
0,1,0,1,1,...
```

It excludes every sequence beginning with `0,0` or `1`. The tail after the
fixed prefix remains free.

{{< reference-figure
  src="fixed-prefix-free-tails.svg"
  alt="Three rows share blue boxes labeled zero and one, followed by differing orange tail symbols."
  caption="**Finite support:** all three sequences lie in the same length-two prefix cylinder. Their later coordinates differ without affecting membership."
>}}

For a discrete alphabet, cylinders are open. They are also closed when the
alphabet is a \(T_1\) space. Prefix cylinders form a basis for natural-indexed
products: every open neighborhood of a sequence contains one that fixes a
sufficiently long initial segment.

The length-zero cylinder is the whole space. If \(m\le n\), then
\(C_n(x)\subseteq C_m(x)\), because the longer prefix imposes every equality
required by the shorter one and possibly more.

## In Lean

{{< lean-bridge
  human="A prefix cylinder fixes exactly the coordinates below its length and equals Mathlib's finite cylinder on that initial range."
  math="\(C_n(x)=\{y:\forall i\lt n,\ y_i=x_i\}.\)"
  lean="theorem prefixCylinder_eq_fullShift_cylinder (x : OneSidedSequence A) (n : ℕ) : prefixCylinder x n = SymbolicDynamics.FullShift.cylinder (Finset.range n) x"
>}}
`Finset.range n` contains the natural numbers strictly below `n`. The equality
connects the prefix-specific `PiNat` basis to Mathlib's general cylinder on an
arbitrary finite coordinate support.
{{< /lean-bridge >}}

This is a **full project check** using the pinned Lean and Mathlib environment:

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Chaos/SymbolicCoding.lean
```

Continue to {{< refterm "symbolic-dynamics" "symbolic dynamics" >}} and the
[Deep Dive]({{< relref "/knowledge-base/deep-dives/one-sided-full-shifts-cylinders-and-itineraries" >}}).

## References

- Douglas Lind and Brian Marcus, *An Introduction to Symbolic Dynamics and
  Coding*, second edition, Cambridge University Press, 2021, Chapter 1.
  [Publisher record](https://doi.org/10.1017/9781108899727).
- Mathlib contributors,
  [`SymbolicDynamics.Basic`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/SymbolicDynamics/Basic.lean)
  and [`PiNat`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Topology/MetricSpace/PiNat.lean), version 4.32.0.
