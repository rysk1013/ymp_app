# YourMasterPieces

## アプリの概要
自分の作ったポートフォリオを投稿できるアプリケーションです。
ポートフォリオをこれから作る人、作成しているが機能に悩んでいる人が
参考にすることができます！

#### ポートフォリオへのリンク
[YourMasterPieces](http://54.168.6.107:3000/)

#### テストアカウント
ヘッダー部分にある"ゲストログイン"をクリックすることでゲストユーザーとしてログインすることができます。

## 目指した課題解決
プログラミングを学習していて、ポートフォリオを作成する段階になりアイデアを考え始めましたが
なかなか良いアイデアが浮かばず、他の人がどのようなポートフォリオを作成しているのかを参考にしようと思い
調べていました。しかし、ひとつひとつしか見つけることができず時間がかかってしまい、
これからポートフォリオを作成する人の中には自分と同じ悩みを持っている方もいるのではないのかと考え、
ポートフォリオを投稿することができるアプリケーションの開発に至りました。

## 工夫した点
ユーザー詳細ページでは自分の投稿一覧といいねをした投稿の一覧が表示されるようになっています。
コメント機能ではJavaScriptを使用し非同期通信で投稿できるようになっています。
Herokuでのデプロイではレスポンスが遅く、また、投稿した画像が一定時間をすぎると消えてしまいます。
その問題を解決するため、データの保存先にはAWSのS3を、デプロイでは同じくAWSのEC2を使用しています。

## 使用技術
- フロントエンド
  - HTML
  - CSS
  - Javascript
- バックエンド
  - Ruby: 2.6.5
  - Ruby on Rails: 6.0.0
- インフラ
  - AWS(EC2, S3)
  - MySQL: 5.6
- テスト・静的コード解析
  - Rspec
  - Rubocop

## 導入予定
- インフラ
  - AWS(VPC, Rout53, RDS)
  - Docker/docker-compose
  - CircleCI(CI/CD)

   - ※テスト用で作成したアプリではDocker/docker-composeとCircleCIの導入ができました。
    テストアプリのGithub: https://github.com/rysk1013/chat-app

## 実装機能
- ユーザー管理機能
- 投稿管理機能
- コメント管理機能
- いいね管理機能
- タグ管理機能
- 検索機能

## 実装予定
- ページネーション
- いいね機能の非同期通信
- レスポンシブWebデザイン

## 要件定義
- ユーザー管理機能
  - 目的
    ユーザーの新規登録、ログイン、編集ができる
  - ユースケース
    ユーザーはアカウントを登録し投稿・コメント・いいね・検索機能を利用することができる

- 投稿管理機能
  - 目的  
    新規投稿、投稿の編集、削除、詳細ページでは投稿情報を確認することができる
  - ユースケース  
    投稿は画像をつけることができる
    ログインしていなくても投稿一覧ページ、詳細ページは閲覧することができる
- コメント管理機能（非同期通信）
  - 目的  
    ログインユーザーであれば投稿の詳細ページからコメントを投稿することができる
    コメントをページ遷移なしで表示することたできる
  - ユースケース  
    アイデアや技術など気になった投稿にコメントしコミュニケーションをとることができる
    ページ遷移しないためユーザーの待ち時間が無くストレスが軽減する
- いいね管理機能
  - 目的  
    ログインユーザーであれば投稿詳細ページからいいねボタンをクリックすることができる。
    また、いいねを押した投稿は自身のユーザー詳細ページに表示される
  - ユースケース  
    参考になる投稿にいいねを付けることができる
    ユーザー詳細でいいねをした投稿が表示されるため、随時、参考にすることができる
- タグ管理機能
  - 目的  
    タグがついている投稿を絞って閲覧することができる
  - ユースケース  
    ユーザーが気になるタグをクリックすることで投稿を絞って見ることができる
- 検索機能
  - 目的  
    投稿のタイトル、概要、使用技術などから投稿を検索することができる
  - ユースケース  
    ユーザーが必要としている情報が載っている投稿を検索することができる
- AWSでのデプロイ
  - 目的  
    AWSを利用しアプリケーションをデプロイする
  - ユースケース  
    レスポンスがherokuより早いということでユーザーにストレスを軽減することができる

## データベース設計
![er図](/public/ymp_er.png)

# テーブル設計

## users テーブル

| Column             | Type        | Options     |
| ------------------ | ----------- | ------------|
| email              | string      | null: false |
| encrypted_password | string      | null: false |
| nickname           | string      | null: false |
| profile            | text        |             |


### Association

- has_many :posts
- has_many :comments
- has_many :likes


## posts テーブル

| Column                | Type          | Options           |
| --------------------- | ------------- | ----------------- |
| title                 | string        | null: false       |
| overview              | text          | null: false       |
| programming_languages | text          | null: false       |
| techs                 | text          | null: false       |
| portfolio_url         | string        | null: false       |
| github_url            | string        | null: false       |
| user                  | references    | foreign_key: true |


### Association

- belongs_to :user
- has_many :comments, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :post_tags, dependent: :destroy
- has_many :tags, through: :post_tags


## comments テーブル

| Column     | Type        | Options           |
| ---------- | ----------- | ----------------- |
| text       | text        | null :false       |
| user       | references  | foreign_key: true |
| post       | references  | foreign_key: true |


### Association

- belongs_to :post
- belongs_to :user


## likes テーブル

| Column     | Type        | Options           |
| ---------- | ----------- | ----------------- |
| user       | references  | foreign_key :true |
| post       | references  | foreign_key :true |


### Association

- belongs_to :post
- belongs_to :user


## tags テーブル

| Column     | Type        | Options           |
| ---------- | ----------- | ----------------- |
| tag_name   | references  | null: false       |


### Association

- has_many :post_tags, dependent: :destroy
- has_many :posts, through: :post_tags


## post_tags テーブル

| Column     | Type        | Options           |
| ---------- | ----------- | ----------------- |
| post       | references  | foreign_key :true |
| tag        | references  | foreign_key :true |


### Association

- belongs_to :post
- belongs_to :tag