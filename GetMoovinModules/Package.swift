// swift-tools-version: 5.7

//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import PackageDescription


let package = Package(
    name: "GetMoovinModules",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "GetMoovinOnboardingFlow", targets: ["GetMoovinOnboardingFlow"]),
        .library(name: "GetMoovinSharedContext", targets: ["GetMoovinSharedContext"]),
        .library(name: "GetMoovinStepCountModule", targets: ["GetMoovinStepCountModule"])
    ],
    dependencies: [
        .package(url: "https://github.com/StanfordBDHG/CardinalKit.git", .upToNextMinor(from: "0.3.2"))
    ],
    targets: [
        .target(
            name: "GetMoovinOnboardingFlow",
            dependencies: [
                .target(name: "GetMoovinSharedContext"),
                .product(name: "Onboarding", package: "CardinalKit")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "GetMoovinSharedContext",
            dependencies: []
        ),
        .target(
            name: "GetMoovinStepCountModule",
            dependencies: [
                .product(name: "CardinalKit", package: "CardinalKit")
            ]
        )
    ]
)
