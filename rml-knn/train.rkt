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

  [partition-and-classify
   (-> data-set? (real-in 1.0 50.0) exact-positive-integer? result-matrix?)]

  [cross-train
   (-> data-set? exact-positive-integer? exact-positive-integer? result-matrix?)]

  [standardize
   (-> data-set? (listof string?) data-set?)]

  [fuzzify
   (-> data-set? (listof string?) data-set?)]))

;; ---------- Requirements

(require rml/data
         rml/not-implemented
         rml/results)

;; ---------- Implementation

(define (partition-and-classify data-set partition-pc k)
  (let* ([partitioned (partition-for-test data-set partition-pc '())]
         [training (partition partitioned 'training)]
         [testing (partition partitioned 'testing)])
    (raise-not-implemented)))

(define (cross-train partitioned-data-set p k)
  (raise-not-implemented))

;; ---------- Implementation (Feature Transformation)

(define (standardize data-set features)
  ; z_{ij} = x_{ij}-μ_j / σ_j
  (raise-not-implemented))

(define (fuzzify data-set features)
  (raise-not-implemented))
