# Claude Code 工作流指南

基於 Boris Cherny（Claude Code 創造者）的工作流，結合本專案設定。

## 核心原則

> "Probably the most important thing to get great results out of Claude Code: give Claude a way to verify its work. If Claude has that feedback loop, it will 2-3x the quality of the final result."
> — Boris Cherny

## 啟動設定

```bash
# 使用 Opus 4.5 + thinking（Boris 推薦）
claude --model opus

# 長時間任務：跳過權限提示
claude --dangerously-skip-permissions
```

## 工作流程

### 1. Plan Mode 優先

大多數任務先用 Plan Mode 規劃：

```
Shift+Tab+Tab  # 進入 Plan Mode
```

- 與 Claude 來回討論直到滿意計畫
- 切換到 auto-accept 模式執行
- 好的計畫 = Claude 一次完成

### 2. Slash Command

每天高頻使用：

```bash
/commit-push-pr    # 格式化 → 提交 → 推送 → 建立 PR
```

### 3. Subagents

完成功能後呼叫：

```
請使用 code-simplifier 簡化這段程式碼

請使用 verify-app 驗證 Recipe 模組

請使用 build-validator 檢查是否可部署

請使用 code-architect 設計這個功能的架構

請使用 log-analyzer 分析最近的錯誤

請使用 oncall-guide 處理這個生產問題
```

### 4. Ralph Loop（長時間自主任務）

基於 [Ralph Wiggum 插件](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum)，透過 Stop hook 創建迭代開發循環。

```bash
# 根據計劃實作
/ralph-loop:ralph-loop 根據計劃實作 --max-iterations 30 --completion-promise "COMPLETE"

# 多階段任務
/ralph-loop:ralph-loop "Phase 1: 用戶認證 (JWT, 測試)
Phase 2: 產品目錄 (列表/搜索)
Phase 3: 購物車功能

完成後輸出 <promise>COMPLETE</promise>" --max-iterations 50 --completion-promise "COMPLETE"

# TDD 開發
/ralph-loop:ralph-loop "實作功能 X：
1. 寫失敗的測試
2. 實作功能
3. 執行測試
4. 若失敗則修復
5. 重構
6. 完成後輸出 <promise>COMPLETE</promise>" --max-iterations 20 --completion-promise "COMPLETE"

# 取消
/ralph-loop:cancel-ralph

# 查看說明
/ralph-loop:help
```

**核心概念：**
- 提示詞在迭代間保持不變
- Claude 的工作持久保存在文件和 git 歷史中
- 每次迭代都能看到先前的修改
- Claude 透過讀取自身過去的工作自主改進

**最佳實踐：**
- 永遠設定 `--max-iterations`（建議 20-50）作為安全機制
- 定義清晰的完成標準
- 設定增量目標（Phase 1, 2, 3...）
- 用測試作為自動驗證機制

**適合場景：**
- 有明確成功標準的任務
- 需要迭代優化的任務（如通過測試）
- 有自動驗證的任務（測試、linter）

**不適合：**
- 需要人工判斷或設計決策的任務
- 成功標準不明確的任務

## 自動化 Hooks

已設定：
- **PostToolUse**：編輯 PHP 檔案後自動執行 `./vendor/bin/pint` 格式化
- **Notification**：Claude 需要輸入時發送 macOS 通知

## 平行工作

Boris 同時開 5 個 Claude 視窗：

```
Tab 1: 功能開發
Tab 2: 測試撰寫
Tab 3: 文件更新
Tab 4: Code Review
Tab 5: 備用
```

使用系統通知知道哪個需要輸入。

### 系統通知設定

已設定 Notification hook，當 Claude 需要輸入時會發送 macOS 通知。

**前置需求：**
```bash
brew install terminal-notifier
```

**macOS 設定（讓通知停留直到關閉）：**
```
系統設定 → 通知 → terminal-notifier → 通知樣式改為「提示」
```

## 權限管理

預先允許常用指令避免提示：

```bash
/permissions
```

設定儲存在 `.claude/settings.json`，團隊共用。

## CLAUDE.md 維護

當 Claude 犯錯時：
1. 記錄到 `CLAUDE.md` 的「常見錯誤」區塊
2. 使用 ❌/✅ 格式
3. 團隊共同維護

## 驗證迴圈（最重要）

每次變更都要驗證：

```
1. 寫程式碼
2. 執行測試 (php artisan test)
3. 檢查格式 (./vendor/bin/pint)
4. 使用 verify-app 驗證
5. 提交 (/commit-push-pr)
```

## 參考資源

- [Boris Cherny Twitter Thread](https://twitter-thread.com/t/2007179832300581177)
- [How Boris Uses Claude Code](https://paddo.dev/blog/how-boris-uses-claude-code/)
- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
