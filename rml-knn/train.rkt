#lang racket
;;
;; Racket Machine Learning - K-NN.
;;
;; Based upon the article:
;;   https://spin.atomicobject.com/2013/05/06/k-nearest-neighbor-racket/
;;
;; Algorith details:
;;   http://www.scholarpedia.org/article/K-nearest_neighbor
;;
;; ~ Simon Johnston 2018.


(provide
 (contract-out

  [partition-and-classify
   (-> data-set? (real-in 1.0 50.0) exact-positive-integer? list?)]

  [cross-train
   (-> data-set? exact-positive-integer? list?)]))

;; ---------- Requirements

(require rml/notimplemented
         rml/data
         math/array)

;; ---------- Implementation

(define (partition-and-classify data-set partition-pc k)
  (let* ([partitioned (partition-for-test data-set partition-pc)]
         [training (partition partitioned 'training)]
         [testing (partition partitioned 'testing)])
    (raise-not-implemented)))

(define (cross-train partitioned-data-set k)
  (raise-not-implemented))
