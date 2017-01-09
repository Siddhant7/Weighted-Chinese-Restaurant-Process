#weighted chinese restaurant process

#exercise-skill affiliation dummy data

num_of_skills = 10
num_of_exercises = 100
index <- c()
for(i in 1:num_of_exercises){
  index=append(index,sample(1:num_of_skills,1))
}
k=1
c=c()
for(j in 1:num_of_exercises){
  
  for(i in 1:num_of_skills){
    if(i==index[k]){
      c=append(c,1)
    }else{
      c=append(c,0)
    }
  }
  k=k+1
}

dummy_data_matrix <- matrix(c,nrow=num_of_exercises,ncol=num_of_skills, byrow = TRUE)

#dummy data ready
#columns represent each skill, and rows represents exercise

#base distribution(generated from uniform random)
skill_list <- c(1:10)
list = c()
for(i in 1:ncol(dummy_data_matrix)){
  list = append(list, sum(dummy_data_matrix[,i]))
}

plot(skill_list, list, type = "h")

crp = function(data, alpha) {
  
  table <- c(1)
  next_table = 2
  for (i in 2:num_of_exercises) {
    if (runif(1,0,1) < alpha / (alpha + (length(table)))) {
      # Customer sits at new table
      table <- c(table, next_table)
      next_table=next_table+1
    } else {
      # Customer sits at an existing table.
      select_table <- which_table(data,table)
      table <- c(table, select_table)
    }
  }
  table
}
#define probability distribution for table(skill) assignment

which_table <- function(data,new_skill){
  
  probs = c()
  prior_skill <- which(data[length(new_skill)+1,]==1)
  for(l in 1:length(unique(new_skill))){

    indices = which(unique(new_skill)[l] == new_skill)
    
    cond_dist_skill <- vector(mode="numeric", length=num_of_skills)
    for(m in indices){
    cond_dist_skill[which(dummy_data_matrix[m,]==1)] <- cond_dist_skill[which(dummy_data_matrix[m,]==1)]
                                                           + 1
    }
    cond_dist_skill <- (1-B)^(-cond_dist_skill)
    softmax_vector <- cond_dist_skill/sum(cond_dist_skill)
    softmax <- softmax_vector[prior_skill]
    
    proportional_value <- length(indices)*(1+B*(softmax-1))            #DEFINE HERE
    probs = append(probs, proportional_value)
  }
  if(sum(probs) !=0)
    probs=probs/sum(probs)
  
  if(length(probs)>1)
    return(sample(x = unique(new_skill), size = 1, prob = probs, replace=T))
  else
    return(unique(new_skill)) #returns table "1" if only that table is available
}

#Resulting distribution
B=0.5
alpha_ = 10
alpha = (alpha_)*(1-B)
v = crp(dummy_data_matrix, alpha)

plot(
  table( v )
  ,xlab="Skill Index", ylab="Frequency of exercises"
)

#EFFECT OF alpha_ ON FINAL DISTRIBUTION
#as we increase value of alpha, wcrp will tend towards to our base distribution, which is uniform random
alpha_ = 500
alpha = (alpha_)*(1-B)
v = crp(dummy_data_matrix, alpha)

plot(
  table( v )
  ,xlab="Skill Index", ylab="Frequency of exercises"
)

#effect of alpha_ on number of clusters generated
num_of_skills_generated = c()
range_alpha_ = c(1:1000)
for(alpha_ in  range_alpha_){
  alpha = (alpha_)*(1-B)
  crp_for_plot = crp(dummy_data_matrix, alpha)
  num_of_skills_generated[alpha_] = length(unique(crp_for_plot))
}

plot(range_alpha_, num_of_skills_generated, type = "l")
#similar to log(n) distribution 

#effect of alpha_ on average number of exercises in each skill(cluster)
range_alpha_ = c(1:1000)
avg_length=c()
for(alpha_ in  range_alpha_){
  alpha = (alpha_)*(1-B)
  crp_for_plot = crp(dummy_data_matrix, alpha)
  
  z=c()
  for(i in 1:length(unique(crp_for_plot))){
    u=c()
    indexes <- which(unique(crp_for_plot)[i] == v)
    for(m in indexes){
      u= append(u,which(dummy_data_matrix[m,] == 1))
    }
    z[[i]] = table(u)/length(u)
    z=as.list(z)
  }
  length=0
  for(i in 1:length(z)){
    length = length+length(z[[i]])
  }
  avg_length=append(avg_length,length/length(z))
}

plot(range_alpha_, avg_length, type = "l")
#similar to e^(-n) distribution

#Exchangeable property

index_i=29   #random index1
index_j=39  #random index2
count=0
alpha=1
for(i in 1:1000){
  a = crp(dummy_data_matrix, alpha)
  b = crp(dummy_data_matrix, alpha)
  if(a[index_i] == a[index_j]){
    count=count+1
  }
}
count/1000
#probability of 2 exercises being in a same cluster remains same irrespective of index