#lang racket
;;
;; Racket Machine Learning - k-NN.
;;
;; Based upon the article:
;;   https://spin.atomicobject.com/2013/05/06/k-nearest-neighbor-racket/
;;
;; Algorith details:
;;   http://www.scholarpedia.org/article/K-nearest_neighbor
;;
;; ~ Simon Johnston 2018.


(provide
 (contract-out

  [standardize
   (-> data-set? (listof string?) data-set?)]

  [fuzzify
   (-> data-set? (listof string?) data-set?)]))

;; ---------- Requirements

(require rml/data rml/not-implemented)

;; ---------- Implementation

(define (standardize data-set features)
  ; z_{ij} = x_{ij}-μ_j / σ_j
  (raise-not-implemented 'standardize))

(define (fuzzify data-set features)
  (raise-not-implemented 'fuzzify))
