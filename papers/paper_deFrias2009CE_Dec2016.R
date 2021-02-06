# Location
folder = 'de Frias 2009'
file = 'deFrias2009CE'

# Paper data
N = 77
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
inhibit         =~ x1 + x2
shift           =~ x3 + x4
update          =~ x5 + x6
'

shiupdmerge <- '
inhibit       =~ x1 + x2
shiupd        =~ x3 + x4 + x5 + x6
'

inhupdmerge <- '
inhupd        =~ x1 + x2  + x5 + x6
shift         =~ x3 + x4
'

inhshimerge <- '
inhshi        =~ x1 + x2 + x3 + x4
update        =~ x5 + x6
'

bifactor <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6
inhibit         =~ v1*x1 + v1*x2
shift           =~ v2*x3 + v2*x4
update          =~ v3*x5 + v3*x6
general         ~~ 0*inhibit
general         ~~ 0*shift
general         ~~ 0*update
inhibit         ~~ 0*shift
inhibit         ~~ 0*update
shift           ~~ 0*update
'

binoinh <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6
shift           =~ v4*x3 + v4*x4
update          =~ v5*x5 + v5*x6
general         ~~ 0*shift
general         ~~ 0*update
shift           ~~ 0*update
'

binoinhshi <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6
update          =~ v5*x5 + v5*x6
general         ~~ 0*update
'

binoinhupd <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6
shift           =~ v4*x3 + v4*x4
general         ~~ 0*shift
'

binoupd <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6
inhibit         =~ v1*x1 + v1*x2
shift           =~ v2*x3 + v2*x4
general         ~~ 0*inhibit
general         ~~ 0*shift
inhibit         ~~ 0*shift
'

binoupdshi <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6
inhibit         =~ v1*x1 + v1*x2
general         ~~ 0*inhibit
'

binoshi <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6
inhibit         =~ v1*x1 + v1*x2
update          =~ v3*x5 + v3*x6
general         ~~ 0*inhibit
general         ~~ 0*update
inhibit         ~~ 0*update
'

bishiupdmerge <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6
inhibit         =~ v1*x1 + v1*x2
shiupd          =~ x3 + x4 + x5 + x6
general         ~~ 0*inhibit
general         ~~ 0*shiupd
inhibit         ~~ 0*shiupd
'

biinhupdmerge <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6
inhupd          =~ x1 + x2 + x5 + x6
shift           =~ v2*x3 + v2*x4
general         ~~ 0*inhupd
general         ~~ 0*shift
inhupd          ~~ 0*shift
'

biinhshimerge <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6
inhshi          =~ x1 + x2 + x3 + x4
update          =~ v3*x5 + v3*x6
general         ~~ 0*inhshi
general         ~~ 0*update
inhshi          ~~ 0*update
'

bishiupdmernoinh <- '
general         =~ x1 + x2 + x3  + x4 + x5 + x6
shiupd          =~ x3 + x4 + x5 + x6
general         ~~ 0*shiupd
'

biinhupdmernoshi <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6
inhupd          =~ x1 + x2 + x5 + x6
general         ~~ 0*inhupd
'

biinhshimernoupd <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6
inhshi          =~ x1 + x2 + x3 + x4
general         ~~ 0*inhshi
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

# (8) Fit bifactor model with no inhibition no shift
runAndSave(sigmaBoot, N, model = binoinhshi, file = file,
           modelName = 'binoinhshi')

# (9) Fit bifactor model with no inhibition no update
runAndSave(sigmaBoot, N, model = binoinhupd, file = file,
           modelName = 'binoinhupd')

# (10) Fit bifactor model with no update
runAndSave(sigmaBoot, N, model = binoupd, file = file,
           modelName = 'binoupd')

# (11) Fit bifactor model with no update no shift
runAndSave(sigmaBoot, N, model = binoupdshi, file = file,
           modelName = 'binoupdshi')

# (12) Fit bifactor model with no shift
runAndSave(sigmaBoot, N, model = binoshi, file = file,
           modelName = 'binoshi')

# (13) Fit bifactor model with inhibition and shift-update
runAndSave(sigmaBoot, N, model = bishiupdmerge, file = file,
           modelName = 'bishiupdmerge')

# (14) Fit bifactor model with inh-update and shift
runAndSave(sigmaBoot, N, model = biinhupdmerge, file = file,
           modelName = 'biinhupdmerge')

# (15) Fit bifactor model with inh-shift and update
runAndSave(sigmaBoot, N, model = biinhshimerge, file = file,
           modelName = 'biinhshimerge')

# (16) Fit bifactor model with upd-shift no inhibition
runAndSave(sigmaBoot, N, model = bishiupdmernoinh, file = file,
           modelName = 'bishiupdmernoinh')

# (17) Fit bifactor model with inh-upd no shift
runAndSave(sigmaBoot, N, model = biinhupdmernoshi, file = file,
           modelName = 'biinhupdmernoshi')

# (18) Fit bifactor model with inh-shift no update
runAndSave(sigmaBoot, N, model = biinhshimernoupd, file = file,
           modelName = 'biinhshimernoupd')
