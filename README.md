# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| family_name        | string | null: false               |
| first_name         | string | null: false               |
| family_name_kana   | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_day          | date   | null: false               |

### Association

- has_many :products
- has_many :product_purchases

## products テーブル

| Column           | Type       | Options           |
| ---------------- | ---------- | ----------------- |
| name             | string     | null: false       |
| description      | text       | null: false       |
| category_id      | integer    | null: false       |
| condition_id     | integer    | null: false       |
| shipping_cost_id | integer    | null: false       |
| prefecture_id    | integer    | null: false       |
| shipping_day_id  | integer    | null: false       |
| price            | integer    | null: false       |
| user             | references | foreign_key: true |

### Association

- belongs_to :user
- has_one :product_purchase

## product_purchases テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| user       | references | foreign_key: true |
| product    | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product
- has_one :shipping_address

## shipping_addresses テーブル

| Column        | Type    | Options     |
| ------------- | ------- | ----------- |
| postal_code   | string  | null: false |
| prefecture_id | integer | null: false |
| municipality  | string  | null: false |
| address       | string  | null: false |
| building_name | string  |             |
| phone_number  | string  | null: false |

### Association

- belongs_to :product_purchase
