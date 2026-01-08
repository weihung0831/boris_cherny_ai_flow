# Commit, Push and Create PR

執行完整的提交流程：格式化程式碼、提交、推送、建立 PR。

## 步驟

1. 執行 `./vendor/bin/pint` 格式化程式碼
2. 檢查 `git status` 確認變更
3. 將所有變更加入暫存區
4. 根據變更內容產生符合規範的 commit message（繁體中文），請用戶確認
5. 詢問用戶要推送到哪個分支或建立新分支，然後推送
6. 使用 `gh pr create` 建立 PR，包含：
   - 標題：簡潔描述變更
   - 內容：變更摘要

## 注意事項

- Commit message 格式：`類型: 描述`（如 `feat: 新增配方匯出功能`）
- 類型：feat, fix, refactor, test, docs, chore
- PR 描述使用繁體中文
