# 🚀 AWS EC2 Webサーバー構築プロジェクト

CloudFormation（IaC）を使用したVPC環境の自動構築と、Webサーバー公開の記録です。

## 🏗️ システム構成図
プロジェクトで設計・構築したインフラの全体像です。

* **[システム構成図1.drawio.png](./images/システム構成図1.drawio.png)**
* **[システム構成図2.drawio.png](./images/システム構成図2.drawio.png)**

---

## 🛠️ トラブルシューティング
構築の過程で直面した課題と、それをどう解決したかの記録です。

| 課題 | 原因 | 解決策 |
| :--- | :--- | :--- |
| **スタックのロールバック** | インスタンスタイプ（t2.micro）の制限 | **t3.micro** への変更 |
| **接続エラー (SSH)** | 鍵の権限・パス指定のミス | **EC2 Instance Connect** の活用 |
| **パブリックIP未付与** | VPC/サブネットの設定不足 | **自動割り当て設定を有効化** して再作成 |

---

## 📸 Evidence Images (構築の証拠)

リポジトリ内の `images` フォルダに保管されているエビデンス一覧です。

### 🏆 構築成功エビデンス
* **[success.png](./images/success.png)** Apacheのデフォルトページ表示確認。
* **[success ! .png](./images/success%20!%20.png)** 「Welcome to My Own VPC!」の表示成功記録。
* **[hello-world-screenshot.png](./images/hello-world-screenshot.png)** 「Hello World! I am an IT Engineer!」の表示成功画面。
* **[ec2_instance_success.png](./images/ec2_instance_success.png)** EC2インスタンスが正常に稼働しているコンソール画面。

### ⚙️ AWSコンソール・ログ
* **[2026-04-05 CREATE_COMPLETE.png](./images/2026-04-05%20CREATE_COMPLETE.png)** CloudFormationの構築完了（CREATE_COMPLETE）ログ。
* **[2026-0405 ログインログ.png](./images/2026-0405%20%E3%83%AD%E3%82%B0%E3%82%A4%E3%83%B3%E3%83%AD%E3%82%B0.png)** SSHログインおよびOS内での操作ログ。

---

## 💡 学んだこと
* **ログ分析**: `CREATE_FAILED` の原因をイベントタブから特定する重要性。
* **コスト意識**: 構築確認後、即座にスタックを削除し不要な課金を防止。
* **IaCの利点**: コード（YAML）を修正するだけで、何度でも同じ環境を正確に再現できる効率性。

---

### 📝 運用上の注意
> [!IMPORTANT]
> 画像ファイル名にスペースや記号（`!` など）が含まれているため、リンクはGitHubの仕様に合わせた形式（`%20` 等）で記述しています。
