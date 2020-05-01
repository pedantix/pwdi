// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "pwdi",
    products: [
        .library(
            name: "pwdi",
            targets: ["pwdi"])
    ],
    dependencies: [
        .package(name: "FregaderoDeCocina", url: "https://github.com/pedantix/fregadero-de-cocina", from: "0.0.2"),
        .package(name: "Nimble", url: "https://github.com/Quick/Nimble.git", from: "8.0.1"),
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
