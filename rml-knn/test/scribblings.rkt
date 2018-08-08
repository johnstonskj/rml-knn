#lang racket
;;
;; Racket Machine Learning - k-NN.
;;
;;
;; ~ Simon Johnston 2018.

;; ---------- Requirements

(require
  rackunit
  rackunit/docs-complete)

;; ---------- Test Cases

(test-case
 "test for documentation completeness"
 (for ([module (list 'rml-knn/classifier)])
  (let ([s (open-output-string)])
      (parameterize ([current-error-port s])
        (check-docs module))
        (displayln (get-output-string s))
        (check-eq? (string-length (get-output-string s)) 0))))
