{-# OPTIONS --without-K #-}
module function.extensionality.dependent where

open import level using (_⊔_; ↑; lift)
open import sets.unit
open import sum
open import equality.core
open import equality.calculus
open import function.core using (_∘'_; const)
open import function.extensionality.core
open import function.extensionality.nondep

open import hott.hlevel.core
open import hott.hlevel.properties

abstract
  ext₀' : ∀ {i j} → Extensionality' i j
  ext₀' {i} {j} {X = X} {Y = Y} {f}{g} h = cong (λ u → proj₁ ∘' u) p
    where
      U : (x : X) → Set j
      U x = singleton (f x)

      U-contr : contr ((x : X) → U x)
      U-contr = Π-contr (λ x → singl-contr (f x))

      f* : (x : X) → U x
      f* x = f x , refl

      g* : (x : X) → U x
      g* x = g x , h x

      p : f* ≡ g*
      p = contr⇒prop U-contr f* g*

abstract
  ext' : ∀ {i j} → Extensionality' i j
  ext' h = ext₀' h ⊚ ext₀' (λ _ → refl) ⁻¹

  ext-id' : ∀ {i j}{X : Set i}{Y : X → Set j}
          → (f : (x : X) → Y x)
          → ext' {f = f} {f} (λ _ → refl) ≡ refl
  ext-id' f = left-inverse (ext₀' (λ _ → refl))