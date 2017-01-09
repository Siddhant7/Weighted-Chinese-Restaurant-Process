# Dirichlet Process

Dirichlet Process (DP) is a distribution over probability distributions. It takes two arguments, a concentration parameter and a probability distribution, called the base distribution. It comes under the Nonparametric Bayesian models. By nonparametric, we mean that our distribution doesn't need any parameter. DP can be used for clustering of data when we do not know the number of clusters before hand. 

Before going in the details of the model, I would like to tell our final goal. DP can be thought of a black box, which inputs a distribution G and a concentration parameter alpha. What DP does is takes random discrete points from a base distribution. The output of DP is another distribution G'. Alpha tells us how similar G and G' are.  If alpha is very large, more samples will be drawn from the base distribution G to form G', hence more similar will be G and G'. These samples will act as centers for clustering. If we repeatedly pass G and alpha through this process, we will get a set of G' distributions. This is why it is called a distribution over probability distributions.

# Chinese Restaurant Process

The Chinese Restaurant Model is based on idea that there is a restaurant with an infinite number of tables. At each table there are an infinite number of seats. The first customer arrives and sits down at a table.  The second customer then arrives and selects a table. However, the customer selects the table that the first customer is currently sitting with probability 1/(1+alpha) or selects a new table with alpha/(1+alpha). This continues on to the (n+1)th customer where they select a table(say k) that a current customer is sitting with probability n{k}/(n+alpha).

Intuitively, this model will have the following properties :

1) The more people (data points) there are at a table (cluster), the more likely it is that people (new data points) will join it.

2) There’s always a small probability that someone joins an entirely new table (i.e., a new group is formed).

3) The probability of a new group depends on alpha. So we can think of alpha as a dispersion parameter that affects the dispersion of our datapoints. The lower alpha is, the more tightly clustered our data points; the higher it is, the more clusters we have.

This is just maximum likelihood, then why are we talking about Chinese restaurants? This is because, in CRP, we can always squeeze in 1 more table. Or one can say that the posterior of a DP is CRP.

# Introduction and Representation of our problem in CRP terminology

I have implemented the modified version of CRP(weighted CRP), following the research paper titled: "Automatic discovery of cognitive skills to improve the prediction of student learning" Lindsey et al. In this paper, the author tries to automatically discover the skills needed in a discipline. So they took various exercises and tried determinining which skill or skills are required to solve those exercises. They also took data in which expert has identified, for each exercise, a specific skill which is required for its solution (the expert labeling). Instaed of ignoring the expert labels(which traditional techniques have done), they incorporate it into the prior.

The incoming customers are exercises, tables are the skills, and the affiliation(or bias) for each table is our expert labelling. So our goal is to assign exercises one by one to the skill it belongs to. One major assumption used in this paper is that each exercise is affiliated with only 1 skill.

# Walk through of the code

-> First I created a dummy data for expert labels. It has 100 exercises assigned to 10 skills randomly. It's a matrix in which each row represents an exercise and each column represents a skill. Each row is filled with one-hot vector(each exercise is assigned to only 1 skill).

-> A crp function is defined, which inputs the expert label data, and the parameter of the model alpha. The first exercise is assigned to a skill "1"(Note that the skills that are being assigned are not labelled skills. These are different from the columns of our matrix, which are labelled). 

-> The next exercises come in one by one sequentially from our matrix, and moves inside the first condition of slecting a new skill, with probability alpha/(alpha+n), where n is the total number of exercises already assigned. So, as n increases, the chances are more that the incoming exercise selects an already assigned skill(which intuitively sounds correct too, as the exercise should not choose a new skill, if many skills are already their to choose from).

-> If the condition above is false, the exercise will now select a new skill. Now the question is which skill should it select. For this purpose, I have defined another function which_table, which inputs data matrix, and the list of already assigned exercises. In this function, we first define our probability distribution of each already available skill, and then return a sample skill from that distribution.

-> To avoid confusion, I have named the list of new skills which are assigned as "table", and the list of expert labelled skills as "skill". Also, the index of the table list represents each exercise of our data matrix(same index). Let the incoming exercise has the expert label of skill "a". The basic idea of this function is that it assigns a probability to a skill by the multiplying the number of exercises already assigned to that skill, and a bias term. The bias term is higher for a table "y" if "a" is the most common affiliation among exercises at table "y". These biases are the weights for each table, hence the term "Weigted CRP".

->Keep on iterating this until we reach to the last exercise. We will get a new skill-exercises cluster every time we run this process, as there is randomness involved. So, CRP is a distribution over partitions. 
