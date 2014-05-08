{-# OPTIONS --without-K #-}
module sets.list.core where

open import sum
import sets.vec.core as V
open import sets.nat.core

List : Set → Set
List A = Σ ℕ (V.Vec A)

module _ {A : Set} where
  vec-to-list : ∀ {n} → V.Vec A n → List A
  vec-to-list {n} xs = n , xs

  [] : List A
  [] = 0 , V.[]

  infixr 4 _∷_
  _∷_ : A → List A → List A
  x ∷ (n , xs) = suc n , x V.∷ xs
