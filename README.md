# ligang · Aurora

高端智能电瓶车 iOS 前端原型，使用 SwiftUI、SF Symbols 与系统 Material 构建。

## 运行

1. 将 `Config.example.xcconfig` 复制为 `Config.xcconfig`。
2. 在 `Config.xcconfig` 中设置 `APP_BEARER_TOKEN`。
3. 使用 Xcode 16 或更新版本打开 `ligang.xcodeproj`，选择 iOS 17+ 模拟器运行。

工程包含首页、骑行、骑行详情、地图、HomeKit、我的、设置，以及 Live Activity、Widget、Apple Watch 与 CarPlay 的界面方案。所有业务数据目前为 Mock Data。

## GitHub Actions

工作流会构建无签名 IPA 并上传为 Artifact。若要生成可安装或发布的 IPA，需要在仓库 Secrets 中配置 Apple Developer 证书、Provisioning Profile 与签名参数。

后端 Token 不会提交到仓库。在 GitHub 仓库中创建名为 `APP_BEARER_TOKEN` 的 Actions Secret，工作流会在构建时注入。
