// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "pwdi",
    platforms: [
      .macOS(.v10_10), .iOS(.v9), .tvOS(.v9)
    ],
    products: [
        .library(
            name: "pwdi",
            targets: ["pwdi"])
    ],
    dependencies: [
        .package(name: "FregaderoDeCocina", url: "https://github.com/pedantix/fregadero-de-cocina", from: "0.0.2"),
        .package(name: "Nimble", url: "https://github.com/Quick/Nimble.git", from: "8.1.2")
    ],
    targets: [
        .target(
            name: "pwdi",
            dependencies: ["FregaderoDeCocina"]),
        .testTarget(
            name: "pwdiTests",
            dependencies: ["pwdi", "Nimble"])
    ]
)
