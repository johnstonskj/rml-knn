#lang info
;;
;; Racket Machine Learning - Core.
;;
;; ~ Simon Johnston 2018.
;;

(define collection 'multi)

(define pkg-desc "Racket Machine Learning - K-Nearest Neighbor")
(define version "1.0")
(define pkg-authors '(johnstonskj))

(define deps '(
  "base"
  "rml-core"
  "math-lib"))
(define build-deps '(
  "scribble-lib"
  "racket-doc"
  "sandbox-lib"
  "cover-coveralls"))
