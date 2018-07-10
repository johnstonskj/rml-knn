#lang racket
;;
;; Racket Machine Learning - k-NN.
;;
;; ~ Simon Johnston 2018.
;;

(require rackunit
         rml/not-implemented
         rml/test/data-sets
         rml-knn/train)

(test-case
  "standardize: ensure not-implemented"
  (check-exn exn:fail:not-implemented?
    (λ () (standardize iris-data-set '()))))

(test-case
  "fuzzify: ensure not-implemented"
  (check-exn exn:fail:not-implemented?
    (λ () (fuzzify iris-data-set '()))))
