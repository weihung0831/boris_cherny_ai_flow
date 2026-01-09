# Ralph - 智能任務執行器

根據用戶輸入，分析任務並生成最適合的 Ralph Loop 指令。

## 你的任務

分析用戶需求 `$ARGUMENTS`，然後：

1. **快速探索**相關程式碼，理解現有架構
2. **設計**明確的完成標準和驗證方式
3. **生成** `/ralph-loop:ralph-loop` 指令供用戶執行
4. **執行**指令後，確保任務完成

## 生成指令模板

**重要**：
- 指令必須是單行格式，不可換行！
- **選項必須放在前面**，任務描述放在最後
- **不使用引號**包裹任務描述（避免參數解析問題）

根據任務複雜度，生成以下格式的指令：

```
/ralph-loop:ralph-loop --max-iterations <n> --completion-promise COMPLETE <任務描述>。需求：<需求1>；<需求2>。完成標準：<標準1>；<標準2>；執行 composer test 確認測試通過；執行 ./vendor/bin/pint 格式化程式碼；完成前至少迭代 3 次確認所有標準達成。當所有標準都達成時，輸出 <promise>COMPLETE</promise>
```

## 參數建議

**重要**：你**必須**根據任務複雜度選擇適當的 `--max-iterations` 值

| 任務複雜度 | `--max-iterations` | 判斷標準 |
|-----------|-------------------|---------|
| 簡單修復 | 10 | 單一檔案修改、移除欄位、修復小 bug |
| 一般功能 | 15-20 | 多檔案修改、新增簡單功能、重構 |
| 複雜功能 | 25-35 | 新增完整 CRUD、跨模組功能 |
| 大型功能 | 40-50 | 新增模組、架構變更、複雜業務邏輯 |

### 判斷複雜度的依據
- **檔案數量**：修改 1-2 個檔案 → 簡單；3-5 個 → 一般；6+ 個 → 複雜
- **測試需求**：不需新測試 → 簡單；需補測試 → 一般；需完整測試覆蓋 → 複雜
- **業務邏輯**：純 UI 調整 → 簡單；有驗證邏輯 → 一般；複雜計算/流程 → 複雜

## 提示編寫要點

### 好的提示特徵
- 明確的需求描述
- 可驗證的完成標準
- 包含測試和格式化要求
- 清楚的 `<promise>COMPLETE</promise>` 輸出條件
- **至少迭代 3 次**後才宣告完成

### 範例：簡單修復（--max-iterations 10）
```
/ralph-loop:ralph-loop --max-iterations 10 --completion-promise COMPLETE 修復 navbar logo 在系統設定移除後仍然顯示的問題。需求：當系統設定中沒有 logo 時 navbar 不應顯示 logo；確保 logo 的顯示邏輯一致。完成標準：navbar 正確反映系統設定的 logo 狀態；執行 composer test 確認測試通過；執行 ./vendor/bin/pint 格式化程式碼；完成前至少迭代 3 次確認所有標準達成。當所有標準都達成時，輸出 <promise>COMPLETE</promise>
```

### 範例：一般功能（--max-iterations 20）
```
/ralph-loop:ralph-loop --max-iterations 20 --completion-promise COMPLETE 新增客戶備註功能。需求：在客戶編輯頁面新增備註欄位；備註可多行輸入最多 1000 字；遵循現有架構。完成標準：備註欄位正確顯示和儲存；驗證規則正確；執行 composer test 確認測試通過；執行 ./vendor/bin/pint 格式化程式碼；完成前至少迭代 3 次確認所有標準達成。當所有標準都達成時，輸出 <promise>COMPLETE</promise>
```

### 範例：複雜功能（--max-iterations 35）
```
/ralph-loop:ralph-loop --max-iterations 35 --completion-promise COMPLETE 實作用戶權限管理功能。需求：建立權限 CRUD 功能；整合現有的用戶系統；遵循 Controller → Service → Repository 架構。完成標準：所有 CRUD 端點正常運作；有對應的測試覆蓋；執行 composer test 確認測試通過；執行 ./vendor/bin/pint 格式化程式碼；完成前至少迭代 3 次確認所有標準達成。當所有標準都達成時，輸出 <promise>COMPLETE</promise>
```

## 立即行動

分析以下任務，探索相關程式碼，然後生成適合的 `/ralph-loop:ralph-loop` 指令：

$ARGUMENTS

## 確認執行

生成指令後，**必須**詢問用戶是否要執行該指令。

**重要規則：**
- 必須等待用戶明確回覆「是」、「好」、「執行」等確認詞彙
- 在用戶確認之前，**絕對不可以**執行指令
- 如果 stop hook 觸發，繼續等待用戶確認，不要自動執行
- 用戶確認後，**必須**提醒用戶按 `Shift+Tab` 切換到自動模式（Auto-accept），然後才執行指令

## 任務結束處理

**重要**：在輸出 `<promise>COMPLETE</promise>` 後，**必須立即**執行以下指令來取消 Ralph Loop：

```
/ralph-loop:cancel-ralph
```

這確保 loop 正確結束，避免 stop hook 持續觸發。

