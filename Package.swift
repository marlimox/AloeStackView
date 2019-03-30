// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "AloeStackView",
    products: [
        .library(
            name: "AloeStackView", 
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
