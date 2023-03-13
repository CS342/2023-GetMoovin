////
//// This source file is part of the CS342 2023 GetMoovin Team Application project
////
//// SPDX-FileCopyrightText: 2023 Stanford University
////
//// SPDX-License-Identifier: MIT
////
//
import GetMoovinSharedContext
import GetMoovinStepCountModule
import Photos
import PhotosUI
import SwiftUI

struct PhotoGallery: View {
    private var photos = [PHAsset]()

    private let options = PHFetchOptions()

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                ForEach(photos, id: \.self) { asset in
                    if let uiImage = getUIImageFromAsset(asset) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .clipped()
                            .accessibility(label: Text("Image Grid"))
                    }
                }
            }
        }
    }
    
    init() {
        fetchPhotos()
    }


    private func getUIImageFromAsset(_ asset: PHAsset) -> UIImage? {
        var resultImage: UIImage?
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        PHImageManager.default().requestImage(
            for: asset,
            targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight),
            contentMode: .aspectFill,
            options: options
        ) { image, _ in
            resultImage = image
        }
        return resultImage
    }
    
    private mutating func fetchPhotos() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: options)
        let newPhotos = (0..<fetchResult.count).compactMap { fetchResult.object(at: $0) }
        self.photos = newPhotos
    }
}

struct PhotoGallery_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGallery()
    }
}
