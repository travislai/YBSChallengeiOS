//
//  PhotoDetailsViewModel.swift
//  YBSChallenge
//
//  Created by Travis Lai on 11/7/2024.
//

import SwiftUI

protocol PhotoDetailsViewModelType: ObservableObject {
    var itemsPublisher: Published<PhotoDetailsViewModel.PhotoItem?>.Publisher { get }
    
    func getTagString(tags: [Tag]) -> String
}

final class PhotoDetailsViewModel {
    @Published private var data: PhotoItem? = nil

    private let photoInfo: PhotoInfo

    init(photoInfo: PhotoInfo) {
        self.photoInfo = photoInfo
        configureContentData()
    }

    // MARK: - PrivateMethods

    private func configureContentData() {
        
        data = .init(id: photoInfo.id,
                     imageUrl: getImageUrl(),
                     iconUrl: getIconUrl(),
                     username: photoInfo.owner.username,
                     imageTitle: photoInfo.title.content,
                     views: photoInfo.views,
                     tags: photoInfo.tags.tag)
    }
    
    private func getImageUrl() -> String {
        "https://live.staticflickr.com/\(photoInfo.server)/\(photoInfo.id)_\(photoInfo.secret)_b.jpg"
    }
    
    private func getIconUrl() -> String {
        "https://farm\(photoInfo.owner.iconFarm).staticflickr.com/\(photoInfo.owner.iconServer)/buddyicons/\(photoInfo.owner.nsId).jpg"
    }
    
    func getTagString(tags: [Tag]) -> String {
        var tagArray: [String] = []
        let _ = tags.map({
            tagArray.append($0.content)
        })
        return tagArray.joined(separator: " ")
    }
}

// MARK: - PhotoDetailsViewModelType

extension PhotoDetailsViewModel: PhotoDetailsViewModelType {
    var itemsPublisher: Published<PhotoDetailsViewModel.PhotoItem?>.Publisher { $data }
}

// MARK: - Types

extension PhotoDetailsViewModel {
    struct PhotoItem: Hashable, Identifiable {
        let id: String
        let imageUrl: String
        let iconUrl: String
        let username: String
        let imageTitle: String
        let views: String
        let tags: [Tag]
    }
}

