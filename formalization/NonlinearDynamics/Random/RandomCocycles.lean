import NonlinearDynamics.Random.RandomCocycles.Discrete
import NonlinearDynamics.Random.RandomCocycles.NormObservables
import NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability
import NonlinearDynamics.Random.RandomCocycles.IntegratedLogPlusGrowth
import NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase
import NonlinearDynamics.Random.RandomCocycles.SubadditiveFiniteBlocks
import NonlinearDynamics.Random.RandomCocycles.SubadditiveCentering
import NonlinearDynamics.Random.RandomCocycles.SubadditivePhaseAveraging
import NonlinearDynamics.Random.RandomCocycles.SubadditiveIntervalPacking
import NonlinearDynamics.Random.RandomCocycles.BirkhoffConvergence
import NonlinearDynamics.Random.RandomCocycles.FiniteHopfMaximal
import NonlinearDynamics.Random.RandomCocycles.InfiniteHopfMaximal
import NonlinearDynamics.Random.RandomCocycles.KoopmanL2Mean
import NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoff

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
An ordered interval-packing layer then encodes positive-length half-open
natural intervals by successive gaps, chooses a left-to-right disjoint cover
of finitely many marked starts inside an enlarged horizon, and turns weak or
strict per-start estimates into finite marked-cardinality bounds. At positive
enlarged horizon, the empty marked set retains only the weak conclusion; the
strict conclusion requires a marked start and derives horizon positivity.
The next layer isolates the event where real Birkhoff averages converge. It
proves finite-horizon measurability and integrability, invariance of that event
under adding or deleting one orbit prefix, and conditional null/conull and
probability zero-one consequences under the appropriate ergodic hypotheses.
It also specializes the event to the one-step subadditive-process observable
and to the cocycle generator's log-positive norm without claiming that either
event has full measure. A finite Hopf-style layer next maximizes Birkhoff sums
through a fixed horizon, proves that the integral of the observable over the
strict positivity event is nonnegative, and derives an average-exceedance
integral inequality at every real threshold. This needs neither finite total
mass nor probability for the core theorem, and no positivity assumption on
the threshold for the finite-measure corollary. The increasing union of those
finite events next gives the positive-time infinite exceedance event. Measure
preservation and one-step integrability make it null measurable without a
finite-mass assumption. Continuity from below is exposed unconditionally for
extended nonnegative real measure; under finite total mass, it yields an
infinite weak maximal bound. The real-measure corollary exposes finiteness
because `Measure.real` totalizes infinite mass to zero. A real `L²` Koopman
layer then constructs the fixed subspace and orthogonal projection, proves von
Neumann mean convergence, and builds a dense set of fixed vectors plus
simple-function coboundaries whose chosen representatives have almost-everywhere
convergent pointwise averages. Norm convergence is kept distinct from
full-sequence pointwise convergence: in general it supplies only an
almost-everywhere convergent subsequence. On a finite-measure base, the weak
maximal estimate then closes this dense pointwise-good core in real `L¹`:
fixed-scale Cauchy failures are null, reciprocal natural scales make the
argument countable, and completeness of the reals gives full-sequence
almost-everywhere convergence for every integrable observable. This final
convergence theorem needs neither probability normalization nor ergodicity and
does not identify the limit. These layers deliberately stop before
conditional-expectation identification, Kingman's subadditive ergodic theorem,
or a samplewise exponent claim.
-/
