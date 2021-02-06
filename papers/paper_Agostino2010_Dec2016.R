# Location
folder = 'Agostino 2010'
file = 'Agostino2010'

# Paper data
N = 155
vars = c(4:10) # Which rows/columns of cor. matrix to import
Sigma = importCorMatrix(paste(folder, '/', file, '.txt', sep = ''), 
                        vars = vars)

# Bootstrap correlation matrices
sigmaBoot = bootstrapCor(Sigma, N, samples)

# Specify Models
unimodel <- '
General         =~ x4 + x5 + x6 + x7 + x8 + x9 + x10
'

multimodel <- '
inhibit          =~ x4 + x5 + x6
update           =~ x7 + x8
shift            =~ x9 + x10
'

shiupdmerge <- '
inhibit          =~ x4 + x5 + x6
shiupd           =~ x7 + x8 + x9 + x10
'

inhupdmerge <- '
shift           =~ x9 + x10
inhupd          =~ x4 + x5 + x6 + x7 + x8
'

inhshimerge <- '
update          =~ x7 + x8
inhshi          =~ x4 + x5 + x6 + x9 + x10
'

bifactor <- '
general          =~ x4 + x5 + x6 + x7 + x8 + x9 + x10
inhibit          =~ x4 + x5 + x6
update           =~ v1*x7 + v1*x8
shift            =~ v2*x9 + v2*x10
general         ~~ 0*shift
general         ~~ 0*update
general         ~~ 0*inhibit
shift           ~~ 0*update
shift           ~~ 0*inhibit
update          ~~ 0*inhibit
'

binoinh <- '
general          =~ x4 + x5 + x6 + x7 + x8 + x9 + x10
update           =~ v1*x7 + v1*x8
shift            =~ v2*x9 + v2*x10
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