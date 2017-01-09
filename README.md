# Dirichlet Process

Dirichlet Process (DP) is a distribution over probability distributions. It takes two arguments, a concentration parameter and a probability distribution, called the base distribution. It comes under the Nonparametric Bayesian models. By nonparametric, we mean that our distribution doesn't need any parameter. DP can be used for clustering of data when we do not know the number of clusters before hand. 

Before going in the details of the model, I would like to tell our final goal. DP can be thought of a black box, which inputs a distribution G and a concentration parameter alpha. What DP does is takes random discrete points from a base distribution. The output of DP is another distribution G'. Alpha tells us how similar G and G' are.  If alpha is very large, more samples will be drawn from the base distribution G to form G', hence more similar will be G and G'. These samples will act as centers for clustering. If we repeatedly pass G and alpha through this process, we will get a set of G' distributions. This is why it is called a distribution over probability distributions.

# Chinese Restaurant Process

The Chinese Restaurant Model is based on idea that there is a restaurant with an infinite number of tables. At each table there are an infinite number of seats. The first customer arrives and sits down at a table.  The second customer then arrives and selects a table. However, the customer selects the table that the first customer is currently sitting with probability alpha/(1+alpha) or selects a new table with 1/(1+alpha). This continues on to the (n+1)th customer where they select a table(say k) that a current customer is sitting with probability n{k}/(n+alpha).

Intuitively, this model will have the following properties :

1) The more people (data points) there are at a table (cluster), the more likely it is that people (new data points) will join it.

2) There’s always a small probability that someone joins an entirely new table (i.e., a new group is formed).

3) The probability of a new group depends on alpha. So we can think of alpha as a dispersion parameter that affects the dispersion of our datapoints. The lower alpha is, the more tightly clustered our data points; the higher it is, the more clusters we have.

This is just maximum likelihood, then why are we talking about Chinese restaurants? This is because, in CRP, we can always squeeze in 1 more table. Or one can say that the posterior of a DP is CRP.

# Introduction and Representation of our problem in CRP terminology

I have implemented the modified version of CRP(weighted CRP), following the research paper titled: "Automatic discovery of cognitive skills to improve the prediction of student learning" Lindsey et al. In this paper, the author tries to automatically discover the skills needed in a discipline. So they took various exercises and tried determinining which skill or skills are required to solve those exercises. They also took data in which expert has identified, for each exercise, a specific skill which is required for its solution (the expert labeling). Instaed of ignoring the expert labels(which traditional techniques have done), they incorporate it into the prior.

The incoming customers are exercises, tables are the skills, and the affiliation(or bias) for each table is our expert labelling. So our goal is to assign exercises one by one to the skill it belongs to. One major assumption used in this paper is that each exercise is affiliated with only 1 skill.
