# ActionCable Chat
ActionCable(Websocket)を利用した1対1のリアルタイム通信チャット
---
## 説明
- ユーザ登録
- テキストチャット
- メッセージログはデータベースに保存
- オンラインのユーザ一覧表示
- チャット中の相手以外からのメッセージを弱く通知

## 使い方
### インストール
`$ bundle install`  
`$ bundle exec rails`  
`$ bundle exec rails db:migrate`  

### 実行
`$ bundle exec rails s`

### アクセス
ブラウザから  
`localhost:3000`
