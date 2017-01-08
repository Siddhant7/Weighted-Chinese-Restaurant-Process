#chinese restaurant process

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

#indices of skill are exercise number

crp = function(data, alpha) {
  
  table <- c(1)
  next.table = 2
  for (i in 2:num_of_exercises) {
    if (runif(1,0,1) < alpha / (alpha + (length(table)))) {
      # Customer sits at new table
      table <- c(table, next.table)
      next.table=next.table+1
    } else {
      # Customer sits at an existing table.
      # He chooses which table to sit at by giving equal weight to each
      # customer already sitting at a table.
      select.table <- wcrp_distribution(data,table)
      table <- c(table, select.table)
    }
  }
  table
}
#define probability distribution for table(skill) assignment

wcrp_distribution <- function(data,new_skill){
  
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
    return(unique(new_skill))
}

#Results, and effect of parameters alpha and B on the final distributions
B=0.8
alpha_ = 50
alpha = (alpha_)*(1-B)

v = crp(dummy_data_matrix, alpha)
z=c()
for(i in 1:length(unique(v))){
  u=c()
  indexes <- which(unique(v)[i] == v)
  for(m in indexes){
    u= append(u,which(dummy_data_matrix[m,] == 1))
  }
  z[[i]] = table(u)/length(u)
}

length=0
for(i in 1:length(z)){
  length = length+length(z[[i]])
}
avg_length=length/length(z)
avg_length

skill_list <- c(1:10)
list = c()
for(i in 1:ncol(dummy_data_matrix)){
  list = append(list, sum(dummy_data_matrix[,i]))
}

plot(skill_list, list, type = "h")
plot(
  table( v )
  ,xlab="Skill Index", ylab="Frequency"
)


#as we increase value of alpha, wcrp will tend towards to our base distribution, which is uniform random  

#Exchangeable property

index_i=5
index_j=55
count=0
for(i in 1:10000){
  a = crp(10000,5)
  b = crp(10000,5)
  if(a[index_i] == a[index_j]){
    count=count+1
  }
}
count/10000

