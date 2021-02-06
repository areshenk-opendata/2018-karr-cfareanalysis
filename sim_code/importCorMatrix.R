importCorMatrix = function(file, vars = NULL){
    
    # Import datafile
    file = paste('paper_data/', file, sep = '')
    dataFile = read.table(file, sep = '', header = F, fill = TRUE)
    
    # Construct covariance matrix
    corMatrix = as.matrix(dataFile[-c(1,2),])
    corMatrix = matrix(mapply(FUN = sum, 
                              corMatrix, 
                              t(corMatrix),  
                              -diag(rep(1, dim(corMatrix)[1])),
                              MoreArgs = list(na.rm = TRUE)),
                       nrow = dim(corMatrix)[1])
    if (is.null(vars)) vars = 1:dim(corMatrix)[1]
    corMatrix = corMatrix[vars, vars]
    row.names(corMatrix) = paste('x', vars, sep = '')
    
    return(corMatrix)
}