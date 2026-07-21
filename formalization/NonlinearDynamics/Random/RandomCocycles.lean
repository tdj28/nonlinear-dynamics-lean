import NonlinearDynamics.Random.RandomCocycles.Discrete
import NonlinearDynamics.Random.RandomCocycles.NormObservables
import NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability
import NonlinearDynamics.Random.RandomCocycles.IntegratedLogPlusGrowth
import NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase
import NonlinearDynamics.Random.RandomCocycles.SubadditiveFiniteBlocks
import NonlinearDynamics.Random.RandomCocycles.SubadditiveCentering
import NonlinearDynamics.Random.RandomCocycles.SubadditivePhaseAveraging

/-!
# Random cocycles

Generator-presented one-sided matrix cocycles over measure-preserving bases,
with finite-time algebra, measurability, maximum-row-sum norm observables, and
extended log norms. A separate real log-positive envelope propagates an
explicit one-step integrability assumption through every finite horizon while
remaining distinct from contraction-sensitive asymptotic growth theory. Its
totalized integrals are invariant under preserved base shifts. Under the same
explicit integrability hypothesis, the integrated sequence is subadditive and
has a deterministic Fekete limit, without assuming probability or ergodicity
and without an almost-sure or Lyapunov conclusion. A final interface layer
separates probability normalization, ergodic rigidity, and finite-time
integrability while packaging the log-positive family as an integrable
subadditive-process candidate. The shifted subadditive inequality alone then
gives finite block bounds by Birkhoff sums of a fixed block observable plus a
short remainder, while preservation of the chosen block map gives
integrability of each finite sum. Subtracting the one-step Birkhoff sum then
produces a shifted-subadditive process that is nonpositive at positive
horizons, and uniformly nonpositive under exact time-zero normalization. It
also gives an exact normalized decomposition into a centered term plus a
Birkhoff average. Here centering is pointwise compensation by an additive
majorant, not subtraction of an expectation. This layer deliberately stops
short of an asymptotic theorem. Finite phase averaging reindexes fixed-block
Birkhoff sums over every residue phase and, after positive-horizon
nonpositivity removes the two gap terms, bounds a centered value at horizon
`b * q + b + r` by a sliding Birkhoff sum with `b * q` starts. The
multiplication form remains total, but vacuous, at `b = 0`; division requires
positive block length. The phase proofs add no time-zero normalization,
measure-preservation, probability, or ergodicity hypothesis, although their
candidate and cocycle inputs retain the fields bundled by those interfaces.
They deliberately stop before a pointwise or mean Birkhoff theorem, Kingman's
subadditive ergodic theorem, interval packing, or any samplewise exponent claim.
-/
