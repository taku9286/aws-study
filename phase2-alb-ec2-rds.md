
# AWS IaC 実習: 高可用性3層アーキテクチャの自動構築 (Phase 2)

## 📌 プロジェクト概要
本プロジェクトでは、AWS CloudFormation（IaC）を用いて、スケーラビリティと高可用性を備えたWebインフラを自動構築しました。手動構築での経験を活かし、コードによる再現性と正確性を重視した設計を行っています。

## 🏗 アーキテクチャ構成
[ここに構成図の画像を挿入する予定]

- **Public Subnets**: 2つのAvailability Zone（AZ）に跨るマルチAZ構成
- **ALB (Application Load Balancer)**: 外部からのトラフィックを分散
- **EC2 (Web Server)**: Amazon Linux 2023を使用し、Apacheを起動
- **RDS (Database)**: MySQL 8.0。Multi-AZ構成により高い耐障害性を確保

## 🛠 技術的アピールポイント
- **動的なAMI IDの取得**: 
  - SSMパラメータストア（`/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64`）を参照し、構築のたびに最新のAmazon Linux 2023イメージを自動取得するように設計。
- **セキュリティグループの連鎖（Chaining）**: 
  - 外部からはALB（Port 80）のみを許可。
  - EC2へはALBからの通信のみを許可。
  - RDSへはEC2からの通信のみを許可。
  - セキュリティグループを「ID」で参照し合うことで、最小権限の原則（Least Privilege）を徹底。
- **マルチAZによる高可用性**: 
  - ALB、EC2、RDSの各レイヤーでAZを分散し、データセンター障害にも耐えうる構成を実現。

## 🚀 克服したトラブルシューティング
本環境の構築過程で、実務に直結する以下の課題を自力で解決しました。

| 事象 | 原因 | 解決策 |
| :--- | :--- | :--- |
| **スタック作成エラー (AMI ID)** | 指定したAMI IDがリージョン内で古くなっていた | SSMパラメータストアを用いた動的取得に変更 |
| **無料枠制限によるロールバック** | Multi-AZやバックアップ保持期間の設定が無料枠の上限を超過 | パラメータを無料枠内に収まるよう調整し再試行 |
| **502 Bad Gateway** | インフラは正常だがEC2内部でWebサーバーが未起動 | SSH接続（EC2 Instance Connect）にてApacheを導入・起動し解消 |
| **接続タイムアウト (SSH)** | インスタンスへのパブリックIP付与設定の不足 | テンプレートに `AssociatePublicIpAddress: true` を追記 |

## 📈 今後の課題
- Route53を用いた独自ドメインの適用とHTTPS化。
- Auto Scalingグループの導入による、負荷に応じたサーバーの自動増減の検証。

## 🛠 使用ツール
- AWS CloudFormation (YAML)
- AWS CLI / EC2 Instance Connect
- Apache (Web Server)
