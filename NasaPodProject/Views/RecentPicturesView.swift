//
//  RecentPicturesView.swift
//  NasaPodProject
//
//  Created by Emmanuel Mathar on 14/01/2025.
//


import SwiftUI

struct RecentPicturesView: View {
    @StateObject private var viewModel = RecentPicturesViewModel()

    var body: some View {
        NavigationView {
            
            List(viewModel.recentPictures) { pictureData in
                NavigationLink(destination: PictureDetailView(pictureData: pictureData)) {
                    VStack(alignment: .leading) {
                        
                        Text(pictureData.copyright ?? "")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text(pictureData.title)
                            .font(.title3)
                            .bold()
                        
                        Text(pictureData.date)
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.gray)
                    }
                }
            }
//            .navigationTitle("Recent Pictures")
        }
        .onAppear {
            viewModel.fetchRecentPictures()
        }
    }
}
