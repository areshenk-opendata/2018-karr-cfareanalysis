# Location
folder = 'Lehto 2003'
file = 'Lehto2003'

# Paper data
N = 103
vars = c(2,4,7,8,9,10,11,13) # Which rows/columns of cor. matrix to import
Sigma = importCorMatrix(paste(folder, '/', file, '.txt', sep = ''), 
                        vars = vars)

# Bootstrap correlation matrices
sigmaBoot = bootstrapCor(Sigma, N, samples)

# Specify Models
unimodel <- '
General         =~ x4 + x13 + x7 + x9 + x10 + x11 + x2 + x8
'

multimodel <- '
inhibit          =~ x4 + x13
update           =~ x7 + x9 + x10 + x11
shift            =~ x2 + x8
'

shiupdmerge <- '
inhibit          =~ x4 + x13
shiupd           =~ x7 + x9 + x10 + x11 + x2 + x8
'

inhupdmerge <- '
shift           =~ x2 + x8
inhupd          =~ x4 + x13 + x7 + x9 + x10 + x11
'

inhshimerge <- '
update          =~ x7 + x9 + x10 + x11
inhshi          =~ x4 + x13 + x2 + x8
'

bifactor <- '
general          =~ x4 + x13 + x7 + x9 + x10 + x11 + x2 + x8
inhibit          =~ v1*x4 + v1*x13
update           =~ x7 + x9 + x10 + x11
shift            =~ v2*x2 + v2*x8
general         ~~ 0*shift
general         ~~ 0*update
general         ~~ 0*inhibit
shift           ~~ 0*update
shift           ~~ 0*inhibit
update          ~~ 0*inhibit
'

binoinh <- '
general          =~ x4 + x13 + x7 + x9 + x10 + x11 + x2 + x8
update           =~ x7 + x9 + x10 + x11
shift            =~ v2*x2 + v2*x8
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