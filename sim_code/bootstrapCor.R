bootstrapCor = function(Sigma, N, samples = 1000){
    
    
    storage = array(NA, dim = c(dim(Sigma), samples),
                    dimnames = list(row.names(Sigma), NULL, NULL))
    
    for (i in 1:samples){
        x = data.frame(mvrnorm(n = N, 
                               mu = rep(0, dim(Sigma)[1]), 
                               Sigma = Sigma))
        storage[,,i] = cor(x)
    }
    
    return(storage)
}