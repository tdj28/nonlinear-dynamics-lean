---
title: "Vector field"
slug: "vector-field"
summary: "A vector field assigns a tangent vector to every point, specifying an instantaneous direction and speed rather than a completed trajectory."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.ODE.GlobalExistence"
tags: ["Vector fields", "ODE", "Manifolds", "Lean 4"]
og_image: "vector-field-card.png"
og_image_alt: "Arrows attached to points on a plane show the values of a rotational vector field."
---

{{< panel "warning" >}}
**Editorial and validation status.** Candidate commit <code>9f8b251</code>
passes its warning-fatal Lean leaf, deterministic aggregator, and complete
repository gate. Professional review is pending, so
<code>pro_reviewed</code> remains false.
{{< /panel >}}

A **vector field** assigns to each point \(x\) of a space a tangent vector
\(v(x)\) based at that point. It specifies an instantaneous direction and
speed. It is not itself a trajectory.

## A checkable example

On the plane \(\mathbb R^2\), define

\[
v(x,y)=(-y,x).
\]

At \((1,0)\), the vector is \((0,1)\), pointing upward. At \((0,1)\), it is
\((-1,0)\), pointing left. The assignments are tangent to circles centered at
the origin. At \((0,0)\), the vector is zero.

{{< reference-figure
  src="rotational-vector-field.svg"
  alt="Eight points around a circle carry counterclockwise tangent arrows, while the origin carries a dot labeled zero vector."
  caption="**The field \(v(x,y)=(-y,x)\):** each arrow is attached to its base point and tangent to the circle through that point. The origin is an equilibrium because its assigned tangent vector is zero."
>}}

The nearby boundary case is the zero field \(v(x)=0\) at every point. It
specifies no instantaneous motion. Every constant curve is then an integral
curve through its own starting point.

## On a manifold

For a smooth manifold \(M\), the tangent spaces vary with the point. A field
therefore has the dependent type

\[
v:(x:M)\longmapsto T_xM.
\]

Regularity such as continuous differentiability concerns the bundled map
\(x\mapsto(x,v(x))\) into the tangent bundle. Regularity supports local
existence and uniqueness results, but it does not by itself guarantee that
every trajectory exists for all real time.

## In Lean

{{< lean-bridge
  human="A vector field assigns a tangent vector based at each point of the manifold."
  math="\(v:x\mapsto v(x)\in T_xM.\)"
  lean="vfield : (x : M) → TangentSpace I x"
>}}
The binder `(x : M)` names the base point. The result type `TangentSpace I x`
depends on `x`. The model-with-corners parameter `I` records the manifold's
coordinate model.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.ODE.GlobalExistence

open Manifold
open NonlinearDynamics.Deterministic.ODE

#check TangentSpace
#check HasGlobalIntegralCurves
#check zeroVectorField_hasGlobalIntegralCurves
~~~

This is a **full project check** on macOS or Linux and uses the repository's
pinned Lean and Mathlib dependencies. Initial setup may require substantial
disk space or build time.

{{< repo-check >}}
The worksheet inspects the dependent tangent-space type and the zero-field
global-curve boundary case.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/ODE/GlobalExistence.lean
```

Continue with {{< refterm "integral-curve" "integral curves" >}} to see how a
curve follows a field.

## References

- John M. Lee, *Introduction to Smooth Manifolds*, second edition, Springer,
  2013, Chapters 3 and 8. [Publisher record](https://doi.org/10.1007/978-1-4419-9982-5).
- Mathlib contributors,
  [`IntegralCurve.Basic`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Geometry/Manifold/IntegralCurve/Basic.lean),
  version 4.32.0.
