// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "WKHTMLTOPDF",
    products: [
        //Swift lib for building pdf file from leaf templates and/or web pages through wkhtmltopdf cli
        .library(name: "WKHTMLTOPDF", targets: ["WKHTMLTOPDF"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0-rc.2.1.2"),
    ],
    targets: [
        .target(name: "WKHTMLTOPDF", dependencies: ["Vapor", "Leaf"]),
        .testTarget(name: "WKHTMLTOPDFTests", dependencies: ["WKHTMLTOPDF"]),
    ]
)
