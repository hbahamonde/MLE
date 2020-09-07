set.seed(2020)
options(scipen=9999999)


# Normal 
binomial.ok = rbinom(
        100, # N
        1, # pruebas (se tira la moneda una vez)
        0.5 # probabilidad de obtener 1. 
        )
hist(binomial.ok)

# Cargada 
binomial.cargada = rbinom(
        100, # N
        1, # pruebas (se tira la moneda una vez)
        0.1 # probabilidad de obtener 1. 
)
hist(binomial.cargada, main = "")
