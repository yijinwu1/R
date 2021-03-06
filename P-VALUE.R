#一個群體參數之統計檢定 - P value
# 單邊檢定:P(z≧|z*|)
# 雙邊檢定:2*P(z≧|z*|)
# P-value < α reject Hₒ
#########################################################
# 若 P-value > 0.10，則稱檢定結果不顯著。
# 若 0.05 < P-value ≦ 0.10，則稱檢定結果趨於顯著。
# 若 0.01 < P-value ≦ 0.05，則稱檢定結果顯著(*)。
# 若 0.001 < P-value ≦ 0.10，則稱檢定結果非常顯著(X*)。
# 若 P-value ≦ 0.001，則稱檢定結果有很高的顯著性(***)。
#########################################################

#Hₒ:μ≦80
#Hₐ:μ>80(右尾檢定)
#α=0.05

#Z=1.82
p <- pnorm(abs(1.82),lower.tail = FALSE)
p #0.0343795 < α reject Hₒ

#z=5.66
p <- pnorm(abs(5.66),lower.tail = FALSE)
p #7.56865e-09 < α reject Hₒ
