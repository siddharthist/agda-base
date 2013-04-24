{-# OPTIONS --without-K #-}

module category2.product.core where

open import level
open import sum
open import function.core
open import equality.core
open import category2.category
open import category2.graph
open import hott.hlevel

-- product of categories
-- for products *in* a category, see category2.limit
_⊗_ : ∀ {i j i' j'}
    → Category i j → Category i' j'
    → Category (i ⊔ i') (j ⊔ j')
C ⊗ D = mk-category record
  { obj = obj C × obj D
  ; hom = λ { (X , Y) (X' , Y')
            → hom X X' × hom Y Y' }
  ; id = λ _ → id , id
  ; _∘_ = λ { (f , f') (g , g') → (f ∘ g , f' ∘ g') }
  ; trunc = λ _ _ → ×-hlevel (trunc _ _) (trunc _ _)
  ; left-id = λ _ → cong₂ _,_ (left-id _) (left-id _)
  ; right-id = λ _ → cong₂ _,_ (right-id _) (right-id _)
  ; assoc = λ _ _ _ → cong₂ _,_ (assoc _ _ _) (assoc _ _ _) }
  where
    open as-category C
    open as-category D
