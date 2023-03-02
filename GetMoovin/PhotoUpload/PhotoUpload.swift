//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import ImageSource
import SwiftUI


struct PhotoUpload: View {
    @State var image: UIImage?
    
    
    private var swiftUIImage: Image? {
        image.flatMap {
            Image(uiImage: $0) // swiftlint:disable:this accessibility_label_for_image
        }
    }
    
    var body: some View {
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

struct PhotoUpload_Previews: PreviewProvider {
    static var previews: some View {
        PhotoUpload()
    }
}
