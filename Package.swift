// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "testframework",
    platforms: [
        .iOS(.v12), // Specify the minimum platform version
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "testframework",
            targets: ["testframework"]),
    ],
    dependencies: [.package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.0"),],
    targets: [
        .target(
            name: "testframework",
            dependencies: [
                "Alamofire"
            ]
        ),
        .testTarget(
            name: "testframeworkTests",
            dependencies: ["testframework"]),  // List dependencies if any
    ]
)

