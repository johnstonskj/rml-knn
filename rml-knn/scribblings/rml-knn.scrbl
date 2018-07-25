#lang scribble/manual

@(require racket/sandbox
          scribble/eval
          (for-label rml/data
                     rml/individual
                     rml/classify
                     rml/results
                     rml-knn/classifier
                     racket/contract))

@;{============================================================================}

@(define example-eval (make-base-eval
                      '(require rml/data rml/individual rml/results rml/not-implemented)))

@;{============================================================================}
@title[#:tag "ml" #:version "1.0"]{Racket Machine Learning - K-Nearest Neighbors}
@author[(author+email "Simon Johnston" "johnstonskj@gmail.com")]

This package provides an implementation of the @italic{k}-Nearest Neighbors
algorithm for classification. It provides both a straightforward @italic{classifier}
function that takes a data set and an individual and returns the set of predicted
classifier values for that individual.

The classifier function provided by this module can be used by the higher-order
classification functions @racket[classify], @racket[cross-classify], and
@racket[partitioned-test-classify] provided by the package @racket[rml-core].

For more information on the @italic{k}-NN algorithm, see
@hyperlink["https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm" "Wikipedia"]
and @hyperlink["http://www.scholarpedia.org/article/K-nearest_neighbor" "Scholar"].


@;{============================================================================}
@;{============================================================================}
@section[]{Module rml-knn/classifier}
@defmodule[rml-knn/classifier]

This package contains the procedures that implement the @italic{k}-NN classifier
itself. The classifier function returned from @racket[make-knn-classifier] will
in turn provide a list of classifiervalues predicted for an individual. Alternately,
the @racket[nearest-k] function will provide the set of closest neighbors that
the @italic{classifier} uses.

@examples[ #:eval example-eval
(require rml/data rml/individual rml-knn/classifier)
(define iris-data
  (load-data-set (path->string (collection-file-path
                                 "test/iris_training_data.csv" "rml"))
                 'csv
                 (list
                   (make-feature "sepal-length" #:index 0)
                   (make-feature "sepal-width" #:index 1)
                   (make-feature "petal-length" #:index 2)
                   (make-feature "petal-width" #:index 3)
                   (make-classifier "classification" #:index 4))))

(define an-iris
  (make-individual #:data-set iris-data
                   "sepal-length" 6.3
                   "sepal-width" 2.5
                   "petal-length" 4.9
                   "petal-width" 1.5
                   "classification" "Iris-versicolor"))
(define classify (make-knn-classifier 5))
(classify iris-data default-partition an-iris)
]

The code block above demonstrates the classifier by constructing an @racket[individual]
and classifying it against the loaded @racket[data-set]. Note that in this example the
classifier returned @italic{Iris-virginica}, whereas the individual was labeled as
@italic{Iris-versicolor}.

@defproc[#:kind "constructor"
         (make-knn-classifier
          [k exact-positive-integer?])
         classifier/c]{
This procedure will produce a classifier function that conforms to the @racket[classifier/c]
contract. The resulting function returns a list of classifier values predicted for the
provided @racket[individual] based on the @racket[k]-nearest neighbors in @racket[dataset].
}

@defproc[(nearest-k
          [dataset data-set?]
          [partition exact-nonnegative-integer?]
          [individual individual?]
          [k exact-positive-integer?])
         list?]{
This procedure will return the @racket[k] nearest neighbors to the provided
@racket[individual] in @racket[dataset].
}

@;{============================================================================}
@subsection[]{Data Transformations}

@defproc[#:kind "transform"
         (fuzzify
          [features (listof string?)])
         data-set?]{
Attempts to improve the accuracy of classification by mapping values into membership
sets. This is sometimes known as Fuzzy @italic{k}-Nearest Neighbors, or F@italic{k}NN

From @hyperlink["http://www.scholarpedia.org/article/K-nearest_neighbor" "Scholarpedia"]}:

@italic{… is a transformation which exploits uncertainty in feature values in order to
increase classification performance. Fuzzification replaces the original features by
mapping original values of an input feature into 3 fuzzy sets representing linguistic
membership functions in order to facilitate the semantic interpretation of each fuzzy set}
}
