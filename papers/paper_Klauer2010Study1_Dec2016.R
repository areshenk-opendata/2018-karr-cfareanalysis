# Location
folder = 'Klauer 2010'
file = 'Klauer2010Study1'

# Paper data
N = 125
vars = c(1:7) # Which rows/columns of cor. matrix to import
Sigma = importCorMatrix(paste(folder, '/', file, '.txt', sep = ''), 
                        vars = vars)

# Bootstrap correlation matrices
sigmaBoot = bootstrapCor(Sigma, N, samples)


# Specify Models
unimodel <- '
General         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7
'

multimodel <- '
shift           =~ x1 + x2 + x3
inhibit         =~ x4 + x5
update          =~ x6 + x7
'

shiupdmerge <- '
shiupd          =~ x1 + x2 + x3 + x6 + x7
inhibit         =~ x4 + x5
'

inhupdmerge <- '
shift           =~ x1 + x2 + x3
inhupd          =~ x4 + x5 + x6 + x7
'

inhshimerge <- '
update          =~ x6 + x7
inhshi          =~ x1 + x2 + x3 + x4 + x5
'

bifactor <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7
shift           =~ x1 + x2 + x3
inhibit         =~ v1*x4 + v1*x5
update          =~ v2*x6 + v2*x7
general         ~~ 0*shift
general         ~~ 0*update
general         ~~ 0*inhibit
shift           ~~ 0*update
shift           ~~ 0*inhibit
update          ~~ 0*inhibit
'

binoinh <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7
shift           =~ x1 + x2 + x3
update          =~ v2*x6 + v2*x7
general         ~~ 0*shift
general         ~~ 0*update
shift           ~~ 0*update
'

binoinhshi <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7
update          =~ v2*x6 + v2*x7
general         ~~ 0*update
'

binoinhupd <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7
shift           =~ x1 + x2 + x3
general         ~~ 0*shift
'

binoupd <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7
shift           =~ x1 + x2 + x3
inhibit         =~ v1*x4 + v1*x5
general         ~~ 0*shift
general         ~~ 0*inhibit
shift           ~~ 0*inhibit
'

binoupdshi <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7
inhibit         =~ v1*x4 + v1*x5
general         ~~ 0*inhibit
'

binoshi <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7
inhibit         =~ v1*x4 + v1*x5
update          =~ v2*x6 + v2*x7
general         ~~ 0*update
general         ~~ 0*inhibit
update          ~~ 0*inhibit
'

bishiupdmerge <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7
shiupd          =~ x1 + x2 + x3 + x6 + x7
inhibit         =~ v1*x4 + v1*x5
general         ~~ 0*shiupd
general         ~~ 0*inhibit
shiupd          ~~ 0*inhibit
'

biinhupdmerge <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7
shift           =~ x1 + x2 + x3
inhupd          =~ x4 + x5 + x6 + x7
general         ~~ 0*shift
general         ~~ 0*inhupd
shift           ~~ 0*inhupd
'

biinhshimerge <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7
inhshi          =~ x1 + x2 + x3 + x4 + x5
update          =~ v2*x6 + v2*x7
general         ~~ 0*update
general         ~~ 0*inhshi
update          ~~ 0*inhshi
'

bishiupdmernoinh <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7
shiupd          =~ x1 + x2 + x3 + x6 + x7
general         ~~ 0*shiupd
'

biinhupdmernoshi <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7
inhupd          =~ x4 + x5 + x6 + x7
general         ~~ 0*inhupd
'

biinhshimernoupd <- '
general         =~ x1 + x2 + x3 + x4 + x5 + x6 + x7
inhshi          =~ x1 + x2 + x3 + x4 + x5
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

# # (8) Fit bifactor model with no inhibition no shift
# runAndSave(sigmaBoot, N, model = binoinhshi, file = file,
#            modelName = 'binoinhshi')
# 
# # (9) Fit bifactor model with no inhibition no update
# runAndSave(sigmaBoot, N, model = binoinhupd, file = file,
#            modelName = 'binoinhupd')
# 
# # (10) Fit bifactor model with no update
# runAndSave(sigmaBoot, N, model = binoupd, file = file,
#            modelName = 'binoupd')
# 
# # (11) Fit bifactor model with no update no shift
# runAndSave(sigmaBoot, N, model = binoupdshi, file = file,
#            modelName = 'binoupdshi')
# 
# # (12) Fit bifactor model with no shift
# runAndSave(sigmaBoot, N, model = binoshi, file = file,
#            modelName = 'binoshi')
# 
# # (13) Fit bifactor model with inhibition and shift-update
# runAndSave(sigmaBoot, N, model = bishiupdmerge, file = file,
#            modelName = 'bishiupdmerge')
# 
# # (14) Fit bifactor model with inh-update and shift
# runAndSave(sigmaBoot, N, model = biinhupdmerge, file = file,
#            modelName = 'biinhupdmerge')
# 
# # (15) Fit bifactor model with inh-shift and update
# runAndSave(sigmaBoot, N, model = biinhshimerge, file = file,
#            modelName = 'biinhshimerge')
# 
# # (16) Fit bifactor model with upd-shift no inhibition
# runAndSave(sigmaBoot, N, model = bishiupdmernoinh, file = file,
#            modelName = 'bishiupdmernoinh')
# 
# # (17) Fit bifactor model with inh-upd no shift
# runAndSave(sigmaBoot, N, model = biinhupdmernoshi, file = file,
#            modelName = 'biinhupdmernoshi')
# 
# # (18) Fit bifactor model with inh-shift no update
# runAndSave(sigmaBoot, N, model = biinhshimernoupd, file = file,
#            modelName = 'biinhshimernoupd')