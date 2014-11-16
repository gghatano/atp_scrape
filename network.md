テニスの勝敗関係からネットワークを作る
===

[ここにある](https://github.com/gghatano/atp_scrape)男子テニスのデータで遊びます. 

## 内容確認

```r
library(dplyr)
library(data.table)
library(igraph)
options(rpubs.upload.method = "internal")

dat = fread("winLoseData.dat")
```

## 勝ち数ランキング

勝ち数で並べてみます. 主要な選手を取り出すためです. 

```r
dat_not_bye = dat %>% 
  filter(PLAYER_1 != "Bye") %>% 
  filter(PLAYER_2 != "Bye") 
  
dat_1 = dat_not_bye %>% 
  select(PLAYER_1, WINNER) %>% setnames(c("PLAYER", "WINNER"))
dat_2 = dat_not_bye %>% 
  select(PLAYER_2, WINNER) %>% setnames(c("PLAYER", "WINNER"))
dat_12 = 
  rbind(dat_1, dat_2)

dat_win = 
  dat_12 %>% 
  mutate(WIN_FLG = (PLAYER==WINNER)) %>% 
  group_by(PLAYER) %>% 
  summarise(WIN = sum(WIN_FLG), 
            GAME=length(WIN_FLG))

## 勝ち数ランキングと勝率
dat_win %>% 
  mutate(WIN_PROB = WIN / GAME) %>% 
  arrange(desc(WIN)) %>% 
  head(20) 
```

```
##                PLAYER  WIN GAME WIN_PROB
## 1       Federer_Roger 1233 1533   0.8043
## 2       Connors_Jimmy 1194 1478   0.8078
## 3          Lendl_Ivan 1022 1259   0.8118
## 4        Agassi_Andre  969 1287   0.7529
## 5        Nadal_Rafael  965 1151   0.8384
## 6        Sampras_Pete  848 1105   0.7674
## 7     Vilas_Guillermo  847 1108   0.7644
## 8        McEnroe_John  817 1006   0.8121
## 9       Edberg_Stefan  810 1072   0.7556
## 10     Djokovic_Novak  786  967   0.8128
## 11       Roddick_Andy  728  987   0.7376
## 12       Ferrer_David  726 1099   0.6606
## 13      Chang_Michael  725 1088   0.6664
## 14       Becker_Boris  706  946   0.7463
## 15       Nastase_Ilie  706 1006   0.7018
## 16     Hewitt_Lleyton  674  974   0.6920
## 17         Haas_Tommy  670 1085   0.6175
## 18        Moya_Carlos  666 1057   0.6301
## 19    Gottfried_Brian  642  946   0.6786
## 20 Kafelnikov_Yevgeny  629  954   0.6593
```

## 上位10人 + 錦織でネットワーク作成
勝敗関係からネットワークを作ります. 

まずは行列を作ります. 

```r
## 勝ち数ランキングと勝率
topplayers = 
  dat_win %>% 
  mutate(WIN_PROB = WIN / GAME) %>% 
  arrange(desc(WIN)) %>% 
  head(10) %>% 
  select(PLAYER) %>% unlist

## 錦織もおまけで入れてあげます
topplayers = c(topplayers, "Nishikori_Kei")

dat_win_lose = 
  dat %>% 
  filter(PLAYER_1 %in% topplayers & PLAYER_2 %in% topplayers) %>% 
  mutate(LOSER = ifelse(PLAYER_1 == WINNER, PLAYER_2, PLAYER_1)) %>% 
  select(WINNER, LOSER) %>% 
  group_by(WINNER,LOSER) %>% 
  filter(WINNER != "") %>% 
  summarise(TIME= n()) %>% 
  arrange(desc(TIME)) %>% 
  group_by(add=FALSE) %>% 
  filter(WINNER %in% topplayers) %>% 
  filter(LOSER %in% topplayers) 

mat = dat_win_lose %>% 
  xtabs(formula = TIME ~ .) 
```


接続行列から有向グラフを作ります. 

```r
graph  = graph.adjacency(mat, mode="directed", weighted = TRUE)
set.seed(1)
V(graph)$size <- 3
V(graph)$color <- NA
V(graph)$frame.color <- NA
E(graph)$width = E(graph)$weight / 5
E(graph)$arrow.size = 0.8
plot(graph, layout=layout.auto, edge.curved=0.3)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

なるほど. 

## ページランクでランキング

PageRankでランキングをつけてみます. 

勝率や勝ち数のランキングと比べて, 変化がありますかね?


```r
## 勝ち数ランキングと勝率
topplayers = 
  dat_win %>% 
  mutate(WIN_PROB = WIN / GAME) %>% 
  arrange(desc(WIN)) %>% 
  head(100) %>% 
  select(PLAYER) %>% unlist

dat_win_lose = 
  dat %>% 
  filter(PLAYER_1 %in% topplayers & PLAYER_2 %in% topplayers) %>% 
  mutate(LOSER = ifelse(PLAYER_1 == WINNER, PLAYER_2, PLAYER_1)) %>% 
  select(WINNER, LOSER) %>% 
  group_by(WINNER,LOSER) %>% 
  filter(WINNER != "") %>% 
  summarise(TIME= n()) %>% 
  arrange(desc(TIME)) %>% 
  group_by(add=FALSE) %>% 
  filter(WINNER %in% topplayers) %>% 
  filter(LOSER %in% topplayers) 
  
mat = dat_win_lose %>% 
  xtabs(formula = TIME ~ .) 

graph  = graph.adjacency(mat, mode="directed", weighted = TRUE)
page.rank(graph)$vector %>% sort(decreasing = TRUE) %>% head(10)
```

```
## Santoro_Fabrice  Alexander_John  Solomon_Harold     Lutz_Robert 
##         0.01589         0.01521         0.01378         0.01376 
## Gottfried_Brian  Bjorkman_Jonas  FillolSr_Jaime   Riessen_Marty 
##         0.01347         0.01325         0.01308         0.01298 
##     Moya_Carlos    Nastase_Ilie 
##         0.01289         0.01285
```
よく分かんねえ

