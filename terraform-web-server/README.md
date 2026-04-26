# 🚀 AWS Web Server Deployment via Terraform

Terraformを使用して、AWS上にWebサーバー環境をコードで自動構築するプロジェクトです。

---

## 📐 ネットワーク構成 (Network Architecture)
- **VPC**: 10.0.0.0/16
- **Public Subnet**: 10.0.1.0/24
- **Security**: インターネットからHTTP(80番ポート)のみを許可し、サーバーの安全性を確保しています。

## ⚙️ 自動化スクリプト (User Data)
EC2起動時に以下の処理を自動実行するように設定しています：
1. OSパッケージのアップデート
2. Apache (httpd) のインストール
3. Webサービスの起動・有効化
4. テスト用HTMLファイルの作成

## ✒️ ネットワーク構成図 (System Architecture)

自分で設計したネットワークの全体像です。
ユーザーからインターネットを経由して、どのようにEC2サーバーへ辿り着くかのフローを可視化しました。

![System Architecture](./my-sketch-image.png)


### 図のポイント
- **Public Subnet**: インターネットから直接アクセス可能なエリアを定義。
- **Inbound Flow**: ユーザーからのHTTPリクエストがIGWを通ってEC2に到達する流れを矢印で記載。
- **Security Group**: サーバー直前で不要な通信をブロックしている様子を表現。


---

## 🏗 構築リソース一覧
コードを実行することで、以下のインフラ要素が自動生成されます。

### 🌐 Network
* **VPC**: 隔離された仮想ネットワーク環境の構築
* **Subnet**: パブリックサブネットの作成
* **Internet Gateway**: 外部通信用ゲートウェイの接続
* **Route Table**: インターネットへのルート配送設定

### 🛡️ Security
* **Security Group**: インバウンド(80/TCP)およびアウトバウンドの制御

### 💻 Compute
* **EC2 Instance**: Amazon Linux 2023 を使用した仮想サーバー
* **User Data**: シェルスクリプトによる Apache(httpd) の自動セットアップ

---

## ⚡ 実行環境
* **Terraform**: v1.14.9
* **Cloud Provider**: AWS (ap-northeast-1)
* **OS**: Amazon Linux 2023

---

## 📸 実行結果
構築後、ブラウザからパブリックIPにアクセスして以下の画面が表示されることを確認しました。

![Hello from Terraform](./terraform-web-server/Hello_from_Terraform..png)

---

## 🛠️ 使い方

1. **初期化**
   ```bash
   terraform init
