#lang scribble/manual

@(require racket/sandbox
          scribble/eval
          (for-label rml-knn/classify
                     rml-knn/train
                     racket/contract))

@;{============================================================================}
@title[#:tag "ml" #:version "1.0"]{Racket Machine Learning - K-Nearest Neighbors}
@author[(author+email "Simon Johnston" "johnstonskj@gmail.com")]

This package provides an implementation of the @italic{K-Nearest Neighbors}
algorithm for classification.

You can view the source on @hyperlink[
  "https://github.com/johnstonskj/rml-knn"
  "GitHub"].

@table-of-contents[]

@;{============================================================================}
@;{============================================================================}
@section[]{Package rml-knn/classify}
@defmodule[rml-knn/classify]

Package Description Here

@defproc[#:kind "classify"
         (classify
           [individual hash?]
           [dataset data-set?]
           [k exact-positive-integer?])
         list?]{
TBD
}

@defproc[#:kind "classify"
         (nearest-k
           [individual hash?]
           [dataset data-set?]
           [k exact-positive-integer?])
         list?]{
TBD
}

@;{============================================================================}
@;{============================================================================}
@section[]{Package rml-knn/train}
@defmodule[rml-knn/train]

Package Description Here

@defproc[#:kind "train"
         (partition-and-classify
           [dataset data-set?]
           [train-percentage (real-in 1.0 50.0)]
           [k exact-positive-integer?])
         list?]{
TBD
}

@defproc[#:kind "train"
         (cross-train
           [dataset data-set?]
           [k exact-positive-integer?])
         list?]{
TBD
}
