import NonlinearDynamics.Random.RandomCocycles.Discrete
import NonlinearDynamics.Random.RandomCocycles.NormObservables
import NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability
import NonlinearDynamics.Random.RandomCocycles.IntegratedLogPlusGrowth
import NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase
import NonlinearDynamics.Random.RandomCocycles.SubadditiveFiniteBlocks
import NonlinearDynamics.Random.RandomCocycles.SubadditiveCentering

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
before a pointwise Birkhoff theorem, Kingman's theorem, or any samplewise
exponent claim.
-/
