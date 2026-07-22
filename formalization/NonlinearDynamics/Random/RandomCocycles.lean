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
import NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoffLimit
import NonlinearDynamics.Random.RandomCocycles.ErgodicBirkhoffLimit
import NonlinearDynamics.Random.RandomCocycles.SubadditiveUpperLimsup
import NonlinearDynamics.Random.RandomCocycles.SubadditiveBadBlockMeasure
import NonlinearDynamics.Random.RandomCocycles.SubadditiveAllLengthBadBlockMeasure
import NonlinearDynamics.Random.RandomCocycles.SubadditiveLowerDeviation
import NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman
import NonlinearDynamics.Random.RandomCocycles.RealLogNormIntegrability
import NonlinearDynamics.Random.RandomCocycles.RealLogNormKingman

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
almost-everywhere convergence for every integrable observable. An
identification layer then chooses one total invariant limit representative,
proves orbit and average uniform integrability, upgrades pointwise convergence
to `L¹`, and matches integrals on every exactly invariant measurable set.
Conditional-expectation uniqueness identifies the full-sequence limit with
the conditional expectation onto `MeasurableSpace.invariants T`. This theorem
still needs neither probability normalization nor ergodicity, and it does not
assume the base map is injective, surjective, or invertible. An additive
specialization then uses the pre-ergodic rigidity component to make this target
almost everywhere constant. On a finite nonzero measure it is the normalized
integral average; on a probability measure it is the ordinary integral. Full
ergodicity supplies measure preservation only when this identification is
combined with the pointwise theorem. The specialization adds no bijectivity,
mixing, or powered-map hypothesis. A final one-sided asymptotic layer combines
finite phase averaging with the ordinary ergodic Birkhoff theorem to bound the
almost-everywhere normalized upper limsup of every nonnegative integrable
shifted-subadditive candidate by every normalized positive-block integral.
For cocycle log-positive growth, taking the infimum over blocks gives the
deterministic integrated Fekete rate. The Birkhoff averages remain along the
original base map, so no ergodicity of a powered map is assumed. This is only
Kingman's upper-bound half. A complementary finite bad-block layer counts
visits to strict centered sublevel sets, selects one bounded witness length at
each marked start, invokes the ordered greedy packing, and integrates the
result under finite measure and preservation. It bounds each finite bad-block
set by a centered integral-rate ratio and specializes that ratio to the
log-positive cocycle Fekete offset without assuming probability or ergodicity.
The increasing union over all finite length caps then records the existence of
one strict bad block at some positive length. Extended measures converge to
the union without a finiteness premise; real measures require an explicit
finite-mass gate, after which the same uniform ratio passes to the union. The
raw once-bad event is not generally invariant, as a finite measure-preserving
countermodel records. This layer still proves neither a lower liminf nor
samplewise convergence, equality with the integrated rate, limit
integrability, a Lyapunov exponent, or an Oseledets splitting. A countably
generated lower-deviation layer then strengthens one finite witness to
positive witnesses beyond every cutoff at one rational slope below the target.
Centered subadditivity gives a threshold-relaxed preimage inclusion; rational
density closes it at the target event. Preservation and finite mass upgrade
that one-sided inclusion to almost invariance, finite-measure ergodicity gives
the null-or-conull fork, and probability normalization lets the strict RMT-31
ratio select the null branch. The cocycle endpoint uses the reusable centered
Fekete-offset lower bound and retains the empty matrix-index boundary. A final
real-liminf layer then identifies the exact guarded bridge from those rational
events, uses a second countable rational exhaustion to obtain the
almost-everywhere lower bound, and adds back the convergent one-step Birkhoff
average.
For the log-positive cocycle process, that lower liminf and the earlier upper
limsup squeeze the normalized sequence to the integrated Fekete rate almost
everywhere. Every real-liminf and real-limsup boundedness gate remains explicit,
and that theorem still proves no signed logarithmic limit, limit-integral
interchange, Lyapunov exponent, or Oseledets splitting. A finite signed layer
then defines the total real logarithmic norm, propagates pointwise generator
invertibility to every cocycle value, and uses the forward-orbit sum of
inverse-generator log-positive norms as a negative-tail majorant. An explicit
two-sided one-step integrability package makes every finite real-log observable
integrable and packages the family as a shifted-subadditive candidate. The
extended-to-real logarithm bridge alone requires nonempty matrix dimension;
the real subadditivity, inverse-tail sandwich, integrability, and candidate
remain dimension-uniform through explicit empty branches. Independently,
strictly positive log-positive growth forces eventual agreement with the real
logarithm and hence almost-everywhere normalized real-log convergence without
invertibility or inverse-tail integrability. The empty-dimensional instance of
that last statement is vacuous because its strict positive-rate premise cannot
hold. A signed Fekete layer then integrates the real logarithmic norm, derives
subadditivity under two-sided generator-tail integrability, and uses the
inverse-generator integral as a finite linear lower bound. The resulting
normalized signed integrals converge to their positive-horizon infimum. On a
pre-ergodic probability base, the generic lower-deviation rail supplies the
samplewise lower liminf, while the generalized phase-averaging upper theorem
uses an actual eventual lower bound supplied by the inverse-generator
Birkhoff rail. Their squeeze proves almost-everywhere normalized signed
real-log convergence to the deterministic Fekete rate, including rate zero in
empty dimension. Strictly positive log-positive growth identifies the signed
and log-positive rates afterward by uniqueness of samplewise limits, not by
interchanging a limit and an integral. This layer proves no `L¹` convergence,
uniform integrability, limit-integral interchange, convergence rate,
concentration estimate, inverse-cocycle exponent identity, singular-value or
conorm limit, Lyapunov spectrum, invariant splitting, Oseledets theorem,
derivative-cocycle theorem, or stable-manifold theorem.
-/
