#lang scribble/manual

@(require racket/sandbox
          scribble/eval
          (for-label rml/data
                     rml/results
                     rml-knn/classify
                     rml-knn/train
                     racket/contract))

@;{============================================================================}

@(define example-eval (make-base-eval
                      '(require rml/data rml/individual rml/results rml/not-implemented)))

@;{============================================================================}
@title[#:tag "ml" #:version "1.0"]{Racket Machine Learning - K-Nearest Neighbors}
@author[(author+email "Simon Johnston" "johnstonskj@gmail.com")]

This package provides an implementation of the @italic{k}-Nearest Neighbors
algorithm for classification. It provides both a straightforward @racket[classify]
procedure that takes an individual and returns the set of predicted classifiers
for that individual.

For more information on the @italic{k}-NN algorithm, see
@hyperlink["https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm" "Wikipedia"]
and @hyperlink["http://www.scholarpedia.org/article/K-nearest_neighbor" "Scholar"].

@table-of-contents[]

@;{============================================================================}
@;{============================================================================}
@section[]{Package rml-knn/classify}
@defmodule[rml-knn/classify]

This package contains the procedures that implement the @italic{k}-NN classifier
itself. The @racket[classify] will return a list of classifiers predicted for
an individual, the @racket[nearest-k] procedure will provide the set of closest
neighbors that @racket[classify] uses.

@examples[ #:eval example-eval
(require rml/data rml/individual rml-knn/classify)
(define iris-data
  (load-data-set "test/iris_training_data.csv"
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
(classify an-iris iris-data 5)
]

The code block above demonstrates the classifier by constructing an @racket[individual]
and classifying it against the loaded @racket[data-set]. Note that in this example the
classifier returned @italic{Iris-virginica}, whereas the individual was labeled as
@italic{Iris-versicolor}.

@defproc[#:kind "classify"
         (classify
           [individual individual?]
           [dataset data-set?]
           [k exact-positive-integer?])
         list?]{
This procedure will return a list of classifier values predicted for the provided
@racket[individual] based on the @racket[k] nearest neighbors in @racket[dataset].
}

@defproc[#:kind "classify"
         (nearest-k
           [individual individual?]
           [dataset data-set?]
           [k exact-positive-integer?])
         list?]{
This procedure will return the @racket[k] nearest neighbors to the provided
@racket[individual] in @racket[dataset].
}

@;{============================================================================}
@;{============================================================================}
@section[]{Package rml-knn/train}
@defmodule[rml-knn/train]

While the @italic{k}-NN method does not necessarily learn, and therefore require
explicit training, it is useful to be able to perform specific testing and training
operations to validate the effectiveness of features in predicting the correctly
classifiers for test data.

Examples: TBD

@;{============================================================================}
@subsection[]{Training}

@defproc[#:kind "train"
         (partition-and-classify
           [dataset data-set?]
           [train-percentage (real-in 1.0 50.0)]
           [k exact-positive-integer?])
         result-matrix?]{
This form of training uses the @racket[partition-for-test] procedure to create two
partitions, a training data partition and a test data partition. It then classifies
all the individuals in the test partition against the training partition and records
the results in a @racket[result-matrix]. The result matrix can be inspected to determine
the accuracy of the classifier.
}

@defproc[#:kind "train"
         (cross-train
           [dataset data-set?]
           [p exact-positive-integer?]
           [k exact-positive-integer?])
         result-matrix?]{
This form of training uses the @racket[partition-equally] procedure to create
@racket[p] partitions. Each partition is then classified against all the others and
the results are collated into a single @racket[result-matrix]. The result matrix
can be inspected to determine the accuracy of the classifier.
}

@;{============================================================================}
@subsection[]{Preparation and Transformations}

@defproc[#:kind "transform"
         (standardize
           [features (listof string?)])
         data-set?]{
Standardization requires statistics be computed for all features listed in
@racket[features], and will normalize the values to reduce the effect of large
outlyer values and enable more efficient distance measures.

From @hyperlink["http://www.scholarpedia.org/article/K-nearest_neighbor" "Scholarpedia"]}:

@italic{… removes scale effects caused by use of features with different measurement
scales. For example, if one feature is based on patient weight in units of kg and
another feature is based on blood protein values in units of ng/dL in the range
[-3,3], then patient weight will have a much greater influence on the distance
between samples and may bias the performance of the classifier. Standardization
transforms raw feature values into z-scores using the mean and standard deviation
of a feature values over all input samples}
}

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
