# テーブル設計

## users テーブル

| Column           | Type   | Options  |
| ---------------- | ------ | -------- |
| nickname         | string | NOT NULL |
| email            | string | NOT NULL |
| password         | string | NOT NULL |
| family_name      | string | NOT NULL |
| first_name       | string | NOT NULL |
| family_name_kana | string | NOT NULL |
| first_name_kana  | string | NOT NULL |
| birth_year       | date   | NOT NULL |
| birth_month      | date   | NOT NULL |
| birth_day        | date   | NOT NULL |

### Association

- has_many :products
- has_many :product_purchase

## products テーブル

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| image         |            |                   |
| name          | string     | NOT NULL          |
| description   | string     | NOT NULL          |
| category      | string     | NOT NULL          |
| condition     | string     | NOT NULL          |
| shipping_cost | string     | NOT NULL          |
| prefecture    | string     | NOT NULL          |
| shipping_days | string     | NOT NULL          |
| price         | integer    | NOT NULL          |
| user_id       | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product_purchase

## product_purchase テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| user_id    | references | foreign_key: true |
| product_id | references | foreign_key: true |

### Association

- belongs_to :user
- has_many :products
- has_one :shipping_address

## shipping_address テーブル

| Column        | Type   | Options  |
| ------------- | ------ | -------- |
| postal code   | string | NOT NULL |
| prefecture    | string | NOT NULL |
| municipality  | string | NOT NULL |
| address       | string | NOT NULL |
| building name | string | NOT NULL |
| phone number  | string | NOT NULL |

### Association

- belongs_to :product_purchase
