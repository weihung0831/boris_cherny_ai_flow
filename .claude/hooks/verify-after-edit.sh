#!/bin/bash
# PostToolUse 鉤子 - 編輯檔案後自動執行格式化
# 當 Write 或 Edit 工具執行後觸發

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# 只處理 PHP 檔案
if [[ "$FILE_PATH" == *.php ]]; then
  cd "$CLAUDE_PROJECT_DIR" 2>/dev/null || exit 0

  # 檢查 pint 是否存在
  if [ -f "./vendor/bin/pint" ]; then
    # 執行格式化（靜默模式）
    ./vendor/bin/pint "$FILE_PATH" --quiet 2>/dev/null || true
  fi
fi

exit 0
