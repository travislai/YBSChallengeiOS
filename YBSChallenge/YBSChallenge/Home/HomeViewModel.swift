//
//  HomeViewModel.swift
//  YBSChallenge
//
//  Created by Travis Lai on 8/7/2024.
//

import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var photos: Photos? = nil
    @Published var photoInfoArray: [PhotoInfo] = []
    @Published var user: User? = nil
    @Published private var selectedPhoto: PhotoInfo? = nil
    var selectedPhotoPublisher: Published<PhotoInfo?>.Publisher { $selectedPhoto }
    
    let loader = ImageLoader()
    
    func searchPhotos() async {
        let photos = try? await loader.searchImages()
        
        await MainActor.run(body: {
            self.photos = photos
        })
        
    }
    
    func getPhotoInfo(photos: Photos) async {
        var photoInfoArray: [PhotoInfo] = []
        
        for photo in photos.photoArray {
            if let photoInfo = try? await loader.getPhotoInfo(photoId: photo.id, secret: photo.secret) {
                photoInfoArray.append(photoInfo)
            }
        }
        self.photoInfoArray = photoInfoArray
    }
    
    func selectPhoto(selectedPhoto: PhotoInfo? = nil) {
        self.selectedPhoto = selectedPhoto
    }
}
