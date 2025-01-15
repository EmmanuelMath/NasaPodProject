//
//  RecentPicturesViewModel.swift
//  NasaPodProject
//
//  Created by Emmanuel Mathar on 14/01/2025.
//


import Foundation

class RecentPicturesViewModel: ObservableObject {
    @Published var recentPictures: [PictureOfTheDay] = []
    @Published var errorMessage: String?


    @Published var service = ApiNetworking()

    func fetchRecentPictures() {
        service.fetchRecentPictures { [weak self] picturesData in
            DispatchQueue.main.async {
                self?.recentPictures = picturesData
            }
        }
    }
}
