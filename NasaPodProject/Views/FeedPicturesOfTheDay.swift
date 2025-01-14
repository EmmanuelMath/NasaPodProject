//
//  FeedPicturesOfTheDay.swift
//  NasaPodProject
//
//  Created by Emmanuel Mathar on 14/01/2025.
//


import SwiftUI

struct FeedPicturesOfTheDay: View {
    let pictureData: PictureOfTheDay

    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: pictureData.url)) { image in
                image.image?.resizable().scaledToFit()
            }
            Text(pictureData.copyright ?? "")
            Text(pictureData.explanation)
                .padding()
        }
        .navigationTitle(pictureData.title)
    }
}
