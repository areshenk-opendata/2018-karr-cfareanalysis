runAndSave <- function(sigmaBoot, N, model, file, modelName){
    
    # Apply model to each bootstrap covariance matrix
    fit = alply(sigmaBoot, 3, 
                function (x) tryCatch(modelFit(x, N, model, sigmaBoot),
                                      error = function(e) NA,
                                      warning = function(w) NA))
    
    # Convert result to data frame
    frame = data.frame(t(as.data.frame(fit)))
    
    # Save data file
    write.table(frame,
                file = paste('simulation_data/', file, '_', modelName, 
                             '.csv', sep = ''),
                sep = ',', row.names = F)
    
    return(NULL)
}