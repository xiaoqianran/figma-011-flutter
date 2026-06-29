# figma-011

基于 Figma 设计稿 **Fast Courier App**（Ui Design 页面，375×812 Light Version）复刻的 Flutter 快递应用。

在线预览（GitHub Pages）：**https://xiaoqianran.github.io/figma-011/**

## 项目简介

本项目将 Figma 中的用户流程逐屏实现为 Flutter 界面，覆盖从启动、引导、登录到寄件、追踪、聊天与设置的完整路径。默认以 **Web（Chrome）** 作为主要开发与预览平台。

| 项 | 说明 |
|---|---|
| 设计稿 | Figma — Fast Courier App / Ui Design |
| 画布尺寸 | 375 × 812 |
| 框架 | Flutter 3.44+ / Dart 3.12+ |
| 路由 | [go_router](https://pub.dev/packages/go_router) |
| 字体 | Merriweather + DM Sans（[google_fonts](https://pub.dev/packages/google_fonts)） |

## 功能页面

| 模块 | 路由 | 说明 |
|------|------|------|
| Splash | `/` | 启动页 |
| Onboarding | `/onboarding` | 引导 1/3、2/3、欢迎页 |
| Log In / Sign up | `/login`、`/sign-up` | 登录与注册 |
| Home | `/home` | 首页 |
| History | `/history` | 寄件历史 |
| Services | `/services-menu`、`/services` | 服务菜单与比价 |
| Nearby Courier | `/nearby-courier` | 附近快递员 |
| Track Order | `/track-order` | 订单追踪 |
| Calculate Parcel | `/calculate-parcel`、`/calculate-result` | 运费计算 |
| Ship Parcel | `/ship-parcel` 等 | 寄件流程 |
| Menu | `/menu` | 个人中心菜单 |
| Profile / FAQ / Help | `/profile`、`/faq`、`/help` | 资料、FAQ、帮助 |
| Chat | `/chat`、`/chat/:id` | 消息列表与对话 |
| Notification | `/notification` | 通知中心 |
| Payment / Security / Setting | `/payment`、`/security`、`/settings` | 菜单子页 |

## 设计 Token

| Token | 值 |
|-------|-----|
| Primary | `#F95A54` |
| Black 1 | `#141312` |
| Black 2 | `#23262F` |
| White 60% | `#FFFFFF99` |
| Green | `#3AC479` |
| Promo BG | `#FCE4E3` |

Token 定义见 `lib/core/theme/`。

## 本地开发

### 环境要求

- Flutter SDK（stable，建议 3.44+）
- Chrome 浏览器（Web 预览）

### 安装依赖

```bash
flutter pub get
```

### 运行（推荐 Web）

```bash
flutter run -d chrome --web-port=7357
```

浏览器访问：http://localhost:7357

常用入口：

- http://localhost:7357/#/home
- http://localhost:7357/#/menu
- http://localhost:7357/#/chat

终端内按 **R** 热重载，按 **q** 退出。

### 代码检查与测试

```bash
flutter analyze
flutter test
```

## 项目结构

```
lib/
  main.dart / app.dart
  core/
    theme/          # 颜色、字体、主题
    constants/      # 布局常量
    router/         # 路由与底部导航
  shared/
    widgets/        # 通用组件
    models/         # 共享模型
  features/         # 按功能划分的页面
assets/images/      # 图片资源
test/               # Widget 测试
```

## CI / CD

本项目使用 GitHub Actions：

| 工作流 | 触发 | 作用 |
|--------|------|------|
| [CI](.github/workflows/ci.yml) | `push` / `pull_request` → `master` | `flutter analyze` + `flutter test` |
| [Deploy Pages](.github/workflows/deploy-pages.yml) | `push` → `master` / 手动 | 构建 Web 并部署到 GitHub Pages |

### GitHub Pages 部署说明

1. 仓库 **Settings → Pages → Build and deployment → Source** 选择 **GitHub Actions**
2. 推送到 `master` 后自动触发 `Deploy Pages` 工作流
3. 部署地址：`https://xiaoqianran.github.io/figma-011/`

构建时使用 `--base-href /figma-011/`，以适配 GitHub Pages 项目站点路径。

## 提交规范

提交信息遵循 [Conventional Commits](https://www.conventionalcommits.org/) 风格：

```plaintext
<type>: <subject>

<body>（可选）
```

常用 type：`feat`、`fix`、`docs`、`test`、`chore`、`refactor`

示例：

```plaintext
feat: 实现 Chat / Notification 页面

根据 Figma 516:6460 / 516:6567 还原消息列表与通知中心。
```

## 许可证

本项目仅供学习与演示使用。Figma 设计稿版权归原作者所有。