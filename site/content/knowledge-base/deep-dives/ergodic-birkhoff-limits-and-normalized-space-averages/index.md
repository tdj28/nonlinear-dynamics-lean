---
title: "Ergodic Birkhoff Limits and Normalized Space Averages"
slug: "ergodic-birkhoff-limits-and-normalized-space-averages"
date: 2026-07-22
summary: "A textbook derivation of why an ergodic Birkhoff time average converges almost everywhere to the correctly normalized space average on every finite nonzero measure space."
lead: "The pointwise Birkhoff theorem first leaves a conditional expectation as its limit. Ergodic rigidity then removes every surviving invariant distinction, while finite nonzero mass determines the one constant that remains. This chapter follows that climb from physical time-versus-space intuition to the exact Lean split between PreErgodic rigidity, Ergodic convergence, Mathlib's canonical integral average, and five compiled boundary probes."
draft: true
pro_reviewed: false
level: "Finite measure theory, conditional expectation, ergodicity, almost-everywhere convergence, normalized Bochner integrals, and intermediate Lean theorem reading"
reading_time: "150 to 220 minutes"
prerequisites: "Finite sums, measurable sets, integrable real observables, almost-everywhere equality, and the conditional-expectation form of the pointwise Birkhoff theorem; probability normalization and Lean experience are not assumed"
lean_module: "NonlinearDynamics.Random.RandomCocycles.ErgodicBirkhoffLimit"
toc: true
og_image: "ergodic-birkhoff-limits-and-normalized-space-averages-card.png"
og_image_alt: "Warm-paper Deep Dive card showing an orbit time average passing through invariant conditional expectation, pre-ergodic information collapse, finite-mass normalization, and the probability specialization."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This chapter is an AI-assisted working draft. Its
mathematical claims and declaration names have been reconciled with the RMT-28
Lean source, but human publication review, final visual inspection, and the
configured external Pro review remain pending. The checked Lean module is
authoritative.
{{< /panel >}}

Watch one nonlinear system for a very long time. Measure one observable at
each step. Average those measurements. When should that **time average** equal
the average obtained by sampling the whole state space at once?

This question links dynamics to statistical physics. A microscopic trajectory
moves through phase space, while a macroscopic prediction is often expressed
as a space or ensemble average. The bridge is a theorem with explicit gates:
measure preservation supplies stationary orbit sampling, RMT-27 supplies a
pointwise limit, pre-ergodic rigidity removes nonconstant invariant
information, integrability legitimizes the observable, and finite nonzero mass
sets the normalization.

Fix a measurable space \(\Omega\), a measure \(\mu\), a self-map
\(T:\Omega\to\Omega\), and an integrable real observable
\(f:\Omega\to\mathbb R\). For \(n\ge 1\), define

\[
A_n f(\omega)
{} =
\frac{1}{n}\sum_{j=0}^{n-1} f\bigl(T^j\omega\bigr).
\]

Random-matrix-theory milestone 27 (RMT-27) proves, on a finite
measure-preserving system, that

\[
A_n f(\omega)
\longrightarrow
\mu[f\mid\mathcal I_T](\omega)
\quad\text{for }\mu\text{-almost every }\omega,
\]

where \(\mathcal I_T\) is Mathlib's exact
{{< refterm "invariant-sigma-algebra" "invariant sigma algebra" >}} and the
right side is
{{< refterm "conditional-expectation" "conditional expectation" >}}.
A nonergodic target may still vary between invariant components.

Milestone RMT-28 adds the rigidity step. On a finite nonzero measure, if the
system is ergodic, then

\[
A_n f(\omega)
\longrightarrow
\frac{1}{\mu(\Omega)}\int_\Omega f\,d\mu
\quad\text{for }\mu\text{-almost every }\omega.
\]

The right side is the
{{< refterm "normalized-space-average" "normalized space average" >}}. If
\(\mu\) is a probability measure, then \(\mu(\Omega)=1\), so the same target is
the ordinary integral and may honestly be called the expectation of \(f\).

The new formalization makes one assumption-minimization point central.
Collapsing an already invariant conditional expectation to a constant needs
only <code>PreErgodic T μ</code>. Convergence of orbit averages also needs
measure preservation, so the final two Birkhoff theorems use the fuller
<code>Ergodic T μ</code> structure.

The immediate predecessor is
[Birkhoff Limits, Invariant Sigma Algebras, and Conditional Expectation]({{< relref "/knowledge-base/deep-dives/birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation" >}}).
The earlier assumption-separation chapter is
[Probability Normalization and Ergodic Rigidity Before Kingman]({{< relref "/knowledge-base/deep-dives/probability-normalization-and-ergodic-rigidity-before-kingman" >}}).
The later subadditive consumer is
[Subadditive Upper Limsup Bounds Before Kingman Convergence]({{< relref "/knowledge-base/deep-dives/subadditive-upper-limsup-bounds-before-kingman-convergence" >}}),
which applies this probability-integral endpoint only under the original map
and proves an upper estimate rather than full Kingman convergence.
The compact companion is {{< refterm "ergodicity" >}}.

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| Physical route | [Time and space answer different questions](#time-and-space-answer-different-questions) | Translate the theorem into dynamics and statistical physics |
| Concrete route | [A two-cycle reaches the summit](#a-two-cycle-reaches-the-summit) | Compute an ergodic, nonmixing example |
| Rigidity route | [Pre-ergodic is the exact constancy gate](#pre-ergodic-is-the-exact-constancy-gate) | Separate information collapse from measure preservation |
| Normalization route | [The canonical space average](#the-canonical-space-average) | Understand <code>⨍</code>, finite mass, and probability |
| Proof route | [The five proof moves](#the-five-proof-moves) | Derive the constant from conditional expectation |
| Lean route | [The exact declaration map](#the-exact-declaration-map) | Audit six public declarations and one private helper |
| Boundary route | [Five compiled boundary probes](#five-compiled-boundary-probes) | Test every weak assumption boundary |
| Practice route | [Thirty solved exercises](#thirty-solved-exercises) | Rebuild the chapter independently |

### Learning objectives

By the summit, a reader should be able to:

1. distinguish an orbit time average from a normalized measure-space average;
2. state the finite nonzero ergodic Birkhoff target;
3. explain why probability is a specialization rather than a hidden premise;
4. distinguish <code>PreErgodic</code> from <code>Ergodic</code>;
5. explain why conditional-expectation collapse needs only pre-ergodicity;
6. explain why orbit convergence still needs measure preservation;
7. distinguish an exact invariant sigma algebra from triviality modulo null
   sets;
8. derive the constant by integrating an almost-everywhere equality;
9. read Mathlib's canonical notation <code>⨍ ω, f ω ∂μ</code>;
10. compute Birkhoff averages on a two-cycle;
11. prove that the cycle is ergodic but not mixing;
12. explain why \(T^2\) need not be ergodic when \(T\) is;
13. locate where integrability and nonzero mass are consumed;
14. audit all six public declarations and the private helper;
15. explain all five compiled boundary probes; and
16. state every major nonclaim without crossing into Kingman or Oseledets.

## Time and space answer different questions

A deterministic orbit begins from one state and produces

\[
\omega,\ T\omega,\ T^2\omega,\ldots.
\]

The time average \(A_nf(\omega)\) asks what one trajectory records during its
first \(n\) observations. The space average asks what the measure assigns
across all states:

\[
\text{time: }\frac{1}{n}\sum_{j=0}^{n-1}f(T^j\omega),
\qquad
\text{space: }\frac{1}{\mu(\Omega)}\int_\Omega f\,d\mu.
\]

In Hamiltonian mechanics, \(\Omega\) may be an energy surface and \(f\) a
macroscopic observable. In a random dynamical system, \(\omega\) may encode an
environment shift. In symbolic dynamics, \(f\) may indicate a local pattern.
The theorem supplies the same measure-theoretic bridge in each setting. It
does not prove that a particular physical system is ergodic, thermalizes
quickly, or carries the physically correct equilibrium measure.

{{< reference-figure
  wide="true"
  src="ergodic-time-space-bridge.svg"
  alt="A long orbit time average first reaches invariant conditional expectation. Pre-ergodic rigidity collapses the invariant target to one constant, and finite nonzero mass identifies the normalized space average. A probability branch removes the denominator."
  caption="**Finding:** convergence and ergodic collapse are separate bridges. RMT-27 reaches conditional expectation on a finite measure space using measure preservation and integrability. RMT-28 uses pre-ergodicity to remove nonconstant invariant information, then finite nonzero mass to identify the constant. Probability changes only the final normalization. No rate, mixing, or physical thermalization is implied."
>}}

### Why the nonergodic limit can retain memory

If \(\Omega\) splits into two positive-measure invariant regions, an orbit
starting in one cannot sample the other. A long time average may settle to one
value on the first region and a different value on the second. The invariant
sigma algebra records that surviving information, and conditional expectation
onto it is the correct general target.

Pre-ergodicity says no measurable strictly invariant region has both it and
its complement of positive measure. An invariant measurable real function
therefore cannot retain two positive-measure sectors. It is constant almost
everywhere.

### The result is not a finite-time guarantee

The theorem is asymptotic and almost everywhere. It gives no horizon sufficient
for a requested accuracy and permits an exceptional null set of starting
states. Slow convergence and long finite-time oscillation are compatible with
the theorem.

## Pre-ergodic is the exact constancy gate

Mathlib separates two structures. <code>PreErgodic T μ</code> says every
measurable set \(S\) satisfying

\[
T^{-1}(S)=S
\]

is almost empty or almost full. Equivalently, either \(\mu(S)=0\) or
\(\mu(S^{\mathsf c})=0\). This is an invariant-information condition. Its
definition does not assert that \(T\) preserves \(\mu\).

<code>Ergodic T μ</code> extends both

1. <code>MeasurePreserving T μ μ</code>; and
2. <code>PreErgodic T μ</code>.

Now set

\[
g=\mu[f\mid\mathcal I_T].
\]

This selected conditional-expectation representative is measurable for
\(\mathcal I_T\) and satisfies the literal equality

\[
g\circ T=g.
\]

Once those facts are available, pre-ergodicity alone makes \(g\) almost
everywhere constant. Measure preservation returns only when the RMT-27
orbit-convergence theorem is invoked.

{{< reference-figure
  wide="true"
  src="preergodic-ergodic-assumption-ladder.svg"
  alt="An assumption ladder gives exact invariant composition without ergodicity, constancy from pre-ergodicity, constant identification from finite nonzero mass and integrability, and Birkhoff convergence only after measure preservation upgrades the system to full ergodicity."
  caption="**Finding:** the proof uses the weakest premise at each rung. Exact representative invariance is unconditional. Pre-ergodicity supplies constancy. Finite nonzero mass and integrability identify the constant. Full ergodicity enters only where RMT-27 consumes measure preservation."
>}}

### The invariant sigma algebra is not literally bottom

Ergodicity does not generally imply the literal set equation

\[
\mathcal I_T=\{\varnothing,\Omega\}.
\]

There may be nonempty invariant null sets and proper conull invariant sets.
Pre-ergodicity makes them trivial modulo \(\mu\); it does not delete them as
sets. RMT-28 proves almost-everywhere constancy and never rewrites
<code>MeasurableSpace.invariants T</code> to the bottom measurable space.

### Zero measure exposes the boundary

Under the zero measure, every measurable set is both almost empty and almost
full. Mathlib can therefore regard a measurable map as ergodic for zero
measure. RMT-28 keeps <code>hμ : μ ≠ 0</code> explicit on finite-mass
normalization theorems. Probability measures obtain nonzeroness automatically.

## The canonical space average

Mathlib already names the normalized integral:

~~~lean
⨍ ω, f ω ∂μ
~~~

On a finite measure,

\[
\operatorname{Avg}_\mu(f)
{} =
\bigl(\mu.\operatorname{real}(\Omega)\bigr)^{-1}
\int_\Omega f\,d\mu.
\]

The finite nonzero hypotheses make the real denominator legitimate. The proof
first identifies the constant with Mathlib's canonical average using
<code>measure_smul_average</code>, then exposes the reciprocal-mass form using
<code>average_eq</code>.

If <code>[IsProbabilityMeasure μ]</code>, then \(\mu(\Omega)=1\), and
<code>average_eq_integral</code> gives

\[
\operatorname{Avg}_\mu(f)
{} =
\int_\Omega f\,d\mu.
\]

Only this mass-one branch licenses the ordinary expectation scale. For a
measure of mass two, the raw integral is twice the normalized average.

Scaling \(\mu\) by a positive scalar \(a\) multiplies both total mass and
integral by \(a\), leaving the ratio unchanged:

\[
\frac{1}{(a\mu)(\Omega)}\int_\Omega f\,d(a\mu)
{} =
\frac{1}{\mu(\Omega)}\int_\Omega f\,d\mu.
\]

The mass-two Dirac probe checks this identity inside Lean.

## A two-cycle reaches the summit

Let \(\Omega=\{0,1\}\), give each point mass \(1/2\), and let \(T\) flip the
points:

\[
T(0)=1,\qquad T(1)=0.
\]

Write \(f(0)=a\) and \(f(1)=b\). For positive \(m\),

\[
A_{2m}f(0)=A_{2m}f(1)=\frac{a+b}{2},
\]

while

\[
\begin{aligned}
A_{2m+1}f(0)
&=\frac{(m+1)a+mb}{2m+1},\\
A_{2m+1}f(1)
&=\frac{ma+(m+1)b}{2m+1}.
\end{aligned}
\]

Both odd subsequences converge to \((a+b)/2\), which is also the probability
integral of \(f\).

The only strictly invariant subsets are \(\varnothing\) and \(\Omega\), and
the flip preserves uniform measure, so it is ergodic. It is not mixing. For
\(E=\{0\}\),

\[
\mu\bigl(E\cap T^{-n}(E)\bigr)
{} =
\begin{cases}
1/2,&n\text{ even},\\
0,&n\text{ odd}.
\end{cases}
\]

This oscillates instead of approaching \(\mu(E)^2=1/4\). Moreover,
\(T^2=\operatorname{id}_\Omega\), so \(T^2\) is not ergodic. RMT-28 needs
ergodicity only of \(T\), not of a powered map.

{{< reference-figure
  wide="true"
  src="two-cycle-parity-boundary.svg"
  alt="A uniform two-state flip alternates observable values a and b. Even and odd Birkhoff averages approach their mean, event overlap alternates between one half and zero, and the squared map is the nonergodic identity."
  caption="**Finding:** the two-cycle is ergodic and its full Birkhoff sequence converges to the space average, yet it is not mixing and its second iterate is not ergodic. This blocks any hidden use of mixing or powered-map ergodicity."
>}}

## The five proof moves

1. Set \(g=\mu[f\mid\mathcal I_T]\).
2. Use exact invariant measurability to prove \(g\circ T=g\) pointwise.
3. Use <code>PreErgodic T μ</code> to obtain \(g=c\) almost everywhere.
4. Under finite nonzero mass and <code>Integrable f μ</code>, integrate the
   equality and use <code>setIntegral_condExp</code> to derive
   \[
   \mu(\Omega)c=\int_\Omega f\,d\mu.
   \]
5. Rewrite RMT-27's conditional-expectation limit using the identified
   constant. Full <code>Ergodic</code> supplies the measure-preserving field
   needed at this final convergence step.

The semantic use of integrability occurs in step 4. The proof does not hide a
nonintegrable zero fallback behind a convenient global-integral identity.

## The exact declaration map

The canonized module exports six public declarations and keeps one existential
constancy helper private.

### Declaration 1: exact composition invariance

~~~lean
theorem condExp_invariants_comp :
    (μ[f | MeasurableSpace.invariants T]) ∘ T =
      μ[f | MeasurableSpace.invariants T]
~~~

No finiteness, integrability, or dynamical hypothesis appears.

### Private helper: pre-ergodic constancy

~~~lean
private theorem condExp_invariants_ae_eq_const_of_preErgodic
    (hT : PreErgodic T μ) :
    ∃ c : ℝ, μ[f | MeasurableSpace.invariants T] =ᵐ[μ]
      fun _ : Ω ↦ c
~~~

The helper records the weakest rigidity step. It is private because public
users normally need the identified constant.

### Declaration 2: canonical average

~~~lean
theorem condExp_invariants_ae_eq_average_of_preErgodic
    [IsFiniteMeasure μ]
    (hμ : μ ≠ 0) (hT : PreErgodic T μ) (hf : Integrable f μ) :
    μ[f | MeasurableSpace.invariants T] =ᵐ[μ]
      fun _ : Ω ↦ ⨍ x, f x ∂μ
~~~

### Declaration 3: explicit normalization

~~~lean
theorem condExp_invariants_ae_eq_normalizedIntegral_of_preErgodic
    [IsFiniteMeasure μ]
    (hμ : μ ≠ 0) (hT : PreErgodic T μ) (hf : Integrable f μ) :
    μ[f | MeasurableSpace.invariants T] =ᵐ[μ]
      fun _ : Ω ↦ (μ.real univ)⁻¹ * ∫ x, f x ∂μ
~~~

### Declaration 4: probability integral

~~~lean
theorem condExp_invariants_ae_eq_integral_of_preErgodic
    [IsProbabilityMeasure μ]
    (hT : PreErgodic T μ) (hf : Integrable f μ) :
    μ[f | MeasurableSpace.invariants T] =ᵐ[μ]
      fun _ : Ω ↦ ∫ x, f x ∂μ
~~~

Declarations 2 through 4 require no measure preservation because they identify
an already invariant conditional expectation.

### Declaration 5: finite nonzero Birkhoff limit

~~~lean
theorem ae_tendsto_birkhoffAverage_normalizedIntegral_of_ergodic
    [IsFiniteMeasure μ]
    (hμ : μ ≠ 0) (hT : Ergodic T μ) (hf : Integrable f μ) :
    ∀ᵐ ω ∂μ,
      Tendsto (fun n ↦ birkhoffAverage ℝ T f n ω) atTop
        (nhds ((μ.real univ)⁻¹ * ∫ x, f x ∂μ))
~~~

### Declaration 6: probability Birkhoff limit

~~~lean
theorem ae_tendsto_birkhoffAverage_integral_of_ergodic
    [IsProbabilityMeasure μ]
    (hT : Ergodic T μ) (hf : Integrable f μ) :
    ∀ᵐ ω ∂μ,
      Tendsto (fun n ↦ birkhoffAverage ℝ T f n ω) atTop
        (nhds (∫ x, f x ∂μ))
~~~

The final pair uses full ergodicity because it composes RMT-27 measure-preserving
convergence with the pre-ergodic target identification.

## Assumption ledger

The signatures form a useful audit table. "Built in" means that the premise is
a field of the stated structure, not an extra argument written beside it.

| Result | Finite measure | Nonzero measure | Pre-ergodic | Measure preserving | Integrable \(f\) | Probability |
|---|---:|---:|---:|---:|---:|---:|
| Exact conditional-expectation composition | No | No | No | No | No | No |
| Private almost-everywhere constancy helper | No | No | Yes | No | No | No |
| Conditional expectation equals integral average | Yes | Yes | Yes | No | Yes | No |
| Conditional expectation equals explicit normalized integral | Yes | Yes | Yes | No | Yes | No |
| Conditional expectation equals ordinary integral | Built in | Built in | Yes | No | Yes | Yes |
| Birkhoff averages tend to normalized integral | Yes | Yes | Built in | Built in | Yes | No |
| Birkhoff averages tend to ordinary integral | Built in | Built in | Built in | Built in | Yes | Yes |

Several omissions are deliberate.

- No declaration asks for injectivity, surjectivity, or invertibility of
  \(T\).
- No declaration asks for mixing, independence, or decay of correlations.
- No declaration asks for ergodicity of \(T^b\) for any \(b\ge2\).
- The conditional-expectation identification declarations do not ask for
  measure preservation.
- The finite-mass declarations do not ask for probability normalization.
- The unconditional representative equality and private constancy helper do
  not ask for integrability.

The final two omissions are easy to misread. They rely on Mathlib's totalized
definitions and say only what their signatures say. The semantic normalized
mean theorem does restore integrability and nonzero finite mass.

## Totalization ledger

Formal libraries often define an operation on every input, then place familiar
mathematical hypotheses on theorems that describe its intended behavior.
RMT-28 keeps five such boundaries visible.

| Object | Totalized behavior | Semantic gate used by RMT-28 |
|---|---|---|
| <code>birkhoffAverage ℝ T f 0 ω</code> | The empty sum and inverse of zero make the horizon-zero value \(0\) | Limits are tail properties, so this convention does not change the theorem |
| <code>μ[f \| 𝓖]</code> | Mathlib returns a function even when \(f\) is not integrable | Identified-average theorems require <code>Integrable f μ</code> and consume it through <code>setIntegral_condExp</code> |
| <code>∫ x, f x ∂μ</code> | The Bochner integral is \(0\) for a nonintegrable function | RMT-28 does not advertise that fallback as a nonintegrable ergodic theorem |
| <code>⨍ x, f x ∂μ</code> | The library average is defined for zero, infinite, and nonintegrable cases; zero or infinite mass can produce \(0\) | The normalized theorem assumes finite nonzero mass and integrability |
| Almost-everywhere claims under \(\mu=0\) | Every predicate holds almost everywhere | The zero-measure probe records the vacuity; the normalized theorem requires <code>μ ≠ 0</code> |

### Horizon zero does not alter convergence

The project defines the average for every natural horizon. At \(n=0\),

\[
A_0f(\omega)=0.
\]

Changing finitely many values of a sequence does not change its limit at
infinity. The theorem therefore describes the full natural-number sequence
without inventing a positive-natural index type. This convenience must not be
mistaken for the claim that the zero-horizon value already equals the space
average.

### The average operation is broader than the average theorem

Mathlib defines <code>average μ f</code> by integrating against a normalized
measure. Its documentation states that the result is zero when \(f\) is not
integrable or when \(\mu\) is infinite. It also has an explicit
<code>average_zero_measure</code> theorem. These are coherent totalized
semantics. They are not a license to cancel \(\mu(\Omega)\) when it is zero or
to interpret a nonintegrable fallback as a physical average.

### Almost everywhere is the right equality

Conditional expectation is unique only up to null sets. The Birkhoff theorem
also permits an exceptional null set of initial conditions. RMT-28 therefore
concludes almost-everywhere equality and almost-everywhere convergence. It
does not strengthen either statement to pointwise equality on all of
\(\Omega\).

## Five compiled boundary probes

The leaf module ends with five <code>example</code> declarations. They are
compiled countermodel tests, not decorative prose examples.

### Probe 1: probability Dirac with a nonbijective map

On <code>Bool</code>, define \(T\) to send both points to
<code>false</code>, and put all probability mass at <code>false</code>. The
module proves simultaneously that:

1. \(T\) is ergodic for \(\delta_{\mathsf{false}}\);
2. \(T\) is not injective;
3. \(T\) is not surjective; and
4. every integrable real observable has Birkhoff averages converging almost
   everywhere to its ordinary integral.

Only the supported point matters to the measure. The unused point witnesses
both failures of bijectivity without disturbing measure preservation or
ergodicity. This probe blocks hidden invertibility assumptions.

### Probe 2: pre-ergodic rigidity without measure preservation

Keep the same constant-false map, but move the Dirac mass to
<code>true</code>. Every self-map is pre-ergodic for a Dirac measure, because
membership of the supported atom makes every measurable set almost empty or
almost full. This particular map does not preserve \(\delta_{\mathsf{true}}\):
it moves the supported point to <code>false</code>.

The probe nevertheless applies
<code>condExp_invariants_ae_eq_integral_of_preErgodic</code>. It proves that the
invariant conditional expectation of every integrable observable equals its
ordinary integral almost everywhere. This is the sharp executable witness for
the assumption split. Conditional-expectation rigidity needs
<code>PreErgodic</code>; orbit convergence cannot be concluded because measure
preservation is missing.

### Probe 3: the same Dirac system at mass two

Scale the supported-at-false Dirac measure by two:

\[
\nu=2\delta_{\mathsf{false}}.
\]

For an integrable \(h\), the module computes

\[
\nu(\Omega)=2,
\qquad
\int_\Omega h\,d\nu=2h(\mathsf{false}),
\]

and therefore

\[
\frac{1}{\nu(\Omega)}\int_\Omega h\,d\nu
{} =
h(\mathsf{false}).
\]

The same noninjective and nonsurjective base remains ergodic. The result tests
the general finite-mass theorem rather than the probability corollary. It also
shows exactly why a raw integral cannot replace the normalized target.

### Probe 4: zero measure is ergodic but cannot pass the mass gate

For the zero measure on <code>Bool</code>, the identity map is ergodic in
Mathlib's sense. The module also proves that <code>NeZero (0 : Measure
Bool)</code> is impossible. Finally it records a normalized-looking
almost-everywhere convergence statement, which is vacuously true because
every almost-everywhere proposition holds under the zero measure.

The point is not to promote that vacuous formula. The point is to prove that
ergodicity alone does not imply positive total mass and that the explicit
<code>hμ : μ ≠ 0</code> premise is necessary for semantic normalization.

### Probe 5: the weak rigidity gate fails on a two-atom identity

Give both Boolean atoms positive mass and let \(T\) be the identity. Let

\[
f(\mathsf{false})=0,
\qquad
f(\mathsf{true})=1.
\]

The finalized probe proves three negative facts in order:

1. the identity is not <code>PreErgodic</code> for this measure;
2. consequently it is not <code>Ergodic</code>; and
3. its invariant conditional expectation does not collapse almost everywhere
   to the normalized global integral.

For identity dynamics, the exact invariant sigma algebra is the whole ambient
sigma algebra, so conditional expectation returns \(f\) almost everywhere.
Since both atoms have positive mass, \(f\) is not almost everywhere constant.
This is the exact countermodel to the weakest missing gate, not merely a
counterexample to full ergodicity.

## How the Lean proof mirrors the mathematics

The central proof of declaration 2 can be read almost line by line as the
paper argument.

~~~lean
obtain ⟨c, hc⟩ :=
  condExp_invariants_ae_eq_const_of_preErgodic (f := f) hT
~~~

This obtains the almost-everywhere constant \(c\). The next calculation
integrates it and uses the whole-space conditional-expectation identity:

~~~lean
have hIntegral : μ.real univ * c = ∫ x, f x ∂μ := by
  calc
    μ.real univ * c = ∫ _x : Ω, c ∂μ := by
      simp only [integral_const, smul_eq_mul]
    _ = ∫ x, μ[f | MeasurableSpace.invariants T] x ∂μ :=
      (integral_congr_ae hc).symm
    _ = ∫ x, f x ∂μ := by
      simpa only [setIntegral_univ] using
        setIntegral_condExp (MeasurableSpace.invariants_le T) hf
          (MeasurableSet.univ :
            MeasurableSet[MeasurableSpace.invariants T] (univ : Set Ω))
~~~

The explicit call to <code>setIntegral_condExp</code> carries
<code>hf</code>. The proof then cancels the nonzero real total mass and uses
<code>measure_smul_average</code> to recognize the canonical integral average.
The two presentation corollaries are short rewrites using
<code>average_eq</code> and <code>average_eq_integral</code>.

The final convergence proof combines two almost-everywhere statements with
<code>filter_upwards</code>:

1. the RMT-27 limit to conditional expectation; and
2. the RMT-28 identification of that conditional expectation with the
   normalized constant.

At a state where both statements hold, rewriting the target finishes the
proof. This composition is the formal analogue of a clean corollary proof in
a textbook.

## Source ledger and theorem alignment

No single historical source is presented as a line-by-line specification of
the Lean module. Each source supports a different layer.

### Birkhoff, 1931

George D. Birkhoff's
[Proof of the Ergodic Theorem](https://doi.org/10.1073/pnas.17.2.656),
*Proceedings of the National Academy of Sciences* 17(12), 656-660, is the
historical pointwise origin. Its setting is a continuous flow preserving
volume on a closed analytic manifold. Page 660 connects strong transitivity
with occupation ratios. That geometric, continuous-time formulation is not
the exact source statement of RMT-28's abstract discrete, finite-measure,
possibly noninvertible interface.

### Keane and Petersen, 2006

Michael Keane and Karl Petersen's
[Easy and Nearly Simultaneous Proofs of the Ergodic Theorem and Maximal Ergodic Theorem](https://doi.org/10.1214/074921706000000266),
*IMS Lecture Notes-Monograph Series* 48, 248-251, presents the pointwise
ergodic theorem for an integrable function on a probability space with a
possibly noninvertible measure-preserving transformation. It is close to the
convergence layer inherited through RMT-27. RMT-28 additionally exposes
arbitrary finite nonzero mass and Mathlib's exact invariant-space interfaces.

### Hess, Seri, and Choirat, 2010

Christian Hess, Raffaello Seri, and Christine Choirat's
[Ergodic Theorems for Extended Real-Valued Random Variables](https://doi.org/10.1016/j.spa.2010.05.008),
*Stochastic Processes and their Applications* 120(10), 1908-1919,
[full text from an author](https://rseri.me/publication/j007/J007.pdf),
distinguishes exact invariant sets from their completion modulo null sets on
pages 1909-1910. Its Theorem 1 states a nonergodic conditional-expectation
target on a probability space. This supports the exact-versus-completed
distinction and the RMT-27 target, while RMT-28 adds the separate pre-ergodic
collapse and finite-mass normalization.

### Pollicott and Yuri

Mark Pollicott and Michiko Yuri's
[Ergodic measures](https://doi.org/10.1017/CBO9781139173049.011), chapter 9 of
*Dynamical Systems and Ergodic Theory*, develops the equivalence between
ergodic invariant-set rigidity and almost-everywhere constancy of invariant
functions in the probability setting. It is a conceptual source for the
function-level collapse. The Lean module uses the exact theorem available in
the pinned Mathlib revision and weakens the local premise to
<code>PreErgodic</code> where measure preservation is unused.

### Pinned Mathlib and project source

The repository pins Mathlib 4.32.0 at commit
<code>81a5d257c8e410db227a6665ed08f64fea08e997</code>. These files are the
version-specific authorities:

- [Ergodic structures](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Ergodic.lean#L40-L52)
  define <code>PreErgodic</code> and <code>Ergodic</code>.
- [Invariant-function rigidity](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Function.lean#L45-L56)
  supplies the pre-ergodic almost-everywhere constancy theorem.
- [Exact invariant measurable spaces](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/MeasurableSpace/Invariants.lean)
  supply literal composition invariance.
- [Integral averages](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Integral/Average.lean#L271-L345)
  define <code>⨍</code> and prove its finite-mass and probability formulas.
- [Conditional-expectation foundations](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Function/ConditionalExpectation/Basic.lean)
  supply strong measurability and set-integral preservation.
- [ErgodicBirkhoffLimit.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/ErgodicBirkhoffLimit.lean)
  is the checked RMT-28 source described by this chapter.

These links document the pinned proof environment. Later Mathlib revisions may
rename declarations or reorganize files without changing the underlying
mathematics.

## Boundaries and nonclaims

RMT-28 proves an additive, real-valued, discrete-time corollary. It does not
prove any of the following:

- convergence at every initial state;
- a rate of convergence or a finite sample-size guarantee;
- uniform convergence in the initial state;
- mixing, weak mixing, decay of correlations, or independence;
- ergodicity of any powered map \(T^b\);
- injectivity, surjectivity, invertibility, or existence of a measurable
  inverse;
- that Mathlib's exact invariant sigma algebra is literally the bottom sigma
  algebra;
- a nonintegrable extension of the semantic mean formula;
- an infinite-measure ergodic theorem;
- a vector-valued pointwise theorem;
- a continuous-time flow theorem;
- physical thermalization, equipartition, or uniqueness of an equilibrium
  measure;
- Kingman's subadditive ergodic theorem;
- a samplewise random-matrix cocycle growth limit;
- a Lyapunov exponent; or
- an Oseledets invariant splitting.

The two-cycle shows why several of these exclusions are substantive. Its
averages converge exactly as promised even though correlations do not decay
and \(T^2\) is not ergodic.

## Reproduce the checked layer

From the repository root on a machine with Elan installed:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean NonlinearDynamics/Random/RandomCocycles/ErgodicBirkhoffLimit.lean
~~~

To replay the repository-wide gate, return to the root and run:

~~~sh
cd ..
make check
git diff --check
~~~

The module ends with six <code>#print axioms</code> commands, one for each
public declaration. Warning-fatal compilation and the repository checks also
reject unfinished proof placeholders. A successful leaf compile establishes
that the stated Lean terms elaborate against the pinned toolchain; it does not
replace human mathematical and editorial review of this chapter.

## Thirty solved exercises

### Exercise 1: one even two-cycle average

Let \(f(0)=3\) and \(f(1)=7\). Compute \(A_6f(0)\).

**Solution.** The observations are \(3,7,3,7,3,7\). Their mean is
\(30/6=5\), equal to \((3+7)/2\).

### Exercise 2: two odd two-cycle averages

Compute \(A_5f(0)\) and \(A_5f(1)\) for the same observable.

**Solution.** The sequences are \(3,7,3,7,3\) and \(7,3,7,3,7\), so the
averages are \(23/5\) and \(27/5\). They differ at this finite horizon, but
both odd subsequences tend to \(5\).

### Exercise 3: the two-cycle space average

Why is the normalized space average equal to \(5\)?

**Solution.** Both atoms have mass \(1/2\), so
\[
\int f\,d\mu=\frac12\cdot3+\frac12\cdot7=5.
\]
The measure is probabilistic, so its integral already is its normalized
average.

### Exercise 4: invariant sets of the flip

List every \(S\subseteq\{0,1\}\) satisfying \(T^{-1}(S)=S\).

**Solution.** The empty and full sets pass. Each singleton pulls back to the
other singleton, so neither passes.

### Exercise 5: the flip is not mixing

Use \(E=\{0\}\) to reject mixing.

**Solution.** The overlap \(\mu(E\cap T^{-n}E)\) alternates between \(1/2\)
and \(0\), while mixing would require convergence to \(\mu(E)^2=1/4\).

### Exercise 6: the squared flip is not ergodic

Why does ergodicity of \(T\) not transfer to \(T^2\) here?

**Solution.** \(T^2\) is the identity. The singleton \(\{0\}\) is invariant
and has mass \(1/2\), as does its complement.

### Exercise 7: pre-ergodic versus ergodic

What extra field does <code>Ergodic T μ</code> contain?

**Solution.** It contains <code>MeasurePreserving T μ μ</code> in addition to
<code>PreErgodic T μ</code>.

### Exercise 8: the weakest constancy premise

Does the private constancy helper need measure preservation?

**Solution.** No. The conditional expectation is already exactly invariant,
so pre-ergodic invariant-information rigidity is sufficient.

### Exercise 9: representative equality

Why is <code>condExp_invariants_comp</code> pointwise?

**Solution.** Mathlib selects a total conditional-expectation representative
that is strongly measurable for the exact invariant measurable space. The
invariant-space composition theorem gives literal equality for that
representative.

### Exercise 10: identify the constant equation

If \(g=c\) almost everywhere and \(\int g\,d\mu=\int f\,d\mu\), what equation
does \(c\) satisfy?

**Solution.**
\[
\mu(\Omega)c=\int_\Omega f\,d\mu.
\]

### Exercise 11: why nonzero mass matters

Why does the preceding equation fail to identify \(c\) for \(\mu=0\)?

**Solution.** It reduces to \(0=0\) for every \(c\), so cancellation is
impossible.

### Exercise 12: a mass-three average

If \(\mu(\Omega)=3\) and \(\int f\,d\mu=12\), find the normalized average.

**Solution.** It is \(3^{-1}\cdot12=4\), not the raw integral \(12\).

### Exercise 13: scaling invariance

Replace the measure in exercise 12 by \(5\mu\). Find its mass, integral, and
average.

**Solution.** They are \(15\), \(60\), and \(60/15=4\), respectively.

### Exercise 14: a mass-two Dirac measure

For \(\nu=2\delta_x\), compute the normalized average of \(h\).

**Solution.** The mass is \(2\), the integral is \(2h(x)\), and the normalized
average is \(h(x)\).

### Exercise 15: when integral means expectation

Which premise licenses expectation language for \(\int f\,d\mu\)?

**Solution.** <code>IsProbabilityMeasure μ</code>, together with the separate
integrability premise. It fixes total mass at one.

### Exercise 16: finite mass without probability

Which declaration handles an ergodic measure of total mass \(7\)?

**Solution.**
<code>ae_tendsto_birkhoffAverage_normalizedIntegral_of_ergodic</code>, whose
target is \(7^{-1}\int f\,d\mu\).

### Exercise 17: two-atom identity limits

For identity dynamics with \(f(\mathsf{false})=0\) and
\(f(\mathsf{true})=1\), find both Birkhoff limits.

**Solution.** Each orbit stays where it starts, so the limits are \(0\) and
\(1\), not the normalized global mean.

### Exercise 18: locate the weak failed gate

Does the system in exercise 17 already fail pre-ergodicity?

**Solution.** Yes. Either singleton is strictly invariant and both it and its
complement have positive mass.

### Exercise 19: exact invariants need not be bottom

May an ergodic system have a nonempty invariant null set?

**Solution.** Yes. Pre-ergodicity gives triviality modulo null sets, not
literal set equality with only \(\varnothing\) and \(\Omega\).

### Exercise 20: zero-measure vacuity

Why does every pointwise predicate hold almost everywhere under the zero
measure?

**Solution.** Every failure set has measure zero.

### Exercise 21: horizon zero

What is <code>birkhoffAverage ℝ T f 0 ω</code>, and must it equal the limit?

**Solution.** It is \(0\). A sequence limit ignores finitely many initial
terms, so it need not equal the eventual target.

### Exercise 22: where integrability is consumed

Which theorem uses <code>hf : Integrable f μ</code> to identify the constant?

**Solution.** <code>setIntegral_condExp</code>, through the whole-space
visible-set integral identity.

### Exercise 23: the totalized private helper

Why is the integrability-free helper not a nonintegrable mean theorem?

**Solution.** It says only that the library's totalized conditional
expectation is some almost-everywhere constant. It does not identify that
constant with a semantic normalized integral.

### Exercise 24: nonbijective measure preservation

How can a constant map preserve \(\delta_{\mathsf{false}}\)?

**Solution.** It fixes the only point carrying mass. Its behavior on the null
point does not change the pushforward measure.

### Exercise 25: pre-ergodic but nonpreserving

Why is the constant-false map pre-ergodic for
\(\delta_{\mathsf{true}}\) but not measure preserving?

**Solution.** Every Dirac measure makes each set almost empty or almost full,
so pre-ergodicity holds. The map moves the supported point from true to false,
so the pushforward Dirac measure changes.

### Exercise 26: why convergence uses full ergodicity

Why do declarations 5 and 6 use <code>Ergodic</code>?

**Solution.** They invoke RMT-27's Birkhoff theorem, which needs measure
preservation, and also need pre-ergodicity to collapse the target.

### Exercise 27: why identification uses only pre-ergodicity

Why do declarations 2 through 4 avoid full <code>Ergodic</code>?

**Solution.** Their input is an already invariant conditional expectation.
Measure preservation has no remaining role in identifying its constant value.

### Exercise 28: reconstruct the proof order

Order these ingredients: RMT-27 convergence, exact composition invariance,
constant identification, pre-ergodic constancy.

**Solution.** Exact composition invariance comes first, then pre-ergodic
constancy, then integration and normalization identify the constant, and
finally RMT-27 convergence is rewritten.

### Exercise 29: choose the declaration-name authority

Which source fixes the exact spelling of <code>average_eq</code>?

**Solution.** The pinned Mathlib
<code>Mathlib/MeasureTheory/Integral/Average.lean</code> source, not a
historical paper or an unpinned documentation page.

### Exercise 30: state the summit honestly

Give the theorem and one major boundary in two sentences.

**Solution.** On a finite nonzero ergodic system, Birkhoff averages of an
integrable real observable converge almost everywhere to its normalized space
integral, with the ordinary integral as the probability specialization. This
supplies no rate, mixing result, powered-map ergodicity, subadditive
cocycle-growth limit, Lyapunov exponent, or Oseledets splitting.

## References

<a id="ref-rmt28-birkhoff"></a>**George D. Birkhoff.**
[Proof of the Ergodic Theorem](https://doi.org/10.1073/pnas.17.2.656),
*Proceedings of the National Academy of Sciences* 17(12), 656-660, 1931.
Historical primary source for pointwise time-average convergence in its
geometric continuous-time setting.

<a id="ref-rmt28-keane-petersen"></a>**Michael Keane and Karl Petersen.**
[Easy and Nearly Simultaneous Proofs of the Ergodic Theorem and Maximal Ergodic Theorem](https://doi.org/10.1214/074921706000000266),
*IMS Lecture Notes-Monograph Series* 48, 248-251, 2006,
[author manuscript](https://arxiv.org/abs/math/0608251). Primary source for a
modern probability-space pointwise theorem allowing a possibly noninvertible
measure-preserving transformation.

<a id="ref-rmt28-hess"></a>**Christian Hess, Raffaello Seri, and Christine Choirat.**
[Ergodic Theorems for Extended Real-Valued Random Variables](https://doi.org/10.1016/j.spa.2010.05.008),
*Stochastic Processes and their Applications* 120(10), 1908-1919, 2010,
[author full text](https://rseri.me/publication/j007/J007.pdf). Primary source
for a modern conditional-expectation formulation and the exact-versus-completed
invariant-field distinction.

<a id="ref-rmt28-pollicott-yuri"></a>**Mark Pollicott and Michiko Yuri.**
[Ergodic measures](https://doi.org/10.1017/CBO9781139173049.011), chapter 9 of
*Dynamical Systems and Ergodic Theory*, Cambridge University Press, 1998.
Textbook source for invariant-set and invariant-function characterizations.

<a id="ref-rmt28-mathlib"></a>**Mathlib contributors.**
[Ergodic structures](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Ergodic.lean),
[invariant functions](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Function.lean),
and
[integral averages](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Integral/Average.lean),
Mathlib 4.32.0 at pinned commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).

<a id="ref-rmt28-project"></a>**Nonlinear Dynamics in Lean contributors.**
[ErgodicBirkhoffLimit.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/ErgodicBirkhoffLimit.lean),
the checked source for the six public declarations, private constancy helper,
five boundary probes, and theorem boundaries described here.
