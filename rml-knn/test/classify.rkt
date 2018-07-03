#lang racket
;;
;; Racket Machine Learning - k-NN.
;;
;; ~ Simon Johnston 2018.
;;

(require rackunit
         rml/data
         rml/individual
         rml/results
         rml-knn/classify)

(define dataset
  (load-data-set "iris_training_data.csv"
                 'csv
                 (list
                   (make-feature "sepal-length" #:index 0)
                   (make-feature "sepal-width" #:index 1)
                   (make-feature "petal-length" #:index 2)
                   (make-feature "petal-width" #:index 3)
                   (make-classifier "classification" #:index 4))))

(define iris
  (make-individual #:data-set dataset
                   "sepal-length" 6.3
                   "sepal-width" 2.5
                   "petal-length" 4.9
                   "petal-width" 1.5
                   "classification" "Iris-versicolor"))

(test-case
  "nearest-k: success results"
  (let ([results (nearest-k iris dataset 5)])
    (check-eq? 5 (length results))
    (check-eq? 118 (second (first results)))
    (check-equal? '("Iris-virginica") (third (first results)))
    (check-eq? 74 (second (fourth results)))
    (check-equal? '("Iris-versicolor") (third (fourth results)))))

(test-case
  "classify: success result"
  (check-equal? '("Iris-virginica") (classify iris dataset 5)))
