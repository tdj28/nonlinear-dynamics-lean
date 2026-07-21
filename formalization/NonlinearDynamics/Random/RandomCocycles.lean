import NonlinearDynamics.Random.RandomCocycles.Discrete
import NonlinearDynamics.Random.RandomCocycles.NormObservables
import NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability
import NonlinearDynamics.Random.RandomCocycles.IntegratedLogPlusGrowth

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
and without an almost-sure or Lyapunov conclusion.
-/
