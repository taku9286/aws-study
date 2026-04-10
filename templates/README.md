# 📜 CloudFormation Templates

AWSのインフラ構成をコードとして管理（Infrastructure as Code）するためのテンプレートファイルを保管しています。

## 🛠 収録ファイル

- **[vpc-web-stack.yaml](./vpc-web-stack.yaml)**
  - VPC、サブネット、インターネットゲートウェイ、EC2、セキュリティグループをすべて一括で構築するためのメインテンプレートです。
  - **特徴**: `UserData` を利用して、インスタンス起動時に自動で Apache のインストールと設定を行うように設計しています。

- **[ec2-setup.yaml](./templates/ec2-setup.yaml)**
  - （過去の学習用）EC2インスタンス単体、または特定のパーツをテストするために使用したテンプレートです。

## 🚀 使い方
AWSコンソールの CloudFormation から、これらのファイルをアップロードすることで、数分で同じインフラ環境を自動作成できます。
