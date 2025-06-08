# Flutter Todo App

SQLiteを使用したクロスプラットフォーム対応のTodoアプリケーションです。Flutter、Provider、SQLiteを組み合わせて、効率的なデータ管理と状態管理を実現しています。

## 📱 主要機能

- ✅ Todoの追加・編集・削除
- 🔄 完了状態の切り替え
- 📋 未完了/完了済みTodoの分類表示
- 💾 SQLiteによるデータの永続化
- 🌐 クロスプラットフォーム対応（iOS、Android、Windows、macOS、Linux、Web）
- 📱 レスポンシブデザイン（NavigationRail使用）

## 🛠 技術スタック

### フレームワーク・言語
- **Flutter**: 3.x
- **Dart**: 2.19.4以上

### 主要パッケージ
- **provider**: ^6.0.0 - 状態管理
- **sqflite**: ^2.3.0 - SQLite（モバイル）
- **sqflite_common_ffi**: ^2.3.0 - SQLite（デスクトップ）
- **path**: ^1.8.3 - ファイルパス操作

### アーキテクチャパターン
- **Repository Pattern**: データアクセス層の抽象化
- **Provider Pattern**: 状態管理とリアクティブUI
- **Singleton Pattern**: データベース接続管理
- **レイヤードアーキテクチャ**: 関心の分離

## 📁 プロジェクト構造

```
lib/
├── main.dart                    # アプリケーションエントリーポイント
├── models/
│   └── todo.dart               # Todoデータモデル
├── providers/
│   └── todo_app_state.dart     # アプリケーション状態管理
├── services/
│   ├── database_service.dart   # SQLite低レベル操作
│   └── todo_repository.dart    # データアクセス層
├── screens/
│   ├── todo_home_page.dart     # メイン画面（ナビゲーション）
│   ├── todo_list_page.dart     # Todo一覧画面
│   └── completed_todos_page.dart # 完了済みTodo画面
└── widgets/
    └── add_todo_dialog.dart    # Todo追加ダイアログ

android/                        # Android固有設定
ios/                            # iOS固有設定
macos/                          # macOS固有設定
windows/                        # Windows固有設定
linux/                          # Linux固有設定
web/                            # Web固有設定
```

## 🏗 アーキテクチャ詳細

### データフロー
```
UI Layer (Screens/Widgets)
    ↕ (Provider)
State Management (TodoAppState)
    ↕ (Repository)
Data Access Layer (TodoRepository)
    ↕ (Service)
Database Layer (DatabaseService)
    ↕ (SQLite)
Persistent Storage
```

### 各レイヤーの責任

#### 1. **UI Layer** (`screens/`, `widgets/`)
- ユーザーインターフェースの描画
- ユーザーインタラクションの処理
- 状態の監視と表示

#### 2. **State Management** (`providers/`)
- アプリケーション状態の管理
- UIへの変更通知
- ビジネスロジックの調整

#### 3. **Data Access Layer** (`services/todo_repository.dart`)
- データ操作の抽象化
- ビジネスロジックの実装
- データ変換処理

#### 4. **Database Layer** (`services/database_service.dart`)
- SQLite操作の実装
- データベース接続管理
- CRUD操作の提供

## 🗄 データベース設計

### テーブル構造

#### `todos` テーブル
| カラム名 | データ型 | 制約 | 説明 |
|---------|---------|------|------|
| id | TEXT | PRIMARY KEY | 一意識別子 |
| title | TEXT | NOT NULL | Todo内容 |
| isCompleted | INTEGER | NOT NULL | 完了状態（0/1） |
| createdAt | INTEGER | NOT NULL | 作成日時（ミリ秒） |

### SQL定義
```sql
CREATE TABLE todos (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  isCompleted INTEGER NOT NULL,
  createdAt INTEGER NOT NULL
)
```

## 🚀 セットアップ手順

### 前提条件
- Flutter SDK 3.x以上
- Dart 2.19.4以上
- 各プラットフォームの開発環境

### インストール

1. **リポジトリのクローン**
```bash
git clone <repository-url>
cd flutter_tutorial
```

2. **依存関係のインストール**
```bash
flutter pub get
```

3. **アプリケーションの実行**
```bash
# デバッグモードで実行
flutter run

# 特定のプラットフォームで実行
flutter run -d windows
flutter run -d macos
flutter run -d chrome
```

## 📖 使用方法

### 基本操作

1. **Todoの追加**
   - 右下の「+」ボタンをタップ
   - ダイアログにTodo内容を入力
   - 「追加」ボタンで保存

2. **Todoの完了**
   - Todo項目のチェックボックスをタップ
   - 完了済みTodoは「完了済み」タブで確認

3. **Todoの削除**
   - Todo項目の削除ボタン（ゴミ箱アイコン）をタップ

4. **画面切り替え**
   - 左側のナビゲーションレールで画面を切り替え
   - 「Todo一覧」: 未完了のTodo表示
   - 「完了済み」: 完了済みのTodo表示

## 🔧 開発者向け情報

### 主要クラス説明

#### `Todo` (models/todo.dart)
```dart
class Todo {
  final String id;           // 一意識別子
  final String title;        // Todo内容
  final bool isCompleted;    // 完了状態
  final DateTime createdAt;  // 作成日時
  
  // データベース変換メソッド
  Map<String, dynamic> toMap();
  factory Todo.fromMap(Map<String, dynamic> map);
}
```

#### `DatabaseService` (services/database_service.dart)
- シングルトンパターンでデータベース接続を管理
- クロスプラットフォーム対応（FFI使用）
- CRUD操作の提供

#### `TodoRepository` (services/todo_repository.dart)
- データアクセスの抽象化
- ビジネスロジックの実装
- DatabaseServiceのラッパー

#### `TodoAppState` (providers/todo_app_state.dart)
- Provider使用の状態管理
- 非同期データ操作
- UI更新の通知

### 機能拡張方法

#### 新しいフィールドの追加
1. `Todo`モデルにフィールド追加
2. `toMap()`/`fromMap()`メソッド更新
3. データベーススキーマ更新（バージョンアップ）
4. UI更新

#### 新しい画面の追加
1. `screens/`に新しいページ作成
2. `TodoHomePage`にナビゲーション追加
3. 必要に応じて状態管理更新

## 🧪 テスト

### 単体テスト実行
```bash
flutter test
```

### 統合テスト実行
```bash
flutter test integration_test/
```

## 📱 対応プラットフォーム

| プラットフォーム | 状態 | 備考 |
|----------------|------|------|
| Android | ✅ 対応 | API 21以上 |
| iOS | ✅ 対応 | iOS 11以上 |
| Windows | ✅ 対応 | Windows 10以上 |
| macOS | ✅ 対応 | macOS 10.14以上 |
| Linux | ✅ 対応 | Ubuntu 18.04以上 |
| Web | ✅ 対応 | モダンブラウザ |

## 🔄 今後の改善予定

- [ ] カテゴリ機能の追加
- [ ] 期限設定機能
- [ ] 検索・フィルタ機能
- [ ] データのエクスポート/インポート
- [ ] ダークモード対応
- [ ] 多言語対応
- [ ] クラウド同期機能

## 📄 ライセンス

このプロジェクトはMITライセンスの下で公開されています。

## 🤝 コントリビューション

1. このリポジトリをフォーク
2. 機能ブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'Add some amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. プルリクエストを作成

## 📞 サポート

問題や質問がある場合は、GitHubのIssuesページで報告してください。

---

**開発者**: Flutter Tutorial Project  
**バージョン**: 0.0.1+1  
**最終更新**: 2025年6月8日
