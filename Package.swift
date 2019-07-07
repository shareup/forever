// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Forever",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v5),
    ],
    products: [
        .library(
            name: "Forever",
            targets: ["Forever"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Forever",
            dependencies: []),
        .testTarget(
            name: "ForeverTests",
            dependencies: ["Forever"]),
    ]
)
