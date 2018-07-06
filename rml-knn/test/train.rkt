#lang racket
;;
;; Racket Machine Learning - k-NN.
;;
;; ~ Simon Johnston 2018.
;;

(require rackunit
         rml/data
         rml/not-implemented
         rml/results
         rml-knn/train)

(define iris-data-set
  (load-data-set (path->string (collection-file-path "test/iris_training_data.csv" "rml"))
                 'csv
                 (list
                   (make-feature "sepal-length" #:index 0)
                   (make-feature "sepal-width" #:index 1)
                   (make-feature "petal-length" #:index 2)
                   (make-feature "petal-width" #:index 3)
                   (make-classifier "classification" #:index 4))))

(test-case
  "partition-and-classify: ensure not-implemented"
  (let ([results (partition-and-classify iris-data-set 25.0 5)])
    (check-eq? (result-value results "Iris-virginica" "Iris-virginica") 45)
    (check-eq? (result-value results "Iris-versicolor" "Iris-virginica") 1)
    (check-eq? (result-value results "Iris-versicolor" "Iris-versicolor") 44)
    (check-eq? (result-value results "Iris-setosa" "Iris-setosa") 45)))

(test-case
  "cross-train: ensure not-implemented"
  (check-exn exn:fail:not-implemented?
    (λ () (cross-train iris-data-set 5 5))))

(test-case
  "standardize: ensure not-implemented"
  (check-exn exn:fail:not-implemented?
    (λ () (standardize iris-data-set '()))))

(test-case
  "fuzzify: ensure not-implemented"
  (check-exn exn:fail:not-implemented?
    (λ () (fuzzify iris-data-set '()))))
