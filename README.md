# Racket Machine Learning - *k*-Nearest Neighbor

[![GitHub release](https://img.shields.io/github/release/johnstonskj/rml-knn.svg?style=flat-square)](https://github.com/johnstonskj/rml-knn/releases)
[![Travis Status](https://travis-ci.org/johnstonskj/rml-knn.svg)](https://www.travis-ci.org/johnstonskj/rml-knn)
[![Coverage Status](https://coveralls.io/repos/github/johnstonskj/rml-knn/badge.svg?branch=master)](https://coveralls.io/github/johnstonskj/rml-knn?branch=master)
[![raco pkg install rml-core](https://img.shields.io/badge/raco%20pkg%20install-rml--knn-blue.svg)](http://pkgs.racket-lang.org/package/rml-knn)
[![Documentation](https://img.shields.io/badge/raco%20docs-rml--knn-blue.svg)](http://docs.racket-lang.org/rml-knn/index.html)
[![GitHub stars](https://img.shields.io/github/stars/johnstonskj/rml-core.svg)](https://github.com/johnstonskj/rml-core/stargazers)
![MIT License](https://img.shields.io/badge/license-MIT-118811.svg)

This package implements a *k*-NN approach for the Racket Machine Learning
package set, based on an article by 
[Tony Baker](https://spin.atomicobject.com/2013/05/06/k-nearest-neighbor-racket/). 
The `classifier` module provides a relatively simple classification approach by
determining the Euclidean distance between an individual and a set of pre-
classified training data. This package relies on the 
[rml-core](https://github.com/johnstonskj/rml-core) package and provides a
*classifier* for use with the `rml/classify` module.



# Modules

* `classifier` - Support for classifying an individual against a trained data set.

# Examples

```scheme
(require rml/data
         rml/individual
         rml/results 
         rml-knn/classifier)

; construct dataset ...

(define iris (make-individual "sepal-length" 6.3
                              "sepal-width" 2.5
                              "petal-length" 4.9
                              "petal-width" 1.5
                              "classification" "Iris-versicolor"))

(define C (make-result-matrix dataset))

(record-result C
  (hash-ref iris "classification")
  (first ((make-knn-classifier 5) dataset iris)))
```

The function `make-knn-classifier` returns the classification function 
itself, this conforms to the `classifier/c` contract from the `rml/classify` 
module.

[![Racket Langaueg](https://racket-lang.org/logo-and-text-1-2.png)](https://racket-lang.org/)
