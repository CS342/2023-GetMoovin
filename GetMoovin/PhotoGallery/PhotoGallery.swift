////
//// This source file is part of the CS342 2023 GetMoovin Team Application project
////
//// SPDX-FileCopyrightText: 2023 Stanford University
////
//// SPDX-License-Identifier: MIT
////
//
import SwiftUI
import Photos
import PhotosUI
import GetMoovinStepCountModule
import GetMoovinSharedContext


struct PhotoGallery: View {

    private var photos = [PHAsset]()

    init() {
        fetchPhotos()
    }

    mutating private func fetchPhotos() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: options)
        let newPhotos = (0..<fetchResult.count).compactMap { fetchResult.object(at: $0) }
        self.photos = newPhotos
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(photos, id: \.self) { asset in
                    if let uiImage = getUIImageFromAsset(asset) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .clipped()
                    }
                }
            }
        }
    }

    private func getUIImageFromAsset(_ asset: PHAsset) -> UIImage? {
        var resultImage: UIImage?
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: options) { (image, info) in
            resultImage = image
        }
        return resultImage
    }
}

struct PhotoGallery_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGallery()
    }
}
