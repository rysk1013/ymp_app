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