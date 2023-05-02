# californicus

## 概要
* 以下の機能群から構成されるRuby on Railsで書かれたウェブシステム
  * 学進会の生徒の保護者が子供の学習状況や成績を確認できる機能
  * システム管理者が生徒や出席の管理を行うことができる機能

## システム要件
* 開発環境、ステージング環境、本番環境はいずれもDockerでの運用を行う
* Docker version 20.10.24
* docker-compose version 2.17.2

## 開発環境の構築
```
$ docker-compose build
$ docker-compose run rails bundle exec rails db:migrate:reset db:seed
```
