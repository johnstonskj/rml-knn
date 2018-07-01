#lang racket
;;
;; Racket Machine Learning - K-NN.
;;
;; ~ Simon Johnston 2018.
;;

(require rml/data)
(require math/statistics)

(define dataset
  (load-data-set "simple-test.json" 'json (list (make-feature "height") (make-classifier "class"))))

(define stats (feature-statistics dataset "height"))
(displayln (statistics-min stats))
(displayln (statistics-max stats))
(displayln (statistics-mean stats))
(displayln (statistics-variance stats))
(displayln (statistics-stddev stats))
(displayln (statistics-skewness stats))
(newline)

(write-snapshot dataset (current-output-port))
(newline)

(require "../classify.rkt")

(classify (hash "height" 199 "class" "m") dataset 5)
