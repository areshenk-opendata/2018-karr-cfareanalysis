# Location
folder = 'Miller 2012'
file = 'Miller2012'

# Paper data
N = 129
vars = c(1:5,7:9,11:13) # Which rows/columns of cor. matrix to import
Sigma = importCorMatrix(paste(folder, '/', file, '.txt', sep = ''), 
                        vars = vars)

# Bootstrap correlation matrices
sigmaBoot = bootstrapCor(Sigma, N, samples)

# Specify Models
unimodel <- '
General         =~ x1 + x2 + x3 + x4 + x5 + x7 + x8 + x9 + x11 + x12 + x13
'

multimodel <- '
update           =~ x1 + x2 + x3 + x4
inhibit          =~ x5 + x7 + x8 + x9
shift            =~ x11 + x12 + x13
'

shiupdmerge <- '
shiupd          =~ x1 + x2 + x3 + x4 + x11 + x12 + x13
inhibit         =~ x5 + x7 + x8 + x9
'

inhupdmerge <- '
shift           =~ x11 + x12 + x13
inhupd          =~ x1 + x2 + x3 + x4 + x5 + x7 + x8 + x9
'

inhshimerge <- '
update          =~ x1 + x2 + x3 + x4
inhshi          =~ x5 + x7 + x8 + x9 + x11 + x12 + x13
'

bifactor <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x7 + x8 + x9 + x11 + x12 + x13
update          =~ x1 + x2 + x3 + x4
inhibit         =~ x5 + x7 + x8 + x9
shift           =~ x11 + x12 + x13
general         ~~ 0*shift
general         ~~ 0*update
general         ~~ 0*inhibit
shift           ~~ 0*update
shift           ~~ 0*inhibit
update          ~~ 0*inhibit
'

binoinh <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x7 + x8 + x9 + x11 + x12 + x13
update          =~ x1 + x2 + x3 + x4
shift           =~ x11 + x12 + x13
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