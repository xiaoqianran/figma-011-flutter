# Learnings

Corrections, insights, and knowledge gaps captured during development.

**Categories**: correction | insight | knowledge_gap | best_practice

---

## [LRN-20260629-001] best_practice

**Logged**: 2026-06-29T16:50:00+08:00
**Priority**: high
**Status**: resolved
**Area**: config

### Summary
Dart 包名用下划线，显示名/仓库名可用连字符 figma-011

### Details
项目重命名时：`pubspec.yaml` 的 `name` 必须是 `figma_011`（Dart 不允许连字符），
而 GitHub 仓库、Pages URL、Web manifest 使用 `figma-011`。
`--base-href` 必须与 GitHub 仓库名一致：`/figma-011/`。

### Suggested Action
重命名 Flutter 项目时同步改：pubspec、import、Android/iOS bundle id、
deploy-pages.yml BASE_HREF、README Pages URL。

### Metadata
- Source: conversation
- Related Files: pubspec.yaml, .github/workflows/deploy-pages.yml
- Tags: rename, github-pages, dart

### Resolution
- **Resolved**: 2026-06-29
- **Commit/PR**: bc264c0
- **Notes**: 已完成重命名并验证 analyze/test

---

## [LRN-20260629-002] best_practice

**Logged**: 2026-06-29T16:50:00+08:00
**Priority**: high
**Status**: resolved
**Area**: frontend

### Summary
无后端 Demo 应用用 AppState + ParcelFlowState 串联全流程

### Details
Figma 复刻项目原先只有 UI 壳。补齐功能时：
- `AppState`（ChangeNotifier）：登录、资料、设置、聊天、通知、支付
- `ParcelFlowState`：计费/寄件路线、包裹、优惠码、金额
- `go_router` 的 `refreshListenable` + `redirect` 做登录守卫

### Suggested Action
新增交互时优先加状态方法，勿在 Widget 里直接改字段并调用 notifyListeners。

### Metadata
- Source: conversation
- Related Files: lib/core/services/app_state.dart, lib/core/services/parcel_flow_state.dart
- Tags: state-management, flutter, demo

### Resolution
- **Resolved**: 2026-06-29
- **Commit/PR**: ad6068b

---

## [LRN-20260629-003] best_practice

**Logged**: 2026-06-29T16:50:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: infra

### Summary
Windows 上优先用 Chrome Web 预览：`flutter run -d chrome --web-port=7357`

### Details
用户环境为 Windows；桌面原生构建需 VS C++ 工具链。
Web 预览足够覆盖 Figma 375×812 移动端 UI 开发与演示。

### Metadata
- Source: conversation
- Tags: flutter-web, windows, dev-workflow

### Resolution
- **Resolved**: 2026-06-29
- **Notes**: 用户明确要求记住 Web 版运行方式

---

## [LRN-20260629-004] best_practice

**Logged**: 2026-06-29T16:50:00+08:00
**Priority**: high
**Status**: resolved
**Area**: frontend

### Summary
ParcelFlowState 对外暴露 updateXxx() 方法，禁止 Widget 直接 notifyListeners()

### Details
在 feature 屏幕里写 `_flow.notifyListeners()` 会触发
`invalid_use_of_protected_member` 分析警告（fatal-infos 下 CI 失败）。

### Suggested Action
所有状态变更封装为 ParcelFlowState 的 public 方法（updateRoute、selectPackage 等）。

### Metadata
- Source: error
- Related Files: lib/core/services/parcel_flow_state.dart
- Tags: change-notifier, lint, flutter-analyze
- See Also: ERR-20260629-001

### Resolution
- **Resolved**: 2026-06-29
- **Commit/PR**: ad6068b

---
