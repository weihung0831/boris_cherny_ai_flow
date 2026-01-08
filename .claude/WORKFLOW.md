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

```bash
/ralph-loop:ralph-loop "實作功能 X，完成後輸出 <promise>COMPLETE</promise>" \
  --max-iterations 30 \
  --completion-promise "COMPLETE"

# 取消
/ralph-loop:cancel-ralph
```

**最佳實踐：**
- 永遠設定 `--max-iterations`
- 明確定義完成條件
- 用測試作為驗證機制

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
