// swift-tools-version: 5.6

import PackageDescription // Import the PackageDescription module

let package = Package( // Define a new package
    name: "UpgradeAlert", // Set the package name to "UpgradeAlert"
    platforms: [.iOS(.v15), .macOS(.v12)], // Set the supported platforms to iOS 15 and macOS 12
    products: [ // Define the products of the package
        .library( // Define a library product
            name: "UpgradeAlert", // Set the library name to "UpgradeAlert"
            targets: ["UpgradeAlert"]) // Set the library target to "UpgradeAlert"
    ],
    dependencies: [], // Set the package dependencies to an empty array
    targets: [ // Define the targets of the package
        .target( // Define a target
            name: "UpgradeAlert", // Set the target name to "UpgradeAlert"
            dependencies: []), // Set the target dependencies to an empty array
        .testTarget( // Define a test target
            name: "UpgradeAlertTests", // Set the test target name to "UpgradeAlertTests"
            dependencies: ["UpgradeAlert"]) // Set the test target dependencies to "UpgradeAlert"
    ]
)