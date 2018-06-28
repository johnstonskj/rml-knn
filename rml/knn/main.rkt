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
   (-> hash? data-set? exact-positive-integer? list?)]

  [partition-and-classify
   (-> data-set? (real-in 1.0 50.0) exact-positive-integer? list?)]

  [cross-train
   (-> data-set? exact-positive-integer? list?)]

  [make-result-matrix
   (-> data-set? confusion-matrix?)]

  [record-result
   (-> confusion-matrix? any/c any/c confusion-matrix?)]

  [result-matrix
   (-> confusion-matrix? list?)]))

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

(define (partition-and-classify data-set partition-pc k)
  (let* ([partitioned (partition-for-test data-set partition-pc)]
         [training (partition partitioned 'training)]
         [testing (partition partitioned 'testing)])
    (raise-not-implemented)))

(define (cross-train partitioned-data-set k)
  (raise-not-implemented))

(define (make-result-matrix data-set)
  (let* ([values (classifier-product data-set)]
         [Ω (length values)])
    (confusion-matrix
     (make-hash (for/list ([i (length values)]) (cons (list-ref values i) i)))
     Ω
     (apply vector (for/list ([i (range Ω)]) (make-vector Ω))))))

(define (record-result C true-ω predicted-ω)
  (let ([true-i (hash-ref (confusion-matrix-values C) true-ω)]
        [predicted-i (hash-ref (confusion-matrix-values C) predicted-ω)])
    (vector-set! (vector-ref (confusion-matrix-results C) true-i)
                  predicted-i
                  (add1 (vector-ref (vector-ref (confusion-matrix-results C) true-i) predicted-i))))
  C)

(define (result-matrix C)
  (let ([labels (make-hash (hash-map (confusion-matrix-values C) (lambda (k v) (cons v k))))])
    (list*
      (list* "true ω pred" (for/list ([i (range (hash-count labels))]) (hash-ref labels i)))
      (for/list ([i (range (hash-count labels))])
        (list* (list* (hash-ref labels i))
          (vector->list (vector-ref (confusion-matrix-results C) i)))))))

;; ---------- Internal types

(struct confusion-matrix
  (values
   Ω
   results))

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
