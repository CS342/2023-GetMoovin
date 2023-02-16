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
        .library(name: "GetMoovinContacts", targets: ["GetMoovinContacts"]),
        .library(name: "GetMoovinMockDataStorageProvider", targets: ["GetMoovinMockDataStorageProvider"]),
        .library(name: "GetMoovinOnboardingFlow", targets: ["GetMoovinOnboardingFlow"]),
        .library(name: "GetMoovinSchedule", targets: ["GetMoovinSchedule"]),
        .library(name: "GetMoovinSharedContext", targets: ["GetMoovinSharedContext"])
    ],
    dependencies: [
        .package(url: "https://github.com/StanfordBDHG/CardinalKit.git", .upToNextMinor(from: "0.3.1"))
    ],
    targets: [
        .target(
            name: "GetMoovinContacts",
            dependencies: [
                .target(name: "GetMoovinSharedContext"),
                .product(name: "Contact", package: "CardinalKit")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "GetMoovinMockDataStorageProvider",
            dependencies: [
                .target(name: "GetMoovinSharedContext"),
                .product(name: "CardinalKit", package: "CardinalKit"),
                .product(name: "FHIR", package: "CardinalKit")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "GetMoovinOnboardingFlow",
            dependencies: [
                .target(name: "GetMoovinSharedContext"),
                .product(name: "Account", package: "CardinalKit"),
                .product(name: "FHIR", package: "CardinalKit"),
                .product(name: "FirebaseAccount", package: "CardinalKit"),
                .product(name: "HealthKitDataSource", package: "CardinalKit"),
                .product(name: "Onboarding", package: "CardinalKit"),
                .product(name: "Views", package: "CardinalKit")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "GetMoovinSchedule",
            dependencies: [
                .target(name: "GetMoovinSharedContext"),
                .product(name: "FHIR", package: "CardinalKit"),
                .product(name: "Questionnaires", package: "CardinalKit"),
                .product(name: "Scheduler", package: "CardinalKit")
            ]
        ),
        .target(
            name: "GetMoovinSharedContext",
            dependencies: []
        )
    ]
)
