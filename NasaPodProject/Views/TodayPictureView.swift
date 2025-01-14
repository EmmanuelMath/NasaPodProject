//
//  TodayPictureView.swift
//  NasaPodProject
//
//  Created by Emmanuel Mathar on 14/01/2025.
//

import SwiftUI

struct TodayPictureView: View {
    @StateObject private var viewModel = PictureOfTheDayViewModel()

    var body: some View {
        ScrollView{
            VStack {
            if let pictureData = viewModel.todayPicture {
                Text(pictureData.title)
                    .font(.title3)
                    .bold()
                AsyncImage(url: URL(string: pictureData.url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                Text(pictureData.copyright ?? "")
                    .font(.subheadline)
                Text(pictureData.explanation)
                    .padding()
            } else if let error = viewModel.errorMessage {
                Text(error)
            } else {
                ProgressView()
            }
        }
    }
        .onAppear {
            viewModel.fetchTodayPicture()
        }
    }
}
