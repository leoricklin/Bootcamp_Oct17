RECOMMENDER SYSTEMS WITH TENSORFLOW
===================================

 

Abstract
--------

 

These are the lab materials which were original created for the "Deep Learning
for Recommender Systems" tutorial for the Strata Data Conference. They will also
be used for Teradata AI acadamy internal training.

 

There are 3 jupyter notebooks with focus on:

-   **Matrix Factorization Model**

![](Picture1.png)

-   **Deep and Wide Model**

![](../../Desktop/Screen Shot 2017-09-20 at 16.34.04.png)

source:<https://www.tensorflow.org/tutorials/wide_and_deep>

 

-   **Deep Matrix Factorization Model**

1.  4 layer neural network, with activation function: relu, relu, relu, softmax.

2.  Input layer is the element wise prodcut of the user embedding and the movie
    embedding.

3.  Cost function: a combination of cross entropy and mean squared error.

4.  User embedding and movie embedding will be initialized with the results from
    matrix factorization model.

5.  First 50 epochs only update weights and bias in DNN, from 51th epoch train
    model end-to-end.

 

Environment to run the notebooks
--------------------------------

python 3.6 + tensorflow 1.3.0
