// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "UpgradeAlert", // Set the name of the package
    platforms: [.iOS(.v15), .macOS(.v12)], // Set the supported platforms
    products: [
        .library(
            name: "UpgradeAlert", // Set the name of the library
            targets: ["UpgradeAlert"]) // Set the library target
    ],
    dependencies: [], // Set the package dependencies
    targets: [
        .target(
            name: "UpgradeAlert", // Set the target name
            dependencies: []), // Set the target dependencies
        .testTarget(
            name: "UpgradeAlertTests", // Set the test target name
            dependencies: ["UpgradeAlert"]) // Set the test target dependencies
    ]
)
/*,*/
/*swiftLanguageVersions: [.v5],*/
/*url: "https://github.com/sentryco/UpgradeAlert",*/
/*description: "A Swift package for showing upgrade alerts."*/

