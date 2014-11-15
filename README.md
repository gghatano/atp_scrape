男子テニスの勝敗データを作りたい
===

## 概要
[ATPの公式サイト](http://www.atpworldtour.com/Share/Event-Draws.aspx?e=339&y=2014)から頑張りました

こんな感じです. 対戦結果をまとめました.

```{sh}
> head winLoseData.dat
TOURNAMENT,GRADE,YEAR,MONTH,DAY,ROUND,PLAYER_1,PLAYER_2,WINNER
Australian Open,1,1970,02,01,1,Roche_Tony,Bye,Roche_Tony
Australian Open,1,1970,02,01,1,Cooper_John,Wilson_Ray,Cooper_John
Australian Open,1,1970,02,01,1,Kukal_Jan,Hammond_Anthony,Kukal_Jan
Australian Open,1,1970,02,01,1,Battrick_Gerald,Bye,Battrick_Gerald
Australian Open,1,1970,02,01,1,Taylor_Roger,Bye,Taylor_Roger
Australian Open,1,1970,02,01,1,Pollard_Geoff,Schloss_Lenny,Schloss_Lenny
Australian Open,1,1970,02,01,1,Anderson_Mal,Werren_Mathias,Werren_Mathias
Australian Open,1,1970,02,01,1,Lutz_Robert,Bye,Lutz_Robert
Australian Open,1,1970,02,01,1,Okker_Tom,Bye,Okker_Tom
```

## 内容

- winLoseData.dat

  勝敗結果表です. 1968年から2014年までの, ATP World Tourの試合結果が入っています. 
  
  列の意味は1行目にありますが, 

  大会の名前, グレード, 大会の最終日の日付, 何回戦か, 対戦者1, 対戦車2, 勝者
  
  です. 


## やったこと

対戦のデータとその勝者のデータを並べました. 


大会のグレードは, 

1:グランドスラム, 2:普通?, 3:マスターズ, 4:チャレンジャー, 5:フューチャーズ

です. 

## やっていないこと

- 日付が大会最終日になっている

  対戦が行われた日付ではなく, 大会最終日の日付が入っています. 

  ATPのWebページに日付データが載っていないためです. 

  大会最終日の日付と, 何回戦かを利用して近い日付を作ってください. 

- チャレンジャーとフューチャーズの試合が入っていない

  まだ入れていません. 後でやります

- スコア

  面倒っぽいからやっていません. 後でやるかもしれません






