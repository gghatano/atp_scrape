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

- network.md 

  勝敗関係をネットワークで可視化しました. 

- seminar/handout.pdf , seminar/slide.pdf

  ネットワーク構造を利用したランキングシステムについて, 論文紹介の発表資料です. 

## やったこと

対戦のデータとその勝者のデータを並べました. 


大会のグレードについては, 

1:グランドスラム, 2:普通?, 3:マスターズ, 4:チャレンジャー, 5:フューチャーズ

です. 1,2,3の試合結果をまとめました. 


## やっていないこと

- 日付が大会最終日になっている

  対戦が行われた日付ではなく, 大会最終日の日付が入っています. 

  ATPのWebページに日付データが載っていないためです. 

  大会最終日の日付と何回戦かを利用して, 近い日付を作るくらいが限界かもしれません. 

- チャレンジャーとフューチャーズの試合が入っていない

  まだ入れていません. 後でやるかもしれません. 

- 一部のマスターズの試合が入っていない

  完全なトーナメント形式の大会を対象にHTMLをパースしましたので, 

  予選リーグ -> 決勝トーナメント のような形式の大会は無視しています. 


## 作業ログ

スコア作ったけど欠損データがありすぎて辛い. 

./mergedDataで, 大会ごとにデータが作ってある. 

大会ごとに, 正しくデータがとれているかどうかを確認して, 正しいものを採択する. 


