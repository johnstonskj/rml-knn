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
         rml/individual
         rml/not-implemented
         rml/results
         rml-knn/classify)

;; ---------- Implementation

(define (partition-and-classify data-set partition-pc k)
  (let* ([partitioned (partition-for-test data-set partition-pc '())]
         [training (partition partitioned 'training)]
         [testing (partition partitioned 'testing)]
         [results (make-result-matrix data-set)])
    (for ([row (in-producer (individuals data-set 0) no-more-individuals)])
      ;; TODO: we need to be able to deal with cross-product hash-refs!
      (record-result results (first (true-w row data-set)) (first (classify row data-set 5))))
    results))

(define (cross-train partitioned-data-set p k)
  (raise-not-implemented 'cross-train))

;; ---------- Implementation (Feature Transformation)

(define (standardize data-set features)
  ; z_{ij} = x_{ij}-μ_j / σ_j
  (raise-not-implemented 'standardize))

(define (fuzzify data-set features)
  (raise-not-implemented 'fuzzify))

;; ---------- Internal procedures

(define (true-w ind data-set)
  (map (λ (c) (hash-ref ind c)) (classifiers data-set)))
