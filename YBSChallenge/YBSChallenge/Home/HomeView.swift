//
//  HomeView.swift
//  YBSChallenge
//
//  Created by Travis Lai on 8/7/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    @State private var showingSheet = false
    @State private var selectedPhoto: PhotoInfo? = nil
    
    var body: some View {
        NavigationView {
            List(viewModel.photoInfoArray) { photoInfo in
                LazyVStack {
                    makePhotoCard(photoInfo: photoInfo)
                }
            }
            .sheet(isPresented: $showingSheet) {
                if let selectedPhoto = self.selectedPhoto {
                    let viewModel = PhotoDetailsViewModel(photoInfo: selectedPhoto)
                    PhotoDetailsView(viewModel: viewModel)
                }
            }
        }
        ZStack {
            if let photos = viewModel.photos {
                Text("Total: \(photos.total)")
            }
        }
        .onAppear {
            Task {
                await viewModel.searchPhotos()
                if let photos = viewModel.photos {
                    await viewModel.getPhotoInfo(photos: photos)
                }
            }
        }
        .onReceive(viewModel.selectedPhotoPublisher) {
            selectedPhoto = $0
            if let _ = self.selectedPhoto {
                showingSheet = true
            } else {
                showingSheet = false
            }
        }
    }
    
    @ViewBuilder
    private func makePhotoCard(photoInfo: PhotoInfo) -> some View {
        let url = "https://live.staticflickr.com/\(photoInfo.server)/\(photoInfo.id)_\(photoInfo.secret)_b.jpg"
        let iconUrl = "https://farm\(photoInfo.owner.iconFarm).staticflickr.com/\(photoInfo.owner.iconServer)/buddyicons/\(photoInfo.owner.nsId).jpg"
        PhotoCardView(showingSheet: $showingSheet, imageURL: url, iconURL: iconUrl, owner: photoInfo.owner.username, title: photoInfo.title.content, viewModel: viewModel, photoInfo: photoInfo)
    }
}

#Preview {
    HomeView()
}
