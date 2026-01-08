# Squash Commits

將當前分支的多個 commits 整理成一條。

## 步驟

1. 執行 `git log --oneline $(git merge-base HEAD main)..HEAD` 查看要整理的 commits
2. 根據 commits 內容產生符合規範的 commit message（`類型: 描述`），請用戶確認
3. 執行 `git reset --soft $(git merge-base HEAD main)`
4. 執行 `git commit -m "<message>"`
5. 詢問用戶是否確認要 push
6. 若確認，執行 `git push --force-with-lease`
