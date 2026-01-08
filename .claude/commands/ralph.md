# Generate Ralph Loop Command

根據用戶輸入生成 Ralph Loop 指令。

## 步驟

1. 詢問用戶以下資訊（使用 AskUserQuestion）：
   - 任務類型：根據計劃實作 / 自訂任務
   - 如果是自訂任務，詢問任務描述
   - 最大迭代次數（建議 20-50）

2. 根據回答生成 Ralph Loop 指令

## 指令格式

```bash
/ralph-loop:ralph-loop "<任務描述>" --max-iterations <次數> --completion-promise "COMPLETE"
```

## 範例輸出

### 根據計劃實作
```bash
/ralph-loop:ralph-loop 根據計劃實作 --max-iterations 30 --completion-promise "COMPLETE"
```

### 自訂任務
```bash
/ralph-loop:ralph-loop "實作用戶認證功能：
1. JWT token 驗證
2. 登入/登出 API
3. 測試覆蓋率 > 80%

完成後輸出 <promise>COMPLETE</promise>" --max-iterations 30 --completion-promise "COMPLETE"
```

## 注意事項

- 永遠設定 `--max-iterations` 作為安全機制
- 任務描述應包含明確的完成標準
- 建議先用 Plan Mode 規劃再執行
