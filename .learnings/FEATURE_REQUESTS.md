# Feature Requests

Capabilities requested by the user.

---

## [FEAT-20260629-001] complete_all_page_functionality

**Logged**: 2026-06-29T16:50:00+08:00
**Priority**: high
**Status**: resolved
**Area**: frontend

### Requested Capability
完善所有页面未完成的功能（表单、导航、状态、支付、聊天等）

### User Context
Figma 复刻完成后，UI 可浏览但按钮/表单多为空实现，需要可走完 demo 全流程。

### Complexity Estimate
complex

### Suggested Implementation
AppState + ParcelFlowState + 路由守卫 + 各屏 StatefulWidget 交互

### Metadata
- Frequency: first_time
- Related Features: auth, ship_parcel, track_order, chat

### Resolution
- **Resolved**: 2026-06-29
- **Commit/PR**: ad6068b
- **Notes**: 地图/扫码/真实 API 仍用 SnackBar 或占位模拟

---
