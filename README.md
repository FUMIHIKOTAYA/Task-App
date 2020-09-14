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

### Tagテーブル
|カラム名|データ型|
---|---
|task_id|bigint|
|genre_id|bigint|

### Genreテーブル
|カラム名|データ型|
---|---
|genre_name|string|
