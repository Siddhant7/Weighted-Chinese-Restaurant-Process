# Dirichlet Process

Dirichlet Process (DP) is a distribution over probability distributions. It takes two arguments, a concentration parameter and a probability distribution, called the base distribution. It comes under the Nonparametric Bayesian models. By nonparametric, we mean that our distribution doesn't need any parameter. DP can be used for clustering of data when we do not know the number of clusters before hand. 

Before going in the details of the model, I would like to tell our final goal. DP can be thought of a black box, which inputs a distribution G and a concentration parameter alpha. What DP does is takes random discrete points from a base distribution. The output of DP is another distribution G'. Alpha tells us how similar G and G' are.  If alpha is very large, more samples will be drawn from the base distribution G to form G', hence more similar will be G and G'. If we repeatedly pass G and alpha through this process, we will get a set of G' distributions. This is why it is called a distribution over probability distributions.

# Chinese Restaurant Process

The Chinese Restaurant Model is based on idea that there is a restaurant with an infinite number of tables. At each table there are an infinite number of seats. The first customer arrives and sits down at a table.  The second customer then arrives and selects a table. However, the customer selects the table that the first customer is currently sitting with probability alpha/(1+alpha) or selects a new table with 1/(1+alpha). This continues on to the (n+1)th customer where they select a table(say k) that a current customer is sitting with probability n{k}/(n+alpha).

Intuitively, this model will have the following properties :

1) The more people (data points) there are at a table (cluster), the more likely it is that people (new data points) will join it.

2) There’s always a small probability that someone joins an entirely new table (i.e., a new group is formed).

3) The probability of a new group depends on αα. So we can think of αα as a dispersion parameter that affects the dispersion of our datapoints. The lower alpha is, the more tightly clustered our data points; the higher it is, the more clusters we have in any finite set of points.



# Weighted Chinese Restaurant Process
