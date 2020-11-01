# タスク管理アプリ

## バージョン情報
- Ruby 2.6.5
- Ruby on Rails 5.2.4
- PostgreSQL 12.4

## システムの要件
- [ ] 自分のタスクを登録したい
- [ ] タスクに終了期限を設定できるようにしたい
- [ ] タスクに優先順位をつけたい
- [ ] タスクのステータス（未着手・着手・完了）を管理したい
- [ ] ステータスでタスクを絞り込みたい
- [ ] タスク名でタスクを検索したい
- [ ] タスクを一覧で表示したい。
- [ ] 一覧画面で優先順位、終了期限を元にしてソートしたい
- [ ] タスクにラベルをつけて分類したい
- [ ] ユーザ登録し、自分が登録したタスクだけを見られるようにしたい

## サポートブラウザ
- macOS/Chrome各最新版を想定

## テーブル設計
### Userテーブル
|カラム名|データ型|
---|---
|name|string|
|email|string|
|password_digest|string|
|admin|boolean|

### Taskテーブル
|カラム名|データ型|
---|---
|title|string|
|content|text|
|deadline|datetime|
|priority|integer|
|status|integer|
|user_id|bigint|

### Task_labelテーブル
|カラム名|データ型|
---|---
|task_id|integer|
|label_id|integer|

### Labelテーブル
|カラム名|データ型|
---|---
|label_name|string|

## Herokuへのデプロイ手順
1. デプロイ前にコミット、アセットプリコンパイル

`git add -A`

`git commmit -m "任意のコメント"`

`rails assets:precompile RAILS_ENV=production`

2. Herokuにログイン

`heroku login`

3. Heroku上にアプリケーションを作成

`heroku create`

4. Heroku上にデプロイ

`git push heroku master`

5. データベースのマイグレーション

`heroku run rails db:migrate`
