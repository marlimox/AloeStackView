// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "AloeStackView",
    platforms: [
       .iOS(.v9),
    ],
    products: [
        .library(
            name: "AloeStackView", 
            targets: ["AloeStackView"]),
        .library(
            name: "AloeStackViewDynamic",
            type: .dynamic,
            targets: ["AloeStackView"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AloeStackView", 
            dependencies: [],
            path: "Sources"),
    ]
)
