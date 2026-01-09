# Maybow ERP

## 常用指令

```bash
composer dev              # 啟動開發環境
composer test             # 執行測試
./vendor/bin/pint         # 程式碼格式化
php artisan migrate:fresh --seed  # 重建資料庫
```

## Slash Commands

- `/commit-push-pr` - 格式化 → 提交 → 推送 → 建立 PR |
| `/squash-commits` | 將多個 commits 整理成一條 |
| `/merge-pr` | 在 main 分支合併 PR |
| `/translate-to-chinese` | 翻譯成繁體中文 |
| `/translate-to-english` | 翻譯成英文 |
| `/ralph` | 智能任務執行器 |

## 架構規則

**IMPORTANT**: 遵循 Controller → Service → Repository 分層

- **Controller** - 只處理 HTTP，呼叫 Service
- **Service** - 商業邏輯，用 `DB::transaction()` 包裝
- **Repository** - 只做資料存取，不含邏輯

## 命名規範

| 類型 | 規範 | 範例 |
|------|------|------|
| Controller | 單數 PascalCase | `RecipeController` |
| Service | 單數 + Service | `RecipeService` |
| Repository | 單數 + Repository | `RecipeRepository` |
| Request | Store/Update + Request | `StoreRecipeRequest` |
| 變數 | snake_case | `$recipe_data` |
| 布林變數 | is/has 前綴 | `$is_active` |

## 程式碼風格

- PSR-12 + Laravel Pint
- 方法需要類型宣告
- 使用 Form Request 驗證，不在 Controller 驗證
- Blade 元件用 kebab-case：`<x-breadcrumbs.recipe-breadcrumb />`

## 常見錯誤

### 1. Controller 寫商業邏輯
- ❌ Controller 內直接操作 Model
- ✅ 透過 Service 處理

### 2. 忽略交易處理
- ❌ 多個 DB 操作沒包 transaction
- ✅ 使用 `DB::transaction()`

### 3. Repository 寫邏輯
- ❌ Repository 內判斷商業規則
- ✅ Repository 只存取資料

### 4. 忘記格式化
- ❌ 提交未格式化程式碼
- ✅ 提交前執行 `./vendor/bin/pint`
