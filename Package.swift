// swift-tools-version:5.5

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/2022.
//  All code (c) 2022 - present day, Sam Deane.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import PackageDescription

let package = Package(
    name: "BinaryCoding",
    platforms: [
        .macOS(.v12), .iOS(.v15), .tvOS(.v15), .watchOS(.v8)
    ],
    products: [
        .library(
            name: "BinaryCoding",
            targets: ["BinaryCoding"]),
    ],
    dependencies: [
        .package(url: "https://github.com/elegantchaos/Bytes.git", .branch("float-support")),
        .package(url: "https://github.com/elegantchaos/XCTestExtensions.git", from: "1.4.4")
    ],
    targets: [
        .target(
            name: "BinaryCoding",
            dependencies: ["Bytes"]),
        .testTarget(
            name: "BinaryCodingTests",
            dependencies: ["BinaryCoding", "XCTestExtensions"]),
    ]
)
