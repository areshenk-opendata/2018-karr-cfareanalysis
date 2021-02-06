# Location
folder = 'AranFilippetti 2013'
file = 'AranFilippetti2013'

# Paper data
N = 248
vars = c(1:9) # Which rows/columns of cor. matrix to import
Sigma = importCorMatrix(paste(folder, '/', file, '.txt', sep = ''), 
                        vars = vars)

# Bootstrap correlation matrices
sigmaBoot = bootstrapCor(Sigma, N, samples)

# Specify Models
unimodel <- '
General         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9
'

multimodel <- '
update          =~ x1 + x2 + x3
shift           =~ x4 + x5 + x6
inhibit         =~ x7 + x8 + x9
'

shiupdmerge <- '
shiupd          =~ x1 + x2 + x3 + x4 + x5 + x6
inhibit         =~ x7 + x8 + x9
'

inhupdmerge <- '
shift           =~ x4 + x5 + x6
inhupd          =~ x1 + x2 + x3 + x7 + x8 + x9
'

inhshimerge <- '
update          =~ x1 + x2 + x3
inhshi          =~ x4 + x5 + x6 + x7 + x8 + x9
'

bifactor <- '
general         =~ x1 + x2 + x3  + x4 + x5 + x6 + x7 + x8 + x9
update          =~ x1 + x2 + x3
shift           =~ x4 + x5 + x6
inhibit         =~ x7 + x8 + x9
general         ~~ 0*shift
general         ~~ 0*update
general         ~~ 0*inhibit
shift           ~~ 0*update
shift           ~~ 0*inhibit
update          ~~ 0*inhibit
'

binoinh <- '
general         =~ x1 + x2 + x3  + x4 + x5 + x6 + x7 + x8 + x9
update          =~ x1 + x2 + x3
shift           =~ x4 + x5 + x6
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