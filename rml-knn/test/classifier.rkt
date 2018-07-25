#lang racket
;;
;; Racket Machine Learning - k-NN.
;;
;; ~ Simon Johnston 2018.
;;

(require rackunit
         rml/data
         rml/individual
         rml/not-implemented
         rml/test/data-sets
         rml-knn/classifier)

(define iris
  (make-individual #:data-set iris-data-set
                   "sepal-length" 6.3
                   "sepal-width" 2.5
                   "petal-length" 4.9
                   "petal-width" 1.5
                   "classification" "Iris-versicolor"))
(define test-k 5)

(test-case
  "nearest-k: success results"
  (let ([results (nearest-k iris-data-set default-partition iris test-k)])
    (check-eq? test-k (length results))
    (check-eq? (second (first results)) 118)
    (check-equal? (third (first results)) '("Iris-virginica"))
    (check-eq? (second (fourth results)) 74)
    (check-equal? (third (fourth results)) '("Iris-versicolor"))))

(test-case
  "make-knn-classifier success result"
  (let ([classify (make-knn-classifier test-k)])
    (check-equal? '("Iris-virginica") (classify iris-data-set default-partition iris))))

(test-case
  "make-knn-classifier check contract"
  (let ([classify (make-knn-classifier test-k)])
    (check-exn exn:fail:contract?
      (λ () (classify iris iris-data-set)))))

(test-case
  "fuzzify: ensure not-implemented"
  (check-exn exn:fail:not-implemented?
    (λ () (fuzzify iris-data-set '()))))
