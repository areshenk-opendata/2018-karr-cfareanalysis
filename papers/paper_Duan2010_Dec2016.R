# Location
folder = 'Duan 2010'
file = 'Duan2010'

# Paper data
N = 61
vars = c(1:6) # Which rows/columns of cor. matrix to import
Sigma = importCorMatrix(paste(folder, '/', file, '.txt', sep = ''), 
                        vars = vars)

# Bootstrap correlation matrices
sigmaBoot = bootstrapCor(Sigma, N, samples)

# Specify Models
unimodel <- '
General         =~ x1 + x2 + x3 + x4 + x5 + x6
'

multimodel <- '
update          =~ x1 + x2
inhibit         =~ x3 + x4
shift           =~ x5 + x6
'

shiupdmerge <- '
inhibit       =~ x3 + x4
shiupd        =~ x1 + x2 + x5 + x6
'

inhupdmerge <- '
inhupd        =~ x1 + x2  + x3 + x4
shift         =~ x5 + x6
'

inhshimerge <- '
update       =~ x1 + x2
inhshi       =~ x3 + x4 + x5 + x6
'

bifactor <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6
update          =~ v1*x1 + v1*x2
inhibit         =~ v2*x3 + v2*x4
shift           =~ v3*x5 + v3*x6
general         ~~ 0*inhibit
general         ~~ 0*shift
general         ~~ 0*update
inhibit         ~~ 0*shift
inhibit         ~~ 0*update
shift           ~~ 0*update
'

binoinh <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6
update          =~ v1*x1 + v1*x2
shift           =~ v3*x5 + v3*x6
general         ~~ 0*shift
general         ~~ 0*update
shift           ~~ 0*update
'

# (1) Fit unidimensional model
runAndSave(sigmaBoot, N, model = unimodel, file = file,
           modelName = 'unimodel')

# (2) Fit three factor model
runAndSave(sigmaBoot, N, model = multimodel, file = file,
           modelName = 'multimodel')

# (3) Fit shift-update merged model
runAndSave(sigmaBoot, N, model = shiupdmerge, file = file,
           modelName = 'shiupdmerge')

# (4) Fit inhibition-update merged model
runAndSave(sigmaBoot, N, model = inhupdmerge, file = file,
           modelName = 'inhupdmerge')

# (5) Fit inhibition-shift merged model
runAndSave(sigmaBoot, N, model = inhshimerge, file = file,
           modelName = 'inhshimerge')

# (6) Fit bifactor model
runAndSave(sigmaBoot, N, model = bifactor, file = file,
           modelName = 'bifactor')

# (7) Fit bifactor model with no inhibition
runAndSave(sigmaBoot, N, model = binoinh, file = file,
           modelName = 'binoinh')