//
//  PictureOfTheDayViewModel.swift
//  NasaPodProject
//
//  Created by Emmanuel Mathar on 14/01/2025.
//


import Foundation

class PictureOfTheDayViewModel: ObservableObject {
    @Published var todayPicture: PictureOfTheDay?
    @Published var errorMessage: String?

    private let service = ApiNetworking.shared

    func fetchTodayPicture() {
        service.fetchPictureOfTheDay { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pictureData):
                    self?.todayPicture = pictureData
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
