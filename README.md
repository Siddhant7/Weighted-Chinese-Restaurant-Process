# Dirichlet Process

Dirichlet Process (DP) is a distribution over probability distributions. It takes two arguments, a concentration parameter and a probability distribution, called the base distribution. It comes under the Nonparametric Bayesian models. By nonparametric, we mean that our distribution doesn't need any parameter. DP can be used for clustering of data when we do not know the number of clusters before hand. 

Before going in the details of the model, I would like to tell our final goal. DP can be thought of a black box, which inputs a distribution G and a concentration parameter alpha. What DP does is takes random discrete points from a base distribution. The output of DP is another distribution G'. Alpha tells us how similar G and G' are.  If alpha is very large, more samples will be drawn from the base distribution G to form G', hence more similar will be G and G'. If we repeatedly pass G and alpha through this process, we will get a set of G' distributions. This is why it is called a distribution over probability distributions.

# Chinese Restaurant Process

The Chinese Restaurant Model is based on idea that there is a restaurant with an infinite number of tables. At each table there are an infinite number of seats. The first customer arrives and sits down at a table.  The second customer then arrives and selects a table. However, the customer selects the table that the first customer is currently sitting with probability alpha/(1+alpha) or selects a new table with 1/(1+alpha). This continues on to the (n+1)th customer where they select a table that a current customer is sitting with probability n{k}/(n+alpha).



# Weighted Chinese Restaurant Process
