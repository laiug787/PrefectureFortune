# Prefecture fortune

## 概要

株式会社ゆめみ iOS エンジニアコードチェック課題

テーマ「あなたと相性のいい都道府県を占ってあげる！」

## アプリの仕様
ユーザから名前，生年月日，血液型の情報を受け取り，以下のAPIに問い合わせ，返ってきた結果を表示する。 

`https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud`

## アプリの使い方

### 占う

あなたの今日の運勢を占います

<img height="500" alt="スクリーンショット 2023-07-03 7 08 36" src="https://github.com/laiug787/PrefectureFortune/assets/86225588/c29c26f8-e38a-4852-8d06-4687fd2d3765">
<img height="500" alt="スクリーンショット 2023-07-03 7 47 57" src="https://github.com/laiug787/PrefectureFortune/assets/86225588/a214325f-c0f5-4ef3-810d-b003b69ca100">

### 集める

占い結果は保存・削除可能

<img height="500" alt="スクリーンショット 2023-07-03 7 43 06" src="https://github.com/laiug787/PrefectureFortune/assets/86225588/f42fe731-e87d-454c-9715-e74e5868034c">
<img height="500" alt="スクリーンショット 2023-07-03 7 43 35" src="https://github.com/laiug787/PrefectureFortune/assets/86225588/e872f1f4-f3c5-4fe1-8f74-41ef2cda8eaa">
<img height="500" alt="スクリーンショット 2023-07-03 7 46 04" src="https://github.com/laiug787/PrefectureFortune/assets/86225588/f16590ae-3f57-4c3a-9c46-85211020b25f">

### 探す

都道府県を検索可能

<img height="500" alt="スクリーンショット 2023-07-03 7 49 30" src="https://github.com/laiug787/PrefectureFortune/assets/86225588/6a7b14b6-6340-4521-9c41-4819d62d3f24">
<img height="500" alt="スクリーンショット 2023-07-03 7 50 04" src="https://github.com/laiug787/PrefectureFortune/assets/86225588/5bd2dec2-ecee-44dd-ae7e-135fd793e022">
<img height="500" alt="スクリーンショット 2023-07-03 8 01 53" src="https://github.com/laiug787/PrefectureFortune/assets/86225588/4e6f174a-ea9c-4041-afc5-717c111934f2">

### 設定
- ユーザーの情報を保存・編集可能
- 外観を選択可能
- 言語を選択可能

<img height="500" alt="スクリーンショット 2023-07-03 7 28 12" src="https://github.com/laiug787/PrefectureFortune/assets/86225588/1402eaf8-c02b-4ce7-9ab6-fee32a25e263">
<img height="500" alt="スクリーンショット 2023-07-03 7 57 05" src="https://github.com/laiug787/PrefectureFortune/assets/86225588/429885e8-df6d-4d74-b837-a0605d1e41e3">

## 頑張った点
- ブランチの切り方，コミット文の書き方，プッシュのやり方を検討。
- APIに初挑戦
- ネイティブアプリを意識
- iPadでも情報を余すことなく表示できるように工夫

<img height="500" alt="スクリーンショット 2023-07-03 8 06 16" src="https://github.com/laiug787/PrefectureFortune/assets/86225588/b986c5c7-99df-4335-a70f-3b8c4d758915">

## 環境
- Language：Swift
- Version：5.8.1
- Xcode：14.3.1
- iOS：16.4
- Architecture：MVVM
- Library：なし

## 使用した技術
- SwiftUI
- CoreData
- MapKit
- Network

## 今回学んだこと
- jsonの使い方
- APIの使用方法
- MapKitの使い方
- xclocの使い方(簡単にローカライズできる)

## 今後やりたいこと
- ユニットテストの導入
- ライブラリの導入
- 保存した人々のリストから占うボタンの追加
- WidgetKit
