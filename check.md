テニスのデータを確認する
===

[ここにある](https://github.com/gghatano/atp_scrape)男子テニスのデータで遊びます. 

## 内容確認

```r
library(dplyr)
library(data.table)
```

中身はこんな感じです.

```r
dat = fread("winLoseData.dat")
dat %>% head
```

```
##         TOURNAMENT GRADE YEAR MONTH DAY ROUND        PLAYER_1
## 1: Australian Open     1 1970     2   1     1      Roche_Tony
## 2: Australian Open     1 1970     2   1     1     Cooper_John
## 3: Australian Open     1 1970     2   1     1       Kukal_Jan
## 4: Australian Open     1 1970     2   1     1 Battrick_Gerald
## 5: Australian Open     1 1970     2   1     1    Taylor_Roger
## 6: Australian Open     1 1970     2   1     1   Pollard_Geoff
##           PLAYER_2          WINNER
## 1:             Bye      Roche_Tony
## 2:      Wilson_Ray     Cooper_John
## 3: Hammond_Anthony       Kukal_Jan
## 4:             Bye Battrick_Gerald
## 5:             Bye    Taylor_Roger
## 6:   Schloss_Lenny   Schloss_Lenny
```

選手別に勝率を見ます.

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
  arrange(desc(WIN))
```

```
## Source: local data table [4,239 x 4]
## 
##             PLAYER  WIN GAME WIN_PROB
## 1    Federer_Roger 1233 1533   0.8043
## 2    Connors_Jimmy 1194 1478   0.8078
## 3       Lendl_Ivan 1022 1259   0.8118
## 4     Agassi_Andre  969 1287   0.7529
## 5     Nadal_Rafael  965 1151   0.8384
## 6     Sampras_Pete  848 1105   0.7674
## 7  Vilas_Guillermo  847 1108   0.7644
## 8     McEnroe_John  817 1006   0.8121
## 9    Edberg_Stefan  810 1072   0.7556
## 10  Djokovic_Novak  786  967   0.8128
## ..             ...  ...  ...      ...
```

フェデラー強い. 

トーナメントでない試合結果が反映されていないため, 通算勝利数は違うっぽいです. 






