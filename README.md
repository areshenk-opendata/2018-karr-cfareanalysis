# 2018_karr_cfaReanalysis

Code for replicating the analyses reported in:
Karr, J. E., Areshenkoff, C. N., Rast, P., Hofer, S. M., Iverson, G. L., & Garcia-Barrera, M. A. (2018). The unity and diversity of executive functions: A systematic review and re-analysis of latent variable studies. Psychological bulletin.

The file run_simulation.R will replicate the reanalysis. Running the simulation requires the the following packages:
- lavaan
- semTools
- MASS
- plyr

Slight changes have been made to the version used in the article to accommodate the variety of environments used by readers. In particular, the  simulation described in the article was run heavily parallelized on a Linux machine, with some of the data organization offloaded to bash. In order to make the code useable for all readers (particularly users of Windows), the code has serialized and ported entirely to R, at the cost of substantial speed. The full 5000 simulations of each model for each study can be expected to take several days, unparallelized.

The number of bootstrap samples is given by the “samples” variable, which is set to 10 for demonstration purposes, though 5000 were used in the publication. 

The directory structure is as follows:
- “paper_data” contains the means and covariance matrices for each study
- “papers” contains model scripts for each study
- “sim_code” contains scripts for importing the covariance matrices and fitting the models to each study
- “simulation_data” contains the simulation results. Separate files are output for each study, for each model. Each file contains one row per bootstrap sample, each containing the omega statistic for each factor, various summary statistics, the correlations between distinct factors.

Variable names in output files are as follows:
- Omega coefficients for each factor + general, denoted by factor names (shift, update, ..., general)
- p.value
- cfi
- aic
- bic
- bic2
- Correlations between factors, if allowed in model. Denoted "Fac1..Fac2" (e.g. update..shift)
- Loadings of variables on factors. Denoted "Fac.Var" (e.g. update.x1)
