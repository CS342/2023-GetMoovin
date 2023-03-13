//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//
import GetMoovinSharedContext
import GetMoovinStepCountModule
import ImageSource
import SwiftUI

struct PhotoUpload: View {
    @State var image: UIImage?
    @EnvironmentObject var stepCountDataSource: StepCountDataSource
    @AppStorage(StorageKeys.userInformation) var userInformation = UserInformation()

    private var swiftUIImage: Image? {
        image.flatMap {
            Image(uiImage: $0) // swiftlint:disable:this accessibility_label_for_image
        }
    }
    var stepsLeft: Int {
        (userInformation.stepGoal ?? 1000) - (stepCountDataSource.todaysSteps ?? 1000)
    }
    var body: some View {
        if stepsLeft > 0 {
            Text("Oops ... you havent walked ur steps!")
        } else {
            NavigationStack {
                ImageSource(image: $image)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                    .navigationTitle("Photo Upload")
                    .toolbar {
                        if let swiftUIImage = swiftUIImage {
                            ToolbarItem {
                                ShareLink(
                                    item: swiftUIImage,
                                    subject: Text("GetMoovin 🚶"),
                                    message: Text("I met my daily goal in GetMoovin!"),
                                    preview: SharePreview("GetMoovin 🚶", image: swiftUIImage)
                                )
                            }
                        }
                    }
            }
        }
    }
}

struct PhotoUpload_Previews: PreviewProvider {
    static var previews: some View {
        PhotoUpload()
    }
}
