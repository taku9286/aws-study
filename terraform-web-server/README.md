# 🚀 AWS Web Server Deployment via Terraform

Terraformを使用して、AWS上にWebサーバー環境をコードで自動構築するプロジェクトです。

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
