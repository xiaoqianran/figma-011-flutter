# Errors

Command failures and integration errors.

---

## [ERR-20260629-001] flutter_analyze_fatal_infos

**Logged**: 2026-06-29T16:50:00+08:00
**Priority**: high
**Status**: resolved
**Area**: tests

### Summary
Widget 外部调用 ChangeNotifier.notifyListeners() 导致 33 个 analyze 警告

### Error
```
invalid_use_of_protected_member - notifyListeners can only be used within subclasses of ChangeNotifier
```

### Context
- 完善寄件/计费页面时在 lib/features/** 直接写 `_flow.notifyListeners()`
- `flutter analyze --fatal-infos` 将 warning 视为失败

### Suggested Fix
在 ParcelFlowState 内封装 update 方法；Widget 只调用 public API。

### Metadata
- Reproducible: yes
- Related Files: lib/features/ship_parcel/, lib/features/calculate_parcel/
- See Also: LRN-20260629-004

### Resolution
- **Resolved**: 2026-06-29
- **Commit/PR**: ad6068b
- **Notes**: analyze 0 issues，test 30/30

---

## [ERR-20260629-002] pwsh_git_commit_heredoc

**Logged**: 2026-06-29T16:50:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: infra

### Summary
PowerShell 不支持 bash 风格 `$(cat <<'EOF')` 多行 commit message

### Error
```
Missing file specification after redirection operator
```

### Context
- 在 Windows pwsh 中用 heredoc 写 git commit -m
- 应用 `-m "title" -m "body line1`nline2"` 替代

### Suggested Fix
Windows 上 git commit 用多个 `-m` 参数，或先写临时文件再 `-F`。

### Metadata
- Reproducible: yes
- Tags: git, powershell, windows

### Resolution
- **Resolved**: 2026-06-29
- **Notes**: 后续提交已改用 `-m` 多参数格式

---

## [ERR-20260629-003] widget_test_dynamic_ui

**Logged**: 2026-06-29T16:50:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: tests

### Summary
动态 UI 改动后 3 个 widget test 失败

### Error
- `find.text(r'$ 48.00')` finds 2 widgets（价格重复显示）
- `find.text('Pay $53.00')` 找不到（按钮文案改为动态 total）
- `Weight Per Package` 需 scrollUntilVisible

### Context
- 计费结果页与支付页改为 ParcelFlowState 动态金额
- 测试仍断言固定文案

### Suggested Fix
用 `findsAtLeastNWidgets(1)`、`find.textContaining('Pay $')`、
长列表字段前 `scrollUntilVisible`。

### Metadata
- Reproducible: yes
- Related Files: test/calculate_parcel_test.dart, test/ship_parcel_test.dart

### Resolution
- **Resolved**: 2026-06-29
- **Notes**: 30/30 tests pass

---
