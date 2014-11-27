男子テニスの勝敗データを作りたい
===

## 概要
[ATPの公式サイト](http://www.atpworldtour.com/Share/Event-Draws.aspx?e=339&y=2014)にある過去の大会結果をまとめました. 

対戦結果をこんな風にまとめました. 

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

どの大会でいつ誰と誰が対戦して誰が勝ったか, というcsvです. 

1968年から2014年まで, 3425大会の151288試合のデータです. 

試しに生涯勝率でランキング作ってみました. 
```{sh}
> head winRanking.dat
PLAYER,WIN,GAME,WIN_PROB
Connors_Jimmy,1184,1461,0.8104
Lendl_Ivan,997,1214,0.8213
Federer_Roger,920,1129,0.8149
Vilas_Guillermo,847,1108,0.7644
McEnroe_John,804,982,0.8187
Agassi_Andre,788,1034,0.7621
Edberg_Stefan,711,938,0.758
Nastase_Ilie,708,1005,0.7045
Sampras_Pete,685,876,0.782
```

詳しい人なら分かるかもしれませんが, 公式の生涯記録とは異なっています.

原因は, 変則的なトーナメントである大会の記録が追えていない, などです. ツアーファイナルとかです. 


## 内容

- winLoseData.dat

  勝敗結果表です. 1968年から2014年までの, ATP World Tourの試合結果が入っています. 
  
  列の意味は1行目にありますが, 

  大会の名前, グレード, 大会の最終日の日付, 何回戦か, 対戦者1, 対戦車2, 勝者
  
  です. 

  対戦者に入っている"Bye"は, シード勝ち上がりの相手です. 勝率計算の際は除いてください. 

- network.md 

  勝敗関係をネットワークで可視化してみました. 

- seminar/handout.pdf , seminar/slide.pdf

  ネットワーク構造を利用したランキングシステムについて, 論文紹介の発表資料です. 



## 問題点など

- 日付が大会最終日になっている

  対戦が行われた日付ではなく, 大会最終日の日付が入っています. 

  ATPのWebページに日付データが載っていないためです. 

  大会最終日の日付と何回戦か...を利用して, 近い日付を作るくらいが限界かもしれません. 

- チャレンジャーとフューチャーズの試合が入っていない

  ATPの大会だけです. 下部組織の大会は入れていません. 後でやるかもしれません. 

- 一部のマスターズの試合が入っていない

  完全なトーナメント形式の大会を対象にHTMLをパースしましたので, 

  予選リーグ -> 決勝トーナメント のような形式の大会は無視しています. 


## 注意

データの中身の正しさは保証しません. 

## 作業ログ

スコア作ったけど欠損データがありすぎて辛い. マージ出来ないつらい. Byeなのか欠損なのか分かんねえし
./mergedDataで, 大会ごとにデータが作ってあるけど辛い

大会ごとに, 正しくデータがとれているかどうかを確認して, 正しいものを採択する. -> winLoseDataは完了



