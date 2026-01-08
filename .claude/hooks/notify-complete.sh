#!/bin/bash
# Claude 完成時發送 macOS 通知中心通知

terminal-notifier \
  -title "Claude Code" \
  -message "Claude 需要你的輸入" \
  -sound Glass \
  -ignoreDnD
