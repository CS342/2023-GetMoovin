<!--

This source file is part of the CS342 2023 GetMoovin Team Application project

SPDX-FileCopyrightText: 2023 Stanford University

SPDX-License-Identifier: MIT

-->

# CS342 2023 GetMoovin Team Application

This repository contains the CS342 2023 GetMoovin Team Application.

It demonstrates using the [CardinalKit](https://github.com/StanfordBDHG/CardinalKit) framework template and builds on top of the [StanfordBDHG Template Application](https://github.com/StanfordBDHG/GetMoovin) and [StanfordBDHG CardinalKit Template Application](https://github.com/StanfordBDHG/CardinalKitGetMoovin).


## Application Structure

The application uses a modularized structure enabled by using the Swift Package Manager. You can learn more about the CardinalKit standards-based software architecture in the [CardinalKit documentation](https://github.com/StanfordBDHG/CardinalKit).


## Build and Run the Application

You can build and run the application using [Xcode](https://developer.apple.com/xcode/) by opening up the **GetMoovin.xcodeproj**.

The application includes the following feature flags that can be configured in the [scheme editor in Xcode](https://help.apple.com/xcode/mac/11.4/index.html?localePath=en.lproj#/dev0bee46f46) and selecting the **GetMoovin** scheme, the **Run** configuration, and to switch to the **Arguments** tab to add, enable, disable, or remove the following arguments passed on launch:
- ``--skipOnboarding``: Skips the onboarding flow to enable easier development of features in the application and to allow UI tests to skip the onboarding flow.
- ``--showOnboarding``: Always show the onboarding when the application is launched. Makes it easy to modify and test the onboarding flow without the need to manually remove the application or reset the simulator.


## Continous Delivery Workflows

The application includes continuous integration (CI) and continuous delivery (CD) setup.
- Automatically build and test the application on every pull request before deploying it.
- An automated setup to deploy the application to TestFlight every time there is a new commit on the repository's main branch.
- Ensure a coherent code style by checking the conformance to the SwiftLint rules defined in `.swiftlint.yml` on every pull request and commit.
- Ensure conformance to the [REUSE Spacification]() to property license the application and all related code.

Please refer to the [StanfordBDHG Template Application](https://github.com/StanfordBDHG/GetMoovin) and the [ContinousDelivery Example by Paul Schmiedmayer](https://github.com/PSchmiedmayer/ContinousDelivery) for more background about the CI and CD setup for the CardinalKit Template Application.


## Contributors & License

This project is based on [ContinousDelivery Example by Paul Schmiedmayer](https://github.com/PSchmiedmayer/ContinousDelivery), [StanfordBDHG Template Application](https://github.com/StanfordBDHG/GetMoovin), and the [StanfordBDHG CardinalKit Template Application](https://github.com/StanfordBDHG/CardinalKitGetMoovin) provided using the MIT license.
You can find a list of contributors in the `CONTRIBUTORS.md` file.

The CS342 2023 GetMoovin Team Application is licensed under the MIT license.
