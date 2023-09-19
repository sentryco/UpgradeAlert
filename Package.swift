// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "UpgradeAlert",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "UpgradeAlert",
            targets: ["UpgradeAlert"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "UpgradeAlert",
            dependencies: []),
        .testTarget(
            name: "UpgradeAlertTests",
            dependencies: ["UpgradeAlert"])
    ],
    /*swiftLanguageVersions: [.v5],*/
    url: "https://github.com/sentryco/UpgradeAlert",
    description: "A Swift package for showing upgrade alerts."
)