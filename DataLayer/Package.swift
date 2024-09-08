// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataLayer",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DataLayer",
            targets: ["DataLayer"]),
    ],
    dependencies: [
        .package(
            name: "Firebase",
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            from: "10.28.1"
        ),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", branch: "master")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DataLayer",
            dependencies: [
                "KeychainAccess",
                .product(name: "FirebaseFirestore", package: "Firebase"),
                .product(name: "FirebaseAuth", package: "Firebase"),
//                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
            ]
//            dependencies: [
//                .product(name: "FirebaseCore", package: "firebase-ios-sdk"),
//                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
//                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
//            ]
        ),
        .testTarget(
            name: "DataLayerTests",
            dependencies: ["DataLayer"]
        ),
    ]
)
