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

(test-case
  "nearest-k: success results"
  (let ([results (nearest-k iris-data-set iris 5)])
    (check-eq? 5 (length results))
    (check-eq? 118 (second (first results)))
    (check-equal? '("Iris-virginica") (third (first results)))
    (check-eq? 74 (second (fourth results)))
    (check-equal? '("Iris-versicolor") (third (fourth results)))))

(test-case
  "make-knn-classifier success result"
  (let ([classify (make-knn-classifier 5)])
    (check-equal? '("Iris-virginica") (classify iris-data-set iris))))

(test-case
  "fuzzify: ensure not-implemented"
  (check-exn exn:fail:not-implemented?
    (λ () (fuzzify iris-data-set '()))))
