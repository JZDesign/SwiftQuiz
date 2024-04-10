// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftQuiz",
    platforms: [.iOS(.v16), .macOS(.v14)],
    products: [
        .library(
            name: "SwiftQuiz",
            targets: ["SwiftQuiz"]),
    ],
    targets: [
        .target(
            name: "SwiftQuiz"),
        .testTarget(
            name: "SwiftQuizTests",
            dependencies: ["SwiftQuiz"]),
    ]
)
