//
//  PhotoDetailsView.swift
//  YBSChallenge
//
//  Created by Travis Lai on 11/7/2024.
//

import SwiftUI

struct PhotoDetailsView<ViewModel: PhotoDetailsViewModelType> {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: ViewModel
    @State var photoItem: PhotoDetailsViewModel.PhotoItem? = nil
    
    init(viewModel: ViewModel, photoItem: PhotoDetailsViewModel.PhotoItem? = nil) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.photoItem = photoItem
    }
}

extension PhotoDetailsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            if let photoItem = photoItem {
                VStack {
                        HStack {
                            AsyncImage(url: URL(string: photoItem.iconUrl)) { image in
                                image.image?.resizable()
                                    .scaledToFit()
                                    .frame(width: Constants.iconSize, height: Constants.iconSize)
                                    .cornerRadius(Constants.iconSize / 2)
                                    .padding()
                            }
                            Text(photoItem.username)
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                            makeDismissButtonView()
                        }
                        .frame(minWidth: .zero, maxWidth: .infinity)

                    
                    
                    Spacer()
                    
                    VStack{
                        Text(photoItem.imageTitle)
                            .padding()
                            .fontWeight(.bold)
                        AsyncImage(url: URL(string: photoItem.imageUrl)) { image in
                            image.image?.resizable()
                                .scaledToFit()
                        }
                        Text(viewModel.getTagString(tags: photoItem.tags))
                            .padding()
                    }
                    
                    Spacer()
                }
            } else {
                EmptyView()
            }
        }.onReceive(viewModel.itemsPublisher) { photoItem = $0 }
    }
    
    private func makeDismissButtonView() -> some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: Constants.buttonSize, height: Constants.buttonSize)
                }
                .padding(.top, Constants.dismissButtonPadding)
            }
            .frame(width: Constants.dismissButtonWidth, alignment: .trailing)
            .padding(.trailing)
        }
    }
}

// MARK: - Constants

private extension PhotoDetailsView {
    enum Constants {
        static var buttonSize: CGFloat { 40.0 }
        static var iconSize: CGFloat { 50.0 }
        static var dismissButtonPadding: CGFloat { 5.0 }
        static var dismissButtonWidth: CGFloat { 80.0 }
    }
}

#if DEBUG

struct PhotoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let photoInfo = PhotoInfo(id: "53843679955", secret: "e15332f307", server: "65535", farm: 66, dateUploaded: "1720446318", isFavorite: 0, originalSecret: "originalsecret", owner: Owner(nsId: "33650137@N05", username: "johnmightycat1", realName: "Big John", iconServer: "7308", iconFarm: 8, pathAlias: "johnmightycat"), title: Title(content: "nyks - MR 1000 arriving york 1981 pic2 JL"), dates: PhotoDate(posted: "1720446318"), views: "128", tags: Tags(tag: [Tag(id: "336547-475847584-84745", author: "336577837@N05", authorName: "johnmightycat1", raw: "Railway", content: "railway"), Tag(id: "336547-475847584-84745", author: "336577837@N05", authorName: "johnmightycat1", raw: "Railway", content: "railway")]), urls: PhotoUrls(url: [PhotoUrl(type: "photopage", content: "https://www.flickr.com/photos/johnmightycat/53843679955/")]))
        
        let viewModel = PhotoDetailsViewModel(photoInfo: photoInfo)
        PhotoDetailsView(viewModel: viewModel)
    }
}

#endif
