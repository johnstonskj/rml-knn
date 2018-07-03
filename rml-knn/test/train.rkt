#lang racket
;;
;; Racket Machine Learning - k-NN.
;;
;; ~ Simon Johnston 2018.
;;

(require rackunit
         rml/data
         rml/not-implemented
         rml-knn/train)

(define dataset
  (load-data-set
    (path->string (collection-file-path "test/simple-test.json" "rml-knn"))
    'json
    (list (make-feature "height") (make-classifier "class"))))

(test-case
  "partition-and-classify: ensure not-implemented"
  (check-exn exn:fail:not-implemented?
    (λ () (partition-and-classify dataset 25.0 5))))

(test-case
  "cross-train: ensure not-implemented"
  (check-exn exn:fail:not-implemented?
    (λ () (cross-train dataset 5 5))))

(test-case
  "standardize: ensure not-implemented"
  (check-exn exn:fail:not-implemented?
    (λ () (standardize dataset '()))))

(test-case
  "fuzzify: ensure not-implemented"
  (check-exn exn:fail:not-implemented?
    (λ () (fuzzify dataset '()))))
