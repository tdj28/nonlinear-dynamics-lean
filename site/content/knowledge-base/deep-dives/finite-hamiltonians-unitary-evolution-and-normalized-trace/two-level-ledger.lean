import Std

/-!
A bounded Gaussian-integer worksheet for the two-level example in the paired
Deep Dive. It checks stored 2-by-2 arithmetic only. It does not implement the
analytic matrix exponential or prove a theorem over arbitrary complex
matrices.
-/

structure GaussianInt where
  re : Int
  im : Int
deriving Repr, DecidableEq

namespace GaussianInt

def zero : GaussianInt := ⟨0, 0⟩
def one : GaussianInt := ⟨1, 0⟩

def add (z w : GaussianInt) : GaussianInt :=
  ⟨z.re + w.re, z.im + w.im⟩

def mul (z w : GaussianInt) : GaussianInt :=
  ⟨z.re * w.re - z.im * w.im,
    z.re * w.im + z.im * w.re⟩

def conj (z : GaussianInt) : GaussianInt :=
  ⟨z.re, -z.im⟩

end GaussianInt

structure MatrixTwo where
  a11 : GaussianInt
  a12 : GaussianInt
  a21 : GaussianInt
  a22 : GaussianInt
deriving Repr, DecidableEq

namespace MatrixTwo

open GaussianInt

def add (A B : MatrixTwo) : MatrixTwo :=
  ⟨A.a11.add B.a11, A.a12.add B.a12,
    A.a21.add B.a21, A.a22.add B.a22⟩

def mul (A B : MatrixTwo) : MatrixTwo :=
  ⟨(A.a11.mul B.a11).add (A.a12.mul B.a21),
    (A.a11.mul B.a12).add (A.a12.mul B.a22),
    (A.a21.mul B.a11).add (A.a22.mul B.a21),
    (A.a21.mul B.a12).add (A.a22.mul B.a22)⟩

def dagger (A : MatrixTwo) : MatrixTwo :=
  ⟨A.a11.conj, A.a21.conj, A.a12.conj, A.a22.conj⟩

def identity : MatrixTwo :=
  ⟨one, zero, zero, one⟩

def hamiltonian : MatrixTwo :=
  ⟨⟨1, 0⟩, zero, zero, ⟨-1, 0⟩⟩

def generator (t : Int) : MatrixTwo :=
  ⟨⟨0, -t⟩, zero, zero, ⟨0, t⟩⟩

/-- The exact matrix `diag(-i, i)`, which is `exp (-i (π/2) H)` for the
displayed diagonal Hamiltonian. That analytic exponential identity is an
input to this bounded worksheet, not something `Std` proves here. -/
def quarterTurnEvolution : MatrixTwo :=
  ⟨⟨0, -1⟩, zero, zero, ⟨0, 1⟩⟩

def trace (A : MatrixTwo) : GaussianInt :=
  A.a11.add A.a22

end MatrixTwo

open MatrixTwo

#eval hamiltonian
#eval generator 2
#eval quarterTurnEvolution
#eval quarterTurnEvolution.dagger.mul quarterTurnEvolution
#eval hamiltonian.trace

example : MatrixTwo.add (generator 1) (generator 2) = generator 3 := by decide

example : quarterTurnEvolution.dagger.mul quarterTurnEvolution = identity := by decide

example : hamiltonian.trace = GaussianInt.zero := by decide

example : List.sum ([1, -1] : List Int) = 0 := by decide
