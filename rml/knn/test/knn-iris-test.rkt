#lang racket
;;
;; Racket Machine Learning - K-NN.
;;
;; ~ Simon Johnston 2018.
;;

(require rml/data)

(define dataset
  (load-data-set "iris_training_data2.csv"
                 'csv
                 (list
                   (make-feature "sepal-length" #:index 0)
                   (make-feature "sepal-width" #:index 1)
                   (make-feature "petal-length" #:index 2)
                   (make-feature "petal-width" #:index 3)
                   (make-classifier "classification" #:index 4))))

;(write-snapshot dataset (current-output-port))
;(newline)

;(displayln (feature-statistics dataset "sepal-width"))
;(newline)

(displayln (classifier-product dataset))
(newline)

(require rml/results "../classify.rkt")

(define iris (hash "sepal-length" 6.3 "sepal-width" 2.5 "petal-length" 4.9 "petal-width" 1.5 "classification" "Iris-versicolor"))

(displayln (nearest-k iris dataset 5))
(newline)

(define C (make-result-matrix dataset))
(record-result C (hash-ref iris "classification") (first (classify iris dataset 5)))
(newline)

(for ([row (result-matrix C)]) (displayln row))
