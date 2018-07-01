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

  [nearest-k
   (-> hash? data-set? exact-positive-integer? list?)]

  [classify
   (-> hash? data-set? exact-positive-integer? list?)]))

;; ---------- Requirements

(require rml/notimplemented
         rml/data
         math/array)

;; ---------- Implementation

(define (nearest-k data-item data-set k)
  (take
   (sort
    (for/list ([item-index (data-count data-set)])
      (classify-distance data-item data-set 'default item-index))
    #:key first <)
   k))

(define (classify data-item data-set k)
  (reduce (nearest-k data-item data-set k)))

;; ---------- Internal procedures

(define (classify-distance sample data-set partition-index value-index)
  (list
   (sqrt
    (apply +
           (for/list ([feature (features data-set)])
             (let ([fvector (feature-vector data-set partition-index feature)])
               (expt (- (hash-ref sample feature) (vector-ref fvector value-index)) 2)))))
   value-index
   (for/list ([classifier (classifiers data-set)])
     (let ([cvector (feature-vector data-set partition-index classifier)])
       (vector-ref cvector value-index)))))

(define (reduce results)
  (second
   (first
    (sort
     (hash-map
      (foldl (lambda (e ht)
               (hash-update ht (list-ref e 2) add1 (lambda () 0)))
             (hash)
             results)
      (lambda (k v) (list v k)))
     #:key first >))))
