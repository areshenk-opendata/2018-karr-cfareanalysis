modelFit = function(Sigma, N, model, sigmaBoot){
    fit = cfa(model, 
              sample.cov = Sigma, 
              sample.mean = rep(0, dim(Sigma)[1]), 
              sample.nobs = N,
              mimic = 'Mplus',
              std.lv = T)
    
    # Cross-validation
    # Mean of RMSEs across all bootstrap iterations
    # pred <- fitted(fit)$cov
    # D = 1/sqrt(diag(pred))
    # pred = D * pred * D
    # pred <- pred[lower.tri(pred)]
    # cv <- mean(apply(sigmaBoot, 3, function(x) sqrt(mean((x[lower.tri(x)] - pred)^2))  ))
    # names(cv) <- 'CV'
    
    # Get factor correlations
    # This is kind of ugly, but we only want the correlations between 
    # certain factors, and I really don't like playing with regex.
    corNames <- names(coef(fit))
    corIdx   <- which(corNames %in% c('update~~shift',   'shift~~update',
                                      'update~~inhibit', 'inhibit~~update',
                                      'inhibit~~shift',  'shift~~inhibit',
                                      'inhibit~~shiupd', 'shiupd~~inhibit',
                                      'shift~~inhupd',   'inhupd~~shift',
                                      'update~~inhshi',  'inhshi~~update',
                                      
                                      'vci~~pri',        'pri~~vci',
                                      'vci~~wmi',        'wmi~~vci',
                                      'vci~~psi',        'psi~~vci',
                                      'pri~~wmi',        'wmi~~pri',
                                      'pri~~psi',        'psi~~pri',
                                      'wmi~~psi',        'psi~~wmi',
                                      
                                      'vci~~vsi',        'vsi~~vci',
                                      'vci~~fri',        'fri~~vci',
                                      'vci~~wmi',        'wmi~~vci',
                                      'vci~~psi',        'psi~~vci',
                                      'vsi~~fri',        'fri~~vsi',
                                      'vsi~~wmi',        'wmi~~vsi',
                                      'vsi~~psi',        'psi~~vsi',
                                      'fri~~wmi',        'wmi~~fri',
                                      'fri~~psi',        'psi~~fri',
                                      'wmi~~psi',        'psi~~wmi'))
    cors     <- coef(fit)[corIdx] 
    
    # Loadings
    pars <- parameterEstimates(fit, se = F)
    labs <- paste(pars$lhs, pars$rhs)
    idx  <- pars$op == '=~'
    ld   <- pars$est[idx] 
    names(ld) <- paste(pars$lhs, pars$rhs)[idx]
    
    return(c(reliability(fit)['omega3',], 
             fitMeasures(fit)[c(5,9,19,20,22,23)], cors, ld))
}
