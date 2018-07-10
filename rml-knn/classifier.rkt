#lang racket
;;
;; Racket Machine Learning - k-NN.
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

  [make-knn-classifier
   (-> exact-positive-integer? classifier/c)]

  [nearest-k
   (-> data-set? individual? exact-positive-integer? list?)]

  [fuzzify
   (-> data-set? (listof string?) data-set?)]))

;; ---------- Requirements

(require rml/data
         rml/classify
         rml/individual
         rml/not-implemented)

;; ---------- Implementation

(define (make-knn-classifier k)
  (λ (data-set data-item)
    (reduce (nearest-k data-set data-item k))))

(define (nearest-k data-set data-item k)
  (take
   (sort
    (for/list ([item-index (data-count data-set)])
      (classify-distance data-item data-set 'default item-index))
    #:key first <)
   k))

(define (fuzzify data-set features)
  (raise-not-implemented 'fuzzify))

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
