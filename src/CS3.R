
library(dplyr)
library(readxl)
set.seed(26)

bonds = read_excel("data/BondPortfolio.xls")
names(bonds) <- gsub(" ", ".", names(bonds))

bonds$Lossrateifdefault= 1-bonds$Recovery.Rate
bonds$lossamount=100000*bonds$Lossrateifdefault
############################
expectedLoss=sum(bonds$lossamount * bonds$Default.Probability)
expectedLoss


########################
#Assuming independence
# n=10^7
# montecarlolosses = numeric(n)
# for (j in 1:n) {
# 
#   bonds$losshappend <- rbinom(
#     n    = nrow(bonds),
#     size = 1,
#     prob = bonds$Default.Probability
#   )
# montecarlolosses[j]= sum(bonds$lossamount*bonds$losshappend)
# 
# }
# #sanity check expected Loss
# mean(montecarlolosses)
# 
# hist(montecarlolosses)
# 
# 
# VaR_95=quantile(montecarlolosses,0.95)
# VaR_95
# tVaR_95 <- mean(montecarlolosses[montecarlolosses > VaR_95], na.rm = TRUE)
# tVaR_95
############################
#own model with parameters for single bond, sector and global shock. Correlation
#between global and sector shock, single company hat no influence 


# Default treshold, assuming the defualt prob come from a normal
bonds$threshold = qnorm(bonds$Default.Probability)

# the different sectors as factors and integers 
bonds$sector_id = as.integer(factor(bonds$Industry.sector))
K = max(bonds$sector_id)

#can this be part of montecarlo somehow?
beta_G = 0.234   # global part
a      = 0.5     # correlation between global and sector
beta_S = 0.306   # sector part
beta_eps = sqrt(1 - (beta_G + a * beta_S)^2 - beta_S^2 * (1 - a^2))  # idiosyncratic


#montecarlo simulation

n <- 10^7
montecarlolosses <- numeric(n)

for (j in 1:n) {
  
  # Global factor 
  G = rnorm(1)
  
  # sector factor, one per factor
  Z_sector = rnorm(K)
  S_sector = a*G + sqrt(1-a^2)*Z_sector
  
  # idiosyncratic, one for each bond
  eps = rnorm(nrow(bonds))
  
  # Latent Variable Y_i
  Y = beta_G * G +
    beta_S * S_sector[bonds$sector_id] +
    beta_eps * eps
  
  # Default-Indikator (1 = Default, 0 = kein Default)
  bonds$losshappend <- as.integer(Y <= bonds$threshold)
  
  # Szenario-Gesamtverlust
  montecarlolosses[j] <- sum(bonds$lossamount * bonds$losshappend)
}


hist(montecarlolosses)
#tVaR_95
#VaR_95

quantile(montecarlolosses,0.99)
quantile(montecarlolosses,0.999)
VaR_99   = quantile(montecarlolosses, 0.99)
VaR_999  = quantile(montecarlolosses, 0.999)

CVaR_99  = mean(montecarlolosses[montecarlolosses > VaR_99])
CVaR_999 = mean(montecarlolosses[montecarlolosses > VaR_999])
c(
VaR_99   = quantile(montecarlolosses, 0.99),
VaR_999  = quantile(montecarlolosses, 0.999),
CVaR_99  = mean(montecarlolosses[montecarlolosses > quantile(montecarlolosses, 0.99)]),
CVaR_999 = mean(montecarlolosses[montecarlolosses > quantile(montecarlolosses, 0.999)]))
  
####the value of the VaR 95% increases from 300k to 645k seems reasonable? 
### also the mean is 141k so no change in the Expected Loss which should be the case
A_required = quantile(montecarlolosses, 1 - 0.99/100)  # 0.9901
A_required

AAA_tranche =10000000-A_required
AAA_tranche









##################
#coupons
N = 10e6
S = N - A_required
T = 5

senior_loss = pmax(pmin(montecarlolosses - A_required, S), 0)
EL_senior_5y = mean(senior_loss) / S
EL_senior_annual = EL_senior_5y / T

bonds$premiumBP = bonds$Spread.5yr-(bonds$Lossrateifdefault * bonds$Default.Probability * 100)
premium_AAA_bps = mean(bonds$premiumBP[bonds$Rating == "AAA"])
premium_AAA = premium_AAA_bps / 10000
EL_senior_annual
premium_AAA
spread_AAA = EL_senior_annual + premium_AAA
spread_AAA
riskfree=0.03125
coupon_AAA=riskfree+spread_AAA
coupon_AAA




sum(100000*bonds$Spread.5yr/10000)




