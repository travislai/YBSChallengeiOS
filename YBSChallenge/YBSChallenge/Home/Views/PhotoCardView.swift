//
//  PhotoCardView.swift
//  YBSChallenge
//
//  Created by Travis Lai on 10/7/2024.
//

import SwiftUI

struct PhotoCardView {
    
    @Binding var showingSheet: Bool
    
    private let imageURL: String
    private let iconURL: String
    private let owner: String
    private let title: String
    private let viewModel: HomeViewModel
    private let photoInfo: PhotoInfo
    
    init(showingSheet: Binding<Bool>, imageURL: String, iconURL: String, owner: String, title: String, viewModel: HomeViewModel, photoInfo: PhotoInfo) {
        self._showingSheet = showingSheet
        self.imageURL = imageURL
        self.iconURL = iconURL
        self.owner = owner
        self.title = title
        self.viewModel = viewModel
        self.photoInfo = photoInfo
    }
}

// MARK: - View

extension PhotoCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: DesignConstants.spacing) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image.image?.resizable()
                    .scaledToFit()
            }
            HStack {
                AsyncImage(url: URL(string: iconURL)) { image in
                    
                    Button(action: {
                        $showingSheet.wrappedValue.toggle()
                        viewModel.selectPhoto(selectedPhoto: photoInfo)
                    }) {
                        image.image?.resizable()
                            .scaledToFit()
                            .frame(width: Constants.iconSize, height: Constants.iconSize)
                            .cornerRadius(Constants.iconSize/2)
                    }
                }
                VStack(alignment: .leading, spacing: DesignConstants.spacing) {
                    Text(owner)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(title)
                }
            }
            
            Divider()
            
            HStack {
                HStack {
                    Image(uiImage: UIImage(systemName: "star") ?? UIImage())
                    Text("9.4K")
                }
                .frame(minWidth: .zero, maxWidth: .infinity)
                HStack {
                    Image(uiImage: UIImage(systemName: "message") ?? UIImage())
                    Text("366")
                }
                .frame(minWidth: .zero, maxWidth: .infinity)
                HStack {
                    Image(uiImage: UIImage(systemName: "arrowshape.turn.up.right") ?? UIImage())
                }
                .frame(minWidth: .zero, maxWidth: .infinity)
            }
        }
    }
}

// MARK: - Constants

private extension PhotoCardView {
    enum Constants {
        static var iconSize: CGFloat { 50.0 }
    }
}

#Preview {
    PhotoCardView(showingSheet: .constant(false), imageURL: "https://live.staticflickr.com/65535/53843679955_e15332f307_s.jpg", iconURL:  "https://farm8.staticflickr.com/7308/buddyicons/33650137@N05.jpg", owner: "Simon", title: "Random", viewModel: HomeViewModel(), photoInfo:     PhotoInfo(id: "00848e", secret: "123456", server: "88", farm: 7, dateUploaded: "12853945", isFavorite: 0, originalSecret: "o89898e", owner: Owner(nsId: "09909", username: "anc_jkl", realName: "Big John", iconServer: "8", iconFarm: 8, pathAlias: "big_john"), title: Title(content: "Title"), dates: PhotoDate(posted: "123434995"), views: "128", tags: Tags(tag: [Tag(id: "336547-475847584-84745", author: "336577837@N05", authorName: "johnmightycat1", raw: "Railway", content: "railway"), Tag(id: "336547-475847584-84745", author: "336577837@N05", authorName: "johnmightycat1", raw: "Railway", content: "railway")]), urls: PhotoUrls(url: [PhotoUrl(type: "photopage", content: "https://www.flickr.com/photos/johnmightycat/53843679955/")])))
}
